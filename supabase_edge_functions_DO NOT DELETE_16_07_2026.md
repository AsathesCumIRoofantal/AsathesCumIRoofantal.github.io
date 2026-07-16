# Edge Function: log_login

Deploy at `supabase/functions/log_login/index.ts`. Called by the app right
after a successful sign-in to record a login event and get back the
caller's `user_table` row (used to populate `CurrentUser` client-side).

## Changes made (2026-07-16)

- Removed the dead, commented-out alternate body-parsing path (the
  `req.text()` / manual `JSON.parse` block) and leftover debug
  `console.log("A--------------")` / `console.log("Here")` lines — noise
  that didn't affect behavior but made this harder to read and easy to
  accidentally re-enable.
- The `user_table` UPDATE this function does (`user_last_login_logs_id`)
  will now actually succeed even for a brand-new sign-up, because of the
  auto-create-profile-on-signup trigger and the nullable-FK fix added in
  `supabase_schema.sql`'s 2026-07-06 patch (section B/E). Before that
  patch, this function would throw on `updateError` for any user whose
  `user_table` row didn't exist yet or whose FK was still NOT NULL.
- Added a clearer 404 instead of a generic 500 if a `user_table` row
  genuinely doesn't exist for this auth user (e.g. the signup trigger was
  never applied to this project) — that's a config problem, not a
  server error, so it gets its own message instead of "Unknown error".

```ts
import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body = await req.json();

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
      {
        global: {
          headers: {
            Authorization: req.headers.get("Authorization") ?? "",
          },
        },
      },
    );

    // Validate logged in user
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return new Response(
        JSON.stringify({ success: false, message: "Unauthorized" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    // Insert login log
    const { data: log, error: logError } = await supabase
      .from("user_logging_data")
      .insert({
        user_id: user.id,
        system_platform_logged: body.system_platform_logged,
        geo_location_logged: body.geo_location_logged,
        is_from_android: body.is_from_android,
        is_from_ios: body.is_from_ios,
        is_from_web: body.is_from_web,
        ip_address: body.ip_address,
        app_version: body.app_version,
        is_login: body.is_login,
      })
      .select()
      .single();

    if (logError) throw logError;

    // Update user_table
    const { error: updateError } = await supabase
      .from("user_table")
      .update({ user_last_login_logs_id: log.id })
      .eq("auth_user_id", user.id);

    if (updateError) throw updateError;

    // Return updated AirUser
    const { data: airUser, error: userError } = await supabase
      .from("user_table")
      .select("*")
      .eq("auth_user_id", user.id)
      .single();

    if (userError) {
      // A missing user_table row here means the signup trigger from
      // supabase_schema.sql section E either wasn't applied to this
      // project, or ran before auth_user_id existed on the table.
      // That's a setup problem, not a server error — say so.
      return new Response(
        JSON.stringify({
          success: false,
          message: "No user_table row for this account. Re-run the " +
            "2026-07-06 schema patch (sections A/B/E) so new sign-ups " +
            "get a profile row automatically.",
        }),
        { status: 404, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    return new Response(JSON.stringify(airUser), {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(
      JSON.stringify({
        success: false,
        message: e instanceof Error ? e.message : "Unknown error",
      }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  }
});
```

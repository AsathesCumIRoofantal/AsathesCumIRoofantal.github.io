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
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  console.log("A--------------");
  
  try {
    // throw new Error("I AM HERE");
    // return new Response("NAVIN");

    console.log(req.method);
    const body = await req.json();
//      const raw = await req.text();

// console.log("RAW:", raw);

// let body = {};

// if (raw.trim().length > 0) {
//   body = JSON.parse(raw);
// }

// console.log(body);

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
        JSON.stringify({
          success: false,
          message: "Unauthorized",
        }),
        {
          status: 401,
          headers: { ...corsHeaders,
            "Content-Type": "application/json" },
        },
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
      .update({
        user_last_login_logs_id: log.id,
        // last_login_at: new Date().toISOString(),
      })
      .eq("auth_user_id", user.id);

    if (updateError) throw updateError;

    // Return updated AirUser
    const { data: airUser, error: userError } = await supabase
      .from("user_table")
      .select("*")
      .eq("auth_user_id", user.id)
      .single();

    if (userError) throw userError;

    return new Response(
      JSON.stringify(airUser),
      {
        status: 200,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (e) {
    console.log("Here");
    console.log(e);
   
    return new Response(
      JSON.stringify({
        success: false,
        message: e instanceof Error ? e.message : "Unknown error",
      }),
      {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});
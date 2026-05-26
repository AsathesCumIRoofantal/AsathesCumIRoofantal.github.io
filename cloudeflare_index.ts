export default {
    async fetch(request, env, ctx): Promise<Response> {
        const url = new URL(request.url);

        // Route handling
        if (url.pathname === "/") {
            return new Response("Hello from Mazeasta! 🚀", {
                status: 200,
                headers: { "Content-Type": "text/plain" },
            });
        }

        if (url.pathname === "/api") {
            return Response.json({ message: "Welcome to Mazeasta API", status: "ok" });
        }

        // 404 for everything else
        return new Response("Not Found", { status: 404 });
    },
} satisfies ExportedHandler<Env>;

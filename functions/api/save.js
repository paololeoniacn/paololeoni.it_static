export async function onRequestGet(context) {
  const { env } = context;
  
  // Try to get data from KV first
  if (env.RESUME_DATA) {
    const data = await env.RESUME_DATA.get("resume_json");
    if (data) {
      return new Response(data, {
        headers: { "Content-Type": "application/json" }
      });
    }
  }

  // Fallback: This is tricky from a Function. 
  // We'll return a 404 so the client knows to use the static file fallback.
  return new Response("Not found in KV", { status: 404 });
}

export async function onRequestPost(context) {
  const { request, env } = context;
  
  if (!env.RESUME_DATA) {
    return new Response(JSON.stringify({ error: "KV Namespace not bound" }), { 
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }

  try {
    const newData = await request.json();
    await env.RESUME_DATA.put("resume_json", JSON.stringify(newData));
    
    return new Response(JSON.stringify({ status: "success" }), {
      headers: { "Content-Type": "application/json" }
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: e.message }), { 
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
}

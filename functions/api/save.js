export async function onRequestGet(context) {
  const { env } = context;
  
  if (env.ORCHESTRATOR_BUCKET) {
    const object = await env.ORCHESTRATOR_BUCKET.get("db/resumeData.json");
    if (object) {
      return new Response(object.body, {
        headers: { "Content-Type": "application/json" }
      });
    }
  }

  // Not found in R2 -> 404 to trigger client-side static file fallback
  return new Response(JSON.stringify({ error: "DB not found in R2" }), { 
    status: 404,
    headers: { "Content-Type": "application/json" }
  });
}

export async function onRequestPost(context) {
  const { request, env } = context;
  
  if (!env.ORCHESTRATOR_BUCKET) {
    return new Response(JSON.stringify({ error: "R2 Bucket not bound" }), { 
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }

  try {
    const newData = await request.json();
    await env.ORCHESTRATOR_BUCKET.put("db/resumeData.json", JSON.stringify(newData, null, 4), {
      httpMetadata: { contentType: "application/json" }
    });
    
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

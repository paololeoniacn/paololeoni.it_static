export async function onRequestPost(context) {
  const { request, env } = context;
  
  if (!env.ORCHESTRATOR_BUCKET) {
    return new Response(JSON.stringify({ error: "R2 Bucket not bound" }), { status: 500 });
  }

  try {
    const fileName = request.headers.get("X-File-Name");
    if (!fileName) {
      return new Response(JSON.stringify({ error: "Missing X-File-Name header" }), { status: 400 });
    }

    const contentType = request.headers.get("Content-Type") || "application/octet-stream";
    const body = await request.arrayBuffer();

    // Store in /files/ directory
    const key = `files/${fileName}`;
    await env.ORCHESTRATOR_BUCKET.put(key, body, {
      httpMetadata: { contentType: contentType }
    });

    // Also handle dynamic serving:
    // To make this file viewable, we'll need a way for the site to read it.
    // We can use a separate GET endpoint (/api/files/[key]) or a public bucket.
    return new Response(JSON.stringify({ status: "success", key: key, url: `/api/files/${fileName}` }), { 
      headers: { "Content-Type": "application/json" }
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: e.message }), { status: 500 });
  }
}

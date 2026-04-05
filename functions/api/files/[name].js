export async function onRequestGet(context) {
  const { env, params } = context;
  const fileName = params.name;

  if (!env.ORCHESTRATOR_BUCKET) {
    return new Response(JSON.stringify({ error: "R2 Bucket not bound" }), { status: 500 });
  }

  try {
    const key = `files/${fileName}`;
    const object = await env.ORCHESTRATOR_BUCKET.get(key);

    if (!object) {
      // Fallback: check if the file exists in the static 'files/' directory
      // (Pages should handle this by default if we don't intercept it, 
      // but here we are in a dynamic function).
      return new Response("File not found in R2", { status: 404 });
    }

    const headers = new Headers();
    object.writeHttpMetadata(headers);
    headers.set("etag", object.httpEtag);
    
    // Safety check for content type if missing
    if (!headers.has("Content-Type")) {
      if (fileName.endsWith(".pdf")) headers.set("Content-Type", "application/pdf");
      if (fileName.endsWith(".png")) headers.set("Content-Type", "image/png");
      if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) headers.set("Content-Type", "image/jpeg");
    }

    return new Response(object.body, {
      headers: headers
    });
  } catch (e) {
    return new Response(e.message, { status: 500 });
  }
}

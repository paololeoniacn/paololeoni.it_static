import http.server
import json
import os

PORT = 8081
# Paths are absolute for local persistence
ROOT_DIR = os.path.join(os.getcwd(), 'web')
JSON_FILE = os.path.join(ROOT_DIR, 'data', 'resumeData.json')

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        # Serve the 'web' directory as the root
        super().__init__(*args, directory=ROOT_DIR, **kwargs)

    def do_GET(self):
        if self.path == '/api/save':
            try:
                with open(JSON_FILE, 'r', encoding='utf-8') as f:
                    data = f.read()
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(data.encode())
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode())
        elif self.path.startswith('/api/files/'):
            file_name = self.path.split('/')[-1]
            local_path = os.path.join(ROOT_DIR, 'files', file_name)
            if os.path.isfile(local_path):
                self.send_response(200)
                if file_name.endswith('.pdf'): self.send_header('Content-type', 'application/pdf')
                elif file_name.endswith('.png'): self.send_header('Content-type', 'image/png')
                elif file_name.endswith('.jpg'): self.send_header('Content-type', 'image/jpeg')
                self.end_headers()
                with open(local_path, 'rb') as f:
                    self.wfile.write(f.read())
            else:
                self.send_response(404)
                self.end_headers()
        else:
            return super().do_GET()

    def do_POST(self):
        # In this context, paths are relative to the 'web/' root
        if self.path == '/api/save':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            try:
                new_data = json.loads(post_data)
                with open(JSON_FILE, 'w', encoding='utf-8') as f:
                    json.dump(new_data, f, indent=4, ensure_ascii=False)
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"status": "success"}).encode())
                print(f"DEBUG: Saved new data to {JSON_FILE}")
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode())
        elif self.path == '/api/upload':
            file_name = self.headers.get('X-File-Name')
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            if not file_name:
                self.send_response(400)
                self.end_headers()
                self.wfile.write(b"Missing X-File-Name")
                return

            try:
                local_path = os.path.join(ROOT_DIR, 'files', file_name)
                # Ensure files directory exists
                os.makedirs(os.path.dirname(local_path), exist_ok=True)
                
                with open(local_path, 'wb') as f:
                    f.write(post_data)
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"status": "success", "url": f"/api/files/{file_name}"}).encode())
                print(f"DEBUG: Uploaded file to {local_path}")
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode())
        else:
            self.send_response(404)
            self.end_headers()

if __name__ == "__main__":
    print(f"Starting Orchestrator Server on port {PORT}...")
    print(f"Serving directory: {ROOT_DIR}")
    server = http.server.HTTPServer(('', PORT), Handler)
    server.allow_reuse_address = True
    server.serve_forever()

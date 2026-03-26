import http.server
import json
import os

PORT = 8081
JSON_FILE = os.path.join(os.getcwd(), 'web', 'data', 'resumeData.json')

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
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
        else:
            self.send_response(404)
            self.end_headers()

if __name__ == "__main__":
    print(f"Starting Orchestrator Server on port {PORT}...")
    server = http.server.HTTPServer(('', PORT), Handler)
    server.allow_reuse_address = True
    server.serve_forever()

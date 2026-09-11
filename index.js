const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Security Gatekeeper demo app is running.\n');
});

server.listen(3000, () => console.log('Listening on port 3000'));

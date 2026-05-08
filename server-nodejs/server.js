const http = require('http');
const fs = require('fs');
const path = require('path');
const { categories, games } = require('./data/games');

const PORT = process.env.PORT || 3000;
const HOST = '0.0.0.0';

function sendJson(res, statusCode, data) {
  const body = JSON.stringify(data, null, 2);
  res.writeHead(statusCode, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  });
  res.end(body);
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    let body = '';
    req.on('data', chunk => body += chunk.toString());
    req.on('end', () => {
      if (!body) return resolve({});
      try {
        resolve(JSON.parse(body));
      } catch (error) {
        reject(error);
      }
    });
  });
}

function compactGame(game) {
  return {
    id: game.id,
    name: game.name,
    category: game.category,
    year: game.year,
    developer: game.developer,
    platform: game.platform,
    image: game.image,
    rating: game.rating,
  };
}

function sendImage(req, res) {
  const filename = decodeURIComponent(req.url.replace('/images/', ''));
  const safeFile = path.basename(filename);
  const imagePath = path.join(__dirname, 'images', safeFile);

  if (!fs.existsSync(imagePath)) {
    sendJson(res, 404, { ok: false, message: 'Imagen no encontrada' });
    return;
  }

  res.writeHead(200, {
    'Content-Type': 'image/png',
    'Access-Control-Allow-Origin': '*',
    'Cache-Control': 'public, max-age=3600',
  });
  fs.createReadStream(imagePath).pipe(res);
}

const server = http.createServer(async (req, res) => {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    });
    return res.end();
  }

  try {
    if (req.method === 'GET' && req.url === '/') {
      return sendJson(res, 200, {
        ok: true,
        name: 'Pixel Vault API',
        endpoints: [
          'POST /categories',
          'POST /games/by-category',
          'POST /games/detail',
          'POST /games/search',
          'GET /images/:filename',
        ],
      });
    }

    if (req.method === 'GET' && req.url.startsWith('/images/')) {
      return sendImage(req, res);
    }

    if (req.method !== 'POST') {
      return sendJson(res, 405, { ok: false, message: 'Método no permitido' });
    }

    if (req.url === '/categories') {
      return sendJson(res, 200, { ok: true, data: categories });
    }

    if (req.url === '/games/by-category') {
      const body = await readBody(req);
      const category = String(body.category || '').toLowerCase();
      const filteredGames = games
        .filter(game => game.category.toLowerCase() === category)
        .map(compactGame);
      return sendJson(res, 200, { ok: true, data: filteredGames });
    }

    if (req.url === '/games/detail') {
      const body = await readBody(req);
      const id = Number(body.id);
      const game = games.find(item => item.id === id);

      if (!game) {
        return sendJson(res, 404, { ok: false, message: 'Juego no encontrado' });
      }

      return sendJson(res, 200, { ok: true, data: game });
    }

    if (req.url === '/games/search') {
      const body = await readBody(req);
      const query = String(body.query || '').trim().toLowerCase();

      if (!query) {
        return sendJson(res, 200, { ok: true, data: [] });
      }

      const results = games.filter(game => {
        const searchableText = [
          game.name,
          game.category,
          game.year,
          game.developer,
          game.platform,
          game.description,
        ].join(' ').toLowerCase();
        return searchableText.includes(query);
      }).map(compactGame);

      return sendJson(res, 200, { ok: true, data: results });
    }

    return sendJson(res, 404, { ok: false, message: 'Ruta no encontrada' });
  } catch (error) {
    return sendJson(res, 500, { ok: false, message: error.message });
  }
});

server.listen(PORT, HOST, () => {
  console.log(`Pixel Vault API funcionando en http://localhost:${PORT}`);
});

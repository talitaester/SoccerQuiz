const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');

const app = express();
app.use(cors());

const AUTH_URL = process.env.AUTH_SERVICE_URL || 'http://localhost:3001';
const GAME_URL = process.env.GAME_SERVICE_URL || 'http://localhost:3002';

console.log(`Gateway iniciado. Auth em: ${AUTH_URL} | Game em: ${GAME_URL}`);

app.use(['/auth', '/user'], createProxyMiddleware({ target: AUTH_URL, changeOrigin: true }));
app.use(['/ranking', '/quizzes', '/questions'], createProxyMiddleware({ target: GAME_URL, changeOrigin: true }));

app.listen(3000, () => console.log('GATEWAY rodando na porta 3000'));
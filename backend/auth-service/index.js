const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const md5 = require('md5');
const db = require('./database.js');

const app = express();
app.use(express.json());
app.use(cors());
const SECRET = process.env.JWT_SECRET || "secret";

app.post('/auth/login', (req, res) => {
    db.get("SELECT * FROM users WHERE email = ? AND password = ?", [req.body.email, md5(req.body.password)], (err, row) => {
        if (row) res.json({ token: jwt.sign({ id: row.id }, SECRET, { expiresIn: '1h' }) });
        else res.status(401).json({ message: "Erro login" });
    });
});

app.get('/user/me', (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1];
    if(!token) return res.sendStatus(401);
    jwt.verify(token, SECRET, (err, user) => {
        if(err) return res.sendStatus(403);
        db.get("SELECT id, name, email, coins FROM users WHERE id = ?", [user.id], (err, row) => res.json(row));
    });
});

app.listen(3001, () => console.log('AUTH rodando na 3001'));
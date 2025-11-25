const express = require('express');
const cors = require('cors');
const db = require('./database.js');
const app = express();
app.use(express.json());
app.use(cors());

app.get('/quizzes', (req, res) => {
    db.all("SELECT * FROM quizzes", [], (err, rows) => res.json(rows));
});

app.get('/ranking/top', (req, res) => {
    res.json([
        { user: "João Silva", points: 1500 },
        { user: "Admin", points: 9999 },
        { user: "Carlos", points: 950 }
    ]);
});

app.post('/questions', (req, res) => {
    db.run('INSERT INTO questions (question, answer) VALUES (?,?)', [req.body.question, req.body.answer], function(err) {
        if(err) res.status(400).json({error: err.message});
        else res.json({message: "Criado", id: this.lastID});
    });
});

app.listen(3002, () => console.log('GAME rodando na 3002'));
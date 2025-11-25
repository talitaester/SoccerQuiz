const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database(':memory:', (err) => {
    if (err) console.error(err.message);
    else {
        console.log('DB Game Conectado.');
        db.run(`CREATE TABLE quizzes (id INTEGER PRIMARY KEY, name text, players text, price text)`);
        db.run(`CREATE TABLE questions (id INTEGER PRIMARY KEY, question text, answer text)`);
        
        
        setTimeout(() => {
            const insert = 'INSERT INTO quizzes (name, players, price) VALUES (?,?,?)';
            db.run(insert, ["Quiz de João", "2/10", "2 SC"]);
            db.run(insert, ["Quiz de Lucas", "3/5", "1 SC"]);
            db.run(insert, ["Quiz da Turma", "9/10", "5 SC"]);
        }, 1000);
    }
});
module.exports = db;
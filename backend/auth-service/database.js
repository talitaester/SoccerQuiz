const sqlite3 = require('sqlite3').verbose();
const md5 = require('md5');

const db = new sqlite3.Database(':memory:', (err) => {
    if (err) console.error(err.message);
    else {
        console.log('DB Auth Conectado.');
        db.run(`CREATE TABLE users (id INTEGER PRIMARY KEY, name text, email text, password text, coins INTEGER)`, () => {
             
             const insert = 'INSERT INTO users (name, email, password, coins) VALUES (?,?,?,?)';
             db.run(insert, ["Administrador", "admin@ufba.br", md5("123456"), 1000]);
             db.run(insert, ["Eduardo", "eduardo@ufba.br", md5("123456"), 50]);
        });
    }
});
module.exports = db;
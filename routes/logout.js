let express = require('express');
let router = express.Router();
let isNull = require('../script').isNull;

// rota para sair da sessão
// a princípio, não precisa mexer aqui
router.get('/', (req, res, next) => {
    req.session.destroy();
    res.redirect('/login.html'); // indique aqui para onde quer que o usuário vá após o logoff
});

module.exports = router;

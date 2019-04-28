let express = require('express');
let isNull = require('../script').isNull;
let Database = require('../Database');
const Cryptr = require('cryptr');
const config = require('../config');
const cryptr = new Cryptr(config.security.key);

let router = express.Router();

// rota de autenticação
router.post('/', (req, res, next) => {
	console.log('tentando autenticar...');
	
	try {
			
		// após o body, são os nomes dos campos no formulário	
		let login = req.body.user;
		let senha = req.body.password;
		
		const msgErro = {'mensagem': 'Login e/ou senha inválidos!'};
		
		if (isNull(login) || isNull(senha)) {
			//console.log('Login e/ou senha inválidos');
			res.render('login', msgErro);
		} else {
			console.log('tentando consulta no banco...');
			// altere aqui o seu select de acordo com sua tabela
			Database.query(`SELECT * FROM TBD_BANCO WHERE email = '${login}';`).then(results => {
				console.log(`Linhas: ${results.recordsets[0].length}`);
				let linhas = results.recordsets[0];
				if (linhas.length > 0) {
					let senhaBanco = linhas[0].senha; // é 'senha' o nome de seu campo?
					if (senhaBanco === senha) {
						let user = {
							// mantenha "nome" e "login" nos antes dos ":"
							nome: linhas[0].nomeBanco, // é 'nome' o nome de seu campo?
							login: linhas[0].usuario, // é 'login' o nome de seu campo?
						};
						req.session.user = user;
						return res.status(200).send('ok');
					} else {
						return res.status(401).send(msgErro);
					}
				} else {
					return res.status(401).send(msgErro);
				}
			}).catch(error => {
				return res.status(401).send(msgErro);
			});
		}
    
	} catch (e) {
		console.error(`erro: ${e}`);
		res.send({'mensagem':`${e}`});
	}

});

// rota que recupera os dados do usuário na sessão
// a princípio, não precisa mexer aqui
router.get('/sessao', (req, res, next) => {
    if (req.session.user && req.session.user) {
		const usuario = req.session.user;
        res.json({
            'nome': usuario.nome,
            'login': usuario.login,
        });
    } else {
        return res.status(401).json({
            'mensagem': 'Nenhum usuário na sessão'
        });
    }
});

module.exports = router;

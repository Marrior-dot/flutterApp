INSERT INTO auth_user (password,last_login,is_superuser,username,last_name,email,is_staff,is_active,date_joined,first_name) VALUES
	 ('pbkdf2_sha256$720000$riAbfF8eCYylAxzrqB4O9z$TI2L6W39YQl55b0WGtOm5q1cqPFOLW3cL+3SYkvQKkg=','2024-11-06 12:08:26.731622',1,'admin','','',1,1,'2024-05-06 15:56:34.926003','');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('novo comentário',27,'ALUNO'),
	 ('asdasdasdasdasd',27,'ALUNO'),
	 ('TextEditingController#73ab0(TextEditingValue(text: ┤├, selection: TextSelection.invalid, composing: TextRange(start: -1, end: -1)))',27,'ALUNO'),
	 ('novo Comentário',30,'ALUNO'),
	 ('Novo comentário',30,'ALUNO'),
	 ('mais um novo comentário',30,'ALUNO'),
	 ('primeiro comentário dessa postagem',31,'ALUNO'),
	 ('segunda comentário dessa postagem',31,'ALUNO'),
	 ('dfhtgffhgfghfhg',27,'ALUNO'),
	 ('asdasdas',30,'ALUNO');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('mais um novo comentário',30,'ALUNO'),
	 ('asdasd',32,'ALUNO'),
	 ('sssss',32,'ALUNO'),
	 ('dddd',32,'ALUNO'),
	 ('primeiro comentário',33,'ALUNO'),
	 ('asdasd',27,'ALUNO'),
	 ('ddddddddddddddd',27,'ALUNO'),
	 ('mais um comentário',32,'nomeUser'),
	 ('nome comentário',36,'ALUNO2'),
	 ('comentário deste usuário',38,'ALUNO2');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('comentário deste usuário',38,'ALUNO2'),
	 ('outro comentário',38,'ALUNO2'),
	 ('ssss',35,'ALUNO2'),
	 ('ddd',36,'ALUNO2');
INSERT INTO myapp_postagem (content,likes,dislikes,escolha_unica,arquivo) VALUES
	 ('a primeira postagem',18,1,0,''),
	 ('outro',2,0,0,''),
	 ('conteudo novo',11,0,0,''),
	 ('teste de respostas',3,0,0,''),
	 ('asdasd',4,0,0,''),
	 ('Postagem de teste 3',8,0,0,''),
	 ('Pergunta com respostas',23,0,1,'images/imagemTeste1_KRwUcML.jpeg'),
	 ('Perguntas com Respostas 2',16,1,0,'images/images.jpeg'),
	 ('teste para nova tela de admin',2,0,1,''),
	 ('Conteudo de texto',1,0,0,'');
INSERT INTO myapp_respostas (respostaTexto,respondido,postagem_id) VALUES
	 ('isso é uma resposta',12,27),
	 ('isso é outra resposta',27,27),
	 ('nova resposta',5,30),
	 ('Mais uma resposta texto',11,34),
	 ('resposta texto 2',4,32),
	 ('pergunta de teste 4',32,35),
	 ('reposta de teste admin',1,37),
	 ('resposta para essa questão',1,38);
INSERT INTO myapp_user (name,password,email,username) VALUES
	 ('','','',''),
	 ('nomealuno','senhaaluno','email@aluno.com','alunoteste2'),
	 ('Usuario novo','senhadousuario','usuario@novo.com','Usuario apenas'),
	 ('novo Usuario','senhanovousuario','novo@usuario.com','awdasdad'),
	 ('ALUNO','Ev2ryday2','email@outroemail.com','ALUNO'),
	 ('ALUNO2','Ev2ryday','email@Outroemail.com','ALUNO2'),
	 ('usuarioQueNaoExiste','LALAL2e2','lalalala@email.com','usuarioQueNaoExiste');

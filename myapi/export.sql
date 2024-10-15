INSERT INTO myapp_commentspostagem ("text",postagem_id,username) VALUES
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
INSERT INTO myapp_commentspostagem ("text",postagem_id,username) VALUES
	 ('mais um novo comentário',30,'ALUNO'),
	 ('asdasd',32,'ALUNO'),
	 ('sssss',32,'ALUNO'),
	 ('dddd',32,'ALUNO'),
	 ('primeiro comentário',33,'ALUNO'),
	 ('asdasd',27,'ALUNO'),
	 ('ddddddddddddddd',27,'ALUNO'),
	 ('mais um comentário',32,'nomeUser');
INSERT INTO myapp_postagem (content,likes,dislikes,escolha_unica,arquivo) VALUES
	 ('a primeira postagem',17,1,0,''),
	 ('outro',1,0,0,''),
	 ('conteudo novo',11,0,0,''),
	 ('teste de respostas',2,0,0,''),
	 ('asdasd',3,0,0,''),
	 ('Postagem de teste 3',7,0,0,''),
	 ('Pergunta com respostas',19,0,0,'images/imagemTeste1_KRwUcML.jpeg'),
	 ('Perguntas com Respostas 2',14,0,0,'images/images.jpeg');
INSERT INTO myapp_postagem_respostas (postagem_id,respostas_id) VALUES
	 (27,2),
	 (27,3),
	 (30,2),
	 (30,4),
	 (33,2),
	 (33,4),
	 (33,5),
	 (32,3),
	 (32,5),
	 (34,8);
INSERT INTO myapp_postagem_respostas (postagem_id,respostas_id) VALUES
	 (34,7),
	 (35,9),
	 (35,3),
	 (36,2),
	 (36,3),
	 (36,7);
INSERT INTO myapp_respostas (respostaTexto,respondido) VALUES
	 ('isso é uma resposta',12),
	 ('isso é outra resposta',27),
	 ('nova resposta',4),
	 ('',22),
	 ('Mais uma resposta texto',11),
	 ('resposta texto 2',3),
	 ('pergunta de teste 4',25);
INSERT INTO myapp_user (name,password,email,username) VALUES
	 ('','','',''),
	 ('nomealuno','senhaaluno','email@aluno.com','alunoteste2'),
	 ('Usuario novo','senhadousuario','usuario@novo.com','Usuario apenas'),
	 ('novo Usuario','senhanovousuario','novo@usuario.com','awdasdad'),
	 ('ALUNO','Ev2ryday@','email@email.com','nomeUser'),
	 ('ALUNO','Ev2ryday2','email@outroemail.com','ALUNO'),
	 ('ALUNO2','Ev2ryday','email@Outroemail.com','ALUNO2');

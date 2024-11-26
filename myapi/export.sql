INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (1,'add_user','Can add user'),
	 (1,'change_user','Can change user'),
	 (1,'delete_user','Can delete user'),
	 (1,'view_user','Can view user'),
	 (2,'add_postagem','Can add postagem'),
	 (2,'change_postagem','Can change postagem'),
	 (2,'delete_postagem','Can delete postagem'),
	 (2,'view_postagem','Can view postagem'),
	 (3,'add_commentspostagem','Can add comments postagem'),
	 (3,'change_commentspostagem','Can change comments postagem');
INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (3,'delete_commentspostagem','Can delete comments postagem'),
	 (3,'view_commentspostagem','Can view comments postagem'),
	 (4,'add_logentry','Can add log entry'),
	 (4,'change_logentry','Can change log entry'),
	 (4,'delete_logentry','Can delete log entry'),
	 (4,'view_logentry','Can view log entry'),
	 (5,'add_permission','Can add permission'),
	 (5,'change_permission','Can change permission'),
	 (5,'delete_permission','Can delete permission'),
	 (5,'view_permission','Can view permission');
INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (6,'add_group','Can add group'),
	 (6,'change_group','Can change group'),
	 (6,'delete_group','Can delete group'),
	 (6,'view_group','Can view group'),
	 (7,'add_user','Can add user'),
	 (7,'change_user','Can change user'),
	 (7,'delete_user','Can delete user'),
	 (7,'view_user','Can view user'),
	 (8,'add_contenttype','Can add content type'),
	 (8,'change_contenttype','Can change content type');
INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (8,'delete_contenttype','Can delete content type'),
	 (8,'view_contenttype','Can view content type'),
	 (9,'add_session','Can add session'),
	 (9,'change_session','Can change session'),
	 (9,'delete_session','Can delete session'),
	 (9,'view_session','Can view session'),
	 (10,'add_respostas','Can add respostas'),
	 (10,'change_respostas','Can change respostas'),
	 (10,'delete_respostas','Can delete respostas'),
	 (10,'view_respostas','Can view respostas');
INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (3,'add_commentarios','Can add commentarios'),
	 (3,'change_commentarios','Can change commentarios'),
	 (3,'delete_commentarios','Can delete commentarios'),
	 (3,'view_commentarios','Can view commentarios'),
	 (11,'add_persistenciauserresposta','Can add persistencia user resposta'),
	 (11,'change_persistenciauserresposta','Can change persistencia user resposta'),
	 (11,'delete_persistenciauserresposta','Can delete persistencia user resposta'),
	 (11,'view_persistenciauserresposta','Can view persistencia user resposta'),
	 (12,'add_persistenciauserpostagem','Can add persistencia user postagem'),
	 (12,'change_persistenciauserpostagem','Can change persistencia user postagem');
INSERT INTO auth_permission (content_type_id,codename,name) VALUES
	 (12,'delete_persistenciauserpostagem','Can delete persistencia user postagem'),
	 (12,'view_persistenciauserpostagem','Can view persistencia user postagem');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('novo comentário',27,'ALUNO'),
	 ('asdasdasdasdasd',27,'ALUNO'),
	 ('primeiro comentário dessa postagem',31,'ALUNO'),
	 ('segunda comentário dessa postagem',31,'ALUNO'),
	 ('dfhtgffhgfghfhg',27,'ALUNO'),
	 ('primeiro comentário',33,'ALUNO'),
	 ('asdasd',27,'ALUNO'),
	 ('ddddddddddddddd',27,'ALUNO'),
	 ('nome comentário',36,'ALUNO2'),
	 ('ssss',35,'ALUNO2');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('ddd',36,'ALUNO2'),
	 ('errrrrrrerer',33,'ALUNO2'),
	 ('errrrrrrerer',33,'ALUNO2'),
	 ('rrrrrrrrrrr',33,'ALUNO2'),
	 ('eeeeeeeeeeeee',33,'ALUNO2'),
	 ('eeeeee',35,'alunoteste2'),
	 ('rrrrrrrrrrrrr',35,'awdasdad'),
	 ('eeeeeeeeeeeeeeeeeeeeeee',34,'awdasdad'),
	 ('ererererer',33,'awdasdad'),
	 ('mais um comentário de teste',31,'awdasdad');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('ola ola',98,'Marrior'),
	 ('oi oi',98,'Marrior'),
	 ('mais um comentário',88,'Marrior'),
	 ('wewewe',87,'Marrior'),
	 ('wewe',87,'Marrior'),
	 ('eee',64,'Marrior'),
	 ('eee',39,'Marrior'),
	 ('eee',39,'Marrior'),
	 ('e',39,'Marrior'),
	 ('e',36,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('w',36,'Marrior'),
	 ('e',36,'Marrior'),
	 ('w',36,'Marrior'),
	 ('eeee',35,'Marrior'),
	 ('e',35,'Marrior'),
	 ('ttt',98,'Marrior'),
	 ('tttt',98,'Marrior'),
	 ('eeeeeeee',98,'Marrior'),
	 ('eeeeeeee',98,'Marrior'),
	 ('sssss',98,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('sssss',98,'Marrior'),
	 ('sssss',98,'Marrior'),
	 ('sssss',98,'Marrior'),
	 ('sssss',98,'Marrior'),
	 ('sssss',98,'Marrior'),
	 ('sssss',98,'Marrior'),
	 ('eee',98,'Marrior'),
	 ('eee',98,'Marrior'),
	 ('eee',98,'Marrior'),
	 ('eee',98,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('eeee',98,'Marrior'),
	 ('asdasdasdasd',98,'Marrior'),
	 ('asdasdsa',88,'Marrior'),
	 ('erererer',88,'Marrior'),
	 ('tetetet',88,'Marrior'),
	 ('eeeee',88,'Marrior'),
	 ('ererer',88,'Marrior'),
	 ('rrrrrrrr',88,'Marrior'),
	 ('rrrrrr',87,'Marrior'),
	 ('tt',87,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('ererer',88,'Marrior'),
	 ('rrrr',88,'Marrior'),
	 ('eeee',98,'Marrior'),
	 ('eeee',88,'Marrior'),
	 ('eeeee',87,'Marrior'),
	 ('ttttt',87,'Marrior'),
	 ('e',87,'Marrior'),
	 ('e',87,'Marrior'),
	 ('e',87,'Marrior'),
	 ('asdasdasd',88,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('wdwdwd',36,'Marrior2'),
	 ('eeeeeeee',36,'Marrior2'),
	 ('ererere',64,'Marrior2'),
	 ('rrrr',64,'Marrior2'),
	 ('asdasd',98,'Marrior'),
	 ('asddeee',98,'Marrior'),
	 ('eeeee',98,'Marrior'),
	 ('eeeeeeeeee',98,'Marrior'),
	 ('eee',98,'Marrior'),
	 ('eeee',88,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('eeee',88,'Marrior'),
	 ('eeeee',88,'Marrior'),
	 ('ererer',88,'Marrior'),
	 ('tttt',88,'Marrior'),
	 ('wwwwwwwwww',88,'Marrior'),
	 ('awawawwa',88,'Marrior'),
	 ('eeeeeeeeeeeee',87,'Marrior'),
	 ('tttttttt',87,'Marrior'),
	 ('wewewe',98,'Marrior'),
	 ('rrrrrrrrrr',98,'Marrior');
INSERT INTO myapp_commentarios (text,postagem_id,username) VALUES
	 ('sdsdsd',98,'Marrior2'),
	 ('eeeeeeeeeeeee',88,'Marrior2'),
	 ('eeee',87,'Marrior2'),
	 ('eer',64,'Marrior2');
INSERT INTO myapp_persistenciauserpostagem (postagem_id,user_id) VALUES
	 (87,'usuarioQueNaoExiste'),
	 (88,'usuarioQueNaoExiste'),
	 (87,'Marrior'),
	 (98,'Marrior'),
	 (88,'Marrior'),
	 (35,'Marrior'),
	 (64,'Marrior'),
	 (98,'Marrior2'),
	 (35,'Marrior2'),
	 (34,'Marrior2');
INSERT INTO myapp_persistenciauserpostagem (postagem_id,user_id) VALUES
	 (88,'Marrior2'),
	 (39,'Marrior2'),
	 (39,'Marrior'),
	 (36,'Marrior'),
	 (34,'Marrior'),
	 (31,'Marrior'),
	 (27,'Marrior'),
	 (87,'Marrior2'),
	 (64,'Marrior2'),
	 (36,'Marrior2');
INSERT INTO myapp_persistenciauserresposta (user_id,postagem_id) VALUES
	 ('usuarioQueNaoExiste',87),
	 ('Marrior',35),
	 ('Marrior',34),
	 ('Marrior',87),
	 ('Marrior',27),
	 ('Marrior2',87),
	 ('Marrior2',35),
	 ('Marrior2',34);
INSERT INTO myapp_postagem (arquivo,content,likes,dislikes,escolha_unica,title) VALUES
	 ('','a primeira postagem',20,2,0,'LoremIpsum'),
	 ('','conteudo novo',13,1,0,'LoremIpsum'),
	 ('','asdasd',5,0,0,'LoremIpsum'),
	 ('','Postagem de teste 3',11,0,0,'LoremIpsum'),
	 ('images/imagemTeste1_KRwUcML.jpeg','Pergunta com respostas',27,0,1,'LoremIpsum'),
	 ('images/images.jpeg','Perguntas com Respostas 2',19,1,0,'LoremIpsum'),
	 ('','Teste para o websocket',3,1,0,'LoremIpsum'),
	 ('','agora vai',2,2,0,'LoremIpsum'),
	 ('','conteudo de Teste',3,0,0,'Postagem para teste'),
	 ('','conteudo de teste websocket',4,1,0,'Postagem para teste 2 websocket');
INSERT INTO myapp_postagem (arquivo,content,likes,dislikes,escolha_unica,title) VALUES
	 ('','Lorem Ipsum 12',2,0,0,'LoremIpsum 12');
INSERT INTO myapp_respostas (respostaTexto,respondido,postagem_id) VALUES
	 ('isso é uma resposta',14,27),
	 ('isso é outra resposta',31,27),
	 ('Mais uma resposta texto',19,34),
	 ('pergunta de teste 4',56,35),
	 ('mais uma resposta',3,87),
	 ('mais uma resposta 2',1,87);
INSERT INTO myapp_user (name,password,email,username) VALUES
	 ('','','',''),
	 ('Usuario novo','senhadousuario','usuario@novo.com','Usuario apenas'),
	 ('usuarioQueNaoExiste','LALAL2e2','lalalala@email.com','usuarioQueNaoExiste'),
	 ('Mario','Ev2ryday','mrlimaroberto@gmail.com','Marrior'),
	 ('Mario','Ev2ryday3','mrlimaroberto2@gmail.com','Marrior2');

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
	 (3,'view_commentarios','Can view commentarios');
INSERT INTO auth_user (password,last_login,is_superuser,username,last_name,email,is_staff,is_active,date_joined,first_name) VALUES
	 ('pbkdf2_sha256$720000$riAbfF8eCYylAxzrqB4O9z$TI2L6W39YQl55b0WGtOm5q1cqPFOLW3cL+3SYkvQKkg=','2024-10-16 11:38:18.870477',1,'admin','','',1,1,'2024-05-06 15:56:34.926003','');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('2','a primeira postagem',1,'[{"added": {}}]',2,1,'2024-05-06 16:03:40.873243'),
	 ('1','',3,'',2,1,'2024-05-06 16:03:51.011822'),
	 ('ALUNO','ALUNO',1,'[{"added": {}}]',1,1,'2024-05-06 16:05:29.261594'),
	 ('2','asdasd',1,'[{"added": {}}]',3,1,'2024-05-06 16:07:01.056978'),
	 ('2','asdasd',3,'',3,1,'2024-05-06 16:07:08.906439'),
	 ('4','',3,'',2,1,'2024-05-06 16:14:05.787537'),
	 ('3','',3,'',2,1,'2024-05-06 16:14:05.790409'),
	 ('3','primeiro comentário',1,'[{"added": {}}]',3,1,'2024-05-06 16:36:35.595871'),
	 ('3','primeiro comentário',2,'[]',3,1,'2024-05-06 18:05:37.782685'),
	 ('10','outro',3,'',2,1,'2024-05-06 19:29:29.634046');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('9','outro',3,'',2,1,'2024-05-06 19:29:29.637796'),
	 ('8','outro',3,'',2,1,'2024-05-06 19:29:29.641182'),
	 ('7','outro',3,'',2,1,'2024-05-06 19:29:29.645095'),
	 ('6','outro',3,'',2,1,'2024-05-06 19:29:29.649222'),
	 ('5','outro',3,'',2,1,'2024-05-06 19:29:29.652816'),
	 ('21','outro',3,'',2,1,'2024-05-07 16:39:08.780957'),
	 ('20','outro',3,'',2,1,'2024-05-07 16:39:08.784131'),
	 ('19','outro',3,'',2,1,'2024-05-07 16:39:08.786772'),
	 ('18','outro',3,'',2,1,'2024-05-07 16:39:08.789416'),
	 ('17','outro',3,'',2,1,'2024-05-07 16:39:08.791775');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('16','outro',3,'',2,1,'2024-05-07 16:39:08.794039'),
	 ('15','outro',3,'',2,1,'2024-05-07 16:39:08.796400'),
	 ('14','outro',3,'',2,1,'2024-05-07 16:39:08.798708'),
	 ('13','outro',3,'',2,1,'2024-05-07 16:39:08.801073'),
	 ('12','outro',3,'',2,1,'2024-05-07 16:39:08.803586'),
	 ('11','outro',3,'',2,1,'2024-05-07 16:39:08.806515'),
	 ('19','ALUNO',3,'',3,1,'2024-05-07 16:59:28.507600'),
	 ('18','ALUNO',3,'',3,1,'2024-05-07 16:59:28.510462'),
	 ('16','ALUNO',3,'',3,1,'2024-05-07 16:59:28.514417'),
	 ('15','ALUNO',3,'',3,1,'2024-05-07 16:59:28.518450');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('24','a primeira postagem',3,'',2,1,'2024-05-07 16:59:37.528627'),
	 ('2','a primeira postagem',3,'',2,1,'2024-05-07 16:59:37.588599'),
	 ('25','outro',3,'',2,1,'2024-05-07 16:59:37.617330'),
	 ('23','outro',3,'',2,1,'2024-05-07 16:59:37.621378'),
	 ('22','outro',3,'',2,1,'2024-05-07 16:59:37.624961'),
	 ('29','outro',3,'',2,1,'2024-05-07 17:16:35.026656'),
	 ('28','outro',3,'',2,1,'2024-05-07 17:16:35.031334'),
	 ('26','outro',3,'',2,1,'2024-05-07 17:16:35.035710'),
	 ('26','asdasdasd',3,'',3,1,'2024-05-07 17:16:43.678377'),
	 ('25','asdasd',3,'',3,1,'2024-05-07 17:16:43.682908');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('24','asdasd',3,'',3,1,'2024-05-07 17:16:43.686408'),
	 ('23','asdasd',3,'',3,1,'2024-05-07 17:16:43.690144'),
	 ('31','conteudo novo',1,'[{"added": {}}]',2,1,'2024-05-08 11:44:13.815254'),
	 ('116','sdsdsds',3,'',3,1,'2024-05-08 21:00:33.241873'),
	 ('115','sddddddd',3,'',3,1,'2024-05-08 21:00:33.246896'),
	 ('112','sdds',3,'',3,1,'2024-05-08 21:00:33.252273'),
	 ('111','dddddddd',3,'',3,1,'2024-05-08 21:00:33.256587'),
	 ('110','ddd',3,'',3,1,'2024-05-08 21:00:33.261066'),
	 ('108','bbbbbbbbbbbbb',3,'',3,1,'2024-05-08 21:00:33.265387'),
	 ('105','sdsdsdsd',3,'',3,1,'2024-05-08 21:00:33.269602');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('104','sdsd',3,'',3,1,'2024-05-08 21:00:33.274158'),
	 ('84','asdasd',3,'',3,1,'2024-05-08 21:00:33.278788'),
	 ('46','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.286466'),
	 ('20','asdasd',3,'',3,1,'2024-05-08 21:00:33.290777'),
	 ('117','sdsdsd',3,'',3,1,'2024-05-08 21:00:33.294836'),
	 ('113','asasd',3,'',3,1,'2024-05-08 21:00:33.299808'),
	 ('107','asassa',3,'',3,1,'2024-05-08 21:00:33.305885'),
	 ('106','asassa',3,'',3,1,'2024-05-08 21:00:33.309978'),
	 ('102','dddddddddd',3,'',3,1,'2024-05-08 21:00:33.314139'),
	 ('101','ddddddd',3,'',3,1,'2024-05-08 21:00:33.318305');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('100','dddddddddddd',3,'',3,1,'2024-05-08 21:00:33.322398'),
	 ('99','ddddddddd',3,'',3,1,'2024-05-08 21:00:33.326377'),
	 ('98','ssssssssssssssssss',3,'',3,1,'2024-05-08 21:00:33.330354'),
	 ('96','sdsd',3,'',3,1,'2024-05-08 21:00:33.337502'),
	 ('95','asdasd',3,'',3,1,'2024-05-08 21:00:33.343739'),
	 ('94','asdasdsa',3,'',3,1,'2024-05-08 21:00:33.349875'),
	 ('93','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.356025'),
	 ('92','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.362200'),
	 ('91','sdsd',3,'',3,1,'2024-05-08 21:00:33.368468'),
	 ('89','aAAAAAAAAAAAAAAA',3,'',3,1,'2024-05-08 21:00:33.374613');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('87','ddddddddd',3,'',3,1,'2024-05-08 21:00:33.380807'),
	 ('85','asdasd',3,'',3,1,'2024-05-08 21:00:33.387108'),
	 ('82','asdasd',3,'',3,1,'2024-05-08 21:00:33.393630'),
	 ('81','asdasd',3,'',3,1,'2024-05-08 21:00:33.400080'),
	 ('78','asdasd',3,'',3,1,'2024-05-08 21:00:33.407237'),
	 ('120','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.415426'),
	 ('118','aaaaaaaaaaaaaaa',3,'',3,1,'2024-05-08 21:00:33.421887'),
	 ('114','asdasd',3,'',3,1,'2024-05-08 21:00:33.428524'),
	 ('109','dddddddddddddddd',3,'',3,1,'2024-05-08 21:00:33.435011'),
	 ('103','ddddddddddddddd',3,'',3,1,'2024-05-08 21:00:33.441260');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('97','sdsds',3,'',3,1,'2024-05-08 21:00:33.447831'),
	 ('90','aaaaaaa',3,'',3,1,'2024-05-08 21:00:33.454409'),
	 ('88','dddddddddddd',3,'',3,1,'2024-05-08 21:00:33.460743'),
	 ('86','asdasd',3,'',3,1,'2024-05-08 21:00:33.467239'),
	 ('83','asdasd',3,'',3,1,'2024-05-08 21:00:33.473604'),
	 ('80','aksdlklklkk',3,'',3,1,'2024-05-08 21:00:33.480631'),
	 ('79','asdasd',3,'',3,1,'2024-05-08 21:00:33.487517'),
	 ('77','sdsdsd',3,'',3,1,'2024-05-08 21:00:33.493410'),
	 ('76','asdsad',3,'',3,1,'2024-05-08 21:00:33.499111'),
	 ('75','asdasd',3,'',3,1,'2024-05-08 21:00:33.505022');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('74','asdasd',3,'',3,1,'2024-05-08 21:00:33.510232'),
	 ('73','hello',3,'',3,1,'2024-05-08 21:00:33.515553'),
	 ('72','heelo',3,'',3,1,'2024-05-08 21:00:33.520122'),
	 ('71','sdsdsd',3,'',3,1,'2024-05-08 21:00:33.524987'),
	 ('70','asdasd',3,'',3,1,'2024-05-08 21:00:33.530970'),
	 ('69','asdasd',3,'',3,1,'2024-05-08 21:00:33.536929'),
	 ('68','asdasd',3,'',3,1,'2024-05-08 21:00:33.544479'),
	 ('67','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.551849'),
	 ('66','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.557875'),
	 ('65','asdasd',3,'',3,1,'2024-05-08 21:00:33.563702');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('64','asdasd',3,'',3,1,'2024-05-08 21:00:33.569426'),
	 ('63','asdasd',3,'',3,1,'2024-05-08 21:00:33.575875'),
	 ('62','asdasd',3,'',3,1,'2024-05-08 21:00:33.582458'),
	 ('61','asdasd',3,'',3,1,'2024-05-08 21:00:33.588968'),
	 ('60','TextEditingController#14803(TextEditingValue(text: ┤asdasdasd├, selection: TextSelection.collapsed(offset: 9, affinity: TextAffinity.downstream, isDirectional: false), composing: TextRange(start: -1, ',3,'',3,1,'2024-05-08 21:00:33.595104'),
	 ('58','novemen',3,'',3,1,'2024-05-08 21:00:33.601410'),
	 ('57','asdasd',3,'',3,1,'2024-05-08 21:00:33.608609'),
	 ('56','sdsdsdsd',3,'',3,1,'2024-05-08 21:00:33.614514'),
	 ('54','asdasdasdasdasd',3,'',3,1,'2024-05-08 21:00:33.619173'),
	 ('53','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.623790');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('52','asdasd',3,'',3,1,'2024-05-08 21:00:33.628413'),
	 ('51','asdasd',3,'',3,1,'2024-05-08 21:00:33.633198'),
	 ('50','asdads',3,'',3,1,'2024-05-08 21:00:33.638129'),
	 ('48','asdasd',3,'',3,1,'2024-05-08 21:00:33.643254'),
	 ('47','asdasd',3,'',3,1,'2024-05-08 21:00:33.647789'),
	 ('45','asdasd',3,'',3,1,'2024-05-08 21:00:33.652506'),
	 ('44','asdasd',3,'',3,1,'2024-05-08 21:00:33.657813'),
	 ('43','asdasd',3,'',3,1,'2024-05-08 21:00:33.663343'),
	 ('42','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.668666'),
	 ('41','asdasdads',3,'',3,1,'2024-05-08 21:00:33.673378');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('40','asdasd',3,'',3,1,'2024-05-08 21:00:33.678033'),
	 ('39','asdasdas',3,'',3,1,'2024-05-08 21:00:33.682522'),
	 ('38','asdasd',3,'',3,1,'2024-05-08 21:00:33.687120'),
	 ('37','asdasd',3,'',3,1,'2024-05-08 21:00:33.693714'),
	 ('36','asdasd',3,'',3,1,'2024-05-08 21:00:33.698623'),
	 ('35','ASASD',3,'',3,1,'2024-05-08 21:00:33.703789'),
	 ('34','asdasd',3,'',3,1,'2024-05-08 21:00:33.710127'),
	 ('33','asdasd',3,'',3,1,'2024-05-08 21:00:33.715165'),
	 ('32','asdasd',3,'',3,1,'2024-05-08 21:00:33.719739'),
	 ('31','ASdasd',3,'',3,1,'2024-05-08 21:00:33.724584');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('30','asdasd',3,'',3,1,'2024-05-08 21:00:33.729133'),
	 ('29','asdasdasd',3,'',3,1,'2024-05-08 21:00:33.733932'),
	 ('28','asdasd',3,'',3,1,'2024-05-08 21:00:33.738697'),
	 ('27','asdasd',3,'',3,1,'2024-05-08 21:00:33.743318'),
	 ('1','Isso é uma opção',1,'[{"added": {}}]',10,1,'2024-05-13 21:51:23.121698'),
	 ('1','Isso é uma opção',3,'',10,1,'2024-05-13 21:54:04.162123'),
	 ('2','isso é uma resposta',1,'[{"added": {}}]',10,1,'2024-05-13 21:54:20.490342'),
	 ('3','isso é outra resposta',1,'[{"added": {}}]',10,1,'2024-05-13 21:54:31.525529'),
	 ('32','teste de respostas',1,'[{"added": {}}]',2,1,'2024-05-13 21:54:37.948895'),
	 ('32','teste de respostas',2,'[]',2,1,'2024-05-13 21:59:43.225077');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('33','outro teste de resposta',1,'[{"added": {}}]',2,1,'2024-05-13 21:59:54.549065'),
	 ('33','outro teste de resposta',3,'',2,1,'2024-05-13 22:00:04.075858'),
	 ('4','nova resposta',1,'[{"added": {}}]',10,1,'2024-05-13 22:54:55.782362'),
	 ('33','asdasd',1,'[{"added": {}}]',2,1,'2024-05-14 12:08:54.411919'),
	 ('27','a primeira postagem',2,'[{"changed": {"fields": ["Respostas"]}}]',2,1,'2024-05-14 12:20:49.474855'),
	 ('30','outro',2,'[{"changed": {"fields": ["Respostas"]}}]',2,1,'2024-05-14 12:22:36.951588'),
	 ('27','a primeira postagem',2,'[]',2,1,'2024-05-14 12:25:31.537973'),
	 ('2','isso é uma resposta',2,'[{"changed": {"fields": ["RespostaBool"]}}]',10,1,'2024-05-14 13:24:51.790687'),
	 ('5','umRespostaDeTeste',1,'[{"added": {}}]',10,1,'2024-05-14 13:29:05.937296'),
	 ('5','umRespostaDeTeste',2,'[{"changed": {"fields": ["RespostaBool"]}}]',10,1,'2024-05-14 13:30:04.270698');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('ALUNO','ALUNO',2,'[]',1,1,'2024-05-16 00:06:42.367499'),
	 ('ALUNO','ALUNO',2,'[]',1,1,'2024-05-16 00:07:02.799433'),
	 ('3','isso é outra resposta',2,'[]',10,1,'2024-05-17 12:14:55.411548'),
	 ('27','a primeira postagem',2,'[]',2,1,'2024-05-17 15:14:39.795038'),
	 ('33','asdasd',2,'[{"changed": {"fields": ["Respostas", "Escolha unica"]}}]',2,1,'2024-05-17 15:14:47.436678'),
	 ('6','resposta de Teste',1,'[{"added": {}}]',10,1,'2024-06-20 16:25:21.466624'),
	 ('32','teste de respostas',2,'[{"changed": {"fields": ["Respostas", "Escolha unica"]}}]',2,1,'2024-06-20 16:25:34.652350'),
	 ('32','teste de respostas',2,'[{"changed": {"fields": ["Escolha unica"]}}]',2,1,'2024-06-21 16:46:15.529365'),
	 ('6','',3,'',10,1,'2024-06-27 13:43:59.552283'),
	 ('32','teste de respostas',2,'[{"changed": {"fields": ["Escolha unica"]}}]',2,1,'2024-06-27 16:15:41.956316');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('30','outro',2,'[{"changed": {"fields": ["Escolha unica"]}}]',2,1,'2024-06-27 16:15:54.892074'),
	 ('7','Mais uma resposta texto',1,'[{"added": {}}]',10,1,'2024-06-27 16:38:11.246211'),
	 ('8','resposta texto 2',1,'[{"added": {}}]',10,1,'2024-06-27 16:38:21.487515'),
	 ('34','Postagem de teste 3',1,'[{"added": {}}]',2,1,'2024-06-27 16:38:33.570433'),
	 ('9','pergunta de teste 4',1,'[{"added": {}}]',10,1,'2024-06-27 18:33:46.126112'),
	 ('35','Pergunta com respostas',1,'[{"added": {}}]',2,1,'2024-06-27 18:33:59.329756'),
	 ('36','Perguntas com Respostas 2',1,'[{"added": {}}]',2,1,'2024-06-27 18:34:12.308379'),
	 ('ALUNO','ALUNO',3,'',1,1,'2024-08-21 12:30:50.723774'),
	 ('usuarioooooooooooooooo','ALUNO',3,'',1,1,'2024-08-21 12:30:53.295415'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-08-29 13:13:44.430676');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-08-29 13:17:19.239518'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 13:11:54.818477'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:51:53.723500'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:53:45.228928'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:53:57.447033'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:54:02.886050'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:57:01.916358'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 17:58:36.630204'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:01:22.828273'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:01:30.413177');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:01:37.948984'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:06:09.871764'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:25:05.788818'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:25:09.997617'),
	 ('34','Postagem de teste 3',2,'[]',2,1,'2024-09-27 18:25:15.692713'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:25:21.202403'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:25:27.257453'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:26:54.788040'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:26:59.399447'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:27:08.795012');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:27:15.986385'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:33:44.341913'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:33:48.367437'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:33:54.218586'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:33:59.277146'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:55:49.995685'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:55:54.743667'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:56:00.575713'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 18:56:05.825717'),
	 ('34','Postagem de teste 3',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-09-27 19:05:45.711524');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-10-02 14:36:14.415531'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-10-02 14:36:19.664650'),
	 ('30','outro',2,'[{"changed": {"fields": ["Escolha unica"]}}]',2,1,'2024-10-02 17:45:09.634515'),
	 ('30','outro',2,'[]',2,1,'2024-10-02 17:46:47.853342'),
	 ('35','Pergunta com respostas',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-10-02 18:45:04.897962'),
	 ('35','Pergunta com respostas',2,'[]',2,1,'2024-10-04 18:46:32.720808'),
	 ('36','Perguntas com Respostas 2',2,'[{"changed": {"fields": ["Arquivo"]}}]',2,1,'2024-10-04 18:46:41.576067'),
	 ('27','a primeira postagem',2,'[]',2,1,'2024-10-10 13:29:54.086852'),
	 ('35','Pergunta com respostas',2,'[]',2,1,'2024-10-10 13:29:58.398822'),
	 ('nomeUser','ALUNO',3,'',1,1,'2024-10-16 11:32:02.851394');
INSERT INTO django_admin_log (object_id,object_repr,action_flag,change_message,content_type_id,user_id,action_time) VALUES
	 ('36','Perguntas com Respostas 2',2,'[]',1,1,'2024-10-16 11:38:44.480650'),
	 ('37','teste para nova tela de admin',1,'[{"added": {}}]',1,1,'2024-10-16 11:39:12.358733');
INSERT INTO django_content_type (app_label,model) VALUES
	 ('myapp','user'),
	 ('myapp','postagem'),
	 ('myapp','commentarios'),
	 ('admin','logentry'),
	 ('auth','permission'),
	 ('auth','group'),
	 ('auth','user'),
	 ('contenttypes','contenttype'),
	 ('sessions','session'),
	 ('myapp','respostas');
INSERT INTO django_migrations (app,name,applied) VALUES
	 ('contenttypes','0001_initial','2024-05-06 15:55:34.160106'),
	 ('auth','0001_initial','2024-05-06 15:55:34.171731'),
	 ('admin','0001_initial','2024-05-06 15:55:34.179494'),
	 ('admin','0002_logentry_remove_auto_add','2024-05-06 15:55:34.185837'),
	 ('admin','0003_logentry_add_action_flag_choices','2024-05-06 15:55:34.192287'),
	 ('contenttypes','0002_remove_content_type_name','2024-05-06 15:55:34.231792'),
	 ('auth','0002_alter_permission_name_max_length','2024-05-06 15:55:34.238225'),
	 ('auth','0003_alter_user_email_max_length','2024-05-06 15:55:34.244522'),
	 ('auth','0004_alter_user_username_opts','2024-05-06 15:55:34.250270'),
	 ('auth','0005_alter_user_last_login_null','2024-05-06 15:55:34.256534');
INSERT INTO django_migrations (app,name,applied) VALUES
	 ('auth','0006_require_contenttypes_0002','2024-05-06 15:55:34.258984'),
	 ('auth','0007_alter_validators_add_error_messages','2024-05-06 15:55:34.263943'),
	 ('auth','0008_alter_user_username_max_length','2024-05-06 15:55:34.271098'),
	 ('auth','0009_alter_user_last_name_max_length','2024-05-06 15:55:34.277688'),
	 ('auth','0010_alter_group_name_max_length','2024-05-06 15:55:34.287761'),
	 ('auth','0011_update_proxy_permissions','2024-05-06 15:55:34.295645'),
	 ('auth','0012_alter_user_first_name_max_length','2024-05-06 15:55:34.302267'),
	 ('sessions','0001_initial','2024-05-06 15:55:34.308060'),
	 ('myapp','0001_initial','2024-05-06 15:58:18.236869'),
	 ('myapp','0002_alter_commentspostagem_postagem_and_more','2024-05-06 16:12:08.390511');
INSERT INTO django_migrations (app,name,applied) VALUES
	 ('myapp','0003_alter_user_username','2024-05-06 17:41:26.369496'),
	 ('myapp','0004_alter_user_username','2024-05-06 17:54:22.936440'),
	 ('myapp','0005_remove_commentspostagem_user','2024-05-06 18:11:29.265203'),
	 ('myapp','0006_commentspostagem_username','2024-05-06 19:37:03.908388'),
	 ('myapp','0007_alter_commentspostagem_username','2024-05-07 17:12:58.741232'),
	 ('myapp','0008_respostas','2024-05-13 11:50:42.203402'),
	 ('myapp','0009_remove_respostas_postagem_postagem_respostas','2024-05-13 12:11:16.951578'),
	 ('myapp','0010_alter_respostas_options_and_more','2024-05-13 21:43:58.216028'),
	 ('myapp','0011_alter_postagem_respostas','2024-05-13 21:57:17.272862'),
	 ('myapp','0012_remove_postagem_respostas','2024-05-13 22:01:17.319061');
INSERT INTO django_migrations (app,name,applied) VALUES
	 ('myapp','0013_respostas_postagem','2024-05-13 22:02:02.699790'),
	 ('myapp','0014_remove_respostas_postagem_postagem_respostas','2024-05-13 22:07:12.284165'),
	 ('myapp','0015_alter_postagem_respostas','2024-05-13 22:50:06.926270'),
	 ('myapp','0016_alter_postagem_arquivo','2024-05-13 22:59:04.344761'),
	 ('myapp','0017_alter_postagem_arquivo_alter_postagem_respostas','2024-05-13 22:59:29.680316'),
	 ('myapp','0018_alter_postagem_respostas','2024-05-13 22:59:54.186723'),
	 ('myapp','0010_alter_respostas_options_respostas_respostabool','2024-05-14 11:32:35.522310'),
	 ('myapp','0019_merge_20240514_1132','2024-05-14 11:32:35.525052'),
	 ('myapp','0020_alter_respostas_options','2024-05-14 11:32:35.528201'),
	 ('myapp','0021_remove_postagem_respostas_respostas_postagem','2024-05-14 11:36:13.342071');
INSERT INTO django_migrations (app,name,applied) VALUES
	 ('myapp','0022_remove_respostas_postagem_postagem_respostas','2024-05-14 12:20:39.569604'),
	 ('myapp','0023_postagem_escolha_unica','2024-05-14 13:10:01.355676'),
	 ('myapp','0024_remove_respostas_respostabool_respostas_respondido','2024-05-16 15:31:42.391317'),
	 ('myapp','0025_alter_postagem_arquivo','2024-09-27 13:11:14.285813'),
	 ('myapp','0026_alter_postagem_arquivo','2024-10-02 10:59:18.736174'),
	 ('myapp','0027_rename_commentspostagem_commentarios','2024-10-16 11:31:44.925736');
INSERT INTO django_session (session_key,session_data,expire_date) VALUES
	 ('x77hs9w4z0cuikon8ppvo1il58o57jla','.eJxVjDEOwjAMRe-SGUWkjeOEkZ0zRHZskQJqpaadEHenlTrA-t97_20yrUvNa9M5D2IuxpnT78ZUnjruQB403idbpnGZB7a7Yg_a7G0SfV0P9--gUqtbTV5UEEMnyRUfe0AATCEkLtqDC5wgOvSFQDASxjNzp0COWDenQ_P5AtB0N40:1s4oON:LYtS2jj3q8MZmDZoIi_dLDLhcZOqj0IpVGn0LG0OYG4','2024-05-22 20:59:59.646045'),
	 ('is9vigapbcesgislc3f3d86l5dofzwvc','.eJxVjEEOwiAQRe_C2pAyHaG4dN8zNAPMSNVAUtqV8e7apAvd_vfef6mJtjVPW-NlmpO6KKNOv1ug-OCyg3Sncqs61rIuc9C7og_a9FgTP6-H-3eQqeVvbXuhEHw4g-1YBiSEFK0T6ESg9xbQeATx7BmMjyREYQARYyI7dKjeH_ARODs:1s7Odd:z_GJZ_FlBVaxpwklnGL6tOFpQ2Mv98pN_26O8Ei7KlU','2024-05-30 00:06:25.891318'),
	 ('kge7fh87g5zeqma7r1qiwqig0vgr4mf2','.eJxVjEEOgjAQRe_StWkKlE7HpXvP0ExnRkENTSisjHcXEha6_e_99zaJ1mVIa9U5jWLOpjGn3y0TP3XagTxouhfLZVrmMdtdsQet9lpEX5fD_QsMVIft7TxAwBAUuVfI0AVGldyGSNH1nolZ45YTQsJbzg2Kd41AgIgdtJ35fAHrvTgh:1s7asr:X4asHhjVmJvCWa8Frj2UI5ljV7cIOSZqaJb8Gv-_rfQ','2024-05-30 13:10:57.310474'),
	 ('73io5ix9b2e6uyoo4dpjqiijbeei063g','.eJxVjEEOgjAQRe_StWkKlE7HpXvP0ExnRkENTSisjHcXEha6_e_99zaJ1mVIa9U5jWLOpjGn3y0TP3XagTxouhfLZVrmMdtdsQet9lpEX5fD_QsMVIft7TxAwBAUuVfI0AVGldyGSNH1nolZ45YTQsJbzg2Kd41AgIgdtJ35fAHrvTgh:1sKKTa:-hDsgW_BLj50NglT4aIfnjwY_L95Mr1iCLTNRzjpRzI','2024-07-04 16:17:30.354020'),
	 ('fqjefs0b7u0tw7xp3clvp119iic2301y','.eJxVjEEOgjAQRe_StWkKlE7HpXvP0ExnRkENTSisjHcXEha6_e_99zaJ1mVIa9U5jWLOpjGn3y0TP3XagTxouhfLZVrmMdtdsQet9lpEX5fD_QsMVIft7TxAwBAUuVfI0AVGldyGSNH1nolZ45YTQsJbzg2Kd41AgIgdtJ35fAHrvTgh:1sKhOY:CNRRZu8N-cv0gwJHhhmw92uH44PloQX6_xoja7-Ejc0','2024-07-05 16:45:50.082784'),
	 ('vlu91q9gsdhdelm75x8r0yin8rzg1yuc','.eJxVjEsOAiEQBe_C2hA-CrRL956BNHQjowaSYWZlvLtOMgvdvqp6LxFxXWpcB89xInEWWhx-t4T5wW0DdMd26zL3tsxTkpsidzrktRM_L7v7d1Bx1G-tNBkDLgSvAlqPxvgECYiQobgCFogVh5CLzUX7EzgVbPLaOLBJ81G8P8_1N2M:1sMpE0:eUtfB_OP-00tvu1d6vvVYrNwY2-gGc8Z72RshNk5kO8','2024-07-11 13:31:44.202537'),
	 ('v3e4cy4s13g41t03yl8ujzp51va3wxo2','.eJxVjDsOwjAQBe_iGll2_KekzxmsXa-DA8iR4qRC3B1HSgHtm5n3ZhH2rcS95TXOxK5MssvvhpCeuR6AHlDvC09L3dYZ-aHwkzY-LpRft9P9OyjQSq81KZ1oCDhRMglJOQsg_CSylgmCMoNxUjgvrBHSqeDRo-48hG4rC-zzBeoAN3M:1sWIR0:0cEFxNy3KZyYLQw8i3NFKtMunO3wZ__PIWOKpZgLx3Q','2024-08-06 16:32:18.971735'),
	 ('qpfadgovz0em9a1waa3rvtu89veeykna','.eJxVjLEOAiEQRP-F2hDQ5RYs7f0GwrIgpwaS464y_ruSXKHNFPPezEv4sK3Fbz0tfmZxFlocfjsK8ZHqAHwP9dZkbHVdZpJDkTvt8to4PS-7-3dQQi_ftcGjPWVEthkhwkTRGYcWKClkIjI6QYgjGRQ4bThrjgkxZMhWTeL9AeApOBw:1sZewY:tlLn-5cBOfNxLFbQ1c3Rsc5JcZF5w1ZQXCYHdk8sgpM','2024-08-15 23:10:46.269138'),
	 ('1hpdckj01ierydths4cjghr0kn39vrwd','.eJxVjEEOwiAQRe_C2hAoIODSfc9AZoZBqoYmpV0Z765NutDtf-_9l0iwrTVtnZc0ZXERWpx-NwR6cNtBvkO7zZLmti4Tyl2RB-1ynDM_r4f7d1Ch12-thnOOEAPbYNBjsdY7j1rb4gyXEIy3hRW6ELUijoZoIGLtPbvsIpB4fwDTpjft:1seIH7:ITgaX6RGfq4v9TDs7YQ5D2WJQizB24mUcZBQ8mtYhIw','2024-08-28 17:59:09.285355'),
	 ('lv2vobtexv1x59svx98wg6uwzho0fu5s','.eJxVjEEOwiAQRe_C2hAoIODSfc9AZoZBqoYmpV0Z765NutDtf-_9l0iwrTVtnZc0ZXERWpx-NwR6cNtBvkO7zZLmti4Tyl2RB-1ynDM_r4f7d1Ch12-thnOOEAPbYNBjsdY7j1rb4gyXEIy3hRW6ELUijoZoIGLtPbvsIpB4fwDTpjft:1sitWT:PYnRa2xRm77V0AZ3DrsUeCOKHHG561hMkpUf3GSFu-k','2024-09-10 10:34:01.099350');
INSERT INTO django_session (session_key,session_data,expire_date) VALUES
	 ('3b12tmvr2rngw4j5kbpbf3iu65ffoq6h','.eJxVjDEOwjAMRe-SGUU1TezCyM4ZIid2SAGlUtNOiLtDpQ6w_vfef5nA61LC2nQOo5izAXP43SKnh9YNyJ3rbbJpqss8RrspdqfNXifR52V3_w4Kt_KtMwpSTBqHIROIAHMSzM6D9ApEouqdSp8J1aHr0CvJKXtOR6cdePP-ABmVONQ:1suAl5:jpPiiyfObHwM_ylXQIBxSa-2II-QUQxVRXznt-xb5kQ','2024-10-11 13:11:43.314356'),
	 ('jf3vh0og6npwa9u39bkchr5sjjds9ptz','.eJxVjDEOwjAMRe-SGUU1TezCyM4ZIid2SAGlUtNOiLtDpQ6w_vfef5nA61LC2nQOo5izAXP43SKnh9YNyJ3rbbJpqss8RrspdqfNXifR52V3_w4Kt_KtMwpSTBqHIROIAHMSzM6D9ApEouqdSp8J1aHr0CvJKXtOR6cdePP-ABmVONQ:1suFz2:Di2SSfHpzZuE7YBGLdcacoCGN9xGcsSoqw1ewnX5dks','2024-10-11 18:46:28.445147'),
	 ('2i0fteuyd5fk9szqg8nxlhy8vzm3euvr','.eJxVjMsOwiAURP-FtSE8L-jSvd9AgHuRqoGktCvjv9smXehy5pyZNwtxXWpYB81hQnZhkp1-uxTzk9oO8BHbvfPc2zJPie8KP-jgt470uh7u30GNo25rV2wWSNE6BI0ZvDIUQW4p-WyhFAEITidFOYE3XoJBp1WhIpQkeWafL_dVOBI:1sw0ND:qDrSTonCQh4K0BME2tJH021VMbuhiUBZUl2p--KCTiM','2024-10-16 14:30:39.030206'),
	 ('z2a08q0dovny2ip6g5wqd200hohj2lpc','.eJxVjMsOwiAURP-FtSE8L-jSvd9AgHuRqoGktCvjv9smXehy5pyZNwtxXWpYB81hQnZhkp1-uxTzk9oO8BHbvfPc2zJPie8KP-jgt470uh7u30GNo25rV2wWSNE6BI0ZvDIUQW4p-WyhFAEITidFOYE3XoJBp1WhIpQkeWafL_dVOBI:1sw3No:NPbV2g9BtQCL_JQugrc7eCKqiDnY_2BZPqucqZVArO8','2024-10-16 17:43:28.823778'),
	 ('zxnw159nelimkaqlhmlghw8g7mw5v6x7','.eJxVjMsOwiAURP-FtSE8L-jSvd9AgHuRqoGktCvjv9smXehy5pyZNwtxXWpYB81hQnZhkp1-uxTzk9oO8BHbvfPc2zJPie8KP-jgt470uh7u30GNo25rV2wWSNE6BI0ZvDIUQW4p-WyhFAEITidFOYE3XoJBp1WhIpQkeWafL_dVOBI:1sysnP:AnGCqwdN4zOlpnVG0sZWFOjIKz5ZwzFuXhOLp6kpmIA','2024-10-24 13:01:35.047025'),
	 ('w7ir2fleltfll8yxxz1zxnf8kric13dk','.eJxVjMsOwiAURP-FtSE8L-jSvd9AgHuRqoGktCvjv9smXehy5pyZNwtxXWpYB81hQnZhkp1-uxTzk9oO8BHbvfPc2zJPie8KP-jgt470uh7u30GNo25rV2wWSNE6BI0ZvDIUQW4p-WyhFAEITidFOYE3XoJBp1WhIpQkeWafL_dVOBI:1t12M6:hqyMK-dgZU8DC8mVqGoRfjuaM4oOK2euQwJbXhJ6o8U','2024-10-30 11:38:18.873443');
INSERT INTO myapp_commentarios ("text",postagem_id,username) VALUES
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
INSERT INTO myapp_commentarios ("text",postagem_id,username) VALUES
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
	 ('Pergunta com respostas',21,0,0,'images/imagemTeste1_KRwUcML.jpeg'),
	 ('Perguntas com Respostas 2',14,0,0,'images/images.jpeg'),
	 ('teste para nova tela de admin',0,0,1,'');
INSERT INTO myapp_respostas (respostaTexto,respondido,postagem_id) VALUES
	 ('isso é uma resposta',12,27),
	 ('isso é outra resposta',27,27),
	 ('nova resposta',4,30),
	 ('Mais uma resposta texto',11,34),
	 ('resposta texto 2',3,32),
	 ('pergunta de teste 4',25,35);
INSERT INTO myapp_user (name,password,email,username) VALUES
	 ('','','',''),
	 ('nomealuno','senhaaluno','email@aluno.com','alunoteste2'),
	 ('Usuario novo','senhadousuario','usuario@novo.com','Usuario apenas'),
	 ('novo Usuario','senhanovousuario','novo@usuario.com','awdasdad'),
	 ('ALUNO','Ev2ryday2','email@outroemail.com','ALUNO'),
	 ('ALUNO2','Ev2ryday','email@Outroemail.com','ALUNO2'),
	 ('usuarioQueNaoExiste','LALAL2e2','lalalala@email.com','usuarioQueNaoExiste');

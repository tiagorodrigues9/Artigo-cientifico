create database camarize_bd;

use camarize_bd;
	 
# Tabela para apenas os registros dos tipos de camarão que são diversos.

create table Tipos_camarao(
	id_tipo_camarao int auto_increment primary key,
	nome varchar(100)
);
	 
# Dieta ideal.

create table Dietas(
	id_dieta int auto_increment primary key,
	descricao varchar(100)
);
	 
# Condições ideais de temperatura, pH e amônia 
# para cada tipo especifico de camarão.

create table Condicoes_ideais(
	id_condicao int auto_increment primary key,
	id_tipo_camarao int,
	temp_ideal double,
	ph_ideal double,
	amonia_ideal double,
	constraint fk_camarao_condicoes foreign key(id_tipo_camarao)
     references Tipos_camarao(id_tipo_camarao)
);

# Registro do ambiente cativeiro, relacionando com o tipo de camarão que abriga, 
# e média diária dos parâmetros.

create table Cativeiros(
	id_cativeiro int auto_increment primary key,
	id_tipo_camarao int,
	data_instalacao date,
	foto_cativeiro varchar(100),
	temp_media_diaria double,
	ph_medio_diario double,
	amonia_media_diaria double,
	constraint fk_camarao_cativeiro foreign key(id_tipo_camarao)
     references Tipos_camarao(id_tipo_camarao)
);

	 
# Parâmetros atuais de cada cativeiro.

create table Parametros_atuais(
	id_parametros_atuais int auto_increment primary key,
	datahora datetime,
	temp_atual double,
	ph_atual double,
	amonia_atual double,
	id_cativeiro int,
	constraint fk_cativeiro_parametro foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro)
);
	 
# Especificação para cada tipo de camarão
# relacionando as condições ambientais ideais e dieta com o tipo de camarão.

create table Especif_camarao(
	id_especif int auto_increment primary key,
	id_dieta int,
	id_condicao int,
	constraint fk_dieta_especif foreign key(id_dieta) 
     references Dietas(id_dieta),
	constraint fk_condicao_especif foreign key(id_condicao)
     references Condicoes_ideais(id_condicao)
);
	 
	 
# Registro de alimentações dadas pelo dispensador de racão 
# de acordo com a dieta do cativeiro.

create table Alimentacao(
	id_alimentacao int auto_increment primary key,
	datahora_alimentacao datetime,
	desc_alimentacao varchar(100),
	id_dieta int,
	id_cativeiro int,
	constraint fk_dieta_alimentacao foreign key(id_dieta)
     references Dietas(id_dieta),
	constraint fk_cativeiro_alimentacao foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro)
);
	 
# Registro dos sitios de camarão.

create table Sitios(
	id_sitio int auto_increment primary key,
	nome varchar(100),
	localizacao varchar(255)
);
	 
# Relacionando sitios e cativeiros.

create table SitiosxCativeiros(
	id_sitio_cativieiro int auto_increment primary key,
	id_sitio int,
	id_cativeiro int,
	constraint fk_sitio_sitioxcat foreign key(id_sitio)
     references Sitios(id_sitio),
	constraint fk_cativeiro_sitioxcat foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro)
);
	 
# Conta de usuário.

create table Usuarios(
	id_usuario int auto_increment primary key,
	nome_usuario varchar(100),
	email_usuario varchar(50),
	telefone varchar(11),
	senha varchar(50),
	foto_perfil varchar(100)
);
	 
# Relacionando cada usuário com seu sitio.

create table UsuariosxSitios(
	id_usuarioxsitio int auto_increment	primary key,
	id_usuario int,
	id_sitio int,
	constraint fk_usuario_usuxsitio foreign key(id_usuario)
     references Usuarios(id_usuario),
	constraint fk_sitio_usuxsitio foreign key(id_sitio)
     references Sitios(id_sitio)
);
	 
# Criar registros de relatórios de tanques individuais. 

create table Relatorio_individual(
	id_relatiorio_individual int auto_increment primary key,
	texto text,
	id_cativeiro int,
	constraint fk_cativeiro_relatorio_i foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro)
);
	 
# Criar registros de relatórios de todos os tanques do sitio.

create table Relatorio_geral(
	id_relatorio_geral int auto_increment primary key,
	texto text,
	id_cativeiro int,
	id_sitio int,
	constraint fk_sitio_relatorio_g foreign key(id_sitio)
     references Sitios(id_sitio)
);
	 
# Tipos de sensor.

create table Tipos_sensor(
	id_tipo_sensor int auto_increment primary key,
	descricao varchar(50)
);
	 
# Registrar sensor.

create table Sensores(
	id_sensor int auto_increment primary key,
	apelido varchar(100),
	id_tipo_sensor int,
	constraint fk_tipo_sensores foreign key(id_tipo_sensor)
     references Tipos_sensor(id_tipo_sensor)
);
	 
# Relacionando quais sensores estão presentes em quais cativeiros.

create table SensoresxCativeiros(
	id_sensor_cativeiro int auto_increment primary key,
	id_sensor int,
	id_cativeiro int,
	constraint fk_sensor_cativeiros foreign key(id_sensor)
     references Sensores(id_sensor),
	constraint fk_cativeiro_sensor foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro)
);
	 
# Recomendações a serem feitas.

create table Recomendacoes(
	id_recomendacao int auto_increment primary key,
	recomendacao text,
	id_cativeiro int,
	id_sitio int,
	constraint fk_cativeiro_rec foreign key(id_cativeiro)
     references Cativeiros(id_cativeiro),
	constraint fk_sitio_rec foreign key(id_sitio)
     references Sitios(id_sitio)
);
    
# Tipos_camarao

insert into Tipos_camarao (nome) values ('Camarão Branco');
insert into Tipos_camarao (nome) values ('Camarão Rosa');
insert into Tipos_camarao (nome) values ('Camarão Tigre');

# Dietas

insert into Dietas (descricao) values ('Dieta Proteica');
insert into Dietas (descricao) values ('Dieta Equilibrada');
insert into Dietas (descricao) values ('Dieta Vegetariana');

# Condicoes_ideais

insert into Condicoes_ideais (id_tipo_camarao, temp_ideal, ph_ideal, amonia_ideal) 
values (1, 27.5, 7.8, 0.1);
insert into Condicoes_ideais (id_tipo_camarao, temp_ideal, ph_ideal, amonia_ideal) 
values (2, 25.0, 7.5, 0.2);
insert into Condicoes_ideais (id_tipo_camarao, temp_ideal, ph_ideal, amonia_ideal) 
values (3, 28.0, 7.9, 0.15);

# Cativeiros

insert into Cativeiros (id_tipo_camarao, data_instalacao, foto_cativeiro,
 temp_media_diaria, ph_medio_diario, amonia_media_diaria) 
values (1, '2024-01-10', 'foto1.jpg', 26.8, 7.7, 0.1);
insert into Cativeiros (id_tipo_camarao, data_instalacao, foto_cativeiro,
 temp_media_diaria, ph_medio_diario, amonia_media_diaria) 
values (2, '2024-02-15', 'foto2.jpg', 25.2, 7.5, 0.2);
insert into Cativeiros (id_tipo_camarao, data_instalacao, foto_cativeiro,
 temp_media_diaria, ph_medio_diario, amonia_media_diaria) 
values (3, '2024-03-20', 'foto3.jpg', 28.1, 7.9, 0.15);

# Parametros_atuais

insert into Parametros_atuais (datahora, temp_atual, ph_atual,
 amonia_atual, id_cativeiro) 
values ('2024-11-15 08:00:00', 27.0, 7.8, 0.1, 1);
insert into Parametros_atuais (datahora, temp_atual, ph_atual,
 amonia_atual, id_cativeiro) 
values ('2024-11-15 09:00:00', 25.1, 7.5, 0.2, 2);
insert into Parametros_atuais (datahora, temp_atual, ph_atual,
 amonia_atual, id_cativeiro) 
values ('2024-11-15 10:00:00', 28.0, 7.9, 0.15, 3);

# Especif_camarao

insert into Especif_camarao (id_dieta, id_condicao) values (1, 1);
insert into Especif_camarao (id_dieta, id_condicao) values (2, 2);
insert into Especif_camarao (id_dieta, id_condicao) values (3, 3);

# Alimentacao

insert into Alimentacao (datahora_alimentacao, desc_alimentacao,
 id_dieta, id_cativeiro) 
values ('2024-11-15 08:30:00', 'Ração Proteica', 1, 1);
insert into Alimentacao (datahora_alimentacao, desc_alimentacao,
 id_dieta, id_cativeiro) 
values ('2024-11-15 09:00:00', 'Ração Equilibrada', 2, 2);
insert into Alimentacao (datahora_alimentacao, desc_alimentacao,
 id_dieta, id_cativeiro) 
values ('2024-11-15 10:30:00', 'Ração Vegetariana', 3, 3);

# Sitios

insert into Sitios (nome, localizacao) values ('Sítio do Camarão 1', 'Local A');
insert into Sitios (nome, localizacao) values ('Sítio do Camarão 2', 'Local B');
insert into Sitios (nome, localizacao) values ('Sítio do Camarão 3', 'Local C');

# SitiosxCativeiros

insert into SitiosxCativeiros (id_sitio, id_cativeiro) values (1, 1);
insert into SitiosxCativeiros (id_sitio, id_cativeiro) values (2, 2);
insert into SitiosxCativeiros (id_sitio, id_cativeiro) values (3, 3);

# Usuarios

insert into Usuarios (nome_usuario, email_usuario, telefone, senha, foto_perfil) 
values ('João Silva', 'joao@example.com', '12345678901', 'senha123', 'joao.jpg');
insert into Usuarios (nome_usuario, email_usuario, telefone, senha, foto_perfil) 
values ('Maria Santos', 'maria@example.com', '98765432109', 'senha456', 'maria.jpg');
insert into Usuarios (nome_usuario, email_usuario, telefone, senha, foto_perfil) 
values ('Pedro Almeida', 'pedro@example.com', '11223344556', 'senha789', 'pedro.jpg');

# UsuariosxSitios

insert into UsuariosxSitios (id_usuario, id_sitio) values (1, 1);
insert into UsuariosxSitios (id_usuario, id_sitio) values (2, 2);
insert into UsuariosxSitios (id_usuario, id_sitio) values (3, 3);

# Relatorio_individual

insert into Relatorio_individual (texto, id_cativeiro) 
values ('Parâmetros dentro do ideal.', 1);
insert into Relatorio_individual (texto, id_cativeiro) 
values ('pH levemente elevado.', 2);
insert into Relatorio_individual (texto, id_cativeiro) 
values ('Temperatura ideal.', 3);

# Relatorio_geral

insert into Relatorio_geral (texto, id_cativeiro, id_sitio)
values ('Todos os tanques estão estáveis.', 1, 1);
insert into Relatorio_geral (texto, id_cativeiro, id_sitio) 
values ('Necessário ajustar pH em alguns tanques.', 2, 2);
insert into Relatorio_geral (texto, id_cativeiro, id_sitio) 
values ('Temperaturas em níveis ideais.', 3, 3);

# Tipos_sensor

insert into Tipos_sensor (descricao) values ('Sensor de Temperatura');
insert into Tipos_sensor (descricao) values ('Sensor de pH');
insert into Tipos_sensor (descricao) values ('Sensor de Amônia');

# Sensores

insert into SensoresxCativeiros (id_sensor, id_cativeiro) values (1, 1);
insert into SensoresxCativeiros (id_sensor, id_cativeiro) values (2, 2);
insert into SensoresxCativeiros (id_sensor, id_cativeiro) values (3, 3);

# Recomendacoes

insert into Recomendacoes (recomendacao, id_cativeiro, id_sitio) 
values ('Ajustar temperatura para o ideal.', 1, 1);
insert into Recomendacoes (recomendacao, id_cativeiro, id_sitio) 
values ('Reduzir amônia para níveis aceitáveis.', 2, 2);
insert into Recomendacoes (recomendacao, id_cativeiro, id_sitio) 
values ('Manter os parâmetros estáveis.', 3, 3);

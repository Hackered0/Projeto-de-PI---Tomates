create database tomates;
use tomates;

create table empresa (
id		int primary key auto_increment,
nome	varchar(50) not null,
cnpj	char(14) not null unique,
cep 	char(08)
);

create table cliente (
	id				int primary key auto_increment,
    nome			varchar(60) not null,
    email			varchar(64) not null unique,
    telefone		char(11) not null unique,
    id_empresa		int not null,
    constraint fk_cliente_empresa foreign key (id_empresa) references empresa(id),
    data_cadastro	datetime default current_timestamp,
    situacao		varchar(10) not null default 'Ativo',
    constraint ck_cliente check(situacao in ('Ativo', 'Inativo'))
);

create table usuario (
id	int primary key auto_increment,
id_cliente	int not null,
constraint fk_cliente_usuario foreign key (id_cliente) references cliente(id),
nome	varchar(60) not null,
email	varchar(60) not null unique,
senha	varchar(25) not null,
tipo	varchar(10) not null,
constraint ck_usuario check(tipo in ('Admin','Tecnico', 'Visitante'))
-- ,constraint ck_senha	check(length(senha) >= 8)
);

create table sensor (
id		int primary key auto_increment,
id_cliente	int not null,
constraint fk_cliente_sensor foreign key (id_cliente) references cliente(id),
modelo	varchar(60) not null,
constraint ck_modelo_sensor check(modelo in ('DHT11','Umidade do Solo Capacitivo')),
num_serie	varchar(60) not null unique,
local_instalacao	varchar(60) not null,
data_instalacao		datetime not null,
situacao	varchar(10) not null default 'Ativo',
constraint ck_sensor check(situacao in ('Ativo', 'Inativo'))
);

create table manutencao(
id int primary key auto_increment,
id_sensor int not null,
constraint fk_manutencao_sensor foreign key (id_sensor) references sensor(id),
data_hora datetime
);

create index ix_sensor on sensor(num_serie, local_instalacao);

create table leitor_temp_umi (
id	int primary key auto_increment,
id_sensor int not null,
constraint fk_sensor_leitor foreign key (id_sensor) references sensor(id),
temperatura	double,
umidade float,
data_hora datetime default current_timestamp
);

create table leitor_umi_solo (
id	int primary key auto_increment,
id_sensor int not null,
constraint fk_sensor_leitor foreign key (id_sensor) references sensor(id),
umidade float,
data_hora datetime default current_timestamp
);


create index ix_leitor on leitor_umi_solo(umidade, data_hora);
create index ix_leitor on leitor_temp_umi(temperatura, umidade, data_hora);
CREATE DATABASE tomatometrics;
USE tomatometrics;

CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
CNPJ CHAR(14)
 
);

CREATE TABLE usuario (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(45) NOT NULL, 
senha VARCHAR(45) UNIQUE NOT NULL,
nome VARCHAR(45) NOT NULL,
cargo VARCHAR(45) NOT NULL,
idAdmin INT, 
idEmpresa INT, 

CONSTRAINT chk_usuario check(cargo in ("Admin", "Operario")),
CONSTRAINT fk_Admin FOREIGN KEY (idAdmin) REFERENCES usuario(id_usuario), 
CONSTRAINT fk_Empresa FOREIGN KEY (idEmpresa) REFERENCES empresa(id_empresa) 
 
);

CREATE TABLE estufa (
id_estufa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
idEmpresa INT,
cep CHAR(8),

CONSTRAINT fk_Empresa_Estufa FOREIGN KEY (idEmpresa) REFERENCES empresa(id_empresa) 
);



CREATE TABLE sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
nome_sensor VARCHAR(100),
numero_de_serie VARCHAR(100),
tipo_sensor VARCHAR(100),
status CHAR(1),
idEstufa INT,

CONSTRAINT chk_sensor check(status in("0","1")),
CONSTRAINT fk_Sensor_Estufa FOREIGN KEY (idEstufa) REFERENCES estufa(id_estufa) 
);

CREATE table retorno_dados (
id_dados INT AUTO_INCREMENT,
idSensor INT, 
temperatura INT,
umidadeAr INT,
umidadeSolo INT,
dtCaptura TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),

CONSTRAINT fk_Sensor_Dados FOREIGN KEY (idSensor) REFERENCES sensor(id_sensor),
CONSTRAINT chaves PRIMARY KEY (id_dados, idSensor)

);


insert into empresa(nome, CNPJ)
values ("AlanTomato", "11121314151618");

insert into estufa(nome,idEmpresa,cep)
values("Tomato Domo", 1, "03630936");

insert into sensor(nome_sensor, numero_de_serie, tipo_sensor, status, idEstufa)
values
("sensor_temp_leste", 2, 'DHT11', 1, 1),
("sensor_solo_leste", 2, 'Umidade Solo', 1, 1);
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
status CHAR(1),
idAdmin INT, 
idEmpresa INT, 

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
numero_de_serie INT,
tipo_sensor VARCHAR(100),
status CHAR(1),
idEstufa INT,


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




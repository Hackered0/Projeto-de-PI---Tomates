CREATE DATABASE tomatometrics;
USE tomatometrics;

CREATE TABLE empresa (
  idempresa INT NOT NULL,
  nome_empresa VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  telefone VARCHAR(14) NULL,
  CNPJ CHAR(14) NULL,
  PRIMARY KEY (idempresa));



CREATE TABLE endereco (
  idendereco INT NOT NULL,
  nome_endereco VARCHAR(45) NULL,
  id_empresa INT NOT NULL,
  PRIMARY KEY (idendereco),
  CONSTRAINT fk_endereco_empresa
    FOREIGN KEY (id_empresa)
    REFERENCES empresa (idempresa) );




CREATE TABLE usuario (
  id_usuario INT NOT NULL,
  nome_usuario VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL UNIQUE,
  senha VARCHAR(45) NOT NULL UNIQUE,
  empresa_idempresa INT NOT NULL UNIQUE,
  PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuario_empresa1
    FOREIGN KEY (empresa_idempresa)
    REFERENCES empresa (idempresa)
    );



CREATE TABLE sensor (
  idsensor INT NOT NULL,
  nome_sensor VARCHAR(45) NULL,
  status CHAR(1) NULL,
  PRIMARY KEY (idsensor));




CREATE TABLE estufa (
  id_estufa INT NOT NULL,
  estufa_id_usuario INT NOT NULL,
  nome_estufa VARCHAR(45) NULL,
  idsensor INT NOT NULL,
  fkempresa INT NOT NULL,
  PRIMARY KEY (id_estufa, estufa_id_usuario),
  CONSTRAINT fk_estufa_usuario1
    FOREIGN KEY (estufa_id_usuario)
    REFERENCES usuario(id_usuario),
    
  CONSTRAINT fk_estufa_sensor1
    FOREIGN KEY (idsensor)
    REFERENCES sensor(idsensor),
    
  CONSTRAINT fk_estufa_empresa1
    FOREIGN KEY (fkempresa)
    REFERENCES empresa(idempresa)
);




CREATE TABLE dados_DHT11 (
  id_dht11 INT NOT NULL auto_increment,
  retorno_umidade VARCHAR(45) NULL,
  retorno_temperatura VARCHAR(45) NULL,
  dht11r_idsensor INT NOT NULL,
  PRIMARY KEY (id_dht11, dht11r_idsensor),

  CONSTRAINT fk_dados_DHT11_sensor1
    FOREIGN KEY (dht11r_idsensor)
    REFERENCES sensor(idsensor)
);




CREATE TABLE dados_solo_capacitivo (
  id_solo_capacitivo INT NOT NULL auto_increment,
  retorno_umidade_solo VARCHAR(45) NULL,
  solo_idsensor INT NOT NULL,
  PRIMARY KEY (id_solo_capacitivo, solo_idsensor),

  CONSTRAINT fk_dados_solo_capacitivo_sensor1
    FOREIGN KEY (solo_idsensor)
    REFERENCES sensor(idsensor)
);

INSERT INTO empresa VALUES
(1, 'TomatoTech', 'contato@tomato.com', '11999999999', '12345678000100'),
(2, 'AgroSmart', 'agro@smart.com', '11888888888', '98765432000100'),
(3, 'GreenHouse BR', 'green@house.com', '11777777777', '45678912000100');


INSERT INTO endereco VALUES
(1, 'Rua A - São Paulo', 1),
(2, 'Av B - Campinas', 2),
(3, 'Rua C - Santos', 3);


INSERT INTO usuario VALUES
(1, 'Ricardo', 'ricardo@email.com', '123456', 1),
(2, 'Ana', 'ana@email.com', 'abcdef', 2),
(3, 'Carlos', 'carlos@email.com', '654321', 3);



INSERT INTO sensor VALUES
(1, 'DHT11', 'A'),
(2, 'Solo Capacitivo', 'A'),
(3, 'DHT11', 'I');


INSERT INTO estufa VALUES
(1, 1, 'Estufa Tomate 1', 1, 1),
(2, 2, 'Estufa Tomate 2', 2, 2),
(3, 3, 'Estufa Tomate 3', 3, 3);

INSERT INTO dados_DHT11 VALUES
(1, 1, '70%', '25C'),
(2, 1, '65%', '24C'),
(3, 3, '80%', '28C');


INSERT INTO dados_solo_capacitivo VALUES
(1, '40%', 2),
(2, '45%', 2),
(3, '50%', 2);


SELECT * FROM estufa;

ALTER TABLE dados_DHT11 add column data_retorno datetime default current_timestamp;
desc dados_DHT11;
desc dados_solo_capacitivo;
use tomatometrics;


INSERT INTO dados_DHT11 (dht11r_idsensor) VALUES 
(1), 
(3);
INSERT INTO dados_solo_capacitivo (solo_idsensor) VALUES
(2),
(2);

SELECT * from dados_DHT11;

-- Acessar Root e executar 
create user usuario_banco identified by 'Urubu#100';
-- Conceder Permissão de Insert ao usuario_banco na VM
GRANT INSERT on tomatometrics.dados_DHT11 to usuario_banco;
GRANT INSERT on tomatometrics.dados_solo_capacitivo to usuario_banco;

# TODOS OS CREATES DE T0DAS AS TABELAS UTILIZADAS:

CREATE TABLE cadastroempresa (
  idEmpresa INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(60) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  PRIMARY KEY (idEmpresa),
  UNIQUE (email),
  UNIQUE (cnpj)
);

#IDEAL SERIA USAR UM VARCHAR(255) NA SENHA PARA FUTURA IMPLEMENTAÇÃO DO HASH, PORÉM NÃO FOMOS ENSINADOS ENTÃO OPTEI POR DEIXAR ASSIM

CREATE TABLE cadastrouser (
  idUser INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(60) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  fk_idEmpresa INT NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  PRIMARY KEY (idUser),
  UNIQUE (email, fk_idEmpresa),
  CONSTRAINT fk_user_empresa FOREIGN KEY (fk_idEmpresa) REFERENCES cadastroempresa(idEmpresa)
);
CREATE TABLE sensor (
  id_sensor INT PRIMARY KEY AUTO_INCREMENT,
  tipo_sensor VARCHAR(50) NOT NULL,
  status_sensor VARCHAR(15) DEFAULT 'ativo',
  fk_estufa INT NOT NULL,
  CHECK (status_sensor IN ('ativo','inativo','manutencao')),
  CONSTRAINT fk_sensor_estufa FOREIGN KEY (fk_estufa) REFERENCES estufa(id_estufa)
);
CREATE TABLE estufa (
  id_estufa INT PRIMARY KEY AUTO_INCREMENT,
  nome_estufa VARCHAR(50),
  descricao VARCHAR(200),
  fk_idEmpresa INT NOT NULL,
  CONSTRAINT fk_estufa_empresa FOREIGN KEY (fk_idEmpresa) REFERENCES cadastroempresa(idEmpresa)
);

#OPTAMOS POR DEIXAR UMA TABELA COM TODOS OS PARAMETROS PELOS SEGUINTES MOTIVOS: MAIOR FLEXIBLIDADE, SE ALTERAR AQ ALTERA EM TODO O CÓDIGO, E TUDO EM UMA TABELA FACILITA: PESQUISA, ORGANIZAÇÃO, COMPREENSÃO E TAMBÉM DEIXA A TABELA GENÉRICA

CREATE TABLE parametros (
  id_parametro INT AUTO_INCREMENT PRIMARY KEY,
  etapa VARCHAR(50) NOT NULL,
  valor DECIMAL(5,2) NOT NULL,
  periodo VARCHAR(30) NOT NULL,
  fk_estufa INT NOT NULL,
  CHECK (periodo IN ('dia','noite','continuo')),
  CONSTRAINT fk_parametros_estufa FOREIGN KEY (fk_estufa) REFERENCES estufa(id_estufa)
)

#NO BACK-END UTILIZAR UM TIMER DE 1s (tempo), NO TICK, PEGAR OS RETORNOS DOS SENSORES E ENVIAR PARA A TABELA, OU SEJA, SE FOR NULL, ENVIA NULL, PARA ASSIM PODER COMPARAR LINHA A LINHA.

CREATE TABLE retornosensores (
  id_retorno INT NOT NULL AUTO_INCREMENT,
  retornoSensorUmidadeSolo DECIMAL(5,2) DEFAULT NULL,
  retornoSensorTemperatura DECIMAL(5,2) DEFAULT NULL,
  retornoSensorUmidadeAr DECIMAL(5,2) DEFAULT NULL,
  fk_sensor INT NOT NULL,
  fk_estufa INT NOT NULL,
  fk_idEmpresa INT NOT NULL,
  dataRetorno TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_retorno),
  CONSTRAINT fk_retorno_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor),
  CONSTRAINT fk_retorno_estufa FOREIGN KEY (fk_estufa) REFERENCES estufa(id_estufa),
  CONSTRAINT fk_retorno_empresa FOREIGN KEY (fk_idEmpresa) REFERENCES cadastroempresa(idEmpresa)
);


#INSERT DOS PARAMETROS:

#O INSERT CONTENDO TODAS AS INFORMAÇÕES DAS CONDIÇÕES DE MICROCLIMA IDEAIS PARA A ESTUFA DE TOMATE PREENCHIDA CONFORME A DOCUMENTAÇÃO!

insert into parametros(etapa, valor, periodo) values
	('Temperatura germinação: ', 26, 'continuo'),
	('Temperatura crescimento: ', 24, 'dia'),
	('Temperatura crescimento: ', 18, 'noite'),
	('Temperatura maturação: ', 22, 'dia'),
	('Temperatura maturação: ', 17, 'noite'),
	('Umidade do ar germinação: ', 85, 'continuo'),
	('Umidade do ar crescimento: ', 70, 'dia'),						
	('Umidade do ar crescimento: ', 75, 'noite'),				
	('Umidade do ar maturação: ', 65, 'dia'),
	('Umidade do ar maturação: ', 70, 'noite'),
	('Umidade do solo germinação: ', 10, 'continuo'),
	('Umidade do solo crescimento: ', 25, 'continuo'),
	('Umidade do solo maturação: ', 35, 'continuo');

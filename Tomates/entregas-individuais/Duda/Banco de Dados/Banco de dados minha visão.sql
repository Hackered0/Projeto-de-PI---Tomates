/* Banco de dados que vamos usar */

Create database tomate; -- Database principal
use tomate; -- Qual a gente vai usar


/* Dados da empresa do cliente */

create table cadastro_empresa (
    idEmpresa int not null auto_increment unique primary key,  -- Empresa do cliente
    nome_da_empresa varchar (50) not null unique,
    email varchar(40) not null unique , -- Email da empresa
    cnpj char(14) not null unique, -- CNPJ da empresa
    endereco varchar(100) not null unique, --  Endereço da empresa 
    telefone  varchar(20) not null unique  -- Telefone da empresa 
);

/* Tabela do cliente, seria os dados dele */

create table cadastro_cliente (
    id int not null auto_increment primary key, 
    nome_completo varchar (100) unique,  -- nome do cliente 
    cpf CHAR(11) not null UNIQUE,  -- Cpf dele
    telefone CHAR(11) not null unique, -- Contato pessoal
    email VARCHAR(50) not null unique, -- Contato pessoal
    fk_idEmpresa int,  -- A foreigh
    constraint cadastro_cliente  foreign key (fk_idEmpresa) references cadastro_empresa(idEmpresa)
);
/*Todos que estão com unique, precisam ter unique para descartar o risco de adicionar a mesma empresa duas vezes, 
e o mesmo cliente */

/*Tabela estufa seria o número das estufas que teriam, para melhor organização e controle*/

create table estufa (
    id_numero_da_estufa int primary key not null, -- Numero da estufa de tomates (Vai que o cliente tem mais de um)
    fk_idEmpresa int,  -- A foreigh
    constraint estufa foreign key (fk_idEmpresa) references cadastro_empresa(idEmpresa)
); 

/* Tabela de sensores, como eles medem a temperatura, essa tabela manda dados o tempo todo*/

create table retorno_sensores (
    idSensores int not null auto_increment primary key,  -- Numero do sensor 
    retorno_UmidadeSolo decimal(5,2) DEFAULT NULL, -- Umidade do solo que o sensor está medindo 
    retorno_Temperatura decimal(5,2) DEFAULT NULL, -- Temperatura do ambiente que o sensor está medindo
    retorno_UmidadeAr decimal(5,2) DEFAULT NULL,  -- Umidade do ar que está na estufa
    idGrupo_Sensor int NOT NULL, -- Decidir em qual setor ele está, exemplo "Sensor 1 lado norte"
    data_Retorno timestamp DEFAULT CURRENT_TIMESTAMP(), -- Data e hora que o sensor está enviando os dados
    fk_idEmpresa int NOT NULL,  -- Foreigh
    constraint retorno_sensores  foreign key (fk_idEmpresa) references cadastro_empresa(idEmpresa) -- Fk
);

/* Alertas do sensor, essa tabela envia dados para quando algo dá errado*/ 

CREATE TABLE alertas (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT, -- Id unico de cada alerta
    fk_idEstufa INT, -- foreign key
    tipo_alerta VARCHAR(50), -- Alta ou baixa.
    data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP, -- Quando enviou esse alerta
    constraint chk_tipo_alerta check (tipo_alerta in ( 'Temperatura alta', 'Temperatura beixa')),
    constraint alertas foreign key (fk_idEstufa) references estufa (id_numero_da_estufa)
);

/* Manual do clima perfeito, que seria quais são os melhores climas para os tomates */

CREATE TABLE parametros (
    idParametro INT PRIMARY KEY AUTO_INCREMENT, -- Id unico do parametro
    etapa VARCHAR(50) NOT NULL,    -- Fases do tomate
    temp_ideal DECIMAL(5,2),       -- O valor da Temperatura
    umidade_ar_ideal DECIMAL(5,2), -- O valor da Umidade do Ar
    umidade_solo_ideal DECIMAL(5,2),-- O valor da Umidade do Solo
    periodo VARCHAR(30),  -- Dia, tarde , noite (Cada periodo precisa de uma temperatura diferente)
    fk_idEmpresa INT,
    constraint fk_idEmpresa  foreign key  (fk_idEmpresa) references cadastro_empresa(idEmpresa)
);


/* insert da empresa   */ 
INSERT INTO cadastro_empresa (nome_da_empresa, email, cnpj, endereco, telefone) VALUES 
                             ('Null Point Tech', 'contato@nullpoint.com', '12345678000199', 'Rua Haddock Lobo, 595', '11999998888'),
                             ('Bee-Alive Monitoramento', 'tech@beealive.com', '98765432000188', 'Av. Paulista, 1000', '11988887777'),
                             ('Tomate de Ouro Estufas', 'vendas@tomategold.com', '11222333000144', 'Rua das Flores, 123', '11977776666'),
                             ('AgroTech Solutions', 'suporte@agrotech.com', '44555666000122', 'Rodovia dos Bandeirantes, Km 50', '19966665555'),
                             ('Fazenda Sustentável', 'adm@fazendasust.com', '77888999000111', 'Estrada Rural, s/n', '15955554444');

/* insert do cliente */

INSERT INTO cadastro_cliente (nome_completo, cpf, telefone, email, fk_idEmpresa) VALUES 
                             ('Gabriel Silva Pinna', '11122233344', '11911112222', 'gabriel.silva@email.com', 1),
                             ('Mirella Santos Cardoso', '22233344455', '11922223333', 'mirella.santos@email.com', 2),
                             ('Bruno Oliveira Viana', '33344455566', '11933334444', 'bruno.oliveira@email.com', 3),
                             ('Emily Souza Silva', '44455566677', '11944445555', 'emily.souza@email.com', 4),
                             ('Daniel Lima Moreira', '55566677788', '11955556666', 'daniel.lima@email.com', 5);

/* Insert das estufas */

INSERT INTO estufa (id_numero_da_estufa, fk_idEmpresa) VALUES 
                   (10, 1), -- Estufa 10 da Null Point Tech
                   (20, 2), -- Estufa 20 da Bee-Alive
                   (30, 3), -- Estufa 30 da Tomate de Ouro
                   (40, 4), -- Estufa 40 da AgroTech Solutions
				   (50, 5); -- Estufa 50 da Fazenda Sustentável

/*O INSERT CONTENDO TODAS AS INFORMAÇÕES DAS CONDIÇÕES DE MICROCLIMA IDEAIS PARA A ESTUFA DE TOMATE PREENCHIDA CONFORME A DOCUMENTAÇÃO*/

INSERT INTO parametros (etapa, temp_ideal, umidade_ar_ideal, umidade_solo_ideal, periodo) VALUES
                       ('Germinação', 26.00, 85.00, 10.00, 'continuo'),
                       ('Crescimento - Dia', 24.00, 70.00, 25.00, 'dia'),
                       ('Crescimento - Noite', 18.00, 75.00, 25.00, 'noite'),
                       ('Maturação - Dia', 22.00, 65.00, 35.00, 'dia'),
					   ('Maturação - Noite', 17.00, 70.00, 35.00, 'noite');


SELECT * from cadastro_empresa;
select * from cadastro_cliente;
select * from estufa;
select * from parametros;

Select * FROM cadastro_empresa INNER JOIN cadastro_cliente ON idEmpresa = fk_idEmpresa;
                       
                       
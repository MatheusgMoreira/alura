CREATE TABLE
    PRODUTOS (
        CODIGO VARCHAR(10) NOT NULL,
        DESCRITOR VARCHAR(100) NULL,
        SABOR VARCHAR(50) NULL,
        TAMANHO VARCHAR(50) NULL,
        EMBALAGEM VARCHAR(50) NULL,
        PRECO_LISTA FLOAT NULL,
        PRIMARY KEY (CODIGO)
    );

SELECT
    *
FROM
    PRODUTOS;

CREATE TABLE
    VENDEDORES (
        MATRICULA VARCHAR(5) NOT NULL,
        NOME VARCHAR(100) NULL,
        BAIRRO VARCHAR(50) NULL,
        COMISSAO FLOAT NULL,
        DATA_ADMISSAO DATE NULL,
        FERIAS BIT NULL,
        PRIMARY KEY (MATRICULA)
    );

SELECT
    NOME
FROM
    VENDEDORES;

CREATE TABLE
    CLIENTES (
        CPF VARCHAR(11) NOT NULL,
        NOME VARCHAR(50) NULL,
        ENDERECO VARCHAR(150) NULL,
        BAIRRO VARCHAR(50) NULL,
        CIDADE VARCHAR(50) NULL,
        ESTADO VARCHAR(50) NULL,
        CEP VARCHAR(8) NULL,
        DATA_NASCIMENTO DATE NULL,
        IDADE INT NULL,
        GENERO CHAR(1) NULL,
        LIMITE_CREDITO FLOAT,
        VOLUME_COMPRA FLOAT,
        PRIMEIRA_COMPRA BIT,
        PRIMARY KEY (CPF)
    );

SELECT
    *
FROM
    CLIENTES;

CREATE TABLE
    TABELA_DE_VENDAS (
        NUMERO VARCHAR(5) NOT NULL,
        DATA_VENDA DATE NULL,
        CPF VARCHAR(11) NOT NULL,
        MATRICULA VARCHAR(5) NOT NULL,
        IMPOSTO FLOAT NULL,
        PRIMARY KEY (NUMERO),
        FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF),
        FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA)
    );

SELECT
    *
FROM
    TABELA_DE_VENDAS;

CREATE TABLE
    TABELA_DE_ITENS_VENDIDOS (
        NUMERO VARCHAR(5) NOT NULL,
        CODIGO VARCHAR(10) NOT NULL,
        QUANTIDADE INT NULL,
        PRECO_UNITARIO FLOAT NULL,
        PRIMARY KEY (NUMERO, CODIGO),
        FOREIGN KEY (NUMERO) REFERENCES TABELA_DE_VENDAS (NUMERO),
        FOREIGN KEY (CODIGO) REFERENCES PRODUTOS (CODIGO)
    );

SELECT
    *
FROM
    TABELA_DE_ITENS_VENDIDOS;

INSERT INTO
    PRODUTOS (
        CODIGO,
        DESCRITOR,
        SABOR,
        TAMANHO,
        EMBALAGEM,
        PRECO_LISTA
    )
VALUES
    (
        '1040111',
        'Light - 350 ml - Manga',
        'Manga',
        '350 ml',
        'Lata',
        3.20
    ),
    (
        '1040112',
        'Light - 350 ml - Maça',
        'Maça',
        '350 ml',
        'Lata',
        4.20
    );

SELECT
    *
FROM
    CLIENTES;

INSERT INTO
    CLIENTES (
        CPF,
        NOME,
        ENDERECO,
        BAIRRO,
        CIDADE,
        ESTADO,
        CEP,
        DATA_NASCIMENTO,
        IDADE,
        GENERO,
        LIMITE_CREDITO,
        VOLUME_COMPRA,
        PRIMEIRA_COMPRA
    )
VALUES
    (
        '1471156710',
        'Érica Carvalho',
        'R. Iriquitia',
        'Jardins',
        'São Paulo',
        'SP',
        '80012212',
        '19900901',
        27,
        'F',
        170000,
        24500,
        0
    ),
    (
        '19290992743',
        'Fernando Cavalcante',
        'R. Dois de Fevereiro',
        'Água Santa',
        'Rio de Janeiro',
        'RJ',
        '22000000',
        '20000212',
        18,
        'M',
        100000,
        20000,
        1
    ),
    (
        '2600586709',
        'César Teixeira',
        'Rua Conde de Bonfim',
        'Tijuca',
        'Rio de Janeiro',
        'RJ',
        '22020001',
        '20000312',
        18,
        'M',
        120000,
        22000,
        0
    );

ALTER DATABASE SUCOS_FRUTAS
SET
    SINGLE_USER
WITH
    ROLLBACK IMMEDIATE;
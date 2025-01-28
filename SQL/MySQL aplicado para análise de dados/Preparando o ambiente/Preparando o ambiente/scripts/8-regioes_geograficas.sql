USE INSIGHTPLACES;

-- Exclui a tabela se ela já existir
DROP TABLE IF EXISTS regioes_geograficas;

-- Cria a tabela regioes_geograficas
CREATE TABLE
    regioes_geograficas (
        id INT IDENTITY (1, 1) PRIMARY KEY,
        estado CHAR(2), -- Ajustado para usar a sigla do estado
        regiao VARCHAR(50)
    );

INSERT INTO
    regioes_geograficas (estado, regiao)
VALUES
    ('SP', 'Sudeste'),
    ('RJ', 'Sudeste'),
    ('MG', 'Sudeste'),
    ('ES', 'Sudeste'),
    ('PR', 'Sul'),
    ('SC', 'Sul'),
    ('RS', 'Sul'),
    ('BA', 'Nordeste'),
    ('PE', 'Nordeste'),
    ('CE', 'Nordeste'),
    ('MA', 'Nordeste'),
    ('PB', 'Nordeste'),
    ('AM', 'Norte'),
    ('PA', 'Norte'),
    ('RO', 'Norte'),
    ('AC', 'Norte'),
    ('GO', 'Centro-Oeste'),
    ('MT', 'Centro-Oeste'),
    ('MS', 'Centro-Oeste'),
    ('DF', 'Centro-Oeste');

SELECT
    *
FROM
    regioes_geograficas;
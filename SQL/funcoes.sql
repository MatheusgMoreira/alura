SELECT
    (SELECT COUNT(*) FROM alugueis) AS alugueis,
	(SELECT COUNT(*) FROM avaliacoes) AS avaliacoes,
	(SELECT COUNT(*) FROM clientes) AS clientes,
	(SELECT COUNT(*) FROM enderecos) AS enderecos,
	(SELECT COUNT(*) FROM hospedagens) AS hospedagens,
	(SELECT COUNT(*) FROM proprietarios) AS proprietarios;
    
SELECT * FROM alugueis;

SELECT AVG(nota) AS media, tipo
FROM avaliacoes a
JOIN hospedagens h
ON h.hospedagem_id = a.hospedagem_id
GROUP BY tipo;

SELECT tipo, SUM(preco_total), MAX(preco_total), MIN(preco_total)
FROM alugueis a
JOIN hospedagens h
ON h.hospedagem_id = a.hospedagem_id
GROUP BY tipo;

SELECT CONCAT(TRIM(nome), ', o e-mail é: ', contato) AS NomeContato FROM clientes;

SELECT 	TRIM(nome) AS cliente, CONCAT(SUBSTRING(cpf, 1, 3), '.', SUBSTRING(cpf, 4, 3), '.', SUBSTRING(cpf, 7, 3), '-', SUBSTRING(cpf, 10, 2)) AS cpf
FROM clientes;

SELECT * FROM clientes;

SELECT TRIM(nome) as Nome, DATEDIFF(data_fim, data_inicio) AS DiasHospedados FROM alugueis a 
JOIN clientes c
ON a.cliente_id = c.cliente_id;

SELECT tipo, SUM(DATEDIFF(data_fim, data_inicio)) AS DiasHospedados 
FROM alugueis a
JOIN hospedagens h
ON a.hospedagem_id = h.hospedagem_id
GROUP BY tipo;

SELECT TRUNCATE(AVG(nota), 2) AS media, tipo
FROM avaliacoes a
JOIN hospedagens h
ON h.hospedagem_id = a.hospedagem_id
GROUP BY tipo;

SELECT ROUND(AVG(nota), 2) AS media, tipo
FROM avaliacoes a
JOIN hospedagens h
ON h.hospedagem_id = a.hospedagem_id
GROUP BY tipo;

SELECT hospedagem_id, nota,
CASE nota
	WHEN 5 THEN 'Excelente'
    WHEN 4 THEN 'Ótimo'
    WHEN 3 THEN 'Muito bom'
    WHEN 2 THEN 'Bom'
    WHEN 1 THEN 'Ruim'
END AS StatusNota
FROM avaliacoes;

DELIMITER $$

CREATE FUNCTION retornoConstante()
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
	RETURN 'Seja bem-vindo(a)';
END$$

DELIMITER ;

SELECT retornoConstante();

DELIMITER $$
CREATE FUNCTION MediaAvaliacoes()
RETURNS FLOAT DETERMINISTIC
BEGIN
	DECLARE media FLOAT;
    SELECT ROUND(AVG(nota), 2) AS MediaNotas
    INTO media
    FROM avaliacoes;
    
    RETURN media;
END$$
DELIMITER ;

SELECT MediaAvaliacoes();

DELIMITER $$
CREATE FUNCTION FormatandoCPF(ClienteID INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
	DECLARE NovoCPF VARCHAR(50);
    SET NovoCPF =(
		SELECT CONCAT(SUBSTRING (cpf, 1, 3), '.', SUBSTRING(cpf, 4, 3), '.', SUBSTRING(cpf, 7, 3), '-', SUBSTRING(cpf, 10, 2)) AS CPF_Mascarado FROM clientes
        WHERE cliente_id = ClienteID
        );
        RETURN NovoCPF;
END$$
DELIMITER ;

SELECT FormatandoCPF(1);

DELIMITER $$
CREATE FUNCTION InfoAluguel(IdAluguel INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE NomeCliente VARCHAR(100);
    DECLARE PrecoTotal FLOAT(10,2);
    DECLARE Dias INT;
    DECLARE ValorDiario FLOAT(10,2);
    DECLARE Resultado VARCHAR(255);

	SELECT c.nome, a.preco_total, DATEDIFF(data_fim, data_inicio) 
    INTO NomeCliente, PrecoTotal, Dias
    FROM alugueis a
    JOIN cliente c
	ON a.cliente_id = c.cliente_id
    WHERE a.aluguel_id - IdAluguel;
    
    SET ValorDiario = PrecoTotal / Dias;
    
    SET Resultado = CONCAT('Nome: ', NomeCliente, ', Valor Diário: R$', FORMAT(ValorDiaria,2));
    
    RETURN Resultado;
END$$
DELIMITER ;

SELECT InfoAluguel(1);

SELECT * FROM alugueis;

DELIMITER $$
CREATE FUNCTION InfoAluguel(IdAluguel INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN

	DECLARE NomeCliente VARCHAR(100);
	DECLARE PrecoTotal DECIMAL(10,2);
	DECLARE Dias INT;
	DECLARE ValorDiaria DECIMAL(10,2);
	DECLARE Resultado VARCHAR(255);

	SELECT c.nome, a.preco_total, DATEDIFF(data_fim, data_inicio)
	INTO NomeCliente, PrecoTotal, Dias
	FROM alugueis a
	JOIN clientes c
	ON a.cliente_id = c.cliente_id
	WHERE a.aluguel_id = IdAluguel;

	SET ValorDiaria = PrecoTotal / Dias;
	SET Resultado = CONCAT('Nome: ', NomeCliente, ', Valor Diário: R$', FORMAT(ValorDiaria,2));

	RETURN Resultado;
END$$
DELIMITER ;

SELECT InfoAluguel(1);

SELECT 
	cliente_id,
    data_inicio, 
    data_fim, DATEDIFF(data_fim, data_inicio) AS total_dias,
CASE
	WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 4 AND 6 THEN 5
	WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 7 AND 9 THEN 10
	WHEN DATEDIFF(data_fim, data_inicio) >= 10 THEN 15
	ELSE 0
END AS desconto_percentual
FROM alugueis;

DELIMITER $$
CREATE FUNCTION CalcularDescontosPorDias(AluguelId INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE Desconto INT;
	SELECT 
		CASE
			WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 4 AND 6 THEN 5
			WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 7 AND 9 THEN 10
			WHEN DATEDIFF(data_fim, data_inicio) >= 10 THEN 15
			ELSE 0
		END
	INTO Desconto
	FROM alugueis
    WHERE aluguel_id = AluguelId;
    
	RETURN Desconto;
END$$
DELIMITER ;

SELECT CalcularDescontosPorDias(1);

DELIMITER $$
CREATE FUNCTION CalcularValorFinalComDesconto(AluguelId INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE ValorTotal DECIMAL(10,2);
    DECLARE Desconto INT;
    DECLARE ValorFinal DECIMAL(10,2);
	SELECT preco_total INTO ValorTotal
    FROM alugueis
    WHERE aluguel_id = AluguelId;
    
	SET Desconto = CalcularDescontosPorDias(AluguelId);
    SET ValorFinal = ValorTotal (ValorTotal * Desconto / 100);
    
    RETURN ValorFinal;
END$$
DELIMITER ;

SELECT CalcularValorFinalComDesconto(1);

CREATE TABLE resumo_aluguel (
    aluguel_id VARCHAR(255),
    cliente_id VARCHAR(255),
    valor_total DECIMAL(10,2),
    desconto_aplicado DECIMAL(10,2),
    valor_final DECIMAL(10,2),
	PRIMARY KEY (aluguel_id, cliente_id),
    FOREIGN KEY (aluguel_id) REFERENCES alugueis(aluguel_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);






























USE insight_places;

SELECT * FROM alugueis;
SELECT * FROM avaliacoes;
SELECT * FROM clientes; 

SELECT * FROM avaliacoes
WHERE nota >= 4;

SELECT * FROM hospedagens
WHERE tipo = 'hotel'
AND ativo = 1;

SELECT cliente_id, AVG(preco_total) AS ticket_medio
FROM alugueis
GROUP BY cliente_id;

SELECT cliente_id, AVG(DATEDIFF(data_fim, data_inicio)) AS media_dias_estadia
FROM alugueis
GROUP BY cliente_id
ORDER BY media_dias_estadia DESC;

SELECT p.nome AS nome_proprietario, COUNT(h.hospedagem_id)
AS total_hospedagens_ativas
FROM proprietarios p
JOIN hospedagens h ON p.proprietario_id = h.proprietario_id
WHERE h.ativo = 1
GROUP BY p.nome
ORDER BY total_hospedagens_ativas DESC
LIMIT 10;

SELECT p.nome AS nome_proprietario, COUNT(*) AS total_hospedagens_inativas
FROM proprietarios p
JOIN hospedagens h ON p.proprietario_id = h.proprietario_id
WHERE h.ativo = 0
GROUP BY p.nome;

SELECT YEAR(data_inicio) AS ano,
MONTH(data_inicio) AS mes,
COUNT(*) AS total_alugueis
FROM alugueis
GROUP BY ano, mes
ORDER BY total_alugueis DESC;

ALTER TABLE proprietarios
ADD COLUMN qtd_hospedagens INT;

ALTER TABLE alugueis
RENAME TO reservas;

ALTER TABLE reservas
RENAME COLUMN aluguel_id TO reserva_id;

UPDATE hospedagens
SET ativo = 1
WHERE hospedagem_id IN ('1','10','100');

UPDATE proprietarios
SET contato = 'daniela_120@email.com'
WHERE proprietario_id = '1009';

SELECT * FROM proprietarios
WHERE contato = 'daniela_120@email.com';

DELETE FROM avaliacoes
WHERE hospedagem_id IN ('10000','1000');

DELETE FROM reservas
WHERE hospedagem_id IN ('10000','1000');

DELETE FROM hospedagens
WHERE hospedagem_id IN ('10000','1000');



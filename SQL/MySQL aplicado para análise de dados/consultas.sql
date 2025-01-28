SELECT
    hospedagem_id,
    MIN(data_inicio) AS primeira_data,
    SUM(DATEDIFF (DAY, data_fim, data_inicio)) AS dias_ocupados,
    DATEDIFF (DAY, MAX(data_fim), MIN(data_inicio)) AS total_dias,
    ROUND(
        (
            SUM(DATEDIFF (DAY, data_fim, data_inicio)) / DATEDIFF (DAY, MAX(data_fim), MIN(data_inicio))
        ) * 100,
        1
    ) AS taxa_ocupacao
FROM
    alugueis
GROUP BY
    hospedagem_id
ORDER BY
    taxa_ocupacao DESC;

SELECT
    p.nome AS proprietario,
    COUNT(DISTINCT h.hospedagem_id) AS total_hospedagens
FROM
    hospedagens h
    JOIN proprietarios p ON h.proprietario_id = p.proprietario_id
GROUP BY
    p.proprietario_id,
    p.nome
ORDER BY
    total_hospedagens DESC;

SELECT
    YEAR (data_inicio) AS ano,
    MONTH (data_inicio) AS mes,
    COUNT(*) AS total_alugueis
FROM
    alugueis
GROUP BY
    YEAR (data_inicio),
    MONTH (data_inicio)
ORDER BY
    ano,
    mes;

SELECT
    hospedagem_id,
    preco_total,
    DATEDIFF (day, data_fim, data_inicio) AS dias_aluguel,
    preco_total / DATEDIFF (day, .data_fim, data_inicio) AS preco_dia
FROM
    alugueis 
ORDER BY
    preco_dia DESC;

SELECT * 
FROM itens_notas_fiscais;

SELECT CPF, NOME 
FROM tabela_de_clientes;

SELECT DISTINCT BAIRRO 
FROM tabela_de_clientes
WHERE CIDADE = 'Rio de Janeiro';

SELECT CPF, NOME,
CASE
	WHEN ESTADO = 'MG' THEN 'Mineiro'
    WHEN ESTADO = 'SP' THEN 'Paulista'
    WHEN ESTADO = 'RJ' THEN 'Carioca'
    ELSE 'Fora do eixo'
END AS NACIONALIDADE
FROM tabela_de_clientes
GROUP BY CPF;

SELECT * FROM tabela_de_clientes;
USE INSIGHTPLACES;

-- Display five rows from each table
SELECT
  *
FROM
  proprietarios;

SELECT
  *
FROM
  clientes;

SELECT
  *
FROM
  enderecos;

SELECT
  *
FROM
  hospedagens;

SELECT
  *
FROM
  alugueis;

SELECT
  *
FROM
  avaliacoes;

SELECT
  (
    SELECT
      COUNT(*)
    FROM
      proprietarios
  ) AS total_proprietarios,
  (
    SELECT
      COUNT(*)
    FROM
      clientes
  ) AS total_clientes,
  (
    SELECT
      COUNT(*)
    FROM
      enderecos
  ) AS total_enderecos,
  (
    SELECT
      COUNT(*)
    FROM
      hospedagens
  ) AS total_hospedagens,
  (
    SELECT
      COUNT(*)
    FROM
      alugueis
  ) AS total_alugueis,
  (
    SELECT
      COUNT(*)
    FROM
      avaliacoes
  ) AS total_avaliacoes;
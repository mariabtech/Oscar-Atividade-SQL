-- 1.3 Qual foi o primeiro ano de cerimônia do Oscar registrado na base?

SELECT MIN(ano_cerimonia) AS primeiro_ano_cerimonia
FROM indicados_ao_oscar;

-- 1.4 Qual foi o último ano de cerimônia registrado na base?

SELECT MAX(ano_cerimonia) AS ultimo_ano_cerimonia
FROM indicados_ao_oscar;

-- 1.5 Quantas cerimônias do Oscar estão registradas no total?

SELECT COUNT(DISTINCT edicao_cerimonia) AS total_cerimonias
FROM indicados_ao_oscar;

-- 1.6 Atualize os registros da tabela com os dados do Oscar 2025 e 2026 (pesquise os vencedores e adicione-os).

-- 97ª Cerimônia (2025 - filmes de 2024)
INSERT INTO indicados_ao_oscar (ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor) VALUES
(2024, 2025, 97, 'BEST PICTURE', 'Alex Coco, Samantha Quan, and Sean Baker', 'Anora', TRUE),
(2024, 2025, 97, 'DIRECTING', 'Sean Baker', 'Anora', TRUE),
(2024, 2025, 97, 'ACTOR IN A LEADING ROLE', 'Adrien Brody', 'The Brutalist', TRUE),
(2024, 2025, 97, 'ACTRESS IN A LEADING ROLE', 'Mikey Madison', 'Anora', TRUE),
(2024, 2025, 97, 'ACTOR IN A SUPPORTING ROLE', 'Kieran Culkin', 'A Real Pain', TRUE),
(2024, 2025, 97, 'ACTRESS IN A SUPPORTING ROLE', 'Zoe Saldaña', 'Emilia Pérez', TRUE),
(2024, 2025, 97, 'INTERNATIONAL FEATURE FILM', 'Walter Salles', 'I''m Still Here', TRUE);

-- 98ª Cerimônia (2026 - filmes de 2025)
INSERT INTO indicados_ao_oscar (ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor) VALUES
(2025, 2026, 98, 'BEST PICTURE', 'Adam Somner, Sara Murphy, and Paul Thomas Anderson', 'One Battle After Another', TRUE),
(2025, 2026, 98, 'DIRECTING', 'Paul Thomas Anderson', 'One Battle After Another', TRUE),
(2025, 2026, 98, 'ACTOR IN A LEADING ROLE', 'Michael B. Jordan', 'Sinners', TRUE),
(2025, 2026, 98, 'ACTRESS IN A LEADING ROLE', 'Jessie Buckley', 'Hamnet', TRUE),
(2025, 2026, 98, 'ACTOR IN A SUPPORTING ROLE', 'Sean Penn', 'One Battle After Another', TRUE),
(2025, 2026, 98, 'ACTRESS IN A SUPPORTING ROLE', 'Amy Madigan', 'Weapons', TRUE);

-- 2.1 Quantas indicações existem para cada categoria? Agrupe por categoria e ordene da mais frequente para a menos frequente.

SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes DESC;

-- 2.2 Qual categoria teve mais indicações ao longo da história do Oscar?

SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes DESC
LIMIT 1;

-- 2.3 Qual categoria teve menos indicações ao longo da história?

SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes ASC
LIMIT 1;

-- 2.4 A partir de que ano a categoria "ACTRESS" deixou de existir? (Dica: procure a última cerimônia com essa categoria)

SELECT MAX(ano_cerimonia) AS ultima_cerimonia_actress,
    MAX(ano_cerimonia) + 1 AS deixou_de_existir_a_partir_de
FROM indicados_ao_oscar
WHERE categoria = 'ACTRESS';

-- 2.5 Quais categorias existiam na primeira cerimônia (1928) e não existem mais hoje?

SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE edicao_cerimonia = (SELECT MIN(edicao_cerimonia) FROM indicados_ao_oscar)
AND categoria NOT IN (
    SELECT DISTINCT categoria
    FROM indicados_ao_oscar
    WHERE edicao_cerimonia = (SELECT MAX(edicao_cerimonia) FROM indicados_ao_oscar)
);

-- 2.6 Liste todas as categorias que contêm a palavra "DIRECTING" no nome.

SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE categoria LIKE '%DIRECTING%';

-- 3.1 Quantas vezes Natalie Portman foi indicada ao Oscar?

SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Natalie Portman%';

-- 3.2 Quantos Oscars Natalie Portman ganhou?

SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Natalie Portman%'
AND vencedor = TRUE;

-- 3.3 Em quais anos e por quais filmes Natalie Portman foi indicada?

SELECT DISTINCT ano_cerimonia, nome_filme
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Natalie Portman%'
ORDER BY ano_cerimonia;

-- 3.4 Liste todas as indicações de Natalie Portman mostrando: ano, categoria, filme e se venceu.

SELECT ano_cerimonia, categoria, nome_filme, vencedor
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Natalie Portman%'
ORDER BY ano_cerimonia;

-- 3.5 Quantas vezes Viola Davis foi indicada ao Oscar?

SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Viola Davis%';

-- 3.6 Quantos Oscars Viola Davis ganhou?

SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Viola Davis%'
AND vencedor = TRUE;

-- 3.7 Por quais filmes Viola Davis foi indicada?

SELECT DISTINCT nome_filme
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Viola Davis%';

-- 3.8 Amy Adams já ganhou algum Oscar?

SELECT CASE WHEN COUNT(*) > 0 THEN 'Sim' ELSE 'Não' END AS ganhou_oscar
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Amy Adams%'
AND vencedor = TRUE;

-- 3.9 Quantas vezes Amy Adams foi indicada sem ganhar?

SELECT COUNT(*) AS indicacoes_sem_vitoria
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Amy Adams%'
AND vencedor = FALSE;

-- 3.10 Denzel Washington já ganhou algum Oscar?

SELECT CASE WHEN COUNT(*) > 0 THEN 'Sim' ELSE 'Não' END AS ganhou_oscar
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Denzel Washington%'
AND vencedor = TRUE;

-- 3.11 Quantas vezes Denzel Washington foi indicado ao Oscar?

SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Denzel Washington%';

-- 3.12 Liste todos os Oscars que Denzel Washington ganhou (ano, categoria, filme).

SELECT ano_cerimonia, categoria, nome_filme
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%Denzel Washington%'
AND vencedor = TRUE
ORDER BY ano_cerimonia;

-- 4.1 Quem ganhou o primeiro Oscar para Melhor Atriz (ACTRESS)? Em que ano e por qual filme?

SELECT nome_indicado, ano_cerimonia, nome_filme
FROM indicados_ao_oscar
WHERE categoria = 'ACTRESS'
AND vencedor = TRUE
ORDER BY ano_cerimonia ASC, edicao_cerimonia ASC
LIMIT 1;

-- 4.2 Quem ganhou o primeiro Oscar para Melhor Ator (ACTOR)? Em que ano e por qual filme?

SELECT nome_indicado, ano_cerimonia, nome_filme
FROM indicados_ao_oscar
WHERE categoria = 'ACTOR'
AND vencedor = TRUE
ORDER BY ano_cerimonia ASC, edicao_cerimonia ASC
LIMIT 1;

-- 4.3 Quantos vencedores existem ao todo na base de dados?

SELECT COUNT(*) AS total_vencedores
FROM indicados_ao_oscar
WHERE vencedor = TRUE;

-- 4.4 Liste todos os filmes que ganharam o Oscar de Melhor Filme (categoria "OUTSTANDING PICTURE" ou "BEST PICTURE").

SELECT DISTINCT nome_filme, ano_cerimonia, categoria
FROM indicados_ao_oscar
WHERE categoria IN ('OUTSTANDING PICTURE', 'BEST PICTURE')
AND vencedor = TRUE
ORDER BY ano_cerimonia;

-- 4.5 Quantos filmes diferentes já ganharam o Oscar?

SELECT COUNT(DISTINCT nome_filme) AS filmes_diferentes_vencedores
FROM indicados_ao_oscar
WHERE vencedor = TRUE
AND nome_filme IS NOT NULL;

-- 5.1 Quais atores/atrizes foram indicados mais de uma vez? Liste o nome e o número de indicações.

SELECT nome_indicado, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > 1
ORDER BY total_indicacoes DESC;

-- 5.2 Qual ator ou atriz tem o maior número de indicações na história do Oscar?

SELECT nome_indicado, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
ORDER BY total_indicacoes DESC
LIMIT 1;

-- 5.3 Quais atores foram indicados mais de 3 vezes, mas nunca ganharam?

SELECT nome_indicado,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = TRUE THEN 1 ELSE 0 END) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > 3
AND SUM(CASE WHEN vencedor = TRUE THEN 1 ELSE 0 END) = 0
ORDER BY total_indicacoes DESC;

-- 5.4 Encontre todos os artistas que foram indicados em categorias diferentes (ex: ator e diretor).

SELECT nome_indicado,
    COUNT(DISTINCT categoria) AS qtd_categorias,
    GROUP_CONCAT(DISTINCT categoria ORDER BY categoria SEPARATOR ' | ') AS categorias
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(DISTINCT categoria) > 1
ORDER BY qtd_categorias DESC;

-- 5.5 Quantos indicados têm exatamente 1 indicação na história?

SELECT COUNT(*) AS indicados_com_uma_indicacao
FROM (
    SELECT nome_indicado
    FROM indicados_ao_oscar
    WHERE nome_indicado IS NOT NULL
    GROUP BY nome_indicado
    HAVING COUNT(*) = 1
) AS sub;

-- 5.6 Qual o maior números de indicados em um único ano? Essa é uma pergunta franca.

SELECT ano_cerimonia, COUNT(*) AS total_indicados
FROM indicados_ao_oscar
GROUP BY ano_cerimonia
ORDER BY total_indicados DESC
LIMIT 1;

-- 6.1 A série de filmes Toy Story ganhou Oscars em quais anos?

SELECT DISTINCT ano_cerimonia, nome_filme, categoria
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%'
AND vencedor = TRUE
ORDER BY ano_cerimonia;

-- 6.2 Quantas indicações a franquia Toy Story recebeu no total?

SELECT COUNT(*) AS total_indicacoes_toy_story
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%';

-- 6.3 Em quais categorias os filmes Toy Story foram indicados?

SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%';

-- 6.4 Em qual edição do Oscar o filme "Crash" concorreu?

SELECT DISTINCT edicao_cerimonia, ano_cerimonia, nome_filme
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash';

-- 6.5 Quantas indicações o filme "Crash" recebeu?

SELECT COUNT(*) AS total_indicacoes_crash
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash';

-- 6.6 "Crash" ganhou o Oscar de Melhor Filme?

SELECT CASE WHEN COUNT(*) > 0 THEN 'Sim' ELSE 'Não' END AS ganhou_melhor_filme
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash'
AND categoria IN ('BEST PICTURE', 'OUTSTANDING PICTURE')
AND vencedor = TRUE;

-- 6.7 O filme "Central do Brasil" aparece no banco de dados?

SELECT CASE WHEN COUNT(*) > 0 THEN 'Sim' ELSE 'Não' END AS aparece_no_banco,
    COUNT(*) AS total_registros
FROM indicados_ao_oscar
WHERE nome_filme = 'Central do Brasil';

-- 6.8 Se sim, quantas indicações "Central do Brasil" recebeu?

SELECT COUNT(*) AS total_indicacoes_central
FROM indicados_ao_oscar
WHERE nome_filme = 'Central do Brasil';

-- 7.1 No campo "vencedor", altere todos os valores "true" (string) para true (booleano) e "false" (string) para false (booleano).

UPDATE indicados_ao_oscar
SET vencedor = CASE
    WHEN LOWER(CAST(vencedor AS CHAR)) = 'true' THEN TRUE
    WHEN LOWER(CAST(vencedor AS CHAR)) = 'false' THEN FALSE
    ELSE vencedor
END;

-- 7.2 Inclua no banco 3 filmes que nunca foram nomeados ao Oscar, mas que você acha que merecem. Use dados fictícios, mas realistas.

INSERT INTO indicados_ao_oscar (ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor) VALUES
(2023, 2024, 96, 'BEST PICTURE', 'Clara Mendes', 'O Último Trem da Madrugada', FALSE),
(2022, 2023, 95, 'ORIGINAL SCREENPLAY', 'Rafael Vasconcelos', 'Cartas de Inverno', FALSE),
(2024, 2025, 97, 'CINEMATOGRAPHY', 'Lucas Ribeiro', 'Horizonte de Sal', FALSE);

-- 7.3 Adicione uma nova categoria chamada "BEST INTERNATIONAL FEATURE FILM" com alguns vencedores recentes (2020-2024).

INSERT INTO indicados_ao_oscar (ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor) VALUES
(2019, 2020, 92, 'BEST INTERNATIONAL FEATURE FILM', 'Bong Joon-ho', 'Parasite', TRUE),
(2020, 2021, 93, 'BEST INTERNATIONAL FEATURE FILM', 'Thomas Vinterberg', 'Another Round', TRUE),
(2021, 2022, 94, 'BEST INTERNATIONAL FEATURE FILM', 'Ryusuke Hamaguchi', 'Drive My Car', TRUE),
(2022, 2023, 95, 'BEST INTERNATIONAL FEATURE FILM', 'Edward Berger', 'All Quiet on the Western Front', TRUE),
(2023, 2024, 96, 'BEST INTERNATIONAL FEATURE FILM', 'Jonathan Glazer', 'The Zone of Interest', TRUE);

-- 7.4 Corrija possíveis erros de digitação nos nomes dos filmes (ex: espaços extras, caracteres especiais desnecessários).

UPDATE indicados_ao_oscar
SET nome_filme = TRIM(REGEXP_REPLACE(nome_filme, '\\s+', ' '))
WHERE nome_filme IS NOT NULL;

-- 7.5 Remova todos os registros com valor NULL no campo nome_do_filme.

DELETE FROM indicados_ao_oscar
WHERE nome_filme IS NULL;

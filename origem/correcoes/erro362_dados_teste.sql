-- =============================================================================
-- Erro362 (imagem erro362.png) - Dados de TESTE para "Posicao de Estoque por
--           Grupo/Faixa de Valor" (FormSIGREFXV / SIGREFXVBO / SigReFxv.frx)
-- SigCdPpc/SigCdPpi (tabela de faixas de preco por GRUPO DE PRODUTO, ngrupos=1)
-- estavam VAZIAS: sem faixa o relatorio nao classifica nenhum produto.
-- Cria 4 faixas para cada grupo com estoque na empresa 001 / estoque 11210:
--   ALO ANO BRO COO CRO PGO PSO  (Grande Grupo JOO - JOIAS OURO)
-- Caracteristica (opcional no filtro "Complemento Caracteristica"):
--   SigPrCpP 'TEOR' + SigCdPft: ANO = 18K, BRO = 10K (demais sem resposta)
-- O estoque (SigMvEst) e os produtos (SigCdPro) ja existem - NAO sao alterados.
-- Marcador: cidchaves LIKE 'T362%'
-- Idempotente. Limpeza: erro362_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCdPft WHERE cidchaves LIKE 'T362%';
DELETE FROM SigPrCpP WHERE cidchaves LIKE 'T362%';
DELETE FROM SigCdPpi WHERE cidchaves LIKE 'T362%';
DELETE FROM SigCdPpc WHERE cidchaves LIKE 'T362%';
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000001', 'ALO', '2026-11-13', 'FAIXAS TESTE ALO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000001', 'T362PPC0000000000001', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000002', 'T362PPC0000000000001', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000003', 'T362PPC0000000000001', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000004', 'T362PPC0000000000001', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000002', 'ANO', '2026-11-13', 'FAIXAS TESTE ANO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000005', 'T362PPC0000000000002', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000006', 'T362PPC0000000000002', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000007', 'T362PPC0000000000002', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000008', 'T362PPC0000000000002', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000003', 'BRO', '2026-11-13', 'FAIXAS TESTE BRO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000009', 'T362PPC0000000000003', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000010', 'T362PPC0000000000003', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000011', 'T362PPC0000000000003', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000012', 'T362PPC0000000000003', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000004', 'COO', '2026-11-13', 'FAIXAS TESTE COO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000013', 'T362PPC0000000000004', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000014', 'T362PPC0000000000004', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000015', 'T362PPC0000000000004', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000016', 'T362PPC0000000000004', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000005', 'CRO', '2026-11-13', 'FAIXAS TESTE CRO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000017', 'T362PPC0000000000005', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000018', 'T362PPC0000000000005', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000019', 'T362PPC0000000000005', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000020', 'T362PPC0000000000005', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000006', 'PGO', '2026-11-13', 'FAIXAS TESTE PGO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000021', 'T362PPC0000000000006', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000022', 'T362PPC0000000000006', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000023', 'T362PPC0000000000006', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000024', 'T362PPC0000000000006', 'ACIMA 50 MIL', 50000.00, 999999999.99);
INSERT INTO SigCdPpc (cidchaves, codigos, datas, descrs, dtalts, usualts, usuars, ngrupos) VALUES ('T362PPC0000000000007', 'PSO', '2026-11-13', 'FAIXAS TESTE PSO', '2026-11-13', 'TESTE', 'TESTE', 1);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000025', 'T362PPC0000000000007', 'ATE 5 MIL', 0.00, 4999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000026', 'T362PPC0000000000007', '5 A 20 MIL', 5000.00, 19999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000027', 'T362PPC0000000000007', '20 A 50 MIL', 20000.00, 49999.99);
INSERT INTO SigCdPpi (cidchaves, fkchaves, descrs, faixais, faixafs) VALUES ('T362PPI0000000000028', 'T362PPC0000000000007', 'ACIMA 50 MIL', 50000.00, 999999999.99);

INSERT INTO SigPrCpP (codigos, descrs, ntipos, cidchaves) VALUES ('TEOR', 'TEOR DO METAL (TESTE)', 1, 'T362CPP0000000000001');

-- Resposta da caracteristica TEOR para os produtos com estoque em ANO (18K) e BRO (10K)
INSERT INTO SigCdPft (ccars, cidchaves, cpros, ctits, procartits, resps)
SELECT 'TEOR', 'T362PFT' + RIGHT('0000000000000' + CAST(ROW_NUMBER() OVER (ORDER BY p.Cpros) AS varchar(13)), 13),
       p.Cpros, 'TEOR', '', CASE p.Cgrus WHEN 'ANO' THEN '18K' ELSE '10K' END
  FROM SigCdPro p
 WHERE p.Cgrus IN ('ANO', 'BRO')
   AND p.Cpros IN (SELECT Cpros FROM SigMvEst WHERE Emps = '001' AND Grupos = '11210');

SELECT a.codigos, b.descrs, b.faixais, b.faixafs FROM SigCdPpc a JOIN SigCdPpi b ON b.fkchaves = a.cidchaves
 WHERE a.cidchaves LIKE 'T362%' ORDER BY a.codigos, b.faixais;
SELECT CAST(resps AS varchar(10)) AS resps, COUNT(*) AS produtos FROM SigCdPft WHERE cidchaves LIKE 'T362%' GROUP BY CAST(resps AS varchar(10));

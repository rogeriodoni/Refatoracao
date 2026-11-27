-- =============================================================================
-- Erro391 - Dados de TESTE para "Processamento para Bloqueio de Contas"
--           (FormSIGBLCTA / SIGBLCTABO)
--
-- POR QUE PRECISA DE DADOS PROPRIOS (medido em 25/11/2026):
--   O processamento faz UPDATE em SigCdCli.Situas das contas selecionadas.
--   Rodando sobre os dados REAIS ele alteraria ate 19 contas de cliente de
--   verdade (DESBLOQUEIO + "Somente com Vendas em Aberto"). Este script cria
--   contas ISOLADAS (IClis 'ZZT%') para o teste nao encostar em cliente real.
--
-- COMO O FORM SELECIONA (duas consultas + cruzamento local):
--   Q1  MAX(Vencs) por conta, SEM periodo:
--         BLOQUEIO    -> so parcelas com VPags <> Valos   (em atraso)
--         DESBLOQUEIO -> so parcelas com VPags =  Valos   (quitadas)
--   Q2  MAX(Vencs) por conta, DENTRO do periodo digitado, + g.Coletors = 2:
--         opcao 1 -> VPags <> Valos | opcao 2 -> VPags = Valos | opcao 3 -> tudo
--   Cruzamento: opcao 1 -> Q1 <  Q2 | opcao 2 -> Q1 >= Q2 | opcao 3 -> sempre
--
--   Por isso cada conta de teste recebe DUAS parcelas no mesmo cabecalho:
--     parcela 1 QUITADA  (VPags = Valos) com vencimento CEDO
--     parcela 2 EM ATRASO(VPags = 0)     com vencimento TARDE
--   Esse par faz a conta aparecer em BLOQ/opcao2, BLOQ/opcao3, DESB/opcao1 e
--   DESB/opcao2 - as quatro combinacoes alcancaveis.
--
-- ATENCAO - BLOQUEIO + "Somente com Parcelas em Atraso" devolve 0 SEMPRE, e
--   NAO eh falta de dado: nessa combinacao Q1 e Q2 filtram as MESMAS parcelas,
--   e Q2 ainda restringe ao periodo, entao Q2 <= Q1 e a condicao "Q1 < Q2"
--   nunca pode ser verdadeira. Esta reportado como suspeita de logica.
--
-- TECNICA: as 3 tabelas tem 152/111/59 colunas NOT NULL sem default, entao as
--   linhas sao CLONADAS de registros reais (SELECT * INTO #tmp + UPDATE das
--   poucas colunas que importam + INSERT), nunca digitadas coluna a coluna.
--   Doadores: SigCdCli 'C000001' (Grupos 11201, SigCdGcr.Coletors = 2)
--             SigMvCab/SigMvPar da chave '001ROMANEIO                10'
--
--   EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes char(20) +
--   Str(Numes,6)  (CLAUDE.md regra #42) - montada aqui com padding explicito.
--
-- COMO TESTAR DEPOIS DE RODAR:
--   Periodo  : 01/01/2026  a  31/12/2026
--   Situacao : 2           (CLIENTE COM RESTRICAO; as contas de teste nascem
--                           com Situas em branco, entao passam no "Situas <> 2")
--   Bloqueio    + "Somente com Vendas em Aberto"  -> 3 contas ZZT
--   Bloqueio    + "Ambos"                         -> 3 contas ZZT
--   Desbloqueio + "Somente com Parcelas em Atraso"-> 3 contas ZZT
--   Desbloqueio + "Somente com Vendas em Aberto"  -> 3 contas ZZT
--
-- Marcadores (para limpeza): SigCdCli.IClis LIKE 'ZZT%'
--                            SigMvCab.cidchaves LIKE 'ZZTST%'
--                            SigMvPar.cidchaves LIKE 'ZZTST%'
-- Idempotente. Limpeza: erro391_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;

-- ---------- limpeza previa (idempotencia) -----------------------------------
DELETE FROM SigMvPar WHERE cidchaves LIKE 'ZZTST%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'ZZTST%';
DELETE FROM SigCdCli WHERE IClis LIKE 'ZZT%';

-- ---------- 1) contas de teste (clone de C000001) ---------------------------
IF OBJECT_ID('tempdb..#cli') IS NOT NULL DROP TABLE #cli;
SELECT * INTO #cli FROM SigCdCli WHERE RTRIM(IClis) = 'C000001';

IF NOT EXISTS (SELECT 1 FROM #cli)
BEGIN
    RAISERROR('Conta doadora C000001 nao encontrada em SigCdCli - ajuste o doador.', 16, 1);
    RETURN;
END

UPDATE #cli SET IClis = 'ZZT000001', RClis = 'ZZ TESTE BLOQUEIO CONTA 01', Situas = '   ';
INSERT INTO SigCdCli SELECT * FROM #cli;
UPDATE #cli SET IClis = 'ZZT000002', RClis = 'ZZ TESTE BLOQUEIO CONTA 02';
INSERT INTO SigCdCli SELECT * FROM #cli;
UPDATE #cli SET IClis = 'ZZT000003', RClis = 'ZZ TESTE BLOQUEIO CONTA 03';
INSERT INTO SigCdCli SELECT * FROM #cli;

-- ---------- 2) cabecalhos de movimento (clone) ------------------------------
IF OBJECT_ID('tempdb..#cab') IS NOT NULL DROP TABLE #cab;
SELECT * INTO #cab FROM SigMvCab WHERE RTRIM(EmpDopNums) = RTRIM('001ROMANEIO                10');

IF NOT EXISTS (SELECT 1 FROM #cab)
BEGIN
    RAISERROR('Cabecalho doador nao encontrado em SigMvCab - ajuste o doador.', 16, 1);
    RETURN;
END

IF OBJECT_ID('tempdb..#par') IS NOT NULL DROP TABLE #par;
SELECT TOP 1 * INTO #par FROM SigMvPar WHERE RTRIM(EmpDopNums) = RTRIM('001ROMANEIO                10');

IF NOT EXISTS (SELECT 1 FROM #par)
BEGIN
    RAISERROR('Parcela doadora nao encontrada em SigMvPar - ajuste o doador.', 16, 1);
    RETURN;
END

-- conta 01 -> Numes 998001
UPDATE #cab SET cidchaves  = 'ZZTSTCAB0000000001',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998001',
                Emps = '001', Dopes = 'VENDA', Numes = 998001, ContaDs = 'ZZT000001';
INSERT INTO SigMvCab SELECT * FROM #cab;

UPDATE #cab SET cidchaves  = 'ZZTSTCAB0000000002',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998002',
                Numes = 998002, ContaDs = 'ZZT000002';
INSERT INTO SigMvCab SELECT * FROM #cab;

UPDATE #cab SET cidchaves  = 'ZZTSTCAB0000000003',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998003',
                Numes = 998003, ContaDs = 'ZZT000003';
INSERT INTO SigMvCab SELECT * FROM #cab;

-- ---------- 3) parcelas: 1 QUITADA cedo + 1 EM ATRASO tarde -----------------
-- conta 01
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000011',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998001',
                Parcs = 1, Valos = 1000.00, VPags = 1000.00, Vencs = '2026-02-10';
INSERT INTO SigMvPar SELECT * FROM #par;
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000012',
                Parcs = 2, Valos = 1000.00, VPags = 0.00,    Vencs = '2026-08-20';
INSERT INTO SigMvPar SELECT * FROM #par;

-- conta 02
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000021',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998002',
                Parcs = 1, Valos = 2500.00, VPags = 2500.00, Vencs = '2026-03-05';
INSERT INTO SigMvPar SELECT * FROM #par;
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000022',
                Parcs = 2, Valos = 2500.00, VPags = 500.00,  Vencs = '2026-09-15';
INSERT INTO SigMvPar SELECT * FROM #par;

-- conta 03
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000031',
                EmpDopNums = '001' + CAST('VENDA' AS char(20)) + '998003',
                Parcs = 1, Valos = 780.00,  VPags = 780.00,  Vencs = '2026-01-25';
INSERT INTO SigMvPar SELECT * FROM #par;
UPDATE #par SET cidchaves = 'ZZTSTPAR0000000032',
                Parcs = 2, Valos = 780.00,  VPags = 0.00,    Vencs = '2026-11-30';
INSERT INTO SigMvPar SELECT * FROM #par;

DROP TABLE #cli; DROP TABLE #cab; DROP TABLE #par;

-- ---------- 4) conferencia --------------------------------------------------
SELECT c.IClis, RTRIM(c.RClis) AS Conta, c.Grupos, g.Coletors, '['+c.Situas+']' AS Situas
  FROM SigCdCli c JOIN SigCdGcr g ON c.Grupos = g.Codigos
 WHERE c.IClis LIKE 'ZZT%' ORDER BY c.IClis;

SELECT b.ContaDs, p.Parcs, p.Valos, p.VPags,
       CASE WHEN p.VPags = p.Valos THEN 'QUITADA' ELSE 'EM ATRASO' END AS Estado,
       CONVERT(varchar(10), p.Vencs, 103) AS Vencimento, RTRIM(p.FPags) AS FPags
  FROM SigMvCab b JOIN SigMvPar p ON p.EmpDopNums = b.EmpDopNums
 WHERE b.cidchaves LIKE 'ZZTST%' ORDER BY b.ContaDs, p.Parcs;

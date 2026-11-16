-- =============================================================================
-- Erro363 (imagem erro363.png) - Dados de TESTE para "Emissao Global de
--           Duplicatas/Boletos" (FormSIGREGDP / SIGREGDPBO)
-- DUPLICATAS: NAO precisa de carga - a serie 1 ja tem NFs com forma de pagamento
--   CREDIARIO (SigOpFp.ImpDups = 1): 000010, 016, 018, 020, 021, 029, 030.
-- BOLETOS: nenhuma forma de pagamento tinha ImpBols = 1, entao a opcao
--   "Boletos Bancarios" nunca listava nada. Cria (clonando registros reais,
--   para herdar todas as colunas NOT NULL):
--   - SigOpFp 'T363 BOLETO' (clone de 'BOLETO PAG') com ImpBols = 1, ImpDups = 0
--   - venda 001/VENDA/9363 (clone da venda 13): SigMvCab + SigMvNfi NF 000031
--     serie 1 + 2 parcelas SigMvPar na forma 'T363 BOLETO'
-- NAO cria configuracao de duplicata (SigCnFDu) nem de boleto (SigCnFBl).
-- Marcador: cidchaves LIKE 'T363%' ; SigOpFp.fpags = 'T363 BOLETO'
-- Idempotente. Limpeza: erro363_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DECLARE @edn_ori char(29) = '001' + LEFT('VENDA' + SPACE(20), 20) + RIGHT(SPACE(6) + '13', 6);
DECLARE @edn_new char(29) = '001' + LEFT('VENDA' + SPACE(20), 20) + RIGHT(SPACE(6) + '9363', 6);

DELETE FROM SigMvPar WHERE cidchaves LIKE 'T363%';
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T363%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T363%';
DELETE FROM SigOpFp  WHERE fpags = 'T363 BOLETO';

SELECT * INTO #fp FROM SigOpFp WHERE fpags = 'BOLETO PAG';
UPDATE #fp SET fpags = 'T363 BOLETO', impbols = 1, impdups = 0;
INSERT INTO SigOpFp SELECT * FROM #fp;

SELECT * INTO #cab FROM SigMvCab WHERE empdopnums = @edn_ori;
UPDATE #cab SET empdopnums = @edn_new, numes = 9363, cidchaves = 'T363CAB0000000000001';
INSERT INTO SigMvCab SELECT * FROM #cab;

SELECT * INTO #nfi FROM SigMvNfi WHERE empdopnums = @edn_ori AND series = '1';
UPDATE #nfi SET empdopnums = @edn_new, numes = 9363, nfis = '000031', cidchaves = 'T363NFI0000000000001';
INSERT INTO SigMvNfi SELECT * FROM #nfi;

SELECT * INTO #par FROM SigMvPar WHERE empdopnums = @edn_ori;
UPDATE #par SET empdopnums = @edn_new, numes = 9363, fpags = 'T363 BOLETO',
       cidchaves = 'T363PAR' + RIGHT('0000000000000' + CAST(parcs AS varchar(13)), 13);
INSERT INTO SigMvPar SELECT * FROM #par;

SELECT (SELECT COUNT(*) FROM SigOpFp WHERE fpags = 'T363 BOLETO') AS fp,
       (SELECT COUNT(*) FROM SigMvCab WHERE cidchaves LIKE 'T363%') AS cab,
       (SELECT COUNT(*) FROM SigMvNfi WHERE cidchaves LIKE 'T363%') AS nfi,
       (SELECT COUNT(*) FROM SigMvPar WHERE cidchaves LIKE 'T363%') AS par;
SELECT a.series, a.nfis, a.clifors, b.fpags, b.parcs, b.valos, CONVERT(char(10), b.vencs, 103) AS venc
  FROM SigMvNfi a JOIN SigMvPar b ON b.empdopnums = a.empdopnums WHERE a.cidchaves LIKE 'T363%';
-- =============================================================================
-- Erro333 - Dados de TESTE para "Cotas de Desconto" (FormSIGREDES / SIGREDESBO)
-- Venda de teste 001 VENDA 933301 (05/11/2026, vendedora DANISA), copiada da
-- venda real 001VENDA 33 (todas as demais colunas do molde), com 2 itens e
-- descontos por item (SigMvItd) ligados a uma cota (sigcddes) de 11/2026.
-- SigMvItd e sigcddes estavam VAZIAS; as vendas reais sao de 2023/2024.
--   item 1: 338  Anel   2 x 1000 -> 900 (10% = 200, tpdesc 3: conta no Realizado)
--   item 2: 1741 Colar  1 x 1800 -> 1710 (5% = 90, tpdesc 1: NAO conta no Realizado)
-- Marcadores: cidchaves LIKE 'T333%' ; numes 933301 ; cota codigo 'T333COTA'
-- Idempotente. Limpeza: erro333_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DECLARE @edn char(29) = '001' + CAST('VENDA' AS char(20)) + STR(933301, 6);

DELETE FROM SigMvItd WHERE cidchaves LIKE 'T333%';
DELETE FROM SigMvItn WHERE cidchaves LIKE 'T333%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T333%';
DELETE FROM sigcddes WHERE codigo = 'T333COTA';

-- Cabecalho da venda (molde: venda real 001VENDA 33)
SELECT * INTO #cab FROM SigMvCab WHERE cidchaves = '0016UQ0PO2PE04162645';
IF (SELECT COUNT(*) FROM #cab) <> 1 RAISERROR('Venda molde nao encontrada', 16, 1);
UPDATE #cab SET cidchaves = 'T333CAB0000000000001', empdopnums = @edn, numes = 933301,
    datars = '2026-11-05 10:30', datas = '2026-11-05', vends = 'DANISA', emps = '001', dopes = 'VENDA';
INSERT INTO SigMvCab SELECT * FROM #cab;
DROP TABLE #cab;

-- Itens (molde: item da venda real)
SELECT * INTO #itn FROM SigMvItn WHERE cidchaves = '0016UQ0PR5VO31425401';
IF (SELECT COUNT(*) FROM #itn) <> 1 RAISERROR('Item molde nao encontrado', 16, 1);
UPDATE #itn SET cidchaves = 'T333ITN0000000000001', empdopnums = @edn, numes = 933301, citens = 1,
    cpros = '338', dpros = 'Anel ouro  338', qtds = 2, units = 900, unitorigs = 1000, totas = 1800;
INSERT INTO SigMvItn SELECT * FROM #itn;
UPDATE #itn SET cidchaves = 'T333ITN0000000000002', citens = 2,
    cpros = '1741', dpros = 'Colar em ouro amarelo', qtds = 1, units = 1710, unitorigs = 1800, totas = 1710;
INSERT INTO SigMvItn SELECT * FROM #itn;
DROP TABLE #itn;

-- Cota de desconto do periodo
INSERT INTO sigcddes (codigo, dtalts, dtfin, dtini, emps, usualts, valcota, valdes, valmeta, valcotac)
VALUES ('T333COTA', GETDATE(), '2026-11-30', '2026-11-01', '001', 'TESTE', 1000, 0, 0, 0);

-- Descontos por item (ligados a cota)
INSERT INTO SigMvItd (cdesc, cidchaves, citens, cpros, ddesc, dopes, dtalts, empdopnums, emps, numes,
    pdes, usuars, valbase, vdes, citenstpdesc, codigo, tpdesc, chaveexterna)
VALUES
 ('', 'T333ITD0000000000001', 1, '338',  'DESCONTO VENDEDOR', 'VENDA', GETDATE(), @edn, '001', 933301,
  10, 'TESTE', 2000, 200, 1, 'T333COTA', 3, ''),
 ('', 'T333ITD0000000000002', 2, '1741', 'DESCONTO A VISTA',  'VENDA', GETDATE(), @edn, '001', 933301,
  5,  'TESTE', 1800, 90,  1, 'T333COTA', 1, '');

COMMIT;

SELECT i.citens, i.cpros, i.qtds, i.unitorigs, i.units, i.totas, d.tpdesc, d.pdes, d.vdes, d.codigo, e.valcota
FROM SigMvItn i
LEFT JOIN SigMvItd d ON d.empdopnums = i.empdopnums AND d.cpros = i.cpros AND d.citens = i.citens
LEFT JOIN sigcddes e ON d.codigo COLLATE DATABASE_DEFAULT = e.codigo
WHERE i.cidchaves LIKE 'T333%' ORDER BY i.citens;

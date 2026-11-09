-- =============================================================================
-- Erro323 - Dados de TESTE para "Listagem de Composicao por OP" (FormSIGRECPM)
-- Tabelas: SigCdNec (cabecalho), SigCdNei (itens/materiais), SigPdMvf (mov.
-- de producao - INNER JOIN no relatorio), SigOpPic (OP -> produto acabado).
-- Marcador para limpeza: cidchaves LIKE 'TST323%'  (ver erro323_limpar_teste.sql)
-- Idempotente: apaga o lote anterior antes de inserir.
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigCdNei WHERE cidchaves LIKE 'TST323%';
DELETE FROM SigCdNec WHERE cidchaves LIKE 'TST323%';
DELETE FROM SigPdMvf WHERE cidchaves LIKE 'TST323%';
DELETE FROM SigOpPic WHERE cidchaves LIKE 'TST323%';

DECLARE @emp char(3) = '001';
DECLARE @dop char(20) = (SELECT TOP 1 dopps FROM SigCdOpd
                         WHERE dopps LIKE 'PRODU%O' AND dopps NOT LIKE '%CONSERTO%' AND dopps NOT LIKE 'ORDEM%');
IF @dop IS NULL RAISERROR('Operacao PRODUCAO nao encontrada em SigCdOpd', 16, 1);

-- ---------------------------------------------------------------- OPs (cabecalhos)
-- numps / nops / produto acabado / qtd OP / data / OP mae (nenvs)
DECLARE @op TABLE (seq int, numps int, nops int, nenvs int, cpros char(14), qtd numeric(11,3), datas datetime);
INSERT @op VALUES
 (1, 90001, 900001, 900001, '338',  10, '2026-11-05 09:00'),   -- Anel ouro 338
 (2, 90002, 900002, 900002, '1741',  4, '2026-11-06 10:30'),   -- Colar em ouro amarelo
 (3, 90003, 900003, 900001, '338',   2, '2026-11-07 14:00');   -- sub-ordem da OP 900001

-- ---------------------------------------------------------------- materiais
DECLARE @it TABLE (seq int, item int, cmats char(14), qtds numeric(9,3), pesos numeric(9,3), peso2s numeric(9,3), servicos bit);
INSERT @it VALUES
 (1, 1, 'AU 750',    10, 25.500, 19.125, 0),
 (1, 2, 'POLIMENTO', 10,  0.300,  0.000, 1),
 (2, 1, 'AU 750',     4, 48.200, 36.150, 0),
 (2, 2, 'POLIMENTO',  4,  0.450,  0.000, 1),
 (3, 1, 'AU 750',     2,  3.100,  2.325, 0);

-- SigCdNec (empdnps = emps(3) + dopps(20) + STR(numps,10) = 33)
INSERT INTO SigCdNec (chksubn, contads, contaos, datars, datas, datatrans, dopps, emps, grupods, grupoos,
    grvends, imprs, lccs, numps, obss, procbals, procdbal, totpesos, usuars, vends, docus, locals, ntrans,
    nops, naceites, retrabs, cidchaves, empdnps, autos, libprods, codnconfs, numbalds, numbals, codobs,
    empds, nconforms, nlotes, jobs, pesolancs, usulibs, chkbaixa, usuconfs)
SELECT 0, '3010110003', '1121001', o.datas, o.datas, o.datas, @dop, @emp, '30101', '11210',
    '', 0, 0, o.numps, 'TESTE Erro323', 0, 0,
    (SELECT SUM(i.pesos) FROM @it i WHERE i.seq = o.seq), 'TESTE', '', '', '', 0,
    o.nops, 0, 0, 'TST323NEC' + RIGHT('00000000000' + CAST(o.seq AS varchar), 11),
    @emp + @dop + STR(o.numps, 10), 0, '', '', 0, 0, 0,
    @emp, 0, 0, '', 0, '', 0, ''
FROM @op o;

-- SigCdNei
INSERT INTO SigCdNei (aqtds, cats, cdescs, cgrus, cmats, coefs, contafs, cunis, datatrans, dopps, emps,
    fators, flagincs, grupofins, grupofs, moedas, moeds, nenvs, nops, numps, obss, pesos, qtds, servicos,
    tpops, locals, ntrans, cidchaves, nlotes, pesofixs, coefinfs, cretrabs, empdnps, empdopnums, chksubn,
    codcors, codnconfs, codtams, peso2s, custofs, moecusfs, estorno, pvens)
SELECT i.qtds, '', LEFT(p.dpros, 40), ISNULL(p.cgrus, ''), i.cmats, 1, '3010110003', p.cunis, o.datas, @dop, @emp,
    1, 0, '', '30101', '', '', o.nenvs, o.nops, o.numps, '', i.pesos, i.qtds, i.servicos,
    '', '', 0, 'TST323NEI' + RIGHT('00000000000' + CAST(o.seq * 10 + i.item AS varchar), 11), 0, 0, 0, '',
    @emp + @dop + STR(o.numps, 10), @emp + @dop + STR(o.numps, 6), 0,
    '', '', '', i.peso2s, 0, '', 0, 0
FROM @it i
JOIN @op o ON o.seq = i.seq
JOIN SigCdPro p ON p.cpros = i.cmats COLLATE DATABASE_DEFAULT;

-- SigPdMvf (f.qtds = quantidade produzida na OP)
INSERT INTO SigPdMvf (codpds, contads, contaos, dataes, dataps, datars, datas, datatrans, dopes, dopps, emps,
    etiqs, finals, grupods, grupoos, inicios, nenvs, nops, numes, numps, obsps, obss, opers, ordems, pesos,
    qtds, unids, usuars, locals, ntrans, cretrabs, cidchaves, empdnps, empdopnums, chksubn, ordemos, tmpmins)
SELECT o.cpros, '3010110003', '1121001', o.datas, o.datas, o.datas, o.datas, o.datas, @dop, @dop, @emp,
    0, o.datas, '30101', '11210', o.datas, o.nenvs, o.nops, o.numps, o.numps, '', 'TESTE Erro323', 'E', 1,
    (SELECT SUM(i.pesos) FROM @it i WHERE i.seq = o.seq),
    o.qtd, p.cunis, 'TESTE', '', 0, '', 'TST323MVF' + RIGHT('00000000000' + CAST(o.seq AS varchar), 11),
    @emp + @dop + STR(o.numps, 10), @emp + @dop + STR(o.numps, 6), 0, 1, 0
FROM @op o
JOIN SigCdPro p ON p.cpros = o.cpros COLLATE DATABASE_DEFAULT;

-- SigOpPic (OP -> produto acabado; nopmaes = OP mae)
INSERT INTO SigOpPic (dataes, dataps, dopes, dopps, emps, nops, numes, numps, obss, qtds, datatrans, locals,
    ntrans, cpros, empds, dtgeras, seqdivs, codcors, codtams, divs, imprs, usuars, nopmaes, pesos, cidchaves,
    codbarras, qtdcpnts, qtdtubos, iimprs, moedas, units, dtfunds, nfunds, dpros, empdnps, empdopnops,
    empdopnums, notas, codtgops, citens)
SELECT o.datas, o.datas, @dop, @dop, @emp, o.nops, o.numps, o.numps, 'TESTE Erro323', o.qtd, o.datas, '',
    0, o.cpros, @emp, o.datas, 0, '', '', 0, 0, 'TESTE',
    CASE WHEN o.nenvs <> o.nops THEN o.nenvs ELSE 0 END,
    (SELECT SUM(i.pesos) FROM @it i WHERE i.seq = o.seq),
    'TST323OPP' + RIGHT('00000000000' + CAST(o.seq AS varchar), 11),
    0, 0, 0, 0, '', 0, NULL, 0, LEFT(p.dpros, 65),
    @emp + @dop + STR(o.numps, 10), @emp + @dop + STR(o.nops, 10), @emp + @dop + STR(o.numps, 6), '', '', 0
FROM @op o
JOIN SigCdPro p ON p.cpros = o.cpros COLLATE DATABASE_DEFAULT;

-- OP 900002 com origem/destino DIFERENTES, para os filtros de Grupo/Conta discriminarem
--   OPs 900001/900003: Origem 11210/1121001    -> Destino 30101/3010110003
--   OP  900002       : Origem 11101/1110100001 -> Destino 30102/3010210001
UPDATE SigCdNec SET grupoos = '11101', contaos = '1110100001', grupods = '30102', contads = '3010210001'
 WHERE cidchaves LIKE 'TST323%' AND nops = 900002;
UPDATE SigPdMvf SET grupoos = '11101', contaos = '1110100001', grupods = '30102', contads = '3010210001'
 WHERE cidchaves LIKE 'TST323%' AND nops = 900002;
UPDATE SigCdNei SET grupofs = '30102', contafs = '3010210001'
 WHERE cidchaves LIKE 'TST323%' AND nops = 900002;

COMMIT;

SELECT 'SigCdNec' tabela, COUNT(*) qtd FROM SigCdNec WHERE cidchaves LIKE 'TST323%'
UNION ALL SELECT 'SigCdNei', COUNT(*) FROM SigCdNei WHERE cidchaves LIKE 'TST323%'
UNION ALL SELECT 'SigPdMvf', COUNT(*) FROM SigPdMvf WHERE cidchaves LIKE 'TST323%'
UNION ALL SELECT 'SigOpPic', COUNT(*) FROM SigOpPic WHERE cidchaves LIKE 'TST323%';

-- =============================================================================
-- Erro328 - Dados de TESTE para "Relatorio Movimentacao de Cartoes"
--           (Formsigrectc / sigrectcBO)
-- SigCdCar = lote de cartao | SigCdCtt = transacao do lote | SigCdCrd = recebivel
-- (transacao ja "depositada": totres total, totpar ja recebido).
-- As 3 tabelas estavam VAZIAS no banco.
--   T1 (9328001) entrada NAO depositada      -> Entradas + A Depositar
--   T2 (9328002) depositada, saldo a receber -> Entradas + A Receber
--   T3 (9328003) depositada e quitada        -> Entradas + Baixados
-- Marcadores: cidchaves LIKE 'T328%' ; ncarts 9328001..9328003 ; nlotecs 'T328L000n'
-- Idempotente. Limpeza: erro328_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigCdCrd WHERE cidchaves LIKE 'T328%';
DELETE FROM SigCdCtt WHERE cidchaves LIKE 'T328%';
DELETE FROM SigCdCar WHERE cidchaves LIKE 'T328%';

DECLARE @emp char(3) = '001', @dop char(20) = 'VENDA';

-- seq, ncarts, numes, lote, cartao (SigOpFp.fpags), cliente, valor, parcelas, taxa%, data entrada,
-- vencimento, deposito? (vai p/ SigCdCrd), venc. do recebivel, ja recebido
DECLARE @t TABLE (seq int, ncarts numeric(10,0), numes numeric(6,0), nlote char(10), fpags char(12), iclis char(10),
                  valos numeric(11,2), parcs numeric(2,0), taxas numeric(7,3), datas datetime, vencs datetime,
                  deposita bit, crdvenc datetime, totpar numeric(9,2));
INSERT @t VALUES
 (1, 9328001, 932801, 'T328L0001', 'CIVISA CRED', 'C000001',    1200.00, 1, 2.500, '2026-11-03 10:00', '2026-12-03', 0, NULL,         0.00),
 (2, 9328002, 932802, 'T328L0002', 'RD VISA CR',  'C001000007',  850.00, 1, 3.000, '2026-10-05 11:00', '2026-11-05', 1, '2026-11-05', 300.00),
 (3, 9328003, 932803, 'T328L0003', 'CI MC 2-6',   'C000001',    2400.00, 3, 4.000, '2026-09-20 15:30', '2026-10-20', 1, '2026-10-20', 2400.00);

-- Lote (SigCdCar)
INSERT INTO SigCdCar (datas, datatrans, dopes, emps, fpags, iclis, locals, nloteants, nlotecs, ntrans, numes,
    numlotechs, utilizados, cidchaves, empdopnums)
SELECT t.datas, t.datas, @dop, @emp, t.fpags, t.iclis, '', 0, t.nlote, 0, t.numes,
    0, 0, 'T328CAR' + RIGHT('0000000000000' + CAST(t.seq AS varchar), 13), @emp + @dop + STR(t.numes, 6)
FROM @t t;

-- Transacao (SigCdCtt)
INSERT INTO SigCdCtt (obs, cartaos, ccons, ctccs, datas, datatrans, descs, dopes, dt_deposit, emps, fpags, iclis,
    locals, ncartants, ncarts, nloteants, nlotecs, nmcos, nocreditos, noresumos, notas, ntrans, numes, parcs,
    recebidos, taxas, valos, valpars, vencs, vr_recebs, numlotechs, cartprots, obses, cidchaves, empdopnums, chaves)
SELECT 'TESTE Erro328', '4111********' + RIGHT(CAST(t.ncarts AS varchar), 4), '', '', t.datas, t.datas, 0, @dop,
    CASE WHEN t.deposita = 1 THEN t.vencs END, @emp, t.fpags, t.iclis,
    '', 0, t.ncarts, 0, t.nlote, 0, '', 'RES' + RIGHT(CAST(t.ncarts AS varchar), 4), '', 0, t.numes, t.parcs,
    NULL, t.taxas, t.valos, ROUND(t.valos / t.parcs, 2), t.vencs, 0, 0, '', '',
    'T328CTT' + RIGHT('0000000000000' + CAST(t.seq AS varchar), 13), @emp + @dop + STR(t.numes, 6), ''
FROM @t t;

-- Recebivel (SigCdCrd) - so das transacoes depositadas
INSERT INTO SigCdCrd (cartaos, ccons, ctccs, datas, datatrans, descs, dopes, dt_deposit, emps, flags, fpags, iclis,
    locals, ncartants, ncarts, nloteants, nlotecs, nmcos, nocreditos, noresumos, notas, ntrans, numes, parcs,
    recebidos, taxas, totpar, totrec, totres, valos, valpars, vencs, vr_recebs, numlotechs, cidchaves, empdopnums)
SELECT '4111********' + RIGHT(CAST(t.ncarts AS varchar), 4), '', '', t.datas, t.datas, 0, @dop, t.vencs, @emp, '', t.fpags, t.iclis,
    '', 0, t.ncarts, 0, t.nlote, 0, '', 'RES' + RIGHT(CAST(t.ncarts AS varchar), 4), '', 0, t.numes, t.parcs,
    CASE WHEN t.totpar >= t.valos THEN t.crdvenc END, t.taxas, t.totpar, t.totpar, t.valos, t.valos, ROUND(t.valos / t.parcs, 2),
    t.crdvenc, t.totpar, 0, 'T328CRD' + RIGHT('0000000000000' + CAST(t.seq AS varchar), 13), @emp + @dop + STR(t.numes, 6)
FROM @t t WHERE t.deposita = 1;

COMMIT;

SELECT b.ncarts, b.fpags, b.iclis, b.valos, b.taxas, b.datas AS entrada, b.vencs,
       d.vencs AS venc_receb, d.totres, d.totpar, d.totres - d.totpar AS saldo
FROM SigCdCtt b LEFT JOIN SigCdCrd d ON d.ncarts = b.ncarts AND d.emps = b.emps
WHERE b.cidchaves LIKE 'T328%' ORDER BY b.ncarts;

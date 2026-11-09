-- =============================================================================
-- Erro325 - Dados de TESTE para "Cheques Prorrogados" (Formsigrecpr / sigrecprBO)
-- SigChe  : cheque (vencs = vencimento ATUAL, ja prorrogado)
-- SigChea : historico da prorrogacao (vencs = vencimento ANTIGO, datas = data
--           da prorrogacao, pjuros/vjuros = juros) - igual ao SigOpChp.Prorroga.Click
-- O relatorio exige e.contat = SigCdCli.iclis: os 9 cheques reais estao com
-- contat em branco e nunca apareceriam (nem no legado). Por isso cheques NOVOS.
-- Marcadores: SigChe.nums LIKE '99325%'  /  SigChea.cidchaves LIKE 'TST325%'
-- Idempotente. Limpeza: erro325_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigChea WHERE cidchaves LIKE 'TST325%';
DELETE FROM SigChe  WHERE nums LIKE '99325%';

-- nums, cliente, conta transito, operacao, valor, ncheque, venc ANTIGO, venc NOVO, dt prorrog, % juros
DECLARE @c TABLE (nums char(8), iclis char(10), contat char(10), umovs char(15), valor numeric(11,2),
                  nch char(6), vantigo datetime, vnovo datetime, dtpror datetime, pj numeric(5,2));
INSERT @c VALUES
 ('99325001', 'C000001',    '1110100001', 'ENTRADA',       1800.00, '325001', '2026-10-10', '2026-11-05', '2026-10-08', 2.00),
 ('99325002', 'C001000007', '1110100001', 'ENTRADA',        950.00, '325002', '2026-09-15', '2026-10-15', '2026-09-14', 1.50),
 ('99325003', 'C000001',    '1110100001', 'ENTRADA',       2500.00, '325003', '2026-11-01', '2026-12-01', '2026-10-30', 2.50),
 ('99325004', 'C001000007', '1110100001', 'DEPOSITO',       500.00, '325004', '2026-08-20', '2026-09-20', '2026-08-19', 1.00),
 ('99325005', 'C000001',    '1110100002', 'CHQ DEVOLVIDO', 3200.00, '325005', '2026-07-05', '2026-08-05', '2026-07-03', 3.00);

-- Cheque: molde = cheque real 00000035 (mesmos grupos/contas/empresa/moeda)
INSERT INTO SigChe (agencias, autos, bancos, concarts, conorigs, conres, contas, copchs, datas, datatrans,
    emps, fpags, grclis, grucarts, gruorigs, grupos, grures, grvends, iclis, leituras, locals, nalineas,
    ncheques, ncontas, notas, ntrans, numeros, numolds, numos, nums, protocolos, umovs, valors, valpags,
    vencs, vends, dtemis, dtalts, contat, grupot, cotas, moeds, tipoblq, custodia)
SELECT m.agencias, m.autos, m.bancos, m.concarts, m.conorigs, m.conres, m.contas, m.copchs, c.vantigo - 30, c.dtpror,
    m.emps, m.fpags, m.grclis, m.grucarts, m.gruorigs, m.grupos, m.grures, m.grvends, c.iclis, '', m.locals, 0,
    c.nch, m.ncontas, '', 0, '', '', 0, c.nums, '', c.umovs, c.valor, 0,
    c.vnovo, m.vends, c.vantigo - 30, c.dtpror, c.contat, '11101', m.cotas, m.moeds, 0, ''
FROM @c c CROSS JOIN SigChe m
WHERE m.nums = '00000035';

-- Prorrogacao
INSERT INTO SigChea (datas, nums, pjuros, usuars, vencs, vjuros, cidchaves, motivo)
SELECT c.dtpror, c.nums, c.pj, 'TESTE#ERRO325', c.vantigo, ROUND(c.valor * c.pj / 100, 2),
       'TST325' + RIGHT('00000000000000' + RTRIM(c.nums), 14), 'TESTE Erro325'
FROM @c c;

COMMIT;

SELECT e.nums, e.iclis, e.contat, e.umovs, e.valors, a.vencs AS venc_antigo, e.vencs AS venc_novo, a.datas AS dt_prorrog, a.pjuros, a.vjuros
FROM SigChe e JOIN SigChea a ON a.nums = e.nums
WHERE e.nums LIKE '99325%' ORDER BY e.nums;

-- =============================================================================
-- Erro327 - Dados de TESTE para "Relatorio de Debitos/Creditos Pendentes"
--           (Formsigrecrp / sigrecrpBO)
-- Lancamentos de conta corrente (SigMvCcr) em aberto (Valors - ValPags <> 0),
-- sem documento (Dopes vazio, Numes 0, Tipos ' '), vencendo em 11/2026.
-- Molde: lancamento real 20231123000202 (todas as demais colunas copiadas).
-- Marcadores: cidchaves LIKE 'T327CCR%'  /  nopers 9327001..9327005
-- Idempotente. Limpeza: erro327_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigMvCcr WHERE cidchaves LIKE 'T327CCR%';

-- seq, opers, grupo, conta, grupo C.P., conta C.P., valor, pago, vencimento, historico
DECLARE @l TABLE (seq int, opers char(1), grupos char(10), contas char(10), sgrupos char(10), scontas char(10),
                  valors numeric(14,2), valpags numeric(14,2), vencs datetime, hists varchar(60));
INSERT @l VALUES
 (1, 'D', '11201', 'C001000007', '11103',    '1110300001', 1500.00, 500.00, '2026-11-09', 'TESTE ERRO327 - DEBITO PARCIAL ANA CRISTINA'),
 (2, 'D', '11201', 'C000001',    '11103',    '1110300001',  800.00,   0.00, '2026-11-20', 'TESTE ERRO327 - DEBITO ADRIANA'),
 (3, 'D', '21101', 'F000000030', 'TRANSITO', 'TRANS PAG',   300.00,   0.00, '2026-11-15', 'TESTE ERRO327 - DEBITO FORNECEDOR'),
 (4, 'C', '21101', 'F000000030', 'TRANSITO', 'TRANS PAG',  2000.00,   0.00, '2026-11-09', 'TESTE ERRO327 - CREDITO FORNECEDOR'),
 (5, 'C', '21102', 'DANISA',     'TRANSITO', 'TRANS REC',   450.00, 150.00, '2026-11-25', 'TESTE ERRO327 - CREDITO PARCIAL DANISA');

SELECT * INTO #m FROM SigMvCcr WHERE cidchaves = '20231123000202';
IF (SELECT COUNT(*) FROM #m) <> 1 RAISERROR('Lancamento molde 20231123000202 nao encontrado', 16, 1);

DECLARE @i int = 1;
WHILE @i <= 5
BEGIN
    UPDATE m SET
        cidchaves  = 'T327CCR' + RIGHT('0000000000000' + CAST(l.seq AS varchar), 13),
        nopers     = 9327000 + l.seq,
        emps       = '001',
        opers      = l.opers,
        sopers     = CASE l.opers WHEN 'D' THEN 'C' ELSE 'D' END,
        tipos      = ' ',
        grupos     = l.grupos,
        contas     = l.contas,
        sgrupos    = l.sgrupos,
        scontas    = l.scontas,
        moedas     = 'R',
        smoedas    = 'R',
        valors     = l.valors,
        svalors    = l.valors,
        valpags    = l.valpags,
        vencs      = l.vencs,
        datas      = DATEADD(day, -30, l.vencs),
        datalts    = GETDATE(),
        hists      = l.hists,
        shists     = '',
        dopes      = '',
        numes      = 0,
        dopcs      = '',
        numcs      = 0,
        empdopncs  = '',
        empdopnums = '',
        gruconmoes = l.grupos + l.contas + 'R  ',
        pagos      = CASE WHEN l.valpags = 0 THEN '0' ELSE '1' END,
        usualts    = 'TESTE327'
    FROM #m m CROSS JOIN @l l WHERE l.seq = @i;
    INSERT INTO SigMvCcr SELECT * FROM #m;
    SET @i = @i + 1;
END
DROP TABLE #m;

COMMIT;

SELECT a.nopers, a.opers, a.grupos, a.contas, b.rclis, a.sgrupos, a.scontas, a.valors, a.valpags,
       a.valors - a.valpags AS pendente, a.vencs
FROM SigMvCcr a JOIN SigCdCli b ON b.iclis = a.contas
WHERE a.cidchaves LIKE 'T327CCR%' ORDER BY a.opers DESC, a.nopers;

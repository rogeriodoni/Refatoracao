-- =============================================================================
-- Erro372 (imagem erro372.png) - Dados de TESTE para "Relatorio de Cheques Emitidos"
--           (Formsigrehtc / sigrehtcBO / SigReHtc.frx)
-- SigCqChi estava VAZIA -> o relatorio nunca trazia nada.
-- Cria 6 cheques da operacao 'T372 PAGAMENTO' (empresa 001) e os itens de
-- pagamento (SigCdPit) que alimentam a coluna Historico:
--   Copia 3721 Grupo 11102/1110200001 Chq 000101  1.500,00 05/10/2026 venc 20/10/2026 EMITIDO
--              hist via SigMvPar (tipo P) -> "001VENDA 32 ( CREDIARIO )"
--   Copia 3722 Grupo 11102/1110200001 Chq 000102  3.200,00 12/10/2026 venc 30/11/2026 EMITIDO
--              2 itens via SigMvCcr: 2.000,00 + 1.200,00 (2 linhas no relatorio)
--   Copia 3723 Grupo 11102/1110200001 Chq 000103    800,00 15/10/2026 CANCELADO
--   Copia 3724 Grupo 11102/1110200001 Chq 000104    450,00 03/11/2026 NAO EMITIDO
--   Copia 3725 Grupo 11101/1110100001 Chq 000201    990,00 01/09/2026 EMITIDO (outra conta)
--   Copia 3726 Grupo 11102/1110200001 Chq 000099    700,00 15/12/1999 EMITIDO -> FORA do periodo
-- Com os filtros da imagem (Emitido/Validos/Movimentacao/por Copia, 01/01/2000 a
-- 16/11/2026) saem as copias 3721, 3722 (2 linhas) e 3725 - total 5.690,00.
-- Marcador: cidchaves LIKE 'T372%' (SigCqChi e SigCdPit)
-- Idempotente. Limpeza: erro372_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCqChi WHERE cidchaves LIKE 'T372%';
DELETE FROM SigCdPit WHERE cidchaves LIKE 'T372%';

-- Cheques
INSERT INTO SigCqChi (agencias, bancos, cancelas, contas, datas, dopes, emitidos, emps, favos, grupos,
                      ncheques, ncontas, ncopias, nemissoes, numes, valors, vencs, versos,
                      cidchaves, empdopnums, justcanc, impversos)
SELECT v.ag, v.bc, v.canc, v.conta, v.dt, 'T372 PAGAMENTO', v.emit, '001', v.fav, v.grp,
       v.chq, '12345-6', v.cop, 1, v.num, v.val, v.venc, '',
       'T372C' + CAST(v.cop AS varchar(6)), '001' + CAST('T372 PAGAMENTO' AS char(20)) + STR(v.num, 6),
       CASE WHEN v.canc = 1 THEN 'Cheque cancelado - teste Erro372' ELSE '' END, 0
  FROM (VALUES
   (3721, 1, '0001', '077', 0, 1, '11102', '1110200001', '000101', 'FORNECEDOR TESTE 372 LTDA',      1500.00, '20261005', '20261020'),
   (3722, 2, '0001', '077', 0, 1, '11102', '1110200001', '000102', 'ALUGUEL LOJA 001 - TESTE 372',   3200.00, '20261012', '20261130'),
   (3723, 3, '0001', '077', 1, 0, '11102', '1110200001', '000103', 'CHEQUE CANCELADO - TESTE 372',    800.00, '20261015', '20261015'),
   (3724, 4, '0001', '077', 0, 0, '11102', '1110200001', '000104', 'CHEQUE NAO EMITIDO - TESTE 372',  450.00, '20261103', '20261110'),
   (3725, 5, '0341', '341', 0, 1, '11101', '1110100001', '000201', 'PRESTADOR SERVICO - TESTE 372',   990.00, '20260901', '20260901'),
   (3726, 6, '0001', '077', 0, 1, '11102', '1110200001', '000099', 'CHEQUE ANTIGO - TESTE 372',       700.00, '19991215', '19991215')
  ) v(cop, num, ag, bc, canc, emit, grp, conta, chq, fav, val, dt, venc);

-- Itens de pagamento (historico). Clone do item real da RECEBIMENTO 3.
SELECT * INTO #p0 FROM SigCdPit WHERE cidchaves = '24031315431560070';
DECLARE @i int = 1;
WHILE @i <= 6
BEGIN
    SELECT * INTO #p FROM #p0;
    UPDATE #p SET
        cidchaves  = 'T372P' + CAST(@i AS varchar(1)),
        emps       = '001',
        dopes      = 'T372 PAGAMENTO',
        numes      = CASE @i WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 3 THEN 2 WHEN 4 THEN 4 WHEN 5 THEN 5 ELSE 6 END,
        tipos      = CASE WHEN @i IN (2,3,5) THEN 'C' ELSE 'P' END,
        empos      = '001',
        nopers     = CASE @i WHEN 2 THEN 9357001 WHEN 3 THEN 9357002 WHEN 5 THEN 9357003 ELSE 773909 END,
        acertos    = CASE @i WHEN 1 THEN 1500 WHEN 2 THEN 2000 WHEN 3 THEN 1200 WHEN 4 THEN 450 WHEN 5 THEN 990 ELSE 700 END,
        valos      = CASE @i WHEN 1 THEN 1500 WHEN 2 THEN 2000 WHEN 3 THEN 1200 WHEN 4 THEN 450 WHEN 5 THEN 990 ELSE 700 END;
    UPDATE #p SET empdopnums = emps + CAST(dopes AS char(20)) + STR(numes, 6);
    INSERT INTO SigCdPit SELECT * FROM #p;
    DROP TABLE #p;
    SET @i = @i + 1;
END
DROP TABLE #p0;

SELECT c.ncopias, c.grupos, c.contas, c.ncheques, c.valors, CONVERT(char(10), c.datas, 103) data,
       CONVERT(char(10), c.vencs, 103) venc, c.emitidos, c.cancelas, p.tipos, p.nopers, p.acertos
  FROM SigCqChi c LEFT JOIN SigCdPit p ON p.emps = c.emps AND p.dopes = c.dopes AND p.numes = c.numes
 WHERE c.cidchaves LIKE 'T372%' ORDER BY c.ncopias, p.cidchaves;

-- =============================================================================
-- Erro374 (imagem erro374.png) - Dados de TESTE para "Impressao de Documento de Titulo"
--           (FormSigReIdt / SigReIdtBO / SigReIag.frx, SigReIdt.frx, SigReIdA.frx)
-- O relatorio imprime UM titulo (empresa/operacao/titulo/numero recebidos da tela
-- de Titulos Gerados). Cria uma DESPESA RECORRENTE de aluguel em 3 documentos
-- da operacao CONTAS A PAGAR (SigMvCcr, RealPrevs = 1), no padrao de partida
-- dobrada do sistema (linha ' ' do titulo + linhas 'C' do rateio por centro de
-- custo, cada uma com a contrapartida D na conta TRANSITO / TRANS PAG):
--   Doc 374001  titulo T374/01  venc 10/11/2026  1.800,00
--   Doc 374002  titulo T374/02  venc 10/12/2026  1.800,00
--   Doc 374003  titulo T374/03  venc 10/01/2027  1.800,00
--   Rateio de cada um: 3110231005 SALARIOS E ORDENADOS 1.200,00
--                      3110231007 FERIAS                 600,00
--   Fornecedor (emitente/portador): 21101 / F000000029
-- SigTtCcd (obs/historico) no doc 374001; SigTtRec liga os 3 docs (nRecors 374)
-- para testar "Imprimir Recorrencia" = Sim / Agrupada.
-- Para testar: empresa 001, operacao CONTAS A PAGAR, titulo T374/01, numero 374001
-- Marcador: cidchaves LIKE 'T374%' (SigMvCcr, SigTtCcd, SigTtRec)
-- Idempotente. Limpeza: erro374_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigMvCcr WHERE cidchaves LIKE 'T374%';
DELETE FROM SigTtCcd WHERE cidchaves LIKE 'T374%';
DELETE FROM SigTtRec WHERE cidchaves LIKE 'T374%';

SELECT * INTO #m FROM SigMvCcr WHERE cidchaves = '20240314000021';   -- modelo: linha ' ' / C
DECLARE @d int = 1, @l int, @num int, @tit char(10), @venc datetime, @edn char(29);
WHILE @d <= 3
BEGIN
    SET @num  = 374000 + @d;
    SET @tit  = 'T374/0' + CAST(@d AS varchar(1));
    SET @venc = DATEADD(month, @d - 1, '20261110');
    SET @edn  = '001' + CAST('CONTAS A PAGAR' AS char(20)) + STR(@num, 6);
    SET @l = 1;
    WHILE @l <= 6
    BEGIN
        -- 1: ' ' C  fornecedor x transito          2: ' ' D contrapartida
        -- 3: 'C' C  transito x CC 3110231005 1200  4: 'C' D contrapartida
        -- 5: 'C' C  transito x CC 3110231007  600  6: 'C' D contrapartida
        SELECT * INTO #n FROM #m;
        UPDATE #n SET
            cidchaves = 'T374CCR' + CAST(@d AS varchar(1)) + CAST(@l AS varchar(1)),
            emps = '001', dopcs = 'CONTAS A PAGAR', titulos = @tit, numcs = @num, empdopncs = @edn,
            datas = '20261105', dtemis = '20261105', vencs = @venc,
            tipos  = CASE WHEN @l <= 2 THEN ' ' ELSE 'C' END,
            opers  = CASE WHEN @l % 2 = 1 THEN 'C' ELSE 'D' END,
            valors = CASE WHEN @l <= 2 THEN 1800 WHEN @l <= 4 THEN 1200 ELSE 600 END,
            valprev = 0, valocurs = 0, valpags = 0,
            grupems = '21101', contems = 'F000000029',
            grupos  = CASE @l WHEN 1 THEN '21101' WHEN 2 THEN 'TRANSITO' WHEN 3 THEN 'TRANSITO'
                              WHEN 4 THEN '31102' WHEN 5 THEN 'TRANSITO' ELSE '31102' END,
            contas  = CASE @l WHEN 1 THEN 'F000000029' WHEN 2 THEN 'TRANS PAG' WHEN 3 THEN 'TRANS PAG'
                              WHEN 4 THEN '3110231005' WHEN 5 THEN 'TRANS PAG' ELSE '3110231007' END,
            sgrupos = CASE @l WHEN 1 THEN 'TRANSITO' WHEN 2 THEN '21101' WHEN 3 THEN '31102'
                              WHEN 4 THEN 'TRANSITO' WHEN 5 THEN '31102' ELSE 'TRANSITO' END,
            scontas = CASE @l WHEN 1 THEN 'TRANS PAG' WHEN 2 THEN 'F000000029' WHEN 3 THEN '3110231005'
                              WHEN 4 THEN 'TRANS PAG' WHEN 5 THEN '3110231007' ELSE 'TRANS PAG' END,
            hist2s = 'ALUGUEL LOJA 001 - PARCELA ' + CAST(@d AS varchar(1)) + '/3 - TESTE 374',
            titbans = 'BOL' + CAST(@num AS varchar(6));
        INSERT INTO SigMvCcr SELECT * FROM #n;
        DROP TABLE #n;
        SET @l = @l + 1;
    END
    INSERT INTO SigTtRec (cidchaves, empdopncs, nrecors) VALUES ('T374REC' + CAST(@d AS varchar(1)), @edn, 374);
    SET @d = @d + 1;
END
DROP TABLE #m;

INSERT INTO SigTtCcd (cidchaves, empdopncs, empdopnums, obsd, dopcps, hists)
VALUES ('T374CCD1', '001' + CAST('CONTAS A PAGAR' AS char(20)) + STR(374001, 6), '',
        'Contrato de locacao 2026 - teste Erro374', '', 'Aluguel mensal da loja 001');

SELECT titulos, numcs, tipos, opers, valors, CONVERT(char(10), vencs, 103) venc,
       grupos, contas, sgrupos, scontas
  FROM SigMvCcr WHERE cidchaves LIKE 'T374%' ORDER BY cidchaves;

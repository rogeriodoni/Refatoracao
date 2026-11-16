-- =============================================================================
-- Erro365 (imagem erro365.png) - Dados de TESTE para Visualizar/Imprimir NF
--           (Formsigregnf -> sigregnfBO -> utils\sigprnfs.prg -> utils\sigprnfx.prg)
-- 1) SigCnFNf serie 1 / empresa 001 existia mas VAZIA (impressora em branco e todas
--    as posicoes zero): ate o legado recusaria ("Nome da Impressora de Nota Fiscal
--    Invalido"). Preenche um layout de teste legivel (linha x coluna de caractere,
--    Courier New 9, papel A4) com a impressora "Microsoft Print to PDF".
--    A impressora tem de existir no Windows de quem testa (o legado valida ate no
--    preview). Os valores ORIGINAIS estao em erro365_limpar_teste.sql.
-- 2) NFs de teste 000032..000034 (Erro364): o cliente C000277 nao tem endereco/UF e o
--    legado cancela a emissao ("O Endereco P/Nota Fiscal esta em branco"). Aponta SO
--    estas 3 NFs de teste para C001000034 (ELIZETE CARVALHO, endereco completo).
-- =============================================================================
SET NOCOUNT ON;
UPDATE SigCnFNf SET
  imppads = 'Microsoft Print to PDF', ctamfolhas = 'Courier New/9/', tamanhos = 9,
  tamdesc = 30, tpcasas = 1, letras = 1,
  l1nf = 2,  c1nf = 76,   lnfsai = 3, cnfsai = 58,  lnfent = 3, cnfent = 66,
  lnatop = 6, cnatop = 2,  lcfop = 6, ccfop = 44,
  lnome = 9,  cnome = 2,   lcgc = 9,  ccgc = 52,   ldtemi = 9, cdtemi = 72,
  lender = 11, cender = 2, lbairr = 11, cbairr = 52, lcep = 11, ccep = 72,
  lmuni = 13, cmuni = 2,   lfone = 13, cfone = 34, lesta = 13, cesta = 52, liest = 13, ciest = 58,
  lfat1num = 16, cfat1num = 2,  lfat1val = 16, cfat1val = 12, lfat1vec = 16, cfat1vec = 24,
  lfat2num = 16, cfat2num = 40, lfat2val = 16, cfat2val = 50, lfat2vec = 16, cfat2vec = 62,
  lvalext = 18, cvalext = 2,
  linprod = 22, ccodpro = 2, cdespro = 9, cclfis = 40, cstrib = 43, cunid = 47, cqtde = 50,
  cvluni = 57, cvltot = 69, caicm = 0, caipi = 0, cvipi = 0,
  lbicm = 45, cbicm = 2,  lticm = 45, cticm = 20, ltprod = 45, ctprod = 66,
  lfrete = 47, cfrete = 2, lseguro = 47, cseguro = 20, loutras = 47, coutras = 38,
  ltipi = 47, ctipi = 52, ltnota = 47, ctnota = 66,
  ltrnome = 50, ctrnome = 2, lqtvol = 53, cqtvol = 2, lpbru = 53, cpbru = 40, lpliq = 53, cpliq = 62,
  lobs = 56, cobs = 2, tamlinobs = 4, tamcolobs = 80, tamlinobsi = 1, tamcolobsi = 60,
  l2nf = 64, c2nf = 76
WHERE series = '1' AND emps = '001';

UPDATE SigMvCab SET contads = 'C001000034' WHERE cidchaves LIKE 'T364%';
UPDATE SigMvNfi SET clifors = 'C001000034' WHERE cidchaves LIKE 'T364%';

SELECT series, emps, imppads, ctamfolhas, l1nf, c1nf, linprod, ltnota, ctnota FROM SigCnFNf WHERE series = '1' AND emps = '001';
SELECT n.nfis, n.clifors, c.contads FROM SigMvNfi n JOIN SigMvCab c ON c.empdopnums = n.empdopnums WHERE n.cidchaves LIKE 'T364%';

-- 3) Itens das NFs de teste (o Erro364 clonou cabecalho/NF/parcelas, nao os itens):
--    clona o item real da venda 32 (SigMvItn + SigMvIts) para as vendas 9364..9366
DELETE FROM SigMvIts WHERE cidchaves LIKE 'T365%';
DELETE FROM SigMvItn WHERE cidchaves LIKE 'T365%';
DECLARE @k int = 1;
WHILE @k <= 3
BEGIN
    DECLARE @edn char(29) = '001' + LEFT('VENDA' + SPACE(20), 20) + RIGHT(SPACE(6) + CAST(9363 + @k AS varchar(6)), 6);
    SELECT * INTO #itn FROM SigMvItn WHERE empdopnums = '001VENDA                   32';
    UPDATE #itn SET empdopnums = @edn, numes = 9363 + @k, cidchaves = 'T365ITN' + RIGHT('0000000000000' + CAST(@k AS varchar(13)), 13);
    INSERT INTO SigMvItn SELECT * FROM #itn; DROP TABLE #itn;
    SELECT * INTO #its FROM SigMvIts WHERE empdopnums = '001VENDA                   32';
    UPDATE #its SET empdopnums = @edn, numes = 9363 + @k, cidchaves = 'T365ITS' + RIGHT('0000000000000' + CAST(@k AS varchar(13)), 13);
    INSERT INTO SigMvIts SELECT * FROM #its; DROP TABLE #its;
    SET @k = @k + 1;
END
SELECT empdopnums, cpros, dpros, qtds, units FROM SigMvItn WHERE cidchaves LIKE 'T365%';
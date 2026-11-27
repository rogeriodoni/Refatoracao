-- =============================================================================
-- Erro395 - Dados de TESTE para o LOOKUP de Empresa / Conta / Empresa Convenio
--           da tela "Geracao de Arquivos CNAB - Pagamentos"
--           (FormSIGPGCNB / SIGPGCNBBO)
--
-- DEFEITO QUE ESTES DADOS SERVEM PARA EXERCITAR:
--   "ao selecionar a empresa nao sai do foco e sempre abrindo a lista"
--   1) TxtCdEmpresaKeyPress abria o picker em ENTER(13) e TAB(9) - as proprias
--      teclas usadas para SAIR do campo (115 nao eh F4, eh a letra "s"; F4 = -3)
--   2) AbrirLookup* chamava Show() sem a guarda this_lAchouRegistro (regra #37),
--      entao o dialogo subia mesmo com o match exato ja resolvido
--   3) sem guarda de reentrancia: o picker eh MODAL e redispara o LostFocus
--
-- O QUE JA EXISTE (medido em 26/11/2026) - nao precisa criar:
--   SigMvCcr ... 175 lancamentos atendem o filtro da tela
--                (pagos=1, ContaPgs<>2, opers='C', Nopers<>0, emps='001')
--   SigCdGcr ... 44 grupos, a grade da tela enche normalmente
--   SigCdCeb ... 1 convenio BRADESCO criado por erro393_dados_teste.sql
--                (cidchaves ZZTCEB00000000000001, par 21101/F000000029)
--
-- A LACUNA: as tabelas dos tres lookups tem UMA LINHA SO.
--
--   SigCdEmp .... 1 empresa ('001' MARCELLA BAHIA / MB 01 JOIAS LTDA)
--   SigCdCeb .... 1 convenio (o do erro393)
--
--   Com uma linha so NAO DA PARA TESTAR o conserto: nao se distingue
--   "o codigo resolveu sozinho e o picker nao abriu" (comportamento CERTO)
--   de "o picker abriu com a unica linha que existe" (o BUG), porque os dois
--   mostram a mesma empresa. E o fallback show-all do FormBuscaAuxiliar
--   devolve sempre a mesma linha, entao a lista nunca parece uma lista.
--
-- O QUE ESTE SCRIPT CRIA:
--   SigCdEmp +3 empresas  -> Z01, Z02, Z90   (clone de '001', ativas = 1)
--   SigCdCeb +2 convenios -> ZZTC95...0002 (Banco do Brasil 001)
--                            ZZTC95...0003 (Itau 341)
--
--   Os codigos foram escolhidos para cobrir as TRES situacoes do lookup:
--     'Z01'  -> match EXATO           -> NAO pode abrir dialogo nenhum
--     'Z0'   -> prefixo com 2 hits    -> abre a lista com Z01 e Z02
--     '999'  -> nenhum hit            -> fallback show-all, lista com as 4
--   Z90 existe justamente para NAO entrar no prefixo 'Z0' - sem ele a busca
--   parcial e o show-all devolveriam o mesmo conjunto e o teste nao separaria
--   um caso do outro.
--
--   Os pares grupos+contas dos convenios sao REAIS (tem movimento em SigMvCcr):
--     TRANSITO  /TRANS REC  -> 37 lancamentos
--     41102     /4110240101 -> 17 lancamentos
--   GruContas eh chave POSICIONAL char(20) = grupos char(10) + contas char(10);
--   o form monta "Grupos + contas IN (SELECT GruContas ...)". Par inventado
--   faria o convenio nunca casar com lancamento nenhum.
--
-- SEGURANCA:
--   SigCdEmp tem 202 colunas (188 NOT NULL) e NENHUMA coluna IDENTITY ou
--   computada, PK = cemps apenas, e ZERO foreign keys apontando para ela
--   (medido). Por isso o INSERT eh feito CLONANDO a linha '001' por tabela
--   temporaria, em vez de listar 202 colunas na mao (regra #22).
--
--   A empresa de login NAO muda: main.prg:CarregarEmpresa le o codigo de
--   SigMvCcr, nao de SigCdEmp. As empresas de teste nao tem movimento, entao
--   nao aparecem em lugar nenhum alem dos pickers.
--
-- Marcadores (para limpeza):
--   SigCdEmp.cemps IN ('Z01','Z02','Z90') AND razsocs LIKE 'ZZ TESTE%'
--   SigCdCeb.cidchaves LIKE 'ZZTC95%'
-- Idempotente. Limpeza: erro395_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;

-- ---------------------------------------------------------------------------
-- 1) SigCdEmp - 3 empresas de teste, clonadas de '001'
-- ---------------------------------------------------------------------------
DELETE FROM SigCdEmp WHERE cemps IN ('Z01','Z02','Z90') AND razsocs LIKE 'ZZ TESTE%';

IF OBJECT_ID('tempdb..#emp_base') IS NOT NULL DROP TABLE #emp_base;
SELECT * INTO #emp_base FROM SigCdEmp WHERE cemps = '001';

IF (SELECT COUNT(*) FROM #emp_base) <> 1
BEGIN
    RAISERROR('SigCdEmp nao tem a empresa 001 para clonar - abortado.', 16, 1);
    RETURN;
END

-- Z01 - entra no prefixo 'Z0'
UPDATE #emp_base SET cemps = 'Z01',
                     codemps = 901, nemps = 901,
                     razas   = 'ZZ TESTE ALFA',
                     razsocs = 'ZZ TESTE EMPRESA ALFA LTDA',
                     cgcs    = '11.111.111/0001-11',
                     ativas  = 1;
INSERT INTO SigCdEmp SELECT * FROM #emp_base;

-- Z02 - entra no prefixo 'Z0'
UPDATE #emp_base SET cemps = 'Z02',
                     codemps = 902, nemps = 902,
                     razas   = 'ZZ TESTE BETA',
                     razsocs = 'ZZ TESTE EMPRESA BETA LTDA',
                     cgcs    = '22.222.222/0001-22',
                     ativas  = 1;
INSERT INTO SigCdEmp SELECT * FROM #emp_base;

-- Z90 - FICA DE FORA do prefixo 'Z0' de proposito
UPDATE #emp_base SET cemps = 'Z90',
                     codemps = 990, nemps = 990,
                     razas   = 'ZZ TESTE GAMA',
                     razsocs = 'ZZ TESTE EMPRESA GAMA LTDA',
                     cgcs    = '33.333.333/0001-33',
                     ativas  = 1;
INSERT INTO SigCdEmp SELECT * FROM #emp_base;

DROP TABLE #emp_base;

-- ---------------------------------------------------------------------------
-- 2) SigCdCeb - 2 convenios de teste, clonados do convenio do erro393
--    (marcador proprio ZZTC95 para nao colidir com a limpeza do erro393)
-- ---------------------------------------------------------------------------
DELETE FROM SigCdCeb WHERE cidchaves LIKE 'ZZTC95%';

IF EXISTS (SELECT 1 FROM SigCdCeb WHERE cidchaves = 'ZZTCEB00000000000001')
BEGIN
    IF OBJECT_ID('tempdb..#ceb_base') IS NOT NULL DROP TABLE #ceb_base;
    SELECT * INTO #ceb_base FROM SigCdCeb WHERE cidchaves = 'ZZTCEB00000000000001';

    -- Banco do Brasil (nbancos 001) sobre TRANSITO / TRANS REC
    UPDATE #ceb_base SET cidchaves = 'ZZTC9500000000000002',
                         grucontas = 'TRANSITO  TRANS REC ',
                         grupos    = 'TRANSITO  ',
                         iclis     = 'TRANS REC ',
                         nbancos   = '001',
                         bancos    = 'BANCO DO BRASIL TESTE 4C',
                         nomes     = 'CONV TESTE BB',
                         arqcnabs  = 'PGTOBB.REM',
                         bcoprincs = 0;
    INSERT INTO SigCdCeb SELECT * FROM #ceb_base;

    -- Itau (nbancos 341) sobre 41102 / 4110240101
    UPDATE #ceb_base SET cidchaves = 'ZZTC9500000000000003',
                         grucontas = '41102     4110240101',
                         grupos    = '41102     ',
                         iclis     = '4110240101',
                         nbancos   = '341',
                         bancos    = 'ITAU TESTE 4C',
                         nomes     = 'CONV TESTE ITAU',
                         arqcnabs  = 'PGTOITAU.REM',
                         bcoprincs = 0;
    INSERT INTO SigCdCeb SELECT * FROM #ceb_base;

    DROP TABLE #ceb_base;
END
ELSE
BEGIN
    PRINT 'AVISO: convenio base do erro393 ausente - rode erro393_dados_teste.sql';
    PRINT '       antes deste script se quiser testar tambem o lookup de Conta.';
END

-- ---------- conferencia -----------------------------------------------------
PRINT '--- SigCdEmp (universo do lookup de Empresa e de Empresa Convenio) ---';
SELECT '['+cemps+']' AS Cemps, RTRIM(razsocs) AS RazSocs, RTRIM(cgcs) AS Cgcs, ativas
  FROM SigCdEmp ORDER BY cemps;

PRINT '--- SigCdCeb (universo do lookup de Conta Bancaria) ---';
SELECT cidchaves, '['+grucontas+']' AS GruContas, nbancos, RTRIM(bancos) AS Banco
  FROM SigCdCeb ORDER BY cidchaves;

PRINT '--- o que cada digitacao no campo Empresa deve produzir ---';
SELECT 'Z01 (exato)'   AS digitar, COUNT(*) AS hits_exatos FROM SigCdEmp WHERE cemps = 'Z01'
UNION ALL
SELECT '001 (exato)',  COUNT(*) FROM SigCdEmp WHERE cemps = '001'
UNION ALL
SELECT 'Z0  (prefixo)',COUNT(*) FROM SigCdEmp WHERE cemps LIKE 'Z0%'
UNION ALL
SELECT '999 (nenhum)', COUNT(*) FROM SigCdEmp WHERE cemps = '999';

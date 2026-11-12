/*==============================================================================
  Erro340 - Posicao de Etiquetas (Formsigreeqe)
  Script de PREPARACAO DE AMBIENTE DE TESTE.  NAO EXECUTADO automaticamente.

  O codigo migrado esta FIEL ao legado: a mensagem "Empresa com Tabela de
  Desconto Padrao Nao Informada !!!" aparece porque faltam DADOS de
  configuracao. O legado (SIGREEQE.SCX, btnReport.Click) mostra a mesma caixa.

  Dois bloqueios, nesta ordem:
    (1) SigOpTde nao tem linha para a empresa 001 com Padraos = 1
        -> produz a mensagem da imagem erro340.PNG
    (2) SigCdPam.ContaEsts = '1121017307' nao casa com nenhuma conta dos
        dados de etiqueta/estoque da empresa 001 (que usam '1121001')
        -> mesmo vencendo (1), o relatorio sai com ZERO linhas

  Medido em 2026-11-11 contra 192.168.200.10 / DB_MBAHIA.
==============================================================================*/

USE DB_MBAHIA;
GO

/*------------------------------------------------------------------------------
  BLOCO 1 - tabela de desconto padrao da empresa 001
  Usa a unica tabela cadastrada em SigOpTdz ('FEITIO VD').
------------------------------------------------------------------------------*/
IF NOT EXISTS (SELECT 1 FROM SigOpTde WHERE RTRIM(emps) = '001' AND padraos = 1)
BEGIN
    INSERT INTO SigOpTde (dtterms, emps, codtabds, regioes, niveis, descregs, padraos, cidchaves)
    VALUES (NULL, '001', 'FEITIO VD', '', 0, '', 1, 'ERRO340TESTE00000001');

    PRINT 'BLOCO 1: linha de SigOpTde criada para a empresa 001 (codtabds = FEITIO VD).';
END
ELSE
    PRINT 'BLOCO 1: ja existe tabela de desconto padrao para a empresa 001 - nada feito.';
GO

/*------------------------------------------------------------------------------
  BLOCO 2 - conta de estoque padrao do sistema

  ATENCAO: SigCdPam.ContaEsts eh parametro GLOBAL do sistema; o relatorio
  so o LE (igual ao legado: lcEstoque = CrSigCdPam.ContaEsts). Alterar aqui
  afeta QUALQUER outra tela que use a conta de estoque padrao.

  Preferir fazer essa troca pela TELA de Parametros do Sistema, nao por UPDATE.
  O UPDATE abaixo esta COMENTADO de proposito - descomentar so apos decidir.

  Valor atual : 1121017307   (sem nenhum movimento/etiqueta na base)
  Valor dos dados: 1121001   (SigOpEtq.Contas e SigMvEst.Estos da empresa 001)
------------------------------------------------------------------------------*/
-- SELECT GrupoEsts, ContaEsts FROM SigCdPam;   -- conferir antes
--
-- UPDATE SigCdPam SET ContaEsts = '1121001';
--
-- PRINT 'BLOCO 2: ContaEsts alterada para 1121001.';
GO

/*------------------------------------------------------------------------------
  CONFERENCIA - deve devolver 279 linhas apos os dois blocos
------------------------------------------------------------------------------*/
SELECT COUNT(*) AS linhas_previstas
FROM (
    SELECT eq.CPros
      FROM SigOpEtq eq, SigCdPro b, SigCdUni c
     WHERE eq.EmpOs = '001'
       AND eq.Grupos = (SELECT RTRIM(GrupoEsts) FROM SigCdPam)
       AND eq.Contas = (SELECT RTRIM(ContaEsts) FROM SigCdPam)
       AND b.CPros = eq.CPros AND b.cUnis = c.cunis AND c.Etiqs = 'S'
    UNION ALL
    SELECT a.CPros
      FROM SigMvEst a, SigCdPro b, SigCdUni c
     WHERE a.Emps = '001'
       AND a.Grupos = (SELECT RTRIM(GrupoEsts) FROM SigCdPam)
       AND a.Estos  = (SELECT RTRIM(ContaEsts) FROM SigCdPam)
       AND a.CPros = b.CPros AND b.cUnis = c.cunis AND c.Etiqs <> 'S'
) t;
GO

/*==============================================================================
  DESFAZER (rollback do BLOCO 1)
    DELETE FROM SigOpTde WHERE cidchaves = 'ERRO340TESTE00000001';
==============================================================================*/

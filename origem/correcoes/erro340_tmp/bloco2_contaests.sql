/*==============================================================================
  Erro340 - BLOCO 2: conta de estoque padrao do sistema
  Ultimo passo para o relatorio "Posicao de Etiquetas" sair COM DADOS.

  Hoje    : SigCdPam.ContaEsts = '1121017307'  -> 0 etiquetas, relatorio vazio
  Depois  : SigCdPam.ContaEsts = '1121001'     -> 246 linhas (medido)

  ATENCAO: ContaEsts eh parametro GLOBAL; outras telas que usam a conta de
  estoque padrao passam a ver '1121001'. O valor novo eh a conta que REALMENTE
  tem as 245 etiquetas da empresa 001 (SigOpEtq) - nao eh um valor inventado.
==============================================================================*/
USE DB_MBAHIA;
GO

SELECT GrupoEsts AS grupo_antes, ContaEsts AS conta_antes FROM SigCdPam;
GO

UPDATE SigCdPam
   SET ContaEsts = '1121001'
 WHERE RTRIM(ContaEsts) = '1121017307';
GO

SELECT GrupoEsts AS grupo_depois, ContaEsts AS conta_depois FROM SigCdPam;
GO

/*------------------------------------------------------------------------------
  DESFAZER
    UPDATE SigCdPam SET ContaEsts = '1121017307' WHERE RTRIM(ContaEsts) = '1121001';
------------------------------------------------------------------------------*/

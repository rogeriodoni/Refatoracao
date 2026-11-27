-- =============================================================================
-- Erro387 - Dados de TESTE para "Tipos de Etiquetas de Produto"
--           (FormTpe / TpeBO -> tabela SigCdTpe)
--
-- LACUNA ENCONTRADA (medida em 25/11/2026):
--   SigCdTpe tem 2 linhas (ntipos 518 e 529) e, nas DUAS, TODO campo opcional
--   esta zerado/em branco:
--       cordems = '   '   tpespes = 0   codobs = 0   npadrao = 0   nsituas = 1
--   Ou seja: nao da para testar Ordem, Etiquetas Especiais, Observacao, nem a
--   opcao "Inativa" do grupo Situacao - a tela sempre abre com tudo vazio.
--
-- O QUE ESTE SCRIPT CRIA (3 linhas, ntipos 901..903):
--   901  ETIQUETA TESTE ORDEM    Ativa    Ordem='A1'  esp=NENHUMA       obs=0
--   902  ETIQUETA TESTE TAG      Ativa    Ordem='B2'  esp=TAG MODELO 1  obs=11 (SEDEX 10)
--   903  ETIQUETA TESTE INATIVA  Inativa  Ordem='C3'  esp=TAG MODELO 1  obs=1  (MENSAGEM SIMPLES)
--
-- DOMINIOS (conferidos no dump do legado e no banco):
--   nsituas  numeric(1,0) : OptionGroup Opt_nSituas 1-based -> 1=Ativa 2=Inativa
--   tpespes  numeric(3,0) : ComboBox RowSourceType=1 "NENHUMA,TAG MODELO 1"
--                           -> grava o INDICE 1-based: 1=NENHUMA 2=TAG MODELO 1
--                           (o legado faz ListItemId=1 quando o valor esta vazio)
--   codobs   numeric(3,0) : FK para SigCdObs.codigos - 1 e 11 EXISTEM no banco
--   cordems  char(3)      : as 3 posicoes sao significativas, gravar com PADR
--   Todas as 7 colunas de SigCdTpe sao NOT NULL (regra #22) - o INSERT cobre todas.
--
-- COMO TESTAR DEPOIS DE RODAR:
--   Visualizar 902 -> Ordem 'B2', Etiquetas Especiais = "TAG MODELO 1",
--                     Observacao = 11 / "SEDEX 10"
--   Visualizar 903 -> grupo Situacao marcando "Inativa"
--
-- Marcador (para limpeza): SigCdTpe.ntipos BETWEEN 901 AND 903
-- Idempotente. Limpeza: erro387_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;

DELETE FROM SigCdTpe WHERE ntipos BETWEEN 901 AND 903;

INSERT INTO SigCdTpe (ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao) VALUES
    (901, 'ETIQUETA TESTE ORDEM',   1, 'A1 ', 1,  0, 0),
    (902, 'ETIQUETA TESTE TAG',     1, 'B2 ', 2, 11, 0),
    (903, 'ETIQUETA TESTE INATIVA', 2, 'C3 ', 2,  1, 0);

SELECT ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao
  FROM SigCdTpe
 ORDER BY ntipos;

-- =============================================================================
-- Erro367 (imagem erro367.png) - Dados de TESTE para "Historico de Envelopes"
--           (FormSigReHev / SigReHevBO / SigReHev.frx)
-- O relatorio percorre as operacoes de envelope de SigCdOpe (Servicos ou Globalizas
-- = 1/2) e, para cada DigEnves, procura o envelope em SigPdMvf. NENHUMA operacao
-- tinha esses flags -> o relatorio nunca encontrava nada.
-- Cria a operacao 'T367 ENVELOPE' (clone da VENDA) com Servicos = 1, DigEnves = 0:
-- com digito 0 o numero procurado eh o proprio envelope digitado.
-- Os movimentos de envelope JA existem (cidchaves TST323MVF*, de um teste anterior):
--   envelope 900001 -> 2 movimentos | envelope 900002 -> 1 movimento
-- Idempotente. Limpeza: erro367_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCdOpe WHERE dopes = 'T367 ENVELOPE';
SELECT * INTO #ope FROM SigCdOpe WHERE dopes = 'VENDA';
UPDATE #ope SET dopes = 'T367 ENVELOPE', servicos = 1, globalizas = 0, digenves = 0;
INSERT INTO SigCdOpe SELECT * FROM #ope;
SELECT dopes, digenves, servicos, globalizas FROM SigCdOpe WHERE dopes = 'T367 ENVELOPE';
SELECT nenvs, datas, emps, dopps, numps, contaos, contads, pesos, qtds FROM SigPdMvf ORDER BY nenvs, cidchaves;
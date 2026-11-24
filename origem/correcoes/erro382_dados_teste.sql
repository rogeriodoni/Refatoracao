-- =============================================================================
-- Erro382 - Dados de TESTE para o "Relatorio de Inventario" (inventario n 3)
--           (Formsigreinr / sigreinrBO)
--
-- LACUNA ENCONTRADA (medida em 18/11/2026):
--   SIGBAOCO .............. 0 linhas em TODA a tabela
--   SIGIVTRH (historicos) . 0 linhas para o inventario 3 (so 1 linha, do inv. 2)
--   SIGIVTRT (tratamentos)  0 linhas
--
-- CONSEQUENCIA na tela:
--   * A grade "Ocorrencias" (lado direito, tipo 4) sai SEMPRE VAZIA, porque ela
--     vem de  Select Codigos,Descrs From SigBaOco Where Tipos = 'O'.
--     Sem linha nenhuma o usuario nao tem o que marcar e o relatorio de
--     Ocorrencias nunca devolve dados - o join e
--         CsHistorico a, CsOperacaos b  ON "O"+a.Ocors = "O"+b.Codigos
--                                       AND b.Marcas = 1
--   * O tipo 2 (Analitico) le SigIvTrH filtrando por CPros = <produto digitado>;
--     sem historico no inventario 3 nao ha o que exibir.
--
-- O QUE ESTE SCRIPT CRIA:
--   SigBaOco: 3 tipos de ocorrencia (Tipos='O') -> codigos 91, 92, 93
--   SigIvTrH: 6 historicos no inventario 3 (Emps='001'), usando pares
--             (cpros, cbars) REAIS que ja existem em SigIvTrB do inventario 3:
--               036/5797  1116/5819  1156/5886  1194/8109  1334/5894  1363/5800
--             Tipos = 1 (Leitura) em 5 linhas e 3 (Releitura) em 1, para que o
--             Analitico ache algo tanto em "Leitura" quanto na 2a passagem.
--
-- COMO TESTAR DEPOIS DE RODAR:
--   Ocorrencias : Relatorio = "Ocorrencia", marcar 91/92/93 na grade da direita
--   Analitico   : Relatorio = "Analitico", Tipo = "Produto", Produto = 1116
--
-- Marcadores (para limpeza): SigIvTrH.cidchaves LIKE 'T382%'
--                            SigBaOco.codigos IN ('91','92','93')
-- Idempotente. Limpeza: erro382_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;

DELETE FROM SigIvTrH WHERE cidchaves LIKE 'T382%';
DELETE FROM SigBaOco WHERE codigos IN ('91', '92', '93');

-- SigBaOco: todas as 9 colunas sao NOT NULL
INSERT INTO SigBaOco (codigos, descrs, apuras, grupos, opers, tipos, autos, operacaos, lancas) VALUES
 ('91', 'FALTA NA PRATELEIRA',  'S', '', '', 'O', 'N', '', 'N'),
 ('92', 'ETIQUETA DANIFICADA',  'S', '', '', 'O', 'N', '', 'N'),
 ('93', 'PRODUTO AVARIADO',     'S', '', '', 'O', 'N', '', 'N');

-- SigIvTrH: 18 colunas NOT NULL (datas/datatrans/obs aceitam nulo)
INSERT INTO SigIvTrH
 (emps, codigos, ntrans, cpros, cbars, codcors, codtams, contas,
  locals, localis, ocors, tipos, qtds, pesos, pesreals, datas, usuars, coletas,
  obs, cidchaves) VALUES
 ('001', 3, 0, '036',  5797, '', '', '', 'LOJA01', 'LOJA01', '91', 1, 1, 0, 0, '20261023', '4control', '', 'Item nao localizado na prateleira',  'T382HIST0000000001'),
 ('001', 3, 0, '1116', 5819, '', '', '', 'LOJA01', 'LOJA01', '92', 1, 2, 0, 0, '20261023', '4control', '', 'Etiqueta ilegivel - relida manualmente', 'T382HIST0000000002'),
 ('001', 3, 0, '1156', 5886, '', '', '', 'LOJA01', 'LOJA01', '93', 1, 1, 0, 0, '20261023', '4control', '', 'Peca com risco na superficie',       'T382HIST0000000003'),
 ('001', 3, 0, '1194', 8109, '', '', '', 'LOJA02', 'LOJA02', '91', 1, 1, 0, 0, '20261023', '4control', '', 'Nao encontrado no local informado',  'T382HIST0000000004'),
 ('001', 3, 0, '1334', 5894, '', '', '', 'LOJA02', 'LOJA02', '92', 1, 2, 0, 0, '20261023', '4control', '', 'Codigo de barras rasurado',          'T382HIST0000000005'),
 ('001', 3, 0, '1363', 5800, '', '', '', 'LOJA02', 'LOJA02', '93', 3, 2, 0, 0, '20261023', '4control', '', 'Reconferido na releitura',           'T382HIST0000000006');

-- ---------------------------------------------------------------- conferencia
SELECT 'SigBaOco' tabela, codigos, descrs, tipos
  FROM SigBaOco WHERE codigos IN ('91','92','93');

SELECT 'SigIvTrH' tabela, h.emps, h.codigos, h.cpros, h.cbars, h.ocors, o.descrs,
       h.tipos, h.qtds, h.localis, CONVERT(char(10), h.datas, 103) datas
  FROM SigIvTrH h
  LEFT JOIN SigBaOco o ON o.codigos = h.ocors
 WHERE h.cidchaves LIKE 'T382%'
 ORDER BY h.cidchaves;

-- o par (cpros, cbars) tem de existir em SigIvTrB do inventario 3
SELECT 'confere x SigIvTrB' conferencia, h.cpros, h.cbars,
       CASE WHEN b.cpros IS NULL THEN 'NAO EXISTE EM SigIvTrB' ELSE 'OK' END situacao
  FROM SigIvTrH h
  LEFT JOIN SigIvTrB b ON b.emps = h.emps AND b.codigos = h.codigos
                      AND b.cpros = h.cpros AND b.cbars = h.cbars
 WHERE h.cidchaves LIKE 'T382%'
 ORDER BY h.cpros;

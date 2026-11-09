-- =============================================================================
-- Erro338 (imagem erro337.png) - Dados de TESTE para "Demonstrativo"
--           (Formsigredtv / sigredtvBO / SigReDt1..4.frx)
-- O unico item de SigCdMrr ('999', Mapas = 2) eh MAPA DE CONTAS: o legado
-- carrega o cursor com "Where Not Mapas = 2" na tela Demonstrativo, entao
-- '999' nao eh aceito ali. E SigCdMri (linhas do demonstrativo) estava VAZIA:
-- o SQL principal faz INNER JOIN SigCdMri, sem linha nenhum movimento entra.
-- Cria o demonstrativo 'TESTE DRE' (Mapas = 1) com linhas sobre grupos que
-- JA tem movimento real em SigMvCcr (41102, 30101, 11101).
--   TpRegs 1 = Grupo | 2 = SubTotal (Grupos = 'SubTotal', Fator 100) | 3 = Classe
-- Marcador: SigCdMri.cidchaves LIKE 'T338%' ; SigCdMrr.Balancos = 'TESTE DRE'
-- Idempotente. Limpeza: erro338_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCdMri WHERE cidchaves LIKE 'T338%';
DELETE FROM SigCdMrr WHERE balancos = 'TESTE DRE';

INSERT INTO SigCdMrr (balancos, titulos, mapas)
VALUES ('TESTE DRE', 'DEMONSTRATIVO DE RESULTADO', 1);

INSERT INTO SigCdMri (balancos, ordems, tpregs, classes, nivels, grupos, descgrps,
    operacaos, analiticos, cpartidas, fators, titulos, subtot100s, tpdatas, cidchaves)
VALUES
 ('TESTE DRE', 10, 1, '411', 3, '41102',    'RECEITAS OPERACIONAIS', '+', 1, 2, 100, '', 2, 2, 'T338MRI0000000000001'),
 ('TESTE DRE', 20, 1, '301', 3, '30101',    'CUSTOS MERCADORIAS',    '+', 1, 1, 100, '', 2, 2, 'T338MRI0000000000002'),
 ('TESTE DRE', 30, 2, '',    0, 'SubTotal', 'RESULTADO BRUTO',       '+', 2, 2, 100, '', 2, 2, 'T338MRI0000000000003'),
 ('TESTE DRE', 40, 1, '111', 3, '11101',    'CAIXAS',                '+', 2, 2, 100, '', 2, 2, 'T338MRI0000000000004'),
 ('TESTE DRE', 50, 2, '',    0, 'SubTotal', 'TOTAL GERAL',           '+', 2, 2, 100, '', 2, 2, 'T338MRI0000000000005');

SELECT r.balancos, r.titulos, r.mapas, i.ordems, i.tpregs, i.grupos, i.descgrps, i.analiticos, i.cpartidas
  FROM SigCdMrr r JOIN SigCdMri i ON i.balancos = r.balancos
 WHERE r.balancos = 'TESTE DRE' ORDER BY i.ordems;

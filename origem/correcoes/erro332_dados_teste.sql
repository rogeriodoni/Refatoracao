-- =============================================================================
-- Erro332 - Dados de TESTE para "Demonstrativo de Balanco"
--           (FormSigReDdp / SigReDdpBO / SigReDdp.frx)
-- SigPrDmo = demonstrativo (conta do saldo inicial)
-- SigCdDpr = linhas (E entrada / S saida / P pesagem / T total / H fases)
-- SigCdFcx = fechamentos por conta | SigOpCfe = saldo/pesagem do fechamento
-- SigCdFes = entradas/saidas do fechamento por tipo de operacao
-- Todas estavam VAZIAS. Produto EM BRANCO de proposito (ver abaixo).
-- ATENCAO: SigCdPam.Ouros (produto 'ouro' da apuracao) esta EM BRANCO neste
-- banco. O relatorio (legado e migrado) so considera movimento com CPros = Ouros,
-- entao os movimentos de teste usam CPros vazio (o FRX nao exibe o produto).
-- Em producao: configurar SigCdPam.Ouros. NAO alteramos SigCdPam aqui.
-- Marcadores: cidchaves LIKE 'T332%' ; codigos 933101..933104 ;
--             demonstrativo 'BALANCO TESTE'
-- Idempotente. Limpeza: erro332_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigCdFes WHERE cidchaves LIKE 'T332%';
DELETE FROM SigOpCfe WHERE cidchaves LIKE 'T332%';
DELETE FROM SigCdFcx WHERE cidchaves LIKE 'T332%';
DELETE FROM SigCdDpr WHERE cidchaves LIKE 'T332%';
DELETE FROM SigPrDmo WHERE cidchaves LIKE 'T332%';

-- Demonstrativo: conta do Saldo Inicial = estoque 11210/1121001
INSERT INTO SigPrDmo (contas, grupos, nome, cidchaves)
VALUES ('1121001', '11210', 'BALANCO TESTE', 'T332DMO0000000000001');

-- Linhas do demonstrativo
INSERT INTO SigCdDpr (contas, grupos, nome, operas, ordems, tpops, cidchaves, dopes)
VALUES
 ('F000318',    '21101', 'BALANCO TESTE', 'E',  10, 'COMPRA METAL', 'T332DPR0000000000001', ''),
 ('C000001',    '11201', 'BALANCO TESTE', 'S',  20, 'VENDA',        'T332DPR0000000000002', ''),
 ('1110100001', '11101', 'BALANCO TESTE', 'P',  30, '',             'T332DPR0000000000003', ''),
 ('',           '',      'BALANCO TESTE', 'T',  40, '',             'T332DPR0000000000004', ''),
 ('',           '',      'BALANCO TESTE', 'T', 999, '',             'T332DPR0000000000005', '');

-- Fechamentos (um por conta, antes da data do relatorio)
INSERT INTO SigCdFcx (emps, codigos, grupos, contas, datais, datas, cpros, entradas, fadmins, freals, pesagems,
    saidas, saldos, usuars, cidchaves)
VALUES
 ('001', 933101, '11210', '1121001',    '2026-10-01', '2026-11-01', '', 0, 0, 0, 0,     0,    1500, 'TESTE', 'T332FCX0000000000001'),
 ('001', 933102, '21101', 'F000318',    '2026-10-01', '2026-11-05', '', 250, 0, 0, 0,   0,    0,    'TESTE', 'T332FCX0000000000002'),
 ('001', 933103, '11201', 'C000001',    '2026-10-01', '2026-11-06', '', 0, 0, 0, 0,     80.5, 0,    'TESTE', 'T332FCX0000000000003'),
 ('001', 933104, '11101', '1110100001', '2026-10-01', '2026-11-07', '', 0, 0, 0, 12.25, 0,    0,    'TESTE', 'T332FCX0000000000004');

-- Saldo (fechamento 933101) e Pesagem (fechamento 933104)
INSERT INTO SigOpCfe (codigos, cpros, entradas, fadmins, freals, pesagems, saidas, saldos, emps, cidchaves, indprods)
VALUES
 (933101, '', 0, 0, 0, 0,     0, 1500, '001', 'T332CFE0000000000001', 0),
 (933104, '', 0, 0, 0, 12.25, 0, 0,    '001', 'T332CFE0000000000002', 0);

-- Entrada (933102, COMPRA METAL) e Saida (933103, VENDA)
INSERT INTO SigCdFes (codigos, cpros, pesos, tpops, falhas, pfalhas, emps, pesoents, pesosais, cidchaves, pesobsais)
VALUES
 (933102, '', 250,  'COMPRA METAL', 0, 0, '001', 250, 0,    'T332FES0000000000001', 0),
 (933103, '', 80.5, 'VENDA',        0, 0, '001', 0,   80.5, 'T332FES0000000000002', 0);

COMMIT;

SELECT ordems, operas, grupos, contas, tpops FROM SigCdDpr WHERE cidchaves LIKE 'T332%' ORDER BY ordems;

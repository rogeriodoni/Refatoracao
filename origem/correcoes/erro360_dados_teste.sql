-- =============================================================================
-- Erro360 (imagem erro360.png) - Dados de TESTE para "Relacao tubos fundicao"
--           (FormSIGREFUN / SIGREFUNBO / sigrefun.frx)
-- SigCdFun e SigCdFud estavam VAZIAS. Cria 3 fundicoes (900001..900003):
--   - linhas de tubo com Nops = 0 e NNumes = 0 (as que o relatorio lista);
--     Ceras (no relatorio) = bCeras - Bases
--   - linhas com Nops > 0 (OS vinculadas): somadas em QtdOs por tubo
-- Cores existentes em SigCdCor: 001 OURO AMARELO, 002 PRATA
-- Marcador: cidchaves LIKE 'T360%'
-- Idempotente. Limpeza: erro360_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCdFud WHERE cidchaves LIKE 'T360%';
DELETE FROM SigCdFun WHERE cidchaves LIKE 'T360%';

INSERT INTO SigCdFun (codigos, codmaqfs, datars, datas, emps, horas, ntubos, obss, usuars, cidchaves) VALUES
 (900001, 'MAQ01', '2026-11-10', '2026-11-10', '001', '08:30:00', 3, 'FUNDICAO TESTE 1 - LOTE NOVEMBRO',  'TESTE', 'T360FUN0000000000001'),
 (900002, 'MAQ01', '2026-11-11', '2026-11-11', '001', '09:15:00', 2, 'FUNDICAO TESTE 2 - PRATA',          'TESTE', 'T360FUN0000000000002'),
 (900003, 'MAQ02', '2026-11-12', '2026-11-12', '001', '14:00:00', 2, 'FUNDICAO TESTE 3 - OURO E PRATA',   'TESTE', 'T360FUN0000000000003');

-- Tubos (Nops = 0, NNumes = 0)
INSERT INTO SigCdFud (codigos, tubos, nops, nnumes, codcors, bceras, bases, metals, metalnvs, qtds, qtdos,
                      tempmets, tempambs, temptubs, tempagus, codarvs, nstatus, obss, cidchaves) VALUES
 (900001, 1, 0, 0, '001', 152.40, 120.10,  480.50,  12.30, 25, 0, '1050', '24', '650', '22', 'ARV001', 1, 'TUBO 1 - ANEIS FEMININOS',   'T360FUD0000000000001'),
 (900001, 2, 0, 0, '001', 148.75, 118.60,  455.20,  10.80, 22, 0, '1050', '24', '650', '22', 'ARV002', 1, 'TUBO 2 - BRINCOS',           'T360FUD0000000000002'),
 (900001, 3, 0, 0, '002', 160.00, 121.00,  390.00,   8.00, 30, 0, '980',  '24', '600', '22', 'ARV003', 1, 'TUBO 3 - PINGENTES PRATA',   'T360FUD0000000000003'),
 (900002, 1, 0, 0, '002', 140.20, 115.00,  310.40,   6.10, 18, 0, '980',  '23', '600', '21', 'ARV004', 1, 'TUBO 1 - CORRENTES',         'T360FUD0000000000004'),
 (900002, 2, 0, 0, '002', 138.90, 114.30,  305.75,   5.95, 16, 0, '980',  '23', '600', '21', 'ARV005', 1, NULL,                         'T360FUD0000000000005'),
 (900003, 1, 0, 0, '001', 155.00, 119.50,  500.00,  15.00, 28, 0, '1060', '25', '660', '22', 'ARV006', 1, 'TUBO 1 - ALIANCAS',          'T360FUD0000000000006'),
 (900003, 2, 0, 0, '002', 149.30, 117.80,  340.10,   7.20, 20, 0, '985',  '25', '610', '22', 'ARV007', 1, 'TUBO 2 - MEDALHAS',          'T360FUD0000000000007');

-- OS vinculadas aos tubos (Nops > 0) -> QtdOs somado por tubo
INSERT INTO SigCdFud (codigos, tubos, nops, nnumes, codcors, bceras, bases, metals, metalnvs, qtds, qtdos,
                      tempmets, tempambs, temptubs, tempagus, codarvs, nstatus, obss, cidchaves) VALUES
 (900001, 1, 5001, 0, '001', 0, 0, 0, 0, 0, 10, '', '', '', '', '', 1, NULL, 'T360FUD0000000000101'),
 (900001, 1, 5002, 0, '001', 0, 0, 0, 0, 0, 12, '', '', '', '', '', 1, NULL, 'T360FUD0000000000102'),
 (900001, 2, 5003, 0, '001', 0, 0, 0, 0, 0, 20, '', '', '', '', '', 1, NULL, 'T360FUD0000000000103'),
 (900002, 1, 5004, 0, '002', 0, 0, 0, 0, 0, 15, '', '', '', '', '', 1, NULL, 'T360FUD0000000000104'),
 (900003, 1, 5005, 0, '001', 0, 0, 0, 0, 0,  8, '', '', '', '', '', 1, NULL, 'T360FUD0000000000105'),
 (900003, 1, 5006, 0, '001', 0, 0, 0, 0, 0, 17, '', '', '', '', '', 1, NULL, 'T360FUD0000000000106');

SELECT a.codigos, b.tubos, b.nops, b.codcors, b.bceras, b.bases, b.bceras - b.bases AS ceras, b.metals, b.qtdos
  FROM SigCdFun a JOIN SigCdFud b ON b.codigos = a.codigos
 WHERE a.cidchaves LIKE 'T360%' ORDER BY a.codigos, b.tubos, b.nops;
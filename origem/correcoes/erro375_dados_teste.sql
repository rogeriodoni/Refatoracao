-- =============================================================================
-- Erro375 (imagem erro375.png) - Dados de TESTE para "Relatorio de Falhas / Perdas"
--           (FormSigReIfp / SigReIfpBO / SigReIfA..SigReIfF.frx)
-- SigCdFea (lancamentos de falha/recuperacao) estava VAZIA -> nada a imprimir.
-- O relatorio so considera setores com SigCdGcr.BalFalPers = 1; hoje o unico eh
-- 11101 (CAIXAS), com as contas 1110100001..1110100015. Nao altera cadastros.
-- Lancamentos (empresa 001, novembro/2026):
--   F  producao geral (sem setor/conta)    Produzido 10.000 g
--   F  11101/1110100011 COFRE CHAMPA       Trab 5.000  Falha 120 g
--   F  11101/1110100012 COFRE EXATA        Trab 3.000  Falha  80 g
--   F  11101/1110100013 COFRE ADELU        Trab 2.000  Falha  50 g
--   P  11101/1110100011 recup. F000000029 LIMALHA OURO  Bruto 100 c/cob 70 s/cob 60
--   P  11101/(todas)    recup. F000000030 VARREDURA     Bruto  60 c/cob 30 s/cob 25
--   P  (todos setores)  recup. F000000029 LIMALHA OURO  Bruto  40 c/cob 20 s/cob 18
--   P  baixas = 0  (NAO entra: recuperacao nao baixada)
--   F  20/12/1999  (NAO entra: fora do periodo)
-- Tipo de Relatorio 1 (padrao da imagem), periodo 01/01/2000 a 16/11/2026:
--   Produzido 10.000 | Falha 250 | Recup c/Cobr 120 | Perda 130
--   Falha/Produzido 2,50% | Recup/Falha 48,00% | Perda/Produzido 1,30%
-- Tipo 7 aceita os filtros: Tipo Material LIMALHA OURO / Recuperadora F000000029 / Grupo 11101
-- Marcador: SigCdFea.cidchaves LIKE 'T375%'
-- Idempotente. Limpeza: erro375_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigCdFea WHERE cidchaves LIKE 'T375%';
INSERT INTO SigCdFea (baixas, brutos, contas, datas, emps, falhas, grupos, ifors, numes,
                      pesoccbs, pesoscbs, tipos, tpmats, trabs, cidchaves, produzidos, numbals)
SELECT v.bx, v.bruto, v.conta, v.dt, '001', v.falha, v.grupo, v.ifor, v.num,
       v.ccob, v.scob, v.tipo, v.tpmat, v.trab, 'T375FEA' + RIGHT('0' + CAST(v.num AS varchar(2)), 2), v.prod, 375
  FROM (VALUES
   ( 1, 0, 0,   '',          '20261103', 0,   '',      '',           0,  0,  'F', '',             0,    10000),
   ( 2, 0, 0,   '1110100011','20261104', 120, '11101', '',           0,  0,  'F', '',             5000, 0),
   ( 3, 0, 0,   '1110100012','20261105', 80,  '11101', '',           0,  0,  'F', '',             3000, 0),
   ( 4, 0, 0,   '1110100013','20261106', 50,  '11101', '',           0,  0,  'F', '',             2000, 0),
   ( 5, 1, 100, '1110100011','20261110', 0,   '11101', 'F000000029', 70, 60, 'P', 'LIMALHA OURO', 0,    0),
   ( 6, 1, 60,  '',          '20261111', 0,   '11101', 'F000000030', 30, 25, 'P', 'VARREDURA',    0,    0),
   ( 7, 1, 40,  '',          '20261112', 0,   '',      'F000000029', 20, 18, 'P', 'LIMALHA OURO', 0,    0),
   ( 8, 0, 500, '1110100011','20261113', 0,   '11101', 'F000000029', 400,350,'P', 'LIMALHA OURO', 0,    0),
   ( 9, 0, 0,   '1110100011','19991220', 999, '11101', '',           0,  0,  'F', '',             9999, 0)
  ) v(num, bx, bruto, conta, dt, falha, grupo, ifor, ccob, scob, tipo, tpmat, trab, prod);
SELECT cidchaves, tipos, baixas, CONVERT(char(10), datas, 103) data, grupos, contas, ifors, tpmats,
       produzidos, trabs, falhas, brutos, pesoccbs, pesoscbs
  FROM SigCdFea WHERE cidchaves LIKE 'T375%' ORDER BY cidchaves;

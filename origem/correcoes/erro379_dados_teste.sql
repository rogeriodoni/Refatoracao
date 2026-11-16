-- =============================================================================
-- Erro379 (imagem erro379.png) - Dados de TESTE para "Impressao de Nota Fiscal"
--           (FormSigReInf / SigReInfBO / utils\sigprnfs.prg + sigprnfx.prg)
-- A tela imprime UMA NF recebida da movimentacao (empresa/operacao/numero/serie).
-- Reaproveita os dados do Erro365 (ja no banco):
--   - SigCnFNf empresa 001 / serie 1 com layout de impressao (Courier New 9,
--     impressora "Microsoft Print to PDF" - tem de existir no Windows de quem testa)
--   - NFs 000032 / 000033 / 000034 (VENDA 9364 / 9365 / 9366), cliente
--     C001000034 ELIZETE CARVALHO com endereco completo
-- Este script so devolve as 3 NFs ao estado "nao impressa" (Impress = 0):
-- Imprimir grava SigMvNfi.Impress = Impress + 1, entao rode-o antes de cada teste.
-- Teste: AbrirFormSigReInf("001", "VENDA", 9364, "1")  -> NF 000032
-- =============================================================================
SET NOCOUNT ON;
UPDATE SigMvNfi SET impress = 0
 WHERE emps = '001' AND nfis IN ('000032', '000033', '000034') AND dopes = 'VENDA';
SELECT n.nfis, n.dopes, n.empdopnums, n.series, n.impress, n.cancelas, n.clifors, c.rclis,
       (SELECT COUNT(*) FROM SigMvItn i WHERE i.empdopnums = n.empdopnums) itens
  FROM SigMvNfi n LEFT JOIN SigCdCli c ON c.iclis = LEFT(n.clifors, 10)
 WHERE n.emps = '001' AND n.nfis IN ('000032', '000033', '000034') AND n.dopes = 'VENDA';
SELECT emps, series, imppads FROM SigCnFNf WHERE emps = '001' AND series = '1';

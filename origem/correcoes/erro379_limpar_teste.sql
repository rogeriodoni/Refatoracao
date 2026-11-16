-- Erro379: devolve as NFs de teste ao estado 'nao impressa'
SET NOCOUNT ON;
UPDATE SigMvNfi SET impress = 0 WHERE emps = '001' AND nfis IN ('000032', '000033', '000034') AND dopes = 'VENDA';

-- Erro372: remove os cheques de teste e seus itens de pagamento
SET NOCOUNT ON;
DELETE FROM SigCqChi WHERE cidchaves LIKE 'T372%';
DELETE FROM SigCdPit WHERE cidchaves LIKE 'T372%';

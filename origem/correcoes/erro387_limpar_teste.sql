-- Erro387: remove os tipos de etiqueta de teste (FormTpe / SigCdTpe)
SET NOCOUNT ON;
DELETE FROM SigCdTpe WHERE ntipos BETWEEN 901 AND 903;

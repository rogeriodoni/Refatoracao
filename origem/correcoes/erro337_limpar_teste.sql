-- Erro337: restaura o GerBals original gravado por erro337_dados_teste.sql
SET NOCOUNT ON;
IF OBJECT_ID('dbo._4c_Teste_Erro337') IS NOT NULL
BEGIN
    UPDATE g SET GerBals = t.GerBalsOrig FROM SigCdGcr g
      JOIN dbo._4c_Teste_Erro337 t ON t.Tabela = 'SigCdGcr' AND t.Chave = RTRIM(g.Codigos) COLLATE DATABASE_DEFAULT;
    UPDATE c SET GerBals = t.GerBalsOrig FROM SigCdCli c
      JOIN dbo._4c_Teste_Erro337 t ON t.Tabela = 'SigCdCli' AND t.Chave = RTRIM(c.IClis) COLLATE DATABASE_DEFAULT;
    DROP TABLE dbo._4c_Teste_Erro337;
END

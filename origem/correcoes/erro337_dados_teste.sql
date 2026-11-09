-- Erro337 (imagem erro336.png) - Analise de Producao (SigReDpD)
-- Lookups de Grupo/Conta filtram GerBals = 1 (fiel ao Init legado).
-- No DB_MBAHIA todo SigCdGcr tem GerBals = 2 e todo SigCdCli GerBals = 0,
-- entao os lookups ficam vazios. Marca GerBals = 1 SO nos grupos/contas
-- usados pelos dados de teste do erro323 (origem e destino).
-- Idempotente: guarda o valor original em _4c_Teste_Erro337 antes de alterar.
SET NOCOUNT ON;
IF OBJECT_ID('dbo._4c_Teste_Erro337') IS NULL
    CREATE TABLE dbo._4c_Teste_Erro337 (Tabela varchar(20), Chave varchar(20), GerBalsOrig int);

INSERT INTO dbo._4c_Teste_Erro337 (Tabela, Chave, GerBalsOrig)
SELECT 'SigCdGcr', RTRIM(g.Codigos), g.GerBals FROM SigCdGcr g
 WHERE RTRIM(g.Codigos) IN ('11101','11210','30101','30102')
   AND NOT EXISTS (SELECT 1 FROM dbo._4c_Teste_Erro337 t WHERE t.Tabela = 'SigCdGcr'
                   AND t.Chave = RTRIM(g.Codigos) COLLATE DATABASE_DEFAULT);
INSERT INTO dbo._4c_Teste_Erro337 (Tabela, Chave, GerBalsOrig)
SELECT 'SigCdCli', RTRIM(c.IClis), c.GerBals FROM SigCdCli c
 WHERE RTRIM(c.IClis) IN ('1110100001','1121001','3010210001','3010110003')
   AND NOT EXISTS (SELECT 1 FROM dbo._4c_Teste_Erro337 t WHERE t.Tabela = 'SigCdCli'
                   AND t.Chave = RTRIM(c.IClis) COLLATE DATABASE_DEFAULT);

UPDATE SigCdGcr SET GerBals = 1 WHERE RTRIM(Codigos) IN ('11101','11210','30101','30102');
UPDATE SigCdCli SET GerBals = 1 WHERE RTRIM(IClis)   IN ('1110100001','1121001','3010210001','3010110003');

SELECT 'SigCdGcr' t, Codigos, Descrs, GerBals FROM SigCdGcr WHERE GerBals = 1;
SELECT 'SigCdCli' t, IClis, RClis, GerBals FROM SigCdCli WHERE GerBals = 1;

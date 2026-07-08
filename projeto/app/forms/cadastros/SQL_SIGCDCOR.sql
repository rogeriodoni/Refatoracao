-- ============================================================================
-- SQL PARA CADASTRO DE CORES (SIGCDCOR)
-- Banco: SQL Server
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. CRIAR TABELA PRINCIPAL
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SigCdCor]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[SigCdCor](
        [cods] VARCHAR(10) NOT NULL,
        [descs] VARCHAR(100) NULL,
        [varias] DECIMAL(7,2) NULL DEFAULT (0.00),
        [grupos] VARCHAR(10) NULL,
        [Pesos] DECIMAL(7,2) NULL DEFAULT (0.00),
        [tpCors] CHAR(1) NULL,
        [DiasEnts] INT NULL DEFAULT (0),
        [Tanque] VARCHAR(10) NULL,
        CONSTRAINT [PK_SigCdCor] PRIMARY KEY CLUSTERED ([cods] ASC)
    )

    PRINT 'Tabela SigCdCor criada com sucesso!'
END
ELSE
BEGIN
    PRINT 'Tabela SigCdCor já existe'
END
GO

-- ----------------------------------------------------------------------------
-- 2. CRIAR ÍNDICES PARA PERFORMANCE
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_sigcdcor_descs' AND object_id = OBJECT_ID('SigCdCor'))
BEGIN
    CREATE NONCLUSTERED INDEX [idx_sigcdcor_descs] ON [dbo].[SigCdCor]([descs] ASC)
    PRINT 'Índice idx_sigcdcor_descs criado!'
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_sigcdcor_grupos' AND object_id = OBJECT_ID('SigCdCor'))
BEGIN
    CREATE NONCLUSTERED INDEX [idx_sigcdcor_grupos] ON [dbo].[SigCdCor]([grupos] ASC)
    PRINT 'Índice idx_sigcdcor_grupos criado!'
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_sigcdcor_tanque' AND object_id = OBJECT_ID('SigCdCor'))
BEGIN
    CREATE NONCLUSTERED INDEX [idx_sigcdcor_tanque] ON [dbo].[SigCdCor]([Tanque] ASC)
    PRINT 'Índice idx_sigcdcor_tanque criado!'
END
GO

-- ----------------------------------------------------------------------------
-- 3. CRIAR TABELA DE TANQUES (SE NÃO EXISTIR)
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SigCdTqe]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[SigCdTqe](
        [codigos] VARCHAR(10) NOT NULL,
        [descrs] VARCHAR(100) NULL,
        CONSTRAINT [PK_SigCdTqe] PRIMARY KEY CLUSTERED ([codigos] ASC)
    )

    PRINT 'Tabela SigCdTqe criada com sucesso!'
END
ELSE
BEGIN
    PRINT 'Tabela SigCdTqe já existe'
END
GO

-- ----------------------------------------------------------------------------
-- 4. INSERIR DADOS DE TESTE - TANQUES
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM SigCdTqe WHERE codigos = 'TQ01')
BEGIN
    INSERT INTO SigCdTqe (codigos, descrs) VALUES ('TQ01', 'Tanque 01')
    INSERT INTO SigCdTqe (codigos, descrs) VALUES ('TQ02', 'Tanque 02')
    INSERT INTO SigCdTqe (codigos, descrs) VALUES ('TQ03', 'Tanque 03')
    INSERT INTO SigCdTqe (codigos, descrs) VALUES ('TQ04', 'Tanque 04')
    INSERT INTO SigCdTqe (codigos, descrs) VALUES ('TQ05', 'Tanque 05')

    PRINT 'Dados de teste de tanques inseridos!'
END
GO

-- ----------------------------------------------------------------------------
-- 5. INSERIR DADOS DE TESTE - CORES
-- ----------------------------------------------------------------------------
-- Apaga dados de teste se existirem
DELETE FROM SigCdCor WHERE cods IN ('AB', 'AG', 'AI', 'AR', 'AZ', 'NG', 'OA', 'OB', 'OR', 'RB', 'ROSA', 'TC', 'VERD')

-- Insere dados de teste (baseados no print1.jpg)
INSERT INTO SigCdCor (cods, descs, varias, grupos, Pesos, tpCors, DiasEnts, Tanque)
VALUES
('AB', 'AMARELO E BRANCO', 0.00, NULL, 0.00, NULL, 0, NULL),
('AG', 'AG', 0.00, NULL, 0.00, NULL, 0, NULL),
('AI', 'AÇO INOX', 0.00, NULL, 0.00, NULL, 0, NULL),
('AR', 'AR', 0.00, NULL, 0.00, NULL, 0, NULL),
('AZ', 'AZUL', 0.00, NULL, 0.00, NULL, 0, NULL),
('NG', 'BLACK', 0.00, NULL, 0.00, NULL, 0, NULL),
('OA', 'OA', 0.00, NULL, 0.00, NULL, 0, NULL),
('OB', 'OB', 0.00, NULL, 0.00, NULL, 0, NULL),
('OR', 'OR', 0.00, NULL, 0.00, NULL, 0, NULL),
('RB', 'RB', 0.00, NULL, 0.00, NULL, 0, NULL),
('ROSA', 'ROSA', 0.00, NULL, 0.00, NULL, 0, NULL),
('TC', 'OA, OB, RS', 0.00, NULL, 0.00, NULL, 0, NULL),
('VERD', 'VERDE', 0.00, NULL, 0.00, NULL, 0, NULL)

PRINT 'Dados de teste de cores inseridos!'
GO

-- ----------------------------------------------------------------------------
-- 6. VERIFICAR DADOS INSERIDOS
-- ----------------------------------------------------------------------------
PRINT ''
PRINT '==================================================================='
PRINT 'VERIFICAÇÃO DOS DADOS'
PRINT '==================================================================='

PRINT ''
PRINT 'Total de Cores cadastradas:'
SELECT COUNT(*) AS TotalCores FROM SigCdCor

PRINT ''
PRINT 'Total de Tanques cadastrados:'
SELECT COUNT(*) AS TotalTanques FROM SigCdTqe

PRINT ''
PRINT 'Primeiras 10 Cores:'
SELECT TOP 10 * FROM SigCdCor ORDER BY cods

PRINT ''
PRINT 'Tanques cadastrados:'
SELECT * FROM SigCdTqe ORDER BY codigos

PRINT ''
PRINT '==================================================================='
PRINT 'SCRIPT EXECUTADO COM SUCESSO!'
PRINT '==================================================================='
GO

-- ----------------------------------------------------------------------------
-- 7. QUERIES ÚTEIS PARA TESTES
-- ----------------------------------------------------------------------------

-- Buscar todas as cores
-- SELECT * FROM SigCdCor ORDER BY cods

-- Buscar cores por descrição
-- SELECT * FROM SigCdCor WHERE descs LIKE '%AZUL%'

-- Verificar se código existe
-- SELECT COUNT(*) FROM SigCdCor WHERE cods = 'AB'

-- Verificar se tanque existe
-- SELECT COUNT(*) FROM SigCdTqe WHERE codigos = 'TQ01'

-- Atualizar uma cor
-- UPDATE SigCdCor SET descs = 'AZUL ESCURO', varias = 10.50 WHERE cods = 'AZ'

-- Excluir uma cor
-- DELETE FROM SigCdCor WHERE cods = 'TEST'

-- Ver estrutura da tabela
-- sp_help 'SigCdCor'

-- ----------------------------------------------------------------------------
-- 8. SCRIPT DE LIMPEZA (USE COM CUIDADO!)
-- ----------------------------------------------------------------------------

-- DESCOMENTAR APENAS SE QUISER REMOVER TUDO E COMEÇAR DO ZERO

-- DROP INDEX IF EXISTS idx_sigcdcor_descs ON SigCdCor
-- DROP INDEX IF EXISTS idx_sigcdcor_grupos ON SigCdCor
-- DROP INDEX IF EXISTS idx_sigcdcor_tanque ON SigCdCor
-- DROP TABLE IF EXISTS SigCdCor
-- DROP TABLE IF EXISTS SigCdTqe

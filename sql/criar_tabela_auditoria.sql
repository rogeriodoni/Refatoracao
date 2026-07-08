/*
================================================================================
SCRIPT: criar_tabela_auditoria.sql
DESCRICAO: Cria tabela de log de auditoria para rastreamento de operacoes
BANCO: DB_MBAHIA
DATA: 2025-12-02
================================================================================
*/

-- Verificar se a tabela ja existe
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogAuditoria]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[LogAuditoria] (
        [Id]              INT IDENTITY(1,1) NOT NULL,
        [Tabela]          VARCHAR(100) NOT NULL,
        [Operacao]        VARCHAR(10) NOT NULL,
        [ChaveRegistro]   VARCHAR(100) NOT NULL,
        [Usuario]         VARCHAR(50) NOT NULL,
        [DataHora]        DATETIME NOT NULL DEFAULT GETDATE(),
        [DadosAnteriores] NVARCHAR(MAX) NULL,
        [DadosNovos]      NVARCHAR(MAX) NULL,
        [IP]              VARCHAR(50) NULL,
        [Estacao]         VARCHAR(100) NULL,
        CONSTRAINT [PK_LogAuditoria] PRIMARY KEY CLUSTERED ([Id] ASC)
    );

    PRINT 'Tabela LogAuditoria criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'Tabela LogAuditoria ja existe.';
END
GO

-- Criar indices para otimizar consultas
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LogAuditoria_Tabela' AND object_id = OBJECT_ID('LogAuditoria'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LogAuditoria_Tabela]
    ON [dbo].[LogAuditoria] ([Tabela] ASC);
    PRINT 'Indice IX_LogAuditoria_Tabela criado.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LogAuditoria_DataHora' AND object_id = OBJECT_ID('LogAuditoria'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LogAuditoria_DataHora]
    ON [dbo].[LogAuditoria] ([DataHora] DESC);
    PRINT 'Indice IX_LogAuditoria_DataHora criado.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LogAuditoria_Usuario' AND object_id = OBJECT_ID('LogAuditoria'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LogAuditoria_Usuario]
    ON [dbo].[LogAuditoria] ([Usuario] ASC);
    PRINT 'Indice IX_LogAuditoria_Usuario criado.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LogAuditoria_Operacao' AND object_id = OBJECT_ID('LogAuditoria'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LogAuditoria_Operacao]
    ON [dbo].[LogAuditoria] ([Operacao] ASC);
    PRINT 'Indice IX_LogAuditoria_Operacao criado.';
END
GO

-- Criar view para consulta facilitada
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_AuditoriaRecente')
BEGIN
    DROP VIEW [dbo].[vw_AuditoriaRecente];
END
GO

CREATE VIEW [dbo].[vw_AuditoriaRecente]
AS
SELECT TOP 1000
    Id,
    Tabela,
    Operacao,
    ChaveRegistro,
    Usuario,
    DataHora,
    DadosAnteriores,
    DadosNovos,
    IP,
    Estacao
FROM [dbo].[LogAuditoria]
ORDER BY DataHora DESC;
GO

PRINT 'View vw_AuditoriaRecente criada.';
GO

-- Stored Procedure para inserir registro de auditoria
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_RegistrarAuditoria]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE [dbo].[sp_RegistrarAuditoria];
END
GO

CREATE PROCEDURE [dbo].[sp_RegistrarAuditoria]
    @Tabela          VARCHAR(100),
    @Operacao        VARCHAR(10),
    @ChaveRegistro   VARCHAR(100),
    @Usuario         VARCHAR(50),
    @DadosAnteriores NVARCHAR(MAX) = NULL,
    @DadosNovos      NVARCHAR(MAX) = NULL,
    @IP              VARCHAR(50) = NULL,
    @Estacao         VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[LogAuditoria]
        (Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosAnteriores, DadosNovos, IP, Estacao)
    VALUES
        (@Tabela, @Operacao, @ChaveRegistro, @Usuario, GETDATE(), @DadosAnteriores, @DadosNovos, @IP, @Estacao);

    RETURN @@IDENTITY;
END
GO

PRINT 'Stored Procedure sp_RegistrarAuditoria criada.';
GO

-- Stored Procedure para consultar auditoria por tabela
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ConsultarAuditoria]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE [dbo].[sp_ConsultarAuditoria];
END
GO

CREATE PROCEDURE [dbo].[sp_ConsultarAuditoria]
    @Tabela        VARCHAR(100) = NULL,
    @ChaveRegistro VARCHAR(100) = NULL,
    @DataInicio    DATETIME = NULL,
    @DataFim       DATETIME = NULL,
    @Usuario       VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        Tabela,
        Operacao,
        ChaveRegistro,
        Usuario,
        DataHora,
        DadosAnteriores,
        DadosNovos,
        IP,
        Estacao
    FROM [dbo].[LogAuditoria]
    WHERE
        (@Tabela IS NULL OR Tabela = @Tabela)
        AND (@ChaveRegistro IS NULL OR ChaveRegistro = @ChaveRegistro)
        AND (@DataInicio IS NULL OR DataHora >= @DataInicio)
        AND (@DataFim IS NULL OR DataHora <= @DataFim)
        AND (@Usuario IS NULL OR Usuario = @Usuario)
    ORDER BY DataHora DESC;
END
GO

PRINT 'Stored Procedure sp_ConsultarAuditoria criada.';
PRINT '';
PRINT '================================================================================';
PRINT 'Script de auditoria executado com sucesso!';
PRINT '================================================================================';
GO

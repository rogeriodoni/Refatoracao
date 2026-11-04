/* ===========================================================
   Erro302 - tabelas do produto AUSENTES do DB_MBAHIA
   DDL extraido do banco VIVO [CORLUIZ], que as tem (16 dos 122
   bancos do servidor tem as 5). Inclui os DEFAULT, que o docs/schema.sql
   NAO traz - com eles, INSERT parcial nao viola o NOT NULL (regra #22).
   Gerado em 04/11/2026 12:11:28 por automation\ProbeErro302GerarDdl.prg
   NAO foi executado. Revisar antes de aplicar no DB_MBAHIA.
   =========================================================== */

USE [DB_MBAHIA];
GO

IF OBJECT_ID('dbo.SigCdOcs', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SigCdOcs] (
        [cods] [char](10) NOT NULL DEFAULT (' '),
        [cidchaves] [char](20) NOT NULL DEFAULT (' '),
        [descs] [char](40) NOT NULL DEFAULT (' '),
        CONSTRAINT [sigcdocs_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)
    );
    PRINT 'criada: dbo.SigCdOcs';
END
ELSE PRINT 'ja existia: dbo.SigCdOcs';
GO

IF OBJECT_ID('dbo.SigCdCcp', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SigCdCcp] (
        [cidchaves] [char](20) NOT NULL DEFAULT (' '),
        [codigo] [char](3) NOT NULL DEFAULT (' '),
        [inativas] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        [cfornecs] [char](10) NOT NULL DEFAULT (' '),
        [merci] [char](3) NOT NULL DEFAULT (' '),
        [mercf] [char](3) NOT NULL DEFAULT (' '),
        [cgrui] [char](3) NOT NULL DEFAULT (' '),
        [cgruf] [char](3) NOT NULL DEFAULT (' '),
        [sgrui] [char](6) NOT NULL DEFAULT (' '),
        [sgruf] [char](6) NOT NULL DEFAULT (' '),
        [cunii] [char](3) NOT NULL DEFAULT (' '),
        [cunif] [char](3) NOT NULL DEFAULT (' '),
        [moedai] [char](3) NOT NULL DEFAULT (' '),
        [moedaf] [char](3) NOT NULL DEFAULT (' '),
        [opcmoedatp] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        [lini] [char](10) NOT NULL DEFAULT (' '),
        [linf] [char](10) NOT NULL DEFAULT (' '),
        [coli] [char](10) NOT NULL DEFAULT (' '),
        [colf] [char](10) NOT NULL DEFAULT (' '),
        [mrki] [numeric](5, 2) NOT NULL DEFAULT ((0)),
        [mrkf] [numeric](5, 2) NOT NULL DEFAULT ((0)),
        [enci] [numeric](5, 2) NOT NULL DEFAULT ((0)),
        [encf] [numeric](5, 2) NOT NULL DEFAULT ((0)),
        [variacao] [numeric](5, 2) NOT NULL DEFAULT ((0)),
        [feitio] [char](10) NOT NULL DEFAULT (' '),
        [opcsit] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        [opcrecalc] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        [reajuste] [numeric](12, 3) NOT NULL DEFAULT ((0)),
        [nmrk] [numeric](12, 2) NOT NULL DEFAULT ((0)),
        [encargo] [numeric](12, 2) NOT NULL DEFAULT ((0)),
        [newmkp] [char](10) NOT NULL DEFAULT (' '),
        [opcpven] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        CONSTRAINT [sigcdccp_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)
    );
    PRINT 'criada: dbo.SigCdCcp';
END
ELSE PRINT 'ja existia: dbo.SigCdCcp';
GO

IF OBJECT_ID('dbo.SigCdCmp', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SigCdCmp] (
        [cods] [char](10) NOT NULL DEFAULT (' '),
        [cidchaves] [char](20) NOT NULL DEFAULT (' '),
        [descs] [char](40) NOT NULL DEFAULT (' '),
        CONSTRAINT [sigcdcmp_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)
    );
    PRINT 'criada: dbo.SigCdCmp';
END
ELSE PRINT 'ja existia: dbo.SigCdCmp';
GO

IF OBJECT_ID('dbo.SigCdCrf', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SigCdCrf] (
        [cidchaves] [char](20) NOT NULL DEFAULT (' '),
        [conferido] [numeric](1, 0) NOT NULL DEFAULT ((0)),
        [datas] [datetime] NULL,
        [vends] [char](10) NOT NULL DEFAULT (' '),
        [cods] [char](10) NOT NULL DEFAULT (' '),
        [emps] [char](3) NOT NULL DEFAULT (' '),
        CONSTRAINT [sigcdcrf_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)
    );
    PRINT 'criada: dbo.SigCdCrf';
END
ELSE PRINT 'ja existia: dbo.SigCdCrf';
GO

IF OBJECT_ID('dbo.SigCdCri', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SigCdCri] (
        [cidchaves] [char](20) NOT NULL DEFAULT (' '),
        [cods] [char](10) NOT NULL DEFAULT (' '),
        [emps] [char](3) NOT NULL DEFAULT (' '),
        [grupos] [char](10) NOT NULL DEFAULT (' '),
        [estos] [char](10) NOT NULL DEFAULT (' '),
        [qtds] [numeric](5, 0) NOT NULL DEFAULT ((0)),
        [estoque] [numeric](5, 0) NOT NULL DEFAULT ((0)),
        [cpros] [char](14) NOT NULL DEFAULT (''),
        CONSTRAINT [sigcdcri_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)
    );
    PRINT 'criada: dbo.SigCdCri';
END
ELSE PRINT 'ja existia: dbo.SigCdCri';
GO


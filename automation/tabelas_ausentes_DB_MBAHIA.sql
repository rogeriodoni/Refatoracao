-- =====================================================================
-- Tabelas do schema canonico (docs/schema.sql) AUSENTES em DB_MBAHIA
-- Levantado em 2026-10-20 comparando as 682 do canonico com as 681 do banco.
-- Origem: Erro233 (Cadastro de Email -> "Nome de objeto 'SigCdEma' invalido")
--
-- NAO EXECUTADO por mim: criar tabela em banco de producao eh decisao do time.
-- DDL copiada LITERAL do schema canonico (PILAR 2: schema identico).
-- =====================================================================
USE [DB_MBAHIA]
GO

-- ---------- sigcdema ----------
IF OBJECT_ID('dbo.sigcdema','U') IS NULL
BEGIN
CREATE TABLE [dbo].[sigcdema](
	[cods] [char](50) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
 CONSTRAINT [sigcdema_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- ---------- sigcdccp ----------
IF OBJECT_ID('dbo.sigcdccp','U') IS NULL
BEGIN
CREATE TABLE [dbo].[SigCdCcp](
	[cIdChaves] [char](20) NOT NULL,
	[codigo] [char](3) NOT NULL,
	[Inativas] [numeric](1, 0) NOT NULL,
	[cfornecs] [char](14) NOT NULL,
	[merci] [char](14) NOT NULL,
	[mercf] [char](14) NOT NULL,
	[cgrui] [char](14) NOT NULL,
	[cgruf] [char](14) NOT NULL,
	[sgrui] [char](14) NOT NULL,
	[sgruf] [char](14) NOT NULL,
	[cunii] [char](10) NOT NULL,
	[cunif] [char](10) NOT NULL,
	[lini] [char](10) NOT NULL,
	[linf] [char](10) NOT NULL,
	[coli] [char](10) NOT NULL,
	[colf] [char](10) NOT NULL,
	[moedai] [char](10) NOT NULL,
	[moedaf] [char](10) NOT NULL,
	[opcmoedatp] [numeric](1, 0) NOT NULL,
	[mrki] [numeric](9, 2) NOT NULL,
	[mrkf] [numeric](9, 2) NOT NULL,
	[enci] [numeric](9, 2) NOT NULL,
	[encf] [numeric](9, 2) NOT NULL,
	[variacao] [numeric](9, 2) NOT NULL,
	[feitio] [char](2) NOT NULL,
	[opcsit] [numeric](1, 0) NOT NULL,
	[opcrecalc] [numeric](1, 0) NOT NULL,
	[reajuste] [numeric](9, 2) NOT NULL,
	[encargo] [numeric](9, 2) NOT NULL,
	[nmrk] [numeric](9, 2) NOT NULL,
	[opcpven] [numeric](1, 0) NOT NULL,
	[newmkp] [char](2) NOT NULL,
 CONSTRAINT [sigcdccp_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cIdChaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- ---------- sigcdcmp ----------
IF OBJECT_ID('dbo.sigcdcmp','U') IS NULL
BEGIN
CREATE TABLE [dbo].[SigCdCmp](
	[cods] [char](10) NOT NULL,
	[descs] [char](60) NOT NULL,
	[cIdChaves] [char](20) NOT NULL,
 CONSTRAINT [sigcdcmp_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cIdChaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- ---------- sigcdcrf ----------
IF OBJECT_ID('dbo.sigcdcrf','U') IS NULL
BEGIN
CREATE TABLE [dbo].[SigCdCrf](
	[cidchaves] [char](20) NOT NULL,
	[cods] [char](10) NOT NULL,
	[emps] [char](3) NOT NULL,
	[vends] [char](10) NOT NULL,
	[datas] [datetime] NULL,
	[conferido] [numeric](1, 0) NOT NULL,
 CONSTRAINT [pk_sigcdcrf] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- ---------- sigcdcri ----------
IF OBJECT_ID('dbo.sigcdcri','U') IS NULL
BEGIN
CREATE TABLE [dbo].[SigCdCri](
	[cidchaves] [char](20) NOT NULL,
	[cods] [char](10) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[estos] [char](10) NOT NULL,
	[cpros] [char](10) NOT NULL,
	[cbars] [numeric](13, 3) NOT NULL,
	[qtds] [numeric](5, 0) NOT NULL,
	[estoque] [numeric](5, 0) NOT NULL,
	[descr] [char](60) NOT NULL,
 CONSTRAINT [pk_sigcdcri] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- ---------- sigcdocs ----------
IF OBJECT_ID('dbo.sigcdocs','U') IS NULL
BEGIN
CREATE TABLE [dbo].[SigCdOcs](
	[cidchaves] [char](20) NOT NULL,
	[cods] [char](10) NOT NULL,
	[descs] [char](40) NOT NULL,
 CONSTRAINT [sigcdocs_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO



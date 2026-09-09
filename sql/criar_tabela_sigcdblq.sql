/*=============================================================================
  criar_tabela_sigcdblq.sql

  Erro155 - "Cadastro de Bloqueios por Periodo" (FormBlq) abre com erro do
  proprio SQL Server:

      Nome de objeto 'SigCdBlq' invalido.

  DIAGNOSTICO: o codigo migrado esta CORRETO. Conferido:
    - o legado usa exatamente esse nome:
        .AddCursor([SigCdBlq], [cIdChaves], [crSigCdBlq], ...)
        (tasks\task351\SigCdBlq_form_codigo_fonte.txt:503)
    - a tabela esta no schema canonico docs\schema.sql, em DB_MBAHIA.dbo,
      com exatamente as colunas que o form usa
    - o SELECT do BlqBO nao tem erro de sintaxe nem coluna inventada
    - a conexao esta boa: outras telas consultam Sig* normalmente
    - o BlqBO nao toca nenhuma outra tabela

  Ou seja: a base conectada (config.prg:22 -> 192.168.200.10, DB_MBAHIA) nao
  bate com o dump de 08/12/2025. A tabela precisa ser criada/importada.

  ANTES DE RODAR, CONFIRMAR que ela realmente nao existe:

      SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_NAME = 'SigCdBlq';

  Se voltar linha, o problema eh OUTRO (schema/owner ou banco diferente do
  esperado) e este script NAO deve ser executado.

  DDL abaixo copiada sem alteracao de docs\schema.sql (PILAR 2: schema
  identico ao legado).
=============================================================================*/

USE [DB_MBAHIA]
GO
/****** Object:  Table [dbo].[SigCdBlq]    Script Date: 08/12/2025 10:07:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SigCdBlq](
	[Codigos] [char](10) NOT NULL,
	[CidChaves] [char](20) NOT NULL,
	[dtInicial] [datetime] NULL,
	[dtFinal] [datetime] NULL,
	[inativo] [bit] NOT NULL,
	[UsuIncs] [char](10) NOT NULL,
	[DtIncs] [datetime] NULL,
	[UsuAlts] [char](10) NOT NULL,
	[DtAlts] [datetime] NULL,
 CONSTRAINT [sigcdblq_codigos] PRIMARY KEY CLUSTERED 
(
	[Codigos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*==============================================================================
  SigLcLo / SigLcLoI / SigLcLoE - Comparativo Entre Locais
  (tela SIGCDCLC / FormCLC)   -- Erro210

  ============================================================================
  LEIA ANTES DE RODAR - ESTE SCRIPT NAO EQUIVALE AO criar_SigCdUep.sql
  ============================================================================
  O criar_SigCdUep.sql pode afirmar que a definicao esta certa porque a tabela
  existe em 16 outros bancos do servidor, identica nos 16.

  AQUI NAO HA BANCO DE REFERENCIA NENHUM. Varredura nos 118 bancos online de
  192.168.200.10 em 2026-10-14:

      SigLcLo   -> 0 bancos
      SigLcLoI  -> 0 bancos
      SigLcLoE  -> 0 bancos

  A definicao abaixo foi DEDUZIDA de duas fontes, nenhuma delas autoritativa:
    1. docs/schema.sql  (que, nesse trecho, nem executa - ver adiante)
    2. as colunas que o SCX legado e o CLCBO migrado realmente leem/gravam

  Larguras, nulabilidade e defaults sao portanto uma APOSTA FUNDAMENTADA, nao
  um fato. Se a 4Control devolver o script oficial, USAR O DELES e descartar
  este arquivo.

  POR QUE ESTE SCRIPT EXISTE
  --------------------------
  A tela nao abre:  "Nome de objeto 'SigLcLo' invalido."
  Nao eh defeito de migracao: o SCX legado usa os mesmos nomes
  (SIGCDCLC_form_codigo_fonte.txt:2610-2627), entao a tela LEGADA quebra igual
  neste banco. O que falta eh a tabela.

  CORRECAO APLICADA SOBRE O docs/schema.sql
  -----------------------------------------
  O CREATE de SigLcLoI do schema canonico NAO EXECUTA:

      [cIdChaves] [char](36) NOT NULL,   -- PK, usada pelo legado e pelo migrado
      [cidchaves] [char](20) NOT NULL,   -- duplicata; ninguem referencia

  Nomes de coluna sao case-insensitive no SQL Server, entao as duas sao a MESMA
  coluna e o CREATE falha com "Os nomes de colunas em cada tabela devem ser
  exclusivos". A duplicata char(20) foi REMOVIDA aqui - o legado so manipula
  cIdChaves (Replace cIdChaves With fUniqueIds() In crSigLcLoI) e o CLCBO
  migrado so grava cIdChaves.

  Outro indicio de que esse trecho do schema.sql foi montado a mao: as PKs tem
  nome que nao bate com a coluna (siglclo_cidchaves construida sobre [Codigos],
  siglcloi_cidchaves sobre [cIdChaves]). Os nomes foram mantidos como estao
  para nao divergir do schema canonico.

  LARGURA DE OperacaoA / OperacaoB - CORRIGIDA EM 2026-10-14 (Erro212)
  --------------------------------------------------------------------
  O docs/schema.sql declara char(10). ERRADO: o campo recebe SigCdOpe.Dopes,
  que eh char(20) e cujo maior valor real no banco tem 20 caracteres
  ("ACEITE TRANSFERENCIA"). Gravar estourava
      "Dados de cadeia ou binarios seriam truncados"
  A tabela-filha SigLcLoI.Operacoes - mesmo conceito - ja era char(20) no
  proprio schema, o que confirma a largura. Aqui vai char(20).

  Codigos permanece char(3), como nas TRES tabelas do modulo; o limite de
  digitacao foi posto no form (MaxLength = 3), nao alargando a coluna.
  COLLATE EXPLICITO - NAO REMOVER
  -------------------------------
  O default do DB_MBAHIA eh Latin1_General_CI_AS, mas TODAS as colunas com que
  estas tabelas fazem JOIN estao em SQL_Latin1_General_CP1_CI_AS (medido em
  2026-10-14):

      SigCdLoc.cods      char(10)   SQL_Latin1_General_CP1_CI_AS
      SigCdGrp.cgrus     char(3)    SQL_Latin1_General_CP1_CI_AS
      SigCdGpr.codigos   char(3)    SQL_Latin1_General_CP1_CI_AS
      SigCdCli.iclis     char(10)   SQL_Latin1_General_CP1_CI_AS
      SigCdCli.grupos    char(10)   SQL_Latin1_General_CP1_CI_AS
      SigCdEmp.cemps     char(3)    SQL_Latin1_General_CP1_CI_AS
      SigCdOpt.operacaos char(15)   SQL_Latin1_General_CP1_CI_AS

  Sem o COLLATE explicito as colunas nasceriam no default do banco e todo JOIN
  estouraria "Não é possível resolver o conflito de ordenação".

  O CODIGO TAMBEM PRECISA DE AJUSTE
  ---------------------------------
  Criar as tabelas NAO basta: tres INSERT do CLCBO omitem a chave Fortyus
  (cidchaves / cIdChaves), que eh NOT NULL - e em SigLcLoE eh a PROPRIA PK.
  Ver o bloco "PENDENCIAS NO CODIGO" no fim deste arquivo.

  ============================================================================
*/

USE DB_MBAHIA;
GO

SET XACT_ABORT ON;
BEGIN TRANSACTION;
GO

/*----------------------------------------------------------------------------
  SigLcLo - cabecalho do comparativo (um registro por classificacao)
  PK: Codigos (char 3) - nome da constraint mantido como no schema canonico
----------------------------------------------------------------------------*/
IF OBJECT_ID('dbo.SigLcLo', 'U') IS NULL
CREATE TABLE [dbo].[SigLcLo](
    [Codigos]    [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Emps]       [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [EmpContas]  [bit]                                                NOT NULL,
    [EmpTrans]   [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Digitos]    [numeric](1, 0)                                      NOT NULL,
    [Autos]      [bit]                                                NOT NULL,
    [Toleras]    [numeric](10, 2)                                     NOT NULL,
    [Percents]   [numeric](10, 2)                                     NOT NULL,
    [LocalA]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GrupoA]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ContaA]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [OperacaoA]  [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GdeGrupoA]  [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [DataA]      [datetime]                                               NULL,
    [EtiquetaA]  [bit]                                                NOT NULL,
    [PalmA]      [bit]                                                NOT NULL,
    [DivisaoA]   [numeric](10, 0)                                     NOT NULL,
    [LocalB]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GrupoB]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ContaB]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [OperacaoB]  [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GdeGrupoB]  [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [DataB]      [datetime]                                               NULL,
    [EtiquetaB]  [bit]                                                NOT NULL,
    [PalmB]      [bit]                                                NOT NULL,
    [DivisaoB]   [numeric](10, 0)                                     NOT NULL,
    [cidchaves]  [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [siglclo_cidchaves] PRIMARY KEY CLUSTERED ([Codigos] ASC)
) ON [PRIMARY];
GO

/*----------------------------------------------------------------------------
  SigLcLoI - operacoes do comparativo (N por classificacao)
  PK: cIdChaves (char 36).  A coluna [cidchaves] char(20) do docs/schema.sql
  foi REMOVIDA: eh duplicata do mesmo nome e impede o CREATE.
----------------------------------------------------------------------------*/
IF OBJECT_ID('dbo.SigLcLoI', 'U') IS NULL
CREATE TABLE [dbo].[SigLcLoI](
    [cIdChaves]  [char](36)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Codigos]    [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Emps]       [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Cods]       [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Operacoes]  [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GrupoOs]    [char](40)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ContaOs]    [char](40)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [GrupoDs]    [char](40)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ContaDs]    [char](40)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Agrupar]    [bit]                                                NOT NULL,
    [EnvRecs]    [char](1)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [siglcloi_cidchaves] PRIMARY KEY CLUSTERED ([cIdChaves] ASC)
) ON [PRIMARY];
GO

/*----------------------------------------------------------------------------
  SigLcLoE - estoques avaliados por local
  PK: cIdChaves (char 20).  No docs/schema.sql a coluna aparece grafada
  [cidchaves]; o legado grava nela como cIdChaves
  (Insert Into crSigLcLoE (..., cIdChaves) com fUniqueIds(), que devolve 20
  caracteres). Mesma coluna - a grafia nao importa no SQL Server.
----------------------------------------------------------------------------*/
IF OBJECT_ID('dbo.SigLcLoE', 'U') IS NULL
CREATE TABLE [dbo].[SigLcLoE](
    [Codigos]    [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Locals]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Emps]       [char](3)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Grupos]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Contas]     [char](10)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Marca]      [bit]                                                NOT NULL,
    [cIdChaves]  [char](20)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [siglcloe_cidchaves] PRIMARY KEY CLUSTERED ([cIdChaves] ASC)
) ON [PRIMARY];
GO

/*----------------------------------------------------------------------------
  Indices de apoio - os dois filhos sao sempre lidos por Codigos
  (CLCBO.CarregarOperacoes / CarregarEstoques: WHERE Codigos = ?)
----------------------------------------------------------------------------*/
IF OBJECT_ID('dbo.SigLcLoI', 'U') IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_siglcloi_codigos')
CREATE INDEX [ix_siglcloi_codigos] ON [dbo].[SigLcLoI] ([Codigos] ASC);
GO

IF OBJECT_ID('dbo.SigLcLoE', 'U') IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_siglcloe_codigos')
CREATE INDEX [ix_siglcloe_codigos] ON [dbo].[SigLcLoE] ([Codigos] ASC, [Locals] ASC);
GO

COMMIT TRANSACTION;
GO

/*----------------------------------------------------------------------------
  Conferencia
----------------------------------------------------------------------------*/
SELECT t.name AS tabela, c.name AS coluna, ty.name AS tipo,
       c.max_length, c.is_nullable, c.collation_name
  FROM sys.columns c
  JOIN sys.tables  t  ON t.object_id = c.object_id
  JOIN sys.types   ty ON ty.user_type_id = c.user_type_id
 WHERE t.name IN ('SigLcLo', 'SigLcLoI', 'SigLcLoE')
 ORDER BY t.name, c.column_id;
GO


/*==============================================================================
  PENDENCIAS NO CODIGO - sem elas a tela abre mas NAO GRAVA
  ==============================================================================

  Tres INSERT do CLCBO.prg omitem a chave Fortyus, que eh NOT NULL:

  1) CLCBO.Inserir()            -> SigLcLo   omite [cidchaves]
  2) CLCBO.GravarEstoques()     -> SigLcLoE  omite [cIdChaves]  (eh a PK!)
  3) FormCLC (linha ~1884) gera a chave de SigLcLoI como
        TRANSFORM(DATETIME(),"YYYYMMDDHHMMSS") + PADL(TRANSFORM(RECNO()),4,"0")
     em vez de fUniqueIds(), que eh o que o legado usa
     (Replace cIdChaves With fUniqueIds() In crSigLcLoI).
     Duas classificacoes gravadas no mesmo segundo com o mesmo RECNO colidiriam
     na PK.

  Em todos os casos o padrao do projeto (regra #22) eh
        EscaparSQL(fUniqueIds())
  e NUNCA string vazia - senao o segundo registro colide no indice unico.
==============================================================================*/

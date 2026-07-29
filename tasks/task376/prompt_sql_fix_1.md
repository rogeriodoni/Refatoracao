CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2484: Coluna 'jobs' NAO EXISTE na tabela 'sigcdace' (referenciada como c.Jobs)
- [SQL-SCHEMA] Linha ~2484: Coluna 'jobs' NAO EXISTE na tabela 'sigcdace' (referenciada como c.Jobs)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdace
CREATE TABLE [dbo].[sigcdace](
	[usuarios] [char](10) NOT NULL,
	[emps] [char](3) NOT NULL,
	[pkchaves] [char](13) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pkchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sigcdacg]    Script Date: 08/12/2025 10:07:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formcnl.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\cnlBO.prg):

--- BO Linhas 511 a 521 ---
511:                        " FROM SigCdCli a" + ;
512:                        " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
513:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
514:                        " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
515:                        " AND a.IClis NOT IN" + ;
516:                        " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
517:                        " WHERE c.Jobs NOT IN" + ;
518:                        " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
519:                        " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
520:                        " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
521:                        " AND a.Inativas <> 2" + ;

--- BO Linhas 512 a 522 ---
512:                        " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
513:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
514:                        " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
515:                        " AND a.IClis NOT IN" + ;
516:                        " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
517:                        " WHERE c.Jobs NOT IN" + ;
518:                        " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
519:                        " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
520:                        " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
521:                        " AND a.Inativas <> 2" + ;
522:                        " AND c.Emps = " + EscaparSQL(loc_cEmpresa) + ;

--- BO Linhas 513 a 523 ---
513:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
514:                        " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
515:                        " AND a.IClis NOT IN" + ;
516:                        " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
517:                        " WHERE c.Jobs NOT IN" + ;
518:                        " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
519:                        " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
520:                        " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
521:                        " AND a.Inativas <> 2" + ;
522:                        " AND c.Emps = " + EscaparSQL(loc_cEmpresa) + ;
523:                        " ORDER BY a.iclis"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formcnl.prg
- BO: C:\4c\projeto\app\classes\cnlBO.prg

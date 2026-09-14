CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2882: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~2882: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.cimps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPdM10BO.prg):

--- BO Linhas 697 a 707 ---
697:         LOCAL loc_nPrinters, loc_aPrinters, loc_nI
698:         loc_lSucesso = .F.
699: 
700:         TRY
701:             loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b" + ;
702:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
703:                        " AND a.cimps = b.impres" + ;
704:                        " UNION ALL " + ;
705:                        "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
706:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
707:                        " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

--- BO Linhas 698 a 708 ---
698:         loc_lSucesso = .F.
699: 
700:         TRY
701:             loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b" + ;
702:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
703:                        " AND a.cimps = b.impres" + ;
704:                        " UNION ALL " + ;
705:                        "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
706:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
707:                        " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"
708: 

--- BO Linhas 702 a 712 ---
702:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
703:                        " AND a.cimps = b.impres" + ;
704:                        " UNION ALL " + ;
705:                        "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
706:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
707:                        " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"
708: 
709:             IF USED("cursor_4c_TmpCimp")
710:                 TABLEREVERT(.T., "cursor_4c_TmpCimp")
711:                 USE IN cursor_4c_TmpCimp
712:             ENDIF


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg
- BO: C:\4c\projeto\app\classes\SigPdM10BO.prg

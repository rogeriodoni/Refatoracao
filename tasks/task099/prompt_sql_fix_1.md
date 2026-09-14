CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~4754: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~4754: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.cImps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrefcx.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrefcxBO.prg):

--- BO Linhas 2722 a 2732 ---
2722:                 SELECT csSigCdmp
2723:                 INDEX ON Impres TAG Imprime FOR (lSituas = .T.)
2724:                 INDEX ON Impres TAG Impres
2725:                 GO TOP IN csSigCdmp
2726: 
2727:                 loc_lcSql = "Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = '" + ;
2728:                             ALLTRIM(gc_4c_UsuarioLogado) + "' And a.cImps = b.Impres And b.nTpImpres = ?loc_pTip " + ;
2729:                             "Union all " + ;
2730:                             "Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios='" + ;
2731:                             ALLTRIM(gc_4c_UsuarioLogado) + "' " + ;
2732:                             "And a.Grupos = b.GrAcess And b.Cimps = c.Impres And c.nTpImpres = ?loc_pTip"

--- BO Linhas 2723 a 2733 ---
2723:                 INDEX ON Impres TAG Imprime FOR (lSituas = .T.)
2724:                 INDEX ON Impres TAG Impres
2725:                 GO TOP IN csSigCdmp
2726: 
2727:                 loc_lcSql = "Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = '" + ;
2728:                             ALLTRIM(gc_4c_UsuarioLogado) + "' And a.cImps = b.Impres And b.nTpImpres = ?loc_pTip " + ;
2729:                             "Union all " + ;
2730:                             "Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios='" + ;
2731:                             ALLTRIM(gc_4c_UsuarioLogado) + "' " + ;
2732:                             "And a.Grupos = b.GrAcess And b.Cimps = c.Impres And c.nTpImpres = ?loc_pTip"
2733:                 IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpCimp") > 0

--- BO Linhas 2727 a 2737 ---
2727:                 loc_lcSql = "Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = '" + ;
2728:                             ALLTRIM(gc_4c_UsuarioLogado) + "' And a.cImps = b.Impres And b.nTpImpres = ?loc_pTip " + ;
2729:                             "Union all " + ;
2730:                             "Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios='" + ;
2731:                             ALLTRIM(gc_4c_UsuarioLogado) + "' " + ;
2732:                             "And a.Grupos = b.GrAcess And b.Cimps = c.Impres And c.nTpImpres = ?loc_pTip"
2733:                 IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpCimp") > 0
2734:                     SELECT CrTmpCimp
2735:                     IF RECCOUNT() > 0
2736:                         loc_llFlags = .F.
2737:                         SELECT DISTINCT Impres FROM CrTmpCimp INTO CURSOR LocalcImp READWRITE


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrefcx.prg
- BO: C:\4c\projeto\app\classes\sigrefcxBO.prg

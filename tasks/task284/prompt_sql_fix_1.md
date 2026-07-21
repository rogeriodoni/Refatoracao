CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2758: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~2758: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.CImps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):

--- BO Linhas 169 a 179 ---
169:             LOCAL loc_cSql, loc_cSqlGrupo
170: 
171:             *-- Impressoras do sistema autorizadas ao usuario via usuario direto
172:             loc_cSql = "SELECT b.Impres " + ;
173:                        "FROM SigSyImp a, SigCdmp b " + ;
174:                        "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
175:                        " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
176:                        "UNION ALL " + ;
177:                        "SELECT c.Impres " + ;
178:                        "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
179:                        "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;

--- BO Linhas 170 a 180 ---
170: 
171:             *-- Impressoras do sistema autorizadas ao usuario via usuario direto
172:             loc_cSql = "SELECT b.Impres " + ;
173:                        "FROM SigSyImp a, SigCdmp b " + ;
174:                        "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
175:                        " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
176:                        "UNION ALL " + ;
177:                        "SELECT c.Impres " + ;
178:                        "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
179:                        "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
180:                        " AND a.Grupos = b.GrAcess " + ;

--- BO Linhas 176 a 186 ---
176:                        "UNION ALL " + ;
177:                        "SELECT c.Impres " + ;
178:                        "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
179:                        "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
180:                        " AND a.Grupos = b.GrAcess " + ;
181:                        "AND b.CImps = c.Impres AND c.nTpImpres = 2"
182: 
183:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCimp") <= 0
184:                 *-- Fallback: todas as impressoras de etiqueta
185:                 LOCAL loc_cSqlAll
186:                 loc_cSqlAll = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg
- BO: C:\4c\projeto\app\classes\SigPrEtqBO.prg

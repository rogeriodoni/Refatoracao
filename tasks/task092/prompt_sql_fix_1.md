CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~957: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~957: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.Cimps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigReEtp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReEtpBO.prg):

--- BO Linhas 152 a 162 ---
152: 
153:             *-- Consulta impressoras autorizadas para o usuario (acesso direto + por grupo)
154:             IF loc_lContinuar
155:                 loc_cSQL = "SELECT b.Impres, b.NtpImpres " + ;
156:                            "FROM SigSyImp a, SigCdmp b " + ;
157:                            "WHERE a.UsuAcess = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
158:                            " AND a.Cimps = b.Impres " + ;
159:                            "UNION ALL " + ;
160:                            "SELECT c.Impres, c.NtpImpres " + ;
161:                            "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
162:                            "WHERE a.Usuarios = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;

--- BO Linhas 153 a 163 ---
153:             *-- Consulta impressoras autorizadas para o usuario (acesso direto + por grupo)
154:             IF loc_lContinuar
155:                 loc_cSQL = "SELECT b.Impres, b.NtpImpres " + ;
156:                            "FROM SigSyImp a, SigCdmp b " + ;
157:                            "WHERE a.UsuAcess = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
158:                            " AND a.Cimps = b.Impres " + ;
159:                            "UNION ALL " + ;
160:                            "SELECT c.Impres, c.NtpImpres " + ;
161:                            "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
162:                            "WHERE a.Usuarios = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
163:                            " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

--- BO Linhas 158 a 168 ---
158:                            " AND a.Cimps = b.Impres " + ;
159:                            "UNION ALL " + ;
160:                            "SELECT c.Impres, c.NtpImpres " + ;
161:                            "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
162:                            "WHERE a.Usuarios = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
163:                            " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"
164: 
165:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp") < 1
166:                     MsgErro("Falha ao consultar impressoras do usu" + CHR(225) + "rio.", "Erro")
167:                     loc_nResult    = -1
168:                     loc_lContinuar = .F.


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigReEtp.prg
- BO: C:\4c\projeto\app\classes\SigReEtpBO.prg

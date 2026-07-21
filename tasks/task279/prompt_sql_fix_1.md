CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1176: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.Impres)
- [SQL-SCHEMA] Linha ~1176: Coluna 'ntpimpres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.nTpImpres)
- [SQL-SCHEMA] Linha ~1176: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.cimps)
- [SQL-SCHEMA] Linha ~1176: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.Impres)
- [SQL-SCHEMA] Linha ~1176: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 

-- Tabela: sigsyimp
CREATE TABLE [dbo].[SIGSYIMP](
	[cidchaves] [char](20) NOT NULL,
	[cimps] [char](30) NOT NULL,
	[gracess] [char](10) NOT NULL,
	[usuacess] [char](10) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigprenvBO.prg):

--- BO Linhas 14 a 24 ---
14:     this_nTipoEtq      = 6    && nTipos do SigCdTpe (6 = Envelope)
15:     this_cDescTipoEtq  = ""   && cEtiquetas do SigCdTpe
16: 
17:     *-- Impressora selecionada (Opt_Impressora)
18:     this_cNomeImpressora = ""  && Tag do botao = nome da impressora (UPPER)
19:     this_nTpImpressora   = 0   && nTpImpres do SigCdMp
20: 
21:     *-- Opcao de protocolo de impressao (Opcao_Imp: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
22:     this_nOpcaoImp     = 1
23: 
24:     *-- Ajustes de impressao (de SigCdPam e SigCdPac)

--- BO Linhas 141 a 151 ---
141:             ENDIF
142:             IF USED("cursor_4c_ImpTemp")
143:                 USE IN cursor_4c_ImpTemp
144:             ENDIF
145: 
146:             loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
147:                        "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
148:                        "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
149:                        "UNION ALL " + ;
150:                        "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
151:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;

--- BO Linhas 142 a 152 ---
142:             IF USED("cursor_4c_ImpTemp")
143:                 USE IN cursor_4c_ImpTemp
144:             ENDIF
145: 
146:             loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
147:                        "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
148:                        "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
149:                        "UNION ALL " + ;
150:                        "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
151:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
152:                        "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;

--- BO Linhas 143 a 153 ---
143:                 USE IN cursor_4c_ImpTemp
144:             ENDIF
145: 
146:             loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
147:                        "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
148:                        "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
149:                        "UNION ALL " + ;
150:                        "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
151:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
152:                        "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
153:                        "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)

--- BO Linhas 145 a 155 ---
145: 
146:             loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
147:                        "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
148:                        "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
149:                        "UNION ALL " + ;
150:                        "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
151:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
152:                        "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
153:                        "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)
154: 
155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0

--- BO Linhas 147 a 157 ---
147:                        "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
148:                        "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
149:                        "UNION ALL " + ;
150:                        "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
151:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
152:                        "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
153:                        "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)
154: 
155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
156:                 IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
157:                     SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;

--- BO Linhas 152 a 162 ---
152:                        "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
153:                        "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)
154: 
155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
156:                 IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
157:                     SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;
158:                         INTO CURSOR cursor_4c_Imp READWRITE
159:                 ELSE
160:                     loc_cSQL = "SELECT Impres, nTpImpres FROM SigCdMp"
161:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Imp")
162:                 ENDIF

--- BO Linhas 155 a 165 ---
155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
156:                 IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
157:                     SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;
158:                         INTO CURSOR cursor_4c_Imp READWRITE
159:                 ELSE
160:                     loc_cSQL = "SELECT Impres, nTpImpres FROM SigCdMp"
161:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Imp")
162:                 ENDIF
163: 
164:                 IF USED("cursor_4c_ImpTemp")
165:                     USE IN cursor_4c_ImpTemp


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg
- BO: C:\4c\projeto\app\classes\sigprenvBO.prg

CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1434: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.impres)
- [SQL-SCHEMA] Linha ~1434: Coluna 'ntpimpres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.ntpimpres)
- [SQL-SCHEMA] Linha ~1434: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.cimps)
- [SQL-SCHEMA] Linha ~1434: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.impres)
- [SQL-SCHEMA] Linha ~1434: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.usuacess)


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

--- BO Linhas 168 a 178 ---
168:         RETURN loc_lSucesso
169:     ENDFUNC
170: 
171:     *--------------------------------------------------------------------------
172:     * CarregarImpressoras - Carrega impressoras acessiveis pelo usuario logado
173:     * Cria cursor_4c_ImpAcessiveis com colunas impres, ntpimpres
174:     * Retorna .T. se sucesso
175:     *--------------------------------------------------------------------------
176:     FUNCTION CarregarImpressoras()
177:         LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
178:         loc_lSucesso = .F.

--- BO Linhas 184 a 194 ---
184:             ENDIF
185:             IF USED("cursor_4c_ImpTemp")
186:                 USE IN cursor_4c_ImpTemp
187:             ENDIF
188: 
189:             loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
190:                        "FROM SIGSYIMP a " + ;
191:                        "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
192:                        "WHERE a.usuacess = " + loc_cUsuario + ;
193:                        " UNION " + ;
194:                        "SELECT DISTINCT c.impres, c.ntpimpres " + ;

--- BO Linhas 186 a 196 ---
186:                 USE IN cursor_4c_ImpTemp
187:             ENDIF
188: 
189:             loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
190:                        "FROM SIGSYIMP a " + ;
191:                        "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
192:                        "WHERE a.usuacess = " + loc_cUsuario + ;
193:                        " UNION " + ;
194:                        "SELECT DISTINCT c.impres, c.ntpimpres " + ;
195:                        "FROM sigcdacg a " + ;
196:                        "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;

--- BO Linhas 187 a 197 ---
187:             ENDIF
188: 
189:             loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
190:                        "FROM SIGSYIMP a " + ;
191:                        "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
192:                        "WHERE a.usuacess = " + loc_cUsuario + ;
193:                        " UNION " + ;
194:                        "SELECT DISTINCT c.impres, c.ntpimpres " + ;
195:                        "FROM sigcdacg a " + ;
196:                        "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
197:                        "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;

--- BO Linhas 189 a 199 ---
189:             loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
190:                        "FROM SIGSYIMP a " + ;
191:                        "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
192:                        "WHERE a.usuacess = " + loc_cUsuario + ;
193:                        " UNION " + ;
194:                        "SELECT DISTINCT c.impres, c.ntpimpres " + ;
195:                        "FROM sigcdacg a " + ;
196:                        "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
197:                        "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
198:                        "WHERE a.usuarios = " + loc_cUsuario
199: 

--- BO Linhas 192 a 202 ---
192:                        "WHERE a.usuacess = " + loc_cUsuario + ;
193:                        " UNION " + ;
194:                        "SELECT DISTINCT c.impres, c.ntpimpres " + ;
195:                        "FROM sigcdacg a " + ;
196:                        "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
197:                        "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
198:                        "WHERE a.usuarios = " + loc_cUsuario
199: 
200:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
201:                 IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
202:                     SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;

--- BO Linhas 197 a 207 ---
197:                        "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
198:                        "WHERE a.usuarios = " + loc_cUsuario
199: 
200:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
201:                 IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
202:                     SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;
203:                         INTO CURSOR cursor_4c_ImpAcessiveis READWRITE
204:                     SELECT cursor_4c_ImpAcessiveis
205:                     IF USED("cursor_4c_ImpTemp")
206:                         USE IN cursor_4c_ImpTemp
207:                     ENDIF

--- BO Linhas 239 a 249 ---
239:                 USE IN cursor_4c_ConfigImp
240:             ENDIF
241: 
242:             loc_cSQL = "SELECT TOP 1 impetis, ajverts, ajhorzs, ajdens, ajvelos " + ;
243:                        "FROM SIGCDMP " + ;
244:                        "WHERE UPPER(RTRIM(impres)) = " + loc_cNome
245: 
246:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigImp") > 0
247:                 IF USED("cursor_4c_ConfigImp") AND !EOF("cursor_4c_ConfigImp")
248:                     SELECT cursor_4c_ConfigImp
249:                     THIS.this_nTpImp   = NVL(impetis, THIS.this_nImpEtis)


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

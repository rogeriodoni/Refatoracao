CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1182: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1182: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1182: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: logauditoria
CREATE TABLE [dbo].[LogAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [varchar](100) NOT NULL,
	[Operacao] [varchar](10) NOT NULL,
	[ChaveRegistro] [varchar](100) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[DadosAnteriores] [nvarchar](max) NULL,
	[DadosNovos] [nvarchar](max) NULL,
	[IP] [varchar](50) NULL,
	[Estacao] [varchar](100) NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigproer.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigproerBO.prg):

--- BO Linhas 13 a 23 ---
13:     this_cData       = ""   && Data da transacao original
14:     this_cHora       = ""   && Hora da transacao original
15:     this_cValor      = ""   && Valor da transacao (string formatada para DLL)
16:     this_cCodEstabs  = ""   && Codigo do estabelecimento
17: 
18:     *-- Dados da empresa carregados de SigCdEmp
19:     this_cEmpresa    = ""   && Cemps char(3)
20:     this_cIdTerminal = ""   && Identificador do terminal composto (Empresa+Caixa)
21: 
22:     *-- Estado do protocolo SiTef (equivalente as PUBLICs do legado)
23:     this_nProximoComando = 0    && ProximoComando

--- BO Linhas 15 a 25 ---
15:     this_cValor      = ""   && Valor da transacao (string formatada para DLL)
16:     this_cCodEstabs  = ""   && Codigo do estabelecimento
17: 
18:     *-- Dados da empresa carregados de SigCdEmp
19:     this_cEmpresa    = ""   && Cemps char(3)
20:     this_cIdTerminal = ""   && Identificador do terminal composto (Empresa+Caixa)
21: 
22:     *-- Estado do protocolo SiTef (equivalente as PUBLICs do legado)
23:     this_nProximoComando = 0    && ProximoComando
24:     this_nTipoCampo      = 0    && TipoCampo
25:     this_nTamanhoMinimo  = 0    && TamanhoMinimo

--- BO Linhas 184 a 194 ---
184:             IF EMPTY(loc_cEmpresa) AND TYPE("go_4c_Sistema") = "O"
185:                 loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
186:             ENDIF
187: 
188:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
189:                        "(DataHora, Usuario, Empresa, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
190:                        "VALUES (GETDATE(), " + ;
191:                        EscaparSQL(LEFT(loc_cUsuario, 20)) + ", " + ;
192:                        EscaparSQL(LEFT(loc_cEmpresa, 3)) + ", " + ;
193:                        EscaparSQL("SIGPROER") + ", " + ;
194:                        EscaparSQL(LEFT(loc_cChave, 50)) + ", " + ;

--- BO Linhas 206 a 216 ---
206:         RETURN .T.
207:     ENDPROC
208: 
209:     *--------------------------------------------------------------------------
210:     FUNCTION CarregarDadosEmpresa()
211:         *-- Carrega codigo empresa de SigCdEmp e monta IdTerminal
212:         LOCAL loc_cSQL, loc_lSucesso, loc_oErro
213:         loc_lSucesso = .F.
214:         TRY
215:             loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
216:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0 AND ;

--- BO Linhas 221 a 231 ---
221:                 THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
222:             ENDIF
223:             IF USED("cursor_4c_Emp")
224:                 USE IN cursor_4c_Emp
225:             ENDIF
226:             *-- ID loja: pcCodEstabs se informado, senao "00000" + empresa
227:             IF EMPTY(THIS.this_cCodEstabs)
228:                 THIS.this_cIdTerminal = "00000" + THIS.this_cEmpresa
229:             ELSE
230:                 THIS.this_cIdTerminal = THIS.this_cCodEstabs
231:             ENDIF

--- BO Linhas 240 a 250 ---
240:     FUNCTION IniciarProtocolo()
241:         *-- Chama ConfiguraIntSiTefInterativo e IniciaFuncaoSiTefInterativo
242:         LOCAL loc_lSucesso, loc_cValores, loc_oErro
243:         loc_lSucesso = .F.
244:         TRY
245:             *-- ID terminal = empresa + caixa (6 digitos)
246:             LOCAL loc_cIdTerminal
247:             loc_cIdTerminal = ALLTRIM(THIS.this_cEmpresa) + ;
248:                               TRANSFORM(VAL(THIS.this_cCaixa), "@L 999999")
249: 
250:             IF ConfiguraIntSiTefInterativo(THIS.this_cEndSitef, THIS.this_cIdTerminal, loc_cIdTerminal, 0) <> 0


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigproer.prg
- BO: C:\4c\projeto\app\classes\sigproerBO.prg

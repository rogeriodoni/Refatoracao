CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1402: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1402: INSERT coluna 'observacao' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrItbBO.prg):

--- BO Linhas 160 a 170 ---
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     * RegistrarAuditoria - Registra em LogAuditoria a operacao de integracao
164:     * Sobrescreve BusinessBase para gravar dados de contexto do processamento
165:     * (periodo, empresa filtrada) na coluna Observacao.
166:     *--------------------------------------------------------------------------
167:     PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
168:         LOCAL loc_lResultado, loc_cSQL, loc_cChave, loc_cObs, loc_cEmp, loc_oErro
169:         loc_lResultado = .F.
170:         TRY

--- BO Linhas 173 a 183 ---
173:                 loc_cChave = "INTEGRACAO"
174:             ENDIF
175:             loc_cEmp = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
176:             loc_cObs = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + ;
177:                        " a " + DTOC(THIS.this_dDataFim) + " | Empresa: " + loc_cEmp
178:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, ChavePrimaria, Operacao, Usuario, DataHora, Observacao) " + ;
179:                        "VALUES (" + EscaparSQL("SigMvCcr") + ", " + ;
180:                                     EscaparSQL(LEFT(loc_cChave, 50)) + ", " + ;
181:                                     EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
182:                                     EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20)) + ", " + ;
183:                                     "GETDATE(), " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg
- BO: C:\4c\projeto\app\classes\SigPrItbBO.prg

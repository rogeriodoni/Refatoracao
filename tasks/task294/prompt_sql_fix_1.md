CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1721: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1721: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):

--- BO Linhas 80 a 90 ---
80:     *--------------------------------------------------------------------------
81:     * ValidarDados - Valida campos obrigatorios do filtro
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ValidarDados()
84:         IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
85:             THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa"
86:             RETURN .F.
87:         ENDIF
88:         IF EMPTY(ALLTRIM(THIS.this_cGrEstoque))
89:             THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo de Estoque"
90:             RETURN .F.

--- BO Linhas 199 a 209 ---
199:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp1") < 1
200:                     MsgErro("Falha na consulta de estoques abaixo do m" + CHR(237) + "nimo", "Erro")
201:                     loc_lResultado = .F.
202:                 ENDIF
203: 
204:                 *-- Produtos que NAO tem registro em SigMvEst para esta empresa/grupo/conta
205:                 loc_cChave = PADR(loc_cEmpresa, 3) + PADR(loc_cGrEstoque, 10) + PADR(loc_cEstoque, 10)
206:                 loc_cSQL = "SELECT cpros, qmins, ifors, pvens, moevs, dpros " + ;
207:                     "FROM SigCdPro " + ;
208:                     "WHERE linhas = " + EscaparSQL(loc_cLinha) + ;
209:                     " AND qmins > 0 AND situas = 1 " + ;

--- BO Linhas 547 a 557 ---
547:     *--------------------------------------------------------------------------
548:     PROCEDURE RegistrarAuditoria(par_cOperacao)
549:         LOCAL loc_cSQL
550:         TRY
551:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
552:                 "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Empresa) " + ;
553:                 "VALUES (" + ;
554:                 EscaparSQL("SigMvCab") + ", " + ;
555:                 EscaparSQL(par_cOperacao) + ", " + ;
556:                 EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
557:                 EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg
- BO: C:\4c\projeto\app\classes\SigPrGmiBO.prg

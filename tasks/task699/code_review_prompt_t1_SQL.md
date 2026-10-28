# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COCOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NUMS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcUpDate = [Update SigChe Set Vencs = ?llVenc, DtAlts = ?lDtAlt Where Nums = ']+CrSigChe.Nums+[']
lnErro   = ThisForm.ParentForm.Podatamgr.SqlExecute(lcUpDate,'')
SELECT CrSigChe
Select CrSigChea
Select CrSigMvCcr
Select CrSigClLan
Insert Into CrSigChea (nums,vencs,usuars,vjuros,pjuros,datas,CidChaves) ;
ThisForm.ParentForm.podatamgr.Update('CrSigChea')
Select crSigCdPam
	Select crSigMvCcr
	Select crSigMvCcr
	select crSigMvCcr
	ThisForm.ParentForm.podatamgr.Update('CrSigMvCcr')
	Select CrChea
		Select CrSigClLan
		If Not ThisForm.ParentForm.podatamgr.Update('CrSigClLan')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChp.prg) - TRECHOS RELEVANTES PARA PASS SQL (887 linhas total):

*-- Linhas 1 a 35:
1: *==============================================================================
2: * FormSigOpChp.prg - Form Operacional: Prorrogar Vencimento de Cheque
3: * Migrado de: tasks/task699/SIGOPCHP.SCX
4: * Tabelas (via SigOpChpBO): SigChe (UPDATE), SigChea (historico), SigMvCcr
5: * (juros), SigClLan (bloqueio por atraso)
6: *
7: * Dialogo filho da Historico de Cheques (FormSigOpChi), aberto passando a
8: * referencia do form pai (equivalente a Lparameters pOldForm / ThisForm.
9: * ParentForm no legado - FormSigOpChi.AcaoProrrogaClick ja chama
10: * CREATEOBJECT("FormSigOpChp", THIS)). Layout CUSTOMIZADO - NAO segue o
11: * padrao CRUD Page1=Lista/Page2=Dados: cabecalho + 2 shapes decorativos +
12: * campos de vencimento/dias/juros direto no Form, com os botoes Prorrogar e
13: * Cancelar.
14: *
15: * SUPERFICIE ENTREGUE x TEMPLATE CRUD
16: * -----------------------------------
17: * Implementados porque existem no legado:
18: *   CarregarCheque       -> localiza o cheque (CrSigChe ja posicionado pelo
19: *                           form pai no legado; aqui via this_cNums + BO.Buscar)
20: *   BOParaForm/FormParaBO-> os ControlSource vazios do Get_Venc/Dias/Juros/
21: *                           ValJuros, aqui centralizados nas properties do BO
22: *   ValidarVenc/Dias/Juros-> os PROCEDURE Valid dos 3 campos digitaveis
23: *   BtnProrrogarClick     -> Prorroga.Click (guard + grava via BO.Salvar)
24: *   BtnCancelarClick      -> btnCancela.Click (ThisForm.Release)
25: *
26: * Deliberadamente AUSENTES - o legado nao tem a superficie, e cria-los seria
27: * inventar (viola o PILAR 1) ou escrever metodo vazio (stub, proibido pela
28: * regra de completude):
29: *   handlers de Incluir/Alterar/Excluir/Buscar e habilitacao de campos por
30: *       modo -> nao ha grid nem lista neste dialogo: um UNICO cheque, ja
31: *       localizado pelo form pai, eh editado em modo unico
32: *   Get_ValJuros nao recebe handler de entrada -> PROCEDURE When do legado
33: *       retorna .f. (o campo nunca entra em edicao); aqui o equivalente eh
34: *       .ReadOnly = .T. + .TabStop = .F. no AddObject
35: *   AbrirLookup*/AbrirBusca* -> este legado NAO TEM LOOKUP ALGUM (medido, ver

*-- Linhas 58 a 80:
58: * portanto nao tem onde digitar codigo para um picker resolver.
59: *
60: * Perfil de gate: OPERACIONAL / CAPTURA - o legado nao tem lista, TEM campos
61: * de ENTRADA e nao vincula nenhum a dado (os 4 declaram ControlSource = "",
62: * override VAZIO que por regra #49 nao se transcreve; por isso o migrado nao
63: * tem .ControlSource algum). Mesmo perfil do precedente SIGPRCFN/task589.
64: *
65: * Toda a logica de gravacao (UPDATE SigChe, INSERT SigChea, lancamento de
66: * juros em SigMvCcr, bloqueio por atraso em SigClLan, fRecalculaS + commit/
67: * rollback) ja foi migrada para SigOpChpBO.Atualizar() (Fases 1-2) - este
68: * form so chama THIS.this_oBusinessObject.Salvar(), que delega para la.
69: *
70: * FASE 7 (Form - Eventos Principais): o dump legado tem EXATAMENTE 2
71: * CommandButton (Prorroga + btnCancela, ver layout.json) - nao 0, nao 1 -
72: * entao o piso de handlers da fase (minHandlersF7 = 2, feedback_gate_fase7_
73: * piso_dois_handlers) ja esta satisfeito pelos dois unicos botoes que o
74: * legado tem: BtnProrrogarClick (linha ~677, equivalente a Prorroga.Click) e
75: * BtnCancelarClick (linha ~702, equivalente a btnCancela.Click), ambos
76: * registrados via BINDEVENT em ConfigurarBotoesAcao e com corpo completo (TRY
77: * implicito via Salvar()/Release(), sem stub). Os 4 nomes-padrao do template
78: * CRUD (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
79: * seguem Deliberadamente AUSENTES pelo motivo ja medido e documentado acima
80: * (SUPERFICIE ENTREGUE x TEMPLATE CRUD) - nao ha grid, nao ha modo, um unico

*-- Linhas 95 a 131:
95: *    this_nJuros    (Get_Juros)         | FormParaBO         | SIM
96: *    this_nValJuros (Get_ValJuros)      | FormParaBO         | SIM
97: *    this_cNums / this_dVencs /         | CarregarDoCursor   | nao
98: *      this_nValors / this_cBancos /    |  (SELECT SigChe,   |
99: *      this_cAgencias / this_cNContas / |   via CarregarCheque)
100: *      this_cNCheques / this_cIClis /   |                    |
101: *      this_cGrClis                     |                    |
102: *    this_cContaJuros/this_cGrupoJuros/ | CarregarParametros-| nao
103: *      this_cMoedaCheqs/this_nDiaPrors  |  Sistema (SigCdPam)|
104: *    this_cSigKey                       | idem (SigCdPac)    | nao
105: *    this_lParametrosCarregados         | flag interna do BO | nao
106: *
107: *    Os QUATRO campos da tela estao nos DOIS sentidos (FormParaBO e
108: *    BOParaForm), que eh o que a fase cobra. As outras 14 properties NAO
109: *    entram nos hooks de proposito: elas vem do BANCO (cursor de SigChe e
110: *    parametros de SigCdPam/SigCdPac), exatamente como no legado, onde
111: *    CrSigChe/crSigCdPam/CrSigCdPac ja chegam prontos do form pai. Passa-las
112: *    pela tela seria inventar campo que o legado nao tem; nenhuma delas tem
113: *    controle correspondente no dump (os 4 Get_* do SCX sao os 4 acima).
114: *
115: * 2) REPINTE DA LISTA DO PAI - unica superficie que FALTAVA. O legado nao
116: *    para no UPDATE: ele reescreve a linha no cursor do form pai
117: *    (Prorroga.Click:498-500, "Replace Vencs With ThisForm.Get_Venc.Value,
118: *    DtAlts With Datetime()" em CrSigChe, que eh o RecordSource da grade do
119: *    pai). Migrado como AtualizarFormPai(), chamado logo apos Salvar() em
120: *    BtnProrrogarClick. Sem ele a grade da "Historico de Cheques" continuava
121: *    exibindo o vencimento ANTIGO depois de prorrogar - variante ENTRE FORMS
122: *    da regra #21 ("popular cursor NAO repinta a grade").
123: *
124: * 3) NOMES DO TEMPLATE CRUD SEM REFERENTE NESTE LEGADO. A fase pede, pelo
125: *    template, BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/CarregarLista/
126: *    HabilitarCampos/LimparCampos/AjustarBotoesPorModo. Medido no dump: o
127: *    legado tem DOIS CommandButton (Prorroga, btnCancela) e mais nada -
128: *    cria-los aqui seria inventar superficie (PILAR 1) ou escrever metodo
129: *    vazio (stub, proibido pela regra de completude). Um a um:
130: *      BtnSalvarClick    -> o botao de gravar DESTE legado se chama
131: *                           "Prorrogar"; o handler eh BtnProrrogarClick,

*-- Linhas 593 a 611:
593:     ENDPROC
594: 
595:     *--------------------------------------------------------------------------
596:     * BOParaForm - sentido BO -> tela dos ControlSource vazios do legado
597:     * (os 4 campos ficam vazios/zero ate o usuario digitar - o legado tambem
598:     * nao pre-popula Get_Venc com o vencimento atual).
599:     *
600:     * PROTECTED obrigatoriamente: FormBase declara BOParaForm/FormParaBO/
601:     * LimparCampos como PROTECTED e o VFP9 nao permite ALARGAR o escopo de
602:     * metodo herdado. Os chamadores sao todos internos a esta classe.
603:     *--------------------------------------------------------------------------
604:     PROTECTED PROCEDURE BOParaForm()
605:         IF !PEMSTATUS(THIS, "txt_4c_Venc", 5) OR VARTYPE(THIS.this_oBusinessObject) != "O"
606:             RETURN
607:         ENDIF
608: 
609:         THIS.txt_4c_Venc.Value     = THIS.this_oBusinessObject.this_dVencNovo
610:         THIS.txt_4c_Dias.Value     = THIS.this_oBusinessObject.this_nDias
611:         THIS.txt_4c_Juros.Value    = THIS.this_oBusinessObject.this_nJuros

*-- Linhas 645 a 663:
645:         loc_lSucesso = .F.
646: 
647:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(ALLTRIM(THIS.this_cNums))
648:             IF THIS.this_oBusinessObject.Buscar("nums = " + EscaparSQL(ALLTRIM(THIS.this_cNums)))
649:                 loc_cCursor = THIS.this_oBusinessObject.this_oDataAccess.this_cCursorName
650: 
651:                 IF THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
652:                     loc_lSucesso = THIS.this_oBusinessObject.EditarRegistro()
653:                 ENDIF
654: 
655:                 IF USED(loc_cCursor)
656:                     USE IN (loc_cCursor)
657:                 ENDIF
658:             ENDIF
659:         ENDIF
660: 
661:         RETURN loc_lSucesso
662:     ENDPROC
663: 

*-- Linhas 768 a 786:
768:     * BtnProrrogarClick - equivalente a Prorroga.Click do legado: guard de
769:     * vencimento obrigatorio (Wait Window -> MsgAviso + SetFocus, regra de
770:     * UI usa MsgAviso), transfere para o BO e grava via Salvar() (que
771:     * delega para SigOpChpBO.Atualizar() - UPDATE SigChe + historico + juros
772:     * + bloqueio + commit/rollback, ja migrados nas Fases 1-2).
773:     *
774:     * Sem ELSE apos Salvar() (regra #20 - BusinessBase ja exibe a falha,
775:     * com o MsgErro especifico de cada etapa do Atualizar ou via
776:     * ExibirFalha quando a subclasse so marcou this_cMensagemErro).
777:     *--------------------------------------------------------------------------
778:     PROCEDURE BtnProrrogarClick()
779:         IF ISNULL(THIS.txt_4c_Venc.Value) OR EMPTY(THIS.txt_4c_Venc.Value)
780:             MsgAviso("Vencimento n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
781:             THIS.txt_4c_Venc.SetFocus()
782:             RETURN
783:         ENDIF
784: 
785:         *-- FormParaBO devolve .F. quando os campos ainda nao existem (form
786:         *-- nao montado). Seguir adiante chamaria Salvar() com as properties

*-- Linhas 800 a 820:
800:     *--------------------------------------------------------------------------
801:     * AtualizarFormPai - repinta a lista do form PAI com o vencimento novo.
802:     *
803:     * O legado NAO se limita ao UPDATE: logo depois dele ele reescreve a
804:     * linha no cursor do form pai (Prorroga.Click:498-500)
805:     *     SELECT CrSigChe
806:     *     Replace Vencs With ThisForm.Get_Venc.Value, DtAlts With Datetime()
807:     * e, como CrSigChe eh justamente o RecordSource da grade do pai (a
808:     * "Historico de Cheques"), o usuario ve o vencimento novo na lista no
809:     * instante em que o dialogo fecha.
810:     *
811:     * Aqui (PILAR 3 - sem cursor global compartilhado entre os dois forms) o
812:     * equivalente eh pedir ao pai que recarregue a propria lista: o cheque
813:     * acabou de ser gravado em SigChe, entao a releitura traz o vencimento
814:     * novo. Sem isto a grade do pai continuaria exibindo o vencimento ANTIGO
815:     * - cursor certo no banco e grade visualmente defasada, o sintoma que a
816:     * regra #21 descreve ("popular cursor NAO repinta a grade"), aqui na sua
817:     * variante entre forms.
818:     *
819:     * Guardas: o form pai eh OPCIONAL (this_oParentForm = .NULL. quando o
820:     * dialogo eh instanciado sem pai, p.ex. no harness de teste), e nem todo


### BO (C:\4c\projeto\app\classes\SigOpChpBO.prg):
*====================================================================
* SigOpChpBO.prg
*
* Business Object para SigOpChp (Prorrogar vencimento de cheque)
* Tabela principal: SigChe (chave: nums)
*
* Form original: dialogo modal MODAL aberto a partir de um form pai
* (ThisForm.ParentForm), que prorroga o vencimento de um cheque
* (SigChe), calcula e grava juros de prorrogacao (SigMvCcr) e
* registra o historico de alteracao de vencimento (SigChea).
*====================================================================

DEFINE CLASS SigOpChpBO AS BusinessBase

	*-- Dados do cheque sendo prorrogado (SigChe)
	this_cNums = ""
	this_dVencs = {}
	this_nValors = 0
	this_cBancos = ""
	this_cAgencias = ""
	this_cNContas = ""
	this_cNCheques = ""
	this_cIClis = ""
	this_cGrClis = ""

	*-- Dados digitados/calculados na tela de prorrogacao
	this_dVencNovo = {}
	this_nDias = 0
	this_nJuros = 0
	this_nValJuros = 0

	*-- Parametros do sistema (SigCdPam) usados na prorrogacao
	this_cMoedaCheqs = ""
	this_cContaJuros = ""
	this_cGrupoJuros = ""
	this_nDiaPrors = 0

	*-- Chave de sessao do usuario (CrSigCdPac.SigKeys)
	this_cSigKey = ""

	*-- Flag: .T. depois da 1a chamada de CarregarParametrosSistema()
	this_lParametrosCarregados = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigChe"
		THIS.this_cCampoChave = "nums"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Nums (char(8)) do cheque sendo prorrogado
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cNums
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia os campos de SigChe (par_cAliasCursor)
	* para as propriedades de exibicao do dialogo. Os campos digitados
	* pelo usuario (this_dVencNovo/this_nDias/this_nJuros/this_nValJuros)
	* NAO sao tocados aqui - ficam vazios/zero, a espera da digitacao.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cNums     = ALLTRIM(TratarNulo(nums, ""))
			THIS.this_dVencs    = TratarNulo(vencs, {})
			THIS.this_nValors   = TratarNulo(valors, 0)
			THIS.this_cBancos   = ALLTRIM(TratarNulo(bancos, ""))
			THIS.this_cAgencias = ALLTRIM(TratarNulo(agencias, ""))
			THIS.this_cNContas  = ALLTRIM(TratarNulo(ncontas, ""))
			THIS.this_cNCheques = ALLTRIM(TratarNulo(ncheques, ""))
			THIS.this_cIClis    = ALLTRIM(TratarNulo(iclis, ""))
			THIS.this_cGrClis   = ALLTRIM(TratarNulo(grclis, ""))

			THIS.this_lNovoRegistro = .F.
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Unica validacao do legado (Prorroga.Click:483-487):
	* o novo vencimento nao pode ficar em branco.
	*====================================================================
	PROCEDURE ValidarDados()
		IF ISNULL(THIS.this_dVencNovo) OR EMPTY(THIS.this_dVencNovo)
			THIS.this_cMensagemErro = "Vencimento n" + CHR(227) + "o pode ficar em branco!"
			RETURN .F.
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarParametrosSistema - Carrega os parametros de SigCdPam
	* (Conta/Grupo de Juros, Moeda de Cheques, Dias para bloqueio) e a
	* chave de sessao de SigCdPac.SigKeys (Init do legado:400-403).
	* Chamado de forma preguicosa (lazy) a partir de Atualizar(), para
	* o BO ficar autossuficiente independente da ordem de chamada do form.
	*====================================================================
	PROTECTED PROCEDURE CarregarParametrosSistema()
		LOCAL loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Pam")
				USE IN cursor_4c_Pam
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 contajuros, grupojuros, moedacheqs, diaprors FROM SigCdPam", ;
				"cursor_4c_Pam")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pam") > 0
				SELECT cursor_4c_Pam
				THIS.this_cContaJuros = ALLTRIM(NVL(contajuros, ""))
				THIS.this_cGrupoJuros = ALLTRIM(NVL(grupojuros, ""))
				THIS.this_cMoedaCheqs = IIF(EMPTY(ALLTRIM(NVL(moedacheqs, ""))), "R", ALLTRIM(moedacheqs))
				THIS.this_nDiaPrors   = NVL(diaprors, 0)
			ENDIF

			IF USED("cursor_4c_Pam")
				USE IN cursor_4c_Pam
			ENDIF

			IF USED("cursor_4c_Pac")
				USE IN cursor_4c_Pac
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 sigkeys FROM SigCdPac", "cursor_4c_Pac")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pac") > 0
				SELECT cursor_4c_Pac
				THIS.this_cSigKey = ALLTRIM(NVL(sigkeys, ""))
			ENDIF

			IF USED("cursor_4c_Pac")
				USE IN cursor_4c_Pac
			ENDIF

			THIS.this_lParametrosCarregados = .T.
			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarCidChaveMvCcr - Reproduz a formula do legado (Prorroga.Click:
	* 530/579) para a CidChaves de cada lancamento de SigMvCcr:
	*   pCidC = Dtos(Datetime()) + Transform(fGerUniqueKey(Dtos(Datetime())),
	*           "@L 999999") + ThisForm.sigkey
	* Chamada DUAS vezes (uma por linha) para gerar valores distintos -
	* fGerUniqueKey incrementa a sequencia a cada chamada.
	*====================================================================
	PROTECTED PROCEDURE GerarCidChaveMvCcr()
		RETURN LEFT(DTOS(DATETIME()) + ;
			TRANSFORM(fGerUniqueKey(DTOS(DATETIME())), "@L 999999") + ;
			THIS.this_cSigKey, 20)
	ENDPROC

	*====================================================================
	* AdicionarCampoSQL - Acumula par (coluna, valor-SQL-ja-formatado) nas
	* strings de colunas/valores passadas por referencia. Usado para
	* montar o INSERT de SigMvCcr (78 colunas NOT NULL - regra #22) sem
	* risco de desalinhamento por contagem manual de virgulas: cada
	* coluna e o seu valor ficam juntos na MESMA linha de chamada.
	*====================================================================
	PROTECTED PROCEDURE AdicionarCampoSQL(par_cCols, par_cVals, par_cColuna, par_cValorSQL)
		par_cCols = par_cCols + IIF(EMPTY(par_cCols), "", ",") + par_cColuna
		par_cVals = par_cVals + IIF(EMPTY(par_cVals), "", ",") + par_cValorSQL
	ENDPROC

	*====================================================================
	* MontarLancamentoSigMvCcr - Monta o INSERT de uma linha de SigMvCcr,
	* cobrindo as 74 colunas NOT NULL da tabela + vencs/datas/datalts/
	* hists (nullable, mas sempre preenchidas pelo legado). Colunas nao
	* referenciadas pelo Prorroga.Click do legado (regra #22) recebem o
	* mesmo "branco"/"zero" que o Append Blank do cursor legado geraria.
	*
	* Parametros:
	*   par_cCidChave  - CidChaves (PK) desta linha
	*   par_cGrupo/par_cConta/par_cMoeda/par_nCotacao/par_nValor - lado
	*     principal (grupos/contas/moedas/cotacaos/valors/opers)
	*   par_cOpers     - "C" ou "D" (lado principal)
	*   par_cSGrupo/par_cSConta/par_cSMoeda/par_nSCotacao/par_nSValor -
	*     lado contrapartida (sgrupos/scontas/smoedas/scotacaos/svalors)
	*   par_cSOpers    - "C" ou "D" (lado contrapartida, oposto de par_cOpers)
	*   par_nNoper     - numero da operacao (fGerUniqueKey, igual nas 2 linhas)
	*   par_cHist      - texto de historico (igual nas 2 linhas)
	*   par_tDatas     - data/hora da operacao (datas/vencs)
	*   par_tDatalts   - data/hora da ultima alteracao (datalts)
	*====================================================================
	PROTECTED PROCEDURE MontarLancamentoSigMvCcr(par_cCidChave, ;
			par_cGrupo, par_cConta, par_cMoeda, par_nCotacao, par_nValor, par_cOpers, ;
			par_cSGrupo, par_cSConta, par_cSMoeda, par_nSCotacao, par_nSValor, par_cSOpers, ;
			par_nNoper, par_cHist, par_tDatas, par_tDatalts)

		LOCAL loc_cCols, loc_cVals, loc_cGruConMoes
		loc_cCols = ""
		loc_cVals = ""
		loc_cGruConMoes = LEFT(PADR(par_cGrupo, 10) + PADR(par_cConta, 10) + PADR(par_cMoeda, 3), 23)

		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "autos", "1")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "concs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contages", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contas", EscaparSQL(par_cConta))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contems", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cotacaos", FormatarNumeroSQL(par_nCotacao, 7))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "datalts", FormatarDataSQL(par_tDatalts))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "datas", FormatarDataSQL(par_tDatas))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "docus", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopes", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "emps", EscaparSQL(go_4c_Sistema.cCodEmpresa))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupages", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupems", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupos", EscaparSQL(par_cGrupo))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "hists", EscaparSQL(par_cHist))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "locals", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "moedas", EscaparSQL(par_cMoeda))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nlancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nopers", FormatarNumeroSQL(par_nNoper, 0))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "ntrans", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "numes", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "opers", EscaparSQL(par_cOpers))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldocs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldons", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "scontas", EscaparSQL(par_cSConta))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "scotacaos", FormatarNumeroSQL(par_nSCotacao, 7))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "sgrupos", EscaparSQL(par_cSGrupo))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "shists", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "smoedas", EscaparSQL(par_cSMoeda))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "sopers", EscaparSQL(par_cSOpers))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "svalors", FormatarNumeroSQL(par_nSValor, 2))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tipos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titbans", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titulos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usualts", EscaparSQL(gc_4c_UsuarioLogado))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuexcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valliqs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valocurs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valors", FormatarNumeroSQL(par_nValor, 2))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valpags", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vencs", FormatarDataSQL(par_tDatas))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vlancs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vopers", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contapgs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "numcs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cotusus", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "bcontas", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "bgrupos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "borderos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "intconts", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuconcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "auditors", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valprev", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cidchaves", EscaparSQL(par_cCidChave))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empdopncs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empdopnums", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "gruconmoes", EscaparSQL(loc_cGruConMoes))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "pagos", EscaparSQL("1"))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopotps", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usupagos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titcancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuconfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nopercancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "especienfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "jobs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "impostos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tpimpostos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titpais", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empccs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "recor", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "compet", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "oridopnums", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "rcontas", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tpdocnf", EscaparSQL(""))

		RETURN "INSERT INTO SigMvCcr (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
	ENDPROC

	*====================================================================
	* Atualizar - Prorroga o vencimento do cheque (Prorroga.Click, linha
	* a linha):
	*   1) UPDATE SigChe (novo vencimento + data de alteracao)
	*   2) INSERT SigChea (historico da prorrogacao)
	*   3) Se houver juros calculados, grava o lancamento em partida
	*      dobrada em SigMvCcr (linha "C" na Conta/Grupo de Juros do
	*      parametro + linha "D" espelhada do lado do cliente) e
	*      acumula o recalculo de saldos (fRecalculaS)
	*   4) Se o atraso (em dias) desde a 1a prorrogacao do cheque for
	*      >= SigCdPam.DiaPrors, registra o bloqueio (SigClLan, Cocos='05')
	*   5) Processa o recalculo de saldos acumulado (fRecalculaS(.T.))
	*
	* NUNCA ha RETURN dentro do TRY (regra #1) - o fluxo e controlado por
	* loc_lContinuar, e o COMMIT/ROLLBACK e decidido uma unica vez no fim.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lContinuar, loc_oErro
		LOCAL loc_tAgora, loc_dVencsAntigo, loc_nNoper, loc_cCidChave1, loc_cCidChave2
		LOCAL loc_cHist, loc_nDias, loc_dVencsHist, loc_nQtdBloqueio

		loc_lSucesso   = .F.
		loc_lContinuar = .T.

		TRY
			THIS.CarregarParametrosSistema()

			loc_tAgora       = DATETIME()
			loc_dVencsAntigo = THIS.this_dVencs

			*-- 1) UPDATE SigChe (Prorroga.Click:489-496)
			loc_cSQL = "UPDATE SigChe SET " + ;
				"vencs = " + FormatarDataSQL(THIS.this_dVencNovo) + "," + ;
				"dtalts = " + FormatarDataSQL(loc_tAgora) + ;
				" WHERE nums = " + EscaparSQL(THIS.this_cNums)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o novo vencimento:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lContinuar = .F.
			ENDIF

			*-- 2) INSERT SigChea - historico (Prorroga.Click:499-525). O
			*--    "vencs" gravado no historico e o vencimento ANTERIOR
			*--    (m.Vencs = _OVenc, capturado antes do UPDATE acima).
			IF loc_lContinuar
				loc_cSQL = "INSERT INTO SigChea (cidchaves, nums, vencs, usuars, vjuros, pjuros, datas, motivo)" + ;
					" VALUES (" + ;
					EscaparSQL(fUniqueIds()) + "," + ;
					EscaparSQL(THIS.this_cNums) + "," + ;
					FormatarDataSQL(loc_dVencsAntigo) + "," + ;
					EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
					FormatarNumeroSQL(THIS.this_nValJuros, 2) + "," + ;
					FormatarNumeroSQL(THIS.this_nJuros, 2) + "," + ;
					FormatarDataSQL(DATE()) + "," + ;
					EscaparSQL("") + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado < 0
					MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o hist" + CHR(243) + ;
						"rico da prorroga" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lContinuar = .F.
				ENDIF
			ENDIF

			*-- 3) Juros de prorrogacao: lancamento em partida dobrada em
			*--    SigMvCcr (Prorroga.Click:527-613), so quando ha valor
			*--    de juros calculado na tela.
			IF loc_lContinuar AND THIS.this_nValJuros > 0
				loc_nNoper     = fGerUniqueKey("SigMvCcr")
				loc_cHist      = go_4c_Sistema.cCodEmpresa + " JUROS PRORROG. CHEQUE " + ;
					ALLTRIM(THIS.this_cBancos) + "/" + ALLTRIM(THIS.this_cAgencias) + "/" + ;
					ALLTRIM(THIS.this_cNContas) + "/" + ALLTRIM(THIS.this_cNCheques)

				*-- 3a) Linha "C" - credito na Conta/Grupo de Juros do
				*--     parametro, contrapartida "D" do lado do cliente.
				loc_cCidChave1 = THIS.GerarCidChaveMvCcr()
				loc_cSQL = THIS.MontarLancamentoSigMvCcr(loc_cCidChave1, ;
					THIS.this_cGrupoJuros, THIS.this_cContaJuros, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "C", ;
					THIS.this_cGrClis, THIS.this_cIClis, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "D", ;
					loc_nNoper, loc_cHist, loc_tAgora, loc_tAgora)

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado < 0
					MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o juros de prorroga" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lContinuar = .F.
				ELSE
					fRecalculaS(THIS.this_cGrupoJuros, THIS.this_cContaJuros, DATE(), THIS.this_cMoedaCheqs)
				ENDIF

				*-- 3b) Linha "D" espelhada - mesma operacao (nopers),
				*--     lados invertidos (Prorroga.Click:579-613). O
				*--     datalts aqui usa DATE() (nao DATETIME()), fiel
				*--     ao quirk do legado nessa 2a linha.
				IF loc_lContinuar
					loc_cCidChave2 = THIS.GerarCidChaveMvCcr()
					loc_cSQL = THIS.MontarLancamentoSigMvCcr(loc_cCidChave2, ;
						THIS.this_cGrClis, THIS.this_cIClis, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "D", ;
						THIS.this_cGrupoJuros, THIS.this_cContaJuros, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "C", ;
						loc_nNoper, loc_cHist, loc_tAgora, DATE())

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

					IF loc_nResultado < 0
						MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a contrapartida do juros de " + ;
							"prorroga" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
						loc_lContinuar = .F.
					ELSE
						fRecalculaS(THIS.this_cGrClis, THIS.this_cIClis, DATE(), THIS.this_cMoedaCheqs)
					ENDIF
				ENDIF
			ENDIF

			*-- 4) Atraso desde a 1a prorrogacao -> bloqueio (Prorroga.Click:
			*--    617-646). Sem ORDER BY, fiel ao CursorQuery('SigChea',...)
			*--    legado, que tambem nao ordena antes do Go Top.
			IF loc_lContinuar
				loc_dVencsHist = {}

				loc_cSQL = "SELECT TOP 1 vencs FROM SigChea WHERE nums = " + EscaparSQL(THIS.this_cNums)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistChea")

				IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_HistChea") > 0
					SELECT cursor_4c_HistChea
					loc_dVencsHist = ConverterParaData(vencs)
				ENDIF

				IF USED("cursor_4c_HistChea")
					USE IN cursor_4c_HistChea
				ENDIF

				loc_nDias = 0
				IF !EMPTY(loc_dVencsHist)
					loc_nDias = ConverterParaData(THIS.this_dVencNovo) - loc_dVencsHist
				ENDIF

				IF loc_nDias >= THIS.this_nDiaPrors
					loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClLan WHERE grupos = " + EscaparSQL(THIS.this_cGrClis) + ;
						" AND contas = " + EscaparSQL(THIS.this_cIClis) + " AND cocos = '05'"
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLan")

					loc_nQtdBloqueio = 0
					IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkLan") > 0
						SELECT cursor_4c_ChkLan
						loc_nQtdBloqueio = NVL(qtd, 0)
					ENDIF

					IF USED("cursor_4c_ChkLan")
						USE IN cursor_4c_ChkLan
					ENDIF

					IF loc_nQtdBloqueio = 0
						loc_cSQL = "INSERT INTO SigClLan (cidchaves, grupos, contas, cocos, grucontas) VALUES (" + ;
							EscaparSQL(fUniqueIds()) + "," + ;
							EscaparSQL(THIS.this_cGrClis) + "," + ;
							EscaparSQL(THIS.this_cIClis) + "," + ;
							EscaparSQL("05") + "," + ;
							EscaparSQL(LEFT(PADR(THIS.this_cGrClis, 10) + PADR(THIS.this_cIClis, 10), 20)) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel registrar o bloqueio de atraso:" + ;
								CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lContinuar = .F.
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			*-- 5) Processa o recalculo de saldos acumulado + commit/rollback
			*--    (Prorroga.Click:648-655)
			IF loc_lContinuar
				IF fRecalculaS(.T.)
					THIS.this_dVencs = THIS.this_dVencNovo
					THIS.RegistrarAuditoria("UPDATE")
					SQLCOMMIT(gnConnHandle)
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
			ENDIF
		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*-- Inserir() NAO e sobrescrito: este BO so prorroga cheques que JA
	*-- existem em SigChe (nunca cria um registro novo) - o comportamento
	*-- herdado da BusinessBase para Inserir() permanece o correto.

ENDDEFINE


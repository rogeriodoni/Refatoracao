# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, LCREF, LCVEN, I, EMPDOPNUMS, CPROS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, LCREF, LCVEN, I, EMPDOPNUMS, CPROS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, LCREF, LCVEN, I, EMPDOPNUMS, CPROS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ATUALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, LCREF, LCVEN, I, EMPDOPNUMS, CPROS, CITENS

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
		lcSql = [Select Emails From SigCdCli where Iclis = ']+LocalEest.contaOs+[']
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpCli')
		lcSql = [Select Emails From SigCdCli where Iclis = ']+LocalEest.contaDs+[']
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpCli')
	Insert Into crCabecalho (Dopes, Numes, Datas, RazSocs, Cgcs, Ies, Obses, TitFornec, DckPrzE, DocPrzE, DckReffs, ;
	Select LocalPar
	Select LocalEestI
		Select LocalEstI2
		If Seek(Str(LocalEestI.CItens, 6), 'LocalEstI2', 'CItens')
			Select LocalEstI2
				Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Aliqs, ValIpis, Obs) ;
			Select LocalEestI
			Select LocalEestI
			Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Aliqs, ValIpis, Obs) ;
			Insert Into crDados (Pagina) Values (lnPgn)
	Select csBranco
	Append Memo Branco From (ThisForm.ImgBranco) OverWrite
Select crCabecalho
Select crDados
lcQuery = [Select a.CItens, a.CPros, b.Reffs, a.DPros, a.CUnis, a.Qtds, a.Units, a.Totas, a.Aliqs, a.ValIpis, a.Obs ] + ;
		    [From SigMvItn a, SigCdPro b ] + ;
If (loCnx.SqlExecute(lcQuery, 'LocalEestI') < 1)
lcQuery = [Select a.CItens, a.CPros, c.Reffs, a.DPros, b.CodEmbs as CUnis, b.Qtds, ] + ;
		    [From SigMvItn a, SigMvIts b, SigCdPro c ] + ;
If (loCnx.SqlExecute(lcQuery, 'crLclMvSub') < 1)
Select CItens, CPros, Reffs, DPros, CUnis, Qtds, Units * Iif(QtdEmbs > 0, QtdEmbs, 1) as Units, ;
  From crLclMvSub ;
Select LocalEstI2
	Select Sum(1) as Total, FPags, MoeFpgs, Valos ;
	  From LocalPar1 ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopden.prg) - PRIMEIRAS 1077 de 1077 linhas:
*==============================================================================
* Formsigopden.prg - Form Operacional: Dados de Entrega
* SCX Origem: SIGOPDEN.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - modal, flat layout (sem PageFrame), visualizador
*
* Chamada: CREATEOBJECT("Formsigopden", par_cEmps, par_cDopes, par_nNumes)
*   par_cEmps  : codigo da empresa  (SigMvCab.Emps  char(3))
*   par_cDopes : codigo da operacao (SigMvCab.Dopes char(20))
*   par_nNumes : numero do movimento (SigMvCab.Numes numeric(6,0))
*
* Fluxo:
*   Init armazena os parametros da chave -> DODEFAULT() chama InicializarForm
*   InicializarForm cria sigopdenBO, carrega os dados via CarregarDadosEntrega
*   e monta o cabecalho visual; a pagina de dados/itens e os eventos entram
*   nas proximas fases.
*
* FASE 3/8 - Form: Estrutura Base (DEFINE CLASS, Init, InicializarForm,
*            ConfigurarCabecalho, Destroy)
*
* FASE 4/8 - "Grid e Botoes CRUD" nao se aplica no sentido literal: o dump
* legado (tasks\task718\sigopden_form_codigo_fonte.txt, SECAO 1) tem raiz
* Class:form/BaseClass:form generica, SEM nenhum BaseClass grid/pageframe,
* SEM AddCursor/pColuna/RecordSource - nao ha lista para reproduzir (mesma
* familia de excecao de FormSigMvMen/SIGPDMEN - ver licao "Gate da Fase 4
* exigia Grid/CRUD que o legado despachante/exibicao nao tem"). SIGOPDEN
* get01..get13 sao TODOS ReadOnly = .T. (get01-get12 explicito no dump) ou
* bloqueados via PROCEDURE When / Return .f. (get13, o EditBox de
* observacao) - eh um dialogo de EXIBICAO (visualizador de "Dados de
* Entrega": fornecedor + endereco de entrega), sem nenhum campo editavel e
* sem CRUD. O UNICO controle interativo do legado eh SIGOPDEN.ok
* (Caption "Encerrar", Cancel=.T. -> ESC fecha), cujo Click
* (comportamento.json) eh so "ThisForm.Release". Isso, e o Shape1
* decorativo atras do botao, sao o que esta fase entrega.
*
* FASE 5/8 - "Form - Campos Principais (Parte 1)" tambem nao se aplica no
* sentido literal de ConfigurarPaginaDados/Page2 (mesma excecao da Fase 4 -
* este form OPERACIONAL eh flat, sem PageFrame). O que esta fase entrega eh
* a METADE dos campos restantes do dump: o bloco do FORNECEDOR
* (shpProdutos + lblTitFornec + get01..get06), equivalente ao
* ThisForm.MostraCampos() legado para esses seis campos. Valores lidos das
* properties this_cFor*/this_nForTpClis do BO (ja povoadas por
* ProcessarCabecalhoEDados nas Fases 1/2), com as MESMAS expressoes do
* legado (ALLTRIM so onde o legado usa Allt/Alltrim - get02 nao trim
* nenhum campo, get03 nao trim Compls/Bairs - regra #17: transcrever a
* formula literalmente, inclusive os ALLTRIM que o legado OMITE). O bloco
* de ENTREGA (Shape2 + lblDocEntregs + get07..get12) e o de OBSERVACAO
* (Shape3 + Say1 + get13) ficam para a Fase 6.
*
* FASE 6/8 - "Campos Restantes e Lookups" entrega a OUTRA metade do dump:
* ConfigurarCamposEntrega (Shape2 + lblDocEntregs + get07..get12, segunda
* metade do MostraCampos() legado) e ConfigurarCamposObservacao (Shape3 +
* Say1 + get13). Valores transcritos LITERALMENTE de
* tasks\task718\sigopden_form_codigo_fonte.txt / comportamento.json
* (linhas 654-664), mesma regra #17 da Fase 5. NAO ha lookup nesta fase:
* analise.json confirma "lookups": [] - os 13 campos (get01..get13) sao
* TODOS somente-leitura (ReadOnly = .T. ou PROCEDURE When / Return .f.),
* entao nao existe F4/DblClick/Valid de busca a implementar neste form.
*
* FASE 7/8 - "Form - Eventos Principais" (BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick) NAO SE APLICA a este form - mesma
* familia de excecao das Fases 4/5/6 acima. O dump legado
* (comportamento.json) nao tem NENHUM PROCEDURE Click alem de
* "SIGOPDEN.ok" ("ThisForm.Release"), nenhum CommandGroup, nenhum
* Grupo_Op, nenhum pcEscolha e nenhum verbo CRUD (Incluir/Alterar/
* Visualizar/Excluir) em lugar nenhum dos 20 metodos analisados - eh um
* dialogo PASSIVO de exibicao (fornecedor + endereco de entrega de um
* movimento ja gravado), chamado com a chave do movimento (par_cEmps,
* par_cDopes, par_nNumes) e cujo UNICO controle interativo eh o botao
* Encerrar. Esse unico evento ja foi entregue nas fases anteriores como
* THIS.BtnOkClick() (linha ~724, BINDEVENT no ConfigurarBotaoOk) -
* equivalente FIEL ao Click do legado. Nao ha superficie de 2 handlers
* para satisfazer um piso generico de CRUD: inventar BtnIncluirClick/
* BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick vazios ou redigindo
* o mesmo Release() sob nomes diferentes violaria a regra de completude
* (stub disfarcado) e o PILAR 1 (o legado nao tem essas acoes). Precedente
* identico: SIGMVCTH -> FormSIGMVCTH (visualizador de 1 botao so,
* "Retornar" = ThisForm.Release) - ver licao "Gate da Fase 7 exigia >=2
* handlers... insatisfazivel sem inventar botao".
*
* FASE 8/8 - "Eventos Auxiliares e Consolidacao Final". O legado tem SEIS
* metodos no form (comportamento.json / SECAO 3 do dump):
*
*   mostracampos   -> THIS.BOParaForm()        <- ENTREGUE NESTA FASE
*   processamento  -> sigopdenBO.ProcessarCabecalhoEDados()   (Fases 1/2)
*   selecionadados -> sigopdenBO.SelecionarDadosOrigem()      (Fases 1/2)
*   Init           -> THIS.Init() + THIS.InicializarForm()    (Fase 3)
*   Load           -> SEM equivalente: o corpo eh "=fConfigGeral()", funcao
*                     GLOBAL do legado Fortyus cujo wrapper
*                     (utils\fconfiggeral.prg) existe APENAS para o p-code
*                     dos VCX e diz, no proprio cabecalho, "em codigo NOSSO
*                     nunca se chama fConfigGeral" - o que ela fazia no
*                     legado hoje esta em config.prg/main.prg/BO.
*   Release        -> THIS.Destroy()                          (Fase 3)
*
* O que esta fase acrescenta de fato:
*
* 1) BOParaForm() - PROTECTED, equivalente 1:1 da PROCEDURE mostracampos.
*    No legado mostracampos eh um metodo SEPARADO, chamado pelo Init DEPOIS
*    de .Processamento; as Fases 5/6 tinham embutido as 13 expressoes de
*    .Value (e as 2 de .Caption) nos proprios blocos AddObject dos metodos
*    ConfigurarCampos*, misturando CRIACAO de controle com CARGA de dado.
*    Esta fase separa as duas coisas: os ConfigurarCampos* passam a nascer
*    com os valores do DUMP (getNN sem Value nenhum; lblTitFornec e
*    lblDocEntregs com Caption = "Dados"), e as expressoes migram
*    LITERALMENTE para BOParaForm, chamado no fim do InicializarForm na
*    MESMA ordem do legado (Processamento -> MostraCampos). Alem de ficar
*    fiel ao legado, isso corrige a fidelidade de UI em modo
*    gb_4c_ValidandoUI (sem conexao as properties do BO estao vazias e os
*    campos exibiam resto de formula, tipo " - ()").
*    PROTECTED obrigatorio: FormBase.BOParaForm() eh PROTECTED e PROTECTED
*    em qualquer nivel da heranca prevalece (regra #51) - declarar sem
*    modificador aqui nao "alargaria" o escopo, so confundiria o leitor.
*
* 2) AjustarOrdemTabulacao() - a ordem de tabulacao do dump (ok=11,
*    get01..get12=5, get13=9, lblTitFornec/lblDocEntregs/Say1=4), que o
*    migrador tinha descartado por inteiro. NAO se reproduz atribuindo esses
*    numeros controle a controle: medido no VFP9 (2026-10-31,
*    tasks\task718\medir_tabindex.prg), valor DUPLICADO ou FORA da faixa
*    1..ControlCount eh DESCARTADO em silencio e vale a ordem de CRIACAO -
*    e o dump tem 12 vezes "5", 3 vezes "4" e um "11" contra 22 controles.
*    Um passe FINAL com valores UNICOS e sequenciais eh o que funciona, e
*    SEM os Shape - medido no mesmo dia (medir_tem_tabindex.prg): Shape,
*    Image e Line NAO TEM a propriedade TabIndex, atribui-la estoura
*    "Property TABINDEX is not found" (regra #33), e o guard certo eh
*    PEMSTATUS no CONTROLE, nao PEMSTATUS(THIS, "<nome>", 5).
*    Consequencia pratica: sem este passe o Encerrar ficava na 2a posicao de
*    tabulacao (ele eh criado antes dos campos), quando o dump o poe em
*    ULTIMO - divergencia de PILAR 1. Ver o cabecalho do metodo.
*
* 3) lbl_4c_LblTitulo.ToolTipText, tambem do dump.
*
* 4) LockScreen = .T./.F. em volta da construcao da tela, como o Init legado
*    faz (.LockScreen = .t. antes de .Processamento e .f. depois do
*    .OK.SetFocus). O reset fica DEPOIS do ENDTRY, nunca dentro do TRY: se
*    uma excecao estourar no meio, a tela nao pode ficar congelada.
*
* NAO entram nesta fase, por ausencia no legado (inventa-los seria stub
* disfarcado - proibido pela regra de completude - e violaria o PILAR 1):
*   FormParaBO        - sentido Form -> BO. Os 13 campos sao TODOS
*                       somente-leitura (get01..get12 com ReadOnly = .T. no
*                       dump, get13 via PROCEDURE When / Return .f.); nao
*                       existe valor digitado para escrever de volta.
*   CarregarLista     - o dump nao tem UMA superficie de lista: zero
*                       ocorrencia de pColuna/Grade/grd, zero AddCursor,
*                       zero BaseClass grid.
*   BtnCancelarClick  - nao ha Page2, nem modo de edicao, nem botao Cancelar;
*                       o unico botao do SCX eh "ok" (Caption "Encerrar",
*                       Cancel = .T.), ja entregue como BtnOkClick.
*   BtnSalvarClick / HabilitarCampos / LimparCampos / AjustarBotoesPorModo
*                     - nao ha gravacao, nem campo habilitavel, nem modo
*                       (INCLUIR/ALTERAR/VISUALIZAR) neste dialogo.
*==============================================================================

DEFINE CLASS Formsigopden AS FormBase

	*-- Propriedades visuais (canonico do projeto - PILAR 1 adaptado a OPERACIONAL)
	Width        = 1000
	Height       = 600
	AutoCenter   = .T.
	Caption      = "Dados de Entrega"
	ShowWindow   = 1
	WindowType   = 1
	ControlBox   = .F.
	Closable     = .F.
	MaxButton    = .F.
	MinButton    = .F.
	TitleBar     = 0
	Movable      = .F.
	ClipControls = .F.
	KeyPreview   = .T.
	Themes       = .F.
	BorderStyle  = 2
	DataSession  = 1
	BackColor    = RGB(100, 100, 100)
	FontName     = "Tahoma"
	FontSize     = 8

	*-- Business Object
	this_oBusinessObject = .NULL.

	*-- Chave do movimento recebida no Init (equivalente a ThisForm.pcEmps/pcDopes/pcNumes)
	this_cEmps  = ""
	this_cDopes = ""
	this_nNumes = 0

	*==========================================================================
	* Init - Armazena a chave do movimento ANTES de DODEFAULT(), para que
	* InicializarForm (chamado por FormBase.Init via DODEFAULT) ja a encontre
	* preenchida.
	*==========================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes)
		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF
		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF
		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		RETURN DODEFAULT()
	ENDPROC

	*==========================================================================
	* InicializarForm - Cria o Business Object, carrega os dados de entrega
	* (SigMvCab + SigCdOpe + SigOpCdc + SigCdEmp + SigCdCli + itens) e monta o
	* cabecalho visual do form.
	*==========================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		*-- Init legado: ".LockScreen = .t." antes de .Processamento. O reset
		*-- para .F. fica DEPOIS do ENDTRY (nunca dentro do TRY): excecao no
		*-- meio da construcao nao pode deixar a tela congelada.
		THIS.LockScreen = .T.

		TRY
			THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

			*-- Instanciar Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("sigopdenBO")
			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MsgErro("Erro ao criar sigopdenBO. VARTYPE retornou: " + ;
					VARTYPE(THIS.this_oBusinessObject), "Formsigopden.InicializarForm")
			ELSE
				IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
					*-- Validacao de UI: sem conexao SQL - nao carrega dados, mas a
					*-- estrutura visual (cabecalho + botao Encerrar) tem de existir
					*-- do mesmo jeito para o ValidarUIFidelity.prg conferir
					THIS.ConfigurarCabecalho()
					THIS.ConfigurarShapeOk()
					THIS.ConfigurarBotaoOk()
					THIS.ConfigurarCamposFornecedor()
					THIS.ConfigurarCamposEntrega()
					THIS.ConfigurarCamposObservacao()

					*-- Por ULTIMO: a faixa valida de TabIndex eh 1..ControlCount.
					THIS.AjustarOrdemTabulacao()

					*-- NAO chama BOParaForm aqui: sem conexao as properties do
					*-- BO estao vazias e as formulas do mostracampos legado
					*-- renderizariam resto de texto (" - ()", "Endereco :  ").
					*-- Os campos ficam como o dump declara - sem Value.
					loc_lSucesso = .T.
				ELSE
					IF THIS.this_oBusinessObject.CarregarDadosEntrega(THIS.this_cEmps, ;
							THIS.this_cDopes, THIS.this_nNumes)

						THIS.Caption = ALLTRIM(THIS.this_cEmps) + " - " + ;
							ALLTRIM(THIS.this_cDopes) + " - " + ;
							ALLTRIM(STR(THIS.this_nNumes, 6)) + " - Dados de Entrega"

						THIS.ConfigurarCabecalho()
						THIS.ConfigurarShapeOk()
						THIS.ConfigurarBotaoOk()
						THIS.ConfigurarCamposFornecedor()
						THIS.ConfigurarCamposEntrega()
						THIS.ConfigurarCamposObservacao()

						*-- Por ULTIMO: a faixa valida de TabIndex eh 1..ControlCount.
						THIS.AjustarOrdemTabulacao()

						*-- Init legado: ".Processamento" (acima, via
						*-- CarregarDadosEntrega) e SO DEPOIS ".MostraCampos".
						THIS.BOParaForm()

						loc_lSucesso = .T.
					ELSE
						MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
							"Dados de Entrega")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigopden.InicializarForm")
		ENDTRY

		*-- Init legado: ".LockScreen = .f." no fim. FORA do TRY de proposito -
		*-- vale tambem quando o CATCH disparou.
		THIS.LockScreen = .F.

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ConfigurarCabecalho - Container escuro com o titulo do form (equivalente
	* ao cntSombra do legado - layout.json: Top=0,Left=0,Width=800,Height=80).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCabecalho()
		LOCAL loc_oCnt

		THIS.AddObject("cnt_4c_Sombra", "Container")
		loc_oCnt = THIS.cnt_4c_Sombra
		WITH loc_oCnt
			.Top         = 0
			.Left        = 0
			.Width       = THIS.Width
			.Height      = 80
			.BorderWidth = 0
			.BackColor   = RGB(100, 100, 100)
			.Visible     = .T.
		ENDWITH

		loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
		WITH loc_oCnt.lbl_4c_LblSombra
			.FontBold      = .T.
			.FontName      = "Tahoma"
			.FontSize      = 18
			.FontUnderline = .F.
			.WordWrap      = .T.
			.Alignment     = 0
			.BackStyle     = 0
			.AutoSize      = .F.
			.Caption       = THIS.Caption
			.Height        = 40
			.Left          = 10
			.Top           = 18
			.Width         = 769
			.ForeColor     = RGB(0, 0, 0)
			.Visible       = .T.
		ENDWITH

		loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
		WITH loc_oCnt.lbl_4c_LblTitulo
			.FontBold  = .T.
			.FontName  = "Tahoma"
			.FontSize  = 18
			.WordWrap  = .T.
			.Alignment = 0
			.BackStyle = 0
			.AutoSize  = .F.
			.Caption   = THIS.Caption
			.Height    = 46
			.Left      = 10
			.Top       = 17
			.Width     = 769
			.ForeColor = RGB(255, 255, 255)
			*-- ToolTipText do dump (PROPRIEDADES DE: SIGOPDEN.cntSombra.lblTitulo)
			.ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
			.Visible   = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarShapeOk - Shape decorativo atras do botao Encerrar (ok no
	* legado). Dump: Top=7, Left=705, Width=88, Height=109, BorderColor=
	* 136,189,188.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarShapeOk()
		THIS.AddObject("shp_4c_Shape1", "Shape")
		WITH THIS.shp_4c_Shape1
			.Top         = 7
			.Left        = 705
			.Width       = 88
			.Height      = 109
			.BackStyle   = 0
			.BorderStyle = 0
			.BorderColor = RGB(136, 189, 188)
			.Visible     = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarBotaoOk - Unico botao interativo do dialogo (SIGOPDEN.ok).
	* Propriedades EXATAS do dump (PROPRIEDADES DE: SIGOPDEN.ok); PicturePosition
	* e MousePointer nao estao no dump (classe base commandbutton, sem
	* equivalente do fwbtng legado) - usados os valores canonicos comuns a
	* todos os botoes do framework (docs\framework_frmcadastro_layout.md).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarBotaoOk()
		THIS.AddObject("cmd_4c_Ok", "CommandButton")
		WITH THIS.cmd_4c_Ok
			.Top             = 3
			.Left            = 725
			.Width           = 75
			.Height          = 75
			.Caption         = "Encerrar"
			.Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
			.FontName        = "Comic Sans MS"
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontSize        = 8
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes           = .T.
			.Cancel          = .T.
			.ToolTipText     = "[Esc] Encerrar"
			.SpecialEffect   = 0
			.PicturePosition = 13
			.MousePointer    = 15
			.WordWrap        = .T.
			.AutoSize        = .F.
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
	ENDPROC

	*==========================================================================
	* ConfigurarCamposFornecedor - Bloco do FORNECEDOR (dump: shpProdutos +
	* lblTitFornec + get01..get06). Equivalente a metade do MostraCampos()
	* legado. Left/Top/Width EXATOS do dump (layout.json) - o form migrado
	* usa Width=1000 (canonico), mas os controles mantem as coordenadas do
	* SCX original (800px), igual ao Shape1/cmd_4c_Ok da Fase 4; sobra
	* espaco em branco a direita, que eh fiel ao original (nao esticar).
	*
	* lbl_4c_LblTitFornec: o dump declara AutoSize = .T. sem Width/Alignment
	* (classe say pura), mas em Label criado por AddObject AutoSize = .T. eh
	* NO-OP (a Width fica no default de 100) - por isso aqui .AutoSize = .F.
	* com .Width explicita que caiba o caption dinamico (regra #23).
	*
	* Valores: transcritos EXATAMENTE do MostraCampos() legado (comportamento.json),
	* trocando ThisForm.getNN.Value por THIS.txt_4c_NN.Value e crCabecalho.X
	* pela property this_cForX/this_nForTpClis do BO (ja povoada por
	* ProcessarCabecalhoEDados). O ALLTRIM e aplicado SOMENTE onde o legado
	* usa Allt/Alltrim - regra #17, nunca "uniformizar" a formula.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCamposFornecedor()
		THIS.AddObject("shp_4c_ShpProdutos", "Shape")
		WITH THIS.shp_4c_ShpProdutos
			.Top           = 107
			.Left          = 29
			.Width         = 741
			.Height        = 172
			.BackStyle     = 0
			.SpecialEffect = 1
			.BorderColor   = RGB(90, 90, 90)
			.Visible       = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_LblTitFornec", "Label")
		WITH THIS.lbl_4c_LblTitFornec
			.FontBold  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.AutoSize  = .F.
			.Alignment = 0
			.BackStyle = 0
			.Left      = 35
			.Top       = 114
			.Width     = 400
			.Height    = 17
			.ForeColor = RGB(90, 90, 90)
			*-- Caption do DUMP. O texto final ("Dados " + TitFornec) e' posto
			*-- por BOParaForm, como o mostracampos legado faz.
			.Caption   = "Dados"
			.Visible   = .T.
		ENDWITH

		*-- get01 (valor em BOParaForm)
		THIS.AddObject("txt_4c_01", "TextBox")
		WITH THIS.txt_4c_01
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 131
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get02: Iif(TpClis=1,'C.P.F','C.N.P.J') + '.: ' + Cgcs + '  ' +
		*          Iif(TpClis=1,'R.G.','I.E.') + ' : ' + Ies +
		*          Iif(TpClis=1, '', '  Inscr.Municipal: ' + IMuns)
		*          -- legado NAO aplica ALLTRIM em nenhum destes campos.
		THIS.AddObject("txt_4c_02", "TextBox")
		WITH THIS.txt_4c_02
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 155
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get03: 'Endereco : ' + Allt(Endes) + Iif(Empty(Nums),'',', '+Allt(Nums))
		*          + Iif(Empty(Compls),'',' - '+Compls) + Iif(Empty(Bairs),'',' - '+Bairs)
		*          -- legado NAO aplica Allt em Compls/Bairs.
		THIS.AddObject("txt_4c_03", "TextBox")
		WITH THIS.txt_4c_03
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 179
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get04: 'Cidade: ' + Alltrim(Cidas) + ' / ' + Alltrim(Estas) + '        CEP: ' + Alltrim(Ceps)
		THIS.AddObject("txt_4c_04", "TextBox")
		WITH THIS.txt_4c_04
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 203
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get05: 'Contato: ' + Contato + '      e-Mail: : ' + Alltrim(eMails)
		*          -- legado NAO aplica Alltrim em Contato.
		THIS.AddObject("txt_4c_05", "TextBox")
		WITH THIS.txt_4c_05
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 227
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get06: 'Telefone: ' + Iif(Empty(Ddds),'','('+Alltrim(Ddds)+') ') + Alltrim(Tel1s)
		*          + Iif(Empty(Tel2s),'','/'+Alltrim(Tel2s)) + '    Fax: ' + Alltrim(Faxs)
		THIS.AddObject("txt_4c_06", "TextBox")
		WITH THIS.txt_4c_06
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 34
			.Top               = 251
			.Width             = 729
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarCamposEntrega - Bloco de ENTREGA (dump: Shape2 + lblDocEntregs
	* + get07..get12). Segunda metade do MostraCampos() legado. Left/Top/Width
	* EXATOS do dump (layout.json). Valores transcritos LITERALMENTE do
	* codigo fonte original (comportamento.json linhas 654-662) - mesma
	* regra #17 da Fase 5: ALLTRIM SOMENTE onde o legado usa Allt/Alltrim
	* (get11 usa Alltrim(EntContato); get09/get12 nao aplicam Alltrim em
	* EntBairs/EntDdds antes do IIF de vazio, mas aplicam no valor usado).
	*
	* lblDocEntregs: dump declara AutoSize = .T. sem Width/Alignment (classe
	* say pura) - AutoSize = .T. em Label criado por AddObject eh NO-OP
	* (regra #23), por isso aqui .AutoSize = .F. com .Width explicita.
	* Caption dinamico: ThisForm.lblDocEntregs.Caption = [Dados ] + DocEntregs
	* (comportamento.json linha 654) - mesmo padrao de lbl_4c_LblTitFornec.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCamposEntrega()
		THIS.AddObject("shp_4c_Shape2", "Shape")
		WITH THIS.shp_4c_Shape2
			.Top         = 286
			.Left        = 29
			.Width       = 741
			.Height      = 103
			.BackStyle   = 0
			.SpecialEffect = 1
			.BorderColor = RGB(90, 90, 90)
			.Visible     = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_LblDocEntregs", "Label")
		WITH THIS.lbl_4c_LblDocEntregs
			.FontBold  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.AutoSize  = .F.
			.Alignment = 0
			.BackStyle = 0
			.Left      = 35
			.Top       = 293
			.Width     = 400
			.Height    = 17
			.ForeColor = RGB(90, 90, 90)
			*-- Caption do DUMP. O texto final ("Dados " + DocEntregs) e' posto
			*-- por BOParaForm, como o mostracampos legado faz.
			.Caption   = "Dados"
			.Visible   = .T.
		ENDWITH

		*-- get07: Alltrim(EntRClis)
		THIS.AddObject("txt_4c_07", "TextBox")
		WITH THIS.txt_4c_07
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 35
			.Top               = 312
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get08: Alltrim(EntEndes)
		THIS.AddObject("txt_4c_08", "TextBox")
		WITH THIS.txt_4c_08
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 35
			.Top               = 336
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get09: Alltrim(EntBairs) + Iif(Empty(Alltrim(EntBairs)),'',' - ') +
		*          Alltrim(EntCidas) + Iif(Empty(EntEstas),'',' / '+Alltrim(EntEstas)) +
		*          '   CEP.: ' + Alltrim(EntCeps)
		THIS.AddObject("txt_4c_09", "TextBox")
		WITH THIS.txt_4c_09
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 35
			.Top               = 360
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get10: Iif(EntTpClis=1,'CPF','CNPJ') + ': ' + Alltrim(EntCgcs) + ' - ' +
		*          Iif(EntTpClis=1,'RG','IE') + ': ' + Alltrim(EntIes)
		THIS.AddObject("txt_4c_10", "TextBox")
		WITH THIS.txt_4c_10
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 400
			.Top               = 312
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get11: 'Contato : ' + Alltrim(EntContato)
		THIS.AddObject("txt_4c_11", "TextBox")
		WITH THIS.txt_4c_11
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 400
			.Top               = 336
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH

		*-- get12: 'Telefone.: ' + Iif(Empty(EntDdds),'','('+Alltrim(EntDdds)+') ') +
		*          Alltrim(EntTel1s) + Iif(Empty(EntTel2s),'','/'+Alltrim(EntTel2s))
		THIS.AddObject("txt_4c_12", "TextBox")
		WITH THIS.txt_4c_12
			.FontName          = "Tahoma"
			.FontSize          = 8
			.Height            = 23
			.Left              = 400
			.Top               = 360
			.Width             = 363
			.ReadOnly          = .T.
			.SpecialEffect     = 1
			.ForeColor         = RGB(0, 0, 0)
			.BackColor         = RGB(255, 255, 255)
			.DisabledBackColor = RGB(255, 255, 255)
			.DisabledForeColor = RGB(192, 192, 192)
			.BorderColor       = RGB(100, 100, 100)
			.Visible           = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarCamposObservacao - Bloco de OBSERVACAO (dump: Shape3 + Say1 +
	* get13). get13 eh fwmemo (Base: editbox) com PROCEDURE When Return .f.
	* (campo bloqueado para edicao, igual aos get01..get12) - .ReadOnly = .T.
	* no EditBox migrado reproduz o mesmo bloqueio.
	*
	* Say1: dump declara AutoSize = .T. sem Width/Alignment (classe say pura)
	* - mesma regra #23 do bloco anterior: .AutoSize = .F. com Width explicita.
	*
	* get13.Value = crCabecalho.Obses (comportamento.json linha 664) - SEM
	* Alltrim no legado; this_cObses do BO ja eh a mesma coluna (regra #17:
	* transcrever literalmente, inclusive a AUSENCIA de Alltrim).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCamposObservacao()
		THIS.AddObject("shp_4c_Shape3", "Shape")
		WITH THIS.shp_4c_Shape3
			.Top         = 396
			.Left        = 29
			.Width       = 741
			.Height      = 91
			.BackStyle   = 0
			.SpecialEffect = 1
			.BorderColor = RGB(90, 90, 90)
			.Visible     = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_Label1", "Label")
		WITH THIS.lbl_4c_Label1
			.FontBold  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.AutoSize  = .F.
			.Alignment = 0
			.BackStyle = 0
			.Left      = 35
			.Top       = 403
			.Width     = 150
			.Height    = 17
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("obj_4c_Get13", "EditBox")
		WITH THIS.obj_4c_Get13
			.FontName      = "Tahoma"
			.FontSize      = 8
			.Height        = 57
			.Left          = 35
			.Top           = 424
			.Width         = 729
			.SpecialEffect = 1
			.ReadOnly      = .T.
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Visible       = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* AjustarOrdemTabulacao - Reproduz a ORDEM DE TABULACAO do SCX legado.
	*
	* Transcrever o TabIndex do dump controle a controle NAO funciona, e falha
	* EM SILENCIO. Medido no VFP9 em 2026-10-31 (tasks\task718\medir_tabindex.prg):
	*
	*   apos AddObject (b1, t1, t2)        -> 1 / 2 / 3   (ordem de CRIACAO)
	*   atribuindo 11 / 5 / 5              -> 1 / 2 / 3   <- DESCARTADO
	*   passe final 1 / 2 / 3 (unicos)     -> 3 / 1 / 2   <- APLICADO
	*
	* Isto e', o VFP9 recusa valor FORA da faixa 1..ControlCount e valor
	* DUPLICADO, mantendo a ordem de criacao - sem erro e sem aviso. E o dump
	* do SIGOPDEN tem exatamente isso: TabIndex = 5 repetido em get01..get12,
	* 4 repetido nos tres labels e 11 no "ok" (acima dos 22 controles do
	* container). Atribuir esses numeros um a um, como o migrador faz, eh
	* no-op puro - mesma familia do AutoSize = .T. em Label criado por
	* AddObject (regra #23).
	*
	* O que o dump codifica de fato eh a ORDEM RELATIVA, e essa se reproduz
	* com um passe FINAL de valores UNICOS e sequenciais. Ordem do legado,
	* por TabIndex crescente e, dentro do empate, pela arvore do SCX:
	*
	*   4  -> lblTitFornec, lblDocEntregs, Say1
	*   5  -> get01 .. get12
	*   9  -> get13
	*   11 -> ok            <- o botao Encerrar eh o ULTIMO
	*
	* Sem este passe o Encerrar herdava a 2a posicao (ele eh criado antes dos
	* campos, igual ao legado), e o usuario tabulando saia do primeiro campo
	* direto para o botao - divergencia de PILAR 1 que o dump justamente
	* corrige com o TabIndex = 11.
	*
	* SHAPE NAO TEM TabIndex - e por isso NAO entra na lista. Medido no VFP9
	* (2026-10-31, tasks\task718\medir_tem_tabindex.prg): Container, Label,
	* TextBox, EditBox, CommandButton e OptionGroup TEM a propriedade;
	* **Shape, Image e Line NAO TEM** - atribuir estoura "Property TABINDEX
	* is not found" (regra #33). Como os quatro Shape do form estao fora da
	* numeracao, dos 22 controles do container apenas 18 participam, e a
	* faixa valida eh 1..18 (nao 1..22).
	*
	* O guard tem de ser PEMSTATUS(<controle>, "TabIndex", 5), no CONTROLE -
	* PEMSTATUS(THIS, "<nome>", 5) so diz que o membro existe no form, e com
	* ele o laco entrava e quebrava no Shape (mesma armadilha das regras #3 e
	* #34). O contador eh SEQUENCIAL E PROPRIO (loc_nSeq), nao o indice do
	* laco: pular um nome sem pular o numero abriria buraco na faixa.
	*
	* Medido na replica fiel (tasks\task718\medir_tab_real.prg - 1 Container,
	* 4 Shape, 3 Label, 12 TextBox, 1 EditBox, 1 CommandButton, botao criado
	* em 3o lugar, igual a este form):
	*
	*   ANTES : btnOk=2   cnt1=1  txt01=4   edt13=18
	*   DEPOIS: btnOk=18  cnt1=1  txt01=5   edt13=17   (18 numerados)
	*
	* Chamado por ULTIMO no InicializarForm, depois de todo AddObject - antes
	* disso os controles ainda nao existem e a faixa util eh menor.
	*==========================================================================
	PROTECTED PROCEDURE AjustarOrdemTabulacao()
		LOCAL ARRAY loc_aOrdem[18]
		LOCAL loc_nI, loc_nSeq, loc_oErro

		*-- Container do cabecalho: tem TabIndex, nao recebe foco util, vem 1o
		loc_aOrdem[ 1] = "cnt_4c_Sombra"
		*-- TabIndex 4 do dump (lblTitFornec, lblDocEntregs, Say1)
		loc_aOrdem[ 2] = "lbl_4c_LblTitFornec"
		loc_aOrdem[ 3] = "lbl_4c_LblDocEntregs"
		loc_aOrdem[ 4] = "lbl_4c_Label1"
		*-- TabIndex 5 do dump (get01..get12)
		loc_aOrdem[ 5] = "txt_4c_01"
		loc_aOrdem[ 6] = "txt_4c_02"
		loc_aOrdem[ 7] = "txt_4c_03"
		loc_aOrdem[ 8] = "txt_4c_04"
		loc_aOrdem[ 9] = "txt_4c_05"
		loc_aOrdem[10] = "txt_4c_06"
		loc_aOrdem[11] = "txt_4c_07"
		loc_aOrdem[12] = "txt_4c_08"
		loc_aOrdem[13] = "txt_4c_09"
		loc_aOrdem[14] = "txt_4c_10"
		loc_aOrdem[15] = "txt_4c_11"
		loc_aOrdem[16] = "txt_4c_12"
		*-- TabIndex 9 do dump (get13)
		loc_aOrdem[17] = "obj_4c_Get13"
		*-- TabIndex 11 do dump: o Encerrar e' o ULTIMO
		loc_aOrdem[18] = "cmd_4c_Ok"

		loc_nSeq = 0

		TRY
			FOR loc_nI = 1 TO ALEN(loc_aOrdem)
				IF PEMSTATUS(THIS, loc_aOrdem[loc_nI], 5)
					*-- membro alcancado por NOME: EVALUATE para LER e
					*-- STORE ... TO (expr) para ATRIBUIR - nunca
					*-- Controls(<nome>) nem EVALUATE com "=" dentro da
					*-- string (regras #15 e #34).
					IF PEMSTATUS(EVALUATE("THIS." + loc_aOrdem[loc_nI]), "TabIndex", 5)
						loc_nSeq = loc_nSeq + 1
						STORE loc_nSeq TO ("THIS." + loc_aOrdem[loc_nI] + ".TabIndex")
					ENDIF
				ENDIF
			ENDFOR
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigopden.AjustarOrdemTabulacao")
		ENDTRY
	ENDPROC

	*==========================================================================
	* BOParaForm - Equivalente 1:1 da "PROCEDURE mostracampos" do SCX legado
	* (tasks\task718\sigopden_form_codigo_fonte.txt, SECAO 3, OBJETO SIGOPDEN).
	*
	* Sentido UNICO BO -> campo: carrega as 2 legendas dinamicas e os 13 campos
	* somente-leitura a partir das properties que o BO ja povoou em
	* ProcessarCabecalhoEDados (o "crCabecalho" do legado). Chamado pelo
	* InicializarForm DEPOIS de CarregarDadosEntrega, na MESMA ordem do Init
	* legado (".Processamento" e so entao ".MostraCampos").
	*
	* PROTECTED: FormBase.BOParaForm() eh PROTECTED, e PROTECTED em qualquer
	* nivel da heranca prevalece (regra #51) - este metodo so eh alcancavel
	* via THIS. de dentro da classe, que eh exatamente como ele eh usado.
	*
	* As expressoes sao TRANSCRICAO LITERAL do legado (regra #17): o ALLTRIM
	* aparece SOMENTE onde o legado usa Allt/Alltrim. Em particular o legado
	* NAO aplica trim em ForCgcs/ForIes/ForIMuns (get02), em ForCompls/ForBairs
	* (get03), em ForContato (get05) nem em Obses (get13) - nao "uniformizar".
	*
	* ReadOnly nao bloqueia atribuicao por codigo (so digitacao do usuario),
	* por isso os 13 campos recebem valor normalmente.
	*==========================================================================
	PROTECTED PROCEDURE BOParaForm()
		LOCAL loc_oBO, loc_oErro

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		loc_oBO = THIS.this_oBusinessObject

		TRY
			*-- lblTitFornec.Caption = [Dados ] + crCabecalho.TitFornec
			THIS.lbl_4c_LblTitFornec.Caption = "Dados " + loc_oBO.this_cTitFornec

			*-- get01 = Alltrim(ForRClis) + ' - (' + Alltrim(ForIClis) + ')'
			THIS.txt_4c_01.Value = ALLTRIM(loc_oBO.this_cForRClis) + " - (" + ;
				ALLTRIM(loc_oBO.this_cForIClis) + ")"

			*-- get02 = Iif(TpClis=1,'C.P.F','C.N.P.J') + '.: ' + Cgcs + '  ' +
			*--         Iif(TpClis=1,'R.G.','I.E.') + ' : ' + Ies +
			*--         Iif(TpClis=1, '', '  Inscr.Municipal: ' + IMuns)
			THIS.txt_4c_02.Value = IIF(loc_oBO.this_nForTpClis = 1, "C.P.F", "C.N.P.J") + ".: " + ;
				loc_oBO.this_cForCgcs + "  " + IIF(loc_oBO.this_nForTpClis = 1, "R.G.", "I.E.") + ;
				" : " + loc_oBO.this_cForIes + ;
				IIF(loc_oBO.this_nForTpClis = 1, "", "  Inscr.Municipal: " + loc_oBO.this_cForIMuns)

			*-- get03 = 'Endereco : ' + Allt(Endes) + Iif(Empty(Nums),'',', '+Allt(Nums))
			*--         + Iif(Empty(Compls),'',' - '+Compls) + Iif(Empty(Bairs),'',' - '+Bairs)
			THIS.txt_4c_03.Value = "Endere" + CHR(231) + "o : " + ALLTRIM(loc_oBO.this_cForEndes) + ;
				IIF(EMPTY(loc_oBO.this_cForNums), "", ", " + ALLTRIM(loc_oBO.this_cForNums)) + ;
				IIF(EMPTY(loc_oBO.this_cForCompls), "", " - " + loc_oBO.this_cForCompls) + ;
				IIF(EMPTY(loc_oBO.this_cForBairs), "", " - " + loc_oBO.this_cForBairs)

			*-- get04 = 'Cidade: ' + Alltrim(Cidas) + ' / ' + Alltrim(Estas) + '        CEP: ' + Alltrim(Ceps)
			THIS.txt_4c_04.Value = "Cidade: " + ALLTRIM(loc_oBO.this_cForCidas) + " / " + ;
				ALLTRIM(loc_oBO.this_cForEstas) + "        CEP: " + ALLTRIM(loc_oBO.this_cForCeps)

			*-- get05 = 'Contato: ' + Contato + '      e-Mail: : ' + Alltrim(eMails)
			THIS.txt_4c_05.Value = "Contato: " + loc_oBO.this_cForContato + ;
				"      e-Mail: : " + ALLTRIM(loc_oBO.this_cForeMails)

			*-- get06 = 'Telefone: ' + Iif(Empty(Ddds),'','('+Alltrim(Ddds)+') ') + Alltrim(Tel1s)
			*--         + Iif(Empty(Tel2s),'','/'+Alltrim(Tel2s)) + '    Fax: ' + Alltrim(Faxs)
			THIS.txt_4c_06.Value = "Telefone: " + ;
				IIF(EMPTY(loc_oBO.this_cForDdds), "", "(" + ALLTRIM(loc_oBO.this_cForDdds) + ") ") + ;
				ALLTRIM(loc_oBO.this_cForTel1s) + ;
				IIF(EMPTY(loc_oBO.this_cForTel2s), "", "/" + ALLTRIM(loc_oBO.this_cForTel2s)) + ;
				"    Fax: " + ALLTRIM(loc_oBO.this_cForFaxs)

			*-- lblDocEntregs.Caption = [Dados ] + crCabecalho.DocEntregs
			THIS.lbl_4c_LblDocEntregs.Caption = "Dados " + loc_oBO.this_cDocEntregs

			*-- get07 = Alltrim(EntRClis)
			THIS.txt_4c_07.Value = ALLTRIM(loc_oBO.this_cEntRClis)

			*-- get08 = Alltrim(EntEndes)
			THIS.txt_4c_08.Value = ALLTRIM(loc_oBO.this_cEntEndes)

			*-- get09 = Alltrim(EntBairs) + Iif(Empty(Alltrim(EntBairs)),'',' - ') +
			*--         Alltrim(EntCidas) + Iif(Empty(EntEstas),'',' / '+Alltrim(EntEstas)) +
			*--         '   CEP.: ' + Alltrim(EntCeps)
			THIS.txt_4c_09.Value = ALLTRIM(loc_oBO.this_cEntBairs) + ;
				IIF(EMPTY(ALLTRIM(loc_oBO.this_cEntBairs)), "", " - ") + ;
				ALLTRIM(loc_oBO.this_cEntCidas) + ;
				IIF(EMPTY(loc_oBO.this_cEntEstas), "", " / " + ALLTRIM(loc_oBO.this_cEntEstas)) + ;
				"   CEP.: " + ALLTRIM(loc_oBO.this_cEntCeps)

			*-- get10 = Iif(EntTpClis=1,'CPF','CNPJ') + ': ' + Alltrim(EntCgcs) + ' - ' +
			*--         Iif(EntTpClis=1,'RG','IE') + ': ' + Alltrim(EntIes)
			THIS.txt_4c_10.Value = IIF(loc_oBO.this_nEntTpClis = 1, "CPF", "CNPJ") + ": " + ;
				ALLTRIM(loc_oBO.this_cEntCgcs) + " - " + ;
				IIF(loc_oBO.this_nEntTpClis = 1, "RG", "IE") + ": " + ALLTRIM(loc_oBO.this_cEntIes)

			*-- get11 = 'Contato : ' + Alltrim(EntContato)
			THIS.txt_4c_11.Value = "Contato : " + ALLTRIM(loc_oBO.this_cEntContato)

			*-- get12 = 'Telefone.: ' + Iif(Empty(EntDdds),'','('+Alltrim(EntDdds)+') ') +
			*--         Alltrim(EntTel1s) + Iif(Empty(EntTel2s),'','/'+Alltrim(EntTel2s))
			THIS.txt_4c_12.Value = "Telefone.: " + ;
				IIF(EMPTY(loc_oBO.this_cEntDdds), "", "(" + ALLTRIM(loc_oBO.this_cEntDdds) + ") ") + ;
				ALLTRIM(loc_oBO.this_cEntTel1s) + ;
				IIF(EMPTY(loc_oBO.this_cEntTel2s), "", "/" + ALLTRIM(loc_oBO.this_cEntTel2s))

			*-- get13 = crCabecalho.Obses (legado NAO aplica Alltrim)
			THIS.obj_4c_Get13.Value = loc_oBO.this_cObses

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigopden.BOParaForm")
		ENDTRY
	ENDPROC

	*==========================================================================
	* BtnOkClick - PUBLIC (BINDEVENT - regra #3 CLAUDE.md). Espelha
	* SIGOPDEN.ok.Click (comportamento.json): "ThisForm.Release".
	*==========================================================================
	PROCEDURE BtnOkClick()
		THIS.Release()
	ENDPROC

	*==========================================================================
	* Activate - Espelha ".OK.SetFocus" do Init legado. No legado o botao ja
	* existe quando o Init roda; no form migrado o cmd_4c_Ok so existe apos
	* InicializarForm (AddObject), entao o foco inicial e' dado aqui, no
	* primeiro Activate. TRY/CATCH porque SetFocus estoura em controle
	* invisivel/desabilitado e Activate nao tem caller que trate o erro -
	* sem isso o usuario veria o Program Error cru do VFP (regra #38).
	*==========================================================================
	PROCEDURE Activate()
		LOCAL loc_oErro

		TRY
			IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
				IF THIS.cmd_4c_Ok.Visible AND THIS.cmd_4c_Ok.Enabled
					THIS.cmd_4c_Ok.SetFocus()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*==========================================================================
	* Destroy - Libera os cursores de saida do BO e a referencia ao BO
	*==========================================================================
	PROCEDURE Destroy()
		LOCAL loc_oErro

		TRY
			IF USED("cursor_4c_Cabecalho")
				USE IN cursor_4c_Cabecalho
			ENDIF
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			THIS.this_oBusinessObject = .NULL.

		CATCH TO loc_oErro
			*-- Destruicao nao bloqueia o encerramento do form
		ENDTRY

		DODEFAULT()
	ENDPROC

ENDDEFINE

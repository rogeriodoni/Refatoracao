*====================================================================
* SIGOPinsBO.prg
*
* Business Object para FormSIGOPins
* Origem legado: SIGOPins.SCX - dialogo "Selecao de Finalidades"
* Tipo de formulario: OPERACIONAL (dialogo de selecao, WindowType = 1)
*
* Tabela principal   : SigCdObs (codigos numeric(3,0) = chave primaria)
* Tabelas auxiliares : SigOpFnl (finalidades do grupo/item)
*                      SigCdOpe (faixa de observacoes e padrao da operacao)
*                      SigCdPro (grupo do produto, no fluxo ITN)
*
* Arquitetura em camadas: FormSIGOPins -> SIGOPinsBO -> SQL Server
*
* FASE 1 DE 8: declaracao de TODAS as propriedades + Init()
*====================================================================

DEFINE CLASS SIGOPinsBO AS BusinessBase

	*-----------------------------------------------------------------
	* Colunas de SigCdObs (entidade principal)
	* codigos    numeric(3,0) NOT NULL - chave primaria
	* observas   text NULL
	* descrs     char(80) NOT NULL
	* comiss     numeric(1,0) NOT NULL
	* classifs   numeric(1,0) NOT NULL
	* grupos     char(10) NOT NULL
	* agrupas    char(10) NOT NULL
	* movautdop  char(20) NOT NULL
	*-----------------------------------------------------------------
	this_nCodigos    = 0
	this_cObservas   = ""
	this_cDescrs     = ""
	this_nComiss     = 0
	this_nClassifs   = 0
	this_cGrupos     = ""
	this_cAgrupas    = ""
	this_cMovautdop  = ""

	*-----------------------------------------------------------------
	* Coluna calculada da lista (legado: "Select 0 as Selecao, ...")
	* Marca de selecao da linha na grade - 1 = selecionada, 0 = nao
	*-----------------------------------------------------------------
	this_nSelecao    = 0

	*-----------------------------------------------------------------
	* Colunas de SigOpFnl (vinculo finalidade x grupo/item)
	* cidchaves   char(20) NOT NULL - chave primaria (fUniqueIds)
	* codigos     numeric(3,0) NOT NULL - aponta para SigCdObs.codigos
	* codutil     char(20) NOT NULL - grupo (GRP) ou item (ITN)
	* empdopnums  char(29) NOT NULL - chave posicional Emps+Dopes+Numes
	* operacao    char(3) NOT NULL - "GRP" ou "ITN"
	*-----------------------------------------------------------------
	this_cCidchaves  = ""
	this_cCodutil    = ""
	this_cEmpdopnums = ""
	this_cOperacao   = ""

	*-----------------------------------------------------------------
	* Colunas de SigCdOpe lidas no fluxo de operacao (sem lista)
	* dopes     char(20) NOT NULL - chave primaria da operacao
	* obspads   numeric(3,0) NOT NULL - observacao padrao
	* obsinis   numeric(3,0) NOT NULL - inicio da faixa
	* obsfins   numeric(3,0) NOT NULL - fim da faixa
	*-----------------------------------------------------------------
	this_cDopes      = ""
	this_nObspads    = 0
	this_nObsinis    = 0
	this_nObsfins    = 0

	*-----------------------------------------------------------------
	* Colunas de SigCdPro usadas no fluxo ITN (grupo do produto)
	* cgrus char(10) / cpros char(14)
	*-----------------------------------------------------------------
	this_cCgrus      = ""
	this_cCpros      = ""

	*-----------------------------------------------------------------
	* Parametros recebidos do formulario chamador
	* Legado: Init(pCnx, pLista, pTipo, pCaption, pEdn) que publicava
	* pcLista / pcTipo / pcChv / pcEDN como variaveis PUBLIC.
	* Aqui viram propriedades do BO (PILAR 3 - sem variavel global).
	*-----------------------------------------------------------------
	this_cLista      = ""
	this_cTipo       = ""
	this_cChave      = ""
	this_cEdn        = ""
	this_cTitulo     = ""

	*-----------------------------------------------------------------
	* Estado do dialogo
	* this_lModoFinalidades reproduz Vartype(pcLista) = "C" do legado:
	*   .T. = selecao de FINALIDADES (lista recebida do chamador)
	*   .F. = selecao de OBSERVACOES da operacao (faixa de SigCdOpe)
	* this_lListaInformada guarda se o parametro pLista chegou, porque
	* lista VAZIA ("") ainda eh modo FINALIDADES no legado.
	* this_lTipoInformado reproduz Vartype(pcTipo) = "C", que no legado
	* separa o fluxo SIGOPINF (sem tipo) dos fluxos GRP e ITN.
	*-----------------------------------------------------------------
	this_lModoFinalidades = .F.
	this_lListaInformada  = .F.
	this_lTipoInformado   = .F.

	*-----------------------------------------------------------------
	* Faixa de observacoes aplicada ao SELECT da lista
	* Legado: pIni / pFim (0..999 no modo finalidades; obsinis/obsfins
	* de SigCdOpe no modo operacao)
	*-----------------------------------------------------------------
	this_nFaixaInicial = 0
	this_nFaixaFinal   = 999

	*-----------------------------------------------------------------
	* Observacao padrao marcada automaticamente na abertura
	* Legado: lcObsPads (-1 no modo finalidades = nao marca nada;
	* LocalOpe.ObsPads no modo operacao)
	*-----------------------------------------------------------------
	this_nObsPadrao  = -1

	*-----------------------------------------------------------------
	* Resultado devolvido ao formulario chamador
	* this_cListaSelecionadas reproduz a PUBLIC listaObs do legado,
	* no formato ",1,7,23," consumido pelo SIGOPINF.
	* this_cTextoObservacoes acumula o texto gravado em TprMvCab.obses.
	*-----------------------------------------------------------------
	this_cListaSelecionadas = ""
	this_cTextoObservacoes  = ""
	this_lConfirmado        = .F.
	this_lPularLinhas       = .T.

	*-----------------------------------------------------------------
	* Cursores proprios do dialogo (nomenclatura nova - PILAR 3)
	* this_cCursorLista        <- LocalObs  (grade de observacoes)
	* this_cCursorSelecionadas <- CrObs     (ja associadas)
	* this_cCursorGrupo        <- CrGRP     (finalidades do grupo)
	* this_cCursorOperacao     <- LocalOpe  (faixa de SigCdOpe)
	* this_cCursorProduto      <- crPro     (grupo do produto)
	*-----------------------------------------------------------------
	this_cCursorLista        = "cursor_4c_Lista"
	this_cCursorSelecionadas = "cursor_4c_Selecionadas"
	this_cCursorGrupo        = "cursor_4c_Grupo"
	this_cCursorOperacao     = "cursor_4c_Operacao"
	this_cCursorProduto      = "cursor_4c_Produto"

	*-----------------------------------------------------------------
	* Cursores do formulario CHAMADOR - os nomes sao CONTRATO com o
	* legado e NAO podem ser renomeados: quem abre este dialogo ja os
	* tem abertos e espera que a gravacao aconteca neles.
	*-----------------------------------------------------------------
	this_cCursorFinalidades  = "crSigOpFnl"
	this_cCursorItemOperacao = "crTpmMvItn"
	this_cCursorCabecalho    = "TprMvCab"
	this_cCursorGrupoPai     = "crSigCdGrp"

	*-----------------------------------------------------------------
	* Mensagem da ultima falha de processamento deste BO
	* this_lFalhaValidacao distingue o UNICO caso de validacao deste BO
	* ("Nenhuma Observacao Foi Selecionada!", MsgAviso no legado) de uma
	* falha tecnica (cursor do chamador indisponivel), que o Form exibe
	* com MsgErro - mesma distincao da regra do projeto sobre MsgAviso
	* vs MsgErro.
	*-----------------------------------------------------------------
	this_cMensagemFalha  = ""
	this_lFalhaValidacao = .F.

	*====================================================================
	* Init - Inicializa o Business Object
	*
	* par_cLista  : lista de codigos ja selecionados (",1,7," ou "")
	*               quando CARACTERE, ativa o modo FINALIDADES
	* par_cTipo   : "GRP" (grupo), "ITN" (item) ou ausente (operacao)
	* par_cTitulo : complemento do titulo do dialogo
	* par_cEdn    : chave Emps+Dopes+Numes (char(29)) da operacao
	*
	* Os quatro parametros sao OPCIONAIS - o dialogo eh aberto tanto pelo
	* menu (sem argumento) quanto pelos formularios SIGOPINF/SIGOPPRO e
	* pelo cadastro de grupos. PCOUNT() distingue argumento AUSENTE de
	* argumento vazio, porque lista vazia continua sendo modo
	* FINALIDADES no legado (Vartype(pcLista) = "C" com pcLista = "").
	*
	* NUNCA retorna .F.: Init de BO que devolve falso mata a abertura do
	* formulario. Falha de parametro fica em this_cMensagemFalha para o
	* Form tratar.
	*====================================================================
	PROCEDURE Init(par_cLista, par_cTipo, par_cTitulo, par_cEdn)
		LOCAL loc_nArgumentos, loc_oErro

		DODEFAULT()

		*-- Nomes EXATOS do banco (PILAR 2) - nao renomear
		THIS.this_cTabela     = "SigCdObs"
		THIS.this_cCampoChave = "codigos"

		loc_nArgumentos = PCOUNT()

		TRY
			*-- Reproduz os PUBLIC pcLista / pcTipo / pcChv / pcEDN
			THIS.this_lListaInformada = (loc_nArgumentos >= 1 AND VARTYPE(par_cLista) = "C")
			THIS.this_cLista = IIF(THIS.this_lListaInformada, par_cLista, "")

			THIS.this_lTipoInformado = (loc_nArgumentos >= 2 AND VARTYPE(par_cTipo) = "C")
			THIS.this_cTipo = IIF(THIS.this_lTipoInformado, UPPER(ALLTRIM(par_cTipo)), "")

			*-- pcChv eh montado durante o processamento (item/grupo)
			THIS.this_cChave = ""

			*-- pcEDN = Iif(Type([pEdn]) = [C], pEdn, [])
			THIS.this_cEdn = IIF(loc_nArgumentos >= 4 AND VARTYPE(par_cEdn) = "C", par_cEdn, "")

			*-- Caption = "Selecao de " + Iif(<pCaption informado>, pCaption, "Finalidades")
			IF loc_nArgumentos >= 3 AND VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
				THIS.this_cTitulo = ALLTRIM(par_cTitulo)
			ELSE
				THIS.this_cTitulo = "Finalidades"
			ENDIF

			*-- Modo de operacao: lista informada = FINALIDADES
			THIS.this_lModoFinalidades = THIS.this_lListaInformada

			*-- Faixa e padrao conforme o modo
			IF THIS.this_lModoFinalidades
				*-- Legado: Where Codigos BetWeen 0 And 999 / lcObsPads = -1
				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = -1
			ELSE
				*-- No modo operacao a faixa real vem de SigCdOpe.obsinis /
				*-- obsfins na carga; estes sao os defaults do legado.
				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = 0
			ENDIF

			*-- Estado inicial dos campos da entidade
			THIS.this_nCodigos           = 0
			THIS.this_cObservas          = ""
			THIS.this_cDescrs            = ""
			THIS.this_nComiss            = 0
			THIS.this_nClassifs          = 0
			THIS.this_cGrupos            = ""
			THIS.this_cAgrupas           = ""
			THIS.this_cMovautdop         = ""
			THIS.this_nSelecao           = 0

			*-- Estado inicial do vinculo SigOpFnl
			THIS.this_cCidchaves         = ""
			THIS.this_cCodutil           = ""
			THIS.this_cEmpdopnums        = THIS.this_cEdn
			THIS.this_cOperacao          = THIS.this_cTipo

			*-- Estado inicial dos auxiliares
			THIS.this_cDopes             = ""
			THIS.this_nObspads           = 0
			THIS.this_nObsinis           = 0
			THIS.this_nObsfins           = 0
			THIS.this_cCgrus             = ""
			THIS.this_cCpros             = ""

			*-- Estado inicial do resultado
			THIS.this_cListaSelecionadas = ""
			THIS.this_cTextoObservacoes  = ""
			THIS.this_lConfirmado        = .F.
			THIS.this_lPularLinhas       = .T.
			THIS.this_cMensagemFalha     = ""
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao inicializar a sele" + CHR(231) + CHR(227) + ;
				"o de finalidades: " + loc_oErro.Message
			MsgAviso(THIS.this_cMensagemFalha, "Aten" + CHR(231) + CHR(227) + "o")
		ENDTRY

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterTituloDialogo - Monta o Caption do dialogo
	* Legado: "Selecao de " + Iif(<pCaption>, pCaption, "Finalidades")
	* Usado pelo Form no Caption e nos dois labels do cabecalho.
	*====================================================================
	PROCEDURE ObterTituloDialogo()
		RETURN "Sele" + CHR(231) + CHR(227) + "o de " + ;
			IIF(EMPTY(THIS.this_cTitulo), "Finalidades", ALLTRIM(THIS.this_cTitulo))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega uma linha de SigCdObs para as properties
	*
	* O legado nunca le SigCdObs registro a registro por fora da grade
	* (a propria SELECT do Init ja devolve Codigos/Observas/Descrs prontos
	* para o cursor LocalObs). Este metodo existe para o uso generico de
	* BusinessBase - uma futura consulta por codigo unico de observacao
	* (equivalente a "SELECT * FROM SigCdObs WHERE codigos = ?") - e por
	* isso mapeia TODAS as colunas da tabela, nao so as quatro da grade.
	*
	* par_cAliasCursor: alias de um cursor aberto com as colunas de
	* SigCdObs (codigos, observas, descrs, comiss, classifs, grupos,
	* agrupas, movautdop). "selecao" eh coluna calculada so na grade
	* LocalObs/cursor_4c_Lista - carregada apenas quando presente.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF !USED(par_cAliasCursor)
			RETURN loc_lResultado
		ENDIF

		SELECT (par_cAliasCursor)

		IF EOF()
			RETURN loc_lResultado
		ENDIF

		THIS.this_nCodigos   = TratarNulo(codigos, 0)
		THIS.this_cObservas  = TratarNulo(observas, "")
		THIS.this_cDescrs    = TratarNulo(descrs, "")
		THIS.this_nComiss    = TratarNulo(comiss, 0)
		THIS.this_nClassifs  = TratarNulo(classifs, 0)
		THIS.this_cGrupos    = TratarNulo(grupos, "")
		THIS.this_cAgrupas   = TratarNulo(agrupas, "")
		THIS.this_cMovautdop = TratarNulo(movautdop, "")

		IF TYPE(par_cAliasCursor + ".selecao") != "U"
			THIS.this_nSelecao = TratarNulo(selecao, 0)
		ENDIF

		loc_lResultado = .T.
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CriarCursorLista - Cria o cursor que a grade do dialogo exibe
	*
	* Equivalente estrutural do LocalObs do legado, que nasce da SELECT
	* "Select 0 as Selecao, Codigos, Observas, Descrs From SigCdObs".
	*
	* A estrutura mora AQUI, num lugar so, de proposito: o Form cria este
	* mesmo cursor ANTES de ligar a grade (sem cursor aberto,
	* Column.ControlSource derruba o Init) e o recarregamento eh feito com
	* ZAP + APPEND FROM DBF(), que casa as colunas por NOME - estrutura
	* mais estreita que a SELECT descartaria coluna em silencio.
	*
	* Tipos conferidos em docs\schema.sql (SigCdObs):
	*   codigos  numeric(3,0) NOT NULL -> N(3,0)
	*   observas text NULL             -> M  (pode chegar NULL: SET NULL ON)
	*   descrs   char(80) NOT NULL     -> C(80)
	* selecao eh coluna de TRABALHO da grade ("0 as Selecao" no legado),
	* nao existe em SigCdObs.
	*====================================================================
	PROCEDURE CriarCursorLista()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF !USED(THIS.this_cCursorLista)
				SET NULL ON
				CREATE CURSOR (THIS.this_cCursorLista) ;
					(selecao N(1,0), codigos N(3,0), observas M, descrs C(80))
				SET NULL OFF
			ENDIF

			loc_lSucesso = USED(THIS.this_cCursorLista)
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao criar a lista de observa" + ;
				CHR(231) + CHR(245) + "es: " + loc_oErro.Message
			MsgAviso(THIS.this_cMensagemFalha, "Aten" + CHR(231) + CHR(227) + "o")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarListaObservacoes - Reproduz TODO o carregamento do Init
	* legado (SIGOPINS.Init), que tem dois fluxos exclusivos:
	*
	*   Vartype(pcLista) = "C"  -> FINALIDADES: faixa fixa 0..999, mais a
	*       marcacao das observacoes ja associadas, cuja origem varia com
	*       pcTipo (ausente = SIGOPINF, "GRP" = cadastro de grupos,
	*       "ITN" = itens da operacao).
	*   senao -> OBSERVACOES DA OPERACAO: a faixa sai de SigCdOpe
	*       (ObsInis/ObsFins) e ObsPads vira a observacao marcada por
	*       padrao.
	*
	* Fecha com a marcacao do padrao, que no legado eh
	* "Update LocalObs Set Selecao = 1 Where Codigos = lcObsPads" - em
	* modo FINALIDADES lcObsPads vale -1 e nao casa com nada, por isso a
	* chamada eh incondicional nos dois fluxos.
	*
	* O GO TOP e o Refresh da grade NAO moram aqui: sao do Form, que eh
	* quem conhece a grade (e repintar grade eh obrigacao de quem exibe).
	*====================================================================
	PROCEDURE CarregarListaObservacoes()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemFalha = ""

		TRY
			IF !THIS.CriarCursorLista()
				THIS.this_cMensagemFalha = "Lista de observa" + CHR(231) + CHR(245) + ;
					"es indispon" + CHR(237) + "vel."
			ELSE
				IF THIS.this_lModoFinalidades
					loc_lSucesso = THIS.CarregarFluxoFinalidades()
				ELSE
					loc_lSucesso = THIS.CarregarFluxoOperacao()
				ENDIF

				IF loc_lSucesso
					THIS.MarcarObservacaoPadrao()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao carregar as observa" + CHR(231) + ;
				CHR(245) + "es: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarFluxoFinalidades - Ramo "Vartype(pcLista) = C" do Init
	*
	* 1) faixa fixa 0..999 de SigCdObs  -> cursor da grade
	* 2) cursor das JA ASSOCIADAS, conforme pcTipo
	* 3) marcacao (SCAN/LOCATE/REPLACE do legado)
	* 4) lcObsPads = -1 (nao marca padrao nenhum)
	*====================================================================
	PROTECTED PROCEDURE CarregarFluxoFinalidades()
		LOCAL loc_lSucesso

		loc_lSucesso = THIS.CarregarObservacoesFaixa(0, 999)

		IF loc_lSucesso
			DO CASE
				CASE !THIS.this_lTipoInformado
					*-- SIGOPINF: as associadas vem da propria lista recebida
					loc_lSucesso = THIS.CarregarSelecionadasDaLista()

				CASE THIS.this_cTipo == "GRP"
					*-- Cadastro de grupos: "Select * from crSigOpFnl into cursor crObs"
					loc_lSucesso = THIS.CarregarSelecionadasDoGrupo()

				CASE THIS.this_cTipo == "ITN"
					*-- Itens da operacao: restringe a lista ao grupo do produto
					*-- e le as associadas do item corrente
					loc_lSucesso = THIS.CarregarSelecionadasDoItem()

				OTHERWISE
					*-- pcTipo informado com valor fora de GRP/ITN: o legado nao
					*-- entra em nenhum dos tres IFs e segue sem cursor de
					*-- associadas, ou seja nada fica pre-marcado.
					loc_lSucesso = .T.
			ENDCASE
		ENDIF

		IF loc_lSucesso
			THIS.MarcarSelecionadas()
			THIS.this_nObsPadrao = -1
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarFluxoOperacao - Ramo ELSE do Init legado
	*
	* Le ObsPads/ObsInis/ObsFins de SigCdOpe pela operacao do cabecalho e
	* carrega SigCdObs dentro dessa faixa. ObsPads vira a observacao
	* marcada por padrao.
	*====================================================================
	PROTECTED PROCEDURE CarregarFluxoOperacao()
		LOCAL loc_lSucesso

		loc_lSucesso = THIS.CarregarFaixaOperacao()

		IF loc_lSucesso
			loc_lSucesso = THIS.CarregarObservacoesFaixa(THIS.this_nFaixaInicial, ;
				THIS.this_nFaixaFinal)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarObservacoesFaixa - SELECT de SigCdObs na faixa informada
	*
	* Legado: [Select 0 as Selecao, Codigos, Observas, Descrs ] +
	*         [From SigCdObs ] + [Where Codigos BetWeen ... ] +
	*         [Order By Codigos]
	*
	* O SQLEXEC vai para cursor TEMPORARIO e o cursor da grade eh
	* recarregado com ZAP + APPEND FROM DBF(): SQLEXEC sobre o alias
	* ligado a grade FECHA e RECRIA o alias, zerando o ColumnCount (a
	* grade viraria um retangulo branco) e perdendo o CurrentControl do
	* CheckBox da Column1.
	*====================================================================
	PROTECTED PROCEDURE CarregarObservacoesFaixa(par_nInicial, par_nFinal)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTemp

		loc_lSucesso = .F.
		loc_cTemp    = "cursor_4c_ListaTmp"

		loc_cSQL = "SELECT 0 AS selecao, codigos, observas, descrs" + ;
			" FROM SigCdObs" + ;
			" WHERE codigos BETWEEN " + FormatarNumeroSQL(par_nInicial, 0) + ;
			" AND " + FormatarNumeroSQL(par_nFinal, 0) + ;
			" ORDER BY codigos"

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
		ELSE
			THIS.LimparCursorLista()

			SELECT (THIS.this_cCursorLista)
			APPEND FROM DBF(loc_cTemp)

			loc_lSucesso = .T.
		ENDIF

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDaLista - Fluxo SIGOPINF (pcTipo ausente)
	*
	* Legado:
	*   lcLista = ALLTRIM(pcLista)
	*   lcWhere = IIF(EMPTY(lcLista),' < 0 ', 'in ('+SUBSTR(lclista,2,LEN(lclista)-2)+') ')
	*   [Select Codigos From SigCdObs Where Codigos ] + lcWhere
	*
	* A lista chega do form chamador no formato ",1,7," - o SUBSTR tira a
	* primeira e a ultima virgula. Lista vazia vira "< 0", que nao casa
	* com codigo nenhum (nada pre-marcado), e eh assim de proposito.
	*
	* O CHRTRAN confere que sobraram SO digitos, virgulas e espacos antes
	* de concatenar: a lista vem de outro formulario, e conteudo
	* inesperado produziria SQL invalido em vez de "nada selecionado".
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDaLista()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.
		loc_cWhere   = THIS.MontarWhereLista()

		loc_cSQL = "SELECT codigos FROM SigCdObs WHERE codigos" + loc_cWhere

		IF USED(THIS.this_cCursorSelecionadas)
			USE IN (THIS.this_cCursorSelecionadas)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSelecionadas)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
		ELSE
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarWhereLista - Monta o predicado do IN a partir da lista recebida
	*
	* Legado:
	*   lcLista = ALLTRIM(pcLista)
	*   lcWhere = IIF(EMPTY(lcLista),' < 0 ', 'in ('+SUBSTR(lclista,2,LEN(lclista)-2)+') ')
	*
	* Lista vazia (ou curta demais para ter conteudo entre as virgulas)
	* devolve " < 0 ", que nao casa com codigo nenhum: eh assim que o
	* legado representa "nada pre-selecionado".
	*
	* O CHRTRAN confere que sobraram SO digitos, virgulas e espacos antes
	* de concatenar. A lista vem de outro formulario; conteudo inesperado
	* geraria SQL invalido em vez de "nada selecionado".
	*====================================================================
	PROTECTED PROCEDURE MontarWhereLista()
		LOCAL loc_cLista, loc_cItens, loc_cWhere

		loc_cLista = ALLTRIM(THIS.this_cLista)
		loc_cWhere = " < 0 "

		IF !EMPTY(loc_cLista) AND LEN(loc_cLista) > 2
			loc_cItens = SUBSTR(loc_cLista, 2, LEN(loc_cLista) - 2)

			IF !EMPTY(ALLTRIM(loc_cItens)) AND EMPTY(CHRTRAN(loc_cItens, "0123456789, ", ""))
				loc_cWhere = " IN (" + loc_cItens + ") "
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDoGrupo - Fluxo pcTipo = "GRP"
	* Legado: SELECT * from crSigOpFnl into cursor crObs
	*
	* crSigOpFnl eh cursor do formulario CHAMADOR (property
	* this_cCursorFinalidades) e chega JA ABERTO - aqui so se copia o
	* conteudo dele, nunca se fecha nem se grava.
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDoGrupo()
		LOCAL loc_lSucesso, loc_cOrigem, loc_cDestino

		loc_lSucesso = .F.
		loc_cOrigem  = THIS.this_cCursorFinalidades
		loc_cDestino = THIS.this_cCursorSelecionadas

		IF !USED(loc_cOrigem)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cOrigem + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + ;
				CHR(225) + "rio chamador."
		ELSE
			IF USED(loc_cDestino)
				USE IN (loc_cDestino)
			ENDIF

			SELECT codigos FROM (loc_cOrigem) INTO CURSOR (loc_cDestino) READWRITE

			loc_lSucesso = USED(loc_cDestino)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDoItem - Fluxo pcTipo = "ITN" (SIGOPPRO)
	*
	* Legado:
	*   pcEDN = crTpmMvItn.Emps + crTpmMvItn.Dopes + str(crTpmMvItn.Numes,6)
	*   pcChv = str(crTpmMvItn.citens,6)
	*   [Select Cgrus From SigCdPro Where cpros = '<cpros>']           -> crPro
	*   [Select * From sigopFnl Where operacao = 'GRP' and codutil = '<cgrus>'] -> CrGRP
	*   Select Distinct ... from localObs a, crGRP b where a.codigos = b.codigos
	*   Select * From crSigopFnl Where codutil = pcChv                 -> crObs
	*
	* EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
	* char(20) + Str(Numes,6): o padding FAZ PARTE da chave, por isso
	* PADR explicito e NUNCA ALLTRIM nas partes.
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDoItem()
		LOCAL loc_lSucesso, loc_cItem, loc_cSQL, loc_nResultado
		LOCAL loc_cCgrus, loc_cChave, loc_cOrigem, loc_cDestino

		loc_lSucesso = .F.
		loc_cItem    = THIS.this_cCursorItemOperacao
		loc_cOrigem  = THIS.this_cCursorFinalidades
		loc_cDestino = THIS.this_cCursorSelecionadas

		IF !USED(loc_cItem)
			THIS.this_cMensagemFalha = "Cursor de itens (" + loc_cItem + ") n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		IF !USED(loc_cOrigem)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cOrigem + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + ;
				CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (loc_cItem)

		THIS.this_cEdn = PADR(TratarNulo(Emps, ""), 3) + ;
			PADR(TratarNulo(Dopes, ""), 20) + ;
			STR(TratarNulo(Numes, 0), 6)
		THIS.this_cEmpdopnums = THIS.this_cEdn
		THIS.this_cChave      = STR(TratarNulo(citens, 0), 6)
		THIS.this_cCpros      = TratarNulo(Cpros, "")

		*-- Grupo do produto do item corrente
		loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + ;
			EscaparSQL(THIS.this_cCpros)

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
			RETURN loc_lSucesso
		ENDIF

		SELECT (THIS.this_cCursorProduto)
		loc_cCgrus = IIF(EOF(), "", ALLTRIM(TratarNulo(cgrus, "")))
		THIS.this_cCgrus = loc_cCgrus

		*-- Finalidades cadastradas para o grupo do produto
		loc_cSQL = "SELECT cidchaves, codigos, codutil, empdopnums, operacao" + ;
			" FROM SigOpFnl" + ;
			" WHERE operacao = " + EscaparSQL("GRP") + ;
			" AND codutil = " + EscaparSQL(loc_cCgrus)

		IF USED(THIS.this_cCursorGrupo)
			USE IN (THIS.this_cCursorGrupo)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorGrupo)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				"(SigOpFnl)" + CHR(13) + CapturarErroSQL()
			RETURN loc_lSucesso
		ENDIF

		IF !THIS.RestringirListaAoGrupo()
			RETURN loc_lSucesso
		ENDIF

		*-- Finalidades ja associadas AO ITEM corrente
		loc_cChave = THIS.this_cChave

		IF USED(loc_cDestino)
			USE IN (loc_cDestino)
		ENDIF

		SELECT codigos FROM (loc_cOrigem) ;
			WHERE codutil = m.loc_cChave ;
			INTO CURSOR (loc_cDestino) READWRITE

		loc_lSucesso = USED(loc_cDestino)

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestringirListaAoGrupo - Mantem na grade so as observacoes que
	* pertencem ao grupo do produto (fluxo ITN).
	*
	* Legado: "Select Distinct a.Selecao, a.Codigos, Left(a.Observas,100)
	* as Observas, a.Descrs from localObs a, crGRP b where a.codigos =
	* b.codigos into cursor localObs READWRITE".
	*
	* Duas diferencas deliberadas, ambas sem efeito no resultado:
	* (a) o legado RECRIA o cursor; aqui ele eh repopulado com ZAP +
	*     APPEND FROM DBF() para o alias continuar VIVO - recriar o alias
	*     ligado a grade reseta Column.Width e Header1.Caption.
	* (b) o Left(...,100) do legado existe porque DISTINCT nao aceita
	*     campo memo; sem o DISTINCT (codigos eh chave de SigCdObs, logo
	*     uma linha por codigo ja eh unica) o texto completo eh
	*     preservado - que eh o que a caixa de observacao exibe.
	*====================================================================
	PROTECTED PROCEDURE RestringirListaAoGrupo()
		LOCAL loc_cTemp, loc_cLista, loc_cGrupo, loc_lSucesso
		LOCAL loc_nCodigo, loc_nSelecao, loc_cObservas, loc_cDescrs, loc_lAchou

		loc_lSucesso = .F.
		loc_cTemp    = "cursor_4c_ListaTmp"
		loc_cLista   = THIS.this_cCursorLista
		loc_cGrupo   = THIS.this_cCursorGrupo

		IF !USED(loc_cLista) OR !USED(loc_cGrupo)
			THIS.this_cMensagemFalha = "Cursores da sele" + CHR(231) + CHR(227) + ;
				"o por grupo indispon" + CHR(237) + "veis."
			RETURN loc_lSucesso
		ENDIF

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		SET NULL ON
		CREATE CURSOR (loc_cTemp) ;
			(selecao N(1,0), codigos N(3,0), observas M, descrs C(80))
		SET NULL OFF

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nSelecao  = selecao
			loc_nCodigo   = codigos
			loc_cObservas = observas
			loc_cDescrs   = descrs

			SELECT (loc_cGrupo)
			LOCATE FOR codigos = loc_nCodigo
			loc_lAchou = FOUND()

			IF loc_lAchou
				SELECT (loc_cTemp)
				APPEND BLANK
				REPLACE selecao  WITH loc_nSelecao, ;
						codigos  WITH loc_nCodigo, ;
						observas WITH loc_cObservas, ;
						descrs   WITH loc_cDescrs
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		THIS.LimparCursorLista()

		SELECT (loc_cLista)
		APPEND FROM DBF(loc_cTemp)

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		loc_lSucesso = .T.

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MarcarSelecionadas - Pre-marca na grade o que ja esta associado
	*
	* Legado:
	*   SELECT crObs / GO top / SCAN
	*       SELECT localObs / LOCATE for codigos = crObs.codigos
	*       IF FOUND() / replace selecao with 1 / ENDIF
	*       SELECT crObs
	*   ENDSCAN
	*
	* O SELECT do cursor de origem no FIM do corpo do SCAN eh o que faz o
	* ENDSCAN avancar o ponteiro certo - sem ele o laco nunca termina.
	*====================================================================
	PROTECTED PROCEDURE MarcarSelecionadas()
		LOCAL loc_cOrigem, loc_cLista, loc_nCodigo, loc_nMarcadas

		loc_cOrigem  = THIS.this_cCursorSelecionadas
		loc_cLista   = THIS.this_cCursorLista
		loc_nMarcadas = 0

		IF !USED(loc_cOrigem) OR !USED(loc_cLista)
			RETURN loc_nMarcadas
		ENDIF

		SELECT (loc_cOrigem)
		GO TOP
		SCAN
			loc_nCodigo = TratarNulo(codigos, -1)

			SELECT (loc_cLista)
			LOCATE FOR codigos = loc_nCodigo
			IF FOUND()
				REPLACE selecao WITH 1
				loc_nMarcadas = loc_nMarcadas + 1
			ENDIF

			SELECT (loc_cOrigem)
		ENDSCAN

		RETURN loc_nMarcadas
	ENDPROC

	*====================================================================
	* CarregarFaixaOperacao - Ramo ELSE do Init legado
	*
	* Legado:
	*   [Select ObsPads, ObsInis, ObsFins From SigCdOpe Where Dopes = '<TprMvCab.Dopes>']
	*   pIni = Iif(Not Eof() And Not Empty(ObsInis), ObsInis, 000)
	*   pFim = Iif(Not Eof() And Not Empty(ObsFins), ObsFins, 999)
	*   lcObsPads = LocalOpe.ObsPads
	*
	* TprMvCab eh cursor do formulario CHAMADOR (property
	* this_cCursorCabecalho) e so eh LIDO aqui.
	*====================================================================
	PROTECTED PROCEDURE CarregarFaixaOperacao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCabecalho

		loc_lSucesso   = .F.
		loc_cCabecalho = THIS.this_cCursorCabecalho

		IF !USED(loc_cCabecalho)
			THIS.this_cMensagemFalha = "Cursor de cabe" + CHR(231) + "alho (" + ;
				loc_cCabecalho + ") n" + CHR(227) + "o dispon" + CHR(237) + ;
				"vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (loc_cCabecalho)
		THIS.this_cDopes = TratarNulo(Dopes, "")

		loc_cSQL = "SELECT obspads, obsinis, obsfins" + ;
			" FROM SigCdOpe" + ;
			" WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

		IF USED(THIS.this_cCursorOperacao)
			USE IN (THIS.this_cCursorOperacao)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				"(SigCdOpe)" + CHR(13) + CapturarErroSQL()
		ELSE
			SELECT (THIS.this_cCursorOperacao)
			GO TOP

			IF EOF()
				THIS.this_nObspads = 0
				THIS.this_nObsinis = 0
				THIS.this_nObsfins = 0

				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = 0
			ELSE
				THIS.this_nObspads = TratarNulo(obspads, 0)
				THIS.this_nObsinis = TratarNulo(obsinis, 0)
				THIS.this_nObsfins = TratarNulo(obsfins, 0)

				THIS.this_nFaixaInicial = IIF(EMPTY(THIS.this_nObsinis), 0, THIS.this_nObsinis)
				THIS.this_nFaixaFinal   = IIF(EMPTY(THIS.this_nObsfins), 999, THIS.this_nObsfins)
				THIS.this_nObsPadrao    = THIS.this_nObspads
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MarcarObservacaoPadrao - "Update LocalObs Set Selecao = 1 Where
	* Codigos = lcObsPads" do legado.
	*
	* Em modo FINALIDADES this_nObsPadrao vale -1 e o SCAN FOR nao casa
	* com nenhuma linha - o legado roda a mesma instrucao nos dois
	* fluxos, por isso aqui nao ha IF sobre o modo.
	*====================================================================
	PROTECTED PROCEDURE MarcarObservacaoPadrao()
		LOCAL loc_nMarcadas

		loc_nMarcadas = 0

		IF !USED(THIS.this_cCursorLista)
			RETURN loc_nMarcadas
		ENDIF

		SELECT (THIS.this_cCursorLista)
		SCAN FOR codigos = THIS.this_nObsPadrao
			REPLACE selecao WITH 1
			loc_nMarcadas = loc_nMarcadas + 1
		ENDSCAN

		RETURN loc_nMarcadas
	ENDPROC

	*====================================================================
	* LimparCursorLista - Esvazia o cursor da grade preservando o ALIAS
	*
	* SET SAFETY eh escopado por DATA SESSION, e este dialogo tem
	* DataSession = 1 (sessao CORRENTE): chamado de um formulario com
	* datasession privada, o BO roda la dentro, onde SAFETY esta ON
	* mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre
	* dialogo modal de confirmacao e CONGELA a tela - por isso o
	* salva/restaura em volta.
	*====================================================================
	PROTECTED PROCEDURE LimparCursorLista()
		LOCAL loc_cSafety, loc_lSucesso

		loc_lSucesso = .F.

		IF USED(THIS.this_cCursorLista)
			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			SELECT (THIS.this_cCursorLista)
			ZAP

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarSelecao - Reproduz TODO o btnConfirmar.Click legado
	*
	* Dois fluxos exclusivos, no MESMO criterio de this_lModoFinalidades
	* usado na carga (CarregarListaObservacoes):
	*   .F. (operacao, "If Vartype(pcLista) <> 'C'") -> acumula o texto
	*       das observacoes marcadas em TprMvCab.obses (cursor do
	*       formulario CHAMADOR).
	*   .T. (finalidades, ramo Else do legado) -> conforme this_cTipo:
	*       ausente = SIGOPINF (monta this_cListaSelecionadas), "GRP" ou
	*       "ITN" = sincroniza INSERT/DELETE em crSigOpFnl (idem cursor
	*       do CHAMADOR).
	*
	* this_lConfirmado fica .T. so quando a gravacao de fato aconteceu -
	* eh o que o Form usa para decidir entre liberar o dialogo (Release)
	* ou devolver o foco a grade sem fechar.
	*====================================================================
	PROCEDURE ConfirmarSelecao()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemFalha  = ""
		THIS.this_lFalhaValidacao = .F.

		TRY
			IF !USED(THIS.this_cCursorLista)
				THIS.this_cMensagemFalha = "Lista de observa" + CHR(231) + CHR(245) + ;
					"es indispon" + CHR(237) + "vel."
			ELSE
				IF THIS.this_lModoFinalidades
					loc_lSucesso = THIS.ConfirmarFluxoFinalidades()
				ELSE
					loc_lSucesso = THIS.ConfirmarFluxoOperacao()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao confirmar a sele" + CHR(231) + CHR(227) + ;
				"o: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		THIS.this_lConfirmado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarFluxoOperacao - Ramo "If Vartype(pcLista) <> 'C'" do
	* btnConfirmar.Click legado
	*
	* Legado:
	*   Locate For Selecao = 1 / If Eof([LocalObs]) -> MessageBox +
	*       Go Top + SetFocus + Return .F.
	*   If Not IsEmpty(TprMvCab.obses) -> MessageBox(4+32+256) <> 6 ->
	*       Replace obses With [] / senao llPri = .F.
	*   Scan: Replace obses With obses + separador + Alltrim(Observas)
	*
	* MessageBox(...,0+48,...) = MsgAviso (validacao, nao erro tecnico) -
	* marca this_lFalhaValidacao para o Form escolher MsgAviso no lugar
	* de MsgErro. MessageBox(4+32+256,...) <> 6 (Nao) = !MsgConfirma().
	*====================================================================
	PROTECTED PROCEDURE ConfirmarFluxoOperacao()
		LOCAL loc_lSucesso, loc_lPrimeira, loc_cCabecalho, loc_cTexto

		loc_lSucesso   = .F.
		loc_cCabecalho = THIS.this_cCursorCabecalho

		IF !USED(loc_cCabecalho)
			THIS.this_cMensagemFalha = "Cursor de cabe" + CHR(231) + "alho (" + ;
				loc_cCabecalho + ") n" + CHR(227) + "o dispon" + CHR(237) + ;
				"vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (THIS.this_cCursorLista)
		LOCATE FOR selecao = 1

		IF EOF()
			THIS.this_cMensagemFalha  = "Nenhuma Observa" + CHR(231) + CHR(227) + ;
				"o Foi Selecionada!"
			THIS.this_lFalhaValidacao = .T.
			GO TOP
			RETURN loc_lSucesso
		ENDIF

		loc_lPrimeira = .T.

		SELECT (loc_cCabecalho)
		IF !EMPTY(TratarNulo(obses, ""))
			IF !MsgConfirma("J" + CHR(225) + " Existe Conte" + CHR(250) + "do Informado No " + ;
					"Campo de Observa" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
					"Deseja Manter o Conte" + CHR(250) + "do e Acrescentar as Observa" + ;
					CHR(231) + CHR(245) + "es" + CHR(13) + "Que Foram Selecionadas Agora?", ;
					"Aten" + CHR(231) + CHR(227) + "o!")
				REPLACE obses WITH ""
			ELSE
				loc_lPrimeira = .F.
			ENDIF
		ENDIF

		SELECT (THIS.this_cCursorLista)
		GO TOP
		SCAN
			IF selecao = 1
				loc_cTexto = ALLTRIM(TratarNulo(observas, ""))

				SELECT (loc_cCabecalho)
				REPLACE obses WITH obses + ;
					IIF(loc_lPrimeira, "", CHR(13) + IIF(THIS.this_lPularLinhas, CHR(13), "")) + ;
					loc_cTexto

				loc_lPrimeira = .F.

				SELECT (THIS.this_cCursorLista)
			ENDIF
		ENDSCAN

		loc_lSucesso = .T.

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarFluxoFinalidades - Ramo Else do btnConfirmar.Click legado
	* (Vartype(pcLista) = 'C'), com os TRES subcasos de this_cTipo.
	*====================================================================
	PROTECTED PROCEDURE ConfirmarFluxoFinalidades()
		LOCAL loc_lSucesso

		loc_lSucesso = .T.

		IF !THIS.this_lTipoInformado
			*-- SIGOPINF: monta a PUBLIC listaObs do legado
			THIS.MontarListaSelecionadas()
		ENDIF

		IF loc_lSucesso AND THIS.this_lTipoInformado AND THIS.this_cTipo == "GRP"
			loc_lSucesso = THIS.SincronizarFinalidadesGrupo()
		ENDIF

		IF loc_lSucesso AND THIS.this_lTipoInformado AND THIS.this_cTipo == "ITN"
			loc_lSucesso = THIS.SincronizarFinalidadesItem()
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarListaSelecionadas - Ramo "Vartype(pcTipo) <> 'C'" do Else
	*
	* Legado:
	*   listaObs = Iif(llPri, ','+Alltrim(Str(codigos))+',',
	*       Alltrim(listaObs)+Alltrim(Str(codigos))+',')
	*
	* Resultado no formato ",1,7,23," - eh o que SIGOPINF le de volta em
	* this_cListaSelecionadas apos o Show() do dialogo.
	*====================================================================
	PROTECTED PROCEDURE MontarListaSelecionadas()
		LOCAL loc_cLista, loc_lPrimeira

		loc_cLista    = ""
		loc_lPrimeira = .T.

		SELECT (THIS.this_cCursorLista)
		GO TOP
		SCAN
			IF selecao = 1
				IF loc_lPrimeira
					loc_cLista = "," + ALLTRIM(STR(codigos)) + ","
				ELSE
					loc_cLista = ALLTRIM(loc_cLista) + ALLTRIM(STR(codigos)) + ","
				ENDIF
				loc_lPrimeira = .F.
			ENDIF
		ENDSCAN

		THIS.this_cListaSelecionadas = loc_cLista

		RETURN .T.
	ENDPROC

	*====================================================================
	* SincronizarFinalidadesGrupo - Ramo "Vartype(pcTipo) = 'C' And
	* pcTipo = 'GRP'" do Else
	*
	* Legado:
	*   Scan localObs: selecao=1 e nao existe em crSigOpFnl -> Insert
	*       (fUniqueIds() na chave); senao (existe e nao selecionado) ->
	*       Delete.
	*
	* crSigOpFnl e crSigCdGrp sao cursores do formulario CHAMADOR
	* (this_cCursorFinalidades / this_cCursorGrupoPai) - chegam JA
	* ABERTOS e bufferizados; o TABLEUPDATE() que persiste no SQL
	* Server roda no formulario pai, fora do alcance deste BO.
	*====================================================================
	PROTECTED PROCEDURE SincronizarFinalidadesGrupo()
		LOCAL loc_cLista, loc_cFinalidades, loc_cGrupoPai, loc_nCodigo, loc_cIdChave, loc_cCgrus

		loc_cLista       = THIS.this_cCursorLista
		loc_cFinalidades = THIS.this_cCursorFinalidades
		loc_cGrupoPai    = THIS.this_cCursorGrupoPai

		IF !USED(loc_cFinalidades)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cFinalidades + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + ;
				"rio chamador."
			RETURN .F.
		ENDIF

		IF !USED(loc_cGrupoPai)
			THIS.this_cMensagemFalha = "Cursor do grupo (" + loc_cGrupoPai + ") n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + "rio chamador."
			RETURN .F.
		ENDIF

		SELECT (loc_cGrupoPai)
		loc_cCgrus = ALLTRIM(TratarNulo(cgrus, ""))

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nCodigo = codigos

			IF selecao = 1
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo

				IF !FOUND()
					loc_cIdChave = fUniqueIds()
					INSERT INTO (loc_cFinalidades) (operacao, codigos, codutil, cidchaves, empdopnums) ;
						VALUES ("GRP", loc_nCodigo, loc_cCgrus, loc_cIdChave, "")
				ENDIF
			ELSE
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo

				IF FOUND()
					DELETE
				ENDIF
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		RETURN .T.
	ENDPROC

	*====================================================================
	* SincronizarFinalidadesItem - Ramo "Vartype(pcTipo) = 'C' And
	* pcTipo = 'ITN'" do Else
	*
	* Mesma logica da sincronizacao do grupo, mas filtrada por
	* codutil = pcChv (this_cChave) e gravando this_cEdn em empdopnums -
	* identico ao Insert Into do legado para o fluxo de item.
	*====================================================================
	PROTECTED PROCEDURE SincronizarFinalidadesItem()
		LOCAL loc_cLista, loc_cFinalidades, loc_cChave, loc_cEdn, loc_nCodigo, loc_cIdChave

		loc_cLista       = THIS.this_cCursorLista
		loc_cFinalidades = THIS.this_cCursorFinalidades
		loc_cChave       = THIS.this_cChave
		loc_cEdn         = THIS.this_cEdn

		IF !USED(loc_cFinalidades)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cFinalidades + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + ;
				"rio chamador."
			RETURN .F.
		ENDIF

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nCodigo = codigos

			IF selecao = 1
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo AND codutil = loc_cChave

				IF !FOUND()
					loc_cIdChave = fUniqueIds()
					INSERT INTO (loc_cFinalidades) (operacao, codigos, codutil, cidchaves, empdopnums) ;
						VALUES ("ITN", loc_nCodigo, loc_cChave, loc_cIdChave, loc_cEdn)
				ENDIF
			ELSE
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo AND codutil = loc_cChave

				IF FOUND()
					DELETE
				ENDIF
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		RETURN .T.
	ENDPROC

	*====================================================================
	* DECISAO DE PROJETO - Inserir()/Atualizar()/ExecutarExclusao() NAO
	* sao sobrescritos neste BO: o comportamento herdado de BusinessBase
	* ja eh o correto, porque SigCdObs eh usada so para LEITURA por este
	* dialogo e nenhuma gravacao remota sobra para este BO executar.
	*
	* Evidencia no dump legado (SIGOPins_form_codigo_fonte.txt):
	* - SIGOPINS.Init: todo acesso a SigCdObs/SigCdOpe/SigCdPro eh
	*   ThisForm.poDataMgr.SqlExecute(<SELECT>, [<cursor local>]) - nunca
	*   Insert/Update/Delete, e sem nenhum .AddCursor() (que eh o bind
	*   remoto do frmcadastro que habilitaria CRUD).
	* - SIGOPINS.Grade.Column1.Header1.Click: "Update LocalObs Set
	*   Selecao = ..." atualiza o cursor LOCAL LocalObs (populado pela
	*   SELECT acima), nao a tabela SigCdObs.
	* - SIGOPINS.cntBotoes.btnConfirmar.Click: os unicos "Insert Into
	*   crSigOpFnl (...)" e "Delete" (apos Locate) tem como alvo
	*   crSigOpFnl - cursor do FORMULARIO CHAMADOR (property
	*   this_cCursorFinalidades), que chega JA ABERTO e bufferizado; o
	*   TABLEUPDATE() que persiste essas linhas no SQL Server roda no
	*   formulario pai, fora do alcance deste BO. "Replace obses With
	*   ... In TprMvCab" altera em MEMORIA outro cursor do chamador
	*   (property this_cCursorCabecalho) - tambem sem TABLEUPDATE().
	*
	* Nenhum SQLEXEC de INSERT/UPDATE/DELETE aparece em lugar nenhum
	* deste BO.
	*====================================================================

	*====================================================================
	* ObterChavePrimaria - Chave de SigCdObs para a auditoria
	* codigos eh numeric(3,0): a chave de auditoria eh a representacao
	* textual do codigo da observacao corrente.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(STR(THIS.this_nCodigos, 3))
	ENDPROC

ENDDEFINE

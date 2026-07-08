*====================================================================
* SigPrGloTBO.prg
*
* Business Object para SigPrGloT (Formulario Operacional)
* Herda de BusinessBase
*====================================================================

DEFINE CLASS SigPrGloTBO AS BusinessBase

	*-- Propriedades da entidade
	this_cMensagemErro = ""
	this_cTipos        = ""
	this_cDescrs       = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = "Tipos"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria do registro atual
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cTipos)
	ENDFUNC

	*====================================================================
	* ValidarDados - Valida dados antes de Inserir/Atualizar
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		IF EMPTY(ALLTRIM(THIS.this_cTipos))
			MsgAviso("Informe o Tipo.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		IF EMPTY(ALLTRIM(THIS.this_cDescrs))
			MsgAviso("Informe a Descri" + CHR(231) + CHR(227) + "o.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		RETURN .T.
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cTipos  = TratarNulo(Tipos,  "C")
			THIS.this_cDescrs = TratarNulo(Descrs, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* Inserir - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Inserir()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("I")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* Atualizar - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Atualizar()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("A")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

ENDDEFINE

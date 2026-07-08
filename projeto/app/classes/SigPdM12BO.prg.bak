*====================================================================
* SigPdM12BO.prg
*
* Business Object para SigPdM12 - Retrabalhos ja Realizados
* Form popup read-only: exibe dados dos cursores xNensiR e tmpnens
* fornecidos pelo form pai via DataSession compartilhada.
* Nao possui tabela propria - operacoes de escrita sao rejeitadas.
*====================================================================

DEFINE CLASS SigPdM12BO AS BusinessBase

	*-- Campos do cursor xNensiR (grid de retrabalhos)
	this_nNenvs      = 0    && O.S. (numero envelope)
	this_cEmpDopNums = ""   && Operacao (descricao)
	this_dDatas      = {}   && Data do retrabalho
	this_cDestinos   = ""   && Grupo/Conta destino
	this_cRetrabs    = ""   && Descricao do retrabalho
	this_cRclis      = ""   && Funcionario (nome)

	*-- Campos do cursor tmpnens (cabecalho da operacao)
	this_nNumps      = 0    && Codigo da operacao (numps)
	this_cEmps       = ""   && Empresa (emps)
	this_cDopps      = ""   && Descricao da operacao (dopps)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""   && Sem tabela propria (usa cursores do form pai)
		THIS.this_cCampoChave = ""   && Sem chave primaria

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir do cursor xNensiR
	* par_cAliasCursor: alias do cursor (normalmente "xNensiR")
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNenvs      = TratarNulo(Nenvs,      "N")
			THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
			THIS.this_dDatas      = TratarNulo(Datas,      "D")
			THIS.this_cDestinos   = TratarNulo(Destinos,   "C")
			THIS.this_cRetrabs    = TratarNulo(Retrabs,    "C")
			THIS.this_cRclis      = TratarNulo(Rclis,      "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* CarregarCabecalhoDoCursor - Carrega cabecalho a partir do cursor tmpnens
	* par_cAliasCursor: alias do cursor (normalmente "tmpnens")
	*====================================================================
	PROCEDURE CarregarCabecalhoDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNumps  = TratarNulo(numps, "N")
			THIS.this_cEmps   = TratarNulo(emps,  "C")
			THIS.this_cDopps  = TratarNulo(dopps, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave do registro corrente (Nenvs)
	* Usado para auditoria; identifica unicamente o envelope/O.S.
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nNenvs)
	ENDFUNC

	*====================================================================
	* Inserir - Operacao nao suportada (form read-only)
	* Form SigPdM12 e um popup de consulta de retrabalhos ja realizados.
	* Os cursores xNensiR e tmpnens sao fornecidos pelo form pai via
	* DataSession compartilhada e nao podem ser modificados aqui.
	* Comportamento original (SCX): apenas exibicao em grid, botao OK fecha.
	*====================================================================
	PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: formul" + CHR(225) + "rio de consulta " + ;
		                         "de retrabalhos " + CHR(233) + " somente leitura."
		RETURN .F.
	ENDPROC

	*====================================================================
	* Atualizar - Operacao nao suportada (form read-only)
	* Form SigPdM12 nao permite alteracao dos retrabalhos exibidos.
	* Manutencao dos registros deve ser feita atraves do form pai
	* (SigPdM01/SigPdM10) que possui a logica de cadastro.
	*====================================================================
	PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para alterar registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Operacao nao suportada (form read-only)
	* Exclusao de retrabalhos deve ser feita pelo form pai responsavel
	* pelo cadastro original. Este form apenas exibe os dados.
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para excluir registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ValidarDados - Sempre invalido (sem operacoes de escrita)
	* Como nao ha Inserir/Atualizar suportados, nao ha dados a validar.
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de consulta n" + CHR(227) + ;
		                         "o suporta valida" + CHR(231) + CHR(227) + "o de escrita."
		RETURN .F.
	ENDFUNC

ENDDEFINE

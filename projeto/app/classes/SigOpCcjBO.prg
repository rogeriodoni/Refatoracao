*====================================================================
* SigOpCcjBO.prg
*
* Business Object para Procura de Contas por Conjuge
* Tabela pesquisada: SigCdCli (busca por RgConjuges/Conjuges)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpCcjBO AS BusinessBase

	*-- Propriedades do dialogo (campos de busca pelo conjuge)
	this_cConjuges   = ""   && Conjuges   char(40) - Nome do conjuge digitado/encontrado
	this_cRgConjuges = ""   && RgConjuges char(13) - RG do conjuge: CHAVE DE BUSCA

	*-- ATENCAO - NAO "corrigir" para RgConjuges sem decisao de negocio.
	*-- O legado BUSCA por SigCdCli.RgConjuges mas, ao exibir o resultado,
	*-- preenche a caixa de R.G. da tela com SigCdCli.Rgs (o RG do TITULAR
	*-- da conta), nao com RgConjuges:
	*--     ThisForm.getRgConjuges.Value = crListaRemota.Rgs
	*-- (getRgConjuges.Valid e getConjuges.Valid, identicos nos dois).
	*-- crListaRemota TEM a coluna porque o fwBuscaExt consulta com
	*-- "select *" quando o chamador nao passa lcFields (12o parametro), e
	*-- o SCX passa apenas 7 - conferido no Init do fwbuscaext.
	*-- Parece descuido do legado (busca um campo e mostra outro), mas eh o
	*-- comportamento que o usuario ve hoje: o PILAR 1 e a regra #17
	*-- mandam TRANSCREVER, nunca reescrever formula/mapeamento.
	this_cRgs = ""   && Rgs char(20) - RG do TITULAR, o que vai para a TELA

	*-- Propriedades da conta encontrada (SigCdCli.IClis/Cpfs/RClis)
	this_cIClis = ""   && IClis char - Codigo da conta encontrada
	this_cCpfs  = ""   && Cpfs  char - CPF da conta encontrada
	this_cRClis = ""   && RClis char - Nome/Razao da conta encontrada

	*-- Propriedade auxiliar do resultado da busca (lista remota)
	this_lInativas = .F.   && Inativas bit - Indica se a conta do conjuge esta inativa

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCli"
		THIS.this_cCampoChave = "IClis"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cIClis)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia as colunas da conta encontrada (SigCdCli)
	* para as propriedades do BO. Alimentado pelo cursor que o
	* FormBuscaAuxiliar deixa populado apos o usuario selecionar a
	* conta na grade (lookup por RgConjuges ou por Conjuges).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cIClis       = TratarNulo(IClis, "C")
			THIS.this_cRClis       = TratarNulo(RClis, "C")
			THIS.this_cCpfs        = TratarNulo(Cpfs, "C")
			THIS.this_cConjuges    = TratarNulo(Conjuges, "C")
			THIS.this_cRgConjuges  = TratarNulo(RgConjuges, "C")
			*-- Rgs (RG do TITULAR) eh o que o legado joga na caixa de R.G.
			*-- da tela - ver o comentario das properties la em cima.
			THIS.this_cRgs         = TratarNulo(Rgs, "C")
			IF VARTYPE(Inativas) = "L"
			    THIS.this_lInativas = Inativas
			ELSE
			    THIS.this_lInativas = (NVL(Inativas, 0) = 1)
			ENDIF
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* BuscarPorConjuge - Equivalente ao CreateObject('fwBuscaExt', ...,
	* 'SigCdCli', 'crListaRemota', par_cCampo, par_cValor, 'Selecao', 200)
	* do Valid legado (getRgConjuges.Valid e getConjuges.Valid, ambos
	* identicos exceto pelo campo de busca). Popula cursor_4c_CcjBusca com
	* TODAS as colunas que o bloco Conjuge e o bloco Conta precisam
	* (RgConjuges/Conjuges/IClis/Cpfs/RClis/Inativas) numa UNICA consulta -
	* o legado faz Isso em DUAS (fwBuscaExt + CursorQuery('SigCdCli',
	* 'LocalCli', 'IClis', ..., 'IClis, Cpfs, RClis')), mas como as duas
	* leem a MESMA linha de SigCdCli, unificar evita round-trip duplicado
	* sem mudar o resultado.
	*
	* par_cCampo: "RgConjuges" ou "Conjuges" (nome de coluna fixo, nunca
	* valor digitado pelo usuario - concatenado direto, sem EscaparSQL).
	* par_cValor vazio busca o universo INTEIRO (sem WHERE), usado pelo
	* atalho F4 do form quando o campo ainda nao tem nada digitado.
	*====================================================================
	FUNCTION BuscarPorConjuge(par_cCampo, par_cValor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_CcjBusca")
				USE IN cursor_4c_CcjBusca
			ENDIF

			*-- Rgs entra na lista porque eh ELE que vai para a caixa de R.G.
			*-- da tela (o legado le crListaRemota.Rgs; o fwBuscaExt trazia
			*-- a coluna de graca, via "select *"). Sem ela, CarregarDoCursor
			*-- estouraria "Variable RGS is not found" em runtime.
			loc_cSQL = "SELECT RgConjuges, Rgs, Conjuges, IClis, Cpfs, RClis, Inativas" + ;
				" FROM SigCdCli"

			IF !EMPTY(ALLTRIM(NVL(par_cValor, "")))
				loc_cSQL = loc_cSQL + " WHERE " + par_cCampo + " LIKE " + ;
					EscaparSQL(ALLTRIM(par_cValor) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY " + par_cCampo

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcjBusca")
			loc_lSucesso = (loc_nResultado >= 0 AND USED("cursor_4c_CcjBusca"))

			IF !loc_lSucesso
				THIS.this_cMensagemErro = CapturarErroSQL()
			ENDIF
		CATCH TO loc_oErro
			loc_lSucesso = .F.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* SigOpCcj eh um dialogo de PROCURA (Procura de Contas por Conjuge),
	* chamado por outro formulario para devolver IClis/Cpfs/RClis de uma
	* conta ja existente. O legado (SIGOPCCJ) nao grava, altera nem
	* exclui nada em SigCdCli - btnconfirmar.Click apenas copia os
	* valores encontrados para os campos do formulario chamador. Por
	* isso o comportamento padrao herdado de BusinessBase (recusar
	* Inserir/Atualizar/ExecutarExclusao) ja eh o correto para este BO.
	*====================================================================

ENDDEFINE

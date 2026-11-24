*====================================================================
* sigopvciBO.prg
*
* Business Object para Formsigopvci (Visualizacao de Cupom Impresso)
* Form OPERACIONAL sem tabela principal propria: o cupom fiscal e lido
* diretamente da memoria da impressora fiscal (MFD) via DLL do
* fabricante (Bematech/Daruma/Epson) ou de arquivo de retorno
* (NSWEDA) - o resultado e apenas EXIBIDO na tela, nao persistido em
* tabela do SQL Server.
*
* O BO resolve a configuracao da impressora fiscal corrente
* (SigFiFis.Imps/Portas) e os parametros de faixa (numero de cupom ou
* data) escolhidos pelo usuario, que alimentam a extracao do cupom.
*
* Tabela: (nenhuma - form nao persiste registro proprio)
*====================================================================

DEFINE CLASS sigopvciBO AS BusinessBase

	*-- Parametro recebido no Init do form legado (PARAMETERS poFormulario)
	*-- identifica a estacao/PDV chamador e e repassado as rotinas
	*-- LeituraFab(ThisForm.poFormulario) e LeMFD(lcInic, lcFim,
	*-- ThisForm.poFormulario) que leem o numero de fabricacao do ECF e o
	*-- conteudo do cupom da impressora NSWEDA.
	this_cFormulario = ""

	*-- Configuracao da impressora fiscal corrente (SigFiFis), lida pelo
	*-- fLerFiscal() do legado. Define qual ramo de extracao (Bematech/
	*-- Daruma/NSWEDA/Epson) e usado nos botoes Consultar.
	this_cImpressora = ""      && SigFiFis.Imps  - modelo da impressora fiscal (ex.: BEMA8501, DARUMA, NSWEDA, EPSON)
	this_nPortas = 0           && SigFiFis.Portas - numero da porta serial/USB configurada
	this_cCidChaves = ""       && SigFiFis.Cidchaves - chave unica do registro de configuracao fiscal (PK)

	*-- Numero de fabricacao do ECF (serifab), devolvido por
	*-- LeituraFab(poFormulario) e usado nas consultas a SigFiRx.
	this_cNumFabricacao = ""

	*-- Criterio de busca escolhido em Optiongroup1 ("Cupom"/"Data").
	*-- ControlSource numerico do legado grava o INDICE do botao (1 ou 2),
	*-- nunca booleano - regra #188.
	this_nTipoBusca = 1        && Optiongroup1.Value (1=Cupom por faixa de numero, 2=Cupom por faixa de Data)

	*-- Faixa de numero de cupom (Text1/Text2), usada quando this_nTipoBusca = 1
	this_nNumeroInicial = 0    && Text1.Value
	this_nNumeroFinal = 0      && Text2.Value

	*-- Faixa de data (Text3/Text4), usada quando this_nTipoBusca = 2
	this_dDataInicial = {}     && Text3.Value
	this_dDataFinal = {}       && Text4.Value

	*-- Check1.Value - gera tambem o arquivo com os cupons extraidos no
	*-- diretorio do sistema, alem de exibir na tela
	this_lGeraArquivo = .F.

	*-- Edit1.Value - conteudo do cupom extraido da impressora fiscal,
	*-- exibido em tela (somente leitura)
	this_cConteudoCupom = ""

	*-- Faixa de SEQUENCIA de cupom resolvida a partir da faixa de DATA,
	*-- para os modelos NSWEDA/DARUMA (ver ResolverSequenciaPorData).
	*-- O legado guarda isso nas PRIVATE lcInic/lcFim do CmdInserir.Click.
	this_cSequenciaInicial = ""
	this_cSequenciaFinal = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Nao ha tabela principal: o cupom e lido da impressora fiscal
		*-- (MFD) e apenas exibido, sem persistencia propria em banco
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia para as properties this_* a configuracao
	* da impressora fiscal corrente lida de SigFiFis (regra CLAUDE.md #9:
	* SELECT (alias) antes de acessar campo, nunca <cursor>.<campo> direto
	* com alias em variavel).
	*
	* O cupom em si (this_cConteudoCupom) NAO passa por aqui: ele vem do
	* retorno da DLL da impressora fiscal (Bematech/Daruma/NSWEDA/Epson),
	* fora do SQL Server - escopo das fases de integracao com hardware
	* (6-8/8), nao de carga de cursor.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
			THIS.this_cImpressora = TratarNulo(imps, "")
			THIS.this_nPortas     = TratarNulo(portas, 0)

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarConfiguracaoFiscal - Equivalente a fLerFiscal() do legado
	* (sigopvci_form_codigo_fonte.txt:548 - "=fLerFiscal()", chamada no
	* Init do form antes de ler crSigFiFis.Imps/Portas).
	*
	* fLerFiscal() e funcao GLOBAL do Fortyus (sig.prg/SIGFUNCS.PRG) que
	* NAO veio no acervo e NAO foi portada (regra CLAUDE.md #13/#27 -
	* nunca chamar helper que nao foi definido; a chamada direta so
	* estouraria em RUNTIME com "File 'flerfiscal.prg' does not exist").
	*
	* SigFiFis e tabela do SQL Server (docs/schema.sql: dtrs bit, hands
	* char(20), portas numeric(1,0), rtss bit, settings char(20), imps
	* char(20), cidchaves char(20) PK) e NAO tem coluna de empresa - e
	* configuracao global da impressora fiscal da instalacao (mesmo
	* parametro que FisBO/FormFis permite editar), nao por empresa/caixa.
	* Sem outro criterio de selecao disponivel no dump legado, le o
	* PRIMEIRO registro cadastrado (SELECT TOP 1 ... ORDER BY cidchaves).
	*====================================================================
	FUNCTION CarregarConfiguracaoFiscal()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro

		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_SigFiFis")
				USE IN cursor_4c_SigFiFis
			ENDIF

			loc_cSQL = "SELECT TOP 1 cidchaves, imps, portas " + ;
				"FROM SigFiFis ORDER BY cidchaves"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiFis")

			IF loc_nResultado > 0 AND USED("cursor_4c_SigFiFis") AND RECCOUNT("cursor_4c_SigFiFis") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_SigFiFis")
			ELSE
				THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de impressora fiscal n" + CHR(227) + "o encontrada em SigFiFis."
			ENDIF

			IF USED("cursor_4c_SigFiFis")
				USE IN cursor_4c_SigFiFis
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao carregar configura" + CHR(231) + CHR(227) + "o fiscal")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ResolverSequenciaPorData - Converte a faixa de DATA escolhida pelo
	* usuario na faixa de SEQUENCIA de cupom que a MFD das impressoras
	* NSWEDA/DARUMA espera, consultando as Reducoes Z gravadas em SigFiRx.
	*
	* Transcricao do ramo "Case crSigFiFis.Imps = 'NSWEDA' Or
	* crSigFiFis.Imps = 'DARUMA'" do CmdInserir.Click legado
	* (sigopvci_form_codigo_fonte.txt:703-720):
	*
	*   ldDtIni  = ThisForm.Text3.Value
	*   lcQryIni = [Select Top 1 dtredzs, SeqFinal2 from SigFiRx Where
	*              serifab = '] + lnNoFabr + [' And dtredzs < ?ldDtIni
	*              Order by DtRedzs Desc]
	*   Select csTmpRelX
	*   If Eof()
	*       lcInic = '000001'
	*   Else
	*       lcInic = Transform(Val(SeqFinal2)+1,'@L 999999')
	*   Endif
	*   ldDtIni  = ThisForm.Text4.Value
	*   lcQryIni = [Select Top 1 dtredzs, SeqFinal2 from SigFiRx Where
	*              serifab = '] + lnNoFabr + [' And dtredzs >= ?ldDtIni]
	*   Select csTmpRelX
	*   If Eof()
	*       lcFim = '999999'
	*   Else
	*       lcFim = Transform(Val(SeqFinal2),'@L 999999')
	*   EndIf
	*
	* A LOGICA e os LITERAIS ('000001' no inicio, '999999' no fim, o +1 no
	* SeqFinal2 da reducao ANTERIOR) sao regra de negocio e estao
	* transcritos literalmente - regra CLAUDE.md #17. A SEGUNDA consulta
	* NAO tem ORDER BY no legado e tambem nao recebe um aqui: acrescentar
	* mudaria o registro escolhido.
	*
	* Colunas conferidas no schema canonico (docs/schema.sql, UTF-16 - regra
	* CLAUDE.md #14): SigFiRx.serifab char(20), SigFiRx.dtredzs datetime
	* NULL, SigFiRx.seqfinal2 char(6).
	*====================================================================
	FUNCTION ResolverSequenciaPorData(par_cNumFabricacao)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cFab, loc_oErro

		loc_lResultado = .F.
		THIS.this_cSequenciaInicial = ""
		THIS.this_cSequenciaFinal   = ""

		loc_cFab = IIF(VARTYPE(par_cNumFabricacao) = "C", ALLTRIM(par_cNumFabricacao), "")

		TRY
			*-- Inicio da faixa: SeqFinal2 da ULTIMA Reducao Z ANTERIOR a data
			*-- inicial, somada de 1; sem reducao anterior, o primeiro cupom.
			IF USED("cursor_4c_RelX")
				IF CURSORGETPROP("Buffering", "cursor_4c_RelX") > 1
					TABLEREVERT(.T., "cursor_4c_RelX")
				ENDIF
				USE IN cursor_4c_RelX
			ENDIF

			loc_cSQL = "SELECT TOP 1 dtredzs, seqfinal2 FROM SigFiRx" + ;
				" WHERE serifab = " + EscaparSQL(loc_cFab) + ;
				" AND dtredzs < " + FormatarDataSQL(THIS.this_dDataInicial) + ;
				" ORDER BY dtredzs DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelX")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Erro ao consultar Redu" + CHR(231) + CHR(245) + ;
					"es Z (SigFiRx)." + CHR(13) + CapturarErroSQL()
			ELSE
				IF USED("cursor_4c_RelX") AND RECCOUNT("cursor_4c_RelX") > 0
					SELECT cursor_4c_RelX
					GO TOP
					THIS.this_cSequenciaInicial = TRANSFORM(VAL(TratarNulo(seqfinal2, "")) + 1, "@L 999999")
				ELSE
					THIS.this_cSequenciaInicial = "000001"
				ENDIF

				IF USED("cursor_4c_RelX")
					USE IN cursor_4c_RelX
				ENDIF

				*-- Fim da faixa: SeqFinal2 da PRIMEIRA Reducao Z em ou apos a
				*-- data final; sem reducao posterior, o ultimo cupom possivel.
				loc_cSQL = "SELECT TOP 1 dtredzs, seqfinal2 FROM SigFiRx" + ;
					" WHERE serifab = " + EscaparSQL(loc_cFab) + ;
					" AND dtredzs >= " + FormatarDataSQL(THIS.this_dDataFinal)

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelX")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao consultar Redu" + CHR(231) + CHR(245) + ;
						"es Z (SigFiRx)." + CHR(13) + CapturarErroSQL()
				ELSE
					IF USED("cursor_4c_RelX") AND RECCOUNT("cursor_4c_RelX") > 0
						SELECT cursor_4c_RelX
						GO TOP
						THIS.this_cSequenciaFinal = TRANSFORM(VAL(TratarNulo(seqfinal2, "")), "@L 999999")
					ELSE
						THIS.this_cSequenciaFinal = "999999"
					ENDIF

					loc_lResultado = .T.
				ENDIF
			ENDIF

			IF USED("cursor_4c_RelX")
				USE IN cursor_4c_RelX
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao resolver faixa de cupom")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Este BO nao persiste registro proprio (o cupom
	* e lido da impressora fiscal, fora do SQL Server - ver cabecalho
	* deste arquivo). A chave mais proxima de "registro em edicao" e a
	* PK da configuracao de impressora fiscal corrente (SigFiFis.
	* Cidchaves), usada so por completude de contrato - RegistrarAuditoria
	* nunca e chamado, porque Inserir/Atualizar nao sao sobrescritos.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* Inserir() / Atualizar() / ExecutarExclusao() - este formulario nao
	* grava registro proprio no banco (o cupom e extraido da memoria da
	* impressora fiscal via DLL do fabricante e apenas exibido em tela -
	* ver cabecalho deste arquivo); o comportamento padrao herdado de
	* BusinessBase ja eh o correto para este BO, entao esses tres metodos
	* nao sao sobrescritos aqui.
	*====================================================================

ENDDEFINE

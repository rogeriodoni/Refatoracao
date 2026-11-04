*==============================================================================
* SigOpDpeBO.prg
*
* Business Object para a Tabela de Depreciacao da Operacao (dialogo modal
* aberto a partir da grade de operacoes do Cadastro de Operacoes - SigCdOpe),
* onde o usuario mantem as faixas de dias (Qtd Dias Inicial / Qtd Dias Final)
* e o percentual de depreciacao aplicado a cada faixa.
*
* Tabela gravada: SigOpDup (chave: cidchaves char(20)):
*
*    [cidchaves] char(20)      NOT NULL   (PK)
*    [dopes]     char(20)      NOT NULL   - operacao dona (SigCdOpe.dopes)
*    [qtddis]    numeric(4,0)  NOT NULL   - Column1 "Qtd Dias Inicial"
*    [qtddfs]    numeric(4,0)  NOT NULL   - Column2 "Qtd Dias Final"
*    [percs]     numeric(5,2)  NOT NULL   - Column3 "%"
*
*------------------------------------------------------------------------------
* MODELO DE GRAVACAO (transcrito do legado)
*
* A tela NAO grava linha a linha: ela acumula as alteracoes no cursor da
* grade (crSigOpDup no legado, cursor_4c_Dados aqui) e persiste TUDO de uma
* vez ao encerrar, no cmdSair.Click:
*
*    Select CrSigOpDup
*    Go Top
*    Delete For Empty(Dopes) or Empty(Qtddfs)
*    Replace CidChaves with fUniqueIds() For Empty(CidChaves)
*    ... poDataMgr.UpDate('crSigOpDup') / Commit() / RollBack()
*
* Os dois marcadores lHouveIns / lHouveExcl do legado SAO properties do FORM
* (RESERVED3 do dump lista lhouveexcl/lhouveins como custom property de
* SIGOPDPE, nao do BO) - por isso ficam em FormSigOpDpe (this_lHouveIns/
* this_lHouveExcl), e este BO so executa a manipulacao de DADOS: quem decide
* se a gravacao chega a ser tentada eh o CmdEncerrarClick do form.
*
* IMPORTANTE (regra #22): as CINCO colunas de SigOpDup sao NOT NULL e nenhuma
* tem DEFAULT (conferido em docs/schema.sql, UTF-16, lido com
* Get-Content -Raw). A gravacao cobre todas as cinco.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado nao tem botao de Alterar nem de Buscar: a grade ja abre editavel
* e o unico botao de acao, alem do Encerrar, eh o Excluir (apaga a linha
* corrente do cursor). A remocao definitiva no servidor acontece junto com a
* gravacao do Encerrar, por reconciliacao do conjunto de linhas da operacao,
* e nao por um DELETE disparado a cada clique: ExcluirLinhaCursor apenas marca
* a linha, e GravarFaixas traduz essa marca em DELETE no servidor, dentro do
* mesmo lote transacional dos INSERT e UPDATE. ExecutarExclusao existe e usa o
* MESMO montador de SQL, para o caso de apagar uma faixa isolada pelo
* Excluir() da BusinessBase - assim a lista de colunas e o criterio da chave
* nao podem divergir entre os dois caminhos.
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDpeBO AS BusinessBase

	*--------------------------------------------------------------------------
	* PROPRIEDADES DA ENTIDADE - SigOpDup
	*--------------------------------------------------------------------------
	this_cCidChaves = ""   && cidchaves char(20)     - PK (fUniqueIds)
	this_cDopes     = ""   && dopes     char(20)     - operacao dona
	this_nQtddis    = 0    && qtddis    numeric(4,0) - Column1 "Qtd Dias Inicial"
	this_nQtddfs    = 0    && qtddfs    numeric(4,0) - Column2 "Qtd Dias Final"
	this_nPercs     = 0    && percs     numeric(5,2) - Column3 "%"

	*--------------------------------------------------------------------------
	* CONTEXTO RECEBIDO DO FORM PAI
	*
	* Legado: lcOperacao = crSigCdOpe.Dopes, lido no Init a partir do cursor
	* da operacao que o cadastro de Tipos de Operacao mantem aberto. Aqui o
	* valor chega por parametro e fica guardado nesta property, que eh a
	* FONTE UNICA da coluna dopes de toda linha nova.
	*--------------------------------------------------------------------------
	this_cOperacao = ""         && Dopes da operacao corrente (contexto)
	this_cEscolha  = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR

	*--------------------------------------------------------------------------
	* PERMISSAO DE EXCLUSAO
	*
	* Legado: .cmdExcluir.Visible = fChecaAcesso('SigOpDup','EXCLUIR') And ;
	*                               InList(PcEscolha,'INSERIR','ALTERAR')
	* Resolvida uma vez e guardada aqui, para o form apenas espelhar no
	* Visible/Enabled do botao.
	*--------------------------------------------------------------------------
	this_lPodeExcluir = .F.

	*--------------------------------------------------------------------------
	* CURSORES DE TRABALHO
	*
	* this_cCursorDados eh o alias ligado ao RecordSource da grade - o mesmo
	* papel do crSigOpDup legado. NUNCA receber SQLEXEC direto: SQLEXEC sobre
	* o alias de um Grid fecha e recria o alias, zerando ColumnCount e
	* deixando a grade um retangulo branco. A carga passa por
	* this_cCursorTemp e eh transferida com ZAP + APPEND FROM DBF().
	*
	* A grade tem coluna EDITAVEL, portanto o cursor de dados precisa ser
	* READWRITE - cursor de SQL pass-through nasce somente-leitura e o
	* REPLACE da edicao estouraria.
	*--------------------------------------------------------------------------
	this_cCursorDados = "cursor_4c_Dados"       && alias do Grid (READWRITE)
	this_cCursorTemp  = "cursor_4c_DadosTmp"    && destino do SQLEXEC

	*--------------------------------------------------------------------------
	* ACOMPANHAMENTO DA GRAVACAO
	*--------------------------------------------------------------------------
	this_nRegistrosInseridos   = 0
	this_nRegistrosAtualizados = 0
	this_nRegistrosExcluidos   = 0

	*--------------------------------------------------------------------------
	* LOTE DE COMANDOS SQL
	*
	* A gravacao do Encerrar abrange varias linhas e tem de ser ATOMICA, como
	* o par Update/Commit-RollBack do poDataMgr legado. Os comandos sao
	* acumulados aqui e executados num unico bloco transacional.
	*--------------------------------------------------------------------------
	this_cLoteGravacao = ""

	*--------------------------------------------------------------------------
	* COLUNAS DO CURSOR DA GRADE - fonte UNICA
	*
	* lnovos NAO eh coluna de SigOpDup: eh o marcador de linha ainda nao
	* gravada no servidor. O legado obtinha essa distincao de graca, porque o
	* crSigOpDup era cursor REMOTO e o poDataMgr.UpDate sabia separar INSERT
	* de UPDATE de DELETE. Aqui a grade vive num CREATE CURSOR comum, logo a
	* distincao tem de ser carregada explicitamente.
	*--------------------------------------------------------------------------
	this_cColunasTabela = "cidchaves,dopes,qtddis,qtddfs,percs"
	this_cColunaNovos   = "lnovos"

	*--------------------------------------------------------------------------
	* CONTROLE DA TRANSACAO DO LOTE
	*
	* BEGIN/COMMIT enviados em SQLEXEC separados NAO protegem nada neste
	* ambiente: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
	* portanto um BEGIN proprio apenas ANINHA e o COMMIT correspondente volta
	* para 1 sem efetivar. Dai o SAVE TRANSACTION com nome proprio quando ja
	* ha transacao aberta e o THROW no CATCH, que faz o erro chegar ao
	* retorno do SQLEXEC e deixa CapturarErroSQL() com o texto real do SQL
	* Server.
	*--------------------------------------------------------------------------
	this_cNomeSavepoint = "SigOpDpe4c"

	*--------------------------------------------------------------------------
	* this_lCursorRecriado - avisa ao form que o alias do Grid foi FECHADO e
	* criado de novo, e que portanto RecordSource e os ControlSource das
	* Columns precisam ser religados.
	*--------------------------------------------------------------------------
	this_lCursorRecriado = .F.

	*==========================================================================
	* Init - Inicializa Business Object
	*
	* par_cOperacao - Dopes da operacao dona das faixas (crSigCdOpe.Dopes no
	*                 legado). Opcional: o form pode informar depois, pela
	*                 property this_cOperacao, antes da primeira carga.
	* par_cEscolha  - PcEscolha herdado do form pai. Vazio equivale a
	*                 "INSERIR", como o IIF(EMPTY(...)) do legado.
	*==========================================================================
	PROCEDURE Init(par_cOperacao, par_cEscolha)
		LOCAL loc_lSucesso, loc_cOperacao, loc_cEscolha, loc_oErro
		loc_lSucesso = .F.

		TRY
			DODEFAULT()

			THIS.this_cTabela     = "SigOpDup"
			THIS.this_cCampoChave = "cidchaves"

			loc_cOperacao = ""
			IF VARTYPE(par_cOperacao) = "C"
				loc_cOperacao = ALLTRIM(par_cOperacao)
			ENDIF
			THIS.this_cOperacao = loc_cOperacao
			THIS.this_cDopes    = loc_cOperacao

			loc_cEscolha = ""
			IF VARTYPE(par_cEscolha) = "C"
				loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
			ENDIF
			IF EMPTY(loc_cEscolha)
				loc_cEscolha = "INSERIR"
			ENDIF
			THIS.this_cEscolha = loc_cEscolha

			*-- Permissao de exclusao: fChecaAcesso + modo editavel (legado)
			THIS.this_lPodeExcluir = fChecaAcesso("SigOpDup", "EXCLUIR") ;
									  AND INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

			THIS.this_nRegistrosInseridos   = 0
			THIS.this_nRegistrosAtualizados = 0
			THIS.this_nRegistrosExcluidos   = 0
			THIS.this_cLoteGravacao         = ""

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "SigOpDpeBO.Init")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InicializarValoresPadrao - defaults da LINHA NOVA
	*
	* Transcricao do Insert Into do inserelinha legado:
	*    Insert Into crSigOpDup (Dopes, CidChaves) ;
	*        Values (crSigCdOpe.Dopes, fUniqueIds())
	*==========================================================================
	PROTECTED PROCEDURE InicializarValoresPadrao()
		THIS.this_cCidChaves = fUniqueIds()
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna a chave (cidchaves) da faixa para
	* auditoria (regra #51 - PROTECTED, so o Excluir()/Salvar() da base
	* chamam)
	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC


	*==========================================================================
	* CriarCursorDados - prepara o cursor READWRITE ligado ao Grid
	*
	* O cursor TEM de ser READWRITE: a grade desta tela eh editavel e cursor
	* de SQL pass-through nasce SOMENTE-LEITURA - o REPLACE da edicao
	* estouraria. Por isso o alias da grade nunca recebe SQLEXEC: a carga
	* passa pelo cursor temporario (ver CarregarFaixas).
	*
	* Ponto UNICO de CREATE CURSOR desta tela. A ordem e a grafia das colunas
	* tem de ser identicas em todo lugar que mencione o cursor, porque o
	* APPEND FROM DBF() casa por NOME.
	*
	* Larguras conferidas em docs/schema.sql: numeric(4,0) sem decimal eh
	* N(4,0); numeric(5,2) sao 3 digitos + 2 decimais, que em VFP (onde a
	* largura inclui o ponto) eh N(6,2). Batem com os InputMask do SCX
	* legado ("9999" e "999.99").
	*
	* par_lForcarRecriar - .T. derruba e recria o alias mesmo que ele exista.
	*                      Quem chamar assim fica responsavel por religar o
	*                      Grid; this_lCursorRecriado avisa que eh o caso.
	*==========================================================================
	PROCEDURE CriarCursorDados(par_lForcarRecriar)
		LOCAL loc_lSucesso, loc_lRecriar, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_lCursorRecriado = .F.

		TRY
			loc_lRecriar = .T.

			IF USED(loc_cAlias)
				loc_lRecriar = .F.

				IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
					loc_lRecriar = .T.
				ENDIF

				*-- Alias herdado de outra tela com estrutura diferente eh pior
				*-- que alias ausente: o ZAP apaga as linhas mas PRESERVA as
				*-- colunas do dono anterior, e o APPEND seguinte falha por
				*-- coluna que esta tela nem conhece.
				IF !loc_lRecriar
					IF !THIS.CursorTemEstruturaEsperada(loc_cAlias)
						loc_lRecriar = .T.
					ENDIF
				ENDIF

				IF loc_lRecriar
					USE IN (loc_cAlias)
				ENDIF
			ENDIF

			IF loc_lRecriar
				CREATE CURSOR (loc_cAlias) ( ;
					cidchaves C(20), ;
					dopes     C(20), ;
					qtddis    N(4, 0), ;
					qtddfs    N(4, 0), ;
					percs     N(6, 2), ;
					lnovos    L )

				THIS.this_lCursorRecriado = .T.
			ENDIF

			*-- SET DELETED eh escopado por data session e o form eh
			*-- DataSession = 2: o SET DELETED ON do config.prg roda na sessao
			*-- 1 e NAO alcanca a sessao privada, que nasce com DELETED OFF.
			*-- Sem repor aqui, o DELETE do botao Excluir apenas MARCA a linha
			*-- e ela continua aparecendo na grade - o usuario clica Excluir e
			*-- nada some, sem erro e sem log.
			SET DELETED ON

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao preparar o cursor da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CursorTemEstruturaEsperada - confere se o alias tem as colunas desta tela
	*
	* PEMSTATUS NAO serve para isto: o primeiro argumento tem de ser OBJETO, e
	* passar nome de cursor dispara "Function argument value, type, or count
	* is invalid.". Campo de cursor se confere com TYPE(alias + ".campo").
	*==========================================================================
	PROTECTED FUNCTION CursorTemEstruturaEsperada(par_cAlias)
		LOCAL loc_lOk, loc_cLista, loc_cAlias, loc_cCampo, loc_nI, loc_nTotal

		loc_lOk    = .T.
		loc_cAlias = ALLTRIM(NVL(par_cAlias, ""))
		loc_cLista = ALLTRIM(THIS.this_cColunasTabela) + "," + ALLTRIM(THIS.this_cColunaNovos)

		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
			loc_lOk = .F.
		ELSE
			loc_nTotal = OCCURS(",", loc_cLista) + 1

			FOR loc_nI = 1 TO loc_nTotal
				loc_cCampo = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))

				IF !EMPTY(loc_cCampo)
					IF TYPE(loc_cAlias + "." + loc_cCampo) = "U"
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDIF
			ENDFOR
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarFaixas - traz as faixas de depreciacao da operacao corrente
	*
	* Equivale ao trecho de carga do Init legado:
	*     With SigCdOpe.poDatamgr
	*         .ReQuery('crSigOpDup') / SELECT crSigOpDup / Go Top
	*     EndWith
	*
	* O SELECT vai para um cursor TEMPORARIO e o conteudo eh transferido com
	* ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias do Grid FECHA e
	* RECRIA o alias, zerando ColumnCount: a grade viraria um retangulo
	* branco sem cabecalho e sem coluna, e nada a religaria depois.
	*
	* Filtro por dopes, como o cursor parametrizado do legado - esta tela
	* edita as faixas de UMA operacao. Sem operacao no contexto, cursor vazio
	* eh o resultado CERTO.
	*==========================================================================
	PROCEDURE CarregarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasTmp
		LOCAL loc_cSQL, loc_nResultado, loc_cSafety, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)
		loc_cSafety     = ""

		THIS.this_cMensagemErro = ""

		TRY
			IF !THIS.CriarCursorDados()
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(NVL(THIS.this_cOperacao, "")))
					*-- Grade vazia com a estrutura pronta: nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					*-- Sem conexao (modo de teste / validacao de UI) a grade
					*-- abre vazia, e isso tambem nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- Comparacao sem RTRIM de proposito: dopes eh char(20) e o
				*-- SQL Server compara char com preenchimento de brancos
				*-- (ANSI), entao o = casa e o indice segue utilizavel.
				loc_cSQL = "SELECT cidchaves, dopes, qtddis, qtddfs, percs" + ;
						   " FROM SigOpDup" + ;
						   " WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao)) + ;
						   " ORDER BY qtddis, qtddfs"

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + ;
						"o da opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- SET SAFETY tambem eh escopado por data session: com
				*-- DataSession = 2 vale ON mesmo com o SET SAFETY OFF do
				*-- main.prg, e ai o ZAP abre o dialogo modal "Are you sure?"
				*-- e CONGELA a tela esperando um clique que ninguem ve.
				loc_cSafety = SET("SAFETY")
				SET SAFETY OFF

				SELECT (loc_cAlias)
				ZAP

				IF loc_cSafety = "ON"
					SET SAFETY ON
				ENDIF
				loc_cSafety = ""

				*-- lnovos chega .F. em toda linha do servidor, porque o APPEND
				*-- casa por NOME e o cursor temporario nao tem essa coluna -
				*-- que eh exatamente o desejado: linha vinda do banco eh
				*-- UPDATE na gravacao, nunca INSERT.
				SELECT (loc_cAlias)
				APPEND FROM DBF(loc_cAliasTmp)

				SELECT (loc_cAlias)
				GO TOP

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirLinhaCursor - acrescenta a linha EM BRANCO de digitacao
	*
	* Transcricao da parte de DADOS do inserelinha legado:
	*     Select crSigOpDup
	*     Locate for Qtddfs=0
	*     If Eof()
	*         Insert Into crSigOpDup (Dopes, CidChaves) ;
	*             Values (crSigCdOpe.Dopes, fUniqueIds())
	*     EndIf
	*     Select crSigOpDup
	*
	* O marcador Thisform.lHouveIns = .T. do legado eh property do FORM (ver
	* cabecalho) e fica em FormSigOpDpe.InserirLinhaCursor, NAO aqui - este
	* metodo so cuida do CURSOR.
	*
	* O Keyboard '{DNARROW}', o GradeSubN.Refresh e o Column1.SetFocus do
	* legado sao da TELA e ficam no form.
	*
	* A linha nasce so com dopes e cidchaves; a coluna qtddfs fica no valor em
	* branco do cursor, que eh zero - e eh justamente qtddfs = 0 que marca a
	* linha como "em branco", tanto para o LOCATE daqui quanto para o
	* descarte da gravacao.
	*==========================================================================
	PROCEDURE InserirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)
				LOCATE FOR qtddfs = 0

				IF EOF()
					INSERT INTO (loc_cAlias) (cidchaves, dopes, lnovos) ;
						VALUES (LEFT(fUniqueIds(), 20), ;
								LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20), ;
								.T.)
				ENDIF

				SELECT (loc_cAlias)
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao inserir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExcluirLinhaCursor - remove a linha corrente da grade (cmdExcluir.Click)
	*
	* Transcricao da parte de DADOS do cmdExcluir.Click legado:
	*     Select crSigOpDup
	*     If Not Eof()
	*         Thisform.lHouveExcl = .T.
	*         Delete
	*         Skip
	*         Skip - 1
	*     Endif
	*
	* O marcador lHouveExcl eh property do FORM (ver cabecalho) - este metodo
	* devolve .T. quando de fato excluiu (a mesma condicao "Not Eof()" que
	* abre o bloco legado), e o form decide ligar o marcador a partir disso.
	*
	* A remocao eh LOCAL: no legado o DELETE so chega ao servidor junto com a
	* gravacao do Encerrar - o poDataMgr.UpDate propaga INSERT, UPDATE e
	* DELETE do cursor remoto de uma vez. GravarFaixas reproduz isso.
	*
	* O par Skip / Skip -1 reposiciona o ponteiro no registro visivel mais
	* proximo e depende de SET DELETED ON, reposto em CriarCursorDados.
	*==========================================================================
	PROCEDURE ExcluirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)

				IF !EOF()
					loc_lSucesso = .T.
					DELETE
					SKIP
					SKIP -1
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao excluir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* GravarFaixas - persiste TODAS as faixas de uma vez (cmdSair.Click legado)
	*
	* Transcricao do cmdSair.Click legado:
	*     Select CrSigOpDup
	*     Go Top
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*     ... poDataMgr.UpDate / Commit / RollBack ...
	*     erro -> MessageBox de "Erro na Gravacao dos Dados do Cadastro de Operacoes."
	*
	* O poDataMgr.UpDate de um cursor REMOTO propaga as tres operacoes de uma
	* vez: INSERT das linhas acrescentadas, UPDATE das alteradas e DELETE das
	* marcadas. Aqui a grade vive num CREATE CURSOR comum, entao a
	* reconciliacao eh explicita - e eh para isso que lnovos existe:
	*
	*     linha marcada DELETED, lnovos = .F.  -> DELETE no servidor
	*     linha marcada DELETED, lnovos = .T.  -> nada (nunca foi gravada)
	*     linha viva, lnovos = .T.             -> INSERT
	*     linha viva, lnovos = .F.             -> UPDATE
	*
	* O GUARD "Thisform.lHouveExcl Or Thisform.lHouveIns" do legado mora no
	* CmdEncerrarClick do form (ele eh property do form) - este metodo roda
	* incondicionalmente, varrendo o cursor.
	*==========================================================================
	PROCEDURE GravarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasAnterior
		LOCAL loc_cDeleted, loc_nRecnoAnterior, loc_cComando, loc_oErro

		loc_lSucesso       = .T.
		loc_lProsseguir    = .T.
		loc_cAlias         = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasAnterior = ALIAS()
		loc_cDeleted       = ""
		loc_nRecnoAnterior = 0

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.
		THIS.this_cLoteGravacao = ""

		THIS.this_nRegistrosInseridos   = 0
		THIS.this_nRegistrosAtualizados = 0
		THIS.this_nRegistrosExcluidos   = 0

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
				loc_lProsseguir = .F.
				loc_lSucesso    = .F.
			ENDIF

			IF loc_lProsseguir
				*-- RECNO guardado junto com o alias: o SCAN abaixo varre o
				*-- cursor inteiro e deixa o ponteiro em EOF. Repor so o alias
				*-- devolveria a area de trabalho certa com a LINHA errada, e
				*-- a grade do usuario mudaria de registro sozinha.
				loc_nRecnoAnterior = RECNO(loc_cAlias)

				*-- Descarte do legado: linha sem operacao, ou com qtd dias
				*-- final zerada (a linha "em branco" de digitacao), nao eh
				*-- gravada.
				SELECT (loc_cAlias)
				GO TOP
				DELETE FOR EMPTY(dopes) OR qtddfs = 0

				*-- A PK eh gerada por LINHA. Cada registro recebe um valor
				*-- proprio porque o VFP reavalia a expressao do WITH a cada
				*-- registro - chave repetida colidiria no indice unico a
				*-- partir da segunda linha.
				REPLACE cidchaves WITH LEFT(fUniqueIds(), 20) ;
					FOR EMPTY(cidchaves) IN (loc_cAlias)

				*-- DELETED OFF para o SCAN VER as linhas marcadas: sao elas
				*-- que viram DELETE no servidor. Reposto apos a varredura.
				loc_cDeleted = SET("DELETED")
				SET DELETED OFF

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					loc_cComando = ""

					IF DELETED()
						*-- Linha removida da grade. Se nunca foi gravada, nao
						*-- existe no servidor e nada ha a apagar la.
						IF !lnovos AND !EMPTY(cidchaves)
							THIS.CarregarDoCursor(loc_cAlias)
							loc_cComando = THIS.MontarDeleteLinha()

							IF EMPTY(loc_cComando)
								MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
								THIS.this_lErroExibido = .T.
								loc_lProsseguir = .F.
								loc_lSucesso    = .F.
								EXIT
							ENDIF

							THIS.AcrescentarAoLote(loc_cComando)
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("DELETE"))
							THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
						ENDIF
					ELSE
						THIS.CarregarDoCursor(loc_cAlias)

						*-- Depois do descarte acima nenhuma linha viva deveria
						*-- reprovar. Se reprovar, a gravacao INTEIRA para com
						*-- a mensagem: pular a linha calada gravaria o resto e
						*-- perderia essa sem o usuario saber.
						IF !THIS.ValidarDados()
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						IF lnovos
							loc_cComando = THIS.MontarInsertLinha()
						ELSE
							loc_cComando = THIS.MontarUpdateLinha()
						ENDIF

						IF EMPTY(loc_cComando)
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						THIS.AcrescentarAoLote(loc_cComando)

						IF lnovos
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("INSERT"))
							THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
						ELSE
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("UPDATE"))
							THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
						ENDIF
					ENDIF
				ENDSCAN

				IF loc_cDeleted = "ON"
					SET DELETED ON
				ENDIF
				loc_cDeleted = ""
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(THIS.this_cLoteGravacao))
					*-- Nada sobrou: as linhas em aberto eram todas em branco e
					*-- cairam no mesmo descarte do legado.
					loc_lSucesso = .T.
				ELSE
					loc_lSucesso = THIS.ExecutarLoteGravacao()
				ENDIF
			ENDIF

			IF USED(loc_cAlias)
				IF loc_lProsseguir AND loc_lSucesso
					*-- Gravou: as linhas marcadas saem FISICAMENTE do cursor e
					*-- as novas deixam de ser novas. Sem isso, uma segunda
					*-- gravacao reenviaria os mesmos DELETE e repetiria os
					*-- INSERT, colidindo na chave primaria.
					SELECT (loc_cAlias)
					PACK
					REPLACE ALL lnovos WITH .F. IN (loc_cAlias)
					GO TOP IN (loc_cAlias)
				ELSE
					IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(loc_cAlias))
						GO loc_nRecnoAnterior IN (loc_cAlias)
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			IF loc_cDeleted = "ON"
				SET DELETED ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
				"Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* AcrescentarAoLote - enfileira um comando no lote transacional
	*==========================================================================
	PROTECTED FUNCTION AcrescentarAoLote(par_cComando)
		LOCAL loc_lOk, loc_cComando

		loc_lOk      = .F.
		loc_cComando = ALLTRIM(NVL(par_cComando, ""))

		IF !EMPTY(loc_cComando)
			THIS.this_cLoteGravacao = THIS.this_cLoteGravacao + loc_cComando + ;
				";" + CHR(13) + CHR(10)
			loc_lOk = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* ExecutarLoteGravacao - manda o lote num SQLEXEC unico e ATOMICO
	*==========================================================================
	PROTECTED FUNCTION ExecutarLoteGravacao()
		LOCAL loc_lOk, loc_cSQL, loc_cCRLF, loc_cSavepoint
		LOCAL loc_nResultado, loc_lManual

		loc_lOk   = .F.
		loc_cCRLF = CHR(13) + CHR(10)

		IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteGravacao, "")))
			THIS.this_cMensagemErro = "Nada para gravar."
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			RETURN .F.
		ENDIF

		loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

		*-- Medido: com a conexao em auto-commit o par fica inerte. IF
		*-- ANINHADO mais abaixo de proposito - VFP9 nao faz curto-circuito
		*-- em AND e chamaria o SQLCOMMIT de qualquer jeito.
		loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

		loc_cSQL = "SET NOCOUNT ON;" + loc_cCRLF + ;
			"DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
			"ELSE SAVE TRANSACTION " + loc_cSavepoint + ";" + loc_cCRLF + ;
			"BEGIN TRY" + loc_cCRLF + ;
			THIS.this_cLoteGravacao + ;
			"IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
			"END TRY" + loc_cCRLF + ;
			"BEGIN CATCH" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
			"ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION " + loc_cSavepoint + "; END;" + loc_cCRLF + ;
			"THROW;" + loc_cCRLF + ;
			"END CATCH"

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

		IF loc_nResultado < 0
			THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
				"o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + "es." + ;
				CHR(13) + CapturarErroSQL()
			loc_lOk = .F.
		ELSE
			loc_lOk = .T.
		ENDIF

		IF loc_lManual
			IF loc_lOk
				= SQLCOMMIT(gnConnHandle)
			ENDIF
		ENDIF

		THIS.this_cLoteGravacao = ""

		IF !loc_lOk
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarDoCursor - Carrega as propriedades da faixa a partir de uma
	* linha do cursor crSigOpDup/cursor_4c_Dados
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*
	* par_cAliasCursor - alias a ler. Omitido, usa o cursor da grade.
	*
	* GUARDA DE EOF obrigatoria: em VFP ler campo com o ponteiro em EOF NAO
	* da erro - devolve o valor EM BRANCO do tipo. Sem o IF EOF() abaixo este
	* metodo zerava as cinco properties e ainda devolvia .T., ou seja relatava
	* SUCESSO sem haver linha nenhuma. Dois estragos, os dois silenciosos:
	*   - this_cCidChaves e this_cDopes ficavam VAZIOS, e a gravacao seguinte
	*     tentaria persistir uma faixa sem chave e sem operacao;
	*   - com this_cCidChaves vazio, a GUARDA DE IDENTIDADE do
	*     FormSigOpDpe.BOParaForm (que compara a chave do BO com a da linha
	*     corrente) deixa de valer e a escrita passa a atingir QUALQUER linha.
	* Medido no VFP9 em 2026-10-31 (automation\Probe724F8.prg, item 8): com o
	* ponteiro em EOF o metodo devolvia .T. Mesma forma do BO do dialogo-irmao
	* SigOpCrdBO.CarregarDoCursor.
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro
		loc_lSucesso = .F.

		loc_cAlias = ALLTRIM(THIS.this_cCursorDados)
		IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
			loc_cAlias = ALLTRIM(par_cAliasCursor)
		ENDIF

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ELSE
				SELECT (loc_cAlias)

				IF EOF()
					*-- Sem linha corrente nao ha o que carregar. As properties
					*-- ficam COMO ESTAVAM de proposito: zera-las aqui
					*-- destruiria a faixa que o chamador ja tinha em maos.
					THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
						" linha corrente para carregar."
				ELSE
					THIS.this_cCidChaves = TratarNulo(cidchaves, "")
					THIS.this_cDopes     = TratarNulo(dopes,     "")
					THIS.this_nQtddis    = TratarNulo(qtddis,    0)
					THIS.this_nQtddfs    = TratarNulo(qtddfs,    0)
					THIS.this_nPercs     = TratarNulo(percs,     0)

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigOpDpeBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDados - criterio de aceitacao de UMA faixa
	*
	* O legado NAO tem validacao de tela aqui: a unica regra que ele aplica eh
	* o descarte do cmdSair.Click,
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	* mais a exigencia implicita de chave,
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*
	* Sao essas as tres condicoes conferidas aqui, e NADA ALEM - em especial
	* NAO se exige qtddis <= qtddfs nem percs > 0: o legado aceita tudo isso,
	* e inventar a regra bloquearia gravacao que hoje funciona.
	*==========================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido

		loc_lValido = .F.
		THIS.this_cMensagemErro = ""

		DO CASE
		CASE EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
			THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
				"o da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."

		CASE THIS.this_nQtddfs = 0
			THIS.this_cMensagemErro = "Qtd Dias Final n" + CHR(227) + "o informada."

		CASE EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
			THIS.this_cMensagemErro = "Chave da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o gerada."

		OTHERWISE
			loc_lValido = .T.
		ENDCASE

		RETURN loc_lValido
	ENDPROC

	*==========================================================================
	* MontarInsertLinha - INSERT da faixa corrente, com as CINCO colunas
	*
	* As cinco colunas de SigOpDup sao NOT NULL e nenhuma tem DEFAULT
	* (conferido em docs/schema.sql, UTF-16, lido com Get-Content -Raw). O
	* legado grava o registro INTEIRO - AddCursor sem query eh SELECT * +
	* TABLEUPDATE - entao as duas colunas que nao aparecem na tela (cidchaves
	* e dopes) continuam sendo gravadas.
	*
	* LEFT(...,20) nas duas colunas char: a largura vem do SCHEMA, nunca do
	* tamanho do controle na tela.
	*==========================================================================
	PROTECTED FUNCTION MontarInsertLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - inclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "INSERT INTO SigOpDup" + ;
			" (cidchaves, dopes, qtddis, qtddfs, percs)" + ;
			" VALUES (" + EscaparSQL(loc_cChave) + ", " + ;
			EscaparSQL(loc_cDopes) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddis, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddfs, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nPercs, 2) + ")"
	ENDFUNC

	*==========================================================================
	* MontarUpdateLinha - UPDATE da faixa corrente, pela chave primaria
	*
	* dopes entra no SET junto com as duas numericas porque eh coluna de
	* DADOS do registro (e NOT NULL), nao parte da chave: a PK de SigOpDup eh
	* so cidchaves (constraint sigopdup_cidchaves).
	*==========================================================================
	PROTECTED FUNCTION MontarUpdateLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - altera" + CHR(231) + CHR(227) + ;
				"o cancelada."
			RETURN ""
		ENDIF

		RETURN "UPDATE SigOpDup SET" + ;
			" dopes = " + EscaparSQL(loc_cDopes) + "," + ;
			" qtddis = " + FormatarNumeroSQL(THIS.this_nQtddis, 0) + "," + ;
			" qtddfs = " + FormatarNumeroSQL(THIS.this_nQtddfs, 0) + "," + ;
			" percs = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ;
			" WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarDeleteLinha - DELETE da faixa corrente, pela chave primaria
	*==========================================================================
	PROTECTED FUNCTION MontarDeleteLinha()
		LOCAL loc_cChave

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)

		IF EMPTY(loc_cChave)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave - exclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "DELETE FROM SigOpDup WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarInsertAuditoria - comando de auditoria para entrar no MESMO lote
	*
	* Vai junto com a operacao no lote transacional, e nao por SQLEXEC a
	* parte: assim o log nunca registra uma gravacao que foi desfeita.
	*
	* DataHora recebe GETDATE() literal, funcao do servidor - NUNCA
	* GETDATE(), que devolveria a string "NULL" e o INSERT
	* quebraria na coluna NOT NULL.
	*
	* Larguras de LogAuditoria no schema: Tabela varchar(100),
	* Operacao varchar(10), ChaveRegistro varchar(100), Usuario varchar(50).
	*==========================================================================
	PROTECTED FUNCTION MontarInsertAuditoria(par_cOperacao)
		LOCAL loc_cOperacao, loc_cChave, loc_cUsuario

		loc_cOperacao = UPPER(ALLTRIM(NVL(par_cOperacao, "")))
		loc_cChave    = ALLTRIM(NVL(THIS.ObterChavePrimaria(), ""))
		loc_cUsuario  = "SISTEMA"

		IF TYPE("gc_4c_UsuarioLogado") = "C"
			IF !EMPTY(ALLTRIM(gc_4c_UsuarioLogado))
				loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
			ENDIF
		ENDIF

		*-- Sem operacao ou sem chave nao ha o que auditar. Devolver vazio eh
		*-- inocuo: AcrescentarAoLote ignora comando vazio e a gravacao do
		*-- DADO, que eh o que importa, segue adiante.
		IF EMPTY(loc_cOperacao) OR EMPTY(loc_cChave)
			RETURN ""
		ENDIF

		RETURN "INSERT INTO LogAuditoria" + ;
			" (Tabela, Operacao, ChaveRegistro, Usuario, DataHora)" + ;
			" VALUES (" + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTabela), 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
			EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cUsuario, 50)) + ", GETDATE())"
	ENDFUNC

	*==========================================================================
	* Inserir - grava UMA faixa de depreciacao (caminho do Salvar da
	* BusinessBase). O caminho normal desta tela eh a gravacao em LOTE do
	* Encerrar (GravarFaixas) - este metodo cumpre o contrato Salvar() ->
	* Inserir() da BusinessBase e compartilha o MESMO montador de SQL, para
	* que a lista de colunas nao possa divergir entre os dois caminhos.
	*
	* cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22),
	* senao a segunda faixa incluida colide na chave primaria.
	*==========================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
				THIS.this_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20)
			ENDIF

			loc_cSQL = THIS.MontarInsertLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao inserir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Inserir")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - grava a alteracao de UMA faixa (contrato do Salvar)
	* WHERE por cidchaves, a PK real da linha (dopes identifica a operacao
	* proprietaria, nao a faixa individual)
	*==========================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarUpdateLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao atualizar a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Atualizar")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - apaga UMA faixa no servidor, pela chave primaria
	*
	* PROTECTED de proposito (regra #51): de fora, sempre Excluir() da
	* BusinessBase, que valida o estado, roda os hooks e garante que a falha
	* nunca eh muda.
	*
	* No fluxo da TELA a remocao eh local (ExcluirLinhaCursor) e so chega ao
	* servidor junto com a gravacao do Encerrar, por reconciliacao - que eh o
	* que o poDataMgr.UpDate do cursor remoto fazia. Os dois caminhos usam o
	* MESMO montador de SQL.
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarDeleteLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				*-- Auditoria ANTES do DELETE: ObterChavePrimaria le a
				*-- property, que o LimparDados do Excluir() zera depois.
				THIS.RegistrarAuditoria("DELETE")

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao excluir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.ExecutarExclusao")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* LimparDados - devolve as propriedades ao estado de registro novo
	*
	* dopes volta para a operacao do CONTEXTO, nao para vazio: toda faixa
	* desta tela pertence a operacao que o form pai esta editando.
	*==========================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cCidChaves = ""
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		THIS.this_cLoteGravacao = ""

		RETURN .T.
	ENDPROC

	*==========================================================================
	* Destroy - fecha os cursores desta tela
	*
	* USE IN fecha o alias mesmo com buffer sujo, e por isso NAO ha
	* TABLEREVERT aqui: TABLEREVERT exige buffering e, sobre cursor criado por
	* CREATE CURSOR (que nasce com Buffering = 1), dispara o erro 1586
	* "Function requires row or table buffering mode."
	*==========================================================================
	PROCEDURE Destroy()
		IF USED(ALLTRIM(THIS.this_cCursorTemp))
			USE IN (ALLTRIM(THIS.this_cCursorTemp))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorDados))
			USE IN (ALLTRIM(THIS.this_cCursorDados))
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

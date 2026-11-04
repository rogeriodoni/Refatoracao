*====================================================================
* SigOpEmbBO.prg
*
* Business Object para SigOpEmb (Quantidade de Embalagens)
* Form OPERACIONAL: dialogo modal chamado pelo form PAI de itens da
* movimentacao (SIGMVITN). Para o item corrente (crTpmMvItn.Citens),
* lista TODAS as embalagens cadastradas em SigCdEmb e permite digitar
* a quantidade de cada uma; ao confirmar, regrava as linhas de
* SigMvIte daquele item e devolve o peso total ao form pai
* (parentform.pesoemb no legado).
*
* Tabela principal (persistencia): SigMvIte  - chave cidchaves
* Tabela de referencia (leitura):  SigCdEmb  - chave cods
*
* ATENCAO - chave POSICIONAL (CLAUDE.md regra #42): empdopnums eh
* char(29) e vale Emps char(3) + Dopes char(20) + Str(Numes, 6).
* ALLTRIM nas partes encurta a chave, ela nunca casa e o SELECT
* devolve ZERO linhas em silencio. Usar MontarChaveEmpDopNums().
*
* Conteudo deste arquivo: declaracoes de propriedades, Init(), os dois
* metodos de chave, a carga da grade (cadastro de embalagens + linhas
* ja gravadas do item), o calculo de peso, a confirmacao que regrava as
* linhas do item e o CRUD de SigMvIte (CarregarDoCursor, Inserir,
* Atualizar, ExecutarExclusao) com auditoria em lote transacional.
*====================================================================

DEFINE CLASS SigOpEmbBO AS BusinessBase

	*----------------------------------------------------------------
	* Colunas de SigMvIte (linha de embalagem do item da movimentacao)
	* Todas as 9 colunas da tabela sao NOT NULL (docs\schema.sql) -
	* o INSERT tem de cobrir TODAS elas (CLAUDE.md regra #22).
	*----------------------------------------------------------------
	this_cCidchaves   = ""   && cidchaves char(20) NOT NULL - PK (fUniqueIds())
	this_nCitens      = 0    && citens numeric(10,0) NOT NULL - item da movimentacao (crTpmMvItn.Citens)
	this_cCodembs     = ""   && codembs char(3) NOT NULL - codigo da embalagem (= SigCdEmb.cods)
	this_cDopes       = ""   && dopes char(20) NOT NULL - operacao da movimentacao
	this_cEmpdopnums  = ""   && empdopnums char(29) NOT NULL - Emps+Dopes+Str(Numes,6)
	this_cEmps        = ""   && emps char(3) NOT NULL - empresa
	this_nNumes       = 0    && numes numeric(6,0) NOT NULL - numero da movimentacao
	this_nPesos       = 0    && pesos numeric(9,3) NOT NULL - peso da linha (Qtds * PesoEmbs)
	this_nQtds        = 0    && qtds numeric(6,0) NOT NULL - quantidade digitada na grade

	*----------------------------------------------------------------
	* Colunas de SigCdEmb (cadastro de embalagens - somente leitura)
	* O legado traz "Descs, Cods, Pesos as PesoEmbs"; por isso o peso
	* unitario da embalagem tem property PROPRIA (this_nPesoEmbs),
	* separada do peso da linha de SigMvIte (this_nPesos) - as duas
	* colunas se chamam "pesos" nas respectivas tabelas e aparecem
	* JUNTAS na grade (Column3 = PesoEmbs, Column4 = Pesos).
	*----------------------------------------------------------------
	this_cCods        = ""   && cods char(3) NOT NULL - PK de SigCdEmb
	this_cDescs       = ""   && descs char(20) NOT NULL - descricao da embalagem
	this_nPesoEmbs    = 0    && pesos numeric(11,2) de SigCdEmb - peso unitario (alias PesoEmbs)
	this_nMultis      = 0    && multis numeric(5,1) de SigCdEmb - coluna da tabela de referencia; a consulta do legado nao a traz
	this_nPrecos      = 0    && precos numeric(11,2) de SigCdEmb - coluna da tabela de referencia; a consulta do legado nao a traz

	*----------------------------------------------------------------
	* Contexto recebido do form PAI
	* No legado o dialogo recebe poForm (o form pai) e le/escreve
	* direto nos cursores globais dele. Aqui os nomes dos cursores
	* do pai ficam em propriedades para o Form nao repetir literais.
	*----------------------------------------------------------------
	this_cCursorItensMov     = "crSigMvIte"   && cursor do pai com as linhas de SigMvIte de toda a movimentacao
	this_cCursorItemCorrente = "crTpmMvItn"   && cursor do pai posicionado no item corrente (fonte de Citens)

	*----------------------------------------------------------------
	* Cursores que este BO popula/consome
	* Nomes PROPRIOS (nao "cursor_4c_Dados") de proposito: a grade
	* precisa de cursor READWRITE recarregado por ZAP + APPEND, e
	* reaproveitar o alias compartilhado por 163+ BOs CRUD herda a
	* estrutura deixada por outro form (origem do Erro138).
	*----------------------------------------------------------------
	this_cCursorEmbalagens = "cursor_4c_Embalagens"   && grade do dialogo (LocalEmb do legado)
	this_cCursorCadEmb     = "cursor_4c_CadEmb"       && cadastro SigCdEmb (LocalCdEmb do legado)

	*----------------------------------------------------------------
	* Valores derivados/calculados
	*----------------------------------------------------------------
	this_nPesoTotalEmbalagens = 0   && lnTotP do legado - soma de Qtds * PesoEmbs das linhas com Qtds > 0, devolvida ao pai (parentform.pesoemb)
	this_nLinhasGravadas      = 0   && quantas linhas de SigMvIte foram regravadas na ultima confirmacao

	*----------------------------------------------------------------
	* Lista CANONICA das colunas do cursor da grade
	* Usada por CursorTemEstruturaEsperada() para recusar alias
	* herdado de outra tela: o ZAP apaga as linhas mas PRESERVA as
	* colunas do dono anterior, e o APPEND FROM DBF() seguinte falha
	* por coluna que esta tela nem conhece (origem do Erro138).
	* A ordem eh a MESMA do SELECT de LocalEmb no Init legado.
	*----------------------------------------------------------------
	this_cColunasGrade = "cods,descs,pesoembs,empdopnums,emps,dopes,numes,qtds,pesos,cidchaves,codembs,citens"

	this_lCursorRecriado = .F.   && .T. quando CriarCursorEmbalagens derrubou e recriou o alias - quem chamou fica responsavel por religar o Grid

	*----------------------------------------------------------------
	* Cursores auxiliares - NUNCA ligados a grade
	* SQLEXEC sobre o alias de um Grid FECHA e RECRIA o alias, zerando
	* o ColumnCount: a grade vira um retangulo branco sem cabecalho e
	* sem coluna, e nada a religa depois. Por isso toda consulta cai
	* num cursor temporario e o alias da grade eh recarregado com
	* ZAP + APPEND FROM DBF(), que preserva estrutura e bindings.
	*----------------------------------------------------------------
	this_cCursorLinhasItem = "cursor_4c_LinhasItem"   && linhas de SigMvIte JA gravadas para o item corrente
	this_cCursorTemp       = "cursor_4c_EmbTemp"      && destino dos SQLEXEC e do LEFT JOIN local

	*----------------------------------------------------------------
	* Gravacao em LOTE transacional
	*
	* A confirmacao regrava TODAS as linhas de embalagem do item de uma
	* vez - DELETE das antigas + INSERT das novas - entao os comandos
	* vao num SQLEXEC unico e ATOMICO: meia gravacao deixaria o item
	* com as embalagens antigas apagadas e as novas ausentes.
	*----------------------------------------------------------------
	this_cLoteGravacao  = ""            && comandos acumulados do lote
	this_cNomeSavepoint = "SigOpEmb4c"  && savepoint, para o lote aninhar em transacao ja aberta

	this_nRegistrosInseridos   = 0   && linhas de SigMvIte inseridas na ultima gravacao
	this_nRegistrosAtualizados = 0   && linhas alteradas pelo caminho Salvar() -> Atualizar()
	this_nRegistrosExcluidos   = 0   && linhas removidas na ultima gravacao

	*====================================================================
	* Init - Inicializa Business Object
	*
	* NAO carrega cursor aqui: a carga de SigCdEmb/SigMvIte eh CACHE e
	* roda sob demanda nos metodos de busca. Init que devolve .F. faz
	* CREATEOBJECT virar logico e o Form aborta o proprio Init - a tela
	* nunca abre, nem em validacao de UI (gnConnHandle = -1).
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			DODEFAULT()

			*-- Nomes CORRETOS das propriedades herdadas de BusinessBase
			THIS.this_cTabela     = "SigMvIte"
			THIS.this_cCampoChave = "cidchaves"

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "SigOpEmbBO.Init")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave POSICIONAL de 29 caracteres
	* Emps + Dopes + Str(Numes, 6) usada em SigMvIte.empdopnums.
	*
	* A chave eh POSICIONAL: o padding FAZ PARTE dela. Emps eh char(3)
	* e Dopes eh char(20), entao 3 + 20 + 6 = 29, exatamente a largura
	* de empdopnums char(29) no docs\schema.sql - essa soma eh a
	* conferencia da montagem.
	*
	* ALLTRIM nas partes QUEBRA a busca em SILENCIO: "001" + "MALOTE" +
	* "     3" da 15 caracteres e nunca casa com o valor gravado
	* ("001MALOTE                   3"). O SELECT roda sem erro e
	* devolve ZERO linhas, entao a grade fica sempre vazia.
	*
	* PADR explicito (em vez de confiar no padding que o cursor por
	* acaso traz) porque este metodo tambem eh chamado com as
	* properties this_cEmps/this_cDopes, que o Form guarda JA com
	* ALLTRIM. Publico porque o Form monta a chave a partir do
	* cabecalho da movimentacao do pai.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso
	* em RegistrarAuditoria(). PROTECTED: de fora do BO nunca eh chamado
	* (CLAUDE.md regra #51).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC


	*====================================================================
	* CriarCursorEmbalagens - cria (ou recria) o cursor da GRADE
	*
	* Ponto UNICO de CREATE CURSOR desta tela: a ordem e a grafia das
	* colunas tem de ser IDENTICAS em todo lugar que mencione o cursor,
	* porque o APPEND FROM DBF() casa por NOME. Ter um segundo
	* CREATE CURSOR com a ordem trocada eh o defeito classico dos forms
	* OPERACIONAIS - por isso a estrutura mora aqui e so aqui, e o Form
	* chama este metodo para montar o placeholder da grade.
	*
	* A grade eh EDITAVEL (Column1 = Qtde, Grade.ReadOnly = .F. no SCX),
	* entao o cursor tem de ser READWRITE: cursor de SQL pass-through
	* nasce SOMENTE-LEITURA e o REPLACE da edicao estouraria. Ja por
	* isso o alias da grade nunca recebe SQLEXEC.
	*
	* Larguras conferidas em docs/schema.sql (UTF-16, lido com
	* Get-Content -Raw). Em VFP a largura declarada INCLUI o ponto
	* decimal, entao numeric(P,D) com D > 0 vira N(P+1, D):
	*   SigCdEmb.pesos  numeric(11,2) -> N(12, 2)   (alias pesoembs)
	*   SigMvIte.pesos  numeric(9,3)  -> N(10, 3)
	*   SigMvIte.qtds   numeric(6,0)  -> N(6, 0)
	*   SigMvIte.numes  numeric(6,0)  -> N(6, 0)
	*   SigMvIte.citens numeric(10,0) -> N(10, 0)
	*
	* citens NAO existe no LocalEmb legado: la o valor eh lido de
	* crTpmMvItn.Citens na hora do Insert. Aqui a coluna existe e eh
	* preenchida a partir de this_nCitens, que o Form guarda do
	* contexto - mesmo valor, sem depender de outro cursor estar
	* posicionado no momento da gravacao.
	*
	* par_lForcarRecriar - .T. derruba e recria o alias mesmo existindo.
	*====================================================================
	PROCEDURE CriarCursorEmbalagens(par_lForcarRecriar)
		LOCAL loc_lSucesso, loc_lRecriar, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorEmbalagens)

		THIS.this_lCursorRecriado = .F.
		THIS.this_cMensagemErro   = ""

		TRY
			loc_lRecriar = .T.

			IF USED(loc_cAlias)
				loc_lRecriar = .F.

				IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
					loc_lRecriar = .T.
				ENDIF

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
					cods       C(3),   ;
					descs      C(20),  ;
					pesoembs   N(12, 2), ;
					empdopnums C(29),  ;
					emps       C(3),   ;
					dopes      C(20),  ;
					numes      N(6, 0),  ;
					qtds       N(6, 0),  ;
					pesos      N(10, 3), ;
					cidchaves  C(20),  ;
					codembs    C(3),   ;
					citens     N(10, 0) )

				THIS.this_lCursorRecriado = .T.
			ENDIF

			*-- SET DELETED eh escopado por data session: num form com
			*-- DataSession = 2 o SET DELETED ON do config.prg roda na sessao 1
			*-- e NAO alcanca a sessao privada, que nasce com DELETED OFF.
			SET DELETED ON

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao preparar o cursor das embalagens:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CursorTemEstruturaEsperada - confere se o alias tem as colunas
	* desta tela.
	*
	* PEMSTATUS NAO serve para isto: o primeiro argumento tem de ser
	* OBJETO, e passar nome de cursor dispara "Function argument value,
	* type, or count is invalid.". Campo de cursor se confere com
	* TYPE(alias + ".campo") != "U".
	*====================================================================
	PROTECTED FUNCTION CursorTemEstruturaEsperada(par_cAlias)
		LOCAL loc_lOk, loc_cAlias, loc_cLista, loc_cCampo, loc_nI, loc_nTotal

		loc_lOk    = .T.
		loc_cAlias = ALLTRIM(NVL(par_cAlias, ""))
		loc_cLista = ALLTRIM(THIS.this_cColunasGrade)

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

	*====================================================================
	* ObterChaveMovimentacao - a chave de 29 caracteres da movimentacao
	* que o item corrente pertence.
	*
	* Prefere o valor JA montado em this_cEmpdopnums (que o Form recebe
	* do cabecalho do pai); so monta a partir de empresa/operacao/numero
	* quando ele vem vazio. PADR final de 29 porque a chave eh
	* POSICIONAL e o padding FAZ PARTE dela (regra #42): um ALLTRIM aqui
	* faria o WHERE nunca casar e o SELECT devolveria ZERO linhas em
	* silencio - a grade ficaria permanentemente vazia.
	*====================================================================
	FUNCTION ObterChaveMovimentacao()
		LOCAL loc_cChave

		loc_cChave = TratarNulo(THIS.this_cEmpdopnums, "")

		IF EMPTY(ALLTRIM(loc_cChave))
			loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN PADR(loc_cChave, 29)
	ENDFUNC

	*====================================================================
	* ContextoMovimentacaoCompleto - .T. quando ha empresa, operacao e
	* numero para enderecar a gravacao no servidor.
	*
	* Sem os tres nao existe chave empdopnums valida, e gravar assim
	* criaria linhas de SigMvIte penduradas em chave em branco - lixo
	* silencioso que nenhuma tela encontraria depois.
	*====================================================================
	FUNCTION ContextoMovimentacaoCompleto()
		LOCAL loc_lOk

		loc_lOk = !EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmps, ""))) ;
			AND !EMPTY(ALLTRIM(TratarNulo(THIS.this_cDopes, ""))) ;
			AND TratarNulo(THIS.this_nNumes, 0) <> 0 ;
			AND TratarNulo(THIS.this_nCitens, 0) <> 0

		RETURN loc_lOk
	ENDFUNC

	*====================================================================
	* CarregarCadastroEmbalagens - traz o cadastro de embalagens
	*
	* Transcricao literal da consulta do Init legado:
	*     lcQuery = [Select Descs, Cods, Pesos as PesoEmbs From SigCdemb
	*                Order By Cods]
	*     If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCdEmb]) < 1)
	*         ... aviso "Favor Reinicializar o Processo!!!" com o titulo
	*             "Falha na Conexao (LocalEmb)" e Return .f. ...
	*     EndIf
	*
	* As colunas multis e precos de SigCdEmb NAO entram: o legado nao as
	* traz, e inventa-las mudaria a estrutura do cursor sem necessidade.
	*
	* Este cursor eh de LEITURA (lado esquerdo do LEFT JOIN) e nunca eh
	* ligado a grade, por isso o SQLEXEC direto nele eh seguro.
	*====================================================================
	PROCEDURE CarregarCadastroEmbalagens()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cSQL
		LOCAL loc_nResultado, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorCadEmb)

		THIS.this_cMensagemErro = ""

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
				MsgErro(THIS.this_cMensagemErro, ;
					"Falha na Conex" + CHR(227) + "o (Embalagens)")
				THIS.this_lErroExibido = .T.
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cSQL = "SELECT descs, cods, pesos AS pesoembs" + ;
						   " FROM SigCdEmb" + ;
						   " ORDER BY cods"

				IF USED(loc_cAlias)
					USE IN (loc_cAlias)
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, ;
						"Falha na Conex" + CHR(227) + "o (Embalagens)")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cAlias)
				GO TOP
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar o cadastro de embalagens:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarLinhasDoItem - as linhas de SigMvIte JA existentes para o
	* item corrente (o lado DIREITO do LEFT JOIN).
	*
	* Duas origens, na mesma ordem de preferencia do legado:
	*
	* (1) cursor do form PAI (crSigMvIte). Eh o que o legado usa: o
	*     dialogo le e escreve direto no cursor remoto do pai, que o
	*     SIGMVCAB comita depois com poDataMgr.UpDate. Quando o pai
	*     tem esse cursor aberto, ele eh a VERDADE do momento - inclui
	*     linhas que o usuario mexeu e ainda nao foram gravadas.
	*
	* (2) servidor, por empdopnums + citens. Caminho necessario quando o
	*     dialogo eh aberto sem o cursor do pai em memoria: sem ele a
	*     grade abriria sempre zerada e o usuario perderia as
	*     embalagens que o item ja tem gravadas.
	*
	* O filtro por citens eh aplicado AQUI, de proposito: assim o LEFT
	* JOIN de CarregarEmbalagensDoItem nao precisa repetir a condicao
	* "And b.Citens = crTpmMvItn.Citens" do legado e, principalmente,
	* nao depende de outro cursor estar POSICIONADO na linha certa.
	*
	* Cursor vazio NAO eh falha: item sem embalagem nenhuma eh o caso
	* normal de uma inclusao.
	*====================================================================
	PROCEDURE CarregarLinhasDoItem()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cPai
		LOCAL loc_nCitens, loc_cChave, loc_cSQL, loc_nResultado, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorLinhasItem)
		loc_cPai        = ALLTRIM(THIS.this_cCursorItensMov)
		loc_nCitens     = TratarNulo(THIS.this_nCitens, 0)

		THIS.this_cMensagemErro = ""

		TRY
			IF USED(loc_cAlias)
				USE IN (loc_cAlias)
			ENDIF

			IF USED(loc_cPai)
				*-- ORIGEM (1): cursor do form pai
				SELECT cidchaves, citens, codembs, dopes, empdopnums, ;
					   emps, numes, pesos, qtds ;
					FROM (loc_cPai) ;
					WHERE citens = m.loc_nCitens ;
					INTO CURSOR (loc_cAlias) READWRITE

				loc_lProsseguir = .F.
				loc_lSucesso    = USED(loc_cAlias)
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					*-- Sem conexao (modo de teste / validacao de UI) a grade
					*-- abre com as embalagens e sem quantidade: nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = THIS.CriarCursorLinhasItemVazio()
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF !THIS.ContextoMovimentacaoCompleto()
					*-- Sem chave da movimentacao nao ha o que consultar; a
					*-- grade fica com as embalagens e quantidade zero.
					loc_lProsseguir = .F.
					loc_lSucesso    = THIS.CriarCursorLinhasItemVazio()
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- ORIGEM (2): servidor. empdopnums eh char(29) POSICIONAL -
				*-- a chave vai COM o padding (regra #42); o SQL Server
				*-- compara char com preenchimento de brancos (ANSI), logo o
				*-- indice segue utilizavel.
				loc_cChave = THIS.ObterChaveMovimentacao()

				loc_cSQL = "SELECT cidchaves, citens, codembs, dopes," + ;
						   " empdopnums, emps, numes, pesos, qtds" + ;
						   " FROM SigMvIte" + ;
						   " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
						   " AND citens = " + FormatarNumeroSQL(loc_nCitens, 0) + ;
						   " ORDER BY codembs"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao carregar as embalagens do item:" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
					THIS.this_lErroExibido = .T.
					loc_lSucesso = .F.
				ELSE
					loc_lSucesso = USED(loc_cAlias)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar as embalagens do item:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CriarCursorLinhasItemVazio - cursor do lado DIREITO vazio, com a
	* estrutura de SigMvIte.
	*
	* Existe para que o LEFT JOIN rode igual quando nao ha linha gravada
	* (sem conexao, ou item novo): sem o alias o SELECT estouraria
	* "Alias is not found" e a grade nem apareceria. As larguras seguem
	* a mesma conversao de CriarCursorEmbalagens.
	*====================================================================
	PROTECTED FUNCTION CriarCursorLinhasItemVazio()
		LOCAL loc_cAlias

		loc_cAlias = ALLTRIM(THIS.this_cCursorLinhasItem)

		IF USED(loc_cAlias)
			USE IN (loc_cAlias)
		ENDIF

		CREATE CURSOR (loc_cAlias) ( ;
			cidchaves  C(20),  ;
			citens     N(10, 0), ;
			codembs    C(3),   ;
			dopes      C(20),  ;
			empdopnums C(29),  ;
			emps       C(3),   ;
			numes      N(6, 0),  ;
			pesos      N(10, 3), ;
			qtds       N(6, 0) )

		RETURN USED(loc_cAlias)
	ENDFUNC

	*====================================================================
	* CarregarEmbalagensDoItem - monta a grade do dialogo
	*
	* Transcricao do LEFT JOIN do Init legado:
	*     Select a.Cods, a.Descs, a.PesoEmbs, Nvl(b.EmpDopNums,[]) as EmpDopNums,
	*            Nvl(b.Emps,[]) as Emps, Nvl(b.Dopes,[]) as Dopes,
	*            Nvl(b.Numes,0) as Numes, Nvl(b.Qtds,0) as Qtds,
	*            Nvl(b.Pesos,0) as Pesos, Nvl(b.CidChaves,[]) as CidChaves,
	*            Nvl(b.CodEmbs,[]) as CodEmbs
	*         From LocalCdEmb a Left Join crSigMvIte b
	*           On a.Cods = b.CodEmbs And b.Citens = crTpmMvItn.Citens
	*         Order By a.Cods Into Cursor LocalEmb ReadWrite
	*
	* TODA embalagem cadastrada aparece, com ou sem quantidade - eh um
	* LEFT JOIN de proposito: a tela existe para o usuario digitar a
	* quantidade de cada uma.
	*
	* A condicao "And b.Citens = crTpmMvItn.Citens" nao se repete aqui
	* porque CarregarLinhasDoItem ja filtrou o lado direito pelo item -
	* mesmo resultado, sem depender de o cursor do pai estar posicionado.
	*
	* O resultado vai para um cursor TEMPORARIO e so entao eh
	* transferido para a grade com ZAP + APPEND FROM DBF(): SELECT INTO
	* CURSOR sobre o alias da grade FECHA e RECRIA o alias, zerando o
	* ColumnCount - a grade viraria um retangulo branco sem cabecalho e
	* sem coluna, sem erro e sem log.
	*
	* codembs recebe cods nas linhas sem correspondencia. No legado isso
	* acontece mais tarde (m.CodEmbs = m.Cods, na hora do Insert);
	* antecipar deixa o cursor coerente e nao muda nada na tela, porque
	* a coluna nao eh exibida. A gravacao reaplica a regra de qualquer
	* forma, para nunca gravar codembs em branco (coluna NOT NULL).
	*====================================================================
	PROCEDURE CarregarEmbalagensDoItem()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cCadEmb
		LOCAL loc_cLinhas, loc_cAliasTmp, loc_cSafety, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_cCadEmb     = ALLTRIM(THIS.this_cCursorCadEmb)
		loc_cLinhas     = ALLTRIM(THIS.this_cCursorLinhasItem)
		loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)
		loc_cSafety     = ""

		THIS.this_cMensagemErro = ""

		TRY
			IF !THIS.CriarCursorEmbalagens()
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF !THIS.CarregarCadastroEmbalagens()
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF !THIS.CarregarLinhasDoItem()
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				SELECT a.cods AS cods, ;
					   a.descs AS descs, ;
					   a.pesoembs AS pesoembs, ;
					   NVL(b.empdopnums, "") AS empdopnums, ;
					   NVL(b.emps, "") AS emps, ;
					   NVL(b.dopes, "") AS dopes, ;
					   NVL(b.numes, 0) AS numes, ;
					   NVL(b.qtds, 0) AS qtds, ;
					   NVL(b.pesos, 0) AS pesos, ;
					   NVL(b.cidchaves, "") AS cidchaves, ;
					   NVL(b.codembs, "") AS codembs ;
					FROM (loc_cCadEmb) a ;
					LEFT JOIN (loc_cLinhas) b ON a.cods = b.codembs ;
					ORDER BY a.cods ;
					INTO CURSOR (loc_cAliasTmp) READWRITE

				IF !USED(loc_cAliasTmp)
					THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
						"vel montar a lista de embalagens."
					MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- SET SAFETY tambem eh escopado por data session: com
				*-- DataSession = 2 vale ON mesmo com o SET SAFETY OFF do
				*-- main.prg, e ai o ZAP abre o dialogo "Are you sure?" e
				*-- CONGELA a tela esperando um clique que ninguem ve.
				loc_cSafety = SET("SAFETY")
				SET SAFETY OFF

				SELECT (loc_cAlias)
				ZAP

				IF loc_cSafety = "ON"
					SET SAFETY ON
				ENDIF
				loc_cSafety = ""

				*-- APPEND casa por NOME: citens nao vem do temporario e fica
				*-- no valor em branco, por isso eh preenchido em seguida.
				SELECT (loc_cAlias)
				APPEND FROM DBF(loc_cAliasTmp)

				REPLACE ALL citens WITH TratarNulo(THIS.this_nCitens, 0) ;
					IN (loc_cAlias)

				REPLACE ALL codembs WITH cods FOR EMPTY(codembs) ;
					IN (loc_cAlias)

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				*-- "Select LocalEmb / Go Top" do fim do Init legado: sem o
				*-- GO TOP a grade pode abrir posicionada em EOF e parecer
				*-- vazia mesmo com o cursor cheio (regra #21).
				SELECT (loc_cAlias)
				GO TOP

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao montar a lista de embalagens:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarPesoLinha - grava a quantidade digitada na linha corrente
	* e recalcula o peso dela.
	*
	* Transcricao do Column1.Text1.Valid legado:
	*     Select LocalEmb
	*     Replace Qtds With This.Value,
	*             Pesos with Localemb.Qtds * LocalEmb.PesoEmbs
	*     thisform.grade.Refresh()
	*
	* O legado usa o Qtds JA atualizado para calcular Pesos (as
	* clausulas do REPLACE valem da esquerda para a direita) - por isso
	* aqui sao dois REPLACE em sequencia, o que deixa isso explicito.
	*
	* SEM ROUND: o legado nao arredonda, quem corta eh a largura do
	* campo N(10,3). Acrescentar ROUND mudaria o valor gravado (#17).
	*
	* O Refresh da grade eh da TELA e fica no Form - este metodo so
	* cuida do CURSOR.
	*
	* par_nQtd - quantidade digitada (o .Value do TextBox da coluna).
	*            Vem do CONTROLE, nao do cursor: dentro do Valid o
	*            cursor ainda tem o valor ANTIGO (regra #46).
	*====================================================================
	PROCEDURE AtualizarPesoLinha(par_nQtd)
		LOCAL loc_lSucesso, loc_cAlias, loc_nQtd, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_nQtd     = 0

		IF VARTYPE(par_nQtd) = "N"
			loc_nQtd = par_nQtd
		ELSE
			IF VARTYPE(par_nQtd) = "C"
				loc_nQtd = VAL(ALLTRIM(par_nQtd))
			ENDIF
		ENDIF

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "A lista de embalagens n" + CHR(227) + ;
					"o est" + CHR(225) + " aberta."
			ELSE
				SELECT (loc_cAlias)

				IF EOF()
					*-- Sem linha corrente nao ha o que gravar. Em VFP mexer
					*-- com o ponteiro em EOF nao da erro, entao sem esta
					*-- guarda o metodo relataria SUCESSO sem ter feito nada.
					THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
						" linha corrente na lista de embalagens."
				ELSE
					REPLACE qtds  WITH loc_nQtd
					REPLACE pesos WITH qtds * pesoembs

					THIS.this_nQtds     = qtds
					THIS.this_nPesos    = pesos
					THIS.this_nPesoEmbs = pesoembs
					THIS.this_cCods     = TratarNulo(cods, "")

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao calcular o peso da embalagem:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CalcularPesoTotalEmbalagens - o lnTotP do btnConfirmar legado
	*
	*     lnTotP = 0
	*     Select LocalEmb
	*     Scan
	*         If LocalEmb.Qtds > 0
	*             lnTotP = lnTotP + Localemb.Qtds * Localemb.PesoEmbs
	*             ...
	*         Endif
	*     Endscan
	*
	* Dois detalhes que sao REGRA e nao se "melhoram":
	*   - o criterio eh Qtds > 0, nao Qtds <> 0;
	*   - o total soma Qtds * PesoEmbs, NAO a coluna Pesos. As duas
	*     costumam coincidir, mas divergem quando a linha veio do banco
	*     com um peso gravado antes de o cadastro da embalagem mudar - e
	*     o numero que o legado devolve ao pai eh o RECALCULADO.
	*
	* O SCAN deixa o ponteiro em EOF, por isso o RECNO eh guardado e
	* reposto: sem isso a grade do usuario mudaria de linha sozinha.
	*====================================================================
	FUNCTION CalcularPesoTotalEmbalagens()
		LOCAL loc_nTotal, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro

		loc_nTotal         = 0
		loc_cAlias         = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_cAliasAnterior = ALIAS()
		loc_nRecno         = 0

		TRY
			IF USED(loc_cAlias)
				loc_nRecno = RECNO(loc_cAlias)

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					IF qtds > 0
						loc_nTotal = loc_nTotal + qtds * pesoembs
					ENDIF
				ENDSCAN

				IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cAlias))
					GO loc_nRecno IN (loc_cAlias)
				ENDIF

				IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
					SELECT (loc_cAliasAnterior)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao somar o peso das embalagens:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_nTotal = 0
		ENDTRY

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* SincronizarCursorItensMov - regrava as linhas do item no cursor do
	* form PAI (o crSigMvIte do legado).
	*
	* Transcricao do btnConfirmar.Click legado:
	*     Select CrSigMvIte
	*     Set Order To
	*     Set Order To Citens
	*     Go Top
	*     Delete For cItens = crTpmMvItn.Citens in CrSigMvIte
	*     Select LocalEmb
	*     Scan
	*         If LocalEmb.Qtds > 0
	*             ...
	*             Scatter Memo Memvar
	*             m.Citens  = crTpmMvItn.Citens
	*             m.CodEmbs = m.Cods
	*             Insert into crSigMvIte From Memvar
	*         Endif
	*     Endscan
	*
	* DELETE das antigas + INSERT das que tem quantidade: eh a regravacao
	* INTEIRA do item, nao um merge. Linha com Qtds = 0 simplesmente nao
	* volta - eh assim que o usuario REMOVE uma embalagem.
	*
	* Os SET ORDER do legado existiam para desfazer o "Set Key to
	* crTpmMvItn.CItens" que o Init aplica no cursor do pai (um filtro de
	* FAIXA, que esconderia as linhas dos outros itens do DELETE FOR).
	* Aqui o DELETE FOR varre o cursor inteiro sem depender de indice, e
	* por isso nenhum SET ORDER eh mexido: alterar a ordem de um cursor
	* que NAO eh nosso deixaria o pai posicionado de forma diferente da
	* que ele espera.
	*
	* As cinco colunas de chave (emps, dopes, numes, empdopnums,
	* cidchaves) o legado deixa EM BRANCO aqui - quem as preenche eh o
	* SIGMVCAB na hora de gravar a movimentacao:
	*     Replace all Emps With TprMvCab.Emps, Dopes With TprMvCab.Dopes,
	*         Numes With TprMvCab.Numes,
	*         EmpDopNums With TprMvCab.Emps+TprMvCab.Dopes+Str(TprMvCab.Numes,6),
	*         CidChaves With fUniqueIds() in crSigMvIte
	* Aqui elas ja vao preenchidas a partir do CONTEXTO recebido do pai,
	* que sao os MESMOS valores: se o pai ainda rodar o Replace dele, so
	* reescreve o que ja esta certo; se nao rodar (caso do sistema novo),
	* as colunas NOT NULL nao chegam vazias ao servidor. Com contexto
	* ausente ficam em branco, exatamente como no legado.
	*
	* INSERT INTO TROCA a area de trabalho corrente para o alias de
	* destino - por isso o SELECT de volta dentro do laco: sem ele o
	* ENDSCAN faria SKIP no cursor do PAI e o laco nunca terminaria o
	* trabalho.
	*====================================================================
	PROTECTED FUNCTION SincronizarCursorItensMov()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cPai
		LOCAL loc_cAliasAnterior, loc_nRecnoPai, loc_nCitens
		LOCAL loc_cChave, loc_cEmps, loc_cDopes, loc_nNumes
		LOCAL loc_cCodEmb, loc_nQtd, loc_nPeso, loc_oErro

		loc_lSucesso       = .F.
		loc_lProsseguir    = .T.
		loc_cAlias         = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_cPai           = ALLTRIM(THIS.this_cCursorItensMov)
		loc_cAliasAnterior = ALIAS()
		loc_nRecnoPai      = 0
		loc_nCitens        = TratarNulo(THIS.this_nCitens, 0)

		loc_cEmps  = PADR(TratarNulo(THIS.this_cEmps, ""), 3)
		loc_cDopes = PADR(TratarNulo(THIS.this_cDopes, ""), 20)
		loc_nNumes = TratarNulo(THIS.this_nNumes, 0)
		loc_cChave = ""

		IF !EMPTY(ALLTRIM(loc_cEmps)) OR !EMPTY(ALLTRIM(loc_cDopes)) OR loc_nNumes <> 0
			loc_cChave = THIS.ObterChaveMovimentacao()
		ENDIF

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cPai)
				THIS.this_cMensagemErro = "O cursor de itens da movimenta" + CHR(231) + ;
					CHR(227) + "o [" + loc_cPai + "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF !USED(loc_cAlias)
					THIS.this_cMensagemErro = "A lista de embalagens n" + CHR(227) + ;
						"o est" + CHR(225) + " aberta."
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_nRecnoPai = RECNO(loc_cPai)

				*-- Fora as antigas: a regravacao eh do item INTEIRO.
				DELETE FOR citens = m.loc_nCitens IN (loc_cPai)

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					IF qtds > 0
						loc_cCodEmb = TratarNulo(codembs, "")
						IF EMPTY(ALLTRIM(loc_cCodEmb))
							loc_cCodEmb = TratarNulo(cods, "")
						ENDIF

						loc_nQtd  = TratarNulo(qtds, 0)
						loc_nPeso = TratarNulo(pesos, 0)

						INSERT INTO (loc_cPai) ;
							(cidchaves, citens, codembs, dopes, empdopnums, ;
							 emps, numes, pesos, qtds) ;
							VALUES (LEFT(fUniqueIds(), 20), ;
									loc_nCitens, ;
									PADR(loc_cCodEmb, 3), ;
									loc_cDopes, ;
									PADR(loc_cChave, 29), ;
									loc_cEmps, ;
									loc_nNumes, ;
									loc_nPeso, ;
									loc_nQtd)

						*-- INSERT INTO trocou a area de trabalho: voltar para
						*-- o cursor da grade antes do ENDSCAN.
						SELECT (loc_cAlias)
					ENDIF
				ENDSCAN

				SELECT (loc_cAlias)
				GO TOP

				IF USED(loc_cPai)
					IF BETWEEN(loc_nRecnoPai, 1, RECCOUNT(loc_cPai))
						GO loc_nRecnoPai IN (loc_cPai)
					ENDIF
				ENDIF

				IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
					SELECT (loc_cAliasAnterior)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao atualizar os itens da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* PersistirEmbalagensDoItem - grava no SERVIDOR as embalagens do item
	*
	* Mesma regravacao do item que SincronizarCursorItensMov faz em
	* memoria, agora em SigMvIte: DELETE de todas as linhas do item +
	* INSERT das que tem quantidade. Tudo num SQLEXEC unico e ATOMICO,
	* porque meia gravacao deixaria o item com as embalagens antigas
	* apagadas e as novas ausentes.
	*
	* No legado esta etapa NAO existe no dialogo: ele so mexia no cursor
	* REMOTO do pai (crSigMvIte, ligado por .AddCursor em SIGMVCAB), e o
	* poDataMgr.UpDate do pai propagava INSERT e DELETE ao gravar a
	* movimentacao. No sistema novo nao ha cursor remoto bufferizado,
	* entao a propagacao eh explicita aqui - sem isso o usuario digitaria
	* as quantidades, veria o peso mudar e NADA seria gravado.
	*
	* cidchaves eh gerado por LINHA, nunca um valor para todas: chave
	* repetida colide na PK a partir da segunda linha (regra #22). Eh o
	* mesmo que o "Replace all CidChaves With fUniqueIds()" do legado
	* faz - a chave eh renovada em cada gravacao, o que eh coerente com
	* o DELETE + INSERT do item inteiro.
	*
	* Zero linha com quantidade NAO eh falha: significa "este item nao
	* leva embalagem nenhuma", e o DELETE sozinho eh a gravacao correta.
	*====================================================================
	PROTECTED FUNCTION PersistirEmbalagensDoItem()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasAnterior
		LOCAL loc_nRecno, loc_nCitens, loc_cChave, loc_cComando, loc_oErro

		loc_lSucesso       = .F.
		loc_lProsseguir    = .T.
		loc_cAlias         = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_cAliasAnterior = ALIAS()
		loc_nRecno         = 0
		loc_nCitens        = TratarNulo(THIS.this_nCitens, 0)
		loc_cChave         = THIS.ObterChaveMovimentacao()

		THIS.this_cMensagemErro = ""
		THIS.this_cLoteGravacao = ""

		THIS.this_nRegistrosInseridos = 0
		THIS.this_nRegistrosExcluidos = 0

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "A lista de embalagens n" + CHR(227) + ;
					"o est" + CHR(225) + " aberta."
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF !THIS.ContextoMovimentacaoCompleto()
					THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + ;
						"o ou item n" + CHR(227) + "o informados - n" + CHR(227) + ;
						"o h" + CHR(225) + " como gravar as embalagens."
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- As antigas saem primeiro, dentro do MESMO lote.
				THIS.AcrescentarAoLote(THIS.MontarDeleteDoItem())
				THIS.AcrescentarAoLote(THIS.MontarInsertAuditoriaChave("DELETE", ;
					ALLTRIM(loc_cChave) + "/" + ALLTRIM(TRANSFORM(loc_nCitens))))

				loc_nRecno = RECNO(loc_cAlias)

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					IF qtds > 0
						*-- Chave nova por linha, e colunas de contexto
						*-- gravadas no cursor para o estado exibido ficar
						*-- igual ao que foi para o banco.
						REPLACE cidchaves  WITH LEFT(fUniqueIds(), 20), ;
								citens     WITH loc_nCitens, ;
								empdopnums WITH PADR(loc_cChave, 29), ;
								emps       WITH PADR(TratarNulo(THIS.this_cEmps, ""), 3), ;
								dopes      WITH PADR(TratarNulo(THIS.this_cDopes, ""), 20), ;
								numes      WITH TratarNulo(THIS.this_nNumes, 0)

						IF EMPTY(codembs)
							REPLACE codembs WITH cods
						ENDIF

						IF !THIS.CarregarDoCursor(loc_cAlias)
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						IF !THIS.ValidarDados()
							*-- Linha reprovada para a gravacao INTEIRA: pular
							*-- calado gravaria o resto e perderia esta sem o
							*-- usuario saber.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						loc_cComando = THIS.MontarInsertLinha()

						IF EMPTY(loc_cComando)
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						THIS.AcrescentarAoLote(loc_cComando)
						THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("INSERT"))
						THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
					ENDIF
				ENDSCAN

				IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cAlias))
					GO loc_nRecno IN (loc_cAlias)
				ENDIF

				IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
					SELECT (loc_cAliasAnterior)
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_lSucesso = THIS.ExecutarLoteGravacao()
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o das embalagens do item:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		IF !loc_lSucesso AND !THIS.this_lErroExibido
			IF !EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
				MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
				THIS.this_lErroExibido = .T.
			ENDIF
		ENDIF

		THIS.this_cLoteGravacao = ""

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarEmbalagensDoItem - a confirmacao da tela (btnConfirmar.Click)
	*
	* Ordem do legado, preservada:
	*   1. soma o peso total das embalagens (lnTotP);
	*   2. regrava as linhas do item;
	*   3. devolve o total ao pai (thisform.parentform.pesoemb = lnTotP);
	*   4. fecha a tela (ThisForm.Release()).
	*
	* Os passos 3 e 4 sao da TELA e ficam no Form: aqui o total fica em
	* this_nPesoTotalEmbalagens, que eh o que o Form le para devolver.
	*
	* A regravacao tem DOIS destinos, e os dois sao tentados:
	*   - o cursor de itens do pai, quando ele esta aberto (o unico
	*     destino que o legado conhece);
	*   - o servidor, quando ha chave da movimentacao e conexao.
	*
	* Se NENHUM dos dois estiver disponivel, isto eh falha e eh
	* reportada: relatar sucesso sem ter gravado nada faria o usuario
	* ver o peso mudar na tela do pai e perder tudo depois.
	*====================================================================
	PROCEDURE GravarEmbalagensDoItem()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_lTemPai, loc_lTemServidor
		LOCAL loc_cAlias, loc_oErro

		loc_lSucesso     = .F.
		loc_lProsseguir  = .T.
		loc_lTemPai      = .F.
		loc_lTemServidor = .F.
		loc_cAlias       = ALLTRIM(THIS.this_cCursorEmbalagens)

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.
		THIS.this_nLinhasGravadas = 0

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "A lista de embalagens n" + CHR(227) + ;
					"o est" + CHR(225) + " aberta."
				MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
				THIS.this_lErroExibido = .T.
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Passo 1: o total eh calculado ANTES de qualquer gravacao,
				*-- sobre o que esta na tela - igual ao legado.
				THIS.this_nPesoTotalEmbalagens = THIS.CalcularPesoTotalEmbalagens()
				THIS.this_nLinhasGravadas      = THIS.ContarLinhasComQuantidade()

				loc_lTemPai = USED(ALLTRIM(THIS.this_cCursorItensMov))

				loc_lTemServidor = THIS.ContextoMovimentacaoCompleto() ;
					AND TYPE("gnConnHandle") = "N" ;
					AND gnConnHandle > 0

				IF !loc_lTemPai AND !loc_lTemServidor
					THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
						"Sem o item da movimenta" + CHR(231) + CHR(227) + ;
						"o n" + CHR(227) + "o h" + CHR(225) + " onde gravar as embalagens."
					MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_lSucesso = .T.

				IF loc_lTemPai
					IF !THIS.SincronizarCursorItensMov()
						IF !THIS.this_lErroExibido
							MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
							THIS.this_lErroExibido = .T.
						ENDIF
						loc_lSucesso = .F.
					ENDIF
				ENDIF

				IF loc_lSucesso AND loc_lTemServidor
					IF !THIS.PersistirEmbalagensDoItem()
						loc_lSucesso = .F.
					ENDIF
				ENDIF

				IF !loc_lSucesso
					*-- Gravacao incompleta: o peso devolvido ao pai nao vale,
					*-- porque as linhas nao foram para o lugar.
					THIS.this_nLinhasGravadas = 0
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao confirmar as embalagens:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ContarLinhasComQuantidade - quantas embalagens o item leva
	*
	* Mesmo criterio do total e da gravacao (Qtds > 0), para os tres
	* numeros nunca divergirem. Zero eh resultado legitimo: item sem
	* embalagem nenhuma.
	*
	* COUNT nao tem clausula IN em VFP9 ("Command contains unrecognized
	* phrase/keyword"), por isso o SELECT antes - e o RECNO eh reposto
	* porque COUNT varre o cursor e deixa o ponteiro em EOF.
	*====================================================================
	FUNCTION ContarLinhasComQuantidade()
		LOCAL loc_nTotal, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro

		loc_nTotal         = 0
		loc_cAlias         = ALLTRIM(THIS.this_cCursorEmbalagens)
		loc_cAliasAnterior = ALIAS()
		loc_nRecno         = 0

		TRY
			IF USED(loc_cAlias)
				loc_nRecno = RECNO(loc_cAlias)

				SELECT (loc_cAlias)
				COUNT FOR qtds > 0 TO loc_nTotal

				IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cAlias))
					GO loc_nRecno IN (loc_cAlias)
				ENDIF

				IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
					SELECT (loc_cAliasAnterior)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao contar as embalagens do item:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_nTotal = 0
		ENDTRY

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - carrega as propriedades a partir da linha
	* corrente de um cursor.
	*
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos -
	* a sintaxe campo NAO existe em VFP.
	*
	* Mapeia TODAS as colunas: as 9 de SigMvIte (cidchaves, citens,
	* codembs, dopes, empdopnums, emps, numes, pesos, qtds) e as 3 que a
	* consulta do legado traz de SigCdEmb (cods, descs, pesoembs). As
	* colunas de SigCdEmb nao existem num cursor que venha so de
	* SigMvIte, e vice-versa: por isso cada campo eh conferido com
	* TYPE(alias + ".campo") antes de ser lido. PEMSTATUS NAO serve
	* aqui - o primeiro argumento tem de ser OBJETO e passar nome de
	* cursor dispara "Function argument value, type, or count is
	* invalid.".
	*
	* GUARDA DE EOF obrigatoria: em VFP ler campo com o ponteiro em EOF
	* NAO da erro, devolve o valor EM BRANCO do tipo. Sem ela este
	* metodo zeraria as properties e AINDA devolveria .T., ou seja
	* relataria sucesso sem haver linha - e a gravacao seguinte tentaria
	* persistir uma linha sem chave e sem embalagem.
	*
	* par_cAliasCursor - alias a ler. Omitido, usa o cursor da grade.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorEmbalagens)

		IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
			loc_cAlias = ALLTRIM(par_cAliasCursor)
		ENDIF

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ELSE
				SELECT (loc_cAlias)

				IF EOF()
					*-- Sem linha corrente nao ha o que carregar. As properties
					*-- ficam COMO ESTAVAM de proposito: zera-las aqui
					*-- destruiria a linha que o chamador ja tinha em maos.
					THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
						" linha corrente para carregar."
				ELSE
					*-- Colunas de SigMvIte
					IF TYPE(loc_cAlias + ".cidchaves") != "U"
						THIS.this_cCidchaves = TratarNulo(cidchaves, "")
					ENDIF

					IF TYPE(loc_cAlias + ".citens") != "U"
						THIS.this_nCitens = TratarNulo(citens, 0)
					ENDIF

					IF TYPE(loc_cAlias + ".codembs") != "U"
						THIS.this_cCodembs = TratarNulo(codembs, "")
					ENDIF

					IF TYPE(loc_cAlias + ".dopes") != "U"
						THIS.this_cDopes = TratarNulo(dopes, "")
					ENDIF

					IF TYPE(loc_cAlias + ".empdopnums") != "U"
						THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
					ENDIF

					IF TYPE(loc_cAlias + ".emps") != "U"
						THIS.this_cEmps = TratarNulo(emps, "")
					ENDIF

					IF TYPE(loc_cAlias + ".numes") != "U"
						THIS.this_nNumes = TratarNulo(numes, 0)
					ENDIF

					IF TYPE(loc_cAlias + ".pesos") != "U"
						THIS.this_nPesos = TratarNulo(pesos, 0)
					ENDIF

					IF TYPE(loc_cAlias + ".qtds") != "U"
						THIS.this_nQtds = TratarNulo(qtds, 0)
					ENDIF

					*-- Colunas de SigCdEmb que a consulta do legado traz.
					*-- pesoembs eh o peso UNITARIO da embalagem e tem
					*-- property propria: nao confundir com pesos, que eh o
					*-- peso da LINHA (qtds * pesoembs).
					IF TYPE(loc_cAlias + ".cods") != "U"
						THIS.this_cCods = TratarNulo(cods, "")
					ENDIF

					IF TYPE(loc_cAlias + ".descs") != "U"
						THIS.this_cDescs = TratarNulo(descs, "")
					ENDIF

					IF TYPE(loc_cAlias + ".pesoembs") != "U"
						THIS.this_nPesoEmbs = TratarNulo(pesoembs, 0)
					ENDIF

					*-- codembs em branco (linha que ainda nao existe em
					*-- SigMvIte) assume o codigo do cadastro, como o
					*-- "m.CodEmbs = m.Cods" do legado.
					IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")))
						THIS.this_cCodembs = TratarNulo(THIS.this_cCods, "")
					ENDIF

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, ;
				"SigOpEmbBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - carrega UMA linha de SigMvIte pela PK
	*
	* SELECT * de proposito: o cursor traz a grafia REAL das colunas e o
	* CarregarDoCursor acima resolve o resto. Serve ao contrato
	* Alterar/Visualizar da BusinessBase e ao caminho Salvar() ->
	* Atualizar(), que precisa das colunas que a tela nao exibe.
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cChave, loc_cAliasTmp
		LOCAL loc_cSQL, loc_nResultado, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cChave      = ALLTRIM(NVL(par_cCidchaves, ""))
		loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)

		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(loc_cChave)
				THIS.this_cMensagemErro = "Chave da embalagem do item n" + CHR(227) + ;
					"o informada."
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				loc_cSQL = "SELECT * FROM SigMvIte" + ;
						   " WHERE cidchaves = " + EscaparSQL(loc_cChave)

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao carregar a embalagem do item:" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				SELECT (loc_cAliasTmp)
				GO TOP

				IF EOF()
					THIS.this_cMensagemErro = "Embalagem do item n" + CHR(227) + ;
						"o encontrada."
				ELSE
					loc_lSucesso = THIS.CarregarDoCursor(loc_cAliasTmp)
				ENDIF

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar a embalagem do item:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - criterio de aceitacao de UMA linha de SigMvIte
	*
	* O legado NAO tem validacao de tela nesta janela: a unica regra que
	* ele aplica eh o "If LocalEmb.Qtds > 0" do btnConfirmar, que decide
	* se a linha vai ou nao para crSigMvIte. Essa eh a primeira condicao
	* abaixo.
	*
	* As demais sao as colunas NOT NULL que precisam de valor para o
	* INSERT nao ser recusado pelo servidor (regra #22) - nao sao
	* invencao de regra de negocio: sao a estrutura da tabela. Em
	* especial NAO se exige pesos > 0 (embalagem de peso zero eh
	* legitima) nem faixa de quantidade.
	*====================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido

		loc_lValido = .F.
		THIS.this_cMensagemErro = ""

		DO CASE
		CASE TratarNulo(THIS.this_nQtds, 0) <= 0
			THIS.this_cMensagemErro = "Quantidade da embalagem n" + CHR(227) + "o informada."

		CASE EMPTY(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")))
			THIS.this_cMensagemErro = "Embalagem n" + CHR(227) + "o informada."

		CASE TratarNulo(THIS.this_nCitens, 0) = 0
			THIS.this_cMensagemErro = "Item da movimenta" + CHR(231) + CHR(227) + ;
				"o n" + CHR(227) + "o informado."

		CASE EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmps, ""))) ;
				OR EMPTY(ALLTRIM(TratarNulo(THIS.this_cDopes, ""))) ;
				OR TratarNulo(THIS.this_nNumes, 0) = 0
			THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + ;
				"o n" + CHR(227) + "o informada (empresa, opera" + CHR(231) + CHR(227) + ;
				"o e n" + CHR(250) + "mero)."

		CASE EMPTY(ALLTRIM(TratarNulo(THIS.this_cCidchaves, "")))
			THIS.this_cMensagemErro = "Chave da embalagem do item n" + CHR(227) + ;
				"o gerada."

		OTHERWISE
			loc_lValido = .T.
		ENDCASE

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* MontarInsertLinha - INSERT de UMA linha de SigMvIte
	*
	* As NOVE colunas da tabela sao NOT NULL e nenhuma tem DEFAULT
	* (conferido em docs/schema.sql, UTF-16, lido com Get-Content -Raw):
	* cidchaves, citens, codembs, dopes, empdopnums, emps, numes, pesos,
	* qtds. TODAS entram - omitir uma faria o servidor recusar o INSERT
	* inteiro com "nao eh possivel inserir o valor NULL na coluna ...".
	*
	* Larguras e decimais vem do SCHEMA, nunca do tamanho do controle na
	* tela: char(20) cidchaves/dopes, char(3) codembs/emps, char(29)
	* empdopnums, numeric(10,0) citens, numeric(6,0) numes/qtds,
	* numeric(9,3) pesos.
	*
	* empdopnums eh chave POSICIONAL e vai COM o padding de 29 (regra
	* #42): montada com ALLTRIM nas partes ela nunca casaria com o valor
	* gravado pelas outras telas e as consultas devolveriam ZERO linhas
	* em silencio.
	*====================================================================
	PROTECTED FUNCTION MontarInsertLinha()
		LOCAL loc_cChave, loc_cCodEmb, loc_cChaveMov

		loc_cChave    = LEFT(ALLTRIM(TratarNulo(THIS.this_cCidchaves, "")), 20)
		loc_cCodEmb   = LEFT(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")), 3)
		loc_cChaveMov = PADR(THIS.ObterChaveMovimentacao(), 29)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cCodEmb)
			THIS.this_cMensagemErro = "Embalagem do item sem chave ou sem c" + CHR(243) + ;
				"digo - inclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "INSERT INTO SigMvIte" + ;
			" (cidchaves, citens, codembs, dopes, empdopnums," + ;
			" emps, numes, pesos, qtds)" + ;
			" VALUES (" + EscaparSQL(loc_cChave) + ", " + ;
			FormatarNumeroSQL(TratarNulo(THIS.this_nCitens, 0), 0) + ", " + ;
			EscaparSQL(loc_cCodEmb) + ", " + ;
			EscaparSQL(LEFT(ALLTRIM(TratarNulo(THIS.this_cDopes, "")), 20)) + ", " + ;
			EscaparSQL(loc_cChaveMov) + ", " + ;
			EscaparSQL(LEFT(ALLTRIM(TratarNulo(THIS.this_cEmps, "")), 3)) + ", " + ;
			FormatarNumeroSQL(TratarNulo(THIS.this_nNumes, 0), 0) + ", " + ;
			FormatarNumeroSQL(TratarNulo(THIS.this_nPesos, 0), 3) + ", " + ;
			FormatarNumeroSQL(TratarNulo(THIS.this_nQtds, 0), 0) + ")"
	ENDFUNC

	*====================================================================
	* MontarUpdateLinha - UPDATE de UMA linha de SigMvIte, pela PK
	*
	* A PK de SigMvIte eh somente cidchaves (constraint pk_sigmvite),
	* entao TODAS as outras oito colunas sao dados e entram no SET -
	* inclusive as de chave da movimentacao, que o legado reescreve a
	* cada gravacao do pai.
	*====================================================================
	PROTECTED FUNCTION MontarUpdateLinha()
		LOCAL loc_cChave, loc_cCodEmb, loc_cChaveMov

		loc_cChave    = LEFT(ALLTRIM(TratarNulo(THIS.this_cCidchaves, "")), 20)
		loc_cCodEmb   = LEFT(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")), 3)
		loc_cChaveMov = PADR(THIS.ObterChaveMovimentacao(), 29)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cCodEmb)
			THIS.this_cMensagemErro = "Embalagem do item sem chave ou sem c" + CHR(243) + ;
				"digo - altera" + CHR(231) + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "UPDATE SigMvIte SET" + ;
			" citens = " + FormatarNumeroSQL(TratarNulo(THIS.this_nCitens, 0), 0) + "," + ;
			" codembs = " + EscaparSQL(loc_cCodEmb) + "," + ;
			" dopes = " + EscaparSQL(LEFT(ALLTRIM(TratarNulo(THIS.this_cDopes, "")), 20)) + "," + ;
			" empdopnums = " + EscaparSQL(loc_cChaveMov) + "," + ;
			" emps = " + EscaparSQL(LEFT(ALLTRIM(TratarNulo(THIS.this_cEmps, "")), 3)) + "," + ;
			" numes = " + FormatarNumeroSQL(TratarNulo(THIS.this_nNumes, 0), 0) + "," + ;
			" pesos = " + FormatarNumeroSQL(TratarNulo(THIS.this_nPesos, 0), 3) + "," + ;
			" qtds = " + FormatarNumeroSQL(TratarNulo(THIS.this_nQtds, 0), 0) + ;
			" WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*====================================================================
	* MontarDeleteLinha - DELETE de UMA linha de SigMvIte, pela PK
	*====================================================================
	PROTECTED FUNCTION MontarDeleteLinha()
		LOCAL loc_cChave

		loc_cChave = LEFT(ALLTRIM(TratarNulo(THIS.this_cCidchaves, "")), 20)

		IF EMPTY(loc_cChave)
			THIS.this_cMensagemErro = "Embalagem do item sem chave - exclus" + CHR(227) + ;
				"o cancelada."
			RETURN ""
		ENDIF

		RETURN "DELETE FROM SigMvIte WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*====================================================================
	* MontarDeleteDoItem - DELETE de TODAS as linhas do item
	*
	* Equivale ao "Delete For cItens = crTpmMvItn.Citens in CrSigMvIte"
	* do btnConfirmar legado, agora no servidor. O escopo eh a
	* movimentacao (empdopnums) MAIS o item (citens): citens sozinho se
	* repete entre movimentacoes diferentes e apagaria embalagens de
	* outros documentos.
	*====================================================================
	PROTECTED FUNCTION MontarDeleteDoItem()
		LOCAL loc_cChaveMov, loc_nCitens

		loc_cChaveMov = PADR(THIS.ObterChaveMovimentacao(), 29)
		loc_nCitens   = TratarNulo(THIS.this_nCitens, 0)

		IF EMPTY(ALLTRIM(loc_cChaveMov)) OR loc_nCitens = 0
			THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + ;
				"o ou item n" + CHR(227) + "o informados - exclus" + CHR(227) + ;
				"o cancelada."
			RETURN ""
		ENDIF

		RETURN "DELETE FROM SigMvIte" + ;
			" WHERE empdopnums = " + EscaparSQL(loc_cChaveMov) + ;
			" AND citens = " + FormatarNumeroSQL(loc_nCitens, 0)
	ENDFUNC

	*====================================================================
	* MontarInsertAuditoria - auditoria da linha corrente, para entrar no
	* MESMO lote da gravacao.
	*====================================================================
	PROTECTED FUNCTION MontarInsertAuditoria(par_cOperacao)
		RETURN THIS.MontarInsertAuditoriaChave(par_cOperacao, THIS.ObterChavePrimaria())
	ENDFUNC

	*====================================================================
	* MontarInsertAuditoriaChave - auditoria com a chave informada
	*
	* Existe porque o DELETE do item inteiro nao tem UMA chave primaria:
	* o registrado ali eh o par movimentacao/item, que eh o escopo real
	* da operacao.
	*
	* Vai junto com a operacao no lote transacional, e nao por SQLEXEC a
	* parte: assim o log nunca registra uma gravacao que foi desfeita.
	*
	* DataHora recebe GETDATE() literal, funcao do servidor - NUNCA
	* GETDATE(), que devolveria "NULL" e quebraria o
	* INSERT na coluna NOT NULL.
	*
	* Larguras de LogAuditoria no schema: Tabela varchar(100), Operacao
	* varchar(10), ChaveRegistro varchar(100), Usuario varchar(50).
	*====================================================================
	PROTECTED FUNCTION MontarInsertAuditoriaChave(par_cOperacao, par_cChave)
		LOCAL loc_cOperacao, loc_cChave, loc_cUsuario

		loc_cOperacao = UPPER(ALLTRIM(NVL(par_cOperacao, "")))
		loc_cChave    = ALLTRIM(NVL(par_cChave, ""))
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

	*====================================================================
	* AcrescentarAoLote - enfileira um comando no lote transacional
	*====================================================================
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

	*====================================================================
	* ExecutarLoteGravacao - manda o lote num SQLEXEC unico e ATOMICO
	*
	* BEGIN/COMMIT enviados em SQLEXEC separados NAO protegem nada: cada
	* chamada eh independente e um erro no meio deixaria o DELETE feito
	* e os INSERT ausentes. Por isso tudo vai num unico comando, com
	* BEGIN TRY / BEGIN CATCH no servidor.
	*
	* O savepoint cobre o caso de a conexao JA estar numa transacao
	* aberta por quem chamou: ali o ROLLBACK total desfaria trabalho de
	* terceiros.
	*====================================================================
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
			MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
			RETURN .F.
		ENDIF

		loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

		*-- Com a conexao em auto-commit o par fica inerte. IF ANINHADO mais
		*-- abaixo de proposito - VFP9 nao faz curto-circuito em AND e
		*-- chamaria o SQLCOMMIT de qualquer jeito.
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
			THIS.this_cMensagemErro = "Erro na grava" + CHR(231) + CHR(227) + ;
				"o das embalagens do item." + CHR(13) + CapturarErroSQL()
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
			MsgErro(THIS.this_cMensagemErro, "Quantidade de Embalagens")
			THIS.this_lErroExibido = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*====================================================================
	* Inserir - grava UMA linha de SigMvIte (contrato Salvar() da
	* BusinessBase).
	*
	* O caminho normal desta tela eh a regravacao em LOTE da confirmacao
	* (GravarEmbalagensDoItem); este metodo cumpre o contrato
	* Salvar() -> Inserir() e usa o MESMO montador de SQL, para que a
	* lista de colunas nao possa divergir entre os dois caminhos.
	*
	* cidchaves eh a PK Fortyus (fUniqueIds) e NUNCA fica em branco: com
	* string vazia a segunda linha colidiria na chave primaria.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")))
				THIS.this_cCodembs = LEFT(ALLTRIM(TratarNulo(THIS.this_cCods, "")), 3)
			ENDIF

			IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmpdopnums, "")))
				THIS.this_cEmpdopnums = THIS.ObterChaveMovimentacao()
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
					THIS.this_cMensagemErro = "Erro ao inserir a embalagem do item:" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpEmbBO.Inserir")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - grava a alteracao de UMA linha de SigMvIte
	* WHERE por cidchaves, a PK real da linha.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cCodembs, "")))
				THIS.this_cCodembs = LEFT(ALLTRIM(TratarNulo(THIS.this_cCods, "")), 3)
			ENDIF

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
					THIS.this_cMensagemErro = "Erro ao atualizar a embalagem do item:" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpEmbBO.Atualizar")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - apaga UMA linha de SigMvIte, pela PK
	*
	* PROTECTED de proposito (regra #51): de fora sempre Excluir() da
	* BusinessBase, que valida o estado, roda os hooks e garante que a
	* falha nunca eh muda.
	*
	* No fluxo da TELA quem remove embalagem eh a confirmacao, zerando a
	* quantidade - e a remocao no servidor acontece pelo DELETE do item
	* inteiro. Os dois caminhos usam montadores desta mesma classe.
	*====================================================================
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
					THIS.this_cMensagemErro = "Erro ao excluir a embalagem do item:" + ;
						CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpEmbBO.ExecutarExclusao")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* LimparDados - devolve as propriedades de LINHA ao estado inicial
	*
	* As properties de CONTEXTO (emps, dopes, numes, empdopnums, citens e
	* os nomes dos cursores) NAO sao zeradas: toda linha desta tela
	* pertence ao item da movimentacao que o pai esta editando, e perder
	* esse contexto faria a gravacao seguinte nao saber onde escrever.
	*====================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cCidchaves = ""
		THIS.this_cCodembs   = ""
		THIS.this_nPesos     = 0
		THIS.this_nQtds      = 0

		THIS.this_cCods     = ""
		THIS.this_cDescs    = ""
		THIS.this_nPesoEmbs = 0

		THIS.this_cLoteGravacao = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - fecha os cursores desta tela
	*
	* USE IN fecha o alias mesmo com buffer sujo, e por isso NAO ha
	* TABLEREVERT aqui: TABLEREVERT exige buffering e, sobre cursor
	* criado por CREATE CURSOR (que nasce com Buffering = 1), dispara o
	* erro 1586 "Function requires row or table buffering mode." (regra
	* #52).
	*
	* O cursor de itens do PAI (crSigMvIte) NAO eh fechado aqui: ele nao
	* eh nosso, o pai continua usando depois que este dialogo fecha.
	*====================================================================
	PROCEDURE Destroy()
		IF USED(ALLTRIM(THIS.this_cCursorTemp))
			USE IN (ALLTRIM(THIS.this_cCursorTemp))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorLinhasItem))
			USE IN (ALLTRIM(THIS.this_cCursorLinhasItem))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorCadEmb))
			USE IN (ALLTRIM(THIS.this_cCursorCadEmb))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorEmbalagens))
			USE IN (ALLTRIM(THIS.this_cCursorEmbalagens))
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigOpIns.descrs"
  ControlSource = "crSigOpIns.cods"
  ControlSource = "crSigOpIns.Tipos"
  ControlSource = "crSigOpIns.mensas"
SELECT csSigOpIns
	SELECT crSigOpIns
		SELECT csSigOpIns
		SELECT crSigOpIns
		.Column1.ControlSource = "csSigOpIns.Cods"
		.Column2.ControlSource = "csSigOpIns.Descrs"
		.Column3.ControlSource = "csSigOpIns.Tipo"
SELECT crSigOpIns
	SELECT csSigOpIns
		SELECT crSigOpIns
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpIns'),1,-1)
	SELECT csSigOpIns
	DELETE

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg) - TRECHOS RELEVANTES PARA PASS SQL (1268 linhas total):

*-- Linhas 336 a 365:
336:         *-- Grid da Lista (Grade no legado: Top=96,Left=32,Width=736,Height=490;
337:         *-- com compensacao PageFrame.Top=-29: 96+29=125. Width/Left seguem o
338:         *-- canonico do Framework para nao sobrepor cnt_4c_Saida (Left=917).
339:         *-- ControlSource/Header sao (re)definidos em CarregarLista(), apos o
340:         *-- RecordSource - regra "Grade perde cabecalhos apos RecordSource".
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.RecordSource = ""
343:         loc_oPagina.grd_4c_Lista.ColumnCount  = 3
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 125
346:             .Left               = 26
347:             .Width              = 880
348:             .Height             = 490
349:             .ReadOnly           = .T.
350:             .DeleteMark         = .F.
351:             .RecordMark         = .F.
352:             .FontName           = "Verdana"
353:             .FontSize           = 8
354:             .ForeColor          = RGB(90, 90, 90)
355:             .BackColor          = RGB(255, 255, 255)
356:             .GridLineColor      = RGB(238, 238, 238)
357:             .GridLines          = 3
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .Visible            = .T.
364:         ENDWITH
365: 

*-- Linhas 536 a 557:
536:             .Visible   = .T.
537:         ENDWITH
538: 
539:         *-- optTipo (legado): ButtonCount=3, Value=1 (default), ControlSource
540:         *-- crSigOpIns.Tipos (1=Cheque, 2=Titulo, 3=Follow Up). O migrado nao
541:         *-- vincula a um cursor vivo - FormParaBO/BOParaForm leem/escrevem
542:         *-- THIS.this_oBusinessObject.this_nTipos (regra ControlSource numerico).
543:         loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
544:         WITH loc_oPagina.obj_4c_OptTipo
545:             .ButtonCount = 3
546:             .BackStyle   = 0
547:             .BorderStyle = 0
548:             .Value       = 1
549:             .Top         = 343
550:             .Left        = 156
551:             .Width       = 292
552:             .Height      = 27
553:             .Visible     = .T.
554: 
555:             WITH .Buttons(1)
556:                 .Caption   = "Cheque"
557:                 .FontName  = "Tahoma"

*-- Linhas 683 a 707:
683:         ENDIF
684: 
685:         TRY
686:             loc_cSQL = "SELECT cidchaves FROM SigOpIns WHERE cods = " + EscaparSQL(loc_cCodigo)
687: 
688:             IF USED("cursor_4c_ChkCodigo")
689:                 USE IN cursor_4c_ChkCodigo
690:             ENDIF
691: 
692:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCodigo")
693: 
694:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCodigo") > 0
695:                 MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
696:                 loc_oPagina.txt_4c_Codigo.Value = ""
697:             ENDIF
698: 
699:             IF USED("cursor_4c_ChkCodigo")
700:                 USE IN cursor_4c_ChkCodigo
701:             ENDIF
702:         CATCH TO loException
703:             MsgErro(loException.Message, "FormSIGPRINT.ValidarCodigoDuplicado")
704:         ENDTRY
705:     ENDPROC
706: 
707:     *===========================================================================

*-- Linhas 735 a 764:
735:     *===========================================================================
736:     * ObterChaveSelecionada - Devolve o cidchaves da linha selecionada na grade
737:     * da Lista (string vazia se nao houver linha). O legado abre o Grupo_op.Click
738:     * com "SELECT crSigOpIns / LOCATE FOR Cods = csSigOpIns.Cods" para sincronizar
739:     * o cursor remoto com a grade; aqui a grade esta ligada direto a
740:     * cursor_4c_Dados, que ja traz cidchaves - a PK REAL de SigOpIns (cods tem
741:     * indice NAO-unico, por isso o BO chaveia por cidchaves).
742:     *===========================================================================
743:     PROTECTED PROCEDURE ObterChaveSelecionada()
744:         LOCAL loc_cChave
745:         loc_cChave = ""
746: 
747:         IF USED("cursor_4c_Dados")
748:             IF RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
749:                 SELECT cursor_4c_Dados
750:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
751:             ENDIF
752:         ENDIF
753: 
754:         RETURN loc_cChave
755:     ENDPROC
756: 
757:     *===========================================================================
758:     * FocarControle - SetFocus protegido (transcricao dos SetFocus do
759:     * Grupo_op.Click legado). SetFocus em controle oculto/desabilitado ou em
760:     * form que ainda nao foi exibido dispara erro de runtime - por isso as
761:     * guardas. VFP9 NAO faz short-circuit: o teste do objeto fica no IF externo.
762:     *===========================================================================
763:     PROTECTED PROCEDURE FocarControle(par_oControle)
764:         IF VARTYPE(par_oControle) = "O" AND THIS.Visible

*-- Linhas 846 a 877:
846:     *===========================================================================
847:     * BtnExcluirClick - Exclui a instrucao selecionada, com confirmacao
848:     * No legado o EXCLUIR abre a ficha somente-leitura e eh o Salva.Click que
849:     * executa o DELETE; aqui vale o padrao canonico do sistema novo (confirmacao
850:     * + exclusao no proprio botao), usado em 144 dos 199 forms CRUD migrados.
851:     * O BusinessBase ja reporta a falha de gravacao (regra #20) - sem ELSE.
852:     * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
853:     *===========================================================================
854:     PROCEDURE BtnExcluirClick()
855:         LOCAL loc_cChave, loc_cCodigo
856:         loc_cChave  = THIS.ObterChaveSelecionada()
857:         loc_cCodigo = ""
858: 
859:         IF EMPTY(loc_cChave)
860:             MsgAviso("Selecione um registro para excluir.", "Aviso")
861:         ELSE
862:             SELECT cursor_4c_Dados
863:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
864: 
865:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da instru" + CHR(231) + ;
866:                     CHR(227) + "o [" + loc_cCodigo + "]?", ;
867:                     "Confirmar Exclus" + CHR(227) + "o")
868:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
869:                     IF THIS.this_oBusinessObject.Excluir()
870:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
871:                         THIS.CarregarLista()
872:                     ENDIF
873:                 ENDIF
874:             ENDIF
875:         ENDIF
876:     ENDPROC
877: 

*-- Linhas 899 a 931:
899: 
900:     *===========================================================================
901:     * PosicionarListaPorCodigo - Transcricao do msv_procurar legado:
902:     *     SELECT csSigOpIns / SET NEAR ON / SEEK getCods.Value / SET NEAR OFF
903:     * cursor_4c_Dados vem do SQLEXEC com ORDER BY cods (sem indice), entao o
904:     * equivalente do SEEK com NEAR ON eh parar na PRIMEIRA linha cujo cods seja
905:     * >= o procurado; se todas forem menores, fica na ultima (o NEAR ON do
906:     * legado tambem nao volta para o topo). Comparacao com PADR porque o
907:     * config.prg liga SET EXACT ON.
908:     *===========================================================================
909:     PROTECTED PROCEDURE PosicionarListaPorCodigo(par_cCodigo)
910:         LOCAL loc_cProcura, loc_oGrid
911: 
912:         IF USED("cursor_4c_Dados")
913:             IF RECCOUNT("cursor_4c_Dados") > 0
914:                 loc_cProcura = PADR(ALLTRIM(par_cCodigo), 10)
915: 
916:                 SELECT cursor_4c_Dados
917:                 GO TOP
918:                 LOCATE FOR PADR(ALLTRIM(cursor_4c_Dados.cods), 10) >= loc_cProcura
919: 
920:                 IF !FOUND()
921:                     GO BOTTOM IN cursor_4c_Dados
922:                 ENDIF
923: 
924:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
925:                 loc_oGrid.Refresh()
926:             ENDIF
927:         ENDIF
928:     ENDPROC
929: 
930:     *===========================================================================
931:     * BtnSalvarClick - Confirmar da ficha (Grupo_Salva.Salva.Click do legado)

*-- Linhas 1037 a 1066:
1037:                 IF USED("cursor_4c_Dados")
1038:                     USE IN cursor_4c_Dados
1039:                 ENDIF
1040:                 CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(10), descrs C(76), tipos N(1,0))
1041:                 INSERT INTO cursor_4c_Dados VALUES ("TESTE00000000000001", "0000000001", "Instru" + CHR(231) + CHR(227) + "o Teste", 1)
1042:                 SET DATASESSION TO (loc_nDsAtual)
1043:                 loc_lResultado = .T.
1044:             ELSE
1045:                 IF THIS.this_oBusinessObject.Buscar("")
1046:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1047: 
1048:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1049:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1050:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1051:                     loc_oGrid.Column3.ControlSource = "IIF(cursor_4c_Dados.tipos=1,'CHEQUE',IIF(cursor_4c_Dados.tipos=2,'TITULOS','FOLLOW UP'))"
1052: 
1053:                     loc_oGrid.Column1.Width    = 90
1054:                     loc_oGrid.Column2.Width    = 560
1055:                     loc_oGrid.Column3.Width    = 220
1056: 
1057:                     loc_oGrid.Column1.ReadOnly = .T.
1058:                     loc_oGrid.Column2.ReadOnly = .T.
1059:                     loc_oGrid.Column3.ReadOnly = .T.
1060: 
1061:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1062:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1063:                     loc_oGrid.Column3.Header1.Caption = "Tipo"
1064: 
1065:                     THIS.FormatarGridLista(loc_oGrid)
1066: 


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*====================================================================
* SIGPRINTBO.prg
*
* Business Object para SIGPRINT (Cadastro de Instrucoes)
* Tabela principal: SigOpIns (cidchaves PK, cods codigo de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

	*-- Propriedades da entidade (SigOpIns)
	this_cCidChaves = ""   && cidchaves char(20) - PK (ID unico gerado por fUniqueIds)
	this_cCods      = ""   && cods char(10)      - codigo da instrucao (indice nao-unico)
	this_cDescrs    = ""   && descrs char(76)    - descricao da instrucao
	this_cMensas    = ""   && mensas text        - mensagem impressa na solicitacao
	this_nTipos     = 0    && tipos numeric(1,0) - tipo (1=Cheque, 2=Titulo, 3=Follow Up)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = "SigOpIns"
		THIS.this_cCampoChave = "cidchaves"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescrs    = TratarNulo(descrs,    "C")
				THIS.this_cMensas    = TratarNulo(mensas,    "C")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigOpIns
	* cidchaves eh a PK tecnica (Fortyus), gerada via fUniqueIds()
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)
				VALUES (
					<<EscaparSQL(THIS.this_cCods)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<EscaparSQL(THIS.this_cMensas)>>,
					<<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					<<EscaparSQL(THIS.this_cCidChaves)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRINTBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigOpIns
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigOpIns
				SET cods   = <<EscaparSQL(THIS.this_cCods)>>,
					descrs = <<EscaparSQL(THIS.this_cDescrs)>>,
					mensas = <<EscaparSQL(THIS.this_cMensas)>>,
					tipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRINTBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro pela chave primaria (cidchaves)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigOpIns WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRINTBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cidchaves, cods, descrs, tipos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(10), descrs C(76), tipos N(1,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descrs, tipos FROM SigOpIns"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY cods"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SIGPRINTBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	* par_cCodigo recebe cidchaves (cods NAO e unico - indice nao-unico)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descrs, mensas, tipos" + ;
				" FROM SigOpIns WHERE cidchaves = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Instru" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


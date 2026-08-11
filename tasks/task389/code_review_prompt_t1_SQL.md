# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigCdCtg.Cods"
  ControlSource = "crSigCdCtg.Descs"
		lcQuery = [Select Cods ] + ;
				    [From SigCdCtg ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCtg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1004 linhas total):

*-- Linhas 343 a 361:
343:             .HighlightBackColor = RGB(255, 255, 255)
344:             .HighlightForeColor = RGB(15, 41, 104)
345:             .HighlightStyle     = 2
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .RowHeight          = 16
349:             .ScrollBars         = 2
350:             .GridLines          = 3
351:             .ReadOnly           = .T.
352:             .Visible            = .T.
353:         ENDWITH
354: 
355:         *-- BINDEVENTs dos botoes da Page1
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
358:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

*-- Linhas 538 a 557:
538:                 loc_oGrid.ColumnCount = 2
539:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
540: 
541:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
542:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
543: 
544:                 loc_oGrid.Column1.Width = 80
545:                 loc_oGrid.Column2.Width = 380
546: 
547:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
548:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
549: 
550:                 THIS.FormatarGridLista(loc_oGrid)
551: 
552:                 loc_lSucesso = .T.
553:             ENDIF
554:         CATCH TO loException
555:             MostrarErro("Erro ao carregar lista de categorias:" + CHR(13) + ;
556:                 loException.Message, "FormCtg.CarregarLista")
557:             loc_lSucesso = .F.

*-- Linhas 646 a 664:
646:         loc_cCodigo = ""
647: 
648:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
649:             SELECT cursor_4c_Dados
650:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
651:         ENDIF
652: 
653:         IF EMPTY(loc_cCodigo)
654:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
655:             RETURN
656:         ENDIF
657: 
658:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
659:             THIS.this_cModoAtual = "VISUALIZAR"
660:             THIS.BOParaForm()
661:             THIS.HabilitarCampos(.F.)
662:             THIS.AlternarPagina(2)
663:             THIS.AjustarBotoesPorModo()
664:         ELSE

*-- Linhas 674 a 692:
674:         loc_cCodigo = ""
675: 
676:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
677:             SELECT cursor_4c_Dados
678:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
679:         ENDIF
680: 
681:         IF EMPTY(loc_cCodigo)
682:             MsgAviso("Selecione um registro para alterar.", "Alterar")
683:             RETURN
684:         ENDIF
685: 
686:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
687:             THIS.this_oBusinessObject.EditarRegistro()
688:             THIS.this_cModoAtual = "ALTERAR"
689:             THIS.BOParaForm()
690:             THIS.HabilitarCampos(.T.)
691:             THIS.AlternarPagina(2)
692:             THIS.AjustarBotoesPorModo()

*-- Linhas 703 a 721:
703:         loc_cCodigo = ""
704: 
705:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
706:             SELECT cursor_4c_Dados
707:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
708:         ENDIF
709: 
710:         IF EMPTY(loc_cCodigo)
711:             MsgAviso("Selecione um registro para excluir.", "Excluir")
712:             RETURN
713:         ENDIF
714: 
715:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da categoria " + ;
716:             ALLTRIM(loc_cCodigo) + "?", "Excluir")
717: 
718:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
719:                 IF THIS.this_oBusinessObject.Excluir()
720:                     MsgInfo("Categoria exclu" + CHR(237) + "da com sucesso!", "Sucesso")
721:                     THIS.CarregarLista()

*-- Linhas 732 a 770:
732:         loc_cCodigo = ""
733: 
734:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
735:             SELECT cursor_4c_Dados
736:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
737:         ENDIF
738: 
739:         TRY
740:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
741:                 "SigCdCtg", "cursor_4c_BuscaCtg", "cods", loc_cCodigo, ;
742:                 "Buscar Categoria")
743: 
744:             IF VARTYPE(loc_oBusca) = "O"
745:                 IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
746:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
747:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
748:                     loc_oBusca.Show()
749:                 ENDIF
750: 
751:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
752:                     SELECT cursor_4c_BuscaCtg
753:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCtg.cods)
754:                     IF USED("cursor_4c_Dados")
755:                         SELECT cursor_4c_Dados
756:                         LOCATE FOR ALLTRIM(cods) == loc_cCodigo
757:                     ENDIF
758:                 ENDIF
759:                 loc_oBusca.Release()
760:             ENDIF
761:         CATCH TO loException
762:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCtg.BtnBuscarClick")
763:         ENDTRY
764: 
765:         IF USED("cursor_4c_BuscaCtg")
766:             USE IN cursor_4c_BuscaCtg
767:         ENDIF
768:     ENDPROC
769: 
770:     *===========================================================================

*-- Linhas 819 a 838:
819:         *-- INCLUIR: verificar se codigo ja existe (logica do legado)
820:         IF THIS.this_cModoAtual = "INCLUIR"
821:             TRY
822:                 loc_nResult = SQLEXEC(gnConnHandle, ;
823:                     "SELECT Cods FROM SigCdCtg WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
824:                     "cursor_4c_CtgDupChk")
825:                 IF loc_nResult > 0 AND USED("cursor_4c_CtgDupChk")
826:                     IF RECCOUNT("cursor_4c_CtgDupChk") > 0
827:                         MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!!!", ;
828:                             "Aten" + CHR(231) + CHR(227) + "o")
829:                         IF USED("cursor_4c_CtgDupChk")
830:                             USE IN cursor_4c_CtgDupChk
831:                         ENDIF
832:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
833:                             loc_oPagina.txt_4c_Codigo.SetFocus()
834:                         ENDIF
835:                         RETURN
836:                     ENDIF
837:                 ENDIF
838:                 IF USED("cursor_4c_CtgDupChk")


### BO (C:\4c\projeto\app\classes\CtgBO.prg):
*====================================================================
* CtgBO.prg
*
* Business Object para Categorias
* Tabela principal: SigCdCtg (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CtgBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCtg)
	this_cCidchaves = ""   && cidchaves char(20) - PK tecnica (UUID)
	this_cCods      = ""   && cods char(6)       - codigo da categoria
	this_cDescs     = ""   && descs char(40)     - descricao da categoria

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCtg"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDFUNC

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
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescs     = TratarNulo(descs,     "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CtgBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCods))
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescs))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se cods ja existe na tabela
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CtgBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdCtg
	* Gera cidchaves via NEWID() do SQL Server
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar UUID para cidchaves via SQL Server
			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MostrarErro("Erro ao gerar chave " + CHR(250) + "nica para o registro.", "CtgBO.Inserir")
			ELSE
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					INSERT INTO SigCdCtg (cidchaves, cods, descs)
					VALUES (
						<<EscaparSQL(THIS.this_cCidchaves)>>,
						<<EscaparSQL(THIS.this_cCods)>>,
						<<EscaparSQL(THIS.this_cDescs)>>
					)
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CtgBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdCtg
	* cods nao e atualizado (chave de negocio imutavel pos-insercao)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdCtg
				SET descs = <<EscaparSQL(THIS.this_cDescs)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CtgBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdCtg WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CtgBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cidchaves, cods, descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(6), descs C(40))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs FROM SigCdCtg"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY cods"

				IF USED("cursor_4c_Dados")
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
					IF loc_nResultado >= 0
						SELECT cursor_4c_Dados
						ZAP
						SET NULL ON
						APPEND FROM DBF("cursor_4c_DadosTmp")
						SET NULL OFF
						IF USED("cursor_4c_DadosTmp")
							USE IN cursor_4c_DadosTmp
						ENDIF
						GO TOP IN cursor_4c_Dados
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CtgBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Categoria n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CtgBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


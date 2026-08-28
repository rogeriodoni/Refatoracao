# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-TABELA] Tabela 'SigCdOcs' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS
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
  ControlSource = "crSigCdOcs.cods"
  ControlSource = "crSigCdOcs.descs"
Select CrSigCdOcs
Select CrSigCdOcs
Select CrSigCdOcs

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOCS.prg) - TRECHOS RELEVANTES PARA PASS SQL (842 linhas total):

*-- Linhas 319 a 337:
319:             .HighlightBackColor = RGB(255, 255, 255)
320:             .HighlightForeColor = RGB(15, 41, 104)
321:             .HighlightStyle     = 2
322:             .DeleteMark         = .F.
323:             .RecordMark         = .F.
324:             .RowHeight          = 16
325:             .ScrollBars         = 2
326:             .GridLines          = 3
327:             .Visible            = .T.
328:         ENDWITH
329: 
330:         WITH loc_oGrid.Column1
331:             .Width           = 90
332:             .Alignment       = 0
333:             .Header1.Caption = "C" + CHR(243) + "digo"
334:         ENDWITH
335: 
336:         WITH loc_oGrid.Column2
337:             .Width           = 337

*-- Linhas 564 a 583:
564:             IF THIS.this_oBusinessObject.Buscar("")
565:                 loc_oGrid.ColumnCount = 2
566:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
567:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
568:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
569:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
570:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
571:                 loc_oGrid.Column1.Width           = 90
572:                 loc_oGrid.Column2.Width           = 337
573:                 THIS.FormatarGridLista(loc_oGrid)
574:                 loc_lResultado = .T.
575:             ENDIF
576:         CATCH TO loException
577:             MsgErro(loException.Message, "FormOCS.CarregarLista")
578:         ENDTRY
579: 
580:         RETURN loc_lResultado
581:     ENDPROC
582: 
583:     *--------------------------------------------------------------------------

*-- Linhas 604 a 622:
604:             RETURN
605:         ENDIF
606: 
607:         SELECT cursor_4c_Dados
608:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
609: 
610:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
611:             THIS.BOParaForm()
612:             THIS.this_cModoAtual = "VISUALIZAR"
613:             THIS.HabilitarCampos(.F.)
614:             THIS.pgf_4c_Paginas.ActivePage = 2
615:         ELSE
616:             MsgErro("Erro ao carregar registro.", "Visualizar")
617:         ENDIF
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnAlterarClick - Altera registro selecionado
622:     *--------------------------------------------------------------------------

*-- Linhas 629 a 647:
629:             RETURN
630:         ENDIF
631: 
632:         SELECT cursor_4c_Dados
633:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
634: 
635:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
636:             THIS.this_oBusinessObject.EditarRegistro()
637:             THIS.BOParaForm()
638:             THIS.this_cModoAtual = "ALTERAR"
639:             THIS.HabilitarCampos(.T.)
640:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.ReadOnly = .T.
641:             THIS.pgf_4c_Paginas.ActivePage = 2
642:             THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus
643:         ELSE
644:             MsgErro("Erro ao carregar registro.", "Alterar")
645:         ENDIF
646:     ENDPROC
647: 

*-- Linhas 658 a 676:
658:             RETURN
659:         ENDIF
660: 
661:         SELECT cursor_4c_Dados
662:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
663: 
664:         loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do registro" + ;
665:             " '" + loc_cCodigo + "'?", "Excluir")
666:         IF !loc_lConfirma
667:             RETURN
668:         ENDIF
669: 
670:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
671:             IF THIS.this_oBusinessObject.Excluir()
672:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
673:                 THIS.CarregarLista()
674:             ELSE
675:                 MsgErro("Erro ao excluir registro.", "Excluir")
676:             ENDIF

*-- Linhas 699 a 717:
699: 
700:                 loc_lSelecionou = loc_oBusca.this_lSelecionou
701:                 IF loc_lSelecionou AND USED("cursor_4c_Busca")
702:                     SELECT cursor_4c_Busca
703:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
704:                 ENDIF
705: 
706:                 loc_oBusca.Release()
707:             ENDIF
708:         CATCH TO loException
709:             MsgErro(loException.Message, "FormOCS.BtnBuscarClick")
710:         ENDTRY
711: 
712:         IF USED("cursor_4c_Busca")
713:             USE IN cursor_4c_Busca
714:         ENDIF
715: 
716:         IF loc_lSelecionou AND !EMPTY(loc_cCodigo)
717:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)


### BO (C:\4c\projeto\app\classes\OCSBO.prg):
*====================================================================
* OCSBO.prg
*
* Business Object para Ocasiao
* Tabela principal: SigCdOcs (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS OCSBO AS BusinessBase

	*-- Propriedades da entidade (SigCdOcs)
	*-- SigCdOcs nao encontrada no schema.sql snapshot; tipos inferidos do
	*-- fonte legado SIGCDOCS.SCX e padrao fUniqueIds/ChkRegister.
	this_cCidchaves = ""   && cidchaves char(20)  - PK tecnica gerada por fUniqueIds
	this_cCods      = ""   && cods char(10)       - codigo de ocasiao (chave de negocio)
	this_cDescs     = ""   && descs char(40)      - descricao da ocasiao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdOcs"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista registros com filtro opcional sobre cods/descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cWhere = " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
				             " OR descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = "SELECT cods, descs FROM SigCdOcs" + ;
			           loc_cWhere + ;
			           " ORDER BY cods"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado > 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs FROM SigCdOcs" + ;
			           " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT INTO SigCdOcs
	* Gera cidchaves via fUniqueIds() (funcao do framework legado)
	* Valida: cods nao pode ser vazio nem duplicado
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCods))
				MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Verificar duplicidade de codigo
				loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOcs WHERE cods = " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cCods))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCods")
				IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkCods") > 0
					SELECT cursor_4c_ChkCods
					IF cursor_4c_ChkCods.qtd > 0
						MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
					ELSE
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
						THIS.this_cCidchaves = fUniqueIds()

						loc_cSQL = "INSERT INTO SigCdOcs (cidchaves, cods, descs)" + ;
						           " VALUES (" + ;
						           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
						           EscaparSQL(THIS.this_cCods) + ", " + ;
						           EscaparSQL(THIS.this_cDescs) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado >= 0
							THIS.RegistrarAuditoria("INSERT")
							loc_lSucesso = .T.
						ELSE
							MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
						ENDIF
					ENDIF
				ELSE
					MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					IF USED("cursor_4c_ChkCods")
						USE IN cursor_4c_ChkCods
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
			IF USED("cursor_4c_ChkCods")
				USE IN cursor_4c_ChkCods
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE SigCdOcs (apenas descs; cods e cidchaves sao imutaveis)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdOcs SET" + ;
			           " descs = " + EscaparSQL(THIS.this_cDescs) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE FROM SigCdOcs
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdOcs WHERE cidchaves = " + ;
			           EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


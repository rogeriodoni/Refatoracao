# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-TABELA] Tabela 'SigCdOcs' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOCS.prg) - TRECHOS RELEVANTES PARA PASS SQL (844 linhas total):

*-- Linhas 321 a 339:
321:             .HighlightBackColor = RGB(255, 255, 255)
322:             .HighlightForeColor = RGB(15, 41, 104)
323:             .HighlightStyle     = 2
324:             .DeleteMark         = .F.
325:             .RecordMark         = .F.
326:             .RowHeight          = 16
327:             .ScrollBars         = 2
328:             .GridLines          = 3
329:             .Visible            = .T.
330:         ENDWITH
331: 
332:         WITH loc_oGrid.Column1
333:             .Width           = 90
334:             .Alignment       = 0
335:             .Header1.Caption = "C" + CHR(243) + "digo"
336:         ENDWITH
337: 
338:         WITH loc_oGrid.Column2
339:             .Width           = 337

*-- Linhas 566 a 585:
566:             IF THIS.this_oBusinessObject.Buscar("")
567:                 loc_oGrid.ColumnCount = 2
568:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
569:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
570:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
571:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
572:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
573:                 loc_oGrid.Column1.Width           = 90
574:                 loc_oGrid.Column2.Width           = 337
575:                 THIS.FormatarGridLista(loc_oGrid)
576:                 loc_lResultado = .T.
577:             ENDIF
578:         CATCH TO loException
579:             MsgErro(loException.Message, "FormOCS.CarregarLista")
580:         ENDTRY
581: 
582:         RETURN loc_lResultado
583:     ENDPROC
584: 
585:     *--------------------------------------------------------------------------

*-- Linhas 606 a 624:
606:             RETURN
607:         ENDIF
608: 
609:         SELECT cursor_4c_Dados
610:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
611: 
612:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
613:             THIS.BOParaForm()
614:             THIS.this_cModoAtual = "VISUALIZAR"
615:             THIS.HabilitarCampos(.F.)
616:             THIS.pgf_4c_Paginas.ActivePage = 2
617:         ELSE
618:             MsgErro("Erro ao carregar registro.", "Visualizar")
619:         ENDIF
620:     ENDPROC
621: 
622:     *--------------------------------------------------------------------------
623:     * BtnAlterarClick - Altera registro selecionado
624:     *--------------------------------------------------------------------------

*-- Linhas 631 a 649:
631:             RETURN
632:         ENDIF
633: 
634:         SELECT cursor_4c_Dados
635:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
636: 
637:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
638:             THIS.this_oBusinessObject.EditarRegistro()
639:             THIS.BOParaForm()
640:             THIS.this_cModoAtual = "ALTERAR"
641:             THIS.HabilitarCampos(.T.)
642:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.ReadOnly = .T.
643:             THIS.pgf_4c_Paginas.ActivePage = 2
644:             THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus
645:         ELSE
646:             MsgErro("Erro ao carregar registro.", "Alterar")
647:         ENDIF
648:     ENDPROC
649: 

*-- Linhas 660 a 678:
660:             RETURN
661:         ENDIF
662: 
663:         SELECT cursor_4c_Dados
664:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
665: 
666:         loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do registro" + ;
667:             " '" + loc_cCodigo + "'?", "Excluir")
668:         IF !loc_lConfirma
669:             RETURN
670:         ENDIF
671: 
672:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
673:             IF THIS.this_oBusinessObject.Excluir()
674:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
675:                 THIS.CarregarLista()
676:             ELSE
677:                 MsgErro("Erro ao excluir registro.", "Excluir")
678:             ENDIF

*-- Linhas 701 a 719:
701: 
702:                 loc_lSelecionou = loc_oBusca.this_lSelecionou
703:                 IF loc_lSelecionou AND USED("cursor_4c_Busca")
704:                     SELECT cursor_4c_Busca
705:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
706:                 ENDIF
707: 
708:                 loc_oBusca.Release()
709:             ENDIF
710:         CATCH TO loException
711:             MsgErro(loException.Message, "FormOCS.BtnBuscarClick")
712:         ENDTRY
713: 
714:         IF USED("cursor_4c_Busca")
715:             USE IN cursor_4c_Busca
716:         ENDIF
717: 
718:         IF loc_lSelecionou AND !EMPTY(loc_cCodigo)
719:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)


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
				loc_cWhere = " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
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
			           " WHERE cods = " + EscaparSQL(THIS.this_cCods)

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
			loc_cSQL = "DELETE FROM SigCdOcs WHERE cods = " + ;
			           EscaparSQL(THIS.this_cCods)

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


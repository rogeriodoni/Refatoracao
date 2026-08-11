# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODFINP

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
  ControlSource = "crSigCdFip.Cods"
  ControlSource = "crSigCdFip.Descs"
	lcQuery = [Select CPros, DPros ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (889 linhas total):

*-- Linhas 353 a 387:
353: 			.HighlightBackColor = RGB(255, 255, 255)
354: 			.HighlightForeColor = RGB(15, 41, 104)
355: 			.HighlightStyle     = 2
356: 			.DeleteMark         = .F.
357: 			.RecordMark         = .F.
358: 			.RowHeight          = 16
359: 			.ScrollBars         = 2
360: 			.GridLines          = 3
361: 			.Visible            = .T.
362: 		ENDWITH
363: 
364: 		*-- ControlSource e Headers APOS RecordSource (VFP reseta headers ao mudar RecordSource)
365: 		WITH loc_oGrid.Column1
366: 			.ControlSource   = "cursor_4c_Dados.Cods"
367: 			.Width           = 60
368: 			.Header1.Caption = "C" + CHR(243) + "digos"
369: 		ENDWITH
370: 
371: 		WITH loc_oGrid.Column2
372: 			.ControlSource   = "cursor_4c_Dados.Descs"
373: 			.Width           = 150
374: 			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
375: 		ENDWITH
376: 
377: 		THIS.TornarControlesVisiveis(loc_oPagina)
378: 	ENDPROC
379: 
380: 	*====================================================================
381: 	* ConfigurarPaginaDados - Page2 (Dados)
382: 	* Grupo_Salva: Left=819,Top=10 -> Top=10+29=39
383: 	* Say1 (C" + CHR(243) + "digo): Top=157+29=186, Left=374
384: 	* getCods (txt_4c_Codigo): Top=153+29=182, Left=422, Width=31
385: 	*====================================================================
386: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
387: 		LOCAL loc_oPagina

*-- Linhas 545 a 564:
545: 				ELSE
546: 					loc_oGrid.ColumnCount = 2
547: 					loc_oGrid.RecordSource = "cursor_4c_Dados"
548: 					loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
549: 					loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
550: 					loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
551: 					loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
552: 					loc_oGrid.Column1.Width           = 60
553: 					loc_oGrid.Column2.Width           = 150
554: 					THIS.FormatarGridLista(loc_oGrid)
555: 					loc_lResultado = .T.
556: 				ENDIF
557: 
558: 			CATCH TO loException
559: 				MostrarErro(loException, "FormFpr.CarregarLista")
560: 				loc_lResultado = .F.
561: 			ENDTRY
562: 		ENDIF
563: 
564: 		RETURN loc_lResultado

*-- Linhas 706 a 724:
706: 		loc_cCodigo = ""
707: 
708: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
709: 			SELECT cursor_4c_Dados
710: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
711: 		ENDIF
712: 
713: 		IF EMPTY(loc_cCodigo)
714: 			MsgAviso("Selecione um registro na lista!")
715: 			RETURN
716: 		ENDIF
717: 
718: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
719: 			THIS.BOParaForm()
720: 			THIS.this_cModoAtual = "VISUALIZAR"
721: 			THIS.HabilitarCampos(.F.)
722: 			THIS.AjustarBotoesPorModo()
723: 			THIS.AlternarPagina(2)
724: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus

*-- Linhas 733 a 751:
733: 		loc_cCodigo = ""
734: 
735: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
736: 			SELECT cursor_4c_Dados
737: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
738: 		ENDIF
739: 
740: 		IF EMPTY(loc_cCodigo)
741: 			MsgAviso("Selecione um registro na lista!")
742: 			RETURN
743: 		ENDIF
744: 
745: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
746: 			THIS.this_oBusinessObject.EditarRegistro()
747: 			THIS.BOParaForm()
748: 			THIS.this_cModoAtual = "ALTERAR"
749: 			THIS.HabilitarCampos(.T.)
750: 			THIS.AjustarBotoesPorModo()
751: 			THIS.AlternarPagina(2)

*-- Linhas 761 a 779:
761: 		loc_cCodigo = ""
762: 
763: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
764: 			SELECT cursor_4c_Dados
765: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
766: 		ENDIF
767: 
768: 		IF EMPTY(loc_cCodigo)
769: 			MsgAviso("Selecione um registro na lista!")
770: 			RETURN
771: 		ENDIF
772: 
773: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
774: 			THIS.BOParaForm()
775: 			THIS.this_cModoAtual = "EXCLUIR"
776: 			THIS.HabilitarCampos(.F.)
777: 			THIS.AjustarBotoesPorModo()
778: 			THIS.AlternarPagina(2)
779: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus

*-- Linhas 823 a 848:
823: 				loc_cFiltro    = ""
824: 
825: 				IF !EMPTY(loc_cCodigo)
826: 					loc_cFiltro = "Cods LIKE " + EscaparSQL(loc_cCodigo + "%")
827: 				ENDIF
828: 
829: 				IF !EMPTY(loc_cDescricao)
830: 					IF !EMPTY(loc_cFiltro)
831: 						loc_cFiltro = loc_cFiltro + " AND "
832: 					ENDIF
833: 					loc_cFiltro = loc_cFiltro + "Descs LIKE " + EscaparSQL("%" + loc_cDescricao + "%")
834: 				ENDIF
835: 
836: 				THIS.this_oBusinessObject.Buscar(loc_cFiltro)
837: 				IF USED("cursor_4c_Dados")
838: 					GO TOP IN cursor_4c_Dados
839: 				ENDIF
840: 				THIS.this_cModoAtual = "LISTA"
841: 				THIS.pgf_4c_Paginas.ActivePage = 1
842: 				loc_lSucesso = .T.
843: 
844: 			CASE THIS.this_cModoAtual = "EXCLUIR"
845: 				TRY
846: 					loc_lSucesso = THIS.this_oBusinessObject.Excluir()
847: 					IF loc_lSucesso
848: 						MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")


### BO (C:\4c\projeto\app\classes\FprBO.prg):
*====================================================================
* FprBO.prg
*
* Business Object para Modelos de Produtos
* Tabela: SigCdFip
* Campos: Cods (PK), Descs
*====================================================================

DEFINE CLASS FprBO AS BusinessBase

	*-- Propriedades da entidade
	this_cCods  = ""
	this_cDescs = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdFip"
			THIS.this_cCampoChave = "Cods"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "FprBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
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
				THIS.this_cCods  = TratarNulo(Cods,  "C")
				THIS.this_cDescs = TratarNulo(Descs, "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FprBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Regras do original: Cods e Descs nao podem ser vazios nem ter aspas
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cCods) OR (AT("'", THIS.this_cCods) + AT('"', THIS.this_cCods) > 0)
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND (EMPTY(THIS.this_cDescs) OR (AT("'", THIS.this_cDescs) + AT('"', THIS.this_cDescs) > 0))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se Cods ja existe em SigCdFip
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpr")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFpr")
				SELECT cursor_4c_ChkFpr
				loc_lExiste = (cursor_4c_ChkFpr.qtd > 0)
				USE IN cursor_4c_ChkFpr
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "FprBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdFip (Cods, Descs)" + ;
				" VALUES (" + EscaparSQL(THIS.this_cCods) + ", " + EscaparSQL(THIS.this_cDescs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FprBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFip" + ;
				" SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
				" WHERE Cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FprBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdFip
	* Verifica se produtos usam este modelo (SigCdPro.CodFinP) antes de excluir
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso, loc_cMsg
		loc_lSucesso = .F.
		loc_nUso     = 0
		loc_cMsg     = ""

		TRY
			loc_cSQL = "SELECT CPros, DPros FROM SigCdPro" + ;
				" WHERE CodFinP = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

			IF loc_nResultado < 0
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
			ELSE
				IF USED("cursor_4c_ChkPro")
					SELECT cursor_4c_ChkPro
					GO TOP IN cursor_4c_ChkPro
					loc_nUso = IIF(!EOF("cursor_4c_ChkPro"), RECCOUNT("cursor_4c_ChkPro"), 0)

					IF loc_nUso > 1
						loc_cMsg = "Existem " + ALLTRIM(STR(loc_nUso)) + " Produtos Utilizando Esse Modelo!!!" + ;
							" Para Excluir o" + CHR(13) + ;
							"Modelo " + CHR(233) + " Necess" + CHR(225) + "rio Alterar o Cadastro de Produtos Primeiro!!!"
						MsgAviso(loc_cMsg)
					ELSE
						IF loc_nUso = 1
							loc_cMsg = "O Produto " + ALLTRIM(cursor_4c_ChkPro.CPros) + " - " + ;
								ALLTRIM(cursor_4c_ChkPro.DPros) + " Est" + CHR(225) + ;
								" Utilizando Esse Modelo!!!" + CHR(13) + ;
								"Para Excluir o Modelo " + CHR(233) + " Necess" + CHR(225) + ;
								"rio Alterar o Cadastro do Produto Primeiro!!!"
							MsgAviso(loc_cMsg)
						ELSE
							USE IN cursor_4c_ChkPro

							loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
							loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
							IF loc_nResultado >= 0
								THIS.RegistrarAuditoria("DELETE")
								loc_lSucesso = .T.
							ELSE
								MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							ENDIF
						ENDIF
					ENDIF

					IF USED("cursor_4c_ChkPro")
						USE IN cursor_4c_ChkPro
					ENDIF
				ELSE
					loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FprBO.ExecutarExclusao")
			IF USED("cursor_4c_ChkPro")
				USE IN cursor_4c_ChkPro
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com Cods, Descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (Cods C(5), Descs C(50))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT Cods, Descs FROM SigCdFip"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY Cods"

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
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FprBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (Cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Modelo de Produto n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FprBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


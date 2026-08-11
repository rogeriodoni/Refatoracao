# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEPS, ENDES, BAIRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TOTAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEPS, ENDES, BAIRS

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
  ControlSource = "crSigCdenr.ceps"
  ControlSource = "crSigCdenr.bairs"
  ControlSource = "crSigCdenr.endes"
lcQryEnr = [Select * From SigCdEnr]
		Select crSigCdEnr
Select crSigCdEnr
Select crSigCdEnr
	lcQuery = 'Select * From SigCdEnr Where ceps=?lcCep And endes=?lcEnd And bairs=?lcBai'
	ThisForm.poDataMgr.SqlExecute(lcQuery, [crLocal])
		SELECT crSigCdEnr
SELECT crSigCdEnr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormENR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1074 linhas total):

*-- Linhas 358 a 376:
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle    = 2
361:             .DeleteMark        = .F.
362:             .RecordMark        = .F.
363:             .RowHeight         = 16
364:             .ScrollBars        = 2
365:             .GridLines         = 3
366:             .Visible           = .T.
367: 
368:             .Column1.Width           = 100
369:             .Column1.FontName        = "Verdana"
370:             .Column1.FontSize        = 8
371: 
372:             .Column2.Width           = 450
373:             .Column2.FontName        = "Verdana"
374:             .Column2.FontSize        = 8
375: 
376:             .Column3.Width           = 300

*-- Linhas 585 a 605:
585:                 IF THIS.this_oBusinessObject.Buscar("")
586:                     *-- Vincular grid ao cursor recriado pelo BO
587:                     loc_oGrid.RecordSource          = "crSigCdEnr"
588:                     loc_oGrid.Column1.ControlSource = "crSigCdEnr.ceps"
589:                     loc_oGrid.Column2.ControlSource = "crSigCdEnr.endes"
590:                     loc_oGrid.Column3.ControlSource = "crSigCdEnr.bairs"
591: 
592:                     *-- Reconfigura??o de headers apos RecordSource (obrigatorio - problema #32)
593:                     loc_oGrid.Column1.Header1.Caption = "CEP"
594:                     loc_oGrid.Column2.Header1.Caption = "Endere" + CHR(231) + "o"
595:                     loc_oGrid.Column3.Header1.Caption = "Bairro"
596: 
597:                     *-- Larguras das colunas
598:                     loc_oGrid.Column1.Width = 100
599:                     loc_oGrid.Column2.Width = 450
600:                     loc_oGrid.Column3.Width = 300
601: 
602:                     THIS.FormatarGridLista(loc_oGrid)
603:                     loc_lResultado = .T.
604:                 ENDIF
605:             ENDIF

*-- Linhas 789 a 807:
789:         ENDIF
790: 
791:         TRY
792:             SELECT crSigCdEnr
793:             loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
794:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
795:         CATCH TO loc_oErro
796:             MsgErro(loc_oErro.Message, "FormENR.BtnVisualizarClick")
797:         ENDTRY
798: 
799:         IF loc_lCarregou
800:             THIS.BOParaForm()
801:             THIS.this_cModoAtual = "VISUALIZAR"
802:             THIS.HabilitarCampos(.F.)
803:             THIS.AjustarBotoesPorModo()
804:             THIS.AlternarPagina(2)
805:         ENDIF
806:     ENDPROC
807: 

*-- Linhas 818 a 836:
818:         ENDIF
819: 
820:         TRY
821:             SELECT crSigCdEnr
822:             loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
823:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
824:             IF loc_lCarregou
825:                 THIS.this_oBusinessObject.EditarRegistro()
826:             ENDIF
827:         CATCH TO loc_oErro
828:             MsgErro(loc_oErro.Message, "FormENR.BtnAlterarClick")
829:         ENDTRY
830: 
831:         IF loc_lCarregou
832:             THIS.BOParaForm()
833:             THIS.this_cModoAtual = "ALTERAR"
834:             THIS.HabilitarCampos(.T.)
835:             THIS.AjustarBotoesPorModo()
836:             THIS.AlternarPagina(2)

*-- Linhas 850 a 868:
850:         ENDIF
851: 
852:         TRY
853:             SELECT crSigCdEnr
854:             loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
855:             loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
856:         CATCH TO loc_oErro
857:             MsgErro(loc_oErro.Message, "FormENR.BtnExcluirClick")
858:         ENDTRY
859: 
860:         IF loc_lCarregou
861:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste endere" + CHR(231) + "o?", "Excluir")
862:                 IF THIS.this_oBusinessObject.Excluir()
863:                     MsgInfo("Endere" + CHR(231) + "o exclu" + CHR(237) + "do com sucesso!")
864:                     THIS.CarregarLista()
865:                 ENDIF
866:             ENDIF
867:         ENDIF
868:     ENDPROC

*-- Linhas 913 a 936:
913: 
914:         *-- Verifica duplicidade apenas no modo INSERIR
915:         IF THIS.this_cModoAtual = "INCLUIR"
916:             loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
917:                        " WHERE ceps = " + EscaparSQL(loc_cCep) + ;
918:                        " AND endes = " + EscaparSQL(loc_cEndes) + ;
919:                        " AND bairs = " + EscaparSQL(loc_cBairs)
920: 
921:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
922:                 IF !EOF("cursor_4c_DupCheck") AND cursor_4c_DupCheck.total > 0
923:                     MsgAviso("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.")
924:                     IF USED("cursor_4c_DupCheck")
925:                         USE IN cursor_4c_DupCheck
926:                     ENDIF
927:                     RETURN
928:                 ENDIF
929:             ENDIF
930:             IF USED("cursor_4c_DupCheck")
931:                 USE IN cursor_4c_DupCheck
932:             ENDIF
933:         ENDIF
934: 
935:         TRY
936:             THIS.FormParaBO()

*-- Linhas 971 a 992:
971:             ENDIF
972: 
973:             IF !EMPTY(STRTRAN(loc_cCep, "-", ""))
974:                 loc_cSQL = "SELECT TOP 1 endes, bairs FROM SigCdEnr" + ;
975:                            " WHERE ceps = " + EscaparSQL(loc_cCep)
976: 
977:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCep") > 0
978:                     IF !EOF("cursor_4c_BuscaCep")
979:                         IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
980:                             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Endereco.Value))
981:                                 loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaCep.endes)
982:                             ENDIF
983:                         ENDIF
984:                         IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
985:                             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
986:                                 loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaCep.bairs)
987:                             ENDIF
988:                         ENDIF
989:                         loc_lResultado = .T.
990:                     ENDIF
991:                 ENDIF
992:             ENDIF

*-- Linhas 1022 a 1044:
1022:             *-- GetEndere?o.When retorna .T. somente se Empty(getCEP))
1023:             *-- Portanto, se o usuario digitou aqui, o CEP esta vazio -> buscar por endes
1024:             IF !EMPTY(STRTRAN(loc_cEndereco, "-", ""))
1025:                 loc_cSQL = "SELECT TOP 1 ceps, endes, bairs FROM SigCdEnr" + ;
1026:                            " WHERE endes LIKE " + EscaparSQL(loc_cEndereco + "%") + ;
1027:                            " ORDER BY ceps"
1028: 
1029:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEndes") > 0
1030:                     IF !EOF("cursor_4c_BuscaEndes")
1031:                         IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
1032:                             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_CEP.Value))
1033:                                 loc_oPg2.txt_4c_CEP.Value = ALLTRIM(cursor_4c_BuscaEndes.ceps)
1034:                             ENDIF
1035:                         ENDIF
1036:                         IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
1037:                             loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaEndes.endes)
1038:                         ENDIF
1039:                         IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
1040:                             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
1041:                                 loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaEndes.bairs)
1042:                             ENDIF
1043:                         ENDIF
1044:                         loc_lResultado = .T.


### BO (C:\4c\projeto\app\classes\ENRBO.prg):
*====================================================================
* ENRBO.prg
*
* Business Object para Enderecos (Cadastro de Enderecos - SigCdEnr)
* Tabela principal: SigCdEnr (pkchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ENRBO AS BusinessBase

	*-- Propriedades da entidade (tabela: SigCdEnr)
	this_cPkChaves  = ""   && pkchaves char(20) - PK (ID gerado via SQL NEWID)
	this_cCep       = ""   && ceps     char(9)  - CEP (formato 99999-999)
	this_cEndereco  = ""   && endes    char(60) - Endereco
	this_cBairro    = ""   && bairs    char(40) - Bairro

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdEnr"
		THIS.this_cCampoChave = "pkchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cPkChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de enderecos no cursor crSigCdEnr
	* par_cFiltro: trecho de CEP ou endereco para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " ORDER BY ceps"
			ELSE
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " WHERE ceps LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " OR endes LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEnr")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo pkchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cPkChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
			           " FROM SigCdEnr" + ;
			           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

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
			THIS.this_cPkChaves  = TratarNulo(pkchaves, "C")
			THIS.this_cCep       = TratarNulo(ceps,     "C")
			THIS.this_cEndereco  = TratarNulo(endes,    "C")
			THIS.this_cBairro    = TratarNulo(bairs,    "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicado - Verifica se endereco ja esta cadastrado
	* Retorna .T. se ja existe (duplicado), .F. se pode inserir
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicado()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
			           " WHERE ceps  = " + EscaparSQL(THIS.this_cCep)      + ;
			           " AND   endes = " + EscaparSQL(THIS.this_cEndereco) + ;
			           " AND   bairs = " + EscaparSQL(THIS.this_cBairro)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
				SELECT cursor_4c_DupCheck
				loc_lDuplicado = (cursor_4c_DupCheck.total > 0)
			ENDIF

			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCep))
				MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
			    IF THIS.VerificarDuplicado()
				MsgErro("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Gerar chave unica via SQL Server NEWID()
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
				IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
					SELECT cursor_4c_Uuid
					THIS.this_cPkChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
				ENDIF
				IF USED("cursor_4c_Uuid")
					USE IN cursor_4c_Uuid
				ENDIF

				IF EMPTY(THIS.this_cPkChaves)
					MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCdEnr (pkchaves, ceps, endes, bairs)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cPkChaves)  + "," + ;
					           EscaparSQL(THIS.this_cCep)       + "," + ;
					           EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
					           EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
					           ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdEnr SET" + ;
			           " ceps  = " + EscaparSQL(THIS.this_cCep)                      + "," + ;
			           " endes = " + EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
			           " bairs = " + EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
			           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdEnr WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


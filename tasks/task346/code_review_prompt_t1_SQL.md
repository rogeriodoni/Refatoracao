# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdAli.FPagSAutos"
  ControlSource = "crSigCdAli.OpSaidas"
  ControlSource = "crSigCdAli.codigos"
  ControlSource = "crSigCdAli.descrs"
  ControlSource = "crSigCdAli.opautos"
  ControlSource = "crSigCdAli.Pefins"
Select CrSigCdAli
Select CrSigCdAli

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormAli.prg) - TRECHOS RELEVANTES PARA PASS SQL (1259 linhas total):

*-- Linhas 350 a 368:
350:             .HighlightBackColor      = RGB(255, 255, 255)
351:             .HighlightForeColor      = RGB(15, 41, 104)
352:             .HighlightStyle          = 2
353:             .DeleteMark              = .F.
354:             .RecordMark              = .F.
355:             .RowHeight               = 16
356:             .ScrollBars              = 2
357:             .GridLines               = 3
358:             .ReadOnly                = .T.
359:             .Visible                 = .T.
360:             .Column1.Width           = 50
361:             .Column2.Width           = 415
362:             .Column3.Width           = 200
363:             .Column4.Width           = 160
364:             .Column1.ReadOnly        = .T.
365:             .Column2.ReadOnly        = .T.
366:             .Column3.ReadOnly        = .T.
367:             .Column4.ReadOnly        = .T.
368:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"

*-- Linhas 703 a 724:
703: 
704:                         loc_oGrid.ColumnCount = 4
705:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
706:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
707:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
708:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.opautos"
709:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fpagsautos"
710: 
711:                         loc_oGrid.Column1.Width = 50
712:                         loc_oGrid.Column2.Width = 415
713:                         loc_oGrid.Column3.Width = 200
714:                         loc_oGrid.Column4.Width = 160
715: 
716:                         loc_oGrid.Column1.ReadOnly = .T.
717:                         loc_oGrid.Column2.ReadOnly = .T.
718:                         loc_oGrid.Column3.ReadOnly = .T.
719:                         loc_oGrid.Column4.ReadOnly = .T.
720: 
721:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
722:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
723:                         loc_oGrid.Column3.Header1.Caption = "Oper. Autom. Cheque"
724:                         loc_oGrid.Column4.Header1.Caption = "Cond. Pag. Autom."

*-- Linhas 828 a 846:
828:             RETURN .F.
829:         ENDIF
830: 
831:         SELECT cursor_4c_Dados
832:         loc_nCodigo = cursor_4c_Dados.codigos
833: 
834:         TRY
835:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
836:                 THIS.BOParaForm()
837:                 THIS.this_cModoAtual = "VISUALIZAR"
838:                 THIS.HabilitarCampos(.F.)
839:                 THIS.AjustarBotoesPorModo()
840:                 THIS.AlternarPagina(2)
841:                 loc_lResultado = .T.
842:             ENDIF
843:         CATCH TO loc_oErro
844:             MsgErro(loc_oErro.Message, "FormAli.BtnVisualizarClick")
845:         ENDTRY
846: 

*-- Linhas 859 a 877:
859:             RETURN .F.
860:         ENDIF
861: 
862:         SELECT cursor_4c_Dados
863:         loc_nCodigo = cursor_4c_Dados.codigos
864: 
865:         TRY
866:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
867:                 THIS.this_oBusinessObject.EditarRegistro()
868:                 THIS.BOParaForm()
869:                 THIS.this_cModoAtual = "ALTERAR"
870:                 THIS.HabilitarCampos(.T.)
871:                 THIS.AjustarBotoesPorModo()
872:                 THIS.AlternarPagina(2)
873:                 loc_lResultado = .T.
874:             ENDIF
875:         CATCH TO loc_oErro
876:             MsgErro(loc_oErro.Message, "FormAli.BtnAlterarClick")
877:         ENDTRY

*-- Linhas 891 a 909:
891:             RETURN .F.
892:         ENDIF
893: 
894:         SELECT cursor_4c_Dados
895:         loc_nCodigo = cursor_4c_Dados.codigos
896: 
897:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
898:             RETURN .F.
899:         ENDIF
900: 
901:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da al" + CHR(237) + ;
902:                         "nea " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
903:             RETURN .F.
904:         ENDIF
905: 
906:         TRY
907:             IF THIS.this_oBusinessObject.Excluir()
908:                 MsgInfo("Al" + CHR(237) + "nea exclu" + CHR(237) + "da com sucesso!")
909:                 THIS.CarregarLista()

*-- Linhas 982 a 1000:
982:                 THIS.this_cModoAtual = "LISTA"
983:                 THIS.AlternarPagina(1)
984:                 IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
985:                     SELECT cursor_4c_Dados
986:                     LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
987:                 ENDIF
988:                 loc_lResultado = .T.
989:             ELSE
990:                 IF THIS.FormParaBO()
991:                     IF THIS.this_oBusinessObject.Salvar()
992:                         MsgInfo("Al" + CHR(237) + "nea salva com sucesso!")
993:                         THIS.this_cModoAtual = "LISTA"
994:                         THIS.AlternarPagina(1)
995:                         loc_lResultado = .T.
996:                     ENDIF
997:                 ENDIF
998:             ENDIF
999:         CATCH TO loc_oErro
1000:             MsgErro(loc_oErro.Message, "FormAli.BtnConfirmarClick")

*-- Linhas 1148 a 1166:
1148:                 ENDIF
1149: 
1150:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
1151:                     SELECT cursor_4c_BuscaOp
1152:                     loc_oPg2.txt_4c_OpAutos.Value = ALLTRIM(cursor_4c_BuscaOp.Operacaos)
1153:                 ENDIF
1154: 
1155:                 loc_oBusca.Release()
1156:             ENDIF
1157:         CATCH TO loc_oErro
1158:             MsgErro(loc_oErro.Message, "FormAli.ValidarOpAutos")
1159:         ENDTRY
1160: 
1161:         IF USED("cursor_4c_BuscaOp")
1162:             USE IN cursor_4c_BuscaOp
1163:         ENDIF
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------

*-- Linhas 1187 a 1205:
1187:                 ENDIF
1188: 
1189:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpSai")
1190:                     SELECT cursor_4c_BuscaOpSai
1191:                     loc_oPg2.txt_4c_OpSaidas.Value = ALLTRIM(cursor_4c_BuscaOpSai.Operacaos)
1192:                 ENDIF
1193: 
1194:                 loc_oBusca.Release()
1195:             ENDIF
1196:         CATCH TO loc_oErro
1197:             MsgErro(loc_oErro.Message, "FormAli.ValidarOpSaidas")
1198:         ENDTRY
1199: 
1200:         IF USED("cursor_4c_BuscaOpSai")
1201:             USE IN cursor_4c_BuscaOpSai
1202:         ENDIF
1203:     ENDPROC
1204: 
1205:     *--------------------------------------------------------------------------

*-- Linhas 1226 a 1244:
1226:                 ENDIF
1227: 
1228:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
1229:                     SELECT cursor_4c_BuscaFPag
1230:                     loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(cursor_4c_BuscaFPag.Fpags)
1231:                 ENDIF
1232: 
1233:                 loc_oBusca.Release()
1234:             ENDIF
1235:         CATCH TO loc_oErro
1236:             MsgErro(loc_oErro.Message, "FormAli.ValidarFPagSAutos")
1237:         ENDTRY
1238: 
1239:         IF USED("cursor_4c_BuscaFPag")
1240:             USE IN cursor_4c_BuscaFPag
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\AliBO.prg):
*====================================================================
* AliBO.prg
*
* Business Object para Alineas
* Tabela: SIGCDALI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS AliBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDALI)
	this_nCodigos    = 0    && codigos numeric(3,0) - PK
	this_cDescrs     = ""   && descrs char(40)
	this_cOpAutos    = ""   && opautos char(15) - FK SigCdOpt.Operacaos
	this_cOpSaidas   = ""   && opsaidas char(15) - FK SigCdOpt.Operacaos
	this_cFPagSAutos = ""   && fpagsautos char(12) - FK SigOpFp.Fpags
	this_nPefins     = 2    && pefins numeric(1,0) - 1=Sim, 2=Nao
	this_nReincids   = 0    && reincids numeric(4,2) - nao exibido no form

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDALI"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de alineas no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " WHERE descrs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
			           " FROM SigCdAli" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_nCodigos    = TratarNulo(codigos, "N")
			THIS.this_cDescrs     = TratarNulo(descrs, "C")
			THIS.this_cOpAutos    = TratarNulo(opautos, "C")
			THIS.this_cOpSaidas   = TratarNulo(opsaidas, "C")
			THIS.this_cFPagSAutos = TratarNulo(fpagsautos, "C")
			THIS.this_nPefins     = TratarNulo(pefins, "N")
			THIS.this_nReincids   = TratarNulo(reincids, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdAli (codigos, descrs, opautos, opsaidas, fpagsautos, pefins)" + ;
			           " VALUES (" + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cDescrs) + "," + ;
			           EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPefins) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdAli SET" + ;
			           " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
			           " opautos = " + EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           " opsaidas = " + EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           " fpagsautos = " + EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           " pefins = " + FormatarNumeroSQL(THIS.this_nPefins) + ;
			           " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdAli WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


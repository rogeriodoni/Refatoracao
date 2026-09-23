# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, DOPES, USUARS

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
  ControlSource = "crSigSyMov.USUARS"
  ControlSource = "crSigSyMov.DOPES"
  ControlSource = "crSigSyMov.EMPS"
  ControlSource = "crSigSyMov.razas"
  ControlSource = "crSigSyMov.ncomps"
		lcQuery = [select a.usuars,a.Dopes,a.Emps,b.ncomps,c.razas,a.cidchaves from SigSyMov a ]+;
				  [Left Join SigCdUsu B ON a.usuars = b.usuarios ]+;
				  [Left Join SigCdEmp C ON a.emps = c.cemps ]			  
	lcSql = [Select * From SigSyMov Where Emps=']+ThisForm.Pagina.Dados.getEmps.Value+[' And Dopes = '  ' ]
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'LocMOV')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormUSA.prg) - TRECHOS RELEVANTES PARA PASS SQL (1262 linhas total):

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
360:             .Column1.Width           = 270
361:             .Column2.Width           = 510
362:             .Column3.Width           = 110
363:             .Column1.ReadOnly        = .T.
364:             .Column2.ReadOnly        = .T.
365:             .Column3.ReadOnly        = .T.
366:             .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
367:             .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
368:             .Column3.Header1.Caption = "Emp"

*-- Linhas 671 a 702:
671:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
672:                 IF !USED("cursor_4c_Dados")
673:                     SET NULL ON
674:                     CREATE CURSOR cursor_4c_Dados (cidchaves C(20), usuars C(10), dopes C(20), emps C(3))
675:                     SET NULL OFF
676:                 ENDIF
677:                 loc_lResultado = .T.
678:             ELSE
679:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
680:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
681:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
682: 
683:                         loc_oGrid.ColumnCount  = 3
684:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
685:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.usuars"
686:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
687:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.emps"
688: 
689:                         loc_oGrid.Column1.Width = 270
690:                         loc_oGrid.Column2.Width = 510
691:                         loc_oGrid.Column3.Width = 110
692: 
693:                         loc_oGrid.Column1.ReadOnly = .T.
694:                         loc_oGrid.Column2.ReadOnly = .T.
695:                         loc_oGrid.Column3.ReadOnly = .T.
696: 
697:                         loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
698:                         loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
699:                         loc_oGrid.Column3.Header1.Caption = "Emp"
700: 
701:                         IF USED("cursor_4c_Dados")
702:                             GO TOP IN cursor_4c_Dados

*-- Linhas 819 a 837:
819: 
820:     *--------------------------------------------------------------------------
821:     * BtnSalvarClick - Valida campos obrigatorios (NOT NULL no schema),
822:     * transfere Form->BO e grava (Salvar decide INSERT/UPDATE internamente).
823:     * BusinessBase.Salvar ja exibe a falha (CLAUDE.md - falha nunca eh muda);
824:     * so avisamos aqui se this_lErroExibido continuar .F.
825:     *--------------------------------------------------------------------------
826:     PROCEDURE BtnSalvarClick()
827:         LOCAL loc_oPg2
828:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
829: 
830:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Usuars.Value))
831:             MsgAviso("Informe o usu" + CHR(225) + "rio!")
832:             loc_oPg2.txt_4c_Usuars.SetFocus()
833:             RETURN
834:         ENDIF
835: 
836:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dopes.Value))
837:             MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o!")

*-- Linhas 891 a 911:
891:                 ENDIF
892: 
893:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUSA")
894:                     SELECT cursor_4c_BuscaUSA
895:                     loc_cUsuario = ALLTRIM(usuars)
896:                     THIS.CarregarLista("usuars = " + EscaparSQL(loc_cUsuario))
897:                 ENDIF
898: 
899:                 loc_oBusca.Release()
900:             ENDIF
901:         CATCH TO loc_oErro
902:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormUSA.BtnBuscarClick")
903:         ENDTRY
904: 
905:         IF USED("cursor_4c_BuscaUSA")
906:             USE IN cursor_4c_BuscaUSA
907:         ENDIF
908:     ENDPROC
909: 
910:     *--------------------------------------------------------------------------
911:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 917 a 935:
917: 
918:     *--------------------------------------------------------------------------
919:     * BtnIncluirClick - Prepara BO e formulario para um NOVO registro.
920:     * NovoRegistro() ANTES de limpar campos (Salvar() decide INSERT/UPDATE via
921:     * this_lNovoRegistro); this_cModoAtual setado ANTES de habilitar os campos
922:     * (CLAUDE.md Problema 19).
923:     *--------------------------------------------------------------------------
924:     PROCEDURE BtnIncluirClick()
925:         LOCAL loc_oPg2
926:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
927: 
928:         THIS.this_oBusinessObject.NovoRegistro()
929: 
930:         THIS.LimparCampos()
931: 
932:         THIS.this_cModoAtual = "INCLUIR"
933: 
934:         THIS.HabilitarCampos(.T.)
935:         THIS.AjustarBotoesPorModo()

*-- Linhas 941 a 971:
941: 
942:     *--------------------------------------------------------------------------
943:     * BtnAlterarClick - Le o registro selecionado na grade (cidchaves = PK,
944:     * nao exibida no grid), carrega do BO, prepara para UPDATE e habilita os
945:     * campos editaveis. EditarRegistro() APOS CarregarPorCodigo() (CLAUDE.md
946:     * Problema 18/22 - reseta this_lNovoRegistro para nao violar a PK).
947:     *--------------------------------------------------------------------------
948:     PROCEDURE BtnAlterarClick()
949:         LOCAL loc_cCidChaves, loc_oPg2
950: 
951:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
952:             MsgAviso("Selecione um registro na lista!")
953:             RETURN
954:         ENDIF
955: 
956:         SELECT cursor_4c_Dados
957:         loc_cCidChaves = ALLTRIM(cidchaves)
958: 
959:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
960:             RETURN
961:         ENDIF
962: 
963:         THIS.this_oBusinessObject.EditarRegistro()
964:         THIS.this_cModoAtual = "ALTERAR"
965:         THIS.BOParaForm()
966: 
967:         THIS.HabilitarCampos(.T.)
968:         THIS.AjustarBotoesPorModo()
969: 
970:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
971:         THIS.AlternarPagina(2)

*-- Linhas 985 a 1003:
985:             RETURN
986:         ENDIF
987: 
988:         SELECT cursor_4c_Dados
989:         loc_cCidChaves = ALLTRIM(cidchaves)
990: 
991:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
992:             RETURN
993:         ENDIF
994: 
995:         THIS.this_cModoAtual = "VISUALIZAR"
996:         THIS.BOParaForm()
997: 
998:         THIS.HabilitarCampos(.F.)
999:         THIS.AjustarBotoesPorModo()
1000: 
1001:         THIS.AlternarPagina(2)
1002:     ENDPROC
1003: 

*-- Linhas 1015 a 1033:
1015:             RETURN
1016:         ENDIF
1017: 
1018:         SELECT cursor_4c_Dados
1019:         loc_cCidChaves = ALLTRIM(cidchaves)
1020: 
1021:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirma" + CHR(231) + CHR(227) + "o")
1022:             RETURN
1023:         ENDIF
1024: 
1025:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1026:             RETURN
1027:         ENDIF
1028: 
1029:         IF THIS.this_oBusinessObject.Excluir()
1030:             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1031:             THIS.CarregarLista()
1032:         ELSE
1033:             IF !THIS.this_oBusinessObject.this_lErroExibido

*-- Linhas 1067 a 1085:
1067:             loc_oBusca.Show()
1068: 
1069:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1070:                 SELECT cursor_4c_BuscaUsu
1071:                 loc_oPg2.txt_4c_Usuars.Value  = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1072:                 loc_oPg2.txt_4c_DUsuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Ncomps)
1073:             ENDIF
1074: 
1075:             loc_oBusca.Release()
1076:         ENDIF
1077: 
1078:         IF USED("cursor_4c_BuscaUsu")
1079:             USE IN cursor_4c_BuscaUsu
1080:         ENDIF
1081:     ENDPROC
1082: 
1083:     *--------------------------------------------------------------------------
1084:     * Lookups - Usuario por Nome (busca reversa - SigCdUsu.Ncomps)
1085:     * txt_4c_DUsuars eh ReadOnly (display), DblClick preenche via codigo mesmo

*-- Linhas 1109 a 1127:
1109:             loc_oBusca.Show()
1110: 
1111:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1112:                 SELECT cursor_4c_BuscaUsu
1113:                 loc_oPg2.txt_4c_DUsuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Ncomps)
1114:                 loc_oPg2.txt_4c_Usuars.Value  = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1115:             ENDIF
1116: 
1117:             loc_oBusca.Release()
1118:         ENDIF
1119: 
1120:         IF USED("cursor_4c_BuscaUsu")
1121:             USE IN cursor_4c_BuscaUsu
1122:         ENDIF
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------
1126:     * Lookups - Operacao (SigCdOpe.Dopes) - tabela single-column: Dopes eh
1127:     * PK e descricao ao mesmo tempo (CLAUDE.md - nao existe campo separado)

*-- Linhas 1153 a 1171:
1153:             loc_oBusca.Show()
1154: 
1155:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1156:                 SELECT cursor_4c_BuscaOpe
1157:                 loc_oPg2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1158:             ENDIF
1159: 
1160:             loc_oBusca.Release()
1161:         ENDIF
1162: 
1163:         IF USED("cursor_4c_BuscaOpe")
1164:             USE IN cursor_4c_BuscaOpe
1165:         ENDIF
1166:     ENDPROC
1167: 
1168:     *--------------------------------------------------------------------------
1169:     * Lookups - Empresa (SigCdEmp.Cemps / Razas)
1170:     *--------------------------------------------------------------------------
1171:     PROCEDURE EmpsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1196 a 1214:
1196:             loc_oBusca.Show()
1197: 
1198:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1199:                 SELECT cursor_4c_BuscaEmp
1200:                 loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1201:                 loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1202:             ENDIF
1203: 
1204:             loc_oBusca.Release()
1205:         ENDIF
1206: 
1207:         IF USED("cursor_4c_BuscaEmp")
1208:             USE IN cursor_4c_BuscaEmp
1209:         ENDIF
1210:     ENDPROC
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * Lookups - Empresa por Nome (busca reversa - SigCdEmp.Razas)
1214:     * txt_4c_DEmps eh ReadOnly (display), DblClick preenche via codigo mesmo

*-- Linhas 1238 a 1256:
1238:             loc_oBusca.Show()
1239: 
1240:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1241:                 SELECT cursor_4c_BuscaEmp
1242:                 loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1243:                 loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1244:             ENDIF
1245: 
1246:             loc_oBusca.Release()
1247:         ENDIF
1248: 
1249:         IF USED("cursor_4c_BuscaEmp")
1250:             USE IN cursor_4c_BuscaEmp
1251:         ENDIF
1252:     ENDPROC
1253: 
1254:     *--------------------------------------------------------------------------
1255:     * Destroy
1256:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\USABO.prg):
*====================================================================
* USABO.prg
*
* Business Object para USA (Usuarios Automaticos)
* Tabela: SigSyMov (PK: cidchaves)
*====================================================================

DEFINE CLASS USABO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigSyMov - docs/schema.sql)
	this_cCidChaves                 = ""   && char(20) - PK (fUniqueIds())
	this_cUsuars                    = ""   && char(10) - FK SigCdUsu.usuarios
	this_cDopes                     = ""   && char(20) - FK SigCdOpe.Dopes
	this_cEmps                      = ""   && char(3)  - FK SigCdEmp.Cemps

	*-- Propriedades de exibicao (NAO persistidas - vem do LEFT JOIN do legado)
	this_cNComps                    = ""   && SigCdUsu.ncomps  (nome do usuario)
	this_cRazas                     = ""   && SigCdEmp.razas   (razao social da empresa)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigSyMov"
			THIS.this_cCampoChave = "cidchaves"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "USABO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	* Colunas persistidas (cidchaves, usuars, dopes, emps) sempre existem;
	* ncomps/razas so existem quando o cursor veio de query com LEFT JOIN
	* (SigCdUsu/SigCdEmp), por isso o TYPE() antes de ler.
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cUsuars    = TratarNulo(usuars, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			THIS.this_cEmps      = TratarNulo(emps, "C")

			IF TYPE(par_cAliasCursor + ".ncomps") != "U"
				THIS.this_cNComps = TratarNulo(ncomps, "C")
			ENDIF
			IF TYPE(par_cAliasCursor + ".razas") != "U"
				THIS.this_cRazas = TratarNulo(razas, "C")
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigSyMov
	* Todas as 4 colunas da tabela sao NOT NULL (docs/schema.sql) - cidchaves
	* eh a PK Fortyus, gerada aqui via fUniqueIds() quando ainda vazia.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigSyMov" + ;
					   " (cidchaves, usuars, dopes, emps)" + ;
					   " VALUES (" + ;
					   EscaparSQL(THIS.this_cCidChaves) + "," + ;
					   EscaparSQL(THIS.this_cUsuars) + "," + ;
					   EscaparSQL(THIS.this_cDopes) + "," + ;
					   EscaparSQL(THIS.this_cEmps) + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigSyMov (cidchaves nunca eh alterada)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigSyMov SET" + ;
					   " usuars = " + EscaparSQL(THIS.this_cUsuars) + "," + ;
					   " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
					   " emps = " + EscaparSQL(THIS.this_cEmps) + ;
					   " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - SELECT para a lista (Page1). Espelha o AddCursor/pColuna
	* do legado (Init): usuars, dopes, emps. cidchaves vai junto no cursor
	* (nao aparece no grid) para permitir Alterar/Excluir/Visualizar.
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), usuars C(10), dopes C(20), emps C(3))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, usuars, dopes, emps FROM SigSyMov"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY usuars"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao buscar usu" + CHR(225) + "rios autom" + CHR(225) + "ticos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "USABO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	* Traz tambem ncomps/razas (LEFT JOIN, igual ao legado) para exibicao
	* somente-leitura em Page2 (CarregarDoCursor ja testa TYPE antes de ler).
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.usuars, a.dopes, a.emps," + ;
				" b.ncomps, c.razas" + ;
				" FROM SigSyMov a" + ;
				" LEFT JOIN SigCdUsu b ON a.usuars = b.usuarios" + ;
				" LEFT JOIN SigCdEmp c ON a.emps = c.cemps" + ;
				" WHERE a.cidchaves = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Usu" + CHR(225) + "rio autom" + CHR(225) + "tico n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar:" + CHR(13) + loc_oErro.Message, "USABO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SigSyMov (chamado por Excluir())
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigSyMov WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


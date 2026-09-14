# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-SQL] Campo 'NComps' usado em ControlSource de cursor_4c_AcJ mas NAO aparece no SELECT SQL

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
  ControlSource = "crGradeJOB.RClis"
  ControlSource = "crGradeJOB.Razaos"
  ControlSource = "crGradeJOB.IClis"
  ControlSource = "crGradeJOB.Grupos"
  ControlSource = "crGradeJOB.Usuars"
  ControlSource = "crGradeJOB.DataIncs"
  ControlSource = "crGradeJOB.Inativas"
  DeleteMark = .F.
If Not ThisForm.poDataMgr.Update([crSigCdAcJ])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdAcJ)])
lcDelete = [Delete From SigCdAcJ Where JOBs = '] + crGradeJOB.IClis + [']
If ThisForm.PodataMgr.SqlExecute(lcDelete, []) < 0
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - crSigCdAcJ)')
lcDelete = [Delete From SigCdAcJ Where JOBs = '] + crGradeJOB.IClis + [']
If ThisForm.PodataMgr.SqlExecute(lcDelete, []) < 0
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - crSigCdAcJ)')
	If Not ThisForm.poDataMgr.Update([crSigCdAcJ])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdAcJ)])
lcQryCdCli = [Select a.Grupos, a.IClis, a.RClis, a.Razaos, a.Inativas, a.Usuars, a.DataIncs ] + ;
			   [From SigCdGcr b, SigCdCli a ] + ;
lcQryCdAcJ = [Select a.*, Space(30) as NComps From SigCdAcJ a Where a.pkChaves = '] + lcKey + [']
			.DeleteMark             = .f.
			.Column1.ControlSource  = [crSigCdAcJ.Usuars]
			.Column2.ControlSource  = [crSigCdAcJ.NComps]
Select crGradeJOB
Select crSigCdAcJ
lcQuery = [Select a.*, b.NComps ] + ;
		    [From SigCdAcJ a Left Join SigCdUsu b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalAcJ]) < 1)
Select LocalAcJ
	Insert Into crSigCdAcJ From Memvar
Select Sum(1) as Soma, Usuars ;
  From crSigCdAcJ ;
Delete From crSigCdAcJ Where Empty(Usuars)
Update crSigCdAcJ Set pkChaves = fUniqueIds() Where Empty(pkChaves)
Update crSigCdAcJ Set JOBs = crGradeJOB.IClis
Select crSigCdAcJ
Select crSigCdAcJ
	Delete In crSigCdAcJ

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormACJ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1501 linhas total):

*-- Linhas 334 a 352:
334:             .HighlightBackColor = RGB(255, 255, 255)
335:             .HighlightForeColor = RGB(15, 41, 104)
336:             .HighlightStyle     = 2
337:             .DeleteMark         = .F.
338:             .RecordMark         = .F.
339:             .RowHeight          = 16
340:             .ScrollBars         = 2
341:             .GridLines          = 3
342:             .Visible            = .T.
343:         ENDWITH
344: 
345:         THIS.TornarControlesVisiveis(loc_oPagina)
346:     ENDPROC
347: 
348:     *--------------------------------------------------------------------------
349:     * ConfigurarPaginaDados - Configura Page2 (Cabecalho JOB + Grade Acessos)
350:     * Fase 5: cabecalho info + botoes acao
351:     * Fase 6: grid de usuarios + botoes linha (btnInserir/btnExcluir)
352:     *--------------------------------------------------------------------------

*-- Linhas 657 a 679:
657:             .AutoSize  = .F.
658:             .Visible   = .T.
659:         ENDWITH
660: 
661:         *-- Criar cursor placeholder para o grid de usuarios
662:         IF !USED("cursor_4c_AcJ")
663:             SET NULL ON
664:             CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
665:             SET NULL OFF
666:         ENDIF
667: 
668:         *-- Grid de usuarios com acesso ao JOB
669:         *-- Legado: grdUsuarios top=170, left=307, width=343, height=418 (+29 compensacao)
670:         LOCAL loc_oGrdUsu
671:         loc_oPagina.AddObject("grd_4c_Usuarios", "Grid")
672:         loc_oGrdUsu = loc_oPagina.grd_4c_Usuarios
673:         loc_oGrdUsu.Top         = 199
674:         loc_oGrdUsu.Left        = 307
675:         loc_oGrdUsu.Width       = 343
676:         loc_oGrdUsu.Height      = 418
677:         loc_oGrdUsu.ColumnCount = 2
678: 
679:         WITH loc_oGrdUsu

*-- Linhas 685 a 718:
685:             .HighlightBackColor = RGB(255, 255, 255)
686:             .HighlightForeColor = RGB(15, 41, 104)
687:             .HighlightStyle     = 2
688:             .DeleteMark         = .F.
689:             .RecordMark         = .F.
690:             .RowHeight          = 16
691:             .ScrollBars         = 2
692:             .GridLines          = 3
693:             .Visible            = .T.
694:         ENDWITH
695: 
696:         loc_oGrdUsu.ColumnCount = 3
697:         loc_oGrdUsu.RecordSource = "cursor_4c_AcJ"
698:         WITH loc_oGrdUsu
699:             .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
700:             .Column1.Width           = 120
701:             .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
702: 
703:             .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
704:             .Column2.Width           = 200
705:             .Column2.Header1.Caption = "Nome"
706:         ENDWITH
707: 
708:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "When",  THIS, "GrdUsuariosColumn1When")
709:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "Valid",  THIS, "GrdUsuariosColumn1Valid")
710:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "When",  THIS, "GrdUsuariosColumn2When")
711:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "Valid",  THIS, "GrdUsuariosColumn2Valid")
712: 
713:         *-- Botao Inserir linha no grid (legado: btnInserir top=170, left=654, +29)
714:         loc_oPagina.AddObject("cmd_4c_InserirUsuario", "CommandButton")
715:         WITH loc_oPagina.cmd_4c_InserirUsuario
716:             .Caption         = ""
717:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
718:             .PicturePosition = 13

*-- Linhas 772 a 806:
772:                 loc_oGrid.ColumnCount  = 5
773: 
774:                 WITH loc_oGrid
775:                     .Column1.ControlSource  = "cursor_4c_GradeJOB.IClis"
776:                     .Column1.Width          = 80
777:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
778: 
779:                     .Column2.ControlSource  = "cursor_4c_GradeJOB.RClis"
780:                     .Column2.Width          = 80
781:                     .Column2.Header1.Caption = "Nome"
782: 
783:                     .Column3.ControlSource  = "cursor_4c_GradeJOB.Razaos"
784:                     .Column3.Width          = 420
785:                     .Column3.Header1.Caption = "Descritivo"
786: 
787:                     .Column4.ControlSource  = "cursor_4c_GradeJOB.Usuars"
788:                     .Column4.Width          = 80
789:                     .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
790: 
791:                     .Column5.ControlSource  = "cursor_4c_GradeJOB.DataIncs"
792:                     .Column5.Width          = 80
793:                     .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
794: 
795:                     .Refresh()
796:                 ENDWITH
797: 
798:                 THIS.FormatarGridLista(loc_oGrid)
799:                 loc_lSucesso = .T.
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
803:             loc_lSucesso = .F.
804:         ENDTRY
805: 
806:         RETURN loc_lSucesso

*-- Linhas 875 a 896:
875:     *--------------------------------------------------------------------------
876:     PROCEDURE BtnEncerrarClick()
877:         IF USED("cursor_4c_GradeJOB")
878:             USE IN cursor_4c_GradeJOB
879:         ENDIF
880:         IF USED("cursor_4c_AcJ")
881:             USE IN cursor_4c_AcJ
882:         ENDIF
883:         THIS.Release()
884:     ENDPROC
885: 
886:     *--------------------------------------------------------------------------
887:     * BtnBuscarClick - Filtra a lista de JOBs pelo texto digitado
888:     *--------------------------------------------------------------------------
889:     PROCEDURE BtnBuscarClick()
890:         LOCAL loc_oBusca, loc_cFiltro, loc_lSucesso
891:         loc_lSucesso = .F.
892: 
893:         TRY
894:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
895:                 "SigCdCli", "cursor_4c_BuscaJOB", "IClis", "", ;
896:                 "Buscar JOB")

*-- Linhas 915 a 941:
915:                         loc_oGrid.RecordSource = "cursor_4c_GradeJOB"
916:                         loc_oGrid.ColumnCount  = 5
917:                         WITH loc_oGrid
918:                             .Column1.ControlSource   = "cursor_4c_GradeJOB.IClis"
919:                             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
920:                             .Column2.ControlSource   = "cursor_4c_GradeJOB.RClis"
921:                             .Column2.Header1.Caption = "Nome"
922:                             .Column3.ControlSource   = "cursor_4c_GradeJOB.Razaos"
923:                             .Column3.Header1.Caption = "Descritivo"
924:                             .Column4.ControlSource   = "cursor_4c_GradeJOB.Usuars"
925:                             .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
926:                             .Column5.ControlSource   = "cursor_4c_GradeJOB.DataIncs"
927:                             .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
928:                             .Refresh()
929:                         ENDWITH
930:                         loc_lSucesso = .T.
931:                     ENDIF
932:                 ELSE
933:                     IF USED("cursor_4c_BuscaJOB")
934:                         USE IN cursor_4c_BuscaJOB
935:                     ENDIF
936:                     loc_lSucesso = THIS.CarregarLista()
937:                 ENDIF
938:                 loc_oBusca.Release()
939:             ENDIF
940:         CATCH TO loc_oErro
941:             MsgErro("Erro ao buscar JOB:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 958 a 976:
958:         ENDIF
959: 
960:         TRY
961:             SELECT cursor_4c_GradeJOB
962:             IF EOF("cursor_4c_GradeJOB")
963:                 MsgAviso("Nenhum JOB selecionado.", "")
964:             ELSE
965:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
966:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
967:                 THIS.this_cModoAtual = "VISUALIZAR"
968:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
969:                 THIS.AlternarPagina(2)
970:                 THIS.BOParaForm()
971:                 THIS.AjustarBotoesPorModo()
972:                 loc_lSucesso = .T.
973:             ENDIF
974:         CATCH TO loc_oErro
975:             MsgErro("Erro ao visualizar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
976:             loc_lSucesso = .F.

*-- Linhas 992 a 1010:
992:         ENDIF
993: 
994:         TRY
995:             SELECT cursor_4c_GradeJOB
996:             IF EOF("cursor_4c_GradeJOB")
997:                 MsgAviso("Nenhum JOB selecionado.", "")
998:             ELSE
999:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1000:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
1001:                 THIS.this_cModoAtual = "ALTERAR"
1002:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
1003:                 THIS.AlternarPagina(2)
1004:                 THIS.BOParaForm()
1005:                 THIS.AjustarBotoesPorModo()
1006:                 loc_lSucesso = .T.
1007:             ENDIF
1008:         CATCH TO loc_oErro
1009:             MsgErro("Erro ao alterar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
1010:             loc_lSucesso = .F.

*-- Linhas 1025 a 1059:
1025:             RETURN .F.
1026:         ENDIF
1027: 
1028:         SELECT cursor_4c_GradeJOB
1029:         IF EOF("cursor_4c_GradeJOB")
1030:             MsgAviso("Selecione um JOB na lista.", "")
1031:             RETURN .F.
1032:         ENDIF
1033: 
1034:         TRY
1035:             THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1036:             THIS.this_cModoAtual = "INCLUIR"
1037:             THIS.LimparCampos()
1038:             THIS.BOParaForm()
1039: 
1040:             IF USED("cursor_4c_AcJ")
1041:                 USE IN cursor_4c_AcJ
1042:             ENDIF
1043:             SET NULL ON
1044:             CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1045:             SET NULL OFF
1046: 
1047:             THIS.AlternarPagina(2)
1048:             THIS.CarregarGridUsuarios()
1049:             THIS.AjustarBotoesPorModo()
1050:             loc_lSucesso = .T.
1051:         CATCH TO loc_oErro
1052:             MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
1053:             loc_lSucesso = .F.
1054:         ENDTRY
1055: 
1056:         RETURN loc_lSucesso
1057:     ENDPROC
1058: 
1059:     *--------------------------------------------------------------------------

*-- Linhas 1070 a 1088:
1070:         ENDIF
1071: 
1072:         TRY
1073:             SELECT cursor_4c_GradeJOB
1074:             IF EOF("cursor_4c_GradeJOB")
1075:                 MsgAviso("Nenhum JOB selecionado.", "")
1076:             ELSE
1077:                 loc_cIClis = ALLTRIM(cursor_4c_GradeJOB.IClis)
1078:                 loc_lConfirmado = MsgConfirma("Excluir todos os acessos do JOB [" + ;
1079:                     loc_cIClis + "]?" + CHR(13) + "Esta opera" + CHR(231) + CHR(227) + ;
1080:                     "o n" + CHR(227) + "o pode ser desfeita.", ;
1081:                     "Confirmar Exclus" + CHR(227) + "o")
1082: 
1083:                 IF loc_lConfirmado
1084:                     IF THIS.this_oBusinessObject.ExcluirAcessos(loc_cIClis)
1085:                         MsgInfo("Acessos do JOB [" + loc_cIClis + "] exclu" + CHR(237) + ;
1086:                             "dos com sucesso.", "Sucesso")
1087:                         THIS.CarregarLista()
1088:                         loc_lSucesso = .T.

*-- Linhas 1230 a 1279:
1230: 
1231:     *--------------------------------------------------------------------------
1232:     * BtnCancelarClick - Cancela edicao e volta para lista
1233:     *--------------------------------------------------------------------------
1234:     PROCEDURE BtnCancelarClick()
1235:         IF USED("cursor_4c_AcJ")
1236:             USE IN cursor_4c_AcJ
1237:         ENDIF
1238:         THIS.this_cModoAtual = "LISTA"
1239:         THIS.AlternarPagina(1)
1240:     ENDPROC
1241: 
1242:     *--------------------------------------------------------------------------
1243:     * CarregarGridUsuarios - Vincula cursor_4c_AcJ ao grd_4c_Usuarios
1244:     *--------------------------------------------------------------------------
1245:     PROCEDURE CarregarGridUsuarios()
1246:         LOCAL loc_oGrid, loc_lSucesso
1247:         loc_lSucesso = .F.
1248: 
1249:         TRY
1250:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios
1251: 
1252:             IF !USED("cursor_4c_AcJ")
1253:                 SET NULL ON
1254:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1255:                 SET NULL OFF
1256:             ENDIF
1257: 
1258:             loc_oGrid.ColumnCount = 3
1259:             loc_oGrid.RecordSource = "cursor_4c_AcJ"
1260:             WITH loc_oGrid
1261:                 .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
1262:                 .Column1.Width           = 120
1263:                 .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1264:                 .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
1265:                 .Column2.Width           = 200
1266:                 .Column2.Header1.Caption = "Nome"
1267:             ENDWITH
1268: 
1269:             loc_oGrid.Refresh()
1270:             loc_lSucesso = .T.
1271:         CATCH TO loc_oErro
1272:             MsgErro("Erro ao carregar grid de usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
1273:             loc_lSucesso = .F.
1274:         ENDTRY
1275: 
1276:         RETURN loc_lSucesso
1277:     ENDPROC
1278: 
1279:     *--------------------------------------------------------------------------

*-- Linhas 1286 a 1352:
1286: 
1287:         LOCAL loc_lSucesso
1288:         loc_lSucesso = .F.
1289: 
1290:         TRY
1291:             IF !USED("cursor_4c_AcJ")
1292:                 SET NULL ON
1293:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1294:                 SET NULL OFF
1295:             ENDIF
1296: 
1297:             SELECT cursor_4c_AcJ
1298:             GO TOP IN cursor_4c_AcJ
1299:             LOCATE FOR EMPTY(ALLTRIM(Usuars)) AND !DELETED()
1300:             IF EOF("cursor_4c_AcJ")
1301:                 APPEND BLANK IN cursor_4c_AcJ
1302:             ENDIF
1303: 
1304:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1305:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1306:             loc_lSucesso = .T.
1307:         CATCH TO loc_oErro
1308:             MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1309:             loc_lSucesso = .F.
1310:         ENDTRY
1311: 
1312:         RETURN loc_lSucesso
1313:     ENDPROC
1314: 
1315:     *--------------------------------------------------------------------------
1316:     * BtnExcluirUsuarioClick - Remove linha atual do grid de usuarios
1317:     *--------------------------------------------------------------------------
1318:     PROCEDURE BtnExcluirUsuarioClick()
1319:         IF THIS.this_cModoAtual != "ALTERAR"
1320:             RETURN
1321:         ENDIF
1322: 
1323:         LOCAL loc_lSucesso, loc_nRec
1324:         loc_lSucesso = .F.
1325: 
1326:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1327:             RETURN .F.
1328:         ENDIF
1329: 
1330:         TRY
1331:             SELECT cursor_4c_AcJ
1332:             IF !EOF("cursor_4c_AcJ")
1333:                 loc_nRec = RECNO("cursor_4c_AcJ")
1334:                 DELETE IN cursor_4c_AcJ
1335:                 GO TOP IN cursor_4c_AcJ
1336:                 IF m.loc_nRec <= RECCOUNT("cursor_4c_AcJ")
1337:                     GO m.loc_nRec IN cursor_4c_AcJ
1338:                 ENDIF
1339:             ENDIF
1340: 
1341:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1342:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1343:             loc_lSucesso = .T.
1344:         CATCH TO loc_oErro
1345:             MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1346:             loc_lSucesso = .F.
1347:         ENDTRY
1348: 
1349:         RETURN loc_lSucesso
1350:     ENDPROC
1351: 
1352:     *--------------------------------------------------------------------------

*-- Linhas 1361 a 1481:
1361:     *--------------------------------------------------------------------------
1362:     PROCEDURE GrdUsuariosColumn1Valid()
1363:         LOCAL loc_oBusca, loc_cUsuario, loc_lResultado
1364:         loc_lResultado = .T.
1365: 
1366:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1367:             RETURN .T.
1368:         ENDIF
1369: 
1370:         TRY
1371:             SELECT cursor_4c_AcJ
1372:             loc_cUsuario = ALLTRIM(cursor_4c_AcJ.Usuars)
1373: 
1374:             IF !EMPTY(loc_cUsuario)
1375:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1376:                     "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuario, ;
1377:                     "Sele" + CHR(231) + CHR(227) + "o")
1378: 
1379:                 IF VARTYPE(loc_oBusca) = "O"
1380:                     IF loc_oBusca.this_lAchouRegistro
1381:                         IF USED("cursor_4c_BuscaUsu")
1382:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1383:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1384:                         ENDIF
1385:                     ELSE
1386:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1387:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1388:                         loc_oBusca.Show()
1389: 
1390:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1391:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1392:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1393:                         ELSE
1394:                             REPLACE Usuars WITH "" IN cursor_4c_AcJ
1395:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1396:                         ENDIF
1397:                     ENDIF
1398: 
1399:                     IF USED("cursor_4c_BuscaUsu")
1400:                         USE IN cursor_4c_BuscaUsu
1401:                     ENDIF
1402:                     loc_oBusca.Release()
1403:                 ENDIF
1404:             ELSE
1405:                 REPLACE NComps WITH "" IN cursor_4c_AcJ
1406:             ENDIF
1407: 
1408:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1409:         CATCH TO loc_oErro
1410:             MsgErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1411:         ENDTRY
1412: 
1413:         RETURN loc_lResultado
1414:     ENDPROC
1415: 
1416:     *--------------------------------------------------------------------------
1417:     * GrdUsuariosColumn2When - Controla editabilidade da coluna Nome
1418:     * Editavel apenas em ALTERAR + quando Usuars da linha esta vazio
1419:     *--------------------------------------------------------------------------
1420:     PROCEDURE GrdUsuariosColumn2When()
1421:         IF THIS.this_cModoAtual != "ALTERAR"
1422:             RETURN .F.
1423:         ENDIF
1424:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1425:             RETURN .F.
1426:         ENDIF
1427:         SELECT cursor_4c_AcJ
1428:         RETURN EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     * GrdUsuariosColumn2Valid - Lookup de usuario pelo Nome na coluna NComps
1433:     *--------------------------------------------------------------------------
1434:     PROCEDURE GrdUsuariosColumn2Valid()
1435:         LOCAL loc_oBusca, loc_cNome, loc_lResultado
1436:         loc_lResultado = .T.
1437: 
1438:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1439:             RETURN .T.
1440:         ENDIF
1441: 
1442:         TRY
1443:             SELECT cursor_4c_AcJ
1444:             loc_cNome = ALLTRIM(cursor_4c_AcJ.NComps)
1445: 
1446:             IF !EMPTY(loc_cNome)
1447:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1448:                     "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cNome, ;
1449:                     "Sele" + CHR(231) + CHR(227) + "o")
1450: 
1451:                 IF VARTYPE(loc_oBusca) = "O"
1452:                     IF loc_oBusca.this_lAchouRegistro
1453:                         IF USED("cursor_4c_BuscaUsu")
1454:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1455:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1456:                         ENDIF
1457:                     ELSE
1458:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1459:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1460:                         loc_oBusca.Show()
1461: 
1462:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1463:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1464:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1465:                         ELSE
1466:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1467:                         ENDIF
1468:                     ENDIF
1469: 
1470:                     IF USED("cursor_4c_BuscaUsu")
1471:                         USE IN cursor_4c_BuscaUsu
1472:                     ENDIF
1473:                     loc_oBusca.Release()
1474:                 ENDIF
1475: 
1476:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1477:             ENDIF
1478:         CATCH TO loc_oErro
1479:             MsgErro("Erro ao validar nome:" + CHR(13) + loc_oErro.Message, "Erro")
1480:         ENDTRY
1481: 

*-- Linhas 1487 a 1501:
1487:     *--------------------------------------------------------------------------
1488:     PROCEDURE Destroy()
1489:         IF USED("cursor_4c_GradeJOB")
1490:             USE IN cursor_4c_GradeJOB
1491:         ENDIF
1492:         IF USED("cursor_4c_AcJ")
1493:             USE IN cursor_4c_AcJ
1494:         ENDIF
1495:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1496:             THIS.this_oBusinessObject = .NULL.
1497:         ENDIF
1498:         DODEFAULT()
1499:     ENDPROC
1500: 
1501: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ACJBO.prg):
*==============================================================================
* ACJBO.prg - Business Object para Acessos de JOB
* Tabela principal: SigCdAcJ | PK: pkChaves
* Lista de JOBs: SigCdCli (filtro SigCdGcr.Coletors=10)
*==============================================================================

DEFINE CLASS ACJBO AS BusinessBase

    *-- Propriedades do JOB selecionado (display - SigCdCli via crGradeJOB)
    this_cGrupos        = ""    && Grupos    CHAR  - Grupo do JOB
    this_cIClis         = ""    && IClis     CHAR  - C" + CHR(243) + "digo do JOB (PK em SigCdCli)
    this_cRClis         = ""    && RClis     CHAR  - C" + CHR(243) + "digo abreviado
    this_cRazaos        = ""    && Razaos    CHAR  - Descritivo do JOB
    this_cUsuarsCriador = ""    && Usuars    CHAR  - Usu" + CHR(225) + "rio que criou o JOB
    this_dDataIncs      = {}    && DataIncs  DATE  - Data de inclus" + CHR(227) + "o
    this_lInativas      = .F.   && Inativas  NUM   - Inativo (0=N, 1=S)

    *-- Propriedades de controle de acesso (SigCdAcJ)
    this_cPkChaves      = ""    && pkChaves  CHAR  - Chave prim" + CHR(225) + "ria (gerada por fUniqueIds)
    this_cJOBs          = ""    && JOBs      CHAR  - FK para IClis do JOB
    this_cUsuars        = ""    && Usuars    CHAR  - Login do usu" + CHR(225) + "rio com acesso
    this_cNComps        = ""    && NComps    CHAR  - Nome completo (JOIN SigCdUsu.NComps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAcJ"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cJOBs     = TratarNulo(JOBs,     "C")
                THIS.this_cUsuars   = TratarNulo(Usuars,   "C")
                THIS.this_cNComps   = TratarNulo(NComps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarJobDoCursor - Carrega dados do JOB selecionado (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarJobDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos        = TratarNulo(Grupos,   "C")
                THIS.this_cIClis         = TratarNulo(IClis,    "C")
                THIS.this_cRClis         = TratarNulo(RClis,    "C")
                THIS.this_cRazaos        = TratarNulo(Razaos,   "C")
                THIS.this_cUsuarsCriador = TratarNulo(Usuars,   "C")
                THIS.this_dDataIncs      = TratarNulo(DataIncs, "D")
                THIS.this_lInativas      = (TratarNulo(Inativas, "N") = 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar JOB do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de JOBs (SigCdCli filtrado por Coletors=10)
    * Cursor destino: cursor_4c_GradeJOB
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Grupos, a.IClis, a.RClis, a.Razaos," + ;
                       " a.Inativas, a.Usuars, a.DataIncs" + ;
                       " FROM SigCdGcr b, SigCdCli a" + ;
                       " WHERE b.Coletors = 10" + ;
                       " AND b.Codigos = a.Grupos"

            loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GradeJOB")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar JOBs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar JOBs:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega usu" + CHR(225) + "rios com acesso ao JOB
    * Cursor destino: cursor_4c_AcJ
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.JOBs = " + EscaparSQL(ALLTRIM(par_cIClis)) + ;
                       " ORDER BY a.Usuars"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcJ")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Salva lista de usu" + CHR(225) + "rios com acesso ao JOB
    * Estrat" + CHR(233) + "gia: DELETE todos os existentes + INSERT dos atuais
    * Par" + CHR(226) + "metro: par_cIClis - c" + CHR(243) + "digo do JOB
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            *-- 1. Deletar todos os acessos antigos para este JOB
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Inserir registros atuais do cursor (somente com Usuars preenchido e nao deletados)
            IF USED("cursor_4c_AcJ") AND RECCOUNT("cursor_4c_AcJ") > 0
                SELECT cursor_4c_AcJ
                GO TOP
                DO WHILE !EOF("cursor_4c_AcJ")
                    IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
                        loc_cPkChaves = ALLTRIM(cursor_4c_AcJ.pkChaves)
                        IF EMPTY(loc_cPkChaves)
                            loc_cPkChaves = SYS(2015) + SYS(2015)
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cIClis)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_AcJ.Usuars)) + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso para usu" + CHR(225) + "rio " + ;
                                   ALLTRIM(cursor_4c_AcJ.Usuars) + ":" + CHR(13) + ;
                                   CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP IN cursor_4c_AcJ
                ENDDO
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirAcessos - Remove todos os acessos de um JOB
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inserir registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                       EscaparSQL(THIS.this_cJOBs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualizar registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdAcJ SET" + ;
                       " JOBs = " + EscaparSQL(THIS.this_cJOBs) + "," + ;
                       " Usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro individual (chamado pelo BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega acesso pela chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.pkChaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidadeUsuario - Verifica usu" + CHR(225) + "rios duplicados no cursor local
    * Retorna "" se OK, ou mensagem de erro se houver duplicata
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUnicidadeUsuario()
        LOCAL loc_cMensagem, loc_lSucesso
        loc_cMensagem = ""
        loc_lSucesso  = .F.

        TRY
            IF !USED("cursor_4c_AcJ")
                loc_lSucesso = ""
            ENDIF

            SELECT SUM(1) AS Soma, Usuars ;
              FROM cursor_4c_AcJ ;
             WHERE !DELETED() AND !EMPTY(ALLTRIM(Usuars)) ;
             GROUP BY Usuars ;
              INTO CURSOR cursor_4c_DuplAcJ

            GO TOP IN cursor_4c_DuplAcJ
            SELECT cursor_4c_DuplAcJ
            LOCATE FOR cursor_4c_DuplAcJ.Soma > 1
            IF !EOF("cursor_4c_DuplAcJ")
                loc_cMensagem = "O Usu" + CHR(225) + "rio " + CHR(34) + ;
                               ALLTRIM(cursor_4c_DuplAcJ.Usuars) + ;
                               CHR(34) + " est" + CHR(225) + " duplicado na grade!!!"
            ENDIF

            IF USED("cursor_4c_DuplAcJ")
                USE IN cursor_4c_DuplAcJ
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

ENDDEFINE


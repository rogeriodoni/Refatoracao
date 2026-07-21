# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-SQL] Campo 'NComps' usado em ControlSource de cursor_4c_AcJ mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: JOBS, COLETORS, PKCHAVES, I, SOMA, ICL, CODIGOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACJ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1507 linhas total):

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

*-- Linhas 772 a 810:
772:                 loc_oGrid.ColumnCount  = 6
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
787:                     .Column4.ControlSource  = "cursor_4c_GradeJOB.Grupos"
788:                     .Column4.Width          = 80
789:                     .Column4.Header1.Caption = "Grupo"
790: 
791:                     .Column5.ControlSource  = "cursor_4c_GradeJOB.DataIncs"
792:                     .Column5.Width          = 80
793:                     .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
794: 
795:                     .Column6.ControlSource  = "cursor_4c_GradeJOB.Inativas"
796:                     .Column6.Width          = 60
797:                     .Column6.Header1.Caption = "Inativo"
798: 
799:                     .Refresh()
800:                 ENDWITH
801: 
802:                 THIS.FormatarGridLista(loc_oGrid)
803:                 loc_lSucesso = .T.
804:             ENDIF
805:         CATCH TO loc_oErro
806:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
807:             loc_lSucesso = .F.
808:         ENDTRY
809: 
810:         RETURN loc_lSucesso

*-- Linhas 879 a 900:
879:     *--------------------------------------------------------------------------
880:     PROCEDURE BtnEncerrarClick()
881:         IF USED("cursor_4c_GradeJOB")
882:             USE IN cursor_4c_GradeJOB
883:         ENDIF
884:         IF USED("cursor_4c_AcJ")
885:             USE IN cursor_4c_AcJ
886:         ENDIF
887:         THIS.Release()
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * BtnBuscarClick - Filtra a lista de JOBs pelo texto digitado
892:     *--------------------------------------------------------------------------
893:     PROCEDURE BtnBuscarClick()
894:         LOCAL loc_oBusca, loc_cFiltro, loc_lSucesso
895:         loc_lSucesso = .F.
896: 
897:         TRY
898:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
899:                 "SigCdCli", "cursor_4c_BuscaJOB", "IClis", "", ;
900:                 "Buscar JOB")

*-- Linhas 919 a 947:
919:                         loc_oGrid.RecordSource = "cursor_4c_GradeJOB"
920:                         loc_oGrid.ColumnCount  = 6
921:                         WITH loc_oGrid
922:                             .Column1.ControlSource   = "cursor_4c_GradeJOB.IClis"
923:                             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
924:                             .Column2.ControlSource   = "cursor_4c_GradeJOB.RClis"
925:                             .Column2.Header1.Caption = "Nome"
926:                             .Column3.ControlSource   = "cursor_4c_GradeJOB.Razaos"
927:                             .Column3.Header1.Caption = "Descritivo"
928:                             .Column4.ControlSource   = "cursor_4c_GradeJOB.Grupos"
929:                             .Column4.Header1.Caption = "Grupo"
930:                             .Column5.ControlSource   = "cursor_4c_GradeJOB.DataIncs"
931:                             .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
932:                             .Column6.ControlSource   = "cursor_4c_GradeJOB.Inativas"
933:                             .Column6.Header1.Caption = "Inativo"
934:                             .Refresh()
935:                         ENDWITH
936:                         loc_lSucesso = .T.
937:                     ENDIF
938:                 ELSE
939:                     IF USED("cursor_4c_BuscaJOB")
940:                         USE IN cursor_4c_BuscaJOB
941:                     ENDIF
942:                     loc_lSucesso = THIS.CarregarLista()
943:                 ENDIF
944:                 loc_oBusca.Release()
945:             ENDIF
946:         CATCH TO loc_oErro
947:             MsgErro("Erro ao buscar JOB:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 964 a 982:
964:         ENDIF
965: 
966:         TRY
967:             SELECT cursor_4c_GradeJOB
968:             IF EOF("cursor_4c_GradeJOB")
969:                 MsgAviso("Nenhum JOB selecionado.", "")
970:             ELSE
971:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
972:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
973:                 THIS.this_cModoAtual = "VISUALIZAR"
974:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
975:                 THIS.AlternarPagina(2)
976:                 THIS.BOParaForm()
977:                 THIS.AjustarBotoesPorModo()
978:                 loc_lSucesso = .T.
979:             ENDIF
980:         CATCH TO loc_oErro
981:             MsgErro("Erro ao visualizar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
982:             loc_lSucesso = .F.

*-- Linhas 998 a 1016:
998:         ENDIF
999: 
1000:         TRY
1001:             SELECT cursor_4c_GradeJOB
1002:             IF EOF("cursor_4c_GradeJOB")
1003:                 MsgAviso("Nenhum JOB selecionado.", "")
1004:             ELSE
1005:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1006:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
1007:                 THIS.this_cModoAtual = "ALTERAR"
1008:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
1009:                 THIS.AlternarPagina(2)
1010:                 THIS.BOParaForm()
1011:                 THIS.AjustarBotoesPorModo()
1012:                 loc_lSucesso = .T.
1013:             ENDIF
1014:         CATCH TO loc_oErro
1015:             MsgErro("Erro ao alterar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
1016:             loc_lSucesso = .F.

*-- Linhas 1031 a 1065:
1031:             RETURN .F.
1032:         ENDIF
1033: 
1034:         SELECT cursor_4c_GradeJOB
1035:         IF EOF("cursor_4c_GradeJOB")
1036:             MsgAviso("Selecione um JOB na lista.", "")
1037:             RETURN .F.
1038:         ENDIF
1039: 
1040:         TRY
1041:             THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1042:             THIS.this_cModoAtual = "INCLUIR"
1043:             THIS.LimparCampos()
1044:             THIS.BOParaForm()
1045: 
1046:             IF USED("cursor_4c_AcJ")
1047:                 USE IN cursor_4c_AcJ
1048:             ENDIF
1049:             SET NULL ON
1050:             CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1051:             SET NULL OFF
1052: 
1053:             THIS.AlternarPagina(2)
1054:             THIS.CarregarGridUsuarios()
1055:             THIS.AjustarBotoesPorModo()
1056:             loc_lSucesso = .T.
1057:         CATCH TO loc_oErro
1058:             MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
1059:             loc_lSucesso = .F.
1060:         ENDTRY
1061: 
1062:         RETURN loc_lSucesso
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------

*-- Linhas 1076 a 1094:
1076:         ENDIF
1077: 
1078:         TRY
1079:             SELECT cursor_4c_GradeJOB
1080:             IF EOF("cursor_4c_GradeJOB")
1081:                 MsgAviso("Nenhum JOB selecionado.", "")
1082:             ELSE
1083:                 loc_cIClis = ALLTRIM(cursor_4c_GradeJOB.IClis)
1084:                 loc_lConfirmado = MsgConfirma("Excluir todos os acessos do JOB [" + ;
1085:                     loc_cIClis + "]?" + CHR(13) + "Esta opera" + CHR(231) + CHR(227) + ;
1086:                     "o n" + CHR(227) + "o pode ser desfeita.", ;
1087:                     "Confirmar Exclus" + CHR(227) + "o")
1088: 
1089:                 IF loc_lConfirmado
1090:                     IF THIS.this_oBusinessObject.ExcluirAcessos(loc_cIClis)
1091:                         MsgInfo("Acessos do JOB [" + loc_cIClis + "] exclu" + CHR(237) + ;
1092:                             "dos com sucesso.", "Sucesso")
1093:                         THIS.CarregarLista()
1094:                         loc_lSucesso = .T.

*-- Linhas 1236 a 1285:
1236: 
1237:     *--------------------------------------------------------------------------
1238:     * BtnCancelarClick - Cancela edicao e volta para lista
1239:     *--------------------------------------------------------------------------
1240:     PROCEDURE BtnCancelarClick()
1241:         IF USED("cursor_4c_AcJ")
1242:             USE IN cursor_4c_AcJ
1243:         ENDIF
1244:         THIS.this_cModoAtual = "LISTA"
1245:         THIS.AlternarPagina(1)
1246:     ENDPROC
1247: 
1248:     *--------------------------------------------------------------------------
1249:     * CarregarGridUsuarios - Vincula cursor_4c_AcJ ao grd_4c_Usuarios
1250:     *--------------------------------------------------------------------------
1251:     PROCEDURE CarregarGridUsuarios()
1252:         LOCAL loc_oGrid, loc_lSucesso
1253:         loc_lSucesso = .F.
1254: 
1255:         TRY
1256:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios
1257: 
1258:             IF !USED("cursor_4c_AcJ")
1259:                 SET NULL ON
1260:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1261:                 SET NULL OFF
1262:             ENDIF
1263: 
1264:             loc_oGrid.ColumnCount = 3
1265:             loc_oGrid.RecordSource = "cursor_4c_AcJ"
1266:             WITH loc_oGrid
1267:                 .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
1268:                 .Column1.Width           = 120
1269:                 .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1270:                 .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
1271:                 .Column2.Width           = 200
1272:                 .Column2.Header1.Caption = "Nome"
1273:             ENDWITH
1274: 
1275:             loc_oGrid.Refresh()
1276:             loc_lSucesso = .T.
1277:         CATCH TO loc_oErro
1278:             MsgErro("Erro ao carregar grid de usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
1279:             loc_lSucesso = .F.
1280:         ENDTRY
1281: 
1282:         RETURN loc_lSucesso
1283:     ENDPROC
1284: 
1285:     *--------------------------------------------------------------------------

*-- Linhas 1292 a 1358:
1292: 
1293:         LOCAL loc_lSucesso
1294:         loc_lSucesso = .F.
1295: 
1296:         TRY
1297:             IF !USED("cursor_4c_AcJ")
1298:                 SET NULL ON
1299:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1300:                 SET NULL OFF
1301:             ENDIF
1302: 
1303:             SELECT cursor_4c_AcJ
1304:             GO TOP IN cursor_4c_AcJ
1305:             LOCATE FOR EMPTY(ALLTRIM(Usuars)) AND !DELETED()
1306:             IF EOF("cursor_4c_AcJ")
1307:                 APPEND BLANK IN cursor_4c_AcJ
1308:             ENDIF
1309: 
1310:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1311:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1312:             loc_lSucesso = .T.
1313:         CATCH TO loc_oErro
1314:             MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1315:             loc_lSucesso = .F.
1316:         ENDTRY
1317: 
1318:         RETURN loc_lSucesso
1319:     ENDPROC
1320: 
1321:     *--------------------------------------------------------------------------
1322:     * BtnExcluirUsuarioClick - Remove linha atual do grid de usuarios
1323:     *--------------------------------------------------------------------------
1324:     PROCEDURE BtnExcluirUsuarioClick()
1325:         IF THIS.this_cModoAtual != "ALTERAR"
1326:             RETURN
1327:         ENDIF
1328: 
1329:         LOCAL loc_lSucesso, loc_nRec
1330:         loc_lSucesso = .F.
1331: 
1332:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1333:             RETURN .F.
1334:         ENDIF
1335: 
1336:         TRY
1337:             SELECT cursor_4c_AcJ
1338:             IF !EOF("cursor_4c_AcJ")
1339:                 loc_nRec = RECNO("cursor_4c_AcJ")
1340:                 DELETE IN cursor_4c_AcJ
1341:                 GO TOP IN cursor_4c_AcJ
1342:                 IF m.loc_nRec <= RECCOUNT("cursor_4c_AcJ")
1343:                     GO m.loc_nRec IN cursor_4c_AcJ
1344:                 ENDIF
1345:             ENDIF
1346: 
1347:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1348:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1349:             loc_lSucesso = .T.
1350:         CATCH TO loc_oErro
1351:             MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1352:             loc_lSucesso = .F.
1353:         ENDTRY
1354: 
1355:         RETURN loc_lSucesso
1356:     ENDPROC
1357: 
1358:     *--------------------------------------------------------------------------

*-- Linhas 1367 a 1487:
1367:     *--------------------------------------------------------------------------
1368:     PROCEDURE GrdUsuariosColumn1Valid()
1369:         LOCAL loc_oBusca, loc_cUsuario, loc_lResultado
1370:         loc_lResultado = .T.
1371: 
1372:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1373:             RETURN .T.
1374:         ENDIF
1375: 
1376:         TRY
1377:             SELECT cursor_4c_AcJ
1378:             loc_cUsuario = ALLTRIM(cursor_4c_AcJ.Usuars)
1379: 
1380:             IF !EMPTY(loc_cUsuario)
1381:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1382:                     "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuario, ;
1383:                     "Sele" + CHR(231) + CHR(227) + "o")
1384: 
1385:                 IF VARTYPE(loc_oBusca) = "O"
1386:                     IF loc_oBusca.this_lAchouRegistro
1387:                         IF USED("cursor_4c_BuscaUsu")
1388:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1389:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1390:                         ENDIF
1391:                     ELSE
1392:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1393:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1394:                         loc_oBusca.Show()
1395: 
1396:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1397:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1398:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1399:                         ELSE
1400:                             REPLACE Usuars WITH "" IN cursor_4c_AcJ
1401:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1402:                         ENDIF
1403:                     ENDIF
1404: 
1405:                     IF USED("cursor_4c_BuscaUsu")
1406:                         USE IN cursor_4c_BuscaUsu
1407:                     ENDIF
1408:                     loc_oBusca.Release()
1409:                 ENDIF
1410:             ELSE
1411:                 REPLACE NComps WITH "" IN cursor_4c_AcJ
1412:             ENDIF
1413: 
1414:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1415:         CATCH TO loc_oErro
1416:             MsgErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1417:         ENDTRY
1418: 
1419:         RETURN loc_lResultado
1420:     ENDPROC
1421: 
1422:     *--------------------------------------------------------------------------
1423:     * GrdUsuariosColumn2When - Controla editabilidade da coluna Nome
1424:     * Editavel apenas em ALTERAR + quando Usuars da linha esta vazio
1425:     *--------------------------------------------------------------------------
1426:     PROCEDURE GrdUsuariosColumn2When()
1427:         IF THIS.this_cModoAtual != "ALTERAR"
1428:             RETURN .F.
1429:         ENDIF
1430:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1431:             RETURN .F.
1432:         ENDIF
1433:         SELECT cursor_4c_AcJ
1434:         RETURN EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
1435:     ENDPROC
1436: 
1437:     *--------------------------------------------------------------------------
1438:     * GrdUsuariosColumn2Valid - Lookup de usuario pelo Nome na coluna NComps
1439:     *--------------------------------------------------------------------------
1440:     PROCEDURE GrdUsuariosColumn2Valid()
1441:         LOCAL loc_oBusca, loc_cNome, loc_lResultado
1442:         loc_lResultado = .T.
1443: 
1444:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1445:             RETURN .T.
1446:         ENDIF
1447: 
1448:         TRY
1449:             SELECT cursor_4c_AcJ
1450:             loc_cNome = ALLTRIM(cursor_4c_AcJ.NComps)
1451: 
1452:             IF !EMPTY(loc_cNome)
1453:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1454:                     "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cNome, ;
1455:                     "Sele" + CHR(231) + CHR(227) + "o")
1456: 
1457:                 IF VARTYPE(loc_oBusca) = "O"
1458:                     IF loc_oBusca.this_lAchouRegistro
1459:                         IF USED("cursor_4c_BuscaUsu")
1460:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1461:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1462:                         ENDIF
1463:                     ELSE
1464:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1465:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1466:                         loc_oBusca.Show()
1467: 
1468:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1469:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1470:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1471:                         ELSE
1472:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1473:                         ENDIF
1474:                     ENDIF
1475: 
1476:                     IF USED("cursor_4c_BuscaUsu")
1477:                         USE IN cursor_4c_BuscaUsu
1478:                     ENDIF
1479:                     loc_oBusca.Release()
1480:                 ENDIF
1481: 
1482:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1483:             ENDIF
1484:         CATCH TO loc_oErro
1485:             MsgErro("Erro ao validar nome:" + CHR(13) + loc_oErro.Message, "Erro")
1486:         ENDTRY
1487: 

*-- Linhas 1493 a 1507:
1493:     *--------------------------------------------------------------------------
1494:     PROCEDURE Destroy()
1495:         IF USED("cursor_4c_GradeJOB")
1496:             USE IN cursor_4c_GradeJOB
1497:         ENDIF
1498:         IF USED("cursor_4c_AcJ")
1499:             USE IN cursor_4c_AcJ
1500:         ENDIF
1501:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1502:             THIS.this_oBusinessObject = .NULL.
1503:         ENDIF
1504:         DODEFAULT()
1505:     ENDPROC
1506: 
1507: ENDDEFINE


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

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND a.IClis LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF

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


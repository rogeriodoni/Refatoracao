# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-SQL] Campo 'NComps' usado em ControlSource de cursor_4c_AcJ mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: JOBS, COLETORS, PKCHAVES, I, SOMA, ICL, CODIGOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACJ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1504 linhas total):

*-- Linhas 331 a 349:
331:             .HighlightBackColor = RGB(255, 255, 255)
332:             .HighlightForeColor = RGB(15, 41, 104)
333:             .HighlightStyle     = 2
334:             .DeleteMark         = .F.
335:             .RecordMark         = .F.
336:             .RowHeight          = 16
337:             .ScrollBars         = 2
338:             .GridLines          = 3
339:             .Visible            = .T.
340:         ENDWITH
341: 
342:         THIS.TornarControlesVisiveis(loc_oPagina)
343:     ENDPROC
344: 
345:     *--------------------------------------------------------------------------
346:     * ConfigurarPaginaDados - Configura Page2 (Cabecalho JOB + Grade Acessos)
347:     * Fase 5: cabecalho info + botoes acao
348:     * Fase 6: grid de usuarios + botoes linha (btnInserir/btnExcluir)
349:     *--------------------------------------------------------------------------

*-- Linhas 654 a 676:
654:             .AutoSize  = .F.
655:             .Visible   = .T.
656:         ENDWITH
657: 
658:         *-- Criar cursor placeholder para o grid de usuarios
659:         IF !USED("cursor_4c_AcJ")
660:             SET NULL ON
661:             CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
662:             SET NULL OFF
663:         ENDIF
664: 
665:         *-- Grid de usuarios com acesso ao JOB
666:         *-- Legado: grdUsuarios top=170, left=307, width=343, height=418 (+29 compensacao)
667:         LOCAL loc_oGrdUsu
668:         loc_oPagina.AddObject("grd_4c_Usuarios", "Grid")
669:         loc_oGrdUsu = loc_oPagina.grd_4c_Usuarios
670:         loc_oGrdUsu.Top         = 199
671:         loc_oGrdUsu.Left        = 307
672:         loc_oGrdUsu.Width       = 343
673:         loc_oGrdUsu.Height      = 418
674:         loc_oGrdUsu.ColumnCount = 2
675: 
676:         WITH loc_oGrdUsu

*-- Linhas 682 a 715:
682:             .HighlightBackColor = RGB(255, 255, 255)
683:             .HighlightForeColor = RGB(15, 41, 104)
684:             .HighlightStyle     = 2
685:             .DeleteMark         = .F.
686:             .RecordMark         = .F.
687:             .RowHeight          = 16
688:             .ScrollBars         = 2
689:             .GridLines          = 3
690:             .Visible            = .T.
691:         ENDWITH
692: 
693:         loc_oGrdUsu.ColumnCount = 3
694:         loc_oGrdUsu.RecordSource = "cursor_4c_AcJ"
695:         WITH loc_oGrdUsu
696:             .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
697:             .Column1.Width           = 120
698:             .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
699: 
700:             .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
701:             .Column2.Width           = 200
702:             .Column2.Header1.Caption = "Nome"
703:         ENDWITH
704: 
705:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "When",  THIS, "GrdUsuariosColumn1When")
706:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "Valid",  THIS, "GrdUsuariosColumn1Valid")
707:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "When",  THIS, "GrdUsuariosColumn2When")
708:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "Valid",  THIS, "GrdUsuariosColumn2Valid")
709: 
710:         *-- Botao Inserir linha no grid (legado: btnInserir top=170, left=654, +29)
711:         loc_oPagina.AddObject("cmd_4c_InserirUsuario", "CommandButton")
712:         WITH loc_oPagina.cmd_4c_InserirUsuario
713:             .Caption         = ""
714:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
715:             .PicturePosition = 13

*-- Linhas 769 a 807:
769:                 loc_oGrid.ColumnCount  = 6
770: 
771:                 WITH loc_oGrid
772:                     .Column1.ControlSource  = "cursor_4c_GradeJOB.IClis"
773:                     .Column1.Width          = 80
774:                     .Column1.Header1.Caption = "JOB"
775: 
776:                     .Column2.ControlSource  = "cursor_4c_GradeJOB.RClis"
777:                     .Column2.Width          = 80
778:                     .Column2.Header1.Caption = "C" + CHR(243) + "d. Abrev."
779: 
780:                     .Column3.ControlSource  = "cursor_4c_GradeJOB.Razaos"
781:                     .Column3.Width          = 420
782:                     .Column3.Header1.Caption = "Descritivo"
783: 
784:                     .Column4.ControlSource  = "cursor_4c_GradeJOB.Grupos"
785:                     .Column4.Width          = 80
786:                     .Column4.Header1.Caption = "Grupo"
787: 
788:                     .Column5.ControlSource  = "cursor_4c_GradeJOB.DataIncs"
789:                     .Column5.Width          = 80
790:                     .Column5.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
791: 
792:                     .Column6.ControlSource  = "cursor_4c_GradeJOB.Inativas"
793:                     .Column6.Width          = 60
794:                     .Column6.Header1.Caption = "Inativo"
795: 
796:                     .Refresh()
797:                 ENDWITH
798: 
799:                 THIS.FormatarGridLista(loc_oGrid)
800:                 loc_lSucesso = .T.
801:             ENDIF
802:         CATCH TO loc_oErro
803:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
804:             loc_lSucesso = .F.
805:         ENDTRY
806: 
807:         RETURN loc_lSucesso

*-- Linhas 876 a 897:
876:     *--------------------------------------------------------------------------
877:     PROCEDURE BtnEncerrarClick()
878:         IF USED("cursor_4c_GradeJOB")
879:             USE IN cursor_4c_GradeJOB
880:         ENDIF
881:         IF USED("cursor_4c_AcJ")
882:             USE IN cursor_4c_AcJ
883:         ENDIF
884:         THIS.Release()
885:     ENDPROC
886: 
887:     *--------------------------------------------------------------------------
888:     * BtnBuscarClick - Filtra a lista de JOBs pelo texto digitado
889:     *--------------------------------------------------------------------------
890:     PROCEDURE BtnBuscarClick()
891:         LOCAL loc_oBusca, loc_cFiltro, loc_lSucesso
892:         loc_lSucesso = .F.
893: 
894:         TRY
895:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
896:                 "SigCdCli", "cursor_4c_BuscaJOB", "IClis", "", ;
897:                 "Buscar JOB")

*-- Linhas 916 a 944:
916:                         loc_oGrid.RecordSource = "cursor_4c_GradeJOB"
917:                         loc_oGrid.ColumnCount  = 6
918:                         WITH loc_oGrid
919:                             .Column1.ControlSource   = "cursor_4c_GradeJOB.IClis"
920:                             .Column1.Header1.Caption = "JOB"
921:                             .Column2.ControlSource   = "cursor_4c_GradeJOB.RClis"
922:                             .Column2.Header1.Caption = "C" + CHR(243) + "d. Abrev."
923:                             .Column3.ControlSource   = "cursor_4c_GradeJOB.Razaos"
924:                             .Column3.Header1.Caption = "Descritivo"
925:                             .Column4.ControlSource   = "cursor_4c_GradeJOB.Grupos"
926:                             .Column4.Header1.Caption = "Grupo"
927:                             .Column5.ControlSource   = "cursor_4c_GradeJOB.DataIncs"
928:                             .Column5.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
929:                             .Column6.ControlSource   = "cursor_4c_GradeJOB.Inativas"
930:                             .Column6.Header1.Caption = "Inativo"
931:                             .Refresh()
932:                         ENDWITH
933:                         loc_lSucesso = .T.
934:                     ENDIF
935:                 ELSE
936:                     IF USED("cursor_4c_BuscaJOB")
937:                         USE IN cursor_4c_BuscaJOB
938:                     ENDIF
939:                     loc_lSucesso = THIS.CarregarLista()
940:                 ENDIF
941:                 loc_oBusca.Release()
942:             ENDIF
943:         CATCH TO loc_oErro
944:             MsgErro("Erro ao buscar JOB:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 961 a 979:
961:         ENDIF
962: 
963:         TRY
964:             SELECT cursor_4c_GradeJOB
965:             IF EOF("cursor_4c_GradeJOB")
966:                 MsgAviso("Nenhum JOB selecionado.", "")
967:             ELSE
968:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
969:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
970:                 THIS.this_cModoAtual = "VISUALIZAR"
971:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
972:                 THIS.AlternarPagina(2)
973:                 THIS.BOParaForm()
974:                 THIS.AjustarBotoesPorModo()
975:                 loc_lSucesso = .T.
976:             ENDIF
977:         CATCH TO loc_oErro
978:             MsgErro("Erro ao visualizar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
979:             loc_lSucesso = .F.

*-- Linhas 995 a 1013:
995:         ENDIF
996: 
997:         TRY
998:             SELECT cursor_4c_GradeJOB
999:             IF EOF("cursor_4c_GradeJOB")
1000:                 MsgAviso("Nenhum JOB selecionado.", "")
1001:             ELSE
1002:                 THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1003:                 loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
1004:                 THIS.this_cModoAtual = "ALTERAR"
1005:                 THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
1006:                 THIS.AlternarPagina(2)
1007:                 THIS.BOParaForm()
1008:                 THIS.AjustarBotoesPorModo()
1009:                 loc_lSucesso = .T.
1010:             ENDIF
1011:         CATCH TO loc_oErro
1012:             MsgErro("Erro ao alterar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
1013:             loc_lSucesso = .F.

*-- Linhas 1028 a 1062:
1028:             RETURN .F.
1029:         ENDIF
1030: 
1031:         SELECT cursor_4c_GradeJOB
1032:         IF EOF("cursor_4c_GradeJOB")
1033:             MsgAviso("Selecione um JOB na lista.", "")
1034:             RETURN .F.
1035:         ENDIF
1036: 
1037:         TRY
1038:             THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
1039:             THIS.this_cModoAtual = "INCLUIR"
1040:             THIS.LimparCampos()
1041:             THIS.BOParaForm()
1042: 
1043:             IF USED("cursor_4c_AcJ")
1044:                 USE IN cursor_4c_AcJ
1045:             ENDIF
1046:             SET NULL ON
1047:             CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1048:             SET NULL OFF
1049: 
1050:             THIS.AlternarPagina(2)
1051:             THIS.CarregarGridUsuarios()
1052:             THIS.AjustarBotoesPorModo()
1053:             loc_lSucesso = .T.
1054:         CATCH TO loc_oErro
1055:             MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
1056:             loc_lSucesso = .F.
1057:         ENDTRY
1058: 
1059:         RETURN loc_lSucesso
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------

*-- Linhas 1073 a 1091:
1073:         ENDIF
1074: 
1075:         TRY
1076:             SELECT cursor_4c_GradeJOB
1077:             IF EOF("cursor_4c_GradeJOB")
1078:                 MsgAviso("Nenhum JOB selecionado.", "")
1079:             ELSE
1080:                 loc_cIClis = ALLTRIM(cursor_4c_GradeJOB.IClis)
1081:                 loc_lConfirmado = MsgConfirma("Excluir todos os acessos do JOB [" + ;
1082:                     loc_cIClis + "]?" + CHR(13) + "Esta opera" + CHR(231) + CHR(227) + ;
1083:                     "o n" + CHR(227) + "o pode ser desfeita.", ;
1084:                     "Confirmar Exclus" + CHR(227) + "o")
1085: 
1086:                 IF loc_lConfirmado
1087:                     IF THIS.this_oBusinessObject.ExcluirAcessos(loc_cIClis)
1088:                         MsgInfo("Acessos do JOB [" + loc_cIClis + "] exclu" + CHR(237) + ;
1089:                             "dos com sucesso.", "Sucesso")
1090:                         THIS.CarregarLista()
1091:                         loc_lSucesso = .T.

*-- Linhas 1233 a 1282:
1233: 
1234:     *--------------------------------------------------------------------------
1235:     * BtnCancelarClick - Cancela edicao e volta para lista
1236:     *--------------------------------------------------------------------------
1237:     PROCEDURE BtnCancelarClick()
1238:         IF USED("cursor_4c_AcJ")
1239:             USE IN cursor_4c_AcJ
1240:         ENDIF
1241:         THIS.this_cModoAtual = "LISTA"
1242:         THIS.AlternarPagina(1)
1243:     ENDPROC
1244: 
1245:     *--------------------------------------------------------------------------
1246:     * CarregarGridUsuarios - Vincula cursor_4c_AcJ ao grd_4c_Usuarios
1247:     *--------------------------------------------------------------------------
1248:     PROCEDURE CarregarGridUsuarios()
1249:         LOCAL loc_oGrid, loc_lSucesso
1250:         loc_lSucesso = .F.
1251: 
1252:         TRY
1253:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios
1254: 
1255:             IF !USED("cursor_4c_AcJ")
1256:                 SET NULL ON
1257:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1258:                 SET NULL OFF
1259:             ENDIF
1260: 
1261:             loc_oGrid.ColumnCount = 3
1262:             loc_oGrid.RecordSource = "cursor_4c_AcJ"
1263:             WITH loc_oGrid
1264:                 .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
1265:                 .Column1.Width           = 120
1266:                 .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1267:                 .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
1268:                 .Column2.Width           = 200
1269:                 .Column2.Header1.Caption = "Nome"
1270:             ENDWITH
1271: 
1272:             loc_oGrid.Refresh()
1273:             loc_lSucesso = .T.
1274:         CATCH TO loc_oErro
1275:             MsgErro("Erro ao carregar grid de usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
1276:             loc_lSucesso = .F.
1277:         ENDTRY
1278: 
1279:         RETURN loc_lSucesso
1280:     ENDPROC
1281: 
1282:     *--------------------------------------------------------------------------

*-- Linhas 1289 a 1355:
1289: 
1290:         LOCAL loc_lSucesso
1291:         loc_lSucesso = .F.
1292: 
1293:         TRY
1294:             IF !USED("cursor_4c_AcJ")
1295:                 SET NULL ON
1296:                 CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
1297:                 SET NULL OFF
1298:             ENDIF
1299: 
1300:             SELECT cursor_4c_AcJ
1301:             GO TOP IN cursor_4c_AcJ
1302:             LOCATE FOR EMPTY(ALLTRIM(Usuars)) AND !DELETED()
1303:             IF EOF("cursor_4c_AcJ")
1304:                 APPEND BLANK IN cursor_4c_AcJ
1305:             ENDIF
1306: 
1307:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1308:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1309:             loc_lSucesso = .T.
1310:         CATCH TO loc_oErro
1311:             MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1312:             loc_lSucesso = .F.
1313:         ENDTRY
1314: 
1315:         RETURN loc_lSucesso
1316:     ENDPROC
1317: 
1318:     *--------------------------------------------------------------------------
1319:     * BtnExcluirUsuarioClick - Remove linha atual do grid de usuarios
1320:     *--------------------------------------------------------------------------
1321:     PROCEDURE BtnExcluirUsuarioClick()
1322:         IF THIS.this_cModoAtual != "ALTERAR"
1323:             RETURN
1324:         ENDIF
1325: 
1326:         LOCAL loc_lSucesso, loc_nRec
1327:         loc_lSucesso = .F.
1328: 
1329:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1330:             RETURN .F.
1331:         ENDIF
1332: 
1333:         TRY
1334:             SELECT cursor_4c_AcJ
1335:             IF !EOF("cursor_4c_AcJ")
1336:                 loc_nRec = RECNO("cursor_4c_AcJ")
1337:                 DELETE IN cursor_4c_AcJ
1338:                 GO TOP IN cursor_4c_AcJ
1339:                 IF m.loc_nRec <= RECCOUNT("cursor_4c_AcJ")
1340:                     GO m.loc_nRec IN cursor_4c_AcJ
1341:                 ENDIF
1342:             ENDIF
1343: 
1344:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1345:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
1346:             loc_lSucesso = .T.
1347:         CATCH TO loc_oErro
1348:             MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1349:             loc_lSucesso = .F.
1350:         ENDTRY
1351: 
1352:         RETURN loc_lSucesso
1353:     ENDPROC
1354: 
1355:     *--------------------------------------------------------------------------

*-- Linhas 1364 a 1484:
1364:     *--------------------------------------------------------------------------
1365:     PROCEDURE GrdUsuariosColumn1Valid()
1366:         LOCAL loc_oBusca, loc_cUsuario, loc_lResultado
1367:         loc_lResultado = .T.
1368: 
1369:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1370:             RETURN .T.
1371:         ENDIF
1372: 
1373:         TRY
1374:             SELECT cursor_4c_AcJ
1375:             loc_cUsuario = ALLTRIM(cursor_4c_AcJ.Usuars)
1376: 
1377:             IF !EMPTY(loc_cUsuario)
1378:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1379:                     "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuario, ;
1380:                     "Sele" + CHR(231) + CHR(227) + "o")
1381: 
1382:                 IF VARTYPE(loc_oBusca) = "O"
1383:                     IF loc_oBusca.this_lAchouRegistro
1384:                         IF USED("cursor_4c_BuscaUsu")
1385:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1386:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1387:                         ENDIF
1388:                     ELSE
1389:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1390:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1391:                         loc_oBusca.Show()
1392: 
1393:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1394:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1395:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1396:                         ELSE
1397:                             REPLACE Usuars WITH "" IN cursor_4c_AcJ
1398:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1399:                         ENDIF
1400:                     ENDIF
1401: 
1402:                     IF USED("cursor_4c_BuscaUsu")
1403:                         USE IN cursor_4c_BuscaUsu
1404:                     ENDIF
1405:                     loc_oBusca.Release()
1406:                 ENDIF
1407:             ELSE
1408:                 REPLACE NComps WITH "" IN cursor_4c_AcJ
1409:             ENDIF
1410: 
1411:             THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1412:         CATCH TO loc_oErro
1413:             MsgErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
1414:         ENDTRY
1415: 
1416:         RETURN loc_lResultado
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * GrdUsuariosColumn2When - Controla editabilidade da coluna Nome
1421:     * Editavel apenas em ALTERAR + quando Usuars da linha esta vazio
1422:     *--------------------------------------------------------------------------
1423:     PROCEDURE GrdUsuariosColumn2When()
1424:         IF THIS.this_cModoAtual != "ALTERAR"
1425:             RETURN .F.
1426:         ENDIF
1427:         IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
1428:             RETURN .F.
1429:         ENDIF
1430:         SELECT cursor_4c_AcJ
1431:         RETURN EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
1432:     ENDPROC
1433: 
1434:     *--------------------------------------------------------------------------
1435:     * GrdUsuariosColumn2Valid - Lookup de usuario pelo Nome na coluna NComps
1436:     *--------------------------------------------------------------------------
1437:     PROCEDURE GrdUsuariosColumn2Valid()
1438:         LOCAL loc_oBusca, loc_cNome, loc_lResultado
1439:         loc_lResultado = .T.
1440: 
1441:         IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
1442:             RETURN .T.
1443:         ENDIF
1444: 
1445:         TRY
1446:             SELECT cursor_4c_AcJ
1447:             loc_cNome = ALLTRIM(cursor_4c_AcJ.NComps)
1448: 
1449:             IF !EMPTY(loc_cNome)
1450:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1451:                     "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cNome, ;
1452:                     "Sele" + CHR(231) + CHR(227) + "o")
1453: 
1454:                 IF VARTYPE(loc_oBusca) = "O"
1455:                     IF loc_oBusca.this_lAchouRegistro
1456:                         IF USED("cursor_4c_BuscaUsu")
1457:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1458:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1459:                         ENDIF
1460:                     ELSE
1461:                         loc_oBusca.mAddColuna("NComps",   "", "Nome")
1462:                         loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1463:                         loc_oBusca.Show()
1464: 
1465:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1466:                             REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
1467:                             REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
1468:                         ELSE
1469:                             REPLACE NComps WITH "" IN cursor_4c_AcJ
1470:                         ENDIF
1471:                     ENDIF
1472: 
1473:                     IF USED("cursor_4c_BuscaUsu")
1474:                         USE IN cursor_4c_BuscaUsu
1475:                     ENDIF
1476:                     loc_oBusca.Release()
1477:                 ENDIF
1478: 
1479:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
1480:             ENDIF
1481:         CATCH TO loc_oErro
1482:             MsgErro("Erro ao validar nome:" + CHR(13) + loc_oErro.Message, "Erro")
1483:         ENDTRY
1484: 

*-- Linhas 1490 a 1504:
1490:     *--------------------------------------------------------------------------
1491:     PROCEDURE Destroy()
1492:         IF USED("cursor_4c_GradeJOB")
1493:             USE IN cursor_4c_GradeJOB
1494:         ENDIF
1495:         IF USED("cursor_4c_AcJ")
1496:             USE IN cursor_4c_AcJ
1497:         ENDIF
1498:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1499:             THIS.this_oBusinessObject = .NULL.
1500:         ENDIF
1501:         DODEFAULT()
1502:     ENDPROC
1503: 
1504: ENDDEFINE


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
                loc_cSQL = loc_cSQL + " AND (a.IClis LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR a.Razaos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
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


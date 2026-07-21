# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NRESULT_CODE, NFTP, LLRESULT, LCMESSAGE, I, FILE, NPOS, NRASCONN, NCONT, ZCT, NTPCONECT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LISTINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NRESULT_CODE, NFTP, LLRESULT, LCMESSAGE, I, FILE, NPOS, NRASCONN, NCONT, ZCT, NTPCONECT

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
  DeleteMark = .F.
  Column1.ControlSource = "tmpprog.file"
  Column2.ControlSource = "tmpprog.size"
  Column3.ControlSource = "tmpprog.local"
  Column4.ControlSource = "tmpprog.host"
  Column5.ControlSource = "tmpprog.status"
  MultiSelect = .T.
  MultiSelect = .T.
  MultiSelect = .T.
  MultiSelect = .T.
  DeleteMark = .F.
  Column1.ControlSource = "logftp.memo"
  ControlSource = "nProvedor"
	        INSERT INTO FtpServer VALUES ( ALLTRIM(lcFileName), ;
PROCEDURE deleteftpfile
DECLARE Integer FtpDeleteFile IN WinInet ;
	fResult = FtpDeleteFile(nftp, @lcRemoteFile)
	Insert into ftpServer (nome, Tipo, Tama, Data, Atri) Values (".","Diretório",str(0),DTOC(date()),"D")
#define ERROR_INTERNET_INSERT_CDROM               (ERROR_INTERNET_BASE + 53)
   CASE lnError =  ERROR_INTERNET_INSERT_CDROM                  
            lcMessage = "ERROR_INTERNET_INSERT_CDROM"
         lEraseRes = ThisForm.DeleteFtpFile(Thisform._direnvloc+plcfile)
	delete file &cFtpLocArq
	INSERT INTO ftpserver ;
Local zct, arqproc, lOk, arqproc, cArquivo_local, cArquivo_FTP, ARRECEB, ntrans, oObj, nselected, lnQtdArq
nselected = 0
              if oObj.Selected(i)
                 nselected = nselected + 1
       if nselected <= 0 
Local zct, arqproc, lOk, cArquivo_local, cArquivo_FTP, ARENV, oObj, ntrans, nselected, nEmpFail, lcEmps,;
nselected = 0
              if oObj.Selected(i)
                 nselected = nselected + 1
	    if nSelected <= 0

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2647 linhas total):

*-- Linhas 136 a 159:
136:     *==========================================================================
137:     PROTECTED PROCEDURE CriarCursores
138:         IF !USED("logftp")
139:             SELECT 0
140:             CREATE CURSOR logftp (memo C(254), cor C(1))
141:         ENDIF
142:         IF !USED("tmpprog")
143:             SELECT 0
144:             CREATE CURSOR tmpprog (file   C(254), ;
145:                                    Size   N(12),  ;
146:                                    Local  C(254), ;
147:                                    Host   C(254), ;
148:                                    Status C(50))
149:         ENDIF
150:     ENDPROC
151: 
152:     *==========================================================================
153:     * ConfigurarForm - Define propriedades visuais do form (background, fonte)
154:     *==========================================================================
155:     PROTECTED PROCEDURE ConfigurarForm
156:         LOCAL loc_cBackground
157:         loc_cBackground = gc_4c_CaminhoIcones + "new_background.jpg"
158:         WITH THIS
159:             .FontName  = "Tahoma"

*-- Linhas 335 a 353:
335:     *==========================================================================
336:     PROCEDURE Inf(par_cMensagem, par_cCor)
337:         IF USED("logftp")
338:             SELECT logftp
339:             APPEND BLANK
340:             REPLACE memo WITH par_cMensagem
341:             REPLACE cor  WITH par_cCor
342:             GO BOTTOM IN logftp
343:             IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
344:                 THIS.grd_4c_GrdInf.Refresh()
345:             ENDIF
346:         ENDIF
347:     ENDPROC
348: 
349:     *==========================================================================
350:     * ConfigurarPaginaLista - Orquestra criacao dos controles operacionais FTP.
351:     * Chamado de InicializarForm apos ConfigurarPageFrame.
352:     * Cria: botoes superiores, conteudo das paginas dos PageFrames,
353:     *        setas de transferencia individual, grid de log (grd_4c_GrdInf).

*-- Linhas 626 a 644:
626:             .ColumnWidths = "130,62,83"
627:             .ColumnLines  = .T.
628:             .RowSourceType = 0
629:             .MultiSelect  = .T.
630:             .FontName     = "Verdana"
631:             .FontSize     = 8
632:             .Visible      = .T.
633:         ENDWITH
634: 
635:         *-- PAGE 2: Recebidos (destino local dos arquivos recebidos do FTP)
636:         loc_oPage2 = loc_oPgLoc.Page2
637:         loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
638:         WITH loc_oPage2.txt_4c_Dirrecftp
639:             .Top      = 2
640:             .Left     = 2
641:             .Width    = 217
642:             .Height   = 23
643:             .Value    = ""
644:             .FontName = "Verdana"

*-- Linhas 674 a 692:
674:             .ColumnWidths = "135,58,82"
675:             .ColumnLines  = .T.
676:             .RowSourceType = 0
677:             .MultiSelect  = .T.
678:             .FontName     = "Verdana"
679:             .FontSize     = 8
680:             .Visible      = .T.
681:         ENDWITH
682: 
683:         BINDEVENT(loc_oPgLoc.Page1, "Activate", THIS, "PgLocPage1Activate")
684:         BINDEVENT(loc_oPgLoc.Page2, "Activate", THIS, "PgLocPage2Activate")
685: 
686:         THIS.TornarControlesVisiveis(loc_oPage1)
687:         THIS.TornarControlesVisiveis(loc_oPage2)
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * ConfigurarConteudoPgFtp - Popula as 2 paginas do pgf_4c_Ftp:
692:     *   Page1 ("Enviados")   = arquivos enviados / destino remoto FTP

*-- Linhas 752 a 770:
752:             .ColumnWidths = "135,58,82"
753:             .ColumnLines  = .T.
754:             .RowSourceType = 0
755:             .MultiSelect  = .T.
756:             .FontName     = "Verdana"
757:             .FontSize     = 8
758:             .Visible      = .T.
759:         ENDWITH
760: 
761:         *-- PAGE 2: A Receber (arquivos remotos FTP dispon?veis para baixar)
762:         loc_oPage2 = loc_oPgFtp.Page2
763:         loc_oPage2.AddObject("txt_4c_Direnvloc", "TextBox")
764:         WITH loc_oPage2.txt_4c_Direnvloc
765:             .Top      = 2
766:             .Left     = 2
767:             .Width    = 217
768:             .Height   = 23
769:             .Value    = ""
770:             .FontName = "Verdana"

*-- Linhas 799 a 817:
799:             .ColumnWidths = "130,62,83"
800:             .ColumnLines  = .T.
801:             .RowSourceType = 0
802:             .MultiSelect  = .T.
803:             .FontName     = "Verdana"
804:             .FontSize     = 8
805:             .Visible      = .T.
806:         ENDWITH
807: 
808:         BINDEVENT(loc_oPgFtp.Page1, "Activate", THIS, "PgFtpPage1Activate")
809:         BINDEVENT(loc_oPgFtp.Page2, "Activate", THIS, "PgFtpPage2Activate")
810: 
811:         THIS.TornarControlesVisiveis(loc_oPage1)
812:         THIS.TornarControlesVisiveis(loc_oPage2)
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
817:     * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):

*-- Linhas 882 a 900:
882:             .Height             = 52
883:             .ColumnCount        = 1
884:             .RecordMark         = .F.
885:             .DeleteMark         = .F.
886:             .GridLines          = 0
887:             .GridLineWidth      = 1
888:             .GridLineColor      = RGB(192, 192, 192)
889:             .HeaderHeight       = 0
890:             .HighlightStyle     = 2
891:             .HighlightBackColor = RGB(255, 255, 255)
892:             .ScrollBars         = 2
893:             .RowHeight          = 14
894:             .FontBold           = .T.
895:             .FontSize           = 8
896:             .ReadOnly           = .T.
897:             .TabStop            = .F.
898:             .RecordSource       = "logftp"
899:             .ForeColor          = RGB(0, 0, 0)
900:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 906 a 924:
906:             .FontSize       = 8
907:             .Alignment      = 0
908:             .Width          = 599
909:             .ControlSource  = "logftp.memo"
910:             .ReadOnly       = .T.
911:             .ForeColor      = RGB(0, 0, 0)
912:             .BackColor      = RGB(255, 255, 255)
913:             .Header1.FontBold  = .T.
914:             .Header1.FontName  = "Arial"
915:             .Header1.FontSize  = 8
916:             .Header1.Caption   = "Memo"
917:             .Header1.Alignment = 2
918:             .Header1.ForeColor = RGB(0, 0, 0)
919:             .Header1.BackColor = RGB(192, 192, 192)
920:         ENDWITH
921:         loc_oGrid.SetAll("DynamicForeColor", ;
922:             "iif(logftp.cor='R',RGB(255,255,255),iif(logftp.cor='G',RGB(0,128,0),iif(logftp.cor='B',RGB(0,0,255),RGB(0,255,255))))", ;
923:             "Column")
924:         loc_oGrid.SetAll("DynamicBackColor", ;

*-- Linhas 942 a 1014:
942:             .Height         = 114
943:             .ColumnCount    = 5
944:             .RecordMark     = .F.
945:             .DeleteMark     = .F.
946:             .GridLines      = 0
947:             .HeaderHeight   = 15
948:             .RowHeight      = 15
949:             .FontSize       = 8
950:             .ReadOnly       = .T.
951:             .TabStop        = .F.
952:             .RecordSource   = "tmpprog"
953:             .ToolTipText    = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
954:             .Visible        = .T.
955:         ENDWITH
956:         WITH loc_oGrid.Column1
957:             .FontSize      = 8
958:             .Width         = 81
959:             .ControlSource = "tmpprog.file"
960:             .ReadOnly      = .T.
961:             .ForeColor     = RGB(0, 0, 0)
962:             .BackColor     = RGB(255, 255, 255)
963:             .Header1.Caption = " Arquivo"
964:             .Header1.FontSize = 8
965:         ENDWITH
966:         WITH loc_oGrid.Column2
967:             .FontSize      = 8
968:             .Width         = 63
969:             .ControlSource = "tmpprog.size"
970:             .ReadOnly      = .T.
971:             .ForeColor     = RGB(0, 0, 0)
972:             .BackColor     = RGB(255, 255, 255)
973:             .Header1.Caption = " Tamanho"
974:             .Header1.FontSize = 8
975:         ENDWITH
976:         WITH loc_oGrid.Column3
977:             .FontSize      = 8
978:             .Width         = 107
979:             .ControlSource = "tmpprog.local"
980:             .ReadOnly      = .T.
981:             .ForeColor     = RGB(0, 0, 0)
982:             .BackColor     = RGB(255, 255, 255)
983:             .Header1.Caption = " Pasta Local "
984:             .Header1.FontSize = 8
985:         ENDWITH
986:         WITH loc_oGrid.Column4
987:             .FontSize      = 8
988:             .Width         = 136
989:             .ControlSource = "tmpprog.host"
990:             .ReadOnly      = .T.
991:             .ForeColor     = RGB(0, 0, 0)
992:             .BackColor     = RGB(255, 255, 255)
993:             .Header1.Caption = " Pasta Host"
994:             .Header1.FontSize = 8
995:         ENDWITH
996:         WITH loc_oGrid.Column5
997:             .FontSize      = 8
998:             .Width         = 207
999:             .ControlSource = "tmpprog.status"
1000:             .ReadOnly      = .T.
1001:             .ForeColor     = RGB(0, 0, 0)
1002:             .BackColor     = RGB(255, 255, 255)
1003:             .Header1.Caption = " Status"
1004:             .Header1.FontSize = 8
1005:         ENDWITH
1006:     ENDPROC
1007: 
1008:     *==========================================================================
1009:     * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
1010:     * e botao de conexao Dial-Up (cmdconect)
1011:     *==========================================================================
1012:     PROTECTED PROCEDURE ConfigurarRodape
1013:         *-- Label de progresso de operacoes (lblprog)
1014:         THIS.AddObject("lbl_4c_Lblprog", "Label")

*-- Linhas 1309 a 1327:
1309:                     FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
1310:                         loc_oObj.RemoveItem(loc_i)
1311:                     ENDFOR
1312:                     SELECT FtpServer
1313:                     SCAN
1314:                         loc_oObj.AddItem(ALLTRIM(FtpServer.lcFileName))
1315:                     ENDSCAN
1316:                     THIS.Inf("FTP: " + TRANSFORM(loc_oObj.ListCount) + ;
1317:                              " arquivo(s) encontrado(s)", "G")
1318:                 ENDIF
1319:             ELSE
1320:                 THIS.Inf("Falha ao listar diret" + CHR(243) + "rio FTP", "R")
1321:                 loc_lOk = .F.
1322:             ENDIF
1323:         ENDIF
1324: 
1325:         *-- [A ENVIAR PARA O HOST] Listagem local (arquivos para enviar)
1326:         IF !EMPTY(THIS.this_cDirEnvFtp)
1327:             loc_oObj = loc_oPgLoc.Page1.obj_4c_Lstenvftp

*-- Linhas 1378 a 1408:
1378:         TRY
1379:             FOR loc_i = 1 TO loc_nQtd
1380:                 loc_cArqLocal = ALLTRIM(loc_oObj.List(loc_i))
1381:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1382:                     LOOP
1383:                 ENDIF
1384:                 loc_cArqFtp = THIS.this_cDirRecLoc + loc_cArqLocal
1385:                 THIS.Inf("Transferindo " + loc_cArqLocal + " para FTP...", "B")
1386:                 IF THIS.RasftpPut(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1387:                                   THIS.this_cFtpPass, ;
1388:                                   THIS.this_cDirEnvFtp + loc_cArqLocal, ;
1389:                                   loc_cArqFtp)
1390:                     loc_nTrans = loc_nTrans + 1
1391:                     IF THIS.this_lDelLocal
1392:                         IF FILE(THIS.this_cDirEnvFtp + loc_cArqLocal)
1393:                             DELETE FILE (THIS.this_cDirEnvFtp + loc_cArqLocal)
1394:                         ENDIF
1395:                     ENDIF
1396:                     THIS.Inf("OK: " + loc_cArqLocal, "G")
1397:                 ELSE
1398:                     loc_nFalha = loc_nFalha + 1
1399:                     THIS.Inf("Falha: " + loc_cArqLocal, "R")
1400:                     loc_lOk = .F.
1401:                 ENDIF
1402:             ENDFOR
1403:             THIS.Inf("Transfer" + CHR(234) + "ncia: " + TRANSFORM(loc_nTrans) + ;
1404:                      " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
1405:                      IIF(loc_nFalha = 0, "G", "R"))
1406:         CATCH TO loc_oErro
1407:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1408:             loc_lOk = .F.

*-- Linhas 1434 a 1463:
1434:         TRY
1435:             FOR loc_i = 1 TO loc_nQtd
1436:                 loc_cArqFtp = ALLTRIM(loc_oObj.List(loc_i))
1437:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1438:                     LOOP
1439:                 ENDIF
1440:                 loc_cArqLocal = THIS.this_cDirRecFtp + loc_cArqFtp
1441:                 THIS.Inf("Recebendo " + loc_cArqFtp + " do FTP...", "B")
1442:                 IF THIS.RasftpGet(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1443:                                   THIS.this_cFtpPass, ;
1444:                                   THIS.this_cDirEnvLoc + loc_cArqFtp, ;
1445:                                   loc_cArqLocal)
1446:                     loc_nTrans = loc_nTrans + 1
1447:                     IF THIS.this_lDelHost
1448:                         THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1449:                                            THIS.this_cFtpPass, ;
1450:                                            THIS.this_cDirEnvLoc + loc_cArqFtp)
1451:                     ENDIF
1452:                     THIS.Inf("OK: " + loc_cArqFtp, "G")
1453:                 ELSE
1454:                     loc_nFalha = loc_nFalha + 1
1455:                     THIS.Inf("Falha: " + loc_cArqFtp, "R")
1456:                     loc_lOk = .F.
1457:                 ENDIF
1458:             ENDFOR
1459:             THIS.Inf("Recebimento: " + TRANSFORM(loc_nTrans) + ;
1460:                      " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
1461:                      IIF(loc_nFalha = 0, "G", "R"))
1462:         CATCH TO loc_oErro
1463:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")

*-- Linhas 1532 a 1570:
1532:                     IF USED("FtpServer")
1533:                         USE IN FtpServer
1534:                     ENDIF
1535:                     SELECT 0
1536:                     CREATE CURSOR FtpServer (lcFileName C(MAX_PATH), ;
1537:                                             lcAlterName C(14), ;
1538:                                             lnSize N(12), ;
1539:                                             ldWriteDate C(10), ;
1540:                                             lcAttributes C(2))
1541: 
1542:                     loc_nFind = FtpFindFirstFile(loc_nFtp, ;
1543:                                                  ALLTRIM(par_cDirFtp) + par_cMask, ;
1544:                                                  @loc_cStruct, 0, 0)
1545:                     IF loc_nFind = 0
1546:                         loc_lOk = .T.
1547:                     ELSE
1548:                         loc_lContinuar = .T.
1549:                         DO WHILE loc_lContinuar
1550:                             loc_cName = LEFT(SUBSTR(loc_cStruct, 45, MAX_PATH), ;
1551:                                             IIF(AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) > 0, ;
1552:                                                 AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) - 1, ;
1553:                                                 MAX_PATH))
1554:                             IF !EMPTY(ALLTRIM(loc_cName)) AND loc_cName <> "." AND loc_cName <> ".."
1555:                                 SELECT FtpServer
1556:                                 APPEND BLANK
1557:                                 REPLACE lcFileName WITH ALLTRIM(loc_cName)
1558:                             ENDIF
1559:                             loc_cStruct = SPACE(592)
1560:                             IF InternetFindNextFile(loc_nFind, @loc_cStruct) = 0
1561:                                 loc_lContinuar = .F.
1562:                             ENDIF
1563:                         ENDDO
1564:                         InternetCloseHandle(loc_nFind)
1565:                         loc_lOk = .T.
1566:                     ENDIF
1567:                     InternetCloseHandle(loc_nFtp)
1568:                 ENDIF
1569:                 InternetCloseHandle(loc_nInternet)
1570:             ENDIF

*-- Linhas 1634 a 1652:
1634:                     THIS.Inf("Falha na conex" + CHR(227) + "o FTP para GET", "R")
1635:                 ELSE
1636:                     IF FILE(par_cFtpLocArq)
1637:                         DELETE FILE (par_cFtpLocArq)
1638:                     ENDIF
1639:                     loc_lOk = (FtpGetFile(loc_nFtp, ;
1640:                                           par_cFtpRemArq, ;
1641:                                           par_cFtpLocArq, ;
1642:                                           .F., ;
1643:                                           FILE_ATTRIBUTE_NORMAL, ;
1644:                                           FTP_TRANSFER_TYPE_BINARY, 0) <> 0)
1645:                     IF !loc_lOk
1646:                         THIS.Inf("Falha ao baixar: " + par_cFtpRemArq, "R")
1647:                     ENDIF
1648:                     InternetCloseHandle(loc_nFtp)
1649:                 ENDIF
1650:                 InternetCloseHandle(loc_nInternet)
1651:             ENDIF
1652:         CATCH TO loc_oErro

*-- Linhas 1735 a 1796:
1735:     ENDPROC
1736: 
1737:     *==========================================================================
1738:     * DeleteFtpFile - Remove arquivo do servidor FTP
1739:     * par_cFtpLoc: endereco, par_cFtpUsu: usuario, par_cFtpSen: senha
1740:     * par_cFtpArq: caminho completo do arquivo no FTP
1741:     * Retorno: .T. se sucesso
1742:     *==========================================================================
1743:     PROCEDURE DeleteFtpFile(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpArq)
1744:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1745: 
1746:         loc_lOk      = .F.
1747:         loc_nInternet = 0
1748:         loc_nFtp      = 0
1749: 
1750:         #DEFINE INTERNET_OPEN_TYPE_DIRECT     1
1751:         #DEFINE INTERNET_DEFAULT_FTP_PORT    21
1752:         #DEFINE INTERNET_SERVICE_FTP          1
1753:         #DEFINE INTERNET_FLAG_PASSIVE  14217728
1754: 
1755:         TRY
1756:             DECLARE Integer InternetOpen IN wininet ;
1757:                 String  sAgent, Integer nAccessType, String sProxy, ;
1758:                 String  sProxyBypass, Integer dwFlags
1759: 
1760:             DECLARE Integer InternetConnect IN wininet ;
1761:                 Integer hInternet, String lpszServerName, ;
1762:                 Integer nServerPort, String lpszUserName, ;
1763:                 String  lpszPassword, Integer dwService, ;
1764:                 Integer dwFlags, Integer dwContext
1765: 
1766:             DECLARE Integer FtpDeleteFile IN wininet ;
1767:                 Integer hConnect, String lpszFileName
1768: 
1769:             DECLARE Integer InternetCloseHandle IN wininet ;
1770:                 Integer hInet
1771: 
1772:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1773:                                          CHR(0), CHR(0), 0)
1774:             IF loc_nInternet <> 0
1775:                 loc_nFtp = InternetConnect(loc_nInternet, par_cFtpLoc, ;
1776:                                            INTERNET_DEFAULT_FTP_PORT, ;
1777:                                            par_cFtpUsu, par_cFtpSen, ;
1778:                                            INTERNET_SERVICE_FTP, ;
1779:                                            INTERNET_FLAG_PASSIVE, 0)
1780:                 IF loc_nFtp <> 0
1781:                     loc_lOk = (FtpDeleteFile(loc_nFtp, par_cFtpArq) <> 0)
1782:                     IF !loc_lOk
1783:                         THIS.Inf("Falha ao remover FTP: " + par_cFtpArq, "R")
1784:                     ENDIF
1785:                     InternetCloseHandle(loc_nFtp)
1786:                 ENDIF
1787:                 InternetCloseHandle(loc_nInternet)
1788:             ENDIF
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP DEL")
1791:             loc_lOk = .F.
1792:         ENDTRY
1793:         RETURN loc_lOk
1794:     ENDPROC
1795: 
1796:     *==========================================================================

*-- Linhas 1897 a 1915:
1897:     *==========================================================================
1898:     * CrackFile - Analisa buffer WIN32_FIND_DATA e insere registro no cursor FtpServer
1899:     * par_cBuffer: buffer binario de 319 bytes (WIN32_FIND_DATA)
1900:     * Resultado: INSERT no cursor FtpServer (campos: nome, Tipo, Tama, Data, Atri)
1901:     *==========================================================================
1902:     PROCEDURE CrackFile(par_cBuffer)
1903:         LOCAL loc_cNomeArq, loc_cNomeAlt, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1904:         LOCAL loc_cAtributos, loc_cBuffTempo, loc_cDataEsc, loc_cTipo, loc_nAttr, loc_oErro
1905: 
1906:         #DEFINE LOC_MAX_PATH       260
1907:         #DEFINE LOC_MAXDWORD       4294967295
1908:         #DEFINE LOC_FILE_ATTR_DIR  16
1909: 
1910:         TRY
1911:             loc_cNomeArq = SUBSTR(par_cBuffer, 45, LOC_MAX_PATH)
1912:             loc_cNomeAlt = RIGHT(par_cBuffer, 14)
1913:             loc_cNomeArq = LEFT(loc_cNomeArq, AT(CHR(0), loc_cNomeArq) - 1)
1914:             loc_cNomeAlt = LEFT(loc_cNomeAlt, AT(CHR(0), loc_cNomeAlt) - 1)
1915: 

*-- Linhas 1934 a 1953:
1934:             loc_cDataEsc   = THIS.CrackDate(loc_cBuffTempo)
1935:             loc_cAtributos = THIS.CrackAttributes(LEFT(par_cBuffer, 4))
1936: 
1937:             SELECT FtpServer
1938:             INSERT INTO FtpServer VALUES (ALLTRIM(loc_cNomeArq), ;
1939:                                           ALLTRIM(loc_cTipo), ;
1940:                                           TRANSFORM(loc_nTamanho, "9999999999"), ;
1941:                                           loc_cDataEsc, ;
1942:                                           loc_cAtributos)
1943:         CATCH TO loc_oErro
1944:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackFile")
1945:         ENDTRY
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     * FileCtrlUp - Atualiza label de progresso lbl_4c_Lblprog
1950:     * Substitui FileControl (classe Framework nao disponivel no novo sistema)
1951:     * par_pStep  : numero (passo atual) OU logico (.T.=iniciar / .F.=ocultar)
1952:     * par_pTotal : total de passos (usado quando par_pStep eh numerico)
1953:     * par_pMessage: mensagem de status (opcional, tipo C)

*-- Linhas 1997 a 2047:
1997:             IF par_cStatus == "I"
1998:                 THIS.FileCtrlUp(.T., .T., "Iniciando a transfer" + CHR(234) + "ncia...")
1999:                 IF USED("tmpprog")
2000:                     SELECT tmpprog
2001:                     APPEND BLANK
2002:                     REPLACE file   WITH par_cArquivo
2003:                     REPLACE size   WITH par_nTamanho
2004:                     REPLACE local  WITH par_cLocal
2005:                     REPLACE host   WITH par_cHost
2006:                     REPLACE status WITH "0 bytes copiados, 0% completado"
2007:                 ENDIF
2008:             ENDIF
2009:             IF par_cStatus == "A"
2010:                 IF USED("tmpprog")
2011:                     SELECT tmpprog
2012:                     LOCATE FOR tmpprog.file = par_cArquivo
2013:                     IF FOUND()
2014:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2015:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2016:                                             "% completado"
2017:                         loc_cTiEst = THIS.SectToHour(INT(IIF(par_nTransf > 0, ;
2018:                                           (par_nTamanho - par_nTransf) * loc_nSec / par_nTransf, 0)))
2019:                         loc_cTiEla = THIS.SectToHour(SECONDS() - par_nSecIni)
2020:                         THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
2021:                                         100, ;
2022:                                         TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
2023:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2024:                             THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
2025:                                                           "   Tempo Estimado : " + loc_cTiEst
2026:                         ENDIF
2027:                     ENDIF
2028:                 ENDIF
2029:             ENDIF
2030:             IF par_cStatus == "C"
2031:                 IF USED("tmpprog")
2032:                     SELECT tmpprog
2033:                     LOCATE FOR tmpprog.file = par_cArquivo
2034:                     IF FOUND()
2035:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2036:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2037:                                             "% completado em " + THIS.SectToHour(par_nSec)
2038:                         THIS.FileCtrlUp(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 100), ;
2039:                                         100, ;
2040:                                         TRANSFORM(IIF(loc_nSec > 0, par_nBuffer / loc_nSec / 1000, 0), "999.99") + " Kbps")
2041:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2042:                             THIS.lbl_4c_Lblprog.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
2043:                                                           par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
2044:                         ENDIF
2045:                         THIS.Inf("Arquivo Transferido...", "B")
2046:                         THIS.FileCtrlUp(.F., .F., "")
2047:                         *-- Atualiza listbox: arquivo enviado local->FTP

*-- Linhas 2081 a 2099:
2081:                             loc_oObj.Refresh()
2082:                             IF THIS.this_lDelHost
2083:                                 THIS.Inf("Excluindo arquivo FTP " + THIS.this_cDirEnvLoc + par_cArquivo, "B")
2084:                                 IF THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2085:                                                       THIS.this_cFtpPass, ;
2086:                                                       THIS.this_cDirEnvLoc + par_cArquivo)
2087:                                     THIS.Inf("Arquivo FTP " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2088:                                     FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.ListCount
2089:                                         IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.List(loc_i, 1))) = UPPER(par_cArquivo)
2090:                                             THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.RemoveItem(loc_i)
2091:                                             EXIT
2092:                                         ENDIF
2093:                                     ENDFOR
2094:                                 ELSE
2095:                                     THIS.Inf("Falha na exclus" + CHR(227) + "o FTP " + par_cArquivo, "R")
2096:                                 ENDIF
2097:                             ENDIF
2098:                         ENDIF
2099:                     ENDIF

*-- Linhas 2216 a 2234:
2216:             CASE par_nErro = 12052
2217:                 loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
2218:             CASE par_nErro = 12053
2219:                 loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
2220:             CASE par_nErro = 12110
2221:                 loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
2222:             CASE par_nErro = 12111
2223:                 loc_cMensagem = "FTP_DROPPED"
2224:             CASE par_nErro = 12112
2225:                 loc_cMensagem = "FTP_NO_PASSIVE_MODE"
2226:             CASE par_nErro = 12157
2227:                 loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
2228:             CASE par_nErro = 12158
2229:                 loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
2230:             CASE par_nErro = 12159
2231:                 loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
2232:             CASE par_nErro = 12163
2233:                 loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
2234:             CASE par_nErro = 12164

*-- Linhas 2453 a 2471:
2453:                 loc_cArquivo = ALLTRIM(loc_oObj.List(loc_oObj.ListIndex, 1))
2454:                 IF !EMPTY(loc_cArquivo) AND MsgConfirma("Excluir arquivo remoto: " + ;
2455:                         loc_cArquivo + " ?", "Confirma" + CHR(231) + CHR(227) + "o")
2456:                     loc_lOk = THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2457:                                                   THIS.this_cFtpPass, loc_cArquivo)
2458:                     IF loc_lOk
2459:                         loc_oObj.RemoveItem(loc_oObj.ListIndex)
2460:                         THIS.Inf("Arquivo " + loc_cArquivo + " exclu" + CHR(237) + "do do FTP.", "B")
2461:                     ENDIF
2462:                 ENDIF
2463:             ELSE
2464:                 THIS.Inf("Selecione um arquivo remoto para excluir.", "R")
2465:             ENDIF
2466:         CATCH TO loc_oErro
2467:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2468:                     " PROC=" + loc_oErro.Procedure, "Erro")
2469:             loc_lOk = .F.
2470:         ENDTRY
2471:         RETURN loc_lOk

*-- Linhas 2609 a 2634:
2609:                 ENDFOR
2610:             ENDIF
2611:             IF USED("logftp")
2612:                 SELECT logftp
2613:                 ZAP
2614:                 IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
2615:                     THIS.grd_4c_GrdInf.Refresh()
2616:                 ENDIF
2617:             ENDIF
2618:             IF USED("tmpprog")
2619:                 SELECT tmpprog
2620:                 ZAP
2621:                 IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2622:                     THIS.grd_4c_GrdProc.Refresh()
2623:                 ENDIF
2624:             ENDIF
2625:             IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2626:                 THIS.lbl_4c_Lblprog.Caption = ""
2627:             ENDIF
2628:         CATCH TO loc_oErro
2629:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
2630:         ENDTRY
2631:     ENDPROC
2632: 
2633:     *==========================================================================
2634:     * CarregarLista - Recarrega listagens FTP e local (adaptador CRUD)


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*==============================================================================
* sigprftpBO.prg - Business Object para Transferencia FTP
* Data: 2026-07-16
* Form Operacional: Transferencia e Recebimento de Arquivos via FTP
* Tabelas: SigCdPam (parametros globais), SigCdEmp (config. por empresa)
*==============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *-- Configuracao de conexao FTP (carregados de SigCdPam/SigCdEmp)
    this_cTpConnect  = ""    && Tipo de conexao: "D"=Dial-Up, "B"=Broadband/Direto
    this_cFtpAdd     = ""    && Endereco do servidor FTP
    this_cFtpUser    = ""    && Usuario FTP
    this_cFtpPass    = ""    && Senha FTP
    this_cDirEnvFtp  = ""    && Dir local de origem para envio ao FTP (_direnvftp)
    this_cDirRecFtp  = ""    && Dir local de destino ao receber do FTP (_dirrecftp)
    this_cDirEnvLoc  = ""    && Dir remoto FTP de origem para recebimento (_direnvloc)
    this_cDirRecLoc  = ""    && Dir remoto FTP de destino para envio (_dirrecloc)
    this_lDelLocal   = .F.   && Excluir arquivo local apos transferencia
    this_lDelHost    = .F.   && Excluir arquivo no FTP apos recebimento
    this_cTpEnv      = ""    && Mascara de arquivos para envio (ex: "*.*")
    this_cTpRec      = ""    && Mascara de arquivos para recebimento (ex: "*.*")
    this_nTpConect   = 0     && Tipo execucao: 0=manual, 1=auto-envio, 2=auto-recebimento

    *-- Parametros globais do sistema (SigCdPam)
    this_cTpTrans    = ""    && tptrans    char(6)  - Tipo de transacao
    this_cEmpMasters = ""    && empmasters char(3)  - Empresa master
    this_cGruMccrs   = ""    && grumccrs   char(10) - Grupo Mercosul
    this_cConMccrs   = ""    && conmccrs   char(10) - Conta Mercosul
    this_cVendNts    = ""    && vendnts    char(10) - Vendas NTS

    *-- Configuracao FTP da empresa (SigCdEmp)
    this_cTpConexaoEmp = ""  && tpconexao  char(1)  - Tipo de conexao da empresa
    this_cFtpAddEmp    = ""  && ftpend     char(50) - Endereco FTP da empresa
    this_cFtpUserEmp   = ""  && ftpusuario char(50) - Usuario FTP da empresa
    this_cFtpPassEmp   = ""  && ftpsenha   char(20) - Senha FTP da empresa (criptografada)
    this_cDriveTs      = ""  && drivets    char(60) - Drive/dir local de envio para FTP
    this_cDriveLs      = ""  && drivels    char(60) - Drive/dir local de recebimento do FTP
    this_cDirFtpTs     = ""  && dirftpts   char(60) - Diretorio remoto FTP de destino (envio)
    this_cDirFtpLs     = ""  && dirftpls   char(60) - Diretorio remoto FTP de origem (recebimento)
    this_lLocDel       = .F. && locdel     bit      - Excluir local apos transferencia
    this_lFtpDel       = .F. && ftpdel     bit      - Excluir do FTP apos recebimento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPam"
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cTpTrans    = TratarNulo(TpTrans,    "C")
                    THIS.this_cEmpMasters = TratarNulo(EmpMasters, "C")
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs,   "C")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs,   "C")
                    THIS.this_cVendNts    = TratarNulo(VendNts,    "C")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema (SigCdPam) n" + CHR(227) + "o encontrados"
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoEmpresa - Carrega config FTP de SigCdEmp
    * par_cCodEmp: codigo da empresa (Cemps)
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracaoEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpConexao, FtpEnd, FtpUsuario, FtpSenha, " + ;
                       "DriveTs, DriveLs, DirFtpTs, DirFtpLs, " + ;
                       "LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(par_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                    THIS.CarregarDoCursor("cursor_4c_Emp")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cCodEmp) + ;
                                              " n" + CHR(227) + "o cadastrada"
                ENDIF
                IF USED("cursor_4c_Emp")
                    USE IN cursor_4c_Emp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdEmp"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega config FTP do cursor SigCdEmp para this_*
    * par_cAliasCursor: nome do cursor com dados de SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTpConexaoEmp = TratarNulo(TpConexao,  "C")
                THIS.this_cFtpAddEmp    = TratarNulo(FtpEnd,     "C")
                THIS.this_cFtpUserEmp   = TratarNulo(FtpUsuario, "C")
                THIS.this_cFtpPassEmp   = TratarNulo(FtpSenha,   "C")
                THIS.this_cDriveTs      = TratarNulo(DriveTs,    "C")
                THIS.this_cDriveLs      = TratarNulo(DriveLs,    "C")
                THIS.this_cDirFtpTs     = TratarNulo(DirFtpTs,   "C")
                THIS.this_cDirFtpLs     = TratarNulo(DirFtpLs,   "C")
                THIS.this_lLocDel       = IIF(VARTYPE(LocDel) = "L", LocDel, .F.)
                THIS.this_lFtpDel       = IIF(VARTYPE(FtpDel) = "L", FtpDel, .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel (form operacional sem CRUD direto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (form operacional - sem INSERT em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (form operacional - sem UPDATE em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

ENDDEFINE


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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2654 linhas total):

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

*-- Linhas 338 a 356:
338:     *==========================================================================
339:     PROCEDURE Inf(par_cMensagem, par_cCor)
340:         IF USED("logftp")
341:             SELECT logftp
342:             APPEND BLANK
343:             REPLACE memo WITH par_cMensagem
344:             REPLACE cor  WITH par_cCor
345:             GO BOTTOM IN logftp
346:             IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
347:                 THIS.grd_4c_GrdInf.Refresh()
348:             ENDIF
349:         ENDIF
350:     ENDPROC
351: 
352:     *==========================================================================
353:     * ConfigurarPaginaLista - Orquestra criacao dos controles operacionais FTP.
354:     * Chamado de InicializarForm apos ConfigurarPageFrame.
355:     * Cria: botoes superiores, conteudo das paginas dos PageFrames,
356:     *        setas de transferencia individual, grid de log (grd_4c_GrdInf).

*-- Linhas 629 a 647:
629:             .ColumnWidths = "130,62,83"
630:             .ColumnLines  = .T.
631:             .RowSourceType = 0
632:             .MultiSelect  = .T.
633:             .FontName     = "Verdana"
634:             .FontSize     = 8
635:             .Visible      = .T.
636:         ENDWITH
637: 
638:         *-- PAGE 2: Recebidos (destino local dos arquivos recebidos do FTP)
639:         loc_oPage2 = loc_oPgLoc.Page2
640:         loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
641:         WITH loc_oPage2.txt_4c_Dirrecftp
642:             .Top      = 2
643:             .Left     = 2
644:             .Width    = 217
645:             .Height   = 23
646:             .Value    = ""
647:             .FontName = "Verdana"

*-- Linhas 677 a 695:
677:             .ColumnWidths = "135,58,82"
678:             .ColumnLines  = .T.
679:             .RowSourceType = 0
680:             .MultiSelect  = .T.
681:             .FontName     = "Verdana"
682:             .FontSize     = 8
683:             .Visible      = .T.
684:         ENDWITH
685: 
686:         BINDEVENT(loc_oPgLoc.Page1, "Activate", THIS, "PgLocPage1Activate")
687:         BINDEVENT(loc_oPgLoc.Page2, "Activate", THIS, "PgLocPage2Activate")
688: 
689:         THIS.TornarControlesVisiveis(loc_oPage1)
690:         THIS.TornarControlesVisiveis(loc_oPage2)
691:     ENDPROC
692: 
693:     *==========================================================================
694:     * ConfigurarConteudoPgFtp - Popula as 2 paginas do pgf_4c_Ftp:
695:     *   Page1 ("Enviados")   = arquivos enviados / destino remoto FTP

*-- Linhas 755 a 773:
755:             .ColumnWidths = "135,58,82"
756:             .ColumnLines  = .T.
757:             .RowSourceType = 0
758:             .MultiSelect  = .T.
759:             .FontName     = "Verdana"
760:             .FontSize     = 8
761:             .Visible      = .T.
762:         ENDWITH
763: 
764:         *-- PAGE 2: A Receber (arquivos remotos FTP dispon?veis para baixar)
765:         loc_oPage2 = loc_oPgFtp.Page2
766:         loc_oPage2.AddObject("txt_4c_Direnvloc", "TextBox")
767:         WITH loc_oPage2.txt_4c_Direnvloc
768:             .Top      = 2
769:             .Left     = 2
770:             .Width    = 217
771:             .Height   = 23
772:             .Value    = ""
773:             .FontName = "Verdana"

*-- Linhas 802 a 820:
802:             .ColumnWidths = "130,62,83"
803:             .ColumnLines  = .T.
804:             .RowSourceType = 0
805:             .MultiSelect  = .T.
806:             .FontName     = "Verdana"
807:             .FontSize     = 8
808:             .Visible      = .T.
809:         ENDWITH
810: 
811:         BINDEVENT(loc_oPgFtp.Page1, "Activate", THIS, "PgFtpPage1Activate")
812:         BINDEVENT(loc_oPgFtp.Page2, "Activate", THIS, "PgFtpPage2Activate")
813: 
814:         THIS.TornarControlesVisiveis(loc_oPage1)
815:         THIS.TornarControlesVisiveis(loc_oPage2)
816:     ENDPROC
817: 
818:     *==========================================================================
819:     * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
820:     * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):

*-- Linhas 885 a 903:
885:             .Height             = 52
886:             .ColumnCount        = 1
887:             .RecordMark         = .F.
888:             .DeleteMark         = .F.
889:             .GridLines          = 0
890:             .GridLineWidth      = 1
891:             .GridLineColor      = RGB(192, 192, 192)
892:             .HeaderHeight       = 0
893:             .HighlightStyle     = 2
894:             .HighlightBackColor = RGB(255, 255, 255)
895:             .ScrollBars         = 2
896:             .RowHeight          = 14
897:             .FontBold           = .T.
898:             .FontSize           = 8
899:             .ReadOnly           = .T.
900:             .TabStop            = .F.
901:             .RecordSource       = "logftp"
902:             .ForeColor          = RGB(0, 0, 0)
903:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 909 a 927:
909:             .FontSize       = 8
910:             .Alignment      = 0
911:             .Width          = 599
912:             .ControlSource  = "logftp.memo"
913:             .ReadOnly       = .T.
914:             .ForeColor      = RGB(0, 0, 0)
915:             .BackColor      = RGB(255, 255, 255)
916:             .Header1.FontBold  = .T.
917:             .Header1.FontName  = "Arial"
918:             .Header1.FontSize  = 8
919:             .Header1.Caption   = "Memo"
920:             .Header1.Alignment = 2
921:             .Header1.ForeColor = RGB(0, 0, 0)
922:             .Header1.BackColor = RGB(192, 192, 192)
923:         ENDWITH
924:         loc_oGrid.SetAll("DynamicForeColor", ;
925:             "iif(logftp.cor='R',RGB(255,255,255),iif(logftp.cor='G',RGB(0,128,0),iif(logftp.cor='B',RGB(0,0,255),RGB(0,255,255))))", ;
926:             "Column")
927:         loc_oGrid.SetAll("DynamicBackColor", ;

*-- Linhas 945 a 1017:
945:             .Height         = 114
946:             .ColumnCount    = 5
947:             .RecordMark     = .F.
948:             .DeleteMark     = .F.
949:             .GridLines      = 0
950:             .HeaderHeight   = 15
951:             .RowHeight      = 15
952:             .FontSize       = 8
953:             .ReadOnly       = .T.
954:             .TabStop        = .F.
955:             .RecordSource   = "tmpprog"
956:             .ToolTipText    = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
957:             .Visible        = .T.
958:         ENDWITH
959:         WITH loc_oGrid.Column1
960:             .FontSize      = 8
961:             .Width         = 81
962:             .ControlSource = "tmpprog.file"
963:             .ReadOnly      = .T.
964:             .ForeColor     = RGB(0, 0, 0)
965:             .BackColor     = RGB(255, 255, 255)
966:             .Header1.Caption = "Arquivo"
967:             .Header1.FontSize = 8
968:         ENDWITH
969:         WITH loc_oGrid.Column2
970:             .FontSize      = 8
971:             .Width         = 63
972:             .ControlSource = "tmpprog.size"
973:             .ReadOnly      = .T.
974:             .ForeColor     = RGB(0, 0, 0)
975:             .BackColor     = RGB(255, 255, 255)
976:             .Header1.Caption = "Tamanho"
977:             .Header1.FontSize = 8
978:         ENDWITH
979:         WITH loc_oGrid.Column3
980:             .FontSize      = 8
981:             .Width         = 107
982:             .ControlSource = "tmpprog.local"
983:             .ReadOnly      = .T.
984:             .ForeColor     = RGB(0, 0, 0)
985:             .BackColor     = RGB(255, 255, 255)
986:             .Header1.Caption = "Pasta Local"
987:             .Header1.FontSize = 8
988:         ENDWITH
989:         WITH loc_oGrid.Column4
990:             .FontSize      = 8
991:             .Width         = 136
992:             .ControlSource = "tmpprog.host"
993:             .ReadOnly      = .T.
994:             .ForeColor     = RGB(0, 0, 0)
995:             .BackColor     = RGB(255, 255, 255)
996:             .Header1.Caption = "Pasta Host"
997:             .Header1.FontSize = 8
998:         ENDWITH
999:         WITH loc_oGrid.Column5
1000:             .FontSize      = 8
1001:             .Width         = 207
1002:             .ControlSource = "tmpprog.status"
1003:             .ReadOnly      = .T.
1004:             .ForeColor     = RGB(0, 0, 0)
1005:             .BackColor     = RGB(255, 255, 255)
1006:             .Header1.Caption = "Status"
1007:             .Header1.FontSize = 8
1008:         ENDWITH
1009:     ENDPROC
1010: 
1011:     *==========================================================================
1012:     * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
1013:     * e botao de conexao Dial-Up (cmdconect)
1014:     *==========================================================================
1015:     PROTECTED PROCEDURE ConfigurarRodape
1016:         *-- Label de progresso de operacoes (lblprog)
1017:         THIS.AddObject("lbl_4c_Lblprog", "Label")

*-- Linhas 1312 a 1330:
1312:                     FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
1313:                         loc_oObj.RemoveItem(loc_i)
1314:                     ENDFOR
1315:                     SELECT FtpServer
1316:                     SCAN
1317:                         loc_oObj.AddItem(ALLTRIM(FtpServer.lcFileName))
1318:                     ENDSCAN
1319:                     THIS.Inf("FTP: " + TRANSFORM(loc_oObj.ListCount) + ;
1320:                              " arquivo(s) encontrado(s)", "G")
1321:                 ENDIF
1322:             ELSE
1323:                 THIS.Inf("Falha ao listar diret" + CHR(243) + "rio FTP", "R")
1324:                 loc_lOk = .F.
1325:             ENDIF
1326:         ENDIF
1327: 
1328:         *-- [A ENVIAR PARA O HOST] Listagem local (arquivos para enviar)
1329:         IF !EMPTY(THIS.this_cDirEnvFtp)
1330:             loc_oObj = loc_oPgLoc.Page1.obj_4c_Lstenvftp

*-- Linhas 1381 a 1411:
1381:         TRY
1382:             FOR loc_i = 1 TO loc_nQtd
1383:                 loc_cArqLocal = ALLTRIM(loc_oObj.List(loc_i))
1384:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1385:                     LOOP
1386:                 ENDIF
1387:                 loc_cArqFtp = THIS.this_cDirRecLoc + loc_cArqLocal
1388:                 THIS.Inf("Transferindo " + loc_cArqLocal + " para FTP...", "B")
1389:                 IF THIS.RasftpPut(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1390:                                   THIS.this_cFtpPass, ;
1391:                                   THIS.this_cDirEnvFtp + loc_cArqLocal, ;
1392:                                   loc_cArqFtp)
1393:                     loc_nTrans = loc_nTrans + 1
1394:                     IF THIS.this_lDelLocal
1395:                         IF FILE(THIS.this_cDirEnvFtp + loc_cArqLocal)
1396:                             DELETE FILE (THIS.this_cDirEnvFtp + loc_cArqLocal)
1397:                         ENDIF
1398:                     ENDIF
1399:                     THIS.Inf("OK: " + loc_cArqLocal, "G")
1400:                 ELSE
1401:                     loc_nFalha = loc_nFalha + 1
1402:                     THIS.Inf("Falha: " + loc_cArqLocal, "R")
1403:                     loc_lOk = .F.
1404:                 ENDIF
1405:             ENDFOR
1406:             THIS.Inf("Transfer" + CHR(234) + "ncia: " + TRANSFORM(loc_nTrans) + ;
1407:                      " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
1408:                      IIF(loc_nFalha = 0, "G", "R"))
1409:         CATCH TO loc_oErro
1410:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1411:             loc_lOk = .F.

*-- Linhas 1441 a 1470:
1441:         TRY
1442:             FOR loc_i = 1 TO loc_nQtd
1443:                 loc_cArqFtp = ALLTRIM(loc_oObj.List(loc_i))
1444:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1445:                     LOOP
1446:                 ENDIF
1447:                 loc_cArqLocal = THIS.this_cDirRecFtp + loc_cArqFtp
1448:                 THIS.Inf("Recebendo " + loc_cArqFtp + " do FTP...", "B")
1449:                 IF THIS.RasftpGet(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1450:                                   THIS.this_cFtpPass, ;
1451:                                   THIS.this_cDirEnvLoc + loc_cArqFtp, ;
1452:                                   loc_cArqLocal)
1453:                     loc_nTrans = loc_nTrans + 1
1454:                     IF THIS.this_lDelHost
1455:                         THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1456:                                            THIS.this_cFtpPass, ;
1457:                                            THIS.this_cDirEnvLoc + loc_cArqFtp)
1458:                     ENDIF
1459:                     THIS.Inf("OK: " + loc_cArqFtp, "G")
1460:                 ELSE
1461:                     loc_nFalha = loc_nFalha + 1
1462:                     THIS.Inf("Falha: " + loc_cArqFtp, "R")
1463:                     loc_lOk = .F.
1464:                 ENDIF
1465:             ENDFOR
1466:             THIS.Inf("Recebimento: " + TRANSFORM(loc_nTrans) + ;
1467:                      " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
1468:                      IIF(loc_nFalha = 0, "G", "R"))
1469:         CATCH TO loc_oErro
1470:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")

*-- Linhas 1539 a 1577:
1539:                     IF USED("FtpServer")
1540:                         USE IN FtpServer
1541:                     ENDIF
1542:                     SELECT 0
1543:                     CREATE CURSOR FtpServer (lcFileName C(MAX_PATH), ;
1544:                                             lcAlterName C(14), ;
1545:                                             lnSize N(12), ;
1546:                                             ldWriteDate C(10), ;
1547:                                             lcAttributes C(2))
1548: 
1549:                     loc_nFind = FtpFindFirstFile(loc_nFtp, ;
1550:                                                  ALLTRIM(par_cDirFtp) + par_cMask, ;
1551:                                                  @loc_cStruct, 0, 0)
1552:                     IF loc_nFind = 0
1553:                         loc_lOk = .T.
1554:                     ELSE
1555:                         loc_lContinuar = .T.
1556:                         DO WHILE loc_lContinuar
1557:                             loc_cName = LEFT(SUBSTR(loc_cStruct, 45, MAX_PATH), ;
1558:                                             IIF(AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) > 0, ;
1559:                                                 AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) - 1, ;
1560:                                                 MAX_PATH))
1561:                             IF !EMPTY(ALLTRIM(loc_cName)) AND loc_cName <> "." AND loc_cName <> ".."
1562:                                 SELECT FtpServer
1563:                                 APPEND BLANK
1564:                                 REPLACE lcFileName WITH ALLTRIM(loc_cName)
1565:                             ENDIF
1566:                             loc_cStruct = SPACE(592)
1567:                             IF InternetFindNextFile(loc_nFind, @loc_cStruct) = 0
1568:                                 loc_lContinuar = .F.
1569:                             ENDIF
1570:                         ENDDO
1571:                         InternetCloseHandle(loc_nFind)
1572:                         loc_lOk = .T.
1573:                     ENDIF
1574:                     InternetCloseHandle(loc_nFtp)
1575:                 ENDIF
1576:                 InternetCloseHandle(loc_nInternet)
1577:             ENDIF

*-- Linhas 1641 a 1659:
1641:                     THIS.Inf("Falha na conex" + CHR(227) + "o FTP para GET", "R")
1642:                 ELSE
1643:                     IF FILE(par_cFtpLocArq)
1644:                         DELETE FILE (par_cFtpLocArq)
1645:                     ENDIF
1646:                     loc_lOk = (FtpGetFile(loc_nFtp, ;
1647:                                           par_cFtpRemArq, ;
1648:                                           par_cFtpLocArq, ;
1649:                                           .F., ;
1650:                                           FILE_ATTRIBUTE_NORMAL, ;
1651:                                           FTP_TRANSFER_TYPE_BINARY, 0) <> 0)
1652:                     IF !loc_lOk
1653:                         THIS.Inf("Falha ao baixar: " + par_cFtpRemArq, "R")
1654:                     ENDIF
1655:                     InternetCloseHandle(loc_nFtp)
1656:                 ENDIF
1657:                 InternetCloseHandle(loc_nInternet)
1658:             ENDIF
1659:         CATCH TO loc_oErro

*-- Linhas 1742 a 1803:
1742:     ENDPROC
1743: 
1744:     *==========================================================================
1745:     * DeleteFtpFile - Remove arquivo do servidor FTP
1746:     * par_cFtpLoc: endereco, par_cFtpUsu: usuario, par_cFtpSen: senha
1747:     * par_cFtpArq: caminho completo do arquivo no FTP
1748:     * Retorno: .T. se sucesso
1749:     *==========================================================================
1750:     PROCEDURE DeleteFtpFile(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpArq)
1751:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1752: 
1753:         loc_lOk      = .F.
1754:         loc_nInternet = 0
1755:         loc_nFtp      = 0
1756: 
1757:         #DEFINE INTERNET_OPEN_TYPE_DIRECT     1
1758:         #DEFINE INTERNET_DEFAULT_FTP_PORT    21
1759:         #DEFINE INTERNET_SERVICE_FTP          1
1760:         #DEFINE INTERNET_FLAG_PASSIVE  14217728
1761: 
1762:         TRY
1763:             DECLARE Integer InternetOpen IN wininet ;
1764:                 String  sAgent, Integer nAccessType, String sProxy, ;
1765:                 String  sProxyBypass, Integer dwFlags
1766: 
1767:             DECLARE Integer InternetConnect IN wininet ;
1768:                 Integer hInternet, String lpszServerName, ;
1769:                 Integer nServerPort, String lpszUserName, ;
1770:                 String  lpszPassword, Integer dwService, ;
1771:                 Integer dwFlags, Integer dwContext
1772: 
1773:             DECLARE Integer FtpDeleteFile IN wininet ;
1774:                 Integer hConnect, String lpszFileName
1775: 
1776:             DECLARE Integer InternetCloseHandle IN wininet ;
1777:                 Integer hInet
1778: 
1779:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1780:                                          CHR(0), CHR(0), 0)
1781:             IF loc_nInternet <> 0
1782:                 loc_nFtp = InternetConnect(loc_nInternet, par_cFtpLoc, ;
1783:                                            INTERNET_DEFAULT_FTP_PORT, ;
1784:                                            par_cFtpUsu, par_cFtpSen, ;
1785:                                            INTERNET_SERVICE_FTP, ;
1786:                                            INTERNET_FLAG_PASSIVE, 0)
1787:                 IF loc_nFtp <> 0
1788:                     loc_lOk = (FtpDeleteFile(loc_nFtp, par_cFtpArq) <> 0)
1789:                     IF !loc_lOk
1790:                         THIS.Inf("Falha ao remover FTP: " + par_cFtpArq, "R")
1791:                     ENDIF
1792:                     InternetCloseHandle(loc_nFtp)
1793:                 ENDIF
1794:                 InternetCloseHandle(loc_nInternet)
1795:             ENDIF
1796:         CATCH TO loc_oErro
1797:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP DEL")
1798:             loc_lOk = .F.
1799:         ENDTRY
1800:         RETURN loc_lOk
1801:     ENDPROC
1802: 
1803:     *==========================================================================

*-- Linhas 1904 a 1922:
1904:     *==========================================================================
1905:     * CrackFile - Analisa buffer WIN32_FIND_DATA e insere registro no cursor FtpServer
1906:     * par_cBuffer: buffer binario de 319 bytes (WIN32_FIND_DATA)
1907:     * Resultado: INSERT no cursor FtpServer (campos: nome, Tipo, Tama, Data, Atri)
1908:     *==========================================================================
1909:     PROCEDURE CrackFile(par_cBuffer)
1910:         LOCAL loc_cNomeArq, loc_cNomeAlt, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1911:         LOCAL loc_cAtributos, loc_cBuffTempo, loc_cDataEsc, loc_cTipo, loc_nAttr, loc_oErro
1912: 
1913:         #DEFINE LOC_MAX_PATH       260
1914:         #DEFINE LOC_MAXDWORD       4294967295
1915:         #DEFINE LOC_FILE_ATTR_DIR  16
1916: 
1917:         TRY
1918:             loc_cNomeArq = SUBSTR(par_cBuffer, 45, LOC_MAX_PATH)
1919:             loc_cNomeAlt = RIGHT(par_cBuffer, 14)
1920:             loc_cNomeArq = LEFT(loc_cNomeArq, AT(CHR(0), loc_cNomeArq) - 1)
1921:             loc_cNomeAlt = LEFT(loc_cNomeAlt, AT(CHR(0), loc_cNomeAlt) - 1)
1922: 

*-- Linhas 1941 a 1960:
1941:             loc_cDataEsc   = THIS.CrackDate(loc_cBuffTempo)
1942:             loc_cAtributos = THIS.CrackAttributes(LEFT(par_cBuffer, 4))
1943: 
1944:             SELECT FtpServer
1945:             INSERT INTO FtpServer VALUES (ALLTRIM(loc_cNomeArq), ;
1946:                                           ALLTRIM(loc_cTipo), ;
1947:                                           TRANSFORM(loc_nTamanho, "9999999999"), ;
1948:                                           loc_cDataEsc, ;
1949:                                           loc_cAtributos)
1950:         CATCH TO loc_oErro
1951:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackFile")
1952:         ENDTRY
1953:     ENDPROC
1954: 
1955:     *==========================================================================
1956:     * FileCtrlUp - Atualiza label de progresso lbl_4c_Lblprog
1957:     * Substitui FileControl (classe Framework nao disponivel no novo sistema)
1958:     * par_pStep  : numero (passo atual) OU logico (.T.=iniciar / .F.=ocultar)
1959:     * par_pTotal : total de passos (usado quando par_pStep eh numerico)
1960:     * par_pMessage: mensagem de status (opcional, tipo C)

*-- Linhas 2004 a 2054:
2004:             IF par_cStatus == "I"
2005:                 THIS.FileCtrlUp(.T., .T., "Iniciando a transfer" + CHR(234) + "ncia...")
2006:                 IF USED("tmpprog")
2007:                     SELECT tmpprog
2008:                     APPEND BLANK
2009:                     REPLACE file   WITH par_cArquivo
2010:                     REPLACE size   WITH par_nTamanho
2011:                     REPLACE local  WITH par_cLocal
2012:                     REPLACE host   WITH par_cHost
2013:                     REPLACE status WITH "0 bytes copiados, 0% completado"
2014:                 ENDIF
2015:             ENDIF
2016:             IF par_cStatus == "A"
2017:                 IF USED("tmpprog")
2018:                     SELECT tmpprog
2019:                     LOCATE FOR tmpprog.file = par_cArquivo
2020:                     IF FOUND()
2021:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2022:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2023:                                             "% completado"
2024:                         loc_cTiEst = THIS.SectToHour(INT(IIF(par_nTransf > 0, ;
2025:                                           (par_nTamanho - par_nTransf) * loc_nSec / par_nTransf, 0)))
2026:                         loc_cTiEla = THIS.SectToHour(SECONDS() - par_nSecIni)
2027:                         THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
2028:                                         100, ;
2029:                                         TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
2030:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2031:                             THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
2032:                                                           "   Tempo Estimado : " + loc_cTiEst
2033:                         ENDIF
2034:                     ENDIF
2035:                 ENDIF
2036:             ENDIF
2037:             IF par_cStatus == "C"
2038:                 IF USED("tmpprog")
2039:                     SELECT tmpprog
2040:                     LOCATE FOR tmpprog.file = par_cArquivo
2041:                     IF FOUND()
2042:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2043:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2044:                                             "% completado em " + THIS.SectToHour(par_nSec)
2045:                         THIS.FileCtrlUp(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 100), ;
2046:                                         100, ;
2047:                                         TRANSFORM(IIF(loc_nSec > 0, par_nBuffer / loc_nSec / 1000, 0), "999.99") + " Kbps")
2048:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2049:                             THIS.lbl_4c_Lblprog.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
2050:                                                           par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
2051:                         ENDIF
2052:                         THIS.Inf("Arquivo Transferido...", "B")
2053:                         THIS.FileCtrlUp(.F., .F., "")
2054:                         *-- Atualiza listbox: arquivo enviado local->FTP

*-- Linhas 2088 a 2106:
2088:                             loc_oObj.Refresh()
2089:                             IF THIS.this_lDelHost
2090:                                 THIS.Inf("Excluindo arquivo FTP " + THIS.this_cDirEnvLoc + par_cArquivo, "B")
2091:                                 IF THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2092:                                                       THIS.this_cFtpPass, ;
2093:                                                       THIS.this_cDirEnvLoc + par_cArquivo)
2094:                                     THIS.Inf("Arquivo FTP " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2095:                                     FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.ListCount
2096:                                         IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.List(loc_i, 1))) = UPPER(par_cArquivo)
2097:                                             THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.RemoveItem(loc_i)
2098:                                             EXIT
2099:                                         ENDIF
2100:                                     ENDFOR
2101:                                 ELSE
2102:                                     THIS.Inf("Falha na exclus" + CHR(227) + "o FTP " + par_cArquivo, "R")
2103:                                 ENDIF
2104:                             ENDIF
2105:                         ENDIF
2106:                     ENDIF

*-- Linhas 2223 a 2241:
2223:             CASE par_nErro = 12052
2224:                 loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
2225:             CASE par_nErro = 12053
2226:                 loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
2227:             CASE par_nErro = 12110
2228:                 loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
2229:             CASE par_nErro = 12111
2230:                 loc_cMensagem = "FTP_DROPPED"
2231:             CASE par_nErro = 12112
2232:                 loc_cMensagem = "FTP_NO_PASSIVE_MODE"
2233:             CASE par_nErro = 12157
2234:                 loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
2235:             CASE par_nErro = 12158
2236:                 loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
2237:             CASE par_nErro = 12159
2238:                 loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
2239:             CASE par_nErro = 12163
2240:                 loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
2241:             CASE par_nErro = 12164

*-- Linhas 2460 a 2478:
2460:                 loc_cArquivo = ALLTRIM(loc_oObj.List(loc_oObj.ListIndex, 1))
2461:                 IF !EMPTY(loc_cArquivo) AND MsgConfirma("Excluir arquivo remoto: " + ;
2462:                         loc_cArquivo + " ?", "Confirma" + CHR(231) + CHR(227) + "o")
2463:                     loc_lOk = THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2464:                                                   THIS.this_cFtpPass, loc_cArquivo)
2465:                     IF loc_lOk
2466:                         loc_oObj.RemoveItem(loc_oObj.ListIndex)
2467:                         THIS.Inf("Arquivo " + loc_cArquivo + " exclu" + CHR(237) + "do do FTP.", "B")
2468:                     ENDIF
2469:                 ENDIF
2470:             ELSE
2471:                 THIS.Inf("Selecione um arquivo remoto para excluir.", "R")
2472:             ENDIF
2473:         CATCH TO loc_oErro
2474:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2475:                     " PROC=" + loc_oErro.Procedure, "Erro")
2476:             loc_lOk = .F.
2477:         ENDTRY
2478:         RETURN loc_lOk

*-- Linhas 2616 a 2641:
2616:                 ENDFOR
2617:             ENDIF
2618:             IF USED("logftp")
2619:                 SELECT logftp
2620:                 ZAP
2621:                 IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
2622:                     THIS.grd_4c_GrdInf.Refresh()
2623:                 ENDIF
2624:             ENDIF
2625:             IF USED("tmpprog")
2626:                 SELECT tmpprog
2627:                 ZAP
2628:                 IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2629:                     THIS.grd_4c_GrdProc.Refresh()
2630:                 ENDIF
2631:             ENDIF
2632:             IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2633:                 THIS.lbl_4c_Lblprog.Caption = ""
2634:             ENDIF
2635:         CATCH TO loc_oErro
2636:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
2637:         ENDTRY
2638:     ENDPROC
2639: 
2640:     *==========================================================================
2641:     * CarregarLista - Recarrega listagens FTP e local (adaptador CRUD)


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


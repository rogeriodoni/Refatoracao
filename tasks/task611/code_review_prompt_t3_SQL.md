# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NRESULT_CODE, NFTP, LLRESULT, LCMESSAGE, I, FILE, NPOS, NRASCONN, NCONT, ZCT, NTPCONECT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NPROVEDOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NRESULT_CODE, NFTP, LLRESULT, LCMESSAGE, I, FILE, NPOS, NRASCONN, NCONT, ZCT, NTPCONECT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ARQUIVO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NRESULT_CODE, NFTP, LLRESULT, LCMESSAGE, I, FILE, NPOS, NRASCONN, NCONT, ZCT, NTPCONECT

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2843 linhas total):

*-- Linhas 40 a 60:
40: *   Transferencia (Fase 7): VerificarArquivoFtp/EnviarArquivoFtp/
41: *                        ReceberArquivoFtp/RenomearArquivoFtp/ExcluirArquivoFtp
42: *                        (WinInet FtpOpenFile/FtpPutFile/FtpGetFile/
43: *                        FtpRenameFile/FtpDeleteFile - equivalentes a
44: *                        rasfile/rasftpput/rasftpget/renameftpfile/
45: *                        deleteftpfile do legado); Transferir/Receber agora
46: *                        percorrem lst_4c_EnvFtp/lst_4c_EnvLoc chamando essas
47: *                        rotinas arquivo a arquivo (equivalente a
48: *                        transfere/recebe); Processa grava o arquivo
49: *                        concluido em lst_4c_RecLoc/lst_4c_RecFtp e, quando
50: *                        this_lDelLocal/this_lDelHost estao ativos, apaga o
51: *                        arquivo de origem
52: *   Consolidacao (Fase 8): BOParaForm/FormParaBO transferem os quatro
53: *                        diretorios entre BO e tela (bloco ".direnvftp.Value =
54: *                        ThisForm._DirEnvFtp" do Init legado e o inverso);
55: *                        CarregarLista eh o ponto unico de recarga (FormParaBO
56: *                        -> MontaContainer -> repinta os dois grids);
57: *                        HabilitarCampos consolida o bloco de ".enabled" que o
58: *                        legado repete em cmdload.Click/transfere/recebe
59: *==============================================================================
60: * O QUE NAO SE APLICA A ESTE FORM (legado SEM CRUD - nao inventar superficie):

*-- Linhas 130 a 148:
130:         loc_lSucesso = .F.
131: 
132:         *-- Em modo teste: retornar sucesso sem criar controles UI nem
133:         *-- depender de SQLEXEC (SigCdPam/SigCdEmp podem nao existir no
134:         *-- ambiente de teste headless)
135:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
136:             RETURN .T.
137:         ENDIF
138: 
139:         TRY
140:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
141:             THIS.Caption = "Transfer" + CHR(234) + "ncia e Recebimento de arquivos via FTP"
142: 
143:             THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")
144:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
145:                 MsgErro("Falha ao criar sigprftpBO.", "InicializarForm")
146:             ELSE
147:                 IF !THIS.this_oBusinessObject.ResolverConfiguracaoFtp(go_4c_Sistema.cCodEmpresa)
148:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;

*-- Linhas 254 a 291:
254: 
255:     *==========================================================================
256:     * ConfigurarCursoresAuxiliares - Cria os cursores locais que sustentam os
257:     * grids de progresso (equivalente a "Create cursor tmpprog") e de log
258:     * (equivalente a "Create cursor Logftp") do Init legado. Campos foram
259:     * renomeados em relacao ao legado (ex.: "local" -> "pastalocal") apenas
260:     * para evitar colisao com palavras reservadas do VFP9 - sao cursores de
261:     * memoria, nao tabelas do PILAR 2.
262:     *==========================================================================
263:     PROTECTED PROCEDURE ConfigurarCursoresAuxiliares()
264:         IF USED("cursor_4c_Progresso")
265:             USE IN cursor_4c_Progresso
266:         ENDIF
267:         SET NULL ON
268:         CREATE CURSOR cursor_4c_Progresso (arquivo C(254), tamanho N(12), ;
269:             pastalocal C(254), pastahost C(254), statusoperacao C(50))
270:         SET NULL OFF
271: 
272:         IF USED("cursor_4c_Log")
273:             USE IN cursor_4c_Log
274:         ENDIF
275:         SET NULL ON
276:         CREATE CURSOR cursor_4c_Log (memo M, cor C(1))
277:         SET NULL OFF
278:     ENDPROC
279: 
280:     *==========================================================================
281:     * ConfigurarGrids - Cria os dois grids do form: GrdProc (progresso das
282:     * transferencias, ligado a cursor_4c_Progresso) e GrdInf (log de
283:     * mensagens, ligado a cursor_4c_Log), com Top/Left/Width/Height/fontes/
284:     * cores/headers fielmente transcritos do SCX legado
285:     *==========================================================================
286:     PROTECTED PROCEDURE ConfigurarGrids()
287:         THIS.AddObject("grd_4c_Progresso", "Grid")
288: 
289:         *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .ColumnN
290:         *-- dentro do mesmo WITH que ainda esta definindo o RecordSource
291:         *-- estoura 'Unknown member COLUMN1' porque as colunas nao existem

*-- Linhas 300 a 350:
300:             .Width        = 622
301:             .Height       = 114
302:             .FontSize     = 8
303:             .DeleteMark   = .F.
304:             .RecordMark   = .F.
305:             .GridLines    = 0
306:             .HeaderHeight = 15
307:             .RowHeight    = 15
308:             .ReadOnly     = .T.
309:             .ToolTipText  = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
310: 
311:             .Column1.ControlSource   = "cursor_4c_Progresso.arquivo"
312:             .Column1.Width           = 81
313:             .Column1.FontSize        = 8
314:             .Column1.ReadOnly        = .T.
315:             .Column1.Header1.Caption = "Arquivo"
316: 
317:             .Column2.ControlSource   = "cursor_4c_Progresso.tamanho"
318:             .Column2.Width           = 63
319:             .Column2.FontSize        = 8
320:             .Column2.ReadOnly        = .T.
321:             .Column2.Header1.Caption = "Tamanho"
322: 
323:             .Column3.ControlSource   = "cursor_4c_Progresso.pastalocal"
324:             .Column3.Width           = 107
325:             .Column3.FontSize        = 8
326:             .Column3.ReadOnly        = .T.
327:             .Column3.Header1.Caption = "Pasta Local"
328: 
329:             .Column4.ControlSource   = "cursor_4c_Progresso.pastahost"
330:             .Column4.Width           = 136
331:             .Column4.FontSize        = 8
332:             .Column4.ReadOnly        = .T.
333:             .Column4.Header1.Caption = "Pasta Host"
334: 
335:             .Column5.ControlSource   = "cursor_4c_Progresso.statusoperacao"
336:             .Column5.Width           = 207
337:             .Column5.FontSize        = 8
338:             .Column5.ReadOnly        = .T.
339:             .Column5.Header1.Caption = "Status"
340: 
341:             .Visible = .T.
342:         ENDWITH
343: 
344:         THIS.AddObject("grd_4c_Log", "Grid")
345: 
346:         *-- ColumnCount/RecordSource ficam FORA do WITH pelo mesmo motivo
347:         *-- do grd_4c_Progresso acima (regra GRID-WITH).
348:         THIS.grd_4c_Log.ColumnCount      = 1
349:         THIS.grd_4c_Log.RecordSourceType = 1
350:         THIS.grd_4c_Log.RecordSource     = "cursor_4c_Log"

*-- Linhas 356 a 386:
356:             .Height        = 52
357:             .FontBold      = .T.
358:             .FontSize      = 8
359:             .DeleteMark    = .F.
360:             .RecordMark    = .F.
361:             .GridLines     = 0
362:             .GridLineWidth = 1
363:             .HeaderHeight  = 0
364:             .RowHeight     = 14
365:             .ScrollBars    = 2
366:             .ReadOnly      = .T.
367:             .ForeColor     = RGB(0,0,0)
368:             .BackColor     = RGB(255,255,255)
369:             .GridLineColor = RGB(192,192,192)
370: 
371:             .Column1.ControlSource    = "cursor_4c_Log.memo"
372:             .Column1.Width            = 599
373:             .Column1.FontBold         = .T.
374:             .Column1.FontName         = "Arial"
375:             .Column1.FontSize         = 8
376:             .Column1.Alignment        = 0
377:             .Column1.ReadOnly         = .T.
378:             .Column1.ForeColor        = RGB(0,0,0)
379:             .Column1.BackColor        = RGB(255,255,255)
380:             .Column1.DynamicForeColor = "IIF(cursor_4c_Log.cor='R', RGB(255,255,255), IIF(cursor_4c_Log.cor='G', RGB(0,128,0), IIF(cursor_4c_Log.cor='B', RGB(0,0,255), RGB(0,255,255))))"
381:             .Column1.DynamicBackColor = "IIF(cursor_4c_Log.cor='R', RGB(255,0,0), RGB(255,255,255))"
382: 
383:             .Column1.Header1.FontBold  = .T.
384:             .Column1.Header1.FontName  = "Arial"
385:             .Column1.Header1.FontSize  = 8
386:             .Column1.Header1.Alignment = 2

*-- Linhas 610 a 628:
610:             .ColumnCount  = 3
611:             .ColumnWidths = "130,62,83"
612:             .ColumnLines  = .T.
613:             .MultiSelect  = .T.
614:             .FontName     = "Verdana"
615:             .FontSize     = 8
616:             .Visible      = .T.
617:         ENDWITH
618: 
619:         loc_oPag1.AddObject("txt_4c_DirEnvFtp", "TextBox")
620:         WITH loc_oPag1.txt_4c_DirEnvFtp
621:             .Top         = 2
622:             .Left        = 2
623:             .Width       = 217
624:             .Height      = 23
625:             .FontName    = "Verdana"
626:             .FontSize    = 8
627:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
628:             .Visible     = .T.

*-- Linhas 653 a 671:
653:             .ColumnCount  = 3
654:             .ColumnWidths = "135,58,82"
655:             .ColumnLines  = .T.
656:             .MultiSelect  = .T.
657:             .FontName     = "Verdana"
658:             .FontSize     = 8
659:             .Visible      = .T.
660:         ENDWITH
661: 
662:         loc_oPag2.AddObject("txt_4c_DirRecFtp", "TextBox")
663:         WITH loc_oPag2.txt_4c_DirRecFtp
664:             .Top         = 2
665:             .Left        = 2
666:             .Width       = 217
667:             .Height      = 23
668:             .FontName    = "Verdana"
669:             .FontSize    = 8
670:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
671:             .Visible     = .T.

*-- Linhas 729 a 747:
729:             .ColumnCount  = 3
730:             .ColumnWidths = "135,58,82"
731:             .ColumnLines  = .T.
732:             .MultiSelect  = .T.
733:             .FontName     = "Verdana"
734:             .FontSize     = 8
735:             .Visible      = .T.
736:         ENDWITH
737: 
738:         loc_oPag1.AddObject("txt_4c_DirRecLoc", "TextBox")
739:         WITH loc_oPag1.txt_4c_DirRecLoc
740:             .Top         = 2
741:             .Left        = 2
742:             .Width       = 217
743:             .Height      = 23
744:             .FontName    = "Verdana"
745:             .FontSize    = 8
746:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
747:             .Visible     = .T.

*-- Linhas 772 a 790:
772:             .ColumnCount  = 3
773:             .ColumnWidths = "130,62,83"
774:             .ColumnLines  = .T.
775:             .MultiSelect  = .T.
776:             .FontName     = "Verdana"
777:             .FontSize     = 8
778:             .Visible      = .T.
779:         ENDWITH
780: 
781:         loc_oPag2.AddObject("txt_4c_DirEnvLoc", "TextBox")
782:         WITH loc_oPag2.txt_4c_DirEnvLoc
783:             .Top         = 2
784:             .Left        = 2
785:             .Width       = 217
786:             .Height      = 23
787:             .FontName    = "Verdana"
788:             .FontSize    = 8
789:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
790:             .Visible     = .T.

*-- Linhas 840 a 858:
840:             .RowSourceType    = 5
841:             .RowSource        = "aProvedor"
842:             .ColumnCount      = 1
843:             .ControlSource    = "nProvedor"
844:             .FirstElement     = 1
845:             .FontName         = "Verdana"
846:             .FontSize         = 8
847:             .Visible          = .F.
848:         ENDWITH
849: 
850:         IF THIS.this_oBusinessObject.this_cTpConnect == "D"
851:             THIS.cbo_4c_Provedor.Visible = .T.
852: 
853:             IF THIS.RasConexao("aProvedor") = 0
854:                 RELEASE aProvedor
855:                 PUBLIC ARRAY aProvedor(1)
856:                 aProvedor(1) = ""
857:                 THIS.Inf("N" + CHR(227) + "o existem conex" + CHR(245) + "es DIAL-UP dispon" + CHR(237) + "veis...", "R")
858:                 MsgAviso("N" + CHR(227) + "o existem conex" + CHR(245) + "es dispon" + CHR(237) + "veis...", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 978 a 1004:
978:             RETURN
979:         ENDIF
980: 
981:         SELECT cursor_4c_Log
982:         APPEND BLANK
983:         REPLACE memo WITH par_cTexto, cor WITH par_cCor
984:         GO BOTTOM
985: 
986:         THIS.grd_4c_Log.Refresh()
987: 
988:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
989:             SELECT (loc_cAliasAnterior)
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * WordToC / CToWord - Conversao entre inteiro (4 bytes) e buffer de
995:     * caracteres usada pelas chamadas RAS/WinInet, equivalente aos metodos
996:     * homonimos do legado
997:     *==========================================================================
998:     PROTECTED PROCEDURE WordToC(par_nNumero)
999:         RETURN CHR(BITAND(255, par_nNumero)) + ;
1000:                CHR(BITAND(65280, par_nNumero) % 255) + ;
1001:                CHR(BITAND(16711680, par_nNumero) % 255) + ;
1002:                CHR(BITAND(4278190080, par_nNumero) % 255)
1003:     ENDPROC
1004: 

*-- Linhas 1211 a 1259:
1211:                         ENDIF
1212: 
1213:                         SET NULL ON
1214:                         CREATE CURSOR cursor_4c_FtpServer ( ;
1215:                             nome C(240), ;
1216:                             tipo C(10), ;
1217:                             tama C(10), ;
1218:                             data C(16), ;
1219:                             atri C(10))
1220:                         SET NULL OFF
1221: 
1222:                         INDEX ON nome TAG nome
1223:                         SET ORDER TO nome
1224: 
1225:                         IF loc_lManual
1226:                             INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1227:                                 VALUES (".", "Diret" + CHR(243) + "rio", STR(0), DTOC(DATE()), "D")
1228:                         ELSE
1229:                             THIS.CrackFile(loc_cStruct)
1230: 
1231:                             loc_nResult = 1
1232: 
1233:                             DO WHILE loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1234:                                 loc_cStruct     = SPACE(319)
1235:                                 loc_nResult     = InternetFindNextFile(loc_nHandle, @loc_cStruct)
1236:                                 loc_nResultCode = GetLastError()
1237: 
1238:                                 IF loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1239:                                     THIS.CrackFile(loc_cStruct)
1240:                                 ENDIF
1241:                             ENDDO
1242:                         ENDIF
1243: 
1244:                         SELECT cursor_4c_FtpServer
1245:                         GO TOP
1246:                     ENDIF
1247: 
1248:                     InternetCloseHandle(loc_nFtp)
1249:                     InternetCloseHandle(loc_nInternet)
1250:                 ENDIF
1251:             ENDIF
1252:         ENDIF
1253: 
1254:         RETURN loc_lSucesso
1255:     ENDPROC
1256: 
1257:     *==========================================================================
1258:     * CrackFile - Desmonta uma estrutura WIN32_FIND_DATA devolvida pelo
1259:     * WinInet e grava a linha correspondente em cursor_4c_FtpServer

*-- Linhas 1306 a 1324:
1306: 
1307:         loc_cAtributos = THIS.CrackAttributes(LEFT(par_cString, 4))
1308: 
1309:         INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1310:             VALUES (ALLTRIM(loc_cArquivo), ;
1311:                     ALLTRIM(loc_cTipo), ;
1312:                     TRANSFORM(loc_nTamanho, "9999999999"), ;
1313:                     loc_cDataGravacao, ;
1314:                     loc_cAtributos)
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * CrackDate - Converte um FILETIME (8 bytes) na data formatada dd/mm/aaaa
1319:     * (transcricao do PROCEDURE crackdate do legado, que desconsidera a hora)
1320:     *==========================================================================
1321:     PROTECTED PROCEDURE CrackDate(par_cBuffer)
1322:         LOCAL loc_cEntrada, loc_nResultado, loc_nDia, loc_nMes, loc_nAno, loc_cData
1323: 
1324:         #DEFINE BYTE_2_CD 256

*-- Linhas 1511 a 1529:
1511:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 52
1512:                 loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
1513:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 53
1514:                 loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
1515:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 110
1516:                 loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
1517:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 111
1518:                 loc_cMensagem = "FTP_DROPPED"
1519:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 112
1520:                 loc_cMensagem = "FTP_NO_PASSIVE_MODE"
1521:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 157
1522:                 loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
1523:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 158
1524:                 loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
1525:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 159
1526:                 loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
1527:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 163
1528:                 loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
1529:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 164

*-- Linhas 1612 a 1655:
1612: 
1613:         DO CASE
1614:             CASE par_cStatus == "I"
1615:                 SELECT cursor_4c_Progresso
1616:                 APPEND BLANK
1617:                 REPLACE arquivo        WITH par_cArquivo, ;
1618:                         tamanho        WITH par_nTamanho, ;
1619:                         pastalocal     WITH par_cPastaLocal, ;
1620:                         pastahost      WITH par_cPastaHost, ;
1621:                         statusoperacao WITH "0 bytes copiados, 0% completado"
1622: 
1623:             CASE par_cStatus == "A"
1624:                 SELECT cursor_4c_Progresso
1625:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1626: 
1627:                 IF FOUND()
1628:                     REPLACE statusoperacao WITH ;
1629:                         STR(par_nTransferido) + " bytes copiados, " + ;
1630:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado"
1631: 
1632:                     loc_cTempoEstimado  = THIS.SecToHour(INT(((par_nTamanho - par_nTransferido) * loc_nSegundos) / par_nTransferido))
1633:                     loc_cTempoDecorrido = THIS.SecToHour(SECONDS() - par_nSegIniciais)
1634: 
1635:                     THIS.lbl_4c_Progresso.Caption = "Tempo decorrido: " + loc_cTempoDecorrido + ;
1636:                         "   Tempo Estimado : " + loc_cTempoEstimado
1637:                 ENDIF
1638: 
1639:             CASE par_cStatus == "C"
1640:                 SELECT cursor_4c_Progresso
1641:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1642: 
1643:                 IF FOUND()
1644:                     REPLACE statusoperacao WITH ;
1645:                         STR(par_nTransferido) + " bytes copiados, " + ;
1646:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado em " + ;
1647:                         THIS.SecToHour(loc_nSegundos)
1648: 
1649:                     THIS.lbl_4c_Progresso.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
1650:                         par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
1651: 
1652:                     THIS.Inf("Arquivo Transferido...", "B")
1653: 
1654:                     *-- "Atualiza os listbox dos arquivos" do PROCEDURE
1655:                     *-- processa legado: registra o arquivo concluido na

*-- Linhas 1771 a 1798:
1771:                 MKDIR (loc_cPastaTemp)
1772:                 SET DEFAULT TO (loc_cPastaTemp)
1773: 
1774:                 SELECT cursor_4c_FtpServer
1775:                 SCAN
1776:                     =STRTOFILE("1", cursor_4c_FtpServer.nome)
1777:                 ENDSCAN
1778: 
1779:                 loc_nArquivosMascara = ADIR(loc_aArquivosMascara, ALLTRIM(THIS.this_oBusinessObject.this_cTpRec))
1780: 
1781:                 loc_nItem = 0
1782:                 FOR loc_nCont = 1 TO loc_nArquivosMascara
1783:                     SELECT cursor_4c_FtpServer
1784:                     LOCATE FOR ALLTRIM(UPPER(cursor_4c_FtpServer.nome)) = ALLTRIM(UPPER(loc_aArquivosMascara[loc_nCont, 1]))
1785:                     IF FOUND() AND SUBSTR(cursor_4c_FtpServer.tipo, 1, 1) == "A"
1786:                         loc_nItem = loc_nItem + 1
1787:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
1788:                             .AddItem(ALLTRIM(cursor_4c_FtpServer.nome), loc_nItem, 1)
1789:                             .AddListItem(cursor_4c_FtpServer.tama, loc_nItem, 2)
1790:                             .AddListItem(cursor_4c_FtpServer.data, loc_nItem, 3)
1791:                         ENDWITH
1792:                     ENDIF
1793:                 ENDFOR
1794: 
1795:                 *-- Apaga os arquivos ficticios e, se a pasta ficou vazia, a
1796:                 *-- propria pasta temporaria
1797:                 FOR loc_nCont = 1 TO ADIR(loc_aArquivosMascara)
1798:                     ERASE (loc_aArquivosMascara[loc_nCont, 1])

*-- Linhas 1986 a 2004:
1986: 
1987:     *==========================================================================
1988:     * ExcluirArquivoFtp - Apaga um arquivo no servidor FTP (equivalente ao
1989:     * PROCEDURE deleteftpfile do legado), tentando por ate 60 segundos.
1990:     * Usado por Processa quando this_lDelHost esta ativo.
1991:     *==========================================================================
1992:     PROTECTED FUNCTION ExcluirArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1993:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivo, loc_nResultado, ;
1994:             loc_lContinua, loc_tSegIni, loc_tSegFim
1995: 
1996:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_XF   1
1997:         #DEFINE INTERNET_DEFAULT_FTP_PORT_XF  21
1998:         #DEFINE INTERNET_SERVICE_FTP_XF        1
1999:         #DEFINE INTERNET_FLAG_PASSIVE_XF 14217728
2000: 
2001:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2002:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2003:             STRING lpszProxyBypass, LONG dwFlags
2004: 

*-- Linhas 2011 a 2029:
2011: 
2012:         DECLARE LONG GetLastError IN WIN32API
2013: 
2014:         DECLARE INTEGER FtpDeleteFile IN WinInet ;
2015:             INTEGER nConnect_Handle, STRING @lpcFileName
2016: 
2017:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_XF, "", "", 0)
2018:         IF loc_nInternet = 0
2019:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2020:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2021:             RETURN .F.
2022:         ENDIF
2023: 
2024:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_XF, ;
2025:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_XF, INTERNET_FLAG_PASSIVE_XF, 0)
2026:         IF loc_nFtp = 0
2027:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
2028:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2029:             InternetCloseHandle(loc_nInternet)

*-- Linhas 2036 a 2054:
2036:         loc_tSegIni    = DATETIME()
2037: 
2038:         DO WHILE loc_lContinua
2039:             loc_nResultado = FtpDeleteFile(loc_nFtp, @loc_cArquivo)
2040:             loc_tSegFim    = DATETIME()
2041:             loc_lContinua  = (!(loc_nResultado == 1) AND (loc_tSegFim - loc_tSegIni) < 60)
2042:         ENDDO
2043: 
2044:         InternetCloseHandle(loc_nFtp)
2045:         InternetCloseHandle(loc_nInternet)
2046: 
2047:         RETURN (loc_nResultado = 1)
2048:     ENDFUNC
2049: 
2050:     *==========================================================================
2051:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2052:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2053:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2054:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia

*-- Linhas 2226 a 2244:
2226:         *-- Renomeia o arquivo para temporario ate completar a transferencia
2227:         loc_cArquivoTemp = LEFT(par_cArquivoLocal, LEN(par_cArquivoLocal) - 3) + "ftp"
2228:         IF FILE(par_cArquivoLocal)
2229:             DELETE FILE (par_cArquivoLocal)
2230:         ENDIF
2231: 
2232:         loc_nSegIni = SECONDS()
2233:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), 99999, ;
2234:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
2235:             0, 0, 0, 0, "I")
2236: 
2237:         loc_lOk = (FtpGetFile(loc_nFtp, par_cArquivoRemoto, loc_cArquivoTemp, .F., ;
2238:             FILE_ATTRIBUTE_NORMAL_GF, FTP_TRANSFER_TYPE_BINARY_GF, 0) = 1)
2239: 
2240:         loc_nSegFim  = SECONDS()
2241:         loc_nTamanho = LEN(FILETOSTR(loc_cArquivoTemp))
2242: 
2243:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), loc_nTamanho, ;
2244:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;

*-- Linhas 2303 a 2321:
2303:         FOR loc_nPos = 1 TO loc_nQtd
2304:             DO CASE
2305:                 CASE par_cModo == "I"
2306:                     IF loc_oObj.Selected(loc_nPos)
2307:                         loc_nSelecionados = loc_nSelecionados + 1
2308:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2309:                     ELSE
2310:                         loc_aArquivos(loc_nPos) = ""
2311:                     ENDIF
2312:                 CASE par_cModo == "A"
2313:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2314:             ENDCASE
2315:         ENDFOR
2316: 
2317:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2318:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2319:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2320:             RETURN .F.
2321:         ENDIF

*-- Linhas 2391 a 2409:
2391:         FOR loc_nPos = 1 TO loc_nQtd
2392:             DO CASE
2393:                 CASE par_cModo == "I"
2394:                     IF loc_oObj.Selected(loc_nPos)
2395:                         loc_nSelecionados = loc_nSelecionados + 1
2396:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2397:                     ELSE
2398:                         loc_aArquivos(loc_nPos) = ""
2399:                     ENDIF
2400:                 CASE par_cModo == "A"
2401:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2402:             ENDCASE
2403:         ENDFOR
2404: 
2405:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2406:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2407:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2408:             RETURN .F.
2409:         ENDIF

*-- Linhas 2512 a 2530:
2512:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2513:     *
2514:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2515:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2516:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2517:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2518:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2519:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2520:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao
2521:     * comportamento a preservar. Sem edicao, o valor lido eh IDENTICO ao que
2522:     * BOParaForm escreveu (ja normalizado), entao o caminho normal nao muda.
2523:     *
2524:     * PROTECTED porque FormBase.FormParaBO eh PROTECTED (nao alargar escopo).
2525:     * Retorna .T. quando a configuracao lida da tela esta apta a transferir.
2526:     *==========================================================================
2527:     PROTECTED FUNCTION FormParaBO()
2528:         LOCAL loc_oPgLoc, loc_oPgFtp, loc_lOk, loc_cEnvFtp, loc_cRecFtp, ;
2529:             loc_cRecLoc, loc_cEnvLoc
2530: 

*-- Linhas 2607 a 2631:
2607:         *-- Grid de progresso (cursor_4c_Progresso) e grid de log
2608:         *-- (cursor_4c_Log): reposiciona e repinta os dois
2609:         IF USED("cursor_4c_Progresso")
2610:             SELECT cursor_4c_Progresso
2611:             GO TOP
2612:             THIS.grd_4c_Progresso.Refresh()
2613:         ENDIF
2614: 
2615:         IF USED("cursor_4c_Log")
2616:             SELECT cursor_4c_Log
2617:             GO BOTTOM
2618:             THIS.grd_4c_Log.Refresh()
2619:         ENDIF
2620: 
2621:         RETURN loc_lSucesso
2622:     ENDPROC
2623: 
2624:     *==========================================================================
2625:     * HabilitarCampos - Liga/desliga em bloco os controles de acao da tela.
2626:     * Consolida o bloco de ".enabled" que o legado repete em cmdload.Click
2627:     * (IF/ELSE), em transfere e em recebe:
2628:     *
2629:     *   ThisForm.Container1.enabled = .t.     && o legado deixa .t. nos dois
2630:     *   ThisForm.cmdtran.enabled    = <flag>  && ramos - transcrito como esta
2631:     *   ThisForm.cmdrec.enabled     = <flag>


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*============================================================================
* sigprftpBO.prg - Business Object para Transferencia e Recebimento de
*                   arquivos via FTP (form OPERACIONAL, sem CRUD proprio)
*
* Tabela de parametros globais : SigCdPam (PK: cidchaves char(20))
*   Colunas usadas: tptrans, empmasters, grumccrs, conmccrs, vendnts
* Tabela de configuracao/empresa: SigCdEmp (PK: cemps char(3))
*   Colunas usadas: cemps, tpconexao, ftpend, ftpusuario, ftpsenha,
*                    drivets, drivels, dirftpts, dirftpls, locdel, ftpdel
*
* Este BO e SOMENTE-LEITURA em relacao a SigCdPam/SigCdEmp: o form legado
* apenas consulta essas tabelas para resolver a configuracao de FTP da
* empresa (ou da empresa "master", quando SigCdPam.empmasters esta
* preenchido) - o comportamento padrao herdado de BusinessBase (recusar
* Inserir/Atualizar/ExecutarExclusao) ja e o correto para esta entidade.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos pelo Init do form legado (equivalentes as
    * propriedades ThisForm._TpEnv / ._TpRec / ._TpConnect / etc do SIGPRFTP)
    * Representam a configuracao RESOLVIDA que efetivamente comanda a
    * transferencia (combinacao dos parametros de chamada + fallback do
    * cadastro de empresa quando a chamada nao informa os dados).
    *==========================================================================
    this_cTpEnv         = "*.*"  && Mascara de arquivos para Envio (Local -> FTP)
    this_cTpRec         = "*.*"  && Mascara de arquivos para Recebimento (FTP -> Local)
    this_cTpConnect     = ""     && Tipo de conexao: "D"=Dial-Up, "B"=Banda Larga/Direta
    this_cFtpAdd        = ""     && Endereco do servidor FTP
    this_cFtpUser       = ""     && Usuario de acesso ao FTP
    this_cFtpPass       = ""     && Senha de acesso ao FTP (ja descriptografada)
    this_cDirEnvFtp     = ""     && Pasta LOCAL de onde os arquivos sao enviados ao FTP
    this_cDirRecFtp     = ""     && Pasta LOCAL onde os arquivos recebidos do FTP sao gravados
    this_cDirEnvLoc     = ""     && Pasta REMOTA (no FTP) onde os arquivos enviados sao gravados
    this_cDirRecLoc     = ""     && Pasta REMOTA (no FTP) de onde os arquivos sao recebidos
    this_lDelLocal      = .F.    && Exclui o arquivo local apos o envio ao FTP
    this_lDelHost       = .F.    && Exclui o arquivo do FTP apos o recebimento
    this_nTpConect      = 0      && 0=Nenhuma acao automatica, 1=Transfere automatico, 2=Recebe automatico
    this_lCaseSensitive = .F.    && Preserva caixa da senha de FTP (nao converte para minusculo)

    *==========================================================================
    * Propriedades de SigCdPam (parametros gerais do sistema) - carregadas
    * uma unica vez em BuscarParametros() nas proximas fases
    *==========================================================================
    this_cTpTrans    = ""    && char(6)  - Tipo de transferencia padrao do sistema
    this_cEmpMasters = ""    && char(3)  - Empresa "master" cuja config de FTP e usada
    this_cGruMccrs   = ""    && char(10) - Grupo padrao (uso do modulo de FTP/movimento)
    this_cConMccrs   = ""    && char(10) - Conta padrao (uso do modulo de FTP/movimento)
    this_cVendNts    = ""    && char(10) - Vendedor padrao (uso do modulo de FTP/movimento)

    *==========================================================================
    * Propriedades de SigCdEmp (configuracao de FTP da empresa consultada)
    *==========================================================================
    this_cCemps      = ""    && char(3)  - Codigo da empresa cuja config foi carregada
    this_cTpConexao  = ""    && char(1)  - Tipo de conexao cadastrado na empresa
    this_cFtpEnd     = ""    && char(50) - Endereco do servidor FTP cadastrado na empresa
    this_cFtpUsuario = ""    && char(20) - Usuario de FTP cadastrado na empresa
    this_cFtpSenha   = ""    && char(20) - Senha de FTP cadastrada na empresa (criptografada)
    this_cDrivets    = ""    && char(60) - Pasta local de envio cadastrada na empresa
    this_cDrivels    = ""    && char(60) - Pasta local de recebimento cadastrada na empresa
    this_cDirftpts   = ""    && char(60) - Pasta remota de recebimento cadastrada na empresa
    this_cDirftpls   = ""    && char(60) - Pasta remota de envio cadastrada na empresa
    this_lLocDel     = .F.   && bit      - Exclui arquivo local apos envio (config da empresa)
    this_lFtpDel     = .F.   && bit      - Exclui arquivo do FTP apos recebimento (config da empresa)

    *==========================================================================
    * Propriedades de controle/mensagens especificas deste BO
    *==========================================================================
    this_lConfigValida = .F.  && .T. quando a configuracao resolvida esta apta a transferir

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria para auditoria/identificacao do
    * registro de configuracao de empresa (SigCdEmp) atualmente carregado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCemps
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigCdEmp (config de FTP da
    * empresa) do cursor para as propriedades this_c*/this_l* do BO.
    * Equivalente ao bloco do Init legado que le "crftpemp" apos o
    * CursorQuery('SigCdEmp', 'crftpemp', 'Cemps', lcBusEmp).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCemps      = ALLTRIM(TratarNulo(cemps, ""))
        THIS.this_cTpConexao  = TratarNulo(tpconexao, "")
        THIS.this_cFtpEnd     = TratarNulo(ftpend, "")
        THIS.this_cFtpUsuario = TratarNulo(ftpusuario, "")
        THIS.this_cFtpSenha   = TratarNulo(ftpsenha, "")
        THIS.this_cDrivets    = TratarNulo(drivets, "")
        THIS.this_cDrivels    = TratarNulo(drivels, "")
        THIS.this_cDirftpts   = TratarNulo(dirftpts, "")
        THIS.this_cDirftpls   = TratarNulo(dirftpls, "")

        * Coluna bit chega ao VFP ora como Logico ora como Numerico
        * conforme o driver - testar VARTYPE antes de comparar (regra #13)
        IF VARTYPE(locdel) = "L"
            THIS.this_lLocDel = locdel
        ELSE
            THIS.this_lLocDel = (NVL(locdel, 0) = 1)
        ENDIF

        IF VARTYPE(ftpdel) = "L"
            THIS.this_lFtpDel = ftpdel
        ELSE
            THIS.this_lFtpDel = (NVL(ftpdel, 0) = 1)
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarParametrosSistema - Carrega a (unica) linha de parametros gerais
    * do sistema em SigCdPam, equivalente a:
    *   ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crftpParam', .f., .f.,
    *     'TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts')
    *==========================================================================
    FUNCTION BuscarParametrosSistema()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_FtpParam")
                USE IN cursor_4c_FtpParam
            ENDIF

            loc_cSQL = "SELECT TOP 1 TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpParam")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpParam") AND RECCOUNT("cursor_4c_FtpParam") > 0
                    SELECT cursor_4c_FtpParam
                    GO TOP
                    THIS.this_cTpTrans    = TratarNulo(TpTrans, "")
                    THIS.this_cEmpMasters = ALLTRIM(TratarNulo(EmpMasters, ""))
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs, "")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs, "")
                    THIS.this_cVendNts    = TratarNulo(VendNts, "")
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar par" + CHR(226) + "metros do sistema (SigCdPam)"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpParam")
            USE IN cursor_4c_FtpParam
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarConfiguracaoEmpresa - Carrega a configuracao de FTP cadastrada
    * para a empresa informada (SigCdEmp), equivalente a:
    *   ThisForm.PodataMgr.Cursorquery('SigCdEmp','crftpemp','Cemps',lcBusEmp)
    *==========================================================================
    FUNCTION BuscarConfiguracaoEmpresa(par_cCemps)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(par_cCemps)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FtpEmp")
                USE IN cursor_4c_FtpEmp
            ENDIF

            loc_cSQL = "SELECT Cemps, TpConexao, Ftpend, Ftpusuario, Ftpsenha, " + ;
                       "Drivets, Drivels, Dirftpts, Dirftpls, LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(par_cCemps), 3))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpEmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpEmp") AND RECCOUNT("cursor_4c_FtpEmp") > 0
                    SELECT cursor_4c_FtpEmp
                    GO TOP
                    THIS.CarregarDoCursor("cursor_4c_FtpEmp")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o cadastrada ... Opera" + CHR(231) + CHR(227) + "o Cancelada"
                    loc_lResultado = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de FTP da empresa"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpEmp")
            USE IN cursor_4c_FtpEmp
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ResolverConfiguracaoFtp - Orquestra a resolucao da configuracao efetiva
    * de FTP (parametros gerais + empresa "master" ou a propria empresa),
    * reproduzindo o bloco de PROCEDURE Init do form legado:
    *   lcBusEmp = Iif(!Empty(crftpparam.EmpMasters), crftpParam.EmpMasters, _Empr)
    *   ... carrega crftpemp e resolve _TpConnect/_FtpAdd/_FtpUser/_FtpPass/
    *       _DirEnvFtp/_DirRecFtp/_DirRecLoc/_DirEnvLoc/_DelLocal/_DelHost
    *
    * par_cCemps: codigo da empresa CORRENTE (equivalente a _Empr do legado -
    *             o form migrado deve passar go_4c_Sistema.cCodEmpresa)
    *==========================================================================
    FUNCTION ResolverConfiguracaoFtp(par_cCemps)
        LOCAL loc_lResultado, loc_cEmpresaBusca

        loc_lResultado = .F.
        THIS.this_lConfigValida = .F.

        IF !THIS.BuscarParametrosSistema()
            RETURN .F.
        ENDIF

        loc_cEmpresaBusca = IIF(!EMPTY(THIS.this_cEmpMasters), THIS.this_cEmpMasters, ALLTRIM(TratarNulo(par_cCemps, "")))

        IF !THIS.BuscarConfiguracaoEmpresa(loc_cEmpresaBusca)
            RETURN .F.
        ENDIF

        * Resolucao dos campos efetivos de conexao (equivalente ao trecho
        * "With ThisForm ... EndWith" do Init legado que copia crftpemp.*
        * para as propriedades _Tp*/_Ftp*/_Dir*/_Del* do form)
        THIS.this_cTpConnect = UPPER(ALLTRIM(THIS.this_cTpConexao))
        THIS.this_cFtpAdd    = LOWER(ALLTRIM(THIS.this_cFtpEnd))
        THIS.this_cFtpUser   = LOWER(ALLTRIM(THIS.this_cFtpUsuario))

        * fCriptografar: mesma funcao global do legado ja referenciada sem
        * wrapper proprio em SigPrScnBO.prg/sigtosenBO.prg (decodifica a
        * senha gravada no cadastro de empresa para uso efetivo no FTP)
        IF THIS.this_lCaseSensitive
            THIS.this_cFtpPass = ALLTRIM(fCriptografar(THIS.this_cFtpSenha))
        ELSE
            THIS.this_cFtpPass = LOWER(ALLTRIM(fCriptografar(THIS.this_cFtpSenha)))
        ENDIF

        THIS.this_cDirEnvFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivets)))
        THIS.this_cDirRecFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivels)))
        THIS.this_cDirRecLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpts)))
        THIS.this_cDirEnvLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpls)))
        THIS.this_lDelLocal  = THIS.this_lLocDel
        THIS.this_lDelHost   = THIS.this_lFtpDel

        * Mesma validacao do "Do Case" do Init legado (TpConnect invalido /
        * FtpAdd, FtpUser ou FtpPass vazios cancelam a operacao)
        loc_lResultado = INLIST(THIS.this_cTpConnect, "D", "B") AND ;
                          !EMPTY(THIS.this_cFtpAdd) AND ;
                          !EMPTY(THIS.this_cFtpUser) AND ;
                          !EMPTY(THIS.this_cFtpPass)

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Esta empresa n" + CHR(227) + "o possui uma configura" + CHR(231) + CHR(227) + "o correta de acesso " + CHR(224) + " FTP"
        ENDIF

        THIS.this_lConfigValida = loc_lResultado

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * NormalizarDiretorioRemoto - Garante barra "/" no final do caminho
    * remoto do FTP, equivalente a:
    *   iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir + "/")
    *==========================================================================
    PROTECTED FUNCTION NormalizarDiretorioRemoto(par_cDiretorio)
        IF EMPTY(par_cDiretorio) OR RIGHT(par_cDiretorio, 1) == "/"
            RETURN par_cDiretorio
        ENDIF

        RETURN par_cDiretorio + "/"
    ENDFUNC

ENDDEFINE


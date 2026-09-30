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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2829 linhas total):

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

*-- Linhas 254 a 374:
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
267:         CREATE CURSOR cursor_4c_Progresso (arquivo C(254), tamanho N(12), ;
268:             pastalocal C(254), pastahost C(254), statusoperacao C(50))
269: 
270:         IF USED("cursor_4c_Log")
271:             USE IN cursor_4c_Log
272:         ENDIF
273:         CREATE CURSOR cursor_4c_Log (memo M, cor C(1))
274:     ENDPROC
275: 
276:     *==========================================================================
277:     * ConfigurarGrids - Cria os dois grids do form: GrdProc (progresso das
278:     * transferencias, ligado a cursor_4c_Progresso) e GrdInf (log de
279:     * mensagens, ligado a cursor_4c_Log), com Top/Left/Width/Height/fontes/
280:     * cores/headers fielmente transcritos do SCX legado
281:     *==========================================================================
282:     PROTECTED PROCEDURE ConfigurarGrids()
283:         THIS.AddObject("grd_4c_Progresso", "Grid")
284:         WITH THIS.grd_4c_Progresso
285:             .Top          = 376
286:             .Left         = 89
287:             .Width        = 622
288:             .Height       = 114
289:             .ColumnCount  = 5
290:             .FontSize     = 8
291:             .DeleteMark   = .F.
292:             .RecordMark   = .F.
293:             .GridLines    = 0
294:             .HeaderHeight = 15
295:             .RowHeight    = 15
296:             .ReadOnly     = .T.
297:             .ToolTipText  = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
298: 
299:             .RecordSourceType = 1
300:             .RecordSource     = "cursor_4c_Progresso"
301: 
302:             .Column1.ControlSource   = "cursor_4c_Progresso.arquivo"
303:             .Column1.Width           = 81
304:             .Column1.FontSize        = 8
305:             .Column1.ReadOnly        = .T.
306:             .Column1.Header1.Caption = " Arquivo"
307: 
308:             .Column2.ControlSource   = "cursor_4c_Progresso.tamanho"
309:             .Column2.Width           = 63
310:             .Column2.FontSize        = 8
311:             .Column2.ReadOnly        = .T.
312:             .Column2.Header1.Caption = " Tamanho"
313: 
314:             .Column3.ControlSource   = "cursor_4c_Progresso.pastalocal"
315:             .Column3.Width           = 107
316:             .Column3.FontSize        = 8
317:             .Column3.ReadOnly        = .T.
318:             .Column3.Header1.Caption = " Pasta Local "
319: 
320:             .Column4.ControlSource   = "cursor_4c_Progresso.pastahost"
321:             .Column4.Width           = 136
322:             .Column4.FontSize        = 8
323:             .Column4.ReadOnly        = .T.
324:             .Column4.Header1.Caption = " Pasta Host"
325: 
326:             .Column5.ControlSource   = "cursor_4c_Progresso.statusoperacao"
327:             .Column5.Width           = 207
328:             .Column5.FontSize        = 8
329:             .Column5.ReadOnly        = .T.
330:             .Column5.Header1.Caption = " Status"
331: 
332:             .Visible = .T.
333:         ENDWITH
334: 
335:         THIS.AddObject("grd_4c_Log", "Grid")
336:         WITH THIS.grd_4c_Log
337:             .Top           = 323
338:             .Left          = 89
339:             .Width         = 622
340:             .Height        = 52
341:             .ColumnCount   = 1
342:             .FontBold      = .T.
343:             .FontSize      = 8
344:             .DeleteMark    = .F.
345:             .RecordMark    = .F.
346:             .GridLines     = 0
347:             .GridLineWidth = 1
348:             .HeaderHeight  = 0
349:             .RowHeight     = 14
350:             .ScrollBars    = 2
351:             .ReadOnly      = .T.
352:             .ForeColor     = RGB(0,0,0)
353:             .BackColor     = RGB(255,255,255)
354:             .GridLineColor = RGB(192,192,192)
355: 
356:             .RecordSourceType = 1
357:             .RecordSource     = "cursor_4c_Log"
358: 
359:             .Column1.ControlSource    = "cursor_4c_Log.memo"
360:             .Column1.Width            = 599
361:             .Column1.FontBold         = .T.
362:             .Column1.FontName         = "Arial"
363:             .Column1.FontSize         = 8
364:             .Column1.Alignment        = 0
365:             .Column1.ReadOnly         = .T.
366:             .Column1.ForeColor        = RGB(0,0,0)
367:             .Column1.BackColor        = RGB(255,255,255)
368:             .Column1.DynamicForeColor = "IIF(cursor_4c_Log.cor='R', RGB(255,255,255), IIF(cursor_4c_Log.cor='G', RGB(0,128,0), IIF(cursor_4c_Log.cor='B', RGB(0,0,255), RGB(0,255,255))))"
369:             .Column1.DynamicBackColor = "IIF(cursor_4c_Log.cor='R', RGB(255,0,0), RGB(255,255,255))"
370: 
371:             .Column1.Header1.FontBold  = .T.
372:             .Column1.Header1.FontName  = "Arial"
373:             .Column1.Header1.FontSize  = 8
374:             .Column1.Header1.Alignment = 2

*-- Linhas 598 a 616:
598:             .ColumnCount  = 3
599:             .ColumnWidths = "130,62,83"
600:             .ColumnLines  = .T.
601:             .MultiSelect  = .T.
602:             .FontName     = "Verdana"
603:             .FontSize     = 8
604:             .Visible      = .T.
605:         ENDWITH
606: 
607:         loc_oPag1.AddObject("txt_4c_DirEnvFtp", "TextBox")
608:         WITH loc_oPag1.txt_4c_DirEnvFtp
609:             .Top         = 2
610:             .Left        = 2
611:             .Width       = 217
612:             .Height      = 23
613:             .FontName    = "Verdana"
614:             .FontSize    = 8
615:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
616:             .Visible     = .T.

*-- Linhas 641 a 659:
641:             .ColumnCount  = 3
642:             .ColumnWidths = "135,58,82"
643:             .ColumnLines  = .T.
644:             .MultiSelect  = .T.
645:             .FontName     = "Verdana"
646:             .FontSize     = 8
647:             .Visible      = .T.
648:         ENDWITH
649: 
650:         loc_oPag2.AddObject("txt_4c_DirRecFtp", "TextBox")
651:         WITH loc_oPag2.txt_4c_DirRecFtp
652:             .Top         = 2
653:             .Left        = 2
654:             .Width       = 217
655:             .Height      = 23
656:             .FontName    = "Verdana"
657:             .FontSize    = 8
658:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
659:             .Visible     = .T.

*-- Linhas 717 a 735:
717:             .ColumnCount  = 3
718:             .ColumnWidths = "135,58,82"
719:             .ColumnLines  = .T.
720:             .MultiSelect  = .T.
721:             .FontName     = "Verdana"
722:             .FontSize     = 8
723:             .Visible      = .T.
724:         ENDWITH
725: 
726:         loc_oPag1.AddObject("txt_4c_DirRecLoc", "TextBox")
727:         WITH loc_oPag1.txt_4c_DirRecLoc
728:             .Top         = 2
729:             .Left        = 2
730:             .Width       = 217
731:             .Height      = 23
732:             .FontName    = "Verdana"
733:             .FontSize    = 8
734:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
735:             .Visible     = .T.

*-- Linhas 760 a 778:
760:             .ColumnCount  = 3
761:             .ColumnWidths = "130,62,83"
762:             .ColumnLines  = .T.
763:             .MultiSelect  = .T.
764:             .FontName     = "Verdana"
765:             .FontSize     = 8
766:             .Visible      = .T.
767:         ENDWITH
768: 
769:         loc_oPag2.AddObject("txt_4c_DirEnvLoc", "TextBox")
770:         WITH loc_oPag2.txt_4c_DirEnvLoc
771:             .Top         = 2
772:             .Left        = 2
773:             .Width       = 217
774:             .Height      = 23
775:             .FontName    = "Verdana"
776:             .FontSize    = 8
777:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
778:             .Visible     = .T.

*-- Linhas 828 a 846:
828:             .RowSourceType    = 5
829:             .RowSource        = "aProvedor"
830:             .ColumnCount      = 1
831:             .ControlSource    = "nProvedor"
832:             .FirstElement     = 1
833:             .FontName         = "Verdana"
834:             .FontSize         = 8
835:             .Visible          = .F.
836:         ENDWITH
837: 
838:         IF THIS.this_oBusinessObject.this_cTpConnect == "D"
839:             THIS.cbo_4c_Provedor.Visible = .T.
840: 
841:             IF THIS.RasConexao("aProvedor") = 0
842:                 RELEASE aProvedor
843:                 PUBLIC ARRAY aProvedor(1)
844:                 aProvedor(1) = ""
845:                 THIS.Inf("N" + CHR(227) + "o existem conex" + CHR(245) + "es DIAL-UP dispon" + CHR(237) + "veis...", "R")
846:                 MsgAviso("N" + CHR(227) + "o existem conex" + CHR(245) + "es dispon" + CHR(237) + "veis...", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 966 a 992:
966:             RETURN
967:         ENDIF
968: 
969:         SELECT cursor_4c_Log
970:         APPEND BLANK
971:         REPLACE memo WITH par_cTexto, cor WITH par_cCor
972:         GO BOTTOM
973: 
974:         THIS.grd_4c_Log.Refresh()
975: 
976:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
977:             SELECT (loc_cAliasAnterior)
978:         ENDIF
979:     ENDPROC
980: 
981:     *==========================================================================
982:     * WordToC / CToWord - Conversao entre inteiro (4 bytes) e buffer de
983:     * caracteres usada pelas chamadas RAS/WinInet, equivalente aos metodos
984:     * homonimos do legado
985:     *==========================================================================
986:     PROTECTED PROCEDURE WordToC(par_nNumero)
987:         RETURN CHR(BITAND(255, par_nNumero)) + ;
988:                CHR(BITAND(65280, par_nNumero) % 255) + ;
989:                CHR(BITAND(16711680, par_nNumero) % 255) + ;
990:                CHR(BITAND(4278190080, par_nNumero) % 255)
991:     ENDPROC
992: 

*-- Linhas 1198 a 1245:
1198:                             USE IN cursor_4c_FtpServer
1199:                         ENDIF
1200: 
1201:                         CREATE CURSOR cursor_4c_FtpServer ( ;
1202:                             nome C(240), ;
1203:                             tipo C(10), ;
1204:                             tama C(10), ;
1205:                             data C(16), ;
1206:                             atri C(10))
1207: 
1208:                         INDEX ON nome TAG nome
1209:                         SET ORDER TO nome
1210: 
1211:                         IF loc_lManual
1212:                             INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1213:                                 VALUES (".", "Diret" + CHR(243) + "rio", STR(0), DTOC(DATE()), "D")
1214:                         ELSE
1215:                             THIS.CrackFile(loc_cStruct)
1216: 
1217:                             loc_nResult = 1
1218: 
1219:                             DO WHILE loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1220:                                 loc_cStruct     = SPACE(319)
1221:                                 loc_nResult     = InternetFindNextFile(loc_nHandle, @loc_cStruct)
1222:                                 loc_nResultCode = GetLastError()
1223: 
1224:                                 IF loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1225:                                     THIS.CrackFile(loc_cStruct)
1226:                                 ENDIF
1227:                             ENDDO
1228:                         ENDIF
1229: 
1230:                         SELECT cursor_4c_FtpServer
1231:                         GO TOP
1232:                     ENDIF
1233: 
1234:                     InternetCloseHandle(loc_nFtp)
1235:                     InternetCloseHandle(loc_nInternet)
1236:                 ENDIF
1237:             ENDIF
1238:         ENDIF
1239: 
1240:         RETURN loc_lSucesso
1241:     ENDPROC
1242: 
1243:     *==========================================================================
1244:     * CrackFile - Desmonta uma estrutura WIN32_FIND_DATA devolvida pelo
1245:     * WinInet e grava a linha correspondente em cursor_4c_FtpServer

*-- Linhas 1292 a 1310:
1292: 
1293:         loc_cAtributos = THIS.CrackAttributes(LEFT(par_cString, 4))
1294: 
1295:         INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1296:             VALUES (ALLTRIM(loc_cArquivo), ;
1297:                     ALLTRIM(loc_cTipo), ;
1298:                     TRANSFORM(loc_nTamanho, "9999999999"), ;
1299:                     loc_cDataGravacao, ;
1300:                     loc_cAtributos)
1301:     ENDPROC
1302: 
1303:     *==========================================================================
1304:     * CrackDate - Converte um FILETIME (8 bytes) na data formatada dd/mm/aaaa
1305:     * (transcricao do PROCEDURE crackdate do legado, que desconsidera a hora)
1306:     *==========================================================================
1307:     PROTECTED PROCEDURE CrackDate(par_cBuffer)
1308:         LOCAL loc_cEntrada, loc_nResultado, loc_nDia, loc_nMes, loc_nAno, loc_cData
1309: 
1310:         #DEFINE BYTE_2_CD 256

*-- Linhas 1497 a 1515:
1497:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 52
1498:                 loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
1499:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 53
1500:                 loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
1501:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 110
1502:                 loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
1503:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 111
1504:                 loc_cMensagem = "FTP_DROPPED"
1505:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 112
1506:                 loc_cMensagem = "FTP_NO_PASSIVE_MODE"
1507:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 157
1508:                 loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
1509:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 158
1510:                 loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
1511:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 159
1512:                 loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
1513:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 163
1514:                 loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
1515:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 164

*-- Linhas 1598 a 1641:
1598: 
1599:         DO CASE
1600:             CASE par_cStatus == "I"
1601:                 SELECT cursor_4c_Progresso
1602:                 APPEND BLANK
1603:                 REPLACE arquivo        WITH par_cArquivo, ;
1604:                         tamanho        WITH par_nTamanho, ;
1605:                         pastalocal     WITH par_cPastaLocal, ;
1606:                         pastahost      WITH par_cPastaHost, ;
1607:                         statusoperacao WITH "0 bytes copiados, 0% completado"
1608: 
1609:             CASE par_cStatus == "A"
1610:                 SELECT cursor_4c_Progresso
1611:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1612: 
1613:                 IF FOUND()
1614:                     REPLACE statusoperacao WITH ;
1615:                         STR(par_nTransferido) + " bytes copiados, " + ;
1616:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado"
1617: 
1618:                     loc_cTempoEstimado  = THIS.SecToHour(INT(((par_nTamanho - par_nTransferido) * loc_nSegundos) / par_nTransferido))
1619:                     loc_cTempoDecorrido = THIS.SecToHour(SECONDS() - par_nSegIniciais)
1620: 
1621:                     THIS.lbl_4c_Progresso.Caption = "Tempo decorrido: " + loc_cTempoDecorrido + ;
1622:                         "   Tempo Estimado : " + loc_cTempoEstimado
1623:                 ENDIF
1624: 
1625:             CASE par_cStatus == "C"
1626:                 SELECT cursor_4c_Progresso
1627:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1628: 
1629:                 IF FOUND()
1630:                     REPLACE statusoperacao WITH ;
1631:                         STR(par_nTransferido) + " bytes copiados, " + ;
1632:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado em " + ;
1633:                         THIS.SecToHour(loc_nSegundos)
1634: 
1635:                     THIS.lbl_4c_Progresso.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
1636:                         par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
1637: 
1638:                     THIS.Inf("Arquivo Transferido...", "B")
1639: 
1640:                     *-- "Atualiza os listbox dos arquivos" do PROCEDURE
1641:                     *-- processa legado: registra o arquivo concluido na

*-- Linhas 1757 a 1784:
1757:                 MKDIR (loc_cPastaTemp)
1758:                 SET DEFAULT TO (loc_cPastaTemp)
1759: 
1760:                 SELECT cursor_4c_FtpServer
1761:                 SCAN
1762:                     =STRTOFILE("1", cursor_4c_FtpServer.nome)
1763:                 ENDSCAN
1764: 
1765:                 loc_nArquivosMascara = ADIR(loc_aArquivosMascara, ALLTRIM(THIS.this_oBusinessObject.this_cTpRec))
1766: 
1767:                 loc_nItem = 0
1768:                 FOR loc_nCont = 1 TO loc_nArquivosMascara
1769:                     SELECT cursor_4c_FtpServer
1770:                     LOCATE FOR ALLTRIM(UPPER(cursor_4c_FtpServer.nome)) = ALLTRIM(UPPER(loc_aArquivosMascara[loc_nCont, 1]))
1771:                     IF FOUND() AND SUBSTR(cursor_4c_FtpServer.tipo, 1, 1) == "A"
1772:                         loc_nItem = loc_nItem + 1
1773:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
1774:                             .AddItem(ALLTRIM(cursor_4c_FtpServer.nome), loc_nItem, 1)
1775:                             .AddListItem(cursor_4c_FtpServer.tama, loc_nItem, 2)
1776:                             .AddListItem(cursor_4c_FtpServer.data, loc_nItem, 3)
1777:                         ENDWITH
1778:                     ENDIF
1779:                 ENDFOR
1780: 
1781:                 *-- Apaga os arquivos ficticios e, se a pasta ficou vazia, a
1782:                 *-- propria pasta temporaria
1783:                 FOR loc_nCont = 1 TO ADIR(loc_aArquivosMascara)
1784:                     ERASE (loc_aArquivosMascara[loc_nCont, 1])

*-- Linhas 1972 a 1990:
1972: 
1973:     *==========================================================================
1974:     * ExcluirArquivoFtp - Apaga um arquivo no servidor FTP (equivalente ao
1975:     * PROCEDURE deleteftpfile do legado), tentando por ate 60 segundos.
1976:     * Usado por Processa quando this_lDelHost esta ativo.
1977:     *==========================================================================
1978:     PROTECTED FUNCTION ExcluirArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1979:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivo, loc_nResultado, ;
1980:             loc_lContinua, loc_tSegIni, loc_tSegFim
1981: 
1982:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_XF   1
1983:         #DEFINE INTERNET_DEFAULT_FTP_PORT_XF  21
1984:         #DEFINE INTERNET_SERVICE_FTP_XF        1
1985:         #DEFINE INTERNET_FLAG_PASSIVE_XF 14217728
1986: 
1987:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1988:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1989:             STRING lpszProxyBypass, LONG dwFlags
1990: 

*-- Linhas 1997 a 2015:
1997: 
1998:         DECLARE LONG GetLastError IN WIN32API
1999: 
2000:         DECLARE INTEGER FtpDeleteFile IN WinInet ;
2001:             INTEGER nConnect_Handle, STRING @lpcFileName
2002: 
2003:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_XF, "", "", 0)
2004:         IF loc_nInternet = 0
2005:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2006:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2007:             RETURN .F.
2008:         ENDIF
2009: 
2010:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_XF, ;
2011:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_XF, INTERNET_FLAG_PASSIVE_XF, 0)
2012:         IF loc_nFtp = 0
2013:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
2014:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2015:             InternetCloseHandle(loc_nInternet)

*-- Linhas 2022 a 2040:
2022:         loc_tSegIni    = DATETIME()
2023: 
2024:         DO WHILE loc_lContinua
2025:             loc_nResultado = FtpDeleteFile(loc_nFtp, @loc_cArquivo)
2026:             loc_tSegFim    = DATETIME()
2027:             loc_lContinua  = (!(loc_nResultado == 1) AND (loc_tSegFim - loc_tSegIni) < 60)
2028:         ENDDO
2029: 
2030:         InternetCloseHandle(loc_nFtp)
2031:         InternetCloseHandle(loc_nInternet)
2032: 
2033:         RETURN (loc_nResultado = 1)
2034:     ENDFUNC
2035: 
2036:     *==========================================================================
2037:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2038:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2039:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2040:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia

*-- Linhas 2212 a 2230:
2212:         *-- Renomeia o arquivo para temporario ate completar a transferencia
2213:         loc_cArquivoTemp = LEFT(par_cArquivoLocal, LEN(par_cArquivoLocal) - 3) + "ftp"
2214:         IF FILE(par_cArquivoLocal)
2215:             DELETE FILE (par_cArquivoLocal)
2216:         ENDIF
2217: 
2218:         loc_nSegIni = SECONDS()
2219:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), 99999, ;
2220:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
2221:             0, 0, 0, 0, "I")
2222: 
2223:         loc_lOk = (FtpGetFile(loc_nFtp, par_cArquivoRemoto, loc_cArquivoTemp, .F., ;
2224:             FILE_ATTRIBUTE_NORMAL_GF, FTP_TRANSFER_TYPE_BINARY_GF, 0) = 1)
2225: 
2226:         loc_nSegFim  = SECONDS()
2227:         loc_nTamanho = LEN(FILETOSTR(loc_cArquivoTemp))
2228: 
2229:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), loc_nTamanho, ;
2230:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;

*-- Linhas 2289 a 2307:
2289:         FOR loc_nPos = 1 TO loc_nQtd
2290:             DO CASE
2291:                 CASE par_cModo == "I"
2292:                     IF loc_oObj.Selected(loc_nPos)
2293:                         loc_nSelecionados = loc_nSelecionados + 1
2294:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2295:                     ELSE
2296:                         loc_aArquivos(loc_nPos) = ""
2297:                     ENDIF
2298:                 CASE par_cModo == "A"
2299:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2300:             ENDCASE
2301:         ENDFOR
2302: 
2303:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2304:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2305:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2306:             RETURN .F.
2307:         ENDIF

*-- Linhas 2377 a 2395:
2377:         FOR loc_nPos = 1 TO loc_nQtd
2378:             DO CASE
2379:                 CASE par_cModo == "I"
2380:                     IF loc_oObj.Selected(loc_nPos)
2381:                         loc_nSelecionados = loc_nSelecionados + 1
2382:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2383:                     ELSE
2384:                         loc_aArquivos(loc_nPos) = ""
2385:                     ENDIF
2386:                 CASE par_cModo == "A"
2387:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2388:             ENDCASE
2389:         ENDFOR
2390: 
2391:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2392:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2393:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2394:             RETURN .F.
2395:         ENDIF

*-- Linhas 2498 a 2516:
2498:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2499:     *
2500:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2501:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2502:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2503:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2504:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2505:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2506:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao
2507:     * comportamento a preservar. Sem edicao, o valor lido eh IDENTICO ao que
2508:     * BOParaForm escreveu (ja normalizado), entao o caminho normal nao muda.
2509:     *
2510:     * PROTECTED porque FormBase.FormParaBO eh PROTECTED (nao alargar escopo).
2511:     * Retorna .T. quando a configuracao lida da tela esta apta a transferir.
2512:     *==========================================================================
2513:     PROTECTED FUNCTION FormParaBO()
2514:         LOCAL loc_oPgLoc, loc_oPgFtp, loc_lOk, loc_cEnvFtp, loc_cRecFtp, ;
2515:             loc_cRecLoc, loc_cEnvLoc
2516: 

*-- Linhas 2593 a 2617:
2593:         *-- Grid de progresso (cursor_4c_Progresso) e grid de log
2594:         *-- (cursor_4c_Log): reposiciona e repinta os dois
2595:         IF USED("cursor_4c_Progresso")
2596:             SELECT cursor_4c_Progresso
2597:             GO TOP
2598:             THIS.grd_4c_Progresso.Refresh()
2599:         ENDIF
2600: 
2601:         IF USED("cursor_4c_Log")
2602:             SELECT cursor_4c_Log
2603:             GO BOTTOM
2604:             THIS.grd_4c_Log.Refresh()
2605:         ENDIF
2606: 
2607:         RETURN loc_lSucesso
2608:     ENDPROC
2609: 
2610:     *==========================================================================
2611:     * HabilitarCampos - Liga/desliga em bloco os controles de acao da tela.
2612:     * Consolida o bloco de ".enabled" que o legado repete em cmdload.Click
2613:     * (IF/ELSE), em transfere e em recebe:
2614:     *
2615:     *   ThisForm.Container1.enabled = .t.     && o legado deixa .t. nos dois
2616:     *   ThisForm.cmdtran.enabled    = <flag>  && ramos - transcrito como esta
2617:     *   ThisForm.cmdrec.enabled     = <flag>


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


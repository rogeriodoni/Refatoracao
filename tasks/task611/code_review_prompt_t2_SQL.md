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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2837 linhas total):

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

*-- Linhas 254 a 288:
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
284: 
285:         *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .ColumnN
286:         *-- dentro do mesmo WITH que ainda esta definindo o RecordSource
287:         *-- estoura 'Unknown member COLUMN1' porque as colunas nao existem
288:         *-- no momento em que o WITH eh aberto (regra GRID-WITH).

*-- Linhas 296 a 346:
296:             .Width        = 622
297:             .Height       = 114
298:             .FontSize     = 8
299:             .DeleteMark   = .F.
300:             .RecordMark   = .F.
301:             .GridLines    = 0
302:             .HeaderHeight = 15
303:             .RowHeight    = 15
304:             .ReadOnly     = .T.
305:             .ToolTipText  = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
306: 
307:             .Column1.ControlSource   = "cursor_4c_Progresso.arquivo"
308:             .Column1.Width           = 81
309:             .Column1.FontSize        = 8
310:             .Column1.ReadOnly        = .T.
311:             .Column1.Header1.Caption = "Arquivo"
312: 
313:             .Column2.ControlSource   = "cursor_4c_Progresso.tamanho"
314:             .Column2.Width           = 63
315:             .Column2.FontSize        = 8
316:             .Column2.ReadOnly        = .T.
317:             .Column2.Header1.Caption = "Tamanho"
318: 
319:             .Column3.ControlSource   = "cursor_4c_Progresso.pastalocal"
320:             .Column3.Width           = 107
321:             .Column3.FontSize        = 8
322:             .Column3.ReadOnly        = .T.
323:             .Column3.Header1.Caption = "Pasta Local"
324: 
325:             .Column4.ControlSource   = "cursor_4c_Progresso.pastahost"
326:             .Column4.Width           = 136
327:             .Column4.FontSize        = 8
328:             .Column4.ReadOnly        = .T.
329:             .Column4.Header1.Caption = "Pasta Host"
330: 
331:             .Column5.ControlSource   = "cursor_4c_Progresso.statusoperacao"
332:             .Column5.Width           = 207
333:             .Column5.FontSize        = 8
334:             .Column5.ReadOnly        = .T.
335:             .Column5.Header1.Caption = "Status"
336: 
337:             .Visible = .T.
338:         ENDWITH
339: 
340:         THIS.AddObject("grd_4c_Log", "Grid")
341: 
342:         *-- ColumnCount/RecordSource ficam FORA do WITH pelo mesmo motivo
343:         *-- do grd_4c_Progresso acima (regra GRID-WITH).
344:         THIS.grd_4c_Log.ColumnCount      = 1
345:         THIS.grd_4c_Log.RecordSourceType = 1
346:         THIS.grd_4c_Log.RecordSource     = "cursor_4c_Log"

*-- Linhas 352 a 382:
352:             .Height        = 52
353:             .FontBold      = .T.
354:             .FontSize      = 8
355:             .DeleteMark    = .F.
356:             .RecordMark    = .F.
357:             .GridLines     = 0
358:             .GridLineWidth = 1
359:             .HeaderHeight  = 0
360:             .RowHeight     = 14
361:             .ScrollBars    = 2
362:             .ReadOnly      = .T.
363:             .ForeColor     = RGB(0,0,0)
364:             .BackColor     = RGB(255,255,255)
365:             .GridLineColor = RGB(192,192,192)
366: 
367:             .Column1.ControlSource    = "cursor_4c_Log.memo"
368:             .Column1.Width            = 599
369:             .Column1.FontBold         = .T.
370:             .Column1.FontName         = "Arial"
371:             .Column1.FontSize         = 8
372:             .Column1.Alignment        = 0
373:             .Column1.ReadOnly         = .T.
374:             .Column1.ForeColor        = RGB(0,0,0)
375:             .Column1.BackColor        = RGB(255,255,255)
376:             .Column1.DynamicForeColor = "IIF(cursor_4c_Log.cor='R', RGB(255,255,255), IIF(cursor_4c_Log.cor='G', RGB(0,128,0), IIF(cursor_4c_Log.cor='B', RGB(0,0,255), RGB(0,255,255))))"
377:             .Column1.DynamicBackColor = "IIF(cursor_4c_Log.cor='R', RGB(255,0,0), RGB(255,255,255))"
378: 
379:             .Column1.Header1.FontBold  = .T.
380:             .Column1.Header1.FontName  = "Arial"
381:             .Column1.Header1.FontSize  = 8
382:             .Column1.Header1.Alignment = 2

*-- Linhas 606 a 624:
606:             .ColumnCount  = 3
607:             .ColumnWidths = "130,62,83"
608:             .ColumnLines  = .T.
609:             .MultiSelect  = .T.
610:             .FontName     = "Verdana"
611:             .FontSize     = 8
612:             .Visible      = .T.
613:         ENDWITH
614: 
615:         loc_oPag1.AddObject("txt_4c_DirEnvFtp", "TextBox")
616:         WITH loc_oPag1.txt_4c_DirEnvFtp
617:             .Top         = 2
618:             .Left        = 2
619:             .Width       = 217
620:             .Height      = 23
621:             .FontName    = "Verdana"
622:             .FontSize    = 8
623:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
624:             .Visible     = .T.

*-- Linhas 649 a 667:
649:             .ColumnCount  = 3
650:             .ColumnWidths = "135,58,82"
651:             .ColumnLines  = .T.
652:             .MultiSelect  = .T.
653:             .FontName     = "Verdana"
654:             .FontSize     = 8
655:             .Visible      = .T.
656:         ENDWITH
657: 
658:         loc_oPag2.AddObject("txt_4c_DirRecFtp", "TextBox")
659:         WITH loc_oPag2.txt_4c_DirRecFtp
660:             .Top         = 2
661:             .Left        = 2
662:             .Width       = 217
663:             .Height      = 23
664:             .FontName    = "Verdana"
665:             .FontSize    = 8
666:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
667:             .Visible     = .T.

*-- Linhas 725 a 743:
725:             .ColumnCount  = 3
726:             .ColumnWidths = "135,58,82"
727:             .ColumnLines  = .T.
728:             .MultiSelect  = .T.
729:             .FontName     = "Verdana"
730:             .FontSize     = 8
731:             .Visible      = .T.
732:         ENDWITH
733: 
734:         loc_oPag1.AddObject("txt_4c_DirRecLoc", "TextBox")
735:         WITH loc_oPag1.txt_4c_DirRecLoc
736:             .Top         = 2
737:             .Left        = 2
738:             .Width       = 217
739:             .Height      = 23
740:             .FontName    = "Verdana"
741:             .FontSize    = 8
742:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
743:             .Visible     = .T.

*-- Linhas 768 a 786:
768:             .ColumnCount  = 3
769:             .ColumnWidths = "130,62,83"
770:             .ColumnLines  = .T.
771:             .MultiSelect  = .T.
772:             .FontName     = "Verdana"
773:             .FontSize     = 8
774:             .Visible      = .T.
775:         ENDWITH
776: 
777:         loc_oPag2.AddObject("txt_4c_DirEnvLoc", "TextBox")
778:         WITH loc_oPag2.txt_4c_DirEnvLoc
779:             .Top         = 2
780:             .Left        = 2
781:             .Width       = 217
782:             .Height      = 23
783:             .FontName    = "Verdana"
784:             .FontSize    = 8
785:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
786:             .Visible     = .T.

*-- Linhas 836 a 854:
836:             .RowSourceType    = 5
837:             .RowSource        = "aProvedor"
838:             .ColumnCount      = 1
839:             .ControlSource    = "nProvedor"
840:             .FirstElement     = 1
841:             .FontName         = "Verdana"
842:             .FontSize         = 8
843:             .Visible          = .F.
844:         ENDWITH
845: 
846:         IF THIS.this_oBusinessObject.this_cTpConnect == "D"
847:             THIS.cbo_4c_Provedor.Visible = .T.
848: 
849:             IF THIS.RasConexao("aProvedor") = 0
850:                 RELEASE aProvedor
851:                 PUBLIC ARRAY aProvedor(1)
852:                 aProvedor(1) = ""
853:                 THIS.Inf("N" + CHR(227) + "o existem conex" + CHR(245) + "es DIAL-UP dispon" + CHR(237) + "veis...", "R")
854:                 MsgAviso("N" + CHR(227) + "o existem conex" + CHR(245) + "es dispon" + CHR(237) + "veis...", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 974 a 1000:
974:             RETURN
975:         ENDIF
976: 
977:         SELECT cursor_4c_Log
978:         APPEND BLANK
979:         REPLACE memo WITH par_cTexto, cor WITH par_cCor
980:         GO BOTTOM
981: 
982:         THIS.grd_4c_Log.Refresh()
983: 
984:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
985:             SELECT (loc_cAliasAnterior)
986:         ENDIF
987:     ENDPROC
988: 
989:     *==========================================================================
990:     * WordToC / CToWord - Conversao entre inteiro (4 bytes) e buffer de
991:     * caracteres usada pelas chamadas RAS/WinInet, equivalente aos metodos
992:     * homonimos do legado
993:     *==========================================================================
994:     PROTECTED PROCEDURE WordToC(par_nNumero)
995:         RETURN CHR(BITAND(255, par_nNumero)) + ;
996:                CHR(BITAND(65280, par_nNumero) % 255) + ;
997:                CHR(BITAND(16711680, par_nNumero) % 255) + ;
998:                CHR(BITAND(4278190080, par_nNumero) % 255)
999:     ENDPROC
1000: 

*-- Linhas 1206 a 1253:
1206:                             USE IN cursor_4c_FtpServer
1207:                         ENDIF
1208: 
1209:                         CREATE CURSOR cursor_4c_FtpServer ( ;
1210:                             nome C(240), ;
1211:                             tipo C(10), ;
1212:                             tama C(10), ;
1213:                             data C(16), ;
1214:                             atri C(10))
1215: 
1216:                         INDEX ON nome TAG nome
1217:                         SET ORDER TO nome
1218: 
1219:                         IF loc_lManual
1220:                             INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1221:                                 VALUES (".", "Diret" + CHR(243) + "rio", STR(0), DTOC(DATE()), "D")
1222:                         ELSE
1223:                             THIS.CrackFile(loc_cStruct)
1224: 
1225:                             loc_nResult = 1
1226: 
1227:                             DO WHILE loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1228:                                 loc_cStruct     = SPACE(319)
1229:                                 loc_nResult     = InternetFindNextFile(loc_nHandle, @loc_cStruct)
1230:                                 loc_nResultCode = GetLastError()
1231: 
1232:                                 IF loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
1233:                                     THIS.CrackFile(loc_cStruct)
1234:                                 ENDIF
1235:                             ENDDO
1236:                         ENDIF
1237: 
1238:                         SELECT cursor_4c_FtpServer
1239:                         GO TOP
1240:                     ENDIF
1241: 
1242:                     InternetCloseHandle(loc_nFtp)
1243:                     InternetCloseHandle(loc_nInternet)
1244:                 ENDIF
1245:             ENDIF
1246:         ENDIF
1247: 
1248:         RETURN loc_lSucesso
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * CrackFile - Desmonta uma estrutura WIN32_FIND_DATA devolvida pelo
1253:     * WinInet e grava a linha correspondente em cursor_4c_FtpServer

*-- Linhas 1300 a 1318:
1300: 
1301:         loc_cAtributos = THIS.CrackAttributes(LEFT(par_cString, 4))
1302: 
1303:         INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
1304:             VALUES (ALLTRIM(loc_cArquivo), ;
1305:                     ALLTRIM(loc_cTipo), ;
1306:                     TRANSFORM(loc_nTamanho, "9999999999"), ;
1307:                     loc_cDataGravacao, ;
1308:                     loc_cAtributos)
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     * CrackDate - Converte um FILETIME (8 bytes) na data formatada dd/mm/aaaa
1313:     * (transcricao do PROCEDURE crackdate do legado, que desconsidera a hora)
1314:     *==========================================================================
1315:     PROTECTED PROCEDURE CrackDate(par_cBuffer)
1316:         LOCAL loc_cEntrada, loc_nResultado, loc_nDia, loc_nMes, loc_nAno, loc_cData
1317: 
1318:         #DEFINE BYTE_2_CD 256

*-- Linhas 1505 a 1523:
1505:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 52
1506:                 loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
1507:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 53
1508:                 loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
1509:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 110
1510:                 loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
1511:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 111
1512:                 loc_cMensagem = "FTP_DROPPED"
1513:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 112
1514:                 loc_cMensagem = "FTP_NO_PASSIVE_MODE"
1515:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 157
1516:                 loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
1517:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 158
1518:                 loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
1519:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 159
1520:                 loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
1521:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 163
1522:                 loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
1523:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 164

*-- Linhas 1606 a 1649:
1606: 
1607:         DO CASE
1608:             CASE par_cStatus == "I"
1609:                 SELECT cursor_4c_Progresso
1610:                 APPEND BLANK
1611:                 REPLACE arquivo        WITH par_cArquivo, ;
1612:                         tamanho        WITH par_nTamanho, ;
1613:                         pastalocal     WITH par_cPastaLocal, ;
1614:                         pastahost      WITH par_cPastaHost, ;
1615:                         statusoperacao WITH "0 bytes copiados, 0% completado"
1616: 
1617:             CASE par_cStatus == "A"
1618:                 SELECT cursor_4c_Progresso
1619:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1620: 
1621:                 IF FOUND()
1622:                     REPLACE statusoperacao WITH ;
1623:                         STR(par_nTransferido) + " bytes copiados, " + ;
1624:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado"
1625: 
1626:                     loc_cTempoEstimado  = THIS.SecToHour(INT(((par_nTamanho - par_nTransferido) * loc_nSegundos) / par_nTransferido))
1627:                     loc_cTempoDecorrido = THIS.SecToHour(SECONDS() - par_nSegIniciais)
1628: 
1629:                     THIS.lbl_4c_Progresso.Caption = "Tempo decorrido: " + loc_cTempoDecorrido + ;
1630:                         "   Tempo Estimado : " + loc_cTempoEstimado
1631:                 ENDIF
1632: 
1633:             CASE par_cStatus == "C"
1634:                 SELECT cursor_4c_Progresso
1635:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1636: 
1637:                 IF FOUND()
1638:                     REPLACE statusoperacao WITH ;
1639:                         STR(par_nTransferido) + " bytes copiados, " + ;
1640:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado em " + ;
1641:                         THIS.SecToHour(loc_nSegundos)
1642: 
1643:                     THIS.lbl_4c_Progresso.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
1644:                         par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
1645: 
1646:                     THIS.Inf("Arquivo Transferido...", "B")
1647: 
1648:                     *-- "Atualiza os listbox dos arquivos" do PROCEDURE
1649:                     *-- processa legado: registra o arquivo concluido na

*-- Linhas 1765 a 1792:
1765:                 MKDIR (loc_cPastaTemp)
1766:                 SET DEFAULT TO (loc_cPastaTemp)
1767: 
1768:                 SELECT cursor_4c_FtpServer
1769:                 SCAN
1770:                     =STRTOFILE("1", cursor_4c_FtpServer.nome)
1771:                 ENDSCAN
1772: 
1773:                 loc_nArquivosMascara = ADIR(loc_aArquivosMascara, ALLTRIM(THIS.this_oBusinessObject.this_cTpRec))
1774: 
1775:                 loc_nItem = 0
1776:                 FOR loc_nCont = 1 TO loc_nArquivosMascara
1777:                     SELECT cursor_4c_FtpServer
1778:                     LOCATE FOR ALLTRIM(UPPER(cursor_4c_FtpServer.nome)) = ALLTRIM(UPPER(loc_aArquivosMascara[loc_nCont, 1]))
1779:                     IF FOUND() AND SUBSTR(cursor_4c_FtpServer.tipo, 1, 1) == "A"
1780:                         loc_nItem = loc_nItem + 1
1781:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
1782:                             .AddItem(ALLTRIM(cursor_4c_FtpServer.nome), loc_nItem, 1)
1783:                             .AddListItem(cursor_4c_FtpServer.tama, loc_nItem, 2)
1784:                             .AddListItem(cursor_4c_FtpServer.data, loc_nItem, 3)
1785:                         ENDWITH
1786:                     ENDIF
1787:                 ENDFOR
1788: 
1789:                 *-- Apaga os arquivos ficticios e, se a pasta ficou vazia, a
1790:                 *-- propria pasta temporaria
1791:                 FOR loc_nCont = 1 TO ADIR(loc_aArquivosMascara)
1792:                     ERASE (loc_aArquivosMascara[loc_nCont, 1])

*-- Linhas 1980 a 1998:
1980: 
1981:     *==========================================================================
1982:     * ExcluirArquivoFtp - Apaga um arquivo no servidor FTP (equivalente ao
1983:     * PROCEDURE deleteftpfile do legado), tentando por ate 60 segundos.
1984:     * Usado por Processa quando this_lDelHost esta ativo.
1985:     *==========================================================================
1986:     PROTECTED FUNCTION ExcluirArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1987:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivo, loc_nResultado, ;
1988:             loc_lContinua, loc_tSegIni, loc_tSegFim
1989: 
1990:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_XF   1
1991:         #DEFINE INTERNET_DEFAULT_FTP_PORT_XF  21
1992:         #DEFINE INTERNET_SERVICE_FTP_XF        1
1993:         #DEFINE INTERNET_FLAG_PASSIVE_XF 14217728
1994: 
1995:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1996:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1997:             STRING lpszProxyBypass, LONG dwFlags
1998: 

*-- Linhas 2005 a 2023:
2005: 
2006:         DECLARE LONG GetLastError IN WIN32API
2007: 
2008:         DECLARE INTEGER FtpDeleteFile IN WinInet ;
2009:             INTEGER nConnect_Handle, STRING @lpcFileName
2010: 
2011:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_XF, "", "", 0)
2012:         IF loc_nInternet = 0
2013:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2014:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2015:             RETURN .F.
2016:         ENDIF
2017: 
2018:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_XF, ;
2019:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_XF, INTERNET_FLAG_PASSIVE_XF, 0)
2020:         IF loc_nFtp = 0
2021:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
2022:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2023:             InternetCloseHandle(loc_nInternet)

*-- Linhas 2030 a 2048:
2030:         loc_tSegIni    = DATETIME()
2031: 
2032:         DO WHILE loc_lContinua
2033:             loc_nResultado = FtpDeleteFile(loc_nFtp, @loc_cArquivo)
2034:             loc_tSegFim    = DATETIME()
2035:             loc_lContinua  = (!(loc_nResultado == 1) AND (loc_tSegFim - loc_tSegIni) < 60)
2036:         ENDDO
2037: 
2038:         InternetCloseHandle(loc_nFtp)
2039:         InternetCloseHandle(loc_nInternet)
2040: 
2041:         RETURN (loc_nResultado = 1)
2042:     ENDFUNC
2043: 
2044:     *==========================================================================
2045:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2046:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2047:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2048:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia

*-- Linhas 2220 a 2238:
2220:         *-- Renomeia o arquivo para temporario ate completar a transferencia
2221:         loc_cArquivoTemp = LEFT(par_cArquivoLocal, LEN(par_cArquivoLocal) - 3) + "ftp"
2222:         IF FILE(par_cArquivoLocal)
2223:             DELETE FILE (par_cArquivoLocal)
2224:         ENDIF
2225: 
2226:         loc_nSegIni = SECONDS()
2227:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), 99999, ;
2228:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
2229:             0, 0, 0, 0, "I")
2230: 
2231:         loc_lOk = (FtpGetFile(loc_nFtp, par_cArquivoRemoto, loc_cArquivoTemp, .F., ;
2232:             FILE_ATTRIBUTE_NORMAL_GF, FTP_TRANSFER_TYPE_BINARY_GF, 0) = 1)
2233: 
2234:         loc_nSegFim  = SECONDS()
2235:         loc_nTamanho = LEN(FILETOSTR(loc_cArquivoTemp))
2236: 
2237:         THIS.Processa(JUSTFNAME(par_cArquivoRemoto), loc_nTamanho, ;
2238:             THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;

*-- Linhas 2297 a 2315:
2297:         FOR loc_nPos = 1 TO loc_nQtd
2298:             DO CASE
2299:                 CASE par_cModo == "I"
2300:                     IF loc_oObj.Selected(loc_nPos)
2301:                         loc_nSelecionados = loc_nSelecionados + 1
2302:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2303:                     ELSE
2304:                         loc_aArquivos(loc_nPos) = ""
2305:                     ENDIF
2306:                 CASE par_cModo == "A"
2307:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2308:             ENDCASE
2309:         ENDFOR
2310: 
2311:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2312:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2313:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2314:             RETURN .F.
2315:         ENDIF

*-- Linhas 2385 a 2403:
2385:         FOR loc_nPos = 1 TO loc_nQtd
2386:             DO CASE
2387:                 CASE par_cModo == "I"
2388:                     IF loc_oObj.Selected(loc_nPos)
2389:                         loc_nSelecionados = loc_nSelecionados + 1
2390:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2391:                     ELSE
2392:                         loc_aArquivos(loc_nPos) = ""
2393:                     ENDIF
2394:                 CASE par_cModo == "A"
2395:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2396:             ENDCASE
2397:         ENDFOR
2398: 
2399:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2400:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2401:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2402:             RETURN .F.
2403:         ENDIF

*-- Linhas 2506 a 2524:
2506:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2507:     *
2508:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2509:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2510:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2511:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2512:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2513:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2514:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao
2515:     * comportamento a preservar. Sem edicao, o valor lido eh IDENTICO ao que
2516:     * BOParaForm escreveu (ja normalizado), entao o caminho normal nao muda.
2517:     *
2518:     * PROTECTED porque FormBase.FormParaBO eh PROTECTED (nao alargar escopo).
2519:     * Retorna .T. quando a configuracao lida da tela esta apta a transferir.
2520:     *==========================================================================
2521:     PROTECTED FUNCTION FormParaBO()
2522:         LOCAL loc_oPgLoc, loc_oPgFtp, loc_lOk, loc_cEnvFtp, loc_cRecFtp, ;
2523:             loc_cRecLoc, loc_cEnvLoc
2524: 

*-- Linhas 2601 a 2625:
2601:         *-- Grid de progresso (cursor_4c_Progresso) e grid de log
2602:         *-- (cursor_4c_Log): reposiciona e repinta os dois
2603:         IF USED("cursor_4c_Progresso")
2604:             SELECT cursor_4c_Progresso
2605:             GO TOP
2606:             THIS.grd_4c_Progresso.Refresh()
2607:         ENDIF
2608: 
2609:         IF USED("cursor_4c_Log")
2610:             SELECT cursor_4c_Log
2611:             GO BOTTOM
2612:             THIS.grd_4c_Log.Refresh()
2613:         ENDIF
2614: 
2615:         RETURN loc_lSucesso
2616:     ENDPROC
2617: 
2618:     *==========================================================================
2619:     * HabilitarCampos - Liga/desliga em bloco os controles de acao da tela.
2620:     * Consolida o bloco de ".enabled" que o legado repete em cmdload.Click
2621:     * (IF/ELSE), em transfere e em recebe:
2622:     *
2623:     *   ThisForm.Container1.enabled = .t.     && o legado deixa .t. nos dois
2624:     *   ThisForm.cmdtran.enabled    = <flag>  && ramos - transcrito como esta
2625:     *   ThisForm.cmdrec.enabled     = <flag>


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


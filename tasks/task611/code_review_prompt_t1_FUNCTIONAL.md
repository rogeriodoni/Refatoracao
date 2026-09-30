# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [METODO-INEXISTENTE] Metodo 'THIS.ExcluirArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RenomearArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EnviarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ReceberArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Progresso' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Log' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_FtpServer' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Progresso define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Progresso.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Log define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Log.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagLocRecebidosActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagFtpAReceberActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [GRID-HEADER] Header Caption ' Arquivo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Tamanho' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Pasta Local ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Pasta Host' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Status' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2829 linhas total):

*-- Linhas 18 a 38:
18: *   GrdProc (Fase 4)  : grid de progresso das operacoes (cursor tmpprog)
19: *   GrdInf  (Fase 4)  : grid de log/mensagens (cursor logftp)
20: *   lblprog (Fase 4)  : label de status, rodape do painel de progresso
21: *   botoes de acao (Fase 4): Conecta/Transfere/Recebe/Rede Dial-Up/Encerrar
22: *   carga de dados (Fase 4): CarregarDados lista o diretorio remoto do FTP
23: *                            (WinInet) em cursor_4c_FtpServer; Processa
24: *                            alimenta o grid de progresso; Inf, o de log
25: *   ConfigurarPaginaDados (Fase 5): ponto de entrada dos controles de DADOS
26: *                        das paginas dos 2 PageFrames + o guard de
27: *                        disponibilidade transcrito do Init legado
28: *   pgf_4c_Loc (Fase 5): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
29: *                        cmd_4c_BrowEnvFtp) e Page2 "Recebidos"
30: *                        (lst_4c_RecFtp/txt_4c_DirRecFtp/cmd_4c_BrowRecFtp);
31: *                        MontaContainer agora povoa lst_4c_EnvFtp via ADIR;
32: *                        Activate das paginas sincroniza pgf_4c_Ftp.ActivePage
33: *   pgf_4c_Ftp (Fase 6) : Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
34: *                        cmd_4c_BrowRecLoc) e Page2 "A Receber"
35: *                        (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc);
36: *                        Activate das paginas sincroniza pgf_4c_Loc.ActivePage
37: *   CboProvedor (Fase 6): cbo_4c_Provedor, combo de provedores Dial-Up
38: *                        (RowSourceType=5 sobre o array PUBLIC aProvedor,

*-- Linhas 90 a 214:
90:     MaxButton   = .F.
91:     MinButton   = .F.
92:     TitleBar    = 0
93:     ShowWindow  = 1     && "As Top-Level Form" - FIXO na classe (igual FormBuscaAuxiliar/
94:                         && FormErro/FormBuscaSimples): ShowWindow e READ-ONLY em runtime
95:                         && nesta instalacao do VFP9 (medido em automation\medir_showwindow.txt
96:                         && - ate um Form nativo vazio recusa THIS.ShowWindow=x no Init com
97:                         && "Property SHOWWINDOW is read-only"); so WindowType aceita mudanca
98:                         && em runtime.
99:     WindowType  = 1
100:     WindowState = 0
101:     LockScreen  = .F.
102:     Themes      = .F.
103: 
104:     this_oBusinessObject      = .NULL.
105:     this_cProvedorConectado   = ""     && Nome do provedor Dial-Up discado por BtnRedeDialupClick (equivalente a "cProvedor" do legado, consultado no Destroy para desconectar)
106: 
107:     *==========================================================================
108:     * Init - Dispara a cadeia FormBase.Init -> InicializarForm
109:     *==========================================================================
110:     FUNCTION Init()
111:         *-- Em modo teste: rebaixa para modeless (WindowType=0, aceita mudanca
112:         *-- em runtime) + Visible=.F. para o VFP9 -T headless nao travar
113:         *-- tentando exibir um form modal top-level (mesma protecao de
114:         *-- FormICD/FormICO/FormSIGPRCIC). NAO tocar ShowWindow aqui - fica
115:         *-- travado no valor fixo da classe (ver comentario acima).
116:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
117:             THIS.WindowType = 0
118:             THIS.Visible = .F.
119:         ENDIF
120: 
121:         RETURN DODEFAULT()
122:     ENDFUNC
123: 
124:     *==========================================================================
125:     * InicializarForm - Resolve a configuracao de FTP da empresa corrente e
126:     * cria a estrutura visual base do form (chamado por FormBase.Init)
127:     *==========================================================================
128:     PROTECTED FUNCTION InicializarForm()
129:         LOCAL loc_lSucesso, loc_oErro
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
149:                         "Configura" + CHR(231) + CHR(227) + "o de FTP")
150:                 ELSE
151:                     THIS.ConfigurarPageFrame()
152:                     THIS.ConfigurarCursoresAuxiliares()
153:                     THIS.ConfigurarGrids()
154:                     THIS.ConfigurarBotoesAcao()
155:                     THIS.ConfigurarPaginaDados()
156:                     loc_lSucesso = .T.
157:                 ENDIF
158:             ENDIF
159:         CATCH TO loc_oErro
160:             MsgErro(loc_oErro.Message + CHR(13) + ;
161:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
162:                 "Procedure: " + loc_oErro.Procedure, "InicializarForm")
163:             loc_lSucesso = .F.
164:         ENDTRY
165: 
166:         RETURN loc_lSucesso
167:     ENDFUNC
168: 
169:     *==========================================================================
170:     * ConfigurarPageFrame - Cria a moldura decorativa (Shape1) e o container
171:     * de navegacao com os 2 PageFrames internos (Local / FTP), reproduzindo
172:     * fielmente Top/Left/Width/Height/Caption/cores do SCX legado
173:     *==========================================================================
174:     PROTECTED PROCEDURE ConfigurarPageFrame()
175:         THIS.AddObject("shp_4c_Shape1", "Shape")
176:         WITH THIS.shp_4c_Shape1
177:             .Top         = 7
178:             .Left        = 696
179:             .Height      = 110
180:             .Width       = 90
181:             .BackStyle   = 0
182:             .BorderStyle = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         THIS.AddObject("cnt_4c_Navegacao", "Container")
187:         WITH THIS.cnt_4c_Navegacao
188:             .Top         = 128
189:             .Left        = 88
190:             .Width       = 620
191:             .Height      = 194
192:             .BackStyle   = 0
193:             .BorderWidth = 0
194:             .Visible     = .T.
195:         ENDWITH
196: 
197:         *-- PageFrame "Local" - Page1 = A Enviar / Page2 = Recebidos
198:         THIS.cnt_4c_Navegacao.AddObject("pgf_4c_Loc", "PageFrame")
199:         WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc
200:             .PageCount   = 2
201:             .Top         = 4
202:             .Left        = 3
203:             .Width       = 294
204:             .Height      = 186
205:             .TabStretch  = 1
206:             .ActivePage  = 1
207:             .Visible     = .T.
208:         ENDWITH
209:         WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
210:             .Caption   = "A Enviar"
211:             .FontBold  = .T.
212:             .FontName  = "Verdana"
213:             .FontSize  = 8
214:             .BackColor = RGB(255,255,255)

*-- Linhas 259 a 626:
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
375:             .Column1.Header1.Caption   = "Memo"
376:             .Column1.Header1.ForeColor = RGB(0,0,0)
377:             .Column1.Header1.BackColor = RGB(192,192,192)
378: 
379:             .Visible = .T.
380:         ENDWITH
381: 
382:         *-- Label de status da operacao corrente (lblprog do legado). Fica
383:         *-- junto dos grids porque e' o rodape do painel de progresso: o
384:         *-- PROCEDURE processa escreve nele o tempo decorrido/estimado a cada
385:         *-- bloco transferido. Classe base "label" (nao a classe "say" do
386:         *-- Framework), logo AutoSize/Alignment ficam nos defaults - Width e
387:         *-- Height vem do SCX (rule #23: fixar os dois, nunca usar AutoSize)
388:         THIS.AddObject("lbl_4c_Progresso", "Label")
389:         WITH THIS.lbl_4c_Progresso
390:             .Top       = 512
391:             .Left      = 245
392:             .Width     = 437
393:             .Height    = 16
394:             .AutoSize  = .F.
395:             .Alignment = 0
396:             .BackStyle = 0
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             .ForeColor = RGB(0,0,0)
400:             .Caption   = ""
401:             .Visible   = .T.
402:         ENDWITH
403:     ENDPROC
404: 
405:     *==========================================================================
406:     * ConfigurarBotoesAcao - Cria os botoes de acao do form (Conecta,
407:     * Transfere, Recebe, Rede Dial-Up, Encerrar e os 2 botoes pequenos de
408:     * transferencia individual dentro de cnt_4c_Navegacao), com o Enabled/
409:     * Visible inicial calculado como no Init legado: checagem de existencia
410:     * dos diretorios locais (this_cDirEnvFtp/this_cDirRecFtp) e visibilidade
411:     * do botao de Dial-Up conforme this_cTpConnect
412:     *==========================================================================
413:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
414:         LOCAL loc_lConfigOk
415:         loc_lConfigOk = .T.
416: 
417:         THIS.AddObject("cmd_4c_Conectar", "CommandButton")
418:         WITH THIS.cmd_4c_Conectar
419:             .Top        = 12
420:             .Left       = 23
421:             .Width      = 75
422:             .Height     = 75
423:             .FontBold   = .T.
424:             .FontItalic = .T.
425:             .FontName   = "Comic Sans MS"
426:             .FontSize   = 8
427:             .WordWrap   = .T.
428:             .Picture    = gc_4c_CaminhoIcones + "a_arrow1.bmp"
429:             .Caption    = "\<Conecta"
430:             .ForeColor  = RGB(90,90,90)
431:             .BackColor  = RGB(255,255,255)
432:             .Themes           = .T.
433:             .Visible    = .T.
434:         ENDWITH
435:         BINDEVENT(THIS.cmd_4c_Conectar, "Click", THIS, "BtnConectarClick")
436: 
437:         THIS.AddObject("cmd_4c_Transferir", "CommandButton")
438:         WITH THIS.cmd_4c_Transferir
439:             .Top        = 12
440:             .Left       = 99
441:             .Width      = 75
442:             .Height     = 75
443:             .FontBold   = .T.
444:             .FontItalic = .T.
445:             .FontName   = "Comic Sans MS"
446:             .FontSize   = 8
447:             .Picture    = gc_4c_CaminhoIcones + "baix_aut.bmp"
448:             .Caption    = "\<Transfere"
449:             .ForeColor  = RGB(90,90,90)
450:             .BackColor  = RGB(255,255,255)
451:             .Themes           = .T.
452:             .DisabledPicture  = gc_4c_CaminhoIcones + "baix_aut.bmp"
453:             .Enabled    = .F.
454:             .Visible    = .T.
455:         ENDWITH
456:         BINDEVENT(THIS.cmd_4c_Transferir, "Click", THIS, "BtnExecutarTransferenciaClick")
457: 
458:         THIS.AddObject("cmd_4c_Receber", "CommandButton")
459:         WITH THIS.cmd_4c_Receber
460:             .Top        = 12
461:             .Left       = 174
462:             .Width      = 75
463:             .Height     = 75
464:             .FontBold   = .T.
465:             .FontItalic = .T.
466:             .FontName   = "Comic Sans MS"
467:             .FontSize   = 8
468:             .Picture    = gc_4c_CaminhoIcones + "d_disk1.bmp"
469:             .Caption    = "\<Recebe"
470:             .ForeColor  = RGB(90,90,90)
471:             .BackColor  = RGB(255,255,255)
472:             .Themes           = .T.
473:             .DisabledPicture  = gc_4c_CaminhoIcones + "d_disk1.bmp"
474:             .Enabled    = .F.
475:             .Visible    = .T.
476:         ENDWITH
477:         BINDEVENT(THIS.cmd_4c_Receber, "Click", THIS, "BtnExecutarRecebimentoClick")
478: 
479:         THIS.AddObject("cmd_4c_RedeDialup", "CommandButton")
480:         WITH THIS.cmd_4c_RedeDialup
481:             .Top        = 534
482:             .Left       = 332
483:             .Width      = 76
484:             .Height     = 54
485:             .FontBold   = .T.
486:             .FontItalic = .T.
487:             .FontName   = "Comic Sans MS"
488:             .FontSize   = 7
489:             .Picture    = gc_4c_CaminhoIcones + "c_comm1.bmp"
490:             .Caption    = "Rede \<Dial-Up"
491:             .ForeColor  = RGB(90,90,90)
492:             .BackColor  = RGB(255,255,255)
493:             .Themes           = .T.
494:             .Visible    = (THIS.this_oBusinessObject.this_cTpConnect == "D")
495:         ENDWITH
496:         BINDEVENT(THIS.cmd_4c_RedeDialup, "Click", THIS, "BtnRedeDialupClick")
497: 
498:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
499:         WITH THIS.cmd_4c_Encerrar
500:             .Top        = 12
501:             .Left = 5
502:             .Width      = 75
503:             .Height     = 75
504:             .FontBold   = .T.
505:             .FontItalic = .T.
506:             .FontName   = "Comic Sans MS"
507:             .FontSize   = 8
508:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
509:             .Cancel     = .T.
510:             .Caption    = "Encerrar"
511:             .ForeColor  = RGB(90,90,90)
512:             .BackColor  = RGB(255,255,255)
513:             .Themes           = .T.
514:             .Enabled    = .T.
515:             .Visible    = .T.
516:         ENDWITH
517:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
518: 
519:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_EnviaFtp", "CommandButton")
520:         WITH THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp
521:             .Top          = 83
522:             .Left         = 299
523:             .Width        = 25
524:             .Height       = 24
525:             .FontName     = "Verdana"
526:             .FontSize     = 8
527:             .Picture      = gc_4c_CaminhoIcones + "b_arrow2.bmp"
528:             .Caption      = ""
529:             .ToolTipText  = "Transfere para FTP"
530:             .ForeColor    = RGB(36,84,155)
531:             .BackColor    = RGB(255,255,255)
532:             .Visible      = .T.
533:         ENDWITH
534:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp, "Click", THIS, "BtnEnviaFtpClick")
535: 
536:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_RecebeFtp", "CommandButton")
537:         WITH THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp
538:             .Top          = 116
539:             .Left         = 299
540:             .Width        = 25
541:             .Height       = 24
542:             .FontName     = "Verdana"
543:             .FontSize     = 8
544:             .Picture      = gc_4c_CaminhoIcones + "b_arrow1.bmp"
545:             .Caption      = ""
546:             .ToolTipText  = "Recebe do FTP"
547:             .ForeColor    = RGB(36,84,155)
548:             .BackColor    = RGB(255,255,255)
549:             .Visible      = .T.
550:         ENDWITH
551:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp, "Click", THIS, "BtnRecebeFtpClick")
552: 
553:         *-- Container1 (cnt_4c_Navegacao) so fica habilitado apos Conecta
554:         THIS.cnt_4c_Navegacao.Enabled = .F.
555: 
556:         *-- "Checa a existencia dos diretorios locais" (Init legado)
557:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirEnvFtp)
558:             THIS.Inf("Diret" + CHR(243) + "rio Local de Envio para FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
559:             loc_lConfigOk = .F.
560:         ENDIF
561:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirRecFtp)
562:             THIS.Inf("Diret" + CHR(243) + "rio Local de Recebimento do FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
563:             loc_lConfigOk = .F.
564:         ENDIF
565: 
566:         THIS.cmd_4c_Conectar.Enabled = loc_lConfigOk
567: 
568:         IF !loc_lConfigOk
569:             MsgAviso("Erro na parametriza" + CHR(231) + CHR(227) + "o ou na configura" + CHR(231) + CHR(227) + "o da conex" + CHR(227) + "o. Verifique... Opera" + CHR(231) + CHR(227) + "o Cancelada", "Aten" + CHR(231) + CHR(227) + "o")
570:         ENDIF
571:     ENDPROC
572: 
573:     *==========================================================================
574:     * ConfigurarControlesLocal - Cria os controles de dados do PageFrame
575:     * "Local" (pgf_4c_Loc): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
576:     * cmd_4c_BrowEnvFtp) e Page2 "Recebidos" (lst_4c_RecFtp/txt_4c_DirRecFtp/
577:     * cmd_4c_BrowRecFtp), com Top/Left/Width/Height/ColumnWidths transcritos
578:     * do SCX legado (lstenvftp/direnvftp/cmdbrowloc de cada pagina - o legado
579:     * reusa o MESMO nome "cmdbrowloc" nas duas paginas; aqui os botoes
580:     * recebem nomes distintos por acao, ja que o nome generico colidiria).
581:     * Os botoes "..." ficam Enabled = .F. porque o legado NUNCA implementa
582:     * Click para eles (nenhum PROCEDURE Click no dump) - sao decorativos no
583:     * original. Os controles de dados do PageFrame "FTP" (pgf_4c_Ftp) e o
584:     * CboProvedor entram na Fase 6.
585:     *==========================================================================
586:     PROTECTED PROCEDURE ConfigurarControlesLocal()
587:         LOCAL loc_oPag1, loc_oPag2
588: 
589:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
590:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2
591: 
592:         loc_oPag1.AddObject("lst_4c_EnvFtp", "ListBox")
593:         WITH loc_oPag1.lst_4c_EnvFtp
594:             .Top          = 26
595:             .Left         = 2
596:             .Width        = 286
597:             .Height       = 130
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
617:         ENDWITH
618: 
619:         loc_oPag1.AddObject("cmd_4c_BrowEnvFtp", "CommandButton")
620:         WITH loc_oPag1.cmd_4c_BrowEnvFtp
621:             .Top       = 2
622:             .Left      = 222
623:             .Width     = 22
624:             .Height    = 22
625:             .FontName  = "Verdana"
626:             .FontSize  = 8

*-- Linhas 685 a 745:
685:         *-- trazer "Enviados" no lado FTP. Page.ZOrder num PageFrame traz a
686:         *-- pagina para a frente, ou seja, SELECIONA a pagina: o equivalente
687:         *-- no migrado eh <pageframe>.ActivePage = N.
688:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagLocEnviarActivate")
689:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagLocRecebidosActivate")
690:     ENDPROC
691: 
692:     *==========================================================================
693:     * ConfigurarControlesFtp - Cria os controles de dados do PageFrame "FTP"
694:     * (pgf_4c_Ftp): Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
695:     * cmd_4c_BrowRecLoc, espelhando a pasta REMOTA this_cDirRecLoc) e Page2
696:     * "A Receber" (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc,
697:     * espelhando this_cDirEnvLoc), com Top/Left/Width/Height/ColumnWidths
698:     * transcritos do SCX legado (lstrecloc/dirrecloc/cmdbrowftp de cada
699:     * pagina - o legado reusa o MESMO nome "cmdbrowftp" nas duas paginas; aqui
700:     * os botoes recebem nomes distintos por acao, como ja feito em
701:     * ConfigurarControlesLocal). Os botoes "..." ficam Enabled = .F. porque o
702:     * legado NUNCA implementa Click para eles (nenhum PROCEDURE Click no
703:     * dump) - sao decorativos no original.
704:     *==========================================================================
705:     PROTECTED PROCEDURE ConfigurarControlesFtp()
706:         LOCAL loc_oPag1, loc_oPag2
707: 
708:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
709:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2
710: 
711:         loc_oPag1.AddObject("lst_4c_RecLoc", "ListBox")
712:         WITH loc_oPag1.lst_4c_RecLoc
713:             .Top          = 26
714:             .Left         = 2
715:             .Width        = 286
716:             .Height       = 130
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
736:         ENDWITH
737: 
738:         loc_oPag1.AddObject("cmd_4c_BrowRecLoc", "CommandButton")
739:         WITH loc_oPag1.cmd_4c_BrowRecLoc
740:             .Top       = 2
741:             .Left      = 223
742:             .Width     = 22
743:             .Height    = 22
744:             .FontName  = "Verdana"
745:             .FontSize  = 8

*-- Linhas 801 a 1135:
801:         *-- Activate de qualquer uma das paginas mexendo nos MESMOS botoes
802:         *-- pequenos This.Parent.Parent.cmdtransfere/cmdrecebe (Container1,
803:         *-- aqui cnt_4c_Navegacao.cmd_4c_EnviaFtp/cmd_4c_RecebeFtp).
804:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagFtpEnviadosActivate")
805:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagFtpAReceberActivate")
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * ConfigurarProvedorDialUp - Cria o combo de provedores Dial-Up
810:     * (CboProvedor do legado) e, quando a conexao configurada for do tipo
811:     * Dial-Up ("D"), enumera as conexoes RAS cadastradas no Windows via
812:     * THIS.RasConexao(), preenchendo o array PUBLIC aProvedor que alimenta o
813:     * RowSource do combo (RowSourceType=5, array). Transcricao do trecho
814:     *==========================================================================
815:     PROTECTED PROCEDURE ConfigurarProvedorDialUp()
816:         PUBLIC ARRAY aProvedor(1)
817:         aProvedor(1) = ""
818:         PUBLIC nProvedor
819:         nProvedor = 1
820: 
821:         THIS.AddObject("cbo_4c_Provedor", "ComboBox")
822:         WITH THIS.cbo_4c_Provedor
823:             .Top              = 550
824:             .Left             = 90
825:             .Width            = 235
826:             .Height           = 24
827:             .Style            = 2
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
847:                 THIS.cmd_4c_Conectar.Enabled = .F.
848:             ELSE
849:             ENDIF
850:         ELSE
851:             THIS.cbo_4c_Provedor.Visible = .F.
852:         ENDIF
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * ConfigurarPaginaDados - Ponto de entrada dos controles de DADOS das
857:     * paginas dos 2 PageFrames de navegacao. Cria os controles da metade
858:     * "Local" (ConfigurarControlesLocal) e da metade "FTP"
859:     * (ConfigurarControlesFtp), aplica o guard de disponibilidade que o Init
860:     * legado executa DEPOIS de montar a tela e, por fim, configura o combo de
861:     * provedores Dial-Up (ConfigurarProvedorDialUp) - na MESMA ordem do Init
862:     * legado (controles -> guard de direcao -> CboProvedor/RasConexao).
863:     *==========================================================================
864:     PROTECTED PROCEDURE ConfigurarPaginaDados()
865:         LOCAL loc_oPgLoc, loc_oPgFtp
866: 
867:         THIS.ConfigurarControlesLocal()
868:         THIS.ConfigurarControlesFtp()
869: 
870:         *-- Bloco ".pgfloc.Page1.direnvftp.Value = ThisForm._DirEnvFtp" (e os
871:         *-- outros tres, mais os quatro ToolTipText) que o Init legado executa
872:         *-- DEPOIS de resolver a configuracao: no migrado isso eh o BOParaForm.
873:         THIS.BOParaForm()
874: 
875:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
876:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
877: 
878:         *-- Guard de disponibilidade, transcrito do Init legado (blocos
879:         *-- "if Empt(_DirEnvFtp) .or. empt(_DirRecLoc)" e
880:         *-- "if Empt(_DirRecFtp) .or. empt(_DirEnvLoc)"): faltando um dos dois
881:         *-- diretorios de um sentido, aquele sentido inteiro eh desativado -
882:         *-- a pagina correspondente nos DOIS PageFrames, o botao pequeno de
883:         *-- transferencia individual e o botao grande da barra de acao - e a
884:         *-- navegacao eh levada para a pagina do sentido que continua valido
885:         *-- (o ".pgfloc.PageN.zOrder" / ".pgfftp.PageN.zOrder" do legado).
886:         IF EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirRecLoc)
887:             loc_oPgLoc.Page1.Enabled = .F.
888:             loc_oPgFtp.Page1.Enabled = .F.
889:             loc_oPgLoc.ActivePage    = 2
890:             loc_oPgFtp.ActivePage    = 2
891:             THIS.cmd_4c_Transferir.Enabled = .F.
892:             THIS.Inf("Sistema Configurado somente para Recebimento. Envio Desativado", "G")
893:         ENDIF
894: 
895:         IF EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
896:             loc_oPgLoc.Page2.Enabled = .F.
897:             loc_oPgFtp.Page2.Enabled = .F.
898:             loc_oPgLoc.ActivePage    = 1
899:             loc_oPgFtp.ActivePage    = 1
900:             THIS.cmd_4c_Receber.Enabled = .F.
901:             THIS.Inf("Sistema Configurado somente para Envio. Recebimento Desativado.", "G")
902:         ENDIF
903: 
904:         THIS.ConfigurarProvedorDialUp()
905:     ENDPROC
906: 
907:     *==========================================================================
908:     * PagLocEnviarActivate / PagLocRecebidosActivate - Activate das paginas
909:     * do PageFrame Local: alternam o Enabled dos botoes pequenos de
910:     * transferencia individual (cmd_4c_EnviaFtp/cmd_4c_RecebeFtp), como o
911:     * legado faz em pgfloc.Page1.Activate/Page2.Activate (cmdtransfere/
912:     * cmdrecebe.enabled). Metodos PUBLIC - BINDEVENT exige (regra #3).
913:     *==========================================================================
914:     PROCEDURE PagLocEnviarActivate()
915:         *-- "This.Parent.Parent.pgfftp.Page1.zorder" do legado: leva o
916:         *-- PageFrame FTP para a pagina do MESMO sentido (Enviados). A
917:         *-- atribuicao so acontece quando o valor muda, para o Activate do
918:         *-- outro PageFrame (que sincroniza de volta) nao tornar a disparar.
919:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 1
920:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 1
921:         ENDIF
922:     ENDPROC
923: 
924:     PROCEDURE PagLocRecebidosActivate()
925:         *-- "This.Parent.Parent.pgfftp.Page2.zorder" do legado: leva o
926:         *-- PageFrame FTP para a pagina do MESMO sentido (A Receber).
927:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 2
928:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 2
929:         ENDIF
930:     ENDPROC
931: 
932:     *==========================================================================
933:     * PagFtpEnviadosActivate / PagFtpAReceberActivate - Activate das paginas
934:     * do PageFrame FTP: espelham PagLocEnviarActivate/PagLocRecebidosActivate
935:     * na direcao oposta, sincronizando pgf_4c_Loc.ActivePage e alternando o
936:     * Enabled dos mesmos botoes pequenos de transferencia individual, como o
937:     * legado faz em pgfftp.Page1.Activate/Page2.Activate. Metodos PUBLIC -
938:     * BINDEVENT exige (regra #3).
939:     *==========================================================================
940:     PROCEDURE PagFtpEnviadosActivate()
941:         *-- "This.Parent.Parent.pgfloc.Page1.zorder" do legado: leva o
942:         *-- PageFrame Local para a pagina do MESMO sentido (A Enviar).
943:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 1
944:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 1
945:         ENDIF
946:     ENDPROC
947: 
948:     PROCEDURE PagFtpAReceberActivate()
949:         *-- "This.Parent.Parent.pgfloc.Page2.zorder" do legado: leva o
950:         *-- PageFrame Local para a pagina do MESMO sentido (Recebidos).
951:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 2
952:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 2
953:         ENDIF
954:     ENDPROC
955: 
956:     *==========================================================================
957:     * Inf - Registra uma mensagem no grid de log (grd_4c_Log/cursor_4c_Log)
958:     * e reposiciona o cursor no ultimo registro, equivalente ao PROCEDURE Inf
959:     * do legado (par_cCor: "R"=erro/vermelho, "G"=sucesso/verde, "B"=info/azul)
960:     *==========================================================================
961:     PROTECTED PROCEDURE Inf(par_cTexto, par_cCor)
962:         LOCAL loc_cAliasAnterior
963:         loc_cAliasAnterior = ALIAS()
964: 
965:         IF !USED("cursor_4c_Log")
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
993:     PROTECTED PROCEDURE CToWord(par_cBuffer)
994:         RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
995:                ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
996:                ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
997:                ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
998:     ENDPROC
999: 
1000:     *==========================================================================
1001:     * RasAtivas - Enumera as conexoes Dial-Up ATIVAS no momento via RAS API
1002:     * (equivalente ao PROCEDURE rasativas do legado). Devolve a quantidade de
1003:     * conexoes ativas e preenche o array PUBLIC cujo nome e passado em
1004:     * par_cNomeArray com [indice,1]=handle e [indice,2..4]=dados da conexao
1005:     *==========================================================================
1006:     PROTECTED PROCEDURE RasAtivas(par_cNomeArray)
1007:         LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nCount, loc_nResultado, loc_nPos
1008: 
1009:         DECLARE INTEGER RasEnumConnections IN RASAPI32.DLL ;
1010:             STRING  @loc_cConexoes, ;
1011:             INTEGER @loc_nSize, ;
1012:             INTEGER @loc_nCount
1013: 
1014:         loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
1015:         loc_cConexoes = REPLICATE(loc_cConexao, 16)
1016:         loc_nSize     = LEN(loc_cConexoes)
1017:         loc_nCount    = 0
1018: 
1019:         loc_nResultado = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nCount)
1020: 
1021:         IF loc_nCount > 0
1022:             PUBLIC ARRAY &par_cNomeArray.[loc_nCount, 4]
1023: 
1024:             FOR loc_nPos = 0 TO loc_nCount - 1
1025:                 loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
1026: 
1027:                 &par_cNomeArray.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
1028:                 &par_cNomeArray.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
1029:                 &par_cNomeArray.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
1030:                 &par_cNomeArray.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
1031:             ENDFOR
1032:         ENDIF
1033: 
1034:         RETURN loc_nCount
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * RasConexao - Enumera as conexoes Dial-Up CADASTRADAS no Windows (todas,
1039:     * ativas ou nao) via RAS API (equivalente ao PROCEDURE rasENTRADAS do
1040:     * legado - RasEnumEntries; o PROCEDURE rasconexao legado, que DISCA via
1041:     * RasDial, e o rashangup, que derruba a linha, sao codigo MORTO no legado:
1042:     * nenhum Click nem metodo os chama - quem disca e derruba e o
1043:     * "RUN /N Rundll Rnaui.dll,RnaDial" de cmdconect.Click e do Release, ja
1044:     * transcrito em BtnRedeDialupClick e Destroy). Devolve a quantidade de
1045:     * conexoes cadastradas e preenche o
1046:     * array PUBLIC cujo nome e passado em par_cNomeArray com o nome de cada
1047:     * conexao - fonte do RowSource de cbo_4c_Provedor.
1048:     *==========================================================================
1049:     PROTECTED PROCEDURE RasConexao(par_cNomeArray)
1050:         LOCAL loc_cEntradaVazia, loc_cEntradas, loc_nTamanho, loc_nEntradas, ;
1051:             loc_nResultado, loc_cEntrada, loc_nPos
1052: 
1053:         #DEFINE RAS_MAXENTRYNAME_CX 256
1054: 
1055:         DECLARE INTEGER RasEnumEntries IN RASAPI32.DLL ;
1056:             INTEGER reserved, ;
1057:             STRING  PhoneBox, ;
1058:             STRING  @loc_cEntradas, ;
1059:             INTEGER @loc_nTamanho, ;
1060:             INTEGER @loc_nEntradas
1061: 
1062:         loc_cEntradaVazia = THIS.WordToC(264) + REPLICATE(CHR(0), RAS_MAXENTRYNAME_CX)
1063:         loc_cEntradas     = REPLICATE(loc_cEntradaVazia, 255)
1064:         loc_nTamanho      = LEN(loc_cEntradas)
1065:         loc_nEntradas     = 0
1066: 
1067:         loc_nResultado = RasEnumEntries(0, "", @loc_cEntradas, @loc_nTamanho, @loc_nEntradas)
1068: 
1069:         IF loc_nEntradas = 0
1070:             RETURN 0
1071:         ENDIF
1072: 
1073:         RELEASE &par_cNomeArray.
1074:         PUBLIC ARRAY &par_cNomeArray.[loc_nEntradas]
1075: 
1076:         FOR loc_nPos = 0 TO loc_nEntradas - 1
1077:             loc_cEntrada = SUBSTR(loc_cEntradas, (264 * loc_nPos) + 1, 264)
1078:             &par_cNomeArray.[loc_nPos + 1] = SUBSTR(loc_cEntrada, 5, AT(CHR(0), SUBSTR(loc_cEntrada, 5)) - 1)
1079:         ENDFOR
1080: 
1081:         RETURN loc_nEntradas
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * CarregarDados - Carga de dados do form: lista o diretorio REMOTO do
1086:     * servidor FTP (WinInet: InternetOpen -> InternetConnect ->
1087:     * FtpSetCurrentDirectory -> FtpFindFirstFile/InternetFindNextFile) e
1088:     * popula cursor_4c_FtpServer, que e a fonte de todo o lado "FTP" da tela.
1089:     * Transcricao do PROCEDURE getftpdirectory do legado.
1090:     *
1091:     * par_cDirRemoto : pasta no servidor FTP a listar
1092:     * par_cMascara   : mascara de arquivos (ex.: "*.*")
1093:     * Retorna .T. quando a listagem foi obtida (cursor_4c_FtpServer populado)
1094:     *==========================================================================
1095:     PROCEDURE CarregarDados(par_cDirRemoto, par_cMascara)
1096:         LOCAL loc_nInternet, loc_nFtp, loc_cTempDir, loc_cDiretorio, loc_cMascara
1097:         LOCAL loc_cStruct, loc_nHandle, loc_nResultCode, loc_nResult, loc_lManual
1098:         LOCAL loc_nFResult, loc_lSucesso, loc_cNulo
1099: 
1100:         #DEFINE ERROR_NO_MORE_FILES_FTP        18
1101:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_FTP   1
1102:         #DEFINE INTERNET_DEFAULT_FTP_PORT_FTP  21
1103:         #DEFINE INTERNET_SERVICE_FTP_FTP        1
1104:         #DEFINE INTERNET_FLAG_PASSIVE_FTP 14217728
1105:         #DEFINE MAX_PATH_FTP                  260
1106: 
1107:         loc_cNulo    = CHR(0)
1108:         loc_lSucesso = .F.
1109:         loc_lManual  = .F.
1110:         loc_nInternet = 0
1111:         loc_nFtp      = 0
1112: 
1113:         DECLARE INTEGER FtpFindFirstFile IN WinInet ;
1114:             INTEGER nConnect_Handle, STRING @lpcSearchStr, ;
1115:             STRING @lpcWIN32_FIND_DATA, INTEGER nFlags, INTEGER nContext
1116: 
1117:         DECLARE INTEGER InternetFindNextFile IN WinInet ;
1118:             INTEGER nConnect_Handle, STRING @lpcWIN32_FIND_DATA
1119: 
1120:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1121:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1122:             STRING lpszProxyBypass, LONG dwFlags
1123: 
1124:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1125:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1126:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1127:             LONG dwFlags, LONG dwContext
1128: 
1129:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1130: 
1131:         DECLARE LONG GetLastError IN WIN32API
1132: 
1133:         DECLARE INTEGER FtpGetCurrentDirectory IN WinInet ;
1134:             INTEGER nConnect_Handle, STRING @lpcDirectory, INTEGER @nMax_Path
1135: 

*-- Linhas 1192 a 1379:
1192:                             loc_lSucesso = .T.
1193:                         ENDIF
1194:                     ENDIF
1195: 
1196:                     IF loc_lSucesso
1197:                         IF USED("cursor_4c_FtpServer")
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
1246:     * (transcricao do PROCEDURE crackfile do legado)
1247:     *==========================================================================
1248:     PROTECTED PROCEDURE CrackFile(par_cString)
1249:         LOCAL loc_cArquivo, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1250:         LOCAL loc_cTipo, loc_cAtributos, loc_cBufferData, loc_cDataGravacao
1251:         LOCAL loc_cNulo, loc_nPosNulo
1252: 
1253:         #DEFINE BYTE_1_CF                     1
1254:         #DEFINE BYTE_2_CF                   256
1255:         #DEFINE BYTE_3_CF                 65536
1256:         #DEFINE BYTE_4_CF              16777216
1257:         #DEFINE MAXDWORD_CF          4294967295
1258:         #DEFINE FILE_ATTRIBUTE_DIRECTORY_CF  16
1259:         #DEFINE MAX_PATH_CF                 260
1260: 
1261:         loc_cNulo = CHR(0)
1262: 
1263:         loc_cArquivo = SUBSTR(par_cString, 45, MAX_PATH_CF)
1264:         loc_nPosNulo = AT(loc_cNulo, loc_cArquivo)
1265: 
1266:         IF loc_nPosNulo > 1
1267:             loc_cArquivo = LEFT(loc_cArquivo, loc_nPosNulo - 1)
1268:         ENDIF
1269: 
1270:         *-- Tamanho do arquivo (dois DWORD)
1271:         loc_nSizeHigh = (ASC(SUBSTR(par_cString, 29, 1)) * BYTE_1_CF) + ;
1272:                         (ASC(SUBSTR(par_cString, 30, 1)) * BYTE_2_CF) + ;
1273:                         (ASC(SUBSTR(par_cString, 31, 1)) * BYTE_3_CF) + ;
1274:                         (ASC(SUBSTR(par_cString, 32, 1)) * BYTE_4_CF)
1275: 
1276:         loc_nSizeLow  = (ASC(SUBSTR(par_cString, 33, 1)) * BYTE_1_CF) + ;
1277:                         (ASC(SUBSTR(par_cString, 34, 1)) * BYTE_2_CF) + ;
1278:                         (ASC(SUBSTR(par_cString, 35, 1)) * BYTE_3_CF) + ;
1279:                         (ASC(SUBSTR(par_cString, 36, 1)) * BYTE_4_CF)
1280: 
1281:         loc_nTamanho = (loc_nSizeHigh * MAXDWORD_CF) + loc_nSizeLow
1282: 
1283:         IF THIS.CToWord(SUBSTR(par_cString, 1, 4)) = FILE_ATTRIBUTE_DIRECTORY_CF
1284:             loc_cTipo = "Diret" + CHR(243) + "rio"
1285:         ELSE
1286:             loc_cTipo = "Arquivo"
1287:         ENDIF
1288: 
1289:         *-- Data de gravacao (o legado le create/access/write e so usa write)
1290:         loc_cBufferData   = SUBSTR(par_cString, 21, 8)
1291:         loc_cDataGravacao = THIS.CrackDate(loc_cBufferData)
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
1311: 
1312:         DECLARE INTEGER FileTimeToSystemTime IN Kernel32 ;
1313:             STRING @lpcBuffer, STRING @lpcBuffer2
1314: 
1315:         loc_cEntrada   = SPACE(16)
1316:         loc_nResultado = FileTimeToSystemTime(@par_cBuffer, @loc_cEntrada)
1317: 
1318:         IF loc_nResultado = 0
1319:             *-- Falhou: data default do legado
1320:             loc_cData = "1901/01/01"
1321:         ELSE
1322:             loc_nAno = ASC(SUBSTR(loc_cEntrada, 1, 1)) + (ASC(SUBSTR(loc_cEntrada, 2, 1)) * BYTE_2_CD)
1323:             loc_nMes = ASC(SUBSTR(loc_cEntrada, 3, 1)) + (ASC(SUBSTR(loc_cEntrada, 4, 1)) * BYTE_2_CD)
1324:             loc_nDia = ASC(SUBSTR(loc_cEntrada, 7, 1)) + (ASC(SUBSTR(loc_cEntrada, 8, 1)) * BYTE_2_CD)
1325: 
1326:             loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
1327:                         PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
1328:                         ALLTRIM(STR(loc_nAno))
1329:         ENDIF
1330: 
1331:         RETURN loc_cData
1332:     ENDPROC
1333: 
1334:     *==========================================================================
1335:     * CrackAttributes - Traduz os 4 bytes de atributos do WIN32_FIND_DATA na
1336:     * letra correspondente (transcricao do PROCEDURE crackattributes do
1337:     * legado - DO CASE, portanto devolve APENAS o primeiro atributo que casar)
1338:     *==========================================================================
1339:     PROTECTED PROCEDURE CrackAttributes(par_cBuffer)
1340:         LOCAL loc_cAtributos, loc_nValor
1341: 
1342:         #DEFINE BYTE_1_CA                      1
1343:         #DEFINE BYTE_2_CA                    256
1344:         #DEFINE BYTE_3_CA                  65536
1345:         #DEFINE BYTE_4_CA               16777216
1346: 
1347:         #DEFINE BIT_ATTRIBUTE_READONLY_CA      0
1348:         #DEFINE BIT_ATTRIBUTE_HIDDEN_CA        1
1349:         #DEFINE BIT_ATTRIBUTE_SYSTEM_CA        2
1350:         #DEFINE BIT_ATTRIBUTE_DIRECTORY_CA     4
1351:         #DEFINE BIT_ATTRIBUTE_ARCHIVE_CA       5
1352:         #DEFINE BIT_ATTRIBUTE_NORMAL_CA        7
1353:         #DEFINE BIT_ATTRIBUTE_TEMPORARY_CA     8
1354:         #DEFINE BIT_ATTRIBUTE_COMPRESSED_CA   11
1355:         #DEFINE BIT_ATTRIBUTE_OFFLINE_CA      12
1356: 
1357:         loc_cAtributos = ""
1358: 
1359:         loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * BYTE_1_CA) + ;
1360:                      (ASC(SUBSTR(par_cBuffer, 2, 1)) * BYTE_2_CA) + ;
1361:                      (ASC(SUBSTR(par_cBuffer, 3, 1)) * BYTE_3_CA) + ;
1362:                      (ASC(SUBSTR(par_cBuffer, 4, 1)) * BYTE_4_CA)
1363: 
1364:         DO CASE
1365:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_READONLY_CA)
1366:                 loc_cAtributos = loc_cAtributos + "R"
1367:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_HIDDEN_CA)
1368:                 loc_cAtributos = loc_cAtributos + "H"
1369:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_SYSTEM_CA)
1370:                 loc_cAtributos = loc_cAtributos + "S"
1371:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_DIRECTORY_CA)
1372:                 loc_cAtributos = loc_cAtributos + "D"
1373:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_ARCHIVE_CA)
1374:                 loc_cAtributos = loc_cAtributos + "A"
1375:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_NORMAL_CA)
1376:                 loc_cAtributos = loc_cAtributos + "N"
1377:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_TEMPORARY_CA)
1378:                 loc_cAtributos = loc_cAtributos + "T"
1379:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_COMPRESSED_CA)

*-- Linhas 1387 a 1433:
1387: 
1388:     *==========================================================================
1389:     * InErrorCase - Traduz o codigo devolvido por GetLastError() no nome
1390:     * simbolico do erro WinInet/Win32 (transcricao do PROCEDURE inerrorcase
1391:     * do legado, incluindo o formato final "[ <codigo> : <nome> ]")
1392:     *==========================================================================
1393:     PROTECTED PROCEDURE InErrorCase(par_nErro)
1394:         LOCAL loc_cMensagem
1395: 
1396:         #DEFINE ERROR_INTERNET_BASE_IE 12000
1397: 
1398:         DO CASE
1399:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 1
1400:                 loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
1401:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 2
1402:                 loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
1403:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 3
1404:                 loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
1405:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 4
1406:                 loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
1407:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 5
1408:                 loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
1409:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 6
1410:                 loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
1411:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 7
1412:                 loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
1413:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 8
1414:                 loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
1415:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 9
1416:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
1417:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 10
1418:                 loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
1419:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 11
1420:                 loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
1421:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 12
1422:                 loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
1423:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 13
1424:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
1425:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 14
1426:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
1427:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 15
1428:                 loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
1429:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 16
1430:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
1431:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 17
1432:                 loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
1433:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 18

*-- Linhas 1549 a 1680:
1549: 
1550:     *==========================================================================
1551:     * SecToHour - Formata uma quantidade de segundos como "Nh, Nm, Ns"
1552:     * (transcricao do PROCEDURE sectohour do legado)
1553:     *==========================================================================
1554:     PROTECTED PROCEDURE SecToHour(par_nSegundos)
1555:         LOCAL loc_nHora, loc_nMinuto, loc_nSegundo
1556: 
1557:         loc_nHora    = INT(par_nSegundos / 3600)
1558:         loc_nMinuto  = MOD(INT(par_nSegundos / 60), 60)
1559:         loc_nSegundo = MOD(par_nSegundos, 60)
1560: 
1561:         RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
1562:                IIF(loc_nMinuto > 0, ALLTRIM(STR(loc_nMinuto)) + " m, ", "") + ;
1563:                ALLTRIM(STR(loc_nSegundo)) + " s"
1564:     ENDPROC
1565: 
1566:     *==========================================================================
1567:     * Processa - Alimenta o grid de progresso (grd_4c_Progresso /
1568:     * cursor_4c_Progresso) durante uma transferencia, nos 3 estagios do
1569:     * legado: "I"=iniciando (cria a linha), "A"=em andamento (atualiza bytes
1570:     * e percentual), "C"=concluido (fecha a linha e registra no log).
1571:     * Transcricao do PROCEDURE processa do legado.
1572:     *
1573:     * DIVERGENCIA DOCUMENTADA: o legado chama ThisForm.FileCtrlUp(...) neste
1574:     * metodo, mas o controle ActiveX que FileCtrlUp manipula (ThisForm.
1575:     * FileControl) NAO EXISTE no SCX - nao consta da lista de objetos do
1576:     * dump, so das linhas "With ThisForm.FileControl" do proprio FileCtrlUp.
1577:     * Reproduzir essas chamadas geraria "Unknown member FILECONTROL" em
1578:     * runtime, entao elas ficam de fora; o percentual segue visivel na coluna
1579:     * Status do grid e no lbl_4c_Progresso, como no legado.
1580:     *==========================================================================
1581:     PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cPastaLocal, ;
1582:             par_cPastaHost, par_nTransferido, par_nBuffer, ;
1583:             par_nSegIniciais, par_nSegundos, par_cStatus)
1584: 
1585:         LOCAL loc_nSegundos, loc_cTempoEstimado, loc_cTempoDecorrido, ;
1586:             loc_nIndice, loc_nPos
1587: 
1588:         loc_nSegundos = par_nSegundos
1589: 
1590:         IF loc_nSegundos = 0
1591:             *-- Valor minimo de tempo de transferencia (evita divisao por zero)
1592:             loc_nSegundos = 0.001
1593:         ENDIF
1594: 
1595:         IF !USED("cursor_4c_Progresso")
1596:             RETURN
1597:         ENDIF
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
1642:                     *-- lista de DESTINO e, se configurado, apaga o arquivo
1643:                     *-- de ORIGEM (this_lDelLocal para envio / this_lDelHost
1644:                     *-- para recebimento) e o remove da lista de origem
1645:                     IF par_cPastaLocal == THIS.this_oBusinessObject.this_cDirEnvFtp
1646:                         *-- Enviando arquivos para o FTP: registra em
1647:                         *-- lst_4c_RecLoc (pgf_4c_Ftp.Page1 "Enviados")
1648:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1.lst_4c_RecLoc
1649:                             loc_nIndice = .ListCount + 1
1650:                             .AddItem(par_cArquivo, loc_nIndice, 1)
1651:                             .AddListItem(STR(par_nTamanho), loc_nIndice, 2)
1652:                             .AddListItem(STR(par_nTransferido), loc_nIndice, 3)
1653:                             .Refresh()
1654:                         ENDWITH
1655: 
1656:                         IF THIS.this_oBusinessObject.this_lDelLocal
1657:                             THIS.Inf("Exclu" + CHR(237) + "ndo o arquivo local " + par_cPastaLocal + par_cArquivo, "B")
1658: 
1659:                             ERASE (par_cPastaLocal + par_cArquivo)
1660: 
1661:                             IF FILE(par_cPastaLocal + par_cArquivo)
1662:                                 THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cPastaLocal + par_cArquivo, "R")
1663:                             ELSE
1664:                                 THIS.Inf("Arquivo Local " + par_cPastaLocal + par_cArquivo + " foi exclu" + CHR(237) + "do com sucesso", "B")
1665:                             ENDIF
1666: 
1667:                             *-- Remove o arquivo da lista de origem (lst_4c_EnvFtp)
1668:                             WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1669:                                 FOR loc_nPos = 1 TO .ListCount
1670:                                     IF UPPER(ALLTRIM(.List(loc_nPos, 1))) == UPPER(par_cArquivo)
1671:                                         .RemoveItem(loc_nPos)
1672:                                         EXIT
1673:                                     ENDIF
1674:                                 ENDFOR
1675:                             ENDWITH
1676:                         ENDIF
1677:                     ENDIF
1678: 
1679:                     IF par_cPastaHost == THIS.this_oBusinessObject.this_cDirEnvLoc
1680:                         *-- Recebendo do FTP: registra em lst_4c_RecFtp

*-- Linhas 1711 a 1791:
1711:                         ENDIF
1712:                     ENDIF
1713:                 ENDIF
1714:         ENDCASE
1715: 
1716:         THIS.grd_4c_Progresso.Refresh()
1717:     ENDPROC
1718: 
1719:     *==========================================================================
1720:     * MontaContainer - "Monta os pageframes com todos os arquivos a enviar e
1721:     * receber" (equivalente ao PROCEDURE montacontainer do legado): carrega a
1722:     * listagem do diretorio REMOTO (via THIS.CarregarDados), filtra pela
1723:     * mascara this_cTpRec e povoa lst_4c_EnvLoc (Page2 "A Receber" do
1724:     * pgf_4c_Ftp), e lista a pasta LOCAL de envio em lst_4c_EnvFtp,
1725:     * registrando no log o mesmo roteiro do legado.
1726:     *
1727:     * DIVERGENCIA DOCUMENTADA (fiel ao legado, nao simplificada): o cursor
1728:     * remoto (cursor_4c_FtpServer) nao pode ser filtrado por wildcard
1729:     * diretamente - o legado grava cada NOME num arquivo VAZIO dentro de uma
1730:     * pasta TEMPORARIA (Strtofile) e roda ADIR com a mascara this_cTpRec
1731:     * sobre essa pasta, ja que ADIR so filtra arquivos REAIS em disco.
1732:     * Reproduzido aqui com SYS(2023) (pasta temp do Windows) + MKDIR +
1733:     * STRTOFILE + ADIR + ERASE, na MESMA ordem - necessario porque
1734:     * this_cTpRec vem da configuracao da empresa (SigCdEmp) e PODE nao ser
1735:     * "*.*".
1736:     *==========================================================================
1737:     PROTECTED PROCEDURE MontaContainer()
1738:         LOCAL loc_lSucesso, loc_nArquivosLocais, loc_nPos, loc_cPastaTemp, ;
1739:             loc_cDefaultAnterior, loc_nArquivosMascara, loc_nCont, loc_nItem
1740:         LOCAL ARRAY loc_aArquivosLocais[1], loc_aArquivosMascara[1]
1741: 
1742:         loc_lSucesso = .T.
1743: 
1744:         THIS.Inf("Carregando os par" + CHR(226) + "metros da tela... Aguarde", "B")
1745: 
1746:         *-- A Receber do Host: lista o diretorio REMOTO no servidor FTP e
1747:         *-- filtra pela mascara this_cTpRec antes de povoar lst_4c_EnvLoc
1748:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
1749:             THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com o servidor FTP no endere" + CHR(231) + "o " + ;
1750:                 THIS.this_oBusinessObject.this_cFtpAdd, "B")
1751: 
1752:             IF THIS.CarregarDados(THIS.this_oBusinessObject.this_cDirEnvLoc, "*.*") AND USED("cursor_4c_FtpServer")
1753:                 THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc.Clear()
1754: 
1755:                 loc_cDefaultAnterior = SYS(5) + SYS(2003)
1756:                 loc_cPastaTemp       = ADDBS(SYS(2023)) + SYS(3)
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
1785:                 ENDFOR
1786:                 IF ADIR(loc_aArquivosMascara) = 0
1787:                     SET DEFAULT TO (SYS(2023))
1788:                     RMDIR (loc_cPastaTemp)
1789:                 ENDIF
1790: 
1791:                 SET DEFAULT TO (loc_cDefaultAnterior)

*-- Linhas 1805 a 1881:
1805: 
1806:         *-- Local -> Host (A Enviar para o Host): lista a pasta LOCAL de onde
1807:         *-- os arquivos saem e povoa lst_4c_EnvFtp (equivalente ao bloco
1808:         *-- "Local -> Host" do PROCEDURE montacontainer legado - nome,
1809:         *-- tamanho e data de cada arquivo, ordenados por nome)
1810:         IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp)
1811:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Clear()
1812: 
1813:             loc_nArquivosLocais = ADIR(loc_aArquivosLocais, ;
1814:                 ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp)) + ;
1815:                 ALLTRIM(THIS.this_oBusinessObject.this_cTpEnv))
1816: 
1817:             IF loc_nArquivosLocais > 0
1818:                 ASORT(loc_aArquivosLocais)
1819: 
1820:                 FOR loc_nPos = 1 TO loc_nArquivosLocais
1821:                     WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1822:                         .AddItem(loc_aArquivosLocais[loc_nPos, 1], loc_nPos, 1)
1823:                         .AddListItem(STR(loc_aArquivosLocais[loc_nPos, 2], 10, 0), loc_nPos, 2)
1824:                         .AddListItem(DTOC(loc_aArquivosLocais[loc_nPos, 3]), loc_nPos, 3)
1825:                     ENDWITH
1826:                 ENDFOR
1827:             ENDIF
1828: 
1829:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Refresh()
1830: 
1831:             THIS.Inf("Lista de arquivos Locais j" + CHR(225) + " carregada do " + ;
1832:                 THIS.this_oBusinessObject.this_cDirEnvFtp, "B")
1833:             THIS.Inf("Pronto para a Transfer" + CHR(234) + "ncia... Clique no bot" + CHR(227) + "o (Transfere)", "G")
1834:         ENDIF
1835: 
1836:         RETURN loc_lSucesso
1837:     ENDPROC
1838: 
1839:     *==========================================================================
1840:     * VerificarArquivoFtp - Confirma que um arquivo existe no servidor FTP,
1841:     * tentando abri-lo para leitura (equivalente ao PROCEDURE rasfile do
1842:     * legado). Usado antes de receber um arquivo e, apos o envio, para
1843:     * confirmar que o arquivo renomeado ficou disponivel no destino.
1844:     *==========================================================================
1845:     PROTECTED FUNCTION VerificarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1846:         LOCAL loc_nInternet, loc_nFtp, loc_nArquivoFtp, loc_lOk
1847: 
1848:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_VF   1
1849:         #DEFINE INTERNET_DEFAULT_FTP_PORT_VF  21
1850:         #DEFINE INTERNET_SERVICE_FTP_VF        1
1851:         #DEFINE INTERNET_FLAG_PASSIVE_VF 14217728
1852:         #DEFINE FTP_TRANSFER_TYPE_BINARY_VF    2
1853:         #DEFINE GENERIC_READ_VF       2147483648
1854: 
1855:         loc_lOk = .F.
1856: 
1857:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1858:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1859:             STRING lpszProxyBypass, LONG dwFlags
1860: 
1861:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1862:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1863:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1864:             LONG dwFlags, LONG dwContext
1865: 
1866:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1867: 
1868:         DECLARE LONG GetLastError IN WIN32API
1869: 
1870:         DECLARE LONG FtpOpenFile IN "wininet.dll" ;
1871:             LONG hFtpSession, STRING lpszFileName, INTEGER fdwAccess, ;
1872:             INTEGER dwFlags, INTEGER dwContext
1873: 
1874:         THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com a Internet", "G")
1875:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_VF, "", "", 0)
1876: 
1877:         IF loc_nInternet = 0
1878:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1879:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1880:             RETURN .F.
1881:         ENDIF

*-- Linhas 1916 a 1959:
1916: 
1917:     *==========================================================================
1918:     * RenomearArquivoFtp - Renomeia um arquivo no servidor FTP (equivalente ao
1919:     * PROCEDURE renameftpfile do legado). Usado por EnviarArquivoFtp para
1920:     * restaurar o nome definitivo do arquivo apos o upload do temporario.
1921:     *==========================================================================
1922:     PROTECTED FUNCTION RenomearArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoAntigo, par_cArquivoNovo)
1923:         LOCAL loc_nInternet, loc_nFtp, loc_nResultado, loc_cAntigo, loc_cNovo
1924: 
1925:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_NF   1
1926:         #DEFINE INTERNET_DEFAULT_FTP_PORT_NF  21
1927:         #DEFINE INTERNET_SERVICE_FTP_NF        1
1928:         #DEFINE INTERNET_FLAG_PASSIVE_NF 14217728
1929: 
1930:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1931:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1932:             STRING lpszProxyBypass, LONG dwFlags
1933: 
1934:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1935:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1936:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1937:             LONG dwFlags, LONG dwContext
1938: 
1939:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1940: 
1941:         DECLARE LONG GetLastError IN WIN32API
1942: 
1943:         DECLARE INTEGER FtpRenameFile IN WinInet ;
1944:             INTEGER nConnect_Handle, STRING @lpcRemoteFile, STRING @lpcNewFile
1945: 
1946:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_NF, "", "", 0)
1947:         IF loc_nInternet = 0
1948:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1949:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1950:             RETURN .F.
1951:         ENDIF
1952: 
1953:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_NF, ;
1954:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_NF, INTERNET_FLAG_PASSIVE_NF, 0)
1955:         IF loc_nFtp = 0
1956:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
1957:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1958:             InternetCloseHandle(loc_nInternet)
1959:             RETURN .F.

*-- Linhas 1972 a 2015:
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
1991:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1992:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1993:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1994:             LONG dwFlags, LONG dwContext
1995: 
1996:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
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

*-- Linhas 2035 a 2078:
2035: 
2036:     *==========================================================================
2037:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2038:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2039:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2040:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia
2041:     * o temporario para o nome definitivo e confirma a existencia final com
2042:     * VerificarArquivoFtp.
2043:     *
2044:     * DIVERGENCIA DOCUMENTADA: o legado, apos renomear, ainda chama
2045:     * ThisForm.raslisarq(...) para recarregar uma listagem completa do
2046:     * diretorio remoto (cursor "ftpserver", nao utilizado por nenhum outro
2047:     * ponto do form) so para obter um booleano de confirmacao - na pratica
2048:     * sempre .T. quando a conexao permanece de pe, exatamente a mesma garantia
2049:     * que VerificarArquivoFtp ja fornece de forma direta. Reproduzir essa
2050:     * listagem completa duplicaria CarregarDados/CrackFile sem mudar o
2051:     * resultado observavel (loc_lOk), entao o passo fica resumido a
2052:     * VerificarArquivoFtp - mantendo o efeito (confirmar sucesso do envio),
2053:     * sem inventar comportamento novo.
2054:     *==========================================================================
2055:     PROTECTED FUNCTION EnviarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoLocal, par_cArquivoRemoto)
2056:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2057:             loc_nSegIni, loc_nSegFim, loc_lOk
2058: 
2059:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_EF   1
2060:         #DEFINE INTERNET_DEFAULT_FTP_PORT_EF  21
2061:         #DEFINE INTERNET_SERVICE_FTP_EF        1
2062:         #DEFINE INTERNET_FLAG_PASSIVE_EF 14217728
2063:         #DEFINE FTP_TRANSFER_TYPE_BINARY_EF    2
2064: 
2065:         loc_lOk = .F.
2066: 
2067:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2068:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2069:             STRING lpszProxyBypass, LONG dwFlags
2070: 
2071:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2072:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2073:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2074:             LONG dwFlags, LONG dwContext
2075: 
2076:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2077: 
2078:         DECLARE LONG GetLastError IN WIN32API

*-- Linhas 2158 a 2201:
2158: 
2159:     *==========================================================================
2160:     * ReceberArquivoFtp - Recebe um arquivo do servidor FTP para uma pasta
2161:     * LOCAL (equivalente ao PROCEDURE rasftpget do legado): baixa o conteudo
2162:     * com FtpGetFile sob um nome LOCAL temporario (extensao trocada por
2163:     * ".ftp") e, tendo sucesso, renomeia para o nome definitivo.
2164:     *==========================================================================
2165:     PROTECTED FUNCTION ReceberArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto, par_cArquivoLocal)
2166:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2167:             loc_nSegIni, loc_nSegFim, loc_lOk
2168: 
2169:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_GF    1
2170:         #DEFINE INTERNET_DEFAULT_FTP_PORT_GF   21
2171:         #DEFINE INTERNET_SERVICE_FTP_GF         1
2172:         #DEFINE INTERNET_FLAG_PASSIVE_GF  14217728
2173:         #DEFINE FILE_ATTRIBUTE_NORMAL_GF      128
2174:         #DEFINE FTP_TRANSFER_TYPE_BINARY_GF     2
2175: 
2176:         loc_lOk     = .F.
2177:         loc_nTamanho = 0
2178: 
2179:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2180:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2181:             STRING lpszProxyBypass, LONG dwFlags
2182: 
2183:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2184:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2185:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2186:             LONG dwFlags, LONG dwContext
2187: 
2188:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2189: 
2190:         DECLARE LONG GetLastError IN WIN32API
2191: 
2192:         DECLARE INTEGER FtpGetFile IN "wininet.dll" ;
2193:             LONG hFtpSession, STRING lpszRemoteFile, STRING lpszNewFile, ;
2194:             LONG fFailIfExist, LONG dwFlagsAndAttributes, LONG dwFlags, LONG dwContext
2195: 
2196:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_GF, "", "", 0)
2197:         IF loc_nInternet = 0
2198:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2199:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2200:             RETURN .F.
2201:         ENDIF

*-- Linhas 2256 a 2345:
2256: 
2257:     *==========================================================================
2258:     * Transferir / Receber - Disparam o envio/recebimento de arquivos
2259:     * (equivalentes aos PROCEDURE transfere/recebe do legado, chamados com
2260:     * par_cModo = "A" para todos os arquivos ou "I" para selecao individual).
2261:     * A origem eh o mesmo ListBox que MontaContainer/lst_4c_* ja mantem
2262:     * populado (lst_4c_EnvFtp para envio, lst_4c_EnvLoc para recebimento);
2263:     * o loop percorre a selecao (ou todos, conforme par_cModo) chamando
2264:     * EnviarArquivoFtp/ReceberArquivoFtp arquivo a arquivo, replicando o
2265:     * DO CASE ptptrans == "I"/"A" e o guard de selecao vazia do legado.
2266:     *==========================================================================
2267:     PROTECTED PROCEDURE Transferir(par_cModo)
2268:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2269:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoRemoto
2270:         LOCAL ARRAY loc_aArquivos[1]
2271: 
2272:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2273:         *-- qualquer caminho: e dali que saem this_cDirEnvFtp/this_cDirRecLoc
2274:         IF !THIS.FormParaBO()
2275:             RETURN .F.
2276:         ENDIF
2277: 
2278:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
2279:         loc_nQtd = loc_oObj.ListCount
2280: 
2281:         IF loc_nQtd <= 0
2282:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
2283:             RETURN .F.
2284:         ENDIF
2285: 
2286:         DIMENSION loc_aArquivos(loc_nQtd)
2287:         loc_nSelecionados = 0
2288: 
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
2308: 
2309:         THIS.HabilitarCampos(.F.)
2310: 
2311:         loc_lOk = .T.
2312:         FOR loc_nPos = 1 TO loc_nQtd
2313:             loc_cArquivo = loc_aArquivos(loc_nPos)
2314: 
2315:             IF EMPTY(ALLTRIM(loc_cArquivo))
2316:                 LOOP
2317:             ENDIF
2318: 
2319:             loc_cArquivoLocal  = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp + ALLTRIM(loc_cArquivo))
2320:             loc_cArquivoRemoto = LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cDirRecLoc + ALLTRIM(loc_cArquivo)))
2321: 
2322:             THIS.Inf("Processando o arquivo Local " + loc_cArquivoLocal + " para enviar ao FTP", "G")
2323: 
2324:             fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2325:                 SUBSTR("INICIANDO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2326: 
2327:             IF THIS.EnviarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2328:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2329:                     THIS.this_oBusinessObject.this_cFtpPass, ;
2330:                     loc_cArquivoLocal, loc_cArquivoRemoto)
2331:                 loc_lOk = .T.
2332:                 THIS.Inf("Arquivo Local " + loc_cArquivoLocal + " transferido para FTP.", "G")
2333:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2334:                     SUBSTR("ENVIO OK DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2335:             ELSE
2336:                 loc_lOk = .F.
2337:                 THIS.Inf("Problema: Arquivo Local " + loc_cArquivoLocal + " N" + CHR(227) + "O foi transferido para o FTP.", "R")
2338:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2339:                     SUBSTR("FALHA NO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2340:                 EXIT
2341:             ENDIF
2342:         ENDFOR
2343: 
2344:         IF loc_lOk
2345:             THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de transfer" + CHR(234) + "ncia Conclu" + CHR(237) + "da", "B")

*-- Linhas 2352 a 2433:
2352:         RETURN loc_lOk
2353:     ENDPROC
2354: 
2355:     PROTECTED PROCEDURE Receber(par_cModo)
2356:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2357:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoFtp
2358:         LOCAL ARRAY loc_aArquivos[1]
2359: 
2360:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2361:         *-- qualquer caminho: e dali que saem this_cDirEnvLoc/this_cDirRecFtp
2362:         IF !THIS.FormParaBO()
2363:             RETURN .F.
2364:         ENDIF
2365: 
2366:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
2367:         loc_nQtd = loc_oObj.ListCount
2368: 
2369:         IF loc_nQtd <= 0
2370:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
2371:             RETURN .F.
2372:         ENDIF
2373: 
2374:         DIMENSION loc_aArquivos(loc_nQtd)
2375:         loc_nSelecionados = 0
2376: 
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
2396: 
2397:         THIS.HabilitarCampos(.F.)
2398: 
2399:         loc_lOk = .T.
2400:         FOR loc_nPos = 1 TO loc_nQtd
2401:             loc_cArquivo = loc_aArquivos(loc_nPos)
2402: 
2403:             IF EMPTY(ALLTRIM(loc_cArquivo))
2404:                 LOOP
2405:             ENDIF
2406: 
2407:             loc_cArquivoFtp   = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvLoc + ALLTRIM(loc_cArquivo))
2408:             loc_cArquivoLocal = ALLTRIM(THIS.this_oBusinessObject.this_cDirRecFtp + ALLTRIM(loc_cArquivo))
2409: 
2410:             THIS.Inf("Processando o arquivo " + loc_cArquivoFtp + " para receber do FTP", "G")
2411: 
2412:             fGravarLog("X", THIS.Name, "REC FTP", ;
2413:                 SUBSTR("INICIANDO RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2414: 
2415:             IF THIS.VerificarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2416:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2417:                     THIS.this_oBusinessObject.this_cFtpPass, loc_cArquivoFtp)
2418:                 IF THIS.ReceberArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2419:                         THIS.this_oBusinessObject.this_cFtpUser, ;
2420:                         THIS.this_oBusinessObject.this_cFtpPass, ;
2421:                         loc_cArquivoFtp, loc_cArquivoLocal)
2422:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2423:                         SUBSTR("RECEPCAO OK DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2424:                     loc_lOk = .T.
2425:                 ELSE
2426:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2427:                         SUBSTR("FALHA NA RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2428:                     loc_lOk = .F.
2429:                 ENDIF
2430:             ELSE
2431:                 loc_lOk = .F.
2432:             ENDIF
2433: 

*-- Linhas 2463 a 2506:
2463:     * PROTECTED porque FormBase.BOParaForm eh PROTECTED - VFP9 nao permite
2464:     * ALARGAR o escopo de um metodo herdado.
2465:     *==========================================================================
2466:     PROTECTED PROCEDURE BOParaForm()
2467:         LOCAL loc_oPgLoc, loc_oPgFtp
2468: 
2469:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
2470:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
2471: 
2472:         WITH THIS.this_oBusinessObject
2473:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.Value       = .this_cDirEnvFtp
2474:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.ToolTipText = .this_cDirEnvFtp
2475: 
2476:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.Value       = .this_cDirRecFtp
2477:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.ToolTipText = .this_cDirRecFtp
2478: 
2479:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.Value       = .this_cDirRecLoc
2480:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.ToolTipText = .this_cDirRecLoc
2481: 
2482:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.Value       = .this_cDirEnvLoc
2483:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.ToolTipText = .this_cDirEnvLoc
2484:         ENDWITH
2485:     ENDPROC
2486: 
2487:     *==========================================================================
2488:     * FormParaBO - Le de volta os quatro campos de diretorio da tela para as
2489:     * properties do BO, aplicando a MESMA normalizacao do Init legado:
2490:     *   pasta LOCAL  -> ADDBS(LOWER(ALLTRIM(x)))
2491:     *   pasta REMOTA -> LOWER(ALLTRIM(x)) + "/" quando ainda nao termina em "/"
2492:     * (iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir+"/") do legado)
2493:     *
2494:     * Campo em BRANCO nao sobrescreve a property: sem isso um campo apagado
2495:     * zeraria a configuracao resolvida e a transferencia passaria a montar
2496:     * caminho a partir de "" - e os guards de sentido de ConfigurarPaginaDados
2497:     * (que rodam no Init) nao seriam reavaliados. Pasta LOCAL que nao existe
2498:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2499:     *
2500:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2501:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2502:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2503:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2504:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2505:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2506:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao

*-- Linhas 2528 a 2685:
2528:         *-- checagem com "if !empt(_DirEnvFtp) and !DIRECTORY(_DirEnvFtp)")
2529:         IF !EMPTY(loc_cEnvFtp) AND !DIRECTORY(loc_cEnvFtp)
2530:             THIS.Inf("A pasta local de envio " + loc_cEnvFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2531:             MsgAviso("A pasta local de envio informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cEnvFtp, ;
2532:                 "Aten" + CHR(231) + CHR(227) + "o")
2533:             loc_lOk = .F.
2534:         ENDIF
2535: 
2536:         IF !EMPTY(loc_cRecFtp) AND !DIRECTORY(loc_cRecFtp)
2537:             THIS.Inf("A pasta local de recebimento " + loc_cRecFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2538:             MsgAviso("A pasta local de recebimento informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cRecFtp, ;
2539:                 "Aten" + CHR(231) + CHR(227) + "o")
2540:             loc_lOk = .F.
2541:         ENDIF
2542: 
2543:         IF loc_lOk
2544:             WITH THIS.this_oBusinessObject
2545:                 IF !EMPTY(loc_cEnvFtp)
2546:                     .this_cDirEnvFtp = ADDBS(loc_cEnvFtp)
2547:                 ENDIF
2548: 
2549:                 IF !EMPTY(loc_cRecFtp)
2550:                     .this_cDirRecFtp = ADDBS(loc_cRecFtp)
2551:                 ENDIF
2552: 
2553:                 IF !EMPTY(loc_cRecLoc)
2554:                     .this_cDirRecLoc = IIF(RIGHT(loc_cRecLoc, 1) == "/", loc_cRecLoc, loc_cRecLoc + "/")
2555:                 ENDIF
2556: 
2557:                 IF !EMPTY(loc_cEnvLoc)
2558:                     .this_cDirEnvLoc = IIF(RIGHT(loc_cEnvLoc, 1) == "/", loc_cEnvLoc, loc_cEnvLoc + "/")
2559:                 ENDIF
2560:             ENDWITH
2561: 
2562:             *-- Reescreve a tela com o valor JA normalizado, para o que o
2563:             *-- usuario ve ser exatamente o que sera usado na transferencia
2564:             THIS.BOParaForm()
2565:         ENDIF
2566: 
2567:         RETURN loc_lOk
2568:     ENDFUNC
2569: 
2570:     *==========================================================================
2571:     * CarregarLista - Ponto unico de (re)carga das listas da tela: le os
2572:     * diretorios da tela para o BO, repovoa as quatro listas via MontaContainer
2573:     * e repinta os dois grids.
2574:     *
2575:     * O GO TOP + Refresh do fim nao eh enfeite: popular cursor NAO repinta
2576:     * grade em VFP9 (o legado sempre fecha com "go bott" + "GrdInf.refresh"),
2577:     * e sem isso a grade fica visualmente vazia com o cursor cheio.
2578:     *
2579:     * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
2580:     * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
2581:     *==========================================================================
2582:     PROCEDURE CarregarLista()
2583:         LOCAL loc_lSucesso
2584: 
2585:         loc_lSucesso = .F.
2586: 
2587:         IF !THIS.FormParaBO()
2588:             RETURN .F.
2589:         ENDIF
2590: 
2591:         loc_lSucesso = THIS.MontaContainer()
2592: 
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
2618:     *   ThisForm.cmdsair.enabled    = <flag>
2619:     *
2620:     * par_lHabilitar = .F. durante a transferencia (trava a tela), .T. ao
2621:     * terminar. cmd_4c_Encerrar segue o flag, como cmdsair no legado.
2622:     *
2623:     * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama
2624:     * de fora da classe.
2625:     *==========================================================================
2626:     PROCEDURE HabilitarCampos(par_lHabilitar)
2627:         LOCAL loc_lHabilitar
2628: 
2629:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2630: 
2631:         *-- "ThisForm.Container1.enabled = .t." do legado: fica .T. tanto ao
2632:         *-- iniciar quanto ao terminar a transferencia (transcrito, nao
2633:         *-- "corrigido" - as listas continuam navegaveis durante a operacao)
2634:         THIS.cnt_4c_Navegacao.Enabled  = .T.
2635:         THIS.cmd_4c_Transferir.Enabled = loc_lHabilitar
2636:         THIS.cmd_4c_Receber.Enabled    = loc_lHabilitar
2637:         THIS.cmd_4c_Encerrar.Enabled   = loc_lHabilitar
2638:     ENDPROC
2639: 
2640:     *==========================================================================
2641:     * BtnConectarClick - Click de cmd_4c_Conectar (cmdload do legado): valida
2642:     * o tipo de conexao (Dial-Up/Banda Larga), tenta conectar quando
2643:     * necessario e, tendo sucesso, habilita os botoes de transferencia
2644:     *==========================================================================
2645:     PROCEDURE BtnConectarClick()
2646:         LOCAL loc_lOk
2647:         loc_lOk = .T.
2648: 
2649:         THIS.cmd_4c_Conectar.Enabled = .F.
2650: 
2651:         DO CASE
2652:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2653:                 IF THIS.RasAtivas("aAtivas") > 0
2654:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2655:                     *-- "=ThisForm.MontaContainer()" seguido de "lOk = .t." no
2656:                     *-- legado: o retorno da carga eh DESCARTADO de proposito -
2657:                     *-- listagem que falha nao desabilita a transferencia
2658:                     THIS.CarregarLista()
2659:                     loc_lOk = .T.
2660:                 ELSE
2661:                     THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + " Internet N" + CHR(227) + "o detectada", "R")
2662:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2663:                     THIS.cmd_4c_RedeDialup.Visible = .T.
2664:                     loc_lOk = .F.
2665:                 ENDIF
2666: 
2667:             CASE THIS.this_oBusinessObject.this_cTpConnect == "B"
2668:                 THIS.Inf("Aguarde a inicializa" + CHR(231) + CHR(227) + "o das rotinas...", "B")
2669:                 THIS.Inf("Checando diret" + CHR(243) + "rios locais e conex" + CHR(245) + "es de rede...", "B")
2670:                 *-- idem ao ramo "D": o legado faz "lOk = .t." e so depois
2671:                 *-- "=ThisForm.MontaContainer()", descartando o retorno
2672:                 loc_lOk = .T.
2673:                 THIS.CarregarLista()
2674: 
2675:             OTHERWISE
2676:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2677:                 loc_lOk = .F.
2678:         ENDCASE
2679: 
2680:         IF loc_lOk
2681:             THIS.cnt_4c_Navegacao.Enabled                  = .T.
2682:             THIS.cmd_4c_Transferir.Enabled                 = .T.
2683:             THIS.cmd_4c_Receber.Enabled                    = .T.
2684:             THIS.cmd_4c_Encerrar.Enabled                   = .T.
2685:             THIS.cmd_4c_Conectar.Enabled                   = .F.

*-- Linhas 2701 a 2824:
2701:     * selecionado no combo (CboProvedor, adicionado junto com os demais
2702:     * controles de dados do PageFrame)
2703:     *==========================================================================
2704:     PROCEDURE BtnRedeDialupClick()
2705:         LOCAL loc_cProvedor, loc_cComando
2706: 
2707:         DO CASE
2708:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2709:                 IF THIS.RasAtivas("aAtivas") > 0
2710:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2711:                 ELSE
2712:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2713:                     *-- VFP9 nao faz short-circuit em AND/OR: TYPE() e o valor
2714:                     *-- da variavel tem de ser checados em IFs separados, senao
2715:                     *-- "nProvedor > 0" estoura "Variable NPROVEDOR is not found"
2716:                     *-- antes de nProvedor existir (CboProvedor, Fase 5-6)
2717:                     IF TYPE("nProvedor") = "N"
2718:                         IF nProvedor > 0
2719:                             loc_cProvedor = aProvedor(nProvedor)
2720:                             THIS.this_cProvedorConectado = loc_cProvedor
2721:                             loc_cComando  = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(loc_cProvedor)
2722:                             &loc_cComando.
2723:                         ELSE
2724:                             THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2725:                             MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2726:                         ENDIF
2727:                     ELSE
2728:                         THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2729:                         MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2730:                     ENDIF
2731:                 ENDIF
2732: 
2733:             OTHERWISE
2734:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2735:         ENDCASE
2736:     ENDPROC
2737: 
2738:     *==========================================================================
2739:     * BtnExecutarTransferenciaClick / BtnEnviaFtpClick - Click de cmd_4c_Transferir
2740:     * (cmdtran, transfere todos) e cmd_4c_EnviaFtp (cmdtransfere, transfere
2741:     * so os selecionados)
2742:     *==========================================================================
2743:     PROCEDURE BtnExecutarTransferenciaClick()
2744:         THIS.Transferir("A")
2745:     ENDPROC
2746: 
2747:     PROCEDURE BtnEnviaFtpClick()
2748:         THIS.Transferir("I")
2749:     ENDPROC
2750: 
2751:     *==========================================================================
2752:     * BtnExecutarRecebimentoClick / BtnRecebeFtpClick - Click de cmd_4c_Receber (cmdrec,
2753:     * recebe todos) e cmd_4c_RecebeFtp (cmdrecebe, recebe so os selecionados)
2754:     *==========================================================================
2755:     PROCEDURE BtnExecutarRecebimentoClick()
2756:         THIS.Receber("A")
2757:     ENDPROC
2758: 
2759:     PROCEDURE BtnRecebeFtpClick()
2760:         THIS.Receber("I")
2761:     ENDPROC
2762: 
2763:     *==========================================================================
2764:     * BtnEncerrarClick - Click de cmd_4c_Encerrar (cmdsair do legado:
2765:     * "ThisForm.release")
2766:     *==========================================================================
2767:     PROCEDURE BtnEncerrarClick()
2768:         THIS.Release()
2769:     ENDPROC
2770: 
2771:     *==========================================================================
2772:     * Destroy - Libera o Business Object; a restauracao do menu principal
2773:     * ja e feita por FormBase.Destroy via DODEFAULT()
2774:     *==========================================================================
2775:     PROCEDURE Destroy()
2776:         LOCAL loc_nAtivas, loc_cComando
2777: 
2778:         *-- "if ThisForm._TpConnect = 'D' ... " do PROCEDURE Release legado:
2779:         *-- se a conexao Dial-Up discada por BtnRedeDialupClick ainda estiver
2780:         *-- ativa ao fechar o form, avisa o usuario e desconecta (a mesma
2781:         *-- chamada RnaDial de novo funciona como toggle e derruba a conexao)
2782:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.this_cTpConnect == "D"
2783:             PUBLIC ARRAY aAtivas(1)
2784:             loc_nAtivas = THIS.RasAtivas("aAtivas")
2785: 
2786:             IF loc_nAtivas > 0
2787:                 MsgInfo("A conex" + CHR(227) + "o " + CHR(224) + " internet ainda est" + CHR(225) + " ativa...", "Aten" + CHR(231) + CHR(227) + "o")
2788: 
2789:                 IF !EMPTY(THIS.this_cProvedorConectado)
2790:                     loc_cComando = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedorConectado)
2791:                     &loc_cComando.
2792:                 ENDIF
2793:             ENDIF
2794: 
2795:             RELEASE aAtivas
2796:         ENDIF
2797: 
2798:         *-- Fecha os cursores locais do form (equivalente ao "sele logftp /
2799:         *-- use" e "sele tmpprog / use" do Destroy legado)
2800:         IF USED("cursor_4c_Progresso")
2801:             USE IN cursor_4c_Progresso
2802:         ENDIF
2803: 
2804:         IF USED("cursor_4c_Log")
2805:             USE IN cursor_4c_Log
2806:         ENDIF
2807: 
2808:         IF USED("cursor_4c_FtpServer")
2809:             USE IN cursor_4c_FtpServer
2810:         ENDIF
2811: 
2812:         *-- "Release aAtivas, cProvedor, aProvedor" do Destroy legado - os
2813:         *-- arrays/memvars PUBLIC do combo de provedores Dial-Up (criados em
2814:         *-- ConfigurarProvedorDialUp) nao devem sobreviver ao fechamento do form
2815:         IF TYPE("aProvedor") <> "U"
2816:             RELEASE aProvedor
2817:         ENDIF
2818:         IF TYPE("nProvedor") <> "U"
2819:             RELEASE nProvedor
2820:         ENDIF
2821: 
2822:         IF !ISNULL(THIS.this_oBusinessObject)
2823:             THIS.this_oBusinessObject = .NULL.
2824:         ENDIF


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


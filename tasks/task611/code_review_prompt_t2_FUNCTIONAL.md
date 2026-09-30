# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [METODO-INEXISTENTE] Metodo 'THIS.ExcluirArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RenomearArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EnviarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ReceberArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Progresso' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Log' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_FtpServer' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagLocRecebidosActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagFtpAReceberActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2837 linhas total):

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

*-- Linhas 259 a 634:
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
289:         THIS.grd_4c_Progresso.ColumnCount      = 5
290:         THIS.grd_4c_Progresso.RecordSourceType = 1
291:         THIS.grd_4c_Progresso.RecordSource     = "cursor_4c_Progresso"
292: 
293:         WITH THIS.grd_4c_Progresso
294:             .Top          = 376
295:             .Left         = 89
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
347: 
348:         WITH THIS.grd_4c_Log
349:             .Top           = 323
350:             .Left          = 89
351:             .Width         = 622
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
383:             .Column1.Header1.Caption   = "Memo"
384:             .Column1.Header1.ForeColor = RGB(0,0,0)
385:             .Column1.Header1.BackColor = RGB(192,192,192)
386: 
387:             .Visible = .T.
388:         ENDWITH
389: 
390:         *-- Label de status da operacao corrente (lblprog do legado). Fica
391:         *-- junto dos grids porque e' o rodape do painel de progresso: o
392:         *-- PROCEDURE processa escreve nele o tempo decorrido/estimado a cada
393:         *-- bloco transferido. Classe base "label" (nao a classe "say" do
394:         *-- Framework), logo AutoSize/Alignment ficam nos defaults - Width e
395:         *-- Height vem do SCX (rule #23: fixar os dois, nunca usar AutoSize)
396:         THIS.AddObject("lbl_4c_Progresso", "Label")
397:         WITH THIS.lbl_4c_Progresso
398:             .Top       = 512
399:             .Left      = 245
400:             .Width     = 437
401:             .Height    = 16
402:             .AutoSize  = .F.
403:             .Alignment = 0
404:             .BackStyle = 0
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .ForeColor = RGB(0,0,0)
408:             .Caption   = ""
409:             .Visible   = .T.
410:         ENDWITH
411:     ENDPROC
412: 
413:     *==========================================================================
414:     * ConfigurarBotoesAcao - Cria os botoes de acao do form (Conecta,
415:     * Transfere, Recebe, Rede Dial-Up, Encerrar e os 2 botoes pequenos de
416:     * transferencia individual dentro de cnt_4c_Navegacao), com o Enabled/
417:     * Visible inicial calculado como no Init legado: checagem de existencia
418:     * dos diretorios locais (this_cDirEnvFtp/this_cDirRecFtp) e visibilidade
419:     * do botao de Dial-Up conforme this_cTpConnect
420:     *==========================================================================
421:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
422:         LOCAL loc_lConfigOk
423:         loc_lConfigOk = .T.
424: 
425:         THIS.AddObject("cmd_4c_Conectar", "CommandButton")
426:         WITH THIS.cmd_4c_Conectar
427:             .Top        = 12
428:             .Left       = 23
429:             .Width      = 75
430:             .Height     = 75
431:             .FontBold   = .T.
432:             .FontItalic = .T.
433:             .FontName   = "Comic Sans MS"
434:             .FontSize   = 8
435:             .WordWrap   = .T.
436:             .Picture    = gc_4c_CaminhoIcones + "a_arrow1.bmp"
437:             .Caption    = "\<Conecta"
438:             .ForeColor  = RGB(90,90,90)
439:             .BackColor  = RGB(255,255,255)
440:             .Themes           = .T.
441:             .Visible    = .T.
442:         ENDWITH
443:         BINDEVENT(THIS.cmd_4c_Conectar, "Click", THIS, "BtnConectarClick")
444: 
445:         THIS.AddObject("cmd_4c_Transferir", "CommandButton")
446:         WITH THIS.cmd_4c_Transferir
447:             .Top        = 12
448:             .Left       = 99
449:             .Width      = 75
450:             .Height     = 75
451:             .FontBold   = .T.
452:             .FontItalic = .T.
453:             .FontName   = "Comic Sans MS"
454:             .FontSize   = 8
455:             .Picture    = gc_4c_CaminhoIcones + "baix_aut.bmp"
456:             .Caption    = "\<Transfere"
457:             .ForeColor  = RGB(90,90,90)
458:             .BackColor  = RGB(255,255,255)
459:             .Themes           = .T.
460:             .DisabledPicture  = gc_4c_CaminhoIcones + "baix_aut.bmp"
461:             .Enabled    = .F.
462:             .Visible    = .T.
463:         ENDWITH
464:         BINDEVENT(THIS.cmd_4c_Transferir, "Click", THIS, "BtnExecutarTransferenciaClick")
465: 
466:         THIS.AddObject("cmd_4c_Receber", "CommandButton")
467:         WITH THIS.cmd_4c_Receber
468:             .Top        = 12
469:             .Left       = 174
470:             .Width      = 75
471:             .Height     = 75
472:             .FontBold   = .T.
473:             .FontItalic = .T.
474:             .FontName   = "Comic Sans MS"
475:             .FontSize   = 8
476:             .Picture    = gc_4c_CaminhoIcones + "d_disk1.bmp"
477:             .Caption    = "\<Recebe"
478:             .ForeColor  = RGB(90,90,90)
479:             .BackColor  = RGB(255,255,255)
480:             .Themes           = .T.
481:             .DisabledPicture  = gc_4c_CaminhoIcones + "d_disk1.bmp"
482:             .Enabled    = .F.
483:             .Visible    = .T.
484:         ENDWITH
485:         BINDEVENT(THIS.cmd_4c_Receber, "Click", THIS, "BtnExecutarRecebimentoClick")
486: 
487:         THIS.AddObject("cmd_4c_RedeDialup", "CommandButton")
488:         WITH THIS.cmd_4c_RedeDialup
489:             .Top        = 534
490:             .Left       = 332
491:             .Width      = 76
492:             .Height     = 54
493:             .FontBold   = .T.
494:             .FontItalic = .T.
495:             .FontName   = "Comic Sans MS"
496:             .FontSize   = 7
497:             .Picture    = gc_4c_CaminhoIcones + "c_comm1.bmp"
498:             .Caption    = "Rede \<Dial-Up"
499:             .ForeColor  = RGB(90,90,90)
500:             .BackColor  = RGB(255,255,255)
501:             .Themes           = .T.
502:             .Visible    = (THIS.this_oBusinessObject.this_cTpConnect == "D")
503:         ENDWITH
504:         BINDEVENT(THIS.cmd_4c_RedeDialup, "Click", THIS, "BtnRedeDialupClick")
505: 
506:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
507:         WITH THIS.cmd_4c_Encerrar
508:             .Top        = 12
509:             .Left = 5
510:             .Width      = 75
511:             .Height     = 75
512:             .FontBold   = .T.
513:             .FontItalic = .T.
514:             .FontName   = "Comic Sans MS"
515:             .FontSize   = 8
516:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
517:             .Cancel     = .T.
518:             .Caption    = "Encerrar"
519:             .ForeColor  = RGB(90,90,90)
520:             .BackColor  = RGB(255,255,255)
521:             .Themes           = .T.
522:             .Enabled    = .T.
523:             .Visible    = .T.
524:         ENDWITH
525:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
526: 
527:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_EnviaFtp", "CommandButton")
528:         WITH THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp
529:             .Top          = 83
530:             .Left         = 299
531:             .Width        = 25
532:             .Height       = 24
533:             .FontName     = "Verdana"
534:             .FontSize     = 8
535:             .Picture      = gc_4c_CaminhoIcones + "b_arrow2.bmp"
536:             .Caption      = ""
537:             .ToolTipText  = "Transfere para FTP"
538:             .ForeColor    = RGB(36,84,155)
539:             .BackColor    = RGB(255,255,255)
540:             .Visible      = .T.
541:         ENDWITH
542:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp, "Click", THIS, "BtnEnviaFtpClick")
543: 
544:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_RecebeFtp", "CommandButton")
545:         WITH THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp
546:             .Top          = 116
547:             .Left         = 299
548:             .Width        = 25
549:             .Height       = 24
550:             .FontName     = "Verdana"
551:             .FontSize     = 8
552:             .Picture      = gc_4c_CaminhoIcones + "b_arrow1.bmp"
553:             .Caption      = ""
554:             .ToolTipText  = "Recebe do FTP"
555:             .ForeColor    = RGB(36,84,155)
556:             .BackColor    = RGB(255,255,255)
557:             .Visible      = .T.
558:         ENDWITH
559:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp, "Click", THIS, "BtnRecebeFtpClick")
560: 
561:         *-- Container1 (cnt_4c_Navegacao) so fica habilitado apos Conecta
562:         THIS.cnt_4c_Navegacao.Enabled = .F.
563: 
564:         *-- "Checa a existencia dos diretorios locais" (Init legado)
565:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirEnvFtp)
566:             THIS.Inf("Diret" + CHR(243) + "rio Local de Envio para FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
567:             loc_lConfigOk = .F.
568:         ENDIF
569:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirRecFtp)
570:             THIS.Inf("Diret" + CHR(243) + "rio Local de Recebimento do FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
571:             loc_lConfigOk = .F.
572:         ENDIF
573: 
574:         THIS.cmd_4c_Conectar.Enabled = loc_lConfigOk
575: 
576:         IF !loc_lConfigOk
577:             MsgAviso("Erro na parametriza" + CHR(231) + CHR(227) + "o ou na configura" + CHR(231) + CHR(227) + "o da conex" + CHR(227) + "o. Verifique... Opera" + CHR(231) + CHR(227) + "o Cancelada", "Aten" + CHR(231) + CHR(227) + "o")
578:         ENDIF
579:     ENDPROC
580: 
581:     *==========================================================================
582:     * ConfigurarControlesLocal - Cria os controles de dados do PageFrame
583:     * "Local" (pgf_4c_Loc): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
584:     * cmd_4c_BrowEnvFtp) e Page2 "Recebidos" (lst_4c_RecFtp/txt_4c_DirRecFtp/
585:     * cmd_4c_BrowRecFtp), com Top/Left/Width/Height/ColumnWidths transcritos
586:     * do SCX legado (lstenvftp/direnvftp/cmdbrowloc de cada pagina - o legado
587:     * reusa o MESMO nome "cmdbrowloc" nas duas paginas; aqui os botoes
588:     * recebem nomes distintos por acao, ja que o nome generico colidiria).
589:     * Os botoes "..." ficam Enabled = .F. porque o legado NUNCA implementa
590:     * Click para eles (nenhum PROCEDURE Click no dump) - sao decorativos no
591:     * original. Os controles de dados do PageFrame "FTP" (pgf_4c_Ftp) e o
592:     * CboProvedor entram na Fase 6.
593:     *==========================================================================
594:     PROTECTED PROCEDURE ConfigurarControlesLocal()
595:         LOCAL loc_oPag1, loc_oPag2
596: 
597:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
598:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2
599: 
600:         loc_oPag1.AddObject("lst_4c_EnvFtp", "ListBox")
601:         WITH loc_oPag1.lst_4c_EnvFtp
602:             .Top          = 26
603:             .Left         = 2
604:             .Width        = 286
605:             .Height       = 130
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
625:         ENDWITH
626: 
627:         loc_oPag1.AddObject("cmd_4c_BrowEnvFtp", "CommandButton")
628:         WITH loc_oPag1.cmd_4c_BrowEnvFtp
629:             .Top       = 2
630:             .Left      = 222
631:             .Width     = 22
632:             .Height    = 22
633:             .FontName  = "Verdana"
634:             .FontSize  = 8

*-- Linhas 693 a 753:
693:         *-- trazer "Enviados" no lado FTP. Page.ZOrder num PageFrame traz a
694:         *-- pagina para a frente, ou seja, SELECIONA a pagina: o equivalente
695:         *-- no migrado eh <pageframe>.ActivePage = N.
696:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagLocEnviarActivate")
697:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagLocRecebidosActivate")
698:     ENDPROC
699: 
700:     *==========================================================================
701:     * ConfigurarControlesFtp - Cria os controles de dados do PageFrame "FTP"
702:     * (pgf_4c_Ftp): Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
703:     * cmd_4c_BrowRecLoc, espelhando a pasta REMOTA this_cDirRecLoc) e Page2
704:     * "A Receber" (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc,
705:     * espelhando this_cDirEnvLoc), com Top/Left/Width/Height/ColumnWidths
706:     * transcritos do SCX legado (lstrecloc/dirrecloc/cmdbrowftp de cada
707:     * pagina - o legado reusa o MESMO nome "cmdbrowftp" nas duas paginas; aqui
708:     * os botoes recebem nomes distintos por acao, como ja feito em
709:     * ConfigurarControlesLocal). Os botoes "..." ficam Enabled = .F. porque o
710:     * legado NUNCA implementa Click para eles (nenhum PROCEDURE Click no
711:     * dump) - sao decorativos no original.
712:     *==========================================================================
713:     PROTECTED PROCEDURE ConfigurarControlesFtp()
714:         LOCAL loc_oPag1, loc_oPag2
715: 
716:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
717:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2
718: 
719:         loc_oPag1.AddObject("lst_4c_RecLoc", "ListBox")
720:         WITH loc_oPag1.lst_4c_RecLoc
721:             .Top          = 26
722:             .Left         = 2
723:             .Width        = 286
724:             .Height       = 130
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
744:         ENDWITH
745: 
746:         loc_oPag1.AddObject("cmd_4c_BrowRecLoc", "CommandButton")
747:         WITH loc_oPag1.cmd_4c_BrowRecLoc
748:             .Top       = 2
749:             .Left      = 223
750:             .Width     = 22
751:             .Height    = 22
752:             .FontName  = "Verdana"
753:             .FontSize  = 8

*-- Linhas 809 a 1143:
809:         *-- Activate de qualquer uma das paginas mexendo nos MESMOS botoes
810:         *-- pequenos This.Parent.Parent.cmdtransfere/cmdrecebe (Container1,
811:         *-- aqui cnt_4c_Navegacao.cmd_4c_EnviaFtp/cmd_4c_RecebeFtp).
812:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagFtpEnviadosActivate")
813:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagFtpAReceberActivate")
814:     ENDPROC
815: 
816:     *==========================================================================
817:     * ConfigurarProvedorDialUp - Cria o combo de provedores Dial-Up
818:     * (CboProvedor do legado) e, quando a conexao configurada for do tipo
819:     * Dial-Up ("D"), enumera as conexoes RAS cadastradas no Windows via
820:     * THIS.RasConexao(), preenchendo o array PUBLIC aProvedor que alimenta o
821:     * RowSource do combo (RowSourceType=5, array). Transcricao do trecho
822:     *==========================================================================
823:     PROTECTED PROCEDURE ConfigurarProvedorDialUp()
824:         PUBLIC ARRAY aProvedor(1)
825:         aProvedor(1) = ""
826:         PUBLIC nProvedor
827:         nProvedor = 1
828: 
829:         THIS.AddObject("cbo_4c_Provedor", "ComboBox")
830:         WITH THIS.cbo_4c_Provedor
831:             .Top              = 550
832:             .Left             = 90
833:             .Width            = 235
834:             .Height           = 24
835:             .Style            = 2
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
855:                 THIS.cmd_4c_Conectar.Enabled = .F.
856:             ELSE
857:             ENDIF
858:         ELSE
859:             THIS.cbo_4c_Provedor.Visible = .F.
860:         ENDIF
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * ConfigurarPaginaDados - Ponto de entrada dos controles de DADOS das
865:     * paginas dos 2 PageFrames de navegacao. Cria os controles da metade
866:     * "Local" (ConfigurarControlesLocal) e da metade "FTP"
867:     * (ConfigurarControlesFtp), aplica o guard de disponibilidade que o Init
868:     * legado executa DEPOIS de montar a tela e, por fim, configura o combo de
869:     * provedores Dial-Up (ConfigurarProvedorDialUp) - na MESMA ordem do Init
870:     * legado (controles -> guard de direcao -> CboProvedor/RasConexao).
871:     *==========================================================================
872:     PROTECTED PROCEDURE ConfigurarPaginaDados()
873:         LOCAL loc_oPgLoc, loc_oPgFtp
874: 
875:         THIS.ConfigurarControlesLocal()
876:         THIS.ConfigurarControlesFtp()
877: 
878:         *-- Bloco ".pgfloc.Page1.direnvftp.Value = ThisForm._DirEnvFtp" (e os
879:         *-- outros tres, mais os quatro ToolTipText) que o Init legado executa
880:         *-- DEPOIS de resolver a configuracao: no migrado isso eh o BOParaForm.
881:         THIS.BOParaForm()
882: 
883:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
884:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
885: 
886:         *-- Guard de disponibilidade, transcrito do Init legado (blocos
887:         *-- "if Empt(_DirEnvFtp) .or. empt(_DirRecLoc)" e
888:         *-- "if Empt(_DirRecFtp) .or. empt(_DirEnvLoc)"): faltando um dos dois
889:         *-- diretorios de um sentido, aquele sentido inteiro eh desativado -
890:         *-- a pagina correspondente nos DOIS PageFrames, o botao pequeno de
891:         *-- transferencia individual e o botao grande da barra de acao - e a
892:         *-- navegacao eh levada para a pagina do sentido que continua valido
893:         *-- (o ".pgfloc.PageN.zOrder" / ".pgfftp.PageN.zOrder" do legado).
894:         IF EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirRecLoc)
895:             loc_oPgLoc.Page1.Enabled = .F.
896:             loc_oPgFtp.Page1.Enabled = .F.
897:             loc_oPgLoc.ActivePage    = 2
898:             loc_oPgFtp.ActivePage    = 2
899:             THIS.cmd_4c_Transferir.Enabled = .F.
900:             THIS.Inf("Sistema Configurado somente para Recebimento. Envio Desativado", "G")
901:         ENDIF
902: 
903:         IF EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
904:             loc_oPgLoc.Page2.Enabled = .F.
905:             loc_oPgFtp.Page2.Enabled = .F.
906:             loc_oPgLoc.ActivePage    = 1
907:             loc_oPgFtp.ActivePage    = 1
908:             THIS.cmd_4c_Receber.Enabled = .F.
909:             THIS.Inf("Sistema Configurado somente para Envio. Recebimento Desativado.", "G")
910:         ENDIF
911: 
912:         THIS.ConfigurarProvedorDialUp()
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * PagLocEnviarActivate / PagLocRecebidosActivate - Activate das paginas
917:     * do PageFrame Local: alternam o Enabled dos botoes pequenos de
918:     * transferencia individual (cmd_4c_EnviaFtp/cmd_4c_RecebeFtp), como o
919:     * legado faz em pgfloc.Page1.Activate/Page2.Activate (cmdtransfere/
920:     * cmdrecebe.enabled). Metodos PUBLIC - BINDEVENT exige (regra #3).
921:     *==========================================================================
922:     PROCEDURE PagLocEnviarActivate()
923:         *-- "This.Parent.Parent.pgfftp.Page1.zorder" do legado: leva o
924:         *-- PageFrame FTP para a pagina do MESMO sentido (Enviados). A
925:         *-- atribuicao so acontece quando o valor muda, para o Activate do
926:         *-- outro PageFrame (que sincroniza de volta) nao tornar a disparar.
927:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 1
928:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 1
929:         ENDIF
930:     ENDPROC
931: 
932:     PROCEDURE PagLocRecebidosActivate()
933:         *-- "This.Parent.Parent.pgfftp.Page2.zorder" do legado: leva o
934:         *-- PageFrame FTP para a pagina do MESMO sentido (A Receber).
935:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 2
936:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 2
937:         ENDIF
938:     ENDPROC
939: 
940:     *==========================================================================
941:     * PagFtpEnviadosActivate / PagFtpAReceberActivate - Activate das paginas
942:     * do PageFrame FTP: espelham PagLocEnviarActivate/PagLocRecebidosActivate
943:     * na direcao oposta, sincronizando pgf_4c_Loc.ActivePage e alternando o
944:     * Enabled dos mesmos botoes pequenos de transferencia individual, como o
945:     * legado faz em pgfftp.Page1.Activate/Page2.Activate. Metodos PUBLIC -
946:     * BINDEVENT exige (regra #3).
947:     *==========================================================================
948:     PROCEDURE PagFtpEnviadosActivate()
949:         *-- "This.Parent.Parent.pgfloc.Page1.zorder" do legado: leva o
950:         *-- PageFrame Local para a pagina do MESMO sentido (A Enviar).
951:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 1
952:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 1
953:         ENDIF
954:     ENDPROC
955: 
956:     PROCEDURE PagFtpAReceberActivate()
957:         *-- "This.Parent.Parent.pgfloc.Page2.zorder" do legado: leva o
958:         *-- PageFrame Local para a pagina do MESMO sentido (Recebidos).
959:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 2
960:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 2
961:         ENDIF
962:     ENDPROC
963: 
964:     *==========================================================================
965:     * Inf - Registra uma mensagem no grid de log (grd_4c_Log/cursor_4c_Log)
966:     * e reposiciona o cursor no ultimo registro, equivalente ao PROCEDURE Inf
967:     * do legado (par_cCor: "R"=erro/vermelho, "G"=sucesso/verde, "B"=info/azul)
968:     *==========================================================================
969:     PROTECTED PROCEDURE Inf(par_cTexto, par_cCor)
970:         LOCAL loc_cAliasAnterior
971:         loc_cAliasAnterior = ALIAS()
972: 
973:         IF !USED("cursor_4c_Log")
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
1001:     PROTECTED PROCEDURE CToWord(par_cBuffer)
1002:         RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
1003:                ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
1004:                ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
1005:                ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
1006:     ENDPROC
1007: 
1008:     *==========================================================================
1009:     * RasAtivas - Enumera as conexoes Dial-Up ATIVAS no momento via RAS API
1010:     * (equivalente ao PROCEDURE rasativas do legado). Devolve a quantidade de
1011:     * conexoes ativas e preenche o array PUBLIC cujo nome e passado em
1012:     * par_cNomeArray com [indice,1]=handle e [indice,2..4]=dados da conexao
1013:     *==========================================================================
1014:     PROTECTED PROCEDURE RasAtivas(par_cNomeArray)
1015:         LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nCount, loc_nResultado, loc_nPos
1016: 
1017:         DECLARE INTEGER RasEnumConnections IN RASAPI32.DLL ;
1018:             STRING  @loc_cConexoes, ;
1019:             INTEGER @loc_nSize, ;
1020:             INTEGER @loc_nCount
1021: 
1022:         loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
1023:         loc_cConexoes = REPLICATE(loc_cConexao, 16)
1024:         loc_nSize     = LEN(loc_cConexoes)
1025:         loc_nCount    = 0
1026: 
1027:         loc_nResultado = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nCount)
1028: 
1029:         IF loc_nCount > 0
1030:             PUBLIC ARRAY &par_cNomeArray.[loc_nCount, 4]
1031: 
1032:             FOR loc_nPos = 0 TO loc_nCount - 1
1033:                 loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
1034: 
1035:                 &par_cNomeArray.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
1036:                 &par_cNomeArray.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
1037:                 &par_cNomeArray.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
1038:                 &par_cNomeArray.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
1039:             ENDFOR
1040:         ENDIF
1041: 
1042:         RETURN loc_nCount
1043:     ENDPROC
1044: 
1045:     *==========================================================================
1046:     * RasConexao - Enumera as conexoes Dial-Up CADASTRADAS no Windows (todas,
1047:     * ativas ou nao) via RAS API (equivalente ao PROCEDURE rasENTRADAS do
1048:     * legado - RasEnumEntries; o PROCEDURE rasconexao legado, que DISCA via
1049:     * RasDial, e o rashangup, que derruba a linha, sao codigo MORTO no legado:
1050:     * nenhum Click nem metodo os chama - quem disca e derruba e o
1051:     * "RUN /N Rundll Rnaui.dll,RnaDial" de cmdconect.Click e do Release, ja
1052:     * transcrito em BtnRedeDialupClick e Destroy). Devolve a quantidade de
1053:     * conexoes cadastradas e preenche o
1054:     * array PUBLIC cujo nome e passado em par_cNomeArray com o nome de cada
1055:     * conexao - fonte do RowSource de cbo_4c_Provedor.
1056:     *==========================================================================
1057:     PROTECTED PROCEDURE RasConexao(par_cNomeArray)
1058:         LOCAL loc_cEntradaVazia, loc_cEntradas, loc_nTamanho, loc_nEntradas, ;
1059:             loc_nResultado, loc_cEntrada, loc_nPos
1060: 
1061:         #DEFINE RAS_MAXENTRYNAME_CX 256
1062: 
1063:         DECLARE INTEGER RasEnumEntries IN RASAPI32.DLL ;
1064:             INTEGER reserved, ;
1065:             STRING  PhoneBox, ;
1066:             STRING  @loc_cEntradas, ;
1067:             INTEGER @loc_nTamanho, ;
1068:             INTEGER @loc_nEntradas
1069: 
1070:         loc_cEntradaVazia = THIS.WordToC(264) + REPLICATE(CHR(0), RAS_MAXENTRYNAME_CX)
1071:         loc_cEntradas     = REPLICATE(loc_cEntradaVazia, 255)
1072:         loc_nTamanho      = LEN(loc_cEntradas)
1073:         loc_nEntradas     = 0
1074: 
1075:         loc_nResultado = RasEnumEntries(0, "", @loc_cEntradas, @loc_nTamanho, @loc_nEntradas)
1076: 
1077:         IF loc_nEntradas = 0
1078:             RETURN 0
1079:         ENDIF
1080: 
1081:         RELEASE &par_cNomeArray.
1082:         PUBLIC ARRAY &par_cNomeArray.[loc_nEntradas]
1083: 
1084:         FOR loc_nPos = 0 TO loc_nEntradas - 1
1085:             loc_cEntrada = SUBSTR(loc_cEntradas, (264 * loc_nPos) + 1, 264)
1086:             &par_cNomeArray.[loc_nPos + 1] = SUBSTR(loc_cEntrada, 5, AT(CHR(0), SUBSTR(loc_cEntrada, 5)) - 1)
1087:         ENDFOR
1088: 
1089:         RETURN loc_nEntradas
1090:     ENDPROC
1091: 
1092:     *==========================================================================
1093:     * CarregarDados - Carga de dados do form: lista o diretorio REMOTO do
1094:     * servidor FTP (WinInet: InternetOpen -> InternetConnect ->
1095:     * FtpSetCurrentDirectory -> FtpFindFirstFile/InternetFindNextFile) e
1096:     * popula cursor_4c_FtpServer, que e a fonte de todo o lado "FTP" da tela.
1097:     * Transcricao do PROCEDURE getftpdirectory do legado.
1098:     *
1099:     * par_cDirRemoto : pasta no servidor FTP a listar
1100:     * par_cMascara   : mascara de arquivos (ex.: "*.*")
1101:     * Retorna .T. quando a listagem foi obtida (cursor_4c_FtpServer populado)
1102:     *==========================================================================
1103:     PROCEDURE CarregarDados(par_cDirRemoto, par_cMascara)
1104:         LOCAL loc_nInternet, loc_nFtp, loc_cTempDir, loc_cDiretorio, loc_cMascara
1105:         LOCAL loc_cStruct, loc_nHandle, loc_nResultCode, loc_nResult, loc_lManual
1106:         LOCAL loc_nFResult, loc_lSucesso, loc_cNulo
1107: 
1108:         #DEFINE ERROR_NO_MORE_FILES_FTP        18
1109:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_FTP   1
1110:         #DEFINE INTERNET_DEFAULT_FTP_PORT_FTP  21
1111:         #DEFINE INTERNET_SERVICE_FTP_FTP        1
1112:         #DEFINE INTERNET_FLAG_PASSIVE_FTP 14217728
1113:         #DEFINE MAX_PATH_FTP                  260
1114: 
1115:         loc_cNulo    = CHR(0)
1116:         loc_lSucesso = .F.
1117:         loc_lManual  = .F.
1118:         loc_nInternet = 0
1119:         loc_nFtp      = 0
1120: 
1121:         DECLARE INTEGER FtpFindFirstFile IN WinInet ;
1122:             INTEGER nConnect_Handle, STRING @lpcSearchStr, ;
1123:             STRING @lpcWIN32_FIND_DATA, INTEGER nFlags, INTEGER nContext
1124: 
1125:         DECLARE INTEGER InternetFindNextFile IN WinInet ;
1126:             INTEGER nConnect_Handle, STRING @lpcWIN32_FIND_DATA
1127: 
1128:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1129:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1130:             STRING lpszProxyBypass, LONG dwFlags
1131: 
1132:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1133:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1134:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1135:             LONG dwFlags, LONG dwContext
1136: 
1137:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1138: 
1139:         DECLARE LONG GetLastError IN WIN32API
1140: 
1141:         DECLARE INTEGER FtpGetCurrentDirectory IN WinInet ;
1142:             INTEGER nConnect_Handle, STRING @lpcDirectory, INTEGER @nMax_Path
1143: 

*-- Linhas 1200 a 1387:
1200:                             loc_lSucesso = .T.
1201:                         ENDIF
1202:                     ENDIF
1203: 
1204:                     IF loc_lSucesso
1205:                         IF USED("cursor_4c_FtpServer")
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
1254:     * (transcricao do PROCEDURE crackfile do legado)
1255:     *==========================================================================
1256:     PROTECTED PROCEDURE CrackFile(par_cString)
1257:         LOCAL loc_cArquivo, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1258:         LOCAL loc_cTipo, loc_cAtributos, loc_cBufferData, loc_cDataGravacao
1259:         LOCAL loc_cNulo, loc_nPosNulo
1260: 
1261:         #DEFINE BYTE_1_CF                     1
1262:         #DEFINE BYTE_2_CF                   256
1263:         #DEFINE BYTE_3_CF                 65536
1264:         #DEFINE BYTE_4_CF              16777216
1265:         #DEFINE MAXDWORD_CF          4294967295
1266:         #DEFINE FILE_ATTRIBUTE_DIRECTORY_CF  16
1267:         #DEFINE MAX_PATH_CF                 260
1268: 
1269:         loc_cNulo = CHR(0)
1270: 
1271:         loc_cArquivo = SUBSTR(par_cString, 45, MAX_PATH_CF)
1272:         loc_nPosNulo = AT(loc_cNulo, loc_cArquivo)
1273: 
1274:         IF loc_nPosNulo > 1
1275:             loc_cArquivo = LEFT(loc_cArquivo, loc_nPosNulo - 1)
1276:         ENDIF
1277: 
1278:         *-- Tamanho do arquivo (dois DWORD)
1279:         loc_nSizeHigh = (ASC(SUBSTR(par_cString, 29, 1)) * BYTE_1_CF) + ;
1280:                         (ASC(SUBSTR(par_cString, 30, 1)) * BYTE_2_CF) + ;
1281:                         (ASC(SUBSTR(par_cString, 31, 1)) * BYTE_3_CF) + ;
1282:                         (ASC(SUBSTR(par_cString, 32, 1)) * BYTE_4_CF)
1283: 
1284:         loc_nSizeLow  = (ASC(SUBSTR(par_cString, 33, 1)) * BYTE_1_CF) + ;
1285:                         (ASC(SUBSTR(par_cString, 34, 1)) * BYTE_2_CF) + ;
1286:                         (ASC(SUBSTR(par_cString, 35, 1)) * BYTE_3_CF) + ;
1287:                         (ASC(SUBSTR(par_cString, 36, 1)) * BYTE_4_CF)
1288: 
1289:         loc_nTamanho = (loc_nSizeHigh * MAXDWORD_CF) + loc_nSizeLow
1290: 
1291:         IF THIS.CToWord(SUBSTR(par_cString, 1, 4)) = FILE_ATTRIBUTE_DIRECTORY_CF
1292:             loc_cTipo = "Diret" + CHR(243) + "rio"
1293:         ELSE
1294:             loc_cTipo = "Arquivo"
1295:         ENDIF
1296: 
1297:         *-- Data de gravacao (o legado le create/access/write e so usa write)
1298:         loc_cBufferData   = SUBSTR(par_cString, 21, 8)
1299:         loc_cDataGravacao = THIS.CrackDate(loc_cBufferData)
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
1319: 
1320:         DECLARE INTEGER FileTimeToSystemTime IN Kernel32 ;
1321:             STRING @lpcBuffer, STRING @lpcBuffer2
1322: 
1323:         loc_cEntrada   = SPACE(16)
1324:         loc_nResultado = FileTimeToSystemTime(@par_cBuffer, @loc_cEntrada)
1325: 
1326:         IF loc_nResultado = 0
1327:             *-- Falhou: data default do legado
1328:             loc_cData = "1901/01/01"
1329:         ELSE
1330:             loc_nAno = ASC(SUBSTR(loc_cEntrada, 1, 1)) + (ASC(SUBSTR(loc_cEntrada, 2, 1)) * BYTE_2_CD)
1331:             loc_nMes = ASC(SUBSTR(loc_cEntrada, 3, 1)) + (ASC(SUBSTR(loc_cEntrada, 4, 1)) * BYTE_2_CD)
1332:             loc_nDia = ASC(SUBSTR(loc_cEntrada, 7, 1)) + (ASC(SUBSTR(loc_cEntrada, 8, 1)) * BYTE_2_CD)
1333: 
1334:             loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
1335:                         PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
1336:                         ALLTRIM(STR(loc_nAno))
1337:         ENDIF
1338: 
1339:         RETURN loc_cData
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * CrackAttributes - Traduz os 4 bytes de atributos do WIN32_FIND_DATA na
1344:     * letra correspondente (transcricao do PROCEDURE crackattributes do
1345:     * legado - DO CASE, portanto devolve APENAS o primeiro atributo que casar)
1346:     *==========================================================================
1347:     PROTECTED PROCEDURE CrackAttributes(par_cBuffer)
1348:         LOCAL loc_cAtributos, loc_nValor
1349: 
1350:         #DEFINE BYTE_1_CA                      1
1351:         #DEFINE BYTE_2_CA                    256
1352:         #DEFINE BYTE_3_CA                  65536
1353:         #DEFINE BYTE_4_CA               16777216
1354: 
1355:         #DEFINE BIT_ATTRIBUTE_READONLY_CA      0
1356:         #DEFINE BIT_ATTRIBUTE_HIDDEN_CA        1
1357:         #DEFINE BIT_ATTRIBUTE_SYSTEM_CA        2
1358:         #DEFINE BIT_ATTRIBUTE_DIRECTORY_CA     4
1359:         #DEFINE BIT_ATTRIBUTE_ARCHIVE_CA       5
1360:         #DEFINE BIT_ATTRIBUTE_NORMAL_CA        7
1361:         #DEFINE BIT_ATTRIBUTE_TEMPORARY_CA     8
1362:         #DEFINE BIT_ATTRIBUTE_COMPRESSED_CA   11
1363:         #DEFINE BIT_ATTRIBUTE_OFFLINE_CA      12
1364: 
1365:         loc_cAtributos = ""
1366: 
1367:         loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * BYTE_1_CA) + ;
1368:                      (ASC(SUBSTR(par_cBuffer, 2, 1)) * BYTE_2_CA) + ;
1369:                      (ASC(SUBSTR(par_cBuffer, 3, 1)) * BYTE_3_CA) + ;
1370:                      (ASC(SUBSTR(par_cBuffer, 4, 1)) * BYTE_4_CA)
1371: 
1372:         DO CASE
1373:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_READONLY_CA)
1374:                 loc_cAtributos = loc_cAtributos + "R"
1375:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_HIDDEN_CA)
1376:                 loc_cAtributos = loc_cAtributos + "H"
1377:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_SYSTEM_CA)
1378:                 loc_cAtributos = loc_cAtributos + "S"
1379:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_DIRECTORY_CA)
1380:                 loc_cAtributos = loc_cAtributos + "D"
1381:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_ARCHIVE_CA)
1382:                 loc_cAtributos = loc_cAtributos + "A"
1383:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_NORMAL_CA)
1384:                 loc_cAtributos = loc_cAtributos + "N"
1385:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_TEMPORARY_CA)
1386:                 loc_cAtributos = loc_cAtributos + "T"
1387:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_COMPRESSED_CA)

*-- Linhas 1395 a 1441:
1395: 
1396:     *==========================================================================
1397:     * InErrorCase - Traduz o codigo devolvido por GetLastError() no nome
1398:     * simbolico do erro WinInet/Win32 (transcricao do PROCEDURE inerrorcase
1399:     * do legado, incluindo o formato final "[ <codigo> : <nome> ]")
1400:     *==========================================================================
1401:     PROTECTED PROCEDURE InErrorCase(par_nErro)
1402:         LOCAL loc_cMensagem
1403: 
1404:         #DEFINE ERROR_INTERNET_BASE_IE 12000
1405: 
1406:         DO CASE
1407:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 1
1408:                 loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
1409:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 2
1410:                 loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
1411:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 3
1412:                 loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
1413:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 4
1414:                 loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
1415:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 5
1416:                 loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
1417:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 6
1418:                 loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
1419:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 7
1420:                 loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
1421:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 8
1422:                 loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
1423:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 9
1424:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
1425:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 10
1426:                 loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
1427:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 11
1428:                 loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
1429:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 12
1430:                 loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
1431:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 13
1432:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
1433:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 14
1434:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
1435:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 15
1436:                 loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
1437:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 16
1438:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
1439:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 17
1440:                 loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
1441:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 18

*-- Linhas 1557 a 1688:
1557: 
1558:     *==========================================================================
1559:     * SecToHour - Formata uma quantidade de segundos como "Nh, Nm, Ns"
1560:     * (transcricao do PROCEDURE sectohour do legado)
1561:     *==========================================================================
1562:     PROTECTED PROCEDURE SecToHour(par_nSegundos)
1563:         LOCAL loc_nHora, loc_nMinuto, loc_nSegundo
1564: 
1565:         loc_nHora    = INT(par_nSegundos / 3600)
1566:         loc_nMinuto  = MOD(INT(par_nSegundos / 60), 60)
1567:         loc_nSegundo = MOD(par_nSegundos, 60)
1568: 
1569:         RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
1570:                IIF(loc_nMinuto > 0, ALLTRIM(STR(loc_nMinuto)) + " m, ", "") + ;
1571:                ALLTRIM(STR(loc_nSegundo)) + " s"
1572:     ENDPROC
1573: 
1574:     *==========================================================================
1575:     * Processa - Alimenta o grid de progresso (grd_4c_Progresso /
1576:     * cursor_4c_Progresso) durante uma transferencia, nos 3 estagios do
1577:     * legado: "I"=iniciando (cria a linha), "A"=em andamento (atualiza bytes
1578:     * e percentual), "C"=concluido (fecha a linha e registra no log).
1579:     * Transcricao do PROCEDURE processa do legado.
1580:     *
1581:     * DIVERGENCIA DOCUMENTADA: o legado chama ThisForm.FileCtrlUp(...) neste
1582:     * metodo, mas o controle ActiveX que FileCtrlUp manipula (ThisForm.
1583:     * FileControl) NAO EXISTE no SCX - nao consta da lista de objetos do
1584:     * dump, so das linhas "With ThisForm.FileControl" do proprio FileCtrlUp.
1585:     * Reproduzir essas chamadas geraria "Unknown member FILECONTROL" em
1586:     * runtime, entao elas ficam de fora; o percentual segue visivel na coluna
1587:     * Status do grid e no lbl_4c_Progresso, como no legado.
1588:     *==========================================================================
1589:     PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cPastaLocal, ;
1590:             par_cPastaHost, par_nTransferido, par_nBuffer, ;
1591:             par_nSegIniciais, par_nSegundos, par_cStatus)
1592: 
1593:         LOCAL loc_nSegundos, loc_cTempoEstimado, loc_cTempoDecorrido, ;
1594:             loc_nIndice, loc_nPos
1595: 
1596:         loc_nSegundos = par_nSegundos
1597: 
1598:         IF loc_nSegundos = 0
1599:             *-- Valor minimo de tempo de transferencia (evita divisao por zero)
1600:             loc_nSegundos = 0.001
1601:         ENDIF
1602: 
1603:         IF !USED("cursor_4c_Progresso")
1604:             RETURN
1605:         ENDIF
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
1650:                     *-- lista de DESTINO e, se configurado, apaga o arquivo
1651:                     *-- de ORIGEM (this_lDelLocal para envio / this_lDelHost
1652:                     *-- para recebimento) e o remove da lista de origem
1653:                     IF par_cPastaLocal == THIS.this_oBusinessObject.this_cDirEnvFtp
1654:                         *-- Enviando arquivos para o FTP: registra em
1655:                         *-- lst_4c_RecLoc (pgf_4c_Ftp.Page1 "Enviados")
1656:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1.lst_4c_RecLoc
1657:                             loc_nIndice = .ListCount + 1
1658:                             .AddItem(par_cArquivo, loc_nIndice, 1)
1659:                             .AddListItem(STR(par_nTamanho), loc_nIndice, 2)
1660:                             .AddListItem(STR(par_nTransferido), loc_nIndice, 3)
1661:                             .Refresh()
1662:                         ENDWITH
1663: 
1664:                         IF THIS.this_oBusinessObject.this_lDelLocal
1665:                             THIS.Inf("Exclu" + CHR(237) + "ndo o arquivo local " + par_cPastaLocal + par_cArquivo, "B")
1666: 
1667:                             ERASE (par_cPastaLocal + par_cArquivo)
1668: 
1669:                             IF FILE(par_cPastaLocal + par_cArquivo)
1670:                                 THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cPastaLocal + par_cArquivo, "R")
1671:                             ELSE
1672:                                 THIS.Inf("Arquivo Local " + par_cPastaLocal + par_cArquivo + " foi exclu" + CHR(237) + "do com sucesso", "B")
1673:                             ENDIF
1674: 
1675:                             *-- Remove o arquivo da lista de origem (lst_4c_EnvFtp)
1676:                             WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1677:                                 FOR loc_nPos = 1 TO .ListCount
1678:                                     IF UPPER(ALLTRIM(.List(loc_nPos, 1))) == UPPER(par_cArquivo)
1679:                                         .RemoveItem(loc_nPos)
1680:                                         EXIT
1681:                                     ENDIF
1682:                                 ENDFOR
1683:                             ENDWITH
1684:                         ENDIF
1685:                     ENDIF
1686: 
1687:                     IF par_cPastaHost == THIS.this_oBusinessObject.this_cDirEnvLoc
1688:                         *-- Recebendo do FTP: registra em lst_4c_RecFtp

*-- Linhas 1726 a 1799:
1726: 
1727:     *==========================================================================
1728:     * MontaContainer - "Monta os pageframes com todos os arquivos a enviar e
1729:     * receber" (equivalente ao PROCEDURE montacontainer do legado): carrega a
1730:     * listagem do diretorio REMOTO (via THIS.CarregarDados), filtra pela
1731:     * mascara this_cTpRec e povoa lst_4c_EnvLoc (Page2 "A Receber" do
1732:     * pgf_4c_Ftp), e lista a pasta LOCAL de envio em lst_4c_EnvFtp,
1733:     * registrando no log o mesmo roteiro do legado.
1734:     *
1735:     * DIVERGENCIA DOCUMENTADA (fiel ao legado, nao simplificada): o cursor
1736:     * remoto (cursor_4c_FtpServer) nao pode ser filtrado por wildcard
1737:     * diretamente - o legado grava cada NOME num arquivo VAZIO dentro de uma
1738:     * pasta TEMPORARIA (Strtofile) e roda ADIR com a mascara this_cTpRec
1739:     * sobre essa pasta, ja que ADIR so filtra arquivos REAIS em disco.
1740:     * Reproduzido aqui com SYS(2023) (pasta temp do Windows) + MKDIR +
1741:     * STRTOFILE + ADIR + ERASE, na MESMA ordem - necessario porque
1742:     * this_cTpRec vem da configuracao da empresa (SigCdEmp) e PODE nao ser
1743:     * "*.*".
1744:     *==========================================================================
1745:     PROTECTED PROCEDURE MontaContainer()
1746:         LOCAL loc_lSucesso, loc_nArquivosLocais, loc_nPos, loc_cPastaTemp, ;
1747:             loc_cDefaultAnterior, loc_nArquivosMascara, loc_nCont, loc_nItem
1748:         LOCAL ARRAY loc_aArquivosLocais[1], loc_aArquivosMascara[1]
1749: 
1750:         loc_lSucesso = .T.
1751: 
1752:         THIS.Inf("Carregando os par" + CHR(226) + "metros da tela... Aguarde", "B")
1753: 
1754:         *-- A Receber do Host: lista o diretorio REMOTO no servidor FTP e
1755:         *-- filtra pela mascara this_cTpRec antes de povoar lst_4c_EnvLoc
1756:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
1757:             THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com o servidor FTP no endere" + CHR(231) + "o " + ;
1758:                 THIS.this_oBusinessObject.this_cFtpAdd, "B")
1759: 
1760:             IF THIS.CarregarDados(THIS.this_oBusinessObject.this_cDirEnvLoc, "*.*") AND USED("cursor_4c_FtpServer")
1761:                 THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc.Clear()
1762: 
1763:                 loc_cDefaultAnterior = SYS(5) + SYS(2003)
1764:                 loc_cPastaTemp       = ADDBS(SYS(2023)) + SYS(3)
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
1793:                 ENDFOR
1794:                 IF ADIR(loc_aArquivosMascara) = 0
1795:                     SET DEFAULT TO (SYS(2023))
1796:                     RMDIR (loc_cPastaTemp)
1797:                 ENDIF
1798: 
1799:                 SET DEFAULT TO (loc_cDefaultAnterior)

*-- Linhas 1813 a 1889:
1813: 
1814:         *-- Local -> Host (A Enviar para o Host): lista a pasta LOCAL de onde
1815:         *-- os arquivos saem e povoa lst_4c_EnvFtp (equivalente ao bloco
1816:         *-- "Local -> Host" do PROCEDURE montacontainer legado - nome,
1817:         *-- tamanho e data de cada arquivo, ordenados por nome)
1818:         IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp)
1819:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Clear()
1820: 
1821:             loc_nArquivosLocais = ADIR(loc_aArquivosLocais, ;
1822:                 ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp)) + ;
1823:                 ALLTRIM(THIS.this_oBusinessObject.this_cTpEnv))
1824: 
1825:             IF loc_nArquivosLocais > 0
1826:                 ASORT(loc_aArquivosLocais)
1827: 
1828:                 FOR loc_nPos = 1 TO loc_nArquivosLocais
1829:                     WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1830:                         .AddItem(loc_aArquivosLocais[loc_nPos, 1], loc_nPos, 1)
1831:                         .AddListItem(STR(loc_aArquivosLocais[loc_nPos, 2], 10, 0), loc_nPos, 2)
1832:                         .AddListItem(DTOC(loc_aArquivosLocais[loc_nPos, 3]), loc_nPos, 3)
1833:                     ENDWITH
1834:                 ENDFOR
1835:             ENDIF
1836: 
1837:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Refresh()
1838: 
1839:             THIS.Inf("Lista de arquivos Locais j" + CHR(225) + " carregada do " + ;
1840:                 THIS.this_oBusinessObject.this_cDirEnvFtp, "B")
1841:             THIS.Inf("Pronto para a Transfer" + CHR(234) + "ncia... Clique no bot" + CHR(227) + "o (Transfere)", "G")
1842:         ENDIF
1843: 
1844:         RETURN loc_lSucesso
1845:     ENDPROC
1846: 
1847:     *==========================================================================
1848:     * VerificarArquivoFtp - Confirma que um arquivo existe no servidor FTP,
1849:     * tentando abri-lo para leitura (equivalente ao PROCEDURE rasfile do
1850:     * legado). Usado antes de receber um arquivo e, apos o envio, para
1851:     * confirmar que o arquivo renomeado ficou disponivel no destino.
1852:     *==========================================================================
1853:     PROTECTED FUNCTION VerificarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1854:         LOCAL loc_nInternet, loc_nFtp, loc_nArquivoFtp, loc_lOk
1855: 
1856:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_VF   1
1857:         #DEFINE INTERNET_DEFAULT_FTP_PORT_VF  21
1858:         #DEFINE INTERNET_SERVICE_FTP_VF        1
1859:         #DEFINE INTERNET_FLAG_PASSIVE_VF 14217728
1860:         #DEFINE FTP_TRANSFER_TYPE_BINARY_VF    2
1861:         #DEFINE GENERIC_READ_VF       2147483648
1862: 
1863:         loc_lOk = .F.
1864: 
1865:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1866:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1867:             STRING lpszProxyBypass, LONG dwFlags
1868: 
1869:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1870:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1871:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1872:             LONG dwFlags, LONG dwContext
1873: 
1874:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1875: 
1876:         DECLARE LONG GetLastError IN WIN32API
1877: 
1878:         DECLARE LONG FtpOpenFile IN "wininet.dll" ;
1879:             LONG hFtpSession, STRING lpszFileName, INTEGER fdwAccess, ;
1880:             INTEGER dwFlags, INTEGER dwContext
1881: 
1882:         THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com a Internet", "G")
1883:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_VF, "", "", 0)
1884: 
1885:         IF loc_nInternet = 0
1886:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1887:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1888:             RETURN .F.
1889:         ENDIF

*-- Linhas 1924 a 1967:
1924: 
1925:     *==========================================================================
1926:     * RenomearArquivoFtp - Renomeia um arquivo no servidor FTP (equivalente ao
1927:     * PROCEDURE renameftpfile do legado). Usado por EnviarArquivoFtp para
1928:     * restaurar o nome definitivo do arquivo apos o upload do temporario.
1929:     *==========================================================================
1930:     PROTECTED FUNCTION RenomearArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoAntigo, par_cArquivoNovo)
1931:         LOCAL loc_nInternet, loc_nFtp, loc_nResultado, loc_cAntigo, loc_cNovo
1932: 
1933:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_NF   1
1934:         #DEFINE INTERNET_DEFAULT_FTP_PORT_NF  21
1935:         #DEFINE INTERNET_SERVICE_FTP_NF        1
1936:         #DEFINE INTERNET_FLAG_PASSIVE_NF 14217728
1937: 
1938:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1939:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1940:             STRING lpszProxyBypass, LONG dwFlags
1941: 
1942:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1943:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1944:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1945:             LONG dwFlags, LONG dwContext
1946: 
1947:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1948: 
1949:         DECLARE LONG GetLastError IN WIN32API
1950: 
1951:         DECLARE INTEGER FtpRenameFile IN WinInet ;
1952:             INTEGER nConnect_Handle, STRING @lpcRemoteFile, STRING @lpcNewFile
1953: 
1954:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_NF, "", "", 0)
1955:         IF loc_nInternet = 0
1956:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1957:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1958:             RETURN .F.
1959:         ENDIF
1960: 
1961:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_NF, ;
1962:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_NF, INTERNET_FLAG_PASSIVE_NF, 0)
1963:         IF loc_nFtp = 0
1964:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
1965:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1966:             InternetCloseHandle(loc_nInternet)
1967:             RETURN .F.

*-- Linhas 1980 a 2023:
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
1999:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2000:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2001:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2002:             LONG dwFlags, LONG dwContext
2003: 
2004:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
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

*-- Linhas 2043 a 2086:
2043: 
2044:     *==========================================================================
2045:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2046:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2047:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2048:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia
2049:     * o temporario para o nome definitivo e confirma a existencia final com
2050:     * VerificarArquivoFtp.
2051:     *
2052:     * DIVERGENCIA DOCUMENTADA: o legado, apos renomear, ainda chama
2053:     * ThisForm.raslisarq(...) para recarregar uma listagem completa do
2054:     * diretorio remoto (cursor "ftpserver", nao utilizado por nenhum outro
2055:     * ponto do form) so para obter um booleano de confirmacao - na pratica
2056:     * sempre .T. quando a conexao permanece de pe, exatamente a mesma garantia
2057:     * que VerificarArquivoFtp ja fornece de forma direta. Reproduzir essa
2058:     * listagem completa duplicaria CarregarDados/CrackFile sem mudar o
2059:     * resultado observavel (loc_lOk), entao o passo fica resumido a
2060:     * VerificarArquivoFtp - mantendo o efeito (confirmar sucesso do envio),
2061:     * sem inventar comportamento novo.
2062:     *==========================================================================
2063:     PROTECTED FUNCTION EnviarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoLocal, par_cArquivoRemoto)
2064:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2065:             loc_nSegIni, loc_nSegFim, loc_lOk
2066: 
2067:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_EF   1
2068:         #DEFINE INTERNET_DEFAULT_FTP_PORT_EF  21
2069:         #DEFINE INTERNET_SERVICE_FTP_EF        1
2070:         #DEFINE INTERNET_FLAG_PASSIVE_EF 14217728
2071:         #DEFINE FTP_TRANSFER_TYPE_BINARY_EF    2
2072: 
2073:         loc_lOk = .F.
2074: 
2075:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2076:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2077:             STRING lpszProxyBypass, LONG dwFlags
2078: 
2079:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2080:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2081:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2082:             LONG dwFlags, LONG dwContext
2083: 
2084:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2085: 
2086:         DECLARE LONG GetLastError IN WIN32API

*-- Linhas 2166 a 2209:
2166: 
2167:     *==========================================================================
2168:     * ReceberArquivoFtp - Recebe um arquivo do servidor FTP para uma pasta
2169:     * LOCAL (equivalente ao PROCEDURE rasftpget do legado): baixa o conteudo
2170:     * com FtpGetFile sob um nome LOCAL temporario (extensao trocada por
2171:     * ".ftp") e, tendo sucesso, renomeia para o nome definitivo.
2172:     *==========================================================================
2173:     PROTECTED FUNCTION ReceberArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto, par_cArquivoLocal)
2174:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2175:             loc_nSegIni, loc_nSegFim, loc_lOk
2176: 
2177:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_GF    1
2178:         #DEFINE INTERNET_DEFAULT_FTP_PORT_GF   21
2179:         #DEFINE INTERNET_SERVICE_FTP_GF         1
2180:         #DEFINE INTERNET_FLAG_PASSIVE_GF  14217728
2181:         #DEFINE FILE_ATTRIBUTE_NORMAL_GF      128
2182:         #DEFINE FTP_TRANSFER_TYPE_BINARY_GF     2
2183: 
2184:         loc_lOk     = .F.
2185:         loc_nTamanho = 0
2186: 
2187:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2188:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2189:             STRING lpszProxyBypass, LONG dwFlags
2190: 
2191:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2192:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2193:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2194:             LONG dwFlags, LONG dwContext
2195: 
2196:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2197: 
2198:         DECLARE LONG GetLastError IN WIN32API
2199: 
2200:         DECLARE INTEGER FtpGetFile IN "wininet.dll" ;
2201:             LONG hFtpSession, STRING lpszRemoteFile, STRING lpszNewFile, ;
2202:             LONG fFailIfExist, LONG dwFlagsAndAttributes, LONG dwFlags, LONG dwContext
2203: 
2204:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_GF, "", "", 0)
2205:         IF loc_nInternet = 0
2206:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2207:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2208:             RETURN .F.
2209:         ENDIF

*-- Linhas 2264 a 2353:
2264: 
2265:     *==========================================================================
2266:     * Transferir / Receber - Disparam o envio/recebimento de arquivos
2267:     * (equivalentes aos PROCEDURE transfere/recebe do legado, chamados com
2268:     * par_cModo = "A" para todos os arquivos ou "I" para selecao individual).
2269:     * A origem eh o mesmo ListBox que MontaContainer/lst_4c_* ja mantem
2270:     * populado (lst_4c_EnvFtp para envio, lst_4c_EnvLoc para recebimento);
2271:     * o loop percorre a selecao (ou todos, conforme par_cModo) chamando
2272:     * EnviarArquivoFtp/ReceberArquivoFtp arquivo a arquivo, replicando o
2273:     * DO CASE ptptrans == "I"/"A" e o guard de selecao vazia do legado.
2274:     *==========================================================================
2275:     PROTECTED PROCEDURE Transferir(par_cModo)
2276:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2277:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoRemoto
2278:         LOCAL ARRAY loc_aArquivos[1]
2279: 
2280:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2281:         *-- qualquer caminho: e dali que saem this_cDirEnvFtp/this_cDirRecLoc
2282:         IF !THIS.FormParaBO()
2283:             RETURN .F.
2284:         ENDIF
2285: 
2286:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
2287:         loc_nQtd = loc_oObj.ListCount
2288: 
2289:         IF loc_nQtd <= 0
2290:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
2291:             RETURN .F.
2292:         ENDIF
2293: 
2294:         DIMENSION loc_aArquivos(loc_nQtd)
2295:         loc_nSelecionados = 0
2296: 
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
2316: 
2317:         THIS.HabilitarCampos(.F.)
2318: 
2319:         loc_lOk = .T.
2320:         FOR loc_nPos = 1 TO loc_nQtd
2321:             loc_cArquivo = loc_aArquivos(loc_nPos)
2322: 
2323:             IF EMPTY(ALLTRIM(loc_cArquivo))
2324:                 LOOP
2325:             ENDIF
2326: 
2327:             loc_cArquivoLocal  = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp + ALLTRIM(loc_cArquivo))
2328:             loc_cArquivoRemoto = LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cDirRecLoc + ALLTRIM(loc_cArquivo)))
2329: 
2330:             THIS.Inf("Processando o arquivo Local " + loc_cArquivoLocal + " para enviar ao FTP", "G")
2331: 
2332:             fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2333:                 SUBSTR("INICIANDO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2334: 
2335:             IF THIS.EnviarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2336:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2337:                     THIS.this_oBusinessObject.this_cFtpPass, ;
2338:                     loc_cArquivoLocal, loc_cArquivoRemoto)
2339:                 loc_lOk = .T.
2340:                 THIS.Inf("Arquivo Local " + loc_cArquivoLocal + " transferido para FTP.", "G")
2341:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2342:                     SUBSTR("ENVIO OK DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2343:             ELSE
2344:                 loc_lOk = .F.
2345:                 THIS.Inf("Problema: Arquivo Local " + loc_cArquivoLocal + " N" + CHR(227) + "O foi transferido para o FTP.", "R")
2346:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2347:                     SUBSTR("FALHA NO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2348:                 EXIT
2349:             ENDIF
2350:         ENDFOR
2351: 
2352:         IF loc_lOk
2353:             THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de transfer" + CHR(234) + "ncia Conclu" + CHR(237) + "da", "B")

*-- Linhas 2360 a 2441:
2360:         RETURN loc_lOk
2361:     ENDPROC
2362: 
2363:     PROTECTED PROCEDURE Receber(par_cModo)
2364:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2365:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoFtp
2366:         LOCAL ARRAY loc_aArquivos[1]
2367: 
2368:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2369:         *-- qualquer caminho: e dali que saem this_cDirEnvLoc/this_cDirRecFtp
2370:         IF !THIS.FormParaBO()
2371:             RETURN .F.
2372:         ENDIF
2373: 
2374:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
2375:         loc_nQtd = loc_oObj.ListCount
2376: 
2377:         IF loc_nQtd <= 0
2378:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
2379:             RETURN .F.
2380:         ENDIF
2381: 
2382:         DIMENSION loc_aArquivos(loc_nQtd)
2383:         loc_nSelecionados = 0
2384: 
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
2404: 
2405:         THIS.HabilitarCampos(.F.)
2406: 
2407:         loc_lOk = .T.
2408:         FOR loc_nPos = 1 TO loc_nQtd
2409:             loc_cArquivo = loc_aArquivos(loc_nPos)
2410: 
2411:             IF EMPTY(ALLTRIM(loc_cArquivo))
2412:                 LOOP
2413:             ENDIF
2414: 
2415:             loc_cArquivoFtp   = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvLoc + ALLTRIM(loc_cArquivo))
2416:             loc_cArquivoLocal = ALLTRIM(THIS.this_oBusinessObject.this_cDirRecFtp + ALLTRIM(loc_cArquivo))
2417: 
2418:             THIS.Inf("Processando o arquivo " + loc_cArquivoFtp + " para receber do FTP", "G")
2419: 
2420:             fGravarLog("X", THIS.Name, "REC FTP", ;
2421:                 SUBSTR("INICIANDO RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2422: 
2423:             IF THIS.VerificarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2424:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2425:                     THIS.this_oBusinessObject.this_cFtpPass, loc_cArquivoFtp)
2426:                 IF THIS.ReceberArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2427:                         THIS.this_oBusinessObject.this_cFtpUser, ;
2428:                         THIS.this_oBusinessObject.this_cFtpPass, ;
2429:                         loc_cArquivoFtp, loc_cArquivoLocal)
2430:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2431:                         SUBSTR("RECEPCAO OK DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2432:                     loc_lOk = .T.
2433:                 ELSE
2434:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2435:                         SUBSTR("FALHA NA RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2436:                     loc_lOk = .F.
2437:                 ENDIF
2438:             ELSE
2439:                 loc_lOk = .F.
2440:             ENDIF
2441: 

*-- Linhas 2471 a 2514:
2471:     * PROTECTED porque FormBase.BOParaForm eh PROTECTED - VFP9 nao permite
2472:     * ALARGAR o escopo de um metodo herdado.
2473:     *==========================================================================
2474:     PROTECTED PROCEDURE BOParaForm()
2475:         LOCAL loc_oPgLoc, loc_oPgFtp
2476: 
2477:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
2478:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
2479: 
2480:         WITH THIS.this_oBusinessObject
2481:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.Value       = .this_cDirEnvFtp
2482:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.ToolTipText = .this_cDirEnvFtp
2483: 
2484:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.Value       = .this_cDirRecFtp
2485:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.ToolTipText = .this_cDirRecFtp
2486: 
2487:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.Value       = .this_cDirRecLoc
2488:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.ToolTipText = .this_cDirRecLoc
2489: 
2490:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.Value       = .this_cDirEnvLoc
2491:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.ToolTipText = .this_cDirEnvLoc
2492:         ENDWITH
2493:     ENDPROC
2494: 
2495:     *==========================================================================
2496:     * FormParaBO - Le de volta os quatro campos de diretorio da tela para as
2497:     * properties do BO, aplicando a MESMA normalizacao do Init legado:
2498:     *   pasta LOCAL  -> ADDBS(LOWER(ALLTRIM(x)))
2499:     *   pasta REMOTA -> LOWER(ALLTRIM(x)) + "/" quando ainda nao termina em "/"
2500:     * (iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir+"/") do legado)
2501:     *
2502:     * Campo em BRANCO nao sobrescreve a property: sem isso um campo apagado
2503:     * zeraria a configuracao resolvida e a transferencia passaria a montar
2504:     * caminho a partir de "" - e os guards de sentido de ConfigurarPaginaDados
2505:     * (que rodam no Init) nao seriam reavaliados. Pasta LOCAL que nao existe
2506:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2507:     *
2508:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2509:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2510:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2511:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2512:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2513:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2514:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao

*-- Linhas 2536 a 2693:
2536:         *-- checagem com "if !empt(_DirEnvFtp) and !DIRECTORY(_DirEnvFtp)")
2537:         IF !EMPTY(loc_cEnvFtp) AND !DIRECTORY(loc_cEnvFtp)
2538:             THIS.Inf("A pasta local de envio " + loc_cEnvFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2539:             MsgAviso("A pasta local de envio informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cEnvFtp, ;
2540:                 "Aten" + CHR(231) + CHR(227) + "o")
2541:             loc_lOk = .F.
2542:         ENDIF
2543: 
2544:         IF !EMPTY(loc_cRecFtp) AND !DIRECTORY(loc_cRecFtp)
2545:             THIS.Inf("A pasta local de recebimento " + loc_cRecFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2546:             MsgAviso("A pasta local de recebimento informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cRecFtp, ;
2547:                 "Aten" + CHR(231) + CHR(227) + "o")
2548:             loc_lOk = .F.
2549:         ENDIF
2550: 
2551:         IF loc_lOk
2552:             WITH THIS.this_oBusinessObject
2553:                 IF !EMPTY(loc_cEnvFtp)
2554:                     .this_cDirEnvFtp = ADDBS(loc_cEnvFtp)
2555:                 ENDIF
2556: 
2557:                 IF !EMPTY(loc_cRecFtp)
2558:                     .this_cDirRecFtp = ADDBS(loc_cRecFtp)
2559:                 ENDIF
2560: 
2561:                 IF !EMPTY(loc_cRecLoc)
2562:                     .this_cDirRecLoc = IIF(RIGHT(loc_cRecLoc, 1) == "/", loc_cRecLoc, loc_cRecLoc + "/")
2563:                 ENDIF
2564: 
2565:                 IF !EMPTY(loc_cEnvLoc)
2566:                     .this_cDirEnvLoc = IIF(RIGHT(loc_cEnvLoc, 1) == "/", loc_cEnvLoc, loc_cEnvLoc + "/")
2567:                 ENDIF
2568:             ENDWITH
2569: 
2570:             *-- Reescreve a tela com o valor JA normalizado, para o que o
2571:             *-- usuario ve ser exatamente o que sera usado na transferencia
2572:             THIS.BOParaForm()
2573:         ENDIF
2574: 
2575:         RETURN loc_lOk
2576:     ENDFUNC
2577: 
2578:     *==========================================================================
2579:     * CarregarLista - Ponto unico de (re)carga das listas da tela: le os
2580:     * diretorios da tela para o BO, repovoa as quatro listas via MontaContainer
2581:     * e repinta os dois grids.
2582:     *
2583:     * O GO TOP + Refresh do fim nao eh enfeite: popular cursor NAO repinta
2584:     * grade em VFP9 (o legado sempre fecha com "go bott" + "GrdInf.refresh"),
2585:     * e sem isso a grade fica visualmente vazia com o cursor cheio.
2586:     *
2587:     * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
2588:     * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
2589:     *==========================================================================
2590:     PROCEDURE CarregarLista()
2591:         LOCAL loc_lSucesso
2592: 
2593:         loc_lSucesso = .F.
2594: 
2595:         IF !THIS.FormParaBO()
2596:             RETURN .F.
2597:         ENDIF
2598: 
2599:         loc_lSucesso = THIS.MontaContainer()
2600: 
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
2626:     *   ThisForm.cmdsair.enabled    = <flag>
2627:     *
2628:     * par_lHabilitar = .F. durante a transferencia (trava a tela), .T. ao
2629:     * terminar. cmd_4c_Encerrar segue o flag, como cmdsair no legado.
2630:     *
2631:     * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama
2632:     * de fora da classe.
2633:     *==========================================================================
2634:     PROCEDURE HabilitarCampos(par_lHabilitar)
2635:         LOCAL loc_lHabilitar
2636: 
2637:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2638: 
2639:         *-- "ThisForm.Container1.enabled = .t." do legado: fica .T. tanto ao
2640:         *-- iniciar quanto ao terminar a transferencia (transcrito, nao
2641:         *-- "corrigido" - as listas continuam navegaveis durante a operacao)
2642:         THIS.cnt_4c_Navegacao.Enabled  = .T.
2643:         THIS.cmd_4c_Transferir.Enabled = loc_lHabilitar
2644:         THIS.cmd_4c_Receber.Enabled    = loc_lHabilitar
2645:         THIS.cmd_4c_Encerrar.Enabled   = loc_lHabilitar
2646:     ENDPROC
2647: 
2648:     *==========================================================================
2649:     * BtnConectarClick - Click de cmd_4c_Conectar (cmdload do legado): valida
2650:     * o tipo de conexao (Dial-Up/Banda Larga), tenta conectar quando
2651:     * necessario e, tendo sucesso, habilita os botoes de transferencia
2652:     *==========================================================================
2653:     PROCEDURE BtnConectarClick()
2654:         LOCAL loc_lOk
2655:         loc_lOk = .T.
2656: 
2657:         THIS.cmd_4c_Conectar.Enabled = .F.
2658: 
2659:         DO CASE
2660:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2661:                 IF THIS.RasAtivas("aAtivas") > 0
2662:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2663:                     *-- "=ThisForm.MontaContainer()" seguido de "lOk = .t." no
2664:                     *-- legado: o retorno da carga eh DESCARTADO de proposito -
2665:                     *-- listagem que falha nao desabilita a transferencia
2666:                     THIS.CarregarLista()
2667:                     loc_lOk = .T.
2668:                 ELSE
2669:                     THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + " Internet N" + CHR(227) + "o detectada", "R")
2670:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2671:                     THIS.cmd_4c_RedeDialup.Visible = .T.
2672:                     loc_lOk = .F.
2673:                 ENDIF
2674: 
2675:             CASE THIS.this_oBusinessObject.this_cTpConnect == "B"
2676:                 THIS.Inf("Aguarde a inicializa" + CHR(231) + CHR(227) + "o das rotinas...", "B")
2677:                 THIS.Inf("Checando diret" + CHR(243) + "rios locais e conex" + CHR(245) + "es de rede...", "B")
2678:                 *-- idem ao ramo "D": o legado faz "lOk = .t." e so depois
2679:                 *-- "=ThisForm.MontaContainer()", descartando o retorno
2680:                 loc_lOk = .T.
2681:                 THIS.CarregarLista()
2682: 
2683:             OTHERWISE
2684:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2685:                 loc_lOk = .F.
2686:         ENDCASE
2687: 
2688:         IF loc_lOk
2689:             THIS.cnt_4c_Navegacao.Enabled                  = .T.
2690:             THIS.cmd_4c_Transferir.Enabled                 = .T.
2691:             THIS.cmd_4c_Receber.Enabled                    = .T.
2692:             THIS.cmd_4c_Encerrar.Enabled                   = .T.
2693:             THIS.cmd_4c_Conectar.Enabled                   = .F.

*-- Linhas 2709 a 2832:
2709:     * selecionado no combo (CboProvedor, adicionado junto com os demais
2710:     * controles de dados do PageFrame)
2711:     *==========================================================================
2712:     PROCEDURE BtnRedeDialupClick()
2713:         LOCAL loc_cProvedor, loc_cComando
2714: 
2715:         DO CASE
2716:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2717:                 IF THIS.RasAtivas("aAtivas") > 0
2718:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2719:                 ELSE
2720:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2721:                     *-- VFP9 nao faz short-circuit em AND/OR: TYPE() e o valor
2722:                     *-- da variavel tem de ser checados em IFs separados, senao
2723:                     *-- "nProvedor > 0" estoura "Variable NPROVEDOR is not found"
2724:                     *-- antes de nProvedor existir (CboProvedor, Fase 5-6)
2725:                     IF TYPE("nProvedor") = "N"
2726:                         IF nProvedor > 0
2727:                             loc_cProvedor = aProvedor(nProvedor)
2728:                             THIS.this_cProvedorConectado = loc_cProvedor
2729:                             loc_cComando  = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(loc_cProvedor)
2730:                             &loc_cComando.
2731:                         ELSE
2732:                             THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2733:                             MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2734:                         ENDIF
2735:                     ELSE
2736:                         THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2737:                         MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2738:                     ENDIF
2739:                 ENDIF
2740: 
2741:             OTHERWISE
2742:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2743:         ENDCASE
2744:     ENDPROC
2745: 
2746:     *==========================================================================
2747:     * BtnExecutarTransferenciaClick / BtnEnviaFtpClick - Click de cmd_4c_Transferir
2748:     * (cmdtran, transfere todos) e cmd_4c_EnviaFtp (cmdtransfere, transfere
2749:     * so os selecionados)
2750:     *==========================================================================
2751:     PROCEDURE BtnExecutarTransferenciaClick()
2752:         THIS.Transferir("A")
2753:     ENDPROC
2754: 
2755:     PROCEDURE BtnEnviaFtpClick()
2756:         THIS.Transferir("I")
2757:     ENDPROC
2758: 
2759:     *==========================================================================
2760:     * BtnExecutarRecebimentoClick / BtnRecebeFtpClick - Click de cmd_4c_Receber (cmdrec,
2761:     * recebe todos) e cmd_4c_RecebeFtp (cmdrecebe, recebe so os selecionados)
2762:     *==========================================================================
2763:     PROCEDURE BtnExecutarRecebimentoClick()
2764:         THIS.Receber("A")
2765:     ENDPROC
2766: 
2767:     PROCEDURE BtnRecebeFtpClick()
2768:         THIS.Receber("I")
2769:     ENDPROC
2770: 
2771:     *==========================================================================
2772:     * BtnEncerrarClick - Click de cmd_4c_Encerrar (cmdsair do legado:
2773:     * "ThisForm.release")
2774:     *==========================================================================
2775:     PROCEDURE BtnEncerrarClick()
2776:         THIS.Release()
2777:     ENDPROC
2778: 
2779:     *==========================================================================
2780:     * Destroy - Libera o Business Object; a restauracao do menu principal
2781:     * ja e feita por FormBase.Destroy via DODEFAULT()
2782:     *==========================================================================
2783:     PROCEDURE Destroy()
2784:         LOCAL loc_nAtivas, loc_cComando
2785: 
2786:         *-- "if ThisForm._TpConnect = 'D' ... " do PROCEDURE Release legado:
2787:         *-- se a conexao Dial-Up discada por BtnRedeDialupClick ainda estiver
2788:         *-- ativa ao fechar o form, avisa o usuario e desconecta (a mesma
2789:         *-- chamada RnaDial de novo funciona como toggle e derruba a conexao)
2790:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.this_cTpConnect == "D"
2791:             PUBLIC ARRAY aAtivas(1)
2792:             loc_nAtivas = THIS.RasAtivas("aAtivas")
2793: 
2794:             IF loc_nAtivas > 0
2795:                 MsgInfo("A conex" + CHR(227) + "o " + CHR(224) + " internet ainda est" + CHR(225) + " ativa...", "Aten" + CHR(231) + CHR(227) + "o")
2796: 
2797:                 IF !EMPTY(THIS.this_cProvedorConectado)
2798:                     loc_cComando = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedorConectado)
2799:                     &loc_cComando.
2800:                 ENDIF
2801:             ENDIF
2802: 
2803:             RELEASE aAtivas
2804:         ENDIF
2805: 
2806:         *-- Fecha os cursores locais do form (equivalente ao "sele logftp /
2807:         *-- use" e "sele tmpprog / use" do Destroy legado)
2808:         IF USED("cursor_4c_Progresso")
2809:             USE IN cursor_4c_Progresso
2810:         ENDIF
2811: 
2812:         IF USED("cursor_4c_Log")
2813:             USE IN cursor_4c_Log
2814:         ENDIF
2815: 
2816:         IF USED("cursor_4c_FtpServer")
2817:             USE IN cursor_4c_FtpServer
2818:         ENDIF
2819: 
2820:         *-- "Release aAtivas, cProvedor, aProvedor" do Destroy legado - os
2821:         *-- arrays/memvars PUBLIC do combo de provedores Dial-Up (criados em
2822:         *-- ConfigurarProvedorDialUp) nao devem sobreviver ao fechamento do form
2823:         IF TYPE("aProvedor") <> "U"
2824:             RELEASE aProvedor
2825:         ENDIF
2826:         IF TYPE("nProvedor") <> "U"
2827:             RELEASE nProvedor
2828:         ENDIF
2829: 
2830:         IF !ISNULL(THIS.this_oBusinessObject)
2831:             THIS.this_oBusinessObject = .NULL.
2832:         ENDIF


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


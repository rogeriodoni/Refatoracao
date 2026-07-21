# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGPRIMA): Top original=129 vs migrado 'obj_4c_OptTipo' Top=5 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGPRIMA): Left original=216 vs migrado 'obj_4c_OptTipo' Left=5 (diff=211px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprima.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (845 linhas total):

*-- Linhas 37 a 179:
37:     * Init - Aceita parametros do chamador (lcTipo1, lcPath1)
38:     * Em modo automatico ('A'): executa processamento e fecha sem exibir form
39:     *==========================================================================
40:     PROCEDURE Init(par_cTipo1, par_cPath1)
41:         LOCAL loc_lSucesso
42: 
43:         *-- Armazenar parametros antes do DODEFAULT
44:         THIS.this_cTipo1    = UPPER(ALLTRIM(IIF(VARTYPE(par_cTipo1) = "C", par_cTipo1, "")))
45:         THIS.this_cPath1    = ADDBS(ALLTRIM(IIF(VARTYPE(par_cPath1) = "C", par_cPath1, "")))
46:         THIS.this_lModoAuto = (THIS.this_cTipo1 == "A")
47: 
48:         *-- Em modo automatico, validar diretorio antes de criar form
49:         IF THIS.this_lModoAuto AND !EMPTY(THIS.this_cPath1)
50:             IF !DIRECTORY(THIS.this_cPath1)
51:                 MsgAviso("Diret" + CHR(243) + "rio de Importa" + CHR(231) + CHR(227) + ;
52:                          "o de Imagens Inv" + CHR(225) + "lido", "Pasta")
53:                 RETURN .F.
54:             ENDIF
55:         ENDIF
56: 
57:         *-- Inicializar Business Object
58:         THIS.this_oBusinessObject = CREATEOBJECT("sigprimaBO")
59:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
60:             MsgErro("Erro ao criar sigprimaBO.", "Erro")
61:             RETURN .F.
62:         ENDIF
63: 
64:         *-- FormBase.Init() -> InicializarForm()
65:         loc_lSucesso = DODEFAULT()
66:         IF !loc_lSucesso
67:             RETURN .F.
68:         ENDIF
69: 
70:         *-- Definir diretorio inicial no campo (criado em fase posterior)
71:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
72:             IF VARTYPE(THIS.txt_4c_Arquivo) = "O"
73:                 THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
74:             ENDIF
75:         ENDIF
76: 
77:         *-- Modo automatico: executar processamento e fechar sem exibir form
78:         IF THIS.this_lModoAuto
79:             THIS.this_oBusinessObject.Processamento(THIS.this_cPath1, 1)
80:             RETURN .F.
81:         ENDIF
82: 
83:         RETURN .T.
84:     ENDPROC
85: 
86:     *==========================================================================
87:     * InicializarForm - Configura controles da interface
88:     *==========================================================================
89:     PROCEDURE InicializarForm()
90:         LOCAL loc_lSucesso, loc_oErro
91:         loc_lSucesso = .F.
92: 
93:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
94:             RETURN .T.
95:         ENDIF
96: 
97:         TRY
98:             *-- Caption com acentos (via CHR - proibido literal acentuado em .PRG)
99:             THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"
100: 
101:             THIS.ConfigurarPageFrame()
102:             THIS.ConfigurarCabecalho()
103:             THIS.ConfigurarPaginaLista()
104:             THIS.ConfigurarPaginaDados()
105: 
106:             THIS.TornarControlesVisiveis()
107: 
108:             *-- Selecionar tipo padrao (Produtos) equivalente ao SCX original
109:             THIS.AlternarPagina(1)
110: 
111:             loc_lSucesso = .T.
112:         CATCH TO loc_oErro
113:             THIS.this_cMensagemErro = loc_oErro.Message
114:             MsgErro("Erro ao inicializar form: " + loc_oErro.Message + ;
115:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
116:                     " | Proc: " + loc_oErro.Procedure, "Erro")
117:         ENDTRY
118: 
119:         RETURN loc_lSucesso
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * ConfigurarPageFrame - Ajusta imagem de fundo do Form
124:     * OPERACIONAL flat: sem PageFrame; mantido por consistencia com FormBase
125:     * e demais forms operacionais (Formsigprila/Formsigprico/FormSIGPRIFF)
126:     *==========================================================================
127:     PROTECTED PROCEDURE ConfigurarPageFrame()
128:         LOCAL loc_cImgFundo
129:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
130:         IF FILE(loc_cImgFundo)
131:             THIS.Picture = loc_cImgFundo
132:         ENDIF
133:     ENDPROC
134: 
135:     *==========================================================================
136:     * ConfigurarCabecalho - Container cinza escuro com labels de titulo
137:     * Equivalente ao cntSombra do SCX original (Top=0, Height=80)
138:     *==========================================================================
139:     PROCEDURE ConfigurarCabecalho()
140:         LOCAL loc_oCnt, loc_cCaption
141:         loc_cCaption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"
142: 
143:         THIS.AddObject("cnt_4c_Sombra", "Container")
144:         loc_oCnt = THIS.cnt_4c_Sombra
145:         WITH loc_oCnt
146:             .Top        = 0
147:             .Left       = 0
148:             .Width      = THIS.Width
149:             .Height     = 80
150:             .BorderWidth = 0
151:             .BackColor  = RGB(100,100,100)
152:             .Visible    = .T.
153: 
154:             .AddObject("lbl_4c_LblSombra", "Label")
155:             WITH .lbl_4c_LblSombra
156:                 .AutoSize      = .F.
157:                 .FontBold      = .T.
158:                 .FontName      = "Tahoma"
159:                 .FontSize      = 18
160:                 .FontUnderline = .F.
161:                 .WordWrap      = .T.
162:                 .Alignment     = 0
163:                 .BackStyle     = 0
164:                 .Caption       = loc_cCaption
165:                 .Height        = 40
166:                 .Left          = 10
167:                 .Top           = 18
168:                 .Width         = THIS.Width
169:                 .ForeColor     = RGB(0,0,0)
170:                 .Visible       = .T.
171:             ENDWITH
172: 
173:             .AddObject("lbl_4c_LblTitulo", "Label")
174:             WITH .lbl_4c_LblTitulo
175:                 .AutoSize      = .F.
176:                 .FontBold      = .T.
177:                 .FontName      = "Tahoma"
178:                 .FontSize      = 18
179:                 .WordWrap      = .T.

*-- Linhas 192 a 330:
192:     ENDPROC
193: 
194:     *==========================================================================
195:     * TornarControlesVisiveis - Torna todos os controles do form visiveis
196:     * (AddObject cria controles com Visible=.F. por padrao)
197:     *==========================================================================
198:     PROCEDURE TornarControlesVisiveis()
199:         LOCAL loc_nI, loc_oObjeto
200:         FOR loc_nI = 1 TO THIS.ControlCount
201:             loc_oObjeto = THIS.Controls(loc_nI)
202:             IF VARTYPE(loc_oObjeto) = "O"
203:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
204:                     loc_oObjeto.Visible = .T.
205:                 ENDIF
206:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
207:                    loc_oObjeto.ControlCount > 0
208:                     THIS.TornarSubControlesVisiveis(loc_oObjeto)
209:                 ENDIF
210:             ENDIF
211:         ENDFOR
212:     ENDPROC
213: 
214:     *==========================================================================
215:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
216:     *==========================================================================
217:         LOCAL loc_nI, loc_oObjeto
218:         FOR loc_nI = 1 TO par_oContainer.ControlCount
219:             loc_oObjeto = par_oContainer.Controls(loc_nI)
220:             IF VARTYPE(loc_oObjeto) = "O"
221:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
222:                     loc_oObjeto.Visible = .T.
223:                 ENDIF
224:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
225:                    loc_oObjeto.ControlCount > 0
226:                     THIS.TornarSubControlesVisiveis(loc_oObjeto)
227:                 ENDIF
228:             ENDIF
229:         ENDFOR
230:     ENDPROC
231: 
232:     *==========================================================================
233:     * ConfigurarPaginaLista - Configura o corpo do form (area operacional)
234:     *
235:     * OPERACIONAL flat: nao ha PageFrame; a "pagina lista" corresponde a
236:     * toda a area do form abaixo do cabecalho, onde ficam:
237:     *   - Botoes de acao (Processar / Encerrar) - lado direito
238:     *   - Campos de parametros (Diretorio, Tipo de importacao)
239:     *==========================================================================
240:     PROTECTED PROCEDURE ConfigurarPaginaLista()
241:         THIS.ConfigurarBotoes()
242:         THIS.ConfigurarCampos()
243:     ENDPROC
244: 
245:     *==========================================================================
246:     * ConfigurarPaginaDados - Adiciona container decorativo de agrupamento
247:     * Equivalente ao Commandgroup3 do legado (ButtonCount=0, apenas visual):
248:     * borda de agrupamento ao redor dos botoes Processar/Encerrar.
249:     * Left=612, Top=7, Width=173, Height=110 / SpecialEffect=1 / ZOrder=1 (atras).
250:     *==========================================================================
251:     PROTECTED PROCEDURE ConfigurarPaginaDados()
252:         THIS.AddObject("obj_4c_Commandgroup3", "Container")
253:         WITH THIS.obj_4c_Commandgroup3
254:             .Top          = 7
255:             .Left         = 612
256:             .Width        = 173
257:             .Height       = 110
258:             .BackStyle    = 0
259:             .BorderWidth  = 1
260:             .SpecialEffect = 1
261:             .BorderColor  = RGB(136,189,188)
262:             .Visible      = .T.
263:         ENDWITH
264:         *-- Enviar para tras dos botoes (cosm?tico - nao interfere em eventos)
265:         THIS.obj_4c_Commandgroup3.ZOrder(1)
266:     ENDPROC
267: 
268:     *==========================================================================
269:     * AlternarPagina - Alterna o modo/tipo de importacao selecionado
270:     *
271:     * OPERACIONAL flat: nao ha paginas para alternar. Neste form, "alternar"
272:     * corresponde a selecionar um dos 3 tipos de importacao no OptionGroup:
273:     *   1 = Produtos, 2 = Auxiliar, 3 = Exportar
274:     * (equivalente semantico ao switch de pagina em forms CRUD)
275:     *==========================================================================
276:     PROTECTED PROCEDURE AlternarPagina(par_nTipo)
277:         IF VARTYPE(par_nTipo) = "N" AND BETWEEN(par_nTipo, 1, 3)
278:             IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND ;
279:                VARTYPE(THIS.obj_4c_OptTipo) = "O"
280:                 THIS.obj_4c_OptTipo.Value = par_nTipo
281:                 THIS.obj_4c_OptTipo.Refresh()
282:             ENDIF
283:         ENDIF
284:     ENDPROC
285: 
286:     *==========================================================================
287:     * ConfigurarBotoes - Adiciona botoes de acao (Processar e Encerrar)
288:     * Posicionados na area direita do cabecalho (Top=3), identicos ao legado
289:     *==========================================================================
290:     PROTECTED PROCEDURE ConfigurarBotoes()
291:         *-- Botao Processar (equivalente ao btnProcessar fwbtng do legado)
292:         THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
293:         WITH THIS.cmd_4c_BtnProcessar
294:             .Top             = 3
295:             .Left            = 650
296:             .Width           = 75
297:             .Height          = 75
298:             .Caption         = "Processar"
299:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
300:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
301:             .FontName        = "Comic Sans MS"
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .FontSize        = 8
305:             .ForeColor       = RGB(90,90,90)
306:             .BackColor       = RGB(255,255,255)
307:             .Themes          = .T.
308:             .SpecialEffect   = 0
309:             .PicturePosition = 13
310:             .MousePointer    = 15
311:             .WordWrap        = .T.
312:             .AutoSize        = .F.
313:             .Visible         = .T.
314:         ENDWITH
315: 
316:         *-- Botao Encerrar (equivalente ao btnSair fwbtng do legado)
317:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
318:         WITH THIS.cmd_4c_BtnSair
319:             .Top             = 3
320:             .Left            = 725
321:             .Width           = 75
322:             .Height          = 75
323:             .Caption         = "Encerrar"
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .FontName        = "Comic Sans MS"
327:             .FontBold        = .T.
328:             .FontItalic      = .T.
329:             .FontSize        = 8
330:             .ForeColor       = RGB(90,90,90)

*-- Linhas 339 a 390:
339:             .Visible         = .T.
340:         ENDWITH
341: 
342:         BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "CmdBtnProcessarClick")
343:         BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "CmdBtnSairClick")
344:     ENDPROC
345: 
346:     *==========================================================================
347:     * ConfigurarCampos - Adiciona campos operacionais: label, textbox diretorio,
348:     * botao browse "...", label tipo e OptionGroup de tipo de importacao
349:     *==========================================================================
350:     PROTECTED PROCEDURE ConfigurarCampos()
351:         *-- Label "Diretorio :"
352:         THIS.AddObject("lbl_4c_Label1", "Label")
353:         WITH THIS.lbl_4c_Label1
354:             .AutoSize  = .T.
355:             .FontBold  = .T.
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .Caption   = "Diret" + CHR(243) + "rio :"
359:             .Height    = 15
360:             .Left      = 156
361:             .Top       = 113
362:             .Width     = 58
363:             .ForeColor = RGB(90,90,90)
364:             .BackStyle = 0
365:             .Visible   = .T.
366:         ENDWITH
367: 
368:         *-- TextBox para o caminho do diretorio de imagens
369:         THIS.AddObject("txt_4c_Arquivo", "TextBox")
370:         WITH THIS.txt_4c_Arquivo
371:             .FontName      = "Tahoma"
372:             .FontSize      = 8
373:             .Value         = ""
374:             .Height        = 21
375:             .Left          = 216
376:             .SpecialEffect = 1
377:             .TabIndex      = 2
378:             .Top           = 110
379:             .Width         = 402
380:             .ForeColor     = RGB(0,0,0)
381:             .Visible       = .T.
382:         ENDWITH
383: 
384:         *-- Botao "..." para navegar e selecionar diretorio
385:         THIS.AddObject("cmd_4c_BtnArquivo", "CommandButton")
386:         WITH THIS.cmd_4c_BtnArquivo
387:             .Top       = 110
388:             .Left      = 622
389:             .Height    = 21
390:             .Width     = 21

*-- Linhas 415 a 459:
415:             .Visible   = .T.
416:         ENDWITH
417: 
418:         *-- OptionGroup para tipo de importacao (Produtos / Auxiliar / Exportar)
419:         THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
420:         WITH THIS.obj_4c_OptTipo
421:             .ButtonCount = 3
422:             .BackStyle   = 0
423:             .BorderStyle = 0
424:             .Value       = 1
425:             .Height      = 63
426:             .Left        = 216
427:             .Top         = 129
428:             .Width       = 92
429:             .Visible     = .T.
430: 
431:             WITH .Buttons(1)
432:                 .FontBold      = .T.
433:                 .FontUnderline = .F.
434:                 .BackStyle     = 0
435:                 .Caption       = "Produtos"
436:                 .Height        = 15
437:                 .Left          = 5
438:                 .Top           = 5
439:                 .Width         = 69
440:                 .AutoSize      = .T.
441:                 .ForeColor     = RGB(90,90,90)
442:             ENDWITH
443: 
444:             WITH .Buttons(2)
445:                 .FontBold      = .T.
446:                 .FontName      = "Tahoma"
447:                 .FontSize      = 8
448:                 .FontUnderline = .F.
449:                 .BackStyle     = 0
450:                 .Caption       = "Auxiliar"
451:                 .Height        = 15
452:                 .Left          = 5
453:                 .Top           = 24
454:                 .Width         = 61
455:                 .AutoSize      = .T.
456:                 .ForeColor     = RGB(90,90,90)
457:             ENDWITH
458: 
459:             WITH .Buttons(3)

*-- Linhas 471 a 845:
471:             ENDWITH
472:         ENDWITH
473: 
474:         BINDEVENT(THIS.cmd_4c_BtnArquivo, "Click",    THIS, "CmdBtnArquivoClick")
475:         BINDEVENT(THIS.txt_4c_Arquivo,    "KeyPress", THIS, "TxtArquivoKeyPress")
476:     ENDPROC
477: 
478:     *==========================================================================
479:     * CmdBtnArquivoClick - Abre dialogo GetDir para selecionar diretorio
480:     *==========================================================================
481:     PROCEDURE CmdBtnArquivoClick()
482:         LOCAL loc_cDir
483:         THIS.txt_4c_Arquivo.Value = ""
484:         loc_cDir = GETDIR("C:\", ;
485:                           "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
486:                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
487:         IF !EMPTY(loc_cDir)
488:             THIS.txt_4c_Arquivo.Value = loc_cDir
489:         ENDIF
490:         THIS.txt_4c_Arquivo.Refresh()
491:     ENDPROC
492: 
493:     *==========================================================================
494:     * CmdBtnProcessarClick - Executa Exportar (tipo=3) ou Processamento (tipos 1/2)
495:     *==========================================================================
496:     PROCEDURE CmdBtnProcessarClick()
497:         LOCAL loc_cDir, loc_nTipo
498:         loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
499:         loc_nTipo = THIS.obj_4c_OptTipo.Value
500: 
501:         IF EMPTY(loc_cDir)
502:             MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
503:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
504:             RETURN
505:         ENDIF
506: 
507:         IF loc_nTipo = 3
508:             THIS.this_oBusinessObject.Exportar(loc_cDir)
509:         ELSE
510:             THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
511:         ENDIF
512:     ENDPROC
513: 
514:     *==========================================================================
515:     * CmdBtnSairClick - Fecha o formulario
516:     *==========================================================================
517:     PROCEDURE CmdBtnSairClick()
518:         THIS.Release()
519:     ENDPROC
520: 
521:     *==========================================================================
522:     * TxtArquivoKeyPress - Valida/corrige diretorio ao pressionar ENTER ou TAB
523:     *==========================================================================
524:     PROCEDURE TxtArquivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
525:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
526:             RETURN
527:         ENDIF
528:         LOCAL loc_cDir
529:         loc_cDir = ALLTRIM(THIS.txt_4c_Arquivo.Value)
530:         IF !EMPTY(loc_cDir) AND !DIRECTORY(loc_cDir)
531:             loc_cDir = GETDIR("C:\", ;
532:                               "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
533:                               "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
534:         ENDIF
535:         THIS.txt_4c_Arquivo.Value = loc_cDir
536:         THIS.txt_4c_Arquivo.Refresh()
537:     ENDPROC
538: 
539:     *==========================================================================
540:     * BtnIncluirClick - Executa importacao (equivalente a "incluir" imagens)
541:     * Mapeamento semantico OPERACIONAL: Incluir = importar novas imagens
542:     * Valida diretorio e tipo, entao dispara Exportar (tipo 3) ou Processamento
543:     *==========================================================================
544:     PROCEDURE BtnIncluirClick()
545:         LOCAL loc_cDir, loc_nTipo
546: 
547:         loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
548:         loc_nTipo = THIS.obj_4c_OptTipo.Value
549: 
550:         IF EMPTY(loc_cDir)
551:             MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
552:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
553:             THIS.txt_4c_Arquivo.SetFocus()
554:             RETURN
555:         ENDIF
556: 
557:         IF !DIRECTORY(loc_cDir)
558:             MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
559:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
560:             THIS.txt_4c_Arquivo.SetFocus()
561:             RETURN
562:         ENDIF
563: 
564:         IF loc_nTipo = 3
565:             THIS.this_oBusinessObject.Exportar(loc_cDir)
566:         ELSE
567:             THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
568:         ENDIF
569:     ENDPROC
570: 
571:     *==========================================================================
572:     * BtnAlterarClick - Re-processa importacao (mesmo fluxo do Incluir).
573:     * Form OPERACIONAL de importacao nao possui distincao entre inserir e
574:     * alterar - reprocessa as imagens do diretorio informado.
575:     *==========================================================================
576:     PROCEDURE BtnAlterarClick()
577:         THIS.BtnIncluirClick()
578:     ENDPROC
579: 
580:     *==========================================================================
581:     * BtnVisualizarClick - Valida configuracao sem executar importacao
582:     * Conta arquivos JPG no diretorio informado e exibe resumo para o usuario
583:     *==========================================================================
584:     PROCEDURE BtnVisualizarClick()
585:         LOCAL loc_cDir, loc_nTipo, loc_cTipoDesc, loc_nArquivos
586:         LOCAL ARRAY loc_aArq(1)
587: 
588:         loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
589:         loc_nTipo = THIS.obj_4c_OptTipo.Value
590: 
591:         IF EMPTY(loc_cDir)
592:             MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
593:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
594:             THIS.txt_4c_Arquivo.SetFocus()
595:             RETURN
596:         ENDIF
597: 
598:         IF !DIRECTORY(loc_cDir)
599:             MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
600:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
601:             THIS.txt_4c_Arquivo.SetFocus()
602:             RETURN
603:         ENDIF
604: 
605:         loc_nArquivos = ADIR(loc_aArq, ADDBS(loc_cDir) + "*.JPG")
606:         loc_cTipoDesc = ICASE(loc_nTipo = 1, "Produtos", ;
607:                               loc_nTipo = 2, "Auxiliar", ;
608:                               loc_nTipo = 3, "Exportar", ;
609:                               "Desconhecido")
610: 
611:         MsgInfo("Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + ;
612:                 "Tipo: " + loc_cTipoDesc + CHR(13) + ;
613:                 "Arquivos .JPG encontrados: " + TRANSFORM(loc_nArquivos), ;
614:                 "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o")
615:     ENDPROC
616: 
617:     *==========================================================================
618:     * BtnExcluirClick - Limpa a configuracao atual (diretorio + tipo padrao)
619:     * Nao remove nenhum dado do banco - apenas reseta os campos da tela
620:     *==========================================================================
621:     PROCEDURE BtnExcluirClick()
622:         IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais?")
623:             THIS.txt_4c_Arquivo.Value = ""
624:             THIS.obj_4c_OptTipo.Value = 1
625:             THIS.txt_4c_Arquivo.Refresh()
626:             THIS.obj_4c_OptTipo.Refresh()
627:             THIS.txt_4c_Arquivo.SetFocus()
628:         ENDIF
629:     ENDPROC
630: 
631:     *==========================================================================
632:     * BtnBuscarClick - Valida configuracao antes de disparar (equivalente
633:     * semantico de "buscar" nesse form OPERACIONAL: pre-visualiza contagem
634:     * de arquivos .JPG no diretorio informado). Reusa BtnVisualizarClick.
635:     *==========================================================================
636:     PROCEDURE BtnBuscarClick()
637:         THIS.BtnVisualizarClick()
638:     ENDPROC
639: 
640:     *==========================================================================
641:     * BtnEncerrarClick - Fecha o formulario (alias semantico de CmdBtnSairClick)
642:     *==========================================================================
643:     PROCEDURE BtnEncerrarClick()
644:         THIS.CmdBtnSairClick()
645:     ENDPROC
646: 
647:     *==========================================================================
648:     * BtnSalvarClick - Confirma execucao (alias semantico de CmdBtnProcessarClick).
649:     * Sincroniza dados do form para o BO e dispara Exportar/Processamento.
650:     *==========================================================================
651:     PROCEDURE BtnSalvarClick()
652:         LOCAL loc_cDir, loc_nTipo
653: 
654:         THIS.FormParaBO()
655: 
656:         loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
657:         loc_nTipo = THIS.obj_4c_OptTipo.Value
658: 
659:         IF EMPTY(loc_cDir)
660:             MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
661:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
662:             THIS.txt_4c_Arquivo.SetFocus()
663:             RETURN
664:         ENDIF
665: 
666:         IF !DIRECTORY(loc_cDir)
667:             MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
668:                      "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
669:             THIS.txt_4c_Arquivo.SetFocus()
670:             RETURN
671:         ENDIF
672: 
673:         IF loc_nTipo = 3
674:             THIS.this_oBusinessObject.Exportar(loc_cDir)
675:         ELSE
676:             THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
677:         ENDIF
678:     ENDPROC
679: 
680:     *==========================================================================
681:     * BtnCancelarClick - Cancela operacao em andamento e limpa selecao atual
682:     * (reset dos campos + recarrega estado padrao). Nao fecha o formulario.
683:     *==========================================================================
684:     PROCEDURE BtnCancelarClick()
685:         THIS.LimparCampos()
686:         THIS.CarregarLista()
687:         THIS.AjustarBotoesPorModo("LISTA")
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * FormParaBO - Sincroniza valores dos controles da tela para o BO
692:     * Form OPERACIONAL: transfere diretorio e tipo de operacao selecionados
693:     *==========================================================================
694:     PROCEDURE FormParaBO()
695:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
696:             RETURN .F.
697:         ENDIF
698: 
699:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
700:             THIS.this_oBusinessObject.this_cDiretorio = ALLTRIM(THIS.txt_4c_Arquivo.Value)
701:         ENDIF
702: 
703:         IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
704:             THIS.this_oBusinessObject.this_nTipoOp = THIS.obj_4c_OptTipo.Value
705:         ENDIF
706: 
707:         THIS.this_oBusinessObject.this_cTipo1 = THIS.this_cTipo1
708:         RETURN .T.
709:     ENDPROC
710: 
711:     *==========================================================================
712:     * BOParaForm - Sincroniza valores do BO para os controles da tela
713:     * Form OPERACIONAL: restaura diretorio e tipo do BO nos controles
714:     *==========================================================================
715:     PROCEDURE BOParaForm()
716:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
717:             RETURN .F.
718:         ENDIF
719: 
720:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
721:             THIS.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cDiretorio
722:             THIS.txt_4c_Arquivo.Refresh()
723:         ENDIF
724: 
725:         IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
726:             IF BETWEEN(THIS.this_oBusinessObject.this_nTipoOp, 1, 3)
727:                 THIS.obj_4c_OptTipo.Value = THIS.this_oBusinessObject.this_nTipoOp
728:                 THIS.obj_4c_OptTipo.Refresh()
729:             ENDIF
730:         ENDIF
731: 
732:         RETURN .T.
733:     ENDPROC
734: 
735:     *==========================================================================
736:     * HabilitarCampos - Habilita/desabilita controles editaveis do form
737:     * conforme o modo atual (LISTA/DADOS/INCLUIR/ALTERAR/VISUALIZAR)
738:     *==========================================================================
739:     PROCEDURE HabilitarCampos(par_lHabilitar)
740:         LOCAL loc_lHab
741:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
742: 
743:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
744:             THIS.txt_4c_Arquivo.Enabled = loc_lHab
745:         ENDIF
746: 
747:         IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
748:             THIS.obj_4c_OptTipo.Enabled = loc_lHab
749:         ENDIF
750: 
751:         IF PEMSTATUS(THIS, "cmd_4c_BtnArquivo", 5) AND VARTYPE(THIS.cmd_4c_BtnArquivo) = "O"
752:             THIS.cmd_4c_BtnArquivo.Enabled = loc_lHab
753:         ENDIF
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * LimparCampos - Reseta os controles editaveis para valores default
758:     *==========================================================================
759:     PROCEDURE LimparCampos()
760:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
761:             THIS.txt_4c_Arquivo.Value = ""
762:             THIS.txt_4c_Arquivo.Refresh()
763:         ENDIF
764: 
765:         IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
766:             THIS.obj_4c_OptTipo.Value = 1
767:             THIS.obj_4c_OptTipo.Refresh()
768:         ENDIF
769: 
770:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
771:             THIS.this_oBusinessObject.this_cDiretorio = ""
772:             THIS.this_oBusinessObject.this_nTipoOp    = 1
773:             THIS.this_oBusinessObject.this_lSucesso   = .F.
774:             THIS.this_oBusinessObject.this_cMsgFinal  = ""
775:         ENDIF
776:     ENDPROC
777: 
778:     *==========================================================================
779:     * CarregarLista - Restaura o estado padrao dos campos operacionais
780:     * Form OPERACIONAL flat: nao ha grid de listagem; o metodo cumpre
781:     * o contrato semantico de "carregar estado inicial" pos-BtnCancelar
782:     *==========================================================================
783:     PROCEDURE CarregarLista()
784:         LOCAL loc_lSucesso
785:         loc_lSucesso = .F.
786: 
787:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
788:             IF !EMPTY(THIS.this_cPath1)
789:                 THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
790:             ENDIF
791:             THIS.txt_4c_Arquivo.Refresh()
792:         ENDIF
793: 
794:         IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
795:             THIS.obj_4c_OptTipo.Refresh()
796:         ENDIF
797: 
798:         loc_lSucesso = .T.
799:         RETURN loc_lSucesso
800:     ENDPROC
801: 
802:     *==========================================================================
803:     * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme o modo atual
804:     * Form OPERACIONAL: apenas 2 botoes de acao (Processar/Encerrar) sempre
805:     * habilitados; metodo cumpre o contrato dos forms CRUD para consistencia
806:     *==========================================================================
807:     PROCEDURE AjustarBotoesPorModo(par_cModo)
808:         LOCAL loc_cModo, loc_lEditavel
809:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "LISTA")))
810:         loc_lEditavel = (loc_cModo != "VISUALIZAR")
811: 
812:         IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5) AND ;
813:            VARTYPE(THIS.cmd_4c_BtnProcessar) = "O"
814:             THIS.cmd_4c_BtnProcessar.Enabled = loc_lEditavel
815:         ENDIF
816: 
817:         IF PEMSTATUS(THIS, "cmd_4c_BtnSair", 5) AND VARTYPE(THIS.cmd_4c_BtnSair) = "O"
818:             THIS.cmd_4c_BtnSair.Enabled = .T.
819:         ENDIF
820: 
821:         THIS.HabilitarCampos(loc_lEditavel)
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * Unload - Chamado ao encerrar o form
826:     * Em modo automatico: limpa loop de eventos para scripts batch
827:     *==========================================================================
828:     PROCEDURE Unload()
829:         IF THIS.this_lModoAuto
830:             CLEAR EVENTS
831:         ENDIF
832:         DODEFAULT()
833:     ENDPROC
834: 
835:     *==========================================================================
836:     * Destroy - Libera recursos
837:     *==========================================================================
838:     PROCEDURE Destroy()
839:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
840:             THIS.this_oBusinessObject = .NULL.
841:         ENDIF
842:         DODEFAULT()
843:     ENDPROC
844: 
845: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprimaBO.prg):
*====================================================================
* sigprimaBO.prg
* Business Object: Importacao/Exportacao de Imagens de Produtos
* Tabela principal: sigscjim
* Formulario OPERACIONAL
*====================================================================

DEFINE CLASS sigprimaBO AS BusinessBase

    *-- Tabela e chave (sigscjim)
    this_cTabela      = "sigscjim"
    this_cCampoChave  = "cidchaves"

    *-- Campos da tabela sigscjim
    this_cCidchaves = ""    && char(20) - chave primaria
    this_cCpros     = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_nIdimagem  = 0     && numeric(38,0) - id imagem
    this_cRefforref = ""    && char(50) - referencia do fornecedor

    *-- Parametros de operacao (passados via Init do form)
    this_cDiretorio = ""    && caminho do diretorio de imagens
    this_nTipoOp    = 1     && 1=Produtos, 2=Auxiliar(sigscjim), 3=Exportar
    this_cTipo1     = ""    && modo de execucao: 'A'=automatico, ''=manual

    *-- Resultado do processamento
    this_lSucesso   = .F.   && resultado do ultimo processamento
    this_cMsgFinal  = ""    && mensagem resultado a exibir

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigscjim"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida dados antes de inserir/atualizar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor sigscjim
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_nIdimagem  = TratarNulo(idimagem,  "N")
            THIS.this_cRefforref = TratarNulo(refforref, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidchaves = fUniqueIds()
            loc_cSQL = "INSERT INTO sigscjim " + ;
                       "(cidchaves, cpros, idimagem, refforref) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIdimagem, 0) + ", " + ;
                       EscaparSQL(THIS.this_cRefforref) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE sigscjim SET " + ;
                       "cpros     = " + EscaparSQL(THIS.this_cCpros)               + ", " + ;
                       "idimagem  = " + FormatarNumeroSQL(THIS.this_nIdimagem, 0)  + ", " + ;
                       "refforref = " + EscaparSQL(THIS.this_cRefforref)           + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processamento - Importa imagens JPG para produtos (SigCdPro) ou
    *                 registros auxiliares (sigscjim)
    * par_cDiretorio - diretorio com as imagens JPG
    * par_nTipo      - 1=Produtos, 2=Auxiliar(sigscjim)
    *====================================================================
    PROCEDURE Processamento(par_cDiretorio, par_nTipo)
        LOCAL loc_lSucesso, loc_cDir, loc_nTip, loc_nArq, loc_oErro
        LOCAL loc_oProgress, loc_nImg, loc_cImg, loc_cPro
        LOCAL loc_cDpro2, loc_cDpro3, loc_cReff, loc_cFig
        LOCAL loc_cSQL, loc_cQuery, loc_cMsg, loc_cDok, loc_cNom
        LOCAL loc_cArq, loc_cAok, loc_nCnt, loc_lVer, loc_lArq
        LOCAL loc_cImagem, loc_cImagem2, loc_cChave, loc_cOrigem
        LOCAL loc_nExiste
        LOCAL ARRAY loc_aArq(1)

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_nTip     = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 1)

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_nArq = ADIR(loc_aArq, loc_cDir + "*.JPG")

            IF loc_nArq < 1
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Cont" + CHR(233) + "m Nenhuma Imagem do Tipo .JPG!!!", ;
                         "Arquivos Inv" + CHR(225) + "lidos")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Nenhuma imagem .JPG encontrada."
                loc_lSucesso = .F.
            ENDIF

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processando Imagens...", loc_nArq)
            loc_oProgress.Show()

            loc_lSucesso = .T.

            FOR loc_nImg = 1 TO loc_nArq
                IF !loc_lSucesso
                    EXIT
                ENDIF

                loc_cImg  = ALLTRIM(loc_aArq(loc_nImg, 1))
                loc_lArq  = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")

                loc_cPro   = PADR(SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1), 14)
                loc_cDpro2 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cDpro3 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cReff  = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)

                loc_oProgress.SubTitulo.Caption = "Arquivo : " + ALLTRIM(loc_cImg)
                loc_oProgress.Update(.T.)

                IF loc_lArq
                    loc_cFig = loc_cDir + loc_cImg

                    IF FILE(loc_cFig)

                        IF loc_nTip = 2
                            *-- Modo auxiliar: busca em sigscjim por idimagem
                            loc_cQuery = "SELECT * FROM sigscjim WHERE idimagem = " + ;
                                         ALLTRIM(loc_cPro) + " ORDER BY CPros"

                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        loc_cImagem = FILETOSTR(loc_cFig)
                                        loc_cSQL    = "UPDATE sigscjim SET Imagem = ?loc_cImagem " + ;
                                                      "WHERE idimagem = " + ALLTRIM(loc_cPro) + ;
                                                      " AND CPros = " + EscaparSQL(cursor_4c_LocalPro.CPros)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigScjIm!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ELSE
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ENDIF

                                        IF USED("cursor_4c_Upd")
                                            USE IN cursor_4c_Upd
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF

                        ELSE
                            *-- Modo produtos: busca em SigCdPro por CPros/descricao/referencia

                            *-- Tentativa 1: busca por CPros
                            loc_cQuery = "SELECT * FROM SigCdPro WHERE CPros = " + ;
                                         EscaparSQL(loc_cPro) + " ORDER BY CPros"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            *-- Tentativa 2: busca por dPro2s
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(loc_cDpro2)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 3: busca por dPro2s sem pontos
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro2, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 4: busca por reffs (referencia fornecedor)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE reffs = " + ;
                                             EscaparSQL(ALLTRIM(loc_cReff)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 5: busca por dPro3s (descricao completa)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro " + ;
                                             "WHERE CONVERT(VARCHAR(50),dPro3s) = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro3, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        loc_cPro = cursor_4c_LocalPro.CPros

                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        *-- UPDATE SigCdPro com imagem
                                        loc_cImagem2 = FILETOSTR(loc_cFig)
                                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                                   "FigJpgs = ?loc_cImagem2, " + ;
                                                   "DtFilms = GETDATE(), " + ;
                                                   "Datas = GETDATE(), " + ;
                                                   "Flagctabs = 1, " + ;
                                                   "Transps = 0 " + ;
                                                   "WHERE CPros = " + EscaparSQL(loc_cPro)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        IF USED("cursor_4c_UpdPro")
                                            USE IN cursor_4c_UpdPro
                                        ENDIF

                                        *-- UPDATE/INSERT SigCdPrc com dados de auditoria
                                        IF loc_lSucesso
                                            loc_cChave  = fUniqueIds()
                                            loc_cOrigem = LEFT(TTOC(DATETIME()) + " SIGPRIMA", 50)

                                            IF SQLEXEC(gnConnHandle, ;
                                                "SELECT COUNT(1) AS nExiste FROM SigCdPrc " + ;
                                                "WHERE CPros = " + EscaparSQL(loc_cPro), ;
                                                "cursor_4c_ExistePrc") > 0 AND ;
                                               USED("cursor_4c_ExistePrc")
                                                SELECT cursor_4c_ExistePrc
                                                loc_nExiste = NVL(nExiste, 0)
                                                USE IN cursor_4c_ExistePrc
                                            ELSE
                                                loc_nExiste = 0
                                            ENDIF

                                            IF loc_nExiste > 0
                                                loc_cSQL = "UPDATE SigCdPrc SET " + ;
                                                           "DataAlts = GETDATE(), " + ;
                                                           "HoraAlts = " + EscaparSQL(TIME()) + ", " + ;
                                                           "UsuaAlts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                                                           "Origem   = " + EscaparSQL(loc_cOrigem) + ;
                                                           " WHERE CPros = " + EscaparSQL(loc_cPro)
                                            ELSE
                                                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                                                           "(cIdChaves, CPros, DataAlts, " + ;
                                                           "HoraAlts, UsuaAlts, Origem) VALUES (" + ;
                                                           EscaparSQL(loc_cChave)                      + ", " + ;
                                                           EscaparSQL(loc_cPro)                        + ", " + ;
                                                           "GETDATE(), "                               + ;
                                                           EscaparSQL(TIME())                          + ", " + ;
                                                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))    + ", " + ;
                                                           EscaparSQL(loc_cOrigem)                     + ;
                                                           ")"
                                            ENDIF

                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                        "vel Atualizar o Arquivo SigCdPrc!!!", ;
                                                        "Processamento Cancelado!!!")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        *-- DELETE FROM SigPrPrt
                                        IF loc_lSucesso
                                            loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + ;
                                                       EscaparSQL(loc_cPro)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                                        "Falha na Conex" + CHR(227) + "o (SigPrPrt)")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        IF loc_lSucesso
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ELSE
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                        ENDIF
                                    ENDIF
                                ENDSCAN

                                *-- Move arquivo para subpasta OK apos processamento
                                IF loc_lSucesso
                                    loc_cDok = loc_cDir + "OK\"
                                    IF !DIRECTORY(loc_cDok)
                                        MD (loc_cDok)
                                    ENDIF

                                    IF !DIRECTORY(loc_cDok)
                                        MsgAviso("O Diret" + CHR(243) + "rio [" + loc_cDok + ;
                                                 "] N" + CHR(227) + "o Pode Ser Criado!!!", ;
                                                 "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                                        loc_lSucesso = .F.
                                    ELSE
                                        loc_cNom = ALLTRIM(loc_aArq(loc_nImg, 1))
                                        loc_lArq = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")
                                        IF loc_lArq
                                            loc_cArq = loc_cDir + loc_cNom
                                            loc_cAok = ALLTRIM(loc_cDok) + "\" + ALLTRIM(loc_cNom)
                                            loc_nCnt = 0
                                            loc_lVer = .T.
                                            DO WHILE loc_lVer
                                                IF !FILE(loc_cAok)
                                                    loc_lVer = .F.
                                                    COPY FILE (loc_cArq) TO (loc_cAok)
                                                    IF FILE(loc_cAok)
                                                        DELETE FILE (loc_cArq)
                                                    ENDIF
                                                ELSE
                                                    loc_nCnt = loc_nCnt + 1
                                                    loc_cAok = loc_cDok + "\" + loc_cNom + "." + ;
                                                               PADL(loc_nCnt, 4, "0")
                                                ENDIF
                                            ENDDO
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            NEXT

            loc_oProgress.Complete()

            IF !loc_lSucesso
                loc_cMsg = "Os Arquivos N" + CHR(227) + "o Foram Importados!!!"
            ELSE
                loc_cMsg = "Os Arquivos Foram Importados!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

    *====================================================================
    * Exportar - Exporta imagens de produtos para arquivos JPG e
    *            converte para base64 (campo FigJpgs64)
    * par_cDiretorio - diretorio destino para os arquivos exportados
    *====================================================================
    PROCEDURE Exportar(par_cDiretorio)
        LOCAL loc_lSucesso, loc_cDir, loc_cMsg, loc_cQuery, loc_oErro
        LOCAL loc_cPro, loc_cFiltro, loc_cImag, loc_cSQL

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_cFiltro  = ""

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca grupos de produtos com imagem
            loc_cQuery = "SELECT cgrus, COUNT(1) AS qtd FROM sigcdpro " + ;
                         "WHERE 0=0 " + loc_cFiltro + ;
                         " GROUP BY cgrus ORDER BY 2"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Grupos") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Grupos)")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Falha ao buscar grupos."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            SCAN
                WAIT WINDOW "Atualizando o Grupo " + cursor_4c_Grupos.cgrus NOWAIT

                *-- Busca produtos do grupo
                loc_cQuery = "SELECT * FROM sigcdpro WHERE cgrus = " + ;
                             EscaparSQL(cursor_4c_Grupos.cgrus) + " " + loc_cFiltro
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Produtos)")
                    loc_lSucesso = .F.
                ENDIF

                IF loc_lSucesso AND USED("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    GO TOP IN cursor_4c_LocalPro

                    SCAN
                        *-- Pula produtos sem imagem
                        IF EMPTY(cursor_4c_LocalPro.FigJpgs)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Pula produtos que ja tem base64
                        IF !EMPTY(cursor_4c_LocalPro.FigJpgs64)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Exporta imagem para arquivo
                        loc_cPro = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                                   cursor_4c_LocalPro.cpros, "*", "_"), "/", "-"), "\", "-"))
                        STRTOFILE(cursor_4c_LocalPro.FigJpgs, ;
                                  loc_cDir + loc_cPro + ".jpg", .T.)

                        *-- Converte para base64 e atualiza FigJpgs64
                        loc_cImag = STRCONV(cursor_4c_LocalPro.FigJpgs, 13, 1046)

                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                   "FigJpgs64 = " + EscaparSQL("data:image/jpeg;base64," + loc_cImag) + ", " + ;
                                   "DtFilms   = GETDATE(), " + ;
                                   "Datas     = GETDATE(), " + ;
                                   "Flagctabs = 1, " + ;
                                   "Transps   = 0 " + ;
                                   "WHERE CPros = " + EscaparSQL(cursor_4c_LocalPro.cpros)

                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        ELSE
                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                    "Processamento Cancelado!!!")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                ENDIF

                SELECT cursor_4c_Grupos
            ENDSCAN

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            IF !loc_lSucesso
                loc_cMsg = "N" + CHR(227) + "o houve exporta" + CHR(231) + CHR(227) + "o!!!"
            ELSE
                loc_cMsg = "Exporta" + CHR(231) + CHR(227) + "o executada com sucesso!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

ENDDEFINE


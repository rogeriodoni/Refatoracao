# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_REFERENCIA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (948 linhas total):

*-- Linhas 35 a 191:
35:     *==========================================================================
36:     * Init - Cria BO e inicializa form via FormBase
37:     *==========================================================================
38:     PROCEDURE Init()
39:         THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTRFBO")
40:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
41:             MsgErro("Erro ao criar SIGPRTRFBO.", ;
42:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
43:             RETURN .F.
44:         ENDIF
45:         RETURN DODEFAULT()
46:     ENDPROC
47: 
48:     *==========================================================================
49:     * InicializarForm - Configura controles e carrega dados iniciais
50:     *==========================================================================
51:     PROCEDURE InicializarForm()
52:         LOCAL loc_lSucesso, loc_oErro
53:         loc_lSucesso = .F.
54: 
55:         THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Produtos"
56: 
57:         TRY
58:             *-- Criar cursor de produtos (RecordSource do grid - adicionado na Fase 4)
59:             SET NULL ON
60:             IF USED("CrProduto")
61:                 TABLEREVERT(.T., "CrProduto")
62:                 USE IN CrProduto
63:             ENDIF
64:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
65:             SET NULL OFF
66: 
67:             *-- Linha em branco inicial para entrada imediata
68:             SELECT CrProduto
69:             APPEND BLANK
70: 
71:             *-- Carregar tempo de espera ECF de SigCdPac
72:             THIS.this_oBusinessObject.CarregarConfiguracao()
73:             THIS.this_nClockEcfs = THIS.this_oBusinessObject.this_nClockEcfs
74: 
75:             *-- Montar layout do form
76:             THIS.ConfigurarPageFrame()
77:             THIS.ConfigurarReferencia()
78:             THIS.ConfigurarPaginaLista()
79:             THIS.ConfigurarPaginaDados()
80:             THIS.ConfigurarMensagem()
81:             THIS.ConfigurarBotoes()
82:             THIS.TornarControlesVisiveis()
83: 
84:             *-- Focar na primeira celula do grid apos montagem
85:             IF VARTYPE(THIS.cnt_4c_Referencia.grd_4c_Dados) = "O"
86:                 THIS.cnt_4c_Referencia.grd_4c_Dados.Column1.Text1.SetFocus()
87:             ENDIF
88: 
89:             loc_lSucesso = .T.
90:         CATCH TO loc_oErro
91:             THIS.this_cMensagemErro = loc_oErro.Message
92:             MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
93:                     " | Proc: " + loc_oErro.Procedure, ;
94:                     "Erro ao inicializar FormSIGPRTRF")
95:         ENDTRY
96: 
97:         RETURN loc_lSucesso
98:     ENDPROC
99: 
100:     *==========================================================================
101:     * ConfigurarPageFrame - Form flat sem PageFrame; compatibilidade com pipeline
102:     *==========================================================================
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:         *-- Form flat: sem PageFrame, cor de fundo neutra
105:         THIS.BackColor = RGB(240, 240, 240)
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarReferencia - Container principal com label identificador
110:     * Grid (grd_4c_Dados) sera adicionado na Fase 4
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarReferencia()
113:         LOCAL loc_oCnt
114: 
115:         THIS.AddObject("cnt_4c_Referencia", "Container")
116:         loc_oCnt = THIS.cnt_4c_Referencia
117:         WITH loc_oCnt
118:             .Top         = 1
119:             .Left        = 2
120:             .Width       = 433
121:             .Height      = 392
122:             .BackStyle   = 1
123:             .BackColor   = RGB(255, 255, 255)
124:             .BorderColor = RGB(128, 128, 128)
125:             .BorderWidth = 1
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oCnt.AddObject("lbl_4c_Ident", "Label")
130:         WITH loc_oCnt.lbl_4c_Ident
131:             .AutoSize    = .F.
132:             .FontBold    = .T.
133:             .FontSize    = 11
134:             .FontName    = "Tahoma"
135:             .Alignment   = 2
136:             .BackStyle   = 0
137:             .Caption     = "Informe os Produtos"
138:             .Height      = 20
139:             .Left        = 8
140:             .Top         = 57
141:             .Width       = 200
142:             .ForeColor   = RGB(0, 0, 255)
143:             .Visible     = .T.
144:         ENDWITH
145:     ENDPROC
146: 
147:     *==========================================================================
148:     * ConfigurarMensagem - Container de progresso ECF (fica Visible=.F. ate Ok)
149:     * 13 textboxes coloridos animados simulam barra de progresso (padrao legado)
150:     *==========================================================================
151:     PROTECTED PROCEDURE ConfigurarMensagem()
152:         LOCAL loc_oCnt, loc_nI, loc_nLeft, loc_cNome
153: 
154:         THIS.AddObject("cnt_4c_Mensagem", "Container")
155:         loc_oCnt = THIS.cnt_4c_Mensagem
156:         WITH loc_oCnt
157:             .Top          = 395
158:             .Left         = 3
159:             .Width        = 302
160:             .Height       = 55
161:             .SpecialEffect = 0
162:             .BackStyle    = 1
163:             .BackColor    = RGB(240, 240, 240)
164:             .BorderWidth  = 0
165:             .Visible      = .F.
166:         ENDWITH
167: 
168:         loc_oCnt.AddObject("lbl_4c_Mensagem1", "Label")
169:         WITH loc_oCnt.lbl_4c_Mensagem1
170:             .AutoSize    = .F.
171:             .FontBold    = .T.
172:             .FontSize    = 14
173:             .FontName    = "Tahoma"
174:             .Caption     = "Aguarde. Verificando Dados!!!"
175:             .Height      = 25
176:             .Left        = 16
177:             .Top         = 2
178:             .Width       = 277
179:             .ForeColor   = RGB(255, 0, 0)
180:             .BackStyle   = 0
181:             .Visible     = .T.
182:         ENDWITH
183: 
184:         *-- 13 textboxes para animacao de progresso (Left: 55, 71, 87...247, incremento 16)
185:         FOR loc_nI = 1 TO 13
186:             loc_cNome  = "txt_4c_Botao" + TRANSFORM(loc_nI)
187:             loc_nLeft  = 55 + (loc_nI - 1) * 16
188:             loc_oCnt.AddObject(loc_cNome, "TextBox")
189:             WITH loc_oCnt.&loc_cNome.
190:                 .BorderWidth = 0
191:                 .Height      = 11

*-- Linhas 202 a 254:
202:     *==========================================================================
203:     * ConfigurarPaginaDados - Form flat sem Page2; compatibilidade com pipeline
204:     *==========================================================================
205:     PROTECTED PROCEDURE ConfigurarPaginaDados()
206:         *-- Form flat sem Page2: elementos criados em ConfigurarBotoes
207:         RETURN .T.
208:     ENDPROC
209: 
210:     *==========================================================================
211:     * ConfigurarBotoes - Shape decorativo + botoes Ok e Cancelar
212:     * Shape1 original: Top=396 Left=311 Width=121 Height=52 SpecialEffect=0
213:     *==========================================================================
214:     PROTECTED PROCEDURE ConfigurarBotoes()
215:         *-- Shape decorativo de fundo (identico ao Shape1 do SCX original)
216:         THIS.AddObject("shp_4c_Shape1", "Shape")
217:         WITH THIS.shp_4c_Shape1
218:             .Top           = 396
219:             .Left          = 311
220:             .Width         = 121
221:             .Height        = 52
222:             .SpecialEffect = 0
223:             .BackStyle     = 0
224:             .FillStyle     = 1
225:             .BorderColor   = RGB(128, 128, 128)
226:             .Visible       = .T.
227:         ENDWITH
228: 
229:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
230:         WITH THIS.cmd_4c_Ok
231:             .Top             = 399
232:             .Left            = 314
233:             .Width           = 58
234:             .Height          = 47
235:             .FontBold        = .T.
236:             .FontName        = "Tahoma"
237:             .FontSize        = 7
238:             .Caption         = "\<Ok"
239:             .ForeColor       = RGB(0, 128, 0)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Picture         = gc_4c_CaminhoIcones + "A_SAVE1.BMP"
242:             .DisabledPicture = gc_4c_CaminhoIcones + "A_SAVE1.BMP"
243:             .PicturePosition = 13
244:             .Themes          = .T.
245:             .SpecialEffect   = 0
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .AutoSize        = .F.
249:             .Visible         = .T.
250:         ENDWITH
251: 
252:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
253:         WITH THIS.cmd_4c_Cancelar
254:             .Top             = 399

*-- Linhas 273 a 376:
273:             .Visible         = .T.
274:         ENDWITH
275: 
276:         BINDEVENT(THIS.cmd_4c_Ok,       "Click", THIS, "CmdOkClick")
277:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "CmdCancelarClick")
278:     ENDPROC
279: 
280:     *==========================================================================
281:     * TornarControlesVisiveis - Torna controles visiveis
282:     * cnt_4c_Mensagem permanece Visible=.F. mas seus filhos ficam visiveis
283:     *==========================================================================
284:     PROCEDURE TornarControlesVisiveis()
285:         LOCAL loc_i, loc_oControl
286:         FOR loc_i = 1 TO THIS.ControlCount
287:             loc_oControl = THIS.Controls(loc_i)
288:             IF VARTYPE(loc_oControl) = "O"
289:                 IF UPPER(loc_oControl.Name) = "CNT_4C_MENSAGEM"
290:                     *-- Torna filhos visiveis sem expor o container (fica Visible=.F.)
291:                     THIS.TornarSubControlesVisiveis(loc_oControl)
292:                     LOOP
293:                 ENDIF
294:                 loc_oControl.Visible = .T.
295:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
296:                    loc_oControl.ControlCount > 0
297:                     THIS.TornarSubControlesVisiveis(loc_oControl)
298:                 ENDIF
299:             ENDIF
300:         ENDFOR
301:     ENDPROC
302: 
303:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
304:         LOCAL loc_i, loc_oControl
305:         FOR loc_i = 1 TO par_oContainer.ControlCount
306:             loc_oControl = par_oContainer.Controls(loc_i)
307:             IF VARTYPE(loc_oControl) = "O"
308:                 loc_oControl.Visible = .T.
309:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
310:                    loc_oControl.ControlCount > 0
311:                     THIS.TornarSubControlesVisiveis(loc_oControl)
312:                 ENDIF
313:             ENDIF
314:         ENDFOR
315:     ENDPROC
316: 
317:     *==========================================================================
318:     * Unload - Retorna valor do dialogo ao chamador (padrao DO FORM xxx TO var)
319:     *==========================================================================
320:     PROCEDURE Unload()
321:         RETURN THIS.this_cRetorno
322:     ENDPROC
323: 
324:     *==========================================================================
325:     * Destroy - Limpeza ao fechar o form
326:     * Cursors em DataSession=2 sao limpos automaticamente pelo VFP9
327:     *==========================================================================
328:     PROCEDURE Destroy()
329:         DODEFAULT()
330:     ENDPROC
331: 
332:     *==========================================================================
333:     * ConfigurarPaginaLista - Adiciona grid de produtos ao cnt_4c_Referencia
334:     * Equivalente a sigprtrf.Cnt_Referencia.Grade do SCX original
335:     *==========================================================================
336:     PROTECTED PROCEDURE ConfigurarPaginaLista()
337:         LOCAL loc_oCnt, loc_oGrd
338: 
339:         loc_oCnt = THIS.cnt_4c_Referencia
340:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")
341:         loc_oGrd = loc_oCnt.grd_4c_Dados
342: 
343:         WITH loc_oGrd
344:             .Top                = 78
345:             .Left               = 3
346:             .Width              = 429
347:             .Height             = 309
348:             .ColumnCount        = 2
349:             .ScrollBars         = 2
350:             .FontName           = "Arial"
351:             .FontSize           = 8
352:             .ReadOnly           = .F.
353:             .RowHeight          = 17
354:             .RecordMark         = .F.
355:             .DeleteMark         = .F.
356:             .GridLineColor      = RGB(200, 200, 200)
357:             .HighlightStyle     = 2
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:         ENDWITH
361: 
362:         *-- Coluna 1: Codigo do Produto
363:         WITH loc_oGrd.Column1
364:             .Width      = 108
365:             .FontName   = "Courier New"
366:             .FontSize   = 8
367:             .Movable    = .F.
368:             .Resizable  = .F.
369:             .ReadOnly   = .F.
370:             .Sparse     = .F.
371:             .Format     = "K!"
372:         ENDWITH
373:         WITH loc_oGrd.Column1.Header1
374:             .Caption   = "C" + CHR(243) + "d. Produto"
375:             .FontName  = "Arial"
376:             .FontSize  = 8

*-- Linhas 421 a 487:
421:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
422: 
423:         *-- Vincular eventos de teclado e foco da Column1.Text1
424:         BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus", THIS, "TxtCodProdGotFocus")
425:         BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TxtCodProdKeyPress")
426:     ENDPROC
427: 
428:     *==========================================================================
429:     * AlternarPagina - Form flat sem PageFrame; mantido para compatibilidade
430:     *==========================================================================
431:     PROCEDURE AlternarPagina(par_nPagina)
432:         *-- Form flat sem PageFrame: nao ha paginas a alternar
433:         RETURN
434:     ENDPROC
435: 
436:     *==========================================================================
437:     * TxtCodProdGotFocus - Salva valor antes da edicao (equivalente ao When do SCX)
438:     *==========================================================================
439:     PROCEDURE TxtCodProdGotFocus()
440:         THIS.this_cAntCPro = ALLTRIM(THIS.cnt_4c_Referencia.grd_4c_Dados.Column1.Text1.Value)
441:     ENDPROC
442: 
443:     *==========================================================================
444:     * TxtCodProdKeyPress - Lookup de produto em SigCdPro por Enter/Tab/F4
445:     * Implementa logica do Valid (fwBuscaExt) e LostFocus (navegacao) do SCX
446:     *==========================================================================
447:     PROCEDURE TxtCodProdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
448: 
449:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
450:             RETURN
451:         ENDIF
452: 
453:         LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros
454:         LOCAL loc_cSQL, loc_oBusca, loc_lAchou, loc_nRecno
455:         loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
456:         loc_oTxt    = loc_oGrd.Column1.Text1
457:         loc_cCodigo = ALLTRIM(loc_oTxt.Value)
458:         loc_cDpros  = ""
459:         loc_lAchou  = .F.
460:         loc_nRecno  = 0
461: 
462:         *-- Codigo vazio: focar Ok se Enter, nao fazer mais nada
463:         IF EMPTY(loc_cCodigo)
464:             IF par_nKeyCode = 13
465:                 THIS.cmd_4c_Ok.SetFocus()
466:             ENDIF
467:             RETURN
468:         ENDIF
469: 
470:         *-- Codigo nao mudou e nao e F4: apenas navegar se Enter
471:         IF loc_cCodigo = THIS.this_cAntCPro AND par_nKeyCode != 115
472:             IF par_nKeyCode = 13
473:                 SELECT CrProduto
474:                 loc_nRecno = RECNO()
475:                 LOCATE FOR EMPTY(Cpros)
476:                 IF EOF()
477:                     APPEND BLANK
478:                 ENDIF
479:                 LOCATE FOR RECNO() = loc_nRecno
480:                 KEYBOARD '{DNARROW}'
481:             ENDIF
482:             RETURN
483:         ENDIF
484: 
485:         *-- Busca exata no SQL Server
486:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
487:                    "WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCodigo)

*-- Linhas 504 a 599:
504:             ENDIF
505:         ENDIF
506: 
507:         *-- Nao encontrado: abrir picker FormBuscaAuxiliar
508:         IF NOT loc_lAchou
509:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
510:                 "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
511:                 ALLTRIM(loc_oTxt.Value), "Produtos", .T., .T., "")
512:             IF VARTYPE(loc_oBusca) = "O"
513:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
514:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
515:                 loc_oBusca.Show()
516:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
517:                     SELECT cursor_4c_ProBusca
518:                     loc_cCodigo = ALLTRIM(cpros)
519:                     loc_cDpros  = ALLTRIM(dpros)
520:                     loc_lAchou  = .T.
521:                 ENDIF
522:                 IF USED("cursor_4c_ProBusca")
523:                     USE IN cursor_4c_ProBusca
524:                 ENDIF
525:                 loc_oBusca.Release()
526:             ENDIF
527:         ENDIF
528: 
529:         *-- Preencher campos no grid e navegar para proxima linha (se Enter)
530:         IF loc_lAchou
531:             loc_oTxt.Value = loc_cCodigo
532:             SELECT CrProduto
533:             REPLACE dpros WITH loc_cDpros
534:             loc_oGrd.Column2.Text1.Value = loc_cDpros
535:             loc_oGrd.Refresh()
536:             IF par_nKeyCode = 13
537:                 loc_nRecno = RECNO()
538:                 LOCATE FOR EMPTY(Cpros)
539:                 IF EOF()
540:                     APPEND BLANK
541:                 ENDIF
542:                 LOCATE FOR RECNO() = loc_nRecno
543:                 KEYBOARD '{DNARROW}'
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * CmdOkClick - Confirma lista e aguarda ECF (animacao de barras coloridas)
550:     * Equivalente ao altera.Click do SCX original
551:     *==========================================================================
552:     PROCEDURE CmdOkClick()
553:         LOCAL loc_nCount, loc_ldDataI, loc_nW, loc_nX, loc_nTempo
554:         LOCAL loc_nBot, loc_cMacro
555: 
556:         SELECT CrProduto
557:         COUNT TO loc_nCount FOR NOT EMPTY(Cpros)
558:         IF loc_nCount = 0
559:             MsgAviso("Nenhum Produto Informado!!!", ;
560:                      "Aten" + CHR(231) + CHR(227) + "o")
561:             RETURN
562:         ENDIF
563: 
564:         THIS.cnt_4c_Mensagem.Visible = .T.
565:         loc_ldDataI = DATETIME()
566:         loc_nW      = THIS.this_nClockEcfs / 3
567:         loc_nX      = 13
568: 
569:         DO WHILE DATETIME() - loc_ldDataI < THIS.this_nClockEcfs
570:             loc_nTempo = DATETIME() - loc_ldDataI
571:             IF loc_nX >= 13
572:                 loc_nX = 1
573:             ELSE
574:                 loc_nX = loc_nX + 1
575:             ENDIF
576:             IF loc_nTempo > loc_nW
577:                 IF loc_nTempo < loc_nW * 2
578:                     FOR loc_nBot = 1 TO 13
579:                         loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
580:                                      ALLTRIM(STR(loc_nBot, 2))
581:                         &loc_cMacro..BackColor = 65535
582:                     ENDFOR
583:                 ELSE
584:                     FOR loc_nBot = 1 TO 13
585:                         loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
586:                                      ALLTRIM(STR(loc_nBot, 2))
587:                         &loc_cMacro..BackColor = 4227072
588:                     ENDFOR
589:                 ENDIF
590:             ELSE
591:                 FOR loc_nBot = 1 TO 13
592:                     loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
593:                                  ALLTRIM(STR(loc_nBot, 2))
594:                     &loc_cMacro..BackColor = 255
595:                 ENDFOR
596:             ENDIF
597: 
598:             FOR loc_nBot = 1 TO 13
599:                 loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;

*-- Linhas 610 a 948:
610:     * CmdCancelarClick - Cancela dialogo sem transmitir produtos
611:     * Equivalente ao sair.Click do SCX original
612:     *==========================================================================
613:     PROCEDURE CmdCancelarClick()
614:         THIS.this_cRetorno = " "
615:         THIS.Release()
616:     ENDPROC
617: 
618:     *==========================================================================
619:     * BtnIncluirClick - Adiciona nova linha em branco ao cursor de produtos
620:     * Anexa a CrProduto e move o foco para a coluna de codigo do grid
621:     *==========================================================================
622:     PROCEDURE BtnIncluirClick()
623:         LOCAL loc_oGrd, loc_nRecno
624: 
625:         IF NOT USED("CrProduto")
626:             SET NULL ON
627:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
628:             SET NULL OFF
629:         ENDIF
630: 
631:         SELECT CrProduto
632:         LOCATE FOR EMPTY(Cpros)
633:         IF EOF()
634:             APPEND BLANK
635:         ENDIF
636:         loc_nRecno = RECNO()
637: 
638:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
639:         IF VARTYPE(loc_oGrd) = "O"
640:             loc_oGrd.Refresh()
641:             loc_oGrd.SetFocus()
642:             loc_oGrd.ActivateCell(loc_nRecno, 1)
643:             loc_oGrd.Column1.Text1.SetFocus()
644:         ENDIF
645:     ENDPROC
646: 
647:     *==========================================================================
648:     * BtnAlterarClick - Habilita edicao da linha corrente do grid de produtos
649:     * Move foco para a coluna Codigo do Produto na linha selecionada
650:     *==========================================================================
651:     PROCEDURE BtnAlterarClick()
652:         LOCAL loc_oGrd
653: 
654:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
655:             MsgAviso("Nenhum produto informado para alterar.", ;
656:                      "Aten" + CHR(231) + CHR(227) + "o")
657:             RETURN
658:         ENDIF
659: 
660:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
661:         IF VARTYPE(loc_oGrd) = "O"
662:             loc_oGrd.Column1.ReadOnly = .F.
663:             loc_oGrd.Refresh()
664:             loc_oGrd.SetFocus()
665:             loc_oGrd.Column1.Text1.SetFocus()
666:         ENDIF
667:     ENDPROC
668: 
669:     *==========================================================================
670:     * BtnVisualizarClick - Coloca o grid em modo somente-leitura para consulta
671:     * Refresh do grid com colunas em readonly (visualizacao pura)
672:     *==========================================================================
673:     PROCEDURE BtnVisualizarClick()
674:         LOCAL loc_oGrd
675: 
676:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
677:             MsgAviso("Nenhum produto informado para visualizar.", ;
678:                      "Aten" + CHR(231) + CHR(227) + "o")
679:             RETURN
680:         ENDIF
681: 
682:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
683:         IF VARTYPE(loc_oGrd) = "O"
684:             loc_oGrd.Column1.ReadOnly = .T.
685:             loc_oGrd.Column2.ReadOnly = .T.
686:             SELECT CrProduto
687:             GO TOP
688:             loc_oGrd.Refresh()
689:         ENDIF
690:     ENDPROC
691: 
692:     *==========================================================================
693:     * BtnExcluirClick - Remove linha corrente do cursor de produtos
694:     * Confirma com MsgConfirma antes de DELETE + PACK
695:     *==========================================================================
696:     PROCEDURE BtnExcluirClick()
697:         LOCAL loc_oGrd, loc_cCodigo, loc_lConfirma
698: 
699:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
700:             MsgAviso("Nenhum produto informado para excluir.", ;
701:                      "Aten" + CHR(231) + CHR(227) + "o")
702:             RETURN
703:         ENDIF
704: 
705:         SELECT CrProduto
706:         IF EMPTY(Cpros)
707:             MsgAviso("Selecione uma linha com produto v" + CHR(225) + "lido.", ;
708:                      "Aten" + CHR(231) + CHR(227) + "o")
709:             RETURN
710:         ENDIF
711: 
712:         loc_cCodigo   = ALLTRIM(Cpros)
713:         loc_lConfirma = MsgConfirma("Excluir o produto " + loc_cCodigo + " da rela" + ;
714:                                     CHR(231) + CHR(227) + "o?", ;
715:                                     "Confirma" + CHR(231) + CHR(227) + "o")
716:         IF NOT loc_lConfirma
717:             RETURN
718:         ENDIF
719: 
720:         SELECT CrProduto
721:         DELETE
722:         PACK
723:         IF RECCOUNT("CrProduto") = 0
724:             APPEND BLANK
725:         ENDIF
726:         GO TOP
727: 
728:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
729:         IF VARTYPE(loc_oGrd) = "O"
730:             loc_oGrd.Refresh()
731:             loc_oGrd.SetFocus()
732:             loc_oGrd.Column1.Text1.SetFocus()
733:         ENDIF
734:     ENDPROC
735: 
736:     *==========================================================================
737:     * BtnBuscarClick - Abre lookup de produto para a linha corrente do grid
738:     * Equivalente a pressionar F4 na coluna Codigo do Produto
739:     *==========================================================================
740:     PROCEDURE BtnBuscarClick()
741:         LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros, loc_oBusca
742: 
743:         IF NOT USED("CrProduto")
744:             MsgAviso("Nenhum produto informado.", ;
745:                      "Aten" + CHR(231) + CHR(227) + "o")
746:             RETURN
747:         ENDIF
748: 
749:         loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
750:         loc_oTxt    = loc_oGrd.Column1.Text1
751:         loc_cCodigo = ALLTRIM(loc_oTxt.Value)
752: 
753:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
754:             "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
755:             loc_cCodigo, "Produtos", .T., .T., "")
756:         IF VARTYPE(loc_oBusca) = "O"
757:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
758:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
759:             loc_oBusca.Show()
760:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
761:                 SELECT cursor_4c_ProBusca
762:                 loc_cCodigo = ALLTRIM(cpros)
763:                 loc_cDpros  = ALLTRIM(dpros)
764:                 loc_oTxt.Value = loc_cCodigo
765:                 SELECT CrProduto
766:                 REPLACE dpros WITH loc_cDpros
767:                 loc_oGrd.Column2.Text1.Value = loc_cDpros
768:                 loc_oGrd.Refresh()
769:             ENDIF
770:             IF USED("cursor_4c_ProBusca")
771:                 USE IN cursor_4c_ProBusca
772:             ENDIF
773:             loc_oBusca.Release()
774:         ENDIF
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * BtnEncerrarClick - Cancela o dialogo sem transmitir produtos
779:     * Alias de CmdCancelarClick para compatibilidade com o pipeline
780:     *==========================================================================
781:     PROCEDURE BtnEncerrarClick()
782:         THIS.CmdCancelarClick()
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * BtnSalvarClick - Confirma a lista de produtos (alias de CmdOkClick)
787:     * Compatibilidade com o pipeline de migracao
788:     *==========================================================================
789:     PROCEDURE BtnSalvarClick()
790:         THIS.CmdOkClick()
791:     ENDPROC
792: 
793:     *==========================================================================
794:     * BtnCancelarClick - Cancela edicao corrente e restaura linha anterior
795:     * Em dialogo sem modo edicao separado: equivale a cancelar selecao
796:     *==========================================================================
797:     PROCEDURE BtnCancelarClick()
798:         LOCAL loc_oGrd
799: 
800:         SELECT CrProduto
801:         IF NOT EMPTY(THIS.this_cAntCPro)
802:             REPLACE Cpros WITH THIS.this_cAntCPro
803:         ENDIF
804:         THIS.this_cAntCPro = ""
805: 
806:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
807:         IF VARTYPE(loc_oGrd) = "O"
808:             loc_oGrd.Refresh()
809:             loc_oGrd.SetFocus()
810:             loc_oGrd.Column1.Text1.SetFocus()
811:         ENDIF
812:     ENDPROC
813: 
814:     *==========================================================================
815:     * FormParaBO - Transfere a lista de produtos do cursor CrProduto para o BO
816:     * O BO guarda a lista para processamento posterior (transmissao ECF)
817:     *==========================================================================
818:     PROCEDURE FormParaBO()
819:         IF NOT USED("CrProduto")
820:             RETURN
821:         ENDIF
822:         THIS.this_oBusinessObject.CarregarProdutosDeCursor("CrProduto")
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * BOParaForm - Carrega lista de produtos do BO no cursor CrProduto
827:     * Usado quando o dialogo reabre com uma lista pre-existente
828:     *==========================================================================
829:     PROCEDURE BOParaForm()
830:         LOCAL loc_oGrd
831: 
832:         IF NOT USED("CrProduto")
833:             SET NULL ON
834:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
835:             SET NULL OFF
836:         ENDIF
837: 
838:         SELECT CrProduto
839:         ZAP
840: 
841:         THIS.this_oBusinessObject.PopularCursorProdutos("CrProduto")
842: 
843:         IF RECCOUNT("CrProduto") = 0
844:             SELECT CrProduto
845:             APPEND BLANK
846:         ENDIF
847: 
848:         GO TOP
849: 
850:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
851:         IF VARTYPE(loc_oGrd) = "O"
852:             loc_oGrd.Refresh()
853:         ENDIF
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * HabilitarCampos - Habilita ou desabilita edicao do grid de produtos
858:     * par_lHabilitar: .T. = edicao livre; .F. = somente visualizacao
859:     *==========================================================================
860:     PROCEDURE HabilitarCampos(par_lHabilitar)
861:         LOCAL loc_oGrd
862: 
863:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
864:         IF VARTYPE(loc_oGrd) != "O"
865:             RETURN
866:         ENDIF
867: 
868:         IF VARTYPE(par_lHabilitar) != "L"
869:             par_lHabilitar = .T.
870:         ENDIF
871: 
872:         loc_oGrd.Column1.ReadOnly = !par_lHabilitar
873:         loc_oGrd.Refresh()
874:     ENDPROC
875: 
876:     *==========================================================================
877:     * LimparCampos - Esvazia a lista de produtos e redefine linha inicial
878:     * Equivale ao estado inicial do dialogo
879:     *==========================================================================
880:     PROCEDURE LimparCampos()
881:         LOCAL loc_oGrd
882: 
883:         IF USED("CrProduto")
884:             SELECT CrProduto
885:             ZAP
886:             APPEND BLANK
887:         ENDIF
888: 
889:         THIS.this_cAntCPro = ""
890: 
891:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
892:         IF VARTYPE(loc_oGrd) = "O"
893:             loc_oGrd.Refresh()
894:             loc_oGrd.SetFocus()
895:             loc_oGrd.Column1.Text1.SetFocus()
896:         ENDIF
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * CarregarLista - Atualiza o grid com o conteudo corrente de CrProduto
901:     * Redefine RecordSource e cabecalhos (VFP9 os reseta apos RecordSource)
902:     *==========================================================================
903:     PROCEDURE CarregarLista()
904:         LOCAL loc_oGrd, loc_lSucesso
905:         loc_lSucesso = .F.
906: 
907:         TRY
908:             IF NOT USED("CrProduto")
909:                 SET NULL ON
910:                 CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
911:                 SET NULL OFF
912:                 SELECT CrProduto
913:                 APPEND BLANK
914:             ENDIF
915: 
916:             loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
917:             IF VARTYPE(loc_oGrd) = "O"
918:                 loc_oGrd.ColumnCount          = 2
919:                 loc_oGrd.RecordSource         = "CrProduto"
920:                 loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
921:                 loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
922:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
923:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
924:                 loc_oGrd.Refresh()
925:             ENDIF
926:             loc_lSucesso = .T.
927:         CATCH TO loc_oErro
928:             MsgErro(loc_oErro.Message + " | LN: " + TRANSFORM(loc_oErro.LineNo), ;
929:                     "Erro ao carregar lista")
930:         ENDTRY
931: 
932:         RETURN loc_lSucesso
933:     ENDPROC
934: 
935:     *==========================================================================
936:     * AjustarBotoesPorModo - Sem modo separado neste dialogo; sem botoes CRUD
937:     * Mantido para compatibilidade com o pipeline
938:     *==========================================================================
939:     PROCEDURE AjustarBotoesPorModo()
940:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
941:             THIS.cmd_4c_Ok.Enabled = .T.
942:         ENDIF
943:         IF VARTYPE(THIS.cmd_4c_Cancelar) = "O"
944:             THIS.cmd_4c_Cancelar.Enabled = .T.
945:         ENDIF
946:     ENDPROC
947: 
948: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRTRFBO.prg):
*==============================================================================
* SIGPRTRFBO.prg - Business Object para Relacao de Produtos (SIGPRTRF)
* Formulario OPERACIONAL - dialogo de selecao de produtos
* Tabela principal: SigCdPro (lookup de produtos)
* Tabela auxiliar:  SigCdPac (ClockEcfs - tempo de espera ECF)
*==============================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Tabela e chave primaria
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "cpros"

    *-- Configuracao de temporizacao (SigCdPac.ClockEcfs)
    this_nClockEcfs  = 0

    *-- Estado do dialogo
    this_cRetorno    = " "
    this_cAntCPro    = ""

    *-- Produto corrente (cpros char(14), dpros char(40))
    this_cCpros      = ""
    this_cDpros      = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarConfiguracao - carrega ClockEcfs de SigCdPac
    *==========================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.
        loc_cSQL     = "SELECT ClockEcfs FROM SigCdPac"

        TRY
            IF USED("cursor_4c_Pac")
                TABLEREVERT(.T., "cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    THIS.this_nClockEcfs = NVL(ClockEcfs, 0)
                ELSE
                    THIS.this_nClockEcfs = 0
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_nClockEcfs = 0
                loc_lSucesso         = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_nClockEcfs = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarProduto - busca produtos por codigo/descricao em SigCdPro
    * par_cCodigo        - valor digitado para busca (LIKE prefix)
    * par_cCursorDestino - cursor de destino (default: cursor_4c_Prods)
    * Retorna .T. se SQLEXEC bem-sucedido
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodigo, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Prods", par_cCursorDestino)
        loc_cSQL     = "SELECT cpros, dpros FROM SigCdPro" + ;
                       " WHERE cpros LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cpros"

        TRY
            IF USED(loc_cCursor)
                TABLEREVERT(.T., loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarProduto - valida se codigo exato existe em SigCdPro
    * Popula this_cCpros e this_cDpros com dados do produto encontrado
    * Retorna .T. se encontrado, .F. caso contrario
    *==========================================================================
    PROCEDURE ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso     = .F.
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro" + ;
                   " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        TRY
            IF USED("cursor_4c_ProdVal")
                TABLEREVERT(.T., "cursor_4c_ProdVal")
                USE IN cursor_4c_ProdVal
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal") > 0
                IF USED("cursor_4c_ProdVal") AND !EOF("cursor_4c_ProdVal")
                    SELECT cursor_4c_ProdVal
                    THIS.this_cCpros = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDpros = ALLTRIM(NVL(dpros, ""))
                    loc_lSucesso     = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros = TratarNulo(cpros, "C")
            THIS.this_cDpros = TratarNulo(dpros, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave primaria do produto corrente
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDPROC

    *==========================================================================
    * ValidarDados - valida dados antes de confirmar selecao
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + ;
                                      CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

ENDDEFINE


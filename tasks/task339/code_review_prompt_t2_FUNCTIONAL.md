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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (953 linhas total):

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

*-- Linhas 273 a 381:
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
283:     * cnt_4c_Referencia gerenciado por ConfigurarReferencia; filhos tornados visiveis
284:     *==========================================================================
285:     PROCEDURE TornarControlesVisiveis()
286:         LOCAL loc_i, loc_oControl
287:         FOR loc_i = 1 TO THIS.ControlCount
288:             loc_oControl = THIS.Controls(loc_i)
289:             IF VARTYPE(loc_oControl) = "O"
290:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_MENSAGEM", "CNT_4C_REFERENCIA")
291:                     *-- Containers ocultos ou gerenciados: torna filhos visiveis sem alterar Visible do container
292:                     THIS.TornarSubControlesVisiveis(loc_oControl)
293:                     *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
294:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
295:                         THIS.TornarControlesVisiveis(loc_oControl)
296:                     ENDIF
297:                     LOOP
298:                 ENDIF
299:                 loc_oControl.Visible = .T.
300:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
301:                    loc_oControl.ControlCount > 0
302:                     THIS.TornarSubControlesVisiveis(loc_oControl)
303:                 ENDIF
304:             ENDIF
305:         ENDFOR
306:     ENDPROC
307: 
308:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
309:         LOCAL loc_i, loc_oControl
310:         FOR loc_i = 1 TO par_oContainer.ControlCount
311:             loc_oControl = par_oContainer.Controls(loc_i)
312:             IF VARTYPE(loc_oControl) = "O"
313:                 loc_oControl.Visible = .T.
314:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
315:                    loc_oControl.ControlCount > 0
316:                     THIS.TornarSubControlesVisiveis(loc_oControl)
317:                 ENDIF
318:             ENDIF
319:         ENDFOR
320:     ENDPROC
321: 
322:     *==========================================================================
323:     * Unload - Retorna valor do dialogo ao chamador (padrao DO FORM xxx TO var)
324:     *==========================================================================
325:     PROCEDURE Unload()
326:         RETURN THIS.this_cRetorno
327:     ENDPROC
328: 
329:     *==========================================================================
330:     * Destroy - Limpeza ao fechar o form
331:     * Cursors em DataSession=2 sao limpos automaticamente pelo VFP9
332:     *==========================================================================
333:     PROCEDURE Destroy()
334:         DODEFAULT()
335:     ENDPROC
336: 
337:     *==========================================================================
338:     * ConfigurarPaginaLista - Adiciona grid de produtos ao cnt_4c_Referencia
339:     * Equivalente a sigprtrf.Cnt_Referencia.Grade do SCX original
340:     *==========================================================================
341:     PROTECTED PROCEDURE ConfigurarPaginaLista()
342:         LOCAL loc_oCnt, loc_oGrd
343: 
344:         loc_oCnt = THIS.cnt_4c_Referencia
345:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")
346:         loc_oGrd = loc_oCnt.grd_4c_Dados
347: 
348:         WITH loc_oGrd
349:             .Top                = 78
350:             .Left               = 3
351:             .Width              = 429
352:             .Height             = 309
353:             .ColumnCount        = 2
354:             .ScrollBars         = 2
355:             .FontName           = "Arial"
356:             .FontSize           = 8
357:             .ReadOnly           = .F.
358:             .RowHeight          = 17
359:             .RecordMark         = .F.
360:             .DeleteMark         = .F.
361:             .GridLineColor      = RGB(200, 200, 200)
362:             .HighlightStyle     = 2
363:             .HighlightBackColor = RGB(255, 255, 255)
364:             .HighlightForeColor = RGB(15, 41, 104)
365:         ENDWITH
366: 
367:         *-- Coluna 1: Codigo do Produto
368:         WITH loc_oGrd.Column1
369:             .Width      = 108
370:             .FontName   = "Courier New"
371:             .FontSize   = 8
372:             .Movable    = .F.
373:             .Resizable  = .F.
374:             .ReadOnly   = .F.
375:             .Sparse     = .F.
376:             .Format     = "K!"
377:         ENDWITH
378:         WITH loc_oGrd.Column1.Header1
379:             .Caption   = "C" + CHR(243) + "d. Produto"
380:             .FontName  = "Arial"
381:             .FontSize  = 8

*-- Linhas 426 a 492:
426:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
427: 
428:         *-- Vincular eventos de teclado e foco da Column1.Text1
429:         BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus", THIS, "TxtCodProdGotFocus")
430:         BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TxtCodProdKeyPress")
431:     ENDPROC
432: 
433:     *==========================================================================
434:     * AlternarPagina - Form flat sem PageFrame; mantido para compatibilidade
435:     *==========================================================================
436:     PROCEDURE AlternarPagina(par_nPagina)
437:         *-- Form flat sem PageFrame: nao ha paginas a alternar
438:         RETURN
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * TxtCodProdGotFocus - Salva valor antes da edicao (equivalente ao When do SCX)
443:     *==========================================================================
444:     PROCEDURE TxtCodProdGotFocus()
445:         THIS.this_cAntCPro = ALLTRIM(THIS.cnt_4c_Referencia.grd_4c_Dados.Column1.Text1.Value)
446:     ENDPROC
447: 
448:     *==========================================================================
449:     * TxtCodProdKeyPress - Lookup de produto em SigCdPro por Enter/Tab/F4
450:     * Implementa logica do Valid (fwBuscaExt) e LostFocus (navegacao) do SCX
451:     *==========================================================================
452:     PROCEDURE TxtCodProdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
453: 
454:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
455:             RETURN
456:         ENDIF
457: 
458:         LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros
459:         LOCAL loc_cSQL, loc_oBusca, loc_lAchou, loc_nRecno
460:         loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
461:         loc_oTxt    = loc_oGrd.Column1.Text1
462:         loc_cCodigo = ALLTRIM(loc_oTxt.Value)
463:         loc_cDpros  = ""
464:         loc_lAchou  = .F.
465:         loc_nRecno  = 0
466: 
467:         *-- Codigo vazio: focar Ok se Enter, nao fazer mais nada
468:         IF EMPTY(loc_cCodigo)
469:             IF par_nKeyCode = 13
470:                 THIS.cmd_4c_Ok.SetFocus()
471:             ENDIF
472:             RETURN
473:         ENDIF
474: 
475:         *-- Codigo nao mudou e nao e F4: apenas navegar se Enter
476:         IF loc_cCodigo = THIS.this_cAntCPro AND par_nKeyCode != 115
477:             IF par_nKeyCode = 13
478:                 SELECT CrProduto
479:                 loc_nRecno = RECNO()
480:                 LOCATE FOR EMPTY(Cpros)
481:                 IF EOF()
482:                     APPEND BLANK
483:                 ENDIF
484:                 LOCATE FOR RECNO() = loc_nRecno
485:                 KEYBOARD '{DNARROW}'
486:             ENDIF
487:             RETURN
488:         ENDIF
489: 
490:         *-- Busca exata no SQL Server
491:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
492:                    "WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCodigo)

*-- Linhas 509 a 604:
509:             ENDIF
510:         ENDIF
511: 
512:         *-- Nao encontrado: abrir picker FormBuscaAuxiliar
513:         IF NOT loc_lAchou
514:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
515:                 "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
516:                 ALLTRIM(loc_oTxt.Value), "Produtos", .T., .T., "")
517:             IF VARTYPE(loc_oBusca) = "O"
518:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
519:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
520:                 loc_oBusca.Show()
521:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
522:                     SELECT cursor_4c_ProBusca
523:                     loc_cCodigo = ALLTRIM(cpros)
524:                     loc_cDpros  = ALLTRIM(dpros)
525:                     loc_lAchou  = .T.
526:                 ENDIF
527:                 IF USED("cursor_4c_ProBusca")
528:                     USE IN cursor_4c_ProBusca
529:                 ENDIF
530:                 loc_oBusca.Release()
531:             ENDIF
532:         ENDIF
533: 
534:         *-- Preencher campos no grid e navegar para proxima linha (se Enter)
535:         IF loc_lAchou
536:             loc_oTxt.Value = loc_cCodigo
537:             SELECT CrProduto
538:             REPLACE dpros WITH loc_cDpros
539:             loc_oGrd.Column2.Text1.Value = loc_cDpros
540:             loc_oGrd.Refresh()
541:             IF par_nKeyCode = 13
542:                 loc_nRecno = RECNO()
543:                 LOCATE FOR EMPTY(Cpros)
544:                 IF EOF()
545:                     APPEND BLANK
546:                 ENDIF
547:                 LOCATE FOR RECNO() = loc_nRecno
548:                 KEYBOARD '{DNARROW}'
549:             ENDIF
550:         ENDIF
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * CmdOkClick - Confirma lista e aguarda ECF (animacao de barras coloridas)
555:     * Equivalente ao altera.Click do SCX original
556:     *==========================================================================
557:     PROCEDURE CmdOkClick()
558:         LOCAL loc_nCount, loc_ldDataI, loc_nW, loc_nX, loc_nTempo
559:         LOCAL loc_nBot, loc_cMacro
560: 
561:         SELECT CrProduto
562:         COUNT TO loc_nCount FOR NOT EMPTY(Cpros)
563:         IF loc_nCount = 0
564:             MsgAviso("Nenhum Produto Informado!!!", ;
565:                      "Aten" + CHR(231) + CHR(227) + "o")
566:             RETURN
567:         ENDIF
568: 
569:         THIS.cnt_4c_Mensagem.Visible = .T.
570:         loc_ldDataI = DATETIME()
571:         loc_nW      = THIS.this_nClockEcfs / 3
572:         loc_nX      = 13
573: 
574:         DO WHILE DATETIME() - loc_ldDataI < THIS.this_nClockEcfs
575:             loc_nTempo = DATETIME() - loc_ldDataI
576:             IF loc_nX >= 13
577:                 loc_nX = 1
578:             ELSE
579:                 loc_nX = loc_nX + 1
580:             ENDIF
581:             IF loc_nTempo > loc_nW
582:                 IF loc_nTempo < loc_nW * 2
583:                     FOR loc_nBot = 1 TO 13
584:                         loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
585:                                      ALLTRIM(STR(loc_nBot, 2))
586:                         &loc_cMacro..BackColor = 65535
587:                     ENDFOR
588:                 ELSE
589:                     FOR loc_nBot = 1 TO 13
590:                         loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
591:                                      ALLTRIM(STR(loc_nBot, 2))
592:                         &loc_cMacro..BackColor = 4227072
593:                     ENDFOR
594:                 ENDIF
595:             ELSE
596:                 FOR loc_nBot = 1 TO 13
597:                     loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
598:                                  ALLTRIM(STR(loc_nBot, 2))
599:                     &loc_cMacro..BackColor = 255
600:                 ENDFOR
601:             ENDIF
602: 
603:             FOR loc_nBot = 1 TO 13
604:                 loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;

*-- Linhas 615 a 953:
615:     * CmdCancelarClick - Cancela dialogo sem transmitir produtos
616:     * Equivalente ao sair.Click do SCX original
617:     *==========================================================================
618:     PROCEDURE CmdCancelarClick()
619:         THIS.this_cRetorno = " "
620:         THIS.Release()
621:     ENDPROC
622: 
623:     *==========================================================================
624:     * BtnIncluirClick - Adiciona nova linha em branco ao cursor de produtos
625:     * Anexa a CrProduto e move o foco para a coluna de codigo do grid
626:     *==========================================================================
627:     PROCEDURE BtnIncluirClick()
628:         LOCAL loc_oGrd, loc_nRecno
629: 
630:         IF NOT USED("CrProduto")
631:             SET NULL ON
632:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
633:             SET NULL OFF
634:         ENDIF
635: 
636:         SELECT CrProduto
637:         LOCATE FOR EMPTY(Cpros)
638:         IF EOF()
639:             APPEND BLANK
640:         ENDIF
641:         loc_nRecno = RECNO()
642: 
643:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
644:         IF VARTYPE(loc_oGrd) = "O"
645:             loc_oGrd.Refresh()
646:             loc_oGrd.SetFocus()
647:             loc_oGrd.ActivateCell(loc_nRecno, 1)
648:             loc_oGrd.Column1.Text1.SetFocus()
649:         ENDIF
650:     ENDPROC
651: 
652:     *==========================================================================
653:     * BtnAlterarClick - Habilita edicao da linha corrente do grid de produtos
654:     * Move foco para a coluna Codigo do Produto na linha selecionada
655:     *==========================================================================
656:     PROCEDURE BtnAlterarClick()
657:         LOCAL loc_oGrd
658: 
659:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
660:             MsgAviso("Nenhum produto informado para alterar.", ;
661:                      "Aten" + CHR(231) + CHR(227) + "o")
662:             RETURN
663:         ENDIF
664: 
665:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
666:         IF VARTYPE(loc_oGrd) = "O"
667:             loc_oGrd.Column1.ReadOnly = .F.
668:             loc_oGrd.Refresh()
669:             loc_oGrd.SetFocus()
670:             loc_oGrd.Column1.Text1.SetFocus()
671:         ENDIF
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnVisualizarClick - Coloca o grid em modo somente-leitura para consulta
676:     * Refresh do grid com colunas em readonly (visualizacao pura)
677:     *==========================================================================
678:     PROCEDURE BtnVisualizarClick()
679:         LOCAL loc_oGrd
680: 
681:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
682:             MsgAviso("Nenhum produto informado para visualizar.", ;
683:                      "Aten" + CHR(231) + CHR(227) + "o")
684:             RETURN
685:         ENDIF
686: 
687:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
688:         IF VARTYPE(loc_oGrd) = "O"
689:             loc_oGrd.Column1.ReadOnly = .T.
690:             loc_oGrd.Column2.ReadOnly = .T.
691:             SELECT CrProduto
692:             GO TOP
693:             loc_oGrd.Refresh()
694:         ENDIF
695:     ENDPROC
696: 
697:     *==========================================================================
698:     * BtnExcluirClick - Remove linha corrente do cursor de produtos
699:     * Confirma com MsgConfirma antes de DELETE + PACK
700:     *==========================================================================
701:     PROCEDURE BtnExcluirClick()
702:         LOCAL loc_oGrd, loc_cCodigo, loc_lConfirma
703: 
704:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
705:             MsgAviso("Nenhum produto informado para excluir.", ;
706:                      "Aten" + CHR(231) + CHR(227) + "o")
707:             RETURN
708:         ENDIF
709: 
710:         SELECT CrProduto
711:         IF EMPTY(Cpros)
712:             MsgAviso("Selecione uma linha com produto v" + CHR(225) + "lido.", ;
713:                      "Aten" + CHR(231) + CHR(227) + "o")
714:             RETURN
715:         ENDIF
716: 
717:         loc_cCodigo   = ALLTRIM(Cpros)
718:         loc_lConfirma = MsgConfirma("Excluir o produto " + loc_cCodigo + " da rela" + ;
719:                                     CHR(231) + CHR(227) + "o?", ;
720:                                     "Confirma" + CHR(231) + CHR(227) + "o")
721:         IF NOT loc_lConfirma
722:             RETURN
723:         ENDIF
724: 
725:         SELECT CrProduto
726:         DELETE
727:         PACK
728:         IF RECCOUNT("CrProduto") = 0
729:             APPEND BLANK
730:         ENDIF
731:         GO TOP
732: 
733:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
734:         IF VARTYPE(loc_oGrd) = "O"
735:             loc_oGrd.Refresh()
736:             loc_oGrd.SetFocus()
737:             loc_oGrd.Column1.Text1.SetFocus()
738:         ENDIF
739:     ENDPROC
740: 
741:     *==========================================================================
742:     * BtnBuscarClick - Abre lookup de produto para a linha corrente do grid
743:     * Equivalente a pressionar F4 na coluna Codigo do Produto
744:     *==========================================================================
745:     PROCEDURE BtnBuscarClick()
746:         LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros, loc_oBusca
747: 
748:         IF NOT USED("CrProduto")
749:             MsgAviso("Nenhum produto informado.", ;
750:                      "Aten" + CHR(231) + CHR(227) + "o")
751:             RETURN
752:         ENDIF
753: 
754:         loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
755:         loc_oTxt    = loc_oGrd.Column1.Text1
756:         loc_cCodigo = ALLTRIM(loc_oTxt.Value)
757: 
758:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
759:             "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
760:             loc_cCodigo, "Produtos", .T., .T., "")
761:         IF VARTYPE(loc_oBusca) = "O"
762:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
763:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
764:             loc_oBusca.Show()
765:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
766:                 SELECT cursor_4c_ProBusca
767:                 loc_cCodigo = ALLTRIM(cpros)
768:                 loc_cDpros  = ALLTRIM(dpros)
769:                 loc_oTxt.Value = loc_cCodigo
770:                 SELECT CrProduto
771:                 REPLACE dpros WITH loc_cDpros
772:                 loc_oGrd.Column2.Text1.Value = loc_cDpros
773:                 loc_oGrd.Refresh()
774:             ENDIF
775:             IF USED("cursor_4c_ProBusca")
776:                 USE IN cursor_4c_ProBusca
777:             ENDIF
778:             loc_oBusca.Release()
779:         ENDIF
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * BtnEncerrarClick - Cancela o dialogo sem transmitir produtos
784:     * Alias de CmdCancelarClick para compatibilidade com o pipeline
785:     *==========================================================================
786:     PROCEDURE BtnEncerrarClick()
787:         THIS.CmdCancelarClick()
788:     ENDPROC
789: 
790:     *==========================================================================
791:     * BtnSalvarClick - Confirma a lista de produtos (alias de CmdOkClick)
792:     * Compatibilidade com o pipeline de migracao
793:     *==========================================================================
794:     PROCEDURE BtnSalvarClick()
795:         THIS.CmdOkClick()
796:     ENDPROC
797: 
798:     *==========================================================================
799:     * BtnCancelarClick - Cancela edicao corrente e restaura linha anterior
800:     * Em dialogo sem modo edicao separado: equivale a cancelar selecao
801:     *==========================================================================
802:     PROCEDURE BtnCancelarClick()
803:         LOCAL loc_oGrd
804: 
805:         SELECT CrProduto
806:         IF NOT EMPTY(THIS.this_cAntCPro)
807:             REPLACE Cpros WITH THIS.this_cAntCPro
808:         ENDIF
809:         THIS.this_cAntCPro = ""
810: 
811:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
812:         IF VARTYPE(loc_oGrd) = "O"
813:             loc_oGrd.Refresh()
814:             loc_oGrd.SetFocus()
815:             loc_oGrd.Column1.Text1.SetFocus()
816:         ENDIF
817:     ENDPROC
818: 
819:     *==========================================================================
820:     * FormParaBO - Transfere a lista de produtos do cursor CrProduto para o BO
821:     * O BO guarda a lista para processamento posterior (transmissao ECF)
822:     *==========================================================================
823:     PROCEDURE FormParaBO()
824:         IF NOT USED("CrProduto")
825:             RETURN
826:         ENDIF
827:         THIS.this_oBusinessObject.CarregarProdutosDeCursor("CrProduto")
828:     ENDPROC
829: 
830:     *==========================================================================
831:     * BOParaForm - Carrega lista de produtos do BO no cursor CrProduto
832:     * Usado quando o dialogo reabre com uma lista pre-existente
833:     *==========================================================================
834:     PROCEDURE BOParaForm()
835:         LOCAL loc_oGrd
836: 
837:         IF NOT USED("CrProduto")
838:             SET NULL ON
839:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
840:             SET NULL OFF
841:         ENDIF
842: 
843:         SELECT CrProduto
844:         ZAP
845: 
846:         THIS.this_oBusinessObject.PopularCursorProdutos("CrProduto")
847: 
848:         IF RECCOUNT("CrProduto") = 0
849:             SELECT CrProduto
850:             APPEND BLANK
851:         ENDIF
852: 
853:         GO TOP
854: 
855:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
856:         IF VARTYPE(loc_oGrd) = "O"
857:             loc_oGrd.Refresh()
858:         ENDIF
859:     ENDPROC
860: 
861:     *==========================================================================
862:     * HabilitarCampos - Habilita ou desabilita edicao do grid de produtos
863:     * par_lHabilitar: .T. = edicao livre; .F. = somente visualizacao
864:     *==========================================================================
865:     PROCEDURE HabilitarCampos(par_lHabilitar)
866:         LOCAL loc_oGrd
867: 
868:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
869:         IF VARTYPE(loc_oGrd) != "O"
870:             RETURN
871:         ENDIF
872: 
873:         IF VARTYPE(par_lHabilitar) != "L"
874:             par_lHabilitar = .T.
875:         ENDIF
876: 
877:         loc_oGrd.Column1.ReadOnly = !par_lHabilitar
878:         loc_oGrd.Refresh()
879:     ENDPROC
880: 
881:     *==========================================================================
882:     * LimparCampos - Esvazia a lista de produtos e redefine linha inicial
883:     * Equivale ao estado inicial do dialogo
884:     *==========================================================================
885:     PROCEDURE LimparCampos()
886:         LOCAL loc_oGrd
887: 
888:         IF USED("CrProduto")
889:             SELECT CrProduto
890:             ZAP
891:             APPEND BLANK
892:         ENDIF
893: 
894:         THIS.this_cAntCPro = ""
895: 
896:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
897:         IF VARTYPE(loc_oGrd) = "O"
898:             loc_oGrd.Refresh()
899:             loc_oGrd.SetFocus()
900:             loc_oGrd.Column1.Text1.SetFocus()
901:         ENDIF
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * CarregarLista - Atualiza o grid com o conteudo corrente de CrProduto
906:     * Redefine RecordSource e cabecalhos (VFP9 os reseta apos RecordSource)
907:     *==========================================================================
908:     PROCEDURE CarregarLista()
909:         LOCAL loc_oGrd, loc_lSucesso
910:         loc_lSucesso = .F.
911: 
912:         TRY
913:             IF NOT USED("CrProduto")
914:                 SET NULL ON
915:                 CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
916:                 SET NULL OFF
917:                 SELECT CrProduto
918:                 APPEND BLANK
919:             ENDIF
920: 
921:             loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
922:             IF VARTYPE(loc_oGrd) = "O"
923:                 loc_oGrd.ColumnCount          = 2
924:                 loc_oGrd.RecordSource         = "CrProduto"
925:                 loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
926:                 loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
927:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
928:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
929:                 loc_oGrd.Refresh()
930:             ENDIF
931:             loc_lSucesso = .T.
932:         CATCH TO loc_oErro
933:             MsgErro(loc_oErro.Message + " | LN: " + TRANSFORM(loc_oErro.LineNo), ;
934:                     "Erro ao carregar lista")
935:         ENDTRY
936: 
937:         RETURN loc_lSucesso
938:     ENDPROC
939: 
940:     *==========================================================================
941:     * AjustarBotoesPorModo - Sem modo separado neste dialogo; sem botoes CRUD
942:     * Mantido para compatibilidade com o pipeline
943:     *==========================================================================
944:     PROCEDURE AjustarBotoesPorModo()
945:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
946:             THIS.cmd_4c_Ok.Enabled = .T.
947:         ENDIF
948:         IF VARTYPE(THIS.cmd_4c_Cancelar) = "O"
949:             THIS.cmd_4c_Cancelar.Enabled = .T.
950:         ENDIF
951:     ENDPROC
952: 
953: ENDDEFINE


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


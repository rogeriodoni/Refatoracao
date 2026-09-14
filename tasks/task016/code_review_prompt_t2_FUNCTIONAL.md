# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3654 linhas total):

*-- Linhas 53 a 167:
53:     *--------------------------------------------------------------------------
54:     * Init - Inicializacao do formulario
55:     *--------------------------------------------------------------------------
56:     PROCEDURE Init()
57:         RETURN DODEFAULT()
58:     ENDPROC
59: 
60:     *--------------------------------------------------------------------------
61:     * InicializarForm - Configuracao inicial (chamado por FormBase.Init)
62:     *--------------------------------------------------------------------------
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lSucesso
65:         loc_lSucesso = .F.
66: 
67:         TRY
68:             THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")
69: 
70:             IF ISNULL(THIS.this_oBusinessObject)
71:                 MostrarErro("Erro ao criar Business Object ccrBO", "Erro Cr" + CHR(237) + "tico")
72:             ELSE
73:                 THIS.ConfigurarPageFrame()
74:                 THIS.ConfigurarPaginaLista()
75:                 THIS.ConfigurarPaginaDados()
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77: 
78:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
79:                     THIS.CarregarLista()
80:                 ENDIF
81: 
82:                 THIS.pgf_4c_Paginas.Visible = .T.
83:                 THIS.pgf_4c_Paginas.ActivePage = 1
84:                 THIS.this_cModoAtual = "LISTA"
85:                 loc_lSucesso = .T.
86:             ENDIF
87: 
88:         CATCH TO loException
89:             MostrarErro("Erro ao inicializar Formccr:" + CHR(13) + ;
90:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
91:                 loException.Message, "Erro")
92:         ENDTRY
93: 
94:         RETURN loc_lSucesso
95:     ENDPROC
96: 
97:     *--------------------------------------------------------------------------
98:     * ConfigurarPageFrame - PageFrame externo (Page1=Lista, Page2=Dados)
99:     * Top=-29 oculta abas, Width=1003 cobre toda a forma
100:     *--------------------------------------------------------------------------
101:     PROTECTED PROCEDURE ConfigurarPageFrame()
102:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
103: 
104:         WITH THIS.pgf_4c_Paginas
105:             .Top       = -29
106:             .Left      = 0
107:             .Width     = 1003
108:             .Height    = 629
109:             .PageCount = 2
110:             .Tabs      = .F.
111:             .Visible   = .T.
112: 
113:             .Page1.Caption   = "Lista"
114:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:             .Page1.BackColor = RGB(255, 255, 255)
116: 
117:             .Page2.Caption   = "Dados"
118:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             .Page2.BackColor = RGB(255, 255, 255)
120:         ENDWITH
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, saida, grid
125:     * Compensacao +29 aplicada (Top_original + 29)
126:     *--------------------------------------------------------------------------
127:     PROTECTED PROCEDURE ConfigurarPaginaLista()
128:         LOCAL loc_oPagina
129:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
130: 
131:         *-- Container cabecalho (Top=31, Width=1020, Height=80)
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 31
135:             .Left        = 0
136:             .Width       = 1020
137:             .Height      = 80
138:             .BackStyle   = 0
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = "Grupos de Contas Corrente"
146:             .Top       = 20
147:             .Left      = 20
148:             .Width     = 400
149:             .Height    = 30
150:             .FontName  = "Tahoma"
151:             .FontSize  = 14
152:             .FontBold  = .T.
153:             .BackStyle = 0
154:             .ForeColor = RGB(90, 90, 90)
155:             .Visible   = .T.
156:         ENDWITH
157: 
158:         *-- Container botoes CRUD (Left=542, Top=29, Width=400, Height=85)
159:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
160:         WITH loc_oPagina.cnt_4c_Botoes
161:             .Top         = 29
162:             .Left        = 542
163:             .Width       = 400
164:             .Height      = 85
165:             .BackStyle = 1
166:             .BackColor = RGB(53, 53, 53)
167:             .BorderWidth = 0

*-- Linhas 186 a 433:
186:             .ForeColor       = RGB(90, 90, 90)
187:             .Visible         = .T.
188:         ENDWITH
189:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
190: 
191:         *-- Visualizar (Left=80)
192:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
194:             .Caption         = "Visualizar"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:             .PicturePosition = 13
197:             .Width           = 75
198:             .Height          = 75
199:             .Left            = 80
200:             .Top             = 5
201:             .FontName        = "Tahoma"
202:             .FontSize        = 8
203:             .Themes          = .F.
204:             .SpecialEffect   = 0
205:             .BackColor       = RGB(255, 255, 255)
206:             .ForeColor       = RGB(90, 90, 90)
207:             .Visible         = .T.
208:         ENDWITH
209:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
210: 
211:         *-- Alterar (Left=155)
212:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
213:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
214:             .Caption         = "Alterar"
215:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
216:             .PicturePosition = 13
217:             .Width           = 75
218:             .Height          = 75
219:             .Left            = 155
220:             .Top             = 5
221:             .FontName        = "Tahoma"
222:             .FontSize        = 8
223:             .Themes          = .F.
224:             .SpecialEffect   = 0
225:             .BackColor       = RGB(255, 255, 255)
226:             .ForeColor       = RGB(90, 90, 90)
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
230: 
231:         *-- Excluir (Left=230)
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
234:             .Caption         = "Excluir"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
236:             .PicturePosition = 13
237:             .Width           = 75
238:             .Height          = 75
239:             .Left            = 230
240:             .Top             = 5
241:             .FontName        = "Tahoma"
242:             .FontSize        = 8
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .BackColor       = RGB(255, 255, 255)
246:             .ForeColor       = RGB(90, 90, 90)
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
250: 
251:         *-- Buscar (Left=305)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
254:             .Caption         = "Buscar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
256:             .PicturePosition = 13
257:             .Width           = 75
258:             .Height          = 75
259:             .Left            = 305
260:             .Top             = 5
261:             .FontName        = "Tahoma"
262:             .FontSize        = 8
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .BackColor       = RGB(255, 255, 255)
266:             .ForeColor       = RGB(90, 90, 90)
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
270: 
271:         *-- Container saida (Left=917, Top=29, Width=90, Height=85)
272:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
273:         WITH loc_oPagina.cnt_4c_Saida
274:             .Top         = 29
275:             .Left        = 917
276:             .Width       = 90
277:             .Height      = 85
278:             .BackStyle = 1
279:             .BackColor = RGB(53, 53, 53)
280:             .BorderWidth = 0
281:             .Visible     = .T.
282:         ENDWITH
283: 
284:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
286:             .Caption         = "Encerrar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
288:             .PicturePosition = 13
289:             .Width           = 75
290:             .Height          = 75
291:             .Left            = 5
292:             .Top             = 5
293:             .FontName        = "Tahoma"
294:             .FontSize        = 8
295:             .Themes          = .F.
296:             .SpecialEffect   = 0
297:             .BackColor       = RGB(255, 255, 255)
298:             .ForeColor       = RGB(90, 90, 90)
299:             .Visible         = .T.
300:         ENDWITH
301:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
302: 
303:         *-- Container filtros (Left=5, Top=29, vazio - busca via BtnBuscarClick)
304:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
305:         WITH loc_oPagina.cnt_4c_Filtros
306:             .Top         = 29
307:             .Left        = 5
308:             .Width       = 530
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         *-- Grid de lista (Top=121, Left=11, Width=938, Height=470)
316:         *-- 5 colunas: Codigos/Descrs/Internos/TpCods/DClasses
317:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
318:         WITH loc_oPagina.grd_4c_Lista
319:             .Top               = 121
320:             .Left              = 11
321:             .Width             = 938
322:             .Height            = 470
323:             .ReadOnly          = .T.
324:             .DeleteMark        = .F.
325:             .RecordMark        = .F.
326:             .ScrollBars        = 3
327:             .GridLines         = 3
328:             .ColumnCount       = 5
329:             .AllowHeaderSizing = .T.
330:             .Visible           = .T.
331:         ENDWITH
332: 
333:         THIS.TornarControlesVisiveis(loc_oPagina)
334:     ENDPROC
335: 
336:     *--------------------------------------------------------------------------
337:     * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
338:     * Compensacao +29 aplicada nos Tops
339:     *--------------------------------------------------------------------------
340:     PROTECTED PROCEDURE ConfigurarPaginaDados()
341:         LOCAL loc_oPagina
342:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
343: 
344:         *-- Botoes Salvar/Cancelar (Top=38, Left=819, Width=165, Height=85)
345:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
346:         WITH loc_oPagina.cnt_4c_BotoesDados
347:             .Top         = 38
348:             .Left        = 819
349:             .Width       = 165
350:             .Height      = 85
351:             .BackStyle = 1
352:             .BackColor = RGB(53, 53, 53)
353:             .BorderWidth = 0
354:             .Visible     = .T.
355:         ENDWITH
356: 
357:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
358:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
359:             .Caption         = "Salvar"
360:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
361:             .PicturePosition = 13
362:             .Width           = 75
363:             .Height          = 75
364:             .Left            = 7
365:             .Top             = 5
366:             .FontName        = "Tahoma"
367:             .FontSize        = 8
368:             .Themes          = .F.
369:             .SpecialEffect   = 0
370:             .BackColor       = RGB(255, 255, 255)
371:             .ForeColor       = RGB(90, 90, 90)
372:             .Visible         = .T.
373:         ENDWITH
374:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
375: 
376:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
378:             .Caption         = "Cancelar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
380:             .PicturePosition = 13
381:             .Width           = 75
382:             .Height          = 75
383:             .Left            = 83
384:             .Top             = 5
385:             .FontName        = "Tahoma"
386:             .FontSize        = 8
387:             .Themes          = .F.
388:             .SpecialEffect   = 0
389:             .BackColor       = RGB(255, 255, 255)
390:             .ForeColor       = RGB(90, 90, 90)
391:             .Visible         = .T.
392:         ENDWITH
393:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
394: 
395:         *----------------------------------------------------------------------
396:         *-- ROW 1: Codigos | Descrs | Internos (Top=38)
397:         *----------------------------------------------------------------------
398:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
399:         WITH loc_oPagina.lbl_4c_LblCodigos
400:             .Caption   = "C" + CHR(243) + "digo :"
401:             .Left      = 5
402:             .Top       = 43
403:             .Width     = 50
404:             .Height    = 15
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .BackStyle = 0
408:             .ForeColor = RGB(90, 90, 90)
409:             .Visible   = .T.
410:         ENDWITH
411: 
412:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
413:         WITH loc_oPagina.txt_4c_Codigos
414:             .Value         = ""
415:             .Left          = 57
416:             .Top           = 38
417:             .Width         = 65
418:             .Height        = 24
419:             .FontName      = "Tahoma"
420:             .FontSize      = 8
421:             .SpecialEffect = 1
422:             .MaxLength     = 10
423:             .InputMask     = "XXXXXXXXXX"
424:             .Visible       = .T.
425:         ENDWITH
426: 
427:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
428:         WITH loc_oPagina.lbl_4c_LblDescrs
429:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
430:             .Left      = 130
431:             .Top       = 43
432:             .Width     = 63
433:             .Height    = 15

*-- Linhas 498 a 566:
498:         ENDWITH
499: 
500:         *-- opt_4c_TpCods: 1=Empresa, 2=C/C
501:         loc_oPagina.AddObject("opt_4c_TpCods", "OptionGroup")
502:         WITH loc_oPagina.opt_4c_TpCods
503:             .ButtonCount  = 2
504:             .Left         = 48
505:             .Top          = 68
506:             .Width        = 130
507:             .Height       = 24
508:             .BorderStyle  = 0
509:             .Value        = 1
510:             .Visible      = .T.
511:             .Buttons(1).Caption  = "Empresa"
512:             .Buttons(1).Width    = 65
513:             .Buttons(1).Left     = 0
514:             .Buttons(1).Top      = 0
515:             .Buttons(1).AutoSize = .F.
516:             .Buttons(1).ForeColor = RGB(90, 90, 90)
517:             .Buttons(1).Themes   = .F.
518:             .Buttons(2).Caption  = "C/C"
519:             .Buttons(2).Width    = 55
520:             .Buttons(2).Left     = 65
521:             .Buttons(2).Top      = 0
522:             .Buttons(2).AutoSize = .F.
523:             .Buttons(2).ForeColor = RGB(90, 90, 90)
524:             .Buttons(2).Themes   = .F.
525:         ENDWITH
526:         BINDEVENT(loc_oPagina.opt_4c_TpCods, "InteractiveChange", THIS, "opt_4c_TpCods_InteractiveChange")
527: 
528:         *-- Digito (visivel somente quando TpCods=1)
529:         loc_oPagina.AddObject("lbl_4c_LblDigito", "Label")
530:         WITH loc_oPagina.lbl_4c_LblDigito
531:             .Caption   = "D" + CHR(237) + "gito :"
532:             .Left      = 183
533:             .Top       = 73
534:             .Width     = 50
535:             .Height    = 15
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .BackStyle = 0
539:             .ForeColor = RGB(90, 90, 90)
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         loc_oPagina.AddObject("txt_4c_Digito", "TextBox")
544:         WITH loc_oPagina.txt_4c_Digito
545:             .Value         = ""
546:             .Left          = 236
547:             .Top           = 68
548:             .Width         = 25
549:             .Height        = 24
550:             .FontName      = "Tahoma"
551:             .FontSize      = 8
552:             .SpecialEffect = 1
553:             .MaxLength     = 1
554:             .Visible       = .T.
555:         ENDWITH
556: 
557:         *-- Classes (lookup SigCdCss via F4/LostFocus)
558:         loc_oPagina.AddObject("lbl_4c_LblClasses", "Label")
559:         WITH loc_oPagina.lbl_4c_LblClasses
560:             .Caption   = "Classe :"
561:             .Left      = 267
562:             .Top       = 73
563:             .Width     = 48
564:             .Height    = 15
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8

*-- Linhas 582 a 626:
582:             .MaxLength     = 10
583:             .Visible       = .T.
584:         ENDWITH
585:         BINDEVENT(loc_oPagina.txt_4c_Classes, "KeyPress", THIS, "txt_4c_Classes_KeyPress")
586:         BINDEVENT(loc_oPagina.txt_4c_Classes, "LostFocus", THIS, "txt_4c_Classes_LostFocus")
587: 
588:         *-- DClasses (display-only, derivado do lookup)
589:         loc_oPagina.AddObject("txt_4c_DClasses", "TextBox")
590:         WITH loc_oPagina.txt_4c_DClasses
591:             .Value         = ""
592:             .Left          = 394
593:             .Top           = 68
594:             .Width         = 185
595:             .Height        = 24
596:             .FontName      = "Tahoma"
597:             .FontSize      = 8
598:             .SpecialEffect = 1
599:             .Enabled       = .F.
600:             .Visible       = .T.
601:         ENDWITH
602: 
603:         *-- chk_4c_LimCrds - Verif. Limite Credito (chklimcrds N(1,0))
604:         loc_oPagina.AddObject("chk_4c_LimCrds", "CheckBox")
605:         WITH loc_oPagina.chk_4c_LimCrds
606:             .Caption   = "Verif. Limite Cr" + CHR(233) + "d."
607:             .Left      = 585
608:             .Top       = 68
609:             .Width     = 105
610:             .Height    = 20
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .BackStyle = 0
614:             .Visible   = .T.
615:         ENDWITH
616: 
617:         *-- chk_4c_LimEsts - Verif. Limite Estoque (chklimests N(1,0))
618:         loc_oPagina.AddObject("chk_4c_LimEsts", "CheckBox")
619:         WITH loc_oPagina.chk_4c_LimEsts
620:             .Caption   = "Verif. Limite Est."
621:             .Left      = 695
622:             .Top       = 68
623:             .Width     = 115
624:             .Height    = 20
625:             .FontName  = "Tahoma"
626:             .FontSize  = 8

*-- Linhas 646 a 729:
646:             .Visible   = .T.  && controlado por TpCods
647:         ENDWITH
648: 
649:         loc_oPagina.AddObject("opt_4c_TpEmps", "OptionGroup")
650:         WITH loc_oPagina.opt_4c_TpEmps
651:             .ButtonCount  = 2
652:             .Left         = 447
653:             .Top          = 68
654:             .Width        = 98
655:             .Height       = 23
656:             .BorderStyle  = 0
657:             .Value        = 1
658:             .Visible      = .T.  && controlado por TpCods
659:             .Buttons(1).Caption  = "Sim"
660:             .Buttons(1).Width    = 49
661:             .Buttons(1).Left     = 0
662:             .Buttons(1).Top      = 0
663:             .Buttons(1).AutoSize = .F.
664:             .Buttons(1).ForeColor = RGB(90, 90, 90)
665:             .Buttons(1).Themes   = .F.
666:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
667:             .Buttons(2).Width    = 49
668:             .Buttons(2).Left     = 49
669:             .Buttons(2).Top      = 0
670:             .Buttons(2).AutoSize = .F.
671:             .Buttons(2).ForeColor = RGB(90, 90, 90)
672:             .Buttons(2).Themes   = .F.
673:         ENDWITH
674: 
675:         loc_oPagina.AddObject("lbl_4c_TpCads", "Label")
676:         WITH loc_oPagina.lbl_4c_TpCads
677:             .Caption   = "Tp.Cad. :"
678:             .Left      = 5
679:             .Top       = 98
680:             .Width     = 55
681:             .Height    = 15
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .BackStyle = 0
685:             .ForeColor = RGB(90, 90, 90)
686:             .Visible   = .T.
687:         ENDWITH
688: 
689:         loc_oPagina.AddObject("opt_4c_TpCads", "OptionGroup")
690:         WITH loc_oPagina.opt_4c_TpCads
691:             .ButtonCount  = 2
692:             .Left         = 63
693:             .Top          = 93
694:             .Width        = 150
695:             .Height       = 23
696:             .BorderStyle  = 0
697:             .Value        = 1
698:             .Visible      = .T.
699:             .Buttons(1).Caption  = "Empresa"
700:             .Buttons(1).Width    = 75
701:             .Buttons(1).Left     = 0
702:             .Buttons(1).Top      = 0
703:             .Buttons(1).AutoSize = .F.
704:             .Buttons(1).ForeColor = RGB(90, 90, 90)
705:             .Buttons(1).Themes   = .F.
706:             .Buttons(2).Caption  = "C/C"
707:             .Buttons(2).Width    = 75
708:             .Buttons(2).Left     = 75
709:             .Buttons(2).Top      = 0
710:             .Buttons(2).AutoSize = .F.
711:             .Buttons(2).ForeColor = RGB(90, 90, 90)
712:             .Buttons(2).Themes   = .F.
713:         ENDWITH
714: 
715:         *----------------------------------------------------------------------
716:         *-- Inner PageFrame - 4 abas (Geral, Cadastro, Estoque, Faturamento)
717:         *-- (Top=120, Left=5, Width=985, Height=447)
718:         *----------------------------------------------------------------------
719:         loc_oPagina.AddObject("pgf_4c_AbaDados", "PageFrame")
720:         WITH loc_oPagina.pgf_4c_AbaDados
721:             .Top       = 120
722:             .Left      = 5
723:             .Width     = 985
724:             .Height    = 447
725:             .PageCount = 4
726:             .Tabs      = .T.
727:             .Visible   = .T.
728: 
729:             .Page1.Caption = "Geral"

*-- Linhas 737 a 841:
737:         THIS.ConfigurarAbaEstoque()
738:         THIS.ConfigurarAbaFaturamento()
739: 
740:         THIS.TornarControlesVisiveis(loc_oPagina)
741:     ENDPROC
742: 
743:     *--------------------------------------------------------------------------
744:     * CriarLabel - Helper: adiciona Label padrao ao container
745:     *--------------------------------------------------------------------------
746:     PROTECTED PROCEDURE CriarLabel(par_oParent, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth)
747:         par_oParent.AddObject(par_cNome, "Label")
748:         WITH par_oParent.Controls(par_oParent.ControlCount)
749:             .Caption   = par_cCaption
750:             .Left      = par_nLeft
751:             .Top       = par_nTop
752:             .Width     = par_nWidth
753:             .Height    = 15
754:             .FontName  = "Tahoma"
755:             .FontSize  = 8
756:             .BackStyle = 0
757:             .ForeColor = RGB(90, 90, 90)
758:         ENDWITH
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * CriarOptSimNao - Helper: adiciona OptionGroup 2-botoes Sim/Nao
763:     *--------------------------------------------------------------------------
764:     PROTECTED PROCEDURE CriarOptSimNao(par_oParent, par_cNome, par_nLeft, par_nTop, par_nWidth, par_nDefault)
765:         LOCAL loc_nBtnW
766:         loc_nBtnW = INT(par_nWidth / 2)
767:         par_oParent.AddObject(par_cNome, "OptionGroup")
768:         WITH par_oParent.Controls(par_oParent.ControlCount)
769:             .ButtonCount  = 2
770:             .Left         = par_nLeft
771:             .Top          = par_nTop
772:             .Width        = par_nWidth
773:             .Height       = 23
774:             .FontName     = "Tahoma"
775:             .FontSize     = 8
776:             .BorderStyle  = 0
777:             .BackStyle    = 0
778:             .Value        = par_nDefault
779:             .Buttons(1).Caption  = "Sim"
780:             .Buttons(1).Width    = loc_nBtnW
781:             .Buttons(1).Left     = 0
782:             .Buttons(1).Top      = 0
783:             .Buttons(1).AutoSize = .F.
784:             .Buttons(1).ForeColor = RGB(90, 90, 90)
785:             .Buttons(1).Themes   = .F.
786:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
787:             .Buttons(2).Width    = par_nWidth - loc_nBtnW
788:             .Buttons(2).Left     = loc_nBtnW
789:             .Buttons(2).Top      = 0
790:             .Buttons(2).AutoSize = .F.
791:             .Buttons(2).ForeColor = RGB(90, 90, 90)
792:             .Buttons(2).Themes   = .F.
793:         ENDWITH
794:     ENDPROC
795: 
796:     *--------------------------------------------------------------------------
797:     * CriarContainerFiscal - Helper: container com 5 campos fiscais
798:     * Estrutura: lbl_4c_TaxNome, txt_4c_CdGrupos, txt_4c_CdContas,
799:     *            txt_4c_DsContas(disabled), txt_4c_PctAliqs, txt_4c_Receitas
800:     *--------------------------------------------------------------------------
801:     PROTECTED PROCEDURE CriarContainerFiscal(par_oAba, par_cNome, par_cLabel, par_nTop)
802:         LOCAL loc_oCnt
803:         par_oAba.AddObject(par_cNome, "Container")
804:         loc_oCnt = par_oAba.Controls(par_oAba.ControlCount)
805:         WITH loc_oCnt
806:             .Top         = par_nTop
807:             .Left        = 18
808:             .Width       = 673
809:             .Height      = 25
810:             .BackStyle   = 0
811:             .BorderWidth = 0
812:         ENDWITH
813: 
814:         loc_oCnt.AddObject("lbl_4c_TaxNome", "Label")
815:         WITH loc_oCnt.lbl_4c_TaxNome
816:             .Caption   = par_cLabel
817:             .Left      = 10
818:             .Top       = 5
819:             .Width     = 55
820:             .Height    = 15
821:             .FontName  = "Tahoma"
822:             .FontSize  = 8
823:             .BackStyle = 0
824:             .ForeColor = RGB(90, 90, 90)
825:         ENDWITH
826: 
827:         loc_oCnt.AddObject("txt_4c_CdGrupos", "TextBox")
828:         WITH loc_oCnt.txt_4c_CdGrupos
829:             .Value         = ""
830:             .Left          = 66
831:             .Top           = 2
832:             .Width         = 80
833:             .Height        = 21
834:             .FontName      = "Tahoma"
835:             .FontSize      = 8
836:             .SpecialEffect = 1
837:             .MaxLength     = 20
838:         ENDWITH
839: 
840:         loc_oCnt.AddObject("txt_4c_CdContas", "TextBox")
841:         WITH loc_oCnt.txt_4c_CdContas

*-- Linhas 892 a 979:
892:         ENDWITH
893: 
894:         *-- Lookups F4 para CdGrupos e CdContas + LostFocus para validacao
895:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "GotFocus",  THIS, "FiscalGotFocus")
896:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "KeyPress",  THIS, "FiscalCdGruposKeyPress")
897:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "LostFocus", THIS, "FiscalCdGruposLostFocus")
898:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "GotFocus",  THIS, "FiscalGotFocus")
899:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "KeyPress",  THIS, "FiscalCdContasKeyPress")
900:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "LostFocus", THIS, "FiscalCdContasLostFocus")
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * ConfigurarAbaGeral - Controles da Aba 1 (Geral)
905:     * Col.Esq: Comple/Pessoais/RefBancs/FollowUp/Fiscais/DadosCom/Respos/LimCre/Comi
906:     * Col.Dir: Empresa/Contabs/Caracts/Perfil/Cargos/ChkLimCr/PreCad + Coletor
907:     * Inferior: GrupoGeral, VrLimCre, CdMoeda, DsMoeda, RodRelCC
908:     *--------------------------------------------------------------------------
909:     PROTECTED PROCEDURE ConfigurarAbaGeral()
910:         LOCAL loc_oAba
911:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
912: 
913:         *== Coluna Esquerda (labels left~27-103, opts left=128) ==================
914:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComple",   "Complemento :",                   56, 22,  74)
915:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComple",   128, 18, 97, 2)
916: 
917:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPessoais", "Dados Pessoais :",                 47, 48,  83)
918:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPessoais",  128, 44, 97, 2)
919: 
920:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRefBancs", "Ref. Banc" + CHR(225) + "rias :", 51, 74,  79)
921:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRefBancs",  128, 70, 97, 2)
922: 
923:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFollowUp", "Follow-Up :",                     74, 101, 56)
924:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFollowUp",  128, 97, 97, 2)
925: 
926:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFiscais",  "Dados Fiscais :",                 57, 127, 73)
927:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFiscais",   128, 123, 97, 2)
928: 
929:         THIS.CriarLabel(loc_oAba, "lbl_4c_GDadosCom", "Dados Comerciais :",              37, 153, 93)
930:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptDadosCom",  128, 149, 97, 2)
931: 
932:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRespos", ;
933:             "Possui Respons" + CHR(225) + "vel :",             27, 178, 103)
934:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRespos",    128, 174, 97, 2)
935: 
936:         *-- Limite de Credito (3 botoes)
937:         THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCre", ;
938:             "Limite de Cr" + CHR(233) + "dito :",              41, 202, 89)
939:         loc_oAba.AddObject("opt_4c_OptLimCre", "OptionGroup")
940:         WITH loc_oAba.opt_4c_OptLimCre
941:             .ButtonCount  = 3
942:             .Left         = 126
943:             .Top          = 197
944:             .Width        = 225
945:             .Height       = 25
946:             .BorderStyle  = 0
947:             .Value        = 1
948:             .Buttons(1).Caption  = "Sim"
949:             .Buttons(1).Width    = 70
950:             .Buttons(1).Left     = 0
951:             .Buttons(1).Top      = 0
952:             .Buttons(1).AutoSize = .F.
953:             .Buttons(1).ForeColor = RGB(90, 90, 90)
954:             .Buttons(1).Themes   = .F.
955:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
956:             .Buttons(2).Width    = 70
957:             .Buttons(2).Left     = 70
958:             .Buttons(2).Top      = 0
959:             .Buttons(2).AutoSize = .F.
960:             .Buttons(2).ForeColor = RGB(90, 90, 90)
961:             .Buttons(2).Themes   = .F.
962:             .Buttons(3).Caption  = "Sim-Saldo"
963:             .Buttons(3).Width    = 85
964:             .Buttons(3).Left     = 140
965:             .Buttons(3).Top      = 0
966:             .Buttons(3).AutoSize = .F.
967:             .Buttons(3).ForeColor = RGB(90, 90, 90)
968:             .Buttons(3).Themes   = .F.
969:         ENDWITH
970: 
971:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComi", ;
972:             "Comiss" + CHR(227) + "o :",                       76, 229, 54)
973:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComi",      128, 225, 97, 2)
974: 
975:         *== Coluna Direita (labels left~411-501, opts left=533) ==================
976:         THIS.CriarLabel(loc_oAba, "lbl_4c_GEmpresa",  "Dados da Empresa :",             436, 22,  98)
977:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEmpresa",   533, 18, 97, 2)
978: 
979:         THIS.CriarLabel(loc_oAba, "lbl_4c_GContabs", ;

*-- Linhas 997 a 1040:
997:         *== Extrema Direita: Grupo Padrao (Coletor, 11 botoes) ==================
998:         THIS.CriarLabel(loc_oAba, "lbl_4c_GColetor", ;
999:             "Grupo Padr" + CHR(227) + "o :",                  706, 22,  75)
1000:         loc_oAba.AddObject("opt_4c_OptColetor", "OptionGroup")
1001:         WITH loc_oAba.opt_4c_OptColetor
1002:             .ButtonCount  = 11
1003:             .Left         = 780
1004:             .Top          = 15
1005:             .Width        = 141
1006:             .Height       = 210
1007:             .BorderStyle  = 0
1008:             .Value        = 1
1009:             .Buttons(1).Caption  = " 1"
1010:             .Buttons(1).Left     = 0
1011:             .Buttons(1).Top      = 0
1012:             .Buttons(1).AutoSize = .F.
1013:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1014:             .Buttons(1).Themes   = .F.
1015:             .Buttons(2).Caption  = " 2"
1016:             .Buttons(2).Left     = 0
1017:             .Buttons(2).Top      = 19
1018:             .Buttons(2).AutoSize = .F.
1019:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1020:             .Buttons(2).Themes   = .F.
1021:             .Buttons(3).Caption  = " 3"
1022:             .Buttons(3).Left     = 0
1023:             .Buttons(3).Top      = 38
1024:             .Buttons(3).AutoSize = .F.
1025:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1026:             .Buttons(3).Themes   = .F.
1027:             .Buttons(4).Caption  = " 4"
1028:             .Buttons(4).Left     = 0
1029:             .Buttons(4).Top      = 57
1030:             .Buttons(4).AutoSize = .F.
1031:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1032:             .Buttons(4).Themes   = .F.
1033:             .Buttons(5).Caption  = " 5"
1034:             .Buttons(5).Left     = 0
1035:             .Buttons(5).Top      = 76
1036:             .Buttons(5).AutoSize = .F.
1037:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1038:             .Buttons(5).Themes   = .F.
1039:             .Buttons(6).Caption  = " 6"
1040:             .Buttons(6).Left     = 0

*-- Linhas 1095 a 1268:
1095:             .SpecialEffect = 1
1096:             .MaxLength     = 20
1097:         ENDWITH
1098:         BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "KeyPress",  THIS, "txt_4c_GrupoGeral_KeyPress")
1099:         BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "LostFocus", THIS, "txt_4c_GrupoGeral_LostFocus")
1100: 
1101:         loc_oAba.AddObject("txt_4c_VrLimCre", "TextBox")
1102:         WITH loc_oAba.txt_4c_VrLimCre
1103:             .Value         = 0
1104:             .Left          = 636
1105:             .Top           = 199
1106:             .Width         = 110
1107:             .Height        = 23
1108:             .FontName      = "Tahoma"
1109:             .FontSize      = 8
1110:             .SpecialEffect = 1
1111:         ENDWITH
1112: 
1113:         THIS.CriarLabel(loc_oAba, "lbl_4c_GMoeda", ;
1114:             "Moeda da Comiss" + CHR(227) + "o :",             430, 229, 107)
1115: 
1116:         loc_oAba.AddObject("txt_4c_CdMoeda", "TextBox")
1117:         WITH loc_oAba.txt_4c_CdMoeda
1118:             .Value         = ""
1119:             .Left          = 536
1120:             .Top           = 225
1121:             .Width         = 32
1122:             .Height        = 23
1123:             .FontName      = "Tahoma"
1124:             .FontSize      = 8
1125:             .SpecialEffect = 1
1126:             .MaxLength     = 10
1127:         ENDWITH
1128:         BINDEVENT(loc_oAba.txt_4c_CdMoeda, "KeyPress",  THIS, "txt_4c_CdMoeda_KeyPress")
1129:         BINDEVENT(loc_oAba.txt_4c_CdMoeda, "LostFocus", THIS, "txt_4c_CdMoeda_LostFocus")
1130: 
1131:         loc_oAba.AddObject("txt_4c_DsMoeda", "TextBox")
1132:         WITH loc_oAba.txt_4c_DsMoeda
1133:             .Value         = ""
1134:             .Left          = 570
1135:             .Top           = 225
1136:             .Width         = 130
1137:             .Height        = 23
1138:             .FontName      = "Tahoma"
1139:             .FontSize      = 8
1140:             .SpecialEffect = 1
1141:             .Enabled       = .F.
1142:         ENDWITH
1143: 
1144:         *== Rodape Relatorio Conta Corrente =====================================
1145:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRodape", ;
1146:             "Rod" + CHR(225) + "p" + CHR(233) + " do Relat" + CHR(243) + ;
1147:             "rio de Conta Corrente",                          165, 263, 220)
1148: 
1149:         loc_oAba.AddObject("edt_4c_RodRelCC", "EditBox")
1150:         WITH loc_oAba.edt_4c_RodRelCC
1151:             .Value         = ""
1152:             .Left          = 165
1153:             .Top           = 280
1154:             .Width         = 788
1155:             .Height        = 117
1156:             .FontName      = "Tahoma"
1157:             .FontSize      = 8
1158:             .SpecialEffect = 1
1159:             .ScrollBars    = 2
1160:         ENDWITH
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * ConfigurarAbaCadastro - Controles da Aba 2 (Cadastro/Financeiro)
1165:     * Col.Esq: CPFObrig/RG/CEP/CalcIMeds/ObrMails/ObrNome/ObrSit/ObrTlm/
1166:     *          ObrCla/ObrSeg/ObrIbge/FpublSobr/NascObrig
1167:     * Col.Dir: RestEnd/CntVinc/DupEnd/MFotos/Observacao/CpfFixo/Situacao/
1168:     *          CaracCad/AceJob/CCustoTit/LogAlt/InfSenha
1169:     * Financeiro: Contint/IntegCont/PadPreench/VincContas/TitBaixado
1170:     *--------------------------------------------------------------------------
1171:     PROTECTED PROCEDURE ConfigurarAbaCadastro()
1172:         LOCAL loc_oAba
1173:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
1174: 
1175:         THIS.CriarLabel(loc_oAba, "lbl_4c_CadHeader", ;
1176:             "Cadastro de Contas",                              29, 14, 120)
1177: 
1178:         *-- CPF/CNPJ Obrigatorio (4 botoes)
1179:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfObrig", ;
1180:             "CPF / CNPJ Obrigat" + CHR(243) + "rio :",        73, 32, 120)
1181:         loc_oAba.AddObject("opt_4c_CpfObrig", "OptionGroup")
1182:         WITH loc_oAba.opt_4c_CpfObrig
1183:             .ButtonCount  = 4
1184:             .Left         = 192
1185:             .Top          = 29
1186:             .Width        = 284
1187:             .Height       = 23
1188:             .BorderStyle  = 0
1189:             .Value        = 1
1190:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1191:             .Buttons(1).Width    = 64
1192:             .Buttons(1).Left     = 0
1193:             .Buttons(1).Top      = 0
1194:             .Buttons(1).AutoSize = .F.
1195:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1196:             .Buttons(1).Themes   = .F.
1197:             .Buttons(2).Caption  = "Sim"
1198:             .Buttons(2).Width    = 64
1199:             .Buttons(2).Left     = 64
1200:             .Buttons(2).Top      = 0
1201:             .Buttons(2).AutoSize = .F.
1202:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1203:             .Buttons(2).Themes   = .F.
1204:             .Buttons(3).Caption  = "Sim-Dupla"
1205:             .Buttons(3).Width    = 80
1206:             .Buttons(3).Left     = 128
1207:             .Buttons(3).Top      = 0
1208:             .Buttons(3).AutoSize = .F.
1209:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1210:             .Buttons(3).Themes   = .F.
1211:             .Buttons(4).Caption  = "N" + CHR(227) + "o-Dupla"
1212:             .Buttons(4).Width    = 76
1213:             .Buttons(4).Left     = 208
1214:             .Buttons(4).Top      = 0
1215:             .Buttons(4).AutoSize = .F.
1216:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1217:             .Buttons(4).Themes   = .F.
1218:         ENDWITH
1219: 
1220:         *-- RG/IE Obrigatorio
1221:         THIS.CriarLabel(loc_oAba, "lbl_4c_CRgObrig", ;
1222:             "RG / IE Obrigat" + CHR(243) + "rio :",           93, 53, 100)
1223:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_RgObrig",       192, 50, 115, 2)
1224: 
1225:         *-- CEP Obrigatorio (3 botoes)
1226:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCepObrig", ;
1227:             "CEP Obrigat" + CHR(243) + "rio :",               108, 76, 85)
1228:         loc_oAba.AddObject("opt_4c_CepObrig", "OptionGroup")
1229:         WITH loc_oAba.opt_4c_CepObrig
1230:             .ButtonCount  = 3
1231:             .Left         = 191
1232:             .Top          = 70
1233:             .Width        = 201
1234:             .Height       = 25
1235:             .BorderStyle  = 0
1236:             .Value        = 1
1237:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1238:             .Buttons(1).Width    = 60
1239:             .Buttons(1).Left     = 0
1240:             .Buttons(1).Top      = 0
1241:             .Buttons(1).AutoSize = .F.
1242:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1243:             .Buttons(1).Themes   = .F.
1244:             .Buttons(2).Caption  = "Sim"
1245:             .Buttons(2).Width    = 60
1246:             .Buttons(2).Left     = 60
1247:             .Buttons(2).Top      = 0
1248:             .Buttons(2).AutoSize = .F.
1249:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1250:             .Buttons(2).Themes   = .F.
1251:             .Buttons(3).Caption  = "Sim-Buscar"
1252:             .Buttons(3).Width    = 81
1253:             .Buttons(3).Left     = 120
1254:             .Buttons(3).Top      = 0
1255:             .Buttons(3).AutoSize = .F.
1256:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1257:             .Buttons(3).Themes   = .F.
1258:         ENDWITH
1259: 
1260:         *-- Calc.IMedias
1261:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCalcIMeds", ;
1262:             "Calc. I.M" + CHR(233) + "dias :",                108, 95, 85)
1263:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CalcIMeds",     191, 92, 97, 2)
1264: 
1265:         *-- eMail Obrigatorio
1266:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrMails", ;
1267:             "e-Mail Obrigat" + CHR(243) + "rio :",             99, 120, 94)
1268:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrMails",      191, 115, 97, 2)

*-- Linhas 1331 a 1541:
1331:         *-- Observacao (3 botoes, height=63)
1332:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObservacao", ;
1333:             "Observa" + CHR(231) + CHR(227) + "o :",          621, 115, 67)
1334:         loc_oAba.AddObject("opt_4c_Observacao", "OptionGroup")
1335:         WITH loc_oAba.opt_4c_Observacao
1336:             .ButtonCount  = 3
1337:             .Left         = 689
1338:             .Top          = 115
1339:             .Width        = 115
1340:             .Height       = 63
1341:             .BorderStyle  = 0
1342:             .Value        = 1
1343:             .Buttons(1).Caption  = "N" + CHR(227) + "o Mostrar"
1344:             .Buttons(1).Width    = 112
1345:             .Buttons(1).Left     = 0
1346:             .Buttons(1).Top      = 0
1347:             .Buttons(1).AutoSize = .F.
1348:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1349:             .Buttons(1).Themes   = .F.
1350:             .Buttons(2).Caption  = "Sempre"
1351:             .Buttons(2).Width    = 112
1352:             .Buttons(2).Left     = 0
1353:             .Buttons(2).Top      = 21
1354:             .Buttons(2).AutoSize = .F.
1355:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1356:             .Buttons(2).Themes   = .F.
1357:             .Buttons(3).Caption  = "Mostrar Bot" + CHR(227) + "o"
1358:             .Buttons(3).Width    = 112
1359:             .Buttons(3).Left     = 0
1360:             .Buttons(3).Top      = 42
1361:             .Buttons(3).AutoSize = .F.
1362:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1363:             .Buttons(3).Themes   = .F.
1364:         ENDWITH
1365: 
1366:         *-- CPF/CNPJ Fixo (3 botoes)
1367:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfFixo", ;
1368:             "CPF / CNPJ Fixo :",                              602, 167, 86)
1369:         loc_oAba.AddObject("opt_4c_CpfFixo", "OptionGroup")
1370:         WITH loc_oAba.opt_4c_CpfFixo
1371:             .ButtonCount  = 3
1372:             .Left         = 690
1373:             .Top          = 164
1374:             .Width        = 167
1375:             .Height       = 23
1376:             .BorderStyle  = 0
1377:             .Value        = 1
1378:             .Buttons(1).Caption  = "CPF"
1379:             .Buttons(1).Width    = 50
1380:             .Buttons(1).Left     = 0
1381:             .Buttons(1).Top      = 0
1382:             .Buttons(1).AutoSize = .F.
1383:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1384:             .Buttons(1).Themes   = .F.
1385:             .Buttons(2).Caption  = "CNPJ"
1386:             .Buttons(2).Width    = 50
1387:             .Buttons(2).Left     = 50
1388:             .Buttons(2).Top      = 0
1389:             .Buttons(2).AutoSize = .F.
1390:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1391:             .Buttons(2).Themes   = .F.
1392:             .Buttons(3).Caption  = "Ambos"
1393:             .Buttons(3).Width    = 67
1394:             .Buttons(3).Left     = 100
1395:             .Buttons(3).Top      = 0
1396:             .Buttons(3).AutoSize = .F.
1397:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1398:             .Buttons(3).Themes   = .F.
1399:         ENDWITH
1400: 
1401:         *-- Situacao Padrao (textbox + lookup)
1402:         THIS.CriarLabel(loc_oAba, "lbl_4c_CSituacao", ;
1403:             "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :", 601, 189, 90)
1404:         loc_oAba.AddObject("txt_4c_Situas", "TextBox")
1405:         WITH loc_oAba.txt_4c_Situas
1406:             .Value         = ""
1407:             .Left          = 693
1408:             .Top           = 185
1409:             .Width         = 32
1410:             .Height        = 23
1411:             .FontName      = "Tahoma"
1412:             .FontSize      = 8
1413:             .SpecialEffect = 1
1414:             .MaxLength     = 10
1415:         ENDWITH
1416:         BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress",  THIS, "txt_4c_Situas_KeyPress")
1417:         BINDEVENT(loc_oAba.txt_4c_Situas, "LostFocus", THIS, "txt_4c_Situas_LostFocus")
1418: 
1419:         *-- Caracteristica Cadastro
1420:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCaracCad", ;
1421:             "Caracter" + CHR(237) + "stica :",                613, 212, 75)
1422:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CaracCad",      688, 208, 115, 2)
1423: 
1424:         *-- Acesso Job
1425:         THIS.CriarLabel(loc_oAba, "lbl_4c_CAceJob",   "Acesso Job :",               625, 233, 63)
1426:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_AceJob",        688, 229, 115, 2)
1427: 
1428:         *-- Habilita Centro de Custos Titulos
1429:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCCustoTit", ;
1430:             "Habilita Centro de Custos nos T" + CHR(237) + "tulos :", 503, 254, 185)
1431:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CCustoTit",     687, 249, 97, 2)
1432: 
1433:         *-- Log de Alteracoes
1434:         THIS.CriarLabel(loc_oAba, "lbl_4c_CLogAlt", ;
1435:             "Log de Altera" + CHR(231) + CHR(245) + "es :",  593, 276, 95)
1436:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_LogAlt",        688, 272, 115, 2)
1437: 
1438:         *-- Informar Senha na Alteracao
1439:         THIS.CriarLabel(loc_oAba, "lbl_4c_CInfSenha", ;
1440:             "Informar senha na Altera" + CHR(231) + CHR(227) + "o :", 541, 296, 147)
1441:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_InfSenha",      688, 292, 115, 2)
1442: 
1443:         *== Separador Financeiro ================================================
1444:         THIS.CriarLabel(loc_oAba, "lbl_4c_CFinHeader", "Financeiro", 29, 315, 60)
1445: 
1446:         *-- Conta Corrente Interna
1447:         THIS.CriarLabel(loc_oAba, "lbl_4c_CContint",  "Conta :",                    152, 324, 40)
1448:         loc_oAba.AddObject("txt_4c_Contint", "TextBox")
1449:         WITH loc_oAba.txt_4c_Contint
1450:             .Value         = ""
1451:             .Left          = 192
1452:             .Top           = 321
1453:             .Width         = 73
1454:             .Height        = 23
1455:             .FontName      = "Tahoma"
1456:             .FontSize      = 8
1457:             .SpecialEffect = 1
1458:             .MaxLength     = 20
1459:         ENDWITH
1460:         BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress",  THIS, "txt_4c_Contint_KeyPress")
1461:         BINDEVENT(loc_oAba.txt_4c_Contint, "LostFocus", THIS, "txt_4c_Contint_LostFocus")
1462: 
1463:         *-- Integracao Contabil (3 botoes)
1464:         THIS.CriarLabel(loc_oAba, "lbl_4c_CIntegCont", ;
1465:             "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :", 86, 348, 104)
1466:         loc_oAba.AddObject("opt_4c_IntegCont", "OptionGroup")
1467:         WITH loc_oAba.opt_4c_IntegCont
1468:             .ButtonCount  = 3
1469:             .Left         = 192
1470:             .Top          = 345
1471:             .Width        = 316
1472:             .Height       = 23
1473:             .BorderStyle  = 0
1474:             .Value        = 1
1475:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1476:             .Buttons(1).Width    = 80
1477:             .Buttons(1).Left     = 0
1478:             .Buttons(1).Top      = 0
1479:             .Buttons(1).AutoSize = .F.
1480:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1481:             .Buttons(1).Themes   = .F.
1482:             .Buttons(2).Caption  = "Sim"
1483:             .Buttons(2).Width    = 80
1484:             .Buttons(2).Left     = 80
1485:             .Buttons(2).Top      = 0
1486:             .Buttons(2).AutoSize = .F.
1487:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1488:             .Buttons(2).Themes   = .F.
1489:             .Buttons(3).Caption  = "Sem ContraPartida"
1490:             .Buttons(3).Width    = 156
1491:             .Buttons(3).Left     = 160
1492:             .Buttons(3).Top      = 0
1493:             .Buttons(3).AutoSize = .F.
1494:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1495:             .Buttons(3).Themes   = .F.
1496:         ENDWITH
1497: 
1498:         *-- Padrao Preenchimento (4 botoes)
1499:         THIS.CriarLabel(loc_oAba, "lbl_4c_CPadPreench", ;
1500:             "Padr" + CHR(227) + "o de Preenchimento :",       58, 369, 132)
1501:         loc_oAba.AddObject("opt_4c_PadPreench", "OptionGroup")
1502:         WITH loc_oAba.opt_4c_PadPreench
1503:             .ButtonCount  = 4
1504:             .Left         = 192
1505:             .Top          = 366
1506:             .Width        = 353
1507:             .Height       = 23
1508:             .BorderStyle  = 0
1509:             .Value        = 1
1510:             .Buttons(1).Caption  = "Nenhum"
1511:             .Buttons(1).Width    = 70
1512:             .Buttons(1).Left     = 0
1513:             .Buttons(1).Top      = 0
1514:             .Buttons(1).AutoSize = .F.
1515:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1516:             .Buttons(1).Themes   = .F.
1517:             .Buttons(2).Caption  = "Pagamentos"
1518:             .Buttons(2).Width    = 90
1519:             .Buttons(2).Left     = 70
1520:             .Buttons(2).Top      = 0
1521:             .Buttons(2).AutoSize = .F.
1522:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1523:             .Buttons(2).Themes   = .F.
1524:             .Buttons(3).Caption  = "Recebimentos"
1525:             .Buttons(3).Width    = 100
1526:             .Buttons(3).Left     = 160
1527:             .Buttons(3).Top      = 0
1528:             .Buttons(3).AutoSize = .F.
1529:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1530:             .Buttons(3).Themes   = .F.
1531:             .Buttons(4).Caption  = "Ambos"
1532:             .Buttons(4).Width    = 93
1533:             .Buttons(4).Left     = 260
1534:             .Buttons(4).Top      = 0
1535:             .Buttons(4).AutoSize = .F.
1536:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1537:             .Buttons(4).Themes   = .F.
1538:         ENDWITH
1539: 
1540:         *-- Vincula Contas no Pag/Rec
1541:         THIS.CriarLabel(loc_oAba, "lbl_4c_CVincContas", ;

*-- Linhas 1554 a 1664:
1554:     * Industria: GBals/DifPeso/Sinal/Tfalhas/GrupoEst + TrfPeso/GrupoFalha/ContaFalha
1555:     *            UnifBal/ContaPdr/FalPers/BlqDivOp/OsAlFuns/OsPend/Compagru/ObjDupTit/GetAgrupa
1556:     *--------------------------------------------------------------------------
1557:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
1558:         LOCAL loc_oAba
1559:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
1560: 
1561:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstHeader", "Estoque", 21, 14, 47)
1562: 
1563:         *== Coluna Esquerda: Limite/Avalia/ProdAcabado/ChkLimEst/CCusto =========
1564:         THIS.CriarLabel(loc_oAba, "lbl_4c_ELimEsto", ;
1565:             "Limite de Estoque :",                             85, 35, 93)
1566:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptLimEsto",    174, 30, 92, 2)
1567: 
1568:         THIS.CriarLabel(loc_oAba, "lbl_4c_EVerEst",   "Avalia Estoque :",            99, 60, 80)
1569:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptVerEst",     174, 56, 92, 2)
1570: 
1571:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstPAcab", ;
1572:             "Estoque Produto Acabado :",                       45, 84, 134)
1573:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEstPAcab",   174, 80, 92, 2)
1574: 
1575:         THIS.CriarLabel(loc_oAba, "lbl_4c_EChkLimEst", ;
1576:             "Checa Limite de Estoque:",                        55, 109, 124)
1577:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimEst",  174, 104, 92, 2)
1578: 
1579:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECCusto",   "Centro de Custos :",          86, 132, 93)
1580:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCCustoEst",  174, 128, 92, 2)
1581: 
1582:         *== Coluna Direita: Saldo/Relevante/BlqConGV/Patrim/TipoInvs ===========
1583:         THIS.CriarLabel(loc_oAba, "lbl_4c_ESaldo", ;
1584:             "C" + CHR(225) + "lculo de Saldo :",              386, 35, 87)
1585:         loc_oAba.AddObject("opt_4c_OptSaldo", "OptionGroup")
1586:         WITH loc_oAba.opt_4c_OptSaldo
1587:             .ButtonCount  = 2
1588:             .Left         = 469
1589:             .Top          = 30
1590:             .Width        = 149
1591:             .Height       = 25
1592:             .BorderStyle  = 0
1593:             .Value        = 1
1594:             .Buttons(1).Caption  = "Online"
1595:             .Buttons(1).Width    = 70
1596:             .Buttons(1).Left     = 0
1597:             .Buttons(1).Top      = 0
1598:             .Buttons(1).AutoSize = .F.
1599:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1600:             .Buttons(1).Themes   = .F.
1601:             .Buttons(2).Caption  = "Background"
1602:             .Buttons(2).Width    = 79
1603:             .Buttons(2).Left     = 70
1604:             .Buttons(2).Top      = 0
1605:             .Buttons(2).AutoSize = .F.
1606:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1607:             .Buttons(2).Themes   = .F.
1608:         ENDWITH
1609: 
1610:         THIS.CriarLabel(loc_oAba, "lbl_4c_ERelevante", ;
1611:             "Empresa Relevante :",                            370, 60, 102)
1612:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRelevante",  469, 56, 113, 2)
1613: 
1614:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqConGV", ;
1615:             "Bloqueia Consulta Vendas :",                     342, 85, 132)
1616:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqConGV",   469, 80, 113, 2)
1617: 
1618:         THIS.CriarLabel(loc_oAba, "lbl_4c_EPatrim", ;
1619:             "Patrimonial por Etiqueta :",                     351, 109, 123)
1620:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPatrim",     469, 104, 113, 2)
1621: 
1622:         THIS.CriarLabel(loc_oAba, "lbl_4c_EInvTipo", ;
1623:             "Invent" + CHR(225) + "rio :",                   415, 132, 55)
1624:         loc_oAba.AddObject("opt_4c_OpTipoInvs", "OptionGroup")
1625:         WITH loc_oAba.opt_4c_OpTipoInvs
1626:             .ButtonCount  = 3
1627:             .Left         = 470
1628:             .Top          = 128
1629:             .Width        = 371
1630:             .Height       = 25
1631:             .BorderStyle  = 0
1632:             .Value        = 1
1633:             .Buttons(1).Caption  = "Pr" + CHR(243) + "prio"
1634:             .Buttons(1).Width    = 100
1635:             .Buttons(1).Left     = 0
1636:             .Buttons(1).Top      = 0
1637:             .Buttons(1).AutoSize = .F.
1638:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1639:             .Buttons(1).Themes   = .F.
1640:             .Buttons(2).Caption  = "Pr" + CHR(243) + "prio Poder 3p"
1641:             .Buttons(2).Width    = 135
1642:             .Buttons(2).Left     = 100
1643:             .Buttons(2).Top      = 0
1644:             .Buttons(2).AutoSize = .F.
1645:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1646:             .Buttons(2).Themes   = .F.
1647:             .Buttons(3).Caption  = "Nos Meios 3p"
1648:             .Buttons(3).Width    = 136
1649:             .Buttons(3).Left     = 235
1650:             .Buttons(3).Top      = 0
1651:             .Buttons(3).AutoSize = .F.
1652:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1653:             .Buttons(3).Themes   = .F.
1654:         ENDWITH
1655: 
1656:         *== DDR/DDF (far right) =================================================
1657:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDdR", ;
1658:             "Dias Bloqueio Retroativo :",                     723, 37, 127)
1659:         loc_oAba.AddObject("txt_4c_DdR", "TextBox")
1660:         WITH loc_oAba.txt_4c_DdR
1661:             .Value         = 0
1662:             .Left          = 852
1663:             .Top           = 33
1664:             .Width         = 45

*-- Linhas 1748 a 1796:
1748:             .SpecialEffect = 1
1749:             .MaxLength     = 20
1750:         ENDWITH
1751:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress",  THIS, "txt_4c_GrupoEst_KeyPress")
1752:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "LostFocus", THIS, "txt_4c_GrupoEst_LostFocus")
1753: 
1754:         *-- Transfere Peso (5 botoes)
1755:         THIS.CriarLabel(loc_oAba, "lbl_4c_ETrfPeso",  "Transfere Peso :",            395, 219, 82)
1756:         loc_oAba.AddObject("opt_4c_ChkTrfPeso", "OptionGroup")
1757:         WITH loc_oAba.opt_4c_ChkTrfPeso
1758:             .ButtonCount  = 5
1759:             .Left         = 474
1760:             .Top          = 219
1761:             .Width        = 186
1762:             .Height       = 95
1763:             .BorderStyle  = 0
1764:             .Value        = 1
1765:             .Buttons(1).Caption  = "1"
1766:             .Buttons(1).Left     = 0
1767:             .Buttons(1).Top      = 0
1768:             .Buttons(1).AutoSize = .F.
1769:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1770:             .Buttons(1).Themes   = .F.
1771:             .Buttons(2).Caption  = "2"
1772:             .Buttons(2).Left     = 0
1773:             .Buttons(2).Top      = 19
1774:             .Buttons(2).AutoSize = .F.
1775:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1776:             .Buttons(2).Themes   = .F.
1777:             .Buttons(3).Caption  = "3"
1778:             .Buttons(3).Left     = 0
1779:             .Buttons(3).Top      = 38
1780:             .Buttons(3).AutoSize = .F.
1781:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1782:             .Buttons(3).Themes   = .F.
1783:             .Buttons(4).Caption  = "4"
1784:             .Buttons(4).Left     = 0
1785:             .Buttons(4).Top      = 57
1786:             .Buttons(4).AutoSize = .F.
1787:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1788:             .Buttons(4).Themes   = .F.
1789:             .Buttons(5).Caption  = "5"
1790:             .Buttons(5).Left     = 0
1791:             .Buttons(5).Top      = 76
1792:             .Buttons(5).AutoSize = .F.
1793:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1794:             .Buttons(5).Themes   = .F.
1795:         ENDWITH
1796: 

*-- Linhas 1809 a 1888:
1809:             .SpecialEffect = 1
1810:             .MaxLength     = 20
1811:         ENDWITH
1812:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress",  THIS, "txt_4c_GrupoFalha_KeyPress")
1813:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "LostFocus", THIS, "txt_4c_GrupoFalha_LostFocus")
1814: 
1815:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaFalha", ;
1816:             "Conta de Falha :",                              721, 224, 82)
1817:         loc_oAba.AddObject("txt_4c_ContaFalha", "TextBox")
1818:         WITH loc_oAba.txt_4c_ContaFalha
1819:             .Value         = ""
1820:             .Left          = 805
1821:             .Top           = 220
1822:             .Width         = 90
1823:             .Height        = 23
1824:             .FontName      = "Tahoma"
1825:             .FontSize      = 8
1826:             .SpecialEffect = 1
1827:             .MaxLength     = 20
1828:         ENDWITH
1829:         BINDEVENT(loc_oAba.txt_4c_ContaFalha, "KeyPress",  THIS, "txt_4c_ContaFalha_KeyPress")
1830:         BINDEVENT(loc_oAba.txt_4c_ContaFalha, "LostFocus", THIS, "txt_4c_ContaFalha_LostFocus")
1831: 
1832:         loc_oAba.AddObject("txt_4c_DsContaFalha", "TextBox")
1833:         WITH loc_oAba.txt_4c_DsContaFalha
1834:             .Value         = ""
1835:             .Left          = 897
1836:             .Top           = 220
1837:             .Width         = 59
1838:             .Height        = 23
1839:             .FontName      = "Tahoma"
1840:             .FontSize      = 8
1841:             .SpecialEffect = 1
1842:             .Enabled       = .F.
1843:         ENDWITH
1844: 
1845:         *== Balanco Unificado (4 botoes) =========================================
1846:         THIS.CriarLabel(loc_oAba, "lbl_4c_EUnifBal", ;
1847:             "Balan" + CHR(231) + "o Unificado :",             83, 249, 93)
1848:         loc_oAba.AddObject("opt_4c_OptUnifBal", "OptionGroup")
1849:         WITH loc_oAba.opt_4c_OptUnifBal
1850:             .ButtonCount  = 4
1851:             .Left         = 174
1852:             .Top          = 245
1853:             .Width        = 171
1854:             .Height       = 43
1855:             .BorderStyle  = 0
1856:             .Value        = 1
1857:             .Buttons(1).Caption  = "N" + CHR(227) + "o"
1858:             .Buttons(1).Width    = 42
1859:             .Buttons(1).Left     = 0
1860:             .Buttons(1).Top      = 0
1861:             .Buttons(1).AutoSize = .F.
1862:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1863:             .Buttons(1).Themes   = .F.
1864:             .Buttons(2).Caption  = "Sim"
1865:             .Buttons(2).Width    = 42
1866:             .Buttons(2).Left     = 42
1867:             .Buttons(2).Top      = 0
1868:             .Buttons(2).AutoSize = .F.
1869:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1870:             .Buttons(2).Themes   = .F.
1871:             .Buttons(3).Caption  = "Parcial"
1872:             .Buttons(3).Width    = 43
1873:             .Buttons(3).Left     = 84
1874:             .Buttons(3).Top      = 0
1875:             .Buttons(3).AutoSize = .F.
1876:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1877:             .Buttons(3).Themes   = .F.
1878:             .Buttons(4).Caption  = "Total"
1879:             .Buttons(4).Width    = 44
1880:             .Buttons(4).Left     = 127
1881:             .Buttons(4).Top      = 0
1882:             .Buttons(4).AutoSize = .F.
1883:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1884:             .Buttons(4).Themes   = .F.
1885:         ENDWITH
1886: 
1887:         *== Conta Padrao =========================================================
1888:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaPdr", ;

*-- Linhas 1899 a 1943:
1899:             .SpecialEffect = 1
1900:             .MaxLength     = 20
1901:         ENDWITH
1902:         BINDEVENT(loc_oAba.txt_4c_ContaPdr, "KeyPress",  THIS, "txt_4c_ContaPdr_KeyPress")
1903:         BINDEVENT(loc_oAba.txt_4c_ContaPdr, "LostFocus", THIS, "txt_4c_ContaPdr_LostFocus")
1904: 
1905:         loc_oAba.AddObject("txt_4c_DsContaPdr", "TextBox")
1906:         WITH loc_oAba.txt_4c_DsContaPdr
1907:             .Value         = ""
1908:             .Left          = 896
1909:             .Top           = 246
1910:             .Width         = 59
1911:             .Height        = 23
1912:             .FontName      = "Tahoma"
1913:             .FontSize      = 8
1914:             .SpecialEffect = 1
1915:             .Enabled       = .F.
1916:         ENDWITH
1917: 
1918:         *== Balanco Falhas/Perdas ================================================
1919:         THIS.CriarLabel(loc_oAba, "lbl_4c_EFalPers", ;
1920:             "Balan" + CHR(231) + "o Falhas/Perdas :",         61, 293, 117)
1921:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFalPers",    174, 288, 92, 2)
1922: 
1923:         *== Bloqueia Divisao OF ==================================================
1924:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqDivOp", ;
1925:             "Bloqueia Divis" + CHR(227) + "o de OF :",        59, 318, 118)
1926:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqDivOp",   174, 314, 92, 2)
1927: 
1928:         *== Container Resumo de Composicao (Os/Alianca/Fundicao) ================
1929:         loc_oAba.AddObject("cnt_4c_OsAlFuns", "Container")
1930:         WITH loc_oAba.cnt_4c_OsAlFuns
1931:             .Top         = 311
1932:             .Left        = 324
1933:             .Width       = 347
1934:             .Height      = 27
1935:             .BackStyle   = 0
1936:             .BorderWidth = 0
1937:             .Visible     = .T.
1938:         ENDWITH
1939: 
1940:         loc_oAba.cnt_4c_OsAlFuns.AddObject("lbl_4c_ResComp", "Label")
1941:         WITH loc_oAba.cnt_4c_OsAlFuns.lbl_4c_ResComp
1942:             .Caption   = "Resumo de Composi" + CHR(231) + CHR(227) + "o :"
1943:             .Left      = 30

*-- Linhas 1997 a 2040:
1997:         *== Agrupa Componentes (3 botoes) ========================================
1998:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECompagru", ;
1999:             "Agrupa Componentes :",                           364, 341, 109)
2000:         loc_oAba.AddObject("opt_4c_OpCompagru", "OptionGroup")
2001:         WITH loc_oAba.opt_4c_OpCompagru
2002:             .ButtonCount  = 3
2003:             .Left         = 474
2004:             .Top          = 340
2005:             .Width        = 186
2006:             .Height       = 21
2007:             .BorderStyle  = 0
2008:             .Value        = 1
2009:             .Buttons(1).Caption  = "Sim"
2010:             .Buttons(1).Width    = 55
2011:             .Buttons(1).Left     = 0
2012:             .Buttons(1).Top      = 0
2013:             .Buttons(1).AutoSize = .F.
2014:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2015:             .Buttons(1).Themes   = .F.
2016:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
2017:             .Buttons(2).Width    = 55
2018:             .Buttons(2).Left     = 55
2019:             .Buttons(2).Top      = 0
2020:             .Buttons(2).AutoSize = .F.
2021:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2022:             .Buttons(2).Themes   = .F.
2023:             .Buttons(3).Caption  = "Mat. Principal"
2024:             .Buttons(3).Width    = 76
2025:             .Buttons(3).Left     = 110
2026:             .Buttons(3).Top      = 0
2027:             .Buttons(3).AutoSize = .F.
2028:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2029:             .Buttons(3).Themes   = .F.
2030:         ENDWITH
2031: 
2032:         *== Checa Duplicidade de Titulo ==========================================
2033:         THIS.CriarLabel(loc_oAba, "lbl_4c_EObjDupTit", ;
2034:             "Checa Duplicidade de T" + CHR(237) + "tulo:",    41, 369, 137)
2035:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObjDupTit",     174, 364, 92, 2)
2036: 
2037:         *== Agrupamento ==========================================================
2038:         THIS.CriarLabel(loc_oAba, "lbl_4c_EAgrupa",   "Agrupamento:",               406, 369, 75)
2039:         loc_oAba.AddObject("txt_4c_GetAgrupa", "TextBox")
2040:         WITH loc_oAba.txt_4c_GetAgrupa

*-- Linhas 2052 a 2210:
2052:         *== Controle de Lote (3 botoes) ==========================================
2053:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECtrlLote", ;
2054:             "Controle de Lote :",                             388, 396, 88)
2055:         loc_oAba.AddObject("opt_4c_CtrlLotes", "OptionGroup")
2056:         WITH loc_oAba.opt_4c_CtrlLotes
2057:             .ButtonCount  = 3
2058:             .Left         = 474
2059:             .Top          = 393
2060:             .Width        = 164
2061:             .Height       = 21
2062:             .BorderStyle  = 0
2063:             .Value        = 1
2064:             .Buttons(1).Caption  = "Sim"
2065:             .Buttons(1).Width    = 48
2066:             .Buttons(1).Left     = 0
2067:             .Buttons(1).Top      = 0
2068:             .Buttons(1).AutoSize = .F.
2069:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2070:             .Buttons(1).Themes   = .F.
2071:             .Buttons(2).Caption  = "N" + CHR(227) + "o"
2072:             .Buttons(2).Width    = 48
2073:             .Buttons(2).Left     = 48
2074:             .Buttons(2).Top      = 0
2075:             .Buttons(2).AutoSize = .F.
2076:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2077:             .Buttons(2).Themes   = .F.
2078:             .Buttons(3).Caption  = "M" + CHR(250) + "ltiplos"
2079:             .Buttons(3).Width    = 68
2080:             .Buttons(3).Left     = 96
2081:             .Buttons(3).Top      = 0
2082:             .Buttons(3).AutoSize = .F.
2083:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2084:             .Buttons(3).Themes   = .F.
2085:         ENDWITH
2086:     ENDPROC
2087: 
2088:     *--------------------------------------------------------------------------
2089:     * ConfigurarAbaFaturamento - Controles da Aba 4 (Faturamento/Fiscal)
2090:     * 9 containers fiscais: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS
2091:     * Cada container: lbl(nome), CdGrupos, CdContas, DsContas, PctAliqs, Receitas
2092:     *--------------------------------------------------------------------------
2093:     PROTECTED PROCEDURE ConfigurarAbaFaturamento()
2094:         LOCAL loc_oAba
2095:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4
2096: 
2097:         *-- Headers
2098:         THIS.CriarLabel(loc_oAba, "lbl_4c_FImposto",  "Impostos",                    22, 33, 60)
2099:         THIS.CriarLabel(loc_oAba, "lbl_4c_FGrupo",    "Grupo",                       104, 33, 40)
2100:         THIS.CriarLabel(loc_oAba, "lbl_4c_FConta", ;
2101:             "Conta e Descri" + CHR(231) + CHR(227) + "o",    301, 33, 120)
2102:         THIS.CriarLabel(loc_oAba, "lbl_4c_FAliqs", ;
2103:             "Al" + CHR(237) + "quota",                        552, 33, 50)
2104:         THIS.CriarLabel(loc_oAba, "lbl_4c_FReceita",  "Receita",                     623, 33, 50)
2105: 
2106:         *-- 9 containers fiscais (mesma estrutura, tops sequenciais)
2107:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ICMS", "ICMS",   52)
2108:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IPI",  "IPI",    78)
2109:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_II",   "II",    104)
2110:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ISS",  "ISS",   130)
2111:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IRRF", "IRRF",  156)
2112:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_INSS", "INSS",  182)
2113:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_PIS",  "PIS",   207)
2114:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_CSL",  "CSSL",  233)
2115:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_COF",  "COFINS",259)
2116:     ENDPROC
2117: 
2118:     *--------------------------------------------------------------------------
2119:     * CarregarLista - Carrega registros no grid da lista
2120:     * Colunas: Codigos(80), Descrs(300), Internos(120), TpCods(60), DClasses(300)
2121:     *--------------------------------------------------------------------------
2122:     PROCEDURE CarregarLista()
2123:         LOCAL loc_oGrid, loc_lResultado
2124:         loc_lResultado = .F.
2125: 
2126:         TRY
2127:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2128: 
2129:             IF !THIS.this_oBusinessObject.Buscar("")
2130:                 loc_lResultado = .F.
2131:             ELSE
2132:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2133: 
2134:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2135:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2136:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
2137:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
2138:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"
2139: 
2140:                 loc_oGrid.Column1.Width = 80
2141:                 loc_oGrid.Column2.Width = 300
2142:                 loc_oGrid.Column3.Width = 120
2143:                 loc_oGrid.Column4.Width = 60
2144:                 loc_oGrid.Column5.Width = 300
2145: 
2146:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2147:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2148:                 loc_oGrid.Column3.Header1.Caption = "Interno"
2149:                 loc_oGrid.Column4.Header1.Caption = "Tipo"
2150:                 loc_oGrid.Column5.Header1.Caption = "Classe"
2151: 
2152:                 THIS.FormatarGridLista(loc_oGrid)
2153:                 loc_lResultado = .T.
2154:             ENDIF
2155: 
2156:         CATCH TO loException
2157:             MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
2158:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
2159:                 loException.Message, "Erro")
2160:             loc_lResultado = .F.
2161:         ENDTRY
2162: 
2163:         RETURN loc_lResultado
2164:     ENDPROC
2165: 
2166:     *--------------------------------------------------------------------------
2167:     * FormParaBO - Transfere dados do formulario para o Business Object
2168:     * NOTA: Controles das abas internas serao adicionados em FASE 4
2169:     *--------------------------------------------------------------------------
2170:     PROTECTED PROCEDURE FormParaBO()
2171:         LOCAL loc_oBO, loc_oPag2
2172:         loc_oBO   = THIS.this_oBusinessObject
2173:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2174: 
2175:         *-- Identificacao (Page2 direto)
2176:         loc_oBO.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
2177:         loc_oBO.this_cDescrs  = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
2178:         loc_oBO.this_cInterno = ALLTRIM(loc_oPag2.txt_4c_Interno.Value)
2179:         loc_oBO.this_nTpCods  = loc_oPag2.opt_4c_TpCods.Value
2180:         loc_oBO.this_nTpEmps  = IIF(loc_oPag2.opt_4c_TpEmps.Visible, loc_oPag2.opt_4c_TpEmps.Value, 2)
2181:         loc_oBO.this_nTpCads  = loc_oPag2.opt_4c_TpCads.Value
2182:         loc_oBO.this_cDigito  = ALLTRIM(loc_oPag2.txt_4c_Digito.Value)
2183:         loc_oBO.this_cClasses = ALLTRIM(loc_oPag2.txt_4c_Classes.Value)
2184: 
2185:         *-- ChkLimCrds (CheckBox 1=checked -> this_nOptChkLimCr=1/Sim, 0=this_nOptChkLimCr=2/Nao)
2186:         loc_oBO.this_nOptChkLimCr  = IIF(loc_oPag2.chk_4c_LimCrds.Value = 1, 1, 2)
2187:         loc_oBO.this_nOptChkLimEst = IIF(loc_oPag2.chk_4c_LimEsts.Value = 1, 1, 2)
2188: 
2189:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2190:         loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
2191:         loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
2192:         loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
2193:         loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4
2194: 
2195:         *== ABA GERAL ===========================================================
2196:         loc_oBO.this_nOptComple    = loc_oG.opt_4c_OptComple.Value
2197:         loc_oBO.this_nOptPessoais  = loc_oG.opt_4c_OptPessoais.Value
2198:         loc_oBO.this_nOptRefBancs  = loc_oG.opt_4c_OptRefBancs.Value
2199:         loc_oBO.this_nOptFollowUp  = loc_oG.opt_4c_OptFollowUp.Value
2200:         loc_oBO.this_nOptFiscais   = loc_oG.opt_4c_OptFiscais.Value
2201:         loc_oBO.this_nOptDadosCom  = loc_oG.opt_4c_OptDadosCom.Value
2202:         loc_oBO.this_nOptRespos    = loc_oG.opt_4c_OptRespos.Value
2203:         loc_oBO.this_nOptLimCre    = loc_oG.opt_4c_OptLimCre.Value
2204:         loc_oBO.this_nOptComi      = loc_oG.opt_4c_OptComi.Value
2205:         loc_oBO.this_nOptEmpresa   = loc_oG.opt_4c_OptEmpresa.Value
2206:         loc_oBO.this_nOptContabs   = loc_oG.opt_4c_OptContabs.Value
2207:         loc_oBO.this_nOptCaract    = loc_oG.opt_4c_OptCaract.Value
2208:         loc_oBO.this_nOptPerfil    = loc_oG.opt_4c_OptPerfil.Value
2209:         loc_oBO.this_nOptCargos    = loc_oG.opt_4c_OptCargos.Value
2210:         loc_oBO.this_nOptChkLimCr  = loc_oG.opt_4c_OptChkLimCrG.Value

*-- Linhas 2332 a 2375:
2332:     * BOParaForm - Transfere dados do Business Object para o formulario
2333:     * NOTA: Controles das abas internas serao populados em FASE 4
2334:     *--------------------------------------------------------------------------
2335:     PROTECTED PROCEDURE BOParaForm()
2336:         LOCAL loc_oBO, loc_oPag2
2337:         loc_oBO   = THIS.this_oBusinessObject
2338:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2339: 
2340:         *-- Identificacao
2341:         loc_oPag2.txt_4c_Codigos.Value  = loc_oBO.this_cCodigos
2342:         loc_oPag2.txt_4c_Descrs.Value   = loc_oBO.this_cDescrs
2343:         loc_oPag2.txt_4c_Interno.Value  = loc_oBO.this_cInterno
2344:         loc_oPag2.opt_4c_TpCods.Value   = IIF(loc_oBO.this_nTpCods > 0, loc_oBO.this_nTpCods, 1)
2345:         loc_oPag2.txt_4c_Digito.Value   = loc_oBO.this_cDigito
2346:         loc_oPag2.txt_4c_Classes.Value  = loc_oBO.this_cClasses
2347:         loc_oPag2.txt_4c_DClasses.Value = loc_oBO.this_cDClasses
2348: 
2349:         *-- TpEmps / TpCads
2350:         loc_oPag2.opt_4c_TpEmps.Value = IIF(loc_oBO.this_nTpEmps > 0, loc_oBO.this_nTpEmps, 1)
2351:         loc_oPag2.opt_4c_TpCads.Value = IIF(loc_oBO.this_nTpCads > 0, loc_oBO.this_nTpCads, 1)
2352: 
2353:         *-- Visibilidade de Digito e TpEmps: controlada por TpCods=1
2354:         loc_oPag2.txt_4c_Digito.Visible    = (loc_oBO.this_nTpCods = 1)
2355:         loc_oPag2.lbl_4c_LblDigito.Visible = (loc_oBO.this_nTpCods = 1)
2356:         loc_oPag2.lbl_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2357:         loc_oPag2.opt_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2358:         loc_oPag2.opt_4c_TpEmps.Enabled    = (loc_oBO.this_nTpCods = 1)
2359: 
2360:         *-- ChkLimCrds/ChkLimEsts
2361:         loc_oPag2.chk_4c_LimCrds.Value = IIF(loc_oBO.this_nOptChkLimCr  = 1, 1, 0)
2362:         loc_oPag2.chk_4c_LimEsts.Value = IIF(loc_oBO.this_nOptChkLimEst = 1, 1, 0)
2363: 
2364:         *-- Sincronizar guardia
2365:         THIS.this_cUltClasses = ALLTRIM(loc_oBO.this_cClasses)
2366: 
2367:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2368:         loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
2369:         loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
2370:         loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
2371:         loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4
2372: 
2373:         *== ABA GERAL ===========================================================
2374:         loc_oG.opt_4c_OptComple.Value    = IIF(loc_oBO.this_nOptComple  > 0, loc_oBO.this_nOptComple,  2)
2375:         loc_oG.opt_4c_OptPessoais.Value  = IIF(loc_oBO.this_nOptPessoais > 0, loc_oBO.this_nOptPessoais, 2)

*-- Linhas 2524 a 2567:
2524:     *--------------------------------------------------------------------------
2525:     * LimparCampos - Limpa todos os campos do formulario
2526:     *--------------------------------------------------------------------------
2527:     PROTECTED PROCEDURE LimparCampos()
2528:         LOCAL loc_oPag2
2529:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2530: 
2531:         loc_oPag2.txt_4c_Codigos.Value  = ""
2532:         loc_oPag2.txt_4c_Descrs.Value   = ""
2533:         loc_oPag2.txt_4c_Interno.Value  = ""
2534:         loc_oPag2.opt_4c_TpCods.Value   = 1
2535:         loc_oPag2.opt_4c_TpEmps.Value   = 1
2536:         loc_oPag2.opt_4c_TpCads.Value   = 1
2537:         loc_oPag2.txt_4c_Digito.Value   = ""
2538:         loc_oPag2.txt_4c_Classes.Value  = ""
2539:         loc_oPag2.txt_4c_DClasses.Value = ""
2540:         loc_oPag2.chk_4c_LimCrds.Value  = 0
2541:         loc_oPag2.chk_4c_LimEsts.Value  = 0
2542: 
2543:         *-- Resetar visibilidade Digito e TpEmps (padrao TpCods=1 = Empresa)
2544:         loc_oPag2.txt_4c_Digito.Visible    = .T.
2545:         loc_oPag2.lbl_4c_LblDigito.Visible = .T.
2546:         loc_oPag2.lbl_4c_TpEmps.Visible    = .T.
2547:         loc_oPag2.opt_4c_TpEmps.Visible    = .T.
2548:         loc_oPag2.opt_4c_TpEmps.Enabled    = .T.
2549: 
2550:         THIS.this_cUltClasses = ""
2551: 
2552:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2553:         loc_oG = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2554:         loc_oC = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2555:         loc_oE = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
2556:         loc_oF = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4
2557: 
2558:         *== ABA GERAL ===========================================================
2559:         loc_oG.opt_4c_OptComple.Value    = 2
2560:         loc_oG.opt_4c_OptPessoais.Value  = 2
2561:         loc_oG.opt_4c_OptRefBancs.Value  = 2
2562:         loc_oG.opt_4c_OptFollowUp.Value  = 2
2563:         loc_oG.opt_4c_OptFiscais.Value   = 2
2564:         loc_oG.opt_4c_OptDadosCom.Value  = 2
2565:         loc_oG.opt_4c_OptRespos.Value    = 2
2566:         loc_oG.opt_4c_OptLimCre.Value    = 1
2567:         loc_oG.opt_4c_OptComi.Value      = 2

*-- Linhas 2710 a 3654:
2710:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
2711:     * par_nPagina: 1=Lista, 2=Dados
2712:     *--------------------------------------------------------------------------
2713:     PROCEDURE AlternarPagina(par_nPagina)
2714:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2715: 
2716:         IF par_nPagina = 1
2717:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .T.
2718:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .T.
2719:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .T.
2720:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .T.
2721:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .F.
2722:         ELSE
2723:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .F.
2724:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .F.
2725:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .F.
2726:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .F.
2727:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .T.
2728:         ENDIF
2729:     ENDPROC
2730: 
2731:     *--------------------------------------------------------------------------
2732:     * HabilitarCampos - Habilita/desabilita campos conforme modo
2733:     * NOTA: Completar em FASE 7 para controles das abas internas
2734:     *--------------------------------------------------------------------------
2735:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2736:         LOCAL loc_oPag2
2737:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2738: 
2739:         *-- Codigo: habilitado somente no modo INCLUIR
2740:         IF THIS.this_cModoAtual = "INCLUIR"
2741:             loc_oPag2.txt_4c_Codigos.Enabled = .T.
2742:         ELSE
2743:             loc_oPag2.txt_4c_Codigos.Enabled = .F.
2744:         ENDIF
2745: 
2746:         loc_oPag2.txt_4c_Descrs.Enabled   = par_lHabilitar
2747:         loc_oPag2.txt_4c_Interno.Enabled  = par_lHabilitar
2748:         loc_oPag2.opt_4c_TpCods.Enabled   = par_lHabilitar
2749:         loc_oPag2.txt_4c_Digito.Enabled   = par_lHabilitar
2750:         loc_oPag2.txt_4c_Classes.Enabled  = par_lHabilitar
2751:         loc_oPag2.chk_4c_LimCrds.Enabled = par_lHabilitar
2752:         loc_oPag2.chk_4c_LimEsts.Enabled = par_lHabilitar
2753:         loc_oPag2.opt_4c_TpEmps.Enabled  = par_lHabilitar
2754:         loc_oPag2.opt_4c_TpCads.Enabled  = par_lHabilitar
2755: 
2756:         *-- Abas internas: habilitar/desabilitar como grupo
2757:         loc_oPag2.pgf_4c_AbaDados.Enabled = par_lHabilitar
2758:     ENDPROC
2759: 
2760:     *==========================================================================
2761:     *-- HANDLERS: Botoes da lista
2762:     *==========================================================================
2763: 
2764:     *--------------------------------------------------------------------------
2765:     * BtnIncluirClick - Incluir novo registro
2766:     *--------------------------------------------------------------------------
2767:     PROCEDURE BtnIncluirClick()
2768:         THIS.this_oBusinessObject.NovoRegistro()
2769:         THIS.LimparCampos()
2770:         THIS.this_cModoAtual = "INCLUIR"
2771:         THIS.HabilitarCampos(.T.)
2772:         THIS.AlternarPagina(2)
2773:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
2774:     ENDPROC
2775: 
2776:     *--------------------------------------------------------------------------
2777:     * BtnVisualizarClick - Visualizar registro selecionado
2778:     *--------------------------------------------------------------------------
2779:     PROCEDURE BtnVisualizarClick()
2780:         LOCAL loc_cCodigo
2781: 
2782:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2783:             MsgAviso("Nenhum registro selecionado!")
2784:             RETURN
2785:         ENDIF
2786: 
2787:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2788: 
2789:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2790:             THIS.BOParaForm()
2791:             THIS.this_cModoAtual = "VISUALIZAR"
2792:             THIS.HabilitarCampos(.F.)
2793:             THIS.AlternarPagina(2)
2794:         ENDIF
2795:     ENDPROC
2796: 
2797:     *--------------------------------------------------------------------------
2798:     * BtnAlterarClick - Alterar registro selecionado
2799:     *--------------------------------------------------------------------------
2800:     PROCEDURE BtnAlterarClick()
2801:         LOCAL loc_cCodigo
2802: 
2803:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2804:             MsgAviso("Nenhum registro selecionado!")
2805:             RETURN
2806:         ENDIF
2807: 
2808:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2809: 
2810:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2811:             THIS.this_oBusinessObject.EditarRegistro()
2812:             THIS.BOParaForm()
2813:             THIS.this_cModoAtual = "ALTERAR"
2814:             THIS.HabilitarCampos(.T.)
2815:             THIS.AlternarPagina(2)
2816:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
2817:         ENDIF
2818:     ENDPROC
2819: 
2820:     *--------------------------------------------------------------------------
2821:     * BtnExcluirClick - Excluir registro selecionado
2822:     * Dependencias verificadas dentro de ccrBO.ExecutarExclusao (SigMvCcr/SigCdCli/SigMvCab)
2823:     *--------------------------------------------------------------------------
2824:     PROCEDURE BtnExcluirClick()
2825:         LOCAL loc_cCodigo
2826: 
2827:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2828:             MsgAviso("Nenhum registro selecionado!")
2829:             RETURN
2830:         ENDIF
2831: 
2832:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2833: 
2834:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2835:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + loc_cCodigo + "'?")
2836:                 IF THIS.this_oBusinessObject.Excluir()
2837:                     MsgSucesso("Grupo exclu" + CHR(237) + "do com sucesso!")
2838:                     THIS.CarregarLista()
2839:                 ENDIF
2840:             ENDIF
2841:         ENDIF
2842:     ENDPROC
2843: 
2844:     *--------------------------------------------------------------------------
2845:     * BtnBuscarClick - Busca por codigo via FormBuscaAuxiliar
2846:     *--------------------------------------------------------------------------
2847:     PROCEDURE BtnBuscarClick()
2848:         LOCAL loc_oBusca, loc_cCodigo
2849: 
2850:         TRY
2851:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2852:                 "SigCdGcr", "cursor_4c_Busca", "Codigos", "", ;
2853:                 "Buscar Grupo CCR")
2854: 
2855:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2856:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2857:             loc_oBusca.mAddColuna("Internos","", "Interno")
2858: 
2859:             loc_oBusca.Show()
2860: 
2861:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2862:                 loc_cCodigo = ALLTRIM(cursor_4c_Busca.Codigos)
2863: 
2864:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2865:                     THIS.BOParaForm()
2866:                     THIS.this_cModoAtual = "VISUALIZAR"
2867:                     THIS.HabilitarCampos(.F.)
2868:                     THIS.AlternarPagina(2)
2869:                 ENDIF
2870:             ENDIF
2871: 
2872:             IF USED("cursor_4c_Busca")
2873:                 USE IN cursor_4c_Busca
2874:             ENDIF
2875:             loc_oBusca.Release()
2876: 
2877:         CATCH TO loException
2878:             MostrarErro("Erro ao buscar:" + CHR(13) + ;
2879:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
2880:                 loException.Message, "Erro")
2881:         ENDTRY
2882:     ENDPROC
2883: 
2884:     *--------------------------------------------------------------------------
2885:     * BtnEncerrarClick - Fechar o formulario
2886:     *--------------------------------------------------------------------------
2887:     PROCEDURE BtnEncerrarClick()
2888:         THIS.Release()
2889:     ENDPROC
2890: 
2891:     *==========================================================================
2892:     *-- HANDLERS: Botoes da pagina de dados
2893:     *==========================================================================
2894: 
2895:     *--------------------------------------------------------------------------
2896:     * BtnSalvarClick - Salvar registro (validacao pelo BO)
2897:     *--------------------------------------------------------------------------
2898:     PROCEDURE BtnSalvarClick()
2899:         THIS.FormParaBO()
2900: 
2901:         IF THIS.this_oBusinessObject.Salvar()
2902:             MsgSucesso("Registro salvo com sucesso!")
2903:             THIS.AlternarPagina(1)
2904:             THIS.CarregarLista()
2905:         ENDIF
2906:     ENDPROC
2907: 
2908:     *--------------------------------------------------------------------------
2909:     * BtnCancelarClick - Cancelar edicao e voltar para lista
2910:     *--------------------------------------------------------------------------
2911:     PROCEDURE BtnCancelarClick()
2912:         THIS.AlternarPagina(1)
2913:         THIS.this_cModoAtual = "LISTA"
2914:         THIS.CarregarLista()
2915:     ENDPROC
2916: 
2917:     *==========================================================================
2918:     *-- EVENTOS: TpCods
2919:     *==========================================================================
2920: 
2921:     *--------------------------------------------------------------------------
2922:     * opt_4c_TpCods_InteractiveChange - Controla visibilidade de Digito
2923:     * Legado: .Get_Digito.Visible = (CrSigCdGcr.TpCods = 1)
2924:     *--------------------------------------------------------------------------
2925:     PROCEDURE opt_4c_TpCods_InteractiveChange()
2926:         LOCAL loc_lEmpresa
2927:         loc_lEmpresa = (THIS.pgf_4c_Paginas.Page2.opt_4c_TpCods.Value = 1)
2928: 
2929:         THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Visible    = loc_lEmpresa
2930:         THIS.pgf_4c_Paginas.Page2.lbl_4c_LblDigito.Visible = loc_lEmpresa
2931: 
2932:         IF !loc_lEmpresa
2933:             THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Value = ""
2934:             THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Value = 2
2935:         ENDIF
2936:         THIS.pgf_4c_Paginas.Page2.lbl_4c_TpEmps.Visible = loc_lEmpresa
2937:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Visible = loc_lEmpresa
2938:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Enabled = loc_lEmpresa
2939:     ENDPROC
2940: 
2941:     *==========================================================================
2942:     *-- LOOKUPS: Classes (SigCdCss)
2943:     *==========================================================================
2944: 
2945:     *--------------------------------------------------------------------------
2946:     * txt_4c_Classes_KeyPress - F4 abre lookup de classes
2947:     *--------------------------------------------------------------------------
2948:     PROCEDURE txt_4c_Classes_KeyPress
2949:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2950:         IF par_nKeyCode = 115  && F4
2951:             THIS.AbrirLookupClasses()
2952:         ENDIF
2953:     ENDPROC
2954: 
2955:     *--------------------------------------------------------------------------
2956:     * txt_4c_Classes_LostFocus - Valida classe digitada
2957:     *--------------------------------------------------------------------------
2958:     PROCEDURE txt_4c_Classes_LostFocus()
2959:         LOCAL loc_cClasses
2960:         loc_cClasses = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)
2961: 
2962:         IF loc_cClasses = THIS.this_cUltClasses
2963:             RETURN
2964:         ENDIF
2965: 
2966:         IF EMPTY(loc_cClasses)
2967:             THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ""
2968:             THIS.this_cUltClasses = ""
2969:             RETURN
2970:         ENDIF
2971: 
2972:         THIS.ValidarClasses(loc_cClasses)
2973:     ENDPROC
2974: 
2975:     *--------------------------------------------------------------------------
2976:     * AbrirLookupClasses - Abre FormBuscaAuxiliar para SigCdCss
2977:     * Legado: fwBuscaExt em SigCdCss, campoCodigo='classes'
2978:     *--------------------------------------------------------------------------
2979:     PROTECTED PROCEDURE AbrirLookupClasses()
2980:         LOCAL loc_oBusca, loc_cValor
2981: 
2982:         TRY
2983:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)
2984: 
2985:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2986:                 "SigCdCss", "cursor_4c_Css", "Classes", loc_cValor, ;
2987:                 "Sele" + CHR(231) + CHR(227) + "o de Classe")
2988:             loc_oBusca.mAddColuna("Classes", "", "Classe")
2989:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2990:             loc_oBusca.Show()
2991: 
2992:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Css")
2993:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value  = ALLTRIM(cursor_4c_Css.Classes)
2994:                 THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ALLTRIM(cursor_4c_Css.Descrs)
2995:                 THIS.this_cUltClasses = ALLTRIM(cursor_4c_Css.Classes)
2996:             ENDIF
2997: 
2998:             IF USED("cursor_4c_Css")
2999:                 USE IN cursor_4c_Css
3000:             ENDIF
3001:             loc_oBusca.Release()
3002: 
3003:         CATCH TO loException
3004:             MostrarErro("Erro no lookup de classes:" + CHR(13) + ;
3005:                 loException.Message, "Erro")
3006:         ENDTRY
3007:     ENDPROC
3008: 
3009:     *--------------------------------------------------------------------------
3010:     * ValidarClasses - Verifica classe digitada em SigCdCss (LostFocus)
3011:     *--------------------------------------------------------------------------
3012:     PROTECTED PROCEDURE ValidarClasses(par_cClasses)
3013:         LOCAL loc_cSQL, loc_nRes
3014: 
3015:         TRY
3016:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
3017:                 SELECT Classes, Descrs FROM SigCdCss
3018:                 WHERE Classes = <<EscaparSQL(par_cClasses)>>
3019:             ENDTEXT
3020: 
3021:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")
3022: 
3023:             IF loc_nRes >= 0
3024:                 IF RECCOUNT("cursor_4c_CssVerif") > 0
3025:                     THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
3026:                         ALLTRIM(cursor_4c_CssVerif.Descrs)
3027:                     THIS.this_cUltClasses = par_cClasses
3028:                 ELSE
3029:                     *-- Codigo nao encontrado: abrir lookup
3030:                     THIS.AbrirLookupClasses()
3031:                 ENDIF
3032: 
3033:                 IF USED("cursor_4c_CssVerif")
3034:                     USE IN cursor_4c_CssVerif
3035:                 ENDIF
3036:             ENDIF
3037: 
3038:         CATCH TO loException
3039:             MostrarErro("Erro ao validar classe:" + CHR(13) + ;
3040:                 loException.Message, "Erro")
3041:         ENDTRY
3042:     ENDPROC
3043: 
3044:     *==========================================================================
3045:     *-- UTILIDADES
3046:     *==========================================================================
3047: 
3048:     *--------------------------------------------------------------------------
3049:     * FormatarGridLista - Formata visual do grid da lista
3050:     *--------------------------------------------------------------------------
3051:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
3052:         WITH par_oGrid
3053:             IF .ColumnCount > 0
3054:                 .FontName = "Tahoma"
3055:                 .FontSize = 8
3056:             ENDIF
3057:         ENDWITH
3058:     ENDPROC
3059: 
3060:     *--------------------------------------------------------------------------
3061:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
3062:     *--------------------------------------------------------------------------
3063:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3064:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cBase
3065: 
3066:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3067:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3068: 
3069:             IF VARTYPE(loc_oObjeto) = "O"
3070:                 loc_cBase = UPPER(loc_oObjeto.BaseClass)
3071: 
3072:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3073:                     *-- Containers ocultos intencionalmente (Visible=.F.) nao devem
3074:                     *-- ser forcados a Visible=.T. - preservar estado definido no setup
3075:                     IF NOT INLIST(loc_cBase, "CONTAINER") OR loc_oObjeto.Visible
3076:                         loc_oObjeto.Visible = .T.
3077:                     ENDIF
3078:                 ENDIF
3079: 
3080:                 IF loc_cBase = "PAGEFRAME"
3081:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3082:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3083:                     ENDFOR
3084:                 ENDIF
3085: 
3086:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3087:                     *-- Nao recursar dentro de containers ocultos
3088:                     IF NOT INLIST(loc_cBase, "CONTAINER") OR loc_oObjeto.Visible
3089:                         THIS.TornarControlesVisiveis(loc_oObjeto)
3090:                     ENDIF
3091:                 ENDIF
3092:             ENDIF
3093:         ENDFOR
3094:     ENDPROC
3095: 
3096:     *==========================================================================
3097:     *-- LOOKUPS: SigCdGcr - Metodos genericos compartilhados
3098:     *==========================================================================
3099: 
3100:     *--------------------------------------------------------------------------
3101:     * AbrirLookupGcr - Abre FormBuscaAuxiliar para SigCdGcr (generico)
3102:     * par_oTxt: TextBox do codigo | par_oTxtDesc: TextBox desc (ou .NULL.)
3103:     *--------------------------------------------------------------------------
3104:     PROTECTED PROCEDURE AbrirLookupGcr(par_oTxt, par_oTxtDesc)
3105:         LOCAL loc_oBusca
3106:         TRY
3107:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3108:                 "SigCdGcr", "cursor_4c_GcrLkp", "Codigos", ;
3109:                 ALLTRIM(par_oTxt.Value), ;
3110:                 "Selecionar Grupo C/C")
3111:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3112:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3113:             loc_oBusca.Show()
3114:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcrLkp")
3115:                 par_oTxt.Value = ALLTRIM(cursor_4c_GcrLkp.Codigos)
3116:                 IF VARTYPE(par_oTxtDesc) = "O"
3117:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrLkp.Descrs)
3118:                 ENDIF
3119:             ENDIF
3120:             IF USED("cursor_4c_GcrLkp")
3121:                 USE IN cursor_4c_GcrLkp
3122:             ENDIF
3123:             loc_oBusca.Release()
3124:         CATCH TO loException
3125:             MostrarErro("Erro no lookup Grupo C/C:" + CHR(13) + loException.Message, "Erro")
3126:         ENDTRY
3127:     ENDPROC
3128: 
3129:     *--------------------------------------------------------------------------
3130:     * ValidarGcr - Verifica codigo SigCdGcr (generico); abre lookup se n/a
3131:     *--------------------------------------------------------------------------
3132:     PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
3133:         LOCAL loc_nRes
3134:         TRY
3135:             loc_nRes = SQLEXEC(gnConnHandle, ;
3136:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
3137:                 "cursor_4c_GcrVerif")
3138:             IF loc_nRes >= 0
3139:                 IF RECCOUNT("cursor_4c_GcrVerif") > 0
3140:                     IF VARTYPE(par_oTxtDesc) = "O"
3141:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
3142:                     ENDIF
3143:                 ELSE
3144:                     THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
3145:                 ENDIF
3146:                 IF USED("cursor_4c_GcrVerif")
3147:                     USE IN cursor_4c_GcrVerif
3148:                 ENDIF
3149:             ENDIF
3150:         CATCH TO loException
3151:             MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")
3152:         ENDTRY
3153:     ENDPROC
3154: 
3155:     *==========================================================================
3156:     *-- LOOKUPS: GrupoGeral (Aba Geral)
3157:     *==========================================================================
3158: 
3159:     PROCEDURE txt_4c_GrupoGeral_KeyPress
3160:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3161:         IF par_nKeyCode = 115
3162:             THIS.AbrirLookupGrupoGeral()
3163:         ENDIF
3164:     ENDPROC
3165: 
3166:     PROCEDURE txt_4c_GrupoGeral_LostFocus()
3167:         LOCAL loc_cVal, loc_oAba
3168:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3169:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
3170:         IF loc_cVal = THIS.this_cUltGrupoGeral
3171:             RETURN
3172:         ENDIF
3173:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3174:             THIS.this_cUltGrupoGeral = ""
3175:             RETURN
3176:         ENDIF
3177:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoGeral, .NULL.)
3178:         THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
3179:     ENDPROC
3180: 
3181:     PROTECTED PROCEDURE AbrirLookupGrupoGeral()
3182:         LOCAL loc_oAba
3183:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3184:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoGeral, .NULL.)
3185:         THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
3186:     ENDPROC
3187: 
3188:     *==========================================================================
3189:     *-- LOOKUPS: CdMoeda (Aba Geral / SigCdMoe)
3190:     *==========================================================================
3191: 
3192:     PROCEDURE txt_4c_CdMoeda_KeyPress
3193:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3194:         IF par_nKeyCode = 115
3195:             THIS.AbrirLookupMoeda()
3196:         ENDIF
3197:     ENDPROC
3198: 
3199:     PROCEDURE txt_4c_CdMoeda_LostFocus()
3200:         LOCAL loc_cVal, loc_oAba
3201:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3202:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value)
3203:         IF loc_cVal = THIS.this_cUltCdMoeda
3204:             RETURN
3205:         ENDIF
3206:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3207:             loc_oAba.txt_4c_DsMoeda.Value = ""
3208:             THIS.this_cUltCdMoeda = ""
3209:             RETURN
3210:         ENDIF
3211:         THIS.ValidarMoeda(loc_cVal)
3212:     ENDPROC
3213: 
3214:     PROTECTED PROCEDURE AbrirLookupMoeda()
3215:         LOCAL loc_oBusca, loc_oAba
3216:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3217:         TRY
3218:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3219:                 "SigCdMoe", "cursor_4c_MoeLkp", "cmoes", ;
3220:                 ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value), ;
3221:                 "Selecionar Moeda")
3222:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3223:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3224:             loc_oBusca.Show()
3225:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeLkp")
3226:                 loc_oAba.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.cmoes)
3227:                 loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.dmoes)
3228:                 THIS.this_cUltCdMoeda = ALLTRIM(cursor_4c_MoeLkp.cmoes)
3229:             ENDIF
3230:             IF USED("cursor_4c_MoeLkp")
3231:                 USE IN cursor_4c_MoeLkp
3232:             ENDIF
3233:             loc_oBusca.Release()
3234:         CATCH TO loException
3235:             MostrarErro("Erro no lookup de Moeda:" + CHR(13) + loException.Message, "Erro")
3236:         ENDTRY
3237:     ENDPROC
3238: 
3239:     PROTECTED PROCEDURE ValidarMoeda(par_cCodigo)
3240:         LOCAL loc_nRes, loc_oAba
3241:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3242:         TRY
3243:             loc_nRes = SQLEXEC(gnConnHandle, ;
3244:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
3245:                 "cursor_4c_MoeVerif")
3246:             IF loc_nRes >= 0
3247:                 IF RECCOUNT("cursor_4c_MoeVerif") > 0
3248:                     loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
3249:                     THIS.this_cUltCdMoeda = par_cCodigo
3250:                 ELSE
3251:                     THIS.AbrirLookupMoeda()
3252:                 ENDIF
3253:                 IF USED("cursor_4c_MoeVerif")
3254:                     USE IN cursor_4c_MoeVerif
3255:                 ENDIF
3256:             ENDIF
3257:         CATCH TO loException
3258:             MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
3259:         ENDTRY
3260:     ENDPROC
3261: 
3262:     *==========================================================================
3263:     *-- LOOKUPS: Situas (Aba Cadastro / SigCdCst)
3264:     *==========================================================================
3265: 
3266:     PROCEDURE txt_4c_Situas_KeyPress
3267:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3268:         IF par_nKeyCode = 115
3269:             THIS.AbrirLookupSituas()
3270:         ENDIF
3271:     ENDPROC
3272: 
3273:     PROCEDURE txt_4c_Situas_LostFocus()
3274:         LOCAL loc_cVal, loc_oAba
3275:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3276:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_Situas.Value)
3277:         IF loc_cVal = THIS.this_cUltSituas
3278:             RETURN
3279:         ENDIF
3280:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3281:             THIS.this_cUltSituas = ""
3282:             RETURN
3283:         ENDIF
3284:         THIS.ValidarSituas(loc_cVal)
3285:     ENDPROC
3286: 
3287:     PROTECTED PROCEDURE AbrirLookupSituas()
3288:         LOCAL loc_oBusca, loc_oAba
3289:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3290:         TRY
3291:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3292:                 "SigCdCst", "cursor_4c_CstLkp", "codigos", ;
3293:                 ALLTRIM(loc_oAba.txt_4c_Situas.Value), ;
3294:                 "Selecionar Situa" + CHR(231) + CHR(227) + "o")
3295:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3296:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3297:             loc_oBusca.Show()
3298:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CstLkp")
3299:                 loc_oAba.txt_4c_Situas.Value = ALLTRIM(cursor_4c_CstLkp.codigos)
3300:                 THIS.this_cUltSituas = ALLTRIM(cursor_4c_CstLkp.codigos)
3301:             ENDIF
3302:             IF USED("cursor_4c_CstLkp")
3303:                 USE IN cursor_4c_CstLkp
3304:             ENDIF
3305:             loc_oBusca.Release()
3306:         CATCH TO loException
3307:             MostrarErro("Erro no lookup de Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
3308:         ENDTRY
3309:     ENDPROC
3310: 
3311:     PROTECTED PROCEDURE ValidarSituas(par_cCodigo)
3312:         LOCAL loc_nRes, loc_oAba
3313:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3314:         TRY
3315:             loc_nRes = SQLEXEC(gnConnHandle, ;
3316:                 "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
3317:                 "cursor_4c_CstVerif")
3318:             IF loc_nRes >= 0
3319:                 IF RECCOUNT("cursor_4c_CstVerif") > 0
3320:                     THIS.this_cUltSituas = par_cCodigo
3321:                 ELSE
3322:                     THIS.AbrirLookupSituas()
3323:                 ENDIF
3324:                 IF USED("cursor_4c_CstVerif")
3325:                     USE IN cursor_4c_CstVerif
3326:                 ENDIF
3327:             ENDIF
3328:         CATCH TO loException
3329:             MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
3330:         ENDTRY
3331:     ENDPROC
3332: 
3333:     *==========================================================================
3334:     *-- LOOKUPS: Contint (Aba Cadastro)
3335:     *==========================================================================
3336: 
3337:     PROCEDURE txt_4c_Contint_KeyPress
3338:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3339:         IF par_nKeyCode = 115
3340:             THIS.AbrirLookupContint()
3341:         ENDIF
3342:     ENDPROC
3343: 
3344:     PROCEDURE txt_4c_Contint_LostFocus()
3345:         LOCAL loc_cVal, loc_oAba
3346:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3347:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3348:         IF loc_cVal = THIS.this_cUltContint
3349:             RETURN
3350:         ENDIF
3351:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3352:             THIS.this_cUltContint = ""
3353:             RETURN
3354:         ENDIF
3355:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_Contint, .NULL.)
3356:         THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3357:     ENDPROC
3358: 
3359:     PROTECTED PROCEDURE AbrirLookupContint()
3360:         LOCAL loc_oAba
3361:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3362:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_Contint, .NULL.)
3363:         THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3364:     ENDPROC
3365: 
3366:     *==========================================================================
3367:     *-- LOOKUPS: GrupoEst (Aba Estoque)
3368:     *==========================================================================
3369: 
3370:     PROCEDURE txt_4c_GrupoEst_KeyPress
3371:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3372:         IF par_nKeyCode = 115
3373:             THIS.AbrirLookupGrupoEst()
3374:         ENDIF
3375:     ENDPROC
3376: 
3377:     PROCEDURE txt_4c_GrupoEst_LostFocus()
3378:         LOCAL loc_cVal, loc_oAba
3379:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3380:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3381:         IF loc_cVal = THIS.this_cUltGrupoEst
3382:             RETURN
3383:         ENDIF
3384:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3385:             THIS.this_cUltGrupoEst = ""
3386:             RETURN
3387:         ENDIF
3388:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoEst, .NULL.)
3389:         THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3390:     ENDPROC
3391: 
3392:     PROTECTED PROCEDURE AbrirLookupGrupoEst()
3393:         LOCAL loc_oAba
3394:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3395:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoEst, .NULL.)
3396:         THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3397:     ENDPROC
3398: 
3399:     *==========================================================================
3400:     *-- LOOKUPS: GrupoFalha (Aba Estoque)
3401:     *==========================================================================
3402: 
3403:     PROCEDURE txt_4c_GrupoFalha_KeyPress
3404:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3405:         IF par_nKeyCode = 115
3406:             THIS.AbrirLookupGrupoFalha()
3407:         ENDIF
3408:     ENDPROC
3409: 
3410:     PROCEDURE txt_4c_GrupoFalha_LostFocus()
3411:         LOCAL loc_cVal, loc_oAba
3412:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3413:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3414:         IF loc_cVal = THIS.this_cUltGrupoFalha
3415:             RETURN
3416:         ENDIF
3417:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3418:             THIS.this_cUltGrupoFalha = ""
3419:             RETURN
3420:         ENDIF
3421:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoFalha, .NULL.)
3422:         THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3423:     ENDPROC
3424: 
3425:     PROTECTED PROCEDURE AbrirLookupGrupoFalha()
3426:         LOCAL loc_oAba
3427:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3428:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoFalha, .NULL.)
3429:         THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3430:     ENDPROC
3431: 
3432:     *==========================================================================
3433:     *-- LOOKUPS: ContaFalha (Aba Estoque -> com DsContaFalha)
3434:     *==========================================================================
3435: 
3436:     PROCEDURE txt_4c_ContaFalha_KeyPress
3437:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3438:         IF par_nKeyCode = 115
3439:             THIS.AbrirLookupContaFalha()
3440:         ENDIF
3441:     ENDPROC
3442: 
3443:     PROCEDURE txt_4c_ContaFalha_LostFocus()
3444:         LOCAL loc_cVal, loc_oAba
3445:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3446:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3447:         IF loc_cVal = THIS.this_cUltContaFalha
3448:             RETURN
3449:         ENDIF
3450:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3451:             loc_oAba.txt_4c_DsContaFalha.Value = ""
3452:             THIS.this_cUltContaFalha = ""
3453:             RETURN
3454:         ENDIF
3455:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
3456:         THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3457:     ENDPROC
3458: 
3459:     PROTECTED PROCEDURE AbrirLookupContaFalha()
3460:         LOCAL loc_oAba
3461:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3462:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
3463:         THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3464:     ENDPROC
3465: 
3466:     *==========================================================================
3467:     *-- LOOKUPS: ContaPdr (Aba Estoque -> com DsContaPdr)
3468:     *==========================================================================
3469: 
3470:     PROCEDURE txt_4c_ContaPdr_KeyPress
3471:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3472:         IF par_nKeyCode = 115
3473:             THIS.AbrirLookupContaPdr()
3474:         ENDIF
3475:     ENDPROC
3476: 
3477:     PROCEDURE txt_4c_ContaPdr_LostFocus()
3478:         LOCAL loc_cVal, loc_oAba
3479:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3480:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3481:         IF loc_cVal = THIS.this_cUltContaPdr
3482:             RETURN
3483:         ENDIF
3484:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3485:             loc_oAba.txt_4c_DsContaPdr.Value = ""
3486:             THIS.this_cUltContaPdr = ""
3487:             RETURN
3488:         ENDIF
3489:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
3490:         THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3491:     ENDPROC
3492: 
3493:     PROTECTED PROCEDURE AbrirLookupContaPdr()
3494:         LOCAL loc_oAba
3495:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3496:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
3497:         THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3498:     ENDPROC
3499: 
3500:     *==========================================================================
3501:     *-- LOOKUPS: Containers Fiscais (CdGrupos + CdContas via F4 + LostFocus)
3502:     *-- GotFocus rastreia container ativo em this_oFiscalCntAtivo
3503:     *-- LostFocus usa this_oFiscalCntAtivo para saber qual container processar
3504:     *==========================================================================
3505: 
3506:     *--------------------------------------------------------------------------
3507:     * FiscalGotFocus - Rastreia container fiscal ativo quando campo ganha foco
3508:     *--------------------------------------------------------------------------
3509:     PROCEDURE FiscalGotFocus()
3510:         LOCAL loc_oCtrl
3511:         loc_oCtrl = _VFP.ActiveControl
3512:         IF VARTYPE(loc_oCtrl) = "O"
3513:             THIS.this_oFiscalCntAtivo = loc_oCtrl.Parent
3514:         ENDIF
3515:     ENDPROC
3516: 
3517:     *--------------------------------------------------------------------------
3518:     * FiscalCdGruposKeyPress - Abre lookup F4 para campo CdGrupos fiscal
3519:     *--------------------------------------------------------------------------
3520:     PROCEDURE FiscalCdGruposKeyPress
3521:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3522:         IF par_nKeyCode = 115  && F4
3523:             LOCAL loc_oCtrl
3524:             loc_oCtrl = _VFP.ActiveControl
3525:             IF VARTYPE(loc_oCtrl) = "O"
3526:                 THIS.AbrirLookupFiscalGrupos(loc_oCtrl.Parent)
3527:             ENDIF
3528:         ENDIF
3529:     ENDPROC
3530: 
3531:     *--------------------------------------------------------------------------
3532:     * FiscalCdGruposLostFocus - Valida CdGrupos; limpa campos subordinados se vazio
3533:     * Legado: getCdGrupos.Valid - fAcessoContab / limpa getCdContas..Receitas
3534:     *--------------------------------------------------------------------------
3535:     PROCEDURE FiscalCdGruposLostFocus()
3536:         LOCAL loc_oCnt, loc_cVal
3537:         loc_oCnt = THIS.this_oFiscalCntAtivo
3538:         IF VARTYPE(loc_oCnt) # "O"
3539:             RETURN
3540:         ENDIF
3541:         IF gb_4c_ValidandoUI
3542:             RETURN
3543:         ENDIF
3544:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdGrupos.Value)
3545:         IF EMPTY(loc_cVal)
3546:             *-- Limpar campos subordinados ao grupo quando CdGrupos e' esvaziado
3547:             loc_oCnt.txt_4c_CdContas.Value = ""
3548:             loc_oCnt.txt_4c_DsContas.Value = ""
3549:             loc_oCnt.txt_4c_PctAliqs.Value = 0
3550:             loc_oCnt.txt_4c_Receitas.Value = ""
3551:         ELSE
3552:             THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdGrupos, .NULL.)
3553:         ENDIF
3554:         THIS.AtualizarEstadoFiscal(loc_oCnt)
3555:     ENDPROC
3556: 
3557:     *--------------------------------------------------------------------------
3558:     * FiscalCdContasKeyPress - Abre lookup F4 para campo CdContas fiscal
3559:     *--------------------------------------------------------------------------
3560:     PROCEDURE FiscalCdContasKeyPress
3561:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3562:         IF par_nKeyCode = 115  && F4
3563:             LOCAL loc_oCtrl
3564:             loc_oCtrl = _VFP.ActiveControl
3565:             IF VARTYPE(loc_oCtrl) = "O"
3566:                 THIS.AbrirLookupFiscalContas(loc_oCtrl.Parent)
3567:             ENDIF
3568:         ENDIF
3569:     ENDPROC
3570: 
3571:     *--------------------------------------------------------------------------
3572:     * FiscalCdContasLostFocus - Valida CdContas; preenche DsContas
3573:     * Legado: getCdContas.Valid - fAcessoContas(grupoX, [C], valor, DsContas)
3574:     *--------------------------------------------------------------------------
3575:     PROCEDURE FiscalCdContasLostFocus()
3576:         LOCAL loc_oCnt, loc_cVal
3577:         loc_oCnt = THIS.this_oFiscalCntAtivo
3578:         IF VARTYPE(loc_oCnt) # "O"
3579:             RETURN
3580:         ENDIF
3581:         IF gb_4c_ValidandoUI
3582:             RETURN
3583:         ENDIF
3584:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdContas.Value)
3585:         IF EMPTY(loc_cVal)
3586:             loc_oCnt.txt_4c_DsContas.Value = ""
3587:         ELSE
3588:             THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdContas, loc_oCnt.txt_4c_DsContas)
3589:         ENDIF
3590:         THIS.AtualizarEstadoFiscal(loc_oCnt)
3591:     ENDPROC
3592: 
3593:     *--------------------------------------------------------------------------
3594:     * AbrirLookupFiscalGrupos - Abre lookup para campo CdGrupos do container
3595:     *--------------------------------------------------------------------------
3596:     PROTECTED PROCEDURE AbrirLookupFiscalGrupos(par_oCnt)
3597:         THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdGrupos, .NULL.)
3598:         THIS.AtualizarEstadoFiscal(par_oCnt)
3599:     ENDPROC
3600: 
3601:     *--------------------------------------------------------------------------
3602:     * AbrirLookupFiscalContas - Abre lookup para campo CdContas do container
3603:     *--------------------------------------------------------------------------
3604:     PROTECTED PROCEDURE AbrirLookupFiscalContas(par_oCnt)
3605:         THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdContas, par_oCnt.txt_4c_DsContas)
3606:         THIS.AtualizarEstadoFiscal(par_oCnt)
3607:     ENDPROC
3608: 
3609:     *--------------------------------------------------------------------------
3610:     * AtualizarEstadoFiscal - Atualiza Enabled dos campos condicionais no container
3611:     * Legado: When() expressions de getCdContas/getDsContas/getPctAliqs/getReceitas
3612:     * Apenas no modo INCLUIR/ALTERAR; VISUALIZAR: todos desabilitados (via pgf_4c_AbaDados.Enabled)
3613:     *--------------------------------------------------------------------------
3614:     PROTECTED PROCEDURE AtualizarEstadoFiscal(par_oCnt)
3615:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3616:             LOCAL loc_lTemGrupo, loc_lTemConta, loc_lTemPct
3617:             loc_lTemGrupo = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdGrupos.Value))
3618:             loc_lTemConta = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdContas.Value))
3619:             loc_lTemPct   = (par_oCnt.txt_4c_PctAliqs.Value # 0)
3620: 
3621:             par_oCnt.txt_4c_CdContas.Enabled = loc_lTemGrupo
3622:             par_oCnt.txt_4c_DsContas.Enabled = loc_lTemGrupo AND !loc_lTemConta
3623:             par_oCnt.txt_4c_PctAliqs.Enabled = loc_lTemGrupo AND loc_lTemConta
3624:             par_oCnt.txt_4c_Receitas.Enabled = loc_lTemGrupo AND loc_lTemConta AND loc_lTemPct
3625:         ENDIF
3626:     ENDPROC
3627: 
3628:     *--------------------------------------------------------------------------
3629:     * AtualizarEstadoFiscalTodos - Chama AtualizarEstadoFiscal para os 9 containers
3630:     * par_oF: referencia para Page4 (aba Faturamento)
3631:     *--------------------------------------------------------------------------
3632:     PROTECTED PROCEDURE AtualizarEstadoFiscalTodos(par_oF)
3633:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ICMS)
3634:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IPI)
3635:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_II)
3636:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ISS)
3637:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IRRF)
3638:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_INSS)
3639:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_PIS)
3640:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_CSL)
3641:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_COF)
3642:     ENDPROC
3643: 
3644:     *--------------------------------------------------------------------------
3645:     * Destroy - Limpeza ao fechar o formulario
3646:     *--------------------------------------------------------------------------
3647:     PROCEDURE Destroy()
3648:         IF !ISNULL(THIS.this_oBusinessObject)
3649:             THIS.this_oBusinessObject = .NULL.
3650:         ENDIF
3651:         DODEFAULT()
3652:     ENDPROC
3653: 
3654: ENDDEFINE


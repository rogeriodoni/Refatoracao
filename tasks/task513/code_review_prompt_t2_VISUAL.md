# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDROP.Pagina.Dados): Top original=329 vs migrado 'lbl_4c_Say6' Top=360 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_gde_grupo' (parent: SIGCDROP.Pagina.Dados): Top original=204 vs migrado 'lbl_4c_Lbl_gde_grupo' Top=235 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDROP.Pagina.Dados): Top original=230 vs migrado 'lbl_4c_Say4' Top=261 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupo' (parent: SIGCDROP.Pagina.Dados): Top original=154 vs migrado 'lbl_4c_Lbl_grupo' Top=185 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say34' (parent: SIGCDROP.Pagina.Dados): Top original=255 vs migrado 'lbl_4c_Say34' Top=286 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDROP.Pagina.Dados): Top original=279 vs migrado 'lbl_4c_Say3' Top=310 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Exclusivo' (parent: SIGCDROP.Pagina.Dados): Top original=325 vs migrado 'obj_4c_Opt_Exclusivo' Top=356 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say42' (parent: SIGCDROP.Pagina.Dados): Top original=304 vs migrado 'lbl_4c_Say42' Top=335 (diff=31px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1961 linhas total):

*-- Linhas 5 a 13:
5: * Tabela: SigCdRpo
6: * Herda de: FormBase
7: *
8: * PageFrame.Top = -31 (compensação +31 em todos os controles)
9: *==============================================================================
10: 
11: DEFINE CLASS FormRop AS FormBase
12: 
13:     *-- Propriedades visuais (PILAR 1 - UX Fidelity)

*-- Linhas 49 a 66:
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.Caption = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
53: 
54:             THIS.this_oBusinessObject = CREATEOBJECT("RopBO")
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Erro ao criar RopBO.", "FormRop.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59: 
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62: 
63:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
64:                     THIS.CarregarLista()
65:                 ENDIF
66: 

*-- Linhas 78 a 106:
78: 
79:     *==========================================================================
80:     * ConfigurarPageFrame - Cria PageFrame com 2 páginas (Lista e Dados)
81:     * Compensação: PageFrame.Top = -31, todos os controles precisam +31 no Top
82:     *==========================================================================
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85:         THIS.pgf_4c_Paginas.PageCount = 2
86:         WITH THIS.pgf_4c_Paginas
87:             .Top    = -31
88:             .Left   = -2
89:             .Width  = THIS.Width + 4
90:             .Height = 631
91:             .Tabs   = .F.
92:             .Visible = .T.
93:         ENDWITH
94: 
95:         WITH THIS.pgf_4c_Paginas.Page1
96:             .Caption = "Lista"
97:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
98:         ENDWITH
99: 
100:         WITH THIS.pgf_4c_Paginas.Page2
101:             .Caption = "Dados"
102:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()

*-- Linhas 119 a 153:
119:         *-- Container cabeçalho com título
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 32
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
133:             .Top      = 15
134:             .Left     = 10
135:             .Width    = THIS.Width - 20
136:             .Height   = 46
137:             .FontName = "Tahoma"
138:             .FontSize = 16
139:             .FontBold = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Visible  = .T.
143:         ENDWITH
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
147:             .Top      = 18
148:             .Left     = 10
149:             .Width    = THIS.Width - 20
150:             .Height   = 46
151:             .FontName = "Tahoma"
152:             .FontSize = 16
153:             .FontBold = .T.

*-- Linhas 159 a 183:
159:         *-- Container botões CRUD (canônico Left=520, Width=390)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 31
163:             .Left        =  542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         *-- Botão Incluir
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:             .PicturePosition = 13
177:             .Top             = 5
178:             .Left            = 5
179:             .Width           = 75
180:             .Height          = 75
181:             .BackColor       = RGB(255, 255, 255)
182:             .ForeColor       = RGB(90, 90, 90)
183:             .FontName        = "Tahoma"

*-- Linhas 190 a 207:
190:             .MousePointer    = 15
191:             .Visible         = .T.
192:         ENDWITH
193:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
194: 
195:         *-- Botão Visualizar
196:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Top             = 5
202:             .Left            = 80
203:             .Width           = 75
204:             .Height          = 75
205:             .BackColor       = RGB(255, 255, 255)
206:             .ForeColor       = RGB(90, 90, 90)
207:             .FontName        = "Tahoma"

*-- Linhas 214 a 231:
214:             .MousePointer    = 15
215:             .Visible         = .T.
216:         ENDWITH
217:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
218: 
219:         *-- Botão Alterar
220:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
221:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
222:             .Caption         = "Alterar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
224:             .PicturePosition = 13
225:             .Top             = 5
226:             .Left            = 155
227:             .Width           = 75
228:             .Height          = 75
229:             .BackColor       = RGB(255, 255, 255)
230:             .ForeColor       = RGB(90, 90, 90)
231:             .FontName        = "Tahoma"

*-- Linhas 238 a 255:
238:             .MousePointer    = 15
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botão Excluir
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .FontName        = "Tahoma"

*-- Linhas 262 a 279:
262:             .MousePointer    = 15
263:             .Visible         = .T.
264:         ENDWITH
265:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
266: 
267:         *-- Botão Buscar
268:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
269:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
270:             .Caption         = "Buscar"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 305
275:             .Width           = 75
276:             .Height          = 75
277:             .BackColor       = RGB(255, 255, 255)
278:             .ForeColor       = RGB(90, 90, 90)
279:             .FontName        = "Tahoma"

*-- Linhas 286 a 313:
286:             .MousePointer    = 15
287:             .Visible         = .T.
288:         ENDWITH
289:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
290: 
291:         *-- Container Encerrar (canônico Left=917, Width=90)
292:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
293:         WITH loc_oPagina.cnt_4c_Saida
294:             .Top         = 31
295:             .Left        = 917
296:             .Width       = 90
297:             .Height      = 85
298:             .BackStyle   = 0
299:             .BorderWidth = 0
300:             .Visible     = .T.
301:         ENDWITH
302:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
304:             .Caption         = "Encerrar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 5
309:             .Width           = 75
310:             .Height          = 75
311:             .BackColor       = RGB(255, 255, 255)
312:             .ForeColor       = RGB(90, 90, 90)
313:             .FontName        = "Tahoma"

*-- Linhas 320 a 336:
320:             .MousePointer    = 15
321:             .Visible         = .T.
322:         ENDWITH
323:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
324: 
325:         *-- Grid de lista (Top=117 = 86+31 compensação PageFrame)
326:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
327:         loc_oGrid = loc_oPagina.grd_4c_Lista
328:         loc_oGrid.ColumnCount = 9
329:         WITH loc_oGrid
330:             .Top                = 117
331:             .Left               = 26
332:             .Width              = 890
333:             .Height             = 470
334:             .FontName           = "Verdana"
335:             .FontSize           = 8
336:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 353 a 387:
353:     *==========================================================================
354:     * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
355:     * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
356:     * Compensação PageFrame.Top=-31: todos os Tops somam +31
357:     *==========================================================================
358:     PROTECTED PROCEDURE ConfigurarPaginaDados()
359:         LOCAL loc_oPagina
360:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
361: 
362:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
363:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
364: 
365:         *-- Container botões Confirmar/Cancelar (canônico: Top=51, Left=842)
366:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
367:         WITH loc_oPagina.cnt_4c_BotoesAcao
368:             .Top         = 51
369:             .Left        = 842
370:             .Width       = 160
371:             .Height      = 85
372:             .BackStyle   = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 5
383:             .Width           = 75
384:             .Height          = 75
385:             .BackColor       = RGB(255, 255, 255)
386:             .ForeColor       = RGB(90, 90, 90)
387:             .FontName        = "Tahoma"

*-- Linhas 394 a 410:
394:             .MousePointer    = 15
395:             .Visible         = .T.
396:         ENDWITH
397:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
398: 
399:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
400:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
401:             .Caption         = "Encerrar"
402:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
403:             .PicturePosition = 13
404:             .Top             = 5
405:             .Left            = 80
406:             .Width           = 75
407:             .Height          = 75
408:             .BackColor       = RGB(255, 255, 255)
409:             .ForeColor       = RGB(90, 90, 90)
410:             .FontName        = "Tahoma"

*-- Linhas 417 a 434:
417:             .MousePointer    = 15
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
421: 
422:         *====================================================================
423:         *-- CAMPO 1: Operação de Produção (Get_Dopp) - original top=98 -> 129
424:         *====================================================================
425:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
426:         WITH loc_oPagina.lbl_4c_Label2
427:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
428:             .Top       = 133
429:             .Left      = 242
430:             .Width     = 85
431:             .Height    = 15
432:             .BackStyle = 0
433:             .ForeColor = RGB(90, 90, 90)
434:             .FontName  = "Tahoma"

*-- Linhas 440 a 449:
440:         loc_oPagina.AddObject("txt_4c_Dopp", "TextBox")
441:         WITH loc_oPagina.txt_4c_Dopp
442:             .Value       = ""
443:             .Top         = 129
444:             .Left        = 328
445:             .Width       = 150
446:             .Height      = 23
447:             .MaxLength   = 20
448:             .BackColor   = RGB(255, 255, 255)
449:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 458 a 470:
458:         *====================================================================
459:         *-- CAMPO 2: Tipo de Material (Get_Tpop) - original top=124 -> 155
460:         *====================================================================
461:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
462:         WITH loc_oPagina.lbl_4c_Label1
463:             .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o :"
464:             .Top       = 159
465:             .Left      = 204
466:             .Width     = 120
467:             .Height    = 15
468:             .BackStyle = 0
469:             .ForeColor = RGB(90, 90, 90)
470:             .FontName  = "Tahoma"

*-- Linhas 476 a 485:
476:         loc_oPagina.AddObject("txt_4c_Tpop", "TextBox")
477:         WITH loc_oPagina.txt_4c_Tpop
478:             .Value       = ""
479:             .Top         = 155
480:             .Left        = 328
481:             .Width       = 115
482:             .Height      = 23
483:             .MaxLength   = 15
484:             .BackColor   = RGB(255, 255, 255)
485:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 495 a 507:
495:         *-- CAMPO 3: Grupo de Produto - código (get_Cgru) + desc (get_ds_grupo)
496:         *-- original top=150 -> 181
497:         *====================================================================
498:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
499:         WITH loc_oPagina.lbl_4c_Lbl_grupo
500:             .Caption   = "Grupo de Produto :"
501:             .Top       = 185
502:             .Left      = 226
503:             .Width     = 94
504:             .Height    = 15
505:             .BackStyle = 0
506:             .ForeColor = RGB(90, 90, 90)
507:             .FontName  = "Tahoma"

*-- Linhas 513 a 522:
513:         loc_oPagina.AddObject("txt_4c__Cgru", "TextBox")
514:         WITH loc_oPagina.txt_4c__Cgru
515:             .Value       = ""
516:             .Top         = 181
517:             .Left        = 328
518:             .Width       = 31
519:             .Height      = 23
520:             .MaxLength   = 3
521:             .BackColor   = RGB(255, 255, 255)
522:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 531 a 540:
531:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
532:         WITH loc_oPagina.txt_4c__ds_grupo
533:             .Value       = ""
534:             .Top         = 181
535:             .Left        = 361
536:             .Width       = 213
537:             .Height      = 23
538:             .MaxLength   = 50
539:             .BackColor   = RGB(255, 255, 255)
540:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 548 a 575:
548:         *====================================================================
549:         *-- CAMPO 4: Operação Estoque E/S (Get_OpPad) - original top=177 -> 208
550:         *====================================================================
551:         loc_oPagina.AddObject("lbl_4c_Label39", "Label")
552:         WITH loc_oPagina.lbl_4c_Label39
553:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Estoque :"
554:             .Top       = 211
555:             .Left      = 222
556:             .Width     = 98
557:             .Height    = 15
558:             .BackStyle = 0
559:             .ForeColor = RGB(90, 90, 90)
560:             .FontName  = "Tahoma"
561:             .FontSize  = 8
562:             .Alignment = 1
563:             .Visible   = .T.
564:         ENDWITH
565: 
566:         loc_oPagina.AddObject("lbl_4c_Label40", "Label")
567:         WITH loc_oPagina.lbl_4c_Label40
568:             .Caption   = "(E / S)"
569:             .Top       = 211
570:             .Left      = 352
571:             .Width     = 32
572:             .Height    = 15
573:             .BackStyle = 0
574:             .ForeColor = RGB(90, 90, 90)
575:             .FontName  = "Tahoma"

*-- Linhas 581 a 590:
581:         loc_oPagina.AddObject("txt_4c_OpPad", "TextBox")
582:         WITH loc_oPagina.txt_4c_OpPad
583:             .Value       = ""
584:             .Top         = 208
585:             .Left        = 328
586:             .Width       = 17
587:             .Height      = 20
588:             .MaxLength   = 1
589:             .BackColor   = RGB(255, 255, 255)
590:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 602 a 611:
602:         loc_oPagina.AddObject("txt_4c_Gde", "TextBox")
603:         WITH loc_oPagina.txt_4c_Gde
604:             .Value       = ""
605:             .Top         = 231
606:             .Left        = 328
607:             .Width       = 33
608:             .Height      = 23
609:             .MaxLength   = 3
610:             .BackColor   = RGB(255, 255, 255)
611:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 617 a 629:
617:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress", THIS, "ValidarGde")
618:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress",  THIS, "TeclaPressionadaGde")
619: 
620:         loc_oPagina.AddObject("lbl_4c_Lbl_gde_grupo", "Label")
621:         WITH loc_oPagina.lbl_4c_Lbl_gde_grupo
622:             .Caption   = "Grande Grupo :"
623:             .Top       = 235
624:             .Left      = 244
625:             .Width     = 76
626:             .Height    = 15
627:             .BackStyle = 0
628:             .ForeColor = RGB(90, 90, 90)
629:             .FontName  = "Tahoma"

*-- Linhas 636 a 648:
636:         *-- CAMPO 6: Grupo Contábil código (Get_Grupos) + desc (Get_Dgrupos)
637:         *-- original top=226 -> 257 | Say4 original top=230 -> 261
638:         *====================================================================
639:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
640:         WITH loc_oPagina.lbl_4c_Say4
641:             .Caption   = "Grupo :"
642:             .Top       = 261
643:             .Left      = 282
644:             .Width     = 43
645:             .Height    = 15
646:             .BackStyle = 0
647:             .ForeColor = RGB(90, 90, 90)
648:             .FontName  = "Tahoma"

*-- Linhas 654 a 663:
654:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
655:         WITH loc_oPagina.txt_4c_Grupo
656:             .Value       = ""
657:             .Top         = 257
658:             .Left        = 328
659:             .Width       = 80
660:             .Height      = 23
661:             .MaxLength   = 10
662:             .BackColor   = RGB(255, 255, 255)
663:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 672 a 681:
672:         loc_oPagina.AddObject("txt_4c_Dgrupos", "TextBox")
673:         WITH loc_oPagina.txt_4c_Dgrupos
674:             .Value       = ""
675:             .Top         = 257
676:             .Left        = 411
677:             .Width       = 162
678:             .Height      = 23
679:             .MaxLength   = 50
680:             .BackColor   = RGB(255, 255, 255)
681:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 690 a 702:
690:         *-- CAMPO 7: Conta Destino (Get_Conta) - original top=252 -> 283
691:         *-- Say34 original top=255 -> 286
692:         *====================================================================
693:         loc_oPagina.AddObject("lbl_4c_Say34", "Label")
694:         WITH loc_oPagina.lbl_4c_Say34
695:             .Caption   = "Conta Destino :"
696:             .Top       = 286
697:             .Left      = 243
698:             .Width     = 82
699:             .Height    = 15
700:             .BackStyle = 0
701:             .ForeColor = RGB(90, 90, 90)
702:             .FontName  = "Tahoma"

*-- Linhas 708 a 717:
708:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
709:         WITH loc_oPagina.txt_4c_Conta
710:             .Value       = ""
711:             .Top         = 283
712:             .Left        = 328
713:             .Width       = 80
714:             .Height      = 21
715:             .MaxLength   = 10
716:             .BackColor   = RGB(255, 255, 255)
717:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 727 a 739:
727:         *-- CAMPO 8: Conta Origem (Get_ContaOrig) - original top=276 -> 307
728:         *-- Say3 original top=279 -> 310
729:         *====================================================================
730:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
731:         WITH loc_oPagina.lbl_4c_Say3
732:             .Caption   = "Conta Origem :"
733:             .Top       = 310
734:             .Left      = 245
735:             .Width     = 80
736:             .Height    = 15
737:             .BackStyle = 0
738:             .ForeColor = RGB(90, 90, 90)
739:             .FontName  = "Tahoma"

*-- Linhas 745 a 754:
745:         loc_oPagina.AddObject("txt_4c_ContaOrig", "TextBox")
746:         WITH loc_oPagina.txt_4c_ContaOrig
747:             .Value       = ""
748:             .Top         = 307
749:             .Left        = 328
750:             .Width       = 80
751:             .Height      = 21
752:             .MaxLength   = 10
753:             .BackColor   = RGB(255, 255, 255)
754:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 764 a 776:
764:         *-- CAMPO 9: Cor (getCor/SigCdCor.Cods) - original top=300 -> 331
765:         *-- Say42 original top=304 -> 335
766:         *====================================================================
767:         loc_oPagina.AddObject("lbl_4c_Say42", "Label")
768:         WITH loc_oPagina.lbl_4c_Say42
769:             .Caption   = "Cor :"
770:             .Top       = 335
771:             .Left      = 294
772:             .Width     = 31
773:             .Height    = 15
774:             .BackStyle = 0
775:             .ForeColor = RGB(90, 90, 90)
776:             .FontName  = "Tahoma"

*-- Linhas 782 a 791:
782:         loc_oPagina.AddObject("txt_4c_Cor", "TextBox")
783:         WITH loc_oPagina.txt_4c_Cor
784:             .Value       = ""
785:             .Top         = 331
786:             .Left        = 328
787:             .Width       = 38
788:             .Height      = 23
789:             .MaxLength   = 6
790:             .BackColor   = RGB(255, 255, 255)
791:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 801 a 852:
801:         *-- CAMPO 10: Exclusivo (opt_Exclusivo) - original top=325 -> 356
802:         *-- Say6 original top=329 -> 360
803:         *====================================================================
804:         loc_oPagina.AddObject("lbl_4c_Say6", "Label")
805:         WITH loc_oPagina.lbl_4c_Say6
806:             .Caption   = "Exclusivo :"
807:             .Top       = 360
808:             .Left      = 267
809:             .Width     = 53
810:             .Height    = 15
811:             .BackStyle = 0
812:             .ForeColor = RGB(90, 90, 90)
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .Alignment = 1
816:             .Visible   = .T.
817:         ENDWITH
818: 
819:         loc_oPagina.AddObject("obj_4c_Opt_Exclusivo", "OptionGroup")
820:         WITH loc_oPagina.obj_4c_Opt_Exclusivo
821:             .Top         = 356
822:             .Left        = 326
823:             .Width       = 86
824:             .Height      = 23
825:             .ButtonCount = 2
826:             .BackStyle   = 0
827:             .BorderStyle = 0
828:             .Value       = 2
829:             .Visible     = .T.
830:         ENDWITH
831:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option1
832:             .Caption   = "Sim"
833:             .Left      = 2
834:             .Top       = 4
835:             .Width     = 34
836:             .Height    = 15
837:             .BackStyle = 0
838:             .ForeColor = RGB(90, 90, 90)
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .AutoSize  = .F.
842:             .Visible   = .T.
843:         ENDWITH
844:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option2
845:             .Caption   = "N" + CHR(227) + "o"
846:             .Left      = 44
847:             .Top       = 4
848:             .Width     = 37
849:             .Height    = 15
850:             .BackStyle = 0
851:             .ForeColor = RGB(90, 90, 90)
852:             .FontName  = "Tahoma"

*-- Linhas 895 a 911:
895:                     loc_oGrid.Column8.Width = 100
896:                     loc_oGrid.Column9.Width = 60
897: 
898:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
899:                     loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
900:                     loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
901:                     loc_oGrid.Column4.Header1.Caption = "Op.Est."
902:                     loc_oGrid.Column5.Header1.Caption = "Grande Grp."
903:                     loc_oGrid.Column6.Header1.Caption = "Gr.Conta"
904:                     loc_oGrid.Column7.Header1.Caption = "Conta Dest."
905:                     loc_oGrid.Column8.Header1.Caption = "Conta Orig."
906:                     loc_oGrid.Column9.Header1.Caption = "Cor"
907: 
908:                     THIS.FormatarGridLista(loc_oGrid)
909:                     loc_lResultado = .T.
910:                 ENDIF
911:             ENDIF

*-- Linhas 1212 a 1220:
1212:         loc_oPagina.obj_4c_Opt_Exclusivo.Enabled  = par_lHabilitar
1213: 
1214:         *-- Confirmar habilitado em modo edição ou exclusão
1215:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1216:             par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     * ValidarDopp - Valida campo Operação ao perder foco

*-- Linhas 1937 a 1952:
1937: 
1938:         DO CASE
1939:             CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
1940:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1941:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1942:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1943:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1944:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1945:             OTHERWISE
1946:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1947:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1948:         ENDCASE
1949:     ENDPROC
1950: 
1951:     *==========================================================================
1952:     * Destroy - Libera recursos ao fechar o formulário


### BO (C:\4c\projeto\app\classes\RopBO.prg):
*==============================================================================
* RopBO.prg
*
* Business Object para Cadastro de Restricoes Por Operacao
* Tabela: SigCdRpo
* Herda de: BusinessBase
*
* Colunas da tabela SigCdRpo:
*   cidchaves  char(20)    PK - Chave unica gerada via NEWID
*   cgrus      char(3)     Grupo de Produto
*   dopps      char(20)    Operacao de Producao
*   doptpgrus  char(48)    Composto: Dopp+TpOp+Cgru+Mercs+Grupos
*   tpops      char(15)    Tipo de Material/Operacao
*   mercs      char(3)     Grande Grupo
*   opers      char(1)     Operacao Estoque (E/S)
*   grupos     char(10)    Grupo de Conta Contabil
*   exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
*   contas     char(10)    Conta Destino
*   codcors    char(4)     Codigo da Cor
*   contaorig  char(10)    Conta Origem
*==============================================================================

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdRpo)
    this_cCidChaves  = ""   && cidchaves  char(20)    PK
    this_cCgrus      = ""   && cgrus      char(3)     Grupo de Produto
    this_cDopps      = ""   && dopps      char(20)    Operacao
    this_cDoptpgrus  = ""   && doptpgrus  char(48)    Composto (auto-gerado)
    this_cTpops      = ""   && tpops      char(15)    Tipo de Material
    this_cMercs      = ""   && mercs      char(3)     Grande Grupo
    this_cOpers      = ""   && opers      char(1)     Op.Estoque E/S
    this_cGrupos     = ""   && grupos     char(10)    Grupo Conta
    this_nExclus     = 2    && exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
    this_cContas     = ""   && contas     char(10)    Conta Destino
    this_cCodcors    = ""   && codcors    char(4)     Cor
    this_cContaorig  = ""   && contaorig  char(10)    Conta Origem

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCgrus      = TratarNulo(cgrus,      "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_cDoptpgrus  = TratarNulo(doptpgrus,  "C")
                THIS.this_cTpops      = TratarNulo(tpops,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cOpers      = TratarNulo(opers,      "C")
                THIS.this_cGrupos     = TratarNulo(grupos,     "C")
                THIS.this_nExclus     = TratarNulo(exclus,     "N")
                THIS.this_cContas     = TratarNulo(contas,     "C")
                THIS.this_cCodcors    = TratarNulo(codcors,    "C")
                THIS.this_cContaorig  = TratarNulo(contaorig,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves  = ""
        THIS.this_cCgrus      = ""
        THIS.this_cDopps      = ""
        THIS.this_cDoptpgrus  = ""
        THIS.this_cTpops      = ""
        THIS.this_cMercs      = ""
        THIS.this_cOpers      = ""
        THIS.this_cGrupos     = ""
        THIS.this_nExclus     = 2
        THIS.this_cContas     = ""
        THIS.this_cCodcors    = ""
        THIS.this_cContaorig  = ""
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(THIS.this_cTpops) AND EMPTY(THIS.this_cCgrus) AND ;
               EMPTY(THIS.this_cMercs) AND EMPTY(THIS.this_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo de Material Ou " + ;
                    "Grupo de Produto Ou Grande Grupo Ou Grupo Conta")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite Apenas [E] ou [S] ou [ ] !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido
            IF THIS.VerificarDuplicidade()
                MsgAviso("Restri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica restricao ja cadastrada com mesmos campos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRpo" + ;
                " WHERE Dopps    = " + EscaparSQL(THIS.this_cDopps) + ;
                " AND   TpOps    = " + EscaparSQL(THIS.this_cTpops) + ;
                " AND   CGrus    = " + EscaparSQL(THIS.this_cCgrus) + ;
                " AND   Mercs    = " + EscaparSQL(THIS.this_cMercs) + ;
                " AND   Grupos   = " + EscaparSQL(THIS.this_cGrupos) + ;
                " AND   Contas   = " + EscaparSQL(THIS.this_cContas) + ;
                " AND   ContaOrig= " + EscaparSQL(THIS.this_cContaorig) + ;
                " AND   CodCors  = " + EscaparSQL(THIS.this_cCodcors) + ;
                " AND   cidchaves <> " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RopBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult, loc_cSQL
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RopBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RopBO.Inserir")
            ELSE
                THIS.this_cDoptpgrus = LEFT( ;
                    ALLTRIM(THIS.this_cDopps)  + ;
                    ALLTRIM(THIS.this_cTpops)  + ;
                    ALLTRIM(THIS.this_cCgrus)  + ;
                    ALLTRIM(THIS.this_cMercs)  + ;
                    ALLTRIM(THIS.this_cGrupos) + ;
                    SPACE(48), 48)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdRpo (
                        cidchaves, cgrus, dopps, doptpgrus, tpops,
                        mercs, opers, grupos, exclus, contas, codcors, contaorig
                    ) VALUES (
                        <<EscaparSQL(THIS.this_cCidChaves)>>,
                        <<EscaparSQL(THIS.this_cCgrus)>>,
                        <<EscaparSQL(THIS.this_cDopps)>>,
                        <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                        <<EscaparSQL(THIS.this_cTpops)>>,
                        <<EscaparSQL(THIS.this_cMercs)>>,
                        <<EscaparSQL(THIS.this_cOpers)>>,
                        <<EscaparSQL(THIS.this_cGrupos)>>,
                        <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                        <<EscaparSQL(THIS.this_cContas)>>,
                        <<EscaparSQL(THIS.this_cCodcors)>>,
                        <<EscaparSQL(THIS.this_cContaorig)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDoptpgrus = LEFT( ;
                ALLTRIM(THIS.this_cDopps)  + ;
                ALLTRIM(THIS.this_cTpops)  + ;
                ALLTRIM(THIS.this_cCgrus)  + ;
                ALLTRIM(THIS.this_cMercs)  + ;
                ALLTRIM(THIS.this_cGrupos) + ;
                SPACE(48), 48)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdRpo SET
                    cgrus      = <<EscaparSQL(THIS.this_cCgrus)>>,
                    dopps      = <<EscaparSQL(THIS.this_cDopps)>>,
                    doptpgrus  = <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                    tpops      = <<EscaparSQL(THIS.this_cTpops)>>,
                    mercs      = <<EscaparSQL(THIS.this_cMercs)>>,
                    opers      = <<EscaparSQL(THIS.this_cOpers)>>,
                    grupos     = <<EscaparSQL(THIS.this_cGrupos)>>,
                    exclus     = <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodcors)>>,
                    contaorig  = <<EscaparSQL(THIS.this_cContaorig)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas para o grid (ordem identica ao legado)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        dopps     C(20), ;
                        tpops     C(15), ;
                        cgrus     C(3),  ;
                        opers     C(1),  ;
                        mercs     C(3),  ;
                        grupos    C(10), ;
                        contas    C(10), ;
                        contaorig C(10), ;
                        codcors   C(4),  ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT dopps, tpops, cgrus, opers, mercs," + ;
                    " grupos, contas, contaorig, codcors, cidchaves" + ;
                    " FROM SigCdRpo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dopps, tpops, cgrus"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cgrus, dopps, doptpgrus, tpops," + ;
                " mercs, opers, grupos, exclus, contas, codcors, contaorig" + ;
                " FROM SigCdRpo WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


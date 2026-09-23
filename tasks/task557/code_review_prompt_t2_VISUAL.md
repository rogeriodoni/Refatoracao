# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.CntPeriodo): Top original=6 vs migrado 'lbl_4c_Label11' Top=425 (diff=419px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.CntPeriodo): Left original=19 vs migrado 'lbl_4c_Label11' Left=305 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntEmps): Top original=6 vs migrado 'lbl_4c_Label11' Top=425 (diff=419px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntEmps): Left original=16 vs migrado 'lbl_4c_Label11' Left=305 (diff=289px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntVens): Top original=7 vs migrado 'lbl_4c_Label11' Top=425 (diff=418px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntVens): Left original=33 vs migrado 'lbl_4c_Label11' Left=305 (diff=272px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormVEN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1798 linhas total):

*-- Linhas 46 a 67:
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             THIS.Caption = "Cadastro de Presen" + CHR(231) + "a de Vendedores"
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("VENBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar VENBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormVEN.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66: 
67:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 90 a 109:
90: 
91:         WITH THIS.pgf_4c_Paginas
92:             .PageCount = 2
93:             .Top       = -29
94:             .Left      = 0
95:             .Width     = THIS.Width
96:             .Height    = THIS.Height + 29
97:             .Tabs      = .F.
98:             .Visible   = .T.
99: 
100:             .Page1.Caption   = "Lista"
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page1.BackColor = RGB(255, 255, 255)
103: 
104:             .Page2.Caption   = "Dados"
105:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:             .Page2.BackColor = RGB(255, 255, 255)
107:         ENDWITH
108: 
109:         THIS.ConfigurarPaginaLista()

*-- Linhas 124 a 161:
124:         *-- Container Cabecalho (cntSombra no legado) - Top=2+29=31
125:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH loc_oPagina.cnt_4c_Cabecalho
127:             .Top         = 31
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Caption   = THIS.Caption
139:             .Top       = 15
140:             .Left      = 10
141:             .Width     = 769
142:             .Height    = 40
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(0, 0, 0)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = THIS.Caption
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = 769
158:             .Height    = 46
159:             .FontName  = "Tahoma"
160:             .FontSize  = 16
161:             .FontBold  = .T.

*-- Linhas 168 a 192:
168:         *-- Container Botoes CRUD (Grupo_op no legado)
169:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
170:         WITH loc_oPagina.cnt_4c_Botoes
171:             .Top         = 29
172:             .Left        = 542
173:             .Width       = 390
174:             .Height      = 85
175:             .BackStyle   = 0
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir (Left=5)
181:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .FontName        = "Tahoma"
191:             .FontBold        = .T.
192:             .FontItalic      = .T.

*-- Linhas 200 a 217:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar (Left=80)
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Tahoma"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.

*-- Linhas 225 a 242:
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar (Left=155)
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Tahoma"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.

*-- Linhas 250 a 267:
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir (Left=230)
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Tahoma"
266:             .FontBold        = .T.
267:             .FontItalic      = .T.

*-- Linhas 275 a 292:
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar (Left=305)
281:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .FontName        = "Tahoma"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.

*-- Linhas 300 a 330:
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, regra #10)
306:         *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
319:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
320:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
321:             .Caption         = "Encerrar"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .FontName        = "Tahoma"
329:             .FontBold        = .T.
330:             .FontItalic      = .T.

*-- Linhas 338 a 357:
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- Grid de listagem de vendedores
344:         *-- Original: Grade.Top=131, Left=29, Width=940, Height=456
345:         *-- Canonico framework: Top=160 (131+29 compensacao), Left=26, Width=880, Height=456
346:         *-- (Width=880 para nao sobrepor cnt_4c_Saida em Left=917; Height preservada do legado)
347:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
348:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
349:         loc_oPagina.grd_4c_Lista.ColumnCount = 11
350:         WITH loc_oPagina.grd_4c_Lista
351:             .Top                = 160
352:             .Left               = 26
353:             .Width              = 880
354:             .Height             = 456
355:             .FontName           = "Verdana"
356:             .FontSize           = 8
357:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 386 a 424:
386:         *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11
387:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
388:         WITH loc_oPagina.cnt_4c_Cabecalho
389:             .Top           = 29
390:             .Left          = 0
391:             .Width         = THIS.Width
392:             .Height        = 80
393:             .BackColor     = RGB(100, 100, 100)
394:             .BorderWidth   = 0
395:             .SpecialEffect = 0
396:             .Visible       = .T.
397:         ENDWITH
398: 
399:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
400:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
401:             .Caption   = THIS.Caption
402:             .Top       = 15
403:             .Left      = 10
404:             .Width     = THIS.Width
405:             .Height    = 40
406:             .FontName  = "Tahoma"
407:             .FontSize  = 16
408:             .FontBold  = .T.
409:             .ForeColor = RGB(0, 0, 0)
410:             .BackStyle = 0
411:             .AutoSize  = .F.
412:             .Visible   = .T.
413:         ENDWITH
414: 
415:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
416:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
417:             .Caption   = THIS.Caption
418:             .Top       = 18
419:             .Left      = 10
420:             .Width     = THIS.Width
421:             .Height    = 46
422:             .FontName  = "Tahoma"
423:             .FontSize  = 16
424:             .FontBold  = .T.

*-- Linhas 431 a 456:
431:         *-- Container BotoesAcao (Grupo_Salva no legado)
432:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
433:         WITH loc_oPagina.cnt_4c_BotoesAcao
434:             .Top         = 33
435:             .Left        = 842
436:             .Width       = 160
437:             .Height      = 85
438:             .BackStyle = 0
439:             .BackColor   = RGB(255, 255, 255)
440:             .BorderWidth = 0
441:             .Visible     = .T.
442:         ENDWITH
443: 
444:         *-- Botao Confirmar (Grupo_Salva.Salva no legado)
445:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
446:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
447:             .Caption         = "Confirmar"
448:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
449:             .PicturePosition = 13
450:             .Top             = 5
451:             .Left            = 5
452:             .Width           = 75
453:             .Height          = 75
454:             .FontName        = "Tahoma"
455:             .FontBold        = .T.
456:             .FontItalic      = .T.

*-- Linhas 464 a 481:
464:             .AutoSize        = .F.
465:             .Visible         = .T.
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
468: 
469:         *-- Botao Cancelar (Grupo_Salva.Cancelar no legado)
470:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 5
476:             .Left            = 80
477:             .Width           = 75
478:             .Height          = 75
479:             .FontName        = "Tahoma"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.

*-- Linhas 489 a 504:
489:             .AutoSize        = .F.
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
493: 
494:         *-- Codigo: Say7.Top=124+29=153, getcodigo.Top=121+29=150 (legado: When retorna .F. - nunca recebe foco)
495:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
496:         WITH loc_oPagina.lbl_4c_Label7
497:             .Caption   = "C" + CHR(243) + "digo : "
498:             .Top       = 153
499:             .Left      = 325
500:             .Width     = 47
501:             .Height    = 17
502:             .AutoSize  = .F.
503:             .Alignment = 0
504:             .FontName  = "Tahoma"

*-- Linhas 511 a 520:
511:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
512:         WITH loc_oPagina.txt_4c_Codigo
513:             .Value         = ""
514:             .Top           = 150
515:             .Left          = 372
516:             .Width         = 160
517:             .Height        = 24
518:             .MaxLength     = 20
519:             .Enabled       = .F.
520:             .FontName      = "Tahoma"

*-- Linhas 526 a 539:
526:             .Visible       = .T.
527:         ENDWITH
528: 
529:         *-- Loja/Empresa: Say1.Top=151+29=180, getEmps.Top=148+29=177 (editavel so em INCLUIR)
530:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
531:         WITH loc_oPagina.lbl_4c_Label1
532:             .Caption   = "Cod Loja : "
533:             .Top       = 180
534:             .Left      = 316
535:             .Width     = 56
536:             .Height    = 17
537:             .AutoSize  = .F.
538:             .Alignment = 0
539:             .FontName  = "Tahoma"

*-- Linhas 546 a 555:
546:         loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
547:         WITH loc_oPagina.txt_4c_Emps
548:             .Value         = ""
549:             .Top           = 177
550:             .Left          = 372
551:             .Width         = 33
552:             .Height        = 24
553:             .MaxLength     = 3
554:             .FontName      = "Tahoma"
555:             .FontSize      = 8

*-- Linhas 562 a 575:
562:         *-- Lookup/validacao: LostFocus busca UF em SigcdEmp + fAcessoEmpresa (regra #27, VerificarAcessoEmpresa)
563:         BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpsDados")
564: 
565:         *-- Empresa Registro: Say12.Top=152+29=181, GetEmpReg.Top=148+29=177 (readonly, preenchido via pegaempreg)
566:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
567:         WITH loc_oPagina.lbl_4c_Label12
568:             .Caption   = "Empresa Registro :"
569:             .Top       = 181
570:             .Left      = 590
571:             .Width     = 95
572:             .Height    = 17
573:             .AutoSize  = .F.
574:             .Alignment = 0
575:             .FontName  = "Tahoma"

*-- Linhas 582 a 591:
582:         loc_oPagina.AddObject("txt_4c_EmpReg", "TextBox")
583:         WITH loc_oPagina.txt_4c_EmpReg
584:             .Value         = ""
585:             .Top           = 177
586:             .Left          = 685
587:             .Width         = 33
588:             .Height        = 24
589:             .MaxLength     = 3
590:             .Enabled       = .F.
591:             .FontName      = "Tahoma"

*-- Linhas 597 a 610:
597:             .Visible       = .T.
598:         ENDWITH
599: 
600:         *-- Estado: Say3.Top=178+29=207, GetUfs.Top=175+29=204 (readonly, preenchido via lookup de Emps)
601:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
602:         WITH loc_oPagina.lbl_4c_Label3
603:             .Caption   = "Estado : "
604:             .Top       = 207
605:             .Left      = 325
606:             .Width     = 47
607:             .Height    = 17
608:             .AutoSize  = .F.
609:             .Alignment = 0
610:             .FontName  = "Tahoma"

*-- Linhas 617 a 626:
617:         loc_oPagina.AddObject("txt_4c_Ufs", "TextBox")
618:         WITH loc_oPagina.txt_4c_Ufs
619:             .Value         = ""
620:             .Top           = 204
621:             .Left          = 372
622:             .Width         = 33
623:             .Height        = 24
624:             .MaxLength     = 2
625:             .Enabled       = .F.
626:             .FontName      = "Tahoma"

*-- Linhas 632 a 645:
632:             .Visible       = .T.
633:         ENDWITH
634: 
635:         *-- Grupo Vendedor: Say8.Top=205+29=234, getGrupo.Top=202+29=231 (readonly, legado: When retorna .F.)
636:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
637:         WITH loc_oPagina.lbl_4c_Label8
638:             .Caption   = "Grupo Vendedor :"
639:             .Top       = 234
640:             .Left      = 280
641:             .Width     = 92
642:             .Height    = 17
643:             .AutoSize  = .F.
644:             .Alignment = 0
645:             .FontName  = "Tahoma"

*-- Linhas 652 a 661:
652:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
653:         WITH loc_oPagina.txt_4c_Grupo
654:             .Value         = ""
655:             .Top           = 231
656:             .Left          = 372
657:             .Width         = 94
658:             .Height        = 24
659:             .MaxLength     = 10
660:             .Enabled       = .F.
661:             .FontName      = "Tahoma"

*-- Linhas 667 a 680:
667:             .Visible       = .T.
668:         ENDWITH
669: 
670:         *-- Cod Vendedor: Say2.Top=232+29=261, GetVens.Top=229+29=258 (editavel so em INCLUIR) + GetdVens (descricao, readonly)
671:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
672:         WITH loc_oPagina.lbl_4c_Label2
673:             .Caption   = "Cod Vendedor :"
674:             .Top       = 261
675:             .Left      = 290
676:             .Width     = 82
677:             .Height    = 17
678:             .AutoSize  = .F.
679:             .Alignment = 0
680:             .FontName  = "Tahoma"

*-- Linhas 687 a 696:
687:         loc_oPagina.AddObject("txt_4c_Vens", "TextBox")
688:         WITH loc_oPagina.txt_4c_Vens
689:             .Value         = ""
690:             .Top           = 258
691:             .Left          = 372
692:             .Width         = 94
693:             .Height        = 24
694:             .MaxLength     = 10
695:             .FontName      = "Tahoma"
696:             .FontSize      = 8

*-- Linhas 704 a 713:
704:         loc_oPagina.AddObject("txt_4c_DVens", "TextBox")
705:         WITH loc_oPagina.txt_4c_DVens
706:             .Value         = ""
707:             .Top           = 258
708:             .Left          = 468
709:             .Width         = 250
710:             .Height        = 24
711:             .MaxLength     = 50
712:             .Enabled       = .F.
713:             .FontName      = "Tahoma"

*-- Linhas 722 a 735:
722:         BINDEVENT(loc_oPagina.txt_4c_Vens,  "KeyPress", THIS, "ValidarVensDados")
723:         BINDEVENT(loc_oPagina.txt_4c_DVens, "KeyPress", THIS, "ValidarDVensDados")
724: 
725:         *-- Data Inicial: Say5.Top=259+29=288, getDtini.Top=256+29=285 (editavel em INCLUIR/ALTERAR)
726:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
727:         WITH loc_oPagina.lbl_4c_Label5
728:             .Caption   = "Data Inicial :"
729:             .Top       = 288
730:             .Left      = 305
731:             .Width     = 67
732:             .Height    = 17
733:             .AutoSize  = .F.
734:             .Alignment = 0
735:             .FontName  = "Tahoma"

*-- Linhas 742 a 768:
742:         loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
743:         WITH loc_oPagina.txt_4c_Dtini
744:             .Value         = {}
745:             .Top           = 285
746:             .Left          = 372
747:             .Width         = 94
748:             .Height        = 24
749:             .FontName      = "Tahoma"
750:             .FontSize      = 8
751:             .ForeColor     = RGB(90, 90, 90)
752:             .BackColor     = RGB(255, 255, 255)
753:             .BorderStyle   = 1
754:             .SpecialEffect = 0
755:             .Visible       = .T.
756:         ENDWITH
757: 
758:         *-- Data Final: Say6.Top=286+29=315, GetDtfin.Top=283+29=312 (editavel em INCLUIR/ALTERAR)
759:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
760:         WITH loc_oPagina.lbl_4c_Label6
761:             .Caption   = "Data Final :"
762:             .Top       = 315
763:             .Left      = 310
764:             .Width     = 62
765:             .Height    = 17
766:             .AutoSize  = .F.
767:             .Alignment = 0
768:             .FontName  = "Tahoma"

*-- Linhas 775 a 801:
775:         loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
776:         WITH loc_oPagina.txt_4c_Dtfin
777:             .Value         = {}
778:             .Top           = 312
779:             .Left          = 372
780:             .Width         = 94
781:             .Height        = 24
782:             .FontName      = "Tahoma"
783:             .FontSize      = 8
784:             .ForeColor     = RGB(90, 90, 90)
785:             .BackColor     = RGB(255, 255, 255)
786:             .BorderStyle   = 1
787:             .SpecialEffect = 0
788:             .Visible       = .T.
789:         ENDWITH
790: 
791:         *-- Situacao: Say4.Top=313+29=342, CmbSituas.Top=310+29=339 (RowSource EXATO do legado)
792:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
793:         WITH loc_oPagina.lbl_4c_Label4
794:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
795:             .Top       = 342
796:             .Left      = 317
797:             .Width     = 55
798:             .Height    = 17
799:             .AutoSize  = .F.
800:             .Alignment = 0
801:             .FontName  = "Tahoma"

*-- Linhas 810 a 819:
810:             .RowSourceType = 1
811:             .RowSource     = "ATIVO,AFASTADO POR ACIDENTE,AFASTADO POR DOENCA,AFASTADO POR MATERNIDADE,DEMITIDO,FERIAS,TREINAMENTO,FOLGA"
812:             .Value         = ""
813:             .Top           = 339
814:             .Left          = 372
815:             .Width         = 160
816:             .Height        = 24
817:             .Style         = 2
818:             .FontName      = "Tahoma"
819:             .FontSize      = 8

*-- Linhas 825 a 838:
825:         *-- Validacao: FOLGA exige fChecaAcesso ou usuario/vendedor na mesma empresa (transcrito do legado)
826:         BINDEVENT(loc_oPagina.cbo_4c_CmbSituas, "KeyPress", THIS, "ValidarSituacao")
827: 
828:         *-- Cargo: Say9.Top=340+29=369, cmbCargo.Top=337+29=366 (RowSource EXATO do legado)
829:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
830:         WITH loc_oPagina.lbl_4c_Label9
831:             .Caption   = "Cargo : "
832:             .Top       = 369
833:             .Left      = 329
834:             .Width     = 43
835:             .Height    = 17
836:             .AutoSize  = .F.
837:             .Alignment = 0
838:             .FontName  = "Tahoma"

*-- Linhas 847 a 873:
847:             .RowSourceType = 1
848:             .RowSource     = "GERENTE,VENDEDOR"
849:             .Value         = ""
850:             .Top           = 366
851:             .Left          = 372
852:             .Width         = 160
853:             .Height        = 24
854:             .Style         = 2
855:             .FontName      = "Tahoma"
856:             .FontSize      = 8
857:             .ForeColor     = RGB(90, 90, 90)
858:             .BackColor     = RGB(255, 255, 255)
859:             .SpecialEffect = 1
860:             .Visible       = .T.
861:         ENDWITH
862: 
863:         *-- Comissao %: Say10.Top=369+29=398, getpdes.Top=364+29=393 (InputMask EXATO do legado)
864:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
865:         WITH loc_oPagina.lbl_4c_Label10
866:             .Caption   = "Comiss" + CHR(227) + "o % : "
867:             .Top       = 398
868:             .Left      = 299
869:             .Width     = 73
870:             .Height    = 17
871:             .AutoSize  = .F.
872:             .Alignment = 0
873:             .FontName  = "Tahoma"

*-- Linhas 880 a 907:
880:         loc_oPagina.AddObject("txt_4c_Comis", "TextBox")
881:         WITH loc_oPagina.txt_4c_Comis
882:             .Value         = 0
883:             .Top           = 393
884:             .Left          = 372
885:             .Width         = 94
886:             .Height        = 24
887:             .InputMask     = "999.99"
888:             .FontName      = "Tahoma"
889:             .FontSize      = 8
890:             .ForeColor     = RGB(90, 90, 90)
891:             .BackColor     = RGB(255, 255, 255)
892:             .BorderStyle   = 1
893:             .SpecialEffect = 0
894:             .Visible       = .T.
895:         ENDWITH
896: 
897:         *-- Subsidio %: Say11.Top=396+29=425, getSubsidio.Top=391+29=420 (InputMask EXATO do legado)
898:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
899:         WITH loc_oPagina.lbl_4c_Label11
900:             .Caption   = "Subs" + CHR(237) + "dio % : "
901:             .Top       = 425
902:             .Left      = 305
903:             .Width     = 67
904:             .Height    = 17
905:             .AutoSize  = .F.
906:             .Alignment = 0
907:             .FontName  = "Tahoma"

*-- Linhas 914 a 941:
914:         loc_oPagina.AddObject("txt_4c_Subsidio", "TextBox")
915:         WITH loc_oPagina.txt_4c_Subsidio
916:             .Value         = 0
917:             .Top           = 420
918:             .Left          = 372
919:             .Width         = 94
920:             .Height        = 24
921:             .InputMask     = "999.99"
922:             .FontName      = "Tahoma"
923:             .FontSize      = 8
924:             .ForeColor     = RGB(90, 90, 90)
925:             .BackColor     = RGB(255, 255, 255)
926:             .BorderStyle   = 1
927:             .SpecialEffect = 0
928:             .Visible       = .T.
929:         ENDWITH
930: 
931:         *-- Meta %: Say13.Top=423+29=452, getpmeta.Top=418+29=447 (InputMask EXATO do legado)
932:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
933:         WITH loc_oPagina.lbl_4c_Label13
934:             .Caption   = "Meta % : "
935:             .Top       = 452
936:             .Left      = 320
937:             .Width     = 52
938:             .Height    = 17
939:             .AutoSize  = .F.
940:             .Alignment = 0
941:             .FontName  = "Tahoma"

*-- Linhas 948 a 957:
948:         loc_oPagina.AddObject("txt_4c_Pmeta", "TextBox")
949:         WITH loc_oPagina.txt_4c_Pmeta
950:             .Value         = 0
951:             .Top           = 447
952:             .Left          = 372
953:             .Width         = 94
954:             .Height        = 24
955:             .InputMask     = "999.99"
956:             .FontName      = "Tahoma"
957:             .FontSize      = 8

*-- Linhas 1010 a 1028:
1010:                 loc_oGrid.Column11.Width = 75
1011: 
1012:                 *-- PROBLEMA 2/32/40: Headers APOS RecordSource, captions EXATOS do legado
1013:                 loc_oGrid.Column1.Header1.Caption  = "Vendedor"
1014:                 loc_oGrid.Column2.Header1.Caption  = "Nome"
1015:                 loc_oGrid.Column3.Header1.Caption  = "Empresa"
1016:                 loc_oGrid.Column4.Header1.Caption  = "Emp Reg"
1017:                 loc_oGrid.Column5.Header1.Caption  = "Grupo"
1018:                 loc_oGrid.Column6.Header1.Caption  = "Dt In" + CHR(237) + "cio"
1019:                 loc_oGrid.Column7.Header1.Caption  = "Dt Final"
1020:                 loc_oGrid.Column8.Header1.Caption  = "Situa" + CHR(231) + CHR(227) + "o"
1021:                 loc_oGrid.Column9.Header1.Caption  = "Cargo"
1022:                 loc_oGrid.Column10.Header1.Caption = "Usu" + CHR(225) + "rio"
1023:                 loc_oGrid.Column11.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
1024: 
1025:                 THIS.FormatarGridLista(loc_oGrid)
1026:                 loc_lResultado = .T.
1027:             ENDIF
1028: 

*-- Linhas 1326 a 1338:
1326:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1327: 
1328:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1329:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1330:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1331:             ENDIF
1332:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1333:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1334:             ENDIF
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     *===========================================================================


### BO (C:\4c\projeto\app\classes\VENBO.prg):
*====================================================================
* VENBO.prg
*
* Business Object para Vendedores
* Tabela principal: SigCdVen (codigo PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VENBO AS BusinessBase

	*-- Propriedades da entidade (SigCdVen)
	this_cCodigo    = ""   && codigo char(20)      - PK (codigo do vendedor)
	this_cEmps      = ""   && emps char(3)         - codigo da empresa/loja
	this_cGrupo     = ""   && gruvens char(10)     - grupo do vendedor
	this_cCodVens   = ""   && codvens char(10)     - codigo do vendedor (cliente)
	this_cNomeVen   = ""   && nomeven varchar(255) - nome do vendedor
	this_cUfs       = ""   && ufs char(2)          - estado
	this_dDtIni     = {}   && dtini datetime       - data inicial (NULL)
	this_dDtFin     = {}   && dtfin datetime       - data final (NULL)
	this_cSituas    = ""   && situas char(30)      - situacao
	this_cCargo     = ""   && cargo char(15)       - cargo
	this_nComis     = 0    && comis numeric(7,4)   - comissao %
	this_nSubsidio  = 0    && subsidio numeric(7,4) - subsidio %
	this_nPmeta     = 0    && pmeta numeric(7,4)   - meta %
	this_cFolga     = ""   && folga char(1)        - folga (S/N) - NOT NULL, sem campo na tela
	this_dDtAlts    = {}   && dtalts datetime      - data da ultima alteracao (NULL)
	this_cUsuAlts   = ""   && usualts char(10)     - usuario da ultima alteracao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdVen"
			THIS.this_cCampoChave = "codigo"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "VENBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo   = TratarNulo(codigo,   "")
				THIS.this_cEmps     = TratarNulo(emps,     "")
				THIS.this_cGrupo    = TratarNulo(gruvens,  "")
				THIS.this_cCodVens  = TratarNulo(codvens,  "")
				THIS.this_cNomeVen  = TratarNulo(nomeven,  "")
				THIS.this_cUfs      = TratarNulo(ufs,      "")
				THIS.this_dDtIni    = TratarNulo(dtini,    {})
				THIS.this_dDtFin    = TratarNulo(dtfin,    {})
				THIS.this_cSituas   = TratarNulo(situas,   "")
				THIS.this_cCargo    = TratarNulo(cargo,    "")
				THIS.this_nComis    = TratarNulo(comis,    0)
				THIS.this_nSubsidio = TratarNulo(subsidio, 0)
				THIS.this_nPmeta    = TratarNulo(pmeta,    0)
				THIS.this_cFolga    = TratarNulo(folga,    "")
				THIS.this_dDtAlts   = TratarNulo(dtalts,   {})
				THIS.this_cUsuAlts  = TratarNulo(usualts,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VENBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdVen (codigo, emps, gruvens, codvens, nomeven, ufs,
					dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga,
					dtalts, usualts)
				VALUES (
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cGrupo)>>,
					<<EscaparSQL(THIS.this_cCodVens)>>,
					<<EscaparSQL(THIS.this_cNomeVen)>>,
					<<EscaparSQL(THIS.this_cUfs)>>,
					<<FormatarDataSQL(THIS.this_dDtIni)>>,
					<<FormatarDataSQL(THIS.this_dDtFin)>>,
					<<EscaparSQL(THIS.this_cSituas)>>,
					<<EscaparSQL(THIS.this_cCargo)>>,
					<<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					<<EscaparSQL(THIS.this_cFolga)>>,
					GETDATE(),
					<<EscaparSQL(gc_4c_UsuarioLogado)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VENBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdVen
				SET emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					gruvens  = <<EscaparSQL(THIS.this_cGrupo)>>,
					codvens  = <<EscaparSQL(THIS.this_cCodVens)>>,
					nomeven  = <<EscaparSQL(THIS.this_cNomeVen)>>,
					ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
					dtini    = <<FormatarDataSQL(THIS.this_dDtIni)>>,
					dtfin    = <<FormatarDataSQL(THIS.this_dDtFin)>>,
					situas   = <<EscaparSQL(THIS.this_cSituas)>>,
					cargo    = <<EscaparSQL(THIS.this_cCargo)>>,
					comis    = <<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					subsidio = <<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					pmeta    = <<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					dtalts   = GETDATE(),
					usualts  = <<EscaparSQL(gc_4c_UsuarioLogado)>>
				WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VENBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdVen WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VENBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados espelhando as colunas do Grade legado
	* (Init: AddCursor lcQrycdVen + pColuna x11):
	* codigo, codvens, nome (SigCdUsu.ncomps), emps, empreg (SigCdCli.emps),
	* gruvens, dtini, dtfin, situas, cargo, usualts, dtalts
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigo C(20), codvens C(10), ;
						nome C(30), emps C(3), empreg C(3), gruvens C(10), ;
						dtini T, dtfin T, situas C(30), cargo C(15), ;
						usualts C(10), dtalts T)
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.codigo, a.codvens, ISNULL(b.ncomps,'') AS nome," + ;
					" a.emps, c.emps AS empreg, a.gruvens, a.dtini, a.dtfin," + ;
					" a.situas, a.cargo, a.usualts, a.dtalts" + ;
					" FROM SigCdVen a" + ;
					" LEFT JOIN SigCdUsu b ON a.codvens = b.usuarios" + ;
					" LEFT JOIN SigCdCli c ON a.gruvens = c.grupos AND a.codvens = c.iclis"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigo"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VENBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigo, emps, gruvens, codvens, nomeven, ufs," + ;
				" dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga," + ;
				" dtalts, usualts" + ;
				" FROM SigCdVen WHERE codigo = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VENBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


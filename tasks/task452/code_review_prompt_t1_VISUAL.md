# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, %. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, %. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, %. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, %. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormInf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1278 linhas total):

*-- Linhas 40 a 61:
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.Caption = "Cadastro de Informa" + CHR(231) + CHR(245) + ;
44:                            "es Complementares"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("InfBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar InfBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormInf.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Visible    = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual           = "LISTA"
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 84 a 103:
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .PageCount = 2
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = THIS.Width
90:             .Height    = THIS.Height + 29
91:             .Tabs      = .F.
92:             .Visible   = .T.
93: 
94:             .Page1.Caption   = "Lista"
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page1.BackColor = RGB(255, 255, 255)
97: 
98:             .Page2.Caption   = "Dados"
99:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.BackColor = RGB(255, 255, 255)
101:         ENDWITH
102: 
103:         THIS.ConfigurarPaginaLista()

*-- Linhas 119 a 157:
119:         *-- Top original=2 + compensacao PageFrame (+29) = 31
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .AutoSize  = .F.
135:             .Top       = 15
136:             .Left      = 10
137:             .Width     = 769
138:             .Height    = 40
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .ForeColor = RGB(0, 0, 0)
143:             .BackStyle = 0
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .AutoSize  = .F.
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 164 a 201:
164:         *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
165:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:         WITH loc_oPagina.cnt_4c_Botoes
167:             .Top         = 29
168:             .Left        = 542
169:             .Width       = 390
170:             .Height      = 85
171:             .BackStyle   = 0
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Container saida - PADRAO CANONICO (Left=917, Width=90, Height=85)
177:         *-- Legado: Grupo_Saida.Left=719, Top=-1 -> Ignorado (regra #10 CLAUDE.md)
178:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
179:         WITH loc_oPagina.cnt_4c_Saida
180:             .Top         = 29
181:             .Left        = 917
182:             .Width       = 90
183:             .Height      = 85
184:             .BackStyle   = 0
185:             .BorderWidth = 0
186:             .Visible     = .T.
187:         ENDWITH
188: 
189:         *-- Botoes dentro de cnt_4c_Botoes (5 botoes CRUD)
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
192:             .Caption         = "Incluir"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
194:             .PicturePosition = 13
195:             .Top             = 5
196:             .Left            = 5
197:             .Width           = 75
198:             .Height          = 75
199:             .BackColor       = RGB(255, 255, 255)
200:             .ForeColor       = RGB(90, 90, 90)
201:             .FontName        = "Tahoma"

*-- Linhas 210 a 224:
210:             .Visible         = .T.
211:         ENDWITH
212: 
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .FontName        = "Tahoma"

*-- Linhas 233 a 247:
233:             .Visible         = .T.
234:         ENDWITH
235: 
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
238:             .Caption         = "Alterar"
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
240:             .PicturePosition = 13
241:             .Top             = 5
242:             .Left            = 155
243:             .Width           = 75
244:             .Height          = 75
245:             .BackColor       = RGB(255, 255, 255)
246:             .ForeColor       = RGB(90, 90, 90)
247:             .FontName        = "Tahoma"

*-- Linhas 256 a 270:
256:             .Visible         = .T.
257:         ENDWITH
258: 
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .BackColor       = RGB(255, 255, 255)
269:             .ForeColor       = RGB(90, 90, 90)
270:             .FontName        = "Tahoma"

*-- Linhas 279 a 293:
279:             .Visible         = .T.
280:         ENDWITH
281: 
282:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Tahoma"

*-- Linhas 303 a 317:
303:         ENDWITH
304: 
305:         *-- Botao Encerrar no container saida (padrao canonico)
306:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
308:             .Caption         = "Encerrar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
310:             .PicturePosition = 13
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .BackColor       = RGB(255, 255, 255)
316:             .ForeColor       = RGB(90, 90, 90)
317:             .FontName        = "Tahoma"

*-- Linhas 333 a 342:
333:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
334: 
335:         WITH loc_oPagina.grd_4c_Lista
336:             .Top                = 117
337:             .Left               = 26
338:             .Width              = 890
339:             .Height             = 490
340:             .FontName           = "Verdana"
341:             .FontSize           = 8
342:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 352 a 371:
352:             .GridLines          = 3
353:             .Visible            = .T.
354:             .Column1.Width              = 60
355:             .Column1.Header1.Caption    = "C" + CHR(243) + "digo"
356:             .Column2.Width              = 820
357:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
358:         ENDWITH
359: 
360:         *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - Problem17)
361:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click",   THIS, "BtnIncluirClick")
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click",   THIS, "BtnVisualizarClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click",   THIS, "BtnAlterarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click",   THIS, "BtnExcluirClick")
365:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click",   THIS, "BtnBuscarClick")
366:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click",   THIS, "BtnEncerrarClick")
367:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "BtnVisualizarClick")
368: 
369:         THIS.TornarControlesVisiveis(loc_oPagina)
370:     ENDPROC
371: 

*-- Linhas 395 a 420:
395:         *-- Framework canonico: Top=33, Left=842, Width=160, Height=85
396:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao
398:             .Top         = 33
399:             .Left        = 842
400:             .Width       = 160
401:             .Height      = 85
402:             .BackStyle = 1
403:             .BackColor = RGB(255, 255, 255)
404:             .BorderWidth = 0
405:             .Visible     = .T.
406:         ENDWITH
407: 
408:         *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
409:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Tahoma"

*-- Linhas 429 a 444:
429:             .Visible         = .T.
430:         ENDWITH
431: 
432:         *-- Botao Cancelar (Cancelar.Left=80, Top=5 no legado)
433:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
434:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
435:             .Caption         = "Encerrar"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Tahoma"

*-- Linhas 454 a 466:
454:         ENDWITH
455: 
456:         *-- Label "Codigo :" (Say8: Left=238, Top=115 + 29 = 144)
457:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
458:         WITH loc_oPagina.lbl_4c_Codigo
459:             .Caption   = "C" + CHR(243) + "digo : "
460:             .Left      = 238
461:             .Top       = 144
462:             .Width     = 45
463:             .Height    = 17
464:             .FontName  = "Tahoma"
465:             .FontSize  = 8
466:             .FontBold  = .F.

*-- Linhas 474 a 498:
474:         loc_oPagina.AddObject("txt_4c_Info", "TextBox")
475:         WITH loc_oPagina.txt_4c_Info
476:             .Value     = ""
477:             .Left      = 287
478:             .Top       = 140
479:             .Width     = 20
480:             .Height    = 20
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .ForeColor = RGB(0, 0, 0)
484:             .MaxLength = 1
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         *-- Label "Descricao :" (Say7: Left=225, Top=139 + 29 = 168)
489:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
490:         WITH loc_oPagina.lbl_4c_Descricao
491:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
492:             .Left      = 225
493:             .Top       = 168
494:             .Width     = 58
495:             .Height    = 17
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .FontBold  = .F.

*-- Linhas 505 a 553:
505:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
506:         WITH loc_oPagina.txt_4c_Descr
507:             .Value     = ""
508:             .Left      = 287
509:             .Top       = 165
510:             .Width     = 115
511:             .Height    = 20
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(0, 0, 0)
515:             .MaxLength = 15
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- Label "Empresas :" (Say27: Left=217, Top=166 + 29 = 195, Width=66, Height=15)
520:         loc_oPagina.AddObject("lbl_4c_Empresas", "Label")
521:         WITH loc_oPagina.lbl_4c_Empresas
522:             .Caption   = "Empresas : "
523:             .Left      = 217
524:             .Top       = 195
525:             .Width     = 66
526:             .Height    = 15
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .FontBold  = .T.
530:             .BackStyle = 0
531:             .ForeColor = RGB(90, 90, 90)
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         *-- BINDEVENTs Confirmar/Cancelar (metodos PUBLIC - Problem17)
536:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
537:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
538: 
539:         *-- Grid de empresas vinculadas (Grade: top=164+29=193, left=287, width=161, height=330)
540:         *-- RecordSource/ColumnCount FORA do WITH para criar colunas imediatamente (Problema36)
541:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
542:         loc_oPagina.grd_4c_Dados.ColumnCount = 3
543:         loc_oPagina.grd_4c_Dados.RecordSource = "cursor_4c_Emps"
544:         loc_oPagina.grd_4c_Dados.ColumnCount  = 2
545: 
546:         WITH loc_oPagina.grd_4c_Dados
547:             .Top                = 193
548:             .Left               = 287
549:             .Width              = 161
550:             .Height             = 330
551:             .FontName           = "Verdana"
552:             .FontSize           = 8
553:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 564 a 602:
564:             .Visible            = .T.
565:             .Column1.ControlSource   = "cursor_4c_Emps.Emps"
566:             .Column1.Width           = 90
567:             .Column1.Header1.Caption = "Empresa"
568:             .Column2.ControlSource   = "cursor_4c_Emps.PercEmps"
569:             .Column2.Width           = 60
570:             .Column2.Header1.Caption = "%"
571:         ENDWITH
572: 
573:         *-- Botao Inserir linha (inserir: top=259+29=288, left=453, width=45, height=45)
574:         loc_oPagina.AddObject("cmd_4c_InsEmps", "CommandButton")
575:         WITH loc_oPagina.cmd_4c_InsEmps
576:             .Caption     = "+"
577:             .ToolTipText = "Inserir Empresa"
578:             .Top         = 288
579:             .Left        = 453
580:             .Width       = 45
581:             .Height      = 45
582:             .Themes      = .T.
583:             .FontName    = "Tahoma"
584:             .FontSize    = 12
585:             .FontBold    = .T.
586:             .ForeColor   = RGB(90, 90, 90)
587:             .BackColor   = RGB(255, 255, 255)
588:             .Visible     = .T.
589:         ENDWITH
590: 
591:         *-- Botao Excluir linha (excluir: top=303+29=332, left=453, width=45, height=45)
592:         loc_oPagina.AddObject("cmd_4c_DelEmps", "CommandButton")
593:         WITH loc_oPagina.cmd_4c_DelEmps
594:             .Caption     = "-"
595:             .ToolTipText = "Excluir Empresa"
596:             .Top         = 332
597:             .Left        = 453
598:             .Width       = 45
599:             .Height      = 45
600:             .Themes      = .T.
601:             .FontName    = "Tahoma"
602:             .FontSize    = 12

*-- Linhas 609 a 618:
609:         *-- BINDEVENTs grid e botoes de empresas (metodos PUBLIC - Problema17)
610:         BINDEVENT(loc_oPagina.grd_4c_Dados,   "KeyPress",          THIS, "GridEmpsKeyPress")
611:         BINDEVENT(loc_oPagina.grd_4c_Dados,   "AfterRowColChange", THIS, "GridEmpsAfterRowColChange")
612:         BINDEVENT(loc_oPagina.cmd_4c_InsEmps, "Click", THIS, "BtnInsEmpsClick")
613:         BINDEVENT(loc_oPagina.cmd_4c_DelEmps, "Click", THIS, "BtnDelEmpsClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *===========================================================================

*-- Linhas 675 a 687:
675: 
676:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Infos"
677:                     loc_oGrid.Column1.Width            = 60
678:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
679: 
680:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descrs"
681:                     loc_oGrid.Column2.Width            = 820
682:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
683: 
684:                     THIS.FormatarGridLista(loc_oGrid)
685:                 ENDIF
686:                 loc_lResultado = .T.
687:             ENDIF

*-- Linhas 995 a 1013:
995: 
996:         *-- Botao Confirmar habilitado apenas quando editando
997:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
998:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
999:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1000:             ENDIF
1001:         ENDIF
1002: 
1003:         *-- Botoes do grid de empresas (adicionados na Fase 6)
1004:         IF PEMSTATUS(loc_oPg2, "cmd_4c_InsEmps", 5)
1005:             loc_oPg2.cmd_4c_InsEmps.Enabled = par_lHabilitar
1006:         ENDIF
1007:         IF PEMSTATUS(loc_oPg2, "cmd_4c_DelEmps", 5)
1008:             loc_oPg2.cmd_4c_DelEmps.Enabled = par_lHabilitar
1009:         ENDIF
1010:     ENDPROC
1011: 
1012:     *===========================================================================
1013:     * LimparCampos - Limpa todos os campos do formulario

*-- Linhas 1221 a 1263:
1221:         *-- Page1: botoes CRUD (habilitados so na Lista)
1222:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1223:             WITH loc_oPg1.cnt_4c_Botoes
1224:                 IF PEMSTATUS(THIS, "cmd_4c_Incluir",    5)
1225:                     .cmd_4c_Incluir.Enabled    = .T.
1226:                 ENDIF
1227:                 IF PEMSTATUS(THIS, "cmd_4c_Visualizar", 5)
1228:                     .cmd_4c_Visualizar.Enabled = .T.
1229:                 ENDIF
1230:                 IF PEMSTATUS(THIS, "cmd_4c_Alterar",    5)
1231:                     .cmd_4c_Alterar.Enabled    = .T.
1232:                 ENDIF
1233:                 IF PEMSTATUS(THIS, "cmd_4c_Excluir",    5)
1234:                     .cmd_4c_Excluir.Enabled    = .T.
1235:                 ENDIF
1236:                 IF PEMSTATUS(THIS, "cmd_4c_Buscar",     5)
1237:                     .cmd_4c_Buscar.Enabled     = .T.
1238:                 ENDIF
1239:                 .Visible     = .T.
1240:             ENDWITH
1241:         ENDIF
1242: 
1243:         *-- Page2: Confirmar e Cancelar
1244:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1245:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1246:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1247:             ENDIF
1248:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1249:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1250:             ENDIF
1251:         ENDIF
1252: 
1253:         *-- Botoes de linha do grid de empresas
1254:         IF PEMSTATUS(loc_oPg2, "cmd_4c_InsEmps", 5)
1255:             loc_oPg2.cmd_4c_InsEmps.Enabled = loc_lEditando
1256:         ENDIF
1257:         IF PEMSTATUS(loc_oPg2, "cmd_4c_DelEmps", 5)
1258:             loc_oPg2.cmd_4c_DelEmps.Enabled = loc_lEditando
1259:         ENDIF
1260:     ENDPROC
1261: 
1262:     *===========================================================================
1263:     * Destroy - Libera recursos do formulario


### BO (C:\4c\projeto\app\classes\InfBO.prg):
*==============================================================================
* InfBO.prg - Business Object: Cadastro de Informações Complementares
* Tabela principal : SigPrInf (infos C(1), descrs C(15))
* Tabela secundária: SigEmInf (Infos FK, Emps, PercEmps, pkChave)
*==============================================================================
DEFINE CLASS InfBO AS BusinessBase

    *-- Propriedades da entidade (SigPrInf)
    this_cInfos  = ""    && C(1)  - Codigo da informacao (PK)
    this_cDescrs = ""    && C(15) - Descricao da informacao

*------------------------------------------------------------------------------
* Init - Configura propriedades base do BO
*------------------------------------------------------------------------------
PROCEDURE Init()
    DODEFAULT()
    THIS.this_cTabela     = "SigPrInf"
    THIS.this_cCampoChave = "Infos"
    RETURN .T.
ENDPROC

*------------------------------------------------------------------------------
* ObterChavePrimaria - Retorna valor da chave primária para auditoria
*------------------------------------------------------------------------------
PROCEDURE ObterChavePrimaria()
    RETURN THIS.this_cInfos
ENDPROC

*------------------------------------------------------------------------------
* Buscar - Carrega lista de informações em cursor_4c_Dados
*------------------------------------------------------------------------------
PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "SELECT Infos, Descrs FROM SigPrInf"
        IF !EMPTY(ALLTRIM(par_cFiltro))
            loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY Infos"

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
        IF loc_nResultado >= 0
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao buscar informa" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarPorCodigo - Carrega registro pelo código de informação
*------------------------------------------------------------------------------
PROCEDURE CarregarPorCodigo(par_cInfos)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "SELECT Infos, Descrs FROM SigPrInf WHERE Infos = " + EscaparSQL(par_cInfos)

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
        IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            THIS.this_lNovoRegistro = .F.
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
    ENDIF

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
*------------------------------------------------------------------------------
PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.

    IF USED(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cInfos  = TratarNulo(Infos,  "C")
        THIS.this_cDescrs = TratarNulo(Descrs, "C")
        loc_lSucesso = .T.
    ENDIF

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* VerificarCodigoDuplicado - Verifica se código já existe em SigPrInf
*------------------------------------------------------------------------------
PROCEDURE VerificarCodigoDuplicado(par_cInfos)
    LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
    loc_lDuplicado = .F.

    TRY
        loc_cSQL = "SELECT COUNT(*) AS Total FROM SigPrInf WHERE Infos = " + EscaparSQL(par_cInfos)
        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
        IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
            SELECT cursor_4c_ChkDup
            loc_lDuplicado = (Total > 0)
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    IF USED("cursor_4c_ChkDup")
        USE IN cursor_4c_ChkDup
    ENDIF

    RETURN loc_lDuplicado
ENDPROC

*------------------------------------------------------------------------------
* Inserir - INSERT INTO SigPrInf
*------------------------------------------------------------------------------
PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "INSERT INTO SigPrInf (Infos, Descrs)" + ;
                   " VALUES (" + EscaparSQL(THIS.this_cInfos) + ;
                   ", " + EscaparSQL(THIS.this_cDescrs) + ")"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("INSERT")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao inserir informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* Atualizar - UPDATE SigPrInf
*------------------------------------------------------------------------------
PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "UPDATE SigPrInf SET Descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                   " WHERE Infos = " + EscaparSQL(THIS.this_cInfos)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao atualizar informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* ExecutarExclusao - DELETE FROM SigEmInf + SigPrInf (transação atômica)
* Empresas vinculadas excluídas primeiro (integridade referencial)
*------------------------------------------------------------------------------
PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQLEmInf, loc_cSQLPrInf, loc_nRes1, loc_nRes2, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQLEmInf = "DELETE FROM SigEmInf WHERE Infos = " + EscaparSQL(THIS.this_cInfos)
        loc_cSQLPrInf = "DELETE FROM SigPrInf WHERE Infos = " + EscaparSQL(THIS.this_cInfos)

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
        loc_nRes1 = SQLEXEC(gnConnHandle, loc_cSQLEmInf)
        loc_nRes2 = SQLEXEC(gnConnHandle, loc_cSQLPrInf)

        IF loc_nRes1 >= 0 AND loc_nRes2 >= 0
            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.
        ELSE
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MostrarErro("Erro ao excluir informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarEmpresas - Carrega empresas vinculadas à informação em cursor local
* par_cInfos : código da informação
* par_cCursor: nome do cursor destino (ex: "cursor_4c_Emps")
*------------------------------------------------------------------------------
PROCEDURE CarregarEmpresas(par_cInfos, par_cCursor)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_cSQL = "SELECT Emps, PercEmps FROM SigEmInf" + ;
                   " WHERE Infos = " + EscaparSQL(par_cInfos) + ;
                   " ORDER BY Emps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (par_cCursor))
        IF loc_nResultado >= 0
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* SalvarEmpresas - Sincroniza empresas do cursor local para SigEmInf
* Deleta todas as empresas do Infos e re-insere as não-vazias do cursor
* par_cInfos : código da informação
* par_cCursor: nome do cursor local com os dados (Emps, PercEmps)
*------------------------------------------------------------------------------
PROCEDURE SalvarEmpresas(par_cInfos, par_cCursor)
    LOCAL loc_cSQLDel, loc_cSQLIns, loc_nRes, loc_lSucesso, loc_lErroInsert
    LOCAL loc_cEmps, loc_nPercEmps
    loc_lSucesso = .F.

    IF !USED(par_cCursor)
        RETURN .F.
    ENDIF

    TRY
        loc_cSQLDel = "DELETE FROM SigEmInf WHERE Infos = " + EscaparSQL(par_cInfos)

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQLDel)

        IF loc_nRes < 0
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MostrarErro("Erro ao limpar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ELSE
            loc_lErroInsert = .F.
            SELECT (par_cCursor)
            GO TOP
            DO WHILE !EOF() AND !loc_lErroInsert
                loc_cEmps     = ALLTRIM(Emps)
                loc_nPercEmps = PercEmps
                IF !EMPTY(loc_cEmps)
                    loc_cSQLIns = "INSERT INTO SigEmInf (Infos, Emps, PercEmps, pkChave)" + ;
                                  " VALUES (" + EscaparSQL(par_cInfos) + ;
                                  ", " + EscaparSQL(loc_cEmps) + ;
                                  ", " + FormatarNumeroSQL(loc_nPercEmps) + ;
                                  ", CONVERT(VARCHAR(36), NEWID()))"
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQLIns)
                    IF loc_nRes < 0
                        loc_lErroInsert = .T.
                    ENDIF
                ENDIF
                SKIP
            ENDDO

            IF loc_lErroInsert
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                MostrarErro("Erro ao inserir empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                loc_lSucesso = .T.
            ENDIF
        ENDIF
    CATCH TO loc_oErro
        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

ENDDEFINE


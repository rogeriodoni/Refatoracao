# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (12)
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês/Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Titulo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês/Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Titulo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês/Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Titulo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOrc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1714 linhas total):

*-- Linhas 46 a 65:
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             THIS.Caption = "Or" + CHR(231) + "amento"
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("OrcBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar OrcBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormOrc.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Visible    = .T.
62:                 THIS.pgf_4c_Paginas.ActivePage = 1
63:                 THIS.this_cModoAtual = "LISTA"
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 88 a 107:
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 120 a 157:
120:         *-- Container Cabecalho (cntSombra no legado, Top=1+29=30)
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top           = 30
124:             .Left          = 0
125:             .Width         = THIS.Width
126:             .Height        = 80
127:             .BackColor     = RGB(100, 100, 100)
128:             .BorderWidth   = 0
129:             .SpecialEffect = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = 769
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .AutoSize  = .F.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 163 a 186:
163:         *-- Container Botoes CRUD (Grupo_Op no legado, Top=0+29=29)
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .FontName        = "Tahoma"

*-- Linhas 194 a 208:
194:             .AutoSize        = .F.
195:         ENDWITH
196: 
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .FontName        = "Tahoma"

*-- Linhas 216 a 230:
216:             .AutoSize        = .F.
217:         ENDWITH
218: 
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .BackColor       = RGB(255, 255, 255)
229:             .ForeColor       = RGB(90, 90, 90)
230:             .FontName        = "Tahoma"

*-- Linhas 238 a 252:
238:             .AutoSize        = .F.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Tahoma"

*-- Linhas 260 a 274:
260:             .AutoSize        = .F.
261:         ENDWITH
262: 
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
265:             .Caption         = "Buscar"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 305
270:             .Width           = 75
271:             .Height          = 75
272:             .BackColor       = RGB(255, 255, 255)
273:             .ForeColor       = RGB(90, 90, 90)
274:             .FontName        = "Tahoma"

*-- Linhas 285 a 308:
285:         *-- Container Saida canonico (Left=917, Width=90, cmd Width=75)
286:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
287:         WITH loc_oPagina.cnt_4c_Saida
288:             .Top         = 29
289:             .Left        = 917
290:             .Width       = 90
291:             .Height      = 85
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294:             .Visible     = .T.
295:         ENDWITH
296: 
297:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
298:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
299:             .Caption         = "Encerrar"
300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:             .PicturePosition = 13
302:             .Top             = 5
303:             .Left            = 5
304:             .Width           = 75
305:             .Height          = 75
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .FontName        = "Tahoma"

*-- Linhas 317 a 331:
317:         ENDWITH
318: 
319:         *-- Botao Copiar (cmdCopiar legado: Top=78+29=107, Left=614, W=115, H=55)
320:         loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
321:         WITH loc_oPagina.cmd_4c_Copiar
322:             .Caption         = "Copiar"
323:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
324:             .PicturePosition = 13
325:             .Top             = 107
326:             .Left            = 614
327:             .Width           = 115
328:             .Height          = 55
329:             .BackColor       = RGB(255, 255, 255)
330:             .ForeColor       = RGB(90, 90, 90)
331:             .FontName        = "Tahoma"

*-- Linhas 344 a 353:
344:         loc_oPagina.grd_4c_Lista.RecordSource = ""
345:         loc_oPagina.grd_4c_Lista.ColumnCount  = 4
346:         WITH loc_oPagina.grd_4c_Lista
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 890
350:             .Height             = 450
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 365 a 393:
365:         ENDWITH
366: 
367:         WITH loc_oPagina.grd_4c_Lista
368:             .Column1.Header1.Caption = "Empresa"
369:             .Column1.Width           = 45
370: 
371:             .Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
372:             .Column2.Width           = 59
373: 
374:             .Column3.Header1.Caption = "Titulo"
375:             .Column3.Width           = 290
376: 
377:             .Column4.Header1.Caption = "Moeda"
378:             .Column4.Width           = 40
379:         ENDWITH
380: 
381:         *-- BINDEVENTs dos botoes (PUBLIC methods - sem PROTECTED)
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
388:         BINDEVENT(loc_oPagina.cmd_4c_Copiar,                   "Click", THIS, "BtnCopiarClick")
389: 
390:         THIS.TornarControlesVisiveis(loc_oPagina)
391:     ENDPROC
392: 
393:     *===========================================================================

*-- Linhas 402 a 429:
402:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
403: 
404:         *-- Container botoes acao (Confirmar/Cancelar)
405:         *-- Original: Grupo_Salva.Top=4. Com compensacao +29: Top=33
406:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao
408:             .Top         = 33
409:             .Left        = 842
410:             .Width       = 160
411:             .Height      = 85
412:             .BackStyle = 1
413:             .BackColor = RGB(255, 255, 255)
414:             .BorderWidth = 0
415:             .Visible     = .T.
416:         ENDWITH
417: 
418:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
419:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
420:             .Caption         = "Confirmar"
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
422:             .PicturePosition = 13
423:             .Top             = 5
424:             .Left            = 5
425:             .Width           = 75
426:             .Height          = 75
427:             .BackColor       = RGB(255, 255, 255)
428:             .ForeColor       = RGB(90, 90, 90)
429:             .FontName        = "Tahoma"

*-- Linhas 437 a 451:
437:             .AutoSize        = .F.
438:         ENDWITH
439: 
440:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
441:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
442:             .Caption         = "Encerrar"
443:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
444:             .PicturePosition = 13
445:             .Top             = 5
446:             .Left            = 80
447:             .Width           = 75
448:             .Height          = 75
449:             .BackColor       = RGB(255, 255, 255)
450:             .ForeColor       = RGB(90, 90, 90)
451:             .FontName        = "Tahoma"

*-- Linhas 460 a 472:
460:         ENDWITH
461: 
462:         *-- Label "Emp:" (Say6 - Top=164+29=193, Left=32)
463:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
464:         WITH loc_oPagina.lbl_4c_Label6
465:             .Caption   = "Emp:"
466:             .Top       = 193
467:             .Left      = 32
468:             .Width     = 30
469:             .Height    = 17
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 478 a 500:
478:         loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
479:         WITH loc_oPagina.txt_4c_Emps
480:             .Value     = ""
481:             .Top       = 189
482:             .Left      = 65
483:             .Width     = 31
484:             .Height    = 23
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8
487:             .MaxLength = 3
488:         ENDWITH
489: 
490:         *-- Label "Mes:" (Say1 - Top=165+29=194, Left=104)
491:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
492:         WITH loc_oPagina.lbl_4c_Label1
493:             .Caption   = "M" + CHR(234) + "s:"
494:             .Top       = 194
495:             .Left      = 104
496:             .Width     = 26
497:             .Height    = 17
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 506 a 528:
506:         loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
507:         WITH loc_oPagina.txt_4c_Mes
508:             .Value     = ""
509:             .Top       = 189
510:             .Left      = 133
511:             .Width     = 24
512:             .Height    = 23
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .MaxLength = 2
516:         ENDWITH
517: 
518:         *-- Label "Ano:" (Say4 - Top=165+29=194, Left=165)
519:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
520:         WITH loc_oPagina.lbl_4c_Label4
521:             .Caption   = "Ano:"
522:             .Top       = 194
523:             .Left      = 165
524:             .Width     = 26
525:             .Height    = 17
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 534 a 556:
534:         loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
535:         WITH loc_oPagina.txt_4c_Ano
536:             .Value     = ""
537:             .Top       = 189
538:             .Left      = 193
539:             .Width     = 38
540:             .Height    = 23
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:             .MaxLength = 4
544:         ENDWITH
545: 
546:         *-- Label "Titulo :" (Say5 - Top=165+29=194, Left=238)
547:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
548:         WITH loc_oPagina.lbl_4c_Label5
549:             .Caption   = "T" + CHR(237) + "tulo :"
550:             .Top       = 194
551:             .Left      = 238
552:             .Width     = 38
553:             .Height    = 17
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 562 a 584:
562:         loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
563:         WITH loc_oPagina.txt_4c_Titulo
564:             .Value     = ""
565:             .Top       = 189
566:             .Left      = 278
567:             .Width     = 280
568:             .Height    = 23
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .MaxLength = 40
572:         ENDWITH
573: 
574:         *-- Label "Moeda :" (lbl_moeda - Top=165+29=194, Left=563, Width=41)
575:         loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
576:         WITH loc_oPagina.lbl_4c_Lbl_moeda
577:             .Caption   = "Moeda :"
578:             .Top       = 194
579:             .Left      = 563
580:             .Width     = 41
581:             .Height    = 17
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 590 a 625:
590:         loc_oPagina.AddObject("txt_4c_Cd_Moeda", "TextBox")
591:         WITH loc_oPagina.txt_4c_Cd_Moeda
592:             .Value     = ""
593:             .Top       = 189
594:             .Left      = 609
595:             .Width     = 31
596:             .Height    = 23
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .MaxLength = 3
600:         ENDWITH
601: 
602:         *-- TextBox Descricao Moeda (get_ds_moeda - Top=160+29=189, Left=643, Width=115, Height=23)
603:         loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
604:         WITH loc_oPagina.txt_4c__ds_moeda
605:             .Value     = ""
606:             .Top       = 189
607:             .Left      = 643
608:             .Width     = 115
609:             .Height    = 23
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .MaxLength = 40
613:         ENDWITH
614: 
615:         *-- Label "Total Orcado :" (Say7 - Top=192+29=221, Left=50, Height=15)
616:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
617:         WITH loc_oPagina.lbl_4c_Label7
618:             .Caption   = "Total Or" + CHR(231) + "ado :"
619:             .Top       = 221
620:             .Left      = 50
621:             .Width     = 80
622:             .Height    = 15
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 631 a 653:
631:         loc_oPagina.AddObject("txt_4c__nVlTots", "TextBox")
632:         WITH loc_oPagina.txt_4c__nVlTots
633:             .Value     = 0
634:             .Top       = 216
635:             .Left      = 132
636:             .Width     = 135
637:             .Height    = 23
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .InputMask = "999,999,999.99"
641:         ENDWITH
642: 
643:         *-- Label "Grupos" (Say2 - Top=214+29=243, Left=35, Width=54, Height=18)
644:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
645:         WITH loc_oPagina.lbl_4c_Label2
646:             .Caption   = "Grupos"
647:             .Top       = 243
648:             .Left      = 35
649:             .Width     = 54
650:             .Height    = 18
651:             .FontName  = "Tahoma"
652:             .FontSize  = 8
653:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 660 a 669:
660:         loc_oPagina.grd_4c_Grupos.RecordSource = ""
661:         loc_oPagina.grd_4c_Grupos.ColumnCount  = 4
662:         WITH loc_oPagina.grd_4c_Grupos
663:             .Top                = 262
664:             .Left               = 36
665:             .Width              = 719
666:             .Height             = 116
667:             .FontName           = "Verdana"
668:             .FontSize           = 8
669:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 677 a 704:
677:             .RowHeight          = 16
678:             .ScrollBars         = 2
679:             .GridLines          = 3
680:             .Column1.Header1.Caption = "Grupo"
681:             .Column1.Width           = 80
682:             .Column1.ReadOnly        = .T.
683:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
684:             .Column2.Width           = 300
685:             .Column2.ReadOnly        = .T.
686:             .Column3.Header1.Caption = "Valor"
687:             .Column3.Width           = 170
688:             .Column3.Alignment       = 1
689:             .Column4.Header1.Caption = "%"
690:             .Column4.Width           = 100
691:             .Column4.Alignment       = 1
692:         ENDWITH
693: 
694:         *-- Label "Contas" (Say3 - Top=362+29=391, Left=39, Width=54, Height=18)
695:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
696:         WITH loc_oPagina.lbl_4c_Label3
697:             .Caption   = "Contas"
698:             .Top       = 391
699:             .Left      = 39
700:             .Width     = 54
701:             .Height    = 18
702:             .FontName  = "Tahoma"
703:             .FontSize  = 8
704:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 711 a 720:
711:         loc_oPagina.grd_4c_Contas.RecordSource = ""
712:         loc_oPagina.grd_4c_Contas.ColumnCount  = 4
713:         WITH loc_oPagina.grd_4c_Contas
714:             .Top                = 409
715:             .Left               = 36
716:             .Width              = 719
717:             .Height             = 132
718:             .FontName           = "Verdana"
719:             .FontSize           = 8
720:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 728 a 755:
728:             .RowHeight          = 16
729:             .ScrollBars         = 2
730:             .GridLines          = 3
731:             .Column1.Header1.Caption = "Conta"
732:             .Column1.Width           = 80
733:             .Column1.ReadOnly        = .T.
734:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
735:             .Column2.Width           = 300
736:             .Column2.ReadOnly        = .T.
737:             .Column3.Header1.Caption = "Valor"
738:             .Column3.Width           = 170
739:             .Column3.Alignment       = 1
740:             .Column4.Header1.Caption = "%"
741:             .Column4.Width           = 100
742:             .Column4.Alignment       = 1
743:         ENDWITH
744: 
745:         *-- Label "Total Lancado :" (Say8 - Top=528+29=557, Left=399, Width=87)
746:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
747:         WITH loc_oPagina.lbl_4c_Label8
748:             .Caption   = "Total Lan" + CHR(231) + "ado :"
749:             .Top       = 557
750:             .Left      = 399
751:             .Width     = 87
752:             .Height    = 17
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 761 a 770:
761:         loc_oPagina.AddObject("txt_4c_TotLancado", "TextBox")
762:         WITH loc_oPagina.txt_4c_TotLancado
763:             .Value     = 0
764:             .Top       = 552
765:             .Left      = 488
766:             .Width     = 125
767:             .Height    = 23
768:             .FontName  = "Tahoma"
769:             .FontSize  = 8
770:             .ReadOnly  = .T.

*-- Linhas 782 a 791:
782:         BINDEVENT(loc_oPagina.grd_4c_Contas,    "AfterRowColChange", THIS, "ContasAfterRowColChange")
783: 
784:         *-- BINDEVENTs dos botoes Page2
785:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
786:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
787: 
788:         THIS.TornarControlesVisiveis(loc_oPagina)
789:     ENDPROC
790: 
791:     *===========================================================================

*-- Linhas 813 a 824:
813:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"
814: 
815:                     *-- Reconfigurar cabecalhos apos RecordSource (obrigatorio - RecordSource reseta)
816:                     loc_oGrid.Column1.Header1.Caption = "Empresa"
817:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
818:                     loc_oGrid.Column3.Header1.Caption = "Titulo"
819:                     loc_oGrid.Column4.Header1.Caption = "Moeda"
820: 
821:                     loc_oGrid.Column1.Width = 45
822:                     loc_oGrid.Column2.Width = 59
823:                     loc_oGrid.Column3.Width = 290
824:                     loc_oGrid.Column4.Width = 40

*-- Linhas 1000 a 1011:
1000:             loc_oGrid.Column2.ControlSource = [ALLTRIM(cursor_4c_Dados.cmes) + IIF(!EMPTY(cursor_4c_Dados.cmes), "/", "") + ALLTRIM(cursor_4c_Dados.cano)]
1001:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ctitulo"
1002:             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"
1003:             loc_oGrid.Column1.Header1.Caption = "Empresa"
1004:             loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
1005:             loc_oGrid.Column3.Header1.Caption = "Titulo"
1006:             loc_oGrid.Column4.Header1.Caption = "Moeda"
1007:             loc_oGrid.Refresh()
1008:         ELSE
1009:             MsgAviso("Nenhum or" + CHR(231) + "amento encontrado.", "Busca")
1010:         ENDIF
1011:     ENDPROC

*-- Linhas 1123 a 1134:
1123:                 loc_oGrdGrupos.Column2.ControlSource = "cursor_4c_Grupos.descrs"
1124:                 loc_oGrdGrupos.Column3.ControlSource = "cursor_4c_Grupos.Valor"
1125:                 loc_oGrdGrupos.Column4.ControlSource = "cursor_4c_Grupos.Perc"
1126:                 loc_oGrdGrupos.Column1.Header1.Caption = "Grupo"
1127:                 loc_oGrdGrupos.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1128:                 loc_oGrdGrupos.Column3.Header1.Caption = "Valor"
1129:                 loc_oGrdGrupos.Column4.Header1.Caption = "%"
1130:                 loc_oGrdGrupos.Column1.Width = 80
1131:                 loc_oGrdGrupos.Column2.Width = 300
1132:                 loc_oGrdGrupos.Column3.Width = 170
1133:                 loc_oGrdGrupos.Column4.Width = 100
1134:                 GO TOP IN cursor_4c_Grupos

*-- Linhas 1145 a 1156:
1145:                 loc_oGrdContas.Column2.ControlSource = "cursor_4c_Contas.rclis"
1146:                 loc_oGrdContas.Column3.ControlSource = "cursor_4c_Contas.Valor"
1147:                 loc_oGrdContas.Column4.ControlSource = "cursor_4c_Contas.Perc"
1148:                 loc_oGrdContas.Column1.Header1.Caption = "Conta"
1149:                 loc_oGrdContas.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1150:                 loc_oGrdContas.Column3.Header1.Caption = "Valor"
1151:                 loc_oGrdContas.Column4.Header1.Caption = "%"
1152:                 loc_oGrdContas.Column1.Width = 80
1153:                 loc_oGrdContas.Column2.Width = 300
1154:                 loc_oGrdContas.Column3.Width = 170
1155:                 loc_oGrdContas.Column4.Width = 100
1156: 

*-- Linhas 1269 a 1278:
1269:             ENDIF
1270: 
1271:             *-- Botoes
1272:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit
1273:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1274:         CATCH TO loException
1275:             MostrarErro(loException, "FormOrc.HabilitarCampos")
1276:         ENDTRY
1277:     ENDPROC
1278: 

*-- Linhas 1690 a 1711:
1690:         TRY
1691:             *-- Botoes CRUD da Page1: habilitados apenas quando na lista
1692:             WITH loc_oPg1.cnt_4c_Botoes
1693:                 .cmd_4c_Incluir.Enabled    = loc_lNaLista
1694:                 .cmd_4c_Visualizar.Enabled = loc_lNaLista
1695:                 .cmd_4c_Alterar.Enabled    = loc_lNaLista
1696:                 .cmd_4c_Excluir.Enabled    = loc_lNaLista
1697:                 .cmd_4c_Buscar.Enabled     = loc_lNaLista
1698:                 .Visible     = .T.
1699:             ENDWITH
1700:             loc_oPg1.cmd_4c_Copiar.Enabled = loc_lNaLista
1701: 
1702:             *-- Botoes da Page2: Confirmar habilitado so em INCLUIR/ALTERAR
1703:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1704:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1705:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1706:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
1707:             ENDIF
1708: 
1709:         CATCH TO loException
1710:             MostrarErro(loException, "FormOrc.AjustarBotoesPorModo")
1711:         ENDTRY


### BO (C:\4c\projeto\app\classes\OrcBO.prg):
*====================================================================
* OrcBO.prg
*
* Business Object para Orc (Orcamento/Previsao)
* Tabela: SigCdMrp (multi-linha: uma por grupo/conta)
*
* Chave composta do "cabecalho": cEmps + cMes + cAno + cTitulo + Moeda
* Chave de linha: cIdChaves (UUID gerado por fUniqueIds)
*
* Estrutura SigCdMrp:
*   cemps     - Empresa       (C(3))
*   cmes      - Mes           (C(2))
*   cano      - Ano           (C(4))
*   ctitulo   - Titulo        (C(40))
*   moeda     - Cod. Moeda    (C(3))
*   nvltots   - Total orcado  (N(15,2))
*   cgrupos   - Cod. Grupo    (C(10)) - linha de grupo
*   iclis     - Cod. Cliente  (C(10)) - linha de conta
*   nvalors   - Valor         (N(15,2))
*   npercs    - Percentual    (N(9,6))
*   cidchaves - ID unico linha (C(20))
*====================================================================

DEFINE CLASS OrcBO AS BusinessBase

	*-- ==========================================
	*-- Propriedades do cabecalho (identificacao)
	*-- ==========================================
	this_cEmps      = ""  && Empresa (C(3))
	this_cMes       = ""  && Mes (C(2)) - "01" a "12"
	this_cAno       = ""  && Ano (C(4)) - "2026"
	this_cTitulo    = ""  && Titulo da previsao (C(40))
	this_cMoeda     = ""  && Codigo da moeda (C(3))
	this_cDescMoeda = ""  && Descricao da moeda - de SigCdMoe.dmoes
	this_nVlTots    = 0   && Total orcado (N(15,2))

	*-- ==========================================
	*-- Propriedades de linha (detalhe)
	*-- ==========================================
	this_cIdChaves  = ""  && ID unico da linha - gerado por fUniqueIds
	this_cGrupos    = ""  && Codigo do grupo - SigCdGcr.codigos
	this_cIClis     = ""  && Codigo da conta/cliente - SigCdCli.iclis
	this_nValors    = 0   && Valor alocado (N(15,2))
	this_nPercs     = 0   && Percentual alocado (N(9,6))

	*-- ==========================================
	*-- Propriedades de controle interno
	*-- ==========================================
	this_cChaveCompostaAnterior = ""  && Chave antes de edicao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = DODEFAULT()

			THIS.this_cTabela     = "SigCdMrp"
			THIS.this_cCampoChave = "cIdChaves"

		CATCH TO loException
			MsgErro("Erro em OrcBO.Init: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave composta para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEmps) + "+" + ;
		       ALLTRIM(THIS.this_cMes)  + "+" + ;
		       ALLTRIM(THIS.this_cAno)  + "+" + ;
		       ALLTRIM(THIS.this_cTitulo) + "+" + ;
		       ALLTRIM(THIS.this_cMoeda)
	ENDPROC

	*====================================================================
	* Buscar - Carrega cursor_4c_Dados com lista agrupada de orcamentos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cWhere = " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			IF !EMPTY(par_cFiltro)
				loc_cWhere = loc_cWhere + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
			           "MAX(cidchaves) AS cidchaves " + ;
			           "FROM SIGCDMRP" + ;
			           loc_cWhere + ;
			           " GROUP BY cemps, cmes, cano, ctitulo, moeda, nvltots" + ;
			           " ORDER BY cano, cmes, ctitulo"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
				USE IN cursor_4c_DadosTmp
				GO TOP IN cursor_4c_Dados
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar or" + CHR(231) + "amentos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEmps     = ALLTRIM(cemps)
				THIS.this_cMes      = ALLTRIM(cmes)
				THIS.this_cAno      = ALLTRIM(cano)
				THIS.this_cTitulo   = ALLTRIM(ctitulo)
				THIS.this_cMoeda    = ALLTRIM(moeda)
				THIS.this_nVlTots   = nvltots
				THIS.this_cIdChaves = ALLTRIM(cidchaves)

				THIS.this_cChaveCompostaAnterior = THIS.ObterChavePrimaria()

				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro por cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, cidchaves " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cidchaves = " + EscaparSQL(par_cChave)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodTmp")
			IF loc_nResult > 0 AND !EOF("cursor_4c_CodTmp")
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CodTmp")
				THIS.this_lNovoRegistro = .F.
			ELSE
				THIS.this_cUltimoErro = "Registro n" + CHR(227) + "o encontrado."
			ENDIF

			IF USED("cursor_4c_CodTmp")
				USE IN cursor_4c_CodTmp
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor_4c_Grupos de SigCdGcr (READWRITE)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_cSQL = "SELECT codigos, descrs, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SigCdGcr " + ;
			           "ORDER BY codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_GrpTmp INTO CURSOR cursor_4c_Grupos READWRITE
				USE IN cursor_4c_GrpTmp
				GO TOP IN cursor_4c_Grupos
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar grupos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor_4c_Contas de SIGCDCLI (READWRITE)
	*====================================================================
	PROCEDURE BuscarContas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_cSQL = "SELECT grupos, iclis, rclis, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SIGCDCLI " + ;
			           "ORDER BY rclis"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_CtaTmp INTO CURSOR cursor_4c_Contas READWRITE
				USE IN cursor_4c_CtaTmp
				GO TOP IN cursor_4c_Contas
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar contas."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDetalhe - Popula Valor/Perc em cursor_4c_Grupos e cursor_4c_Contas
	*                   com os valores existentes no BD para o orcamento atual
	*====================================================================
	PROCEDURE CarregarDetalhe()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cGrupo, loc_cConta, loc_nValor, loc_nPerc
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cgrupos, iclis, nvalors, npercs " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")
			IF loc_nResult > 0
				SELECT cursor_4c_Detalhe
				SCAN
					loc_cGrupo = ALLTRIM(cgrupos)
					loc_cConta = ALLTRIM(iclis)
					loc_nValor = nvalors
					loc_nPerc  = npercs

					IF !EMPTY(loc_cGrupo) AND USED("cursor_4c_Grupos")
						SELECT cursor_4c_Grupos
						LOCATE FOR ALLTRIM(codigos) == loc_cGrupo
						IF FOUND("cursor_4c_Grupos")
							SELECT cursor_4c_Grupos
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF

					IF !EMPTY(loc_cConta) AND USED("cursor_4c_Contas")
						SELECT cursor_4c_Contas
						LOCATE FOR ALLTRIM(iclis) == loc_cConta
						IF FOUND("cursor_4c_Contas")
							SELECT cursor_4c_Contas
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF
				ENDSCAN

				IF USED("cursor_4c_Detalhe")
					USE IN cursor_4c_Detalhe
				ENDIF

				IF USED("cursor_4c_Grupos")
					GO TOP IN cursor_4c_Grupos
				ENDIF
				IF USED("cursor_4c_Contas")
					GO TOP IN cursor_4c_Contas
				ENDIF
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Retorna .T. se chave composta ja existe no BD
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
			IF loc_nResult > 0
				SELECT cursor_4c_DupChk
				loc_lResultado = (qtde > 0)
				USE IN cursor_4c_DupChk
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterDescricaoMoeda - Retorna SigCdMoe.dmoes para o codigo informado
	*====================================================================
	PROCEDURE ObterDescricaoMoeda(par_cCodMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResult
		loc_cDescricao = ""

		TRY
			IF !EMPTY(par_cCodMoeda)
				loc_cSQL = "SELECT dmoes FROM SigCdMoe " + ;
				           "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodMoeda))

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
				IF loc_nResult > 0 AND !EOF("cursor_4c_Moeda")
					SELECT cursor_4c_Moeda
					loc_cDescricao = ALLTRIM(dmoes)
				ENDIF
				IF USED("cursor_4c_Moeda")
					USE IN cursor_4c_Moeda
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDPROC

	*====================================================================
	* EfetuarSalvamento - Delta save de grupos e contas em SIGCDMRP
	*   Para cada grupo/conta: faz UPDATE se ja existe, INSERT se novo
	*   Para ALTERAR: deleta previamente linhas zeradas (removidas pelo usuario)
	*====================================================================
	PROTECTED PROCEDURE EfetuarSalvamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda, loc_nVlTots
		LOCAL loc_cCodigo, loc_cIdChaves, loc_cOper, loc_lOk
		loc_lResultado = .F.

		TRY
			loc_lOk     = .T.
			loc_cEmps   = EscaparSQL(ALLTRIM(THIS.this_cEmps))
			loc_cMes    = EscaparSQL(ALLTRIM(THIS.this_cMes))
			loc_cAno    = EscaparSQL(ALLTRIM(THIS.this_cAno))
			loc_cTitulo = EscaparSQL(ALLTRIM(THIS.this_cTitulo))
			loc_cMoeda  = EscaparSQL(ALLTRIM(THIS.this_cMoeda))
			loc_nVlTots = FormatarNumeroSQL(THIS.this_nVlTots)
			loc_cOper   = IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE")

			*-- Para ALTERAR: remover linhas de grupos zerados (usuario removeu do orcamento)
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor = 0 AND cursor_4c_Grupos.Perc = 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = EscaparSQL(ALLTRIM(codigos))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + loc_cCodigo + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover grupo zerado."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Para ALTERAR: remover linhas de contas zeradas
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor = 0 AND cursor_4c_Contas.Perc = 0
					SELECT cursor_4c_Contas
					loc_cCodigo = EscaparSQL(ALLTRIM(iclis))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + loc_cCodigo + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover conta zerada."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar grupos com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor <> 0 OR cursor_4c_Grupos.Perc <> 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = ALLTRIM(codigos)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           EscaparSQL("") + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar grupo " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar contas com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor <> 0 OR cursor_4c_Contas.Perc <> 0
					SELECT cursor_4c_Contas
					loc_cCodigo = ALLTRIM(iclis)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL("") + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar conta " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			IF loc_lOk
				THIS.RegistrarAuditoria(loc_cOper)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui todas as linhas do orcamento no BD
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao excluir or" + CHR(231) + "amento."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE


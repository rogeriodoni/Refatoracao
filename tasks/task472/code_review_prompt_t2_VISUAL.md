# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (14)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, Total, Valida. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGCDMTZ.Pagina.Dados.grdSaldos.Column28): Top original=25 vs migrado 'chk_4c_Check1' Top=72 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGCDMTZ.Pagina.Dados.grdSaldos.Column28): Left original=31 vs migrado 'chk_4c_Check1' Left=440 (diff=409px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2304 linhas total):

*-- Linhas 65 a 74:
65: 
66:             *-- Configura estrutura de paginas
67:             THIS.ConfigurarPageFrame()
68:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
69:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
70: 
71:             *-- Carrega lista inicial (pula se validando UI)
72:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
73:                 THIS.CarregarLista()
74:             ENDIF

*-- Linhas 96 a 117:
96: 
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount  = 2
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = THIS.Width
102:             .Height     = THIS.Height + 29
103:             .Tabs       = .F.
104:             .Visible    = .T.
105: 
106:             *-- Imagens de fundo nas duas paginas
107:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109: 
110:             .Page1.Caption = "Lista"
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.Caption = "Dados"
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         *-- Configura cada pagina
117:         THIS.ConfigurarPaginaLista()

*-- Linhas 134 a 170:
134:         *--------------------------------------------------------------------------
135:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH loc_oPagina.cnt_4c_Cabecalho
137:             .Top         = 2
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = 80
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
148:             .Caption   = "Matriz de Saldos por Centro de Custo"
149:             .Top       = 15
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 40
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.
156:             .ForeColor = RGB(0, 0, 0)
157:             .BackStyle = 0
158:             .Visible   = .T.
159:         ENDWITH
160: 
161:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
162:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
163:             .Caption   = "Matriz de Saldos por Centro de Custo"
164:             .Top       = 18
165:             .Left      = 10
166:             .Width     = 769
167:             .Height    = 46
168:             .FontName  = "Tahoma"
169:             .FontSize  = 16
170:             .FontBold  = .T.

*-- Linhas 178 a 202:
178:         *--------------------------------------------------------------------------
179:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
180:         WITH loc_oPagina.cnt_4c_Botoes
181:             .Top         = 0
182:             .Left        = 542
183:             .Width       = 475
184:             .Height      = 85
185:             .BackStyle = 0
186:             .BorderWidth = 0
187:             .Visible     = .T.
188:         ENDWITH
189: 
190:         *-- Botao Incluir
191:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
192:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
193:             .Caption         = "Incluir"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
195:             .PicturePosition = 13
196:             .Top             = 5
197:             .Left            = 5
198:             .Width           = 75
199:             .Height          = 75
200:             .FontName        = "Tahoma"
201:             .FontBold        = .T.
202:             .FontItalic      = .T.

*-- Linhas 212 a 226:
212:         ENDWITH
213: 
214:         *-- Botao Visualizar
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
217:             .Caption         = "Visualizar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 80
222:             .Width           = 75
223:             .Height          = 75
224:             .FontName        = "Tahoma"
225:             .FontBold        = .T.
226:             .FontItalic      = .T.

*-- Linhas 236 a 250:
236:         ENDWITH
237: 
238:         *-- Botao Alterar
239:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
240:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
241:             .Caption         = "Alterar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 155
246:             .Width           = 75
247:             .Height          = 75
248:             .FontName        = "Tahoma"
249:             .FontBold        = .T.
250:             .FontItalic      = .T.

*-- Linhas 260 a 274:
260:         ENDWITH
261: 
262:         *-- Botao Excluir
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
265:             .Caption         = "Excluir"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 230
270:             .Width           = 75
271:             .Height          = 75
272:             .FontName        = "Tahoma"
273:             .FontBold        = .T.
274:             .FontItalic      = .T.

*-- Linhas 284 a 298:
284:         ENDWITH
285: 
286:         *-- Botao Buscar
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
289:             .Caption         = "Buscar"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 305
294:             .Width           = 75
295:             .Height          = 75
296:             .FontName        = "Tahoma"
297:             .FontBold        = .T.
298:             .FontItalic      = .T.

*-- Linhas 312 a 336:
312:         *--------------------------------------------------------------------------
313:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
314:         WITH loc_oPagina.cnt_4c_Saida
315:             .Top         = 29
316:             .Left        = 917
317:             .Width       = 90
318:             .Height      = 85
319:             .BackStyle = 1
320:             .BackColor = RGB(255, 255, 255)
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
326:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
327:             .Caption         = "Encerrar"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .PicturePosition = 13
330:             .Top             = 5
331:             .Left            = 5
332:             .Width           = 75
333:             .Height          = 75
334:             .FontName        = "Tahoma"
335:             .FontBold        = .T.
336:             .FontItalic      = .T.

*-- Linhas 353 a 362:
353:         loc_oPagina.grd_4c_Lista.ColumnCount  = 7
354: 
355:         WITH loc_oPagina.grd_4c_Lista
356:             .Top                = 88
357:             .Left               = 5
358:             .Width              = 905
359:             .Height             = 480
360:             .FontName           = "Verdana"
361:             .FontSize           = 8
362:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 372 a 402:
372:             .GridLines          = 3
373:             .ReadOnly           = .T.
374:             .Visible            = .T.
375:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
376:             .Column1.Width           = 50
377:             .Column2.Header1.Caption = "Ano"
378:             .Column2.Width           = 50
379:             .Column3.Header1.Caption = "Grupo"
380:             .Column3.Width           = 80
381:             .Column4.Header1.Caption = "Conta"
382:             .Column4.Width           = 80
383:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
384:             .Column5.Width           = 440
385:             .Column6.Header1.Caption = "Moeda"
386:             .Column6.Width           = 60
387:             .Column7.Header1.Caption = "Valida"
388:             .Column7.Width           = 55
389:         ENDWITH
390: 
391:         *-- Vincular eventos da Page1
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
397:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
398: 
399:         THIS.TornarControlesVisiveis(loc_oPagina)
400:     ENDPROC
401: 
402:     *-- =========================================================================

*-- Linhas 415 a 439:
415:         *--------------------------------------------------------------------------
416:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
417:         WITH loc_oPagina.cnt_4c_BotoesAcao
418:             .Top         = 33
419:             .Left        = 842
420:             .Width       = 160
421:             .Height      = 85
422:             .BackStyle = 1
423:             .BackColor = RGB(255, 255, 255)
424:             .Visible     = .T.
425:         ENDWITH
426: 
427:         *-- Botao Confirmar (Salvar)
428:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
429:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
430:             .Caption         = "Confirmar"
431:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
432:             .PicturePosition = 13
433:             .Top             = 5
434:             .Left            = 5
435:             .Width           = 75
436:             .Height          = 75
437:             .FontName        = "Tahoma"
438:             .FontBold        = .T.
439:             .FontItalic      = .T.

*-- Linhas 449 a 463:
449:         ENDWITH
450: 
451:         *-- Botao Cancelar
452:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
453:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
454:             .Caption         = "Encerrar"
455:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
456:             .PicturePosition = 13
457:             .Top             = 5
458:             .Left            = 80
459:             .Width           = 75
460:             .Height          = 75
461:             .FontName        = "Tahoma"
462:             .FontBold        = .T.
463:             .FontItalic      = .T.

*-- Linhas 474 a 488:
474: 
475:         *--------------------------------------------------------------------------
476:         *-- Label "Codigo :" + TextBox Codigo (getCodigo)
477:         *-- Original: lbl_grupo.Top=43,Left=334 / getCodigo.Top=39,Left=382
478:         *--------------------------------------------------------------------------
479:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
480:         WITH loc_oPagina.lbl_4c_Lbl_grupo
481:             .Caption   = "C" + CHR(243) + "digo :"
482:             .Top       = 72
483:             .Left      = 334
484:             .Width     = 42
485:             .Height    = 15
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 494 a 538:
494:         WITH loc_oPagina.txt_4c_Codigo
495:             .Value     = ""
496:             .MaxLength = 10
497:             .Top       = 68
498:             .Left      = 382
499:             .Width     = 51
500:             .Height    = 23
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .ReadOnly  = .T.
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         *--------------------------------------------------------------------------
508:         *-- CheckBox "Inativa" (Check1)
509:         *-- Original: Top=43, Left=440
510:         *--------------------------------------------------------------------------
511:         loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
512:         WITH loc_oPagina.chk_4c_Check1
513:             .Caption   = "Inativa"
514:             .Value     = 0
515:             .Top       = 72
516:             .Left      = 440
517:             .Width     = 52
518:             .Height    = 15
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .ForeColor = RGB(90, 90, 90)
522:             .Visible   = .T.
523:         ENDWITH
524: 
525:         *--------------------------------------------------------------------------
526:         *-- Label "Moeda :" + TextBox Moeda (getMoeda)
527:         *-- Original: Say2.Top=43,Left=718 / getMoeda.Top=39,Left=764
528:         *--------------------------------------------------------------------------
529:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
530:         WITH loc_oPagina.lbl_4c_Label2
531:             .Caption   = "Moeda :"
532:             .Top       = 72
533:             .Left      = 718
534:             .Width     = 41
535:             .Height    = 15
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 544 a 569:
544:         WITH loc_oPagina.txt_4c_Moeda
545:             .Value     = ""
546:             .MaxLength = 3
547:             .Top       = 68
548:             .Left      = 764
549:             .Width     = 51
550:             .Height    = 23
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *--------------------------------------------------------------------------
557:         *-- Label "Ano Competencia :" + TextBox Ano (getAno)
558:         *-- Original: lbl_Ano.Top=70,Left=283 / getAno.Top=66,Left=382
559:         *--------------------------------------------------------------------------
560:         loc_oPagina.AddObject("lbl_4c_Lbl_Ano", "Label")
561:         WITH loc_oPagina.lbl_4c_Lbl_Ano
562:             .Caption   = "Ano Compet" + CHR(234) + "ncia :"
563:             .Top       = 99
564:             .Left      = 283
565:             .Width     = 93
566:             .Height    = 15
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 575 a 633:
575:         WITH loc_oPagina.txt_4c_Ano
576:             .Value     = ""
577:             .MaxLength = 4
578:             .Top       = 95
579:             .Left      = 382
580:             .Width     = 51
581:             .Height    = 23
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .Visible   = .T.
585:         ENDWITH
586: 
587:         *--------------------------------------------------------------------------
588:         *-- Label "Valor Acumulado :" + TextBox ValorTotal (readonly/calculado)
589:         *-- Original: Say1.Top=70,Left=671 / getValorTotal.Top=66,Left=764
590:         *--------------------------------------------------------------------------
591:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
592:         WITH loc_oPagina.lbl_4c_Label1
593:             .Caption   = "Valor Acumulado :"
594:             .Top       = 99
595:             .Left      = 671
596:             .Width     = 88
597:             .Height    = 15
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .ForeColor = RGB(90, 90, 90)
601:             .BackStyle = 0
602:             .Visible   = .T.
603:         ENDWITH
604: 
605:         loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
606:         WITH loc_oPagina.txt_4c_ValorTotal
607:             .Value     = 0
608:             .Top       = 95
609:             .Left      = 764
610:             .Width     = 108
611:             .Height    = 23
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .ReadOnly  = .T.
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         *--------------------------------------------------------------------------
619:         *-- "Centro de Custo :" + Grupo + "/" + Conta + Desc + Class3
620:         *-- Original: lblCentroCusto.Top=97,Left=288 / Get_sgrupo.Top=93,Left=382
621:         *--   Say14("/").Top=97,Left=466 / Get_sconta.Top=93,Left=473
622:         *--   Get_sdconta.Top=93,Left=554,Width=290 / Get_class3.Top=93,Left=845
623:         *--------------------------------------------------------------------------
624:         loc_oPagina.AddObject("lbl_4c_LblCentroCusto", "Label")
625:         WITH loc_oPagina.lbl_4c_LblCentroCusto
626:             .Caption   = "Centro de Custo :"
627:             .Top       = 126
628:             .Left      = 288
629:             .Width     = 88
630:             .Height    = 15
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 639 a 660:
639:         WITH loc_oPagina.txt_4c_Sgrupo
640:             .Value     = ""
641:             .MaxLength = 10
642:             .Top       = 122
643:             .Left      = 382
644:             .Width     = 82
645:             .Height    = 23
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .Visible   = .T.
649:         ENDWITH
650: 
651:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
652:         WITH loc_oPagina.lbl_4c_Label14
653:             .Caption   = "/"
654:             .Top       = 126
655:             .Left      = 466
656:             .Width     = 10
657:             .Height    = 15
658:             .FontName  = "Tahoma"
659:             .FontSize  = 8
660:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 666 a 737:
666:         WITH loc_oPagina.txt_4c_Sconta
667:             .Value     = ""
668:             .MaxLength = 20
669:             .Top       = 122
670:             .Left      = 473
671:             .Width     = 80
672:             .Height    = 23
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         loc_oPagina.AddObject("txt_4c_Sdconta", "TextBox")
679:         WITH loc_oPagina.txt_4c_Sdconta
680:             .Value     = ""
681:             .Top       = 122
682:             .Left      = 554
683:             .Width     = 290
684:             .Height    = 23
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .ReadOnly  = .T.
688:             .Visible   = .T.
689:         ENDWITH
690: 
691:         loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
692:         WITH loc_oPagina.txt_4c_Class3
693:             .Value     = ""
694:             .MaxLength = 3
695:             .Top       = 122
696:             .Left      = 845
697:             .Width     = 27
698:             .Height    = 23
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ReadOnly  = .T.
702:             .Visible   = .T.
703:         ENDWITH
704: 
705:         *--------------------------------------------------------------------------
706:         *-- getSaldo - exibe total saldo do registro (readonly, acima do grid)
707:         *-- Original: getSaldo.Top=109, Left=11, Width=100, Height=17
708:         *--------------------------------------------------------------------------
709:         loc_oPagina.AddObject("txt_4c_Saldo", "TextBox")
710:         WITH loc_oPagina.txt_4c_Saldo
711:             .Value     = 0
712:             .Top       = 138
713:             .Left      = 11
714:             .Width     = 100
715:             .Height    = 17
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .ReadOnly  = .T.
719:             .Visible   = .T.
720:         ENDWITH
721: 
722:         *--------------------------------------------------------------------------
723:         *-- Grade grd_4c_Dados (grdSaldos) - 28 colunas
724:         *-- Original: grdSaldos.Top=129, Left=11, Width=1045, Height=419
725:         *--------------------------------------------------------------------------
726:         LOCAL loc_oGrid
727:         loc_oGrid = .NULL.
728: 
729:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
730:         WITH loc_oPagina.grd_4c_Dados
731:             .Top         = 158     && 129+29
732:             .Left        = 11
733:             .Width       = 1045
734:             .Height      = 419
735:             .ColumnCount = 28
736:             .ReadOnly    = .T.     && HabilitarCampos gerencia
737:             .FontName    = "Tahoma"

*-- Linhas 745 a 1111:
745: 
746:         *-- Coluna 1 - Grupos
747:         WITH loc_oGrid.Column1
748:             .Header1.Caption = "Grupo"
749:             .Width           = 65
750:         ENDWITH
751: 
752:         *-- Coluna 2 - Contas
753:         WITH loc_oGrid.Column2
754:             .Header1.Caption = "Conta"
755:             .Width           = 65
756:         ENDWITH
757: 
758:         *-- Coluna 3 - Janeiro
759:         WITH loc_oGrid.Column3
760:             .Header1.Caption = "Janeiro"
761:             .Width           = 70
762:         ENDWITH
763: 
764:         *-- Coluna 4 - Fevereiro
765:         WITH loc_oGrid.Column4
766:             .Header1.Caption = "Fevereiro"
767:             .Width           = 70
768:         ENDWITH
769: 
770:         *-- Coluna 5 - Marco
771:         WITH loc_oGrid.Column5
772:             .Header1.Caption = "Mar" + CHR(231) + "o"
773:             .Width           = 70
774:         ENDWITH
775: 
776:         *-- Coluna 6 - Abril
777:         WITH loc_oGrid.Column6
778:             .Header1.Caption = "Abril"
779:             .Width           = 70
780:         ENDWITH
781: 
782:         *-- Coluna 7 - Maio
783:         WITH loc_oGrid.Column7
784:             .Header1.Caption = "Maio"
785:             .Width           = 70
786:         ENDWITH
787: 
788:         *-- Coluna 8 - Junho
789:         WITH loc_oGrid.Column8
790:             .Header1.Caption = "Junho"
791:             .Width           = 70
792:         ENDWITH
793: 
794:         *-- Coluna 9 - Julho
795:         WITH loc_oGrid.Column9
796:             .Header1.Caption = "Julho"
797:             .Width           = 70
798:         ENDWITH
799: 
800:         *-- Coluna 10 - Agosto
801:         WITH loc_oGrid.Column10
802:             .Header1.Caption = "Agosto"
803:             .Width           = 70
804:         ENDWITH
805: 
806:         *-- Coluna 11 - Setembro
807:         WITH loc_oGrid.Column11
808:             .Header1.Caption = "Setembro"
809:             .Width           = 70
810:         ENDWITH
811: 
812:         *-- Coluna 12 - Outubro
813:         WITH loc_oGrid.Column12
814:             .Header1.Caption = "Outubro"
815:             .Width           = 70
816:         ENDWITH
817: 
818:         *-- Coluna 13 - Novembro
819:         WITH loc_oGrid.Column13
820:             .Header1.Caption = "Novembro"
821:             .Width           = 70
822:         ENDWITH
823: 
824:         *-- Coluna 14 - Dezembro
825:         WITH loc_oGrid.Column14
826:             .Header1.Caption = "Dezembro"
827:             .Width           = 70
828:         ENDWITH
829: 
830:         *-- Coluna 15 - Total (calculado, readonly)
831:         WITH loc_oGrid.Column15
832:             .Header1.Caption = "Total"
833:             .Width           = 85
834:             .ReadOnly        = .T.
835:         ENDWITH
836: 
837:         *-- Colunas 16-27: Acumulados mensais (readonly)
838:         WITH loc_oGrid.Column16
839:             .Header1.Caption = ""
840:             .Width           = 75
841:             .ReadOnly        = .T.
842:         ENDWITH
843: 
844:         WITH loc_oGrid.Column17
845:             .Header1.Caption = ""
846:             .Width           = 75
847:             .ReadOnly        = .T.
848:         ENDWITH
849: 
850:         WITH loc_oGrid.Column18
851:             .Header1.Caption = ""
852:             .Width           = 75
853:             .ReadOnly        = .T.
854:         ENDWITH
855: 
856:         WITH loc_oGrid.Column19
857:             .Header1.Caption = ""
858:             .Width           = 75
859:             .ReadOnly        = .T.
860:         ENDWITH
861: 
862:         WITH loc_oGrid.Column20
863:             .Header1.Caption = ""
864:             .Width           = 75
865:             .ReadOnly        = .T.
866:         ENDWITH
867: 
868:         WITH loc_oGrid.Column21
869:             .Header1.Caption = ""
870:             .Width           = 75
871:             .ReadOnly        = .T.
872:         ENDWITH
873: 
874:         WITH loc_oGrid.Column22
875:             .Header1.Caption = ""
876:             .Width           = 75
877:             .ReadOnly        = .T.
878:         ENDWITH
879: 
880:         WITH loc_oGrid.Column23
881:             .Header1.Caption = ""
882:             .Width           = 75
883:             .ReadOnly        = .T.
884:         ENDWITH
885: 
886:         WITH loc_oGrid.Column24
887:             .Header1.Caption = ""
888:             .Width           = 75
889:             .ReadOnly        = .T.
890:         ENDWITH
891: 
892:         WITH loc_oGrid.Column25
893:             .Header1.Caption = ""
894:             .Width           = 75
895:             .ReadOnly        = .T.
896:         ENDWITH
897: 
898:         WITH loc_oGrid.Column26
899:             .Header1.Caption = ""
900:             .Width           = 75
901:             .ReadOnly        = .T.
902:         ENDWITH
903: 
904:         WITH loc_oGrid.Column27
905:             .Header1.Caption = ""
906:             .Width           = 75
907:             .ReadOnly        = .T.
908:         ENDWITH
909: 
910:         *-- Coluna 28 - Valida (CheckBox)
911:         WITH loc_oGrid.Column28
912:             .Header1.Caption = "Valida"
913:             .Width           = 45
914:             .Sparse          = .F.
915:         ENDWITH
916: 
917:         loc_oGrid.Column28.AddObject("chk_4c_Valida", "CheckBox")
918:         WITH loc_oGrid.Column28.chk_4c_Valida
919:             .Caption   = ""
920:             .Alignment = 0
921:             .ReadOnly  = .F.
922:             .Visible   = .T.
923:             .Top       = 25
924:             .Left      = 31
925:             .Height    = 17
926:             .Width     = 22
927:         ENDWITH
928: 
929:         *--------------------------------------------------------------------------
930:         *-- Container botoes Inserir/Excluir linha (cmdInsFtc)
931:         *-- Original: cmdInsFtc.Top=253, Left=1055, Width=50, Height=90
932:         *--------------------------------------------------------------------------
933:         loc_oPagina.AddObject("cnt_4c_InsFtc", "Container")
934:         WITH loc_oPagina.cnt_4c_InsFtc
935:             .Top         = 282     && 253+29
936:             .Left        = 1055
937:             .Width       = 45
938:             .Height      = 90
939:             .BackStyle = 1
940:             .BackColor = RGB(255, 255, 255)
941:             .Visible     = .T.
942:         ENDWITH
943: 
944:         loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_InserirLinha", "CommandButton")
945:         WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha
946:             .Caption       = "+"
947:             .Top           = 5
948:             .Left          = 2
949:             .Width         = 40
950:             .Height        = 36
951:             .FontName      = "Tahoma"
952:             .FontSize      = 12
953:             .FontBold      = .T.
954:             .ForeColor     = RGB(0, 128, 0)
955:             .SpecialEffect = 0
956:             .Visible       = .T.
957:         ENDWITH
958: 
959:         loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
960:         WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha
961:             .Caption       = "-"
962:             .Top           = 49
963:             .Left          = 2
964:             .Width         = 40
965:             .Height        = 36
966:             .FontName      = "Tahoma"
967:             .FontSize      = 14
968:             .FontBold      = .T.
969:             .ForeColor     = RGB(192, 0, 0)
970:             .SpecialEffect = 0
971:             .Visible       = .T.
972:         ENDWITH
973: 
974:         *--------------------------------------------------------------------------
975:         *-- Shape separador (Shape3)
976:         *-- Original: Shape3.Top=569, Left=5, Width=504, Height=2
977:         *--------------------------------------------------------------------------
978:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
979:         WITH loc_oPagina.shp_4c_Shape3
980:             .Top         = 598     && 569+29
981:             .Left        = 5
982:             .Width       = 504
983:             .Height      = 2
984:             .BackStyle   = 1
985:             .BackColor   = RGB(128, 128, 128)
986:             .BorderStyle = 0
987:             .Visible     = .T.
988:         ENDWITH
989: 
990:         *--------------------------------------------------------------------------
991:         *-- Campos de Auditoria (readonly)
992:         *-- Original: Say20.Top=553, Say24/Say25.Top=578, Get_DtIncs/etc.Top=574
993:         *--------------------------------------------------------------------------
994:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
995:         WITH loc_oPagina.lbl_4c_Label20
996:             .Caption   = "Data / Usu" + CHR(225) + "rio"
997:             .Top       = 582     && 553+29
998:             .Left      = 11
999:             .Width     = 84
1000:             .Height    = 15
1001:             .FontName  = "Tahoma"
1002:             .FontSize  = 8
1003:             .ForeColor = RGB(90, 90, 90)
1004:             .BackStyle = 0
1005:             .Visible   = .T.
1006:         ENDWITH
1007: 
1008:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
1009:         WITH loc_oPagina.lbl_4c_Label24
1010:             .Caption   = "Inclus" + CHR(227) + "o :"
1011:             .Top       = 607     && 578+29
1012:             .Left      = 10
1013:             .Width     = 49
1014:             .Height    = 15
1015:             .FontName  = "Tahoma"
1016:             .FontSize  = 8
1017:             .ForeColor = RGB(90, 90, 90)
1018:             .BackStyle = 0
1019:             .Visible   = .T.
1020:         ENDWITH
1021: 
1022:         loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
1023:         WITH loc_oPagina.txt_4c_DtIncs
1024:             .Value     = {}
1025:             .Top       = 603     && 574+29
1026:             .Left      = 67
1027:             .Width     = 79
1028:             .Height    = 23
1029:             .FontName  = "Tahoma"
1030:             .FontSize  = 8
1031:             .ReadOnly  = .T.
1032:             .Visible   = .T.
1033:         ENDWITH
1034: 
1035:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
1036:         WITH loc_oPagina.txt_4c_Usuario
1037:             .Value     = ""
1038:             .MaxLength = 20
1039:             .Top       = 603     && 574+29
1040:             .Left      = 148
1041:             .Width     = 79
1042:             .Height    = 23
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:             .ReadOnly  = .T.
1046:             .Visible   = .T.
1047:         ENDWITH
1048: 
1049:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
1050:         WITH loc_oPagina.lbl_4c_Label25
1051:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o :"
1052:             .Top       = 607     && 578+29
1053:             .Left      = 251
1054:             .Width     = 55
1055:             .Height    = 15
1056:             .FontName  = "Tahoma"
1057:             .FontSize  = 8
1058:             .ForeColor = RGB(90, 90, 90)
1059:             .BackStyle = 0
1060:             .Visible   = .T.
1061:         ENDWITH
1062: 
1063:         loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
1064:         WITH loc_oPagina.txt_4c_DataAlts
1065:             .Value     = {}
1066:             .Top       = 603     && 574+29
1067:             .Left      = 319
1068:             .Width     = 79
1069:             .Height    = 23
1070:             .FontName  = "Tahoma"
1071:             .FontSize  = 8
1072:             .ReadOnly  = .T.
1073:             .Visible   = .T.
1074:         ENDWITH
1075: 
1076:         loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
1077:         WITH loc_oPagina.txt_4c_UsuaAlts
1078:             .Value     = ""
1079:             .MaxLength = 20
1080:             .Top       = 603     && 574+29
1081:             .Left      = 400
1082:             .Width     = 79
1083:             .Height    = 23
1084:             .FontName  = "Tahoma"
1085:             .FontSize  = 8
1086:             .ReadOnly  = .T.
1087:             .Visible   = .T.
1088:         ENDWITH
1089: 
1090:         *-- Vincular eventos Page2 (botoes Salvar/Cancelar)
1091:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1092:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1093: 
1094:         *-- Vincular validacao/lookup campos header
1095:         BINDEVENT(loc_oPagina.txt_4c_Ano,    "KeyPress", THIS, "ValidarAnoMtz")
1096:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress", THIS, "ValidarGrupoMtz")
1097:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress", THIS, "ValidarContaMtz")
1098:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "ValidarMoedaMtz")
1099:         BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress",  THIS, "TeclaF4Sgrupo")
1100:         BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress",  THIS, "TeclaF4Sconta")
1101:         BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress",  THIS, "TeclaF4Moeda")
1102: 
1103:         *-- Vincular eventos da grade e botoes de linha
1104:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1105:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha, "Click", THIS, "BtnInserirLinhaClick")
1106:         BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
1107: 
1108:         THIS.TornarControlesVisiveis(loc_oPagina)
1109:     ENDPROC
1110: 
1111:     *-- =========================================================================

*-- Linhas 1132 a 1146:
1132:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1133:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1134:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1135:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1136:                 loc_oGrid.Column2.Header1.Caption = "Ano"
1137:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1138:                 loc_oGrid.Column4.Header1.Caption = "Conta"
1139:                 loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1140:                 loc_oGrid.Column6.Header1.Caption = "Moeda"
1141:                 loc_oGrid.Column7.Header1.Caption = "Valida"
1142:                 THIS.FormatarGridLista(loc_oGrid)
1143:                 loc_lResultado = .T.
1144:             ENDIF
1145: 
1146:         CATCH TO loc_oErro

*-- Linhas 1309 a 1318:
1309:             ENDIF
1310: 
1311:             *-- Botoes Confirmar/Cancelar
1312:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
1313:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
1314: 
1315:             *-- Campos readonly sempre
1316:             loc_oPagina.txt_4c_Sdconta.ReadOnly    = .T.
1317:             loc_oPagina.txt_4c_ValorTotal.ReadOnly = .T.
1318:             loc_oPagina.txt_4c_DtIncs.ReadOnly     = .T.

*-- Linhas 1335 a 1347:
1335:         TRY
1336:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1337:             IF THIS.this_cModoAtual = "VISUALIZAR"
1338:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1339:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1340:             ELSE
1341:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1342:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1343:             ENDIF
1344:         CATCH TO loc_oErro
1345:             MsgErro(loc_oErro.Message, "Formmtz.AjustarBotoesPorModo")
1346:         ENDTRY
1347:     ENDPROC

*-- Linhas 1516 a 1530:
1516:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1517:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1518:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1519:                             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1520:                             loc_oGrid.Column2.Header1.Caption = "Ano"
1521:                             loc_oGrid.Column3.Header1.Caption = "Grupo"
1522:                             loc_oGrid.Column4.Header1.Caption = "Conta"
1523:                             loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1524:                             loc_oGrid.Column6.Header1.Caption = "Moeda"
1525:                             loc_oGrid.Column7.Header1.Caption = "Valida"
1526:                             THIS.FormatarGridLista(loc_oGrid)
1527:                         ENDIF
1528:                     ENDIF
1529:                 ENDIF
1530: 


### BO (C:\4c\projeto\app\classes\mtzBO.prg):
*******************************************************************************
* mtzBO.prg - Business Object: Matriz de Saldos por Centro de Custo
* Tabela principal : SigCdMtz  (cabecalho da matriz)
* Tabela detalhe   : SigCdMtI  (linhas de centro de custo / meses)
* Herda de         : BusinessBase
*******************************************************************************

DEFINE CLASS mtzBO AS BusinessBase

    *-- =========================================================================
    *-- PROPRIEDADES: SigCdMtz (cabecalho)
    *-- =========================================================================

    *-- Chave usuario (char 3 - gerada por GerarProximoCodigo na insercao)
    this_cCodigo    = ""

    *-- Ano de competencia da matriz (char 4, ex: "2026")
    this_cAno       = ""

    *-- Grupo de conta corrente (SigCdGcr.Codigos)
    this_cSGrupos   = ""

    *-- Conta de centro de custo (SigCdCli.IClis)
    this_cSContas   = ""

    *-- Flag inativa (0=ativa / 1=inativa -> convertido para .T./.F.)
    this_lInativas  = .F.

    *-- Moeda da matriz (SigCdMoe.CMoes, char 4)
    this_cMoeda     = ""

    *-- Auditoria de inclusao
    this_tDtIncs    = {}
    this_cUsuIncs   = ""

    *-- Auditoria de alteracao
    this_tDtAlts    = {}
    this_cUsuAlts   = ""

    *-- =========================================================================
    *-- PROPRIEDADES DERIVADAS / AUXILIARES (nao armazenadas diretamente)
    *-- =========================================================================

    *-- Descricao da conta - derivada do JOIN: SigCdCli.rclis AS sDContas
    *-- Nao existe como coluna em SigCdMtz; carregada via SELECT com JOIN
    this_cSDesconta = ""

    *-- Valor total acumulado dos meses de SigCdMtI (calculado, exibicao)
    this_nValorTotal = 0

    *-- =========================================================================
    *-- INIT
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMtz"
            THIS.this_cCampoChave = "Codigo"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- OBTER CHAVE PRIMARIA (requerido pelo sistema de auditoria)
    *-- =========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *-- =========================================================================
    *-- NOVO REGISTRO - Gera codigo unico para insercao
    *-- =========================================================================

    FUNCTION NovoRegistro()
        LOCAL loc_lResultado, loc_nProximo
        loc_lResultado = DODEFAULT()

        IF loc_lResultado
            TRY
                loc_nProximo = THIS.GerarProximoCodigo()
                IF loc_nProximo > 0
                    THIS.this_cCodigo = ALLTRIM(STR(loc_nProximo, 3))
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel gerar c" + CHR(243) + "digo para nova matriz.", "mtzBO.NovoRegistro")
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "mtzBO.NovoRegistro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- GERAR PROXIMO CODIGO (PROTECTED) - MAX(Codigo)+1 em SigCdMtz
    *-- =========================================================================

    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(Codigo) AS INT)), 0) + 1 AS ProximoCodigo" + ;
                       " FROM SigCdMtz" + ;
                       " WHERE ISNUMERIC(LTRIM(Codigo)) = 1"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ProxCod")
                TABLEREVERT(.T., "cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(ProximoCodigo, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *-- =========================================================================
    *-- BUSCAR - SELECT para grid Page1 (lista de matrizes)
    *-- =========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " ORDER BY a.Ano, a.sGrupos, a.sContas"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                           " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                           " a.DtIncs, a.UsuIncs" + ;
                           " FROM SigCdMtz a" + ;
                           " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY a.Ano, a.sGrupos, a.sContas"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro SigCdMtz no BO
    *-- =========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs, a.DtAlts, a.UsuAlts, a.CidChaves" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DO CURSOR - Mapeia cursor para propriedades do BO
    *-- =========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Codigo, "C")
            THIS.this_cAno       = TratarNulo(Ano, "C")
            THIS.this_cSGrupos   = TratarNulo(sGrupos, "C")
            THIS.this_cSContas   = TratarNulo(sContas, "C")
            THIS.this_cSDesconta = TratarNulo(sDContas, "C")
            THIS.this_cMoeda     = TratarNulo(Moeda, "C")
            IF VARTYPE(Inativas) = "L"
                THIS.this_lInativas = Inativas
            ELSE
                THIS.this_lInativas = (NVL(Inativas, 0) = 1)
            ENDIF
            THIS.this_tDtIncs    = TratarNulo(DtIncs, "T")
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs, "C")
            THIS.this_tDtAlts    = TratarNulo(DtAlts, "T")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DETALHE - Carrega SigCdMtI para cursor_4c_MtI (grid Page2)
    *-- =========================================================================

    FUNCTION CarregarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_cSQL = "SELECT a.Codigo, a.CidChaves, a.Grupos, a.Contas," + ;
                       " a.Val_Jan, a.Val_Fev, a.Val_Mar, a.Val_Abr," + ;
                       " a.Val_Mai, a.Val_Jun, a.Val_Jul, a.Val_Ago," + ;
                       " a.Val_Set, a.Val_Out, a.Val_Nov, a.Val_Dez," + ;
                       " a.Acm_Jan, a.Acm_Fev, a.Acm_Mar, a.Acm_Abr," + ;
                       " a.Acm_Mai, a.Acm_Jun, a.Acm_Jul, a.Acm_Ago," + ;
                       " a.Acm_Set, a.Acm_Out, a.Acm_Nov, a.Acm_Dez," + ;
                       " (a.Val_Jan+a.Val_Fev+a.Val_Mar+a.Val_Abr+a.Val_Mai+a.Val_Jun+" + ;
                       "  a.Val_Jul+a.Val_Ago+a.Val_Set+a.Val_Out+a.Val_Nov+a.Val_Dez)" + ;
                       " AS Total, a.ChkValida" + ;
                       " FROM SigCdMtI a" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_MtI")
                TABLEREVERT(.T., "cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtI")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.CarregarDetalhe")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CRIAR CURSOR DETALHE VAZIO - Cria cursor_4c_MtI vazio para insercao
    *-- =========================================================================

    FUNCTION CriarCursorDetalheVazio(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_MtI ( ;
                Codigo    C(3), ;
                CidChaves C(36), ;
                Grupos    C(10), ;
                Contas    C(10), ;
                Val_Jan   N(14,2), ;
                Val_Fev   N(14,2), ;
                Val_Mar   N(14,2), ;
                Val_Abr   N(14,2), ;
                Val_Mai   N(14,2), ;
                Val_Jun   N(14,2), ;
                Val_Jul   N(14,2), ;
                Val_Ago   N(14,2), ;
                Val_Set   N(14,2), ;
                Val_Out   N(14,2), ;
                Val_Nov   N(14,2), ;
                Val_Dez   N(14,2), ;
                Acm_Jan   N(14,2), ;
                Acm_Fev   N(14,2), ;
                Acm_Mar   N(14,2), ;
                Acm_Abr   N(14,2), ;
                Acm_Mai   N(14,2), ;
                Acm_Jun   N(14,2), ;
                Acm_Jul   N(14,2), ;
                Acm_Ago   N(14,2), ;
                Acm_Set   N(14,2), ;
                Acm_Out   N(14,2), ;
                Acm_Nov   N(14,2), ;
                Acm_Dez   N(14,2), ;
                Total     N(18,2), ;
                ChkValida L ;
            )
            SET NULL OFF

            *-- Adiciona linha em branco inicial para o usuario comecar a inserir
            INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                Total, ChkValida) ;
                VALUES (par_cCodigo, "", "", "", ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, .F.)

            GO TOP IN cursor_4c_MtI
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CriarCursorDetalheVazio")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR LINHA DETALHE - Adiciona linha em branco no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION InserirLinhaDetalhe(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                *-- Verifica se ja existe uma linha vazia (sem Grupos e Contas)
                SELECT cursor_4c_MtI
                GO TOP
                LOCATE FOR EMPTY(ALLTRIM(Grupos)) AND EMPTY(ALLTRIM(Contas))
                IF !FOUND()
                    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                        Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                        Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                        Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                        Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                        Total, ChkValida) ;
                        VALUES (par_cCodigo, "", "", "", ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, .F.)
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.InserirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- EXCLUIR LINHA DETALHE - Remove linha atual do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ExcluirLinhaDetalhe()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExcluirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- ATUALIZAR TOTAL - Calcula Total na linha do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION AtualizarTotal(par_cChave)
        LOCAL loc_nTotal, loc_nTotalGeral, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                IF !EMPTY(ALLTRIM(par_cChave))
                    SELECT cursor_4c_MtI
                    LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    IF FOUND()
                        loc_nTotal = NVL(Val_Jan, 0) + NVL(Val_Fev, 0) + NVL(Val_Mar, 0) + ;
                                     NVL(Val_Abr, 0) + NVL(Val_Mai, 0) + NVL(Val_Jun, 0) + ;
                                     NVL(Val_Jul, 0) + NVL(Val_Ago, 0) + NVL(Val_Set, 0) + ;
                                     NVL(Val_Out, 0) + NVL(Val_Nov, 0) + NVL(Val_Dez, 0)
                        REPLACE Total WITH loc_nTotal IN cursor_4c_MtI ;
                            FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    ENDIF
                ENDIF

                *-- Calcula total geral de todas as linhas
                SELECT SUM(NVL(Total, 0)) AS TotalGeral FROM cursor_4c_MtI INTO CURSOR cursor_4c_TmpTot READWRITE
                SELECT cursor_4c_TmpTot
                THIS.this_nValorTotal = NVL(TotalGeral, 0)
                USE IN cursor_4c_TmpTot

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.AtualizarTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VALIDAR DUPLICATAS - Verifica Grupos+Contas duplicados no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_lResultado
        loc_lValido = .T.
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                SELECT COUNT(*) AS Qtds, Grupos, Contas ;
                    FROM cursor_4c_MtI ;
                    WHERE !EMPTY(ALLTRIM(Contas)) AND !EMPTY(ALLTRIM(Grupos)) ;
                    GROUP BY Grupos, Contas ;
                    HAVING COUNT(*) >= 2 ;
                    INTO CURSOR cursor_4c_Dup READWRITE

                SELECT cursor_4c_Dup
                IF RECCOUNT("cursor_4c_Dup") > 0
                    MsgErro("H" + CHR(225) + " registros duplicados na grade de Contas, Verifique.", "Aviso")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_lResultado = loc_lValido
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ValidarDuplicatas")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR (PROTECTED) - INSERT SigCdMtz + SigCdMtI via cursor_4c_MtI
    *-- =========================================================================

    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMtz" + ;
                       " (Codigo, Ano, sGrupos, sContas, Moeda, Inativas," + ;
                       "  DtIncs, UsuIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cAno) + "," + ;
                       EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       EscaparSQL(THIS.this_cSContas) + "," + ;
                       EscaparSQL(THIS.this_cMoeda) + "," + ;
                       IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .T.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZAR (PROTECTED) - UPDATE SigCdMtz + re-inserir SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtz SET" + ;
                       " Ano = " + EscaparSQL(THIS.this_cAno) + "," + ;
                       " sGrupos = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       " sContas = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                       " Moeda = " + EscaparSQL(THIS.this_cMoeda) + "," + ;
                       " Inativas = " + IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .F.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- EXECUTAR EXCLUSAO (PROTECTED) - DELETE SigCdMtz + SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- DELETE SigCdMtI (detalhe) primeiro por FK
            loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdMtz WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtz)")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtI)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- SALVAR DETALHE (PROTECTED) - INSERT SigCdMtI a partir de cursor_4c_MtI
    *-- =========================================================================

    PROTECTED FUNCTION SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupos, loc_cContas, loc_cChave
        LOCAL loc_nJan, loc_nFev, loc_nMar, loc_nAbr, loc_nMai, loc_nJun
        LOCAL loc_nJul, loc_nAgo, loc_nSet, loc_nOut, loc_nNov, loc_nDez
        loc_lResultado = .F.

        TRY
            IF !par_lSomenteInserir
                loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(par_cCodigo)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            loc_lResultado = .T.

            IF USED("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                SCAN FOR !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas))
                    loc_cGrupos = ALLTRIM(Grupos)
                    loc_cContas = ALLTRIM(Contas)
                    loc_cChave  = ALLTRIM(CidChaves)
                    loc_nJan    = NVL(Val_Jan, 0)
                    loc_nFev    = NVL(Val_Fev, 0)
                    loc_nMar    = NVL(Val_Mar, 0)
                    loc_nAbr    = NVL(Val_Abr, 0)
                    loc_nMai    = NVL(Val_Mai, 0)
                    loc_nJun    = NVL(Val_Jun, 0)
                    loc_nJul    = NVL(Val_Jul, 0)
                    loc_nAgo    = NVL(Val_Ago, 0)
                    loc_nSet    = NVL(Val_Set, 0)
                    loc_nOut    = NVL(Val_Out, 0)
                    loc_nNov    = NVL(Val_Nov, 0)
                    loc_nDez    = NVL(Val_Dez, 0)

                    IF EMPTY(loc_cChave)
                        loc_cChave = ALLTRIM(SYS(2015)) + ALLTRIM(STR(SECONDS(), 10, 0))
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdMtI" + ;
                               " (Codigo, CidChaves, Grupos, Contas," + ;
                               "  Val_Jan, Val_Fev, Val_Mar, Val_Abr," + ;
                               "  Val_Mai, Val_Jun, Val_Jul, Val_Ago," + ;
                               "  Val_Set, Val_Out, Val_Nov, Val_Dez)" + ;
                               " VALUES (" + ;
                               EscaparSQL(par_cCodigo) + "," + ;
                               EscaparSQL(loc_cChave) + "," + ;
                               EscaparSQL(loc_cGrupos) + "," + ;
                               EscaparSQL(loc_cContas) + "," + ;
                               FormatarNumeroSQL(loc_nJan) + "," + ;
                               FormatarNumeroSQL(loc_nFev) + "," + ;
                               FormatarNumeroSQL(loc_nMar) + "," + ;
                               FormatarNumeroSQL(loc_nAbr) + "," + ;
                               FormatarNumeroSQL(loc_nMai) + "," + ;
                               FormatarNumeroSQL(loc_nJun) + "," + ;
                               FormatarNumeroSQL(loc_nJul) + "," + ;
                               FormatarNumeroSQL(loc_nAgo) + "," + ;
                               FormatarNumeroSQL(loc_nSet) + "," + ;
                               FormatarNumeroSQL(loc_nOut) + "," + ;
                               FormatarNumeroSQL(loc_nNov) + "," + ;
                               FormatarNumeroSQL(loc_nDez) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro(CapturarErroSQL(), "mtzBO.SalvarDetalhe (linha " + loc_cGrupos + "/" + loc_cContas + ")")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.SalvarDetalhe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VERIFICAR DUPLICADO - Verifica se Ano+Grupo+Conta ja existe em SigCdMtz
    *-- =========================================================================

    FUNCTION VerificarDuplicado(par_cAno, par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdMtz" + ;
                       " WHERE Ano = " + EscaparSQL(par_cAno) + ;
                       " AND sGrupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND sContas = " + EscaparSQL(par_cConta)

            IF !EMPTY(ALLTRIM(THIS.this_cCodigo)) AND !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                           " AND Codigo <> " + EscaparSQL(THIS.this_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMtz")
                TABLEREVERT(.T., "cursor_4c_ChkMtz")
                USE IN cursor_4c_ChkMtz
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMtz")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkMtz") > 0
                SELECT cursor_4c_ChkMtz
                loc_lExiste = (NVL(Qtd, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.VerificarDuplicado")
        ENDTRY

        IF USED("cursor_4c_ChkMtz")
            USE IN cursor_4c_ChkMtz
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *-- =========================================================================
    *-- DESTRUIR - Fecha cursores abertos pelo BO
    *-- =========================================================================

    PROCEDURE Destroy()
        IF USED("cursor_4c_MtI")
            USE IN cursor_4c_MtI
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


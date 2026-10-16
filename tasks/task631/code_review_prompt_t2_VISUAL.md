# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGPRINT.Pagina.Dados): Top original=314 vs migrado 'obj_4c_OptTipo' Top=5 (diff=309px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGPRINT.Pagina.Dados): Left original=156 vs migrado 'obj_4c_OptTipo' Left=7 (diff=149px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1270 linhas total):

*-- Linhas 47 a 58:
47:                     "FormSIGPRINT.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Visible    = .T.
55: 
56:                 *-- Popula a grade da Lista. No legado isso esta no proprio
57:                 *-- Init (SCAN em crSigOpIns alimentando csSigOpIns + bind das
58:                 *-- 3 colunas da Grade), e os botoes Alterar/Visualizar/Excluir

*-- Linhas 87 a 106:
87: 
88:         WITH THIS.pgf_4c_Paginas
89:             .PageCount = 2
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .Tabs      = .F.
95:             .Visible   = .T.
96: 
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 121 a 158:
121:         *-- Original: Top=1. Com compensacao +29: Top=31
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
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
146:             .Visible   = .T.
147:         ENDWITH
148: 
149:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
150:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = 769
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.

*-- Linhas 165 a 187:
165:         *-- Container Botoes CRUD (Grupo_op no legado) - canonico: Left=542, Top=29
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 29
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackStyle   = 0
173:             .BorderWidth = 0
174:             .Visible     = .T.
175: 
176:             .AddObject("cmd_4c_Incluir", "CommandButton")
177:             WITH .cmd_4c_Incluir
178:                 .Caption         = "Incluir"
179:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:                 .PicturePosition = 13
181:                 .Top             = 5
182:                 .Left            = 5
183:                 .Width           = 75
184:                 .Height          = 75
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .FontName        = "Comic Sans MS"

*-- Linhas 196 a 210:
196:                 .Visible         = .T.
197:             ENDWITH
198: 
199:             .AddObject("cmd_4c_Visualizar", "CommandButton")
200:             WITH .cmd_4c_Visualizar
201:                 .Caption         = "Visualizar"
202:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:                 .PicturePosition = 13
204:                 .Top             = 5
205:                 .Left            = 80
206:                 .Width           = 75
207:                 .Height          = 75
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .FontName        = "Comic Sans MS"

*-- Linhas 219 a 233:
219:                 .Visible         = .T.
220:             ENDWITH
221: 
222:             .AddObject("cmd_4c_Alterar", "CommandButton")
223:             WITH .cmd_4c_Alterar
224:                 .Caption         = "Alterar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            = 155
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Comic Sans MS"

*-- Linhas 242 a 256:
242:                 .Visible         = .T.
243:             ENDWITH
244: 
245:             .AddObject("cmd_4c_Excluir", "CommandButton")
246:             WITH .cmd_4c_Excluir
247:                 .Caption         = "Excluir"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            = 230
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .BackColor       = RGB(255, 255, 255)
255:                 .ForeColor       = RGB(90, 90, 90)
256:                 .FontName        = "Comic Sans MS"

*-- Linhas 265 a 279:
265:                 .Visible         = .T.
266:             ENDWITH
267: 
268:             .AddObject("cmd_4c_Buscar", "CommandButton")
269:             WITH .cmd_4c_Buscar
270:                 .Caption         = "Buscar"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top             = 5
274:                 .Left            = 305
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .BackColor       = RGB(255, 255, 255)
278:                 .ForeColor       = RGB(90, 90, 90)
279:                 .FontName        = "Comic Sans MS"

*-- Linhas 289 a 321:
289:             ENDWITH
290:         ENDWITH
291: 
292:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
296:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container Saida (Grupo_Saida no legado) - padrao canonico do
299:         *-- sistema novo, prevalece sobre o PILAR 1 (regra #10 CLAUDE.md)
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         WITH loc_oPagina.cnt_4c_Saida
302:             .Top         = 29
303:             .Left        = 917
304:             .Width       = 90
305:             .Height      = 85
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309: 
310:             .AddObject("cmd_4c_Encerrar", "CommandButton")
311:             WITH .cmd_4c_Encerrar
312:                 .Caption         = "Encerrar"
313:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:                 .PicturePosition = 13
315:                 .Top             = 5
316:                 .Left            = 5
317:                 .Width           = 75
318:                 .Height          = 75
319:                 .BackColor       = RGB(255, 255, 255)
320:                 .ForeColor       = RGB(90, 90, 90)
321:                 .FontName        = "Comic Sans MS"

*-- Linhas 331 a 351:
331:             ENDWITH
332:         ENDWITH
333: 
334:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
335: 
336:         *-- Grid da Lista (Grade no legado: Top=96,Left=32,Width=736,Height=490;
337:         *-- com compensacao PageFrame.Top=-29: 96+29=125. Width/Left seguem o
338:         *-- canonico do Framework para nao sobrepor cnt_4c_Saida (Left=917).
339:         *-- ControlSource/Header sao (re)definidos em CarregarLista(), apos o
340:         *-- RecordSource - regra "Grade perde cabecalhos apos RecordSource".
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.RecordSource = ""
343:         loc_oPagina.grd_4c_Lista.ColumnCount  = 3
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 125
346:             .Left               = 26
347:             .Width              = 880
348:             .Height             = 490
349:             .ReadOnly           = .T.
350:             .DeleteMark         = .F.
351:             .RecordMark         = .F.

*-- Linhas 380 a 417:
380:         *-- (faixa vai nas DUAS paginas; Page2 nao compensa +2 do original)
381:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
382:         WITH loc_oPagina.cnt_4c_Cabecalho
383:             .Top         = 29
384:             .Left        = 0
385:             .Width       = THIS.Width
386:             .Height      = 80
387:             .BackColor   = RGB(100, 100, 100)
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
393:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
394:             .Caption   = THIS.Caption
395:             .Top       = 15
396:             .Left      = 10
397:             .Width     = 769
398:             .Height    = 40
399:             .FontName  = "Tahoma"
400:             .FontSize  = 16
401:             .FontBold  = .T.
402:             .ForeColor = RGB(0, 0, 0)
403:             .BackStyle = 0
404:             .AutoSize  = .F.
405:             .Visible   = .T.
406:         ENDWITH
407: 
408:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
409:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
410:             .Caption   = THIS.Caption
411:             .Top       = 18
412:             .Left      = 10
413:             .Width     = 769
414:             .Height    = 46
415:             .FontName  = "Tahoma"
416:             .FontSize  = 16
417:             .FontBold  = .T.

*-- Linhas 423 a 437:
423: 
424:         *-- Campos principais (Say8/getCods, Say1/getDescrs) - 1a metade dos
425:         *-- campos da Page2. Compensacao PageFrame +29 no Top (regra #11).
426:         *-- Nomes conforme mapeamento.json (lbl_4c_Label8/1, txt_4c_Codigo/Descrs).
427: 
428:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
429:         WITH loc_oPagina.lbl_4c_Label8
430:             .Caption   = "C" + CHR(243) + "digo :"
431:             .Top       = 191
432:             .Left      = 118
433:             .Width     = 42
434:             .Height    = 17
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 443 a 467:
443: 
444:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
445:         WITH loc_oPagina.txt_4c_Codigo
446:             .Top       = 188
447:             .Left      = 162
448:             .Width     = 80
449:             .Height    = 23
450:             .MaxLength = 10
451:             .Format    = "!"
452:             .FontSize  = 8
453:             .ForeColor = RGB(0, 0, 0)
454:             .Value     = ""
455:             .Visible   = .T.
456:         ENDWITH
457: 
458:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
459:         WITH loc_oPagina.lbl_4c_Label1
460:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
461:             .Top       = 216
462:             .Left      = 105
463:             .Width     = 55
464:             .Height    = 17
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 473 a 504:
473: 
474:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
475:         WITH loc_oPagina.txt_4c_Descrs
476:             .Top       = 213
477:             .Left      = 162
478:             .Width     = 537
479:             .Height    = 23
480:             .MaxLength = 76
481:             .Format    = "!"
482:             .FontSize  = 8
483:             .ForeColor = RGB(0, 0, 0)
484:             .Value     = ""
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         *-- Campos restantes (Say3/getMensas, Say2/optTipo) - 2a metade dos
489:         *-- campos da Page2. Compensacao PageFrame +29 no Top (regra #11).
490:         *-- Nomes conforme mapeamento.json (lbl_4c_Label3/2, obj_4c_GetMensas/OptTipo).
491:         *-- NAO ha lookups neste form: codigo fonte original nao usa
492:         *-- fwbuscaext/fwBuscaSel/sigacess em nenhum campo (confirmado em
493:         *-- comportamento.json - funcoesExternas: fConfigGeral, fUniqueIds).
494: 
495:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
496:         WITH loc_oPagina.lbl_4c_Label3
497:             .Caption   = "Mensagem :"
498:             .Top       = 239
499:             .Left      = 100
500:             .Width     = 60
501:             .Height    = 17
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8
504:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 510 a 532:
510: 
511:         loc_oPagina.AddObject("obj_4c_GetMensas", "EditBox")
512:         WITH loc_oPagina.obj_4c_GetMensas
513:             .Top       = 238
514:             .Left      = 162
515:             .Width     = 537
516:             .Height    = 103
517:             .FontSize  = 8
518:             .ForeColor = RGB(0, 0, 0)
519:             .Value     = ""
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
524:         WITH loc_oPagina.lbl_4c_Label2
525:             .Caption   = "Tipo :"
526:             .Top       = 349
527:             .Left      = 131
528:             .Width     = 29
529:             .Height    = 17
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 546 a 618:
546:             .BackStyle   = 0
547:             .BorderStyle = 0
548:             .Value       = 1
549:             .Top         = 343
550:             .Left        = 156
551:             .Width       = 292
552:             .Height      = 27
553:             .Visible     = .T.
554: 
555:             WITH .Buttons(1)
556:                 .Caption   = "Cheque"
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 8
559:                 .BackStyle = 0
560:                 .Left      = 7
561:                 .Top       = 5
562:                 .Width     = 62
563:                 .Height    = 17
564:                 .AutoSize  = .F.
565:                 .ForeColor = RGB(90, 90, 90)
566:             ENDWITH
567: 
568:             WITH .Buttons(2)
569:                 .Caption   = "T" + CHR(237) + "tulo"
570:                 .FontName  = "Tahoma"
571:                 .FontSize  = 8
572:                 .BackStyle = 0
573:                 .Left      = 84
574:                 .Top       = 5
575:                 .Width     = 62
576:                 .Height    = 17
577:                 .AutoSize  = .F.
578:                 .ForeColor = RGB(90, 90, 90)
579:             ENDWITH
580: 
581:             WITH .Buttons(3)
582:                 .Caption   = "Follow Up"
583:                 .FontName  = "Tahoma"
584:                 .FontSize  = 8
585:                 .BackStyle = 0
586:                 .Left      = 148
587:                 .Top       = 5
588:                 .Width     = 64
589:                 .Height    = 15
590:                 .AutoSize  = .T.
591:                 .ForeColor = RGB(90, 90, 90)
592:             ENDWITH
593:         ENDWITH
594: 
595:         *-- Container Botoes de Acao (Grupo_Salva no legado) - canonico
596:         *-- (cnt_4c_Salva): Left=842, Top=33; Confirmar/Cancelar Left=5/80
597:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
598:         WITH loc_oPagina.cnt_4c_BotoesAcao
599:             .Top         = 33
600:             .Left        = 842
601:             .Width       = 160
602:             .Height      = 85
603:             .BackStyle   = 0
604:             .BorderWidth = 0
605:             .Visible     = .T.
606: 
607:             .AddObject("cmd_4c_Confirmar", "CommandButton")
608:             WITH .cmd_4c_Confirmar
609:                 .Caption         = "Confirmar"
610:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
611:                 .PicturePosition = 13
612:                 .Top             = 5
613:                 .Left            = 5
614:                 .Width           = 75
615:                 .Height          = 75
616:                 .BackColor       = RGB(255, 255, 255)
617:                 .ForeColor       = RGB(90, 90, 90)
618:                 .FontName        = "Comic Sans MS"

*-- Linhas 627 a 641:
627:                 .Visible         = .T.
628:             ENDWITH
629: 
630:             .AddObject("cmd_4c_Cancelar", "CommandButton")
631:             WITH .cmd_4c_Cancelar
632:                 .Caption         = "Encerrar"
633:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
634:                 .PicturePosition = 13
635:                 .Top             = 5
636:                 .Left            = 80
637:                 .Width           = 75
638:                 .Height          = 75
639:                 .BackColor       = RGB(255, 255, 255)
640:                 .ForeColor       = RGB(90, 90, 90)
641:                 .FontName        = "Comic Sans MS"

*-- Linhas 651 a 660:
651:             ENDWITH
652:         ENDWITH
653: 
654:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
655:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
656: 
657:         *-- Validacao de codigo duplicado (transcricao do Valid legado de
658:         *-- getCods: ChkRegister + MessageBox + limpa o campo). LostFocus
659:         *-- (NAO KeyPress) - regra #47 CLAUDE.md.
660:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "LostFocus", THIS, "ValidarCodigoDuplicado")

*-- Linhas 811 a 819:
811:                 *-- Confirmar fica DESABILITADO no modo VISUALIZAR, entao o foco
812:                 *-- vai para o Cancelar, que eh o botao ativo da ficha.
813:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
814:                 THIS.FocarControle(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar)
815:             ENDIF
816:         ENDIF
817:     ENDPROC
818: 
819:     *===========================================================================

*-- Linhas 1060 a 1070:
1060:                     loc_oGrid.Column2.ReadOnly = .T.
1061:                     loc_oGrid.Column3.ReadOnly = .T.
1062: 
1063:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1064:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1065:                     loc_oGrid.Column3.Header1.Caption = "Tipo"
1066: 
1067:                     THIS.FormatarGridLista(loc_oGrid)
1068: 
1069:                     *-- Legado fecha a carga da Grade com "Go Top In <cursor>"
1070:                     *-- + "grade.Refresh" (regra #21: popular cursor NAO

*-- Linhas 1185 a 1197:
1185:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1186: 
1187:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1188:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1189:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1190:             ENDIF
1191:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1192:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1193:             ENDIF
1194:         ENDIF
1195:     ENDPROC
1196: 
1197:     *===========================================================================


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*====================================================================
* SIGPRINTBO.prg
*
* Business Object para SIGPRINT (Cadastro de Instrucoes)
* Tabela principal: SigOpIns (cidchaves PK, cods codigo de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

	*-- Propriedades da entidade (SigOpIns)
	this_cCidChaves = ""   && cidchaves char(20) - PK (ID unico gerado por fUniqueIds)
	this_cCods      = ""   && cods char(10)      - codigo da instrucao (indice nao-unico)
	this_cDescrs    = ""   && descrs char(76)    - descricao da instrucao
	this_cMensas    = ""   && mensas text        - mensagem impressa na solicitacao
	this_nTipos     = 0    && tipos numeric(1,0) - tipo (1=Cheque, 2=Titulo, 3=Follow Up)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = "SigOpIns"
		THIS.this_cCampoChave = "cidchaves"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescrs    = TratarNulo(descrs,    "C")
				THIS.this_cMensas    = TratarNulo(mensas,    "C")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigOpIns
	* cidchaves eh a PK tecnica (Fortyus), gerada via fUniqueIds()
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)
				VALUES (
					<<EscaparSQL(THIS.this_cCods)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<EscaparSQL(THIS.this_cMensas)>>,
					<<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					<<EscaparSQL(THIS.this_cCidChaves)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRINTBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigOpIns
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigOpIns
				SET cods   = <<EscaparSQL(THIS.this_cCods)>>,
					descrs = <<EscaparSQL(THIS.this_cDescrs)>>,
					mensas = <<EscaparSQL(THIS.this_cMensas)>>,
					tipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRINTBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro pela chave primaria (cidchaves)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigOpIns WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRINTBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cidchaves, cods, descrs, tipos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(10), descrs C(76), tipos N(1,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descrs, tipos FROM SigOpIns"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY cods"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SIGPRINTBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	* par_cCodigo recebe cidchaves (cods NAO e unico - indice nao-unico)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descrs, mensas, tipos" + ;
				" FROM SigOpIns WHERE cidchaves = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Instru" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


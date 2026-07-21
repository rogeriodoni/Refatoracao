# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descritivo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inclusão' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descritivo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inclusão' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Usuário, Nome. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACJ.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1501 linhas total):

*-- Linhas 46 a 55:
46:                 THIS.ConfigurarPaginaLista()
47:                 THIS.ConfigurarPaginaDados()
48: 
49:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
51: 
52:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
53:                     THIS.CarregarLista()
54:                 ENDIF
55: 

*-- Linhas 71 a 90:
71:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
72:         WITH THIS.pgf_4c_Paginas
73:             .PageCount = 2
74:             .Top       = -29
75:             .Left      = 0
76:             .Width     = THIS.Width
77:             .Height    = THIS.Height + 29
78:             .Tabs      = .F.
79:             .Visible   = .T.
80: 
81:             .Page1.Caption   = "Lista"
82:             .Page1.BackColor = RGB(217, 217, 217)
83:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
84: 
85:             .Page2.Caption   = "Dados"
86:             .Page2.BackColor = RGB(217, 217, 217)
87:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:         ENDWITH
89:         THIS.pgf_4c_Paginas.Visible = .T.
90:     ENDPROC

*-- Linhas 102 a 170:
102:         *-- Container cabecalho (fundo escuro com titulo)
103:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH loc_oPagina.cnt_4c_Cabecalho
105:             .Top         = 31
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackColor   = RGB(100, 100, 100)
110:             .BorderWidth = 0
111:             .Visible     = .T.
112:         ENDWITH
113: 
114:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
115:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
116:             .Top       = 15
117:             .Left      = 10
118:             .Width     = THIS.Width
119:             .Height    = 40
120:             .Caption   = THIS.Caption
121:             .FontName  = "Tahoma"
122:             .FontSize  = 16
123:             .FontBold  = .T.
124:             .ForeColor = RGB(0, 0, 0)
125:             .BackStyle = 0
126:             .AutoSize  = .F.
127:             .Visible   = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
132:             .Top       = 18
133:             .Left      = 10
134:             .Width     = THIS.Width
135:             .Height    = 46
136:             .Caption   = THIS.Caption
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(255, 255, 255)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         *-- Container de botoes CRUD (lado direito, Top compensado +29)
147:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
148:         WITH loc_oPagina.cnt_4c_Botoes
149:             .Top         = 29
150:             .Left        = 542
151:             .Width       = 390
152:             .Height      = 85
153:             .BackStyle = 0
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Botao Incluir
159:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
160:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
161:             .Caption         = "Incluir"
162:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:             .PicturePosition = 13
164:             .Top             = 5
165:             .Left            = 5
166:             .Width           = 75
167:             .Height          = 75
168:             .BackColor       = RGB(255, 255, 255)
169:             .ForeColor       = RGB(90, 90, 90)
170:             .FontName        = "Tahoma"

*-- Linhas 178 a 195:
178:             .MousePointer    = 15
179:             .Visible         = .T.
180:         ENDWITH
181:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
182: 
183:         *-- Botao Visualizar
184:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
185:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
186:             .Caption         = "Visualizar"
187:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
188:             .PicturePosition = 13
189:             .Top             = 5
190:             .Left            = 80
191:             .Width           = 75
192:             .Height          = 75
193:             .BackColor       = RGB(255, 255, 255)
194:             .ForeColor       = RGB(90, 90, 90)
195:             .FontName        = "Tahoma"

*-- Linhas 203 a 220:
203:             .MousePointer    = 15
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
207: 
208:         *-- Botao Alterar
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
211:             .Caption         = "Alterar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 155
216:             .Width           = 75
217:             .Height          = 75
218:             .BackColor       = RGB(255, 255, 255)
219:             .ForeColor       = RGB(90, 90, 90)
220:             .FontName        = "Tahoma"

*-- Linhas 228 a 245:
228:             .MousePointer    = 15
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         *-- Botao Excluir
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 230
241:             .Width           = 75
242:             .Height          = 75
243:             .BackColor       = RGB(255, 255, 255)
244:             .ForeColor       = RGB(90, 90, 90)
245:             .FontName        = "Tahoma"

*-- Linhas 253 a 270:
253:             .MousePointer    = 15
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
257: 
258:         *-- Botao Buscar
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
261:             .Caption         = "Buscar"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 305
266:             .Width           = 75
267:             .Height          = 75
268:             .BackColor       = RGB(255, 255, 255)
269:             .ForeColor       = RGB(90, 90, 90)
270:             .FontName        = "Tahoma"

*-- Linhas 278 a 306:
278:             .MousePointer    = 15
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container de saida (padrao canonico - prevalece sobre legado)
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294: 
295:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
296:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
297:             .Caption         = "Encerrar"
298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
299:             .PicturePosition = 13
300:             .Top             = 5
301:             .Left            = 5
302:             .Width           = 75
303:             .Height          = 75
304:             .BackColor       = RGB(255, 255, 255)
305:             .ForeColor       = RGB(90, 90, 90)
306:             .FontName        = "Tahoma"

*-- Linhas 314 a 328:
314:             .MousePointer    = 15
315:             .Visible         = .T.
316:         ENDWITH
317:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
318: 
319:         *-- Grid de JOBs (cursor criado por CarregarLista/Buscar)
320:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
321:         loc_oGrid = loc_oPagina.grd_4c_Lista
322:         loc_oGrid.Top         = 117
323:         loc_oGrid.Left        = 26
324:         loc_oGrid.Width       = 890
325:         loc_oGrid.Height      = 498
326:         loc_oGrid.ColumnCount = 5
327: 
328:         WITH loc_oGrid

*-- Linhas 360 a 383:
360:         *-- Container de botoes Confirmar/Cancelar (Top=4+29=33)
361:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
362:         WITH loc_oPagina.cnt_4c_BotoesAcao
363:             .Top         = 33
364:             .Left        = 842
365:             .Width       = 160
366:             .Height      = 85
367:             .BackStyle   = 0
368:             .BorderWidth = 0
369:             .Visible     = .T.
370:         ENDWITH
371: 
372:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
373:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
374:             .Caption         = "Confirmar"
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
376:             .PicturePosition = 13
377:             .Top             = 5
378:             .Left            = 5
379:             .Width           = 75
380:             .Height          = 75
381:             .BackColor       = RGB(255, 255, 255)
382:             .ForeColor       = RGB(90, 90, 90)
383:             .FontName        = "Tahoma"

*-- Linhas 391 a 407:
391:             .MousePointer    = 15
392:             .Visible         = .T.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
395: 
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
398:             .Caption         = "Encerrar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 80
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Tahoma"

*-- Linhas 415 a 443:
415:             .MousePointer    = 15
416:             .Visible         = .T.
417:         ENDWITH
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
419: 
420:         *-- Container de saida (padrao canonico)
421:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
422:         WITH loc_oPagina.cnt_4c_Saida
423:             .Top         = 29
424:             .Left        = 917
425:             .Width       = 90
426:             .Height      = 85
427:             .BackStyle   = 0
428:             .BorderWidth = 0
429:             .Visible     = .T.
430:         ENDWITH
431: 
432:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
433:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
434:             .Caption         = "Encerrar"
435:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
436:             .PicturePosition = 13
437:             .Top             = 5
438:             .Left            = 5
439:             .Width           = 75
440:             .Height          = 75
441:             .BackColor       = RGB(255, 255, 255)
442:             .ForeColor       = RGB(90, 90, 90)
443:             .FontName        = "Tahoma"

*-- Linhas 451 a 484:
451:             .MousePointer    = 15
452:             .Visible         = .T.
453:         ENDWITH
454:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
455: 
456:         *-- CheckBox chkInativos: top=27+29=56, left=307 (acima da linha principal)
457:         loc_oPagina.AddObject("chk_4c_ChkInativos", "CheckBox")
458:         WITH loc_oPagina.chk_4c_ChkInativos
459:             .Caption   = "Inativo"
460:             .Value     = 0
461:             .Top       = 56
462:             .Left      = 307
463:             .Width     = 80
464:             .Height    = 17
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .ForeColor = RGB(90, 90, 90)
468:             .BackStyle = 0
469:             .ReadOnly  = .T.
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         *-- Linha 1: Grupo | Criacao do JOB | Criado em
474:         *-- Label Say1 "Grupo :" top=49+29=78, left=267
475:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
476:         WITH loc_oPagina.lbl_4c_Label1
477:             .Caption   = "Grupo :"
478:             .Top       = 78
479:             .Left      = 267
480:             .Width     = 40
481:             .Height    = 17
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 492 a 515:
492:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
493:         WITH loc_oPagina.txt_4c_Grupo
494:             .Value    = ""
495:             .Top      = 74
496:             .Left     = 307
497:             .Width    = 80
498:             .Height   = 21
499:             .FontName = "Tahoma"
500:             .FontSize = 8
501:             .ReadOnly = .T.
502:             .Visible  = .T.
503:         ENDWITH
504: 
505:         *-- Label Say4 "Criacao do JOB :" top=49+29=78, left=410
506:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
507:         WITH loc_oPagina.lbl_4c_Label4
508:             .Caption   = "Cria" + CHR(231) + CHR(227) + "o do JOB :"
509:             .Top       = 78
510:             .Left      = 410
511:             .Width     = 84
512:             .Height    = 17
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 523 a 546:
523:         loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
524:         WITH loc_oPagina.txt_4c_Usuars
525:             .Value    = ""
526:             .Top      = 74
527:             .Left     = 494
528:             .Width    = 92
529:             .Height   = 23
530:             .FontName = "Tahoma"
531:             .FontSize = 8
532:             .ReadOnly = .T.
533:             .Visible  = .T.
534:         ENDWITH
535: 
536:         *-- Label Say5 "Criado em :" top=49+29=78, left=611
537:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
538:         WITH loc_oPagina.lbl_4c_Label5
539:             .Caption   = "Criado em :"
540:             .Top       = 78
541:             .Left      = 611
542:             .Width     = 58
543:             .Height    = 17
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 554 a 578:
554:         loc_oPagina.AddObject("txt_4c_DataIncs", "TextBox")
555:         WITH loc_oPagina.txt_4c_DataIncs
556:             .Value    = ""
557:             .Top      = 74
558:             .Left     = 670
559:             .Width    = 80
560:             .Height   = 21
561:             .FontName = "Tahoma"
562:             .FontSize = 8
563:             .ReadOnly = .T.
564:             .Visible  = .T.
565:         ENDWITH
566: 
567:         *-- Linha 2: JOB codigo | JOB descricao abreviada
568:         *-- Label Say2 "JOB :" top=75+29=104, left=277
569:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
570:         WITH loc_oPagina.lbl_4c_Label2
571:             .Caption   = "JOB :"
572:             .Top       = 104
573:             .Left      = 277
574:             .Width     = 30
575:             .Height    = 17
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 586 a 624:
586:         loc_oPagina.AddObject("txt_4c_IClis", "TextBox")
587:         WITH loc_oPagina.txt_4c_IClis
588:             .Value    = ""
589:             .Top      = 100
590:             .Left     = 307
591:             .Width    = 80
592:             .Height   = 21
593:             .FontName = "Tahoma"
594:             .FontSize = 8
595:             .ReadOnly = .T.
596:             .Visible  = .T.
597:         ENDWITH
598: 
599:         *-- TextBox getRClis (descritivo abreviado): top=71+29=100, left=390, width=360
600:         loc_oPagina.AddObject("txt_4c_RClis", "TextBox")
601:         WITH loc_oPagina.txt_4c_RClis
602:             .Value    = ""
603:             .Top      = 100
604:             .Left     = 390
605:             .Width    = 360
606:             .Height   = 21
607:             .FontName = "Tahoma"
608:             .FontSize = 8
609:             .ReadOnly = .T.
610:             .Visible  = .T.
611:         ENDWITH
612: 
613:         *-- Linha 3: Descritivo completo
614:         *-- Label Say3 "Descritivo :" top=101+29=130, left=249
615:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
616:         WITH loc_oPagina.lbl_4c_Label3
617:             .Caption   = "Descritivo :"
618:             .Top       = 130
619:             .Left      = 249
620:             .Width     = 58
621:             .Height    = 17
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 632 a 655:
632:         loc_oPagina.AddObject("txt_4c_Razaos", "TextBox")
633:         WITH loc_oPagina.txt_4c_Razaos
634:             .Value    = ""
635:             .Top      = 126
636:             .Left     = 307
637:             .Width    = 443
638:             .Height   = 23
639:             .FontName = "Tahoma"
640:             .FontSize = 8
641:             .ReadOnly = .T.
642:             .Visible  = .T.
643:         ENDWITH
644: 
645:         *-- Label Say6 "Lista de Usuarios..." top=154+29=183, left=308
646:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
647:         WITH loc_oPagina.lbl_4c_Label6
648:             .Caption   = "Lista de Usu" + CHR(225) + "rios Que Ter" + CHR(227) + "o Acesso a Esse JOB:"
649:             .Top       = 183
650:             .Left      = 308
651:             .Width     = 340
652:             .Height    = 17
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 670 a 679:
670:         LOCAL loc_oGrdUsu
671:         loc_oPagina.AddObject("grd_4c_Usuarios", "Grid")
672:         loc_oGrdUsu = loc_oPagina.grd_4c_Usuarios
673:         loc_oGrdUsu.Top         = 199
674:         loc_oGrdUsu.Left        = 307
675:         loc_oGrdUsu.Width       = 343
676:         loc_oGrdUsu.Height      = 418
677:         loc_oGrdUsu.ColumnCount = 2
678: 
679:         WITH loc_oGrdUsu

*-- Linhas 698 a 752:
698:         WITH loc_oGrdUsu
699:             .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
700:             .Column1.Width           = 120
701:             .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
702: 
703:             .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
704:             .Column2.Width           = 200
705:             .Column2.Header1.Caption = "Nome"
706:         ENDWITH
707: 
708:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "When",  THIS, "GrdUsuariosColumn1When")
709:         BINDEVENT(loc_oGrdUsu.Column1.Text1, "Valid",  THIS, "GrdUsuariosColumn1Valid")
710:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "When",  THIS, "GrdUsuariosColumn2When")
711:         BINDEVENT(loc_oGrdUsu.Column2.Text1, "Valid",  THIS, "GrdUsuariosColumn2Valid")
712: 
713:         *-- Botao Inserir linha no grid (legado: btnInserir top=170, left=654, +29)
714:         loc_oPagina.AddObject("cmd_4c_InserirUsuario", "CommandButton")
715:         WITH loc_oPagina.cmd_4c_InserirUsuario
716:             .Caption         = ""
717:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
718:             .PicturePosition = 13
719:             .Top             = 199
720:             .Left            = 654
721:             .Width           = 42
722:             .Height          = 42
723:             .Themes          = .T.
724:             .SpecialEffect   = 0
725:             .MousePointer    = 15
726:             .ToolTipText     = "Inserir usu" + CHR(225) + "rio"
727:             .Visible         = .T.
728:         ENDWITH
729:         BINDEVENT(loc_oPagina.cmd_4c_InserirUsuario, "Click", THIS, "BtnInserirUsuarioClick")
730: 
731:         *-- Botao Excluir linha no grid (legado: btnExcluir top=212, left=654, +29)
732:         loc_oPagina.AddObject("cmd_4c_ExcluirUsuario", "CommandButton")
733:         WITH loc_oPagina.cmd_4c_ExcluirUsuario
734:             .Caption         = ""
735:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
736:             .PicturePosition = 13
737:             .Top             = 241
738:             .Left            = 654
739:             .Width           = 42
740:             .Height          = 42
741:             .Themes          = .T.
742:             .SpecialEffect   = 0
743:             .MousePointer    = 15
744:             .ToolTipText     = "Excluir usu" + CHR(225) + "rio"
745:             .Visible         = .T.
746:         ENDWITH
747:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirUsuario, "Click", THIS, "BtnExcluirUsuarioClick")
748: 
749:         THIS.TornarControlesVisiveis(loc_oPagina)
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------

*-- Linhas 774 a 798:
774:                 WITH loc_oGrid
775:                     .Column1.ControlSource  = "cursor_4c_GradeJOB.IClis"
776:                     .Column1.Width          = 80
777:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
778: 
779:                     .Column2.ControlSource  = "cursor_4c_GradeJOB.RClis"
780:                     .Column2.Width          = 80
781:                     .Column2.Header1.Caption = "Nome"
782: 
783:                     .Column3.ControlSource  = "cursor_4c_GradeJOB.Razaos"
784:                     .Column3.Width          = 420
785:                     .Column3.Header1.Caption = "Descritivo"
786: 
787:                     .Column4.ControlSource  = "cursor_4c_GradeJOB.Usuars"
788:                     .Column4.Width          = 80
789:                     .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
790: 
791:                     .Column5.ControlSource  = "cursor_4c_GradeJOB.DataIncs"
792:                     .Column5.Width          = 80
793:                     .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
794: 
795:                     .Refresh()
796:                 ENDWITH
797: 
798:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 916 a 932:
916:                         loc_oGrid.ColumnCount  = 5
917:                         WITH loc_oGrid
918:                             .Column1.ControlSource   = "cursor_4c_GradeJOB.IClis"
919:                             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
920:                             .Column2.ControlSource   = "cursor_4c_GradeJOB.RClis"
921:                             .Column2.Header1.Caption = "Nome"
922:                             .Column3.ControlSource   = "cursor_4c_GradeJOB.Razaos"
923:                             .Column3.Header1.Caption = "Descritivo"
924:                             .Column4.ControlSource   = "cursor_4c_GradeJOB.Usuars"
925:                             .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
926:                             .Column5.ControlSource   = "cursor_4c_GradeJOB.DataIncs"
927:                             .Column5.Header1.Caption = "Inclus" + CHR(227) + "o"
928:                             .Refresh()
929:                         ENDWITH
930:                         loc_lSucesso = .T.
931:                     ENDIF
932:                 ELSE

*-- Linhas 1149 a 1164:
1149: 
1150:         TRY
1151:             *-- Botoes de linha do grid (Inserir/Excluir usuario)
1152:             IF VARTYPE(loc_oPg2.cmd_4c_InserirUsuario) = "O"
1153:             ENDIF
1154:             IF VARTYPE(loc_oPg2.cmd_4c_ExcluirUsuario) = "O"
1155:             ENDIF
1156:             *-- Botao Confirmar
1157:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1158:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
1159:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1160:                 ENDIF
1161:             ENDIF
1162:         CATCH TO loc_oErro
1163:             MsgErro("Erro ao ajustar estado dos controles:" + CHR(13) + loc_oErro.Message, "Erro")
1164:         ENDTRY

*-- Linhas 1260 a 1271:
1260:             WITH loc_oGrid
1261:                 .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
1262:                 .Column1.Width           = 120
1263:                 .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1264:                 .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
1265:                 .Column2.Width           = 200
1266:                 .Column2.Header1.Caption = "Nome"
1267:             ENDWITH
1268: 
1269:             loc_oGrid.Refresh()
1270:             loc_lSucesso = .T.
1271:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\ACJBO.prg):
*==============================================================================
* ACJBO.prg - Business Object para Acessos de JOB
* Tabela principal: SigCdAcJ | PK: pkChaves
* Lista de JOBs: SigCdCli (filtro SigCdGcr.Coletors=10)
*==============================================================================

DEFINE CLASS ACJBO AS BusinessBase

    *-- Propriedades do JOB selecionado (display - SigCdCli via crGradeJOB)
    this_cGrupos        = ""    && Grupos    CHAR  - Grupo do JOB
    this_cIClis         = ""    && IClis     CHAR  - C" + CHR(243) + "digo do JOB (PK em SigCdCli)
    this_cRClis         = ""    && RClis     CHAR  - C" + CHR(243) + "digo abreviado
    this_cRazaos        = ""    && Razaos    CHAR  - Descritivo do JOB
    this_cUsuarsCriador = ""    && Usuars    CHAR  - Usu" + CHR(225) + "rio que criou o JOB
    this_dDataIncs      = {}    && DataIncs  DATE  - Data de inclus" + CHR(227) + "o
    this_lInativas      = .F.   && Inativas  NUM   - Inativo (0=N, 1=S)

    *-- Propriedades de controle de acesso (SigCdAcJ)
    this_cPkChaves      = ""    && pkChaves  CHAR  - Chave prim" + CHR(225) + "ria (gerada por fUniqueIds)
    this_cJOBs          = ""    && JOBs      CHAR  - FK para IClis do JOB
    this_cUsuars        = ""    && Usuars    CHAR  - Login do usu" + CHR(225) + "rio com acesso
    this_cNComps        = ""    && NComps    CHAR  - Nome completo (JOIN SigCdUsu.NComps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAcJ"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cJOBs     = TratarNulo(JOBs,     "C")
                THIS.this_cUsuars   = TratarNulo(Usuars,   "C")
                THIS.this_cNComps   = TratarNulo(NComps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarJobDoCursor - Carrega dados do JOB selecionado (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarJobDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos        = TratarNulo(Grupos,   "C")
                THIS.this_cIClis         = TratarNulo(IClis,    "C")
                THIS.this_cRClis         = TratarNulo(RClis,    "C")
                THIS.this_cRazaos        = TratarNulo(Razaos,   "C")
                THIS.this_cUsuarsCriador = TratarNulo(Usuars,   "C")
                THIS.this_dDataIncs      = TratarNulo(DataIncs, "D")
                THIS.this_lInativas      = (TratarNulo(Inativas, "N") = 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar JOB do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de JOBs (SigCdCli filtrado por Coletors=10)
    * Cursor destino: cursor_4c_GradeJOB
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Grupos, a.IClis, a.RClis, a.Razaos," + ;
                       " a.Inativas, a.Usuars, a.DataIncs" + ;
                       " FROM SigCdGcr b, SigCdCli a" + ;
                       " WHERE b.Coletors = 10" + ;
                       " AND b.Codigos = a.Grupos"

            loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GradeJOB")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar JOBs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar JOBs:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega usu" + CHR(225) + "rios com acesso ao JOB
    * Cursor destino: cursor_4c_AcJ
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.JOBs = " + EscaparSQL(ALLTRIM(par_cIClis)) + ;
                       " ORDER BY a.Usuars"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcJ")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Salva lista de usu" + CHR(225) + "rios com acesso ao JOB
    * Estrat" + CHR(233) + "gia: DELETE todos os existentes + INSERT dos atuais
    * Par" + CHR(226) + "metro: par_cIClis - c" + CHR(243) + "digo do JOB
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            *-- 1. Deletar todos os acessos antigos para este JOB
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Inserir registros atuais do cursor (somente com Usuars preenchido e nao deletados)
            IF USED("cursor_4c_AcJ") AND RECCOUNT("cursor_4c_AcJ") > 0
                SELECT cursor_4c_AcJ
                GO TOP
                DO WHILE !EOF("cursor_4c_AcJ")
                    IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
                        loc_cPkChaves = ALLTRIM(cursor_4c_AcJ.pkChaves)
                        IF EMPTY(loc_cPkChaves)
                            loc_cPkChaves = SYS(2015) + SYS(2015)
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cIClis)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_AcJ.Usuars)) + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso para usu" + CHR(225) + "rio " + ;
                                   ALLTRIM(cursor_4c_AcJ.Usuars) + ":" + CHR(13) + ;
                                   CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP IN cursor_4c_AcJ
                ENDDO
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirAcessos - Remove todos os acessos de um JOB
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inserir registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                       EscaparSQL(THIS.this_cJOBs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualizar registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdAcJ SET" + ;
                       " JOBs = " + EscaparSQL(THIS.this_cJOBs) + "," + ;
                       " Usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro individual (chamado pelo BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega acesso pela chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.pkChaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidadeUsuario - Verifica usu" + CHR(225) + "rios duplicados no cursor local
    * Retorna "" se OK, ou mensagem de erro se houver duplicata
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUnicidadeUsuario()
        LOCAL loc_cMensagem, loc_lSucesso
        loc_cMensagem = ""
        loc_lSucesso  = .F.

        TRY
            IF !USED("cursor_4c_AcJ")
                loc_lSucesso = ""
            ENDIF

            SELECT SUM(1) AS Soma, Usuars ;
              FROM cursor_4c_AcJ ;
             WHERE !DELETED() AND !EMPTY(ALLTRIM(Usuars)) ;
             GROUP BY Usuars ;
              INTO CURSOR cursor_4c_DuplAcJ

            GO TOP IN cursor_4c_DuplAcJ
            SELECT cursor_4c_DuplAcJ
            LOCATE FOR cursor_4c_DuplAcJ.Soma > 1
            IF !EOF("cursor_4c_DuplAcJ")
                loc_cMensagem = "O Usu" + CHR(225) + "rio " + CHR(34) + ;
                               ALLTRIM(cursor_4c_DuplAcJ.Usuars) + ;
                               CHR(34) + " est" + CHR(225) + " duplicado na grade!!!"
            ENDIF

            IF USED("cursor_4c_DuplAcJ")
                USE IN cursor_4c_DuplAcJ
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

ENDDEFINE


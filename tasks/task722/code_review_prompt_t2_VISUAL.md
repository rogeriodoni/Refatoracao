# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption 'Nome do Demonstrativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Fase, Funcionário, E/S, Ordem, Tipo Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo Operaç' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Fase, Funcionário, E/S, Ordem, Tipo Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigOpDmp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4218 linhas total):

*-- Linhas 60 a 68:
60: *   - Grupo_op (Left=338) e Grupo_Saida (Left=718) do SCX estao no espaco de
61: *     coordenadas do frmcadastro de 800px. O form novo tem 1000px e usa os
62: *     valores canonicos 542 e 917 (CLAUDE.md regra #10).
63: *   - Pagina.Top = -29 no legado: todo controle das Pages compensa +29 no Top.
64: *==============================================================================
65: 
66: DEFINE CLASS FormSigOpDmp AS FormBase
67: 
68:     *-- Propriedades visuais (PILAR 1 - frmcadastro: 1000x600, sem barra de titulo)

*-- Linhas 139 a 150:
139: 
140:                 *-- Titulo das faixas das DUAS paginas (legado: lblSombra/lblTitulo
141:                 *-- recebem ThisForm.Caption no Init do frmcadastro)
142:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
143:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
144:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
145:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
146: 
147:                 THIS.pgf_4c_Paginas.Visible    = .T.
148:                 THIS.pgf_4c_Paginas.ActivePage = 1
149:                 THIS.this_cModoAtual           = "LISTA"
150: 

*-- Linhas 180 a 202:
180: 
181:         WITH THIS.pgf_4c_Paginas
182:             .PageCount = 2
183:             .Top       = -29
184:             .Left      = 0
185:             .Width     = THIS.Width
186:             .Height    = THIS.Height + 29
187:             .Tabs      = .F.
188:             .Visible   = .T.
189: 
190:             *-- Page1 = Lista (legado: Pagina.Page1.Name = "Lista")
191:             .Page1.Caption   = "Lista"
192:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
193:             .Page1.BackColor = RGB(255, 255, 255)
194: 
195:             *-- Page2 = Dados (legado: Pagina.Page2.Name = "Dados", com a
196:             *-- Picture sobrescrita no SCX para new_background.jpg)
197:             .Page2.Caption   = "Dados"
198:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
199:             .Page2.BackColor = RGB(255, 255, 255)
200:         ENDWITH
201: 
202:         THIS.ConfigurarPaginaLista()

*-- Linhas 223 a 232:
223:         *-- BackColor=100,100,100; com a compensacao +29 do PageFrame -> Top=29)
224:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
225:         WITH loc_oPagina.cnt_4c_Cabecalho
226:             .Top         = 29
227:             .Left        = 0
228:             .Width       = THIS.Width
229:             .Height      = 80
230:             .BackStyle   = 1
231:             .BackColor   = RGB(100, 100, 100)
232:             .BorderWidth = 0

*-- Linhas 240 a 249:
240:         *-- Canonico do form de 1000px: Top=29 (-1+29), Left=542, Width=390.
241:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
242:         WITH loc_oPagina.cnt_4c_Botoes
243:             .Top         = 29
244:             .Left        = 542
245:             .Width       = 390
246:             .Height      = 85
247:             .BackStyle   = 0
248:             .BorderWidth = 0
249:             .Visible     = .T.

*-- Linhas 260 a 274:
260:         *-- handlers dos 5 vem na Fase 7, junto com o Grupo_op.Click do legado.
261: 
262:         *-- Incluir (legado: Grupo_op.Inserir)
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
265:             .Caption         = "Incluir"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 5
270:             .Width           = 75
271:             .Height          = 75
272:             .FontName        = "Tahoma"
273:             .FontBold        = .T.
274:             .FontItalic      = .T.

*-- Linhas 284 a 298:
284:         ENDWITH
285: 
286:         *-- Visualizar (legado: Grupo_op.Consultar)
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
289:             .Caption         = "Visualizar"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 80
294:             .Width           = 75
295:             .Height          = 75
296:             .FontName        = "Tahoma"
297:             .FontBold        = .T.
298:             .FontItalic      = .T.

*-- Linhas 308 a 322:
308:         ENDWITH
309: 
310:         *-- Alterar (legado: Grupo_op.Alterar)
311:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
313:             .Caption         = "Alterar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 155
318:             .Width           = 75
319:             .Height          = 75
320:             .FontName        = "Tahoma"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.

*-- Linhas 332 a 346:
332:         ENDWITH
333: 
334:         *-- Excluir (legado: Grupo_op.Excluir)
335:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
336:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
337:             .Caption         = "Excluir"
338:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
339:             .PicturePosition = 13
340:             .Top             = 5
341:             .Left            = 230
342:             .Width           = 75
343:             .Height          = 75
344:             .FontName        = "Tahoma"
345:             .FontBold        = .T.
346:             .FontItalic      = .T.

*-- Linhas 362 a 376:
362:         *-- campo Nome na pagina Dados; quem executa a consulta e o Confirmar,
363:         *-- que reproduz o msv_procurar (Set Near On, Seek pelo nome digitado,
364:         *-- Set Near Off) para posicionar a grade da Lista.
365:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
366:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
367:             .Caption         = "Buscar"
368:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
369:             .PicturePosition = 13
370:             .Top             = 5
371:             .Left            = 305
372:             .Width           = 75
373:             .Height          = 75
374:             .FontName        = "Tahoma"
375:             .FontBold        = .T.
376:             .FontItalic      = .T.

*-- Linhas 391 a 428:
391:         *-- Case do Do Case virou um handler PUBLIC proprio.
392:         *-- O Buscar (BtnBuscarClick) e BUSCA POR EXEMPLO - o legado tem
393:         *-- PROCEDURE msv_procurar - e quem executa a consulta e o Confirmar.
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
399: 
400:         *-- Container de saida (legado: Pagina.Lista.Grupo_Saida Top=-1,
401:         *-- Left=718 no espaco de 800px). Padrao canonico (regra #10, que
402:         *-- prevalece sobre o PILAR 1): Left=917, Width=90, Height=85,
403:         *-- transparente.
404:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
405:         WITH loc_oPagina.cnt_4c_Saida
406:             .Top         = 29
407:             .Left        = 917
408:             .Width       = 90
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413:         ENDWITH
414: 
415:         *-- Encerrar (legado: Grupo_Saida.SAIR Top=5 Left=5). Caption, Width e
416:         *-- Height sao os canonicos da regra #10, nao os do SCX.
417:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 5
424:             .Width           = 75
425:             .Height          = 75
426:             .FontName        = "Tahoma"
427:             .FontBold        = .T.
428:             .FontItalic      = .T.

*-- Linhas 436 a 457:
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
440: 
441:         *-- Grade da Lista (legado: Pagina.Lista.Grade). O SCX sobrescreve so
442:         *-- FontName="Tahoma", FontSize=8, RowHeight=16 e ForeColor=90,90,90;
443:         *-- a geometria vem da classe frmcadastro (Top=88 -> 117 com a
444:         *-- compensacao +29, Left=26, Height=498). Width=880 para a grade nao
445:         *-- correr por baixo de cnt_4c_Saida (Left=917).
446:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH as colunas
447:         *-- nao existem na linha seguinte).
448:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
449:         loc_oPagina.grd_4c_Lista.ColumnCount = 1
450:         WITH loc_oPagina.grd_4c_Lista
451:             .Top                = 117
452:             .Left               = 26
453:             .Width              = 880
454:             .Height             = 498
455:             .FontName           = "Tahoma"
456:             .FontSize           = 8
457:             .RowHeight          = 16

*-- Linhas 500 a 509:
500:         *-- Faixa do cabecalho (mesmos valores canonicos da Page1)
501:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
502:         WITH loc_oPagina.cnt_4c_Cabecalho
503:             .Top         = 29
504:             .Left        = 0
505:             .Width       = THIS.Width
506:             .Height      = 80
507:             .BackStyle   = 1
508:             .BackColor   = RGB(100, 100, 100)
509:             .BorderWidth = 0

*-- Linhas 517 a 544:
517:         *-- Canonico do form de 1000px: Top=33 (4+29), Left=842, Width=160.
518:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
519:         WITH loc_oPagina.cnt_4c_Salva
520:             .Top         = 33
521:             .Left        = 842
522:             .Width       = 160
523:             .Height      = 85
524:             .BackStyle = 1
525:             .BackColor = RGB(255, 255, 255)
526:             .BorderWidth = 0
527:             .Visible     = .T.
528:         ENDWITH
529: 
530:         *-- Confirmar (legado: Grupo_Salva.Salva). O Click e o despachante por
531:         *-- modo: grava o cabecalho e as fases em INCLUIR/ALTERAR, exclui em
532:         *-- EXCLUIR e executa o msv_procurar em PROCURAR (BtnSalvarClick).
533:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
534:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
535:             .Caption         = "Confirmar"
536:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
537:             .PicturePosition = 13
538:             .Top             = 5
539:             .Left            = 5
540:             .Width           = 75
541:             .Height          = 75
542:             .FontName        = "Tahoma"
543:             .FontBold        = .T.
544:             .FontItalic      = .T.

*-- Linhas 552 a 572:
552:             .AutoSize        = .F.
553:             .Visible         = .T.
554:         ENDWITH
555:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
556: 
557:         *-- Cancelar (legado: Grupo_Salva.Cancelar, cujo Click chama
558:         *-- DoDefault() e, se plCancelar, mAtivapagina1 - ou seja, volta para a
559:         *-- pagina Lista). O handler esta completo nesta fase, por isso ele ja
560:         *-- recebe BINDEVENT: sem ele a pagina Dados nao teria saida.
561:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
562:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
563:             .Caption         = "Encerrar"
564:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
565:             .PicturePosition = 13
566:             .Top             = 5
567:             .Left            = 80
568:             .Width           = 75
569:             .Height          = 75
570:             .FontName        = "Tahoma"
571:             .FontBold        = .T.
572:             .FontItalic      = .T.

*-- Linhas 580 a 618:
580:             .AutoSize        = .F.
581:             .Visible         = .T.
582:         ENDWITH
583:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
584: 
585:         *-- ---------------------------------------------------------------
586:         *-- CAMPOS DA FICHA - PARTE 1: Nome e Grupo Sd Inicial
587:         *-- ---------------------------------------------------------------
588:         *-- No SCX legado os campos ficam DIRETO na Pagina.Dados (nao existe
589:         *-- container de campos), e todo Top compensa +29 porque
590:         *-- pgf_4c_Paginas.Top = -29. Nenhum deles fica abaixo de 109, logo
591:         *-- nenhum e' coberto pela faixa do cabecalho (regra #11).
592:         *--
593:         *-- Os labels sao criados ANTES dos TextBox vizinhos: a caixa de um
594:         *-- label com BackStyle = 0 nao pinta, mas interceptaria o clique no
595:         *-- campo se fosse desenhada por cima dele (regra #23).
596:         *--
597:         *-- ZOrderSet do dump NAO e' transcrito: e' propriedade so do Form
598:         *-- Designer e atribui-la em runtime derruba o Init (regra #33). O
599:         *-- legado nao chama ZOrder() em nenhum desses controles.
600: 
601:         *-- Say1 -> lbl_4c_Nome ("Nome : ", classe legada say).
602:         *-- A classe say e' AutoSize = .T., mas AutoSize e' no-op em Label
603:         *-- criado por AddObject e, com WordWrap, DESCARTA a Height (regra
604:         *-- #23): vai como .F. com os 39x15 do dump, que JA SAO o auto-size
605:         *-- calculado pelo Form Designer.
606:         *-- Alignment = 0 (esquerda) e ForeColor = 90,90,90 sao os da classe
607:         *-- say: branco aqui ficaria INVISIVEL, porque a Page tem Picture
608:         *-- clara por cima do BackColor (regra #12).
609:         loc_oPagina.AddObject("lbl_4c_Nome", "Label")
610:         WITH loc_oPagina.lbl_4c_Nome
611:             .Caption   = "Nome : "
612:             .Top       = 178
613:             .Left      = 172
614:             .Width     = 39
615:             .Height    = 15
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .FontBold  = .F.

*-- Linhas 637 a 667:
637:         loc_oPagina.AddObject("txt_4c_Nome", "TextBox")
638:         WITH loc_oPagina.txt_4c_Nome
639:             .Value             = ""
640:             .Top               = 175
641:             .Left              = 214
642:             .Width             = 150
643:             .Height            = 23
644:             .MaxLength         = 20
645:             .FontName          = "Tahoma"
646:             .FontSize          = 8
647:             .Format            = "K"
648:             .DisabledBackColor = RGB(192, 192, 192)
649:             .DisabledForeColor = RGB(0, 0, 0)
650:             .Themes            = .F.
651:             .Visible           = .T.
652:         ENDWITH
653: 
654:         *-- Label1 -> lbl_4c_Grupo ("Grupo Sd Inicial : ", BaseClass label).
655:         *-- O dump declara AutoSize = .T. com Width = 86 e Height = 15; vale
656:         *-- a mesma regra #23 do label anterior - AutoSize = .F. e a
657:         *-- geometria transcrita.
658:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
659:         WITH loc_oPagina.lbl_4c_Grupo
660:             .Caption   = "Grupo Sd Inicial : "
661:             .Top       = 203
662:             .Left      = 125
663:             .Width     = 86
664:             .Height    = 15
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .FontBold  = .F.

*-- Linhas 683 a 692:
683:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
684:         WITH loc_oPagina.txt_4c_Grupo
685:             .Value             = ""
686:             .Top               = 198
687:             .Left              = 214
688:             .Width             = 80
689:             .Height            = 25
690:             .MaxLength         = 10
691:             .FontName          = "Courier New"
692:             .FontSize          = 9

*-- Linhas 714 a 723:
714:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
715:         WITH loc_oPagina.txt_4c_DGrupo
716:             .Value             = ""
717:             .Top               = 198
718:             .Left              = 294
719:             .Width             = 271
720:             .Height            = 25
721:             .MaxLength         = 20
722:             .FontName          = "Courier New"
723:             .FontSize          = 9

*-- Linhas 740 a 760:
740:         *-- CAMPOS DA FICHA - PARTE 2: Conta Sd Inicial
741:         *-- ---------------------------------------------------------------
742: 
743:         *-- Label2 -> lbl_4c_Conta ("Conta Sd Inicial : ", BaseClass label).
744:         *-- Criado ANTES dos TextBox da mesma linha (regra #23) e com
745:         *-- AutoSize = .F. + a geometria 86x15 do dump, que JA E' o auto-size
746:         *-- calculado pelo Form Designer - AutoSize = .T. e' no-op em Label
747:         *-- criado por AddObject e, com WordWrap, DESCARTA a Height.
748:         *-- ForeColor 90,90,90 (classe say/label do legado): branco ficaria
749:         *-- INVISIVEL sobre a Picture clara da Page (regra #12).
750:         *-- ZOrderSet = 3 do dump NAO e' transcrito (regra #33).
751:         loc_oPagina.AddObject("lbl_4c_Conta", "Label")
752:         WITH loc_oPagina.lbl_4c_Conta
753:             .Caption   = "Conta Sd Inicial : "
754:             .Top       = 228
755:             .Left      = 125
756:             .Width     = 86
757:             .Height    = 15
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8
760:             .FontBold  = .F.

*-- Linhas 778 a 787:
778:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
779:         WITH loc_oPagina.txt_4c_Conta
780:             .Value             = ""
781:             .Top               = 223
782:             .Left              = 214
783:             .Width             = 80
784:             .Height            = 25
785:             .MaxLength         = 10
786:             .FontName          = "Courier New"
787:             .FontSize          = 9

*-- Linhas 812 a 821:
812:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
813:         WITH loc_oPagina.txt_4c_DConta
814:             .Value             = ""
815:             .Top               = 223
816:             .Left              = 294
817:             .Width             = 271
818:             .Height            = 25
819:             .MaxLength         = 40
820:             .FontName          = "Courier New"
821:             .FontSize          = 9

*-- Linhas 839 a 894:
839:         *-- ---------------------------------------------------------------
840:         THIS.ConfigurarGradeFases(loc_oPagina)
841: 
842:         *-- Inserir -> cmd_4c_InserirFase (legado: Pagina.Dados.Inserir, cujo
843:         *-- Click chama InsiraRegGrade e devolve o foco a' coluna Ordem).
844:         *-- Caption = "" e Picture 26px sao do dump: e' botao SO de icone, e
845:         *-- .Picture apontando para arquivo inexistente falha em SILENCIO
846:         *-- (regra #25) - cadastro_inserir_26.jpg conferido em vbmp\.
847:         *-- ForeColor 36,84,155 e BackColor 255,255,255 transcritos do dump.
848:         loc_oPagina.AddObject("cmd_4c_InserirFase", "CommandButton")
849:         WITH loc_oPagina.cmd_4c_InserirFase
850:             .Caption       = ""
851:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
852:             .ToolTipText   = "Inserir Fase"
853:             .Top           = 338
854:             .Left          = 607
855:             .Width         = 40
856:             .Height        = 40
857:             .FontName      = "Verdana"
858:             .FontSize      = 8
859:             .ForeColor     = RGB(36, 84, 155)
860:             .BackColor     = RGB(255, 255, 255)
861:             .Themes        = .F.
862:             .SpecialEffect = 0
863:             .MousePointer  = 15
864:             .Visible       = .T.
865:         ENDWITH
866:         BINDEVENT(loc_oPagina.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
867: 
868:         *-- Excluir -> cmd_4c_ExcluirFase (legado: Pagina.Dados.Excluir).
869:         *-- NAO confundir com o cmd_4c_Excluir da pagina Lista (CRUD do
870:         *-- registro mestre): este exclui a LINHA da grade de fases.
871:         loc_oPagina.AddObject("cmd_4c_ExcluirFase", "CommandButton")
872:         WITH loc_oPagina.cmd_4c_ExcluirFase
873:             .Caption       = ""
874:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
875:             .ToolTipText   = "Excluir Fase"
876:             .Top           = 381
877:             .Left          = 607
878:             .Width         = 40
879:             .Height        = 40
880:             .FontName      = "Verdana"
881:             .FontSize      = 8
882:             .ForeColor     = RGB(36, 84, 155)
883:             .BackColor     = RGB(255, 255, 255)
884:             .Themes        = .F.
885:             .SpecialEffect = 0
886:             .MousePointer  = 15
887:             .Visible       = .T.
888:         ENDWITH
889:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
890: 
891:         *-- ---------------------------------------------------------------
892:         *-- LOOKUPS DOS CAMPOS DA FICHA (Valid do legado = ao SAIR do campo)
893:         *-- ---------------------------------------------------------------
894:         *-- O legado valida/abre o picker no "Valid" dos quatro campos, ou

*-- Linhas 942 a 976:
942:     ENDPROC
943: 
944:     *===========================================================================
945:     * ConfigurarLabelsCabecalho - Cria lbl_4c_Sombra/lbl_4c_Titulo na faixa
946:     * Fonte unica para as duas paginas (regra #11: os labels NUNCA ficam
947:     * pelados, e o Caption vem do Caption do form). O ForeColor branco e
948:     * legitimo aqui porque o container e OPACO e escuro (excecao da regra #12).
949:     *===========================================================================
950:     PROTECTED PROCEDURE ConfigurarLabelsCabecalho(par_oCabecalho)
951:         par_oCabecalho.AddObject("lbl_4c_Sombra", "Label")
952:         WITH par_oCabecalho.lbl_4c_Sombra
953:             .Caption   = THIS.Caption
954:             .Top       = 15
955:             .Left      = 10
956:             .Width     = 769
957:             .Height    = 40
958:             .FontName  = "Tahoma"
959:             .FontSize  = 16
960:             .FontBold  = .T.
961:             .ForeColor = RGB(0, 0, 0)
962:             .BackStyle = 0
963:             .AutoSize  = .F.
964:             .Visible   = .T.
965:         ENDWITH
966: 
967:         par_oCabecalho.AddObject("lbl_4c_Titulo", "Label")
968:         WITH par_oCabecalho.lbl_4c_Titulo
969:             .Caption   = THIS.Caption
970:             .Top       = 18
971:             .Left      = 10
972:             .Width     = 769
973:             .Height    = 46
974:             .FontName  = "Tahoma"
975:             .FontSize  = 16
976:             .FontBold  = .T.

*-- Linhas 1015 a 1033:
1015:         ENDIF
1016: 
1017:         loc_aOrdem[1]  = "cnt_4c_Salva"
1018:         loc_aOrdem[2]  = "lbl_4c_Nome"
1019:         loc_aOrdem[3]  = "lbl_4c_Grupo"
1020:         loc_aOrdem[4]  = "txt_4c_Nome"
1021:         loc_aOrdem[5]  = "txt_4c_Grupo"
1022:         loc_aOrdem[6]  = "txt_4c_DGrupo"
1023:         loc_aOrdem[7]  = "txt_4c_Conta"
1024:         loc_aOrdem[8]  = "txt_4c_DConta"
1025:         loc_aOrdem[9]  = "lbl_4c_Conta"
1026:         loc_aOrdem[10] = "grd_4c_Fases"
1027:         loc_aOrdem[11] = "cmd_4c_InserirFase"
1028:         loc_aOrdem[12] = "cmd_4c_ExcluirFase"
1029: 
1030:         loc_nSlot = 0
1031: 
1032:         FOR loc_nI = 1 TO ALEN(loc_aOrdem)
1033:             IF PEMSTATUS(par_oPagina, loc_aOrdem[loc_nI], 5)

*-- Linhas 1120 a 1128:
1120:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1121: 
1122:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.nome"
1123:                 loc_oGrid.Column1.Header1.Caption = "Nome do Demonstrativo"
1124: 
1125:                 *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18): o do
1126:                 *-- grid propaga para as colunas e sobrescreveria este.
1127:                 loc_oGrid.Column1.ReadOnly = .T.
1128: 

*-- Linhas 1214 a 1249:
1214: 
1215:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1216:                 WITH loc_oPg1.cnt_4c_Botoes
1217:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1218:                         .cmd_4c_Incluir.Enabled = loc_lNaLista
1219:                     ENDIF
1220:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1221:                         .cmd_4c_Visualizar.Enabled = loc_lNaLista
1222:                     ENDIF
1223:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1224:                         .cmd_4c_Alterar.Enabled = loc_lNaLista
1225:                     ENDIF
1226:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1227:                         .cmd_4c_Excluir.Enabled = loc_lNaLista
1228:                     ENDIF
1229:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1230:                         .cmd_4c_Buscar.Enabled = loc_lNaLista
1231:                     ENDIF
1232:                 ENDWITH
1233:             ENDIF
1234: 
1235:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1236: 
1237:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1238:                 WITH loc_oPg2.cnt_4c_Salva
1239:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1240:                         .cmd_4c_Confirmar.Enabled = loc_lEditando OR ;
1241:                             (THIS.this_cModoAtual == "EXCLUIR")
1242:                     ENDIF
1243:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1244:                         .cmd_4c_Cancelar.Enabled = .T.
1245:                     ENDIF
1246:                 ENDWITH
1247:             ENDIF
1248: 
1249:             *-- Os campos da ficha seguem os "When" do legado, nao o estado

*-- Linhas 1299 a 1308:
1299:         loc_oGrid.ColumnCount = 5
1300: 
1301:         WITH loc_oGrid
1302:             .Top               = 254
1303:             .Left              = 108
1304:             .Width             = 492
1305:             .Height            = 260
1306:             .FontName          = "Tahoma"
1307:             .FontSize          = 8
1308:             .RowHeight         = 20

*-- Linhas 1544 a 1557:
1544:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Fases.tpops"
1545:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Fases.operas"
1546: 
1547:                 loc_oGrid.Column1.Header1.Caption = "Ordem"
1548:                 loc_oGrid.Column2.Header1.Caption = "Fase"
1549:                 loc_oGrid.Column3.Header1.Caption = "Funcion" + CHR(225) + "rio"
1550:                 loc_oGrid.Column4.Header1.Caption = "Tipo Opera" + CHR(231) + ;
1551:                     CHR(227) + "o"
1552:                 loc_oGrid.Column5.Header1.Caption = "E/S"
1553: 
1554:                 *-- Grid.ReadOnly ANTES de Column.ReadOnly: o do grid propaga
1555:                 *-- para as colunas (regra #18). O legado faz exatamente isto
1556:                 *-- no Grupo_op.Click (columnN.ReadOnly = .F.); quem bloqueia a
1557:                 *-- edicao fora dos modos INSERIR/ALTERAR e o "When" da celula.

*-- Linhas 3290 a 3304:
3290:                 ENDIF
3291: 
3292:             CASE INLIST(THIS.this_cModoAtual, "EXCLUIR", "VISUALIZAR")
3293:                 IF loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled AND ;
3294:                    loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible
3295:                     loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
3296:                 ELSE
3297:                     IF loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled AND ;
3298:                        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Visible
3299:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
3300:                     ENDIF
3301:                 ENDIF
3302:         ENDCASE
3303:     ENDPROC
3304: 


### BO (C:\4c\projeto\app\classes\SigOpDmpBO.prg):
*====================================================================
* SigOpDmpBO.prg
*
* Business Object para Cadastro de Demonstrativos de Balanco (SigOpDmp)
* Tabela: SigPrDmo (cabecalho) - detalhe em SigCdDpr (fases 2+)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDmo)
    this_cNome      = ""    && nome char(20) - chave (nome do demonstrativo)
    this_cContas    = ""    && contas char(10)
    this_cGrupos    = ""    && grupos char(10)
    this_cCidChaves = ""    && cidchaves char(20) - PK Fortyus (gerada em fUniqueIds())

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDmo"
            THIS.this_cCampoChave = "nome"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpDmpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave (nome) do demonstrativo para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNome)
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
                *-- O 2o argumento do TratarNulo e o valor PADRAO, nao o tipo:
                *-- TratarNulo(x, "C") devolveria a letra "C" se a coluna
                *-- viesse NULL. Nenhuma coluna de SigPrDmo aceita nulo
                *-- no schema, logo o caminho era inerte - mas o
                *-- padrao certo de coluna char e a string vazia.
                THIS.this_cNome      = TratarNulo(nome,      "")
                THIS.this_cContas    = TratarNulo(contas,    "")
                THIS.this_cGrupos    = TratarNulo(grupos,    "")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpDmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDmo
    * cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDmo (contas, grupos, nome, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpDmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDmo
    * nome eh a chave de negocio (nao editavel em modo ALTERAR) - WHERE por nome
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDmo
                SET contas = <<EscaparSQL(THIS.this_cContas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>
                WHERE nome = <<EscaparSQL(THIS.this_cNome)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpDmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * Buscar - Alimenta cursor_4c_Dados, o cursor da grade da pagina Lista
    *
    * Legado (Init do SCX):
    *   lcQryDmPro = [Select * From SigPrDmo ]
    *   .AddCursor('SigPrDmo','cIdChaves','crSigPrDmo','',
    *              ThisForm.Pagina.Lista.Grade, lcQryDmPro)
    *   Select crSigPrDmo / Index On nome tag ix_nome
    * Ou seja: consulta SEM filtro (tabela inteira) e ordenada por nome
    * (regra #35 - a pagina Lista segue o Init do legado).
    *
    * O BusinessBase.Buscar herdado NAO serve aqui: ele delega para
    * this_oDataAccess (nunca instanciado, porque o Init chama DODEFAULT()
    * sem o nome da tabela) e grava no cursor "cur" + tabela, nao no
    * cursor_4c_Dados a que a grade se liga.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (ValidarUIFidelity / teste headless): cria um
                *-- cursor vazio com a MESMA estrutura de SigPrDmo, para a
                *-- grade ter a que se ligar sem consultar o banco.
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (contas C(10), grupos C(10), nome C(20), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT contas, grupos, nome, cidchaves FROM SigPrDmo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY nome"

                *-- USE IN fecha o alias mesmo com buffer sujo; NUNCA
                *-- TABLEREVERT sem antes conferir o Buffering (regra #52).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar demonstrativos:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Le do BANCO o demonstrativo de um nome
    *
    * Equivale ao ReQuery(1, pcChavePrimaria, <cursor>.<chave>) que o
    * Grupo_op.Click do frmcadastro dispara nos verbos CONSULTAR, ALTERAR e
    * EXCLUIR: o registro vem da tabela, nao do cursor que esta na grade da
    * Lista - que pode estar na tela desde antes de outro usuario altera-lo.
    *
    * A chave de NEGOCIO e o nome (this_cCampoChave = "nome"), e nao a
    * cidchaves: o nome e o que a grade da Lista exibe e o que amarra as
    * linhas de SigCdDpr ao demonstrativo (Where nome=?sNome do AddCursor
    * legado).
    *
    * this_lNovoRegistro volta a .F. aqui: sem isso, um Incluir seguido de
    * Alterar faria o Salvar escolher INSERT e violar a chave primaria.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""

            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF

                    loc_cSQL = "SELECT contas, grupos, nome, cidchaves" + ;
                        " FROM SigPrDmo" + ;
                        " WHERE RTRIM(nome) = " + EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar o demonstrativo:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        IF USED("cursor_4c_Carrega") AND ;
                           RECCOUNT("cursor_4c_Carrega") > 0
                            GO TOP IN cursor_4c_Carrega
                            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                            THIS.this_lNovoRegistro = .F.
                        ELSE
                            THIS.this_cMensagemErro = "Demonstrativo n" + ;
                                CHR(227) + "o encontrado: " + ALLTRIM(par_cNome)
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.CarregarPorCodigo")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as properties da entidade
    *
    * O LimparDados do BusinessBase limpa so a mensagem de erro: as
    * properties de CADA entidade sao responsabilidade da subclasse. Sem este
    * override, NovoRegistro() (chamado pelo Incluir) deixaria nome, grupos,
    * contas e - o mais grave - a cidchaves do registro ANTERIOR nas
    * properties, e o INSERT seguinte reaproveitaria aquela PK: colisao na
    * chave primaria de SigPrDmo (regra #22).
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cNome      = ""
        THIS.this_cContas    = ""
        THIS.this_cGrupos    = ""
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro mestre em SigPrDmo
    *
    * Legado: frmcadastro.mSv_Excluir -> poDataMgr.Delete(1) + Commit(). O
    * AddCursor do Init legado passa 'cIdChaves' como chave do cursor
    * mestre, logo o Delete(1) do Fortyus apaga PELA cidchaves - que e a
    * PRIMARY KEY de SigPrDmo (docs\schema.sql, lido com Get-Content -Raw
    * por ser UTF-16 - regra #14). O nome e a chave de NEGOCIO e NAO tem
    * indice unico: apagar por nome mataria tambem um homonimo gravado por
    * outro caminho. Por isso o WHERE prefere a cidchaves e so cai no nome
    * quando ela nao veio.
    *
    * O COMMIT NAO ACONTECE AQUI. No legado ele e um passo com caminho de
    * falha PROPRIO logo depois do Delete/Update ("If (poDataMgr.Commit()
    * < 1) -> Favor Reinicializar o Processo!!!"), e nesta tela UMA
    * gravacao mexe em DUAS tabelas (SigPrDmo e SigCdDpr): commitar aqui
    * efetivaria o mestre antes de saber se as fases foram gravadas. O
    * commit unico vive no Confirmar do form.
    *
    * PROTECTED: quem chama e o Excluir() do BusinessBase, que ja faz o
    * AntesDeExcluir e o ExibirFalha (regra #51). O form chama Excluir().
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(nome) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cNome))
            ELSE
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(cidchaves) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir demonstrativo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirFases - PROCEDURE excluiitens do legado
    *
    *   lcQuery = [Delete From SigCdDpr Where nome=] + getnome.Value
    *   If (poDataMgr.SqlExecute(lcQuery, 'crDelSigCdDpr') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *   If (poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * Apaga TODAS as fases de um demonstrativo. Serve a dois caminhos do
    * Confirmar: a exclusao do demonstrativo inteiro (o ExcluiItens do
    * legado) e o "apaga e regrava" do GravarFases.
    *
    * O Commit fica de fora pelo mesmo motivo do ExecutarExclusao: e UM so,
    * no form, cobrindo mestre e fases.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE ExcluirFases(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    loc_cSQL = "DELETE FROM SigCdDpr WHERE RTRIM(nome) = " + ;
                        EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir as fases do " + ;
                            "demonstrativo:" + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao excluir as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.ExcluirFases")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GravarFases - o poDataMgr.Update('crSigCdDpr') do Salva.Click legado
    *
    * No legado o cursor de detalhe e um cursor REMOTO BUFFERIZADO: o
    * Update do fSqlConector e um TABLEUPDATE, que manda ao SQL Server o
    * INSERT das linhas novas, o UPDATE das alteradas e o DELETE das
    * marcadas. Aqui o cursor_4c_Fases e um cursor LOCAL sem buffering
    * (TABLEUPDATE/TABLEREVERT em cursor com Buffering = 1 dispara o erro
    * 1586 - regra #52), logo nao existe lista de alteracoes em aberto a
    * mandar: a gravacao e "apaga as fases deste nome e regrava as linhas
    * vivas da grade".
    *
    * O efeito no banco e o MESMO do TABLEUPDATE: o conjunto de linhas de
    * SigCdDpr daquele nome passa a ser exatamente o conjunto exibido na
    * grade, cada uma com a sua cidchaves PRESERVADA (a PK de SigCdDpr).
    *
    * SCAN FOR !DELETED(): o botao Excluir de LINHA do form faz DELETE no
    * cursor (delecao LOGICA, como o legado), e linha apagada nao pode ser
    * regravada. O FOR explicito e necessario porque SET DELETED e escopado
    * por data session - confiar no SET DELETED ON do config.prg deixaria a
    * exclusao de linha sem efeito em form de sessao privada.
    *
    * O nome gravado em cada linha e o da FICHA, nao o que estava na linha:
    * ele e a chave que amarra a fase ao demonstrativo (o Where nome=?sNome
    * do AddCursor legado). O legado o estampa no momento do Append Blank
    * (InsiraRegGrade) e a ficha nunca deixa trocar o Nome depois que as
    * fases estao preenchidas (o "When" de GetNome), logo em todo caminho
    * normal e o MESMO valor - mas gravar o da ficha fecha a janela em que
    * o usuario troca o Nome com a grade ainda em branco e as linhas ficam
    * ORFAS, invisiveis para o CarregarFasesDoBanco.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE GravarFases(par_cCursor, par_cNome)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cNome, loc_cSQL
        LOCAL loc_nResultado, loc_nAliasAnt, loc_nRegAnt, loc_cCidChaves

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            DO CASE
                CASE VARTYPE(par_cCursor) != "C" OR !USED(par_cCursor)
                    THIS.this_cMensagemErro = "Cursor de fases indispon" + ;
                        CHR(237) + "vel."
                    loc_lProsseguir = .F.

                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."
                    loc_lProsseguir = .F.

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."
                    loc_lProsseguir = .F.
            ENDCASE

            IF loc_lProsseguir
                loc_cNome = ALLTRIM(par_cNome)

                *-- Apaga as fases atuais do nome. A falha ja foi exibida
                *-- pelo proprio ExcluirFases.
                IF !THIS.ExcluirFases(loc_cNome)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nAliasAnt = SELECT(0)
                SELECT (par_cCursor)
                loc_nRegAnt = RECNO(par_cCursor)

                loc_lSucesso = .T.

                SCAN FOR !DELETED()
                    *-- cidchaves NUNCA em branco: com ela vazia a segunda
                    *-- linha colidiria na PK de SigCdDpr (regra #22).
                    loc_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    IF EMPTY(loc_cCidChaves)
                        loc_cCidChaves = fUniqueIds()
                    ENDIF

                    *-- As OITO colunas de SigCdDpr sao NOT NULL e todas
                    *-- entram no INSERT - inclusive dopes, que nao aparece
                    *-- em lugar nenhum do codigo legado (ele a ganhava de
                    *-- graca do "Select *" + "Append Blank") e cuja
                    *-- ausencia faria o SQL Server recusar o INSERT
                    *-- inteiro (regra #22).
                    loc_cSQL = "INSERT INTO SigCdDpr" + ;
                        " (contas, grupos, nome, operas, ordems," + ;
                        " tpops, cidchaves, dopes) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TratarNulo(contas, ""))) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(grupos, ""))) + "," + ;
                        EscaparSQL(loc_cNome) + "," + ;
                        EscaparSQL(TratarNulo(operas, " ")) + "," + ;
                        FormatarNumeroSQL(TratarNulo(ordems, 0), 0) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(tpops, ""))) + "," + ;
                        EscaparSQL(loc_cCidChaves) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(dopes, ""))) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao gravar a fase de ordem " + ;
                            TRANSFORM(TratarNulo(ordems, 0)) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT(par_cCursor)
                    GO loc_nRegAnt IN (par_cCursor)
                ENDIF
                SELECT (loc_nAliasAnt)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.GravarFases")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC
ENDDEFINE


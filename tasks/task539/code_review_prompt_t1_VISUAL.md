# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTot.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1149 linhas total):

*-- Linhas 8 a 32:
8: * Page1 completa: faixa do cabecalho com labels, Grid (Codigo/Descricao,
9: * espelhando o AddCursor/pColuna do legado) e Container cnt_4c_Botoes com
10: * os 5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) + cnt_4c_Saida
11: * canonico (CLAUDE.md #10) com cmd_4c_Encerrar. AlternarPagina() e
12: * CarregarLista() implementados. Campos de Page2 e eventos Btn*Click sao
13: * adicionados nas proximas fases.
14: *
15: * FASE 5/8: Form - Campos Principais (Page2 - Parte 1)
16: * Page2 (Dados) recebe a faixa do cabecalho completa (lbl_4c_Sombra +
17: * lbl_4c_Titulo, igual a Page1 - CLAUDE.md #11) e os primeiros 50% dos
18: * campos: Codigo (txt_4c_Codigos, InputMask "99") e Descricao
19: * (txt_4c_Descrs, Format "!K"), com os labels correspondentes
20: * (lbl_4c_LblCodigos/lbl_4c_LblDescrs, ForeColor RGB(90,90,90) - CLAUDE.md
21: * #12).
22: *
23: * FASE 6/8: Form - Campos Restantes e Lookups (Page2 - Parte 2)
24: * Ultimo campo: Tipo de Operacao (obj_4c_Fwoption1/OptionGroup com botoes
25: * Soma/Subtrai, ControlSource numerico -> Value grava indice 1/2 do botao)
26: * + label lbl_4c_Label4. Container cnt_4c_BotoesAcao populado com
27: * cmd_4c_Confirmar/cmd_4c_Cancelar + BINDEVENT para BtnSalvarClick/
28: * BtnCancelarClick (implementados na Fase 7). NAO ha lookups no form
29: * original (SigCdTot_form_codigo_fonte.txt nao usa fwbuscaext/fwBuscaSel/
30: * sigacess) - nenhum lookup foi inventado.
31: *
32: * FASE 7/8: Form - Eventos Principais

*-- Linhas 124 a 143:
124: 
125:         WITH THIS.pgf_4c_Paginas
126:             .PageCount = 2
127:             .Top       = -29
128:             .Left      = 0
129:             .Width     = THIS.Width
130:             .Height    = THIS.Height + 29
131:             .Tabs      = .F.
132:             .Visible   = .T.
133: 
134:             .Page1.Caption   = "Lista"
135:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
136:             .Page1.BackColor = RGB(255, 255, 255)
137: 
138:             .Page2.Caption   = "Dados"
139:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140:             .Page2.BackColor = RGB(255, 255, 255)
141:         ENDWITH
142: 
143:         THIS.ConfigurarPaginaLista()

*-- Linhas 162 a 199:
162:         *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
163:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
164:         WITH loc_oPagina.cnt_4c_Cabecalho
165:             .Top         = 29
166:             .Left        = 0
167:             .Width       = THIS.Width
168:             .Height      = 80
169:             .BackColor   = RGB(100, 100, 100)
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
175:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
176:             .Caption   = THIS.Caption
177:             .Top       = 15
178:             .Left      = 10
179:             .Width     = 769
180:             .Height    = 40
181:             .FontName  = "Tahoma"
182:             .FontSize  = 16
183:             .FontBold  = .T.
184:             .ForeColor = RGB(0, 0, 0)
185:             .BackStyle = 0
186:             .AutoSize  = .F.
187:             .Visible   = .T.
188:         ENDWITH
189: 
190:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
191:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
192:             .Caption   = THIS.Caption
193:             .Top       = 18
194:             .Left      = 10
195:             .Width     = 769
196:             .Height    = 46
197:             .FontName  = "Tahoma"
198:             .FontSize  = 16
199:             .FontBold  = .T.

*-- Linhas 207 a 229:
207:         *-- Canonico: Left=542, Top=29, Width=390, Height=85 (framework_frmcadastro_layout.md)
208:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
209:         WITH loc_oPagina.cnt_4c_Botoes
210:             .Top         = 29
211:             .Left        = 542
212:             .Width       = 390
213:             .Height      = 85
214:             .BackColor   = RGB(100, 100, 100)
215:             .BackStyle   = 0
216:             .BorderWidth = 0
217:             .Visible     = .T.
218:         ENDWITH
219: 
220:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
221:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
222:             .Caption         = "Incluir"
223:             .Top             = 5
224:             .Left            = 5
225:             .Width           = 75
226:             .Height          = 75
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
228:             .PicturePosition = 13
229:             .FontName        = "Tahoma"

*-- Linhas 240 a 252:
240:             .Visible         = .T.
241:         ENDWITH
242: 
243:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
244:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
245:             .Caption         = "Visualizar"
246:             .Top             = 5
247:             .Left            = 80
248:             .Width           = 75
249:             .Height          = 75
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
251:             .PicturePosition = 13
252:             .FontName        = "Tahoma"

*-- Linhas 263 a 275:
263:             .Visible         = .T.
264:         ENDWITH
265: 
266:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
267:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
268:             .Caption         = "Alterar"
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
274:             .PicturePosition = 13
275:             .FontName        = "Tahoma"

*-- Linhas 286 a 298:
286:             .Visible         = .T.
287:         ENDWITH
288: 
289:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
290:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
291:             .Caption         = "Excluir"
292:             .Top             = 5
293:             .Left            = 230
294:             .Width           = 75
295:             .Height          = 75
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
297:             .PicturePosition = 13
298:             .FontName        = "Tahoma"

*-- Linhas 309 a 321:
309:             .Visible         = .T.
310:         ENDWITH
311: 
312:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
313:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
314:             .Caption         = "Buscar"
315:             .Top             = 5
316:             .Left            = 305
317:             .Width           = 75
318:             .Height          = 75
319:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
320:             .PicturePosition = 13
321:             .FontName        = "Tahoma"

*-- Linhas 336 a 357:
336:         *-- Transparente/flutuante sobre a Page; Page.Width NAO subtrai espaco por este container
337:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
338:         WITH loc_oPagina.cnt_4c_Saida
339:             .Top         = 29
340:             .Left        = 917
341:             .Width       = 90
342:             .Height      = 85
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346:         ENDWITH
347: 
348:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
349:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
350:             .Caption         = "Encerrar"
351:             .Top             = 5
352:             .Left            = 5
353:             .Width           = 75
354:             .Height          = 75
355:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
356:             .PicturePosition = 13
357:             .FontName        = "Tahoma"

*-- Linhas 372 a 381:
372:         *-- pColuna('Codigos',...,44) + pColuna('Descrs',...,279)
373:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
374:         WITH loc_oPagina.grd_4c_Lista
375:             .Top                = 117
376:             .Left               = 12
377:             .Width              = 895
378:             .Height             = 455
379:             .FontName           = "Verdana"
380:             .FontSize           = 8
381:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 397 a 421:
397:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
398: 
399:         WITH loc_oPagina.grd_4c_Lista
400:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
401:             .Column1.Width           = 120
402:             .Column1.Alignment       = 1
403: 
404:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
405:             .Column2.Width           = 770
406:             .Column2.Alignment       = 0
407:         ENDWITH
408: 
409:         *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
410:         *-- (metodos Btn*Click implementados em fase posterior)
411:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
412:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
415:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
416:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
417: 
418:         THIS.TornarControlesVisiveis(loc_oPagina)
419:     ENDPROC
420: 
421:     *===========================================================================

*-- Linhas 466 a 475:
466:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
467: 
468:                     *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
469:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
470:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
471: 
472:                     loc_oGrid.Column1.Width     = 120
473:                     loc_oGrid.Column1.Alignment = 1
474:                     loc_oGrid.Column2.Width     = 770
475:                     loc_oGrid.Column2.Alignment = 0

*-- Linhas 531 a 585:
531:     * (decisao do time - diverge do legado frmcadastro que so tem na Lista).
532:     *
533:     * FASE 5/8: primeiros 50% dos campos (Codigo + Descricao) + faixa do
534:     * cabecalho completa (lbl_4c_Sombra/lbl_4c_Titulo).
535:     *
536:     * FASE 6/8: campo restante (Tipo de Operacao - obj_4c_Fwoption1) +
537:     * botoes de acao (cmd_4c_Confirmar/cmd_4c_Cancelar) em cnt_4c_BotoesAcao.
538:     *
539:     * Compensacao PageFrame.Top=-29: todo Top do original (Pagina.Dados.*)
540:     * recebe +29.
541:     *===========================================================================
542:     PROTECTED PROCEDURE ConfigurarPaginaDados()
543:         LOCAL loc_oPagina
544:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
545: 
546:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
547: 
548:         *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
549:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
550:         WITH loc_oPagina.cnt_4c_Cabecalho
551:             .Top         = 29
552:             .Left        = 0
553:             .Width       = THIS.Width
554:             .Height      = 80
555:             .BackColor   = RGB(100, 100, 100)
556:             .BorderWidth = 0
557:             .Visible     = .T.
558:         ENDWITH
559: 
560:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
561:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
562:             .Caption   = THIS.Caption
563:             .Top       = 15
564:             .Left      = 10
565:             .Width     = 769
566:             .Height    = 40
567:             .FontName  = "Tahoma"
568:             .FontSize  = 16
569:             .FontBold  = .T.
570:             .ForeColor = RGB(0, 0, 0)
571:             .BackStyle = 0
572:             .AutoSize  = .F.
573:             .Visible   = .T.
574:         ENDWITH
575: 
576:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
577:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
578:             .Caption   = THIS.Caption
579:             .Top       = 18
580:             .Left      = 10
581:             .Width     = 769
582:             .Height    = 46
583:             .FontName  = "Tahoma"
584:             .FontSize  = 16
585:             .FontBold  = .T.

*-- Linhas 591 a 633:
591: 
592:         *-- Container Botoes de Acao (Confirmar/Cancelar)
593:         *-- Posicao base equivalente ao Grupo_Salva do framework (Top=33, Left=842)
594:         *-- Vazio nesta fase; botoes cmd_4c_Confirmar/cmd_4c_Cancelar sao
595:         *-- adicionados na Fase 6/7
596:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
597:         WITH loc_oPagina.cnt_4c_BotoesAcao
598:             .Top         = 33
599:             .Left        = 842
600:             .Width       = 160
601:             .Height      = 85
602:             .BackStyle = 1
603:             .BackColor   = RGB(255, 255, 255)
604:             .BorderWidth = 0
605:             .Visible     = .T.
606:         ENDWITH
607: 
608:         *-- Campo Codigo (Get_Codigos: crSigCdToi.Codigos numeric(2,0))
609:         *-- Original: Top=155 Left=260 Width=25 Height=23 InputMask="99" MaxLength=2
610:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
611:         WITH loc_oPagina.lbl_4c_LblCodigos
612:             .Caption   = "C" + CHR(243) + "digo :"
613:             .Top       = 158 + 29
614:             .Left      = 216
615:             .Width     = 42
616:             .Height    = 17
617:             .AutoSize  = .T.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackStyle = 0
621:             .ForeColor = RGB(90, 90, 90)
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
626:         WITH loc_oPagina.txt_4c_Codigos
627:             .Top        = 155 + 29
628:             .Left       = 260
629:             .Width      = 25
630:             .Height     = 23
631:             .InputMask  = "99"
632:             .MaxLength  = 2
633:             .FontName   = "Tahoma"

*-- Linhas 639 a 682:
639: 
640:         *-- Campo Descricao (Get_Descrs: crSigCdToi.Descrs char(30))
641:         *-- Original: Top=180 Left=260 Width=220 Format="!K" (uppercase + limpa ao entrar)
642:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
643:         WITH loc_oPagina.lbl_4c_LblDescrs
644:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
645:             .Top       = 183 + 29
646:             .Left      = 203
647:             .Width     = 55
648:             .Height    = 17
649:             .AutoSize  = .T.
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .BackStyle = 0
653:             .ForeColor = RGB(90, 90, 90)
654:             .Visible   = .T.
655:         ENDWITH
656: 
657:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
658:         WITH loc_oPagina.txt_4c_Descrs
659:             .Top        = 180 + 29
660:             .Left       = 260
661:             .Width      = 220
662:             .Height     = 23
663:             .Format     = "!K"
664:             .FontName   = "Tahoma"
665:             .FontSize   = 8
666:             .ForeColor  = RGB(0, 0, 0)
667:             .Value      = ""
668:             .Visible    = .T.
669:         ENDWITH
670: 
671:         *-- Label "Tipo de Operacao :" (Label4 no legado)
672:         *-- Original: Top=209 Left=164 Width=94
673:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
674:         WITH loc_oPagina.lbl_4c_Label4
675:             .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
676:             .Top       = 209 + 29
677:             .Left      = 164
678:             .Width     = 94
679:             .Height    = 17
680:             .AutoSize  = .T.
681:             .FontName  = "Tahoma"
682:             .FontSize  = 8

*-- Linhas 694 a 703:
694:         loc_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
695:         WITH loc_oPagina.obj_4c_Fwoption1
696:             .ButtonCount   = 2
697:             .Top           = 206 + 29
698:             .Left          = 260
699:             .Width         = 121
700:             .Height        = 24
701:             .BackStyle     = 0
702:             .SpecialEffect = 0
703:             .Value         = 0

*-- Linhas 710 a 746:
710:         loc_oBtnSubtrai = loc_oPagina.obj_4c_Fwoption1.Buttons(2)
711: 
712:         WITH loc_oBtnSoma
713:             .Caption   = "Soma"
714:             .Left      = 3
715:             .Top       = 4
716:             .AutoSize  = .T.
717:             .FontName  = "Tahoma"
718:             .FontSize  = 8
719:             .BackStyle = 0
720:             .ForeColor = RGB(90, 90, 90)
721:             .Themes    = .F.
722:         ENDWITH
723: 
724:         WITH loc_oBtnSubtrai
725:             .Caption   = "Subtrai"
726:             .Left      = 63
727:             .Top       = 4
728:             .AutoSize  = .T.
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .BackStyle = 0
732:             .ForeColor = RGB(90, 90, 90)
733:             .Themes    = .F.
734:         ENDWITH
735: 
736:         *-- Container Botoes de Acao (Grupo_Salva no legado): Confirmar/Cancelar
737:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
738:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
739:             .Caption         = "Confirmar"
740:             .Top             = 5
741:             .Left            = 5
742:             .Width           = 75
743:             .Height          = 75
744:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
745:             .PicturePosition = 13
746:             .FontName        = "Tahoma"

*-- Linhas 757 a 769:
757:             .Visible         = .T.
758:         ENDWITH
759: 
760:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
761:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
762:             .Caption         = "Encerrar"
763:             .Top             = 5
764:             .Left            = 80
765:             .Width           = 75
766:             .Height          = 75
767:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
768:             .PicturePosition = 13
769:             .FontName        = "Tahoma"

*-- Linhas 782 a 791:
782: 
783:         *-- BINDEVENTs Page2 - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
784:         *-- (metodos BtnSalvarClick/BtnCancelarClick implementados em fase posterior)
785:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
786:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
787: 
788:         THIS.TornarControlesVisiveis(loc_oPagina)
789:     ENDPROC
790: 
791:     *===========================================================================

*-- Linhas 1052 a 1062:
1052:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1053: 
1054:         WITH THIS.this_oBusinessObject
1055:             loc_oPg2.txt_4c_Codigos.Value   = .this_nCodigo
1056:             loc_oPg2.txt_4c_Descrs.Value    = .this_cDescricao
1057:             loc_oPg2.obj_4c_Fwoption1.Value = .this_nTipoOperacao
1058:         ENDWITH
1059:     ENDPROC
1060: 
1061:     *===========================================================================
1062:     * FormParaBO - Transfere os controles da Page2 para as propriedades do TotBO

*-- Linhas 1083 a 1096:
1083:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
1084: 
1085:         TRY
1086:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
1087:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
1088:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
1089:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
1090:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
1091:             loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
1092:         CATCH TO loException
1093:             MostrarErro("Erro em FormTot.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
1094:         ENDTRY
1095:     ENDPROC
1096: 

*-- Linhas 1123 a 1132:
1123:         loc_oPg2.obj_4c_Fwoption1.Enabled = loc_lEditavel
1124: 
1125:         *-- Confirmar so fica habilitado quando ha algo para gravar (INCLUIR/ALTERAR)
1126:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditavel OR (THIS.this_cModoAtual = "EXCLUIR")
1127:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1128:     ENDPROC
1129: 
1130:     *===========================================================================
1131:     * Destroy - Libera recursos do formulario
1132:     *===========================================================================


### BO (C:\4c\projeto\app\classes\TotBO.prg):
*====================================================================
* TotBO.prg
*
* Business Object para Cadastro de Tipos de Operacoes de Producao
* Tabela: SigCdToi
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TotBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdToi)
    this_nCodigo        = 0     && codigos numeric(2,0) - PK
    this_cDescricao     = ""    && descrs  char(30)
    this_nTipoOperacao  = 0     && tpgdmis numeric(1,0) - OptionGroup (1=Soma, 2=Subtrai)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
            THIS.this_cTabela     = "SigCdToi"
            THIS.this_cCampoChave = "codigos"

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TotBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de operacoes no cursor_4c_Dados
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                           " FROM SigCdToi" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                           " FROM SigCdToi" + ;
                           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                       " FROM SigCdToi" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigo       = TratarNulo(codigos, "N")
            THIS.this_cDescricao    = TratarNulo(descrs, "C")
            THIS.this_nTipoOperacao = TratarNulo(tpgdmis, "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdToi (codigos, descrs, tpgdmis)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoOperacao) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdToi SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " tpgdmis = " + FormatarNumeroSQL(THIS.this_nTipoOperacao) + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE da tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdToi WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


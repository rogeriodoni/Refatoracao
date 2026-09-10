# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Extensao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'chklocdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chklocdel' Top=313 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkftpdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chkftpdel' Top=313 (diff=103px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTme.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2810 linhas total):

*-- Linhas 56 a 67:
56:                     "FormTme.InicializarForm")
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

*-- Linhas 92 a 111:
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()

*-- Linhas 126 a 163:
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 171 a 196:
171:         *-- Left=542, Top=29, Width=390, Height=85 (lado DIREITO)
172:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
173:         WITH loc_oPagina.cnt_4c_Botoes
174:             .Top         = 29
175:             .Left        = 542
176:             .Width       = 390
177:             .Height      = 85
178:             .BackStyle = 1
179:             .BackColor = RGB(255, 255, 255)
180:             .BorderWidth = 0
181:             .Visible     = .T.
182:         ENDWITH
183: 
184:         *-- Botao Incluir (Left=5)
185:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
186:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
187:             .Caption         = "Incluir"
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
189:             .PicturePosition = 13
190:             .Top             = 5
191:             .Left            = 5
192:             .Width           = 75
193:             .Height          = 75
194:             .FontName        = "Tahoma"
195:             .FontBold        = .T.
196:             .FontItalic      = .T.

*-- Linhas 204 a 221:
204:             .AutoSize        = .F.
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
208: 
209:         *-- Botao Visualizar (Left=80)
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.

*-- Linhas 229 a 246:
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar (Left=155)
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .FontName        = "Tahoma"
245:             .FontBold        = .T.
246:             .FontItalic      = .T.

*-- Linhas 254 a 271:
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
258: 
259:         *-- Botao Excluir (Left=230)
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
262:             .Caption         = "Excluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 230
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Tahoma"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.

*-- Linhas 279 a 296:
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         *-- Botao Buscar (Left=305)
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.

*-- Linhas 304 a 334:
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle = 1
317:             .BackColor = RGB(255, 255, 255)
318:             .BorderWidth = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .FontName        = "Tahoma"
333:             .FontBold        = .T.
334:             .FontItalic      = .T.

*-- Linhas 342 a 361:
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
346: 
347:         *-- Grid de listagem de transportes
348:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
349:         *-- Colunas: tipos (Transporte), emps (Empresa), descrs (Descricao)
350:         *-- tipoemps (PK concatenada) permanece no cursor mas nao eh exibida
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
353:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top                = 117
356:             .Left               = 26
357:             .Width              = 880
358:             .Height             = 498
359:             .FontName           = "Verdana"
360:             .FontSize           = 8
361:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 411 a 426:
411:                 *-- .pfSqlTabela(1).pColuna('Tipos','','','Tipo',52,.t.)
412:                 *-- Caption correta = "Tipo" (NAO "Processo" - esse eh o rotulo do campo na
413:                 *-- Pagina.Dados/Say7, um controle diferente do mesmo formulario)
414:                 loc_oGrid.Column1.Header1.Caption = "Tipo"
415:                 loc_oGrid.Column2.Header1.Caption = "Emp"
416:                 *-- Column3: pColuna do legado declara EXATAMENTE 3 colunas na grade da Lista
417:                 *-- (Tipos->"Tipo", Emps->"Emp", Extensao->"Extensao" - linhas 2677/2678/2679 do
418:                 *-- fonte legado). Descrs NAO aparece na grade legada - usar Descrs aqui era
419:                 *-- desvio do PILAR 1 (grid deve ser identica ao legado). Corrigido para
420:                 *-- Extensao, com o mesmo Caption literal do pColuna (sem acento no legado).
421:                 loc_oGrid.Column3.Header1.Caption = "Extensao"
422: 
423:                 THIS.FormatarGridLista(loc_oGrid)
424:                 loc_lResultado = .T.
425:             ENDIF
426: 

*-- Linhas 492 a 529:
492:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
493:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
494:         WITH loc_oPagina.cnt_4c_Cabecalho
495:             .Top           = 29
496:             .Left          = 0
497:             .Width         = THIS.Width
498:             .Height        = 80
499:             .BackColor     = RGB(100, 100, 100)
500:             .BorderWidth   = 0
501:             .SpecialEffect = 0
502:             .Visible       = .T.
503: 
504:             .AddObject("lbl_4c_Sombra", "Label")
505:             WITH .lbl_4c_Sombra
506:                 .Caption   = THIS.Caption
507:                 .Top       = 15
508:                 .Left      = 10
509:                 .Width     = THIS.Width
510:                 .Height    = 40
511:                 .FontName  = "Tahoma"
512:                 .FontSize  = 16
513:                 .FontBold  = .T.
514:                 .ForeColor = RGB(0, 0, 0)
515:                 .BackStyle = 0
516:                 .AutoSize  = .F.
517:                 .Visible   = .T.
518:             ENDWITH
519: 
520:             .AddObject("lbl_4c_Titulo", "Label")
521:             WITH .lbl_4c_Titulo
522:                 .Caption   = THIS.Caption
523:                 .Top       = 18
524:                 .Left      = 10
525:                 .Width     = THIS.Width
526:                 .Height    = 46
527:                 .FontName  = "Tahoma"
528:                 .FontSize  = 16
529:                 .FontBold  = .T.

*-- Linhas 538 a 563:
538:         *-- Canonico: Left=842, Top=33, Width=160, Height=85
539:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
540:         WITH loc_oPagina.cnt_4c_BotoesAcao
541:             .Top         = 33
542:             .Left        = 842
543:             .Width       = 160
544:             .Height      = 85
545:             .BackStyle = 1
546:             .BackColor   = RGB(255, 255, 255)
547:             .BorderWidth = 0
548:             .Visible     = .T.
549:         ENDWITH
550: 
551:         *-- Botao Confirmar (Left=5)
552:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
553:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
554:             .Caption         = "Confirmar"
555:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
556:             .PicturePosition = 13
557:             .Top             = 5
558:             .Left            = 5
559:             .Width           = 75
560:             .Height          = 75
561:             .FontName        = "Tahoma"
562:             .FontBold        = .T.
563:             .FontItalic      = .T.

*-- Linhas 571 a 588:
571:             .AutoSize        = .F.
572:             .Visible         = .T.
573:         ENDWITH
574:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
575: 
576:         *-- Botao Cancelar (Left=80)
577:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
578:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
579:             .Caption         = "Encerrar"
580:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
581:             .PicturePosition = 13
582:             .Top             = 5
583:             .Left            = 80
584:             .Width           = 75
585:             .Height          = 75
586:             .FontName        = "Tahoma"
587:             .FontBold        = .T.
588:             .FontItalic      = .T.

*-- Linhas 596 a 604:
596:             .AutoSize        = .F.
597:             .Visible         = .T.
598:         ENDWITH
599:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
600: 
601:         *-- FASE 5/8 - Campos Principais Parte 1 (Secao "Configuracao do
602:         *-- Transporte" do legado: Pageframe1.Page1, Top original 12..149).
603:         *-- FASE 6/8 - Campos Restantes Parte 2 (Secao "Configuracao da area
604:         *-- do FTP" do legado: Pageframe1.Page1, Top original 185..306).

*-- Linhas 616 a 642:
616:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
617:         WITH loc_oPagina.pgf_4c_DadosInternos
618:             .PageCount = 3
619:             .Top       = 420
620:             .Left      = 6
621:             .Width     = 689
622:             .Height    = 291
623:             .Visible   = .T.
624: 
625:             .Page1.Caption   = "Titulos/Pag/Rec/Lote Chq"
626:             .Page1.FontName  = "Tahoma"
627:             .Page1.FontSize  = 8
628:             .Page1.BackColor = RGB(255, 255, 255)
629:             .Page1.ForeColor = RGB(90, 90, 90)
630: 
631:             .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Estoque"
632:             .Page2.FontName  = "Tahoma"
633:             .Page2.FontSize  = 8
634:             .Page2.BackColor = RGB(255, 255, 255)
635:             .Page2.ForeColor = RGB(90, 90, 90)
636: 
637:             .Page3.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
638:             .Page3.FontName  = "Tahoma"
639:             .Page3.FontSize  = 8
640:             .Page3.BackColor = RGB(255, 255, 255)
641:             .Page3.ForeColor = RGB(90, 90, 90)
642:         ENDWITH

*-- Linhas 661 a 778:
661:     *===========================================================================
662:     PROTECTED PROCEDURE AdicionarCamposIdentificacao(par_oPagina)
663:         *-- Processo (Tipos) - chave do transporte
664:         par_oPagina.AddObject("lbl_4c_Processo", "Label")
665:         WITH par_oPagina.lbl_4c_Processo
666:             .Caption   = "Processo :"
667:             .Top       = 119
668:             .Left      = 18
669:             .Width     = 62
670:             .Height    = 15
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .ForeColor = RGB(90, 90, 90)
674:             .BackStyle = 0
675:             .AutoSize  = .F.
676:             .Visible   = .T.
677:         ENDWITH
678: 
679:         par_oPagina.AddObject("txt_4c_Tipos", "TextBox")
680:         WITH par_oPagina.txt_4c_Tipos
681:             .Top       = 115
682:             .Left      = 85
683:             .Width     = 52
684:             .Height    = 23
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .ForeColor = RGB(0, 0, 0)
688:             .BackColor = RGB(255, 255, 255)
689:             .Value     = ""
690:             .Visible   = .T.
691:         ENDWITH
692: 
693:         *-- Empresa (Emps) - fAcessoEmpresa() NAO foi portada, campo simples
694:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
695:         WITH par_oPagina.lbl_4c_Empresa
696:             .Caption   = "Empresa :"
697:             .Top       = 119
698:             .Left      = 142
699:             .Width     = 60
700:             .Height    = 15
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .ForeColor = RGB(90, 90, 90)
704:             .BackStyle = 0
705:             .AutoSize  = .F.
706:             .Visible   = .T.
707:         ENDWITH
708: 
709:         par_oPagina.AddObject("txt_4c_Emps", "TextBox")
710:         WITH par_oPagina.txt_4c_Emps
711:             .Top        = 115
712:             .Left       = 210
713:             .Width      = 31
714:             .Height     = 23
715:             .FontName   = "Tahoma"
716:             .FontSize   = 8
717:             .ForeColor  = RGB(0, 0, 0)
718:             .BackColor  = RGB(255, 255, 255)
719:             .Value      = ""
720:             .Visible    = .T.
721:             .MaxLength   = 3
722:         ENDWITH
723: 
724:         *-- Descricao (Descrs)
725:         par_oPagina.AddObject("lbl_4c_Descricao", "Label")
726:         WITH par_oPagina.lbl_4c_Descricao
727:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
728:             .Top       = 119
729:             .Left      = 247
730:             .Width     = 63
731:             .Height    = 15
732:             .FontName  = "Tahoma"
733:             .FontSize  = 8
734:             .ForeColor = RGB(90, 90, 90)
735:             .BackStyle = 0
736:             .AutoSize  = .F.
737:             .Visible   = .T.
738:         ENDWITH
739: 
740:         par_oPagina.AddObject("txt_4c_Descrs", "TextBox")
741:         WITH par_oPagina.txt_4c_Descrs
742:             .Top       = 115
743:             .Left      = 320
744:             .Width     = 150
745:             .Height    = 23
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .ForeColor = RGB(0, 0, 0)
749:             .BackColor = RGB(255, 255, 255)
750:             .Value     = ""
751:             .Visible   = .T.
752:         ENDWITH
753: 
754:         *-- Tipo de Extensao do Arquivo (Extensao)
755:         par_oPagina.AddObject("lbl_4c_TipoExtensao", "Label")
756:         WITH par_oPagina.lbl_4c_TipoExtensao
757:             .Caption   = "Tipo de Extens" + CHR(227) + "o do Arquivo :"
758:             .Top       = 119
759:             .Left      = 492
760:             .Width     = 170
761:             .Height    = 15
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .ForeColor = RGB(90, 90, 90)
765:             .BackStyle = 0
766:             .AutoSize  = .F.
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         par_oPagina.AddObject("txt_4c_Extensao", "TextBox")
771:         WITH par_oPagina.txt_4c_Extensao
772:             .Top       = 115
773:             .Left      = 668
774:             .Width     = 31
775:             .Height    = 23
776:             .FontName  = "Tahoma"
777:             .FontSize  = 8
778:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 792 a 842:
792:         *-- Divisor + titulo da secao (Shape3 + Say15 do legado)
793:         par_oPagina.AddObject("shp_4c_DivisorTransporte", "Shape")
794:         WITH par_oPagina.shp_4c_DivisorTransporte
795:             .Top     = 147
796:             .Left    = 6
797:             .Width   = 690
798:             .Height  = 2
799:             .Visible = .T.
800:         ENDWITH
801: 
802:         par_oPagina.AddObject("lbl_4c_SecaoTransporte", "Label")
803:         WITH par_oPagina.lbl_4c_SecaoTransporte
804:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
805:             .Top       = 150
806:             .Left      = 6
807:             .Width     = 250
808:             .Height    = 18
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .FontBold  = .T.
812:             .ForeColor = RGB(90, 90, 90)
813:             .BackStyle = 0
814:             .AutoSize  = .F.
815:             .Visible   = .T.
816:         ENDWITH
817: 
818:         *-- Transporte (Dados) - lookup SigPrTrn.Codigos (F4/LostFocus)
819:         par_oPagina.AddObject("lbl_4c_TransporteDados", "Label")
820:         WITH par_oPagina.lbl_4c_TransporteDados
821:             .Caption   = "Transporte (Dados) :"
822:             .Top       = 157
823:             .Left      = 506
824:             .Width     = 120
825:             .Height    = 15
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .ForeColor = RGB(90, 90, 90)
829:             .BackStyle = 0
830:             .AutoSize  = .F.
831:             .Visible   = .T.
832:         ENDWITH
833: 
834:         par_oPagina.AddObject("txt_4c_TransTipo", "TextBox")
835:         WITH par_oPagina.txt_4c_TransTipo
836:             .Top       = 153
837:             .Left      = 629
838:             .Width     = 52
839:             .Height    = 23
840:             .FontName  = "Tahoma"
841:             .FontSize  = 8
842:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 848 a 1014:
848:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "ValidarTransTipo")
849: 
850:         *-- Transporte - diretorio de geracao/gravacao (drivets)
851:         par_oPagina.AddObject("lbl_4c_Transporte", "Label")
852:         WITH par_oPagina.lbl_4c_Transporte
853:             .Caption   = "Transporte :"
854:             .Top       = 183
855:             .Left      = 15
856:             .Width     = 62
857:             .Height    = 15
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .ForeColor = RGB(90, 90, 90)
861:             .BackStyle = 0
862:             .AutoSize  = .F.
863:             .Visible   = .T.
864:         ENDWITH
865: 
866:         par_oPagina.AddObject("txt_4c_DirGeracao", "TextBox")
867:         WITH par_oPagina.txt_4c_DirGeracao
868:             .Top       = 180
869:             .Left      = 79
870:             .Width     = 430
871:             .Height    = 23
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .ForeColor = RGB(0, 0, 0)
875:             .BackColor = RGB(255, 255, 255)
876:             .Value     = ""
877:             .Visible   = .T.
878:         ENDWITH
879:         BINDEVENT(par_oPagina.txt_4c_DirGeracao, "KeyPress", THIS, "ValidarDirGeracao")
880: 
881:         *-- No. Transporte Ok (clrarqs) - numerico
882:         par_oPagina.AddObject("lbl_4c_NoTransporteOk", "Label")
883:         WITH par_oPagina.lbl_4c_NoTransporteOk
884:             .Caption   = "No. Transporte Ok :"
885:             .Top       = 184
886:             .Left      = 555
887:             .Width     = 120
888:             .Height    = 15
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .ForeColor = RGB(90, 90, 90)
892:             .BackStyle = 0
893:             .AutoSize  = .F.
894:             .Visible   = .T.
895:         ENDWITH
896: 
897:         par_oPagina.AddObject("txt_4c_ClrArqOks", "TextBox")
898:         WITH par_oPagina.txt_4c_ClrArqOks
899:             .Top       = 180
900:             .Left      = 650
901:             .Width     = 31
902:             .Height    = 23
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ForeColor = RGB(0, 0, 0)
906:             .BackColor = RGB(255, 255, 255)
907:             .InputMask = "999"
908:             .Value     = ""
909:             .Visible   = .T.
910:         ENDWITH
911: 
912:         *-- Leitura - diretorio de leitura do zip (drivels)
913:         par_oPagina.AddObject("lbl_4c_Leitura", "Label")
914:         WITH par_oPagina.lbl_4c_Leitura
915:             .Caption   = "Leitura :"
916:             .Top       = 205
917:             .Left      = 35
918:             .Width     = 42
919:             .Height    = 15
920:             .FontName  = "Tahoma"
921:             .FontSize  = 8
922:             .ForeColor = RGB(90, 90, 90)
923:             .BackStyle = 0
924:             .AutoSize  = .F.
925:             .Visible   = .T.
926:         ENDWITH
927: 
928:         par_oPagina.AddObject("txt_4c_DirLeitura", "TextBox")
929:         WITH par_oPagina.txt_4c_DirLeitura
930:             .Top       = 202
931:             .Left      = 79
932:             .Width     = 430
933:             .Height    = 23
934:             .FontName  = "Tahoma"
935:             .FontSize  = 8
936:             .ForeColor = RGB(0, 0, 0)
937:             .BackColor = RGB(255, 255, 255)
938:             .Value     = ""
939:             .Visible   = .T.
940:         ENDWITH
941:         BINDEVENT(par_oPagina.txt_4c_DirLeitura, "KeyPress", THIS, "ValidarDirLeitura")
942: 
943:         *-- Nao Checar Sequencia (nchkseqs)
944:         par_oPagina.AddObject("chk_4c_Seqnum", "CheckBox")
945:         WITH par_oPagina.chk_4c_Seqnum
946:             .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia "
947:             .Top       = 207
948:             .Left      = 531
949:             .Width     = 129
950:             .Height    = 15
951:             .FontName  = "Tahoma"
952:             .FontSize  = 8
953:             .ForeColor = RGB(90, 90, 90)
954:             .BackStyle = 0
955:             .Value     = 0
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         *-- Recepcao - diretorio de recepcao do transporte (drivers)
960:         par_oPagina.AddObject("lbl_4c_Recepcao", "Label")
961:         WITH par_oPagina.lbl_4c_Recepcao
962:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
963:             .Top       = 228
964:             .Left      = 21
965:             .Width     = 56
966:             .Height    = 15
967:             .FontName  = "Tahoma"
968:             .FontSize  = 8
969:             .ForeColor = RGB(90, 90, 90)
970:             .BackStyle = 0
971:             .AutoSize  = .F.
972:             .Visible   = .T.
973:         ENDWITH
974: 
975:         par_oPagina.AddObject("txt_4c_DirRecepcao", "TextBox")
976:         WITH par_oPagina.txt_4c_DirRecepcao
977:             .Top       = 225
978:             .Left      = 79
979:             .Width     = 430
980:             .Height    = 23
981:             .FontName  = "Tahoma"
982:             .FontSize  = 8
983:             .ForeColor = RGB(0, 0, 0)
984:             .BackColor = RGB(255, 255, 255)
985:             .Value     = ""
986:             .Visible   = .T.
987:         ENDWITH
988:         BINDEVENT(par_oPagina.txt_4c_DirRecepcao, "KeyPress", THIS, "ValidarDirRecepcao")
989: 
990:         *-- Arquivar - diretorio para arquivar arquivo recebido (paths, opcional)
991:         par_oPagina.AddObject("lbl_4c_Arquivar", "Label")
992:         WITH par_oPagina.lbl_4c_Arquivar
993:             .Caption   = "Arquivar :"
994:             .Top       = 252
995:             .Left      = 27
996:             .Width     = 50
997:             .Height    = 15
998:             .FontName  = "Tahoma"
999:             .FontSize  = 8
1000:             .ForeColor = RGB(90, 90, 90)
1001:             .BackStyle = 0
1002:             .AutoSize  = .F.
1003:             .Visible   = .T.
1004:         ENDWITH
1005: 
1006:         par_oPagina.AddObject("txt_4c_DirArquivar", "TextBox")
1007:         WITH par_oPagina.txt_4c_DirArquivar
1008:             .Top       = 249
1009:             .Left      = 79
1010:             .Width     = 430
1011:             .Height    = 23
1012:             .FontName  = "Tahoma"
1013:             .FontSize  = 8
1014:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1021 a 1056:
1021:         *-- Caixa decorativa em torno de "Prox.Transp." e "Prox.Recebe" (Shape2 do legado)
1022:         par_oPagina.AddObject("shp_4c_CaixaProximos", "Shape")
1023:         WITH par_oPagina.shp_4c_CaixaProximos
1024:             .Top     = 230
1025:             .Left    = 516
1026:             .Width   = 172
1027:             .Height  = 48
1028:             .Visible = .T.
1029:         ENDWITH
1030: 
1031:         *-- Proximo Numero de Transporte (sem ControlSource no legado - campo
1032:         *-- desvinculado, nao gravado na tabela)
1033:         par_oPagina.AddObject("lbl_4c_ProxTransp", "Label")
1034:         WITH par_oPagina.lbl_4c_ProxTransp
1035:             .Caption   = "Pr" + CHR(243) + "x.Transp."
1036:             .Top       = 235
1037:             .Left      = 523
1038:             .Width     = 90
1039:             .Height    = 15
1040:             .FontName  = "Tahoma"
1041:             .FontSize  = 8
1042:             .ForeColor = RGB(90, 90, 90)
1043:             .BackStyle = 0
1044:             .AutoSize  = .F.
1045:             .Visible   = .T.
1046:         ENDWITH
1047: 
1048:         par_oPagina.AddObject("txt_4c_ProxTransp", "TextBox")
1049:         WITH par_oPagina.txt_4c_ProxTransp
1050:             .Top       = 250
1051:             .Left      = 529
1052:             .Width     = 58
1053:             .Height    = 23
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1062 a 1088:
1062: 
1063:         *-- Proximo Numero de Recebimento (sem ControlSource no legado - campo
1064:         *-- desvinculado, nao gravado na tabela)
1065:         par_oPagina.AddObject("lbl_4c_ProxRecebe", "Label")
1066:         WITH par_oPagina.lbl_4c_ProxRecebe
1067:             .Caption   = "Pr" + CHR(243) + "x.Recebe"
1068:             .Top       = 234
1069:             .Left      = 604
1070:             .Width     = 90
1071:             .Height    = 15
1072:             .FontName  = "Tahoma"
1073:             .FontSize  = 8
1074:             .ForeColor = RGB(90, 90, 90)
1075:             .BackStyle = 0
1076:             .AutoSize  = .F.
1077:             .Visible   = .T.
1078:         ENDWITH
1079: 
1080:         par_oPagina.AddObject("txt_4c_ProxRecebe", "TextBox")
1081:         WITH par_oPagina.txt_4c_ProxRecebe
1082:             .Top       = 249
1083:             .Left      = 612
1084:             .Width     = 58
1085:             .Height    = 23
1086:             .FontName  = "Tahoma"
1087:             .FontSize  = 8
1088:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1095 a 1104:
1095:         *-- Divisor de fechamento da caixa "Configuracao do Transporte" (Shape1 do legado)
1096:         par_oPagina.AddObject("shp_4c_DivisorTransporteFim", "Shape")
1097:         WITH par_oPagina.shp_4c_DivisorTransporteFim
1098:             .Top     = 285
1099:             .Left    = 4
1100:             .Width   = 690
1101:             .Height  = 2
1102:             .Visible = .T.
1103:         ENDWITH
1104:     ENDPROC

*-- Linhas 1111 a 1190:
1111:     *===========================================================================
1112:     PROTECTED PROCEDURE AdicionarCamposFtp(par_oPagina)
1113:         *-- Titulo da secao (Say12 do legado)
1114:         par_oPagina.AddObject("lbl_4c_SecaoFtp", "Label")
1115:         WITH par_oPagina.lbl_4c_SecaoFtp
1116:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(225) + "rea do FTP "
1117:             .Top       = 288
1118:             .Left      = 5
1119:             .Width     = 194
1120:             .Height    = 18
1121:             .FontName  = "Tahoma"
1122:             .FontSize  = 8
1123:             .FontBold  = .T.
1124:             .ForeColor = RGB(90, 90, 90)
1125:             .BackStyle = 0
1126:             .AutoSize  = .F.
1127:             .Visible   = .T.
1128:         ENDWITH
1129: 
1130:         *-- Tipo de Conexao (tpconexao) - D=Dial-Up / B=Banda Larga
1131:         par_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
1132:         WITH par_oPagina.lbl_4c_TipoConexao
1133:             .Caption   = "Tipo de Conex" + CHR(227) + "o :"
1134:             .Top       = 314
1135:             .Left      = 27
1136:             .Width     = 90
1137:             .Height    = 15
1138:             .FontName  = "Tahoma"
1139:             .FontSize  = 8
1140:             .ForeColor = RGB(90, 90, 90)
1141:             .BackStyle = 0
1142:             .AutoSize  = .F.
1143:             .Visible   = .T.
1144:         ENDWITH
1145: 
1146:         par_oPagina.AddObject("txt_4c_Tpconexao", "TextBox")
1147:         WITH par_oPagina.txt_4c_Tpconexao
1148:             .Top       = 310
1149:             .Left      = 122
1150:             .Width     = 28
1151:             .Height    = 23
1152:             .FontName  = "Tahoma"
1153:             .FontSize  = 8
1154:             .ForeColor = RGB(0, 0, 0)
1155:             .BackColor = RGB(255, 255, 255)
1156:             .Value     = ""
1157:             .Visible   = .T.
1158:         ENDWITH
1159: 
1160:         par_oPagina.AddObject("lbl_4c_DialUpBanda", "Label")
1161:         WITH par_oPagina.lbl_4c_DialUpBanda
1162:             .Caption   = "(D/B) Dial-Up / Banda Larga"
1163:             .Top       = 313
1164:             .Left      = 153
1165:             .Width     = 159
1166:             .Height    = 15
1167:             .FontName  = "Tahoma"
1168:             .FontSize  = 8
1169:             .ForeColor = RGB(90, 90, 90)
1170:             .BackStyle = 0
1171:             .AutoSize  = .F.
1172:             .Visible   = .T.
1173:         ENDWITH
1174: 
1175:         *-- Limpa diretorio de envio (locdel) - legado Top=210 + offset canonico +103 = 313
1176:         *-- (confere com os vizinhos da mesma linha: Say19/Say5 legado Top=210/211 ->
1177:         *-- lbl_4c_DialUpBanda/lbl_4c_TipoConexao migrado Top=313/314). Offset sistemico da
1178:         *-- faixa de cabecalho injetada na Pagina.Dados (CLAUDE.md regra #11 - prevalece sobre
1179:         *-- PILAR 1). O diff de 103px vs o legado NAO eh desalinhamento - eh o re-layout
1180:         *-- obrigatorio de toda a pagina apos a faixa. NAO alterar.
1181:         par_oPagina.AddObject("chk_4c_Chklocdel", "CheckBox")
1182:         WITH par_oPagina.chk_4c_Chklocdel
1183:             .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
1184:             .Top       = 313
1185:             .Left      = 362
1186:             .Width     = 160
1187:             .Height    = 17
1188:             .FontName  = "Tahoma"
1189:             .FontSize  = 8
1190:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1196 a 1208:
1196:         *-- Limpa diretorio do FTP (ftpdel) - legado Top=210 + offset canonico +103 = 313
1197:         *-- (mesma linha de chk_4c_Chklocdel acima - offset sistemico CLAUDE.md regra #11,
1198:         *-- ver comentario). NAO alterar.
1199:         par_oPagina.AddObject("chk_4c_Chkftpdel", "CheckBox")
1200:         WITH par_oPagina.chk_4c_Chkftpdel
1201:             .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
1202:             .Top       = 313
1203:             .Left      = 527
1204:             .Width     = 160
1205:             .Height    = 17
1206:             .FontName  = "Tahoma"
1207:             .FontSize  = 8
1208:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1214 a 1238:
1214:         *-- Endereco FTP (ftpend)
1215:         par_oPagina.AddObject("txt_4c_Ftpend", "TextBox")
1216:         WITH par_oPagina.txt_4c_Ftpend
1217:             .Top       = 333
1218:             .Left      = 122
1219:             .Width     = 330
1220:             .Height    = 23
1221:             .FontName  = "Tahoma"
1222:             .FontSize  = 8
1223:             .ForeColor = RGB(0, 0, 0)
1224:             .BackColor = RGB(255, 255, 255)
1225:             .Value     = ""
1226:             .Visible   = .T.
1227:         ENDWITH
1228: 
1229:         par_oPagina.AddObject("lbl_4c_EnderecoFtp", "Label")
1230:         WITH par_oPagina.lbl_4c_EnderecoFtp
1231:             .Caption   = "Endere" + CHR(231) + "o FTP :"
1232:             .Top       = 335
1233:             .Left      = 42
1234:             .Width     = 75
1235:             .Height    = 15
1236:             .FontName  = "Tahoma"
1237:             .FontSize  = 8
1238:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1244 a 1268:
1244:         *-- Usuario do FTP (ftpusuario)
1245:         par_oPagina.AddObject("txt_4c_Ftpusuario", "TextBox")
1246:         WITH par_oPagina.txt_4c_Ftpusuario
1247:             .Top       = 333
1248:             .Left      = 526
1249:             .Width     = 160
1250:             .Height    = 23
1251:             .FontName  = "Tahoma"
1252:             .FontSize  = 8
1253:             .ForeColor = RGB(0, 0, 0)
1254:             .BackColor = RGB(255, 255, 255)
1255:             .Value     = ""
1256:             .Visible   = .T.
1257:         ENDWITH
1258: 
1259:         par_oPagina.AddObject("lbl_4c_Usuario", "Label")
1260:         WITH par_oPagina.lbl_4c_Usuario
1261:             .Caption   = "Usu" + CHR(225) + "rio :"
1262:             .Top       = 336
1263:             .Left      = 477
1264:             .Width     = 45
1265:             .Height    = 15
1266:             .FontName  = "Tahoma"
1267:             .FontSize  = 8
1268:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1274 a 1298:
1274:         *-- Pasta p/ Envio (dirftpts)
1275:         par_oPagina.AddObject("txt_4c_Dirftpts", "TextBox")
1276:         WITH par_oPagina.txt_4c_Dirftpts
1277:             .Top       = 356
1278:             .Left      = 122
1279:             .Width     = 330
1280:             .Height    = 23
1281:             .FontName  = "Tahoma"
1282:             .FontSize  = 8
1283:             .ForeColor = RGB(0, 0, 0)
1284:             .BackColor = RGB(255, 255, 255)
1285:             .Value     = ""
1286:             .Visible   = .T.
1287:         ENDWITH
1288: 
1289:         par_oPagina.AddObject("lbl_4c_PastaEnvio", "Label")
1290:         WITH par_oPagina.lbl_4c_PastaEnvio
1291:             .Caption   = "Pasta p/ Envio :"
1292:             .Top       = 358
1293:             .Left      = 39
1294:             .Width     = 78
1295:             .Height    = 15
1296:             .FontName  = "Tahoma"
1297:             .FontSize  = 8
1298:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1305 a 1331:
1305:         *-- perder o foco (fDecriptografar, apesar do nome, CODIFICA para gravar)
1306:         par_oPagina.AddObject("txt_4c_Ftpsenha", "TextBox")
1307:         WITH par_oPagina.txt_4c_Ftpsenha
1308:             .Top          = 356
1309:             .Left         = 526
1310:             .Width        = 130
1311:             .Height       = 23
1312:             .FontName     = "Tahoma"
1313:             .FontSize     = 8
1314:             .ForeColor    = RGB(0, 0, 0)
1315:             .BackColor    = RGB(255, 255, 255)
1316:             .PasswordChar = "*"
1317:             .Value        = ""
1318:             .Visible      = .T.
1319:         ENDWITH
1320:         BINDEVENT(par_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")
1321: 
1322:         par_oPagina.AddObject("lbl_4c_Senha", "Label")
1323:         WITH par_oPagina.lbl_4c_Senha
1324:             .Caption   = "Senha :"
1325:             .Top       = 359
1326:             .Left      = 483
1327:             .Width     = 39
1328:             .Height    = 15
1329:             .FontName  = "Tahoma"
1330:             .FontSize  = 8
1331:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1337 a 1361:
1337:         *-- Pasta p/Recepcao (dirftpls)
1338:         par_oPagina.AddObject("txt_4c_Dirftpls", "TextBox")
1339:         WITH par_oPagina.txt_4c_Dirftpls
1340:             .Top       = 379
1341:             .Left      = 122
1342:             .Width     = 330
1343:             .Height    = 23
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .ForeColor = RGB(0, 0, 0)
1347:             .BackColor = RGB(255, 255, 255)
1348:             .Value     = ""
1349:             .Visible   = .T.
1350:         ENDWITH
1351: 
1352:         par_oPagina.AddObject("lbl_4c_PastaRecepcao", "Label")
1353:         WITH par_oPagina.lbl_4c_PastaRecepcao
1354:             .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
1355:             .Top       = 381
1356:             .Left      = 21
1357:             .Width     = 96
1358:             .Height    = 15
1359:             .FontName  = "Tahoma"
1360:             .FontSize  = 8
1361:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1368 a 1394:
1368:         *-- confirmacao apenas, nao gravado na tabela)
1369:         par_oPagina.AddObject("txt_4c_Senha2", "TextBox")
1370:         WITH par_oPagina.txt_4c_Senha2
1371:             .Top          = 379
1372:             .Left         = 526
1373:             .Width        = 130
1374:             .Height       = 23
1375:             .FontName     = "Tahoma"
1376:             .FontSize     = 8
1377:             .ForeColor    = RGB(0, 0, 0)
1378:             .BackColor    = RGB(255, 255, 255)
1379:             .PasswordChar = "*"
1380:             .Value        = ""
1381:             .Visible      = .T.
1382:         ENDWITH
1383:         BINDEVENT(par_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")
1384: 
1385:         par_oPagina.AddObject("lbl_4c_Redigita", "Label")
1386:         WITH par_oPagina.lbl_4c_Redigita
1387:             .Caption   = "Redigita :"
1388:             .Top       = 382
1389:             .Left      = 474
1390:             .Width     = 48
1391:             .Height    = 15
1392:             .FontName  = "Tahoma"
1393:             .FontSize  = 8
1394:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1400 a 1409:
1400:         *-- Divisor de fechamento da caixa "Configuracao da area do FTP" (Shape4 do legado)
1401:         par_oPagina.AddObject("shp_4c_DivisorFtpFim", "Shape")
1402:         WITH par_oPagina.shp_4c_DivisorFtpFim
1403:             .Top     = 409
1404:             .Left    = 4
1405:             .Width   = 690
1406:             .Height  = 2
1407:             .Visible = .T.
1408:         ENDWITH
1409:     ENDPROC

*-- Linhas 1435 a 1444:
1435:         loc_oPgN.grd_4c_Grade.ColumnCount  = 11
1436:         loc_oPgN.grd_4c_Grade.RecordSource = "cursor_4c_Grade"
1437:         WITH loc_oPgN.grd_4c_Grade
1438:             .Top               = 1
1439:             .Left              = 55
1440:             .Width             = 595
1441:             .Height            = 241
1442:             .FontName          = "Tahoma"
1443:             .FontSize          = 8
1444:             .AllowHeaderSizing = .F.

*-- Linhas 1505 a 1523:
1505:             .Column11.ForeColor     = RGB(0, 0, 0)
1506: 
1507:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1508:             .Column1.Header1.Caption  = "Emp"
1509:             .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
1510:             .Column3.Header1.Caption  = "Pg"
1511:             .Column4.Header1.Caption  = "Bx"
1512:             .Column5.Header1.Caption  = "Empds"
1513:             .Column6.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o Destino"
1514:             .Column7.Header1.Caption  = "Local Entrega"
1515:             .Column8.Header1.Caption  = "Del"
1516:             .Column9.Header1.Caption  = "DD"
1517:             .Column10.Header1.Caption = "NN"
1518:             .Column11.Header1.Caption = "DT"
1519:         ENDWITH
1520: 
1521:         *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
1522:         FOR loc_nCol = 1 TO 11
1523:             WITH loc_oPgN.grd_4c_Grade.Columns(loc_nCol).Text1

*-- Linhas 1557 a 1778:
1557:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column11.Text1, "KeyPress", THIS, "ValidarGradeDtTrans")
1558: 
1559:         *-- Legenda [S]im/[N]ao/[T]odos - Pg/Bx (Label1..Label10 do legado)
1560:         loc_oPgN.AddObject("lbl_4c_LegendaPg", "Label")
1561:         WITH loc_oPgN.lbl_4c_LegendaPg
1562:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1563:             .Top       = 247
1564:             .Left      = 69
1565:             .Width     = 137
1566:             .Height    = 13
1567:             .FontName  = "Tahoma"
1568:             .FontSize  = 7
1569:             .FontBold  = .T.
1570:             .ForeColor = RGB(90, 90, 90)
1571:             .BackStyle = 0
1572:             .AutoSize  = .T.
1573:             .Visible   = .T.
1574:         ENDWITH
1575: 
1576:         loc_oPgN.AddObject("lbl_4c_LegendaBx", "Label")
1577:         WITH loc_oPgN.lbl_4c_LegendaBx
1578:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1579:             .Top       = 247
1580:             .Left      = 318
1581:             .Width     = 137
1582:             .Height    = 13
1583:             .FontName  = "Tahoma"
1584:             .FontSize  = 7
1585:             .FontBold  = .T.
1586:             .ForeColor = RGB(90, 90, 90)
1587:             .BackStyle = 0
1588:             .AutoSize  = .T.
1589:             .Visible   = .T.
1590:         ENDWITH
1591: 
1592:         loc_oPgN.AddObject("lbl_4c_RotuloPg", "Label")
1593:         WITH loc_oPgN.lbl_4c_RotuloPg
1594:             .Caption   = "Pg(Pago) : "
1595:             .Top       = 247
1596:             .Left      = 12
1597:             .Width     = 59
1598:             .Height    = 13
1599:             .FontName  = "Tahoma"
1600:             .FontSize  = 7
1601:             .FontBold  = .T.
1602:             .ForeColor = RGB(90, 90, 90)
1603:             .BackStyle = 0
1604:             .AutoSize  = .T.
1605:             .Visible   = .T.
1606:         ENDWITH
1607: 
1608:         loc_oPgN.AddObject("lbl_4c_RotuloBx", "Label")
1609:         WITH loc_oPgN.lbl_4c_RotuloBx
1610:             .Caption   = "Bx(Baixado) : "
1611:             .Top       = 247
1612:             .Left      = 245
1613:             .Width     = 74
1614:             .Height    = 13
1615:             .FontName  = "Tahoma"
1616:             .FontSize  = 7
1617:             .FontBold  = .T.
1618:             .ForeColor = RGB(90, 90, 90)
1619:             .BackStyle = 0
1620:             .AutoSize  = .T.
1621:             .Visible   = .T.
1622:         ENDWITH
1623: 
1624:         loc_oPgN.AddObject("lbl_4c_PgS", "Label")
1625:         WITH loc_oPgN.lbl_4c_PgS
1626:             .Caption   = "S"
1627:             .Top       = 246
1628:             .Left      = 77
1629:             .Width     = 10
1630:             .Height    = 16
1631:             .FontName  = "Tahoma"
1632:             .FontSize  = 8
1633:             .FontBold  = .T.
1634:             .ForeColor = RGB(90, 90, 90)
1635:             .BackStyle = 0
1636:             .AutoSize  = .T.
1637:             .Visible   = .T.
1638:         ENDWITH
1639: 
1640:         loc_oPgN.AddObject("lbl_4c_BxS", "Label")
1641:         WITH loc_oPgN.lbl_4c_BxS
1642:             .Caption   = "S"
1643:             .Top       = 246
1644:             .Left      = 326
1645:             .Width     = 10
1646:             .Height    = 16
1647:             .FontName  = "Tahoma"
1648:             .FontSize  = 8
1649:             .FontBold  = .T.
1650:             .ForeColor = RGB(90, 90, 90)
1651:             .BackStyle = 0
1652:             .AutoSize  = .T.
1653:             .Visible   = .T.
1654:         ENDWITH
1655: 
1656:         loc_oPgN.AddObject("lbl_4c_PgN", "Label")
1657:         WITH loc_oPgN.lbl_4c_PgN
1658:             .Caption   = "N"
1659:             .Top       = 246
1660:             .Left      = 122
1661:             .Width     = 10
1662:             .Height    = 16
1663:             .FontName  = "Tahoma"
1664:             .FontSize  = 8
1665:             .FontBold  = .T.
1666:             .ForeColor = RGB(90, 90, 90)
1667:             .BackStyle = 0
1668:             .AutoSize  = .T.
1669:             .Visible   = .T.
1670:         ENDWITH
1671: 
1672:         loc_oPgN.AddObject("lbl_4c_BxN", "Label")
1673:         WITH loc_oPgN.lbl_4c_BxN
1674:             .Caption   = "N"
1675:             .Top       = 246
1676:             .Left      = 372
1677:             .Width     = 10
1678:             .Height    = 16
1679:             .FontName  = "Tahoma"
1680:             .FontSize  = 8
1681:             .FontBold  = .T.
1682:             .ForeColor = RGB(90, 90, 90)
1683:             .BackStyle = 0
1684:             .AutoSize  = .T.
1685:             .Visible   = .T.
1686:         ENDWITH
1687: 
1688:         loc_oPgN.AddObject("lbl_4c_PgT", "Label")
1689:         WITH loc_oPgN.lbl_4c_PgT
1690:             .Caption   = "T"
1691:             .Top       = 246
1692:             .Left      = 169
1693:             .Width     = 9
1694:             .Height    = 16
1695:             .FontName  = "Tahoma"
1696:             .FontSize  = 8
1697:             .FontBold  = .T.
1698:             .ForeColor = RGB(90, 90, 90)
1699:             .BackStyle = 0
1700:             .AutoSize  = .T.
1701:             .Visible   = .T.
1702:         ENDWITH
1703: 
1704:         loc_oPgN.AddObject("lbl_4c_BxT", "Label")
1705:         WITH loc_oPgN.lbl_4c_BxT
1706:             .Caption   = "T"
1707:             .Top       = 246
1708:             .Left      = 418
1709:             .Width     = 9
1710:             .Height    = 16
1711:             .FontName  = "Tahoma"
1712:             .FontSize  = 8
1713:             .FontBold  = .T.
1714:             .ForeColor = RGB(90, 90, 90)
1715:             .BackStyle = 0
1716:             .AutoSize  = .T.
1717:             .Visible   = .T.
1718:         ENDWITH
1719: 
1720:         *-- Legenda [S]im/[N]ao - Nn/Troca Numeracao (Label11..Label14 do legado)
1721:         loc_oPgN.AddObject("lbl_4c_LegendaNn", "Label")
1722:         WITH loc_oPgN.lbl_4c_LegendaNn
1723:             .Caption   = "[    ]im / [    ]ao"
1724:             .Top       = 247
1725:             .Left      = 594
1726:             .Width     = 81
1727:             .Height    = 13
1728:             .FontName  = "Tahoma"
1729:             .FontSize  = 7
1730:             .FontBold  = .T.
1731:             .ForeColor = RGB(90, 90, 90)
1732:             .BackStyle = 0
1733:             .AutoSize  = .T.
1734:             .Visible   = .T.
1735:         ENDWITH
1736: 
1737:         loc_oPgN.AddObject("lbl_4c_RotuloNn", "Label")
1738:         WITH loc_oPgN.lbl_4c_RotuloNn
1739:             .Caption   = "Nn(Troca Numera" + CHR(231) + CHR(227) + "o) : "
1740:             .Top       = 247
1741:             .Left      = 477
1742:             .Width     = 122
1743:             .Height    = 13
1744:             .FontName  = "Tahoma"
1745:             .FontSize  = 7
1746:             .FontBold  = .T.
1747:             .ForeColor = RGB(90, 90, 90)
1748:             .BackStyle = 0
1749:             .AutoSize  = .T.
1750:             .Visible   = .T.
1751:         ENDWITH
1752: 
1753:         loc_oPgN.AddObject("lbl_4c_NnS", "Label")
1754:         WITH loc_oPgN.lbl_4c_NnS
1755:             .Caption   = "S"
1756:             .Top       = 246
1757:             .Left      = 602
1758:             .Width     = 10
1759:             .Height    = 16
1760:             .FontName  = "Tahoma"
1761:             .FontSize  = 8
1762:             .FontBold  = .T.
1763:             .ForeColor = RGB(90, 90, 90)
1764:             .BackStyle = 0
1765:             .AutoSize  = .T.
1766:             .Visible   = .T.
1767:         ENDWITH
1768: 
1769:         loc_oPgN.AddObject("lbl_4c_NnN", "Label")
1770:         WITH loc_oPgN.lbl_4c_NnN
1771:             .Caption   = "N"
1772:             .Top       = 246
1773:             .Left      = 648
1774:             .Width     = 10
1775:             .Height    = 16
1776:             .FontName  = "Tahoma"
1777:             .FontSize  = 8
1778:             .FontBold  = .T.

*-- Linhas 1930 a 1939:
1930:         loc_oPgN.grd_4c_Titulos.ColumnCount  = 3
1931:         loc_oPgN.grd_4c_Titulos.RecordSource = "cursor_4c_Titulos"
1932:         WITH loc_oPgN.grd_4c_Titulos
1933:             .Top               = 1
1934:             .Left              = 222
1935:             .Width             = 260
1936:             .Height            = 242
1937:             .FontName          = "Tahoma"
1938:             .FontSize          = 8
1939:             .AllowHeaderSizing = .F.

*-- Linhas 1962 a 1972:
1962:             .Column3.Resizable     = .F.
1963: 
1964:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1965:             .Column1.Header1.Caption = "Emp"
1966:             .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1967:             .Column3.Header1.Caption = "S/N/A"
1968:         ENDWITH
1969: 
1970:         *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
1971:         FOR loc_nCol = 1 TO 3
1972:             WITH loc_oPgN.grd_4c_Titulos.Columns(loc_nCol).Text1

*-- Linhas 1990 a 2050:
1990:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column3.Text1, "KeyPress", THIS, "ValidarGradeTituloSNA")
1991: 
1992:         *-- Legenda [S]im/[N]ao/[A]mbos (Label1/5/7/9 do legado)
1993:         loc_oPgN.AddObject("lbl_4c_LegendaSNA", "Label")
1994:         WITH loc_oPgN.lbl_4c_LegendaSNA
1995:             .Caption   = "[ S ]im / [ N ]ao / [ A ]mbos"
1996:             .Top       = 248
1997:             .Left      = 270
1998:             .Width     = 155
1999:             .Height    = 15
2000:             .FontName  = "Tahoma"
2001:             .FontSize  = 8
2002:             .FontBold  = .T.
2003:             .ForeColor = RGB(90, 90, 90)
2004:             .BackStyle = 0
2005:             .AutoSize  = .T.
2006:             .Visible   = .T.
2007:         ENDWITH
2008: 
2009:         loc_oPgN.AddObject("lbl_4c_SnaS", "Label")
2010:         WITH loc_oPgN.lbl_4c_SnaS
2011:             .Caption   = "S"
2012:             .Top       = 247
2013:             .Left      = 278
2014:             .Width     = 10
2015:             .Height    = 16
2016:             .FontName  = "Tahoma"
2017:             .FontSize  = 8
2018:             .FontBold  = .T.
2019:             .ForeColor = RGB(90, 90, 90)
2020:             .BackStyle = 0
2021:             .AutoSize  = .T.
2022:             .Visible   = .T.
2023:         ENDWITH
2024: 
2025:         loc_oPgN.AddObject("lbl_4c_SnaN", "Label")
2026:         WITH loc_oPgN.lbl_4c_SnaN
2027:             .Caption   = "N"
2028:             .Top       = 247
2029:             .Left      = 326
2030:             .Width     = 10
2031:             .Height    = 16
2032:             .FontName  = "Tahoma"
2033:             .FontSize  = 8
2034:             .FontBold  = .T.
2035:             .ForeColor = RGB(90, 90, 90)
2036:             .BackStyle = 0
2037:             .AutoSize  = .T.
2038:             .Visible   = .T.
2039:         ENDWITH
2040: 
2041:         loc_oPgN.AddObject("lbl_4c_SnaA", "Label")
2042:         WITH loc_oPgN.lbl_4c_SnaA
2043:             .Caption   = "A"
2044:             .Top       = 247
2045:             .Left      = 375
2046:             .Width     = 11
2047:             .Height    = 16
2048:             .FontName  = "Tahoma"
2049:             .FontSize  = 8
2050:             .FontBold  = .T.

*-- Linhas 2513 a 2522:
2513:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2514: 
2515:         TRY
2516:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2517:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2518:         CATCH TO loException
2519:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2520:                 "FormTme.AjustarBotoesPorModo")
2521:         ENDTRY
2522:     ENDPROC


### BO (C:\4c\projeto\app\classes\TmeBO.prg):
*====================================================================
* TmeBO.prg
*
* Business Object para Cadastro de Transporte de Movimentacao de
* Estoque (Configuracao de Transporte/FTP entre empresas)
* Tabela principal: SigCdMe (PK: tipoemps = Tipos + Emps)
* Tabelas de detalhe (grids da Page2.Configuracao):
*   - SigCdMeI (Page1 do PageFrame de Configuracao - Operacoes/Itens)
*   - SigCdMeT (Page2 do PageFrame de Configuracao - Titulos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMe)
    this_cTipoEmps            = ""    && tipoemps    char(9)  - PK (concatenacao Tipos+Emps)
    this_cTipos               = ""    && tipos       char(6)  - codigo do Processo/Transporte
    this_cEmps                = ""    && emps        char(3)  - codigo da Empresa
    this_cDescricao           = ""    && descrs      char(20) - descricao do transporte
    this_cExtensao            = ""    && extensao    char(3)  - tipo de extensao do arquivo
    this_cDirGeracao          = ""    && drivets     char(60) - diretorio de geracao/gravacao do transporte
    this_cDirLeitura          = ""    && drivels     char(60) - diretorio de leitura do zip
    this_cDirRecepcao         = ""    && drivers     char(60) - diretorio de recepcao do transporte
    this_cDirArquivar         = ""    && paths       char(60) - diretorio para arquivar o arquivo recebido
    this_cTipoConexao         = ""    && tpconexao   char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco         = ""    && ftpend      char(50) - endereco do FTP
    this_cFtpUsuario          = ""    && ftpusuario  char(50) - usuario do FTP
    this_cFtpSenha            = ""    && ftpsenha    char(20) - senha do FTP (criptografada)
    this_cDirFtpEnvio         = ""    && dirftpts    char(60) - pasta para envio (FTP)
    this_cDirFtpRecepcao      = ""    && dirftpls    char(60) - pasta para recepcao (FTP)
    this_lNaoChecarSequencia  = .F.   && nchkseqs    bit      - nao checar sequencia
    this_nTransporteOk        = 0     && clrarqs     numeric(3,0) - numero do transporte OK / limpar arqs OK
    this_cTipoTransporte      = ""    && transtipo   char(6)  - tipo transporte (lookup SigPrTrn.Codigos)
    this_lLimpaDirEnvio       = .F.   && locdel      bit      - limpa diretorio de envio
    this_lLimpaDirFtp         = .F.   && ftpdel      bit      - limpa diretorio do FTP
    this_cEmpDs               = ""    && empds       char(3)  - empresa de destino

    *-- Cursores dos grids de detalhe (Page2.Configuracao.Page1/Page2)
    this_cCursorItens         = "cursor_4c_Itens"     && grid de Operacoes/Itens (tabela SigCdMeI)
    this_cCursorTitulos       = "cursor_4c_Titulos"   && grid de Titulos (tabela SigCdMeT)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMe"
            THIS.this_cCampoChave = "tipoemps"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TmeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipoEmps)
    ENDFUNC

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
                THIS.this_cTipoEmps           = TratarNulo(tipoemps,   "C")
                THIS.this_cTipos              = TratarNulo(tipos,      "C")
                THIS.this_cEmps               = TratarNulo(emps,       "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cDirGeracao         = TratarNulo(drivets,    "C")
                THIS.this_cDirLeitura         = TratarNulo(drivels,    "C")
                THIS.this_cDirRecepcao        = TratarNulo(drivers,    "C")
                THIS.this_cDirArquivar        = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_cTipoTransporte     = TratarNulo(transtipo,  "C")
                THIS.this_lLimpaDirEnvio      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_cEmpDs              = TratarNulo(empds,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TmeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cTipos)
            MsgAviso("C" + CHR(243) + "digo do Transporte Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            MsgAviso("C" + CHR(243) + "digo da Empresa Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            THIS.this_cTipoEmps = PADR(THIS.this_cTipos, 6) + PADR(THIS.this_cEmps, 3)
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarChaveExistente(THIS.this_cTipoEmps)
                MsgAviso("Transporte j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se tipoemps ja existe no banco
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMe" + ;
                " WHERE tipoemps = " + EscaparSQL(par_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChave")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkChave")
                SELECT cursor_4c_ChkChave
                loc_lExiste = (cursor_4c_ChkChave.qtd > 0)
                USE IN cursor_4c_ChkChave
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar transporte:" + CHR(13) + loException.Message, "TmeBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMe (tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipoEmps)>>,
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TmeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMe
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    extensao   = <<EscaparSQL(THIS.this_cExtensao)>>,
                    drivets    = <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    drivels    = <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    drivers    = <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    paths      = <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    tpconexao  = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    ftpend     = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpusuario = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    ftpsenha   = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    dirftpts   = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    dirftpls   = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    nchkseqs   = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    clrarqs    = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    transtipo  = <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    locdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    ftpdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>
                WHERE tipoemps = <<EscaparSQL(THIS.this_cTipoEmps)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TmeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdMe e seus detalhes
    * (SigCdMeI = Operacoes/Itens, SigCdMeT = Titulos)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMei WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdMet WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdMe WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TmeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com tipoemps, tipos, emps, descrs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipoemps C(9), tipos C(6), emps C(3), descrs C(20), extensao C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipoemps, tipos, emps, descrs, extensao FROM SigCdMe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY tipos, emps"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TmeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (tipoemps)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds
                FROM SigCdMe
                WHERE tipoemps = <<EscaparSQL(par_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TmeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega grid de Operacoes/Itens (SigCdMeI) do transporte
    * Legado: csGrade (TipoEmps, Emps, Dopes, cIdChaves, ChkPagos, ChkSubns,
    *         EmpDs, DopeDs, ContaEs, Apagas, nDias, Numeras, DtTrans)
    *====================================================================
    PROCEDURE BuscarItens(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, chkpagos, chksubns,
                    empds, dopeds, contaes, apagas, ndias, numeras, dttrans
                FROM SigCdMei
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorItens))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar itens:" + CHR(13) + loException.Message, "TmeBO.BuscarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarTitulos - Carrega grid de Titulos (SigCdMeT) do transporte
    * Legado: CsTitulo (TipoEmps, Emps, Dopes, cIdChaves, cNotas)
    *====================================================================
    PROCEDURE BuscarTitulos(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorTitulos)
                USE IN (THIS.this_cCursorTitulos)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, cnotas, empds
                FROM SigCdMet
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTitulos))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar t" + CHR(237) + "tulos:" + CHR(13) + loException.Message, "TmeBO.BuscarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarOperacoesDisponiveis - Lista de operacoes para o lookup da
    * coluna "Operacao" do grid de Titulos (Pagina Titulos/Pag/Rec/Lote
    * Chq). Legado: CrSigOpOpe (Init) = SELECT Dopes FROM SigOpOpe + 3
    * operacoes especiais fixas que nao existem na tabela (PAGAMENTO,
    * RECEBIMENTO, LOTE DE CHEQUE) - tratadas apenas nesta pagina.
    * Retorna cursor_4c_Operacoes (dopes), indexado por dopes.
    *====================================================================
    PROCEDURE BuscarOperacoesDisponiveis()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT dopes FROM SigOpOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("PAGAMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("RECEBIMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("LOTE DE CHEQUE")
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es dispon" + CHR(237) + "veis:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "TmeBO.BuscarOperacoesDisponiveis")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


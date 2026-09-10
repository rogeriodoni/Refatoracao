# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption 'Processo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTme.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2800 linhas total):

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

*-- Linhas 408 a 420:
408:                 *-- Column1 (tipos): legado nao tem grid na Pagina.Lista (browse generico do
409:                 *-- frmcadastro) - caption usa o rotulo do proprio campo no legado
410:                 *-- (Say7 "Processo :" em Pagina.Dados.Pageframe1.Page1, ControlSource crSigCdMe.Tipos)
411:                 loc_oGrid.Column1.Header1.Caption = "Processo"
412:                 loc_oGrid.Column2.Header1.Caption = "Emp"
413:                 *-- Column3 (descrs): idem - sem Header1 no legado; caption usa o rotulo do
414:                 *-- proprio campo (Say4 "Descri" + CHR(231) + CHR(227) + "o :", ControlSource crSigCdMe.descrs)
415:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
416: 
417:                 THIS.FormatarGridLista(loc_oGrid)
418:                 loc_lResultado = .T.
419:             ENDIF
420: 

*-- Linhas 486 a 523:
486:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
487:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
488:         WITH loc_oPagina.cnt_4c_Cabecalho
489:             .Top           = 29
490:             .Left          = 0
491:             .Width         = THIS.Width
492:             .Height        = 80
493:             .BackColor     = RGB(100, 100, 100)
494:             .BorderWidth   = 0
495:             .SpecialEffect = 0
496:             .Visible       = .T.
497: 
498:             .AddObject("lbl_4c_Sombra", "Label")
499:             WITH .lbl_4c_Sombra
500:                 .Caption   = THIS.Caption
501:                 .Top       = 15
502:                 .Left      = 10
503:                 .Width     = THIS.Width
504:                 .Height    = 40
505:                 .FontName  = "Tahoma"
506:                 .FontSize  = 16
507:                 .FontBold  = .T.
508:                 .ForeColor = RGB(0, 0, 0)
509:                 .BackStyle = 0
510:                 .AutoSize  = .F.
511:                 .Visible   = .T.
512:             ENDWITH
513: 
514:             .AddObject("lbl_4c_Titulo", "Label")
515:             WITH .lbl_4c_Titulo
516:                 .Caption   = THIS.Caption
517:                 .Top       = 18
518:                 .Left      = 10
519:                 .Width     = THIS.Width
520:                 .Height    = 46
521:                 .FontName  = "Tahoma"
522:                 .FontSize  = 16
523:                 .FontBold  = .T.

*-- Linhas 532 a 557:
532:         *-- Canonico: Left=842, Top=33, Width=160, Height=85
533:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
534:         WITH loc_oPagina.cnt_4c_BotoesAcao
535:             .Top         = 33
536:             .Left        = 842
537:             .Width       = 160
538:             .Height      = 85
539:             .BackStyle = 1
540:             .BackColor   = RGB(255, 255, 255)
541:             .BorderWidth = 0
542:             .Visible     = .T.
543:         ENDWITH
544: 
545:         *-- Botao Confirmar (Left=5)
546:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
547:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
548:             .Caption         = "Confirmar"
549:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
550:             .PicturePosition = 13
551:             .Top             = 5
552:             .Left            = 5
553:             .Width           = 75
554:             .Height          = 75
555:             .FontName        = "Tahoma"
556:             .FontBold        = .T.
557:             .FontItalic      = .T.

*-- Linhas 565 a 582:
565:             .AutoSize        = .F.
566:             .Visible         = .T.
567:         ENDWITH
568:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
569: 
570:         *-- Botao Cancelar (Left=80)
571:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
572:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
573:             .Caption         = "Encerrar"
574:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
575:             .PicturePosition = 13
576:             .Top             = 5
577:             .Left            = 80
578:             .Width           = 75
579:             .Height          = 75
580:             .FontName        = "Tahoma"
581:             .FontBold        = .T.
582:             .FontItalic      = .T.

*-- Linhas 590 a 598:
590:             .AutoSize        = .F.
591:             .Visible         = .T.
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
594: 
595:         *-- FASE 5/8 - Campos Principais Parte 1 (Secao "Configuracao do
596:         *-- Transporte" do legado: Pageframe1.Page1, Top original 12..149).
597:         *-- FASE 6/8 - Campos Restantes Parte 2 (Secao "Configuracao da area
598:         *-- do FTP" do legado: Pageframe1.Page1, Top original 185..306).

*-- Linhas 610 a 636:
610:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
611:         WITH loc_oPagina.pgf_4c_DadosInternos
612:             .PageCount = 3
613:             .Top       = 420
614:             .Left      = 6
615:             .Width     = 689
616:             .Height    = 291
617:             .Visible   = .T.
618: 
619:             .Page1.Caption   = "Titulos/Pag/Rec/Lote Chq"
620:             .Page1.FontName  = "Tahoma"
621:             .Page1.FontSize  = 8
622:             .Page1.BackColor = RGB(255, 255, 255)
623:             .Page1.ForeColor = RGB(90, 90, 90)
624: 
625:             .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Estoque"
626:             .Page2.FontName  = "Tahoma"
627:             .Page2.FontSize  = 8
628:             .Page2.BackColor = RGB(255, 255, 255)
629:             .Page2.ForeColor = RGB(90, 90, 90)
630: 
631:             .Page3.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
632:             .Page3.FontName  = "Tahoma"
633:             .Page3.FontSize  = 8
634:             .Page3.BackColor = RGB(255, 255, 255)
635:             .Page3.ForeColor = RGB(90, 90, 90)
636:         ENDWITH

*-- Linhas 655 a 772:
655:     *===========================================================================
656:     PROTECTED PROCEDURE AdicionarCamposIdentificacao(par_oPagina)
657:         *-- Processo (Tipos) - chave do transporte
658:         par_oPagina.AddObject("lbl_4c_Processo", "Label")
659:         WITH par_oPagina.lbl_4c_Processo
660:             .Caption   = "Processo :"
661:             .Top       = 119
662:             .Left      = 18
663:             .Width     = 62
664:             .Height    = 15
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .ForeColor = RGB(90, 90, 90)
668:             .BackStyle = 0
669:             .AutoSize  = .F.
670:             .Visible   = .T.
671:         ENDWITH
672: 
673:         par_oPagina.AddObject("txt_4c_Tipos", "TextBox")
674:         WITH par_oPagina.txt_4c_Tipos
675:             .Top       = 115
676:             .Left      = 85
677:             .Width     = 52
678:             .Height    = 23
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .ForeColor = RGB(0, 0, 0)
682:             .BackColor = RGB(255, 255, 255)
683:             .Value     = ""
684:             .Visible   = .T.
685:         ENDWITH
686: 
687:         *-- Empresa (Emps) - fAcessoEmpresa() NAO foi portada, campo simples
688:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
689:         WITH par_oPagina.lbl_4c_Empresa
690:             .Caption   = "Empresa :"
691:             .Top       = 119
692:             .Left      = 142
693:             .Width     = 60
694:             .Height    = 15
695:             .FontName  = "Tahoma"
696:             .FontSize  = 8
697:             .ForeColor = RGB(90, 90, 90)
698:             .BackStyle = 0
699:             .AutoSize  = .F.
700:             .Visible   = .T.
701:         ENDWITH
702: 
703:         par_oPagina.AddObject("txt_4c_Emps", "TextBox")
704:         WITH par_oPagina.txt_4c_Emps
705:             .Top        = 115
706:             .Left       = 210
707:             .Width      = 31
708:             .Height     = 23
709:             .FontName   = "Tahoma"
710:             .FontSize   = 8
711:             .ForeColor  = RGB(0, 0, 0)
712:             .BackColor  = RGB(255, 255, 255)
713:             .Value      = ""
714:             .Visible    = .T.
715:             .MaxLength   = 3
716:         ENDWITH
717: 
718:         *-- Descricao (Descrs)
719:         par_oPagina.AddObject("lbl_4c_Descricao", "Label")
720:         WITH par_oPagina.lbl_4c_Descricao
721:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
722:             .Top       = 119
723:             .Left      = 247
724:             .Width     = 63
725:             .Height    = 15
726:             .FontName  = "Tahoma"
727:             .FontSize  = 8
728:             .ForeColor = RGB(90, 90, 90)
729:             .BackStyle = 0
730:             .AutoSize  = .F.
731:             .Visible   = .T.
732:         ENDWITH
733: 
734:         par_oPagina.AddObject("txt_4c_Descrs", "TextBox")
735:         WITH par_oPagina.txt_4c_Descrs
736:             .Top       = 115
737:             .Left      = 320
738:             .Width     = 150
739:             .Height    = 23
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .ForeColor = RGB(0, 0, 0)
743:             .BackColor = RGB(255, 255, 255)
744:             .Value     = ""
745:             .Visible   = .T.
746:         ENDWITH
747: 
748:         *-- Tipo de Extensao do Arquivo (Extensao)
749:         par_oPagina.AddObject("lbl_4c_TipoExtensao", "Label")
750:         WITH par_oPagina.lbl_4c_TipoExtensao
751:             .Caption   = "Tipo de Extens" + CHR(227) + "o do Arquivo :"
752:             .Top       = 119
753:             .Left      = 492
754:             .Width     = 170
755:             .Height    = 15
756:             .FontName  = "Tahoma"
757:             .FontSize  = 8
758:             .ForeColor = RGB(90, 90, 90)
759:             .BackStyle = 0
760:             .AutoSize  = .F.
761:             .Visible   = .T.
762:         ENDWITH
763: 
764:         par_oPagina.AddObject("txt_4c_Extensao", "TextBox")
765:         WITH par_oPagina.txt_4c_Extensao
766:             .Top       = 115
767:             .Left      = 668
768:             .Width     = 31
769:             .Height    = 23
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 786 a 836:
786:         *-- Divisor + titulo da secao (Shape3 + Say15 do legado)
787:         par_oPagina.AddObject("shp_4c_DivisorTransporte", "Shape")
788:         WITH par_oPagina.shp_4c_DivisorTransporte
789:             .Top     = 147
790:             .Left    = 6
791:             .Width   = 690
792:             .Height  = 2
793:             .Visible = .T.
794:         ENDWITH
795: 
796:         par_oPagina.AddObject("lbl_4c_SecaoTransporte", "Label")
797:         WITH par_oPagina.lbl_4c_SecaoTransporte
798:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
799:             .Top       = 150
800:             .Left      = 6
801:             .Width     = 250
802:             .Height    = 18
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .FontBold  = .T.
806:             .ForeColor = RGB(90, 90, 90)
807:             .BackStyle = 0
808:             .AutoSize  = .F.
809:             .Visible   = .T.
810:         ENDWITH
811: 
812:         *-- Transporte (Dados) - lookup SigPrTrn.Codigos (F4/LostFocus)
813:         par_oPagina.AddObject("lbl_4c_TransporteDados", "Label")
814:         WITH par_oPagina.lbl_4c_TransporteDados
815:             .Caption   = "Transporte (Dados) :"
816:             .Top       = 157
817:             .Left      = 506
818:             .Width     = 120
819:             .Height    = 15
820:             .FontName  = "Tahoma"
821:             .FontSize  = 8
822:             .ForeColor = RGB(90, 90, 90)
823:             .BackStyle = 0
824:             .AutoSize  = .F.
825:             .Visible   = .T.
826:         ENDWITH
827: 
828:         par_oPagina.AddObject("txt_4c_TransTipo", "TextBox")
829:         WITH par_oPagina.txt_4c_TransTipo
830:             .Top       = 153
831:             .Left      = 629
832:             .Width     = 52
833:             .Height    = 23
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 842 a 1008:
842:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "ValidarTransTipo")
843: 
844:         *-- Transporte - diretorio de geracao/gravacao (drivets)
845:         par_oPagina.AddObject("lbl_4c_Transporte", "Label")
846:         WITH par_oPagina.lbl_4c_Transporte
847:             .Caption   = "Transporte :"
848:             .Top       = 183
849:             .Left      = 15
850:             .Width     = 62
851:             .Height    = 15
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .ForeColor = RGB(90, 90, 90)
855:             .BackStyle = 0
856:             .AutoSize  = .F.
857:             .Visible   = .T.
858:         ENDWITH
859: 
860:         par_oPagina.AddObject("txt_4c_DirGeracao", "TextBox")
861:         WITH par_oPagina.txt_4c_DirGeracao
862:             .Top       = 180
863:             .Left      = 79
864:             .Width     = 430
865:             .Height    = 23
866:             .FontName  = "Tahoma"
867:             .FontSize  = 8
868:             .ForeColor = RGB(0, 0, 0)
869:             .BackColor = RGB(255, 255, 255)
870:             .Value     = ""
871:             .Visible   = .T.
872:         ENDWITH
873:         BINDEVENT(par_oPagina.txt_4c_DirGeracao, "KeyPress", THIS, "ValidarDirGeracao")
874: 
875:         *-- No. Transporte Ok (clrarqs) - numerico
876:         par_oPagina.AddObject("lbl_4c_NoTransporteOk", "Label")
877:         WITH par_oPagina.lbl_4c_NoTransporteOk
878:             .Caption   = "No. Transporte Ok :"
879:             .Top       = 184
880:             .Left      = 555
881:             .Width     = 120
882:             .Height    = 15
883:             .FontName  = "Tahoma"
884:             .FontSize  = 8
885:             .ForeColor = RGB(90, 90, 90)
886:             .BackStyle = 0
887:             .AutoSize  = .F.
888:             .Visible   = .T.
889:         ENDWITH
890: 
891:         par_oPagina.AddObject("txt_4c_ClrArqOks", "TextBox")
892:         WITH par_oPagina.txt_4c_ClrArqOks
893:             .Top       = 180
894:             .Left      = 650
895:             .Width     = 31
896:             .Height    = 23
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:             .ForeColor = RGB(0, 0, 0)
900:             .BackColor = RGB(255, 255, 255)
901:             .InputMask = "999"
902:             .Value     = ""
903:             .Visible   = .T.
904:         ENDWITH
905: 
906:         *-- Leitura - diretorio de leitura do zip (drivels)
907:         par_oPagina.AddObject("lbl_4c_Leitura", "Label")
908:         WITH par_oPagina.lbl_4c_Leitura
909:             .Caption   = "Leitura :"
910:             .Top       = 205
911:             .Left      = 35
912:             .Width     = 42
913:             .Height    = 15
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .ForeColor = RGB(90, 90, 90)
917:             .BackStyle = 0
918:             .AutoSize  = .F.
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         par_oPagina.AddObject("txt_4c_DirLeitura", "TextBox")
923:         WITH par_oPagina.txt_4c_DirLeitura
924:             .Top       = 202
925:             .Left      = 79
926:             .Width     = 430
927:             .Height    = 23
928:             .FontName  = "Tahoma"
929:             .FontSize  = 8
930:             .ForeColor = RGB(0, 0, 0)
931:             .BackColor = RGB(255, 255, 255)
932:             .Value     = ""
933:             .Visible   = .T.
934:         ENDWITH
935:         BINDEVENT(par_oPagina.txt_4c_DirLeitura, "KeyPress", THIS, "ValidarDirLeitura")
936: 
937:         *-- Nao Checar Sequencia (nchkseqs)
938:         par_oPagina.AddObject("chk_4c_Seqnum", "CheckBox")
939:         WITH par_oPagina.chk_4c_Seqnum
940:             .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia "
941:             .Top       = 207
942:             .Left      = 531
943:             .Width     = 129
944:             .Height    = 15
945:             .FontName  = "Tahoma"
946:             .FontSize  = 8
947:             .ForeColor = RGB(90, 90, 90)
948:             .BackStyle = 0
949:             .Value     = 0
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         *-- Recepcao - diretorio de recepcao do transporte (drivers)
954:         par_oPagina.AddObject("lbl_4c_Recepcao", "Label")
955:         WITH par_oPagina.lbl_4c_Recepcao
956:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
957:             .Top       = 228
958:             .Left      = 21
959:             .Width     = 56
960:             .Height    = 15
961:             .FontName  = "Tahoma"
962:             .FontSize  = 8
963:             .ForeColor = RGB(90, 90, 90)
964:             .BackStyle = 0
965:             .AutoSize  = .F.
966:             .Visible   = .T.
967:         ENDWITH
968: 
969:         par_oPagina.AddObject("txt_4c_DirRecepcao", "TextBox")
970:         WITH par_oPagina.txt_4c_DirRecepcao
971:             .Top       = 225
972:             .Left      = 79
973:             .Width     = 430
974:             .Height    = 23
975:             .FontName  = "Tahoma"
976:             .FontSize  = 8
977:             .ForeColor = RGB(0, 0, 0)
978:             .BackColor = RGB(255, 255, 255)
979:             .Value     = ""
980:             .Visible   = .T.
981:         ENDWITH
982:         BINDEVENT(par_oPagina.txt_4c_DirRecepcao, "KeyPress", THIS, "ValidarDirRecepcao")
983: 
984:         *-- Arquivar - diretorio para arquivar arquivo recebido (paths, opcional)
985:         par_oPagina.AddObject("lbl_4c_Arquivar", "Label")
986:         WITH par_oPagina.lbl_4c_Arquivar
987:             .Caption   = "Arquivar :"
988:             .Top       = 252
989:             .Left      = 27
990:             .Width     = 50
991:             .Height    = 15
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .ForeColor = RGB(90, 90, 90)
995:             .BackStyle = 0
996:             .AutoSize  = .F.
997:             .Visible   = .T.
998:         ENDWITH
999: 
1000:         par_oPagina.AddObject("txt_4c_DirArquivar", "TextBox")
1001:         WITH par_oPagina.txt_4c_DirArquivar
1002:             .Top       = 249
1003:             .Left      = 79
1004:             .Width     = 430
1005:             .Height    = 23
1006:             .FontName  = "Tahoma"
1007:             .FontSize  = 8
1008:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1015 a 1050:
1015:         *-- Caixa decorativa em torno de "Prox.Transp." e "Prox.Recebe" (Shape2 do legado)
1016:         par_oPagina.AddObject("shp_4c_CaixaProximos", "Shape")
1017:         WITH par_oPagina.shp_4c_CaixaProximos
1018:             .Top     = 230
1019:             .Left    = 516
1020:             .Width   = 172
1021:             .Height  = 48
1022:             .Visible = .T.
1023:         ENDWITH
1024: 
1025:         *-- Proximo Numero de Transporte (sem ControlSource no legado - campo
1026:         *-- desvinculado, nao gravado na tabela)
1027:         par_oPagina.AddObject("lbl_4c_ProxTransp", "Label")
1028:         WITH par_oPagina.lbl_4c_ProxTransp
1029:             .Caption   = "Pr" + CHR(243) + "x.Transp."
1030:             .Top       = 235
1031:             .Left      = 523
1032:             .Width     = 90
1033:             .Height    = 15
1034:             .FontName  = "Tahoma"
1035:             .FontSize  = 8
1036:             .ForeColor = RGB(90, 90, 90)
1037:             .BackStyle = 0
1038:             .AutoSize  = .F.
1039:             .Visible   = .T.
1040:         ENDWITH
1041: 
1042:         par_oPagina.AddObject("txt_4c_ProxTransp", "TextBox")
1043:         WITH par_oPagina.txt_4c_ProxTransp
1044:             .Top       = 250
1045:             .Left      = 529
1046:             .Width     = 58
1047:             .Height    = 23
1048:             .FontName  = "Tahoma"
1049:             .FontSize  = 8
1050:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1056 a 1082:
1056: 
1057:         *-- Proximo Numero de Recebimento (sem ControlSource no legado - campo
1058:         *-- desvinculado, nao gravado na tabela)
1059:         par_oPagina.AddObject("lbl_4c_ProxRecebe", "Label")
1060:         WITH par_oPagina.lbl_4c_ProxRecebe
1061:             .Caption   = "Pr" + CHR(243) + "x.Recebe"
1062:             .Top       = 234
1063:             .Left      = 604
1064:             .Width     = 90
1065:             .Height    = 15
1066:             .FontName  = "Tahoma"
1067:             .FontSize  = 8
1068:             .ForeColor = RGB(90, 90, 90)
1069:             .BackStyle = 0
1070:             .AutoSize  = .F.
1071:             .Visible   = .T.
1072:         ENDWITH
1073: 
1074:         par_oPagina.AddObject("txt_4c_ProxRecebe", "TextBox")
1075:         WITH par_oPagina.txt_4c_ProxRecebe
1076:             .Top       = 249
1077:             .Left      = 612
1078:             .Width     = 58
1079:             .Height    = 23
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1089 a 1098:
1089:         *-- Divisor de fechamento da caixa "Configuracao do Transporte" (Shape1 do legado)
1090:         par_oPagina.AddObject("shp_4c_DivisorTransporteFim", "Shape")
1091:         WITH par_oPagina.shp_4c_DivisorTransporteFim
1092:             .Top     = 285
1093:             .Left    = 4
1094:             .Width   = 690
1095:             .Height  = 2
1096:             .Visible = .T.
1097:         ENDWITH
1098:     ENDPROC

*-- Linhas 1105 a 1198:
1105:     *===========================================================================
1106:     PROTECTED PROCEDURE AdicionarCamposFtp(par_oPagina)
1107:         *-- Titulo da secao (Say12 do legado)
1108:         par_oPagina.AddObject("lbl_4c_SecaoFtp", "Label")
1109:         WITH par_oPagina.lbl_4c_SecaoFtp
1110:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(225) + "rea do FTP "
1111:             .Top       = 288
1112:             .Left      = 5
1113:             .Width     = 194
1114:             .Height    = 18
1115:             .FontName  = "Tahoma"
1116:             .FontSize  = 8
1117:             .FontBold  = .T.
1118:             .ForeColor = RGB(90, 90, 90)
1119:             .BackStyle = 0
1120:             .AutoSize  = .F.
1121:             .Visible   = .T.
1122:         ENDWITH
1123: 
1124:         *-- Tipo de Conexao (tpconexao) - D=Dial-Up / B=Banda Larga
1125:         par_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
1126:         WITH par_oPagina.lbl_4c_TipoConexao
1127:             .Caption   = "Tipo de Conex" + CHR(227) + "o :"
1128:             .Top       = 314
1129:             .Left      = 27
1130:             .Width     = 90
1131:             .Height    = 15
1132:             .FontName  = "Tahoma"
1133:             .FontSize  = 8
1134:             .ForeColor = RGB(90, 90, 90)
1135:             .BackStyle = 0
1136:             .AutoSize  = .F.
1137:             .Visible   = .T.
1138:         ENDWITH
1139: 
1140:         par_oPagina.AddObject("txt_4c_Tpconexao", "TextBox")
1141:         WITH par_oPagina.txt_4c_Tpconexao
1142:             .Top       = 310
1143:             .Left      = 122
1144:             .Width     = 28
1145:             .Height    = 23
1146:             .FontName  = "Tahoma"
1147:             .FontSize  = 8
1148:             .ForeColor = RGB(0, 0, 0)
1149:             .BackColor = RGB(255, 255, 255)
1150:             .Value     = ""
1151:             .Visible   = .T.
1152:         ENDWITH
1153: 
1154:         par_oPagina.AddObject("lbl_4c_DialUpBanda", "Label")
1155:         WITH par_oPagina.lbl_4c_DialUpBanda
1156:             .Caption   = "(D/B) Dial-Up / Banda Larga"
1157:             .Top       = 313
1158:             .Left      = 153
1159:             .Width     = 159
1160:             .Height    = 15
1161:             .FontName  = "Tahoma"
1162:             .FontSize  = 8
1163:             .ForeColor = RGB(90, 90, 90)
1164:             .BackStyle = 0
1165:             .AutoSize  = .F.
1166:             .Visible   = .T.
1167:         ENDWITH
1168: 
1169:         *-- Limpa diretorio de envio (locdel) - legado Top=210 + offset canonico +103 = 313
1170:         *-- (confere com os vizinhos da mesma linha: Say19/Say5 legado Top=210/211 ->
1171:         *-- lbl_4c_DialUpBanda/lbl_4c_TipoConexao migrado Top=313/314). NAO alterar.
1172:         par_oPagina.AddObject("chk_4c_Chklocdel", "CheckBox")
1173:         WITH par_oPagina.chk_4c_Chklocdel
1174:             .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
1175:             .Top       = 313
1176:             .Left      = 362
1177:             .Width     = 160
1178:             .Height    = 17
1179:             .FontName  = "Tahoma"
1180:             .FontSize  = 8
1181:             .ForeColor = RGB(90, 90, 90)
1182:             .BackStyle = 0
1183:             .Value     = 0
1184:             .Visible   = .T.
1185:         ENDWITH
1186: 
1187:         *-- Limpa diretorio do FTP (ftpdel) - legado Top=210 + offset canonico +103 = 313
1188:         *-- (mesma linha de chk_4c_Chklocdel acima - ver comentario). NAO alterar.
1189:         par_oPagina.AddObject("chk_4c_Chkftpdel", "CheckBox")
1190:         WITH par_oPagina.chk_4c_Chkftpdel
1191:             .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
1192:             .Top       = 313
1193:             .Left      = 527
1194:             .Width     = 160
1195:             .Height    = 17
1196:             .FontName  = "Tahoma"
1197:             .FontSize  = 8
1198:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1204 a 1228:
1204:         *-- Endereco FTP (ftpend)
1205:         par_oPagina.AddObject("txt_4c_Ftpend", "TextBox")
1206:         WITH par_oPagina.txt_4c_Ftpend
1207:             .Top       = 333
1208:             .Left      = 122
1209:             .Width     = 330
1210:             .Height    = 23
1211:             .FontName  = "Tahoma"
1212:             .FontSize  = 8
1213:             .ForeColor = RGB(0, 0, 0)
1214:             .BackColor = RGB(255, 255, 255)
1215:             .Value     = ""
1216:             .Visible   = .T.
1217:         ENDWITH
1218: 
1219:         par_oPagina.AddObject("lbl_4c_EnderecoFtp", "Label")
1220:         WITH par_oPagina.lbl_4c_EnderecoFtp
1221:             .Caption   = "Endere" + CHR(231) + "o FTP :"
1222:             .Top       = 335
1223:             .Left      = 42
1224:             .Width     = 75
1225:             .Height    = 15
1226:             .FontName  = "Tahoma"
1227:             .FontSize  = 8
1228:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1234 a 1258:
1234:         *-- Usuario do FTP (ftpusuario)
1235:         par_oPagina.AddObject("txt_4c_Ftpusuario", "TextBox")
1236:         WITH par_oPagina.txt_4c_Ftpusuario
1237:             .Top       = 333
1238:             .Left      = 526
1239:             .Width     = 160
1240:             .Height    = 23
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:             .ForeColor = RGB(0, 0, 0)
1244:             .BackColor = RGB(255, 255, 255)
1245:             .Value     = ""
1246:             .Visible   = .T.
1247:         ENDWITH
1248: 
1249:         par_oPagina.AddObject("lbl_4c_Usuario", "Label")
1250:         WITH par_oPagina.lbl_4c_Usuario
1251:             .Caption   = "Usu" + CHR(225) + "rio :"
1252:             .Top       = 336
1253:             .Left      = 477
1254:             .Width     = 45
1255:             .Height    = 15
1256:             .FontName  = "Tahoma"
1257:             .FontSize  = 8
1258:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1264 a 1288:
1264:         *-- Pasta p/ Envio (dirftpts)
1265:         par_oPagina.AddObject("txt_4c_Dirftpts", "TextBox")
1266:         WITH par_oPagina.txt_4c_Dirftpts
1267:             .Top       = 356
1268:             .Left      = 122
1269:             .Width     = 330
1270:             .Height    = 23
1271:             .FontName  = "Tahoma"
1272:             .FontSize  = 8
1273:             .ForeColor = RGB(0, 0, 0)
1274:             .BackColor = RGB(255, 255, 255)
1275:             .Value     = ""
1276:             .Visible   = .T.
1277:         ENDWITH
1278: 
1279:         par_oPagina.AddObject("lbl_4c_PastaEnvio", "Label")
1280:         WITH par_oPagina.lbl_4c_PastaEnvio
1281:             .Caption   = "Pasta p/ Envio :"
1282:             .Top       = 358
1283:             .Left      = 39
1284:             .Width     = 78
1285:             .Height    = 15
1286:             .FontName  = "Tahoma"
1287:             .FontSize  = 8
1288:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1295 a 1321:
1295:         *-- perder o foco (fDecriptografar, apesar do nome, CODIFICA para gravar)
1296:         par_oPagina.AddObject("txt_4c_Ftpsenha", "TextBox")
1297:         WITH par_oPagina.txt_4c_Ftpsenha
1298:             .Top          = 356
1299:             .Left         = 526
1300:             .Width        = 130
1301:             .Height       = 23
1302:             .FontName     = "Tahoma"
1303:             .FontSize     = 8
1304:             .ForeColor    = RGB(0, 0, 0)
1305:             .BackColor    = RGB(255, 255, 255)
1306:             .PasswordChar = "*"
1307:             .Value        = ""
1308:             .Visible      = .T.
1309:         ENDWITH
1310:         BINDEVENT(par_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")
1311: 
1312:         par_oPagina.AddObject("lbl_4c_Senha", "Label")
1313:         WITH par_oPagina.lbl_4c_Senha
1314:             .Caption   = "Senha :"
1315:             .Top       = 359
1316:             .Left      = 483
1317:             .Width     = 39
1318:             .Height    = 15
1319:             .FontName  = "Tahoma"
1320:             .FontSize  = 8
1321:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1327 a 1351:
1327:         *-- Pasta p/Recepcao (dirftpls)
1328:         par_oPagina.AddObject("txt_4c_Dirftpls", "TextBox")
1329:         WITH par_oPagina.txt_4c_Dirftpls
1330:             .Top       = 379
1331:             .Left      = 122
1332:             .Width     = 330
1333:             .Height    = 23
1334:             .FontName  = "Tahoma"
1335:             .FontSize  = 8
1336:             .ForeColor = RGB(0, 0, 0)
1337:             .BackColor = RGB(255, 255, 255)
1338:             .Value     = ""
1339:             .Visible   = .T.
1340:         ENDWITH
1341: 
1342:         par_oPagina.AddObject("lbl_4c_PastaRecepcao", "Label")
1343:         WITH par_oPagina.lbl_4c_PastaRecepcao
1344:             .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
1345:             .Top       = 381
1346:             .Left      = 21
1347:             .Width     = 96
1348:             .Height    = 15
1349:             .FontName  = "Tahoma"
1350:             .FontSize  = 8
1351:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1358 a 1384:
1358:         *-- confirmacao apenas, nao gravado na tabela)
1359:         par_oPagina.AddObject("txt_4c_Senha2", "TextBox")
1360:         WITH par_oPagina.txt_4c_Senha2
1361:             .Top          = 379
1362:             .Left         = 526
1363:             .Width        = 130
1364:             .Height       = 23
1365:             .FontName     = "Tahoma"
1366:             .FontSize     = 8
1367:             .ForeColor    = RGB(0, 0, 0)
1368:             .BackColor    = RGB(255, 255, 255)
1369:             .PasswordChar = "*"
1370:             .Value        = ""
1371:             .Visible      = .T.
1372:         ENDWITH
1373:         BINDEVENT(par_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")
1374: 
1375:         par_oPagina.AddObject("lbl_4c_Redigita", "Label")
1376:         WITH par_oPagina.lbl_4c_Redigita
1377:             .Caption   = "Redigita :"
1378:             .Top       = 382
1379:             .Left      = 474
1380:             .Width     = 48
1381:             .Height    = 15
1382:             .FontName  = "Tahoma"
1383:             .FontSize  = 8
1384:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1390 a 1399:
1390:         *-- Divisor de fechamento da caixa "Configuracao da area do FTP" (Shape4 do legado)
1391:         par_oPagina.AddObject("shp_4c_DivisorFtpFim", "Shape")
1392:         WITH par_oPagina.shp_4c_DivisorFtpFim
1393:             .Top     = 409
1394:             .Left    = 4
1395:             .Width   = 690
1396:             .Height  = 2
1397:             .Visible = .T.
1398:         ENDWITH
1399:     ENDPROC

*-- Linhas 1425 a 1434:
1425:         loc_oPgN.grd_4c_Grade.ColumnCount  = 11
1426:         loc_oPgN.grd_4c_Grade.RecordSource = "cursor_4c_Grade"
1427:         WITH loc_oPgN.grd_4c_Grade
1428:             .Top               = 1
1429:             .Left              = 55
1430:             .Width             = 595
1431:             .Height            = 241
1432:             .FontName          = "Tahoma"
1433:             .FontSize          = 8
1434:             .AllowHeaderSizing = .F.

*-- Linhas 1495 a 1513:
1495:             .Column11.ForeColor     = RGB(0, 0, 0)
1496: 
1497:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1498:             .Column1.Header1.Caption  = "Emp"
1499:             .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
1500:             .Column3.Header1.Caption  = "Pg"
1501:             .Column4.Header1.Caption  = "Bx"
1502:             .Column5.Header1.Caption  = "Empds"
1503:             .Column6.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o Destino"
1504:             .Column7.Header1.Caption  = "Local Entrega"
1505:             .Column8.Header1.Caption  = "Del"
1506:             .Column9.Header1.Caption  = "DD"
1507:             .Column10.Header1.Caption = "NN"
1508:             .Column11.Header1.Caption = "DT"
1509:         ENDWITH
1510: 
1511:         *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
1512:         FOR loc_nCol = 1 TO 11
1513:             WITH loc_oPgN.grd_4c_Grade.Columns(loc_nCol).Text1

*-- Linhas 1547 a 1768:
1547:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column11.Text1, "KeyPress", THIS, "ValidarGradeDtTrans")
1548: 
1549:         *-- Legenda [S]im/[N]ao/[T]odos - Pg/Bx (Label1..Label10 do legado)
1550:         loc_oPgN.AddObject("lbl_4c_LegendaPg", "Label")
1551:         WITH loc_oPgN.lbl_4c_LegendaPg
1552:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1553:             .Top       = 247
1554:             .Left      = 69
1555:             .Width     = 137
1556:             .Height    = 13
1557:             .FontName  = "Tahoma"
1558:             .FontSize  = 7
1559:             .FontBold  = .T.
1560:             .ForeColor = RGB(90, 90, 90)
1561:             .BackStyle = 0
1562:             .AutoSize  = .T.
1563:             .Visible   = .T.
1564:         ENDWITH
1565: 
1566:         loc_oPgN.AddObject("lbl_4c_LegendaBx", "Label")
1567:         WITH loc_oPgN.lbl_4c_LegendaBx
1568:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1569:             .Top       = 247
1570:             .Left      = 318
1571:             .Width     = 137
1572:             .Height    = 13
1573:             .FontName  = "Tahoma"
1574:             .FontSize  = 7
1575:             .FontBold  = .T.
1576:             .ForeColor = RGB(90, 90, 90)
1577:             .BackStyle = 0
1578:             .AutoSize  = .T.
1579:             .Visible   = .T.
1580:         ENDWITH
1581: 
1582:         loc_oPgN.AddObject("lbl_4c_RotuloPg", "Label")
1583:         WITH loc_oPgN.lbl_4c_RotuloPg
1584:             .Caption   = "Pg(Pago) : "
1585:             .Top       = 247
1586:             .Left      = 12
1587:             .Width     = 59
1588:             .Height    = 13
1589:             .FontName  = "Tahoma"
1590:             .FontSize  = 7
1591:             .FontBold  = .T.
1592:             .ForeColor = RGB(90, 90, 90)
1593:             .BackStyle = 0
1594:             .AutoSize  = .T.
1595:             .Visible   = .T.
1596:         ENDWITH
1597: 
1598:         loc_oPgN.AddObject("lbl_4c_RotuloBx", "Label")
1599:         WITH loc_oPgN.lbl_4c_RotuloBx
1600:             .Caption   = "Bx(Baixado) : "
1601:             .Top       = 247
1602:             .Left      = 245
1603:             .Width     = 74
1604:             .Height    = 13
1605:             .FontName  = "Tahoma"
1606:             .FontSize  = 7
1607:             .FontBold  = .T.
1608:             .ForeColor = RGB(90, 90, 90)
1609:             .BackStyle = 0
1610:             .AutoSize  = .T.
1611:             .Visible   = .T.
1612:         ENDWITH
1613: 
1614:         loc_oPgN.AddObject("lbl_4c_PgS", "Label")
1615:         WITH loc_oPgN.lbl_4c_PgS
1616:             .Caption   = "S"
1617:             .Top       = 246
1618:             .Left      = 77
1619:             .Width     = 10
1620:             .Height    = 16
1621:             .FontName  = "Tahoma"
1622:             .FontSize  = 8
1623:             .FontBold  = .T.
1624:             .ForeColor = RGB(90, 90, 90)
1625:             .BackStyle = 0
1626:             .AutoSize  = .T.
1627:             .Visible   = .T.
1628:         ENDWITH
1629: 
1630:         loc_oPgN.AddObject("lbl_4c_BxS", "Label")
1631:         WITH loc_oPgN.lbl_4c_BxS
1632:             .Caption   = "S"
1633:             .Top       = 246
1634:             .Left      = 326
1635:             .Width     = 10
1636:             .Height    = 16
1637:             .FontName  = "Tahoma"
1638:             .FontSize  = 8
1639:             .FontBold  = .T.
1640:             .ForeColor = RGB(90, 90, 90)
1641:             .BackStyle = 0
1642:             .AutoSize  = .T.
1643:             .Visible   = .T.
1644:         ENDWITH
1645: 
1646:         loc_oPgN.AddObject("lbl_4c_PgN", "Label")
1647:         WITH loc_oPgN.lbl_4c_PgN
1648:             .Caption   = "N"
1649:             .Top       = 246
1650:             .Left      = 122
1651:             .Width     = 10
1652:             .Height    = 16
1653:             .FontName  = "Tahoma"
1654:             .FontSize  = 8
1655:             .FontBold  = .T.
1656:             .ForeColor = RGB(90, 90, 90)
1657:             .BackStyle = 0
1658:             .AutoSize  = .T.
1659:             .Visible   = .T.
1660:         ENDWITH
1661: 
1662:         loc_oPgN.AddObject("lbl_4c_BxN", "Label")
1663:         WITH loc_oPgN.lbl_4c_BxN
1664:             .Caption   = "N"
1665:             .Top       = 246
1666:             .Left      = 372
1667:             .Width     = 10
1668:             .Height    = 16
1669:             .FontName  = "Tahoma"
1670:             .FontSize  = 8
1671:             .FontBold  = .T.
1672:             .ForeColor = RGB(90, 90, 90)
1673:             .BackStyle = 0
1674:             .AutoSize  = .T.
1675:             .Visible   = .T.
1676:         ENDWITH
1677: 
1678:         loc_oPgN.AddObject("lbl_4c_PgT", "Label")
1679:         WITH loc_oPgN.lbl_4c_PgT
1680:             .Caption   = "T"
1681:             .Top       = 246
1682:             .Left      = 169
1683:             .Width     = 9
1684:             .Height    = 16
1685:             .FontName  = "Tahoma"
1686:             .FontSize  = 8
1687:             .FontBold  = .T.
1688:             .ForeColor = RGB(90, 90, 90)
1689:             .BackStyle = 0
1690:             .AutoSize  = .T.
1691:             .Visible   = .T.
1692:         ENDWITH
1693: 
1694:         loc_oPgN.AddObject("lbl_4c_BxT", "Label")
1695:         WITH loc_oPgN.lbl_4c_BxT
1696:             .Caption   = "T"
1697:             .Top       = 246
1698:             .Left      = 418
1699:             .Width     = 9
1700:             .Height    = 16
1701:             .FontName  = "Tahoma"
1702:             .FontSize  = 8
1703:             .FontBold  = .T.
1704:             .ForeColor = RGB(90, 90, 90)
1705:             .BackStyle = 0
1706:             .AutoSize  = .T.
1707:             .Visible   = .T.
1708:         ENDWITH
1709: 
1710:         *-- Legenda [S]im/[N]ao - Nn/Troca Numeracao (Label11..Label14 do legado)
1711:         loc_oPgN.AddObject("lbl_4c_LegendaNn", "Label")
1712:         WITH loc_oPgN.lbl_4c_LegendaNn
1713:             .Caption   = "[    ]im / [    ]ao"
1714:             .Top       = 247
1715:             .Left      = 594
1716:             .Width     = 81
1717:             .Height    = 13
1718:             .FontName  = "Tahoma"
1719:             .FontSize  = 7
1720:             .FontBold  = .T.
1721:             .ForeColor = RGB(90, 90, 90)
1722:             .BackStyle = 0
1723:             .AutoSize  = .T.
1724:             .Visible   = .T.
1725:         ENDWITH
1726: 
1727:         loc_oPgN.AddObject("lbl_4c_RotuloNn", "Label")
1728:         WITH loc_oPgN.lbl_4c_RotuloNn
1729:             .Caption   = "Nn(Troca Numera" + CHR(231) + CHR(227) + "o) : "
1730:             .Top       = 247
1731:             .Left      = 477
1732:             .Width     = 122
1733:             .Height    = 13
1734:             .FontName  = "Tahoma"
1735:             .FontSize  = 7
1736:             .FontBold  = .T.
1737:             .ForeColor = RGB(90, 90, 90)
1738:             .BackStyle = 0
1739:             .AutoSize  = .T.
1740:             .Visible   = .T.
1741:         ENDWITH
1742: 
1743:         loc_oPgN.AddObject("lbl_4c_NnS", "Label")
1744:         WITH loc_oPgN.lbl_4c_NnS
1745:             .Caption   = "S"
1746:             .Top       = 246
1747:             .Left      = 602
1748:             .Width     = 10
1749:             .Height    = 16
1750:             .FontName  = "Tahoma"
1751:             .FontSize  = 8
1752:             .FontBold  = .T.
1753:             .ForeColor = RGB(90, 90, 90)
1754:             .BackStyle = 0
1755:             .AutoSize  = .T.
1756:             .Visible   = .T.
1757:         ENDWITH
1758: 
1759:         loc_oPgN.AddObject("lbl_4c_NnN", "Label")
1760:         WITH loc_oPgN.lbl_4c_NnN
1761:             .Caption   = "N"
1762:             .Top       = 246
1763:             .Left      = 648
1764:             .Width     = 10
1765:             .Height    = 16
1766:             .FontName  = "Tahoma"
1767:             .FontSize  = 8
1768:             .FontBold  = .T.

*-- Linhas 1920 a 1929:
1920:         loc_oPgN.grd_4c_Titulos.ColumnCount  = 3
1921:         loc_oPgN.grd_4c_Titulos.RecordSource = "cursor_4c_Titulos"
1922:         WITH loc_oPgN.grd_4c_Titulos
1923:             .Top               = 1
1924:             .Left              = 222
1925:             .Width             = 260
1926:             .Height            = 242
1927:             .FontName          = "Tahoma"
1928:             .FontSize          = 8
1929:             .AllowHeaderSizing = .F.

*-- Linhas 1952 a 1962:
1952:             .Column3.Resizable     = .F.
1953: 
1954:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1955:             .Column1.Header1.Caption = "Emp"
1956:             .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1957:             .Column3.Header1.Caption = "S/N/A"
1958:         ENDWITH
1959: 
1960:         *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
1961:         FOR loc_nCol = 1 TO 3
1962:             WITH loc_oPgN.grd_4c_Titulos.Columns(loc_nCol).Text1

*-- Linhas 1980 a 2040:
1980:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column3.Text1, "KeyPress", THIS, "ValidarGradeTituloSNA")
1981: 
1982:         *-- Legenda [S]im/[N]ao/[A]mbos (Label1/5/7/9 do legado)
1983:         loc_oPgN.AddObject("lbl_4c_LegendaSNA", "Label")
1984:         WITH loc_oPgN.lbl_4c_LegendaSNA
1985:             .Caption   = "[ S ]im / [ N ]ao / [ A ]mbos"
1986:             .Top       = 248
1987:             .Left      = 270
1988:             .Width     = 155
1989:             .Height    = 15
1990:             .FontName  = "Tahoma"
1991:             .FontSize  = 8
1992:             .FontBold  = .T.
1993:             .ForeColor = RGB(90, 90, 90)
1994:             .BackStyle = 0
1995:             .AutoSize  = .T.
1996:             .Visible   = .T.
1997:         ENDWITH
1998: 
1999:         loc_oPgN.AddObject("lbl_4c_SnaS", "Label")
2000:         WITH loc_oPgN.lbl_4c_SnaS
2001:             .Caption   = "S"
2002:             .Top       = 247
2003:             .Left      = 278
2004:             .Width     = 10
2005:             .Height    = 16
2006:             .FontName  = "Tahoma"
2007:             .FontSize  = 8
2008:             .FontBold  = .T.
2009:             .ForeColor = RGB(90, 90, 90)
2010:             .BackStyle = 0
2011:             .AutoSize  = .T.
2012:             .Visible   = .T.
2013:         ENDWITH
2014: 
2015:         loc_oPgN.AddObject("lbl_4c_SnaN", "Label")
2016:         WITH loc_oPgN.lbl_4c_SnaN
2017:             .Caption   = "N"
2018:             .Top       = 247
2019:             .Left      = 326
2020:             .Width     = 10
2021:             .Height    = 16
2022:             .FontName  = "Tahoma"
2023:             .FontSize  = 8
2024:             .FontBold  = .T.
2025:             .ForeColor = RGB(90, 90, 90)
2026:             .BackStyle = 0
2027:             .AutoSize  = .T.
2028:             .Visible   = .T.
2029:         ENDWITH
2030: 
2031:         loc_oPgN.AddObject("lbl_4c_SnaA", "Label")
2032:         WITH loc_oPgN.lbl_4c_SnaA
2033:             .Caption   = "A"
2034:             .Top       = 247
2035:             .Left      = 375
2036:             .Width     = 11
2037:             .Height    = 16
2038:             .FontName  = "Tahoma"
2039:             .FontSize  = 8
2040:             .FontBold  = .T.

*-- Linhas 2503 a 2512:
2503:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2504: 
2505:         TRY
2506:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2507:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2508:         CATCH TO loException
2509:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2510:                 "FormTme.AjustarBotoesPorModo")
2511:         ENDTRY
2512:     ENDPROC


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
                    CREATE CURSOR cursor_4c_Dados (tipoemps C(9), tipos C(6), emps C(3), descrs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipoemps, tipos, emps, descrs FROM SigCdMe"

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


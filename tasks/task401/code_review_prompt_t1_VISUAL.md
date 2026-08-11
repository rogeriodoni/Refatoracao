# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formema.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (923 linhas total):

*-- Linhas 60 a 71:
60:                 THIS.ConfigurarPaginaLista()
61:                 THIS.ConfigurarPaginaDados()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
65:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:                 THIS.CarregarLista()
69: 
70:                 THIS.pgf_4c_Paginas.Visible   = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 81 a 107:
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
84:     * Original: Pagina.Width=1003; PageFrame.Top=-29 para ocultar abas
85:     *--------------------------------------------------------------------------
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = 1003
94:             .Height    = 631    && runtime adiciona +4 -> 635 visivel
95:             .Tabs      = .F.
96:         ENDWITH
97: 
98:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
99:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
100:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101: 
102:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
103:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
104:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------

*-- Linhas 120 a 157:
120:         *-- Container sombra/titulo (cntSombra: Top=1+29=30, Left=0, W=1020, H=80)
121:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
122:         WITH loc_oPagina.cnt_4c_Sombra
123:             .Top         = 30       && 1 + 29 (compensacao PageFrame.Top=-29)
124:             .Left        = 0
125:             .Width       = 1020
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
134:             .Caption   = THIS.Caption
135:             .Top       = 45
136:             .Left      = 12
137:             .Width     = 980
138:             .Height    = 30
139:             .AutoSize  = .F.
140:             .FontName  = "Tahoma"
141:             .FontSize  = 18
142:             .FontBold  = .T.
143:             .ForeColor = RGB(30, 30, 30)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 43
152:             .Left      = 10
153:             .Width     = 980
154:             .Height    = 30
155:             .AutoSize  = .F.
156:             .FontName  = "Tahoma"
157:             .FontSize  = 18

*-- Linhas 164 a 186:
164:         *-- Container botoes CRUD (Grupo_op: L=542, Top=-1+29=28)
165:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:         WITH loc_oPagina.cnt_4c_Botoes
167:             .Top         = 28
168:             .Left        = 542
169:             .Width       = 390
170:             .Height      = 88
171:             .BackStyle   = 0
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Botao Incluir
177:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
178:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
179:             .Caption         = "Incluir"
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .FontName        = "Tahoma"

*-- Linhas 197 a 209:
197:         ENDWITH
198: 
199:         *-- Botao Visualizar
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
208:             .PicturePosition = 13
209:             .FontName        = "Tahoma"

*-- Linhas 220 a 232:
220:         ENDWITH
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .FontName        = "Tahoma"

*-- Linhas 243 a 255:
243:         ENDWITH
244: 
245:         *-- Botao Excluir
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
254:             .PicturePosition = 13
255:             .FontName        = "Tahoma"

*-- Linhas 266 a 278:
266:         ENDWITH
267: 
268:         *-- Botao Buscar
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .FontName        = "Tahoma"

*-- Linhas 291 a 313:
291:         *-- Container botao Encerrar (canonico: L=917, Top=29)
292:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
293:         WITH loc_oPagina.cnt_4c_Saida
294:             .Top         = 29
295:             .Left        = 917
296:             .Width       = 90
297:             .Height      = 85
298:             .BackStyle   = 0
299:             .BorderWidth = 0
300:             .Visible     = .T.
301:         ENDWITH
302: 
303:         *-- Botao Encerrar
304:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
305:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
306:             .Caption         = "Encerrar"
307:             .Top             = 5
308:             .Left            = 5
309:             .Width           = 75
310:             .Height          = 75
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .FontName        = "Tahoma"

*-- Linhas 326 a 335:
326:         *-- Grid lista (Grade: Top=112+29=141, Left=20, Width=890, Height=470)
327:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
328:         WITH loc_oPagina.grd_4c_Lista
329:             .Top                = 141
330:             .Left               = 20
331:             .Width              = 890
332:             .Height             = 470
333:             .FontName           = "Verdana"
334:             .FontSize           = 8
335:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 347 a 411:
347:         ENDWITH
348: 
349:         *-- BINDEVENTs dos botoes CRUD (handlers devem ser PUBLIC)
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
355:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
356:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")
357: 
358:         THIS.TornarControlesVisiveis(loc_oPagina)
359:     ENDPROC
360: 
361:     *--------------------------------------------------------------------------
362:     * ConfigurarPaginaDados - Cria estrutura da Page2
363:     * Original: Grupo_Salva(L=812,T=24), getCods(T=137,L=359,W=339,H=24),
364:     *           Say1(T=141,L=301) "Descricao :"
365:     * Fase 5: adicionados lbl_4c_Label1 + txt_4c_Codigo (email)
366:     *--------------------------------------------------------------------------
367:     PROTECTED PROCEDURE ConfigurarPaginaDados()
368:         LOCAL loc_oPagina
369:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
370: 
371:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
372:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
373: 
374:         *-- Container sombra/titulo (espelha Page1)
375:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
376:         WITH loc_oPagina.cnt_4c_Sombra
377:             .Top         = 30       && 1 + 29 (compensacao PageFrame.Top=-29)
378:             .Left        = 0
379:             .Width       = 1020
380:             .Height      = 80
381:             .BackColor   = RGB(100, 100, 100)
382:             .BorderWidth = 0
383:             .Visible     = .T.
384:         ENDWITH
385: 
386:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
387:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
388:             .Caption   = THIS.Caption
389:             .Top       = 45
390:             .Left      = 12
391:             .Width     = 980
392:             .Height    = 30
393:             .AutoSize  = .F.
394:             .FontName  = "Tahoma"
395:             .FontSize  = 18
396:             .FontBold  = .T.
397:             .ForeColor = RGB(30, 30, 30)
398:             .BackStyle = 0
399:             .Visible   = .T.
400:         ENDWITH
401: 
402:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
403:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
404:             .Caption   = THIS.Caption
405:             .Top       = 43
406:             .Left      = 10
407:             .Width     = 980
408:             .Height    = 30
409:             .AutoSize  = .F.
410:             .FontName  = "Tahoma"
411:             .FontSize  = 18

*-- Linhas 418 a 441:
418:         *-- Container botoes Salvar/Cancelar (Grupo_Salva: L=812, Top=24+29=53)
419:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao
421:             .Top         = 53       && 24 + 29
422:             .Left        = 812
423:             .Width       = 175
424:             .Height      = 88
425:             .BackStyle = 0
426:             .BackColor   = RGB(255, 255, 255)
427:             .BorderWidth = 0
428:             .Visible     = .T.
429:         ENDWITH
430: 
431:         *-- Botao Salvar (Salva: Left=7, Top=5)
432:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
433:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
434:             .Caption         = "Salvar"
435:             .Top             = 5
436:             .Left            = 7
437:             .Width           = 75
438:             .Height          = 75
439:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
440:             .PicturePosition = 13
441:             .FontName        = "Tahoma"

*-- Linhas 452 a 464:
452:         ENDWITH
453: 
454:         *-- Botao Cancelar (Cancelar: Left=82, Top=5)
455:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
456:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
457:             .Caption         = "Encerrar"
458:             .Top             = 5
459:             .Left            = 82
460:             .Width           = 75
461:             .Height          = 75
462:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
463:             .PicturePosition = 13
464:             .FontName        = "Tahoma"

*-- Linhas 475 a 491:
475:         ENDWITH
476: 
477:         *-- BINDEVENTs dos botoes de acao (handlers PUBLIC para BINDEVENT funcionar)
478:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
479:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
480: 
481:         *-- Label "Descricao :" (Say1: Top=141+29=170, Left=301, ForeColor=RGB(90,90,90))
482:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
483:         WITH loc_oPagina.lbl_4c_Label1
484:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
485:             .Top       = 170
486:             .Left      = 301
487:             .Width     = 55
488:             .Height    = 17
489:             .AutoSize  = .F.
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8

*-- Linhas 500 a 509:
500:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
501:         WITH loc_oPagina.txt_4c_Codigo
502:             .Value         = ""
503:             .Top           = 166
504:             .Left          = 359
505:             .Width         = 339
506:             .Height        = 24
507:             .MaxLength     = 50
508:             .SpecialEffect = 1
509:             .FontName      = "Tahoma"

*-- Linhas 522 a 557:
522:         LOCAL loc_lResultado, loc_oGrid
523:         loc_lResultado = .F.
524: 
525:         TRY
526:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
527:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(36), Cods C(50))
528:                 loc_lResultado = .T.
529:             ELSE
530:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
531:             ENDIF
532: 
533:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
534:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
535: 
536:                 *-- RecordSource e ColumnCount FORA de WITH (Problema 36/48)
537:                 loc_oGrid.ColumnCount = 3
538:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
539:                 loc_oGrid.ColumnCount  = 1
540: 
541:                 WITH loc_oGrid
542:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
543:                     .Column1.Width           = 880
544:                     .Column1.Header1.Caption = "Email"
545:                 ENDWITH
546: 
547:                 THIS.FormatarGridLista(loc_oGrid)
548:                 loc_oGrid.Refresh()
549:             ENDIF
550:         CATCH TO loc_oErro
551:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
552:             loc_lResultado = .F.
553:         ENDTRY
554: 
555:         RETURN loc_lResultado
556:     ENDPROC
557: 

*-- Linhas 630 a 704:
630:     *--------------------------------------------------------------------------
631:     PROCEDURE BtnVisualizarClick()
632:         LOCAL loc_cCodigo
633:         loc_cCodigo = ""
634: 
635:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
636:             SELECT cursor_4c_Dados
637:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
638:         ENDIF
639: 
640:         IF EMPTY(loc_cCodigo)
641:             MsgAviso("Selecione um registro na lista.", "Visualizar")
642:             RETURN
643:         ENDIF
644: 
645:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
646:             THIS.BOParaForm()
647:             THIS.this_cModoAtual = "VISUALIZAR"
648:             THIS.HabilitarCampos(.F.)
649:             THIS.AlternarPagina(2)
650:         ENDIF
651:     ENDPROC
652: 
653:     *--------------------------------------------------------------------------
654:     * BtnAlterarClick - Carrega registro selecionado para edicao
655:     *--------------------------------------------------------------------------
656:     PROCEDURE BtnAlterarClick()
657:         LOCAL loc_cCodigo
658:         loc_cCodigo = ""
659: 
660:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
661:             SELECT cursor_4c_Dados
662:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
663:         ENDIF
664: 
665:         IF EMPTY(loc_cCodigo)
666:             MsgAviso("Selecione um registro na lista.", "Alterar")
667:             RETURN
668:         ENDIF
669: 
670:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
671:             THIS.this_oBusinessObject.EditarRegistro()
672:             THIS.BOParaForm()
673:             THIS.this_cModoAtual = "ALTERAR"
674:             THIS.HabilitarCampos(.T.)
675:             THIS.AlternarPagina(2)
676:         ENDIF
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * BtnExcluirClick - Confirma e exclui o registro selecionado
681:     *--------------------------------------------------------------------------
682:     PROCEDURE BtnExcluirClick()
683:         LOCAL loc_cCodigo, loc_lConfirmado
684:         loc_cCodigo    = ""
685:         loc_lConfirmado = .F.
686: 
687:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
688:             SELECT cursor_4c_Dados
689:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
690:         ENDIF
691: 
692:         IF EMPTY(loc_cCodigo)
693:             MsgAviso("Selecione um registro na lista.", "Excluir")
694:             RETURN
695:         ENDIF
696: 
697:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
698:                                       "Confirmar Exclus" + CHR(227) + "o")
699:         IF !loc_lConfirmado
700:             RETURN
701:         ENDIF
702: 
703:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
704:             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 724 a 747:
724:             loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
725:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
726:                 LOCAL loc_oGrid
727:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
728:                 loc_oGrid.ColumnCount = 3
729:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
730:                 loc_oGrid.ColumnCount  = 1
731:                 WITH loc_oGrid
732:                     .Column1.ControlSource   = "cursor_4c_Dados.Cods"
733:                     .Column1.Width           = 880
734:                     .Column1.Header1.Caption = "Email"
735:                 ENDWITH
736:                 loc_oGrid.Refresh()
737:             ENDIF
738:         CATCH TO loc_oErro
739:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
740:         ENDTRY
741:     ENDPROC
742: 
743:     *--------------------------------------------------------------------------
744:     * BtnEncerrarClick - Fecha o formulario
745:     *--------------------------------------------------------------------------
746:     PROCEDURE BtnEncerrarClick()
747:         THIS.Release()

*-- Linhas 779 a 791:
779:         ENDIF
780: 
781:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
782:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
783:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEdicao
784:             ENDIF
785:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
786:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
787:             ENDIF
788:         ENDIF
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------

*-- Linhas 872 a 923:
872: 
873:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
874: 
875:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Incluir", 5)
876:                 loc_oPg1.cmd_4c_Incluir.Enabled = loc_lNaLista
877:             ENDIF
878:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Visualizar", 5)
879:                 loc_oPg1.cmd_4c_Visualizar.Enabled = loc_lNaLista
880:             ENDIF
881:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Alterar", 5)
882:                 loc_oPg1.cmd_4c_Alterar.Enabled = loc_lNaLista
883:             ENDIF
884:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Excluir", 5)
885:                 loc_oPg1.cmd_4c_Excluir.Enabled = loc_lNaLista
886:             ENDIF
887:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Buscar", 5)
888:                 loc_oPg1.cmd_4c_Buscar.Enabled = loc_lNaLista
889:             ENDIF
890:         ENDIF
891: 
892:         IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5) AND ;
893:            PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
894: 
895:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
896:             LOCAL loc_lEdicao
897:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
898: 
899:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Salvar", 5)
900:                 loc_oPg2.cmd_4c_Salvar.Enabled = loc_lEdicao
901:             ENDIF
902:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Cancelar", 5)
903:                 loc_oPg2.cmd_4c_Cancelar.Enabled = .T.
904:             ENDIF
905:         ENDIF
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * Destroy - Libera recursos ao fechar o formulario
910:     *--------------------------------------------------------------------------
911:     PROCEDURE Destroy()
912:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
913:             THIS.this_oBusinessObject = .NULL.
914:         ENDIF
915: 
916:         IF USED("cursor_4c_Dados")
917:             USE IN cursor_4c_Dados
918:         ENDIF
919: 
920:         DODEFAULT()
921:     ENDPROC
922: 
923: ENDDEFINE


### BO (C:\4c\projeto\app\classes\emaBO.prg):
*==============================================================================
* EMABO.PRG
* Business Object para Cadastro de Email (SigCdEma)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS emaBO AS BusinessBase

    *-- Propriedades de dados
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cCods     = ""    && Email (C 50)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEma"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar emaBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cCods     = TratarNulo(Cods,      "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os emails (ou filtrados por texto)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar emails:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo email (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma" + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(par_cCodigo), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEma
    * Logica do legado: valida email nao vazio, verifica duplicidade, gera PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de email (logica identica ao legado)
            loc_cSQLDup = "SELECT Cods FROM SigCdEma" + ;
                          " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")

            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("Email J" + CHR(225) + " Cadastrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                *-- Gerar chave primaria (equivalente ao fUniqueIds() do legado)
                THIS.this_cIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdEma (cIdChaves, Cods)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            MsgErro("Chave prim" + CHR(225) + "ria inv" + CHR(225) + "lida para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdEma" + ;
                       " SET Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEma" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


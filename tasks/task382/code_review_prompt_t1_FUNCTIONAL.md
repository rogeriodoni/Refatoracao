# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'GrupoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DGruposLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DGruposLostFocus(par_nKeyCode, par_nShiftAltCtrl)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCRC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1268 linhas total):

*-- Linhas 27 a 148:
27: 
28:     *==========================================================================
29:     * Init - Inicializa o formulario
30:     * FormBase.Init() chama THIS.InicializarForm() automaticamente via DODEFAULT
31:     *==========================================================================
32:     PROCEDURE Init()
33:         LOCAL loc_lSucesso
34:         loc_lSucesso = .F.
35:         TRY
36:             loc_lSucesso = DODEFAULT()
37:         CATCH TO loException
38:             MostrarErro("Erro na inicializa" + CHR(231) + CHR(227) + "o do FormCRC:" + CHR(13) + ;
39:                 loException.Message + CHR(13) + ;
40:                 "Linha: " + TRANSFORM(loException.LineNo), "FormCRC.Init")
41:         ENDTRY
42:         RETURN loc_lSucesso
43:     ENDPROC
44: 
45:     *==========================================================================
46:     * InicializarForm - Configuracao completa chamada pelo FormBase.Init()
47:     *==========================================================================
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             THIS.this_oBusinessObject = CREATEOBJECT("CRCBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar CRCBO - VARTYPE: " + VARTYPE(THIS.this_oBusinessObject), "FormCRC.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 loc_lSucesso = .T.
68:             ENDIF
69: 
70:         CATCH TO loException
71:             MostrarErro("Erro ao inicializar FormCRC:" + CHR(13) + ;
72:                 loException.Message + CHR(13) + ;
73:                 "Linha: " + TRANSFORM(loException.LineNo), "FormCRC.InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *==========================================================================
80:     * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
81:     *==========================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .PageCount = 2
91:             .Tabs      = .F.
92:             .Visible   = .T.
93: 
94:             .Page1.BackColor = RGB(90, 90, 90)
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(90, 90, 90)
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:         ENDWITH
99: 
100:         THIS.ConfigurarPaginaLista()
101:         THIS.ConfigurarPaginaDados()
102:     ENDPROC
103: 
104:     *==========================================================================
105:     * ConfigurarPaginaLista - Estrutura da Page1 (Lista)
106:     * Cabecalho + Botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) + Grid
107:     *==========================================================================
108:     PROTECTED PROCEDURE ConfigurarPaginaLista()
109:         LOCAL loc_oPagina
110:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
111: 
112:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Container cabecalho (titulo do form)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = THIS.Width - 20
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = THIS.Width - 20

*-- Linhas 283 a 405:
283:             .Visible         = .T.
284:         ENDWITH
285: 
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
288:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
289:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
291: 
292:         *-- Container Encerrar (canonico: Left=917, Width=90, cmd Width=75)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
305:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
306:             .Caption         = "Encerrar"
307:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:             .PicturePosition = 13
309:             .Top             = 5
310:             .Left            = 5
311:             .Width           = 75
312:             .Height          = 75
313:             .BackColor       = RGB(255, 255, 255)
314:             .ForeColor       = RGB(90, 90, 90)
315:             .FontName        = "Comic Sans MS"
316:             .FontSize        = 8
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .Themes          = .F.
320:             .SpecialEffect   = 0
321:             .MousePointer    = 15
322:             .WordWrap        = .T.
323:             .AutoSize        = .F.
324:             .Visible         = .T.
325:         ENDWITH
326: 
327:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
328: 
329:         *-- Grid da lista: 3 colunas do original (Grupos=80, Codigos=150, Descrs=290)
330:         *-- ColumnCount FORA do WITH (Problema 36)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
333: 
334:         WITH loc_oPagina.grd_4c_Lista
335:             .Top                = 126
336:             .Left               = 31
337:             .Width              = 937
338:             .Height             = 489
339:             .FontName           = "Verdana"
340:             .FontSize           = 8
341:             .ForeColor          = RGB(90, 90, 90)
342:             .BackColor          = RGB(255, 255, 255)
343:             .GridLineColor      = RGB(238, 238, 238)
344:             .HighlightBackColor = RGB(255, 255, 255)
345:             .HighlightForeColor = RGB(15, 41, 104)
346:             .HighlightStyle     = 2
347:             .DeleteMark         = .F.
348:             .RecordMark         = .F.
349:             .RowHeight          = 16
350:             .ScrollBars         = 2
351:             .GridLines          = 3
352:             .Visible            = .T.
353:         ENDWITH
354: 
355:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
356: 
357:         THIS.TornarControlesVisiveis(loc_oPagina)
358:     ENDPROC
359: 
360:     *==========================================================================
361:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
362:     * cnt_4c_Salva com botoes Confirmar + Cancelar
363:     * Fases 5-6 adicionam: Labels, TextBoxes e CheckBoxes
364:     *==========================================================================
365:     PROTECTED PROCEDURE ConfigurarPaginaDados()
366:         LOCAL loc_oPagina
367:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
368: 
369:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
370:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
371: 
372:         *-- Container botoes acao (Confirmar + Cancelar)
373:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
374:         WITH loc_oPagina.cnt_4c_Salva
375:             .Top         = 33
376:             .Left        = 842
377:             .Width       = 160
378:             .Height      = 85
379:             .BackStyle   = 0
380:             .Visible     = .T.
381:         ENDWITH
382: 
383:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
384:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
385:             .Caption         = "Confirmar"
386:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
387:             .PicturePosition = 13
388:             .Top             = 5
389:             .Left            = 5
390:             .Width           = 75
391:             .Height          = 75
392:             .BackColor       = RGB(255, 255, 255)
393:             .ForeColor       = RGB(90, 90, 90)
394:             .FontName        = "Comic Sans MS"
395:             .FontSize        = 8
396:             .FontBold        = .T.
397:             .FontItalic      = .T.
398:             .Themes          = .F.
399:             .SpecialEffect   = 0
400:             .MousePointer    = 15
401:             .WordWrap        = .T.
402:             .AutoSize        = .F.
403:             .Enabled         = .F.
404:             .Visible         = .T.
405:         ENDWITH

*-- Linhas 427 a 471:
427:             .Visible         = .T.
428:         ENDWITH
429: 
430:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
431:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
432: 
433:         *-- ===== FASE 5: Labels + TextBoxes (Codigos e Descrs) =====
434:         *-- Compensacao PageFrame: Top_original + 29
435: 
436:         *-- Label: Codigo (Say1 original: Top=174, Left=297, ForeColor=90,90,90)
437:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
438:         WITH loc_oPagina.lbl_4c_Label1
439:             .Caption   = "C" + CHR(243) + "digo :"
440:             .Top       = 203
441:             .Left      = 297
442:             .Width     = 44
443:             .Height    = 17
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .FontBold  = .F.
447:             .ForeColor = RGB(90, 90, 90)
448:             .BackStyle = 0
449:             .AutoSize  = .F.
450:             .Alignment = 1
451:             .Visible   = .T.
452:         ENDWITH
453: 
454:         *-- TextBox: Codigos (getCodigos original: Top=171, Left=341, Width=150, MaxLength=20)
455:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
456:         WITH loc_oPagina.txt_4c_Codigos
457:             .Value         = ""
458:             .Top           = 200
459:             .Left          = 341
460:             .Width         = 150
461:             .Height        = 23
462:             .FontName      = "Tahoma"
463:             .FontSize      = 8
464:             .ForeColor     = RGB(0, 0, 0)
465:             .BackColor     = RGB(255, 255, 255)
466:             .BorderColor   = RGB(100, 100, 100)
467:             .SpecialEffect = 1
468:             .MaxLength     = 20
469:             .Format        = "K!"
470:             .Enabled       = .T.
471:             .Visible       = .T.

*-- Linhas 648 a 704:
648:             .Visible       = .T.
649:         ENDWITH
650: 
651:         *-- BINDEVENT lookups: Grupo (F4/LostFocus) e DGrupos (F4/LostFocus)
652:         BINDEVENT(loc_oPagina.txt_4c_Grupo,   "KeyPress",  THIS, "GrupoKeyPress")
653:         BINDEVENT(loc_oPagina.txt_4c_Grupo,   "KeyPress", THIS, "GrupoLostFocus")
654:         BINDEVENT(loc_oPagina.txt_4c_DGrupos, "KeyPress",  THIS, "DGruposKeyPress")
655:         BINDEVENT(loc_oPagina.txt_4c_DGrupos, "KeyPress", THIS, "DGruposLostFocus")
656: 
657:         THIS.TornarControlesVisiveis(loc_oPagina)
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * CarregarLista - Carrega dados no cursor e configura o Grid da Page1
662:     * Grid: 3 colunas - Grupos(80), Codigos(150), Descrs(290)
663:     *==========================================================================
664:     PROCEDURE CarregarLista()
665:         LOCAL loc_lSucesso, loc_oGrid
666:         loc_lSucesso = .F.
667: 
668:         TRY
669:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
670:                 loc_lSucesso = .T.
671:             ELSE
672:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
673:                     IF THIS.this_oBusinessObject.Buscar("")
674:                         *-- Configurar Grid apenas se ja foi adicionado a Page1 (Problema 36)
675:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
676:                             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
677: 
678:                             *-- RecordSource FORA de WITH (Problema 36)
679:                             loc_oGrid.ColumnCount = 3
680:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
681: 
682:                             *-- ControlSources APOS RecordSource (Problema 48)
683:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.grupos"
684:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
685:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
686: 
687:                             loc_oGrid.Column1.Width = 80
688:                             loc_oGrid.Column2.Width = 150
689:                             loc_oGrid.Column3.Width = 290
690: 
691:                             *-- Headers OBRIGATORIO apos RecordSource (Problema 2 / Problema 32)
692:                             loc_oGrid.Column1.Header1.Caption = "Grupo"
693:                             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
694:                             loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
695: 
696:                             THIS.FormatarGridLista(loc_oGrid)
697:                         ENDIF
698:                         loc_lSucesso = .T.
699:                     ENDIF
700:                 ENDIF
701:             ENDIF
702:         CATCH TO loException
703:             MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
704:                 loException.Message + CHR(13) + ;

*-- Linhas 711 a 1268:
711:     *==========================================================================
712:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
713:     *==========================================================================
714:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
715:         LOCAL loc_lSucesso
716:         loc_lSucesso = .F.
717: 
718:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
719:             RETURN .F.
720:         ENDIF
721: 
722:         TRY
723:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
724: 
725:             IF par_nPagina = 1
726:                 THIS.CarregarLista()
727:             ENDIF
728: 
729:             loc_lSucesso = .T.
730:         CATCH TO loException
731:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "FormCRC.AlternarPagina")
732:         ENDTRY
733: 
734:         RETURN loc_lSucesso
735:     ENDPROC
736: 
737:     *==========================================================================
738:     * BtnEncerrarClick - Fecha o formulario
739:     *==========================================================================
740:     PROCEDURE BtnEncerrarClick()
741:         THIS.Release()
742:     ENDPROC
743: 
744:     *==========================================================================
745:     * BtnIncluirClick - Cria novo registro e navega para Page2
746:     *==========================================================================
747:     PROCEDURE BtnIncluirClick()
748:         THIS.this_oBusinessObject.NovoRegistro()
749:         THIS.LimparCampos()
750:         THIS.this_cModoAtual = "INCLUIR"
751:         THIS.HabilitarCampos(.T.)
752:         THIS.AlternarPagina(2)
753:     ENDPROC
754: 
755:     *==========================================================================
756:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
757:     *==========================================================================
758:     PROCEDURE BtnVisualizarClick()
759:         LOCAL loc_cCodigo
760: 
761:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
762:             SELECT cursor_4c_Dados
763:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
764: 
765:             IF !EMPTY(loc_cCodigo)
766:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
767:                     THIS.BOParaForm()
768:                     THIS.this_cModoAtual = "VISUALIZAR"
769:                     THIS.HabilitarCampos(.F.)
770:                     THIS.AlternarPagina(2)
771:                 ENDIF
772:             ENDIF
773:         ELSE
774:             MsgAviso("Nenhum registro selecionado!")
775:         ENDIF
776:     ENDPROC
777: 
778:     *==========================================================================
779:     * BtnAlterarClick - Carrega registro selecionado para edicao
780:     *==========================================================================
781:     PROCEDURE BtnAlterarClick()
782:         LOCAL loc_cCodigo
783: 
784:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
785:             SELECT cursor_4c_Dados
786:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
787: 
788:             IF !EMPTY(loc_cCodigo)
789:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
790:                     THIS.this_oBusinessObject.EditarRegistro()
791:                     THIS.BOParaForm()
792:                     THIS.this_cModoAtual = "ALTERAR"
793:                     THIS.HabilitarCampos(.T.)
794:                     THIS.AlternarPagina(2)
795:                 ENDIF
796:             ENDIF
797:         ELSE
798:             MsgAviso("Nenhum registro selecionado!")
799:         ENDIF
800:     ENDPROC
801: 
802:     *==========================================================================
803:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
804:     *==========================================================================
805:     PROCEDURE BtnExcluirClick()
806:         LOCAL loc_cCodigo, loc_lConfirma
807: 
808:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
809:             SELECT cursor_4c_Dados
810:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
811: 
812:             IF !EMPTY(loc_cCodigo)
813:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da caracteristica '" + ;
814:                     loc_cCodigo + "'?", "Excluir")
815:                 IF loc_lConfirma
816:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
817:                         IF THIS.this_oBusinessObject.Excluir()
818:                             MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
819:                             THIS.CarregarLista()
820:                         ENDIF
821:                     ENDIF
822:                 ENDIF
823:             ENDIF
824:         ELSE
825:             MsgAviso("Nenhum registro selecionado!")
826:         ENDIF
827:     ENDPROC
828: 
829:     *==========================================================================
830:     * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar/localizar registro
831:     *==========================================================================
832:     PROCEDURE BtnBuscarClick()
833:         LOCAL loc_oBusca, loc_cCodigo
834: 
835:         TRY
836:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
837:                 "SigCrRac", "cursor_4c_BuscaCRC", "codigos", "", ;
838:                 "Buscar Caracteristica")
839: 
840:             IF VARTYPE(loc_oBusca) = "O"
841:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
842:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
843:                 loc_oBusca.mAddColuna("grupos",  "", "Grupo")
844:                 loc_oBusca.Show()
845: 
846:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCRC")
847:                     SELECT cursor_4c_BuscaCRC
848:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCRC.codigos)
849:                     IF USED("cursor_4c_Dados")
850:                         SELECT cursor_4c_Dados
851:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
852:                     ENDIF
853:                 ENDIF
854: 
855:                 loc_oBusca.Release()
856:             ENDIF
857:         CATCH TO loException
858:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCRC.BtnBuscarClick")
859:         ENDTRY
860: 
861:         IF USED("cursor_4c_BuscaCRC")
862:             USE IN cursor_4c_BuscaCRC
863:         ENDIF
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * BtnSalvarClick - Transfere dados do Form para o BO e salva
868:     *==========================================================================
869:     PROCEDURE BtnSalvarClick()
870:         THIS.FormParaBO()
871:         IF THIS.this_oBusinessObject.Salvar()
872:             MsgSucesso("Registro salvo com sucesso!")
873:             THIS.this_cModoAtual = "LISTA"
874:             THIS.AlternarPagina(1)
875:         ENDIF
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * BtnCancelarClick - Cancela e retorna para a lista
880:     *==========================================================================
881:     PROCEDURE BtnCancelarClick()
882:         THIS.this_cModoAtual = "LISTA"
883:         THIS.AlternarPagina(1)
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * LimparCampos - Limpa valores de todos os campos da Page2
888:     *==========================================================================
889:     PROTECTED PROCEDURE LimparCampos()
890:         LOCAL loc_oPag2
891:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
892: 
893:         IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
894:             loc_oPag2.txt_4c_Codigos.Value = ""
895:         ENDIF
896:         IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
897:             loc_oPag2.txt_4c_Descrs.Value = ""
898:         ENDIF
899:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
900:             loc_oPag2.txt_4c_Grupo.Value = ""
901:         ENDIF
902:         IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
903:             loc_oPag2.txt_4c_DGrupos.Value = ""
904:         ENDIF
905:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
906:             loc_oPag2.chk_4c_ChkAuto.Value = 0
907:         ENDIF
908:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
909:             loc_oPag2.chk_4c_ChkBloqueios.Value = 0
910:         ENDIF
911:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
912:             loc_oPag2.chk_4c_ChkObrigs.Value = 0
913:         ENDIF
914:         IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
915:             loc_oPag2.chk_4c_Check1.Value = 0
916:         ENDIF
917:     ENDPROC
918: 
919:     *==========================================================================
920:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo atual
921:     *==========================================================================
922:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
923:         LOCAL loc_oPag2, loc_lCodHabilitado
924:         loc_oPag2          = THIS.pgf_4c_Paginas.Page2
925:         loc_lCodHabilitado = (THIS.this_cModoAtual = "INCLUIR")
926: 
927:         IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
928:             loc_oPag2.txt_4c_Codigos.Enabled = loc_lCodHabilitado
929:         ENDIF
930:         IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
931:             loc_oPag2.txt_4c_Descrs.Enabled = par_lHabilitar
932:         ENDIF
933:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
934:             loc_oPag2.txt_4c_Grupo.Enabled = par_lHabilitar
935:         ENDIF
936:         IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
937:             loc_oPag2.txt_4c_DGrupos.Enabled = .F.
938:         ENDIF
939:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
940:             loc_oPag2.chk_4c_ChkAuto.Enabled = par_lHabilitar
941:         ENDIF
942:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
943:             loc_oPag2.chk_4c_ChkBloqueios.Enabled = par_lHabilitar
944:         ENDIF
945:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
946:             loc_oPag2.chk_4c_ChkObrigs.Enabled = par_lHabilitar
947:         ENDIF
948:         IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
949:             loc_oPag2.chk_4c_Check1.Enabled = par_lHabilitar
950:         ENDIF
951:         IF PEMSTATUS(loc_oPag2, "cnt_4c_Salva", 5)
952:             loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
953:             loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
954:         ENDIF
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * BOParaForm - Transfere dados do BO para os campos da Page2
959:     *==========================================================================
960:     PROTECTED PROCEDURE BOParaForm()
961:         LOCAL loc_oPag2
962:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
963: 
964:         IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
965:             loc_oPag2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
966:         ENDIF
967:         IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
968:             loc_oPag2.txt_4c_Descrs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
969:         ENDIF
970:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
971:             loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
972:         ENDIF
973:         IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
974:             loc_oPag2.txt_4c_DGrupos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrupos)
975:         ENDIF
976:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
977:             loc_oPag2.chk_4c_ChkAuto.Value = (THIS.this_oBusinessObject.this_nAutos .Value = IIF(THIS.this_oBusinessObject.this_nAutos = 1, 1, 0))
978:         ENDIF
979:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
980:             loc_oPag2.chk_4c_ChkBloqueios.Value = (THIS.this_oBusinessObject.this_nBloqueios .Value = IIF(THIS.this_oBusinessObject.this_nBloqueios = 1, 1, 0))
981:         ENDIF
982:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
983:             loc_oPag2.chk_4c_ChkObrigs.Value = (THIS.this_oBusinessObject.this_nObrigs .Value = IIF(THIS.this_oBusinessObject.this_nObrigs = 1, 1, 0))
984:         ENDIF
985:         IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
986:             loc_oPag2.chk_4c_Check1.Value = (THIS.this_oBusinessObject.this_nLocks .Value = IIF(THIS.this_oBusinessObject.this_nLocks = 1, 1, 0))
987:         ENDIF
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * FormParaBO - Transfere dados dos campos da Page2 para o BO
992:     *==========================================================================
993:     PROTECTED PROCEDURE FormParaBO()
994:         LOCAL loc_oPag2
995:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
996: 
997:         IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
998:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
999:         ENDIF
1000:         IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
1001:             THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
1002:         ENDIF
1003:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1004:             THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1005:         ENDIF
1006:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
1007:             THIS.this_oBusinessObject.this_nAutos = IIF(loc_oPag2.chk_4c_ChkAuto.Value, 1, 0)
1008:         ENDIF
1009:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
1010:             THIS.this_oBusinessObject.this_nBloqueios = IIF(loc_oPag2.chk_4c_ChkBloqueios.Value, 1, 0)
1011:         ENDIF
1012:         IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
1013:             THIS.this_oBusinessObject.this_nObrigs = IIF(loc_oPag2.chk_4c_ChkObrigs.Value, 1, 0)
1014:         ENDIF
1015:         IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
1016:             THIS.this_oBusinessObject.this_nLocks = IIF(loc_oPag2.chk_4c_Check1.Value, 1, 0)
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * Destroy - Libera recursos ao fechar o formulario
1022:     *==========================================================================
1023:     PROCEDURE Destroy()
1024:         LOCAL loc_oErro
1025:         TRY
1026:             IF USED("cursor_4c_Dados")
1027:                 USE IN cursor_4c_Dados
1028:             ENDIF
1029:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1030:                 THIS.this_oBusinessObject = .NULL.
1031:             ENDIF
1032:         CATCH TO loc_oErro
1033:             MostrarErro("Erro ao destruir FormCRC:" + CHR(13) + loc_oErro.Message, "FormCRC.Destroy")
1034:         ENDTRY
1035:         DODEFAULT()
1036:     ENDPROC
1037: 
1038:     *==========================================================================
1039:     * FormatarGridLista - Formata visual do Grid da lista
1040:     *==========================================================================
1041:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1042:         WITH par_oGrid
1043:             .FontName = "Tahoma"
1044:             .FontSize = 8
1045:         ENDWITH
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     * GrupoKeyPress - F4 abre lookup de SigCdGcr pelo codigo do grupo
1050:     *==========================================================================
1051:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1052:         IF par_nKeyCode = 28
1053:             THIS.AbrirLookupGrupoCodigo()
1054:         ENDIF
1055:     ENDPROC
1056: 
1057:     *==========================================================================
1058:     * GrupoLostFocus - Ao sair do campo Grupo, valida codigo e preenche descricao
1059:     * Reproduz logica de getGrupos.Valid -> fAcessoContab('C', ...)
1060:     *==========================================================================
1061:     PROCEDURE GrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1062:         LOCAL loc_oPag2, loc_cCodigo, loc_cDescricao
1063:         loc_oPag2      = THIS.pgf_4c_Paginas.Page2
1064:         loc_cCodigo    = ""
1065:         loc_cDescricao = ""
1066: 
1067:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1068:             loc_cCodigo = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1069:         ENDIF
1070: 
1071:         IF EMPTY(loc_cCodigo)
1072:             IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1073:                 loc_oPag2.txt_4c_DGrupos.Value   = ""
1074:                 loc_oPag2.txt_4c_DGrupos.Enabled = (THIS.this_cModoAtual # "VISUALIZAR")
1075:             ENDIF
1076:         ELSE
1077:             loc_cDescricao = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
1078:             IF EMPTY(loc_cDescricao)
1079:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!")
1080:                 THIS.AbrirLookupGrupoCodigo()
1081:             ELSE
1082:                 IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1083:                     loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
1084:                     loc_oPag2.txt_4c_DGrupos.Enabled = .F.
1085:                 ENDIF
1086:             ENDIF
1087:         ENDIF
1088:     ENDPROC
1089: 
1090:     *==========================================================================
1091:     * DGruposKeyPress - F4 abre lookup de SigCdGcr pela descricao do grupo
1092:     *==========================================================================
1093:     PROCEDURE DGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1094:         IF par_nKeyCode = 28
1095:             THIS.AbrirLookupGrupoDescrs()
1096:         ENDIF
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * DGruposLostFocus - Ao sair do campo DGrupos, pesquisa grupo por descricao
1101:     * Reproduz logica de getDGrupos.Valid -> fAcessoContab('D', ...)
1102:     *==========================================================================
1103:     PROCEDURE DGruposLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1104:         LOCAL loc_oPag2, loc_cDescricao
1105:         loc_oPag2      = THIS.pgf_4c_Paginas.Page2
1106:         loc_cDescricao = ""
1107: 
1108:         IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1109:             loc_cDescricao = ALLTRIM(loc_oPag2.txt_4c_DGrupos.Value)
1110:         ENDIF
1111: 
1112:         IF !EMPTY(loc_cDescricao)
1113:             THIS.AbrirLookupGrupoDescrs()
1114:         ENDIF
1115:     ENDPROC
1116: 
1117:     *==========================================================================
1118:     * AbrirLookupGrupoCodigo - Abre picker de SigCdGcr por codigo
1119:     * Substitui fAcessoContab(Usuar, 'C', ...) do legado
1120:     *==========================================================================
1121:     PROCEDURE AbrirLookupGrupoCodigo()
1122:         LOCAL loc_oBusca, loc_oPag2, loc_cCodigo, loc_cDescricao
1123:         loc_oPag2      = THIS.pgf_4c_Paginas.Page2
1124:         loc_cCodigo    = ""
1125:         loc_cDescricao = ""
1126: 
1127:         IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1128:             IF !loc_oPag2.txt_4c_Grupo.Enabled
1129:                 RETURN
1130:             ENDIF
1131:             loc_cCodigo = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1132:         ENDIF
1133: 
1134:         TRY
1135:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1136:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, ;
1137:                 "Buscar Grupo de Conta Corrente")
1138: 
1139:             IF VARTYPE(loc_oBusca) = "O"
1140:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1141:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1142:                 loc_oBusca.Show()
1143: 
1144:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1145:                     SELECT cursor_4c_BuscaGcr
1146:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1147:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1148:                     IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1149:                         loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
1150:                     ENDIF
1151:                     IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1152:                         loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
1153:                         loc_oPag2.txt_4c_DGrupos.Enabled = .F.
1154:                     ENDIF
1155:                 ENDIF
1156: 
1157:                 loc_oBusca.Release()
1158:             ENDIF
1159:         CATCH TO loException
1160:             MostrarErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, ;
1161:                 "FormCRC.AbrirLookupGrupoCodigo")
1162:         ENDTRY
1163: 
1164:         IF USED("cursor_4c_BuscaGcr")
1165:             USE IN cursor_4c_BuscaGcr
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * AbrirLookupGrupoDescrs - Abre picker de SigCdGcr pela descricao
1171:     * Substitui fAcessoContab(Usuar, 'D', ...) do legado
1172:     *==========================================================================
1173:     PROCEDURE AbrirLookupGrupoDescrs()
1174:         LOCAL loc_oBusca, loc_oPag2, loc_cDescricao, loc_cCodigo
1175:         loc_oPag2      = THIS.pgf_4c_Paginas.Page2
1176:         loc_cDescricao = ""
1177:         loc_cCodigo    = ""
1178: 
1179:         IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1180:             IF !loc_oPag2.txt_4c_DGrupos.Enabled
1181:                 RETURN
1182:             ENDIF
1183:             loc_cDescricao = ALLTRIM(loc_oPag2.txt_4c_DGrupos.Value)
1184:         ENDIF
1185: 
1186:         TRY
1187:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1188:                 "SigCdGcr", "cursor_4c_BuscaGcr", "descrs", loc_cDescricao, ;
1189:                 "Buscar Grupo de Conta Corrente")
1190: 
1191:             IF VARTYPE(loc_oBusca) = "O"
1192:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1193:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1194:                 loc_oBusca.Show()
1195: 
1196:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1197:                     SELECT cursor_4c_BuscaGcr
1198:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1199:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1200:                     IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1201:                         loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
1202:                     ENDIF
1203:                     IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1204:                         loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
1205:                         loc_oPag2.txt_4c_DGrupos.Enabled = .F.
1206:                     ENDIF
1207:                 ENDIF
1208: 
1209:                 loc_oBusca.Release()
1210:             ENDIF
1211:         CATCH TO loException
1212:             MostrarErro("Erro ao abrir busca de grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
1213:                 CHR(13) + loException.Message, "FormCRC.AbrirLookupGrupoDescrs")
1214:         ENDTRY
1215: 
1216:         IF USED("cursor_4c_BuscaGcr")
1217:             USE IN cursor_4c_BuscaGcr
1218:         ENDIF
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1 conforme
1223:     * disponibilidade de registros no cursor
1224:     *==========================================================================
1225:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1226:         LOCAL loc_lTemRegistro, loc_oCnt
1227:         loc_lTemRegistro = (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
1228:             RECCOUNT("cursor_4c_Dados") > 0)
1229: 
1230:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1231:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1232:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1233:                 loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1234:             ENDIF
1235:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1236:                 loc_oCnt.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1237:             ENDIF
1238:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1239:                 loc_oCnt.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1240:             ENDIF
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1245:         LOCAL loc_nI, loc_oObjeto, loc_nP
1246: 
1247:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1248:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1249: 
1250:             IF VARTYPE(loc_oObjeto) = "O"
1251:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1252:                     loc_oObjeto.Visible = .T.
1253:                 ENDIF
1254: 
1255:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1256:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1257:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1258:                     ENDFOR
1259:                 ENDIF
1260: 
1261:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1262:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1263:                 ENDIF
1264:             ENDIF
1265:         ENDFOR
1266:     ENDPROC
1267: 
1268: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CRCBO.prg):
*==============================================================================
* CRCBO.prg - Business Object: Caracteristicas de Contas (SigCrRac)
*==============================================================================
* Tarefa   : task382 - Migracao de SIGCDCRC
* Tabela   : SigCrRac
* PK       : Codigos  (char 20)
*==============================================================================

DEFINE CLASS CRCBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Campos da tabela SigCrRac
    *-- ----------------------------------------------------------------
    this_cCodigos   = ""    && codigos   char(20)  PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cGrupos    = ""    && grupos    char(10)  FK -> SigCdGcr.Codigos
    this_nAutos     = 0     && autos     numeric(1,0)
    this_nLocks     = 0     && locks     numeric(1,0)
    this_nBloqueios = 0     && bloqueios numeric(1,0)
    this_nObrigs    = 0     && obrigs    numeric(1,0)
    this_nCodobs    = 0     && codobs    numeric(3,0)
    this_dDtInis    = {}    && dtinis    datetime NULL
    this_dDtFins    = {}    && dtfins    datetime NULL
    this_nOrdems    = 0     && ordems    numeric(3,0)
    this_cRelacs    = ""    && relacs    char(30)
    this_nTipoops   = 0     && tipoops   numeric(2,0)
    this_nTpprocs   = 0     && tpprocs   numeric(2,0)

    *-- Campo auxiliar de UI (descricao do grupo - vem de SigCdGcr.Descrs, nao persiste)
    this_cDGrupos   = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCrRac"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
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
                THIS.this_cCodigos   = TratarNulo(codigos,   "C")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nAutos     = TratarNulo(autos,     "N")
                THIS.this_nLocks     = TratarNulo(locks,     "N")
                THIS.this_nBloqueios = TratarNulo(bloqueios, "N")
                THIS.this_nObrigs    = TratarNulo(obrigs,    "N")
                THIS.this_nCodobs    = TratarNulo(codobs,    "N")
                THIS.this_dDtInis    = TratarNulo(dtinis,    "T")
                THIS.this_dDtFins    = TratarNulo(dtfins,    "T")
                THIS.this_nOrdems    = TratarNulo(ordems,    "N")
                THIS.this_cRelacs    = TratarNulo(relacs,    "C")
                THIS.this_nTipoops   = TratarNulo(tipoops,   "N")
                THIS.this_nTpprocs   = TratarNulo(tpprocs,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CRCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        IF EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Codigos (apenas no INSERT)
        IF THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                    " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.qtd > 0
                        MsgAviso("C" + CHR(243) + "digo da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrado!!!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        IF !loc_lValido
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Descrs (INSERT e UPDATE - exceto o proprio registro)
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                " WHERE descrs = " + EscaparSQL(THIS.this_cDescrs)
            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + " AND codigos <> " + EscaparSQL(THIS.this_cCodigos)
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDesc")
                SELECT cursor_4c_ChkDesc
                IF cursor_4c_ChkDesc.qtd > 0
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrada!!!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRac (codigos, descrs, grupos, autos, locks, bloqueios, obrigs, codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    <<EscaparSQL(THIS.this_cRelacs)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CRCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRac
                SET descrs    = <<EscaparSQL(THIS.this_cDescrs)>>,
                    grupos    = <<EscaparSQL(THIS.this_cGrupos)>>,
                    autos     = <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    locks     = <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    bloqueios = <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    obrigs    = <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    codobs    = <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    dtinis    = <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    dtfins    = <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    ordems    = <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    relacs    = <<EscaparSQL(THIS.this_cRelacs)>>,
                    tipoops   = <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    tpprocs   = <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CRCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRac
    * Verifica uso em SigClCrc antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se a caracteristica esta sendo utilizada em SigClCrc
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClCrc" + ;
                " WHERE Caracteris = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCrc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCrc")
                SELECT cursor_4c_ChkCrc
                loc_nUso = cursor_4c_ChkCrc.qtd
                USE IN cursor_4c_ChkCrc
                IF loc_nUso > 0
                    MsgAviso("Caracter" + CHR(237) + "stica Sendo Utilizada!!!")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCrRac WHERE codigos = " + ;
                        EscaparSQL(THIS.this_cCodigos)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CRCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid da Page1
    * Grid original: Grupos(80), Codigos(150), Descrs(290)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), codigos C(20), descrs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, codigos, descrs FROM SigCrRac"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CRCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, grupos, autos, locks, bloqueios, obrigs," + ;
                " codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs" + ;
                " FROM SigCrRac WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracteristica n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CRCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Busca descricao de grupo em SigCdGcr pelo codigo
    * Substitui fAcessoContab(Usuar, 'C', ...) do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGrp")
                    IF !EOF("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, "CRCBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE


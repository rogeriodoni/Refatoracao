# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [BINDEVENT-PARAMS] Handler 'ValidarCOrdems' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCOrdems(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCobs' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCobs(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTPE.Pagina.Lista): Top original=104 vs migrado 'lbl_4c_Label1' Top=138 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTPE.Pagina.Lista): Left original=42 vs migrado 'lbl_4c_Label1' Left=184 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTPE.Pagina.Lista): Top original=104 vs migrado 'lbl_4c_Label2' Top=162 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTPE.Pagina.Lista): Left original=369 vs migrado 'lbl_4c_Label2' Left=158 (diff=211px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTpe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1305 linhas total):

*-- Linhas 18 a 175:
18: *   Ordem/EtiquetasEspeciais/Observacao (cobs/dobs) + lookup fwBuscaExt->SigCdObs
19: *   (ValidarCobs/AbrirLookupObs/CobsKeyPress) + validacao ValidarCOrdems.
20: * FASE 7/8 - Form - Eventos Principais:
21: *   BINDEVENT dos 4 botoes CRUD de cnt_4c_Botoes + BtnIncluirClick/
22: *   BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick (PUBLIC - CLAUDE.md #3) +
23: *   FormParaBO/BOParaForm/HabilitarCampos/LimparCampos como suporte completo
24: *   (nenhum metodo chamado fica sem implementacao - regra de completude).
25: * FASE 8/8 - Form - Eventos Auxiliares e Consolidacao Final:
26: *   BtnBuscarClick (FormBuscaAuxiliar sobre a propria SigCdTpe + LOCATE no
27: *   grid) + BtnEncerrarClick (THIS.Release()) + BtnSalvarClick (FormParaBO +
28: *   Salvar sem parametro) + BtnCancelarClick (volta para Lista) +
29: *   AjustarBotoesPorModo (Confirmar so habilitado em INCLUIR/ALTERAR) +
30: *   BINDEVENT dos botoes Buscar/Encerrar/Confirmar/Cancelar.
31: *==============================================================================
32: 
33: DEFINE CLASS FormTpe AS FormBase
34: 
35:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
36:     Height      = 600
37:     Width       = 1000
38:     Caption     = "Tipos de Etiquetas de Produto"
39:     AutoCenter  = .T.
40:     ShowWindow  = 1
41:     WindowType  = 1
42:     ControlBox  = .F.
43:     TitleBar    = 0
44:     Themes      = .F.
45:     BorderStyle = 2
46: 
47:     *-- Propriedades de estado
48:     this_oBusinessObject     = .NULL.
49:     this_cModoAtual          = "LISTA"
50:     this_nUltimoCobsValidado = 0
51: 
52:     *===========================================================================
53:     * Init - Inicializa o formulario
54:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
55:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
56:     *===========================================================================
57:     PROCEDURE Init()
58:         RETURN DODEFAULT()
59:     ENDPROC
60: 
61:     *===========================================================================
62:     * InicializarForm - Configura estrutura completa
63:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
64:     *===========================================================================
65:     PROTECTED PROCEDURE InicializarForm()
66:         LOCAL loc_lSucesso
67:         loc_lSucesso = .F.
68: 
69:         TRY
70:             THIS.this_oBusinessObject = CREATEOBJECT("TpeBO")
71: 
72:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
73:                 MostrarErro("Erro ao criar TpeBO" + CHR(13) + ;
74:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
75:                     "FormTpe.InicializarForm")
76:             ELSE
77:                 THIS.ConfigurarPageFrame()
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82:                 THIS.pgf_4c_Paginas.Visible = .T.
83:                 THIS.pgf_4c_Paginas.ActivePage = 1
84:                 THIS.this_cModoAtual = "LISTA"
85:                 THIS.CarregarLista()
86: 
87:                 loc_lSucesso = .T.
88:             ENDIF
89: 
90:         CATCH TO loException
91:             MostrarErro("Erro ao inicializar FormTpe:" + CHR(13) + ;
92:                 loException.Message + CHR(13) + ;
93:                 "Linha: " + TRANSFORM(loException.LineNo), ;
94:                 "FormTpe.InicializarForm")
95:         ENDTRY
96: 
97:         RETURN loc_lSucesso
98:     ENDPROC
99: 
100:     *===========================================================================
101:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
102:     * Top=-29 para esconder abas; controles compensam +29 no Top
103:     *===========================================================================
104:     PROTECTED PROCEDURE ConfigurarPageFrame()
105:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106: 
107:         WITH THIS.pgf_4c_Paginas
108:             .PageCount = 2
109:             .Top       = -29
110:             .Left      = 0
111:             .Width     = THIS.Width
112:             .Height    = THIS.Height + 29
113:             .Tabs      = .F.
114:             .Visible   = .T.
115: 
116:             .Page1.Caption   = "Lista"
117:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:             .Page1.BackColor = RGB(255, 255, 255)
119: 
120:             .Page2.Caption   = "Dados"
121:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122:             .Page2.BackColor = RGB(255, 255, 255)
123:         ENDWITH
124: 
125:         THIS.ConfigurarPaginaLista()
126:         THIS.ConfigurarPaginaDados()
127:     ENDPROC
128: 
129:     *===========================================================================
130:     * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
131:     * Cabecalho (regra #11) + cnt_4c_Botoes (5 botoes CRUD) + cnt_4c_Saida
132:     * (cmd_4c_Encerrar canonico) + grd_4c_Lista (4 colunas). BINDEVENT dos
133:     * botoes fica para Fase 7-8, quando os metodos Btn*Click existirem.
134:     *===========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaLista()
136:         LOCAL loc_oPagina
137:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
138: 
139:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140: 
141:         *-- Container Cabecalho (cntSombra no legado)
142:         *-- Original: Top=2 (default da classe). Com compensacao +29: Top=31
143:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH loc_oPagina.cnt_4c_Cabecalho
145:             .Top         = 31
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
156:             .Caption   = THIS.Caption
157:             .Top       = 15
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 40
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(0, 0, 0)
165:             .BackStyle = 0
166:             .AutoSize  = .F.
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
171:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
172:             .Caption   = THIS.Caption
173:             .Top       = 18
174:             .Left      = 10
175:             .Width     = 769

*-- Linhas 316 a 451:
316:             .Visible         = .T.
317:         ENDWITH
318: 
319:         *-- BINDEVENT dos 5 botoes CRUD principais + Encerrar
320:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
325: 
326:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
327:         *-- Legado: Grupo_Saida.Left=719, Top=-1 / Sair.Caption default. Canonico: Left=917, Width=90
328:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
329:         WITH loc_oPagina.cnt_4c_Saida
330:             .Top         = 29
331:             .Left        = 917
332:             .Width       = 90
333:             .Height      = 85
334:             .BackStyle   = 0
335:             .BorderWidth = 0
336:             .Visible     = .T.
337:         ENDWITH
338: 
339:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
340:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
341:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
342:             .Caption         = "Encerrar"
343:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
344:             .PicturePosition = 13
345:             .Top             = 5
346:             .Left            = 5
347:             .Width           = 75
348:             .Height          = 75
349:             .FontName        = "Tahoma"
350:             .FontBold        = .T.
351:             .FontItalic      = .T.
352:             .FontSize        = 8
353:             .ForeColor       = RGB(90, 90, 90)
354:             .BackColor       = RGB(255, 255, 255)
355:             .Themes          = .F.
356:             .SpecialEffect   = 0
357:             .MousePointer    = 15
358:             .WordWrap        = .T.
359:             .AutoSize        = .F.
360:             .Visible         = .T.
361:         ENDWITH
362: 
363:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
364: 
365:         *-- Grid de listagem (Grade no legado)
366:         *-- Legado: pColuna(ntipos,Tipo,50) + pColuna(cetiquetas,Descricao,280) +
367:         *--         pColuna(nsituas,Situacao,50) + pColuna(cordems,Ordem,50)
368:         *-- Posicao canonica (framework_frmcadastro_layout.md): Top=117, Left=26, Width=890
369:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
370:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
371:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
372:         WITH loc_oPagina.grd_4c_Lista
373:             .Top                = 117
374:             .Left               = 26
375:             .Width              = 890
376:             .Height             = 498
377:             .FontName           = "Verdana"
378:             .FontSize           = 8
379:             .ForeColor          = RGB(90, 90, 90)
380:             .BackColor          = RGB(255, 255, 255)
381:             .GridLineColor      = RGB(238, 238, 238)
382:             .GridLines          = 3
383:             .HighlightBackColor = RGB(255, 255, 255)
384:             .HighlightForeColor = RGB(15, 41, 104)
385:             .HighlightStyle     = 2
386:             .DeleteMark         = .F.
387:             .RecordMark         = .F.
388:             .RowHeight          = 16
389:             .ScrollBars         = 2
390:             .ReadOnly           = .T.
391:             .Visible            = .T.
392:         ENDWITH
393: 
394:         loc_oPagina.grd_4c_Lista.Column1.Width = 60
395:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "Tipo"
396:         loc_oPagina.grd_4c_Lista.Column2.Width = 550
397:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
398:         loc_oPagina.grd_4c_Lista.Column3.Width = 130
399:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
400:         loc_oPagina.grd_4c_Lista.Column4.Width = 100
401:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Ordem"
402: 
403:         THIS.TornarControlesVisiveis(loc_oPagina)
404:     ENDPROC
405: 
406:     *===========================================================================
407:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
408:     * Cabecalho completo (regra #11 - faixa nas duas paginas) + container de
409:     * botoes de acao ainda VAZIO (Confirmar/Cancelar entram em fase posterior).
410:     *===========================================================================
411:     PROTECTED PROCEDURE ConfigurarPaginaDados()
412:         LOCAL loc_oPagina
413:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
414: 
415:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
416: 
417:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
418:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
419:         WITH loc_oPagina.cnt_4c_Cabecalho
420:             .Top           = 29
421:             .Left          = 0
422:             .Width         = THIS.Width
423:             .Height        = 80
424:             .BackColor     = RGB(100, 100, 100)
425:             .BorderWidth   = 0
426:             .SpecialEffect = 0
427:             .Visible       = .T.
428: 
429:             .AddObject("lbl_4c_Sombra", "Label")
430:             WITH .lbl_4c_Sombra
431:                 .Caption   = THIS.Caption
432:                 .Top       = 15
433:                 .Left      = 10
434:                 .Width     = THIS.Width
435:                 .Height    = 40
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 16
438:                 .FontBold  = .T.
439:                 .ForeColor = RGB(0, 0, 0)
440:                 .BackStyle = 0
441:                 .AutoSize  = .F.
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             .AddObject("lbl_4c_Titulo", "Label")
446:             WITH .lbl_4c_Titulo
447:                 .Caption   = THIS.Caption
448:                 .Top       = 18
449:                 .Left      = 10
450:                 .Width     = THIS.Width
451:                 .Height    = 46

*-- Linhas 553 a 599:
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *-- OptionGroup "Situacao" (Opt_nSituas legado: nsituas numeric(1,0),
557:         *-- ControlSource=crSigCdTpe.nSituas, Left=220, Top=156, Width=140, Height=20
558:         *-- Option1="Ativa" Value=0, Option2="Inativa" Value=1 - transcrito literal)
559:         loc_oPagina.AddObject("obj_4c_Opt_nSituas", "OptionGroup")
560:         WITH loc_oPagina.obj_4c_Opt_nSituas
561:             .ButtonCount   = 2
562:             .Left          = 220
563:             .Top           = 185
564:             .Width         = 140
565:             .Height        = 20
566:             .BackStyle     = 0
567:             .BorderStyle   = 0
568:             .SpecialEffect = 0
569:             .Value         = 0
570:             .Visible       = .T.
571:         ENDWITH
572: 
573:         WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(1)
574:             .Caption   = "\<Ativa"
575:             .Value     = 0
576:             .Left      = 5
577:             .Top       = 2
578:             .AutoSize  = .T.
579:             .BackStyle = 0
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(0, 0, 0)
583:         ENDWITH
584: 
585:         WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(2)
586:             .Caption   = "I\<nativa"
587:             .Value     = 1
588:             .Left      = 75
589:             .Top       = 2
590:             .AutoSize  = .T.
591:             .BackStyle = 0
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .ForeColor = RGB(0, 0, 0)
595:         ENDWITH
596: 
597:         *-- Label "Ordem :" (Say3 legado: Left=172, Top=182, ForeColor=0,0,0)
598:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
599:         WITH loc_oPagina.lbl_4c_Label3

*-- Linhas 713 a 764:
713:             .Visible     = .T.
714:         ENDWITH
715: 
716:         *-- BINDEVENT: Ordem - Valid legado: This.Value = PadL(AllTrim(This.Value), 3)
717:         BINDEVENT(loc_oPagina.txt_4c_COrdems, "KeyPress", THIS, "ValidarCOrdems")
718: 
719:         *-- BINDEVENT: Observacao - Valid legado abre fwBuscaExt automaticamente
720:         *-- ao sair do campo preenchido (nao ha F4 no legado, mas DblClick e F4
721:         *-- sao acrescentados como atalho adicional para o mesmo lookup).
722:         BINDEVENT(loc_oPagina.txt_4c_Cobs, "KeyPress", THIS, "ValidarCobs")
723:         BINDEVENT(loc_oPagina.txt_4c_Cobs, "KeyPress", THIS, "CobsKeyPress")
724:         BINDEVENT(loc_oPagina.txt_4c_Cobs, "DblClick", THIS, "AbrirLookupObs")
725: 
726:         *-- Container BotoesAcao - Confirmar/Cancelar (padrao canonico)
727:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
728:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
729:             .Caption         = "Confirmar"
730:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
731:             .PicturePosition = 13
732:             .Top             = 5
733:             .Left            = 5
734:             .Width           = 75
735:             .Height          = 75
736:             .FontName        = "Tahoma"
737:             .FontBold        = .T.
738:             .FontItalic      = .T.
739:             .FontSize        = 8
740:             .ForeColor       = RGB(90, 90, 90)
741:             .BackColor       = RGB(255, 255, 255)
742:             .Themes          = .F.
743:             .SpecialEffect   = 0
744:             .MousePointer    = 15
745:             .WordWrap        = .T.
746:             .AutoSize        = .F.
747:             .Visible         = .T.
748:         ENDWITH
749: 
750:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
751:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
752:             .Caption         = "Encerrar"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
754:             .PicturePosition = 13
755:             .Top             = 5
756:             .Left            = 80
757:             .Width           = 75
758:             .Height          = 75
759:             .FontName        = "Tahoma"
760:             .FontBold        = .T.
761:             .FontItalic      = .T.
762:             .FontSize        = 8
763:             .ForeColor       = RGB(90, 90, 90)
764:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 770 a 1216:
770:             .Visible         = .T.
771:         ENDWITH
772: 
773:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
774:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
775: 
776:         THIS.TornarControlesVisiveis(loc_oPagina)
777:     ENDPROC
778: 
779:     *===========================================================================
780:     * ValidarCOrdems - LostFocus de txt_4c_COrdems
781:     * Transcrito do legado (Get_cOrdems.Valid): This.Value = PadL(AllTrim(This.Value), 3)
782:     *===========================================================================
783:     PROCEDURE ValidarCOrdems()
784:         LOCAL loc_oTxt
785:         loc_oTxt = THIS.pgf_4c_Paginas.Page2.txt_4c_COrdems
786: 
787:         IF !EMPTY(ALLTRIM(loc_oTxt.Value))
788:             loc_oTxt.Value = PADL(ALLTRIM(loc_oTxt.Value), 3)
789:         ENDIF
790:     ENDPROC
791: 
792:     *===========================================================================
793:     * CobsKeyPress - KeyPress de txt_4c_Cobs (F4 abre o lookup manualmente)
794:     * BINDEVENT exige LPARAMETERS com os parametros do evento (CLAUDE.md #3).
795:     *===========================================================================
796:     PROCEDURE CobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
797:         IF par_nKeyCode = 28
798:             THIS.AbrirLookupObs()
799:         ENDIF
800:     ENDPROC
801: 
802:     *===========================================================================
803:     * ValidarCobs - LostFocus de txt_4c_Cobs
804:     * Transcrito do legado (cobs.Valid): se o valor mudou e nao esta vazio,
805:     * abre fwBuscaExt (aqui: FormBuscaAuxiliar Modo 1) automaticamente.
806:     * Guarda contra reabertura em toda perda de foco sem mudanca (Problema 45).
807:     *===========================================================================
808:     PROCEDURE ValidarCobs()
809:         LOCAL loc_oPagina, loc_nValor
810: 
811:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
812:         loc_nValor  = loc_oPagina.txt_4c_Cobs.Value
813: 
814:         IF loc_nValor == THIS.this_nUltimoCobsValidado
815:             RETURN
816:         ENDIF
817:         THIS.this_nUltimoCobsValidado = loc_nValor
818: 
819:         IF loc_nValor = 0
820:             loc_oPagina.txt_4c_Dobs.Value = ""
821:         ELSE
822:             THIS.AbrirLookupObs()
823:         ENDIF
824:     ENDPROC
825: 
826:     *===========================================================================
827:     * AbrirLookupObs - Lookup completo de Observacao (SigCdObs.codigos/descrs)
828:     * Transcrito do legado (cobs.Valid):
829:     *   xBrox = CreateObject('fwBuscaExt', poDataMgr.pnIdConn, 'SigCdObs',
830:     *       'crListaRemota', 'codigos', This.Value, 'Observacao', .T.)
831:     *   Se nao achou exato -> mostra grid; senao preenche direto.
832:     *   Se ESC (LastKey=27) -> limpa ambos os campos.
833:     *===========================================================================
834:     PROCEDURE AbrirLookupObs()
835:         LOCAL loc_oPagina, loc_oBusca, loc_nCodigo
836: 
837:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
838:         loc_nCodigo = loc_oPagina.txt_4c_Cobs.Value
839: 
840:         IF loc_nCodigo = 0
841:             loc_oPagina.txt_4c_Dobs.Value = ""
842:             RETURN
843:         ENDIF
844: 
845:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
846:             "SigCdObs", "cursor_4c_BuscaObs", "codigos", ;
847:             TRANSFORM(loc_nCodigo), "Observa" + CHR(231) + CHR(227) + "o")
848: 
849:         IF VARTYPE(loc_oBusca) = "O"
850:             IF !loc_oBusca.this_lAchouRegistro
851:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
852:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
853:                 loc_oBusca.Show()
854:             ENDIF
855: 
856:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
857:                 loc_oPagina.txt_4c_Cobs.Value = cursor_4c_BuscaObs.codigos
858:                 loc_oPagina.txt_4c_Dobs.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaObs.descrs, "C"))
859:             ELSE
860:                 loc_oPagina.txt_4c_Cobs.Value = 0
861:                 loc_oPagina.txt_4c_Dobs.Value = ""
862:             ENDIF
863: 
864:             THIS.this_nUltimoCobsValidado = loc_oPagina.txt_4c_Cobs.Value
865: 
866:             loc_oBusca.Release()
867:         ENDIF
868: 
869:         IF USED("cursor_4c_BuscaObs")
870:             USE IN cursor_4c_BuscaObs
871:         ENDIF
872:     ENDPROC
873: 
874:     *===========================================================================
875:     * LimparCampos - Restaura Page2 para os valores padrao de um novo registro
876:     * Transcrito do legado (padrao do Framework): nsituas=0 (Ativa), tpespes=
877:     * NENHUMA (ListIndex=1), demais campos vazios/zerados.
878:     *===========================================================================
879:     PROTECTED PROCEDURE LimparCampos()
880:         LOCAL loc_oPagina
881:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
882: 
883:         loc_oPagina.txt_4c_NTipos.Value        = 0
884:         loc_oPagina.txt_4c_CEtiquetas.Value    = ""
885:         loc_oPagina.obj_4c_Opt_nSituas.Value   = 0
886:         loc_oPagina.txt_4c_COrdems.Value       = ""
887:         loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1
888:         loc_oPagina.txt_4c_Cobs.Value          = 0
889:         loc_oPagina.txt_4c_Dobs.Value          = ""
890: 
891:         THIS.this_nUltimoCobsValidado = 0
892:     ENDPROC
893: 
894:     *===========================================================================
895:     * FormParaBO - Transfere valores de Page2 para as propriedades this_* do BO
896:     * Chamado antes de THIS.this_oBusinessObject.Salvar() (Fase 8).
897:     *===========================================================================
898:     PROTECTED PROCEDURE FormParaBO()
899:         LOCAL loc_oPagina
900:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
901: 
902:         THIS.this_oBusinessObject.this_nTipos     = loc_oPagina.txt_4c_NTipos.Value
903:         THIS.this_oBusinessObject.this_cEtiquetas = ALLTRIM(loc_oPagina.txt_4c_CEtiquetas.Value)
904:         THIS.this_oBusinessObject.this_nSituas    = loc_oPagina.obj_4c_Opt_nSituas.Value
905:         THIS.this_oBusinessObject.this_cOrdems    = ALLTRIM(loc_oPagina.txt_4c_COrdems.Value)
906:         THIS.this_oBusinessObject.this_nTpEspes   = loc_oPagina.cbo_4c_Cmbetqesp.ListIndex
907:         THIS.this_oBusinessObject.this_nCodObs    = loc_oPagina.txt_4c_Cobs.Value
908:         THIS.this_oBusinessObject.this_nPadrao    = 0
909:     ENDPROC
910: 
911:     *===========================================================================
912:     * BOParaForm - Transfere as propriedades this_* do BO para os campos Page2
913:     * Chamado apos CarregarPorCodigo() (BtnAlterarClick/BtnVisualizarClick).
914:     *===========================================================================
915:     PROTECTED PROCEDURE BOParaForm()
916:         LOCAL loc_oPagina
917:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
918: 
919:         loc_oPagina.txt_4c_NTipos.Value      = THIS.this_oBusinessObject.this_nTipos
920:         loc_oPagina.txt_4c_CEtiquetas.Value  = THIS.this_oBusinessObject.this_cEtiquetas
921:         loc_oPagina.obj_4c_Opt_nSituas.Value = THIS.this_oBusinessObject.this_nSituas
922:         loc_oPagina.txt_4c_COrdems.Value     = THIS.this_oBusinessObject.this_cOrdems
923: 
924:         IF THIS.this_oBusinessObject.this_nTpEspes >= 1 AND THIS.this_oBusinessObject.this_nTpEspes <= 2
925:             loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = THIS.this_oBusinessObject.this_nTpEspes
926:         ELSE
927:             loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1
928:         ENDIF
929: 
930:         loc_oPagina.txt_4c_Cobs.Value = THIS.this_oBusinessObject.this_nCodObs
931:         THIS.this_nUltimoCobsValidado = THIS.this_oBusinessObject.this_nCodObs
932: 
933:         IF THIS.this_oBusinessObject.this_nCodObs > 0
934:             loc_oPagina.txt_4c_Dobs.Value = THIS.this_oBusinessObject.BuscarDescricaoObs(THIS.this_oBusinessObject.this_nCodObs)
935:         ELSE
936:             loc_oPagina.txt_4c_Dobs.Value = ""
937:         ENDIF
938:     ENDPROC
939: 
940:     *===========================================================================
941:     * HabilitarCampos - Habilita/desabilita os campos de Page2 conforme o modo
942:     * Transcrito do legado: Get_nTipos.When = InList(pcEscolha,'INSERIR','PROCURAR')
943:     * (Tipo so editavel na INCLUSAO); Get_cEtiquetas.When = InList('INSERIR',
944:     * 'ALTERAR') (demais campos editaveis em INCLUIR/ALTERAR, bloqueados em
945:     * VISUALIZAR). cmd_4c_Confirmar acompanha o mesmo flag (nunca habilitado
946:     * em modo VISUALIZAR).
947:     *===========================================================================
948:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
949:         LOCAL loc_oPagina, loc_lHabilitarCodigo
950: 
951:         loc_oPagina          = THIS.pgf_4c_Paginas.Page2
952:         loc_lHabilitarCodigo = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"
953: 
954:         loc_oPagina.txt_4c_NTipos.Enabled      = loc_lHabilitarCodigo
955:         loc_oPagina.txt_4c_CEtiquetas.Enabled  = par_lHabilitar
956:         loc_oPagina.obj_4c_Opt_nSituas.Enabled = par_lHabilitar
957:         loc_oPagina.txt_4c_COrdems.Enabled     = par_lHabilitar
958:         loc_oPagina.cbo_4c_Cmbetqesp.Enabled   = par_lHabilitar
959:         loc_oPagina.txt_4c_Cobs.Enabled        = par_lHabilitar
960:         loc_oPagina.txt_4c_Dobs.Enabled        = .F.
961: 
962:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
963:     ENDPROC
964: 
965:     *===========================================================================
966:     * BtnIncluirClick - Botao Incluir (Page1)
967:     * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama direto de fora
968:     * da classe. Transcrito do legado (Grupo_op.Inserir -> pcEscolha='INSERIR'):
969:     * limpa campos, habilita edicao total e navega para Page2.
970:     *===========================================================================
971:     PROCEDURE BtnIncluirClick()
972:         THIS.this_oBusinessObject.NovoRegistro()
973:         THIS.LimparCampos()
974:         THIS.this_cModoAtual = "INCLUIR"
975:         THIS.HabilitarCampos(.T.)
976:         THIS.AjustarBotoesPorModo()
977:         THIS.AlternarPagina(2)
978:         THIS.pgf_4c_Paginas.Page2.txt_4c_NTipos.SetFocus()
979:     ENDPROC
980: 
981:     *===========================================================================
982:     * BtnAlterarClick - Botao Alterar (Page1)
983:     * PUBLIC (CLAUDE.md regra #3). Le o registro selecionado no grid,
984:     * carrega do banco (CarregarPorCodigo), prepara o BO para UPDATE
985:     * (EditarRegistro) e navega para Page2 com os campos preenchidos.
986:     *===========================================================================
987:     PROCEDURE BtnAlterarClick()
988:         LOCAL loc_nCodigo
989: 
990:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
991:             MsgAviso("Selecione um registro para alterar.")
992:         ELSE
993:             loc_nCodigo = cursor_4c_Dados.ntipos
994: 
995:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
996:                 THIS.this_oBusinessObject.EditarRegistro()
997:                 THIS.this_cModoAtual = "ALTERAR"
998:                 THIS.BOParaForm()
999:                 THIS.HabilitarCampos(.T.)
1000:                 THIS.AjustarBotoesPorModo()
1001:                 THIS.AlternarPagina(2)
1002:             ENDIF
1003:         ENDIF
1004:     ENDPROC
1005: 
1006:     *===========================================================================
1007:     * BtnVisualizarClick - Botao Visualizar (Page1)
1008:     * PUBLIC (CLAUDE.md regra #3). Transcrito do legado (Grupo_op.Consultar ->
1009:     * pcEscolha='CONSULTAR'): carrega o registro, mostra Page2 somente leitura.
1010:     *===========================================================================
1011:     PROCEDURE BtnVisualizarClick()
1012:         LOCAL loc_nCodigo
1013: 
1014:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1015:             MsgAviso("Selecione um registro para visualizar.")
1016:         ELSE
1017:             loc_nCodigo = cursor_4c_Dados.ntipos
1018: 
1019:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1020:                 THIS.this_cModoAtual = "VISUALIZAR"
1021:                 THIS.BOParaForm()
1022:                 THIS.HabilitarCampos(.F.)
1023:                 THIS.AjustarBotoesPorModo()
1024:                 THIS.AlternarPagina(2)
1025:             ENDIF
1026:         ENDIF
1027:     ENDPROC
1028: 
1029:     *===========================================================================
1030:     * BtnExcluirClick - Botao Excluir (Page1)
1031:     * PUBLIC (CLAUDE.md regra #3). Confirma com o usuario (MsgConfirma retorna
1032:     * LOGICAL - regra #7), carrega o registro selecionado e delega a exclusao
1033:     * ao BO (Excluir() PUBLIC, chama ExecutarExclusao() internamente - regra
1034:     * do BusinessBase). Falha de gravacao ja eh reportada pelo BO (regra #20);
1035:     * o ELSE aqui so cobre o caso de this_lErroExibido = .F.
1036:     *===========================================================================
1037:     PROCEDURE BtnExcluirClick()
1038:         LOCAL loc_nCodigo, loc_cEtiqueta
1039: 
1040:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1041:             MsgAviso("Selecione um registro para excluir.")
1042:         ELSE
1043:             loc_nCodigo   = cursor_4c_Dados.ntipos
1044:             loc_cEtiqueta = ALLTRIM(TratarNulo(cursor_4c_Dados.cetiquetas, "C"))
1045: 
1046:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Etiqueta " + ;
1047:                     ALLTRIM(TRANSFORM(loc_nCodigo)) + " - " + loc_cEtiqueta + "?", "Excluir")
1048: 
1049:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1050:                     IF THIS.this_oBusinessObject.Excluir()
1051:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1052:                         THIS.CarregarLista()
1053:                     ELSE
1054:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1055:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
1056:                         ENDIF
1057:                     ENDIF
1058:                 ENDIF
1059:             ENDIF
1060:         ENDIF
1061:     ENDPROC
1062: 
1063:     *===========================================================================
1064:     * BtnBuscarClick - Botao Buscar (Page1)
1065:     * PUBLIC (CLAUDE.md regra #3). Abre FormBuscaAuxiliar sobre a propria
1066:     * tabela SigCdTpe (chave ntipos) e localiza o registro escolhido no grid.
1067:     *===========================================================================
1068:     PROCEDURE BtnBuscarClick()
1069:         LOCAL loc_oBusca, loc_nCodigo
1070:         loc_nCodigo = 0
1071: 
1072:         TRY
1073:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1074:                 "SigCdTpe", "cursor_4c_BuscaTpe", "ntipos", "", ;
1075:                 "Buscar Tipo de Etiqueta")
1076: 
1077:             IF VARTYPE(loc_oBusca) = "O"
1078:                 loc_oBusca.mAddColuna("ntipos", "", "Tipo")
1079:                 loc_oBusca.mAddColuna("cetiquetas", "", "Descri" + CHR(231) + CHR(227) + "o")
1080:                 loc_oBusca.Show()
1081: 
1082:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpe")
1083:                     SELECT cursor_4c_BuscaTpe
1084:                     loc_nCodigo = cursor_4c_BuscaTpe.ntipos
1085:                 ENDIF
1086: 
1087:                 loc_oBusca.Release()
1088:             ENDIF
1089: 
1090:             IF USED("cursor_4c_BuscaTpe")
1091:                 USE IN cursor_4c_BuscaTpe
1092:             ENDIF
1093: 
1094:             IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
1095:                 SELECT cursor_4c_Dados
1096:                 LOCATE FOR ntipos = loc_nCodigo
1097:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1098:             ENDIF
1099: 
1100:         CATCH TO loException
1101:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTpe.BtnBuscarClick")
1102:             IF USED("cursor_4c_BuscaTpe")
1103:                 USE IN cursor_4c_BuscaTpe
1104:             ENDIF
1105:         ENDTRY
1106:     ENDPROC
1107: 
1108:     *===========================================================================
1109:     * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
1110:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3 / Problema 17)
1111:     *===========================================================================
1112:     PROCEDURE BtnEncerrarClick()
1113:         THIS.Release()
1114:     ENDPROC
1115: 
1116:     *===========================================================================
1117:     * BtnSalvarClick - Confirma a gravacao de Page2 (Incluir/Alterar)
1118:     * PUBLIC: BINDEVENT requer metodo publico. Salvar() SEM parametro - o BO
1119:     * decide INSERT/UPDATE por this_lNovoRegistro (regra #4 do guia).
1120:     * Falha de gravacao ja e reportada pelo BusinessBase (regra #20 CLAUDE.md).
1121:     *===========================================================================
1122:     PROCEDURE BtnSalvarClick()
1123:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1124:             RETURN
1125:         ENDIF
1126: 
1127:         THIS.FormParaBO()
1128: 
1129:         IF THIS.this_oBusinessObject.Salvar()
1130:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
1131:             THIS.AlternarPagina(1)
1132:         ELSE
1133:             IF !THIS.this_oBusinessObject.this_lErroExibido
1134:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1135:             ENDIF
1136:         ENDIF
1137:     ENDPROC
1138: 
1139:     *===========================================================================
1140:     * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
1141:     * PUBLIC: BINDEVENT requer metodo publico.
1142:     *===========================================================================
1143:     PROCEDURE BtnCancelarClick()
1144:         THIS.AlternarPagina(1)
1145:         THIS.this_cModoAtual = "LISTA"
1146:         THIS.CarregarLista()
1147:     ENDPROC
1148: 
1149:     *===========================================================================
1150:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
1151:     * Confirmar so fica habilitado em INCLUIR/ALTERAR (nunca em VISUALIZAR -
1152:     * ver Problema 40/CLAUDE.md sobre cmd_4c_Confirmar.Enabled por modo).
1153:     *===========================================================================
1154:     PROCEDURE AjustarBotoesPorModo()
1155:         LOCAL loc_oPagina, loc_lEditando
1156:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1157:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1158: 
1159:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1160:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1161:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1162:             ENDIF
1163:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1164:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1165:             ENDIF
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *===========================================================================
1170:     * CarregarLista - Carrega dados no Grid da Page1
1171:     * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama este metodo direto
1172:     * de fora da classe.
1173:     * OBRIGATORIO: ControlSource e Header1.Caption redefinidos APOS RecordSource
1174:     * (RecordSource reseta ambos - Problema 2/48 do guia de migracao).
1175:     *===========================================================================
1176:     PROCEDURE CarregarLista()
1177:         LOCAL loc_lResultado, loc_oGrid
1178:         loc_lResultado = .F.
1179: 
1180:         TRY
1181:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1182:                 loc_lResultado = .T.
1183:             ELSE
1184:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1185: 
1186:                 IF !THIS.this_oBusinessObject.Buscar("")
1187:                     loc_lResultado = .F.
1188:                 ELSE
1189:                     *-- RecordSource reseta ControlSource/Headers - redefinir SEMPRE apos
1190:                     loc_oGrid.RecordSource = ""
1191:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1192: 
1193:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ntipos"
1194:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cetiquetas"
1195:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nsituas"
1196:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cordems"
1197: 
1198:                     loc_oGrid.Column1.Width = 60
1199:                     loc_oGrid.Column2.Width = 550
1200:                     loc_oGrid.Column3.Width = 130
1201:                     loc_oGrid.Column4.Width = 100
1202: 
1203:                     loc_oGrid.Column1.Header1.Caption = "Tipo"
1204:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1205:                     loc_oGrid.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
1206:                     loc_oGrid.Column4.Header1.Caption = "Ordem"
1207: 
1208:                     *-- Transcrito do legado (SIGCDTPE.Init):
1209:                     *-- .SetAll('DynamicForeColor','RGB(Iif(crSigCdTpe.nSituas # 1, 255, 0),0,0)','Column')
1210:                     loc_oGrid.SetAll("DynamicForeColor", ;
1211:                         "RGB(IIF(cursor_4c_Dados.nsituas # 1, 255, 0), 0, 0)", "Column")
1212: 
1213:                     THIS.FormatarGridLista(loc_oGrid)
1214: 
1215:                     loc_lResultado = .T.
1216:                 ENDIF

*-- Linhas 1229 a 1305:
1229:     * de fora da classe.
1230:     * Ao voltar para Page1, recarrega a lista.
1231:     *===========================================================================
1232:     PROCEDURE AlternarPagina(par_nPagina)
1233:         LOCAL loc_lResultado
1234:         loc_lResultado = .F.
1235: 
1236:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1237:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1238: 
1239:             IF par_nPagina = 1
1240:                 THIS.this_cModoAtual = "LISTA"
1241:                 THIS.CarregarLista()
1242:             ENDIF
1243: 
1244:             loc_lResultado = .T.
1245:         ELSE
1246:             MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1247:         ENDIF
1248: 
1249:         RETURN loc_lResultado
1250:     ENDPROC
1251: 
1252:     *===========================================================================
1253:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
1254:     *===========================================================================
1255:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1256:         WITH par_oGrid
1257:             .FontName = "Verdana"
1258:             .FontSize = 8
1259:         ENDWITH
1260:     ENDPROC
1261: 
1262:     *===========================================================================
1263:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1264:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1265:     *===========================================================================
1266:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1267:         LOCAL loc_nI, loc_oObjeto, loc_nP
1268: 
1269:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1270:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1271: 
1272:             IF VARTYPE(loc_oObjeto) = "O"
1273:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1274:                     loc_oObjeto.Visible = .T.
1275:                 ENDIF
1276: 
1277:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1278:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1279:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1280:                     ENDFOR
1281:                 ENDIF
1282: 
1283:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1284:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1285:                 ENDIF
1286:             ENDIF
1287:         ENDFOR
1288:     ENDPROC
1289: 
1290:     *===========================================================================
1291:     * Destroy - Libera recursos ao fechar o formulario
1292:     *===========================================================================
1293:     PROCEDURE Destroy()
1294:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1295:             THIS.this_oBusinessObject = .NULL.
1296:         ENDIF
1297: 
1298:         IF USED("cursor_4c_Dados")
1299:             USE IN cursor_4c_Dados
1300:         ENDIF
1301: 
1302:         DODEFAULT()
1303:     ENDPROC
1304: 
1305: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TpeBO.prg):
*====================================================================
* TpeBO.prg
*
* Business Object para Cadastro de Tipos de Etiquetas de Produto
* Tabela: SigCdTpe
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdTpe)
    this_nTipos      = 0     && ntipos numeric(3,0) - PK
    this_cEtiquetas  = ""    && cetiquetas char(30)
    this_nSituas     = 0     && nsituas numeric(1,0) - 0=Ativa, 1=Inativa
    this_cOrdems     = ""    && cordems char(3)
    this_nTpEspes    = 0     && tpespes numeric(3,0) - NENHUMA/TAG MODELO 1
    this_nCodObs     = 0     && codobs numeric(3,0) - FK SigCdObs
    this_nPadrao     = 0     && npadrao numeric(1,0) - NOT NULL, ausente na tela

    *-- Propriedade auxiliar somente-exibicao (nao persistida em SigCdTpe)
    this_cDescObs    = ""    && SigCdObs.descrs referente a this_nCodObs

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTpe"
            THIS.this_cCampoChave = "ntipos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (ntipos) para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nTipos)
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
                THIS.this_nTipos     = TratarNulo(ntipos,     "N")
                THIS.this_cEtiquetas = TratarNulo(cetiquetas, "C")
                THIS.this_nSituas    = TratarNulo(nsituas,    "N")
                THIS.this_cOrdems    = TratarNulo(cordems,    "C")
                THIS.this_nTpEspes   = TratarNulo(tpespes,    "N")
                THIS.this_nCodObs    = TratarNulo(codobs,     "N")
                THIS.this_nPadrao    = TratarNulo(npadrao,    "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TpeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
    *   - Descricao da Etiqueta e obrigatoria
    *   - Na INCLUSAO, ntipos e cetiquetas nao podem se repetir (ChkRegister)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEtiquetas))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Etiqueta " + CHR(233) + ;
                " informa" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarTipoExistente(THIS.this_nTipos)
                MsgAviso("Tipo de Etiqueta j" + CHR(225) + " cadastrado.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarEtiquetaExistente(THIS.this_cEtiquetas)
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Permitido Etiquetas com a mesma descri" + ;
                    CHR(231) + CHR(227) + "o.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * AntesDeGravar - Normaliza cOrdems antes de gravar
    * Transcrito do legado: Replace cOrdems With PadL(AllTrim(Str(Val(cOrdems))),3)
    *====================================================================
    PROTECTED PROCEDURE AntesDeGravar()
        IF !EMPTY(ALLTRIM(THIS.this_cOrdems))
            THIS.this_cOrdems = PADL(ALLTRIM(STR(VAL(THIS.this_cOrdems))), 3)
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * VerificarTipoExistente - Verifica se ntipos ja existe no banco
    *====================================================================
    PROCEDURE VerificarTipoExistente(par_nTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE ntipos = " + FormatarNumeroSQL(par_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTipo")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTipo")
                SELECT cursor_4c_ChkTipo
                loc_lExiste = (cursor_4c_ChkTipo.qtd > 0)
                USE IN cursor_4c_ChkTipo
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar tipo:" + CHR(13) + loException.Message, "TpeBO.VerificarTipoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * VerificarEtiquetaExistente - Verifica se cetiquetas ja existe no banco
    *====================================================================
    PROCEDURE VerificarEtiquetaExistente(par_cEtiquetas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE cetiquetas = " + EscaparSQL(par_cEtiquetas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEtiq")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEtiq")
                SELECT cursor_4c_ChkEtiq
                loc_lExiste = (cursor_4c_ChkEtiq.qtd > 0)
                USE IN cursor_4c_ChkEtiq
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar etiqueta:" + CHR(13) + loException.Message, "TpeBO.VerificarEtiquetaExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdTpe
    * Todas as colunas sao NOT NULL - nenhuma pode ficar de fora do INSERT
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdTpe (ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cOrdems)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TpeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdTpe
                SET cetiquetas = <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    nsituas    = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    cordems    = <<EscaparSQL(THIS.this_cOrdems)>>,
                    tpespes    = <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    codobs     = <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    npadrao    = <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                WHERE ntipos = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TpeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TpeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ntipos, cetiquetas, nsituas, cordems
    * (mesmas colunas usadas na grade do legado: pColuna ntipos/cetiquetas/nsituas/cordems)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ntipos N(3,0), cetiquetas C(30), nsituas N(1,0), cordems C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems FROM SigCdTpe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ntipos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TpeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (ntipos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao" + ;
                " FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(par_nCodigo, 0)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Etiqueta n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TpeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoObs - Retorna descrs de SigCdObs para exibicao (dobs)
    * Transcrito do legado (Grupo_op.Click):
    *   select descrs from SigCdObs where codigos = ?crSigCdTpe.codobs
    *====================================================================
    PROCEDURE BuscarDescricaoObs(par_nCodObs)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF VARTYPE(par_nCodObs) = "N" AND par_nCodObs > 0
            TRY
                loc_cSQL = "SELECT descrs FROM SigCdObs WHERE codigos = " + FormatarNumeroSQL(par_nCodObs, 0)

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescObs")

                IF loc_nResultado >= 0 AND USED("cursor_4c_DescObs") AND RECCOUNT("cursor_4c_DescObs") > 0
                    loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_DescObs.descrs, "C"))
                ENDIF

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao buscar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "TpeBO.BuscarDescricaoObs")
            ENDTRY
        ENDIF

        THIS.this_cDescObs = loc_cDescricao
        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE


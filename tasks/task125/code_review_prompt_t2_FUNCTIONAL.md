# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (15)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=8 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGREINR): Top original=266 vs migrado 'optg_4c_TipoLeitura' Top=5 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGREINR): Left original=131 vs migrado 'optg_4c_TipoLeitura' Left=5 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREINR): Top original=320 vs migrado 'cmd_4c_Apaga' Top=235 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREINR): Top original=279 vs migrado 'cmd_4c_SelTudo' Top=194 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreinr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1958 linhas total):

*-- Linhas 44 a 153:
44:     *--------------------------------------------------------------------------
45:     * Init - Armazena parametro, inicializa form via FormBase.Init()
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init(par_nNumBal)
48:         THIS.this_nNumBal = IIF(VARTYPE(par_nNumBal) = "N", par_nNumBal, 0)
49:         IF !DODEFAULT()
50:             RETURN .F.
51:         ENDIF
52:         RETURN .T.
53:     ENDPROC
54: 
55:     *--------------------------------------------------------------------------
56:     * InicializarForm - Cria estrutura visual e carrega dados iniciais
57:     *--------------------------------------------------------------------------
58:     PROTECTED PROCEDURE InicializarForm()
59:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
60:         loc_lSucesso   = .F.
61:         loc_lContinuar = .T.
62: 
63:         TRY
64:             THIS.Caption = " Invent" + CHR(225) + "rio n" + CHR(186) + ;
65:                 " " + ALLTRIM(STR(THIS.this_nNumBal))
66: 
67:             IF TYPE("gc_4c_CaminhoIcones") = "U"
68:                 gc_4c_CaminhoIcones = ""
69:             ENDIF
70:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
71: 
72:             THIS.this_oRelatorio = CREATEOBJECT("sigreinrBO")
73:             IF VARTYPE(THIS.this_oRelatorio) != "O"
74:                 MsgErro("Erro ao criar sigreinrBO" + CHR(13) + ;
75:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
76:                 loc_lContinuar = .F.
77:             ENDIF
78: 
79:             IF loc_lContinuar
80:                 IF !THIS.this_oRelatorio.InicializarDadosBasicos(THIS.this_nNumBal)
81:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
82:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
83:                     loc_lContinuar = .F.
84:                 ENDIF
85:             ENDIF
86: 
87:             IF loc_lContinuar
88:                 THIS.ConfigurarCabecalho()
89:                 THIS.ConfigurarPageFrame()
90:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
91:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
92:                 THIS.ConfigurarPaginaLista()
93:                 THIS.ConfigurarPaginaDados()
94:                 THIS.LimparCampos()
95:                 loc_lSucesso = .T.
96:             ENDIF
97: 
98:         CATCH TO loc_oErro
99:             THIS.this_cMensagemErro = loc_oErro.Message
100:             MsgErro(loc_oErro.Message + CHR(13) + ;
101:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
102:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
103:         ENDTRY
104: 
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarCabecalho - Container escuro superior com titulo e botoes
110:     *   cnt_4c_Cabecalho: Top=0, Left=0, Width=800, Height=80
111:     *   cmg_4c_Botoes: Left=529, Width=271, 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarCabecalho()
114:         LOCAL loc_oCab, loc_oCmg
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         loc_oCab = THIS.cnt_4c_Cabecalho
117: 
118:         WITH loc_oCab
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127: 
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .Top       = 22
131:                 .Left      = 22
132:                 .Width     = THIS.Width
133:                 .Height    = 30
134:                 .Caption   = THIS.Caption
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 14
137:                 .FontBold  = .T.
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .Visible   = .T.
141:             ENDWITH
142: 
143:             .AddObject("lbl_4c_Titulo", "Label")
144:             WITH .lbl_4c_Titulo
145:                 .Top       = 20
146:                 .Left      = 20
147:                 .Width     = THIS.Width
148:                 .Height    = 30
149:                 .Caption   = THIS.Caption
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 14
152:                 .FontBold  = .T.
153:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 254 a 358:
254:         ENDWITH
255: 
256:         loc_oCmg = loc_oCab.cmg_4c_Botoes
257:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
258:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
259:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
260:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
261:     ENDPROC
262: 
263:     *--------------------------------------------------------------------------
264:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
265:     *   Form: Width=800, Height=461
266:     *   Cabecalho Height=80; PageFrame.Top=85, Height=461-85=376, Width=802
267:     *--------------------------------------------------------------------------
268:     PROTECTED PROCEDURE ConfigurarPageFrame()
269:         LOCAL loc_oPgf
270: 
271:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
272:         loc_oPgf = THIS.pgf_4c_Paginas
273: 
274:         loc_oPgf.PageCount = 1
275:         loc_oPgf.Top       = 85
276:         loc_oPgf.Left      = -1
277:         loc_oPgf.Width     = THIS.Width + 2
278:         loc_oPgf.Height    = THIS.Height - 85
279:         loc_oPgf.Tabs      = .F.
280: 
281:         loc_oPgf.Page1.Caption   = "Filtros"
282:         loc_oPgf.Page1.FontName  = "Tahoma"
283:         loc_oPgf.Page1.FontSize  = 8
284:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
285:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
286:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
287: 
288:         loc_oPgf.Visible    = .T.
289:         loc_oPgf.ActivePage = 1
290:     ENDPROC
291: 
292:     *--------------------------------------------------------------------------
293:     * ConfigurarPaginaLista - Todos os controles de filtro na Page1
294:     *   Posicoes em Page1 = Top_original - 85 (altura do cabecalho)
295:     *--------------------------------------------------------------------------
296:     PROTECTED PROCEDURE ConfigurarPaginaLista()
297:         LOCAL loc_oPagina, loc_oGrd
298:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
299: 
300:         *-- Rotulo "Relatorio :" (Say1: Top=86 -> Page1: 1)
301:         loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
302:         WITH loc_oPagina.lbl_4c_TipoRel
303:             .Top       = 1
304:             .Left      = 77
305:             .Width     = 55
306:             .Height    = 15
307:             .Caption   = "Relat" + CHR(243) + "rio :"
308:             .FontName  = "Tahoma"
309:             .FontSize  = 8
310:             .AutoSize  = .T.
311:             .ForeColor = RGB(90, 90, 90)
312:             .BackStyle = 0
313:             .Visible   = .T.
314:         ENDWITH
315: 
316:         *-- OptionGroup TipoRelatorio (TipoRelat?rio: Top=82 -> Page1: 0)
317:         *   8 opcoes: Resumido/Analitico/Etiqueta/Ocorrencia/ConsultaEtiqueta/RelacaoComBarra/EstoqueXLeitura/EtiquetaPorEstoque
318:         loc_oPagina.AddObject("optg_4c_TipoRel", "OptionGroup")
319:         WITH loc_oPagina.optg_4c_TipoRel
320:             .AutoSize      = .F.
321:             .ButtonCount   = 8
322:             .BackStyle     = 0
323:             .BorderStyle   = 0
324:             .Value         = 1
325:             .Height        = 62
326:             .Left          = 131
327:             .SpecialEffect = 1
328:             .Top           = 0
329:             .Width         = 370
330:             .Visible       = .T.
331: 
332:             WITH .Buttons(1)
333:                 .Caption   = "Resumido"
334:                 .FontBold  = .F.
335:                 .BackStyle = 0
336:                 .Height    = 15
337:                 .Left      = 5
338:                 .Top       = 5
339:                 .Width     = 64
340:                 .AutoSize  = .T.
341:                 .ForeColor = RGB(90, 90, 90)
342:                 .Themes    = .F.
343:             ENDWITH
344:             WITH .Buttons(2)
345:                 .Caption   = "Anal" + CHR(237) + "tico"
346:                 .FontName  = "Tahoma"
347:                 .FontSize  = 8
348:                 .FontBold  = .F.
349:                 .BackStyle = 0
350:                 .Height    = 15
351:                 .Left      = 99
352:                 .Top       = 5
353:                 .Width     = 58
354:                 .AutoSize  = .T.
355:                 .ForeColor = RGB(90, 90, 90)
356:                 .Themes    = .F.
357:             ENDWITH
358:             WITH .Buttons(3)

*-- Linhas 440 a 502:
440:                 .Themes    = .F.
441:             ENDWITH
442:         ENDWITH
443:         BINDEVENT(loc_oPagina.optg_4c_TipoRel, "InteractiveChange", THIS, "MudouTipoRelatorio")
444: 
445:         *-- Rotulo "Tipo :" (Say4: Top=140 -> Page1: 55)
446:         loc_oPagina.AddObject("lbl_4c_TipoAnal", "Label")
447:         WITH loc_oPagina.lbl_4c_TipoAnal
448:             .Top       = 55
449:             .Left      = 100
450:             .Width     = 32
451:             .Height    = 15
452:             .Caption   = "Tipo :"
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .AutoSize  = .T.
456:             .ForeColor = RGB(90, 90, 90)
457:             .BackStyle = 0
458:             .Visible   = .T.
459:         ENDWITH
460: 
461:         *-- OptionGroup TipoAnalitico (Top=135 -> Page1: 50)
462:         loc_oPagina.AddObject("optg_4c_TipoAnal", "OptionGroup")
463:         WITH loc_oPagina.optg_4c_TipoAnal
464:             .AutoSize      = .T.
465:             .ButtonCount   = 3
466:             .BackStyle     = 0
467:             .BorderStyle   = 0
468:             .Value         = 1
469:             .Height        = 25
470:             .Left          = 131
471:             .SpecialEffect = 1
472:             .Top           = 50
473:             .Width         = 287
474:             .Visible       = .T.
475: 
476:             WITH .Buttons(1)
477:                 .Caption   = "Produto"
478:                 .FontBold  = .F.
479:                 .BackStyle = 0
480:                 .Height    = 15
481:                 .Left      = 5
482:                 .Top       = 5
483:                 .Width     = 56
484:                 .AutoSize  = .T.
485:                 .ForeColor = RGB(90, 90, 90)
486:                 .Themes    = .F.
487:             ENDWITH
488:             WITH .Buttons(2)
489:                 .Caption   = "Local"
490:                 .FontName  = "Tahoma"
491:                 .FontSize  = 8
492:                 .FontBold  = .F.
493:                 .BackStyle = 0
494:                 .Height    = 15
495:                 .Left      = 99
496:                 .Top       = 5
497:                 .Width     = 42
498:                 .AutoSize  = .T.
499:                 .ForeColor = RGB(90, 90, 90)
500:                 .Themes    = .F.
501:             ENDWITH
502:             WITH .Buttons(3)

*-- Linhas 514 a 683:
514:                 .Themes    = .F.
515:             ENDWITH
516:         ENDWITH
517:         BINDEVENT(loc_oPagina.optg_4c_TipoAnal, "InteractiveChange", THIS, "MudouTipoAnalitico")
518: 
519:         *-- Rotulo "Produto :" (lbl_codigo: Top=168 -> Page1: 83)
520:         loc_oPagina.AddObject("lbl_4c_Produto", "Label")
521:         WITH loc_oPagina.lbl_4c_Produto
522:             .Top       = 83
523:             .Left      = 82
524:             .Width     = 50
525:             .Height    = 15
526:             .Caption   = "Produto :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .AutoSize  = .T.
530:             .ForeColor = RGB(90, 90, 90)
531:             .BackStyle = 0
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         *-- TextBox Codigo Produto (get_cd_codigo: Top=163 -> Page1: 78)
536:         loc_oPagina.AddObject("txt_4c_CodProduto", "TextBox")
537:         WITH loc_oPagina.txt_4c_CodProduto
538:             .Top                = 78
539:             .Left               = 137
540:             .Width              = 108
541:             .Height             = 25
542:             .Value              = ""
543:             .MaxLength          = 14
544:             .FontName           = "Tahoma"
545:             .FontSize           = 8
546:             .Format             = "!"
547:             .SpecialEffect      = 1
548:             .BorderStyle        = 1
549:             .ForeColor          = RGB(0, 0, 0)
550:             .BackColor          = RGB(255, 255, 255)
551:             .DisabledBackColor  = RGB(255, 255, 255)
552:             .Enabled            = .F.
553:             .Visible            = .T.
554:         ENDWITH
555:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress",  THIS, "TeclaCodProduto")
556:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick",  THIS, "AbrirBuscaCodProduto")
557:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")
558: 
559:         *-- TextBox Descricao Produto (get_ds_codigo: Top=163 -> Page1: 78)
560:         loc_oPagina.AddObject("txt_4c_DsProduto", "TextBox")
561:         WITH loc_oPagina.txt_4c_DsProduto
562:             .Top                = 78
563:             .Left               = 247
564:             .Width              = 290
565:             .Height             = 25
566:             .Value              = ""
567:             .MaxLength          = 40
568:             .FontName           = "Tahoma"
569:             .FontSize           = 8
570:             .Format             = "!"
571:             .SpecialEffect      = 1
572:             .BorderStyle        = 1
573:             .ForeColor          = RGB(0, 0, 0)
574:             .BackColor          = RGB(255, 255, 255)
575:             .DisabledBackColor  = RGB(255, 255, 255)
576:             .Enabled            = .F.
577:             .Visible            = .T.
578:         ENDWITH
579:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress",  THIS, "TeclaDsProduto")
580:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "DblClick",  THIS, "AbrirBuscaDsProduto")
581:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress", THIS, "ValidarDsProduto")
582: 
583:         *-- Rotulo "Local :" (Say5: Top=195 -> Page1: 110)
584:         loc_oPagina.AddObject("lbl_4c_Local", "Label")
585:         WITH loc_oPagina.lbl_4c_Local
586:             .Top       = 110
587:             .Left      = 96
588:             .Width     = 36
589:             .Height    = 15
590:             .Caption   = "Local :"
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .AutoSize  = .T.
594:             .ForeColor = RGB(90, 90, 90)
595:             .BackStyle = 0
596:             .Visible   = .T.
597:         ENDWITH
598: 
599:         *-- TextBox Codigo Local (Get_Local: Top=190 -> Page1: 105)
600:         loc_oPagina.AddObject("txt_4c_CodLocal", "TextBox")
601:         WITH loc_oPagina.txt_4c_CodLocal
602:             .Top                = 105
603:             .Left               = 137
604:             .Width              = 108
605:             .Height             = 25
606:             .Value              = ""
607:             .MaxLength          = 10
608:             .FontName           = "Tahoma"
609:             .FontSize           = 8
610:             .Alignment          = 3
611:             .SpecialEffect      = 1
612:             .ForeColor          = RGB(0, 0, 0)
613:             .BackColor          = RGB(255, 255, 255)
614:             .DisabledBackColor  = RGB(255, 255, 255)
615:             .Enabled            = .F.
616:             .Visible            = .T.
617:         ENDWITH
618:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress",  THIS, "TeclaCodLocal")
619:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "DblClick",  THIS, "AbrirBuscaCodLocal")
620:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress", THIS, "ValidarCodLocal")
621: 
622:         *-- TextBox Descricao Local (get_Dlocal: Top=190 -> Page1: 105)
623:         loc_oPagina.AddObject("txt_4c_DsLocal", "TextBox")
624:         WITH loc_oPagina.txt_4c_DsLocal
625:             .Top                = 105
626:             .Left               = 247
627:             .Width              = 290
628:             .Height             = 25
629:             .Value              = ""
630:             .MaxLength          = 20
631:             .FontName           = "Tahoma"
632:             .FontSize           = 8
633:             .Alignment          = 3
634:             .SpecialEffect      = 1
635:             .ForeColor          = RGB(0, 0, 0)
636:             .BackColor          = RGB(255, 255, 255)
637:             .DisabledBackColor  = RGB(255, 255, 255)
638:             .Enabled            = .F.
639:             .Visible            = .T.
640:         ENDWITH
641:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress",  THIS, "TeclaDsLocal")
642:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "DblClick",  THIS, "AbrirBuscaDsLocal")
643:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress", THIS, "ValidarDsLocal")
644: 
645:         *-- Rotulo "Etiqueta :" (Say8: Top=222 -> Page1: 137)
646:         loc_oPagina.AddObject("lbl_4c_Etiqueta", "Label")
647:         WITH loc_oPagina.lbl_4c_Etiqueta
648:             .Top       = 137
649:             .Left      = 80
650:             .Width     = 52
651:             .Height    = 15
652:             .Caption   = "Etiqueta :"
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .AutoSize  = .T.
656:             .ForeColor = RGB(90, 90, 90)
657:             .BackStyle = 0
658:             .Visible   = .T.
659:         ENDWITH
660: 
661:         *-- TextBox Barra (Get_Barra: Top=217 -> Page1: 132)
662:         loc_oPagina.AddObject("txt_4c_Barra", "TextBox")
663:         WITH loc_oPagina.txt_4c_Barra
664:             .Top                = 132
665:             .Left               = 137
666:             .Width              = 108
667:             .Height             = 25
668:             .Value              = 0
669:             .InputMask          = "99999999999999"
670:             .Format             = "!"
671:             .FontName           = "Tahoma"
672:             .FontSize           = 8
673:             .BorderStyle        = 1
674:             .SpecialEffect      = 1
675:             .ForeColor          = RGB(0, 0, 0)
676:             .BackColor          = RGB(255, 255, 255)
677:             .DisabledBackColor  = RGB(255, 255, 255)
678:             .Enabled            = .F.
679:             .Visible            = .T.
680:         ENDWITH
681: 
682:         *-- Rotulo "Itens :" (Say2: Top=249 -> Page1: 164)
683:         loc_oPagina.AddObject("lbl_4c_Itens", "Label")

*-- Linhas 695 a 739:
695:             .Visible   = .T.
696:         ENDWITH
697: 
698:         *-- OptionGroup TipoDiferenca (TipoDiferen?a: Top=244 -> Page1: 159)
699:         loc_oPagina.AddObject("optg_4c_TipoDif", "OptionGroup")
700:         WITH loc_oPagina.optg_4c_TipoDif
701:             .AutoSize      = .T.
702:             .ButtonCount   = 2
703:             .BackStyle     = 0
704:             .BorderStyle   = 0
705:             .Value         = 2
706:             .Height        = 25
707:             .Left          = 131
708:             .SpecialEffect = 1
709:             .Top           = 159
710:             .Width         = 168
711:             .Visible       = .T.
712: 
713:             WITH .Buttons(1)
714:                 .Caption   = "Todos"
715:                 .FontBold  = .F.
716:                 .BackStyle = 0
717:                 .Height    = 15
718:                 .Left      = 5
719:                 .Top       = 5
720:                 .Width     = 47
721:                 .AutoSize  = .T.
722:                 .ForeColor = RGB(90, 90, 90)
723:                 .Themes    = .F.
724:             ENDWITH
725:             WITH .Buttons(2)
726:                 .Caption   = "Com Diferen" + CHR(231) + "a"
727:                 .FontName  = "Tahoma"
728:                 .FontSize  = 8
729:                 .FontBold  = .F.
730:                 .BackStyle = 0
731:                 .Height    = 15
732:                 .Left      = 75
733:                 .Top       = 5
734:                 .Width     = 88
735:                 .AutoSize  = .T.
736:                 .ForeColor = RGB(90, 90, 90)
737:                 .Themes    = .F.
738:             ENDWITH
739:         ENDWITH

*-- Linhas 754 a 798:
754:             .Visible   = .T.
755:         ENDWITH
756: 
757:         *-- OptionGroup TipoLeitura (Top=266 -> Page1: 181)
758:         loc_oPagina.AddObject("optg_4c_TipoLeitura", "OptionGroup")
759:         WITH loc_oPagina.optg_4c_TipoLeitura
760:             .AutoSize      = .T.
761:             .ButtonCount   = 2
762:             .BackStyle     = 0
763:             .BorderStyle   = 0
764:             .Value         = 1
765:             .Height        = 25
766:             .Left          = 131
767:             .SpecialEffect = 1
768:             .Top           = 181
769:             .Width         = 141
770:             .Visible       = .T.
771: 
772:             WITH .Buttons(1)
773:                 .Caption   = "Leitura"
774:                 .FontBold  = .F.
775:                 .BackStyle = 0
776:                 .Height    = 15
777:                 .Left      = 5
778:                 .Top       = 5
779:                 .Width     = 51
780:                 .AutoSize  = .T.
781:                 .ForeColor = RGB(90, 90, 90)
782:                 .Themes    = .F.
783:             ENDWITH
784:             WITH .Buttons(2)
785:                 .Caption   = "Releitura"
786:                 .FontName  = "Tahoma"
787:                 .FontSize  = 8
788:                 .FontBold  = .F.
789:                 .BackStyle = 0
790:                 .Height    = 15
791:                 .Left      = 75
792:                 .Top       = 5
793:                 .Width     = 61
794:                 .AutoSize  = .T.
795:                 .ForeColor = RGB(90, 90, 90)
796:                 .Themes    = .F.
797:             ENDWITH
798:         ENDWITH

*-- Linhas 813 a 857:
813:             .Visible   = .F.
814:         ENDWITH
815: 
816:         *-- OptionGroup TipoCusto (optgTpCusto: Top=288 -> Page1: 203)
817:         loc_oPagina.AddObject("optg_4c_TpCusto", "OptionGroup")
818:         WITH loc_oPagina.optg_4c_TpCusto
819:             .AutoSize      = .T.
820:             .ButtonCount   = 2
821:             .BackStyle     = 0
822:             .BorderStyle   = 0
823:             .Value         = 2
824:             .Height        = 27
825:             .Left          = 131
826:             .Top           = 203
827:             .Width         = 121
828:             .Visible       = .F.
829: 
830:             WITH .Buttons(1)
831:                 .Caption   = "\<Sim"
832:                 .FontBold  = .F.
833:                 .BackStyle = 0
834:                 .Height    = 17
835:                 .Left      = 5
836:                 .Top       = 5
837:                 .Width     = 40
838:                 .AutoSize  = .T.
839:                 .ForeColor = RGB(90, 90, 90)
840:                 .Themes    = .F.
841:             ENDWITH
842:             WITH .Buttons(2)
843:                 .Caption   = "\<N" + CHR(227) + "o"
844:                 .FontName  = "Tahoma"
845:                 .FontSize  = 8
846:                 .FontBold  = .F.
847:                 .BackStyle = 0
848:                 .Height    = 17
849:                 .Left      = 75
850:                 .Top       = 5
851:                 .Width     = 41
852:                 .AutoSize  = .T.
853:                 .ForeColor = RGB(90, 90, 90)
854:                 .Themes    = .F.
855:             ENDWITH
856:         ENDWITH
857: 

*-- Linhas 871 a 915:
871:             .Visible   = .T.
872:         ENDWITH
873: 
874:         *-- OptionGroup TipoVenda (optgTpVenda: Top=313 -> Page1: 228)
875:         loc_oPagina.AddObject("optg_4c_TpVenda", "OptionGroup")
876:         WITH loc_oPagina.optg_4c_TpVenda
877:             .AutoSize      = .T.
878:             .ButtonCount   = 2
879:             .BackStyle     = 0
880:             .BorderStyle   = 0
881:             .Value         = 1
882:             .Height        = 27
883:             .Left          = 131
884:             .Top           = 228
885:             .Width         = 121
886:             .Visible       = .T.
887: 
888:             WITH .Buttons(1)
889:                 .Caption   = "\<Sim"
890:                 .FontBold  = .F.
891:                 .BackStyle = 0
892:                 .Height    = 17
893:                 .Left      = 5
894:                 .Top       = 5
895:                 .Width     = 40
896:                 .AutoSize  = .T.
897:                 .ForeColor = RGB(90, 90, 90)
898:                 .Themes    = .F.
899:             ENDWITH
900:             WITH .Buttons(2)
901:                 .Caption   = "\<N" + CHR(227) + "o"
902:                 .FontName  = "Tahoma"
903:                 .FontSize  = 8
904:                 .FontBold  = .F.
905:                 .BackStyle = 0
906:                 .Height    = 17
907:                 .Left      = 75
908:                 .Top       = 5
909:                 .Width     = 41
910:                 .AutoSize  = .T.
911:                 .ForeColor = RGB(90, 90, 90)
912:                 .Themes    = .F.
913:             ENDWITH
914:         ENDWITH
915: 

*-- Linhas 929 a 973:
929:             .Visible   = .T.
930:         ENDWITH
931: 
932:         *-- OptionGroup Foto (OptFoto: Top=337 -> Page1: 252)
933:         loc_oPagina.AddObject("optg_4c_Foto", "OptionGroup")
934:         WITH loc_oPagina.optg_4c_Foto
935:             .AutoSize      = .T.
936:             .ButtonCount   = 2
937:             .BackStyle     = 0
938:             .BorderStyle   = 0
939:             .Value         = 2
940:             .Height        = 27
941:             .Left          = 131
942:             .Top           = 252
943:             .Width         = 121
944:             .Visible       = .T.
945: 
946:             WITH .Buttons(1)
947:                 .Caption   = "\<Sim"
948:                 .FontBold  = .F.
949:                 .BackStyle = 0
950:                 .Height    = 17
951:                 .Left      = 5
952:                 .Top       = 5
953:                 .Width     = 40
954:                 .AutoSize  = .T.
955:                 .ForeColor = RGB(90, 90, 90)
956:                 .Themes    = .F.
957:             ENDWITH
958:             WITH .Buttons(2)
959:                 .Caption   = "\<N" + CHR(227) + "o"
960:                 .FontName  = "Tahoma"
961:                 .FontSize  = 8
962:                 .FontBold  = .F.
963:                 .BackStyle = 0
964:                 .Height    = 17
965:                 .Left      = 75
966:                 .Top       = 5
967:                 .Width     = 41
968:                 .AutoSize  = .T.
969:                 .ForeColor = RGB(90, 90, 90)
970:                 .Themes    = .F.
971:             ENDWITH
972:         ENDWITH
973: 

*-- Linhas 987 a 1031:
987:             .Visible   = .T.
988:         ENDWITH
989: 
990:         *-- OptionGroup Etiquetas (OptEtiq: Top=361 -> Page1: 276)
991:         loc_oPagina.AddObject("optg_4c_Etiq", "OptionGroup")
992:         WITH loc_oPagina.optg_4c_Etiq
993:             .AutoSize      = .T.
994:             .ButtonCount   = 2
995:             .BackStyle     = 0
996:             .BorderStyle   = 0
997:             .Value         = 2
998:             .Height        = 27
999:             .Left          = 131
1000:             .Top           = 276
1001:             .Width         = 121
1002:             .Visible       = .T.
1003: 
1004:             WITH .Buttons(1)
1005:                 .Caption   = "\<Sim"
1006:                 .FontBold  = .F.
1007:                 .BackStyle = 0
1008:                 .Height    = 17
1009:                 .Left      = 5
1010:                 .Top       = 5
1011:                 .Width     = 40
1012:                 .AutoSize  = .T.
1013:                 .ForeColor = RGB(90, 90, 90)
1014:                 .Themes    = .F.
1015:             ENDWITH
1016:             WITH .Buttons(2)
1017:                 .Caption   = "\<N" + CHR(227) + "o"
1018:                 .FontName  = "Tahoma"
1019:                 .FontSize  = 8
1020:                 .FontBold  = .F.
1021:                 .BackStyle = 0
1022:                 .Height    = 17
1023:                 .Left      = 75
1024:                 .Top       = 5
1025:                 .Width     = 41
1026:                 .AutoSize  = .T.
1027:                 .ForeColor = RGB(90, 90, 90)
1028:                 .Themes    = .F.
1029:             ENDWITH
1030:         ENDWITH
1031: 

*-- Linhas 1045 a 1089:
1045:             .Visible   = .T.
1046:         ENDWITH
1047: 
1048:         *-- OptionGroup Observacao (OptObs: Top=384 -> Page1: 299)
1049:         loc_oPagina.AddObject("optg_4c_Obs", "OptionGroup")
1050:         WITH loc_oPagina.optg_4c_Obs
1051:             .AutoSize      = .T.
1052:             .ButtonCount   = 2
1053:             .BackStyle     = 0
1054:             .BorderStyle   = 0
1055:             .Value         = 2
1056:             .Height        = 27
1057:             .Left          = 131
1058:             .Top           = 299
1059:             .Width         = 121
1060:             .Visible       = .T.
1061: 
1062:             WITH .Buttons(1)
1063:                 .Caption   = "\<Sim"
1064:                 .FontBold  = .F.
1065:                 .BackStyle = 0
1066:                 .Height    = 17
1067:                 .Left      = 5
1068:                 .Top       = 5
1069:                 .Width     = 40
1070:                 .AutoSize  = .T.
1071:                 .ForeColor = RGB(90, 90, 90)
1072:                 .Themes    = .F.
1073:             ENDWITH
1074:             WITH .Buttons(2)
1075:                 .Caption   = "\<N" + CHR(227) + "o"
1076:                 .FontName  = "Tahoma"
1077:                 .FontSize  = 8
1078:                 .FontBold  = .F.
1079:                 .BackStyle = 0
1080:                 .Height    = 17
1081:                 .Left      = 75
1082:                 .Top       = 5
1083:                 .Width     = 41
1084:                 .AutoSize  = .T.
1085:                 .ForeColor = RGB(90, 90, 90)
1086:                 .Themes    = .F.
1087:             ENDWITH
1088:         ENDWITH
1089: 

*-- Linhas 1103 a 1147:
1103:             .Visible   = .T.
1104:         ENDWITH
1105: 
1106:         *-- OptionGroup Colecao (OptCtg: Top=405 -> Page1: 320)
1107:         loc_oPagina.AddObject("optg_4c_Ctg", "OptionGroup")
1108:         WITH loc_oPagina.optg_4c_Ctg
1109:             .AutoSize      = .T.
1110:             .ButtonCount   = 2
1111:             .BackStyle     = 0
1112:             .BorderStyle   = 0
1113:             .Value         = 2
1114:             .Height        = 27
1115:             .Left          = 130
1116:             .Top           = 320
1117:             .Width         = 121
1118:             .Visible       = .T.
1119: 
1120:             WITH .Buttons(1)
1121:                 .Caption   = "\<Sim"
1122:                 .FontBold  = .F.
1123:                 .BackStyle = 0
1124:                 .Height    = 17
1125:                 .Left      = 5
1126:                 .Top       = 5
1127:                 .Width     = 40
1128:                 .AutoSize  = .T.
1129:                 .ForeColor = RGB(90, 90, 90)
1130:                 .Themes    = .F.
1131:             ENDWITH
1132:             WITH .Buttons(2)
1133:                 .Caption   = "\<N" + CHR(227) + "o"
1134:                 .FontName  = "Tahoma"
1135:                 .FontSize  = 8
1136:                 .FontBold  = .F.
1137:                 .BackStyle = 0
1138:                 .Height    = 17
1139:                 .Left      = 75
1140:                 .Top       = 5
1141:                 .Width     = 41
1142:                 .AutoSize  = .T.
1143:                 .ForeColor = RGB(90, 90, 90)
1144:                 .Themes    = .F.
1145:             ENDWITH
1146:         ENDWITH
1147: 

*-- Linhas 1161 a 1205:
1161:             .Visible   = .T.
1162:         ENDWITH
1163: 
1164:         *-- OptionGroup Categoria (OptCol: Top=427 -> Page1: 342)
1165:         loc_oPagina.AddObject("optg_4c_Col", "OptionGroup")
1166:         WITH loc_oPagina.optg_4c_Col
1167:             .AutoSize      = .T.
1168:             .ButtonCount   = 2
1169:             .BackStyle     = 0
1170:             .BorderStyle   = 0
1171:             .Value         = 2
1172:             .Height        = 27
1173:             .Left          = 130
1174:             .Top           = 342
1175:             .Width         = 121
1176:             .Visible       = .T.
1177: 
1178:             WITH .Buttons(1)
1179:                 .Caption   = "\<Sim"
1180:                 .FontBold  = .F.
1181:                 .BackStyle = 0
1182:                 .Height    = 17
1183:                 .Left      = 5
1184:                 .Top       = 5
1185:                 .Width     = 40
1186:                 .AutoSize  = .T.
1187:                 .ForeColor = RGB(90, 90, 90)
1188:                 .Themes    = .F.
1189:             ENDWITH
1190:             WITH .Buttons(2)
1191:                 .Caption   = "\<N" + CHR(227) + "o"
1192:                 .FontName  = "Tahoma"
1193:                 .FontSize  = 8
1194:                 .FontBold  = .F.
1195:                 .BackStyle = 0
1196:                 .Height    = 17
1197:                 .Left      = 75
1198:                 .Top       = 5
1199:                 .Width     = 41
1200:                 .AutoSize  = .T.
1201:                 .ForeColor = RGB(90, 90, 90)
1202:                 .Themes    = .F.
1203:             ENDWITH
1204:         ENDWITH
1205: 

*-- Linhas 1269 a 1958:
1269:         ENDWITH
1270:         loc_oPagina.grd_4c_Operacaos.Column1.CurrentControl  = "chk_4c_Marca"
1271:         loc_oPagina.grd_4c_Operacaos.Column1.ControlSource   = "CsOperacaos.Marcas"
1272:         BINDEVENT(loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca, ;
1273:             "Click", THIS, "CliqueCheckOperacao")
1274: 
1275:         *-- Botao Selecionar Tudo (SelTudo: Top=279 -> Page1: 194, Left=696)
1276:         loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
1277:         WITH loc_oPagina.cmd_4c_SelTudo
1278:             .Top          = 194
1279:             .Left         = 696
1280:             .Width        = 40
1281:             .Height       = 40
1282:             .Caption      = ""
1283:             .FontName     = "Verdana"
1284:             .FontSize     = 8
1285:             .WordWrap     = .T.
1286:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1287:             .TabStop      = .F.
1288:             .ToolTipText  = "Seleciona Tudo"
1289:             .ForeColor    = RGB(36, 84, 155)
1290:             .BackColor    = RGB(255, 255, 255)
1291:             .Themes       = .F.
1292:             .Visible      = .F.
1293:         ENDWITH
1294:         BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "CliqueSelTudo")
1295: 
1296:         *-- Botao Cancela Tudo (apaga: Top=320 -> Page1: 235, Left=696)
1297:         loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
1298:         WITH loc_oPagina.cmd_4c_Apaga
1299:             .Top          = 235
1300:             .Left         = 696
1301:             .Width        = 40
1302:             .Height       = 40
1303:             .Caption      = ""
1304:             .FontName     = "Verdana"
1305:             .FontSize     = 8
1306:             .WordWrap     = .T.
1307:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1308:             .TabStop      = .F.
1309:             .ToolTipText  = "Cancela Tudo"
1310:             .ForeColor    = RGB(36, 84, 155)
1311:             .BackColor    = RGB(255, 255, 255)
1312:             .Themes       = .F.
1313:             .Visible      = .F.
1314:         ENDWITH
1315:         BINDEVENT(loc_oPagina.cmd_4c_Apaga, "Click", THIS, "CliqueApaga")
1316: 
1317:         *-- Controle de acesso via fChecaAcesso
1318:         THIS.AplicarAcessoControles()
1319:     ENDPROC
1320: 
1321:     *--------------------------------------------------------------------------
1322:     * ConfigurarPaginaDados - Nao aplicavel para form de relatorio (stub)
1323:     *--------------------------------------------------------------------------
1324:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1325:         RETURN .T.
1326:     ENDPROC
1327: 
1328:     *--------------------------------------------------------------------------
1329:     * AplicarAcessoControles - Controla visibilidade conforme perfil do usuario
1330:     *   fChecaAcesso("SIGREINR", "CUSTO") -> mostra/oculta optg_4c_TpCusto
1331:     *   fChecaAcesso("SIGREINR", "RELATORIO") -> controla opcoes do TipoRel
1332:     *--------------------------------------------------------------------------
1333:     PROTECTED PROCEDURE AplicarAcessoControles()
1334:         LOCAL loc_oPg, loc_lCusto, loc_lRelatorio, loc_oErro
1335:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1336: 
1337:         TRY
1338:             loc_lCusto     = fChecaAcesso("SIGREINR", "CUSTO")
1339:             loc_lRelatorio = fChecaAcesso("SIGREINR", "RELATORIO")
1340:         CATCH TO loc_oErro
1341:             loc_lCusto     = .F.
1342:             loc_lRelatorio = .T.
1343:         ENDTRY
1344: 
1345:         *-- Custo: visivel apenas se tem acesso
1346:         loc_oPg.lbl_4c_TpCusto.Visible    = loc_lCusto
1347:         loc_oPg.optg_4c_TpCusto.Visible   = loc_lCusto
1348:         IF !loc_lCusto
1349:             loc_oPg.optg_4c_TpCusto.Value = 2
1350:         ENDIF
1351:         THIS.this_oRelatorio.this_lPermissaoCusto = loc_lCusto
1352: 
1353:         *-- Relatorio completo: oculta opcoes restrictas se sem acesso
1354:         IF !loc_lRelatorio
1355:             loc_oPg.optg_4c_TipoRel.Buttons(2).Visible = .F.
1356:             loc_oPg.optg_4c_TipoRel.Buttons(4).Visible = .F.
1357:             loc_oPg.optg_4c_TipoRel.Buttons(5).Visible = .F.
1358:             loc_oPg.optg_4c_TipoRel.Buttons(6).Visible = .F.
1359:             loc_oPg.optg_4c_TipoRel.Buttons(7).Visible = .F.
1360:         ENDIF
1361:         THIS.this_oRelatorio.this_lPermissaoRelatorio = loc_lRelatorio
1362:     ENDPROC
1363: 
1364:     *--------------------------------------------------------------------------
1365:     * FormParaRelatorio - Transfere valores dos controles para o BO
1366:     *--------------------------------------------------------------------------
1367:     PROTECTED PROCEDURE FormParaRelatorio()
1368:         LOCAL loc_oPg, loc_oErro
1369:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1370: 
1371:         TRY
1372:             WITH THIS.this_oRelatorio
1373:                 .this_nTipoRel    = loc_oPg.optg_4c_TipoRel.Value
1374:                 .this_nTipoDif    = loc_oPg.optg_4c_TipoDif.Value
1375:                 .this_nTipoLeitura = loc_oPg.optg_4c_TipoLeitura.Value
1376:                 .this_nTipoAnal   = loc_oPg.optg_4c_TipoAnal.Value
1377:                 .this_cProduto    = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1378:                 .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1379:                 .this_cLocal      = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1380:                 .this_cDsLocal    = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1381:                 .this_nBarra      = TRANSFORM(loc_oPg.txt_4c_Barra.Value)
1382:                 .this_nOptTpCusto = loc_oPg.optg_4c_TpCusto.Value
1383:                 .this_nOptTpVenda = loc_oPg.optg_4c_TpVenda.Value
1384:                 .this_nOptFoto    = loc_oPg.optg_4c_Foto.Value
1385:                 .this_nOptEtiq    = loc_oPg.optg_4c_Etiq.Value
1386:                 .this_nOptObs     = loc_oPg.optg_4c_Obs.Value
1387:                 .this_nOptCtg     = loc_oPg.optg_4c_Ctg.Value
1388:                 .this_nOptCol     = loc_oPg.optg_4c_Col.Value
1389:             ENDWITH
1390:         CATCH TO loc_oErro
1391:             MsgErro(loc_oErro.Message, "FormParaRelatorio")
1392:         ENDTRY
1393:     ENDPROC
1394: 
1395:     *--------------------------------------------------------------------------
1396:     * ValidarFiltros - Delega validacao ao BO (apos FormParaRelatorio)
1397:     *--------------------------------------------------------------------------
1398:     PROTECTED PROCEDURE ValidarFiltros()
1399:         RETURN THIS.this_oRelatorio.ValidarFiltros()
1400:     ENDPROC
1401: 
1402:     *==========================================================================
1403:     * CONTROLE DE ESTADO - INTERACTIVIDADE DOS FILTROS
1404:     *==========================================================================
1405: 
1406:     *--------------------------------------------------------------------------
1407:     * MudouTipoRelatorio - Atualiza estado dos controles conforme TipoRel
1408:     *   Espelha TipoRelat?rio.InteractiveChange do legado
1409:     *--------------------------------------------------------------------------
1410:     PROCEDURE MudouTipoRelatorio()
1411:         LOCAL loc_nTipo, loc_oPg, loc_lPermCusto
1412:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1413:         loc_nTipo = loc_oPg.optg_4c_TipoRel.Value
1414: 
1415:         *-- TipoDiferenca: apenas TipoRel=1
1416:         loc_oPg.optg_4c_TipoDif.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1417: 
1418:         *-- TipoLeitura e TipoAnalitico: apenas TipoRel=2
1419:         loc_oPg.optg_4c_TipoLeitura.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
1420:         loc_oPg.optg_4c_TipoAnal.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
1421: 
1422:         *-- TpCusto e TpVenda: apenas TipoRel=1, e se tem permissao
1423:         loc_lPermCusto = THIS.this_oRelatorio.this_lPermissaoCusto
1424:         loc_oPg.optg_4c_TpCusto.SetAll("Enabled", (loc_nTipo = 1 AND loc_lPermCusto), "OptionButton")
1425:         loc_oPg.optg_4c_TpVenda.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1426: 
1427:         *-- Foto e Etiq: apenas TipoRel=1
1428:         loc_oPg.optg_4c_Foto.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1429:         loc_oPg.optg_4c_Etiq.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1430: 
1431:         *-- Campos Produto/Local/Barra: apenas TipoRel=2
1432:         loc_oPg.txt_4c_CodProduto.Enabled = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
1433:         loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
1434:         loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
1435:         loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
1436:         loc_oPg.txt_4c_Barra.Enabled      = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 3)
1437: 
1438:         *-- Grid de ocorrencias: apenas TipoRel=4
1439:         loc_oPg.grd_4c_Operacaos.Visible   = (loc_nTipo = 4)
1440:         loc_oPg.cmd_4c_Apaga.Visible       = (loc_nTipo = 4)
1441:         loc_oPg.cmd_4c_SelTudo.Visible     = (loc_nTipo = 4)
1442:         loc_oPg.lbl_4c_Ocorrencias.Visible = (loc_nTipo = 4)
1443: 
1444:         *-- Obs/Colecao/Categoria: apenas TipoRel=1 ou 3
1445:         loc_oPg.lbl_4c_Obs.Visible      = INLIST(loc_nTipo, 1, 3)
1446:         loc_oPg.optg_4c_Obs.Visible     = INLIST(loc_nTipo, 1, 3)
1447:         loc_oPg.lbl_4c_Colecao.Visible  = INLIST(loc_nTipo, 1, 3)
1448:         loc_oPg.optg_4c_Ctg.Visible     = INLIST(loc_nTipo, 1, 3)
1449:         loc_oPg.lbl_4c_Ctg.Visible      = INLIST(loc_nTipo, 1, 3)
1450:         loc_oPg.optg_4c_Col.Visible     = INLIST(loc_nTipo, 1, 3)
1451: 
1452:         THIS.Refresh()
1453:     ENDPROC
1454: 
1455:     *--------------------------------------------------------------------------
1456:     * MudouTipoAnalitico - Atualiza campos de filtro conforme TipoAnal
1457:     *   Espelha TipoAnal?tico.InteractiveChange do legado
1458:     *--------------------------------------------------------------------------
1459:     PROCEDURE MudouTipoAnalitico()
1460:         LOCAL loc_nAnal, loc_oPg
1461:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1462:         loc_nAnal = loc_oPg.optg_4c_TipoAnal.Value
1463: 
1464:         loc_oPg.txt_4c_CodProduto.Enabled = (loc_nAnal = 1)
1465:         loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nAnal = 1)
1466:         loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nAnal = 2)
1467:         loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nAnal = 2)
1468:         loc_oPg.txt_4c_Barra.Enabled      = (loc_nAnal = 3)
1469: 
1470:         DO CASE
1471:             CASE loc_nAnal = 1
1472:                 loc_oPg.txt_4c_CodProduto.SetFocus()
1473:             CASE loc_nAnal = 2
1474:                 loc_oPg.txt_4c_CodLocal.SetFocus()
1475:             OTHERWISE
1476:                 loc_oPg.txt_4c_Barra.SetFocus()
1477:         ENDCASE
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * LOOKUPS - PRODUTO
1482:     *==========================================================================
1483: 
1484:     PROCEDURE TeclaCodProduto(par_nKeyCode, par_nShiftAltCtrl)
1485:         IF INLIST(par_nKeyCode, 115, 116)
1486:             THIS.AbrirBuscaCodProduto()
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     PROCEDURE TeclaDsProduto(par_nKeyCode, par_nShiftAltCtrl)
1491:         IF INLIST(par_nKeyCode, 115, 116)
1492:             THIS.AbrirBuscaDsProduto()
1493:         ENDIF
1494:     ENDPROC
1495: 
1496:     PROCEDURE AbrirBuscaCodProduto()
1497:         LOCAL loc_oPg, loc_cValor, loc_oForm, loc_nResult, loc_nBarra
1498:         LOCAL lnbarra_val, lcpros_val
1499:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1500:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1501: 
1502:         *-- Se valor e numerico, pode ser codigo de barras -> busca em SigOpEtq
1503:         loc_nBarra = VAL(loc_cValor)
1504:         IF loc_nBarra > 0
1505:             lnbarra_val = loc_nBarra
1506:             loc_nResult = SQLEXEC(gnConnHandle, ;
1507:                 "Select CPros From SigOpEtq Where CBars = ?lnbarra_val", ;
1508:                 "cursor_4c_EtqLkp")
1509:             IF loc_nResult > 0
1510:                 SELECT cursor_4c_EtqLkp
1511:                 GO TOP
1512:                 IF !EOF()
1513:                     loc_cValor = ALLTRIM(cursor_4c_EtqLkp.CPros)
1514:                 ENDIF
1515:                 USE IN cursor_4c_EtqLkp
1516:             ENDIF
1517:         ENDIF
1518: 
1519:         *-- Busca direta por codigo na SigCdPro
1520:         lcpros_val  = loc_cValor
1521:         loc_nResult = SQLEXEC(gnConnHandle, ;
1522:             "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
1523:             "cursor_4c_ProLkp")
1524:         IF loc_nResult > 0
1525:             SELECT cursor_4c_ProLkp
1526:             GO TOP
1527:             IF !EOF()
1528:                 loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProLkp.cpros)
1529:                 loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProLkp.dpros)
1530:                 USE IN cursor_4c_ProLkp
1531:                 RETURN
1532:             ENDIF
1533:             USE IN cursor_4c_ProLkp
1534:         ENDIF
1535: 
1536:         *-- Nao encontrado: abre FormBuscaAuxiliar
1537:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1538:             "SigCdPro", "cursor_4c_ProBusca", "cpros", loc_cValor, "Produtos")
1539:         IF ISNULL(loc_oForm)
1540:             RETURN
1541:         ENDIF
1542:         IF !loc_oForm.this_lAchouRegistro
1543:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1544:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1545:             loc_oForm.Show()
1546:         ENDIF
1547:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
1548:             loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
1549:             loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
1550:         ELSE
1551:             loc_oPg.txt_4c_CodProduto.Value = ""
1552:             loc_oPg.txt_4c_DsProduto.Value  = ""
1553:         ENDIF
1554:         IF USED("cursor_4c_ProBusca")
1555:             USE IN cursor_4c_ProBusca
1556:         ENDIF
1557:         loc_oForm.Release()
1558:     ENDPROC
1559: 
1560:     PROCEDURE AbrirBuscaDsProduto()
1561:         LOCAL loc_oPg, loc_cValor, loc_oForm
1562:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1563:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1564: 
1565:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1566:             "SigCdPro", "cursor_4c_ProBusca", "dpros", loc_cValor, "Produtos")
1567:         IF ISNULL(loc_oForm)
1568:             RETURN
1569:         ENDIF
1570:         IF !loc_oForm.this_lAchouRegistro
1571:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1572:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1573:             loc_oForm.Show()
1574:         ENDIF
1575:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
1576:             loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
1577:             loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
1578:         ELSE
1579:             loc_oPg.txt_4c_CodProduto.Value = ""
1580:             loc_oPg.txt_4c_DsProduto.Value  = ""
1581:         ENDIF
1582:         IF USED("cursor_4c_ProBusca")
1583:             USE IN cursor_4c_ProBusca
1584:         ENDIF
1585:         loc_oForm.Release()
1586:     ENDPROC
1587: 
1588:     PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
1589:         LOCAL loc_oPg, loc_cValor, lcpros_val, loc_nResult
1590:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1591:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1592:         IF EMPTY(loc_cValor)
1593:             loc_oPg.txt_4c_DsProduto.Value = ""
1594:             RETURN
1595:         ENDIF
1596:         lcpros_val  = loc_cValor
1597:         loc_nResult = SQLEXEC(gnConnHandle, ;
1598:             "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
1599:             "cursor_4c_ProVal")
1600:         IF loc_nResult > 0
1601:             SELECT cursor_4c_ProVal
1602:             GO TOP
1603:             IF !EOF()
1604:                 loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProVal.cpros)
1605:                 loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProVal.dpros)
1606:             ELSE
1607:                 THIS.AbrirBuscaCodProduto()
1608:             ENDIF
1609:             USE IN cursor_4c_ProVal
1610:         ENDIF
1611:     ENDPROC
1612: 
1613:     PROCEDURE ValidarDsProduto(par_nKeyCode, par_nShiftAltCtrl)
1614:         LOCAL loc_oPg, loc_cValor
1615:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1616:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1617:         IF EMPTY(loc_cValor)
1618:             loc_oPg.txt_4c_CodProduto.Value = ""
1619:             loc_oPg.txt_4c_DsProduto.Value  = ""
1620:             RETURN
1621:         ENDIF
1622:         THIS.AbrirBuscaDsProduto()
1623:     ENDPROC
1624: 
1625:     *==========================================================================
1626:     * LOOKUPS - LOCAL
1627:     *==========================================================================
1628: 
1629:     PROCEDURE TeclaCodLocal(par_nKeyCode, par_nShiftAltCtrl)
1630:         IF INLIST(par_nKeyCode, 115, 116)
1631:             THIS.AbrirBuscaCodLocal()
1632:         ENDIF
1633:     ENDPROC
1634: 
1635:     PROCEDURE TeclaDsLocal(par_nKeyCode, par_nShiftAltCtrl)
1636:         IF INLIST(par_nKeyCode, 115, 116)
1637:             THIS.AbrirBuscaDsLocal()
1638:         ENDIF
1639:     ENDPROC
1640: 
1641:     PROCEDURE AbrirBuscaCodLocal()
1642:         LOCAL loc_oPg, loc_cValor, loc_oForm
1643:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1644:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1645: 
1646:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1647:             "SigPrLcl", "cursor_4c_LclBusca", "codigos", loc_cValor, "Locais")
1648:         IF ISNULL(loc_oForm)
1649:             RETURN
1650:         ENDIF
1651:         IF !loc_oForm.this_lAchouRegistro
1652:             loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
1653:             loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
1654:             loc_oForm.Show()
1655:         ENDIF
1656:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
1657:             loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
1658:             loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
1659:         ELSE
1660:             loc_oPg.txt_4c_CodLocal.Value = ""
1661:             loc_oPg.txt_4c_DsLocal.Value  = ""
1662:         ENDIF
1663:         IF USED("cursor_4c_LclBusca")
1664:             USE IN cursor_4c_LclBusca
1665:         ENDIF
1666:         loc_oForm.Release()
1667:     ENDPROC
1668: 
1669:     PROCEDURE AbrirBuscaDsLocal()
1670:         LOCAL loc_oPg, loc_cValor, loc_oForm
1671:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1672:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1673: 
1674:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1675:             "SigPrLcl", "cursor_4c_LclBusca", "descricaos", loc_cValor, "Locais")
1676:         IF ISNULL(loc_oForm)
1677:             RETURN
1678:         ENDIF
1679:         IF !loc_oForm.this_lAchouRegistro
1680:             loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
1681:             loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
1682:             loc_oForm.Show()
1683:         ENDIF
1684:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
1685:             loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
1686:             loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
1687:         ELSE
1688:             loc_oPg.txt_4c_CodLocal.Value = ""
1689:             loc_oPg.txt_4c_DsLocal.Value  = ""
1690:         ENDIF
1691:         IF USED("cursor_4c_LclBusca")
1692:             USE IN cursor_4c_LclBusca
1693:         ENDIF
1694:         loc_oForm.Release()
1695:     ENDPROC
1696: 
1697:     PROCEDURE ValidarCodLocal(par_nKeyCode, par_nShiftAltCtrl)
1698:         LOCAL loc_oPg, loc_cValor, lcodigos_val, loc_nResult
1699:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1700:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1701:         IF EMPTY(loc_cValor)
1702:             loc_oPg.txt_4c_DsLocal.Value = ""
1703:             RETURN
1704:         ENDIF
1705:         lcodigos_val = loc_cValor
1706:         loc_nResult  = SQLEXEC(gnConnHandle, ;
1707:             "Select codigos,descricaos From SigPrLcl Where codigos = ?lcodigos_val", ;
1708:             "cursor_4c_LclVal")
1709:         IF loc_nResult > 0
1710:             SELECT cursor_4c_LclVal
1711:             GO TOP
1712:             IF !EOF()
1713:                 loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclVal.codigos)
1714:                 loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclVal.descricaos)
1715:             ELSE
1716:                 THIS.AbrirBuscaCodLocal()
1717:             ENDIF
1718:             USE IN cursor_4c_LclVal
1719:         ENDIF
1720:     ENDPROC
1721: 
1722:     PROCEDURE ValidarDsLocal(par_nKeyCode, par_nShiftAltCtrl)
1723:         LOCAL loc_oPg, loc_cValor
1724:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1725:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1726:         IF EMPTY(loc_cValor)
1727:             loc_oPg.txt_4c_CodLocal.Value = ""
1728:             loc_oPg.txt_4c_DsLocal.Value  = ""
1729:             RETURN
1730:         ENDIF
1731:         THIS.AbrirBuscaDsLocal()
1732:     ENDPROC
1733: 
1734:     *==========================================================================
1735:     * GRID OCORRENCIAS
1736:     *==========================================================================
1737: 
1738:     PROCEDURE CliqueCheckOperacao()
1739:         IF USED("CsOperacaos")
1740:             SELECT CsOperacaos
1741:             REPLACE Marcas WITH IIF(CsOperacaos.Marcas = 0, 1, 0) IN CsOperacaos
1742:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1743:         ENDIF
1744:     ENDPROC
1745: 
1746:     PROCEDURE CliqueSelTudo()
1747:         IF USED("CsOperacaos")
1748:             SELECT CsOperacaos
1749:             UPDATE CsOperacaos SET Marcas = 1
1750:             GO TOP
1751:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1752:             THIS.Refresh()
1753:         ENDIF
1754:     ENDPROC
1755: 
1756:     PROCEDURE CliqueApaga()
1757:         IF USED("CsOperacaos")
1758:             SELECT CsOperacaos
1759:             UPDATE CsOperacaos SET Marcas = 0
1760:             GO TOP
1761:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1762:             THIS.Refresh()
1763:         ENDIF
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * ACOES DOS BOTOES DO RELATORIO
1768:     *==========================================================================
1769: 
1770:     PROCEDURE BtnVisualizarClick()
1771:         LOCAL loc_oErro
1772:         TRY
1773:             THIS.FormParaRelatorio()
1774:             IF !THIS.this_oRelatorio.ValidarFiltros()
1775:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1776:                     "Campo Obrigat" + CHR(243) + "rio")
1777:                 RETURN
1778:             ENDIF
1779:             IF !THIS.this_oRelatorio.PrepararDados()
1780:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1781:                 RETURN
1782:             ENDIF
1783:             IF !THIS.this_oRelatorio.Visualizar()
1784:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1785:                     "Erro na Visualiza" + CHR(231) + CHR(227) + "o")
1786:             ELSE
1787:                 THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
1788:             ENDIF
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + CHR(13) + ;
1791:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1792:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1793:         ENDTRY
1794:     ENDPROC
1795: 
1796:     PROCEDURE BtnImprimirClick()
1797:         LOCAL loc_oErro
1798:         TRY
1799:             THIS.FormParaRelatorio()
1800:             IF !THIS.this_oRelatorio.ValidarFiltros()
1801:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1802:                     "Campo Obrigat" + CHR(243) + "rio")
1803:                 RETURN
1804:             ENDIF
1805:             IF !THIS.this_oRelatorio.PrepararDados()
1806:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1807:                 RETURN
1808:             ENDIF
1809:             IF !THIS.this_oRelatorio.Imprimir(.T.)
1810:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro na Impress" + CHR(227) + "o")
1811:             ELSE
1812:                 THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
1813:             ENDIF
1814:         CATCH TO loc_oErro
1815:             MsgErro(loc_oErro.Message + CHR(13) + ;
1816:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1817:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1818:         ENDTRY
1819:     ENDPROC
1820: 
1821:     PROCEDURE BtnGerarExcelClick()
1822:         LOCAL loc_oErro
1823:         TRY
1824:             THIS.FormParaRelatorio()
1825:             IF !THIS.this_oRelatorio.ValidarFiltros()
1826:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1827:                     "Campo Obrigat" + CHR(243) + "rio")
1828:                 RETURN
1829:             ENDIF
1830:             IF !THIS.this_oRelatorio.PrepararDados()
1831:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1832:                 RETURN
1833:             ENDIF
1834:             IF !THIS.this_oRelatorio.Imprimir(.F.)
1835:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Documento")
1836:             ELSE
1837:                 THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
1838:             ENDIF
1839:         CATCH TO loc_oErro
1840:             MsgErro(loc_oErro.Message + CHR(13) + ;
1841:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1842:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1843:         ENDTRY
1844:     ENDPROC
1845: 
1846:     PROCEDURE BtnCancelarClick()
1847:         THIS.Release()
1848:     ENDPROC
1849: 
1850:     *==========================================================================
1851:     * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
1852:     *==========================================================================
1853: 
1854:     PROCEDURE BtnIncluirClick()
1855:         THIS.BtnVisualizarClick()
1856:     ENDPROC
1857: 
1858:     PROCEDURE BtnAlterarClick()
1859:         THIS.BtnVisualizarClick()
1860:     ENDPROC
1861: 
1862:     PROCEDURE BtnExcluirClick()
1863:         MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
1864:             CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
1865:             "Use Visualizar ou Imprimir.", "Aten" + CHR(231) + CHR(227) + "o")
1866:     ENDPROC
1867: 
1868:     PROCEDURE BtnBuscarClick()
1869:         THIS.BtnVisualizarClick()
1870:     ENDPROC
1871: 
1872:     PROCEDURE BtnEncerrarClick()
1873:         THIS.Release()
1874:     ENDPROC
1875: 
1876:     PROCEDURE BtnSairClick()
1877:         THIS.Release()
1878:     ENDPROC
1879: 
1880:     PROCEDURE BtnSalvarClick()
1881:         THIS.BtnImprimirClick()
1882:     ENDPROC
1883: 
1884:     PROTECTED PROCEDURE FormParaBO()
1885:         THIS.FormParaRelatorio()
1886:     ENDPROC
1887: 
1888:     PROTECTED PROCEDURE BOParaForm()
1889:         RETURN .T.
1890:     ENDPROC
1891: 
1892:     PROCEDURE HabilitarCampos(par_lHabilitar)
1893:         RETURN .T.
1894:     ENDPROC
1895: 
1896:     *--------------------------------------------------------------------------
1897:     * LimparCampos - Restaura valores padrao dos controles
1898:     *--------------------------------------------------------------------------
1899:     PROCEDURE LimparCampos()
1900:         LOCAL loc_oPg, loc_oErro
1901:         TRY
1902:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1903:             loc_oPg.txt_4c_CodProduto.Value    = ""
1904:             loc_oPg.txt_4c_DsProduto.Value     = ""
1905:             loc_oPg.txt_4c_CodLocal.Value      = ""
1906:             loc_oPg.txt_4c_DsLocal.Value       = ""
1907:             loc_oPg.txt_4c_Barra.Value         = 0
1908:             loc_oPg.optg_4c_TipoRel.Value      = 1
1909:             loc_oPg.optg_4c_TipoDif.Value      = 2
1910:             loc_oPg.optg_4c_TipoLeitura.Value  = 1
1911:             loc_oPg.optg_4c_TipoAnal.Value     = 1
1912:             loc_oPg.optg_4c_TpCusto.Value      = 2
1913:             loc_oPg.optg_4c_TpVenda.Value      = 1
1914:             loc_oPg.optg_4c_Foto.Value         = 2
1915:             loc_oPg.optg_4c_Etiq.Value         = 2
1916:             loc_oPg.optg_4c_Obs.Value          = 2
1917:             loc_oPg.optg_4c_Ctg.Value          = 2
1918:             loc_oPg.optg_4c_Col.Value          = 2
1919:             THIS.MudouTipoRelatorio()
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message, "Erro")
1922:         ENDTRY
1923:     ENDPROC
1924: 
1925:     PROCEDURE CarregarLista()
1926:         RETURN .T.
1927:     ENDPROC
1928: 
1929:     PROCEDURE AjustarBotoesPorModo()
1930:         TRY
1931:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
1932:                 IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
1933:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1934:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1935:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1936:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1937:                 ENDIF
1938:             ENDIF
1939:         CATCH TO loc_oErro
1940:             MsgErro(loc_oErro.Message, "Erro")
1941:         ENDTRY
1942:     ENDPROC
1943: 
1944:     PROCEDURE AlternarPagina(par_nPagina)
1945:         RETURN .T.
1946:     ENDPROC
1947: 
1948:     *--------------------------------------------------------------------------
1949:     * Destroy - Libera referencia ao BO (Custom nao tem Release, usar .NULL.)
1950:     *--------------------------------------------------------------------------
1951:     PROCEDURE Destroy()
1952:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1953:             THIS.this_oRelatorio = .NULL.
1954:         ENDIF
1955:         DODEFAULT()
1956:     ENDPROC
1957: 
1958: ENDDEFINE


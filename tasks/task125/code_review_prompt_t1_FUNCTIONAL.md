# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
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
- [GRID-WITH] Bloco WITH loc_oPagina.grd_4c_Operacaos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPagina.grd_4c_Operacaos.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreinr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1900 linhas total):

*-- Linhas 10 a 30:
10: *   - TipoDiferenca: Todos/Com Diferenca (apenas TipoRel=1)
11: *   - TipoLeitura: Leitura/Releitura (apenas TipoRel=2)
12: *   - txt_4c_CodProduto / txt_4c_DsProduto : Busca F4 em SigCdPro
13: *   - txt_4c_CodLocal / txt_4c_DsLocal     : Busca F4 em SigPrLcl
14: *   - txt_4c_Barra                         : Codigo de barras (TipoAnal=3)
15: *   - grd_4c_Operacaos                     : Grid de ocorrencias (TipoRel=4)
16: *
17: * Chamado com parametro:
18: *   DO FORM SIGREINR WITH lnNumBal
19: *
20: * Posicoes originais: Width=800, Height=461
21: * PageFrame.Top=85; posicao em Page1 = Top_original - 85
22: *==============================================================================
23: 
24: DEFINE CLASS Formsigreinr AS FormBase
25: 
26:     Height      = 461
27:     Width       = 800
28:     DataSession = 2
29:     ShowWindow  = 1
30:     WindowType  = 1

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
342:             ENDWITH
343:             WITH .Buttons(2)
344:                 .Caption   = "Anal" + CHR(237) + "tico"
345:                 .FontName  = "Tahoma"
346:                 .FontSize  = 8
347:                 .FontBold  = .F.
348:                 .BackStyle = 0
349:                 .Height    = 15
350:                 .Left      = 99
351:                 .Top       = 5
352:                 .Width     = 58
353:                 .AutoSize  = .T.
354:                 .ForeColor = RGB(90, 90, 90)
355:             ENDWITH
356:             WITH .Buttons(3)
357:                 .Caption   = "Etiqueta"
358:                 .FontName  = "Tahoma"

*-- Linhas 430 a 492:
430:                 .ForeColor = RGB(90, 90, 90)
431:             ENDWITH
432:         ENDWITH
433:         BINDEVENT(loc_oPagina.optg_4c_TipoRel, "InteractiveChange", THIS, "MudouTipoRelatorio")
434: 
435:         *-- Rotulo "Tipo :" (Say4: Top=140 -> Page1: 55)
436:         loc_oPagina.AddObject("lbl_4c_TipoAnal", "Label")
437:         WITH loc_oPagina.lbl_4c_TipoAnal
438:             .Top       = 55
439:             .Left      = 100
440:             .Width     = 32
441:             .Height    = 15
442:             .Caption   = "Tipo :"
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .AutoSize  = .T.
446:             .ForeColor = RGB(90, 90, 90)
447:             .BackStyle = 0
448:             .Visible   = .T.
449:         ENDWITH
450: 
451:         *-- OptionGroup TipoAnalitico (Top=135 -> Page1: 50)
452:         loc_oPagina.AddObject("optg_4c_TipoAnal", "OptionGroup")
453:         WITH loc_oPagina.optg_4c_TipoAnal
454:             .AutoSize      = .T.
455:             .ButtonCount   = 3
456:             .BackStyle     = 0
457:             .BorderStyle   = 0
458:             .Value         = 1
459:             .Height        = 25
460:             .Left          = 131
461:             .SpecialEffect = 1
462:             .Top           = 50
463:             .Width         = 287
464:             .Visible       = .T.
465: 
466:             WITH .Buttons(1)
467:                 .Caption   = "Produto"
468:                 .FontBold  = .F.
469:                 .BackStyle = 0
470:                 .Height    = 15
471:                 .Left      = 5
472:                 .Top       = 5
473:                 .Width     = 56
474:                 .AutoSize  = .T.
475:                 .ForeColor = RGB(90, 90, 90)
476:             ENDWITH
477:             WITH .Buttons(2)
478:                 .Caption   = "Local"
479:                 .FontName  = "Tahoma"
480:                 .FontSize  = 8
481:                 .FontBold  = .F.
482:                 .BackStyle = 0
483:                 .Height    = 15
484:                 .Left      = 99
485:                 .Top       = 5
486:                 .Width     = 42
487:                 .AutoSize  = .T.
488:                 .ForeColor = RGB(90, 90, 90)
489:             ENDWITH
490:             WITH .Buttons(3)
491:                 .Caption   = "Etiqueta"
492:                 .FontName  = "Tahoma"

*-- Linhas 501 a 670:
501:                 .ForeColor = RGB(90, 90, 90)
502:             ENDWITH
503:         ENDWITH
504:         BINDEVENT(loc_oPagina.optg_4c_TipoAnal, "InteractiveChange", THIS, "MudouTipoAnalitico")
505: 
506:         *-- Rotulo "Produto :" (lbl_codigo: Top=168 -> Page1: 83)
507:         loc_oPagina.AddObject("lbl_4c_Produto", "Label")
508:         WITH loc_oPagina.lbl_4c_Produto
509:             .Top       = 83
510:             .Left      = 82
511:             .Width     = 50
512:             .Height    = 15
513:             .Caption   = "Produto :"
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .AutoSize  = .T.
517:             .ForeColor = RGB(90, 90, 90)
518:             .BackStyle = 0
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         *-- TextBox Codigo Produto (get_cd_codigo: Top=163 -> Page1: 78)
523:         loc_oPagina.AddObject("txt_4c_CodProduto", "TextBox")
524:         WITH loc_oPagina.txt_4c_CodProduto
525:             .Top                = 78
526:             .Left               = 137
527:             .Width              = 108
528:             .Height             = 25
529:             .Value              = ""
530:             .MaxLength          = 14
531:             .FontName           = "Tahoma"
532:             .FontSize           = 8
533:             .Format             = "!"
534:             .SpecialEffect      = 1
535:             .BorderStyle        = 1
536:             .ForeColor          = RGB(0, 0, 0)
537:             .BackColor          = RGB(255, 255, 255)
538:             .DisabledBackColor  = RGB(255, 255, 255)
539:             .Enabled            = .F.
540:             .Visible            = .T.
541:         ENDWITH
542:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress",  THIS, "TeclaCodProduto")
543:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick",  THIS, "AbrirBuscaCodProduto")
544:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")
545: 
546:         *-- TextBox Descricao Produto (get_ds_codigo: Top=163 -> Page1: 78)
547:         loc_oPagina.AddObject("txt_4c_DsProduto", "TextBox")
548:         WITH loc_oPagina.txt_4c_DsProduto
549:             .Top                = 78
550:             .Left               = 247
551:             .Width              = 290
552:             .Height             = 25
553:             .Value              = ""
554:             .MaxLength          = 40
555:             .FontName           = "Tahoma"
556:             .FontSize           = 8
557:             .Format             = "!"
558:             .SpecialEffect      = 1
559:             .BorderStyle        = 1
560:             .ForeColor          = RGB(0, 0, 0)
561:             .BackColor          = RGB(255, 255, 255)
562:             .DisabledBackColor  = RGB(255, 255, 255)
563:             .Enabled            = .F.
564:             .Visible            = .T.
565:         ENDWITH
566:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress",  THIS, "TeclaDsProduto")
567:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "DblClick",  THIS, "AbrirBuscaDsProduto")
568:         BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress", THIS, "ValidarDsProduto")
569: 
570:         *-- Rotulo "Local :" (Say5: Top=195 -> Page1: 110)
571:         loc_oPagina.AddObject("lbl_4c_Local", "Label")
572:         WITH loc_oPagina.lbl_4c_Local
573:             .Top       = 110
574:             .Left      = 96
575:             .Width     = 36
576:             .Height    = 15
577:             .Caption   = "Local :"
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .AutoSize  = .T.
581:             .ForeColor = RGB(90, 90, 90)
582:             .BackStyle = 0
583:             .Visible   = .T.
584:         ENDWITH
585: 
586:         *-- TextBox Codigo Local (Get_Local: Top=190 -> Page1: 105)
587:         loc_oPagina.AddObject("txt_4c_CodLocal", "TextBox")
588:         WITH loc_oPagina.txt_4c_CodLocal
589:             .Top                = 105
590:             .Left               = 137
591:             .Width              = 108
592:             .Height             = 25
593:             .Value              = ""
594:             .MaxLength          = 10
595:             .FontName           = "Tahoma"
596:             .FontSize           = 8
597:             .Alignment          = 3
598:             .SpecialEffect      = 1
599:             .ForeColor          = RGB(0, 0, 0)
600:             .BackColor          = RGB(255, 255, 255)
601:             .DisabledBackColor  = RGB(255, 255, 255)
602:             .Enabled            = .F.
603:             .Visible            = .T.
604:         ENDWITH
605:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress",  THIS, "TeclaCodLocal")
606:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "DblClick",  THIS, "AbrirBuscaCodLocal")
607:         BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress", THIS, "ValidarCodLocal")
608: 
609:         *-- TextBox Descricao Local (get_Dlocal: Top=190 -> Page1: 105)
610:         loc_oPagina.AddObject("txt_4c_DsLocal", "TextBox")
611:         WITH loc_oPagina.txt_4c_DsLocal
612:             .Top                = 105
613:             .Left               = 247
614:             .Width              = 290
615:             .Height             = 25
616:             .Value              = ""
617:             .MaxLength          = 20
618:             .FontName           = "Tahoma"
619:             .FontSize           = 8
620:             .Alignment          = 3
621:             .SpecialEffect      = 1
622:             .ForeColor          = RGB(0, 0, 0)
623:             .BackColor          = RGB(255, 255, 255)
624:             .DisabledBackColor  = RGB(255, 255, 255)
625:             .Enabled            = .F.
626:             .Visible            = .T.
627:         ENDWITH
628:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress",  THIS, "TeclaDsLocal")
629:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "DblClick",  THIS, "AbrirBuscaDsLocal")
630:         BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress", THIS, "ValidarDsLocal")
631: 
632:         *-- Rotulo "Etiqueta :" (Say8: Top=222 -> Page1: 137)
633:         loc_oPagina.AddObject("lbl_4c_Etiqueta", "Label")
634:         WITH loc_oPagina.lbl_4c_Etiqueta
635:             .Top       = 137
636:             .Left      = 80
637:             .Width     = 52
638:             .Height    = 15
639:             .Caption   = "Etiqueta :"
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .AutoSize  = .T.
643:             .ForeColor = RGB(90, 90, 90)
644:             .BackStyle = 0
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         *-- TextBox Barra (Get_Barra: Top=217 -> Page1: 132)
649:         loc_oPagina.AddObject("txt_4c_Barra", "TextBox")
650:         WITH loc_oPagina.txt_4c_Barra
651:             .Top                = 132
652:             .Left               = 137
653:             .Width              = 108
654:             .Height             = 25
655:             .Value              = 0
656:             .InputMask          = "99999999999999"
657:             .Format             = "!"
658:             .FontName           = "Tahoma"
659:             .FontSize           = 8
660:             .BorderStyle        = 1
661:             .SpecialEffect      = 1
662:             .ForeColor          = RGB(0, 0, 0)
663:             .BackColor          = RGB(255, 255, 255)
664:             .DisabledBackColor  = RGB(255, 255, 255)
665:             .Enabled            = .F.
666:             .Visible            = .T.
667:         ENDWITH
668: 
669:         *-- Rotulo "Itens :" (Say2: Top=249 -> Page1: 164)
670:         loc_oPagina.AddObject("lbl_4c_Itens", "Label")

*-- Linhas 682 a 726:
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         *-- OptionGroup TipoDiferenca (TipoDiferen?a: Top=244 -> Page1: 159)
686:         loc_oPagina.AddObject("optg_4c_TipoDif", "OptionGroup")
687:         WITH loc_oPagina.optg_4c_TipoDif
688:             .AutoSize      = .T.
689:             .ButtonCount   = 2
690:             .BackStyle     = 0
691:             .BorderStyle   = 0
692:             .Value         = 2
693:             .Height        = 25
694:             .Left          = 131
695:             .SpecialEffect = 1
696:             .Top           = 159
697:             .Width         = 168
698:             .Visible       = .T.
699: 
700:             WITH .Buttons(1)
701:                 .Caption   = "Todos"
702:                 .FontBold  = .F.
703:                 .BackStyle = 0
704:                 .Height    = 15
705:                 .Left      = 5
706:                 .Top       = 5
707:                 .Width     = 47
708:                 .AutoSize  = .T.
709:                 .ForeColor = RGB(90, 90, 90)
710:             ENDWITH
711:             WITH .Buttons(2)
712:                 .Caption   = "Com Diferen" + CHR(231) + "a"
713:                 .FontName  = "Tahoma"
714:                 .FontSize  = 8
715:                 .FontBold  = .F.
716:                 .BackStyle = 0
717:                 .Height    = 15
718:                 .Left      = 75
719:                 .Top       = 5
720:                 .Width     = 88
721:                 .AutoSize  = .T.
722:                 .ForeColor = RGB(90, 90, 90)
723:             ENDWITH
724:         ENDWITH
725: 
726:         *-- Rotulo "Leitura :" (Say3: Top=271 -> Page1: 186)

*-- Linhas 739 a 783:
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         *-- OptionGroup TipoLeitura (Top=266 -> Page1: 181)
743:         loc_oPagina.AddObject("optg_4c_TipoLeitura", "OptionGroup")
744:         WITH loc_oPagina.optg_4c_TipoLeitura
745:             .AutoSize      = .T.
746:             .ButtonCount   = 2
747:             .BackStyle     = 0
748:             .BorderStyle   = 0
749:             .Value         = 1
750:             .Height        = 25
751:             .Left          = 131
752:             .SpecialEffect = 1
753:             .Top           = 181
754:             .Width         = 141
755:             .Visible       = .T.
756: 
757:             WITH .Buttons(1)
758:                 .Caption   = "Leitura"
759:                 .FontBold  = .F.
760:                 .BackStyle = 0
761:                 .Height    = 15
762:                 .Left      = 5
763:                 .Top       = 5
764:                 .Width     = 51
765:                 .AutoSize  = .T.
766:                 .ForeColor = RGB(90, 90, 90)
767:             ENDWITH
768:             WITH .Buttons(2)
769:                 .Caption   = "Releitura"
770:                 .FontName  = "Tahoma"
771:                 .FontSize  = 8
772:                 .FontBold  = .F.
773:                 .BackStyle = 0
774:                 .Height    = 15
775:                 .Left      = 75
776:                 .Top       = 5
777:                 .Width     = 61
778:                 .AutoSize  = .T.
779:                 .ForeColor = RGB(90, 90, 90)
780:             ENDWITH
781:         ENDWITH
782: 
783:         *-- Rotulo "Preco Custo :" (Say6: Top=294 -> Page1: 209)

*-- Linhas 796 a 840:
796:             .Visible   = .F.
797:         ENDWITH
798: 
799:         *-- OptionGroup TipoCusto (optgTpCusto: Top=288 -> Page1: 203)
800:         loc_oPagina.AddObject("optg_4c_TpCusto", "OptionGroup")
801:         WITH loc_oPagina.optg_4c_TpCusto
802:             .AutoSize      = .T.
803:             .ButtonCount   = 2
804:             .BackStyle     = 0
805:             .BorderStyle   = 0
806:             .Value         = 2
807:             .Height        = 27
808:             .Left          = 131
809:             .Top           = 203
810:             .Width         = 121
811:             .Visible       = .F.
812: 
813:             WITH .Buttons(1)
814:                 .Caption   = "\<Sim"
815:                 .FontBold  = .F.
816:                 .BackStyle = 0
817:                 .Height    = 17
818:                 .Left      = 5
819:                 .Top       = 5
820:                 .Width     = 40
821:                 .ForeColor = RGB(90, 90, 90)
822:             ENDWITH
823:             WITH .Buttons(2)
824:                 .Caption   = "\<N" + CHR(227) + "o"
825:                 .FontName  = "Tahoma"
826:                 .FontSize  = 8
827:                 .FontBold  = .F.
828:                 .BackStyle = 0
829:                 .Height    = 17
830:                 .Left      = 75
831:                 .Top       = 5
832:                 .Width     = 41
833:                 .ForeColor = RGB(90, 90, 90)
834:             ENDWITH
835:         ENDWITH
836: 
837:         *-- Rotulo "Preco Venda :" (Say7: Top=319 -> Page1: 234)
838:         loc_oPagina.AddObject("lbl_4c_TpVenda", "Label")
839:         WITH loc_oPagina.lbl_4c_TpVenda
840:             .Top       = 234

*-- Linhas 850 a 894:
850:             .Visible   = .T.
851:         ENDWITH
852: 
853:         *-- OptionGroup TipoVenda (optgTpVenda: Top=313 -> Page1: 228)
854:         loc_oPagina.AddObject("optg_4c_TpVenda", "OptionGroup")
855:         WITH loc_oPagina.optg_4c_TpVenda
856:             .AutoSize      = .T.
857:             .ButtonCount   = 2
858:             .BackStyle     = 0
859:             .BorderStyle   = 0
860:             .Value         = 1
861:             .Height        = 27
862:             .Left          = 131
863:             .Top           = 228
864:             .Width         = 121
865:             .Visible       = .T.
866: 
867:             WITH .Buttons(1)
868:                 .Caption   = "\<Sim"
869:                 .BackStyle = 0
870:                 .Height    = 17
871:                 .Left      = 5
872:                 .Top       = 5
873:                 .Width     = 40
874:                 .ForeColor = RGB(90, 90, 90)
875:             ENDWITH
876:             WITH .Buttons(2)
877:                 .Caption   = "\<N" + CHR(227) + "o"
878:                 .FontName  = "Tahoma"
879:                 .FontSize  = 8
880:                 .BackStyle = 0
881:                 .Height    = 17
882:                 .Left      = 75
883:                 .Top       = 5
884:                 .Width     = 41
885:                 .ForeColor = RGB(90, 90, 90)
886:             ENDWITH
887:         ENDWITH
888: 
889:         *-- Rotulo "Foto :" (Say9: Top=343 -> Page1: 258)
890:         loc_oPagina.AddObject("lbl_4c_Foto", "Label")
891:         WITH loc_oPagina.lbl_4c_Foto
892:             .Top       = 258
893:             .Left      = 98
894:             .Width     = 34

*-- Linhas 902 a 946:
902:             .Visible   = .T.
903:         ENDWITH
904: 
905:         *-- OptionGroup Foto (OptFoto: Top=337 -> Page1: 252)
906:         loc_oPagina.AddObject("optg_4c_Foto", "OptionGroup")
907:         WITH loc_oPagina.optg_4c_Foto
908:             .AutoSize      = .T.
909:             .ButtonCount   = 2
910:             .BackStyle     = 0
911:             .BorderStyle   = 0
912:             .Value         = 2
913:             .Height        = 27
914:             .Left          = 131
915:             .Top           = 252
916:             .Width         = 121
917:             .Visible       = .T.
918: 
919:             WITH .Buttons(1)
920:                 .Caption   = "\<Sim"
921:                 .BackStyle = 0
922:                 .Height    = 17
923:                 .Left      = 5
924:                 .Top       = 5
925:                 .Width     = 40
926:                 .ForeColor = RGB(90, 90, 90)
927:             ENDWITH
928:             WITH .Buttons(2)
929:                 .Caption   = "\<N" + CHR(227) + "o"
930:                 .FontName  = "Tahoma"
931:                 .FontSize  = 8
932:                 .BackStyle = 0
933:                 .Height    = 17
934:                 .Left      = 75
935:                 .Top       = 5
936:                 .Width     = 41
937:                 .ForeColor = RGB(90, 90, 90)
938:             ENDWITH
939:         ENDWITH
940: 
941:         *-- Rotulo "Etiquetas Faltando :" (Say10: Top=367 -> Page1: 282)
942:         loc_oPagina.AddObject("lbl_4c_Etiq", "Label")
943:         WITH loc_oPagina.lbl_4c_Etiq
944:             .Top       = 282
945:             .Left      = 30
946:             .Width     = 102

*-- Linhas 954 a 998:
954:             .Visible   = .T.
955:         ENDWITH
956: 
957:         *-- OptionGroup Etiquetas (OptEtiq: Top=361 -> Page1: 276)
958:         loc_oPagina.AddObject("optg_4c_Etiq", "OptionGroup")
959:         WITH loc_oPagina.optg_4c_Etiq
960:             .AutoSize      = .T.
961:             .ButtonCount   = 2
962:             .BackStyle     = 0
963:             .BorderStyle   = 0
964:             .Value         = 2
965:             .Height        = 27
966:             .Left          = 131
967:             .Top           = 276
968:             .Width         = 121
969:             .Visible       = .T.
970: 
971:             WITH .Buttons(1)
972:                 .Caption   = "\<Sim"
973:                 .BackStyle = 0
974:                 .Height    = 17
975:                 .Left      = 5
976:                 .Top       = 5
977:                 .Width     = 40
978:                 .ForeColor = RGB(90, 90, 90)
979:             ENDWITH
980:             WITH .Buttons(2)
981:                 .Caption   = "\<N" + CHR(227) + "o"
982:                 .FontName  = "Tahoma"
983:                 .FontSize  = 8
984:                 .BackStyle = 0
985:                 .Height    = 17
986:                 .Left      = 75
987:                 .Top       = 5
988:                 .Width     = 41
989:                 .ForeColor = RGB(90, 90, 90)
990:             ENDWITH
991:         ENDWITH
992: 
993:         *-- Rotulo "Mostrar Observacao :" (lblObs: Top=390 -> Page1: 305)
994:         loc_oPagina.AddObject("lbl_4c_Obs", "Label")
995:         WITH loc_oPagina.lbl_4c_Obs
996:             .Top       = 305
997:             .Left      = 22
998:             .Width     = 110

*-- Linhas 1006 a 1050:
1006:             .Visible   = .T.
1007:         ENDWITH
1008: 
1009:         *-- OptionGroup Observacao (OptObs: Top=384 -> Page1: 299)
1010:         loc_oPagina.AddObject("optg_4c_Obs", "OptionGroup")
1011:         WITH loc_oPagina.optg_4c_Obs
1012:             .AutoSize      = .T.
1013:             .ButtonCount   = 2
1014:             .BackStyle     = 0
1015:             .BorderStyle   = 0
1016:             .Value         = 2
1017:             .Height        = 27
1018:             .Left          = 131
1019:             .Top           = 299
1020:             .Width         = 121
1021:             .Visible       = .T.
1022: 
1023:             WITH .Buttons(1)
1024:                 .Caption   = "\<Sim"
1025:                 .BackStyle = 0
1026:                 .Height    = 17
1027:                 .Left      = 5
1028:                 .Top       = 5
1029:                 .Width     = 40
1030:                 .ForeColor = RGB(90, 90, 90)
1031:             ENDWITH
1032:             WITH .Buttons(2)
1033:                 .Caption   = "\<N" + CHR(227) + "o"
1034:                 .FontName  = "Tahoma"
1035:                 .FontSize  = 8
1036:                 .BackStyle = 0
1037:                 .Height    = 17
1038:                 .Left      = 75
1039:                 .Top       = 5
1040:                 .Width     = 41
1041:                 .ForeColor = RGB(90, 90, 90)
1042:             ENDWITH
1043:         ENDWITH
1044: 
1045:         *-- Rotulo "Mostrar Colecao :" (Say12: Top=411 -> Page1: 326)
1046:         loc_oPagina.AddObject("lbl_4c_Colecao", "Label")
1047:         WITH loc_oPagina.lbl_4c_Colecao
1048:             .Top       = 326
1049:             .Left      = 42
1050:             .Width     = 90

*-- Linhas 1058 a 1102:
1058:             .Visible   = .T.
1059:         ENDWITH
1060: 
1061:         *-- OptionGroup Colecao (OptCtg: Top=405 -> Page1: 320)
1062:         loc_oPagina.AddObject("optg_4c_Ctg", "OptionGroup")
1063:         WITH loc_oPagina.optg_4c_Ctg
1064:             .AutoSize      = .T.
1065:             .ButtonCount   = 2
1066:             .BackStyle     = 0
1067:             .BorderStyle   = 0
1068:             .Value         = 2
1069:             .Height        = 27
1070:             .Left          = 130
1071:             .Top           = 320
1072:             .Width         = 121
1073:             .Visible       = .T.
1074: 
1075:             WITH .Buttons(1)
1076:                 .Caption   = "\<Sim"
1077:                 .BackStyle = 0
1078:                 .Height    = 17
1079:                 .Left      = 5
1080:                 .Top       = 5
1081:                 .Width     = 40
1082:                 .ForeColor = RGB(90, 90, 90)
1083:             ENDWITH
1084:             WITH .Buttons(2)
1085:                 .Caption   = "\<N" + CHR(227) + "o"
1086:                 .FontName  = "Tahoma"
1087:                 .FontSize  = 8
1088:                 .BackStyle = 0
1089:                 .Height    = 17
1090:                 .Left      = 75
1091:                 .Top       = 5
1092:                 .Width     = 41
1093:                 .ForeColor = RGB(90, 90, 90)
1094:             ENDWITH
1095:         ENDWITH
1096: 
1097:         *-- Rotulo "Mostrar Categoria :" (Say13: Top=433 -> Page1: 348)
1098:         loc_oPagina.AddObject("lbl_4c_Ctg", "Label")
1099:         WITH loc_oPagina.lbl_4c_Ctg
1100:             .Top       = 348
1101:             .Left      = 33
1102:             .Width     = 99

*-- Linhas 1110 a 1154:
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         *-- OptionGroup Categoria (OptCol: Top=427 -> Page1: 342)
1114:         loc_oPagina.AddObject("optg_4c_Col", "OptionGroup")
1115:         WITH loc_oPagina.optg_4c_Col
1116:             .AutoSize      = .T.
1117:             .ButtonCount   = 2
1118:             .BackStyle     = 0
1119:             .BorderStyle   = 0
1120:             .Value         = 2
1121:             .Height        = 27
1122:             .Left          = 130
1123:             .Top           = 342
1124:             .Width         = 121
1125:             .Visible       = .T.
1126: 
1127:             WITH .Buttons(1)
1128:                 .Caption   = "\<Sim"
1129:                 .BackStyle = 0
1130:                 .Height    = 17
1131:                 .Left      = 5
1132:                 .Top       = 5
1133:                 .Width     = 40
1134:                 .ForeColor = RGB(90, 90, 90)
1135:             ENDWITH
1136:             WITH .Buttons(2)
1137:                 .Caption   = "\<N" + CHR(227) + "o"
1138:                 .FontName  = "Tahoma"
1139:                 .FontSize  = 8
1140:                 .BackStyle = 0
1141:                 .Height    = 17
1142:                 .Left      = 75
1143:                 .Top       = 5
1144:                 .Width     = 41
1145:                 .ForeColor = RGB(90, 90, 90)
1146:             ENDWITH
1147:         ENDWITH
1148: 
1149:         *-- Rotulo "Ocorrencias" (Say11: Top=227 -> Page1: 142, Left=348)
1150:         loc_oPagina.AddObject("lbl_4c_Ocorrencias", "Label")
1151:         WITH loc_oPagina.lbl_4c_Ocorrencias
1152:             .Top       = 142
1153:             .Left      = 348
1154:             .Width     = 72

*-- Linhas 1162 a 1183:
1162:             .BackStyle = 0
1163:             .Visible   = .F.
1164:         ENDWITH
1165: 
1166:         *-- Grid Operacoes (grdOperacaos: Top=242 -> Page1: 157, Left=348)
1167:         loc_oPagina.AddObject("grd_4c_Operacaos", "Grid")
1168:         WITH loc_oPagina.grd_4c_Operacaos
1169:             .Top               = 157
1170:             .Left              = 348
1171:             .Width             = 340
1172:             .Height            = 201
1173:             .ColumnCount       = 3
1174:             .RecordSource      = "CsOperacaos"
1175:             .AllowHeaderSizing = .F.
1176:             .AllowRowSizing    = .F.
1177:             .DeleteMark        = .F.
1178:             .HeaderHeight      = 0
1179:             .RecordMark        = .F.
1180:             .ScrollBars        = 2
1181:             .GridLineColor     = RGB(238, 238, 238)
1182:             .FontName          = "Tahoma"
1183:             .Visible           = .F.

*-- Linhas 1199 a 1900:
1199:             .Column3.ReadOnly       = .T.
1200:             .Column3.ControlSource  = "CsOperacaos.Descrs"
1201:         ENDWITH
1202: 
1203:         *-- Adiciona CheckBox na Column1 para marcar ocorrencias
1204:         loc_oPagina.grd_4c_Operacaos.Column1.AddObject("chk_4c_Marca", "CheckBox")
1205:         WITH loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca
1206:             .AutoSize      = .T.
1207:             .Alignment     = 0
1208:             .Caption       = ""
1209:             .BackStyle     = 0
1210:             .Visible       = .T.
1211:         ENDWITH
1212:         loc_oPagina.grd_4c_Operacaos.Column1.CurrentControl  = "chk_4c_Marca"
1213:         loc_oPagina.grd_4c_Operacaos.Column1.ControlSource   = "CsOperacaos.Marcas"
1214:         BINDEVENT(loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca, ;
1215:             "Click", THIS, "CliqueCheckOperacao")
1216: 
1217:         *-- Botao Selecionar Tudo (SelTudo: Top=279 -> Page1: 194, Left=696)
1218:         loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
1219:         WITH loc_oPagina.cmd_4c_SelTudo
1220:             .Top          = 194
1221:             .Left         = 696
1222:             .Width        = 40
1223:             .Height       = 40
1224:             .Caption      = ""
1225:             .FontName     = "Verdana"
1226:             .FontSize     = 8
1227:             .WordWrap     = .T.
1228:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1229:             .TabStop      = .F.
1230:             .ToolTipText  = "Seleciona Tudo"
1231:             .ForeColor    = RGB(36, 84, 155)
1232:             .BackColor    = RGB(255, 255, 255)
1233:             .Themes       = .F.
1234:             .Visible      = .F.
1235:         ENDWITH
1236:         BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "CliqueSelTudo")
1237: 
1238:         *-- Botao Cancela Tudo (apaga: Top=320 -> Page1: 235, Left=696)
1239:         loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
1240:         WITH loc_oPagina.cmd_4c_Apaga
1241:             .Top          = 235
1242:             .Left         = 696
1243:             .Width        = 40
1244:             .Height       = 40
1245:             .Caption      = ""
1246:             .FontName     = "Verdana"
1247:             .FontSize     = 8
1248:             .WordWrap     = .T.
1249:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1250:             .TabStop      = .F.
1251:             .ToolTipText  = "Cancela Tudo"
1252:             .ForeColor    = RGB(36, 84, 155)
1253:             .BackColor    = RGB(255, 255, 255)
1254:             .Themes       = .F.
1255:             .Visible      = .F.
1256:         ENDWITH
1257:         BINDEVENT(loc_oPagina.cmd_4c_Apaga, "Click", THIS, "CliqueApaga")
1258: 
1259:         *-- Controle de acesso via fChecaAcesso
1260:         THIS.AplicarAcessoControles()
1261:     ENDPROC
1262: 
1263:     *--------------------------------------------------------------------------
1264:     * ConfigurarPaginaDados - Nao aplicavel para form de relatorio (stub)
1265:     *--------------------------------------------------------------------------
1266:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1267:         RETURN .T.
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     * AplicarAcessoControles - Controla visibilidade conforme perfil do usuario
1272:     *   fChecaAcesso("SIGREINR", "CUSTO") -> mostra/oculta optg_4c_TpCusto
1273:     *   fChecaAcesso("SIGREINR", "RELATORIO") -> controla opcoes do TipoRel
1274:     *--------------------------------------------------------------------------
1275:     PROTECTED PROCEDURE AplicarAcessoControles()
1276:         LOCAL loc_oPg, loc_lCusto, loc_lRelatorio, loc_oErro
1277:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1278: 
1279:         TRY
1280:             loc_lCusto     = fChecaAcesso("SIGREINR", "CUSTO")
1281:             loc_lRelatorio = fChecaAcesso("SIGREINR", "RELATORIO")
1282:         CATCH TO loc_oErro
1283:             loc_lCusto     = .F.
1284:             loc_lRelatorio = .T.
1285:         ENDTRY
1286: 
1287:         *-- Custo: visivel apenas se tem acesso
1288:         loc_oPg.lbl_4c_TpCusto.Visible    = loc_lCusto
1289:         loc_oPg.optg_4c_TpCusto.Visible   = loc_lCusto
1290:         IF !loc_lCusto
1291:             loc_oPg.optg_4c_TpCusto.Value = 2
1292:         ENDIF
1293:         THIS.this_oRelatorio.this_lPermissaoCusto = loc_lCusto
1294: 
1295:         *-- Relatorio completo: oculta opcoes restrictas se sem acesso
1296:         IF !loc_lRelatorio
1297:             loc_oPg.optg_4c_TipoRel.Buttons(2).Visible = .F.
1298:             loc_oPg.optg_4c_TipoRel.Buttons(4).Visible = .F.
1299:             loc_oPg.optg_4c_TipoRel.Buttons(5).Visible = .F.
1300:             loc_oPg.optg_4c_TipoRel.Buttons(6).Visible = .F.
1301:             loc_oPg.optg_4c_TipoRel.Buttons(7).Visible = .F.
1302:         ENDIF
1303:         THIS.this_oRelatorio.this_lPermissaoRelatorio = loc_lRelatorio
1304:     ENDPROC
1305: 
1306:     *--------------------------------------------------------------------------
1307:     * FormParaRelatorio - Transfere valores dos controles para o BO
1308:     *--------------------------------------------------------------------------
1309:     PROTECTED PROCEDURE FormParaRelatorio()
1310:         LOCAL loc_oPg, loc_oErro
1311:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1312: 
1313:         TRY
1314:             WITH THIS.this_oRelatorio
1315:                 .this_nTipoRel    = loc_oPg.optg_4c_TipoRel.Value
1316:                 .this_nTipoDif    = loc_oPg.optg_4c_TipoDif.Value
1317:                 .this_nTipoLeitura = loc_oPg.optg_4c_TipoLeitura.Value
1318:                 .this_nTipoAnal   = loc_oPg.optg_4c_TipoAnal.Value
1319:                 .this_cProduto    = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1320:                 .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1321:                 .this_cLocal      = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1322:                 .this_cDsLocal    = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1323:                 .this_nBarra      = TRANSFORM(loc_oPg.txt_4c_Barra.Value)
1324:                 .this_nOptTpCusto = loc_oPg.optg_4c_TpCusto.Value
1325:                 .this_nOptTpVenda = loc_oPg.optg_4c_TpVenda.Value
1326:                 .this_nOptFoto    = loc_oPg.optg_4c_Foto.Value
1327:                 .this_nOptEtiq    = loc_oPg.optg_4c_Etiq.Value
1328:                 .this_nOptObs     = loc_oPg.optg_4c_Obs.Value
1329:                 .this_nOptCtg     = loc_oPg.optg_4c_Ctg.Value
1330:                 .this_nOptCol     = loc_oPg.optg_4c_Col.Value
1331:             ENDWITH
1332:         CATCH TO loc_oErro
1333:             MsgErro(loc_oErro.Message, "FormParaRelatorio")
1334:         ENDTRY
1335:     ENDPROC
1336: 
1337:     *--------------------------------------------------------------------------
1338:     * ValidarFiltros - Delega validacao ao BO (apos FormParaRelatorio)
1339:     *--------------------------------------------------------------------------
1340:     PROTECTED PROCEDURE ValidarFiltros()
1341:         RETURN THIS.this_oRelatorio.ValidarFiltros()
1342:     ENDPROC
1343: 
1344:     *==========================================================================
1345:     * CONTROLE DE ESTADO - INTERACTIVIDADE DOS FILTROS
1346:     *==========================================================================
1347: 
1348:     *--------------------------------------------------------------------------
1349:     * MudouTipoRelatorio - Atualiza estado dos controles conforme TipoRel
1350:     *   Espelha TipoRelat?rio.InteractiveChange do legado
1351:     *--------------------------------------------------------------------------
1352:     PROCEDURE MudouTipoRelatorio()
1353:         LOCAL loc_nTipo, loc_oPg, loc_lPermCusto
1354:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1355:         loc_nTipo = loc_oPg.optg_4c_TipoRel.Value
1356: 
1357:         *-- TipoDiferenca: apenas TipoRel=1
1358:         loc_oPg.optg_4c_TipoDif.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1359: 
1360:         *-- TipoLeitura e TipoAnalitico: apenas TipoRel=2
1361:         loc_oPg.optg_4c_TipoLeitura.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
1362:         loc_oPg.optg_4c_TipoAnal.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
1363: 
1364:         *-- TpCusto e TpVenda: apenas TipoRel=1, e se tem permissao
1365:         loc_lPermCusto = THIS.this_oRelatorio.this_lPermissaoCusto
1366:         loc_oPg.optg_4c_TpCusto.SetAll("Enabled", (loc_nTipo = 1 AND loc_lPermCusto), "OptionButton")
1367:         loc_oPg.optg_4c_TpVenda.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1368: 
1369:         *-- Foto e Etiq: apenas TipoRel=1
1370:         loc_oPg.optg_4c_Foto.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1371:         loc_oPg.optg_4c_Etiq.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
1372: 
1373:         *-- Campos Produto/Local/Barra: apenas TipoRel=2
1374:         loc_oPg.txt_4c_CodProduto.Enabled = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
1375:         loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
1376:         loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
1377:         loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
1378:         loc_oPg.txt_4c_Barra.Enabled      = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 3)
1379: 
1380:         *-- Grid de ocorrencias: apenas TipoRel=4
1381:         loc_oPg.grd_4c_Operacaos.Visible   = (loc_nTipo = 4)
1382:         loc_oPg.cmd_4c_Apaga.Visible       = (loc_nTipo = 4)
1383:         loc_oPg.cmd_4c_SelTudo.Visible     = (loc_nTipo = 4)
1384:         loc_oPg.lbl_4c_Ocorrencias.Visible = (loc_nTipo = 4)
1385: 
1386:         *-- Obs/Colecao/Categoria: apenas TipoRel=1 ou 3
1387:         loc_oPg.lbl_4c_Obs.Visible      = INLIST(loc_nTipo, 1, 3)
1388:         loc_oPg.optg_4c_Obs.Visible     = INLIST(loc_nTipo, 1, 3)
1389:         loc_oPg.lbl_4c_Colecao.Visible  = INLIST(loc_nTipo, 1, 3)
1390:         loc_oPg.optg_4c_Ctg.Visible     = INLIST(loc_nTipo, 1, 3)
1391:         loc_oPg.lbl_4c_Ctg.Visible      = INLIST(loc_nTipo, 1, 3)
1392:         loc_oPg.optg_4c_Col.Visible     = INLIST(loc_nTipo, 1, 3)
1393: 
1394:         THIS.Refresh()
1395:     ENDPROC
1396: 
1397:     *--------------------------------------------------------------------------
1398:     * MudouTipoAnalitico - Atualiza campos de filtro conforme TipoAnal
1399:     *   Espelha TipoAnal?tico.InteractiveChange do legado
1400:     *--------------------------------------------------------------------------
1401:     PROCEDURE MudouTipoAnalitico()
1402:         LOCAL loc_nAnal, loc_oPg
1403:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1404:         loc_nAnal = loc_oPg.optg_4c_TipoAnal.Value
1405: 
1406:         loc_oPg.txt_4c_CodProduto.Enabled = (loc_nAnal = 1)
1407:         loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nAnal = 1)
1408:         loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nAnal = 2)
1409:         loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nAnal = 2)
1410:         loc_oPg.txt_4c_Barra.Enabled      = (loc_nAnal = 3)
1411: 
1412:         DO CASE
1413:             CASE loc_nAnal = 1
1414:                 loc_oPg.txt_4c_CodProduto.SetFocus()
1415:             CASE loc_nAnal = 2
1416:                 loc_oPg.txt_4c_CodLocal.SetFocus()
1417:             OTHERWISE
1418:                 loc_oPg.txt_4c_Barra.SetFocus()
1419:         ENDCASE
1420:     ENDPROC
1421: 
1422:     *==========================================================================
1423:     * LOOKUPS - PRODUTO
1424:     *==========================================================================
1425: 
1426:     PROCEDURE TeclaCodProduto(par_nKeyCode, par_nShiftAltCtrl)
1427:         IF INLIST(par_nKeyCode, 115, 116)
1428:             THIS.AbrirBuscaCodProduto()
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     PROCEDURE TeclaDsProduto(par_nKeyCode, par_nShiftAltCtrl)
1433:         IF INLIST(par_nKeyCode, 115, 116)
1434:             THIS.AbrirBuscaDsProduto()
1435:         ENDIF
1436:     ENDPROC
1437: 
1438:     PROCEDURE AbrirBuscaCodProduto()
1439:         LOCAL loc_oPg, loc_cValor, loc_oForm, loc_nResult, loc_nBarra
1440:         LOCAL lnbarra_val, lcpros_val
1441:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1442:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1443: 
1444:         *-- Se valor e numerico, pode ser codigo de barras -> busca em SigOpEtq
1445:         loc_nBarra = VAL(loc_cValor)
1446:         IF loc_nBarra > 0
1447:             lnbarra_val = loc_nBarra
1448:             loc_nResult = SQLEXEC(gnConnHandle, ;
1449:                 "Select CPros From SigOpEtq Where CBars = ?lnbarra_val", ;
1450:                 "cursor_4c_EtqLkp")
1451:             IF loc_nResult > 0
1452:                 SELECT cursor_4c_EtqLkp
1453:                 GO TOP
1454:                 IF !EOF()
1455:                     loc_cValor = ALLTRIM(cursor_4c_EtqLkp.CPros)
1456:                 ENDIF
1457:                 USE IN cursor_4c_EtqLkp
1458:             ENDIF
1459:         ENDIF
1460: 
1461:         *-- Busca direta por codigo na SigCdPro
1462:         lcpros_val  = loc_cValor
1463:         loc_nResult = SQLEXEC(gnConnHandle, ;
1464:             "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
1465:             "cursor_4c_ProLkp")
1466:         IF loc_nResult > 0
1467:             SELECT cursor_4c_ProLkp
1468:             GO TOP
1469:             IF !EOF()
1470:                 loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProLkp.cpros)
1471:                 loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProLkp.dpros)
1472:                 USE IN cursor_4c_ProLkp
1473:                 RETURN
1474:             ENDIF
1475:             USE IN cursor_4c_ProLkp
1476:         ENDIF
1477: 
1478:         *-- Nao encontrado: abre FormBuscaAuxiliar
1479:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1480:             "SigCdPro", "cursor_4c_ProBusca", "cpros", loc_cValor, "Produtos")
1481:         IF ISNULL(loc_oForm)
1482:             RETURN
1483:         ENDIF
1484:         IF !loc_oForm.this_lAchouRegistro
1485:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1486:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1487:             loc_oForm.Show()
1488:         ENDIF
1489:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
1490:             loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
1491:             loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
1492:         ELSE
1493:             loc_oPg.txt_4c_CodProduto.Value = ""
1494:             loc_oPg.txt_4c_DsProduto.Value  = ""
1495:         ENDIF
1496:         IF USED("cursor_4c_ProBusca")
1497:             USE IN cursor_4c_ProBusca
1498:         ENDIF
1499:         loc_oForm.Release()
1500:     ENDPROC
1501: 
1502:     PROCEDURE AbrirBuscaDsProduto()
1503:         LOCAL loc_oPg, loc_cValor, loc_oForm
1504:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1505:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1506: 
1507:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1508:             "SigCdPro", "cursor_4c_ProBusca", "dpros", loc_cValor, "Produtos")
1509:         IF ISNULL(loc_oForm)
1510:             RETURN
1511:         ENDIF
1512:         IF !loc_oForm.this_lAchouRegistro
1513:             loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1514:             loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1515:             loc_oForm.Show()
1516:         ENDIF
1517:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
1518:             loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
1519:             loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
1520:         ELSE
1521:             loc_oPg.txt_4c_CodProduto.Value = ""
1522:             loc_oPg.txt_4c_DsProduto.Value  = ""
1523:         ENDIF
1524:         IF USED("cursor_4c_ProBusca")
1525:             USE IN cursor_4c_ProBusca
1526:         ENDIF
1527:         loc_oForm.Release()
1528:     ENDPROC
1529: 
1530:     PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
1531:         LOCAL loc_oPg, loc_cValor, lcpros_val, loc_nResult
1532:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1533:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
1534:         IF EMPTY(loc_cValor)
1535:             loc_oPg.txt_4c_DsProduto.Value = ""
1536:             RETURN
1537:         ENDIF
1538:         lcpros_val  = loc_cValor
1539:         loc_nResult = SQLEXEC(gnConnHandle, ;
1540:             "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
1541:             "cursor_4c_ProVal")
1542:         IF loc_nResult > 0
1543:             SELECT cursor_4c_ProVal
1544:             GO TOP
1545:             IF !EOF()
1546:                 loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProVal.cpros)
1547:                 loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProVal.dpros)
1548:             ELSE
1549:                 THIS.AbrirBuscaCodProduto()
1550:             ENDIF
1551:             USE IN cursor_4c_ProVal
1552:         ENDIF
1553:     ENDPROC
1554: 
1555:     PROCEDURE ValidarDsProduto(par_nKeyCode, par_nShiftAltCtrl)
1556:         LOCAL loc_oPg, loc_cValor
1557:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1558:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
1559:         IF EMPTY(loc_cValor)
1560:             loc_oPg.txt_4c_CodProduto.Value = ""
1561:             loc_oPg.txt_4c_DsProduto.Value  = ""
1562:             RETURN
1563:         ENDIF
1564:         THIS.AbrirBuscaDsProduto()
1565:     ENDPROC
1566: 
1567:     *==========================================================================
1568:     * LOOKUPS - LOCAL
1569:     *==========================================================================
1570: 
1571:     PROCEDURE TeclaCodLocal(par_nKeyCode, par_nShiftAltCtrl)
1572:         IF INLIST(par_nKeyCode, 115, 116)
1573:             THIS.AbrirBuscaCodLocal()
1574:         ENDIF
1575:     ENDPROC
1576: 
1577:     PROCEDURE TeclaDsLocal(par_nKeyCode, par_nShiftAltCtrl)
1578:         IF INLIST(par_nKeyCode, 115, 116)
1579:             THIS.AbrirBuscaDsLocal()
1580:         ENDIF
1581:     ENDPROC
1582: 
1583:     PROCEDURE AbrirBuscaCodLocal()
1584:         LOCAL loc_oPg, loc_cValor, loc_oForm
1585:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1586:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1587: 
1588:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1589:             "SigPrLcl", "cursor_4c_LclBusca", "codigos", loc_cValor, "Locais")
1590:         IF ISNULL(loc_oForm)
1591:             RETURN
1592:         ENDIF
1593:         IF !loc_oForm.this_lAchouRegistro
1594:             loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
1595:             loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
1596:             loc_oForm.Show()
1597:         ENDIF
1598:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
1599:             loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
1600:             loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
1601:         ELSE
1602:             loc_oPg.txt_4c_CodLocal.Value = ""
1603:             loc_oPg.txt_4c_DsLocal.Value  = ""
1604:         ENDIF
1605:         IF USED("cursor_4c_LclBusca")
1606:             USE IN cursor_4c_LclBusca
1607:         ENDIF
1608:         loc_oForm.Release()
1609:     ENDPROC
1610: 
1611:     PROCEDURE AbrirBuscaDsLocal()
1612:         LOCAL loc_oPg, loc_cValor, loc_oForm
1613:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1614:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1615: 
1616:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1617:             "SigPrLcl", "cursor_4c_LclBusca", "descricaos", loc_cValor, "Locais")
1618:         IF ISNULL(loc_oForm)
1619:             RETURN
1620:         ENDIF
1621:         IF !loc_oForm.this_lAchouRegistro
1622:             loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
1623:             loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
1624:             loc_oForm.Show()
1625:         ENDIF
1626:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
1627:             loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
1628:             loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
1629:         ELSE
1630:             loc_oPg.txt_4c_CodLocal.Value = ""
1631:             loc_oPg.txt_4c_DsLocal.Value  = ""
1632:         ENDIF
1633:         IF USED("cursor_4c_LclBusca")
1634:             USE IN cursor_4c_LclBusca
1635:         ENDIF
1636:         loc_oForm.Release()
1637:     ENDPROC
1638: 
1639:     PROCEDURE ValidarCodLocal(par_nKeyCode, par_nShiftAltCtrl)
1640:         LOCAL loc_oPg, loc_cValor, lcodigos_val, loc_nResult
1641:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1642:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
1643:         IF EMPTY(loc_cValor)
1644:             loc_oPg.txt_4c_DsLocal.Value = ""
1645:             RETURN
1646:         ENDIF
1647:         lcodigos_val = loc_cValor
1648:         loc_nResult  = SQLEXEC(gnConnHandle, ;
1649:             "Select codigos,descricaos From SigPrLcl Where codigos = ?lcodigos_val", ;
1650:             "cursor_4c_LclVal")
1651:         IF loc_nResult > 0
1652:             SELECT cursor_4c_LclVal
1653:             GO TOP
1654:             IF !EOF()
1655:                 loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclVal.codigos)
1656:                 loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclVal.descricaos)
1657:             ELSE
1658:                 THIS.AbrirBuscaCodLocal()
1659:             ENDIF
1660:             USE IN cursor_4c_LclVal
1661:         ENDIF
1662:     ENDPROC
1663: 
1664:     PROCEDURE ValidarDsLocal(par_nKeyCode, par_nShiftAltCtrl)
1665:         LOCAL loc_oPg, loc_cValor
1666:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1667:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
1668:         IF EMPTY(loc_cValor)
1669:             loc_oPg.txt_4c_CodLocal.Value = ""
1670:             loc_oPg.txt_4c_DsLocal.Value  = ""
1671:             RETURN
1672:         ENDIF
1673:         THIS.AbrirBuscaDsLocal()
1674:     ENDPROC
1675: 
1676:     *==========================================================================
1677:     * GRID OCORRENCIAS
1678:     *==========================================================================
1679: 
1680:     PROCEDURE CliqueCheckOperacao()
1681:         IF USED("CsOperacaos")
1682:             SELECT CsOperacaos
1683:             REPLACE Marcas WITH IIF(CsOperacaos.Marcas = 0, 1, 0) IN CsOperacaos
1684:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1685:         ENDIF
1686:     ENDPROC
1687: 
1688:     PROCEDURE CliqueSelTudo()
1689:         IF USED("CsOperacaos")
1690:             SELECT CsOperacaos
1691:             UPDATE CsOperacaos SET Marcas = 1
1692:             GO TOP
1693:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1694:             THIS.Refresh()
1695:         ENDIF
1696:     ENDPROC
1697: 
1698:     PROCEDURE CliqueApaga()
1699:         IF USED("CsOperacaos")
1700:             SELECT CsOperacaos
1701:             UPDATE CsOperacaos SET Marcas = 0
1702:             GO TOP
1703:             THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
1704:             THIS.Refresh()
1705:         ENDIF
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * ACOES DOS BOTOES DO RELATORIO
1710:     *==========================================================================
1711: 
1712:     PROCEDURE BtnVisualizarClick()
1713:         LOCAL loc_oErro
1714:         TRY
1715:             THIS.FormParaRelatorio()
1716:             IF !THIS.this_oRelatorio.ValidarFiltros()
1717:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1718:                     "Campo Obrigat" + CHR(243) + "rio")
1719:                 RETURN
1720:             ENDIF
1721:             IF !THIS.this_oRelatorio.PrepararDados()
1722:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1723:                 RETURN
1724:             ENDIF
1725:             IF !THIS.this_oRelatorio.Visualizar()
1726:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1727:                     "Erro na Visualiza" + CHR(231) + CHR(227) + "o")
1728:             ELSE
1729:                 THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
1730:             ENDIF
1731:         CATCH TO loc_oErro
1732:             MsgErro(loc_oErro.Message + CHR(13) + ;
1733:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1734:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1735:         ENDTRY
1736:     ENDPROC
1737: 
1738:     PROCEDURE BtnImprimirClick()
1739:         LOCAL loc_oErro
1740:         TRY
1741:             THIS.FormParaRelatorio()
1742:             IF !THIS.this_oRelatorio.ValidarFiltros()
1743:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1744:                     "Campo Obrigat" + CHR(243) + "rio")
1745:                 RETURN
1746:             ENDIF
1747:             IF !THIS.this_oRelatorio.PrepararDados()
1748:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1749:                 RETURN
1750:             ENDIF
1751:             IF !THIS.this_oRelatorio.Imprimir(.T.)
1752:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro na Impress" + CHR(227) + "o")
1753:             ELSE
1754:                 THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
1755:             ENDIF
1756:         CATCH TO loc_oErro
1757:             MsgErro(loc_oErro.Message + CHR(13) + ;
1758:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1759:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1760:         ENDTRY
1761:     ENDPROC
1762: 
1763:     PROCEDURE BtnGerarExcelClick()
1764:         LOCAL loc_oErro
1765:         TRY
1766:             THIS.FormParaRelatorio()
1767:             IF !THIS.this_oRelatorio.ValidarFiltros()
1768:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
1769:                     "Campo Obrigat" + CHR(243) + "rio")
1770:                 RETURN
1771:             ENDIF
1772:             IF !THIS.this_oRelatorio.PrepararDados()
1773:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
1774:                 RETURN
1775:             ENDIF
1776:             IF !THIS.this_oRelatorio.Imprimir(.F.)
1777:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Documento")
1778:             ELSE
1779:                 THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
1780:             ENDIF
1781:         CATCH TO loc_oErro
1782:             MsgErro(loc_oErro.Message + CHR(13) + ;
1783:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1784:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1785:         ENDTRY
1786:     ENDPROC
1787: 
1788:     PROCEDURE BtnCancelarClick()
1789:         THIS.Release()
1790:     ENDPROC
1791: 
1792:     *==========================================================================
1793:     * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
1794:     *==========================================================================
1795: 
1796:     PROCEDURE BtnIncluirClick()
1797:         THIS.BtnVisualizarClick()
1798:     ENDPROC
1799: 
1800:     PROCEDURE BtnAlterarClick()
1801:         THIS.BtnVisualizarClick()
1802:     ENDPROC
1803: 
1804:     PROCEDURE BtnExcluirClick()
1805:         MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
1806:             CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
1807:             "Use Visualizar ou Imprimir.", "Aten" + CHR(231) + CHR(227) + "o")
1808:     ENDPROC
1809: 
1810:     PROCEDURE BtnBuscarClick()
1811:         THIS.BtnVisualizarClick()
1812:     ENDPROC
1813: 
1814:     PROCEDURE BtnEncerrarClick()
1815:         THIS.Release()
1816:     ENDPROC
1817: 
1818:     PROCEDURE BtnSairClick()
1819:         THIS.Release()
1820:     ENDPROC
1821: 
1822:     PROCEDURE BtnSalvarClick()
1823:         THIS.BtnImprimirClick()
1824:     ENDPROC
1825: 
1826:     PROTECTED PROCEDURE FormParaBO()
1827:         THIS.FormParaRelatorio()
1828:     ENDPROC
1829: 
1830:     PROTECTED PROCEDURE BOParaForm()
1831:         RETURN .T.
1832:     ENDPROC
1833: 
1834:     PROCEDURE HabilitarCampos(par_lHabilitar)
1835:         RETURN .T.
1836:     ENDPROC
1837: 
1838:     *--------------------------------------------------------------------------
1839:     * LimparCampos - Restaura valores padrao dos controles
1840:     *--------------------------------------------------------------------------
1841:     PROCEDURE LimparCampos()
1842:         LOCAL loc_oPg, loc_oErro
1843:         TRY
1844:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1845:             loc_oPg.txt_4c_CodProduto.Value    = ""
1846:             loc_oPg.txt_4c_DsProduto.Value     = ""
1847:             loc_oPg.txt_4c_CodLocal.Value      = ""
1848:             loc_oPg.txt_4c_DsLocal.Value       = ""
1849:             loc_oPg.txt_4c_Barra.Value         = 0
1850:             loc_oPg.optg_4c_TipoRel.Value      = 1
1851:             loc_oPg.optg_4c_TipoDif.Value      = 2
1852:             loc_oPg.optg_4c_TipoLeitura.Value  = 1
1853:             loc_oPg.optg_4c_TipoAnal.Value     = 1
1854:             loc_oPg.optg_4c_TpCusto.Value      = 2
1855:             loc_oPg.optg_4c_TpVenda.Value      = 1
1856:             loc_oPg.optg_4c_Foto.Value         = 2
1857:             loc_oPg.optg_4c_Etiq.Value         = 2
1858:             loc_oPg.optg_4c_Obs.Value          = 2
1859:             loc_oPg.optg_4c_Ctg.Value          = 2
1860:             loc_oPg.optg_4c_Col.Value          = 2
1861:             THIS.MudouTipoRelatorio()
1862:         CATCH TO loc_oErro
1863:             MsgErro(loc_oErro.Message, "Erro")
1864:         ENDTRY
1865:     ENDPROC
1866: 
1867:     PROCEDURE CarregarLista()
1868:         RETURN .T.
1869:     ENDPROC
1870: 
1871:     PROCEDURE AjustarBotoesPorModo()
1872:         TRY
1873:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
1874:                 IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
1875:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1876:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1877:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1878:                     THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1879:                 ENDIF
1880:             ENDIF
1881:         CATCH TO loc_oErro
1882:             MsgErro(loc_oErro.Message, "Erro")
1883:         ENDTRY
1884:     ENDPROC
1885: 
1886:     PROCEDURE AlternarPagina(par_nPagina)
1887:         RETURN .T.
1888:     ENDPROC
1889: 
1890:     *--------------------------------------------------------------------------
1891:     * Destroy - Libera referencia ao BO (Custom nao tem Release, usar .NULL.)
1892:     *--------------------------------------------------------------------------
1893:     PROCEDURE Destroy()
1894:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1895:             THIS.this_oRelatorio = .NULL.
1896:         ENDIF
1897:         DODEFAULT()
1898:     ENDPROC
1899: 
1900: ENDDEFINE


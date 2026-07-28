# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (30)
- [BINDEVENT-PARAMS] Handler 'ContFrtLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ContFrtLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ContSegLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ContSegLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ContDaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ContDaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=315 vs migrado 'cbo_4c_Combo2' Top=27 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=380 vs migrado 'cbo_4c_Combo2' Left=642 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opc_situacao' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=243 vs migrado 'obj_4c_Opc_situacao' Left=0 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=368 vs migrado 'obj_4c_Fwoption1' Top=0 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption1' Left=0 (diff=686px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=399 vs migrado 'obj_4c_Fwoption2' Top=0 (diff=399px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption2' Left=0 (diff=686px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAgrupas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=79 vs migrado 'obj_4c_OptAgrupas' Top=0 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAgrupas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_OptAgrupas' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optZeradas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=103 vs migrado 'obj_4c_OptZeradas' Top=0 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optZeradas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_OptZeradas' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=127 vs migrado 'obj_4c_Fwoption1' Top=0 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_Fwoption1' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optutilvars' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=150 vs migrado 'obj_4c_Optutilvars' Top=0 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optutilvars' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_Optutilvars' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=233 vs migrado 'obj_4c_Fwoption2' Top=0 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption2' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=253 vs migrado 'obj_4c_Fwoption3' Top=0 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption3' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=272 vs migrado 'obj_4c_Fwoption4' Top=0 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption4' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=292 vs migrado 'obj_4c_Fwoption5' Top=0 (diff=292px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption5' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=312 vs migrado 'obj_4c_Fwoption6' Top=0 (diff=312px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption6' Left=0 (diff=231px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3903 linhas total):

*-- Linhas 24 a 134:
24:     this_cModoAtual      = "LISTA"
25: 
26:     *==========================================================================
27:     PROCEDURE Init()
28:     *==========================================================================
29:         LOCAL loc_lSucesso
30:         loc_lSucesso = .F.
31:         TRY
32:             loc_lSucesso = DODEFAULT()
33:         CATCH TO loc_oErro
34:             MsgErro(loc_oErro.Message, "Erro ao inicializar Formcfo")
35:         ENDTRY
36:         RETURN loc_lSucesso
37:     ENDPROC
38: 
39:     *==========================================================================
40:     PROTECTED PROCEDURE InicializarForm()
41:     *==========================================================================
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MsgErro("Erro ao criar cfoBO", "Erro")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
54:                     THIS.CarregarLista()
55:                 ENDIF
56: 
57:                 THIS.pgf_4c_Paginas.Visible = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual = "LISTA"
60:                 loc_lSucesso = .T.
61:             ENDIF
62:         CATCH TO loc_oErro
63:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
64:         ENDTRY
65: 
66:         RETURN loc_lSucesso
67:     ENDPROC
68: 
69:     *==========================================================================
70:     PROTECTED PROCEDURE ConfigurarPageFrame()
71:     *==========================================================================
72:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
73:         WITH THIS.pgf_4c_Paginas
74:             .PageCount  = 2
75:             .Top        = -29
76:             .Left       = 0
77:             .Width      = THIS.Width
78:             .Height     = THIS.Height + 29
79:             .Tabs       = .F.
80:             .Visible    = .T.
81:             .Page1.Caption   = "Lista"
82:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
83:             .Page2.Caption   = "Dados"
84:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:             .Page1.BackColor = RGB(224, 223, 227)
86:             .Page2.BackColor = RGB(224, 223, 227)
87:         ENDWITH
88: 
89:         THIS.ConfigurarPaginaLista()
90:         THIS.ConfigurarPaginaDados()
91:     ENDPROC
92: 
93:     *==========================================================================
94:     PROTECTED PROCEDURE ConfigurarPaginaLista()
95:     *==========================================================================
96:         LOCAL loc_oPagina
97:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
98: 
99:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
100:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101: 
102:         *-- Container cabecalho cinza superior (cntSombra no legado)
103:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH loc_oPagina.cnt_4c_Cabecalho
105:             .Top         = 31
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackColor   = RGB(100, 100, 100)
110:             .BorderWidth = 0
111:             .SpecialEffect = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Caption   = "Cadastro de CFOP"
117:                 .Top       = 15
118:                 .Left      = 10
119:                 .Width     = THIS.Parent.Width - 20
120:                 .Height    = 40
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 16
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .AutoSize  = .F.
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Caption   = "Cadastro de CFOP"
133:                 .Top       = 18
134:                 .Left      = 10

*-- Linhas 371 a 428:
371:             .Visible            = .T.
372:         ENDWITH
373: 
374:         *-- BINDEVENTs para botoes CRUD e auxiliares
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
381:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
382:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *==========================================================================
388:     PROTECTED PROCEDURE ConfigurarPaginaDados()
389:     *==========================================================================
390:         LOCAL loc_oPagina
391:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
392: 
393:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
394:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
395: 
396:         *-- Cabecalho cinza (identico ao da Page1 Lista)
397:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
398:         WITH loc_oPagina.cnt_4c_Cabecalho
399:             .Top           = 29
400:             .Left          = 0
401:             .Width         = THIS.Width
402:             .Height        = 80
403:             .BackColor     = RGB(100, 100, 100)
404:             .BorderWidth   = 0
405:             .SpecialEffect = 0
406:             .Visible       = .T.
407: 
408:             .AddObject("lbl_4c_Sombra", "Label")
409:             WITH .lbl_4c_Sombra
410:                 .Caption   = "Cadastro de CFOP"
411:                 .Top       = 15
412:                 .Left      = 10
413:                 .Width     = THIS.Parent.Width - 20
414:                 .Height    = 40
415:                 .FontName  = "Tahoma"
416:                 .FontSize  = 16
417:                 .FontBold  = .T.
418:                 .ForeColor = RGB(0, 0, 0)
419:                 .BackStyle = 0
420:                 .AutoSize  = .F.
421:                 .Visible   = .T.
422:             ENDWITH
423: 
424:             .AddObject("lbl_4c_Titulo", "Label")
425:             WITH .lbl_4c_Titulo
426:                 .Caption   = "Cadastro de CFOP"
427:                 .Top       = 18
428:                 .Left      = 10

*-- Linhas 469 a 560:
469:             .ForeColor       = RGB(90, 90, 90)
470:             .Visible         = .T.
471:         ENDWITH
472:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
473: 
474:         *-- Botao Cancelar / Encerrar edicao
475:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
479:             .PicturePosition = 13
480:             .Width           = 75
481:             .Height          = 75
482:             .Left            = 83
483:             .Top             = 5
484:             .FontName        = "Tahoma"
485:             .FontSize        = 8
486:             .Themes          = .F.
487:             .SpecialEffect   = 0
488:             .BackColor       = RGB(255, 255, 255)
489:             .ForeColor       = RGB(90, 90, 90)
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
493: 
494:         *-- PageFrame interno (PagDados no legado) - top=120+29=149
495:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
496:         WITH loc_oPagina.pgf_4c_PagDados
497:             .PageCount       = 2
498:             .Top             = 149
499:             .Left            = -1
500:             .Width           = 998
501:             .Height          = 730
502:             .Tabs            = .T.
503:             .Visible         = .T.
504:             .Page1.Caption   = "Dados CFOP"
505:             .Page2.Caption   = "Contabilidade"
506:             .Page1.BackColor = RGB(224, 223, 227)
507:             .Page2.BackColor = RGB(224, 223, 227)
508:         ENDWITH
509: 
510:         THIS.ConfigurarPgPage1()
511:         THIS.ConfigurarPgPage2()
512: 
513: 
514:         THIS.TornarControlesVisiveis(loc_oPagina)
515:     ENDPROC
516: 
517:     *==========================================================================
518:     * ConfigurarPgPage1 - Configura controles da Page1 (Dados CFOP)
519:     *==========================================================================
520:     PROTECTED PROCEDURE ConfigurarPgPage1()
521:         LOCAL loc_oPage1
522:         loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
523: 
524: 
525:         *-- Separadores horizontais
526:         loc_oPage1.AddObject("shp_4c_Shp01", "Shape")
527:         WITH loc_oPage1.shp_4c_Shp01
528:             .Top         = 92
529:             .Left        = 3
530:             .Width       = 984
531:             .Height      = 1
532:             .BackColor   = RGB(128, 128, 128)
533:             .BorderColor = RGB(128, 128, 128)
534:             .Visible     = .T.
535:         ENDWITH
536: 
537:         loc_oPage1.AddObject("shp_4c_Shp03", "Shape")
538:         WITH loc_oPage1.shp_4c_Shp03
539:             .Top         = 236
540:             .Left        = 3
541:             .Width       = 984
542:             .Height      = 1
543:             .BackColor   = RGB(128, 128, 128)
544:             .BorderColor = RGB(128, 128, 128)
545:             .Visible     = .T.
546:         ENDWITH
547: 
548:         *-- Separador vertical NF-e
549:         loc_oPage1.AddObject("shp_4c_Shape1", "Shape")
550:         WITH loc_oPage1.shp_4c_Shape1
551:             .Top         = 243
552:             .Left        = 488
553:             .Width       = 1
554:             .Height      = 206
555:             .BackColor   = RGB(128, 128, 128)
556:             .BorderColor = RGB(128, 128, 128)
557:             .Visible     = .T.
558:         ENDWITH
559: 
560:         *-- Label: Codigo

*-- Linhas 586 a 629:
586:         ENDWITH
587: 
588:         *-- opc_situacao - situas (0=Ativo 1=Inativo)
589:         loc_oPage1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
590:         WITH loc_oPage1.obj_4c_Opc_situacao
591:             .Top         = 11
592:             .Left        = 243
593:             .Width       = 137
594:             .Height      = 17
595:             .ButtonCount = 2
596:             .BackStyle   = 0
597:             .Value       = 1
598:             .Visible     = .T.
599: 
600:             WITH .Buttons(1)
601:                 .Caption   = "Ativo"
602:                 .Width     = 65
603:                 .Height    = 17
604:                 .Left      = 0
605:                 .Top       = 0
606:                 .BackStyle = 0
607:                 .Visible   = .T.
608:             ENDWITH
609: 
610:             WITH .Buttons(2)
611:                 .Caption   = "Inativo"
612:                 .Width     = 65
613:                 .Height    = 17
614:                 .Left      = 67
615:                 .Top       = 0
616:                 .BackStyle = 0
617:                 .FontName  = "Tahoma"
618:                 .FontSize  = 8
619:                 .Visible   = .T.
620:             ENDWITH
621:         ENDWITH
622: 
623:         *-- Label: Operacao
624:         loc_oPage1.AddObject("lbl_4c_Label3", "Label")
625:         WITH loc_oPage1.lbl_4c_Label3
626:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
627:             .Top       = 11
628:             .Left      = 393
629:             .Width     = 56

*-- Linhas 1924 a 1967:
1924:         ENDWITH
1925: 
1926:         *-- Fwoption1 - ctissqn numeric(1,0), 5 buttons (0-4)
1927:         loc_oPage1.AddObject("obj_4c_Fwoption1", "OptionGroup")
1928:         WITH loc_oPage1.obj_4c_Fwoption1
1929:             .Top         = 368
1930:             .Left        = 686
1931:             .Width       = 297
1932:             .Height      = 34
1933:             .ButtonCount = 5
1934:             .BackStyle   = 0
1935:             .Value       = 1
1936:             .Visible     = .T.
1937: 
1938:             WITH .Buttons(1)
1939:                 .Caption   = "0"
1940:                 .Width     = 55
1941:                 .Height    = 17
1942:                 .Left      = 0
1943:                 .Top       = 0
1944:                 .BackStyle = 0
1945:                 .Visible   = .T.
1946:             ENDWITH
1947: 
1948:             WITH .Buttons(2)
1949:                 .Caption   = "1"
1950:                 .Width     = 55
1951:                 .Height    = 17
1952:                 .Left      = 57
1953:                 .Top       = 0
1954:                 .BackStyle = 0
1955:                 .FontName  = "Tahoma"
1956:                 .FontSize  = 8
1957:                 .Visible   = .T.
1958:             ENDWITH
1959: 
1960:             WITH .Buttons(3)
1961:                 .Caption   = "2"
1962:                 .Width     = 55
1963:                 .Height    = 17
1964:                 .Left      = 114
1965:                 .Top       = 0
1966:                 .BackStyle = 0
1967:                 .FontName  = "Tahoma"

*-- Linhas 2009 a 2052:
2009:         ENDWITH
2010: 
2011:         *-- Fwoption2 - rettribs numeric(1,0), 2 buttons Sim/Nao
2012:         loc_oPage1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2013:         WITH loc_oPage1.obj_4c_Fwoption2
2014:             .Top         = 399
2015:             .Left        = 686
2016:             .Width       = 95
2017:             .Height      = 25
2018:             .ButtonCount = 2
2019:             .BackStyle   = 0
2020:             .Value       = 2
2021:             .Visible     = .T.
2022: 
2023:             WITH .Buttons(1)
2024:                 .Caption   = "Sim"
2025:                 .Width     = 44
2026:                 .Height    = 17
2027:                 .Left      = 0
2028:                 .Top       = 0
2029:                 .BackStyle = 0
2030:                 .Visible   = .T.
2031:             ENDWITH
2032: 
2033:             WITH .Buttons(2)
2034:                 .Caption   = "N" + CHR(227) + "o"
2035:                 .Width     = 44
2036:                 .Height    = 17
2037:                 .Left      = 46
2038:                 .Top       = 0
2039:                 .BackStyle = 0
2040:                 .FontName  = "Tahoma"
2041:                 .FontSize  = 8
2042:                 .Visible   = .T.
2043:             ENDWITH
2044:         ENDWITH
2045: 
2046:         *-- Label: Aliquota do II
2047:         loc_oPage1.AddObject("lbl_4c_Label47", "Label")
2048:         WITH loc_oPage1.lbl_4c_Label47
2049:             .Caption   = "Al" + CHR(237) + "quota do II :"
2050:             .Top       = 404
2051:             .Left      = 839
2052:             .Width     = 74

*-- Linhas 2114 a 2171:
2114:             .Visible   = .T.
2115:         ENDWITH
2116: 
2117:         *-- BINDEVENTs para campos com lookup (F4/F5 + DblClick)
2118:         BINDEVENT(loc_oPage1.txt_4c_CfoST60,  "KeyPress", THIS, "CfoST60LookupKeyPress")
2119:         BINDEVENT(loc_oPage1.txt_4c_CfoST60,  "DblClick", THIS, "CfoST60LookupDblClick")
2120:         BINDEVENT(loc_oPage1.txt_4c_CfoST,    "KeyPress", THIS, "CfoSTLookupKeyPress")
2121:         BINDEVENT(loc_oPage1.txt_4c_CfoST,    "DblClick", THIS, "CfoSTLookupDblClick")
2122:         BINDEVENT(loc_oPage1.txt_4c_Cfdest,   "KeyPress", THIS, "CfdestLookupKeyPress")
2123:         BINDEVENT(loc_oPage1.txt_4c_Cfdest,   "DblClick", THIS, "CfdestLookupDblClick")
2124:         BINDEVENT(loc_oPage1.txt_4c_Sittricm, "KeyPress", THIS, "SittricmLookupKeyPress")
2125:         BINDEVENT(loc_oPage1.txt_4c_Sittricm, "DblClick", THIS, "SittricmLookupDblClick")
2126:     ENDPROC
2127: 
2128:     *==========================================================================
2129:     * ConfigurarPgPage2 - Configura controles da Page2 (Integracao Contabil/Fiscal)
2130:     *==========================================================================
2131:     PROTECTED PROCEDURE ConfigurarPgPage2()
2132:         LOCAL loc_oPg2
2133:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
2134: 
2135:         *-- Separador secoes
2136:         loc_oPg2.AddObject("shp_4c_Shp03", "Shape")
2137:         WITH loc_oPg2.shp_4c_Shp03
2138:             .Top         = 211
2139:             .Left        = 5
2140:             .Width       = 984
2141:             .Height      = 1
2142:             .BackColor   = RGB(128, 128, 128)
2143:             .BorderColor = RGB(128, 128, 128)
2144:             .Visible     = .T.
2145:         ENDWITH
2146: 
2147:         *-- Label: Integracao Contabil (titulo secao)
2148:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
2149:         WITH loc_oPg2.lbl_4c_Label7
2150:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2151:             .Top       = 6
2152:             .Left      = 15
2153:             .Width     = 114
2154:             .Height    = 15
2155:             .FontName  = "Tahoma"
2156:             .FontSize  = 8
2157:             .FontBold  = .T.
2158:             .BackStyle = 0
2159:             .Visible   = .T.
2160:         ENDWITH
2161: 
2162:         *-- Label: Valor Contabil
2163:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
2164:         WITH loc_oPg2.lbl_4c_Label10
2165:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2166:             .Top       = 34
2167:             .Left      = 82
2168:             .Width     = 75
2169:             .Height    = 15
2170:             .FontName  = "Tahoma"
2171:             .FontSize  = 8

*-- Linhas 2525 a 2568:
2525:         ENDWITH
2526: 
2527:         *-- obj_4c_OptAgrupas - agrupas numeric(1,0), 2 buttons Sim/Nao
2528:         loc_oPg2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
2529:         WITH loc_oPg2.obj_4c_OptAgrupas
2530:             .Top         = 79
2531:             .Left        = 638
2532:             .Width       = 94
2533:             .Height      = 27
2534:             .ButtonCount = 2
2535:             .BackStyle   = 0
2536:             .Value       = 2
2537:             .Visible     = .T.
2538: 
2539:             WITH .Buttons(1)
2540:                 .Caption   = "Sim"
2541:                 .Width     = 43
2542:                 .Height    = 17
2543:                 .Left      = 0
2544:                 .Top       = 0
2545:                 .BackStyle = 0
2546:                 .Visible   = .T.
2547:             ENDWITH
2548: 
2549:             WITH .Buttons(2)
2550:                 .Caption   = "N" + CHR(227) + "o"
2551:                 .Width     = 43
2552:                 .Height    = 17
2553:                 .Left      = 45
2554:                 .Top       = 0
2555:                 .BackStyle = 0
2556:                 .FontName  = "Tahoma"
2557:                 .FontSize  = 8
2558:                 .Visible   = .T.
2559:             ENDWITH
2560:         ENDWITH
2561: 
2562:         *-- Label: Integracao Zerada
2563:         loc_oPg2.AddObject("lbl_4c_Label30", "Label")
2564:         WITH loc_oPg2.lbl_4c_Label30
2565:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
2566:             .Top       = 108
2567:             .Left      = 538
2568:             .Width     = 99

*-- Linhas 2574 a 2617:
2574:         ENDWITH
2575: 
2576:         *-- obj_4c_OptZeradas - zeradas numeric(1,0), 2 buttons Sim/Nao
2577:         loc_oPg2.AddObject("obj_4c_OptZeradas", "OptionGroup")
2578:         WITH loc_oPg2.obj_4c_OptZeradas
2579:             .Top         = 103
2580:             .Left        = 638
2581:             .Width       = 94
2582:             .Height      = 27
2583:             .ButtonCount = 2
2584:             .BackStyle   = 0
2585:             .Value       = 2
2586:             .Visible     = .T.
2587: 
2588:             WITH .Buttons(1)
2589:                 .Caption   = "Sim"
2590:                 .Width     = 43
2591:                 .Height    = 17
2592:                 .Left      = 0
2593:                 .Top       = 0
2594:                 .BackStyle = 0
2595:                 .Visible   = .T.
2596:             ENDWITH
2597: 
2598:             WITH .Buttons(2)
2599:                 .Caption   = "N" + CHR(227) + "o"
2600:                 .Width     = 43
2601:                 .Height    = 17
2602:                 .Left      = 45
2603:                 .Top       = 0
2604:                 .BackStyle = 0
2605:                 .FontName  = "Tahoma"
2606:                 .FontSize  = 8
2607:                 .Visible   = .T.
2608:             ENDWITH
2609:         ENDWITH
2610: 
2611:         *-- Label: Data Lancamento Contabil
2612:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
2613:         WITH loc_oPg2.lbl_4c_Label1
2614:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
2615:             .Top       = 132
2616:             .Left      = 502
2617:             .Width     = 135

*-- Linhas 2623 a 2666:
2623:         ENDWITH
2624: 
2625:         *-- obj_4c_Fwoption1 - dtintfis numeric(1,0): 1=Data Integracao, 2=Data N.F.
2626:         loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
2627:         WITH loc_oPg2.obj_4c_Fwoption1
2628:             .Top         = 127
2629:             .Left        = 638
2630:             .Width       = 192
2631:             .Height      = 25
2632:             .ButtonCount = 2
2633:             .BackStyle   = 0
2634:             .Value       = 1
2635:             .Visible     = .T.
2636: 
2637:             WITH .Buttons(1)
2638:                 .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
2639:                 .Width     = 97
2640:                 .Height    = 17
2641:                 .Left      = 0
2642:                 .Top       = 0
2643:                 .BackStyle = 0
2644:                 .Visible   = .T.
2645:             ENDWITH
2646: 
2647:             WITH .Buttons(2)
2648:                 .Caption   = "Data N.F."
2649:                 .Width     = 65
2650:                 .Height    = 17
2651:                 .Left      = 122
2652:                 .Top       = 0
2653:                 .BackStyle = 0
2654:                 .FontName  = "Tahoma"
2655:                 .FontSize  = 8
2656:                 .Visible   = .T.
2657:             ENDWITH
2658:         ENDWITH
2659: 
2660:         *-- Label: Utilizar variacao de CFOP na Integracao
2661:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
2662:         WITH loc_oPg2.lbl_4c_Label2
2663:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
2664:             .Top       = 156
2665:             .Left      = 427
2666:             .Width     = 210

*-- Linhas 2672 a 2715:
2672:         ENDWITH
2673: 
2674:         *-- obj_4c_Optutilvars - utilvars numeric(1,0), 2 buttons Sim/Nao
2675:         loc_oPg2.AddObject("obj_4c_Optutilvars", "OptionGroup")
2676:         WITH loc_oPg2.obj_4c_Optutilvars
2677:             .Top         = 150
2678:             .Left        = 638
2679:             .Width       = 94
2680:             .Height      = 27
2681:             .ButtonCount = 2
2682:             .BackStyle   = 0
2683:             .Value       = 2
2684:             .Visible     = .T.
2685: 
2686:             WITH .Buttons(1)
2687:                 .Caption   = "Sim"
2688:                 .Width     = 43
2689:                 .Height    = 17
2690:                 .Left      = 0
2691:                 .Top       = 0
2692:                 .BackStyle = 0
2693:                 .Visible   = .T.
2694:             ENDWITH
2695: 
2696:             WITH .Buttons(2)
2697:                 .Caption   = "N" + CHR(227) + "o"
2698:                 .Width     = 43
2699:                 .Height    = 17
2700:                 .Left      = 45
2701:                 .Top       = 0
2702:                 .BackStyle = 0
2703:                 .FontName  = "Tahoma"
2704:                 .FontSize  = 8
2705:                 .Visible   = .T.
2706:             ENDWITH
2707:         ENDWITH
2708: 
2709:         *-- Label: Integracao Fiscal (titulo secao)
2710:         loc_oPg2.AddObject("lbl_4c_Label35", "Label")
2711:         WITH loc_oPg2.lbl_4c_Label35
2712:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
2713:             .Top       = 217
2714:             .Left      = 18
2715:             .Width     = 99

*-- Linhas 2736 a 2779:
2736:         ENDWITH
2737: 
2738:         *-- obj_4c_Fwoption2 - intvlrcont numeric(1,0), 2 buttons Sim/Nao
2739:         loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
2740:         WITH loc_oPg2.obj_4c_Fwoption2
2741:             .Top         = 233
2742:             .Left        = 231
2743:             .Width       = 94
2744:             .Height      = 27
2745:             .ButtonCount = 2
2746:             .BackStyle   = 0
2747:             .Value       = 2
2748:             .Visible     = .T.
2749: 
2750:             WITH .Buttons(1)
2751:                 .Caption   = "Sim"
2752:                 .Width     = 43
2753:                 .Height    = 17
2754:                 .Left      = 0
2755:                 .Top       = 0
2756:                 .BackStyle = 0
2757:                 .Visible   = .T.
2758:             ENDWITH
2759: 
2760:             WITH .Buttons(2)
2761:                 .Caption   = "N" + CHR(227) + "o"
2762:                 .Width     = 43
2763:                 .Height    = 17
2764:                 .Left      = 45
2765:                 .Top       = 0
2766:                 .BackStyle = 0
2767:                 .FontName  = "Tahoma"
2768:                 .FontSize  = 8
2769:                 .Visible   = .T.
2770:             ENDWITH
2771:         ENDWITH
2772: 
2773:         *-- Label: Integrar Valores Icms
2774:         loc_oPg2.AddObject("lbl_4c_Label33", "Label")
2775:         WITH loc_oPg2.lbl_4c_Label33
2776:             .Caption   = "Integrar Valores Icms :"
2777:             .Top       = 259
2778:             .Left      = 120
2779:             .Width     = 112

*-- Linhas 2785 a 2828:
2785:         ENDWITH
2786: 
2787:         *-- obj_4c_Fwoption3 - intvlricms numeric(1,0), 2 buttons Sim/Nao
2788:         loc_oPg2.AddObject("obj_4c_Fwoption3", "OptionGroup")
2789:         WITH loc_oPg2.obj_4c_Fwoption3
2790:             .Top         = 253
2791:             .Left        = 231
2792:             .Width       = 94
2793:             .Height      = 27
2794:             .ButtonCount = 2
2795:             .BackStyle   = 0
2796:             .Value       = 2
2797:             .Visible     = .T.
2798: 
2799:             WITH .Buttons(1)
2800:                 .Caption   = "Sim"
2801:                 .Width     = 43
2802:                 .Height    = 17
2803:                 .Left      = 0
2804:                 .Top       = 0
2805:                 .BackStyle = 0
2806:                 .Visible   = .T.
2807:             ENDWITH
2808: 
2809:             WITH .Buttons(2)
2810:                 .Caption   = "N" + CHR(227) + "o"
2811:                 .Width     = 43
2812:                 .Height    = 17
2813:                 .Left      = 45
2814:                 .Top       = 0
2815:                 .BackStyle = 0
2816:                 .FontName  = "Tahoma"
2817:                 .FontSize  = 8
2818:                 .Visible   = .T.
2819:             ENDWITH
2820:         ENDWITH
2821: 
2822:         *-- Label: Integrar Valores Ipi
2823:         loc_oPg2.AddObject("lbl_4c_Label34", "Label")
2824:         WITH loc_oPg2.lbl_4c_Label34
2825:             .Caption   = "Integrar Valores Ipi :"
2826:             .Top       = 278
2827:             .Left      = 130
2828:             .Width     = 102

*-- Linhas 2834 a 2877:
2834:         ENDWITH
2835: 
2836:         *-- obj_4c_Fwoption4 - intvlripi numeric(1,0), 2 buttons Sim/Nao
2837:         loc_oPg2.AddObject("obj_4c_Fwoption4", "OptionGroup")
2838:         WITH loc_oPg2.obj_4c_Fwoption4
2839:             .Top         = 272
2840:             .Left        = 231
2841:             .Width       = 94
2842:             .Height      = 27
2843:             .ButtonCount = 2
2844:             .BackStyle   = 0
2845:             .Value       = 2
2846:             .Visible     = .T.
2847: 
2848:             WITH .Buttons(1)
2849:                 .Caption   = "Sim"
2850:                 .Width     = 43
2851:                 .Height    = 17
2852:                 .Left      = 0
2853:                 .Top       = 0
2854:                 .BackStyle = 0
2855:                 .Visible   = .T.
2856:             ENDWITH
2857: 
2858:             WITH .Buttons(2)
2859:                 .Caption   = "N" + CHR(227) + "o"
2860:                 .Width     = 43
2861:                 .Height    = 17
2862:                 .Left      = 45
2863:                 .Top       = 0
2864:                 .BackStyle = 0
2865:                 .FontName  = "Tahoma"
2866:                 .FontSize  = 8
2867:                 .Visible   = .T.
2868:             ENDWITH
2869:         ENDWITH
2870: 
2871:         *-- Label: Movimentacao Fisica de Estoque
2872:         loc_oPg2.AddObject("lbl_4c_Label38", "Label")
2873:         WITH loc_oPg2.lbl_4c_Label38
2874:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
2875:             .Top       = 298
2876:             .Left      = 68
2877:             .Width     = 164

*-- Linhas 2883 a 2926:
2883:         ENDWITH
2884: 
2885:         *-- obj_4c_Fwoption5 - indmov numeric(1,0), 2 buttons Sim/Nao
2886:         loc_oPg2.AddObject("obj_4c_Fwoption5", "OptionGroup")
2887:         WITH loc_oPg2.obj_4c_Fwoption5
2888:             .Top         = 292
2889:             .Left        = 231
2890:             .Width       = 94
2891:             .Height      = 27
2892:             .ButtonCount = 2
2893:             .BackStyle   = 0
2894:             .Value       = 2
2895:             .Visible     = .T.
2896: 
2897:             WITH .Buttons(1)
2898:                 .Caption   = "Sim"
2899:                 .Width     = 43
2900:                 .Height    = 17
2901:                 .Left      = 0
2902:                 .Top       = 0
2903:                 .BackStyle = 0
2904:                 .Visible   = .T.
2905:             ENDWITH
2906: 
2907:             WITH .Buttons(2)
2908:                 .Caption   = "N" + CHR(227) + "o"
2909:                 .Width     = 43
2910:                 .Height    = 17
2911:                 .Left      = 45
2912:                 .Top       = 0
2913:                 .BackStyle = 0
2914:                 .FontName  = "Tahoma"
2915:                 .FontSize  = 8
2916:                 .Visible   = .T.
2917:             ENDWITH
2918:         ENDWITH
2919: 
2920:         *-- Label: Indicacao de Pagamento
2921:         loc_oPg2.AddObject("lbl_4c_Label39", "Label")
2922:         WITH loc_oPg2.lbl_4c_Label39
2923:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
2924:             .Top       = 318
2925:             .Left      = 105
2926:             .Width     = 127

*-- Linhas 2932 a 3270:
2932:         ENDWITH
2933: 
2934:         *-- obj_4c_Fwoption6 - indpagto numeric(1,0), 2 buttons Sim/Nao
2935:         loc_oPg2.AddObject("obj_4c_Fwoption6", "OptionGroup")
2936:         WITH loc_oPg2.obj_4c_Fwoption6
2937:             .Top         = 312
2938:             .Left        = 231
2939:             .Width       = 94
2940:             .Height      = 27
2941:             .ButtonCount = 2
2942:             .BackStyle   = 0
2943:             .Value       = 2
2944:             .Visible     = .T.
2945: 
2946:             WITH .Buttons(1)
2947:                 .Caption   = "Sim"
2948:                 .Width     = 43
2949:                 .Height    = 17
2950:                 .Left      = 0
2951:                 .Top       = 0
2952:                 .BackStyle = 0
2953:                 .Visible   = .T.
2954:             ENDWITH
2955: 
2956:             WITH .Buttons(2)
2957:                 .Caption   = "N" + CHR(227) + "o"
2958:                 .Width     = 43
2959:                 .Height    = 17
2960:                 .Left      = 45
2961:                 .Top       = 0
2962:                 .BackStyle = 0
2963:                 .FontName  = "Tahoma"
2964:                 .FontSize  = 8
2965:                 .Visible   = .T.
2966:             ENDWITH
2967:         ENDWITH
2968: 
2969:         *-- BINDEVENTs para validacao de contas contabeis (LostFocus)
2970:         BINDEVENT(loc_oPg2.txt_4c_ContFrt, "KeyPress", THIS, "ContFrtLostFocus")
2971:         BINDEVENT(loc_oPg2.txt_4c_ContSeg, "KeyPress", THIS, "ContSegLostFocus")
2972:         BINDEVENT(loc_oPg2.txt_4c_ContDa,  "KeyPress", THIS, "ContDaLostFocus")
2973:     ENDPROC
2974: 
2975: 
2976:     *==========================================================================
2977:     * CarregarLista - Carrega dados no Grid da Page1
2978:     *==========================================================================
2979:     PROCEDURE CarregarLista()
2980:         LOCAL loc_lResultado, loc_oGrid
2981:         loc_lResultado = .F.
2982: 
2983:         TRY
2984:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2985:                 loc_lResultado = .T.
2986:             ELSE
2987:                 IF THIS.this_oBusinessObject.Buscar("")
2988:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2989: 
2990:                     loc_oGrid.ColumnCount = 2
2991:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
2992:                     loc_oGrid.ColumnCount  = 2
2993: 
2994:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
2995:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
2996: 
2997:                     loc_oGrid.Column1.Width = 80
2998:                     loc_oGrid.Column2.Width = 400
2999: 
3000:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3001:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3002: 
3003:                     *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
3004:                     loc_oGrid.SetAll("DynamicForeColor", ;
3005:                         "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")
3006: 
3007:                     THIS.FormatarGridLista(loc_oGrid)
3008:                     loc_oGrid.Refresh()
3009:                     loc_lResultado = .T.
3010:                 ENDIF
3011:             ENDIF
3012:         CATCH TO loc_oErro
3013:             MsgErro(loc_oErro.Message, "Erro em CarregarLista")
3014:             loc_lResultado = .F.
3015:         ENDTRY
3016: 
3017:         RETURN loc_lResultado
3018:     ENDPROC
3019: 
3020:     *==========================================================================
3021:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
3022:     *==========================================================================
3023:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
3024:         LOCAL loc_lResultado
3025:         loc_lResultado = .F.
3026: 
3027:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
3028:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3029: 
3030:             IF par_nPagina = 1
3031:                 THIS.CarregarLista()
3032:             ENDIF
3033: 
3034:             loc_lResultado = .T.
3035:         ENDIF
3036: 
3037:         RETURN loc_lResultado
3038:     ENDPROC
3039: 
3040:     *==========================================================================
3041:     * BtnEncerrarClick - Fecha o formulario (PUBLIC para BINDEVENT)
3042:     *==========================================================================
3043:     PROCEDURE BtnEncerrarClick()
3044:         THIS.Release()
3045:     ENDPROC
3046: 
3047:     *==========================================================================
3048:     * BtnIncluirClick - Incluir novo registro (PUBLIC para BINDEVENT)
3049:     *==========================================================================
3050:     PROCEDURE BtnIncluirClick()
3051:         THIS.this_oBusinessObject.NovoRegistro()
3052:         THIS.LimparCampos()
3053:         THIS.this_cModoAtual = "INCLUIR"
3054:         THIS.HabilitarCampos(.T.)
3055:         THIS.AjustarBotoesPorModo()
3056:         THIS.AlternarPagina(2)
3057:     ENDPROC
3058: 
3059:     *==========================================================================
3060:     * BtnVisualizarClick - Visualizar registro selecionado (PUBLIC para BINDEVENT)
3061:     *==========================================================================
3062:     PROCEDURE BtnVisualizarClick()
3063:         LOCAL loc_cCodigo
3064:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3065:             MsgAviso("Nenhum registro selecionado.", "")
3066:             RETURN
3067:         ENDIF
3068:         SELECT cursor_4c_Dados
3069:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3070:         IF EMPTY(loc_cCodigo)
3071:             MsgAviso("Nenhum registro selecionado.", "")
3072:             RETURN
3073:         ENDIF
3074:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3075:             THIS.BOParaForm()
3076:             THIS.this_cModoAtual = "VISUALIZAR"
3077:             THIS.HabilitarCampos(.F.)
3078:             THIS.AjustarBotoesPorModo()
3079:             THIS.AlternarPagina(2)
3080:         ELSE
3081:             MsgErro("Erro ao carregar registro.", "Erro")
3082:         ENDIF
3083:     ENDPROC
3084: 
3085:     *==========================================================================
3086:     * BtnAlterarClick - Alterar registro selecionado (PUBLIC para BINDEVENT)
3087:     *==========================================================================
3088:     PROCEDURE BtnAlterarClick()
3089:         LOCAL loc_cCodigo
3090:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3091:             MsgAviso("Nenhum registro selecionado.", "")
3092:             RETURN
3093:         ENDIF
3094:         SELECT cursor_4c_Dados
3095:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3096:         IF EMPTY(loc_cCodigo)
3097:             MsgAviso("Nenhum registro selecionado.", "")
3098:             RETURN
3099:         ENDIF
3100:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3101:             THIS.this_oBusinessObject.EditarRegistro()
3102:             THIS.BOParaForm()
3103:             THIS.this_cModoAtual = "ALTERAR"
3104:             THIS.HabilitarCampos(.T.)
3105:             THIS.AjustarBotoesPorModo()
3106:             THIS.AlternarPagina(2)
3107:         ELSE
3108:             MsgErro("Erro ao carregar CFOP para altera" + CHR(231) + CHR(227) + "o.", "Erro")
3109:         ENDIF
3110:     ENDPROC
3111: 
3112:     *==========================================================================
3113:     * BtnExcluirClick - Excluir registro selecionado (PUBLIC para BINDEVENT)
3114:     *==========================================================================
3115:     PROCEDURE BtnExcluirClick()
3116:         LOCAL loc_cCodigo, loc_lConfirmado
3117:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3118:             MsgAviso("Nenhum registro selecionado.", "")
3119:             RETURN
3120:         ENDIF
3121:         SELECT cursor_4c_Dados
3122:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3123:         IF EMPTY(loc_cCodigo)
3124:             MsgAviso("Nenhum registro selecionado.", "")
3125:             RETURN
3126:         ENDIF
3127:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do CFOP " + ;
3128:             loc_cCodigo + "?", "Confirmar Exclus" + CHR(227) + CHR(227) + "o")
3129:         IF loc_lConfirmado
3130:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3131:                 IF THIS.this_oBusinessObject.Excluir()
3132:                     MsgInfo("CFOP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
3133:                     THIS.CarregarLista()
3134:                 ELSE
3135:                     MsgErro("Erro ao excluir CFOP.", "Erro")
3136:                 ENDIF
3137:             ELSE
3138:                 MsgErro("Erro ao carregar CFOP para exclus" + CHR(227) + "o.", "Erro")
3139:             ENDIF
3140:         ENDIF
3141:     ENDPROC
3142: 
3143:     *==========================================================================
3144:     * BtnBuscarClick - Posiciona na lista pelo codigo/descricao (PUBLIC BINDEVENT)
3145:     *==========================================================================
3146:     PROCEDURE BtnBuscarClick()
3147:         LOCAL loc_oBusca, loc_cCodigo
3148:         TRY
3149:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3150:                 "SigCdCfo", "cursor_4c_BuscaCfo", "codigos", "", ;
3151:                 "Buscar CFOP")
3152: 
3153:             IF VARTYPE(loc_oBusca) = "O"
3154:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3155:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3156:                 loc_oBusca.Show()
3157: 
3158:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
3159:                     SELECT cursor_4c_BuscaCfo
3160:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfo.codigos)
3161:                     IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
3162:                         SELECT cursor_4c_Dados
3163:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3164:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3165:                     ENDIF
3166:                 ENDIF
3167:                 loc_oBusca.Release()
3168:             ENDIF
3169:         CATCH TO loc_oErro
3170:             MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
3171:         ENDTRY
3172: 
3173:         IF USED("cursor_4c_BuscaCfo")
3174:             USE IN cursor_4c_BuscaCfo
3175:         ENDIF
3176:     ENDPROC
3177: 
3178:     *==========================================================================
3179:     * BtnExpXMLClick - Exporta XML do CFOP selecionado (PUBLIC para BINDEVENT)
3180:     *==========================================================================
3181:     PROCEDURE BtnExpXMLClick()
3182:         LOCAL loc_cCodigo
3183:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3184:             MsgAviso("Selecione um CFOP na lista.", "")
3185:             RETURN
3186:         ENDIF
3187:         SELECT cursor_4c_Dados
3188:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3189:         IF EMPTY(loc_cCodigo)
3190:             MsgAviso("Selecione um CFOP na lista.", "")
3191:             RETURN
3192:         ENDIF
3193:         TRY
3194:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
3195:             THIS.CarregarLista()
3196:             IF USED("cursor_4c_Dados")
3197:                 SELECT cursor_4c_Dados
3198:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3199:             ENDIF
3200:         CATCH TO loc_oErro
3201:             MsgErro("Erro ao exportar XML:" + CHR(13) + loc_oErro.Message, "Erro")
3202:         ENDTRY
3203:     ENDPROC
3204: 
3205:     *==========================================================================
3206:     * BtnImpXMLClick - Importa XML de CFOP (PUBLIC para BINDEVENT)
3207:     *==========================================================================
3208:     PROCEDURE BtnImpXMLClick()
3209:         LOCAL loc_cCodigo
3210:         loc_cCodigo = ""
3211:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3212:             SELECT cursor_4c_Dados
3213:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3214:         ENDIF
3215:         TRY
3216:             DO FORM SigOpXml WITH THIS, "", "I", "CFOP", 10
3217:             THIS.CarregarLista()
3218:             IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodigo)
3219:                 SELECT cursor_4c_Dados
3220:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3221:             ENDIF
3222:         CATCH TO loc_oErro
3223:             MsgErro("Erro ao importar XML:" + CHR(13) + loc_oErro.Message, "Erro")
3224:         ENDTRY
3225:     ENDPROC
3226: 
3227:     *==========================================================================
3228:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
3229:     *==========================================================================
3230:     PROTECTED PROCEDURE FormParaBO()
3231:         LOCAL loc_oBO, loc_oPage1, loc_oPage2
3232:         TRY
3233:             loc_oBO    = THIS.this_oBusinessObject
3234:             loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3235:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3236: 
3237:             *-- Identificacao
3238:             loc_oBO.this_cCodigos    = ALLTRIM(loc_oPage1.txt_4c_Codigo.Value)
3239:             loc_oBO.this_cDescricaos = ALLTRIM(loc_oPage1.txt_4c_Descricao.Value)
3240:             loc_oBO.this_cDesc2s     = ALLTRIM(loc_oPage1.txt_4c_Desc2s.Value)
3241:             loc_oBO.this_cOperacaos  = ALLTRIM(loc_oPage1.cbo_4c_CmbOperacao.Value)
3242:             loc_oBO.this_nTipos      = ALLTRIM(loc_oPage1.cbo_4c_Cmbtipo.Value)
3243:             loc_oBO.this_nNdigitos   = loc_oPage1.spn_4c_Ndigito.Value
3244: 
3245:             *-- Situacao (Ativo=Button1?Value=1?situas=0; Inativo=Button2?Value=2?situas=1)
3246:             loc_oBO.this_nSituas = IIF(loc_oPage1.obj_4c_Opc_situacao.Value = 1, 0, 1)
3247: 
3248:             *-- ICMS
3249:             loc_oBO.this_cIcms       = ALLTRIM(loc_oPage1.cbo_4c_CmbIcms.Value)
3250:             loc_oBO.this_cSittribs   = ALLTRIM(loc_oPage1.txt_4c_Sittricm.Value)
3251:             loc_oBO.this_nAliqivcs   = loc_oPage1.txt_4c_AliqIVCs.Value
3252:             loc_oBO.this_nInclicms   = ALLTRIM(loc_oPage1.cbo_4c_Combo3.Value)
3253:             loc_oBO.this_nIcmsdscs   = ALLTRIM(loc_oPage1.cbo_4c_Combo10.Value)
3254:             loc_oBO.this_nIcmsincs   = ALLTRIM(loc_oPage1.cbo_4c_Combo6.Value)
3255:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPage1.chk_4c_Fwcheckbox1.Value, 1, 0)
3256:             loc_oBO.this_cCgergia1s  = ALLTRIM(loc_oPage1.txt_4c_Gergia1.Value)
3257:             loc_oBO.this_nFrticms    = IIF(loc_oPage1.chk_4c_ObjFreteICM.Value, 1, 0)
3258:             loc_oBO.this_nSegicms    = IIF(loc_oPage1.chk_4c_ObjSegIcm.Value, 1, 0)
3259:             loc_oBO.this_nDesicms    = IIF(loc_oPage1.chk_4c_ObjDespIcm.Value, 1, 0)
3260: 
3261:             *-- Substituicao Tributaria ICMS
3262:             loc_oBO.this_cSubtribs   = ALLTRIM(loc_oPage1.cbo_4c_CmbSTRIB.Value)
3263:             loc_oBO.this_nPbcsts     = loc_oPage1.txt_4c_Bcst.Value
3264:             loc_oBO.this_cCfosts     = ALLTRIM(loc_oPage1.txt_4c_CfoST.Value)
3265:             loc_oBO.this_cCfost60s   = ALLTRIM(loc_oPage1.txt_4c_CfoST60.Value)
3266:             loc_oBO.this_cCoddests   = ALLTRIM(loc_oPage1.txt_4c_Cfdest.Value)
3267:             loc_oBO.this_nTransps    = ALLTRIM(loc_oPage1.cbo_4c_Combo5.Value)
3268: 
3269:             *-- IPI
3270:             loc_oBO.this_cIpis       = ALLTRIM(loc_oPage1.cbo_4c_CmbIpi.Value)

*-- Linhas 3292 a 3378:
3292:             loc_oBO.this_nAliqcofins = loc_oPage1.txt_4c_AliqCofins.Value
3293:             loc_oBO.this_nAliqissqn  = loc_oPage1.txt_4c_AliqISSQN.Value
3294:             loc_oBO.this_nAliqii     = loc_oPage1.txt_4c_AliqII.Value
3295:             *-- ctissqn: OptionGroup 5 botoes (0-4), Value=1 ? ctissqn=0
3296:             loc_oBO.this_nCtissqn    = loc_oPage1.obj_4c_Fwoption1.Value - 1
3297:             *-- rettribs: Sim=Button1?Value=1?1, Nao=Button2?Value=2?0
3298:             loc_oBO.this_nRettribs   = IIF(loc_oPage1.obj_4c_Fwoption2.Value = 1, 1, 0)
3299: 
3300:             *-- Contribuinte
3301:             loc_oBO.this_cContribs   = ALLTRIM(loc_oPage1.cbo_4c_CmbContribuinte.Value)
3302: 
3303:             *-- Contabilidade - contas DB/CR (Page2)
3304:             loc_oBO.this_nPontedescs = loc_oPage2.cbo_4c_Combo2.ListIndex
3305:             loc_oBO.this_cContconts  = LEFT(UPPER(ALLTRIM(loc_oPage2.cbo_4c_CmbFixa.Value)), 1)
3306:             loc_oBO.this_cContvcds   = ALLTRIM(loc_oPage2.txt_4c_Vrcds.Value)
3307:             loc_oBO.this_cContvccs   = ALLTRIM(loc_oPage2.txt_4c_Vrccs.Value)
3308:             loc_oBO.this_cContipds   = ALLTRIM(loc_oPage2.txt_4c_Ipids.Value)
3309:             loc_oBO.this_cContipcs   = ALLTRIM(loc_oPage2.txt_4c_Ipics.Value)
3310:             loc_oBO.this_cConticds   = ALLTRIM(loc_oPage2.txt_4c_Icmds.Value)
3311:             loc_oBO.this_cConticcs   = ALLTRIM(loc_oPage2.txt_4c_Icmcs.Value)
3312:             loc_oBO.this_cContfrt    = ALLTRIM(loc_oPage2.txt_4c_ContFrt.Value)
3313:             loc_oBO.this_cContseg    = ALLTRIM(loc_oPage2.txt_4c_ContSeg.Value)
3314:             loc_oBO.this_cContda     = ALLTRIM(loc_oPage2.txt_4c_ContDa.Value)
3315: 
3316:             *-- Contabilidade - opcoes (Page2)
3317:             *-- agrupas/zeradas/utilvars: Sim=Value=1?1, Nao=Value=2?0
3318:             loc_oBO.this_nAgrupas    = IIF(loc_oPage2.obj_4c_OptAgrupas.Value = 1, 1, 0)
3319:             loc_oBO.this_nZeradas    = IIF(loc_oPage2.obj_4c_OptZeradas.Value = 1, 1, 0)
3320:             loc_oBO.this_nUtilvars   = IIF(loc_oPage2.obj_4c_Optutilvars.Value = 1, 1, 0)
3321:             *-- dtintfis: 2 botoes, Value=1=Data Integracao, Value=2=Data N.F.
3322:             loc_oBO.this_nDtintfis   = loc_oPage2.obj_4c_Fwoption1.Value
3323:             *-- intvlrcont/ricms/ripi/indmov/indpagto: Sim=1/Nao=2
3324:             loc_oBO.this_nIntvlrcont = IIF(loc_oPage2.obj_4c_Fwoption2.Value = 1, 1, 0)
3325:             loc_oBO.this_nIntvlricms = IIF(loc_oPage2.obj_4c_Fwoption3.Value = 1, 1, 0)
3326:             loc_oBO.this_nIntvlripi  = IIF(loc_oPage2.obj_4c_Fwoption4.Value = 1, 1, 0)
3327:             loc_oBO.this_nIndmov     = IIF(loc_oPage2.obj_4c_Fwoption5.Value = 1, 1, 0)
3328:             loc_oBO.this_nIndpagto   = IIF(loc_oPage2.obj_4c_Fwoption6.Value = 1, 1, 0)
3329: 
3330:         CATCH TO loc_oErro
3331:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
3332:         ENDTRY
3333:     ENDPROC
3334: 
3335:     *==========================================================================
3336:     * BOParaForm - Transfere valores do BO para os campos da Page2
3337:     *==========================================================================
3338:     PROTECTED PROCEDURE BOParaForm()
3339:         LOCAL loc_oBO, loc_oPage1, loc_oPage2
3340:         TRY
3341:             loc_oBO    = THIS.this_oBusinessObject
3342:             loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3343:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3344: 
3345:             *-- Identificacao
3346:             loc_oPage1.txt_4c_Codigo.Value       = loc_oBO.this_cCodigos
3347:             loc_oPage1.txt_4c_Descricao.Value    = loc_oBO.this_cDescricaos
3348:             loc_oPage1.txt_4c_Desc2s.Value       = loc_oBO.this_cDesc2s
3349:             loc_oPage1.cbo_4c_CmbOperacao.Value  = loc_oBO.this_cOperacaos
3350:             loc_oPage1.cbo_4c_Cmbtipo.Value      = LTRIM(STR(loc_oBO.this_nTipos, 1))
3351:             loc_oPage1.spn_4c_Ndigito.Value      = loc_oBO.this_nNdigitos
3352: 
3353:             *-- Situacao (situas=0?Ativo=Button1?Value=1; situas=1?Inativo=Button2?Value=2)
3354:             loc_oPage1.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 0, 1, 2)
3355: 
3356:             *-- ICMS
3357:             loc_oPage1.cbo_4c_CmbIcms.Value      = loc_oBO.this_cIcms
3358:             loc_oPage1.txt_4c_Sittricm.Value     = loc_oBO.this_cSittribs
3359:             loc_oPage1.txt_4c_AliqIVCs.Value     = loc_oBO.this_nAliqivcs
3360:             loc_oPage1.cbo_4c_Combo3.Value       = LTRIM(STR(loc_oBO.this_nInclicms, 1))
3361:             loc_oPage1.cbo_4c_Combo10.Value      = LTRIM(STR(loc_oBO.this_nIcmsdscs, 1))
3362:             loc_oPage1.cbo_4c_Combo6.Value       = LTRIM(STR(loc_oBO.this_nIcmsincs, 1))
3363:             loc_oPage1.chk_4c_Fwcheckbox1.Value  = (loc_oBO.this_nIncicmnfs .Value  = IIF(loc_oBO.this_nIncicmnfs = 1, 1, 0))
3364:             loc_oPage1.txt_4c_Gergia1.Value      = loc_oBO.this_cCgergia1s
3365:             loc_oPage1.chk_4c_ObjFreteICM.Value  = (loc_oBO.this_nFrticms .Value  = IIF(loc_oBO.this_nFrticms = 1, 1, 0))
3366:             loc_oPage1.chk_4c_ObjSegIcm.Value    = (loc_oBO.this_nSegicms .Value    = IIF(loc_oBO.this_nSegicms = 1, 1, 0))
3367:             loc_oPage1.chk_4c_ObjDespIcm.Value   = (loc_oBO.this_nDesicms .Value   = IIF(loc_oBO.this_nDesicms = 1, 1, 0))
3368: 
3369:             *-- Substituicao Tributaria ICMS
3370:             loc_oPage1.cbo_4c_CmbSTRIB.Value     = loc_oBO.this_cSubtribs
3371:             loc_oPage1.txt_4c_Bcst.Value         = loc_oBO.this_nPbcsts
3372:             loc_oPage1.txt_4c_CfoST.Value        = loc_oBO.this_cCfosts
3373:             loc_oPage1.txt_4c_CfoST60.Value      = loc_oBO.this_cCfost60s
3374:             loc_oPage1.txt_4c_Cfdest.Value       = loc_oBO.this_cCoddests
3375:             loc_oPage1.cbo_4c_Combo5.Value       = LTRIM(STR(loc_oBO.this_nTransps, 1))
3376: 
3377:             *-- IPI
3378:             loc_oPage1.cbo_4c_CmbIpi.Value       = loc_oBO.this_cIpis

*-- Linhas 3400 a 3903:
3400:             loc_oPage1.txt_4c_AliqCofins.Value   = loc_oBO.this_nAliqcofins
3401:             loc_oPage1.txt_4c_AliqISSQN.Value    = loc_oBO.this_nAliqissqn
3402:             loc_oPage1.txt_4c_AliqII.Value       = loc_oBO.this_nAliqii
3403:             *-- ctissqn: OptionGroup Value = ctissqn + 1
3404:             loc_oPage1.obj_4c_Fwoption1.Value    = loc_oBO.this_nCtissqn + 1
3405:             *-- rettribs: Sim=1?Value=1, Nao=0?Value=2
3406:             loc_oPage1.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nRettribs = 1, 1, 2)
3407: 
3408:             *-- Contribuinte
3409:             loc_oPage1.cbo_4c_CmbContribuinte.Value = loc_oBO.this_cContribs
3410: 
3411:             *-- Contabilidade - contas DB/CR (Page2)
3412:             loc_oPage2.cbo_4c_Combo2.ListIndex   = IIF(loc_oBO.this_nPontedescs >= 1 AND loc_oBO.this_nPontedescs <= 3, loc_oBO.this_nPontedescs, 1)
3413:             loc_oPage2.cbo_4c_CmbFixa.ListIndex  = MAX(1, AT(loc_oBO.this_cContconts, "SNC"))
3414:             loc_oPage2.txt_4c_Vrcds.Value        = loc_oBO.this_cContvcds
3415:             loc_oPage2.txt_4c_Vrccs.Value        = loc_oBO.this_cContvccs
3416:             loc_oPage2.txt_4c_Ipids.Value        = loc_oBO.this_cContipds
3417:             loc_oPage2.txt_4c_Ipics.Value        = loc_oBO.this_cContipcs
3418:             loc_oPage2.txt_4c_Icmds.Value        = loc_oBO.this_cConticds
3419:             loc_oPage2.txt_4c_Icmcs.Value        = loc_oBO.this_cConticcs
3420:             loc_oPage2.txt_4c_ContFrt.Value      = loc_oBO.this_cContfrt
3421:             loc_oPage2.txt_4c_ContSeg.Value      = loc_oBO.this_cContseg
3422:             loc_oPage2.txt_4c_ContDa.Value       = loc_oBO.this_cContda
3423: 
3424:             *-- Contabilidade - opcoes (Page2)
3425:             *-- agrupas/zeradas/utilvars: 1?Value=1 (Sim), 0?Value=2 (Nao)
3426:             loc_oPage2.obj_4c_OptAgrupas.Value   = IIF(loc_oBO.this_nAgrupas = 1, 1, 2)
3427:             loc_oPage2.obj_4c_OptZeradas.Value   = IIF(loc_oBO.this_nZeradas = 1, 1, 2)
3428:             loc_oPage2.obj_4c_Optutilvars.Value  = IIF(loc_oBO.this_nUtilvars = 1, 1, 2)
3429:             *-- dtintfis: 1=Data Integracao, 2=Data N.F.
3430:             loc_oPage2.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nDtintfis = 2, 2, 1)
3431:             *-- intvlrcont/ricms/ripi/indmov/indpagto: 1?Value=1, 0?Value=2
3432:             loc_oPage2.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nIntvlrcont = 1, 1, 2)
3433:             loc_oPage2.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nIntvlricms = 1, 1, 2)
3434:             loc_oPage2.obj_4c_Fwoption4.Value    = IIF(loc_oBO.this_nIntvlripi = 1, 1, 2)
3435:             loc_oPage2.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nIndmov = 1, 1, 2)
3436:             loc_oPage2.obj_4c_Fwoption6.Value    = IIF(loc_oBO.this_nIndpagto = 1, 1, 2)
3437: 
3438:         CATCH TO loc_oErro
3439:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
3440:         ENDTRY
3441:     ENDPROC
3442: 
3443:     *==========================================================================
3444:     * BtnSalvarClick - Salvar registro (PUBLIC para BINDEVENT)
3445:     *==========================================================================
3446:     PROCEDURE BtnSalvarClick()
3447:         LOCAL loc_lProsseguir, loc_cCodigo, loc_cSQL, loc_nRet
3448:         loc_lProsseguir = .T.
3449: 
3450:         *-- Validacao: codigo obrigatorio
3451:         loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.Value)
3452:         IF EMPTY(STRTRAN(loc_cCodigo, ".", ""))
3453:             MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "")
3454:             THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
3455:             loc_lProsseguir = .F.
3456:         ENDIF
3457: 
3458:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
3459:         IF loc_lProsseguir AND THIS.this_cModoAtual = "INCLUIR"
3460:             TRY
3461:                 loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo WHERE codigos = " + ;
3462:                     EscaparSQL(loc_cCodigo)
3463:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCfo")
3464:                 IF loc_nRet >= 0 AND NVL(cursor_4c_DupCfo.nExiste, 0) > 0
3465:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "")
3466:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
3467:                     loc_lProsseguir = .F.
3468:                 ENDIF
3469:                 IF USED("cursor_4c_DupCfo")
3470:                     USE IN cursor_4c_DupCfo
3471:                 ENDIF
3472:             CATCH TO loc_oErro
3473:                 IF USED("cursor_4c_DupCfo")
3474:                     USE IN cursor_4c_DupCfo
3475:                 ENDIF
3476:                 MsgErro(loc_oErro.Message, "Erro ao verificar duplicidade")
3477:                 loc_lProsseguir = .F.
3478:             ENDTRY
3479:         ENDIF
3480: 
3481:         IF loc_lProsseguir
3482:             THIS.FormParaBO()
3483:             TRY
3484:                 IF THIS.this_oBusinessObject.Salvar()
3485:                     MsgInfo("Registro salvo com sucesso!", "Sucesso")
3486:                     THIS.this_cModoAtual = "LISTA"
3487:                     THIS.AlternarPagina(1)
3488:                 ENDIF
3489:             CATCH TO loc_oErro
3490:                 MsgErro(loc_oErro.Message, "Erro em BtnSalvarClick")
3491:             ENDTRY
3492:         ENDIF
3493:     ENDPROC
3494: 
3495:     *==========================================================================
3496:     * BtnCancelarClick - Cancelar edicao e voltar para lista (PUBLIC para BINDEVENT)
3497:     *==========================================================================
3498:     PROCEDURE BtnCancelarClick()
3499:         THIS.this_cModoAtual = "LISTA"
3500:         THIS.AlternarPagina(1)
3501:     ENDPROC
3502: 
3503:     *==========================================================================
3504:     * LimparCampos - Limpa todos os campos da Page2
3505:     *==========================================================================
3506:     PROTECTED PROCEDURE LimparCampos()
3507:         LOCAL loc_oPagDados, loc_nI
3508:         TRY
3509:             loc_oPagDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados
3510:             FOR loc_nI = 1 TO loc_oPagDados.PageCount
3511:                 THIS.LimparControles(loc_oPagDados.Pages(loc_nI))
3512:             ENDFOR
3513:         CATCH TO loc_oErro
3514:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
3515:         ENDTRY
3516:     ENDPROC
3517: 
3518:     PROTECTED PROCEDURE LimparControles(par_oContainer)
3519:         LOCAL loc_nI, loc_oCtrl
3520:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3521:             loc_oCtrl = par_oContainer.Controls(loc_nI)
3522:             IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "Value", 5)
3523:                 DO CASE
3524:                 CASE VARTYPE(loc_oCtrl.Value) = "C"
3525:                     loc_oCtrl.Value = ""
3526:                 CASE VARTYPE(loc_oCtrl.Value) = "N"
3527:                     loc_oCtrl.Value = 0
3528:                 CASE VARTYPE(loc_oCtrl.Value) = "L"
3529:                     loc_oCtrl.Value = .F.
3530:                 CASE VARTYPE(loc_oCtrl.Value) = "D"
3531:                     loc_oCtrl.Value = {}
3532:                 ENDCASE
3533:             ENDIF
3534:             IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "ControlCount", 5)
3535:                 IF loc_oCtrl.ControlCount > 0
3536:                     THIS.LimparControles(loc_oCtrl)
3537:                 ENDIF
3538:             ENDIF
3539:         ENDFOR
3540:     ENDPROC
3541: 
3542:     *==========================================================================
3543:     * HabilitarCampos - Habilita/desabilita campos da Page2 por modo
3544:     *==========================================================================
3545:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3546:         LOCAL loc_oPagDados, loc_nI
3547:         TRY
3548:             loc_oPagDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados
3549:             FOR loc_nI = 1 TO loc_oPagDados.PageCount
3550:                 THIS.HabilitarControles(loc_oPagDados.Pages(loc_nI), par_lHabilitar)
3551:             ENDFOR
3552:         CATCH TO loc_oErro
3553:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
3554:         ENDTRY
3555:     ENDPROC
3556: 
3557:     PROTECTED PROCEDURE HabilitarControles(par_oContainer, par_lHabilitar)
3558:         LOCAL loc_nI, loc_oCtrl, loc_cBase
3559:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3560:             loc_oCtrl = par_oContainer.Controls(loc_nI)
3561:             IF VARTYPE(loc_oCtrl) = "O"
3562:                 loc_cBase = UPPER(loc_oCtrl.BaseClass)
3563:                 IF INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", ;
3564:                         "SPINNER", "OPTIONGROUP")
3565:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
3566:                         loc_oCtrl.Enabled = par_lHabilitar
3567:                     ENDIF
3568:                 ENDIF
3569:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
3570:                     IF loc_oCtrl.ControlCount > 0
3571:                         THIS.HabilitarControles(loc_oCtrl, par_lHabilitar)
3572:                     ENDIF
3573:                 ENDIF
3574:             ENDIF
3575:         ENDFOR
3576:     ENDPROC
3577: 
3578:     *==========================================================================
3579:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
3580:     *==========================================================================
3581:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3582:         LOCAL loc_nI, loc_oObjeto, loc_nP
3583: 
3584:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3585:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3586: 
3587:             IF VARTYPE(loc_oObjeto) = "O"
3588:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3589:                     loc_oObjeto.Visible = .T.
3590:                 ENDIF
3591: 
3592:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3593:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3594:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3595:                     ENDFOR
3596:                 ENDIF
3597: 
3598:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3599:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3600:                 ENDIF
3601:             ENDIF
3602:         ENDFOR
3603:     ENDPROC
3604: 
3605:     *==========================================================================
3606:     * CfoST60LookupKeyPress - F4/F5 abre lookup para txt_4c_CfoST60 (PUBLIC BINDEVENT)
3607:     *==========================================================================
3608:     PROCEDURE CfoST60LookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3609:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
3610:             THIS.AbrirLookupCfoST60()
3611:         ENDIF
3612:     ENDPROC
3613: 
3614:     *==========================================================================
3615:     * CfoST60LookupDblClick - DblClick abre lookup para txt_4c_CfoST60 (PUBLIC BINDEVENT)
3616:     *==========================================================================
3617:     PROCEDURE CfoST60LookupDblClick()
3618:         THIS.AbrirLookupCfoST60()
3619:     ENDPROC
3620: 
3621:     *==========================================================================
3622:     * AbrirLookupCfoST60 - Lookup SigCdCfo para cfost60s (CFOP ST Tributada)
3623:     *==========================================================================
3624:     PROCEDURE AbrirLookupCfoST60()
3625:         LOCAL loc_oLookup, loc_oPagDados1
3626:         loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3627:         TRY
3628:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3629:                 "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
3630:                 ALLTRIM(loc_oPagDados1.txt_4c_CfoST60.Value), "CFOP - ST Trib.")
3631:             IF VARTYPE(loc_oLookup) = "O"
3632:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3633:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3634:                 loc_oLookup.Show()
3635:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3636:                     SELECT cursor_4c_BuscaCfoST60
3637:                     loc_oPagDados1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3638:                 ENDIF
3639:                 loc_oLookup.Release()
3640:             ENDIF
3641:         CATCH TO loc_oErro
3642:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST60")
3643:         ENDTRY
3644:         IF USED("cursor_4c_BuscaCfoST60")
3645:             USE IN cursor_4c_BuscaCfoST60
3646:         ENDIF
3647:     ENDPROC
3648: 
3649:     *==========================================================================
3650:     * CfoSTLookupKeyPress - F4/F5 abre lookup para txt_4c_CfoST (PUBLIC BINDEVENT)
3651:     *==========================================================================
3652:     PROCEDURE CfoSTLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3653:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
3654:             THIS.AbrirLookupCfoST()
3655:         ENDIF
3656:     ENDPROC
3657: 
3658:     *==========================================================================
3659:     * CfoSTLookupDblClick - DblClick abre lookup para txt_4c_CfoST (PUBLIC BINDEVENT)
3660:     *==========================================================================
3661:     PROCEDURE CfoSTLookupDblClick()
3662:         THIS.AbrirLookupCfoST()
3663:     ENDPROC
3664: 
3665:     *==========================================================================
3666:     * AbrirLookupCfoST - Lookup SigCdCfo para cfosts (CFOP Substitui" + CHR(231) + CHR(227) + "o Trib.)
3667:     *==========================================================================
3668:     PROCEDURE AbrirLookupCfoST()
3669:         LOCAL loc_oLookup, loc_oPagDados1
3670:         loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3671:         TRY
3672:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3673:                 "SigCdCfo", "cursor_4c_BuscaCfoST", "codigos", ;
3674:                 ALLTRIM(loc_oPagDados1.txt_4c_CfoST.Value), ;
3675:                 "CFOP - Substitui" + CHR(231) + CHR(227) + "o Trib.")
3676:             IF VARTYPE(loc_oLookup) = "O"
3677:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3678:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3679:                 loc_oLookup.Show()
3680:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3681:                     SELECT cursor_4c_BuscaCfoST
3682:                     loc_oPagDados1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3683:                 ENDIF
3684:                 loc_oLookup.Release()
3685:             ENDIF
3686:         CATCH TO loc_oErro
3687:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST")
3688:         ENDTRY
3689:         IF USED("cursor_4c_BuscaCfoST")
3690:             USE IN cursor_4c_BuscaCfoST
3691:         ENDIF
3692:     ENDPROC
3693: 
3694:     *==========================================================================
3695:     * CfdestLookupKeyPress - F4/F5 abre lookup para txt_4c_Cfdest (PUBLIC BINDEVENT)
3696:     *==========================================================================
3697:     PROCEDURE CfdestLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3698:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
3699:             THIS.AbrirLookupCfdest()
3700:         ENDIF
3701:     ENDPROC
3702: 
3703:     *==========================================================================
3704:     * CfdestLookupDblClick - DblClick abre lookup para txt_4c_Cfdest (PUBLIC BINDEVENT)
3705:     *==========================================================================
3706:     PROCEDURE CfdestLookupDblClick()
3707:         THIS.AbrirLookupCfdest()
3708:     ENDPROC
3709: 
3710:     *==========================================================================
3711:     * AbrirLookupCfdest - Lookup SigCdCfo para coddests (CFOP Destino)
3712:     *==========================================================================
3713:     PROCEDURE AbrirLookupCfdest()
3714:         LOCAL loc_oLookup, loc_oPagDados1
3715:         loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3716:         TRY
3717:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3718:                 "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
3719:                 ALLTRIM(loc_oPagDados1.txt_4c_Cfdest.Value), "CFOP - Destino")
3720:             IF VARTYPE(loc_oLookup) = "O"
3721:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3722:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3723:                 loc_oLookup.Show()
3724:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3725:                     SELECT cursor_4c_BuscaCfdest
3726:                     loc_oPagDados1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3727:                 ENDIF
3728:                 loc_oLookup.Release()
3729:             ENDIF
3730:         CATCH TO loc_oErro
3731:             MsgErro(loc_oErro.Message, "Erro no Lookup Cfdest")
3732:         ENDTRY
3733:         IF USED("cursor_4c_BuscaCfdest")
3734:             USE IN cursor_4c_BuscaCfdest
3735:         ENDIF
3736:     ENDPROC
3737: 
3738:     *==========================================================================
3739:     * SittricmLookupKeyPress - F4/F5 abre lookup para txt_4c_Sittricm (PUBLIC BINDEVENT)
3740:     *==========================================================================
3741:     PROCEDURE SittricmLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3742:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
3743:             THIS.AbrirLookupSittricm()
3744:         ENDIF
3745:     ENDPROC
3746: 
3747:     *==========================================================================
3748:     * SittricmLookupDblClick - DblClick abre lookup para txt_4c_Sittricm (PUBLIC BINDEVENT)
3749:     *==========================================================================
3750:     PROCEDURE SittricmLookupDblClick()
3751:         THIS.AbrirLookupSittricm()
3752:     ENDPROC
3753: 
3754:     *==========================================================================
3755:     * AbrirLookupSittricm - Lookup SigCdIcm para sittribs (Sit. Tributaria ICMS)
3756:     *==========================================================================
3757:     PROCEDURE AbrirLookupSittricm()
3758:         LOCAL loc_oLookup, loc_oPagDados1
3759:         loc_oPagDados1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3760:         TRY
3761:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3762:                 "SigCdIcm", "cursor_4c_BuscaSittricm", "Codigos", ;
3763:                 ALLTRIM(loc_oPagDados1.txt_4c_Sittricm.Value), ;
3764:                 "Situa" + CHR(231) + CHR(227) + "o Trib. ICMS")
3765:             IF VARTYPE(loc_oLookup) = "O"
3766:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
3767:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3768:                 loc_oLookup.Show()
3769:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
3770:                     SELECT cursor_4c_BuscaSittricm
3771:                     loc_oPagDados1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
3772:                 ENDIF
3773:                 loc_oLookup.Release()
3774:             ENDIF
3775:         CATCH TO loc_oErro
3776:             MsgErro(loc_oErro.Message, "Erro no Lookup Sittricm")
3777:         ENDTRY
3778:         IF USED("cursor_4c_BuscaSittricm")
3779:             USE IN cursor_4c_BuscaSittricm
3780:         ENDIF
3781:     ENDPROC
3782: 
3783:     *==========================================================================
3784:     * FormatarGridLista - Formata visual do Grid da lista
3785:     *==========================================================================
3786:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
3787:         WITH par_oGrid
3788:             .FontName = "Tahoma"
3789:             .FontSize = 8
3790:         ENDWITH
3791:     ENDPROC
3792: 
3793:     *==========================================================================
3794:     * AjustarBotoesPorModo - Ajusta botao Salvar conforme modo atual
3795:     *==========================================================================
3796:     PROTECTED PROCEDURE AjustarBotoesPorModo()
3797:         LOCAL loc_oCntSalva, loc_lEditavel
3798:         TRY
3799:             loc_oCntSalva  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
3800:             loc_lEditavel  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3801:             IF VARTYPE(loc_oCntSalva) = "O"
3802:                 loc_oCntSalva.cmd_4c_Salvar.Enabled = loc_lEditavel
3803:             ENDIF
3804:         CATCH TO loc_oErro
3805:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
3806:         ENDTRY
3807:     ENDPROC
3808: 
3809:     *==========================================================================
3810:     * ContFrtLostFocus - Valida conta contabil de Frete ao sair do campo (PUBLIC BINDEVENT)
3811:     *==========================================================================
3812:     PROCEDURE ContFrtLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3813:         LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
3814:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3815:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContFrt.Value)
3816:         IF !EMPTY(loc_cConta)
3817:             TRY
3818:                 loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
3819:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContFrtVal")
3820:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContFrtVal") OR EOF("cursor_4c_ContFrtVal")
3821:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3822:                     loc_oPg2.txt_4c_ContFrt.Value = ""
3823:                 ENDIF
3824:                 IF USED("cursor_4c_ContFrtVal")
3825:                     USE IN cursor_4c_ContFrtVal
3826:                 ENDIF
3827:             CATCH TO loc_oErro
3828:                 IF USED("cursor_4c_ContFrtVal")
3829:                     USE IN cursor_4c_ContFrtVal
3830:                 ENDIF
3831:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Frete")
3832:             ENDTRY
3833:         ENDIF
3834:     ENDPROC
3835: 
3836:     *==========================================================================
3837:     * ContSegLostFocus - Valida conta contabil de Seguro ao sair do campo (PUBLIC BINDEVENT)
3838:     *==========================================================================
3839:     PROCEDURE ContSegLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3840:         LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
3841:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3842:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContSeg.Value)
3843:         IF !EMPTY(loc_cConta)
3844:             TRY
3845:                 loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
3846:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContSegVal")
3847:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContSegVal") OR EOF("cursor_4c_ContSegVal")
3848:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3849:                     loc_oPg2.txt_4c_ContSeg.Value = ""
3850:                 ENDIF
3851:                 IF USED("cursor_4c_ContSegVal")
3852:                     USE IN cursor_4c_ContSegVal
3853:                 ENDIF
3854:             CATCH TO loc_oErro
3855:                 IF USED("cursor_4c_ContSegVal")
3856:                     USE IN cursor_4c_ContSegVal
3857:                 ENDIF
3858:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Seguro")
3859:             ENDTRY
3860:         ENDIF
3861:     ENDPROC
3862: 
3863:     *==========================================================================
3864:     * ContDaLostFocus - Valida conta contabil de Despesas ao sair do campo (PUBLIC BINDEVENT)
3865:     *==========================================================================
3866:     PROCEDURE ContDaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3867:         LOCAL loc_cConta, loc_cSQL, loc_nRet, loc_oPg2
3868:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3869:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContDa.Value)
3870:         IF !EMPTY(loc_cConta)
3871:             TRY
3872:                 loc_cSQL = "SELECT TOP 1 codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
3873:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDaVal")
3874:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContDaVal") OR EOF("cursor_4c_ContDaVal")
3875:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3876:                     loc_oPg2.txt_4c_ContDa.Value = ""
3877:                 ENDIF
3878:                 IF USED("cursor_4c_ContDaVal")
3879:                     USE IN cursor_4c_ContDaVal
3880:                 ENDIF
3881:             CATCH TO loc_oErro
3882:                 IF USED("cursor_4c_ContDaVal")
3883:                     USE IN cursor_4c_ContDaVal
3884:                 ENDIF
3885:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Despesas")
3886:             ENDTRY
3887:         ENDIF
3888:     ENDPROC
3889: 
3890:     *==========================================================================
3891:     PROCEDURE Destroy()
3892:     *==========================================================================
3893:         TRY
3894:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3895:                 THIS.this_oBusinessObject = .NULL.
3896:             ENDIF
3897:         CATCH TO loc_oErro
3898:             MsgErro(loc_oErro.Message, "Erro em Destroy")
3899:         ENDTRY
3900:         DODEFAULT()
3901:     ENDPROC
3902: 
3903: ENDDEFINE


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para Cadastro de CFOP
* Tabela: SigCdCfo
* Chave: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdCfo (mapeados diretamente do schema)
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCodigos    = ""    && codigos     char(10)  PK
    this_cDescricaos = ""    && descricaos  char(60)  Descricao nota fiscal
    this_cDesc2s     = ""    && desc2s      char(60)  Descricao consulta

    *-- Operacao e tipo
    this_cOperacaos  = ""    && operacaos   char(1)   E=Entrada S=Saida
    this_nTipos      = 0     && tipos       numeric(1,0)
    this_nNdigitos   = 0     && ndigitos    numeric(2,0)  Digitos para NF

    *-- ICMS
    this_cIcms       = ""    && icms        char(1)   T=Tributado I=Isento O=Outros N=N.Tributa
    this_cSittribs   = ""    && sittribs    char(3)   Situacao tributaria ICMS
    this_nAliqivcs   = 0     && aliqivcs    numeric(4,2)  Aliquota venda consumidor
    this_nInclicms   = 0     && inclicms    numeric(1,0)  Incluir ICMS na base
    this_nIcmsdscs   = 0     && icmsdscs    numeric(1,0)  ICMS incluso no preco
    this_nIcmsincs   = 0     && icmsincs    numeric(1,0)  Integrar valores ICMS
    this_nIncicmnfs  = 0     && incicmnfs   numeric(1,0)  Incluir ICMS no total da NF
    this_cCgergia1s  = ""    && cgergia1s   char(1)   Destaca ICMS na NF S/N
    this_nFrticms    = 0     && frticms     numeric(1,0)  Frete compoe base ICMS
    this_nSegicms    = 0     && segicms     numeric(1,0)  Seguro compoe base ICMS
    this_nDesicms    = 0     && desicms     numeric(1,0)  Despesas compoe base ICMS

    *-- Substituicao tributaria ICMS
    this_cSubtribs   = ""    && subtribs    char(1)   Substituicao tributaria S/N
    this_nPbcsts     = 0     && pbcsts      numeric(5,2)  % base ST
    this_cCfosts     = ""    && cfosts      char(10)  CFOP subst. tributaria
    this_cCoddests   = ""    && coddests    char(10)  CFOP destino
    this_nTransps    = 0     && transps     numeric(1,0)  CFOP transporte

    *-- IPI
    this_cIpis       = ""    && ipis        char(1)   T=Tributado I=Isento O=Outros
    this_cIpi_icms   = ""    && ipi_icms    char(1)   IPI sobre ICMS
    this_nInclipis   = 0     && inclipis    numeric(1,0)  Incluir IPI na base
    this_nPbcipis    = 0     && pbcipis     numeric(5,2)  % base IPI
    this_cBcipis     = ""    && bcipis      char(1)   Base de calculo IPI
    this_nAliqipis   = 0     && aliqipis    numeric(4,2)  Aliquota IPI
    this_cAcresipis  = ""    && acresipis   char(1)   Acrescenta na base
    this_cIpiimpors  = ""    && ipiimpors   char(1)   IPI importacao
    this_cIpiom2s    = ""    && ipiom2s     char(1)   IPI calc. p/ origem mercadoria=2
    this_nFrtipis    = 0     && frtipis     numeric(1,0)  Frete compoe base IPI
    this_nSegipis    = 0     && segipis     numeric(1,0)  Seguro compoe base IPI
    this_nDesipis    = 0     && desipis     numeric(1,0)  Despesas compoe base IPI
    this_nIpincreds  = 0     && ipincreds   numeric(1,0)  IPI nao creditado
    this_nPontedescs = 0     && pontedescs  numeric(1,0)  Retira IPI do valor
    this_cIpicst     = ""    && ipicst      char(2)   Codigo IPI sit. tributaria NF-e
    this_cIpienq     = ""    && ipienq      char(3)   Enquadramento IPI
    this_cUnitimps   = ""    && unitimps    char(1)   Inibe valor unitario NF importacao

    *-- PIS / COFINS / ISSQN / II
    this_cPiscst     = ""    && piscst      char(2)   Codigo PIS sit. tributaria
    this_cCofcst     = ""    && cofcst      char(2)   Codigo COFINS sit. tributaria
    this_cIssqnl     = ""    && issqnl      char(5)   Codigo ISSQN lista servicos
    this_nAliqpis    = 0     && aliqpis     numeric(5,2)  Aliquota PIS
    this_nAliqcofins = 0     && aliqcofins  numeric(5,2)  Aliquota COFINS
    this_nAliqissqn  = 0     && aliqissqn   numeric(5,2)  Aliquota ISSQN
    this_nAliqii     = 0     && aliqii      numeric(5,2)  Aliquota II
    this_nCtissqn    = 0     && ctissqn     numeric(1,0)  Codigo tributacao ISSQN
    this_nRettribs   = 0     && rettribs    numeric(1,0)  Informa retencao de tributos

    *-- Contribuinte / Situacao
    this_cContribs   = ""    && contribs    char(1)   S=Sim N=Nao O=Outros
    this_nSituas     = 0     && situas      numeric(1,0)  0=Ativo 1=Inativo
    this_cCfost60s   = ""    && cfost60s    char(10)  CFOP ST60
    this_nSomaicmfrete = 0   && somaicmfrete numeric(1,0)
    this_cMotdeson   = ""    && motdeson    char(2)   Motivo desoneracao ICMS

    *-- Integracao Contabil - Contas DB/CR
    this_cContconts  = ""    && contconts   char(1)   Pega conta contabil da NF
    this_cContvcds   = ""    && contvcds    char(9)   Conta valor contabil DB
    this_cContvccs   = ""    && contvccs    char(9)   Conta valor contabil CR
    this_cContipds   = ""    && contipds    char(9)   Conta IPI DB
    this_cContipcs   = ""    && contipcs    char(9)   Conta IPI CR
    this_cConticds   = ""    && conticds    char(9)   Conta ICMS DB
    this_cConticcs   = ""    && conticcs    char(9)   Conta ICMS CR
    this_cContfrt    = ""    && contfrt     char(9)   Conta frete
    this_cContseg    = ""    && contseg     char(9)   Conta seguro
    this_cContda     = ""    && contda      char(9)   Conta despesas acessorias

    *-- Integracao Contabil - Opcoes
    this_nAgrupas    = 0     && agrupas     numeric(1,0)  Agrupa CFO na integracao
    this_nZeradas    = 0     && zeradas     numeric(1,0)  Integracao zerada
    this_nIntvlrcont = 0     && intvlrcont  numeric(1,0)  Integrar valor contabil
    this_nIntvlricms = 0     && intvlricms  numeric(1,0)  Integrar valores ICMS
    this_nIntvlripi  = 0     && intvlripi   numeric(1,0)  Integrar valores IPI
    this_nUtilvars   = 0     && utilvars    numeric(1,0)  Utilizar variacao CFOP
    this_nIndmov     = 0     && indmov      numeric(1,0)  Movimentacao fisica estoque
    this_nIndpagto   = 0     && indpagto    numeric(1,0)  Indicacao pagamento
    this_nTiporecs   = 0     && tiporecs    numeric(1,0)  Data lancamento contabil
    this_nObspads    = 0     && obspads     numeric(3,0)  Observacao padrao
    this_nDtintfis   = 0     && dtintfis    numeric(1,0)  Integracao fiscal

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cIpi_icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCols, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCols = "codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis"

            loc_cVals = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "INSERT INTO SigCdCfo (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSet, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSet = "descricaos = "  + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s = "             + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "operacaos = "          + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "tipos = "              + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "ndigitos = "           + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms = "               + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "sittribs = "           + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "aliqivcs = "           + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "inclicms = "           + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsdscs = "           + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "icmsincs = "           + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "incicmnfs = "          + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "cgergia1s = "          + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "frticms = "            + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms = "            + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "desicms = "            + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "subtribs = "           + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "pbcsts = "             + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "cfosts = "             + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests = "           + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "transps = "            + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "ipis = "               + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "ipi_icms = "           + EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                "inclipis = "           + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "pbcipis = "            + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "bcipis = "             + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "aliqipis = "           + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "acresipis = "          + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors = "          + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s = "            + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "frtipis = "            + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis = "            + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "desipis = "            + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "ipincreds = "          + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "pontedescs = "         + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "ipicst = "             + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "ipienq = "             + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "unitimps = "           + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "piscst = "             + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst = "             + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl = "             + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis = "            + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins = "         + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn = "          + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "aliqii = "             + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ctissqn = "            + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs = "           + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "contribs = "           + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "situas = "             + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "cfost60s = "           + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "somaicmfrete = "       + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "motdeson = "           + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "contconts = "          + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "contvcds = "           + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs = "           + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "contipds = "           + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs = "           + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "conticds = "           + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs = "           + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contfrt = "            + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg = "            + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda = "             + EscaparSQL(THIS.this_cContda) + ", " + ;
                "agrupas = "            + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas = "            + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "intvlrcont = "         + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms = "         + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi = "          + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "utilvars = "           + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "indmov = "             + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto = "           + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "tiporecs = "           + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads = "            + FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                "dtintfis = "           + FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "UPDATE SigCdCfo SET " + loc_cSet + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCfo WHERE codigos = " + ;
                EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, desc2s, operacaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, situas" + ;
                " FROM SigCdCfo"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                " FROM SigCdCfo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da nota fiscal obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE


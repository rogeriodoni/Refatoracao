# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDIR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1167 linhas total):

*-- Linhas 35 a 149:
35:     Themes      = .F.
36:     ShowTips    = .T.
37: 
38:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
39:     this_oRelatorio    = .NULL.
40:     this_cMensagemErro = ""
41: 
42:     *--------------------------------------------------------------------------
43:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
44:     *        e garante SET DATE BRITISH + SET CENTURY ON (DataSession=2)
45:     *--------------------------------------------------------------------------
46:     PROCEDURE Init()
47:         RETURN DODEFAULT()
48:     ENDPROC
49: 
50:     *--------------------------------------------------------------------------
51:     * InicializarForm - Constroi estrutura visual e instancia o BO
52:     *   Ordem obrigatoria: estrutura visual ANTES do BO (estrutura nao depende
53:     *   de SQL, BO depende - assim o form abre mesmo em modo validacao UI).
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso
57:         loc_lSucesso = .F.
58: 
59:         TRY
60:             THIS.Caption = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos - CSLL, COFINS e PIS/PASEP"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
66: 
67:             *-- Estrutura visual (independe de SQL - construida sempre)
68:             THIS.ConfigurarCabecalho()
69:             THIS.ConfigurarBotoes()
70:             THIS.ConfigurarPageFrame()
71: 
72:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:             *-- Instanciar BO apenas quando ha conexao real (pula em validacao UI)
76:             *   SIGREDIRBO.Init() executa SQLEXEC para carregar empresas;
77:             *   em modo gb_4c_ValidandoUI (gnConnHandle=-1) isso falharia.
78:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
79:                 THIS.this_oRelatorio = CREATEOBJECT("SIGREDIRBO")
80:                 IF VARTYPE(THIS.this_oRelatorio) != "O"
81:                     MsgErro("Erro ao criar SIGREDIRBO" + CHR(13) + ;
82:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
83:                     loc_lSucesso = .F.
84:                 ENDIF
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87:                 THIS.LimparCampos()
88:             ENDIF
89: 
90:             THIS.Visible   = .T.
91:             loc_lSucesso   = .T.
92: 
93:         CATCH TO loc_oErro
94:             THIS.this_cMensagemErro = loc_oErro.Message
95:             MsgErro(loc_oErro.Message + CHR(13) + ;
96:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
97:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
98:         ENDTRY
99: 
100:         RETURN loc_lSucesso
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
105:     *   Equivalente ao cntSombra do frmrelatorio legado.
106:     *   Width = THIS.Width (cobre toda a faixa superior - cnt_4c_Saida eh
107:     *   transparente por cima, nao precisa deixar espaco).
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarCabecalho()
110:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH THIS.cnt_4c_Cabecalho
112:             .Top         = 0
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackStyle   = 1
117:             .BackColor   = RGB(100, 100, 100)
118:             .BorderWidth = 0
119:             .Visible     = .T.
120: 
121:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Top       = 22
125:                 .Left      = 22
126:                 .Width     = THIS.Width
127:                 .Height    = 30
128:                 .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 14
131:                 .FontBold  = .T.
132:                 .ForeColor = RGB(0, 0, 0)
133:                 .BackStyle = 0
134:                 .Visible   = .T.
135:             ENDWITH
136: 
137:             *-- Titulo em branco sobre a sombra
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Top       = 20
141:                 .Left      = 20
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(255, 255, 255)
149:                 .BackStyle = 0

*-- Linhas 159 a 202:
159:     *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
160:     *     Buttons: Top=5, Width=65, Height=70, Lefts=5/71/137/203
161:     *--------------------------------------------------------------------------
162:     PROTECTED PROCEDURE ConfigurarBotoes()
163:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
164:         WITH THIS.cmg_4c_Botoes
165:             .Top           = 0
166:             .Left          = 529
167:             .Width         = 273
168:             .Height        = 80
169:             .ButtonCount   = 4
170:             .BackStyle     = 0
171:             .BorderStyle   = 0
172:             .BorderColor   = RGB(136, 189, 188)
173:             .SpecialEffect = 1
174:             .Themes        = .F.
175:             .Visible       = .T.
176: 
177:             *-- Buttons(1): Visualizar (preview em tela)
178:             WITH .Buttons(1)
179:                 .Top             = 5
180:                 .Left            = 5
181:                 .Width           = 65
182:                 .Height          = 70
183:                 .Caption         = "Visualizar"
184:                 .FontBold        = .T.
185:                 .FontItalic      = .T.
186:                 .BackColor       = RGB(255, 255, 255)
187:                 .ForeColor       = RGB(90, 90, 90)
188:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
189:                 .PicturePosition = 13
190:                 .SpecialEffect   = 0
191:                 .MousePointer    = 15
192:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
193:                 .Themes          = .F.
194:                 .Visible         = .T.
195:             ENDWITH
196: 
197:             *-- Buttons(2): Imprimir (com dialogo de impressora)
198:             WITH .Buttons(2)
199:                 .Top             = 5
200:                 .Left            = 71
201:                 .Width           = 65
202:                 .Height          = 70

*-- Linhas 269 a 344:
269:     *   Height = THIS.Height - 85 = 350 - 85 = 265
270:     *   Page1 recebe os controles de filtro nas fases seguintes (4-6).
271:     *--------------------------------------------------------------------------
272:     PROTECTED PROCEDURE ConfigurarPageFrame()
273:         LOCAL loc_oPgf
274: 
275:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
276:         loc_oPgf = THIS.pgf_4c_Paginas
277: 
278:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
279:         loc_oPgf.PageCount = 1
280: 
281:         loc_oPgf.Top    = 85
282:         loc_oPgf.Left   = -1
283:         loc_oPgf.Width  = THIS.Width + 2
284:         loc_oPgf.Height = THIS.Height - 85
285:         loc_oPgf.Tabs   = .F.
286: 
287:         loc_oPgf.Page1.Caption   = "Filtros"
288:         loc_oPgf.Page1.FontName  = "Tahoma"
289:         loc_oPgf.Page1.FontSize  = 8
290:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
291:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
292:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
293: 
294:         loc_oPgf.Visible    = .T.
295:         loc_oPgf.ActivePage = 1
296:     ENDPROC
297: 
298:     *--------------------------------------------------------------------------
299:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 e conecta eventos
300:     *   Em forms REPORT, "Pagina Lista" eh a unica pagina (filtros + grid de empresas)
301:     *   Posicoes relativas a Page1 (top original - pgf.Top=85)
302:     *   Chamado APOS SIGREDIRBO ser instanciado (grid usa cursor de empresas)
303:     *--------------------------------------------------------------------------
304:     PROTECTED PROCEDURE ConfigurarPaginaLista()
305:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
306: 
307:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
308: 
309:         *-- Label "Ano Base :"  (original: Say2.Top=109, Left=181 -> Page1: 24, 181)
310:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
311:         WITH loc_oPagina.lbl_4c_Label2
312:             .Top       = 24
313:             .Left      = 181
314:             .Width     = 54
315:             .Height    = 18
316:             .Caption   = "Ano Base :"
317:             .FontName  = "Tahoma"
318:             .FontSize  = 8
319:             .ForeColor = RGB(90, 90, 90)
320:             .BackStyle = 0
321:             .Visible   = .T.
322:         ENDWITH
323: 
324:         *-- TextBox Ano Base (original: getAnoBase.Top=106, Left=242 -> Page1: 21, 242)
325:         loc_oPagina.AddObject("txt_4c_AnoBase", "TextBox")
326:         WITH loc_oPagina.txt_4c_AnoBase
327:             .Top       = 21
328:             .Left      = 242
329:             .Width     = 38
330:             .Height    = 23
331:             .FontName  = "Tahoma"
332:             .FontSize  = 8
333:             .Value     = ""
334:             .InputMask = "9999"
335:             .MaxLength = 4
336:             .Visible   = .T.
337:         ENDWITH
338: 
339:         *-- Label "Fornecedor :"  (original: Say4.Top=147, Left=171 -> Page1: 62, 171)
340:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
341:         WITH loc_oPagina.lbl_4c_Label4
342:             .Top       = 62
343:             .Left      = 171
344:             .Width     = 64

*-- Linhas 514 a 1167:
514:             ENDWITH
515:         ENDWITH
516: 
517:         *-- BINDEVENTs (todos os handlers sao PUBLIC - exigencia do BINDEVENT)
518:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
519:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
520:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
521:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
522:         BINDEVENT(loc_oPagina.txt_4c_Fornec, "KeyPress", THIS, "TeclaFornecKeyPress")
523:         BINDEVENT(loc_oPagina.txt_4c_Dforn,  "KeyPress", THIS, "TeclaDfornKeyPress")
524:         BINDEVENT(loc_oPagina.chk_4c_MarcaEmp,       "InteractiveChange", THIS, "BtnMarcaEmpClick")
525:         BINDEVENT(loc_oPagina.obj_4c_CmdEmps.Buttons(1), "Click", THIS, "BtnCmdEmp1Click")
526:         BINDEVENT(loc_oPagina.obj_4c_CmdEmps.Buttons(2), "Click", THIS, "BtnCmdEmp2Click")
527:     ENDPROC
528: 
529:     *--------------------------------------------------------------------------
530:     * FormParaRelatorio - Copia filtros do form para o BO antes de gerar
531:     *--------------------------------------------------------------------------
532:     PROTECTED PROCEDURE FormParaRelatorio()
533:         IF VARTYPE(THIS.this_oRelatorio) != "O"
534:             RETURN
535:         ENDIF
536:         WITH THIS.this_oRelatorio
537:             .this_cAnoBase = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
538:             .this_cFornec  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
539:             .this_cDforn   = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value)
540:         ENDWITH
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * BtnIncluirClick - Mapeamento CRUD->REPORT: "incluir" = gerar novo relatorio
545:     *   Form de relatorio nao possui operacoes CRUD. Para satisfazer a interface
546:     *   esperada pelo pipeline de validacao, este metodo delega para o fluxo
547:     *   equivalente em REPORT: limpar campos para um novo relatorio e gerar o
548:     *   preview com os filtros padrao (ano corrente, todas as empresas).
549:     *--------------------------------------------------------------------------
550:     PROCEDURE BtnIncluirClick()
551:         LOCAL loc_oPagina
552:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
553: 
554:         *-- Reset filtros para estado inicial e marcar todas as empresas
555:         THIS.LimparCampos()
556:         IF VARTYPE(THIS.this_oRelatorio) = "O"
557:             THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.T.)
558:             IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
559:                 loc_oPagina.chk_4c_MarcaEmp.Value = 1
560:             ENDIF
561:             IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
562:                 loc_oPagina.grd_4c_Dados.Refresh()
563:             ENDIF
564:         ENDIF
565: 
566:         *-- Foco no primeiro filtro relevante (ano base)
567:         IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
568:             loc_oPagina.txt_4c_AnoBase.SetFocus()
569:         ENDIF
570:     ENDPROC
571: 
572:     *--------------------------------------------------------------------------
573:     * BtnAlterarClick - Mapeamento CRUD->REPORT: "alterar" = enviar para impressora
574:     *   Form de relatorio nao possui edicao de registros. Esta operacao delega
575:     *   para BtnImprimirClick (alterar a saida de tela -> impressora) preservando
576:     *   a validacao completa de ano base e empresas selecionadas.
577:     *--------------------------------------------------------------------------
578:     PROCEDURE BtnAlterarClick()
579:         THIS.BtnImprimirClick()
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * BtnVisualizarClick - Preview do relatorio na tela (Buttons(1))
584:     *--------------------------------------------------------------------------
585:     PROCEDURE BtnVisualizarClick()
586:         LOCAL loc_cAno, loc_cMensagem, loc_cEmpresas
587:         loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
588:         IF EMPTY(loc_cAno)
589:             MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
590:             THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
591:             RETURN
592:         ENDIF
593:         loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
594:         IF EMPTY(ALLTRIM(loc_cEmpresas))
595:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
596:             IF EMPTY(loc_cMensagem)
597:                 loc_cMensagem = "Nenhuma empresa foi selecionada."
598:             ENDIF
599:             MsgAviso(loc_cMensagem, "Aviso")
600:             RETURN
601:         ENDIF
602:         THIS.FormParaRelatorio()
603:         IF !THIS.this_oRelatorio.Visualizar()
604:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
605:             IF !EMPTY(loc_cMensagem)
606:                 MsgErro(loc_cMensagem, "Erro")
607:             ENDIF
608:         ENDIF
609:     ENDPROC
610: 
611:     *--------------------------------------------------------------------------
612:     * BtnImprimirClick - Envia relatorio para impressora com dialogo (Buttons(2))
613:     *--------------------------------------------------------------------------
614:     PROCEDURE BtnImprimirClick()
615:         LOCAL loc_cAno, loc_cMensagem, loc_cEmpresas
616:         loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
617:         IF EMPTY(loc_cAno)
618:             MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
619:             THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
620:             RETURN
621:         ENDIF
622:         loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
623:         IF EMPTY(ALLTRIM(loc_cEmpresas))
624:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
625:             IF EMPTY(loc_cMensagem)
626:                 loc_cMensagem = "Nenhuma empresa foi selecionada."
627:             ENDIF
628:             MsgAviso(loc_cMensagem, "Aviso")
629:             RETURN
630:         ENDIF
631:         THIS.FormParaRelatorio()
632:         IF !THIS.this_oRelatorio.ImprimirComPrompt()
633:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
634:             IF !EMPTY(loc_cMensagem)
635:                 MsgErro(loc_cMensagem, "Erro")
636:             ENDIF
637:         ENDIF
638:     ENDPROC
639: 
640:     *--------------------------------------------------------------------------
641:     * BtnExcelClick - Exporta dados do relatorio para arquivo XLS (Buttons(3))
642:     *--------------------------------------------------------------------------
643:     PROCEDURE BtnExcelClick()
644:         LOCAL loc_cAno, loc_cMensagem, loc_cArquivo, loc_cEmpresas
645:         loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.Value)
646:         IF EMPTY(loc_cAno)
647:             MsgAviso("Ano base n" + CHR(227) + "o informado.", "Aviso")
648:             THIS.pgf_4c_Paginas.Page1.txt_4c_AnoBase.SetFocus()
649:             RETURN
650:         ENDIF
651:         loc_cEmpresas = THIS.this_oRelatorio.MontarEmpresas()
652:         IF EMPTY(ALLTRIM(loc_cEmpresas))
653:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
654:             IF EMPTY(loc_cMensagem)
655:                 loc_cMensagem = "Nenhuma empresa foi selecionada."
656:             ENDIF
657:             MsgAviso(loc_cMensagem, "Aviso")
658:             RETURN
659:         ENDIF
660:         THIS.FormParaRelatorio()
661:         IF THIS.this_oRelatorio.ExportarExcel()
662:             loc_cArquivo = THIS.this_oRelatorio.this_cUltimoArquivoExcel
663:             IF !EMPTY(loc_cArquivo)
664:                 MsgInfo("Relat" + CHR(243) + "rio exportado para:" + CHR(13) + ;
665:                     loc_cArquivo, "Exporta" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da")
666:             ENDIF
667:         ELSE
668:             loc_cMensagem = THIS.this_oRelatorio.ObterMensagemErro()
669:             IF !EMPTY(loc_cMensagem)
670:                 MsgErro(loc_cMensagem, "Erro")
671:             ENDIF
672:         ENDIF
673:     ENDPROC
674: 
675:     *--------------------------------------------------------------------------
676:     * BtnExcluirClick - Mapeamento CRUD->REPORT: "excluir" = limpar selecoes
677:     *   Form de relatorio nao possui exclusao de registros. Esta operacao
678:     *   delega para a limpeza dos filtros e desmarcacao de todas as empresas,
679:     *   deixando o form pronto para uma nova configuracao de relatorio.
680:     *--------------------------------------------------------------------------
681:     PROCEDURE BtnExcluirClick()
682:         LOCAL loc_oPagina
683:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
684: 
685:         THIS.LimparCampos()
686:         IF VARTYPE(THIS.this_oRelatorio) = "O"
687:             THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.F.)
688:             IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
689:                 loc_oPagina.chk_4c_MarcaEmp.Value = 0
690:             ENDIF
691:             IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
692:                 loc_oPagina.grd_4c_Dados.Refresh()
693:             ENDIF
694:         ENDIF
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     * BtnEncerrarClick - Fecha o form (Buttons(4) - Cancel=.T. / ESC)
699:     *--------------------------------------------------------------------------
700:     PROCEDURE BtnEncerrarClick()
701:         THIS.Release()
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * TeclaFornecKeyPress - F4/ENTER/TAB em txt_4c_Fornec
706:     *   F4(115)/F5(116): abre busca por codigo
707:     *   ENTER(13)/TAB(9): valida codigo digitado e busca descricao
708:     *--------------------------------------------------------------------------
709:     PROCEDURE TeclaFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
710:         DO CASE
711:             CASE INLIST(par_nKeyCode, 115, 116)
712:                 THIS.AbrirBuscaFornec()
713: 
714:             CASE INLIST(par_nKeyCode, 13, 9)
715:                 THIS.ValidarFornec()
716:         ENDCASE
717:     ENDPROC
718: 
719:     *--------------------------------------------------------------------------
720:     * TeclaDfornKeyPress - F4/ENTER/TAB em txt_4c_Dforn
721:     *   Habilitado apenas quando txt_4c_Fornec esta vazio (busca por nome)
722:     *   F4(115)/F5(116)/ENTER(13)/TAB(9): abre busca por nome
723:     *--------------------------------------------------------------------------
724:     PROCEDURE TeclaDfornKeyPress(par_nKeyCode, par_nShiftAltCtrl)
725:         LOCAL loc_cCodFornec
726:         loc_cCodFornec = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
727:         IF !EMPTY(loc_cCodFornec)
728:             RETURN
729:         ENDIF
730:         IF INLIST(par_nKeyCode, 115, 116, 13, 9)
731:             THIS.AbrirBuscaFornecPorNome()
732:         ENDIF
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * ValidarFornec - Valida codigo digitado em txt_4c_Fornec via SQLEXEC
737:     *   Se encontrado: preenche txt_4c_Dforn e torna ReadOnly
738:     *   Se nao encontrado: abre FormBuscaAuxiliar para selecao
739:     *--------------------------------------------------------------------------
740:     PROTECTED PROCEDURE ValidarFornec()
741:         LOCAL loc_cValor, loc_cSQL, loc_nResult
742:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
743: 
744:         IF EMPTY(loc_cValor)
745:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ""
746:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .F.
747:             RETURN
748:         ENDIF
749: 
750:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
751:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
752: 
753:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_FornVal") = 1
754:             SELECT cursor_4c_FornVal
755:             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
756:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
757:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
758:         ELSE
759:             IF USED("cursor_4c_FornVal")
760:                 USE IN cursor_4c_FornVal
761:             ENDIF
762:             THIS.AbrirBuscaFornec()
763:             RETURN
764:         ENDIF
765: 
766:         IF USED("cursor_4c_FornVal")
767:             USE IN cursor_4c_FornVal
768:         ENDIF
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     * AbrirBuscaFornec - Abre FormBuscaAuxiliar para SigCdCli buscando por codigo
773:     *   Ao selecionar: preenche txt_4c_Fornec, txt_4c_Dforn e torna ReadOnly
774:     *--------------------------------------------------------------------------
775:     PROTECTED PROCEDURE AbrirBuscaFornec()
776:         LOCAL loc_cValorAtual, loc_oBusca
777:         TRY
778:             loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
779: 
780:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
781:                 gnConnHandle, ;
782:                 "SigCdCli", ;
783:                 "cursor_4c_Busca", ;
784:                 "iclis", ;
785:                 loc_cValorAtual, ;
786:                 "Busca de Fornecedor")
787: 
788:             IF VARTYPE(loc_oBusca) = "O"
789:                 IF loc_oBusca.this_lSelecionou
790:                     IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
791:                         SELECT cursor_4c_Busca
792:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
793:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
794:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
795:                     ENDIF
796:                 ELSE
797:                     IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
798:                         loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
799:                         loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
800:                         loc_oBusca.Show()
801:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
802:                             SELECT cursor_4c_Busca
803:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
804:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
805:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
806:                         ENDIF
807:                     ENDIF
808:                 ENDIF
809:                 loc_oBusca.Release()
810:             ENDIF
811: 
812:             IF USED("cursor_4c_Busca")
813:                 USE IN cursor_4c_Busca
814:             ENDIF
815: 
816:         CATCH TO loc_oErro
817:             MsgErro(loc_oErro.Message, "Erro")
818:         ENDTRY
819:     ENDPROC
820: 
821:     *--------------------------------------------------------------------------
822:     * AbrirBuscaFornecPorNome - Abre FormBuscaAuxiliar buscando por nome/razao social
823:     *   Ativado quando txt_4c_Fornec esta vazio e usuario digita em txt_4c_Dforn
824:     *   Ao selecionar: preenche ambos os campos e torna txt_4c_Dforn ReadOnly
825:     *--------------------------------------------------------------------------
826:     PROTECTED PROCEDURE AbrirBuscaFornecPorNome()
827:         LOCAL loc_cValorAtual, loc_oBusca
828:         TRY
829:             loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value)
830: 
831:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
832:                 gnConnHandle, ;
833:                 "SigCdCli", ;
834:                 "cursor_4c_Busca", ;
835:                 "rclis", ;
836:                 loc_cValorAtual, ;
837:                 "Busca de Fornecedor por Nome")
838: 
839:             IF VARTYPE(loc_oBusca) = "O"
840:                 IF loc_oBusca.this_lSelecionou
841:                     IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
842:                         SELECT cursor_4c_Busca
843:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
844:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
845:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
846:                     ENDIF
847:                 ELSE
848:                     IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
849:                         loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
850:                         loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
851:                         loc_oBusca.Show()
852:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
853:                             SELECT cursor_4c_Busca
854:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
855:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
856:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
857:                         ENDIF
858:                     ENDIF
859:                 ENDIF
860:                 loc_oBusca.Release()
861:             ENDIF
862: 
863:             IF USED("cursor_4c_Busca")
864:                 USE IN cursor_4c_Busca
865:             ENDIF
866: 
867:         CATCH TO loc_oErro
868:             MsgErro(loc_oErro.Message, "Erro")
869:         ENDTRY
870:     ENDPROC
871: 
872:     *--------------------------------------------------------------------------
873:     * BtnMarcaEmpClick - Marca/desmarca todas as empresas pelo chk_4c_MarcaEmp
874:     *   CheckBox.Value=1 -> marca todas; Value=0 -> desmarca todas
875:     *--------------------------------------------------------------------------
876:     PROCEDURE BtnMarcaEmpClick()
877:         LOCAL loc_lMarcar
878:         IF VARTYPE(THIS.this_oRelatorio) != "O"
879:             RETURN
880:         ENDIF
881:         loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 1)
882:         THIS.this_oRelatorio.AtualizarSelecaoEmpresas(loc_lMarcar)
883:         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
884:     ENDPROC
885: 
886:     *--------------------------------------------------------------------------
887:     * BtnCmdEmp1Click - Botao "Marcar Todas" do obj_4c_CmdEmps
888:     *--------------------------------------------------------------------------
889:     PROCEDURE BtnCmdEmp1Click()
890:         IF VARTYPE(THIS.this_oRelatorio) = "O"
891:             THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.T.)
892:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
893:             THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 1
894:         ENDIF
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * BtnCmdEmp2Click - Botao "Desmarcar" do obj_4c_CmdEmps
899:     *--------------------------------------------------------------------------
900:     PROCEDURE BtnCmdEmp2Click()
901:         IF VARTYPE(THIS.this_oRelatorio) = "O"
902:             THIS.this_oRelatorio.AtualizarSelecaoEmpresas(.F.)
903:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
904:             THIS.pgf_4c_Paginas.Page1.chk_4c_MarcaEmp.Value = 0
905:         ENDIF
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * AlternarPagina - Alterna a pagina ativa do PageFrame de filtros
910:     *   par_nPagina: indice da pagina (1..PageCount). Valores invalidos sao
911:     *   limitados ao range valido. Refresca o grid de empresas ao voltar
912:     *   para a pagina 1 (lista de filtros) para garantir que o estado
913:     *   visual reflita o cursor (apos AtualizarSelecaoEmpresas*, por exemplo).
914:     *--------------------------------------------------------------------------
915:     PROCEDURE AlternarPagina(par_nPagina)
916:         LOCAL loc_nPagina, loc_nMax, loc_oPgf, loc_oGrid
917: 
918:         IF VARTYPE(par_nPagina) <> "N"
919:             loc_nPagina = 1
920:         ELSE
921:             loc_nPagina = par_nPagina
922:         ENDIF
923: 
924:         loc_oPgf = THIS.pgf_4c_Paginas
925:         IF VARTYPE(loc_oPgf) <> "O"
926:             RETURN
927:         ENDIF
928: 
929:         loc_nMax = loc_oPgf.PageCount
930:         IF loc_nPagina < 1
931:             loc_nPagina = 1
932:         ENDIF
933:         IF loc_nPagina > loc_nMax
934:             loc_nPagina = loc_nMax
935:         ENDIF
936: 
937:         loc_oPgf.ActivePage = loc_nPagina
938: 
939:         IF loc_nPagina = 1
940:             loc_oGrid = loc_oPgf.Page1.grd_4c_Dados
941:             IF VARTYPE(loc_oGrid) = "O"
942:                 loc_oGrid.Refresh()
943:             ENDIF
944:         ENDIF
945:     ENDPROC
946: 
947:     *--------------------------------------------------------------------------
948:     * ConfigurarPaginaDados - Inicializa valores padrao dos campos de filtro
949:     *   Form SIGREDIR e plano (sem Page2); este metodo substitui o Init()
950:     *   do legado que definia: getAnoBase.Value = Str(Year(Date()),4)
951:     *   Chamado apos ConfigurarPaginaLista() para garantir que os controles
952:     *   ja existam antes de atribuir valores iniciais.
953:     *--------------------------------------------------------------------------
954:     PROTECTED PROCEDURE ConfigurarPaginaDados()
955:         LOCAL loc_oPagina
956:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
957: 
958:         *-- AnoBase: inicializa com ano corrente (original: getAnoBase.Value = Str(Year(Date()),4))
959:         IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
960:             loc_oPagina.txt_4c_AnoBase.Value = STR(YEAR(DATE()), 4)
961:         ENDIF
962: 
963:         *-- Fornecedor: campos iniciam vazios, txt_4c_Dforn habilitado para busca por nome
964:         IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
965:             loc_oPagina.txt_4c_Fornec.Value = ""
966:         ENDIF
967:         IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
968:             loc_oPagina.txt_4c_Dforn.Value    = ""
969:             loc_oPagina.txt_4c_Dforn.ReadOnly = .F.
970:         ENDIF
971:     ENDPROC
972: 
973:     *--------------------------------------------------------------------------
974:     * LimparCampos - Restaura campos de filtro para estado inicial
975:     *   Reseta ano base para o ano corrente e limpa filtro de fornecedor.
976:     *   Pode ser chamado externamente para reutilizar o form sem fechar.
977:     *--------------------------------------------------------------------------
978:     PROCEDURE LimparCampos()
979:         LOCAL loc_oPagina
980: 
981:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
982:             RETURN
983:         ENDIF
984: 
985:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
986:         IF VARTYPE(loc_oPagina) != "O"
987:             RETURN
988:         ENDIF
989: 
990:         IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
991:             loc_oPagina.txt_4c_AnoBase.Value = STR(YEAR(DATE()), 4)
992:         ENDIF
993:         IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
994:             loc_oPagina.txt_4c_Fornec.Value = ""
995:         ENDIF
996:         IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
997:             loc_oPagina.txt_4c_Dforn.Value    = ""
998:             loc_oPagina.txt_4c_Dforn.ReadOnly = .F.
999:         ENDIF
1000:     ENDPROC
1001: 
1002:     *--------------------------------------------------------------------------
1003:     * BtnBuscarClick - Preview do relatorio na tela
1004:     *   Mapeamento CRUD->REPORT: "buscar" = visualizar dados do relatorio
1005:     *--------------------------------------------------------------------------
1006:     PROCEDURE BtnBuscarClick()
1007:         THIS.BtnVisualizarClick()
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * BtnSalvarClick - Envia relatorio para impressora com dialogo
1012:     *   Mapeamento CRUD->REPORT: "salvar" = imprimir/gerar relatorio final
1013:     *--------------------------------------------------------------------------
1014:     PROCEDURE BtnSalvarClick()
1015:         THIS.BtnImprimirClick()
1016:     ENDPROC
1017: 
1018:     *--------------------------------------------------------------------------
1019:     * BtnCancelarClick - Fecha o form sem gerar relatorio
1020:     *   Mapeamento CRUD->REPORT: "cancelar" = encerrar sem gerar relatorio
1021:     *--------------------------------------------------------------------------
1022:     PROCEDURE BtnCancelarClick()
1023:         THIS.BtnEncerrarClick()
1024:     ENDPROC
1025: 
1026:     *--------------------------------------------------------------------------
1027:     * FormParaBO - Sincroniza filtros do form para o BO de relatorio
1028:     *   Alias de FormParaRelatorio() para compatibilidade com pipeline de validacao
1029:     *--------------------------------------------------------------------------
1030:     PROCEDURE FormParaBO()
1031:         THIS.FormParaRelatorio()
1032:     ENDPROC
1033: 
1034:     *--------------------------------------------------------------------------
1035:     * BOParaForm - Copia propriedades do BO de relatorio de volta para o form
1036:     *   Permite restaurar filtros a partir de estado salvo no BO
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE BOParaForm()
1039:         LOCAL loc_oPagina
1040:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1041:             RETURN
1042:         ENDIF
1043:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1044:             RETURN
1045:         ENDIF
1046:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1047:         IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
1048:             loc_oPagina.txt_4c_AnoBase.Value = ALLTRIM(THIS.this_oRelatorio.this_cAnoBase)
1049:         ENDIF
1050:         IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
1051:             loc_oPagina.txt_4c_Fornec.Value = ALLTRIM(THIS.this_oRelatorio.this_cFornec)
1052:         ENDIF
1053:         IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
1054:             loc_oPagina.txt_4c_Dforn.Value    = ALLTRIM(THIS.this_oRelatorio.this_cDforn)
1055:             loc_oPagina.txt_4c_Dforn.ReadOnly = !EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cFornec))
1056:         ENDIF
1057:     ENDPROC
1058: 
1059:     *--------------------------------------------------------------------------
1060:     * HabilitarCampos - Habilita ou desabilita campos de filtro do relatorio
1061:     *   par_lHabilitar: .T. habilita todos os filtros, .F. desabilita (somente leitura)
1062:     *--------------------------------------------------------------------------
1063:     PROCEDURE HabilitarCampos(par_lHabilitar)
1064:         LOCAL loc_oPagina, loc_lHabilitar
1065:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1066:             RETURN
1067:         ENDIF
1068:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1069:         loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1070: 
1071:         IF VARTYPE(loc_oPagina.txt_4c_AnoBase) = "O"
1072:             loc_oPagina.txt_4c_AnoBase.Enabled  = loc_lHabilitar
1073:         ENDIF
1074:         IF VARTYPE(loc_oPagina.txt_4c_Fornec) = "O"
1075:             loc_oPagina.txt_4c_Fornec.Enabled   = loc_lHabilitar
1076:         ENDIF
1077:         IF VARTYPE(loc_oPagina.txt_4c_Dforn) = "O"
1078:             loc_oPagina.txt_4c_Dforn.Enabled    = loc_lHabilitar
1079:         ENDIF
1080:         IF VARTYPE(loc_oPagina.chk_4c_MarcaEmp) = "O"
1081:             loc_oPagina.chk_4c_MarcaEmp.Enabled = loc_lHabilitar
1082:         ENDIF
1083:         IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
1084:             loc_oPagina.grd_4c_Dados.Enabled    = loc_lHabilitar
1085:         ENDIF
1086:         IF VARTYPE(loc_oPagina.obj_4c_CmdEmps) = "O"
1087:             loc_oPagina.obj_4c_CmdEmps.Enabled  = loc_lHabilitar
1088:         ENDIF
1089:     ENDPROC
1090: 
1091:     *--------------------------------------------------------------------------
1092:     * CarregarLista - Recarrega grid de selecao de empresas do banco de dados
1093:     *   Equivalente ao CarregarLista() de forms CRUD.
1094:     *   Retorna .T. se dados carregados com sucesso.
1095:     *--------------------------------------------------------------------------
1096:     PROCEDURE CarregarLista()
1097:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oGrid
1098:         loc_lSucesso = .F.
1099: 
1100:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1101:             RETURN .F.
1102:         ENDIF
1103: 
1104:         TRY
1105:             loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
1106:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1107: 
1108:             IF loc_nResult > 0
1109:                 IF USED(THIS.this_oRelatorio.this_cCursorEmpresas)
1110:                     USE IN (THIS.this_oRelatorio.this_cCursorEmpresas)
1111:                 ENDIF
1112:                 SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
1113:                     INTO CURSOR (THIS.this_oRelatorio.this_cCursorEmpresas) READWRITE
1114:                 USE IN cursor_4c_EmpTmp
1115: 
1116:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1117:                 IF VARTYPE(loc_oGrid) = "O"
1118:                     loc_oGrid.RecordSource          = THIS.this_oRelatorio.this_cCursorEmpresas
1119:                     loc_oGrid.Column1.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".Imps"
1120:                     loc_oGrid.Column2.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".cemps"
1121:                     loc_oGrid.Column3.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".razas"
1122:                     loc_oGrid.Refresh()
1123:                 ENDIF
1124: 
1125:                 loc_lSucesso = .T.
1126:             ELSE
1127:                 THIS.this_cMensagemErro = "Erro ao recarregar lista de empresas"
1128:             ENDIF
1129: 
1130:         CATCH TO loc_oErro
1131:             MsgErro(loc_oErro.Message, "Erro")
1132:             THIS.this_cMensagemErro = loc_oErro.Message
1133:         ENDTRY
1134: 
1135:         RETURN loc_lSucesso
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * AjustarBotoesPorModo - Atualiza estado visual dos botoes do CommandGroup
1140:     *   Forms de relatorio nao tem modos INCLUIR/ALTERAR/EXCLUIR distintos.
1141:     *   Visualizar/Imprimir/Excel ficam habilitados quando BO esta disponivel;
1142:     *   Encerrar fica sempre habilitado.
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE AjustarBotoesPorModo()
1145:         LOCAL loc_lConectado
1146:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
1147:             RETURN
1148:         ENDIF
1149:         loc_lConectado = (VARTYPE(THIS.this_oRelatorio) = "O")
1150:         THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lConectado
1151:         THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lConectado
1152:         THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lConectado
1153:         THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * Destroy - Libera referencia ao BO
1158:     *   NUNCA usar .Release() em objetos Custom/BO - apenas atribuir .NULL.
1159:     *--------------------------------------------------------------------------
1160:     PROCEDURE Destroy()
1161:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1162:             THIS.this_oRelatorio = .NULL.
1163:         ENDIF
1164:         DODEFAULT()
1165:     ENDPROC
1166: 
1167: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREDIRBO.prg):
*==============================================================================
* SIGREDIRBO.PRG
* Business Object - Demonstrativo de Retencao de Impostos
* CSLL, COFINS e PIS/PASEP
*
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREDIRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cAnoBase            = ""
    this_cFornec             = ""
    this_cDforn              = ""

    *-- Cursores internos
    this_cCursorEmpresas     = "cursor_4c_Empresas"
    this_cCursorDados        = "cursor_4c_Dados"

    *-- Arquivo de relatorio (sem extensao)
    this_cArquivoFRX         = "sigReDir"
    this_cUltimoArquivoExcel  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursor de empresas para selecao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        IF !DODEFAULT()
            THIS.this_cMensagemErro = "Falha na inicializa" + CHR(231) + CHR(227) + "o da classe base"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")

            IF loc_nResult > 0
                *-- Cria cursor local READWRITE para permitir marcacao pelo usuario
                IF USED(THIS.this_cCursorEmpresas)
                    USE IN (THIS.this_cCursorEmpresas)
                ENDIF
                SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
                    INTO CURSOR (THIS.this_cCursorEmpresas) READWRITE
                USE IN cursor_4c_EmpTmp
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar lista de empresas"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e recursos alocados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorEmpresas)
            USE IN (THIS.this_cCursorEmpresas)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarEmpresas - Monta clausula WHERE para filtro de empresas selecionadas
    * Retorna string SQL (ex: " AND a.Emps = 'xxx'") ou "" se nenhuma selecionada
    *--------------------------------------------------------------------------
    PROCEDURE MontarEmpresas()
        LOCAL loc_cEmp, loc_cVir, loc_nCount

        loc_cEmp   = ""
        loc_cVir   = ""
        loc_nCount = 0

        IF !USED(THIS.this_cCursorEmpresas)
            THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN ""
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        SCAN
            IF Imps = 1
                loc_nCount = loc_nCount + 1
            ENDIF
        ENDSCAN

        IF loc_nCount = 0
            THIS.this_cMensagemErro = "Nenhuma empresa foi selecionada."
            RETURN ""
        ENDIF

        IF loc_nCount = 1
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = " AND a.Emps = '" + ALLTRIM(cemps) + "'"
                ENDIF
            ENDSCAN
        ELSE
            loc_cEmp = " AND a.Emps IN ("
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = loc_cEmp + loc_cVir + "'" + ALLTRIM(cemps) + "'"
                    loc_cVir = ", "
                ENDIF
            ENDSCAN
            loc_cEmp = loc_cEmp + ")"
        ENDIF

        RETURN loc_cEmp
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL UNION ALL (PIS/COFINS/CSLL) e executa query
    * Retorna .T. se dados carregados com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpFilter, loc_cFornecFilter
        LOCAL loc_cDtIni, loc_cDtFin, loc_cAno
        LOCAL loc_cJoins, loc_cWhere
        LOCAL loc_cSelect1, loc_cSelect2, loc_cSelect3

        loc_lSucesso = .F.

        TRY
            *-- Validacao: ano base obrigatorio
            loc_cAno = ALLTRIM(THIS.this_cAnoBase)
            IF EMPTY(loc_cAno)
                THIS.this_cMensagemErro = "Ano base n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Filtro de empresas (valida selecao e monta clausula)
            loc_cEmpFilter = THIS.MontarEmpresas()
            IF EMPTY(loc_cEmpFilter)
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo do exercicio anual
            loc_cDtIni = "'" + loc_cAno + "-01-01'"
            loc_cDtFin = "'" + loc_cAno + "-12-31 23:59:59'"

            *-- Filtro de fornecedor (opcional)
            IF !EMPTY(ALLTRIM(THIS.this_cFornec))
                loc_cFornecFilter = " AND a.clifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornec))
            ELSE
                loc_cFornecFilter = ""
            ENDIF

            *-- Clausulas reutilizaveis
            loc_cJoins = " LEFT JOIN SigCdSrv b WITH (NOLOCK) ON a.codservs = b.codservs" + ;
                         " LEFT JOIN SigCdCli c ON c.iclis = a.clifors" + ;
                         " LEFT JOIN SigCdEmp d ON a.emps = d.cemps"

            loc_cWhere = " WHERE a.emis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + ;
                         " AND (a.vpis <> 0 OR a.vcofins <> 0 OR a.vcsll <> 0)" + ;
                         loc_cEmpFilter + loc_cFornecFilter

            *-- SELECT PIS
            loc_cSelect1 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vpis AS vimposto, b.codpiss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT COFINS
            loc_cSelect2 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcofins AS vimposto, b.codcofinss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT CSLL
            loc_cSelect3 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcsll AS vimposto, b.codcslls AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- UNION ALL (PIS + COFINS + CSLL) com ordenacao
            loc_cSQL = loc_cSelect1 + ;
                       " UNION ALL " + loc_cSelect2 + ;
                       " UNION ALL " + loc_cSelect3 + ;
                       " ORDER BY cnpj, clifors, emis, codservs"

            *-- Fechar cursor anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e abre dialogo de impressao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresas - Marca ou desmarca todas as empresas no cursor
    * par_lMarcar: .T. marca todas, .F. desmarca todas
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresas(par_lMarcar)
        LOCAL loc_nValor
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)
        IF USED(THIS.this_cCursorEmpresas)
            SELECT (THIS.this_cCursorEmpresas)
            REPLACE ALL Imps WITH loc_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresaUnica - Marca/desmarca empresa especifica no cursor
    * par_cCodigoEmp: codigo da empresa (cemps) a alterar
    * par_lMarcar: .T. para marcar (Imps=1), .F. para desmarcar (Imps=0)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, par_lMarcar)
        LOCAL loc_lSucesso, loc_nValor, loc_cCodigo
        loc_lSucesso = .F.
        loc_cCodigo = ALLTRIM(par_cCodigoEmp)
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)

        IF EMPTY(loc_cCodigo) OR !USED(THIS.this_cCursorEmpresas)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        LOCATE FOR ALLTRIM(cemps) == loc_cCodigo
        IF FOUND()
            REPLACE Imps WITH loc_nValor
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirEmpresaNaSelecao - Adiciona empresa especifica na selecao (Imps=1)
    * Util para pre-selecionar empresas via codigo externo (ex: empresa logada)
    * par_cCodigoEmp: codigo da empresa (cemps) a marcar
    *--------------------------------------------------------------------------
    PROCEDURE InserirEmpresaNaSelecao(par_cCodigoEmp)
        RETURN THIS.AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros da linha atual do cursor
    * Permite restaurar estado de filtros a partir de cursor externo
    * (ex: configuracao salva, parametros de outro form, agendamento)
    * par_cAliasCursor: nome do cursor com campos AnoBase/Fornec/Dforn
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ELSE
                SELECT (par_cAliasCursor)

                IF TYPE("AnoBase") <> "U"
                    THIS.this_cAnoBase = TratarNulo(AnoBase, "C")
                ENDIF

                IF TYPE("Fornec") <> "U"
                    THIS.this_cFornec = TratarNulo(Fornec, "C")
                ENDIF

                IF TYPE("Dforn") <> "U"
                    THIS.this_cDforn = TratarNulo(Dforn, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para arquivo XLS
    *   Retorna .T. se exportacao bem-sucedida
    *   this_cUltimoArquivoExcel recebe caminho do arquivo gerado
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cData
        loc_lSucesso = .F.
        THIS.this_cUltimoArquivoExcel = ""

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cData    = TRANSFORM(YEAR(DATE())) + ;
                           RIGHT("0" + TRANSFORM(MONTH(DATE())), 2) + ;
                           RIGHT("0" + TRANSFORM(DAY(DATE())), 2)
            loc_cArquivo = SYS(5) + CURDIR() + "sigReDir_" + loc_cData + ".xls"

            SELECT (THIS.this_cCursorDados)
            COPY TO (loc_cArquivo) TYPE XLS

            THIS.this_cUltimoArquivoExcel = loc_cArquivo
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do relatorio (ano base + cnpj fornec)
    * Usado por RegistrarAuditoria para identificar a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cAnoBase)
        IF !EMPTY(ALLTRIM(THIS.this_cFornec))
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cFornec)
        ENDIF
        RETURN loc_cChave
    ENDPROC

ENDDEFINE


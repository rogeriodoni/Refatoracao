# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'lbl_fornecedor' (parent: SIGREAPR): Top original=198 vs migrado 'lbl_4c_Lbl_fornecedor' Top=113 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1377 linhas total):

*-- Linhas 15 a 166:
15: *
16: * FASE 3/8 - Form Estrutura Base
17: *   - DEFINE CLASS + propriedades
18: *   - Init() / InicializarForm() / Destroy()
19: *   - ConfigurarCabecalho()  (container cinza escuro com t" + CHR(237) + "tulo)
20: *   - ConfigurarBotoes()     (CommandGroup: Visualizar/Imprimir/Excel/Encerrar)
21: *   - ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
22: *
23: * FASE 4/8 - Form Grid e Bot" + CHR(245) + "es (Page1 - campos de filtro)
24: *   - ConfigurarPaginaLista() (labels + textboxes + BINDEVENTs)
25: *   - AlternarPagina()
26: *   - LimparCampos() / AtualizarEstadoCampos() / ValidarCampos()
27: *   - FormParaRelatorio()
28: *   - CmgBotoesClick() + BtnVisualizarClick/Imprimir/Excel/Encerrar
29: *   - TeclaXxx() / AbrirBuscaXxx() / ValidarXxx() para cada lookup
30: *
31: * FASE 5/8 - Form Campos Principais (Parte 1 - primeiros 50% dos filtros)
32: *   REPORT flat: sem PageFrame CRUD de 2 p" + CHR(225) + "ginas. Para alinhar com o
33: *   pipeline multi-fase, os controles de filtro foram divididos entre dois
34: *   m" + CHR(233) + "todos (ambos populam pgf_4c_Paginas.Page1):
35: *     - ConfigurarPaginaDados()  ? 50% iniciais (Data, Grupo, Produto, Linha)
36: *     - ConfigurarPaginaLista()  ? 50% restantes (Fornecedor, Diferen" + CHR(231) + "as)
37: *   Esta fase adiciona ConfigurarPaginaDados() com os 11 primeiros controles.
38: *
39: * FASE 6/8 - Form Lookups Canonicos e DblClick
40: *   - AbrirBuscaXxx() reescritos com padrao canonico: mAddColuna+Show sempre
41: *   - BINDEVENTs DblClick adicionados para todos os 8 campos com lookup
42: *   - DblClickXxx() handlers adicionados (Grupo, Produto, Linha, Fornecedor)
43: *==============================================================================
44: 
45: DEFINE CLASS FormSIGREAPR AS FormBase
46: 
47:     *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
48:     Height      = 300
49:     Width       = 800
50:     DataSession = 2
51:     ShowWindow  = 1
52:     WindowType  = 1
53:     AutoCenter  = .T.
54:     BorderStyle = 2
55:     ControlBox  = .F.
56:     MaxButton   = .F.
57:     MinButton   = .F.
58:     TitleBar    = 0
59:     Themes      = .F.
60:     ShowTips    = .T.
61: 
62:     *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
63:     this_oRelatorio    = .NULL.
64:     this_cMensagemErro = ""
65: 
66:     *--------------------------------------------------------------------------
67:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
68:     *--------------------------------------------------------------------------
69:     PROCEDURE Init()
70:         RETURN DODEFAULT()
71:     ENDPROC
72: 
73:     *--------------------------------------------------------------------------
74:     * InicializarForm - Cria estrutura base do formulario de relatorio
75:     *   1. Define Caption / Picture (fundo)
76:     *   2. Cria SIGREAPRBO
77:     *   3. Monta cabecalho escuro + botoes + PageFrame vazio
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE InicializarForm()
80:         LOCAL loc_lSucesso, loc_lContinuar
81:         loc_lSucesso   = .F.
82:         loc_lContinuar = .T.
83:         TRY
84:             THIS.Caption = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
85: 
86:             IF TYPE("gc_4c_CaminhoIcones") = "U"
87:                 gc_4c_CaminhoIcones = ""
88:             ENDIF
89:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90: 
91:             THIS.this_oRelatorio = CREATEOBJECT("SIGREAPRBO")
92:             IF VARTYPE(THIS.this_oRelatorio) != "O"
93:                 MsgErro("Erro ao criar SIGREAPRBO" + CHR(13) + ;
94:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
95:                 loc_lContinuar = .F.
96:             ENDIF
97: 
98:             IF loc_lContinuar
99:                 THIS.ConfigurarCabecalho()
100:                 THIS.ConfigurarBotoes()
101:                 THIS.ConfigurarPageFrame()
102:                 THIS.ConfigurarPaginaDados()
103:                 THIS.ConfigurarPaginaLista()
104:                 THIS.LimparCampos()
105: 
106:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 THIS.Visible = .T.
110:                 loc_lSucesso = .T.
111:             ENDIF
112:         CATCH TO loc_oErro
113:             THIS.this_cMensagemErro = loc_oErro.Message
114:             MsgErro(loc_oErro.Message + CHR(13) + ;
115:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
116:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
117:         ENDTRY
118:         RETURN loc_lSucesso
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
123:     *   Equivalente ao cntSombra.Top=0, Left=-1 do frmrelatorio legado.
124:     *   Width = THIS.Width (cobre toda a faixa superior).
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarCabecalho()
127:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH THIS.cnt_4c_Cabecalho
129:             .Top         = 0
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackStyle   = 1
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137: 
138:             .AddObject("lbl_4c_Sombra", "Label")
139:             WITH .lbl_4c_Sombra
140:                 .Top       = 22
141:                 .Left      = 22
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(0, 0, 0)
149:                 .BackStyle = 0
150:                 .Visible   = .T.
151:             ENDWITH
152: 
153:             .AddObject("lbl_4c_Titulo", "Label")
154:             WITH .lbl_4c_Titulo
155:                 .Top       = 20
156:                 .Left      = 20
157:                 .Width     = THIS.Width
158:                 .Height    = 30
159:                 .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 14
162:                 .FontBold  = .T.
163:                 .ForeColor = RGB(255, 255, 255)
164:                 .BackStyle = 0
165:                 .Visible   = .T.
166:             ENDWITH

*-- Linhas 172 a 215:
172:     *   Original: btnReport.Left=526, Top=3, Width~270, Height~85
173:     *   Botoes: Visualiza(Left=6), Imprime(72), DocExcel(138), Sair(204) - W=60
174:     *--------------------------------------------------------------------------
175:     PROTECTED PROCEDURE ConfigurarBotoes()
176:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
177:         WITH THIS.cmg_4c_Botoes
178:             .Top           = 0
179:             .Left          = 529
180:             .Width         = 273
181:             .Height        = 80
182:             .ButtonCount   = 4
183:             .BackStyle     = 0
184:             .BorderStyle   = 0
185:             .BorderColor   = RGB(136, 189, 188)
186:             .SpecialEffect = 1
187:             .Themes        = .F.
188:             .Visible       = .T.
189: 
190:             WITH .Buttons(1)
191:                 .Top             = 5
192:                 .Left            = 5
193:                 .Width           = 65
194:                 .Height          = 70
195:                 .Caption         = "Visualizar"
196:                 .FontBold        = .T.
197:                 .FontItalic      = .T.
198:                 .BackColor       = RGB(255, 255, 255)
199:                 .ForeColor       = RGB(90, 90, 90)
200:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
201:                 .PicturePosition = 13
202:                 .SpecialEffect   = 0
203:                 .MousePointer    = 15
204:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
205:                 .Themes          = .F.
206:                 .Visible         = .T.
207:             ENDWITH
208: 
209:             WITH .Buttons(2)
210:                 .Top             = 5
211:                 .Left            = 71
212:                 .Width           = 65
213:                 .Height          = 70
214:                 .Caption         = "Imprimir"
215:                 .FontName        = "Comic Sans MS"

*-- Linhas 279 a 366:
279:     *   consistencia com o restante do sistema.
280:     *   Posicao: abaixo do cabecalho (85px) ate o fim do form.
281:     *--------------------------------------------------------------------------
282:     PROTECTED PROCEDURE ConfigurarPageFrame()
283:         LOCAL loc_oPgf
284: 
285:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
286:         loc_oPgf = THIS.pgf_4c_Paginas
287: 
288:         loc_oPgf.PageCount = 1
289: 
290:         loc_oPgf.Top    = 85
291:         loc_oPgf.Left   = -1
292:         loc_oPgf.Width  = THIS.Width + 2
293:         loc_oPgf.Height = THIS.Height - 85
294:         loc_oPgf.Tabs   = .F.
295: 
296:         loc_oPgf.Page1.Caption   = "Filtros"
297:         loc_oPgf.Page1.FontName  = "Tahoma"
298:         loc_oPgf.Page1.FontSize  = 8
299:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
300:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
301:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
302: 
303:         loc_oPgf.Visible    = .T.
304:         loc_oPgf.ActivePage = 1
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
309:     *--------------------------------------------------------------------------
310:     PROCEDURE Destroy()
311:         IF VARTYPE(THIS.this_oRelatorio) = "O"
312:             THIS.this_oRelatorio = .NULL.
313:         ENDIF
314:         DODEFAULT()
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     * ConfigurarPaginaDados - Fase 5/8: cria os primeiros 50% dos filtros
319:     *   em pgf_4c_Paginas.Page1 (REPORT flat sem Page2 separada).
320:     *   Controles: Data Inicial, Grupo (cod+desc), Produto (cod+desc), Linha
321:     *   (cod+desc). Total: 4 labels + 7 textboxes = 11 controles.
322:     *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
323:     *   Chamado por InicializarForm() ANTES de ConfigurarPaginaLista() para
324:     *   que os BINDEVENTs (em ConfigurarPaginaLista) encontrem os controles.
325:     *--------------------------------------------------------------------------
326:     PROTECTED PROCEDURE ConfigurarPaginaDados()
327:         LOCAL loc_oPg
328:         loc_oPg = THIS.pgf_4c_Paginas.Page1
329: 
330:         *-- lbl_4c_Label1 "Data Inicial :" (Say1: top=98, left=189)
331:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
332:         WITH loc_oPg.lbl_4c_Label1
333:             .Top       = 13
334:             .Left      = 189
335:             .Width     = 70
336:             .Height    = 15
337:             .Caption   = "Data Inicial :"
338:             .FontName  = "Tahoma"
339:             .FontSize  = 8
340:             .ForeColor = RGB(90, 90, 90)
341:             .BackStyle = 0
342:             .Visible   = .T.
343:         ENDWITH
344: 
345:         *-- txt_4c_DtInicial (getDtInicial: top=95, left=255)
346:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
347:         WITH loc_oPg.txt_4c_DtInicial
348:             .Top      = 10
349:             .Left     = 255
350:             .Width    = 80
351:             .Height   = 23
352:             .FontName = "Tahoma"
353:             .FontSize = 8
354:             .Value    = {}
355:             .Visible  = .T.
356:         ENDWITH
357: 
358:         *-- lbl_4c_Label2 "Grupo :" (Say2: top=123, left=213)
359:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
360:         WITH loc_oPg.lbl_4c_Label2
361:             .Top       = 38
362:             .Left      = 213
363:             .Width     = 38
364:             .Height    = 15
365:             .Caption   = "Grupo :"
366:             .FontName  = "Tahoma"

*-- Linhas 485 a 528:
485:     *   Page1 hospeda os FILTROS (nao ha grid de registros - frmrelatorio FLAT).
486:     *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarPaginaLista()
489:         LOCAL loc_oPg
490:         loc_oPg = THIS.pgf_4c_Paginas.Page1
491: 
492:         *-- Controles da PARTE SUPERIOR (Data, Grupo, Produto, Linha) sao
493:         *-- criados em ConfigurarPaginaDados() - Fase 5.
494:         *-- Aqui (Fase 4 + extensoes) configuramos a PARTE INFERIOR:
495:         *-- Fornecedor + Diferencas Minimas (Venda/Custo).
496: 
497:         *-- lbl_4c_Lbl_fornecedor "Fornecedor :" (lbl_fornecedor: top=198, left=187)
498:         loc_oPg.AddObject("lbl_4c_Lbl_fornecedor", "Label")
499:         WITH loc_oPg.lbl_4c_Lbl_fornecedor
500:             .Top       = 113
501:             .Left      = 187
502:             .Width     = 64
503:             .Height    = 15
504:             .Caption   = "Fornecedor :"
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(90, 90, 90)
508:             .BackStyle = 0
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         *-- txt_4c_Fornecedor (getFornecedor: top=195, left=255, width=80)
513:         loc_oPg.AddObject("txt_4c_Fornecedor", "TextBox")
514:         WITH loc_oPg.txt_4c_Fornecedor
515:             .Top      = 110
516:             .Left     = 255
517:             .Width    = 80
518:             .Height   = 23
519:             .FontName = "Tahoma"
520:             .FontSize = 8
521:             .Value    = ""
522:             .Visible  = .T.
523:         ENDWITH
524: 
525:         *-- txt_4c_DFornecedor (getDFornecedor: top=195, left=337, width=290)
526:         loc_oPg.AddObject("txt_4c_DFornecedor", "TextBox")
527:         WITH loc_oPg.txt_4c_DFornecedor
528:             .Top      = 110

*-- Linhas 651 a 1377:
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         *-- BINDEVENTs para campos com lookup (F4/F5 e Enter/Tab)
655:         BINDEVENT(loc_oPg.txt_4c_Grupo,       "KeyPress", THIS, "TeclaGrupo")
656:         BINDEVENT(loc_oPg.txt_4c_DGrupo,      "KeyPress", THIS, "TeclaDGrupo")
657:         BINDEVENT(loc_oPg.txt_4c_CPros,        "KeyPress", THIS, "TeclaCPros")
658:         BINDEVENT(loc_oPg.txt_4c_DPros,        "KeyPress", THIS, "TeclaDPros")
659:         BINDEVENT(loc_oPg.txt_4c_Lin,          "KeyPress", THIS, "TeclaLin")
660:         BINDEVENT(loc_oPg.txt_4c_DLin,         "KeyPress", THIS, "TeclaDLin")
661:         BINDEVENT(loc_oPg.txt_4c_Fornecedor,   "KeyPress", THIS, "TeclaFornecedor")
662:         BINDEVENT(loc_oPg.txt_4c_DFornecedor,  "KeyPress", THIS, "TeclaDFornecedor")
663: 
664:         *-- BINDEVENT para CommandGroup de botoes do relatorio
665:         BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")
666: 
667:         *-- DblClick abre lookup diretamente (complementa o F4 do KeyPress)
668:         BINDEVENT(loc_oPg.txt_4c_Grupo,       "DblClick", THIS, "DblClickGrupo")
669:         BINDEVENT(loc_oPg.txt_4c_DGrupo,      "DblClick", THIS, "DblClickGrupo")
670:         BINDEVENT(loc_oPg.txt_4c_CPros,       "DblClick", THIS, "DblClickProduto")
671:         BINDEVENT(loc_oPg.txt_4c_DPros,       "DblClick", THIS, "DblClickProduto")
672:         BINDEVENT(loc_oPg.txt_4c_Lin,         "DblClick", THIS, "DblClickLinha")
673:         BINDEVENT(loc_oPg.txt_4c_DLin,        "DblClick", THIS, "DblClickLinha")
674:         BINDEVENT(loc_oPg.txt_4c_Fornecedor,  "DblClick", THIS, "DblClickFornecedor")
675:         BINDEVENT(loc_oPg.txt_4c_DFornecedor, "DblClick", THIS, "DblClickFornecedor")
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * AlternarPagina - Exibe a pagina informada no PageFrame de filtros
680:     *--------------------------------------------------------------------------
681:     PROCEDURE AlternarPagina(par_nPagina)
682:         IF par_nPagina > 0 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
683:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
684:         ELSE
685:             THIS.pgf_4c_Paginas.Visible = .T.
686:             THIS.pgf_4c_Paginas.ActivePage = 1
687:         ENDIF
688:     ENDPROC
689: 
690:     *--------------------------------------------------------------------------
691:     * LimparCampos - Redefine todos os filtros para valores iniciais do BO
692:     *--------------------------------------------------------------------------
693:     PROTECTED PROCEDURE LimparCampos()
694:         LOCAL loc_oPg
695:         loc_oPg = THIS.pgf_4c_Paginas.Page1
696: 
697:         loc_oPg.txt_4c_DtInicial.Value      = DATE()
698:         loc_oPg.txt_4c_Grupo.Value          = ""
699:         loc_oPg.txt_4c_DGrupo.Value         = ""
700:         loc_oPg.txt_4c_DGrupo.ReadOnly      = .F.
701:         loc_oPg.txt_4c_CPros.Value           = ""
702:         loc_oPg.txt_4c_DPros.Value           = ""
703:         loc_oPg.txt_4c_DPros.ReadOnly        = .F.
704:         loc_oPg.txt_4c_Lin.Value             = ""
705:         loc_oPg.txt_4c_DLin.Value            = ""
706:         loc_oPg.txt_4c_DLin.ReadOnly         = .F.
707:         loc_oPg.txt_4c_Fornecedor.Value      = ""
708:         loc_oPg.txt_4c_DFornecedor.Value     = ""
709:         loc_oPg.txt_4c_DFornecedor.ReadOnly  = .F.
710:         loc_oPg.txt_4c_MinVendas.Value       = 0
711:         loc_oPg.txt_4c_MinCustos.Value       = 0
712:     ENDPROC
713: 
714:     *--------------------------------------------------------------------------
715:     * AtualizarEstadoCampos - Sincroniza ReadOnly dos campos de descricao
716:     *   Descricao fica somente-leitura quando o codigo correspondente esta
717:     *   preenchido (replica comportamento When do legado)
718:     *--------------------------------------------------------------------------
719:     PROTECTED PROCEDURE AtualizarEstadoCampos()
720:         LOCAL loc_oPg
721:         loc_oPg = THIS.pgf_4c_Paginas.Page1
722:         loc_oPg.txt_4c_DGrupo.ReadOnly      = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
723:         loc_oPg.txt_4c_DPros.ReadOnly       = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CPros.Value))
724:         loc_oPg.txt_4c_DLin.ReadOnly        = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Lin.Value))
725:         loc_oPg.txt_4c_DFornecedor.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value))
726:     ENDPROC
727: 
728:     *--------------------------------------------------------------------------
729:     * ValidarCampos - Verifica campos obrigatorios antes de gerar relatorio
730:     *   Data Inicial e o unico campo obrigatorio (igual ao legado)
731:     *--------------------------------------------------------------------------
732:     PROTECTED PROCEDURE ValidarCampos()
733:         LOCAL loc_oPg
734:         loc_oPg = THIS.pgf_4c_Paginas.Page1
735: 
736:         IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
737:             MsgAviso("Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
738:                      "Aten" + CHR(231) + CHR(227) + "o")
739:             loc_oPg.txt_4c_DtInicial.SetFocus()
740:             RETURN .F.
741:         ENDIF
742: 
743:         RETURN .T.
744:     ENDPROC
745: 
746:     *--------------------------------------------------------------------------
747:     * FormParaRelatorio - Transfere valores dos filtros do form para o BO
748:     *--------------------------------------------------------------------------
749:     PROTECTED PROCEDURE FormParaRelatorio()
750:         LOCAL loc_oPg
751:         loc_oPg = THIS.pgf_4c_Paginas.Page1
752: 
753:         WITH THIS.this_oRelatorio
754:             .this_dDtInicial   = loc_oPg.txt_4c_DtInicial.Value
755:             .this_cGrupo       = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
756:             .this_cDGrupo      = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
757:             .this_cCPros       = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
758:             .this_cDPros       = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
759:             .this_cLin         = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
760:             .this_cDLin        = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
761:             .this_cFornecedor  = ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value)
762:             .this_cDFornecedor = ALLTRIM(loc_oPg.txt_4c_DFornecedor.Value)
763:             .this_nMinVendas   = loc_oPg.txt_4c_MinVendas.Value
764:             .this_nMinCustos   = loc_oPg.txt_4c_MinCustos.Value
765:         ENDWITH
766:     ENDPROC
767: 
768:     *--------------------------------------------------------------------------
769:     * CmgBotoesClick - Roteia clique nos botoes do relatorio
770:     *   Buttons: 1=Visualizar, 2=Imprimir, 3=Excel, 4=Encerrar
771:     *--------------------------------------------------------------------------
772:     PROCEDURE CmgBotoesClick()
773:         DO CASE
774:             CASE THIS.cmg_4c_Botoes.Value = 1
775:                 THIS.BtnVisualizarClick()
776:             CASE THIS.cmg_4c_Botoes.Value = 2
777:                 THIS.BtnImprimirClick()
778:             CASE THIS.cmg_4c_Botoes.Value = 3
779:                 THIS.BtnExcelClick()
780:             CASE THIS.cmg_4c_Botoes.Value = 4
781:                 THIS.BtnEncerrarClick()
782:         ENDCASE
783:     ENDPROC
784: 
785:     *--------------------------------------------------------------------------
786:     * BtnVisualizarClick - Gera preview do relatorio na tela
787:     *--------------------------------------------------------------------------
788:     PROTECTED PROCEDURE BtnVisualizarClick()
789:         IF !THIS.ValidarCampos()
790:             RETURN
791:         ENDIF
792:         THIS.FormParaRelatorio()
793:         IF !THIS.this_oRelatorio.Visualizar()
794:             MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
795:                      "Aten" + CHR(231) + CHR(227) + "o")
796:         ENDIF
797:     ENDPROC
798: 
799:     *--------------------------------------------------------------------------
800:     * BtnImprimirClick - Envia relatorio para impressora
801:     *--------------------------------------------------------------------------
802:     PROTECTED PROCEDURE BtnImprimirClick()
803:         IF !THIS.ValidarCampos()
804:             RETURN
805:         ENDIF
806:         THIS.FormParaRelatorio()
807:         IF !THIS.this_oRelatorio.Imprimir()
808:             MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
809:                      "Aten" + CHR(231) + CHR(227) + "o")
810:         ENDIF
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * BtnExcelClick - Exporta dados do relatorio para planilha Excel
815:     *--------------------------------------------------------------------------
816:     PROTECTED PROCEDURE BtnExcelClick()
817:         IF !THIS.ValidarCampos()
818:             RETURN
819:         ENDIF
820:         THIS.FormParaRelatorio()
821:         IF !THIS.this_oRelatorio.ExportarExcel()
822:             MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
823:                      "Aten" + CHR(231) + CHR(227) + "o")
824:         ENDIF
825:     ENDPROC
826: 
827:     *--------------------------------------------------------------------------
828:     * BtnEncerrarClick - Fecha o formulario de relatorio
829:     *--------------------------------------------------------------------------
830:     PROTECTED PROCEDURE BtnEncerrarClick()
831:         THIS.Release()
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * BtnIncluirClick - REPORT form: operacao CRUD nao se aplica
836:     *   Este formulario eh do tipo frmrelatorio (apenas filtros + saida em FRX),
837:     *   nao possui registros para incluir. Mantido por convencao da pipeline
838:     *   multi-fase de migracao para preservar simetria com forms CRUD. Se for
839:     *   invocado programaticamente, redireciona para a acao mais proxima
840:     *   (Visualizar) para que o usuario obtenha o resultado esperado.
841:     *--------------------------------------------------------------------------
842:     PROCEDURE BtnIncluirClick()
843:         MsgInfo("Este formul" + CHR(225) + "rio " + CHR(233) + " de relat" + CHR(243) + "rio." + CHR(13) + ;
844:                 "Use Visualizar, Imprimir ou Excel para gerar o resultado.", ;
845:                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
846:         THIS.BtnVisualizarClick()
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * BtnAlterarClick - REPORT form: operacao CRUD nao se aplica
851:     *   Mantido por convencao da pipeline. Redireciona para Imprimir.
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnAlterarClick()
854:         MsgInfo("Este formul" + CHR(225) + "rio " + CHR(233) + " de relat" + CHR(243) + "rio." + CHR(13) + ;
855:                 "Use Visualizar, Imprimir ou Excel para gerar o resultado.", ;
856:                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
857:         THIS.BtnImprimirClick()
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * BtnExcluirClick - REPORT form: operacao CRUD nao se aplica
862:     *   Mantido por convencao da pipeline. Encerra o formulario.
863:     *--------------------------------------------------------------------------
864:     PROCEDURE BtnExcluirClick()
865:         MsgInfo("Este formul" + CHR(225) + "rio " + CHR(233) + " de relat" + CHR(243) + "rio." + CHR(13) + ;
866:                 "Use Visualizar, Imprimir ou Excel para gerar o resultado.", ;
867:                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
868:         THIS.BtnEncerrarClick()
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * TeclaGrupo - F4/F5 abre busca de grupos; Enter/Tab valida codigo digitado
873:     *--------------------------------------------------------------------------
874:     PROCEDURE TeclaGrupo(par_nKeyCode, par_nShift)
875:         LOCAL loc_cCod
876:         IF INLIST(par_nKeyCode, 115, 116)
877:             THIS.AbrirBuscaGrupo()
878:         ENDIF
879:         IF INLIST(par_nKeyCode, 13, 9)
880:             loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
881:             IF !EMPTY(loc_cCod)
882:                 THIS.ValidarGrupo(loc_cCod)
883:             ELSE
884:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value   = ""
885:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.ReadOnly = .F.
886:             ENDIF
887:         ENDIF
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * TeclaDGrupo - F4/F5 abre busca de grupos; Enter/Tab abre lista filtrada
892:     *--------------------------------------------------------------------------
893:     PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShift)
894:         IF INLIST(par_nKeyCode, 115, 116)
895:             THIS.AbrirBuscaGrupo()
896:         ENDIF
897:         IF INLIST(par_nKeyCode, 13, 9)
898:             IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value))
899:                 THIS.AbrirBuscaGrupo()
900:             ENDIF
901:         ENDIF
902:     ENDPROC
903: 
904:     *--------------------------------------------------------------------------
905:     * ValidarGrupo - Valida codigo digitado contra SigCdGrp; abre busca se invalido
906:     *--------------------------------------------------------------------------
907:     PROTECTED PROCEDURE ValidarGrupo(par_cCodigo)
908:         LOCAL loc_oPg, loc_cSQL, loc_nResult
909:         loc_oPg = THIS.pgf_4c_Paginas.Page1
910:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
911:                    EscaparSQL(par_cCodigo)
912:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
913:         IF loc_nResult > 0
914:             SELECT cursor_4c_GrupoVal
915:             IF !EOF()
916:                 loc_oPg.txt_4c_DGrupo.Value   = ALLTRIM(DGrus)
917:                 loc_oPg.txt_4c_DGrupo.ReadOnly = .T.
918:             ELSE
919:                 USE IN cursor_4c_GrupoVal
920:                 THIS.AbrirBuscaGrupo()
921:                 RETURN
922:             ENDIF
923:             USE IN cursor_4c_GrupoVal
924:         ELSE
925:             MsgAviso("Erro ao buscar grupo", "Aviso")
926:         ENDIF
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para SigCdGrp (CGrus/DGrus)
931:     *--------------------------------------------------------------------------
932:     PROCEDURE AbrirBuscaGrupo()
933:         LOCAL loc_oPg, loc_cValor, loc_oForm
934:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
935:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
936:         IF EMPTY(loc_cValor)
937:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
938:         ENDIF
939: 
940:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
941:                     "SigCdGrp", "cursor_4c_GrupoBusca", "CGrus", loc_cValor, ;
942:                     "Selecionar Grupo")
943: 
944:         IF VARTYPE(loc_oForm) != "O"
945:             RETURN
946:         ENDIF
947: 
948:         loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
949:         loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
950:         loc_oForm.Show()
951: 
952:         IF loc_oForm.this_lSelecionou
953:             IF USED("cursor_4c_GrupoBusca")
954:                 SELECT cursor_4c_GrupoBusca
955:                 loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(CGrus)
956:                 loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(DGrus)
957:             ENDIF
958:         ENDIF
959: 
960:         IF USED("cursor_4c_GrupoBusca")
961:             USE IN cursor_4c_GrupoBusca
962:         ENDIF
963:         loc_oForm.Release()
964:         THIS.AtualizarEstadoCampos()
965:     ENDPROC
966: 
967:     *--------------------------------------------------------------------------
968:     * TeclaCPros - F4/F5 abre busca de produtos; Enter/Tab valida codigo
969:     *--------------------------------------------------------------------------
970:     PROCEDURE TeclaCPros(par_nKeyCode, par_nShift)
971:         LOCAL loc_cCod
972:         IF INLIST(par_nKeyCode, 115, 116)
973:             THIS.AbrirBuscaProduto()
974:         ENDIF
975:         IF INLIST(par_nKeyCode, 13, 9)
976:             loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CPros.Value)
977:             IF !EMPTY(loc_cCod)
978:                 THIS.ValidarProduto(loc_cCod)
979:             ELSE
980:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.Value   = ""
981:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.ReadOnly = .F.
982:             ENDIF
983:         ENDIF
984:     ENDPROC
985: 
986:     *--------------------------------------------------------------------------
987:     * TeclaDPros - F4/F5 abre busca de produtos; Enter/Tab abre lista filtrada
988:     *--------------------------------------------------------------------------
989:     PROCEDURE TeclaDPros(par_nKeyCode, par_nShift)
990:         IF INLIST(par_nKeyCode, 115, 116)
991:             THIS.AbrirBuscaProduto()
992:         ENDIF
993:         IF INLIST(par_nKeyCode, 13, 9)
994:             IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.Value))
995:                 THIS.AbrirBuscaProduto()
996:             ENDIF
997:         ENDIF
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     * ValidarProduto - Valida codigo digitado contra SigCdPro
1002:     *--------------------------------------------------------------------------
1003:     PROTECTED PROCEDURE ValidarProduto(par_cCodigo)
1004:         LOCAL loc_oPg, loc_cSQL, loc_nResult
1005:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1006:         loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + ;
1007:                    EscaparSQL(par_cCodigo)
1008:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1009:         IF loc_nResult > 0
1010:             SELECT cursor_4c_ProdVal
1011:             IF !EOF()
1012:                 loc_oPg.txt_4c_DPros.Value   = ALLTRIM(DPros)
1013:                 loc_oPg.txt_4c_DPros.ReadOnly = .T.
1014:             ELSE
1015:                 USE IN cursor_4c_ProdVal
1016:                 THIS.AbrirBuscaProduto()
1017:                 RETURN
1018:             ENDIF
1019:             USE IN cursor_4c_ProdVal
1020:         ELSE
1021:             MsgAviso("Erro ao buscar produto", "Aviso")
1022:         ENDIF
1023:     ENDPROC
1024: 
1025:     *--------------------------------------------------------------------------
1026:     * AbrirBuscaProduto - Abre FormBuscaAuxiliar para SigCdPro (CPros/DPros)
1027:     *--------------------------------------------------------------------------
1028:     PROCEDURE AbrirBuscaProduto()
1029:         LOCAL loc_oPg, loc_cValor, loc_oForm
1030:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1031:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
1032:         IF EMPTY(loc_cValor)
1033:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
1034:         ENDIF
1035: 
1036:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1037:                     "SigCdPro", "cursor_4c_ProdBusca", "CPros", loc_cValor, ;
1038:                     "Selecionar Produto")
1039: 
1040:         IF VARTYPE(loc_oForm) != "O"
1041:             RETURN
1042:         ENDIF
1043: 
1044:         loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1045:         loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1046:         loc_oForm.Show()
1047: 
1048:         IF loc_oForm.this_lSelecionou
1049:             IF USED("cursor_4c_ProdBusca")
1050:                 SELECT cursor_4c_ProdBusca
1051:                 loc_oPg.txt_4c_CPros.Value   = ALLTRIM(CPros)
1052:                 loc_oPg.txt_4c_DPros.Value   = ALLTRIM(DPros)
1053:             ENDIF
1054:         ENDIF
1055: 
1056:         IF USED("cursor_4c_ProdBusca")
1057:             USE IN cursor_4c_ProdBusca
1058:         ENDIF
1059:         loc_oForm.Release()
1060:         THIS.AtualizarEstadoCampos()
1061:     ENDPROC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * TeclaLin - F4/F5 abre busca de linhas; Enter/Tab valida codigo
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE TeclaLin(par_nKeyCode, par_nShift)
1067:         LOCAL loc_cCod
1068:         IF INLIST(par_nKeyCode, 115, 116)
1069:             THIS.AbrirBuscaLinha()
1070:         ENDIF
1071:         IF INLIST(par_nKeyCode, 13, 9)
1072:             loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Lin.Value)
1073:             IF !EMPTY(loc_cCod)
1074:                 THIS.ValidarLinha(loc_cCod)
1075:             ELSE
1076:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.Value   = ""
1077:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.ReadOnly = .F.
1078:             ENDIF
1079:         ENDIF
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * TeclaDLin - F4/F5 abre busca de linhas; Enter/Tab abre lista filtrada
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE TeclaDLin(par_nKeyCode, par_nShift)
1086:         IF INLIST(par_nKeyCode, 115, 116)
1087:             THIS.AbrirBuscaLinha()
1088:         ENDIF
1089:         IF INLIST(par_nKeyCode, 13, 9)
1090:             IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.Value))
1091:                 THIS.AbrirBuscaLinha()
1092:             ENDIF
1093:         ENDIF
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     * ValidarLinha - Valida codigo digitado contra SigCdLin (Linhas/Descs)
1098:     *--------------------------------------------------------------------------
1099:     PROTECTED PROCEDURE ValidarLinha(par_cCodigo)
1100:         LOCAL loc_oPg, loc_cSQL, loc_nResult
1101:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1102:         loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
1103:                    EscaparSQL(par_cCodigo)
1104:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinVal")
1105:         IF loc_nResult > 0
1106:             SELECT cursor_4c_LinVal
1107:             IF !EOF()
1108:                 loc_oPg.txt_4c_DLin.Value   = ALLTRIM(Descs)
1109:                 loc_oPg.txt_4c_DLin.ReadOnly = .T.
1110:             ELSE
1111:                 USE IN cursor_4c_LinVal
1112:                 THIS.AbrirBuscaLinha()
1113:                 RETURN
1114:             ENDIF
1115:             USE IN cursor_4c_LinVal
1116:         ELSE
1117:             MsgAviso("Erro ao buscar linha", "Aviso")
1118:         ENDIF
1119:     ENDPROC
1120: 
1121:     *--------------------------------------------------------------------------
1122:     * AbrirBuscaLinha - Abre FormBuscaAuxiliar para SigCdLin (Linhas/Descs)
1123:     *   Colunas Linhas/Descs conforme codigo fonte original (fwBuscaExt)
1124:     *--------------------------------------------------------------------------
1125:     PROCEDURE AbrirBuscaLinha()
1126:         LOCAL loc_oPg, loc_cValor, loc_oForm
1127:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1128:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
1129:         IF EMPTY(loc_cValor)
1130:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
1131:         ENDIF
1132: 
1133:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1134:                     "SigCdLin", "cursor_4c_LinBusca", "Linhas", loc_cValor, ;
1135:                     "Selecionar Linha")
1136: 
1137:         IF VARTYPE(loc_oForm) != "O"
1138:             RETURN
1139:         ENDIF
1140: 
1141:         loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
1142:         loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1143:         loc_oForm.Show()
1144: 
1145:         IF loc_oForm.this_lSelecionou
1146:             IF USED("cursor_4c_LinBusca")
1147:                 SELECT cursor_4c_LinBusca
1148:                 loc_oPg.txt_4c_Lin.Value  = ALLTRIM(Linhas)
1149:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(Descs)
1150:             ENDIF
1151:         ENDIF
1152: 
1153:         IF USED("cursor_4c_LinBusca")
1154:             USE IN cursor_4c_LinBusca
1155:         ENDIF
1156:         loc_oForm.Release()
1157:         THIS.AtualizarEstadoCampos()
1158:     ENDPROC
1159: 
1160:     *--------------------------------------------------------------------------
1161:     * TeclaFornecedor - F4/F5 abre busca de fornecedor; Enter/Tab valida codigo
1162:     *--------------------------------------------------------------------------
1163:     PROCEDURE TeclaFornecedor(par_nKeyCode, par_nShift)
1164:         LOCAL loc_cCod
1165:         IF INLIST(par_nKeyCode, 115, 116)
1166:             THIS.AbrirBuscaFornecedor()
1167:         ENDIF
1168:         IF INLIST(par_nKeyCode, 13, 9)
1169:             loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornecedor.Value)
1170:             IF !EMPTY(loc_cCod)
1171:                 THIS.ValidarFornecedor(loc_cCod)
1172:             ELSE
1173:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.Value   = ""
1174:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.ReadOnly = .F.
1175:             ENDIF
1176:         ENDIF
1177:     ENDPROC
1178: 
1179:     *--------------------------------------------------------------------------
1180:     * TeclaDFornecedor - F4/F5 abre busca de fornecedor; Enter/Tab abre lista
1181:     *--------------------------------------------------------------------------
1182:     PROCEDURE TeclaDFornecedor(par_nKeyCode, par_nShift)
1183:         IF INLIST(par_nKeyCode, 115, 116)
1184:             THIS.AbrirBuscaFornecedor()
1185:         ENDIF
1186:         IF INLIST(par_nKeyCode, 13, 9)
1187:             IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.Value))
1188:                 THIS.AbrirBuscaFornecedor()
1189:             ENDIF
1190:         ENDIF
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * ValidarFornecedor - Valida codigo digitado contra SIGCDCLI (iclis/nomes)
1195:     *   Substitui fAcessoContas() do legado
1196:     *--------------------------------------------------------------------------
1197:     PROTECTED PROCEDURE ValidarFornecedor(par_cCodigo)
1198:         LOCAL loc_oPg, loc_cSQL, loc_nResult
1199:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1200:         loc_cSQL = "SELECT iclis, nomes FROM SIGCDCLI WHERE iclis = " + ;
1201:                    EscaparSQL(par_cCodigo)
1202:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
1203:         IF loc_nResult > 0
1204:             SELECT cursor_4c_FornVal
1205:             IF !EOF()
1206:                 loc_oPg.txt_4c_DFornecedor.Value   = ALLTRIM(nomes)
1207:                 loc_oPg.txt_4c_DFornecedor.ReadOnly = .T.
1208:             ELSE
1209:                 USE IN cursor_4c_FornVal
1210:                 THIS.AbrirBuscaFornecedor()
1211:                 RETURN
1212:             ENDIF
1213:             USE IN cursor_4c_FornVal
1214:         ELSE
1215:             MsgAviso("Erro ao buscar fornecedor", "Aviso")
1216:         ENDIF
1217:     ENDPROC
1218: 
1219:     *--------------------------------------------------------------------------
1220:     * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para SIGCDCLI (iclis/nomes)
1221:     *   Substitui fAcessoContas() do legado (tabela SIGCDCLI = clientes/fornec)
1222:     *--------------------------------------------------------------------------
1223:     PROCEDURE AbrirBuscaFornecedor()
1224:         LOCAL loc_oPg, loc_cValor, loc_oForm
1225:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1226:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value)
1227:         IF EMPTY(loc_cValor)
1228:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_DFornecedor.Value)
1229:         ENDIF
1230: 
1231:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1232:                     "SIGCDCLI", "cursor_4c_FornBusca", "iclis", loc_cValor, ;
1233:                     "Selecionar Fornecedor")
1234: 
1235:         IF VARTYPE(loc_oForm) != "O"
1236:             RETURN
1237:         ENDIF
1238: 
1239:         loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1240:         loc_oForm.mAddColuna("nomes", "", "Nome")
1241:         loc_oForm.Show()
1242: 
1243:         IF loc_oForm.this_lSelecionou
1244:             IF USED("cursor_4c_FornBusca")
1245:                 SELECT cursor_4c_FornBusca
1246:                 loc_oPg.txt_4c_Fornecedor.Value   = ALLTRIM(iclis)
1247:                 loc_oPg.txt_4c_DFornecedor.Value  = ALLTRIM(nomes)
1248:             ENDIF
1249:         ENDIF
1250: 
1251:         IF USED("cursor_4c_FornBusca")
1252:             USE IN cursor_4c_FornBusca
1253:         ENDIF
1254:         loc_oForm.Release()
1255:         THIS.AtualizarEstadoCampos()
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * DblClickXxx - Handlers para duplo-clique nos campos de lookup
1260:     *   BINDEVENT registrado em ConfigurarPaginaLista()
1261:     *--------------------------------------------------------------------------
1262:     PROCEDURE DblClickGrupo()
1263:         THIS.AbrirBuscaGrupo()
1264:     ENDPROC
1265: 
1266:     PROCEDURE DblClickProduto()
1267:         THIS.AbrirBuscaProduto()
1268:     ENDPROC
1269: 
1270:     PROCEDURE DblClickLinha()
1271:         THIS.AbrirBuscaLinha()
1272:     ENDPROC
1273: 
1274:     PROCEDURE DblClickFornecedor()
1275:         THIS.AbrirBuscaFornecedor()
1276:     ENDPROC
1277: 
1278:     *--------------------------------------------------------------------------
1279:     * BtnBuscarClick - REPORT form: Buscar equivale a Visualizar (preview)
1280:     *--------------------------------------------------------------------------
1281:     PROCEDURE BtnBuscarClick()
1282:         THIS.BtnVisualizarClick()
1283:     ENDPROC
1284: 
1285:     *--------------------------------------------------------------------------
1286:     * BtnSalvarClick - REPORT form: Salvar equivale a Imprimir
1287:     *--------------------------------------------------------------------------
1288:     PROCEDURE BtnSalvarClick()
1289:         THIS.BtnImprimirClick()
1290:     ENDPROC
1291: 
1292:     *--------------------------------------------------------------------------
1293:     * BtnCancelarClick - REPORT form: Cancelar equivale a Encerrar
1294:     *--------------------------------------------------------------------------
1295:     PROCEDURE BtnCancelarClick()
1296:         THIS.BtnEncerrarClick()
1297:     ENDPROC
1298: 
1299:     *--------------------------------------------------------------------------
1300:     * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
1301:     *   Mantido para compatibilidade com FormBase; a logica real esta em
1302:     *   FormParaRelatorio() que ja e chamada pelos botoes de acao.
1303:     *--------------------------------------------------------------------------
1304:     PROTECTED PROCEDURE FormParaBO()
1305:         THIS.FormParaRelatorio()
1306:     ENDPROC
1307: 
1308:     *--------------------------------------------------------------------------
1309:     * BOParaForm - Carrega filtros do BO de volta para os controles do form
1310:     *   Util para restaurar o estado dos filtros apos uma geracao de relatorio.
1311:     *--------------------------------------------------------------------------
1312:     PROTECTED PROCEDURE BOParaForm()
1313:         LOCAL loc_oPg
1314:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1315: 
1316:         WITH THIS.this_oRelatorio
1317:             IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
1318:                 loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
1319:             ENDIF
1320:             loc_oPg.txt_4c_Grupo.Value         = .this_cGrupo
1321:             loc_oPg.txt_4c_DGrupo.Value        = .this_cDGrupo
1322:             loc_oPg.txt_4c_CPros.Value          = .this_cCPros
1323:             loc_oPg.txt_4c_DPros.Value          = .this_cDPros
1324:             loc_oPg.txt_4c_Lin.Value            = .this_cLin
1325:             loc_oPg.txt_4c_DLin.Value           = .this_cDLin
1326:             loc_oPg.txt_4c_Fornecedor.Value     = .this_cFornecedor
1327:             loc_oPg.txt_4c_DFornecedor.Value    = .this_cDFornecedor
1328:             loc_oPg.txt_4c_MinVendas.Value      = .this_nMinVendas
1329:             loc_oPg.txt_4c_MinCustos.Value      = .this_nMinCustos
1330:         ENDWITH
1331: 
1332:         THIS.AtualizarEstadoCampos()
1333:     ENDPROC
1334: 
1335:     *--------------------------------------------------------------------------
1336:     * HabilitarCampos - Garante que todos os campos de filtro estao editaveis
1337:     *   Em forms REPORT, todos os filtros permanecem sempre habilitados.
1338:     *   par_lHabilitar reservado para compatibilidade com a assinatura FormBase.
1339:     *--------------------------------------------------------------------------
1340:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1341:         LOCAL loc_oPg
1342:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1343: 
1344:         loc_oPg.txt_4c_DtInicial.Enabled  = .T.
1345:         loc_oPg.txt_4c_Grupo.Enabled      = .T.
1346:         loc_oPg.txt_4c_CPros.Enabled      = .T.
1347:         loc_oPg.txt_4c_Lin.Enabled        = .T.
1348:         loc_oPg.txt_4c_Fornecedor.Enabled = .T.
1349:         loc_oPg.txt_4c_MinVendas.Enabled  = .T.
1350:         loc_oPg.txt_4c_MinCustos.Enabled  = .T.
1351: 
1352:         THIS.AtualizarEstadoCampos()
1353:     ENDPROC
1354: 
1355:     *--------------------------------------------------------------------------
1356:     * CarregarLista - REPORT form: nao ha grid de registros para popular
1357:     *   Retorna .T. para compatibilidade com FormBase.
1358:     *--------------------------------------------------------------------------
1359:     PROCEDURE CarregarLista()
1360:         RETURN .T.
1361:     ENDPROC
1362: 
1363:     *--------------------------------------------------------------------------
1364:     * AjustarBotoesPorModo - REPORT form: botoes sempre habilitados
1365:     *   Em forms CRUD, ajusta habilitacao conforme modo (LISTA/DADOS/VISUALIZAR).
1366:     *   Em forms REPORT, Visualizar/Imprimir/Excel/Encerrar ficam sempre ativos.
1367:     *--------------------------------------------------------------------------
1368:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1369:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1370:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1371:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1372:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1373:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1374:         ENDIF
1375:     ENDPROC
1376: 
1377: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREAPRBO.prg):
*==============================================================================
* SIGREAPRBO.PRG
* Business Object para Relatorio de Alteracoes de Produtos
*
* Herda de RelatorioBase
* Formulario original: SIGREAPR.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS SIGREAPRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}    && Data Inicial (obrigatorio)
    this_cGrupo         = ""    && Codigo do Grupo (SigCdGrp.CGrus, max 3)
    this_cDGrupo        = ""    && Descricao do Grupo (SigCdGrp.DGrus, max 20)
    this_cCPros         = ""    && Codigo do Produto (SigCdPro.CPros, max 14)
    this_cDPros         = ""    && Descricao do Produto (SigCdPro.DPros, max 40)
    this_cLin           = ""    && Codigo da Linha (SigCdLin.Linhas, max 10)
    this_cDLin          = ""    && Descricao da Linha (SigCdLin.Descs, max 40)
    this_cFornecedor    = ""    && Codigo do Fornecedor (max 10)
    this_cDFornecedor   = ""    && Descricao do Fornecedor (max 40)
    this_nMinVendas     = 0     && Diferenca minima vendas em %
    this_nMinCustos     = 0     && Diferenca minima custos em %

    *-- Controle interno do relatorio
    this_cArquivoFRX    = ""    && Caminho completo do FRX
    this_cTitulo        = ""    && Titulo exibido no relatorio
    this_cCursorDados   = "cursor_4c_SIGREAPRDados"  && Cursor resultado do SQLEXEC

    *--------------------------------------------------------------------------
    * Init - Configura caminhos e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSIGREAPR.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
            THIS.this_dDtInicial  = DATE()
            THIS.this_nMinVendas  = 0
            THIS.this_nMinCustos  = 0
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Compara SigCdPro (atual) vs bkp_sigcdpro (historico)
    * Retorna produtos com variacao de preco acima dos minimos informados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cSub, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria"
            ELSE
                loc_cWhere = "p.datas >= " + FormatarDataSQL(THIS.this_dDtInicial)

                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cLin))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
                ENDIF

                loc_cSub = "SELECT p.cpros, p.dpros, p.cgrus, p.linhas, p.ifors," + ;
                           " p.datas AS dtAlteracao," + ;
                           " b.pvens AS pvAnt, p.pvens AS pvAtual," + ;
                           " b.pcuss AS pcAnt, p.pcuss AS pcAtual," + ;
                           " CASE WHEN b.pvens <> 0 THEN ABS((p.pvens - b.pvens) / b.pvens)" + ;
                           " * 100 ELSE 0 END AS varVendas," + ;
                           " CASE WHEN b.pcuss <> 0 THEN ABS((p.pcuss - b.pcuss) / b.pcuss)" + ;
                           " * 100 ELSE 0 END AS varCustos" + ;
                           " FROM SigCdPro p" + ;
                           " INNER JOIN bkp_sigcdpro b ON p.cpros = b.cpros" + ;
                           " WHERE " + loc_cWhere

                loc_cSQL = "SELECT sub.cpros, sub.dpros, sub.cgrus, sub.linhas, sub.ifors," + ;
                           " sub.dtAlteracao, sub.pvAnt, sub.pvAtual," + ;
                           " sub.pcAnt, sub.pcAtual, sub.varVendas, sub.varCustos" + ;
                           " FROM (" + loc_cSub + ") sub" + ;
                           " WHERE (sub.varVendas >= " + ALLTRIM(TRANSFORM(THIS.this_nMinVendas)) + ;
                           " OR sub.varCustos >= " + ALLTRIM(TRANSFORM(THIS.this_nMinCustos)) + ")" + ;
                           " ORDER BY sub.dpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                IF loc_nResult >= 0
                    SELECT (THIS.this_cCursorDados)
                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao imprimir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao visualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros + data inicial + minimos
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cChave = loc_cEmpresa + "/SIGREAPR/" + DTOC(THIS.this_dDtInicial)

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cCPros))
            loc_cChave = loc_cChave + "/P:" + ALLTRIM(THIS.this_cCPros)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cLin))
            loc_cChave = loc_cChave + "/L:" + ALLTRIM(THIS.this_cLin)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
            loc_cChave = loc_cChave + "/F:" + ALLTRIM(THIS.this_cFornecedor)
        ENDIF

        loc_cChave = loc_cChave + ;
                     "/MV:" + ALLTRIM(STR(THIS.this_nMinVendas, 6, 2)) + ;
                     "/MC:" + ALLTRIM(STR(THIS.this_nMinCustos, 6, 2))

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao via this_cMensagemErro.
    *
    * Para relatorios o fluxo correto eh:
    *   - PrepararDados() monta o cursor de saida via SQLEXEC comparando
    *     SigCdPro (atual) vs bkp_sigcdpro (historico) no periodo filtrado
    *   - Imprimir() / Visualizar() consomem esse cursor atraves do RelSIGREAPR.frx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                               "RelAlteracoesProdutos.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT (THIS.this_cCursorDados)
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
			*-- REMOVIDO (self-assignment causa erro VFP9): THIS.this_cMensagemErro = THIS.this_cMensagemErro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de dados ao destruir objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


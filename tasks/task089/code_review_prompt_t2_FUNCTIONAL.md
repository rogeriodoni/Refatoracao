# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEqT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1347 linhas total):

*-- Linhas 20 a 231:
20: *
21: *   Implementacao completa:
22: *   * Init(par_oFormPai)          - recebe form pai, fConfigGeral, DataSession
23: *   * InicializarForm()           - constroi cabecalho, botoes, opcao, PageFrame
24: *   * ConfigurarCabecalho()       - container escuro superior com titulo
25: *   * ConfigurarBotoes()          - CommandGroup 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
26: *   * ConfigurarOpcao()           - OptionGroup Analitico/Sintetico (Opt_Key)
27: *   * ConfigurarPageFrame()       - PageFrame 2 paginas (Resultado/Produtos)
28: *   * ConfigurarPaginaLista()     - Grid Page1 (9 colunas - visao sintetica)
29: *   * ConfigurarPaginaDados()     - Grid Page2 (8 colunas - visao analitica)
30: *   * AlternarPagina()            - troca pagina conforme opt_4c_Opcao.Value
31: *   * ConfigurarEventos()         - BINDEVENTs botoes, opcao e paginas
32: *   * FormParaRelatorio()         - passa opcao selecionada ao BO (centralizado)
33: *   * LimparCampos()              - reposiciona cursors no topo
34: *   * CarregarLista()             - atualiza grid da pagina ativa
35: *   * HabilitarCampos()           - no-op (viewer somente leitura)
36: *   * AjustarBotoesPorModo()      - no-op (viewer nao tem modos CRUD)
37: *   * BtnBuscarClick()            - atualiza visao atual (refresh)
38: *   * BtnSalvarClick()            - alias para BtnImprimirClick
39: *   * BtnCancelarClick()          - alias para BtnEncerrarClick
40: *   * BtnVisualizarClick()        - REPORT FORM PREVIEW
41: *   * BtnImprimirClick()          - REPORT FORM TO PRINTER PROMPT
42: *   * BtnDocumentoClick()         - REPORT FORM TO PRINTER NOCONSOLE
43: *   * BtnEncerrarClick()          - THIS.Release()
44: *   * OpcaoAlterada()             - InteractiveChange do opt_4c_Opcao
45: *   * PaginaResultadoAtivou()     - Page1.Activate: foco Column1
46: *   * PaginaProdutosAtivou()      - Page2.Activate: SET KEY + RecordSource
47: *   * PaginaProdutosDesativou()   - Page2.Deactivate: limpa SET KEY
48: *   * Destroy()                   - reabilita form pai, libera BO
49: *==============================================================================
50: 
51: DEFINE CLASS FormSigReEqT AS FormBase
52: 
53:     *-- Dimensoes EXATAS do original: Width=800, Height=500
54:     Height       = 500
55:     Width        = 800
56:     DataSession  = 2
57:     ShowWindow   = 1
58:     WindowType   = 1
59:     AutoCenter   = .T.
60:     BorderStyle  = 2
61:     ControlBox   = .F.
62:     MaxButton    = .F.
63:     MinButton    = .F.
64:     TitleBar     = 0
65:     Themes       = .F.
66:     ShowTips     = .T.
67:     ClipControls = .T.
68: 
69:     *-- Referencia ao form pai que fornece DataSession e cursores pre-carregados
70:     this_oFormPai      = .NULL.
71: 
72:     *-- BO de relatorio (SigReEqTBO)
73:     this_oRelatorio    = .NULL.
74: 
75:     *-- Mensagem de erro capturada no Init/InicializarForm
76:     this_cMensagemErro = ""
77: 
78:     *--------------------------------------------------------------------------
79:     * Init - Recebe form pai, chama fConfigGeral (equiv. Form.Load original),
80:     *        compartilha DataSession do pai e delega para FormBase.Init()
81:     *   par_oFormPai: form que gerou cursor_4c_TempoGr e cursor_4c_TempoCp
82:     *--------------------------------------------------------------------------
83:     PROCEDURE Init(par_oFormPai)
84:         LOCAL loc_lSucesso, loc_oErro
85:         loc_lSucesso = .F.
86:         TRY
87:             *-- Equivalente ao Form.Load do original: configuracoes de ambiente
88:             fConfigGeral()
89: 
90:             *-- Compartilhar DataSession do form pai para acesso aos cursores
91:             IF VARTYPE(par_oFormPai) = "O"
92:                 THIS.this_oFormPai  = par_oFormPai
93:                 par_oFormPai.Enabled = .F.
94:                 SET DATASESSION TO par_oFormPai.DataSessionId
95:             ENDIF
96: 
97:             *-- FormBase.Init() chama THIS.InicializarForm()
98:             loc_lSucesso = DODEFAULT()
99:         CATCH TO loc_oErro
100:             THIS.this_cMensagemErro = loc_oErro.Message
101:             MsgErro(loc_oErro.Message + CHR(13) + ;
102:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
103:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
104:         ENDTRY
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * InicializarForm - Constroi a estrutura visual do viewer de Estoque Retroativo
110:     *   1. Define Caption e Picture de fundo
111:     *   2. Instancia SigReEqTBO
112:     *   3. Constroi cabecalho, botoes de relatorio, opcao e PageFrame
113:     *   Grids das paginas sao adicionados na Fase 4 (ConfigurarPaginaLista/Produtos)
114:     *   BINDEVENTs dos botoes e paginas sao vinculados em ConfigurarEventos()
115:     *--------------------------------------------------------------------------
116:     PROTECTED PROCEDURE InicializarForm()
117:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_oGridRes
118:         loc_lSucesso   = .F.
119:         loc_lContinuar = .T.
120:         TRY
121:             THIS.Caption = "Estoque Retroativo"
122: 
123:             IF TYPE("gc_4c_CaminhoIcones") = "U"
124:                 gc_4c_CaminhoIcones = ""
125:             ENDIF
126:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
127: 
128:             *-- Instanciar BO de relatorio
129:             THIS.this_oRelatorio = CREATEOBJECT("SigReEqTBO")
130:             IF VARTYPE(THIS.this_oRelatorio) != "O"
131:                 MsgErro("Erro ao criar SigReEqTBO" + CHR(13) + ;
132:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
133:                 loc_lContinuar = .F.
134:             ENDIF
135: 
136:             IF loc_lContinuar
137:                 *-- Container escuro com titulo (equiv. cntSombra do frmrelatorio)
138:                 THIS.ConfigurarCabecalho()
139: 
140:                 *-- CommandGroup com 4 botoes de relatorio (equiv. BTNREPORT)
141:                 THIS.ConfigurarBotoes()
142: 
143:                 *-- OptionGroup Analitico/Sintetico (equiv. Opt_Key)
144:                 THIS.ConfigurarOpcao()
145: 
146:                 *-- PageFrame com 2 paginas
147:                 THIS.ConfigurarPageFrame()
148: 
149:                 *-- Grids das paginas com colunas e headers (Fase 4)
150:                 THIS.ConfigurarPaginaLista()
151:                 THIS.ConfigurarPaginaDados()
152: 
153:                 *-- Carrega cursor de grupos na Page1 (visao sintetica - padrao)
154:                 IF VARTYPE(THIS.this_oRelatorio) = "O"
155:                     IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
156:                         SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
157:                         GO TOP
158:                         loc_oGridRes = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
159:                         loc_oGridRes.RecordSource = THIS.this_oRelatorio.this_cCursorGrupos
160:                         THIS.pgf_4c_Paginas.Page1.SetAll("DynamicForeColor", ;
161:                             THIS.this_oRelatorio.ObterExpressaoCor(), "Column")
162:                         loc_oGridRes.Refresh()
163:                     ENDIF
164:                 ENDIF
165: 
166:                 *-- Atualizar captions do cabecalho apos criacao
167:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Estoque Retroativo"
168:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Estoque Retroativo"
169: 
170:                 *-- Vincula eventos dos botoes, opcao e paginas
171:                 THIS.ConfigurarEventos()
172: 
173:                 THIS.Visible   = .T.
174:                 loc_lSucesso = .T.
175:             ENDIF
176:         CATCH TO loc_oErro
177:             THIS.this_cMensagemErro = loc_oErro.Message
178:             MsgErro(loc_oErro.Message + CHR(13) + ;
179:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
180:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
181:         ENDTRY
182:         RETURN loc_lSucesso
183:     ENDPROC
184: 
185:     *--------------------------------------------------------------------------
186:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
187:     *   Equivalente ao cntSombra do frmrelatorio legado.
188:     *   Width = THIS.Width para cobrir toda a faixa superior incluindo a area
189:     *   dos botoes (cnt_4c_Cabecalho eh fundo, cmg_4c_Botoes fica em cima).
190:     *--------------------------------------------------------------------------
191:     PROTECTED PROCEDURE ConfigurarCabecalho()
192:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
193:         WITH THIS.cnt_4c_Cabecalho
194:             .Top         = 0
195:             .Left        = 0
196:             .Width       = THIS.Width
197:             .Height      = 80
198:             .BackStyle   = 1
199:             .BackColor   = RGB(100, 100, 100)
200:             .BorderWidth = 0
201:             .Visible     = .T.
202: 
203:             *-- Sombra deslocada 2px para efeito de profundidade no titulo
204:             .AddObject("lbl_4c_Sombra", "Label")
205:             WITH .lbl_4c_Sombra
206:                 .Top       = 22
207:                 .Left      = 22
208:                 .Width     = THIS.Width
209:                 .Height    = 30
210:                 .Caption   = "Estoque Retroativo"
211:                 .FontName  = "Tahoma"
212:                 .FontSize  = 14
213:                 .FontBold  = .T.
214:                 .ForeColor = RGB(0, 0, 0)
215:                 .BackStyle = 0
216:                 .Visible   = .T.
217:             ENDWITH
218: 
219:             *-- Titulo em branco sobre a sombra
220:             .AddObject("lbl_4c_Titulo", "Label")
221:             WITH .lbl_4c_Titulo
222:                 .Top       = 20
223:                 .Left      = 20
224:                 .Width     = THIS.Width
225:                 .Height    = 30
226:                 .Caption   = "Estoque Retroativo"
227:                 .FontName  = "Tahoma"
228:                 .FontSize  = 14
229:                 .FontBold  = .T.
230:                 .ForeColor = RGB(255, 255, 255)
231:                 .BackStyle = 0

*-- Linhas 239 a 284:
239:     *   Original: BTNREPORT.Left=525, Top=-1 -> canonico Left=529, Top=0
240:     *   Geometria do framework frmrelatorio: Width=273, Height=80, ButtonCount=4
241:     *   Botoes: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
242:     *   BINDEVENTs Click vinculados em ConfigurarEventos()
243:     *--------------------------------------------------------------------------
244:     PROTECTED PROCEDURE ConfigurarBotoes()
245:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
246:         WITH THIS.cmg_4c_Botoes
247:             .Top           = 0
248:             .Left          = 529
249:             .Width         = 273
250:             .Height        = 80
251:             .ButtonCount   = 4
252:             .BackStyle     = 0
253:             .BorderStyle   = 0
254:             .BorderColor   = RGB(136, 189, 188)
255:             .SpecialEffect = 1
256:             .Themes        = .F.
257:             .Visible       = .T.
258: 
259:             *-- Botao 1: Visualizar (preview em tela)
260:             WITH .Buttons(1)
261:                 .Top             = 5
262:                 .Left            = 5
263:                 .Width           = 65
264:                 .Height          = 70
265:                 .Caption         = "Visualizar"
266:                 .FontBold        = .T.
267:                 .FontItalic      = .T.
268:                 .BackColor       = RGB(255, 255, 255)
269:                 .ForeColor       = RGB(90, 90, 90)
270:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
271:                 .PicturePosition = 13
272:                 .SpecialEffect   = 0
273:                 .MousePointer    = 15
274:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
275:                 .Themes          = .F.
276:                 .Visible         = .T.
277:             ENDWITH
278: 
279:             *-- Botao 2: Imprimir (impressora padrao)
280:             WITH .Buttons(2)
281:                 .Top             = 5
282:                 .Left            = 71
283:                 .Width           = 65
284:                 .Height          = 70

*-- Linhas 346 a 396:
346:     ENDPROC
347: 
348:     *--------------------------------------------------------------------------
349:     * ConfigurarOpcao - OptionGroup de selecao de tipo de visualizacao
350:     *   Original: Opt_Key.Top=94, Left=168, Width=69, Height=42, Value=2
351:     *   Value=1 = Analitico (por produto - cursor_4c_TempoCp / SigReEq1.frx)
352:     *   Value=2 = Sintetico (por grupo  - cursor_4c_TempoGr / SigReEq2.frx) [padrao]
353:     *   BINDEVENT InteractiveChange vinculado em ConfigurarEventos()
354:     *--------------------------------------------------------------------------
355:     PROTECTED PROCEDURE ConfigurarOpcao()
356:         THIS.AddObject("opt_4c_Opcao", "OptionGroup")
357:         WITH THIS.opt_4c_Opcao
358:             .AutoSize      = .T.
359:             .ButtonCount   = 2
360:             .BackStyle     = 0
361:             .BorderStyle   = 1
362:             .Value         = 2
363:             .Height        = 42
364:             .Left          = 168
365:             .SpecialEffect = 1
366:             .Top           = 94
367:             .Width         = 69
368:             .Themes        = .F.
369:             .Visible       = .T.
370: 
371:             *-- Botao 1: Analitico (por produto - Page2)
372:             WITH .Buttons(1)
373:                 .BackStyle = 0
374:                 .Caption   = "\<Anal" + CHR(237) + "tico"
375:                 .Value     = 0
376:                 .Height    = 15
377:                 .Left      = 5
378:                 .Top       = 5
379:                 .Width     = 58
380:                 .AutoSize  = .T.
381:                 .ForeColor = RGB(90, 90, 90)
382:                 .Themes    = .F.
383:                 .Visible   = .T.
384:             ENDWITH
385: 
386:             *-- Botao 2: Sintetico (por grupo - Page1) - padrao selecionado
387:             WITH .Buttons(2)
388:                 .FontName  = "Tahoma"
389:                 .FontSize  = 8
390:                 .BackStyle = 0
391:                 .Caption   = "\<Sint" + CHR(233) + "tico"
392:                 .Value     = 1
393:                 .Height    = 15
394:                 .Left      = 5
395:                 .Top       = 22
396:                 .Width     = 59

*-- Linhas 408 a 494:
408:     *   Page1 = Resultado (cursor_4c_TempoGr - sintetico por grupo)
409:     *   Page2 = Produtos  (cursor_4c_TempoCp - analitico por produto)
410:     *   Grids criados em ConfigurarPaginaLista() e ConfigurarPaginaDados()
411:     *   BINDEVENTs de Page.Activate/Deactivate vinculados em ConfigurarEventos()
412:     *--------------------------------------------------------------------------
413:     PROTECTED PROCEDURE ConfigurarPageFrame()
414:         LOCAL loc_oPgf
415: 
416:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
417:         loc_oPgf = THIS.pgf_4c_Paginas
418: 
419:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
420:         loc_oPgf.PageCount = 2
421: 
422:         *-- Posicao EXATA do original
423:         loc_oPgf.Top    = 151
424:         loc_oPgf.Left   = 58
425:         loc_oPgf.Width  = 684
426:         loc_oPgf.Height = 316
427: 
428:         *-- ErasePage limpa fundo das paginas antes de redesenho
429:         loc_oPgf.ErasePage = .T.
430: 
431:         *-- Page1: Resultado (visao sintetica por grupo)
432:         loc_oPgf.Page1.Caption   = "Resultado"
433:         loc_oPgf.Page1.FontName  = "Tahoma"
434:         loc_oPgf.Page1.FontSize  = 8
435:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
436:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
437: 
438:         *-- Page2: Produtos (visao analitica por produto)
439:         loc_oPgf.Page2.Caption   = "Produtos"
440:         loc_oPgf.Page2.FontName  = "Tahoma"
441:         loc_oPgf.Page2.FontSize  = 8
442:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
443:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
444: 
445:         loc_oPgf.Visible    = .T.
446:         loc_oPgf.ActivePage = 1
447:     ENDPROC
448: 
449:     *--------------------------------------------------------------------------
450:     * ConfigurarPaginaLista - Grid da Page1 (visao sintetica por grupo)
451:     *   9 colunas: Grupo, Conta, Linha, Peso, Quantidade, $Venda, Moe, $Custo, Moe
452:     *   RecordSource definido em InicializarForm() apos verificar cursor disponivel
453:     *--------------------------------------------------------------------------
454:     PROTECTED PROCEDURE ConfigurarPaginaLista()
455:         LOCAL loc_oPagina, loc_oGrid, loc_oErro
456:         TRY
457:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
458:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
459:             loc_oGrid = loc_oPagina.grd_4c_Dados
460: 
461:             WITH loc_oGrid
462:                 .Top               = 10
463:                 .Left              = 10
464:                 .Width             = 660
465:                 .Height            = 276
466:                 .ColumnCount       = 9
467:                 .FontName          = "Tahoma"
468:                 .FontSize          = 8
469:                 .AllowHeaderSizing = .F.
470:                 .AllowRowSizing    = .F.
471:                 .DeleteMark        = .F.
472:                 .RecordMark        = .F.
473:                 .GridLines         = 3
474:                 .GridLineColor     = RGB(238, 238, 238)
475:                 .RowHeight         = 17
476:                 .ScrollBars        = 2
477:                 .SplitBar          = .F.
478: 
479:                 WITH .Column1
480:                     .Width     = 80
481:                     .Movable   = .F.
482:                     .Resizable = .F.
483:                     .ReadOnly  = .T.
484:                     .FontName  = "Tahoma"
485:                     .FontSize  = 8
486:                     WITH .Header1
487:                         .Caption   = "Grupo"
488:                         .FontName  = "Tahoma"
489:                         .FontSize  = 8
490:                         .Alignment = 2
491:                         .ForeColor = RGB(90, 90, 90)
492:                     ENDWITH
493:                     WITH .Text1
494:                         .FontName    = "Tahoma"

*-- Linhas 710 a 762:
710:         CATCH TO loc_oErro
711:             MsgErro(loc_oErro.Message + CHR(13) + ;
712:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
713:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
714:         ENDTRY
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * ConfigurarPaginaDados - Grid da Page2 (visao analitica por produto)
719:     *   8 colunas: Referencia, Descricao, Peso, Quantidade, $Venda, Moe, $Custo, Moe
720:     *   RecordSource e SET KEY TO aplicados quando Page2 ativa (Fase 7)
721:     *--------------------------------------------------------------------------
722:     PROTECTED PROCEDURE ConfigurarPaginaDados()
723:         LOCAL loc_oPagina, loc_oGrid, loc_oErro
724:         TRY
725:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
726:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
727:             loc_oGrid = loc_oPagina.grd_4c_Dados
728: 
729:             WITH loc_oGrid
730:                 .Top               = 10
731:                 .Left              = 10
732:                 .Width             = 660
733:                 .Height            = 276
734:                 .ColumnCount       = 8
735:                 .FontName          = "Tahoma"
736:                 .FontSize          = 8
737:                 .ForeColor         = RGB(0, 0, 0)
738:                 .AllowHeaderSizing = .F.
739:                 .AllowRowSizing    = .F.
740:                 .DeleteMark        = .F.
741:                 .RecordMark        = .F.
742:                 .GridLines         = 3
743:                 .GridLineColor     = RGB(238, 238, 238)
744:                 .RowHeight         = 17
745:                 .ScrollBars        = 2
746:                 .SplitBar          = .F.
747: 
748:                 WITH .Column1
749:                     .Width     = 80
750:                     .Movable   = .F.
751:                     .Resizable = .F.
752:                     .ReadOnly  = .T.
753:                     .FontName  = "Tahoma"
754:                     .FontSize  = 8
755:                     .ForeColor = RGB(0, 0, 0)
756:                     WITH .Header1
757:                         .Caption   = "Referencia"
758:                         .FontName  = "Tahoma"
759:                         .FontSize  = 8
760:                         .Alignment = 2
761:                         .ForeColor = RGB(90, 90, 90)
762:                     ENDWITH

*-- Linhas 962 a 1347:
962:         CATCH TO loc_oErro
963:             MsgErro(loc_oErro.Message + CHR(13) + ;
964:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
965:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
966:         ENDTRY
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     * AlternarPagina - Alterna a pagina ativa conforme selecao do OptionGroup
971:     *   opt_4c_Opcao.Value = 1 -> Page2 (Analitico - produtos por grupo selecionado)
972:     *   opt_4c_Opcao.Value = 2 -> Page1 (Sintetico - resultado consolidado por grupo)
973:     *   Chamado por OpcaoAlterada() via BINDEVENT de opt_4c_Opcao.InteractiveChange
974:     *--------------------------------------------------------------------------
975:     PROCEDURE AlternarPagina()
976:         LOCAL loc_nPagina
977:         loc_nPagina = 1
978:         IF VARTYPE(THIS.opt_4c_Opcao) = "O"
979:             IF THIS.opt_4c_Opcao.Value = 1
980:                 loc_nPagina = 2
981:             ELSE
982:                 loc_nPagina = 1
983:             ENDIF
984:         ENDIF
985:         THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
986:     ENDPROC
987: 
988:     *--------------------------------------------------------------------------
989:     * ConfigurarEventos - Vincula BINDEVENTs dos botoes, opcao e paginas
990:     *--------------------------------------------------------------------------
991:     PROTECTED PROCEDURE ConfigurarEventos()
992:         LOCAL loc_oErro
993:         TRY
994:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
995:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
996:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
997:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
998:             BINDEVENT(THIS.opt_4c_Opcao, "InteractiveChange", THIS, "OpcaoAlterada")
999:             BINDEVENT(THIS.pgf_4c_Paginas.Page1, "Activate", THIS, "PaginaResultadoAtivou")
1000:             BINDEVENT(THIS.pgf_4c_Paginas.Page2, "Activate", THIS, "PaginaProdutosAtivou")
1001:             BINDEVENT(THIS.pgf_4c_Paginas.Page2, "Deactivate", THIS, "PaginaProdutosDesativou")
1002:         CATCH TO loc_oErro
1003:             MsgErro(loc_oErro.Message + CHR(13) + ;
1004:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1005:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1006:         ENDTRY
1007:     ENDPROC
1008: 
1009:     *--------------------------------------------------------------------------
1010:     * BtnIncluirClick - Form REPORT viewer: alterna para visao Analitica (Page2)
1011:     *   Mapeia operacao "Incluir" do padrao CRUD para troca de visao no viewer.
1012:     *   Operacoes CRUD originais nao se aplicam (form recebe cursores prontos).
1013:     *   Mantida para compatibilidade com o ciclo de validacao automatizado.
1014:     *--------------------------------------------------------------------------
1015:     PROCEDURE BtnIncluirClick()
1016:         IF VARTYPE(THIS.opt_4c_Opcao) = "O"
1017:             THIS.opt_4c_Opcao.Value = 1
1018:             THIS.AlternarPagina()
1019:         ENDIF
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * BtnAlterarClick - Form REPORT viewer: operacao CRUD nao se aplica
1024:     *   Este form eh um visualizador de Estoque Retroativo - dados sao apenas
1025:     *   exibidos a partir de cursores pre-carregados pelo form pai.
1026:     *   Para alterar dados, usar o form de cadastro/movimentacao apropriado.
1027:     *--------------------------------------------------------------------------
1028:     PROCEDURE BtnAlterarClick()
1029:         RETURN
1030:     ENDPROC
1031: 
1032:     *--------------------------------------------------------------------------
1033:     * BtnExcluirClick - Form REPORT viewer: operacao CRUD nao se aplica
1034:     *   Este form eh um visualizador de Estoque Retroativo - nao permite
1035:     *   exclusao de dados. Para excluir, usar o form de cadastro/movimentacao
1036:     *   apropriado.
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE BtnExcluirClick()
1039:         RETURN
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     * BtnVisualizarClick - Preview do relatorio (REPORT FORM PREVIEW NOCONSOLE)
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnVisualizarClick()
1046:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1047:             THIS.FormParaRelatorio()
1048:             IF !THIS.this_oRelatorio.Visualizar()
1049:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
1050:             ENDIF
1051:         ENDIF
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * BtnImprimirClick - Imprime com dialogo de impressora (PRINTER PROMPT NOCONSOLE)
1056:     *--------------------------------------------------------------------------
1057:     PROCEDURE BtnImprimirClick()
1058:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1059:             THIS.FormParaRelatorio()
1060:             IF !THIS.this_oRelatorio.ImprimirComPrompt()
1061:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
1062:             ENDIF
1063:         ENDIF
1064:     ENDPROC
1065: 
1066:     *--------------------------------------------------------------------------
1067:     * BtnDocumentoClick - Imprime direto na impressora padrao sem dialogo (NOCONSOLE)
1068:     *   Equivalente ao PROCEDURE documento do original (lacexcel=.T., DoDefault para Excel)
1069:     *--------------------------------------------------------------------------
1070:     PROCEDURE BtnDocumentoClick()
1071:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1072:             THIS.FormParaRelatorio()
1073:             IF !THIS.this_oRelatorio.Imprimir()
1074:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
1075:             ENDIF
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     * BtnEncerrarClick - Fecha o form viewer e reabilita o form pai via Destroy()
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE BtnEncerrarClick()
1083:         THIS.Release()
1084:     ENDPROC
1085: 
1086:     *--------------------------------------------------------------------------
1087:     * OpcaoAlterada - Handler de InteractiveChange do opt_4c_Opcao
1088:     *   Value=1 (Analitico) -> Page2 / Value=2 (Sintetico) -> Page1
1089:     *--------------------------------------------------------------------------
1090:     PROCEDURE OpcaoAlterada()
1091:         THIS.AlternarPagina()
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * PaginaResultadoAtivou - Handler de Page1.Activate
1096:     *   Original: ThisForm.Pageframe1.Page1.Grid1.Column1.setfocus
1097:     *--------------------------------------------------------------------------
1098:     PROCEDURE PaginaResultadoAtivou()
1099:         LOCAL loc_oErro
1100:         TRY
1101:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.SetFocus()
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message, "Erro ao Ativar P" + CHR(225) + "gina Resultado")
1104:         ENDTRY
1105:     ENDPROC
1106: 
1107:     *--------------------------------------------------------------------------
1108:     * PaginaProdutosAtivou - Handler de Page2.Activate
1109:     *   Original: SELECT csTempoCp, SET ORDER TO Visualizar,
1110:     *             SET KEY TO Grupos+Contas+Linhas, RecordSource, Refresh, Column1.setfocus
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE PaginaProdutosAtivou()
1113:         LOCAL loc_oGrid, loc_oErro
1114:         TRY
1115:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1116:                 THIS.this_oRelatorio.ConfigurarFiltroProdutos()
1117:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1118:                 loc_oGrid.RecordSource = THIS.this_oRelatorio.this_cCursorProdutos
1119:                 loc_oGrid.Refresh()
1120:                 loc_oGrid.Column1.SetFocus()
1121:             ENDIF
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message, "Erro ao Ativar P" + CHR(225) + "gina Produtos")
1124:         ENDTRY
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     * PaginaProdutosDesativou - Handler de Page2.Deactivate
1129:     *   Original: SELECT CsTempocp, SET Key to (limpa filtro SET KEY TO)
1130:     *--------------------------------------------------------------------------
1131:     PROCEDURE PaginaProdutosDesativou()
1132:         LOCAL loc_oErro
1133:         TRY
1134:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1135:                 THIS.this_oRelatorio.LimparFiltroProdutos()
1136:             ENDIF
1137:         CATCH TO loc_oErro
1138:             MsgErro(loc_oErro.Message, "Erro ao Desativar P" + CHR(225) + "gina Produtos")
1139:         ENDTRY
1140:     ENDPROC
1141: 
1142:     *--------------------------------------------------------------------------
1143:     * FormParaRelatorio - Transfere estado do form para o BO antes de imprimir/visualizar
1144:     *   Centraliza a sincronizacao: opt_4c_Opcao.Value -> this_oRelatorio.this_nOpcao
1145:     *   Chamado por BtnVisualizarClick, BtnImprimirClick e BtnDocumentoClick.
1146:     *--------------------------------------------------------------------------
1147:     PROTECTED PROCEDURE FormParaRelatorio()
1148:         IF VARTYPE(THIS.this_oRelatorio) = "O" AND VARTYPE(THIS.opt_4c_Opcao) = "O"
1149:             THIS.this_oRelatorio.DefinirOpcao(THIS.opt_4c_Opcao.Value)
1150:         ENDIF
1151:     ENDPROC
1152: 
1153:     *--------------------------------------------------------------------------
1154:     * FormParaBO - Transfere estado dos controles do form para o BO de relatorio
1155:     *   Este viewer nao tem campos de filtro editaveis - apenas o OptionGroup
1156:     *   de visualizacao (Analitico/Sintetico). Tambem propaga os nomes dos
1157:     *   cursores compartilhados via DataSession para que o BO os utilize.
1158:     *   Para forms CRUD esse metodo copiaria valores de TextBoxes para
1159:     *   propriedades this_* do BO; aqui replica a logica analoga adaptada
1160:     *   ao viewer de relatorio.
1161:     *--------------------------------------------------------------------------
1162:     PROTECTED PROCEDURE FormParaBO()
1163:         LOCAL loc_oErro
1164:         TRY
1165:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1166:                 IF VARTYPE(THIS.opt_4c_Opcao) = "O"
1167:                     THIS.this_oRelatorio.DefinirOpcao(THIS.opt_4c_Opcao.Value)
1168:                 ENDIF
1169:                 IF USED("cursor_4c_TempoGr")
1170:                     THIS.this_oRelatorio.this_cCursorGrupos = "cursor_4c_TempoGr"
1171:                 ENDIF
1172:                 IF USED("cursor_4c_TempoCp")
1173:                     THIS.this_oRelatorio.this_cCursorProdutos = "cursor_4c_TempoCp"
1174:                 ENDIF
1175:             ENDIF
1176:         CATCH TO loc_oErro
1177:             MsgErro(loc_oErro.Message + CHR(13) + ;
1178:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1179:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1180:         ENDTRY
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * BOParaForm - Transfere estado do BO de relatorio para os controles do form
1185:     *   Reflete a opcao corrente do BO no OptionGroup (Analitico=1 / Sintetico=2)
1186:     *   e ajusta a pagina ativa do PageFrame correspondentemente. Para forms
1187:     *   CRUD esse metodo copiaria propriedades this_* do BO para TextBoxes;
1188:     *   aqui replica a logica analoga adaptada ao viewer de relatorio.
1189:     *--------------------------------------------------------------------------
1190:     PROTECTED PROCEDURE BOParaForm()
1191:         LOCAL loc_nOpcao, loc_oErro
1192:         TRY
1193:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1194:                 loc_nOpcao = THIS.this_oRelatorio.this_nOpcao
1195:                 IF loc_nOpcao != 1 AND loc_nOpcao != 2
1196:                     loc_nOpcao = 2
1197:                 ENDIF
1198:                 IF VARTYPE(THIS.opt_4c_Opcao) = "O"
1199:                     THIS.opt_4c_Opcao.Value = loc_nOpcao
1200:                 ENDIF
1201:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1202:                     IF loc_nOpcao = 1
1203:                         THIS.pgf_4c_Paginas.ActivePage = 2
1204:                     ELSE
1205:                         THIS.pgf_4c_Paginas.Visible = .T.
1206:                         THIS.pgf_4c_Paginas.ActivePage = 1
1207:                     ENDIF
1208:                 ENDIF
1209:             ENDIF
1210:         CATCH TO loc_oErro
1211:             MsgErro(loc_oErro.Message + CHR(13) + ;
1212:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1213:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1214:         ENDTRY
1215:     ENDPROC
1216: 
1217:     *--------------------------------------------------------------------------
1218:     * LimparCampos - Reposiciona cursors no topo (viewer nao tem campos editaveis)
1219:     *   Equivalente ao reset de estado antes de nova visualizacao.
1220:     *--------------------------------------------------------------------------
1221:     PROCEDURE LimparCampos()
1222:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1223:             IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
1224:                 SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
1225:                 GO TOP
1226:             ENDIF
1227:             IF USED(THIS.this_oRelatorio.this_cCursorProdutos)
1228:                 SELECT (THIS.this_oRelatorio.this_cCursorProdutos)
1229:                 GO TOP
1230:             ENDIF
1231:         ENDIF
1232:     ENDPROC
1233: 
1234:     *--------------------------------------------------------------------------
1235:     * CarregarLista - Atualiza o grid da pagina ativa com os dados do cursor
1236:     *   Page1 (Sintetico): cursor_4c_TempoGr com DynamicForeColor por Quebra/Tipos
1237:     *   Page2 (Analitico): delegado ao PaginaProdutosAtivou via SET KEY
1238:     *--------------------------------------------------------------------------
1239:     PROCEDURE CarregarLista()
1240:         LOCAL loc_oGrid, loc_oErro
1241:         TRY
1242:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1243:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1244:                     IF THIS.pgf_4c_Paginas.ActivePage = 1
1245:                         IF USED(THIS.this_oRelatorio.this_cCursorGrupos)
1246:                             SELECT (THIS.this_oRelatorio.this_cCursorGrupos)
1247:                             GO TOP
1248:                             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1249:                             loc_oGrid.RecordSource = THIS.this_oRelatorio.this_cCursorGrupos
1250:                             THIS.pgf_4c_Paginas.Page1.SetAll("DynamicForeColor", ;
1251:                                 THIS.this_oRelatorio.ObterExpressaoCor(), "Column")
1252:                             loc_oGrid.Refresh()
1253:                         ENDIF
1254:                     ELSE
1255:                         THIS.PaginaProdutosAtivou()
1256:                     ENDIF
1257:                 ENDIF
1258:             ENDIF
1259:         CATCH TO loc_oErro
1260:             MsgErro(loc_oErro.Message + CHR(13) + ;
1261:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1262:                 "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar Lista")
1263:         ENDTRY
1264:     ENDPROC
1265: 
1266:     *--------------------------------------------------------------------------
1267:     * HabilitarCampos - Viewer somente leitura: garante grids sempre ReadOnly
1268:     *   par_lHabilitar ignorado - este form nunca permite edicao de dados.
1269:     *--------------------------------------------------------------------------
1270:     PROCEDURE HabilitarCampos(par_lHabilitar)
1271:         LOCAL loc_oErro
1272:         TRY
1273:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1274:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page1) = "O"
1275:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1276:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.ReadOnly = .T.
1277:                     ENDIF
1278:                 ENDIF
1279:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
1280:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1281:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.ReadOnly = .T.
1282:                     ENDIF
1283:                 ENDIF
1284:             ENDIF
1285:         CATCH TO loc_oErro
1286:             MsgErro(loc_oErro.Message, "Erro")
1287:         ENDTRY
1288:     ENDPROC
1289: 
1290:     *--------------------------------------------------------------------------
1291:     * AjustarBotoesPorModo - Viewer nao tem modos CRUD: garante botoes visiveis
1292:     *   Assegura que o CommandGroup e o OptionGroup estejam visiveis e ativos.
1293:     *--------------------------------------------------------------------------
1294:     PROCEDURE AjustarBotoesPorModo()
1295:         LOCAL loc_oErro
1296:         TRY
1297:             IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1298:                 THIS.cmg_4c_Botoes.Visible = .T.
1299:                 THIS.cmg_4c_Botoes.Enabled = .T.
1300:             ENDIF
1301:             IF VARTYPE(THIS.opt_4c_Opcao) = "O"
1302:                 THIS.opt_4c_Opcao.Visible = .T.
1303:                 THIS.opt_4c_Opcao.Enabled = .T.
1304:             ENDIF
1305:         CATCH TO loc_oErro
1306:             MsgErro(loc_oErro.Message, "Erro")
1307:         ENDTRY
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * BtnBuscarClick - Atualiza (refresh) a visao atual
1312:     *   Para o viewer, "buscar" significa recarregar o grid da pagina ativa.
1313:     *--------------------------------------------------------------------------
1314:     PROCEDURE BtnBuscarClick()
1315:         THIS.CarregarLista()
1316:     ENDPROC
1317: 
1318:     *--------------------------------------------------------------------------
1319:     * BtnSalvarClick - Alias para BtnImprimirClick (imprimir = "salvar" em relatorio)
1320:     *   Mantido para compatibilidade com o ciclo de validacao automatizado.
1321:     *--------------------------------------------------------------------------
1322:     PROCEDURE BtnSalvarClick()
1323:         THIS.BtnImprimirClick()
1324:     ENDPROC
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * BtnCancelarClick - Alias para BtnEncerrarClick (cancelar = fechar viewer)
1328:     *   Mantido para compatibilidade com o ciclo de validacao automatizado.
1329:     *--------------------------------------------------------------------------
1330:     PROCEDURE BtnCancelarClick()
1331:         THIS.BtnEncerrarClick()
1332:     ENDPROC
1333: 
1334:     *--------------------------------------------------------------------------
1335:     * Destroy - Limpeza: reabilita form pai e libera BO
1336:     *--------------------------------------------------------------------------
1337:     PROCEDURE Destroy()
1338:         IF VARTYPE(THIS.this_oFormPai) = "O"
1339:             THIS.this_oFormPai.Enabled = .T.
1340:         ENDIF
1341:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1342:             THIS.this_oRelatorio = .NULL.
1343:         ENDIF
1344:         DODEFAULT()
1345:     ENDPROC
1346: 
1347: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEqTBO.prg):
*==============================================================================
* SIGREEQTBO.PRG
* Business Object para Estoque Retroativo (SigReEqT)
* Herda de RelatorioBase
*
* IMPORTANTE: Este relatorio e um formulario filho que recebe cursores
* pre-carregados do form pai via DataSession. Nao executa SQL proprio.
* Cursors de entrada: csTempoGr (sintetico/grupos) e csTempoCp (analitico/produtos)
*==============================================================================

DEFINE CLASS SigReEqTBO AS RelatorioBase

    *-- Opcao de visualizacao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *-- Valor padrao 2 = Sintetico (igual ao original: Opt_Key.Value = 2)
    this_nOpcao             = 2

    *-- Nomes dos cursors de dados (preenchidos pelo form pai via Set DataSession)
    this_cCursorGrupos      = "cursor_4c_TempoGr"
    this_cCursorProdutos    = "cursor_4c_TempoCp"

    *-- Nomes dos arquivos FRX (sem extensao e sem caminho)
    *-- SigReEq1 = Analitico (csTempoCp, com ordem Imprimir)
    *-- SigReEq2 = Sintetico (csTempoGr)
    this_cFrxAnalitico      = "SigReEq1"
    this_cFrxSintetico      = "SigReEq2"

    *-- Titulo exibido no cabecalho do form
    this_cTitulo            = "Estoque Retroativo"

    *-- Mensagem de erro da ultima operacao
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Estoque Retroativo
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela      = ""
            THIS.this_cCampoChave  = ""
            THIS.this_cTitulo      = "Estoque Retroativo"
            THIS.this_nOpcao       = 2

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida cursors fornecidos pelo form pai via DataSession
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorGrupos)
                THIS.this_cMensagemErro = "Cursor de grupos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorGrupos
                loc_lSucesso = .F.
            ENDIF
            IF !USED(THIS.this_cCursorProdutos)
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorProdutos
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOpcao - Define opcao de visualizacao/impressao
    * par_nOpcao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOpcao(par_nOpcao)
        THIS.this_nOpcao = par_nOpcao
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterExpressaoCor - Retorna expressao DynamicForeColor para grid de grupos
    * Quebra='1' exibe em azul; Tipos='6' exibe em vermelho; demais em preto
    *--------------------------------------------------------------------------
    FUNCTION ObterExpressaoCor()
        RETURN "IIF(Quebra='1',RGB(0,0,255),IIF(Tipos='6',RGB(255,0,0),RGB(0,0,0)))"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroProdutos - Filtra cursor de produtos pelo grupo selecionado
    * Equivalente ao Page2.Activate do original (SET KEY TO Grupos+Contas+Linhas)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarFiltroProdutos()
        LOCAL loc_lSucesso, loc_cGrupos, loc_cContas, loc_cLinhas
        loc_lSucesso = .F.
        TRY
            SELECT (THIS.this_cCursorGrupos)
            loc_cGrupos = Grupos
            loc_cContas = Contas
            loc_cLinhas = Linhas

            SELECT (THIS.this_cCursorProdutos)
            SET ORDER TO Visualizar
            SET KEY TO loc_cGrupos + loc_cContas + loc_cLinhas
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparFiltroProdutos - Remove filtro SET KEY TO do cursor de produtos
    * Equivalente ao Page2.Deactivate do original
    *--------------------------------------------------------------------------
    PROCEDURE LimparFiltroProdutos()
        LOCAL loc_oErro
        TRY
            SELECT (THIS.this_cCursorProdutos)
            SET KEY TO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Configura cursor de dados para o relatorio
    * par_cAliasCursor: alias do cursor preenchido pelo form pai
    * par_cTipo: "ANALITICO" (produtos/csTempoCp) ou "SINTETICO" (grupos/csTempoGr)
    *
    * Equivalente ao Init original que recebia poForm e setava DataSession.
    * Permite ao form pai injetar dinamicamente os cursors a usar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor, par_cTipo)
        LOCAL loc_lSucesso, loc_cTipo
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o existe: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            loc_cTipo = UPPER(ALLTRIM(NVL(par_cTipo, "SINTETICO")))
            IF loc_cTipo == "ANALITICO"
                THIS.this_cCursorProdutos = par_cAliasCursor
                THIS.this_nOpcao = 1
            ELSE
                THIS.this_cCursorGrupos = par_cAliasCursor
                THIS.this_nOpcao = 2
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Inser" + CHR(231) + CHR(245) + "es em tabelas de movimento s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Atualiza" + CHR(231) + CHR(245) + "es de registros s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do cursor ativo para fins de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorGrupos)
                SELECT (THIS.this_cCursorGrupos)
                IF !EOF() AND TYPE(THIS.this_cCursorGrupos + ".Grupos") == "C"
                    loc_cChave = ALLTRIM(EVALUATE(THIS.this_cCursorGrupos + ".Grupos"))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emiss" + CHR(227) + "o de relat" + CHR(243) + "rio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTipoRelatorio, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .F.
            ENDIF

            loc_cTipoRelatorio = IIF(THIS.this_nOpcao = 1, "Analitico", "Sintetico")
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigReEqT") + ", " + ;
                EscaparSQL(LEFT(NVL(par_cOperacao, "RELATORIO"), 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.ObterChavePrimaria() + "|" + loc_cTipoRelatorio, 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


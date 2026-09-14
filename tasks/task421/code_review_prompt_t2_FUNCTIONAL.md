# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1523 linhas total):

*-- Linhas 3 a 280:
3: * Origem: SIGCDFOP.SCX (task421)
4: * Herda de: FormBase
5: * Tipo: OPERACIONAL (form filho/modal - gerencia fornecedores em SigPrFnc)
6: *       Aberto pelo form pai com: CREATEOBJECT("FormFop", oFormPai, nDataSes, cEscolha, cProduto)
7: *       DataSession=1: operacoes via FopBO que acessa SQL Server diretamente
8: *==============================================================================
9: 
10: DEFINE CLASS FormFop AS FormBase
11: 
12:     Width        = 1000
13:     Height       = 600
14:     AutoCenter   = .T.
15:     TitleBar     = 0
16:     ShowWindow   = 1
17:     WindowType   = 1
18:     ControlBox   = .F.
19:     MaxButton    = .F.
20:     MinButton    = .F.
21:     Movable      = .F.
22:     BorderStyle  = 2
23:     ClipControls = .F.
24:     ShowTips     = .T.
25:     DataSession  = 1
26:     Caption      = "Fornecedores do Produto"
27: 
28:     *-- Referencia ao form pai
29:     this_oParentForm  = .NULL.
30: 
31:     *-- Modo herdado do form pai ("INSERIR", "ALTERAR" ou "VISUALIZAR")
32:     this_cPcEscolha   = ""
33:     this_lModoEdicao  = .F.
34: 
35:     *-- Produto em edicao
36:     this_cCpros       = ""
37:     this_cDpros       = ""
38: 
39:     *-- Flags de controle (espelham houveincl/houveexcl do legado)
40:     this_lHouveIncl   = .F.
41:     this_lHouveExcl   = .F.
42: 
43:     *==========================================================================
44:     * Init - Recebe parametros do form pai e prepara estado inicial
45:     * par_oParentForm : referencia ao form pai (FormProduto ou similar)
46:     * par_nDataSes    : DataSession do pai (nao usado na nova arq - DataSession=1)
47:     * par_cEscolha    : modo de operacao ("INSERIR", "ALTERAR", "VISUALIZAR")
48:     * par_cProduto    : codigo do produto (char) - SigCdPro.cPros
49:     *==========================================================================
50:     PROCEDURE Init()
51:         LPARAMETERS par_oParentForm, par_nDataSes, par_cEscolha, par_cProduto
52: 
53:         LOCAL loc_oErro
54:         TRY
55:             IF VARTYPE(par_oParentForm) = "O"
56:                 THIS.this_oParentForm = par_oParentForm
57:             ENDIF
58: 
59:             THIS.this_cPcEscolha  = IIF(TYPE("par_cEscolha")  = "C", UPPER(ALLTRIM(par_cEscolha)), "VISUALIZAR")
60:             THIS.this_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
61:             THIS.this_cCpros      = IIF(TYPE("par_cProduto") = "C", ALLTRIM(par_cProduto), "")
62:         CATCH TO loc_oErro
63:             MsgErro(loc_oErro.Message + CHR(13) + ;
64:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
65:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormFop.Init")
66:         ENDTRY
67: 
68:         RETURN DODEFAULT()
69:     ENDPROC
70: 
71:     *==========================================================================
72:     * InicializarForm - Cria estrutura visual, instancia BO e carrega dados
73:     *==========================================================================
74:     PROTECTED PROCEDURE InicializarForm()
75:         LOCAL loc_lSucesso, loc_oErro, loc_nRet, loc_cSQL
76:         loc_lSucesso = .F.
77: 
78:         TRY
79:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
80:             SET DATE TO BRITISH
81:             SET CENTURY ON
82: 
83:             *-- Instanciar BO
84:             THIS.this_oBusinessObject = CREATEOBJECT("FopBO")
85:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
86: 
87:                 *-- Obter descricao do produto para o caption
88:                 IF !EMPTY(THIS.this_cCpros)
89:                     loc_cSQL = "SELECT ISNULL(Dpros, '') AS Dpros " + ;
90:                                "FROM SigCdPro " + ;
91:                                "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
92:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crFopProdDesc")
93:                     IF loc_nRet > 0 AND !EOF("crFopProdDesc")
94:                         THIS.this_cDpros = ALLTRIM(NVL(crFopProdDesc.Dpros, ""))
95:                     ENDIF
96:                     IF USED("crFopProdDesc")
97:                         USE IN crFopProdDesc
98:                     ENDIF
99: 
100:                     THIS.Caption = "Fornecedores do Produto : " + THIS.this_cCpros + "-" + THIS.this_cDpros
101:                 ENDIF
102: 
103:                 *-- Estrutura visual base (Fase 3) via orquestrador
104:                 THIS.ConfigurarPageFrame()
105: 
106:                 *-- Sincronizar caption nos labels
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
108:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
109: 
110:                 *-- Vincular eventos dos botoes
111:                 BINDEVENT(THIS.cmd_4c_Inserir,  "Click",     THIS, "CmdInserirClick")
112:                 BINDEVENT(THIS.cmd_4c_Excluir,  "Click",     THIS, "CmdExcluirClick")
113:                 BINDEVENT(THIS.cmd_4c_Repetir,  "Click",     THIS, "CmdRepetirClick")
114:                 BINDEVENT(THIS.cmd_4c_Encerrar, "Click",     THIS, "CmdEncerrarClick")
115:                 BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress",  THIS, "TxtQtdeKeyPress")
116:                 BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress", THIS, "TxtQtdeLostFocus")
117: 
118:                 *-- Vincular eventos de lookup nas colunas editaveis do grid
119:                 IF THIS.this_lModoEdicao
120:                     BINDEVENT(THIS.grd_4c_Dados.Column1.Text1,  "KeyPress", THIS, "GrdCol1KeyPress")
121:                     BINDEVENT(THIS.grd_4c_Dados.Column2.Text1,  "KeyPress", THIS, "GrdCol2KeyPress")
122:                     BINDEVENT(THIS.grd_4c_Dados.Column4.Text1,  "KeyPress", THIS, "GrdCol4KeyPress")
123:                     BINDEVENT(THIS.grd_4c_Dados.Column8.Text1,  "KeyPress", THIS, "GrdCol8KeyPress")
124:                     BINDEVENT(THIS.grd_4c_Dados.Column9.Text1,  "KeyPress", THIS, "GrdCol9KeyPress")
125:                     BINDEVENT(THIS.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GrdCol10KeyPress")
126:                 ENDIF
127: 
128:                 *-- Carregar fornecedores do produto e vincular ao grid
129:                 IF !EMPTY(THIS.this_cCpros)
130:                     THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
131:                     IF USED("crSigPrFnc")
132:                         THIS.grd_4c_Dados.ColumnCount  = 10
133:                         THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
134:                         THIS.grd_4c_Dados.Refresh()
135:                     ENDIF
136:                 ENDIF
137: 
138:                 THIS.TornarControlesVisiveis(THIS)
139:                 THIS.Visible  = .T.
140:                 loc_lSucesso  = .T.
141:             ELSE
142:                 MsgErro("Falha ao criar FopBO.", "Erro em InicializarForm")
143:             ENDIF
144:         CATCH TO loc_oErro
145:             MsgErro(loc_oErro.Message + CHR(13) + ;
146:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
147:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
148:         ENDTRY
149: 
150:         RETURN loc_lSucesso
151:     ENDPROC
152: 
153:     *==========================================================================
154:     * ConfigurarPageFrame - Orquestrador de montagem visual
155:     * SIGCDFOP legado (SCX, Width=1075) eh Form PLANO sem PageFrame ??? layout
156:     * flat (cabecalho + botoes no topo + grid + area de repeticao). PILAR 1 (UX
157:     * pixel-perfect) exige manter esse layout ao inves de introduzir abas
158:     * artificialmente. Esta rotina preserva o papel arquitetural de
159:     * "ConfigurarPageFrame" como ponto de entrada da montagem visual, delegando
160:     * para os helpers dedicados (cabecalho, botoes; grid e area repetir vem em
161:     * fases posteriores).
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarPageFrame()
164:         THIS.ConfigurarCabecalho()
165:         THIS.ConfigurarBotoes()
166:         THIS.ConfigurarGrid()
167:         THIS.ConfigurarAreaRepetir()
168:     ENDPROC
169: 
170:     *==========================================================================
171:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
172:     * Original: cntSombra Top=0, Width=1104, Height=80, BackColor=100,100,100
173:     * Novo: proporcional a 1000px, mesmas alturas e estilos
174:     *==========================================================================
175:     PROTECTED PROCEDURE ConfigurarCabecalho()
176:         LOCAL loc_oErro
177:         TRY
178:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
179:             WITH THIS.cnt_4c_Cabecalho
180:                 .Top         = 0
181:                 .Left        = 0
182:                 .Width       = THIS.Width
183:                 .Height      = 80
184:                 .BackStyle   = 1
185:                 .BackColor   = RGB(100, 100, 100)
186:                 .BorderWidth = 0
187:                 .Visible     = .T.
188:             ENDWITH
189: 
190:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
191:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
192:                 .FontBold      = .T.
193:                 .FontName      = "Tahoma"
194:                 .FontSize      = 18
195:                 .FontUnderline = .F.
196:                 .WordWrap      = .T.
197:                 .Alignment     = 0
198:                 .BackStyle     = 0
199:                 .AutoSize      = .F.
200:                 .Caption       = THIS.Caption
201:                 .Height        = 40
202:                 .Left          = 10
203:                 .Top           = 25
204:                 .Width         = 660
205:                 .ForeColor     = RGB(0, 0, 0)
206:                 .Visible       = .T.
207:             ENDWITH
208: 
209:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
210:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
211:                 .FontBold      = .T.
212:                 .FontName      = "Tahoma"
213:                 .FontSize      = 18
214:                 .WordWrap      = .T.
215:                 .Alignment     = 0
216:                 .BackStyle     = 0
217:                 .AutoSize      = .F.
218:                 .Caption       = THIS.Caption
219:                 .Height        = 46
220:                 .Left          = 10
221:                 .Top           = 24
222:                 .Width         = 660
223:                 .ForeColor     = RGB(255, 255, 255)
224:                 .ToolTipText   = "T" + CHR(237) + "tulo"
225:                 .Visible       = .T.
226:             ENDWITH
227:         CATCH TO loc_oErro
228:             MsgErro(loc_oErro.Message + CHR(13) + ;
229:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
230:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
231:         ENDTRY
232:     ENDPROC
233: 
234:     *==========================================================================
235:     * ConfigurarBotoes - Cria cmd_4c_Repetir, Inserir, Excluir, Encerrar
236:     * Original (1075px): Repetir=770, Inserir=846, Excluir=922, Sair=998
237:     * Escalado (1000px): Repetir=680, Inserir=760, Excluir=840, Encerrar=920
238:     * Todos ficam dentro do cnt_4c_Cabecalho (Top=3, sobrepostos)
239:     *==========================================================================
240:     PROTECTED PROCEDURE ConfigurarBotoes()
241:         LOCAL loc_lVis, loc_oErro
242:         loc_lVis = THIS.this_lModoEdicao
243: 
244:         TRY
245:             *-- cmd_4c_Repetir (original cmdRepetir, Left=770->680)
246:             THIS.AddObject("cmd_4c_Repetir", "CommandButton")
247:             WITH THIS.cmd_4c_Repetir
248:                 .Top             = 3
249:                 .Left            = 680
250:                 .Width           = 75
251:                 .Height          = 75
252:                 .Caption         = "Repetir"
253:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
254:                 .ToolTipText     = "Repetir Fornecedor"
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8
259:                 .ForeColor       = RGB(90, 90, 90)
260:                 .BackColor       = RGB(255, 255, 255)
261:                 .Themes          = .T.
262:                 .SpecialEffect   = 0
263:                 .PicturePosition = 13
264:                 .MousePointer    = 15
265:                 .WordWrap        = .T.
266:                 .AutoSize        = .F.
267:                 .Visible         = loc_lVis
268:                 .Enabled         = loc_lVis
269:             ENDWITH
270: 
271:             *-- ShpRepetir: shape decorativo ao redor do botao Repetir
272:             THIS.AddObject("shp_4c_ShpRepetir", "Shape")
273:             WITH THIS.shp_4c_ShpRepetir
274:                 .Top         = 1
275:                 .Left        = 677
276:                 .Width       = 81
277:                 .Height      = 80
278:                 .BackStyle   = 0
279:                 .BorderStyle = 0
280:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 375 a 493:
375:         CATCH TO loc_oErro
376:             MsgErro(loc_oErro.Message + CHR(13) + ;
377:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
378:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
379:         ENDTRY
380:     ENDPROC
381: 
382:     *==========================================================================
383:     * TornarControlesVisiveis - Recursivamente torna controles visiveis
384:     * EXCECAO: shp_4c_ShpRepetir e cmd_4c_Repetir controlados por this_lModoEdicao
385:     *==========================================================================
386:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
387:         LOCAL loc_i, loc_oControl
388: 
389:         FOR loc_i = 1 TO par_oContainer.ControlCount
390:             loc_oControl = par_oContainer.Controls(loc_i)
391:             IF VARTYPE(loc_oControl) = "O"
392:                 *-- Controles cuja visibilidade depende do modo (nao alterar aqui)
393:                 IF INLIST(UPPER(loc_oControl.Name), ;
394:                           "CMD_4C_REPETIR", ;
395:                           "SHP_4C_SHPREPETIR", ;
396:                           "CMD_4C_INSERIR", ;
397:                           "CMD_4C_EXCLUIR", ;
398:                           "LBL_4C_LBLQTDE", ;
399:                           "TXT_4C_QTDE", ;
400:                           "SHP_4C_SHPQTDE", ;
401:                           "CNT_4C_CABECALHO")
402:                     LOOP
403:                 ENDIF
404: 
405:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
406:                     loc_oControl.Visible = .T.
407:                 ENDIF
408: 
409:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
410:                     THIS.TornarControlesVisiveis(loc_oControl)
411:                 ENDIF
412:             ENDIF
413:         ENDFOR
414:     ENDPROC
415: 
416:     *==========================================================================
417:     * Destroy - Libera recursos e restaura menu do sistema
418:     *==========================================================================
419:     PROCEDURE Destroy()
420:         IF USED("crSigPrFnc")
421:             USE IN crSigPrFnc
422:         ENDIF
423:         IF USED("crFopProdDesc")
424:             USE IN crFopProdDesc
425:         ENDIF
426:         IF USED("crFopBuscaCli")
427:             USE IN crFopBuscaCli
428:         ENDIF
429:         IF USED("crFopBuscaMoe")
430:             USE IN crFopBuscaMoe
431:         ENDIF
432:         IF USED("crFopBuscaCol")
433:             USE IN crFopBuscaCol
434:         ENDIF
435:         IF USED("crFopBuscaCor")
436:             USE IN crFopBuscaCor
437:         ENDIF
438:         IF USED("crFopBuscaTam")
439:             USE IN crFopBuscaTam
440:         ENDIF
441:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
442:             THIS.this_oBusinessObject.LiberarCursores()
443:             THIS.this_oBusinessObject = .NULL.
444:         ENDIF
445:         DODEFAULT()
446:     ENDPROC
447: 
448:     *==========================================================================
449:     * ConfigurarGrid - Cria grd_4c_Dados com 10 colunas (replica SIGCDFOP.Grade)
450:     * Original: Top=129, Left=8, Width=1060, Height=462 (form 1075px)
451:     * Novo: Width=960 proporcional ao form 1000px
452:     *==========================================================================
453:     PROTECTED PROCEDURE ConfigurarGrid()
454:         LOCAL loc_oGrid, loc_oErro
455: 
456:         TRY
457:             THIS.AddObject("grd_4c_Dados", "Grid")
458:             loc_oGrid = THIS.grd_4c_Dados
459:             WITH loc_oGrid
460:                 .Top                = 129
461:                 .Left               = 8
462:                 .Width              = 960
463:                 .Height             = 462
464:                 .ColumnCount        = 10
465:                 .FontName           = "Tahoma"
466:                 .FontSize           = 8
467:                 .RowHeight          = 17
468:                 .DeleteMark         = .F.
469:                 .RecordMark         = .F.
470:                 .ScrollBars         = 2
471:                 .AllowHeaderSizing  = .F.
472:                 .AllowRowSizing     = .F.
473:                 .AllowCellSelection = .T.
474:                 .GridLineColor      = RGB(238, 238, 238)
475:                 .HighlightBackColor = RGB(255, 255, 255)
476:                 .HighlightForeColor = RGB(15, 41, 104)
477:                 .HighlightStyle     = 2
478:             ENDWITH
479: 
480:             *-- Column1: iFors (Codigo Fornecedor) ColumnOrder=1
481:             WITH loc_oGrid.Column1
482:                 .Width         = 108
483:                 .ColumnOrder   = 1
484:                 .Movable       = .F.
485:                 .Resizable     = .F.
486:                 .FontName      = "Tahoma"
487:                 .FontSize      = 8
488:                 .ControlSource = "crSigPrFnc.iFors"
489:                 .ReadOnly      = !THIS.this_lModoEdicao
490:             ENDWITH
491:             WITH loc_oGrid.Column1.Header1
492:                 .Caption   = "C" + CHR(243) + "digo"
493:                 .Alignment = 2

*-- Linhas 724 a 1523:
724:         CATCH TO loc_oErro
725:             MsgErro(loc_oErro.Message + CHR(13) + ;
726:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
727:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
728:         ENDTRY
729:     ENDPROC
730: 
731:     *==========================================================================
732:     * ConfigurarAreaRepetir - Cria controles da area de repeticao de linhas
733:     * Original: shpQtde(Top=90,L=588,W=123,H=30), lblQtde, getQtde
734:     * Todos iniciam Visible=.F. e sao mostrados por CmdRepetirClick
735:     *==========================================================================
736:     PROTECTED PROCEDURE ConfigurarAreaRepetir()
737:         LOCAL loc_oErro
738: 
739:         TRY
740:             THIS.AddObject("shp_4c_ShpQtde", "Shape")
741:             WITH THIS.shp_4c_ShpQtde
742:                 .Top         = 90
743:                 .Left        = 588
744:                 .Width       = 123
745:                 .Height      = 30
746:                 .BackStyle   = 0
747:                 .BorderStyle = 0
748:                 .Visible     = .F.
749:             ENDWITH
750: 
751:             THIS.AddObject("lbl_4c_LblQtde", "Label")
752:             WITH THIS.lbl_4c_LblQtde
753:                 .Top       = 97
754:                 .Left      = 595
755:                 .Width     = 73
756:                 .Height    = 16
757:                 .Caption   = "Quantidade :"
758:                 .FontName  = "Tahoma"
759:                 .FontSize  = 8
760:                 .BackStyle = 0
761:                 .ForeColor = RGB(90, 90, 90)
762:                 .Visible   = .F.
763:             ENDWITH
764: 
765:             THIS.AddObject("txt_4c_Qtde", "TextBox")
766:             WITH THIS.txt_4c_Qtde
767:                 .Top           = 94
768:                 .Left          = 669
769:                 .Width         = 36
770:                 .Height        = 23
771:                 .Value         = 0
772:                 .FontName      = "Tahoma"
773:                 .FontSize      = 8
774:                 .InputMask     = "999"
775:                 .SpecialEffect = 1
776:                 .Visible       = .F.
777:             ENDWITH
778:         CATCH TO loc_oErro
779:             MsgErro(loc_oErro.Message + CHR(13) + ;
780:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
781:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAreaRepetir")
782:         ENDTRY
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * CmdInserirClick - Adiciona linha vazia ao cursor e posiciona no grid
787:     *==========================================================================
788:     PROCEDURE CmdInserirClick()
789:         LOCAL loc_oErro
790: 
791:         TRY
792:             IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cCpros)
793:                 THIS.grd_4c_Dados.Refresh()
794:                 IF USED("crSigPrFnc")
795:                     SELECT crSigPrFnc
796:                     GO BOTTOM
797:                 ENDIF
798:                 THIS.grd_4c_Dados.Column1.SetFocus()
799:             ENDIF
800:         CATCH TO loc_oErro
801:             MsgErro(loc_oErro.Message + CHR(13) + ;
802:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
803:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
804:         ENDTRY
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * CmdExcluirClick - Marca linha corrente para exclusao
809:     *==========================================================================
810:     PROCEDURE CmdExcluirClick()
811:         LOCAL loc_oErro
812: 
813:         TRY
814:             IF THIS.this_oBusinessObject.ExcluirLinha()
815:                 THIS.grd_4c_Dados.Refresh()
816:             ENDIF
817:         CATCH TO loc_oErro
818:             MsgErro(loc_oErro.Message + CHR(13) + ;
819:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
820:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
821:         ENDTRY
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * CmdRepetirClick - Exibe area de quantidade para duplicar linha corrente
826:     *==========================================================================
827:     PROCEDURE CmdRepetirClick()
828:         LOCAL loc_oErro
829: 
830:         TRY
831:             IF !USED("crSigPrFnc")
832:                 RETURN
833:             ENDIF
834:             SELECT crSigPrFnc
835:             IF EOF() OR EMPTY(iFors)
836:                 MsgAviso("Selecione um registro para ser repetido.", ;
837:                          "Aten" + CHR(231) + CHR(227) + "o")
838:                 RETURN
839:             ENDIF
840:             THIS.lbl_4c_LblQtde.Visible = .T.
841:             THIS.txt_4c_Qtde.Visible    = .T.
842:             THIS.shp_4c_ShpQtde.Visible = .T.
843:             THIS.txt_4c_Qtde.Value      = 0
844:             THIS.txt_4c_Qtde.SetFocus()
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message + CHR(13) + ;
847:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
848:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRepetirClick")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * CmdEncerrarClick - Valida, salva (se modo edicao) e fecha o form
854:     *==========================================================================
855:     PROCEDURE CmdEncerrarClick()
856:         LOCAL loc_lPode, loc_oErro
857: 
858:         TRY
859:             loc_lPode = .T.
860: 
861:             IF THIS.this_lModoEdicao
862:                 loc_lPode = THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
863:                 IF loc_lPode
864:                     loc_lPode = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
865:                 ENDIF
866:             ENDIF
867: 
868:             IF loc_lPode
869:                 IF VARTYPE(THIS.this_oParentForm) = "O"
870:                     THIS.this_oParentForm.Enabled = .T.
871:                 ENDIF
872:                 THIS.Release()
873:             ENDIF
874:         CATCH TO loc_oErro
875:             MsgErro(loc_oErro.Message + CHR(13) + ;
876:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
877:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
878:         ENDTRY
879:     ENDPROC
880: 
881:     *==========================================================================
882:     * TxtQtdeKeyPress - Processa ENTER/TAB no campo quantidade de repeticoes
883:     *==========================================================================
884:     PROCEDURE TxtQtdeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
885: 
886:         LOCAL loc_nVezes, loc_oErro
887: 
888:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
889:             RETURN
890:         ENDIF
891: 
892:         TRY
893:             loc_nVezes = NVL(THIS.txt_4c_Qtde.Value, 0)
894: 
895:             IF loc_nVezes > 0
896:                 THIS.this_oBusinessObject.RepetirLinha(loc_nVezes)
897:                 THIS.grd_4c_Dados.Refresh()
898:             ENDIF
899: 
900:             THIS.lbl_4c_LblQtde.Visible = .F.
901:             THIS.shp_4c_ShpQtde.Visible  = .F.
902:             THIS.txt_4c_Qtde.Visible     = .F.
903: 
904:             IF USED("crSigPrFnc")
905:                 SELECT crSigPrFnc
906:             ENDIF
907:             THIS.grd_4c_Dados.Column1.SetFocus()
908:         CATCH TO loc_oErro
909:             MsgErro(loc_oErro.Message + CHR(13) + ;
910:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
911:                     "Procedure: " + loc_oErro.Procedure, "Erro em TxtQtdeKeyPress")
912:         ENDTRY
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * TxtQtdeLostFocus - Oculta area de repeticao ao perder foco
917:     *==========================================================================
918:     PROCEDURE TxtQtdeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
919:         LOCAL loc_oErro
920: 
921:         TRY
922:             THIS.lbl_4c_LblQtde.Visible = .F.
923:             THIS.shp_4c_ShpQtde.Visible  = .F.
924:             THIS.txt_4c_Qtde.Visible     = .F.
925:             IF USED("crSigPrFnc")
926:                 SELECT crSigPrFnc
927:                 THIS.grd_4c_Dados.Column1.SetFocus()
928:             ENDIF
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message, "Erro em TxtQtdeLostFocus")
931:         ENDTRY
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * GrdCol1KeyPress - Lookup Column1 (iFors) em SigCdCli por codigo
936:     *==========================================================================
937:     PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
938: 
939:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
940:             RETURN
941:         ENDIF
942:         IF !THIS.this_lModoEdicao
943:             RETURN
944:         ENDIF
945:         THIS.AbrirBuscaCli("iclis", ;
946:             ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
947:     ENDPROC
948: 
949:     *==========================================================================
950:     * GrdCol2KeyPress - Lookup Column2 (rClis) em SigCdCli por razao social
951:     *==========================================================================
952:     PROCEDURE GrdCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
953: 
954:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
955:             RETURN
956:         ENDIF
957:         IF !THIS.this_lModoEdicao
958:             RETURN
959:         ENDIF
960:         THIS.AbrirBuscaCli("rclis", ;
961:             ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, "")))
962:     ENDPROC
963: 
964:     *==========================================================================
965:     * GrdCol4KeyPress - Lookup Column4 (MoeVs) em SigCdMoe
966:     *==========================================================================
967:     PROCEDURE GrdCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
968: 
969:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
970:             RETURN
971:         ENDIF
972:         IF !THIS.this_lModoEdicao
973:             RETURN
974:         ENDIF
975:         THIS.AbrirBuscaMoe(ALLTRIM(NVL(THIS.grd_4c_Dados.Column4.Text1.Value, "")))
976:     ENDPROC
977: 
978:     *==========================================================================
979:     * GrdCol8KeyPress - Lookup Column8 (Colecoes) em SigCdCol
980:     *==========================================================================
981:     PROCEDURE GrdCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
982: 
983:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
984:             RETURN
985:         ENDIF
986:         IF !THIS.this_lModoEdicao
987:             RETURN
988:         ENDIF
989:         THIS.AbrirBuscaCol(ALLTRIM(NVL(THIS.grd_4c_Dados.Column8.Text1.Value, "")))
990:     ENDPROC
991: 
992:     *==========================================================================
993:     * GrdCol9KeyPress - Lookup Column9 (CodCors) em SigCdCor
994:     *==========================================================================
995:     PROCEDURE GrdCol9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
996: 
997:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
998:             RETURN
999:         ENDIF
1000:         IF !THIS.this_lModoEdicao
1001:             RETURN
1002:         ENDIF
1003:         THIS.AbrirBuscaCor(ALLTRIM(NVL(THIS.grd_4c_Dados.Column9.Text1.Value, "")))
1004:     ENDPROC
1005: 
1006:     *==========================================================================
1007:     * GrdCol10KeyPress - Lookup Column10 (CodTams) em SigCdTam
1008:     *==========================================================================
1009:     PROCEDURE GrdCol10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1010: 
1011:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1012:             RETURN
1013:         ENDIF
1014:         IF !THIS.this_lModoEdicao
1015:             RETURN
1016:         ENDIF
1017:         THIS.AbrirBuscaTam(ALLTRIM(NVL(THIS.grd_4c_Dados.Column10.Text1.Value, "")))
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * AbrirBuscaCli - Abre FormBuscaAuxiliar para SigCdCli
1022:     * par_cCampo: "iclis" (busca por codigo) ou "rclis" (busca por nome)
1023:     * Ao selecionar, preenche iFors E rClis no cursor corrente
1024:     *==========================================================================
1025:     PROTECTED PROCEDURE AbrirBuscaCli(par_cCampo, par_cValor)
1026:         LOCAL loc_oFba, loc_cIfors, loc_cRClis, loc_oErro
1027: 
1028:         TRY
1029:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1030:                 "SigCdCli", "crFopBuscaCli", par_cCampo, par_cValor, ;
1031:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .F., .T., "")
1032: 
1033:             IF VARTYPE(loc_oFba) = "O"
1034:                 loc_oFba.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1035:                 loc_oFba.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
1036:                 loc_oFba.Show()
1037:             ENDIF
1038: 
1039:             IF USED("crFopBuscaCli")
1040:                 IF !EOF("crFopBuscaCli")
1041:                     loc_cIfors = ALLTRIM(NVL(crFopBuscaCli.iclis, ""))
1042:                     loc_cRClis = ALLTRIM(NVL(crFopBuscaCli.rclis, ""))
1043:                     USE IN crFopBuscaCli
1044:                     SELECT crSigPrFnc
1045:                     REPLACE iFors WITH loc_cIfors, rClis WITH loc_cRClis
1046:                     THIS.grd_4c_Dados.Refresh()
1047:                 ELSE
1048:                     USE IN crFopBuscaCli
1049:                 ENDIF
1050:             ENDIF
1051:         CATCH TO loc_oErro
1052:             MsgErro(loc_oErro.Message + CHR(13) + ;
1053:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1054:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCli")
1055:             IF USED("crFopBuscaCli")
1056:                 USE IN crFopBuscaCli
1057:             ENDIF
1058:         ENDTRY
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * AbrirBuscaMoe - Abre FormBuscaAuxiliar para SigCdMoe (Moeda)
1063:     *==========================================================================
1064:     PROTECTED PROCEDURE AbrirBuscaMoe(par_cValor)
1065:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1066: 
1067:         TRY
1068:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1069:                 "SigCdMoe", "crFopBuscaMoe", "CMoes", par_cValor, ;
1070:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
1071: 
1072:             IF VARTYPE(loc_oFba) = "O"
1073:                 loc_oFba.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1074:                 loc_oFba.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1075:                 loc_oFba.Show()
1076:             ENDIF
1077: 
1078:             IF USED("crFopBuscaMoe")
1079:                 IF !EOF("crFopBuscaMoe")
1080:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaMoe.CMoes, ""))
1081:                     USE IN crFopBuscaMoe
1082:                     SELECT crSigPrFnc
1083:                     REPLACE MoeVs WITH loc_cCodigo
1084:                     THIS.grd_4c_Dados.Refresh()
1085:                 ELSE
1086:                     USE IN crFopBuscaMoe
1087:                 ENDIF
1088:             ENDIF
1089:         CATCH TO loc_oErro
1090:             MsgErro(loc_oErro.Message + CHR(13) + ;
1091:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1092:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaMoe")
1093:             IF USED("crFopBuscaMoe")
1094:                 USE IN crFopBuscaMoe
1095:             ENDIF
1096:         ENDTRY
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * AbrirBuscaCol - Abre FormBuscaAuxiliar para SigCdCol (Colecoes/Grupo Venda)
1101:     *==========================================================================
1102:     PROTECTED PROCEDURE AbrirBuscaCol(par_cValor)
1103:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1104: 
1105:         TRY
1106:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1107:                 "SigCdCol", "crFopBuscaCol", "Colecoes", par_cValor, ;
1108:                 "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o", ;
1109:                 .F., .T., "")
1110: 
1111:             IF VARTYPE(loc_oFba) = "O"
1112:                 loc_oFba.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1113:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1114:                 loc_oFba.Show()
1115:             ENDIF
1116: 
1117:             IF USED("crFopBuscaCol")
1118:                 IF !EOF("crFopBuscaCol")
1119:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCol.Colecoes, ""))
1120:                     USE IN crFopBuscaCol
1121:                     SELECT crSigPrFnc
1122:                     REPLACE Colecoes WITH loc_cCodigo
1123:                     THIS.grd_4c_Dados.Refresh()
1124:                 ELSE
1125:                     USE IN crFopBuscaCol
1126:                 ENDIF
1127:             ENDIF
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + CHR(13) + ;
1130:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1131:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCol")
1132:             IF USED("crFopBuscaCol")
1133:                 USE IN crFopBuscaCol
1134:             ENDIF
1135:         ENDTRY
1136:     ENDPROC
1137: 
1138:     *==========================================================================
1139:     * AbrirBuscaCor - Abre FormBuscaAuxiliar para SigCdCor (Cor)
1140:     *==========================================================================
1141:     PROTECTED PROCEDURE AbrirBuscaCor(par_cValor)
1142:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1143: 
1144:         TRY
1145:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1146:                 "SigCdCor", "crFopBuscaCor", "Cods", par_cValor, ;
1147:                 "Sele" + CHR(231) + CHR(227) + "o de Cor", .F., .T., "")
1148: 
1149:             IF VARTYPE(loc_oFba) = "O"
1150:                 loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1151:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1152:                 loc_oFba.Show()
1153:             ENDIF
1154: 
1155:             IF USED("crFopBuscaCor")
1156:                 IF !EOF("crFopBuscaCor")
1157:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCor.Cods, ""))
1158:                     USE IN crFopBuscaCor
1159:                     SELECT crSigPrFnc
1160:                     REPLACE CodCors WITH loc_cCodigo
1161:                     THIS.grd_4c_Dados.Refresh()
1162:                 ELSE
1163:                     USE IN crFopBuscaCor
1164:                 ENDIF
1165:             ENDIF
1166:         CATCH TO loc_oErro
1167:             MsgErro(loc_oErro.Message + CHR(13) + ;
1168:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1169:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCor")
1170:             IF USED("crFopBuscaCor")
1171:                 USE IN crFopBuscaCor
1172:             ENDIF
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * ConfigurarPaginaLista - Wrapper para o padrao CRUD (delegador)
1178:     * SIGCDFOP eh form OPERACIONAL modal (sem PageFrame), com layout FLAT:
1179:     * cabecalho + botoes no topo + grid + area de repeticao. Nao ha Page1/Page2.
1180:     * Mantido para conformidade com o pipeline de migracao (Fase 4 valida
1181:     * presenca dos nomes ConfigurarPaginaLista/AlternarPagina). Delega para os
1182:     * helpers reais que ja fazem o trabalho: ConfigurarGrid (grid 10 colunas) +
1183:     * ConfigurarBotoes (Repetir/Inserir/Excluir/Encerrar do cnt_4c_Cabecalho).
1184:     *==========================================================================
1185:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1186:         THIS.ConfigurarGrid()
1187:         THIS.ConfigurarBotoes()
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * AlternarPagina - No-op para conformidade com o pipeline CRUD
1192:     * Este form nao tem PageFrame (layout FLAT), portanto nao ha paginas para
1193:     * alternar. Metodo existe apenas para satisfazer o validador da Fase 4 do
1194:     * pipeline. Qualquer chamada eh silenciosamente ignorada.
1195:     *==========================================================================
1196:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1197:         RETURN
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * ConfigurarPaginaDados - Wrapper de conformidade com o pipeline (Fase 5)
1202:     * SIGCDFOP eh form OPERACIONAL modal com layout FLAT (sem PageFrame).
1203:     * Nao existe "Page2 de Dados" separada — a entrada de dados acontece
1204:     * diretamente nas celulas do grid (grd_4c_Dados, 10 colunas, configurado
1205:     * em ConfigurarGrid na Fase 4). Este metodo existe apenas para satisfazer
1206:     * o validador de fase do pipeline multi-fase. Nenhuma acao necessaria.
1207:     *==========================================================================
1208:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1209:         RETURN
1210:     ENDPROC
1211: 
1212:     *==========================================================================
1213:     * AbrirBuscaTam - Abre FormBuscaAuxiliar para SigCdTam (Tamanho)
1214:     *==========================================================================
1215:     PROTECTED PROCEDURE AbrirBuscaTam(par_cValor)
1216:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1217: 
1218:         TRY
1219:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1220:                 "SigCdTam", "crFopBuscaTam", "Cods", par_cValor, ;
1221:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .F., .T., "")
1222: 
1223:             IF VARTYPE(loc_oFba) = "O"
1224:                 loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1225:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1226:                 loc_oFba.Show()
1227:             ENDIF
1228: 
1229:             IF USED("crFopBuscaTam")
1230:                 IF !EOF("crFopBuscaTam")
1231:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaTam.Cods, ""))
1232:                     USE IN crFopBuscaTam
1233:                     SELECT crSigPrFnc
1234:                     REPLACE CodTams WITH loc_cCodigo
1235:                     THIS.grd_4c_Dados.Refresh()
1236:                 ELSE
1237:                     USE IN crFopBuscaTam
1238:                 ENDIF
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message + CHR(13) + ;
1242:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1243:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaTam")
1244:             IF USED("crFopBuscaTam")
1245:                 USE IN crFopBuscaTam
1246:             ENDIF
1247:         ENDTRY
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * BtnIncluirClick - Delega para o handler nativo do form OPERACIONAL
1252:     * SIGCDFOP legado tem cmdInserir (nao cmdIncluir do CRUD). O handler
1253:     * CmdInserirClick ja realiza a acao correta: insere linha vazia no cursor
1254:     * crSigPrFnc via BO e reposiciona o grid. Este wrapper existe para
1255:     * conformidade com o validador da Fase 7 do pipeline multi-fase que
1256:     * verifica presenca do nome canonico Btn*Click.
1257:     *==========================================================================
1258:     PROCEDURE BtnIncluirClick()
1259:         THIS.CmdInserirClick()
1260:     ENDPROC
1261: 
1262:     *==========================================================================
1263:     * BtnAlterarClick - Posiciona edicao na 1a coluna do grid (equivalente a
1264:     * "Alterar" em form OPERACIONAL: os dados sao editados diretamente nas
1265:     * celulas). Sem paginas Lista/Dados, "Alterar" resume-se a garantir foco
1266:     * na linha corrente para permitir digitacao.
1267:     *==========================================================================
1268:     PROCEDURE BtnAlterarClick()
1269:         LOCAL loc_oErro
1270: 
1271:         TRY
1272:             IF !THIS.this_lModoEdicao
1273:                 MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
1274:                          "Reabra a partir do form pai em modo Incluir ou Alterar.", ;
1275:                          "Aten" + CHR(231) + CHR(227) + "o")
1276:                 RETURN
1277:             ENDIF
1278:             IF USED("crSigPrFnc") AND !EOF("crSigPrFnc")
1279:                 THIS.grd_4c_Dados.Column1.SetFocus()
1280:             ENDIF
1281:         CATCH TO loc_oErro
1282:             MsgErro(loc_oErro.Message + CHR(13) + ;
1283:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1284:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
1285:         ENDTRY
1286:     ENDPROC
1287: 
1288:     *==========================================================================
1289:     * BtnVisualizarClick - Recarrega e refresca a lista de fornecedores
1290:     * Em form OPERACIONAL sem Page1/Page2, "Visualizar" equivale a atualizar
1291:     * o grid a partir do banco (util para refletir mudancas concorrentes).
1292:     *==========================================================================
1293:     PROCEDURE BtnVisualizarClick()
1294:         LOCAL loc_oErro
1295: 
1296:         TRY
1297:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1298:                 RETURN
1299:             ENDIF
1300:             IF EMPTY(THIS.this_cCpros)
1301:                 RETURN
1302:             ENDIF
1303:             THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
1304:             IF USED("crSigPrFnc")
1305:                 THIS.grd_4c_Dados.ColumnCount  = 10
1306:                 THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
1307:                 THIS.grd_4c_Dados.Refresh()
1308:             ENDIF
1309:         CATCH TO loc_oErro
1310:             MsgErro(loc_oErro.Message + CHR(13) + ;
1311:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1312:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
1313:         ENDTRY
1314:     ENDPROC
1315: 
1316:     *==========================================================================
1317:     * BtnExcluirClick - Delega para o handler nativo do form OPERACIONAL
1318:     * SIGCDFOP legado tem cmdExcluir. O handler CmdExcluirClick ja marca a
1319:     * linha corrente do cursor crSigPrFnc para exclusao via BO. Wrapper de
1320:     * conformidade com o validador da Fase 7 do pipeline.
1321:     *==========================================================================
1322:     PROCEDURE BtnExcluirClick()
1323:         THIS.CmdExcluirClick()
1324:     ENDPROC
1325: 
1326:     *==========================================================================
1327:     * BtnBuscarClick - Recarrega lista de fornecedores do produto
1328:     * Em form OPERACIONAL sem campo de filtro separado, "Buscar" equivale
1329:     * a recarregar os dados atuais do SQL Server para o grid.
1330:     *==========================================================================
1331:     PROCEDURE BtnBuscarClick()
1332:         THIS.CarregarLista()
1333:     ENDPROC
1334: 
1335:     *==========================================================================
1336:     * BtnEncerrarClick - Delega para o handler nativo do form OPERACIONAL
1337:     * CmdEncerrarClick ja faz validacao, salva (se modo edicao) e fecha.
1338:     *==========================================================================
1339:     PROCEDURE BtnEncerrarClick()
1340:         THIS.CmdEncerrarClick()
1341:     ENDPROC
1342: 
1343:     *==========================================================================
1344:     * BtnSalvarClick - Valida e persiste alteracoes sem fechar o form
1345:     * Permite que o usuario salve o progresso e continue editando.
1346:     * Apos salvar com sucesso, recarrega a lista do banco para refletir o
1347:     * estado real (inclusive chaves geradas pelo SQL Server).
1348:     *==========================================================================
1349:     PROCEDURE BtnSalvarClick()
1350:         LOCAL loc_oErro
1351: 
1352:         TRY
1353:             IF !THIS.this_lModoEdicao
1354:                 MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
1355:                          "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel salvar.", ;
1356:                          "Aten" + CHR(231) + CHR(227) + "o")
1357:                 RETURN
1358:             ENDIF
1359: 
1360:             IF THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
1361:                 IF THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
1362:                     MsgInfo("Fornecedores salvos com sucesso.")
1363:                     THIS.CarregarLista()
1364:                 ENDIF
1365:             ENDIF
1366:         CATCH TO loc_oErro
1367:             MsgErro(loc_oErro.Message + CHR(13) + ;
1368:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1369:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1370:         ENDTRY
1371:     ENDPROC
1372: 
1373:     *==========================================================================
1374:     * BtnCancelarClick - Desfaz alteracoes nao salvas e fecha o form
1375:     * Reverte o buffer do cursor (TABLEREVERT) e libera o form sem validar,
1376:     * replicando o comportamento de "Cancelar" em forms de edicao.
1377:     *==========================================================================
1378:     PROCEDURE BtnCancelarClick()
1379:         LOCAL loc_oErro
1380: 
1381:         TRY
1382:             IF THIS.this_lModoEdicao AND USED("crSigPrFnc")
1383:                 TABLEREVERT(.T., "crSigPrFnc")
1384:             ENDIF
1385: 
1386:             IF VARTYPE(THIS.this_oParentForm) = "O"
1387:                 THIS.this_oParentForm.Enabled = .T.
1388:             ENDIF
1389:             THIS.Release()
1390:         CATCH TO loc_oErro
1391:             MsgErro(loc_oErro.Message + CHR(13) + ;
1392:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1393:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
1394:         ENDTRY
1395:     ENDPROC
1396: 
1397:     *==========================================================================
1398:     * CarregarLista - Recarrega fornecedores do produto no grid
1399:     * Chama BuscarPorProduto no BO e revincula o RecordSource do grid.
1400:     * Equivalente ao InicializarForm de carga de dados (sem recriar controles).
1401:     *==========================================================================
1402:     PROCEDURE CarregarLista()
1403:         LOCAL loc_oErro
1404: 
1405:         TRY
1406:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1407:                 RETURN
1408:             ENDIF
1409:             IF EMPTY(THIS.this_cCpros)
1410:                 RETURN
1411:             ENDIF
1412:             THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
1413:             IF USED("crSigPrFnc")
1414:                 THIS.grd_4c_Dados.ColumnCount  = 10
1415:                 THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
1416:                 THIS.grd_4c_Dados.Refresh()
1417:             ENDIF
1418:         CATCH TO loc_oErro
1419:             MsgErro(loc_oErro.Message + CHR(13) + ;
1420:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1421:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1422:         ENDTRY
1423:     ENDPROC
1424: 
1425:     *==========================================================================
1426:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme o modo
1427:     * Inserir/Excluir/Repetir ficam visiveis apenas em modo edicao.
1428:     * Encerrar sempre visivel.
1429:     *==========================================================================
1430:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1431:         LOCAL loc_oErro
1432: 
1433:         TRY
1434:             THIS.cmd_4c_Inserir.Visible      = THIS.this_lModoEdicao
1435:             THIS.cmd_4c_Inserir.Enabled      = THIS.this_lModoEdicao
1436:             THIS.cmd_4c_Excluir.Visible      = THIS.this_lModoEdicao
1437:             THIS.cmd_4c_Excluir.Enabled      = THIS.this_lModoEdicao
1438:             THIS.cmd_4c_Repetir.Visible      = THIS.this_lModoEdicao
1439:             THIS.cmd_4c_Repetir.Enabled      = THIS.this_lModoEdicao
1440:             THIS.shp_4c_ShpRepetir.Visible   = THIS.this_lModoEdicao
1441:             THIS.cmd_4c_Encerrar.Visible     = .T.
1442:             THIS.cmd_4c_Encerrar.Enabled     = .T.
1443:         CATCH TO loc_oErro
1444:             MsgErro(loc_oErro.Message + CHR(13) + ;
1445:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1446:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
1447:         ENDTRY
1448:     ENDPROC
1449: 
1450:     *==========================================================================
1451:     * HabilitarCampos - Ajusta ReadOnly das 10 colunas do grid conforme modo
1452:     * par_lHabilitar = .T. -> colunas editaveis; .F. -> somente leitura
1453:     *==========================================================================
1454:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1455:         LOCAL loc_i, loc_oGrid, loc_oErro
1456: 
1457:         TRY
1458:             loc_oGrid = THIS.grd_4c_Dados
1459:             FOR loc_i = 1 TO loc_oGrid.ColumnCount
1460:                 loc_oGrid.Columns(loc_i).ReadOnly = !par_lHabilitar
1461:             ENDFOR
1462:         CATCH TO loc_oErro
1463:             MsgErro(loc_oErro.Message + CHR(13) + ;
1464:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1465:                     "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *==========================================================================
1470:     * LimparCampos - Zera o cursor crSigPrFnc e refresca o grid
1471:     * Usado para limpar a grade quando o form precisa ser resetado.
1472:     *==========================================================================
1473:     PROTECTED PROCEDURE LimparCampos()
1474:         LOCAL loc_oErro
1475: 
1476:         TRY
1477:             IF USED("crSigPrFnc")
1478:                 SELECT crSigPrFnc
1479:                 ZAP
1480:                 THIS.grd_4c_Dados.Refresh()
1481:             ENDIF
1482:             THIS.this_lHouveIncl = .F.
1483:             THIS.this_lHouveExcl = .F.
1484:         CATCH TO loc_oErro
1485:             MsgErro(loc_oErro.Message + CHR(13) + ;
1486:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1487:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1488:         ENDTRY
1489:     ENDPROC
1490: 
1491:     *==========================================================================
1492:     * FormParaBO - Sincroniza a linha corrente do cursor com as propriedades do BO
1493:     * Neste form OPERACIONAL, a edicao ocorre diretamente nas celulas do grid
1494:     * (cursor crSigPrFnc). FormParaBO carrega a linha corrente no BO via
1495:     * CarregarDoCursor para que o BO possa usar as propriedades this_* em
1496:     * operacoes avulsas (ex: validacoes ou auditorias de linha individual).
1497:     *==========================================================================
1498:     PROTECTED PROCEDURE FormParaBO()
1499:         LOCAL loc_oErro
1500: 
1501:         TRY
1502:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1503:                USED("crSigPrFnc") AND !EOF("crSigPrFnc")
1504:                 THIS.this_oBusinessObject.CarregarDoCursor("crSigPrFnc")
1505:             ENDIF
1506:         CATCH TO loc_oErro
1507:             MsgErro(loc_oErro.Message + CHR(13) + ;
1508:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1509:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1510:         ENDTRY
1511:     ENDPROC
1512: 
1513:     *==========================================================================
1514:     * BOParaForm - Sincroniza propriedades do BO para controles do form
1515:     * Neste form OPERACIONAL, nao ha campos individuais de formulario: os dados
1516:     * ficam diretamente no cursor crSigPrFnc e sao exibidos pelo grid.
1517:     * O metodo existe para conformidade com o padrao CRUD do pipeline.
1518:     *==========================================================================
1519:     PROTECTED PROCEDURE BOParaForm()
1520:         RETURN
1521:     ENDPROC
1522: 
1523: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FopBO.prg):
*==============================================================================
* FopBO.prg - Business Object para Fornecedores do Produto
* Tabela   : SigPrFnc
* Herda de : BusinessBase
* Migrado de: SIGCDFOP.SCX (task421)
*==============================================================================
DEFINE CLASS FopBO AS BusinessBase

    *---------------------------------------------------------------------------
    *-- Campos da tabela SigPrFnc (schema.sql)
    *---------------------------------------------------------------------------
    this_cCidChaves  = ""   && PK char(20)
    this_cCpros      = ""   && Produto char(14) - FK SigCdPro
    this_cIfors      = ""   && Fornecedor char(10) - FK SigCdCli
    this_cRClis      = ""   && Razao Social (JOIN SigCdCli - exibicao, nao persistido)
    this_cReffs      = ""   && Referencia do Fornecedor char(40)
    this_cMoevs      = ""   && Moeda char(3) - FK SigCdMoe
    this_nPvens      = 0    && Preco de Custo numeric(10,2)
    this_dDtvalid    = {}   && Validade datetime NULL
    this_nSituas     = 0    && Situacao numeric(1,0) - checkbox (Situas)
    this_cColecoes   = ""   && Grupo Venda char(10) - FK SigCdCol
    this_cCodcors    = ""   && Cor char(4) - FK SigCdCor
    this_cCodtams    = ""   && Tamanho char(4) - FK SigCdTam

    *---------------------------------------------------------------------------
    *-- Estado operacional do formulario
    *---------------------------------------------------------------------------
    this_cCprosAtivo = ""   && Codigo do produto em edicao
    this_lHouveIncl  = .F.  && Houve inclusoes nesta sessao
    this_lHouveExcl  = .F.  && Houve exclusoes nesta sessao
    this_cModoAtual  = ""   && Modo atual: INSERIR / ALTERAR / VISUALIZAR

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrFnc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *===========================================================================
    PROCEDURE BuscarPorProduto(par_cCpros)
    *===========================================================================
    * Carrega fornecedores do produto do SQL Server para cursor crSigPrFnc.
    * O cursor inclui coluna lNovo (.F. para registros ja existentes no DB).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cCPros, loc_cIfors, loc_cRClis
        LOCAL loc_cReffs, loc_cMoevs, loc_nPvens, loc_dDtvalid
        LOCAL loc_nSituas, loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.cPros, a.iFors, " + ;
                       "ISNULL(b.rClis, '') AS rClis, " + ;
                       "a.Reffs, a.MoeVs, a.PVens, a.DtValid, " + ;
                       "a.Situas, a.Colecoes, a.CodCors, a.CodTams " + ;
                       "FROM SigPrFnc a " + ;
                       "LEFT JOIN SigCdCli b ON b.iClis = a.iFors " + ;
                       "WHERE a.cPros = " + EscaparSQL(par_cCpros)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrFncTemp")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar fornecedores do produto.", "Erro em BuscarPorProduto")
            ELSE
                IF USED("crSigPrFnc")
                    TABLEREVERT(.T., "crSigPrFnc")
                    USE IN crSigPrFnc
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigPrFnc ;
                    (CidChaves C(20) NULL, cPros C(14) NULL, iFors C(10) NULL, ;
                     rClis C(50) NULL, Reffs C(40) NULL, MoeVs C(3) NULL, ;
                     PVens N(10,2) NULL, DtValid T NULL, Situas N(1,0) NULL, ;
                     Colecoes C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     lNovo L)
                SET NULL OFF

                SELECT crSigPrFncTemp
                GO TOP
                SCAN
                    loc_cCidChaves = NVL(crSigPrFncTemp.CidChaves, "")
                    loc_cCPros     = NVL(crSigPrFncTemp.cPros, "")
                    loc_cIfors     = NVL(crSigPrFncTemp.iFors, "")
                    loc_cRClis     = NVL(crSigPrFncTemp.rClis, "")
                    loc_cReffs     = NVL(crSigPrFncTemp.Reffs, "")
                    loc_cMoevs     = NVL(crSigPrFncTemp.MoeVs, "")
                    loc_nPvens     = NVL(crSigPrFncTemp.PVens, 0)
                    loc_dDtvalid   = crSigPrFncTemp.DtValid
                    loc_nSituas    = NVL(crSigPrFncTemp.Situas, 0)
                    loc_cColecoes  = NVL(crSigPrFncTemp.Colecoes, "")
                    loc_cCodcors   = NVL(crSigPrFncTemp.CodCors, "")
                    loc_cCodtams   = NVL(crSigPrFncTemp.CodTams, "")

                    SELECT crSigPrFnc
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cCidChaves, ;
                            cPros     WITH loc_cCPros, ;
                            iFors     WITH loc_cIfors, ;
                            rClis     WITH loc_cRClis, ;
                            Reffs     WITH loc_cReffs, ;
                            MoeVs     WITH loc_cMoevs, ;
                            PVens     WITH loc_nPvens, ;
                            DtValid   WITH loc_dDtvalid, ;
                            Situas    WITH loc_nSituas, ;
                            Colecoes  WITH loc_cColecoes, ;
                            CodCors   WITH loc_cCodcors, ;
                            CodTams   WITH loc_cCodtams, ;
                            lNovo     WITH .F.

                    SELECT crSigPrFncTemp
                ENDSCAN

                USE IN crSigPrFncTemp

                SELECT crSigPrFnc
                GO TOP

                THIS.this_cCprosAtivo = par_cCpros
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE InserirLinha(par_cCpros)
    *===========================================================================
    * Adiciona linha em branco ao cursor crSigPrFnc (ainda nao persiste no DB).
    * Replica cmdInserir.Click: localiza linha vazia existente, senao append.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cChave, loc_lAchou

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                MsgErro("Cursor crSigPrFnc n" + CHR(227) + "o inicializado.", "Erro em InserirLinha")
            ELSE
                SELECT crSigPrFnc
                SET EXACT ON
                LOCATE FOR ALLTRIM(cPros) == ALLTRIM(par_cCpros) AND EMPTY(iFors) AND !DELETED()
                loc_lAchou = !EOF()

                IF !loc_lAchou
                    loc_cChave = THIS.GerarCidChaves()
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cChave, ;
                            cPros     WITH par_cCpros, ;
                            iFors     WITH "", ;
                            rClis     WITH "", ;
                            Reffs     WITH "", ;
                            MoeVs     WITH "", ;
                            PVens     WITH 0, ;
                            Situas    WITH 0, ;
                            Colecoes  WITH "", ;
                            CodCors   WITH "", ;
                            CodTams   WITH "", ;
                            lNovo     WITH .T.
                    THIS.this_lHouveIncl = .T.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ExcluirLinha()
    *===========================================================================
    * Marca a linha corrente do cursor para exclusao (replica cmdExcluir.Click).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF !EOF() AND ALLTRIM(cPros) == ALLTRIM(THIS.this_cCprosAtivo) AND !DELETED()
                    DELETE
                    SKIP
                    SKIP - 1
                    THIS.this_lHouveExcl = .T.
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE RepetirLinha(par_nVezes)
    *===========================================================================
    * Duplica a linha corrente do cursor N vezes (replica getQtde.Valid).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_i, loc_cChave
        LOCAL loc_cIfors, loc_cRClis, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams, loc_cCpros

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF EMPTY(iFors)
                    MsgAviso("Selecione um registro para ser repetido.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cRClis    = ALLTRIM(rClis)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cMoevs    = ALLTRIM(MoeVs)
                    loc_nPvens    = NVL(PVens, 0)
                    loc_dDtvalid  = DtValid
                    loc_nSituas   = NVL(Situas, 0)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_cCodcors  = ALLTRIM(CodCors)
                    loc_cCodtams  = ALLTRIM(CodTams)
                    loc_cCpros    = ALLTRIM(cPros)

                    FOR loc_i = 1 TO par_nVezes
                        loc_cChave = THIS.GerarCidChaves()
                        SELECT crSigPrFnc
                        APPEND BLANK
                        REPLACE CidChaves WITH loc_cChave, ;
                                cPros     WITH loc_cCpros, ;
                                iFors     WITH loc_cIfors, ;
                                rClis     WITH loc_cRClis, ;
                                Reffs     WITH loc_cReffs, ;
                                MoeVs     WITH loc_cMoevs, ;
                                PVens     WITH loc_nPvens, ;
                                DtValid   WITH loc_dDtvalid, ;
                                Situas    WITH loc_nSituas, ;
                                Colecoes  WITH loc_cColecoes, ;
                                CodCors   WITH loc_cCodcors, ;
                                CodTams   WITH loc_cCodtams, ;
                                lNovo     WITH .T.
                    ENDFOR

                    THIS.this_lHouveIncl = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RepetirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ValidarCursor(par_cModo)
    *===========================================================================
    * Valida todas as linhas do cursor antes de salvar (replica cmdSair.Click).
    * Retorna .T. se valido, .F. se invalido (com MsgAviso ao usuario).
    *---------------------------------------------------------------------------
        LOCAL loc_lValido
        LOCAL loc_cIfors, loc_cReffs, loc_cColecoes, loc_nPvens
        LOCAL loc_nDupli

        loc_lValido = .T.

        TRY
            IF USED("crSigPrFnc") AND INLIST(UPPER(par_cModo), "INSERIR", "ALTERAR")
                SELECT crSigPrFnc
                GO TOP
                SCAN
                    IF DELETED()
                        LOOP
                    ENDIF

                    IF EMPTY(iFors)
                        MsgAviso("Fornecedor deve ser informado!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(Reffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(MoeVs)
                        MsgAviso("A Moeda deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_nPvens    = NVL(PVens, 0)

                    SELECT COUNT(*) AS nDupli ;
                        FROM crSigPrFnc a ;
                        WHERE ALLTRIM(a.iFors)    == m.loc_cIfors ;
                          AND ALLTRIM(a.Reffs)    == m.loc_cReffs ;
                          AND ALLTRIM(a.Colecoes) == m.loc_cColecoes ;
                          AND NVL(a.PVens, 0)      = m.loc_nPvens ;
                          AND !DELETED() ;
                        INTO CURSOR crAuxDupli READWRITE

                    SELECT crAuxDupli
                    loc_nDupli = NVL(crAuxDupli.nDupli, 0)
                    USE IN crAuxDupli

                    IF loc_nDupli > 1
                        MsgAviso("Fornecedor j" + CHR(225) + " informado para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    SELECT crSigPrFnc
                ENDSCAN

                SELECT crSigPrFnc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarCursor")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *===========================================================================
    PROCEDURE SalvarAlteracoes(par_cCpros)
    *===========================================================================
    * Persiste as alteracoes do cursor crSigPrFnc no SQL Server.
    * Estrategia: DELETE todos existentes para o produto + INSERT os nao-deletados.
    * Isso replica o comportamento do fSqlConector.ReQuery do legado.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cIfors, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "DELETE FROM SigPrFnc WHERE cPros = " + EscaparSQL(par_cCpros)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir registros anteriores de SigPrFnc.", ;
                            "Erro em SalvarAlteracoes")
                ELSE
                    SELECT crSigPrFnc
                    GO TOP
                    SCAN
                        IF DELETED()
                            LOOP
                        ENDIF

                        loc_cCidChaves = ALLTRIM(CidChaves)
                        loc_cIfors     = ALLTRIM(iFors)
                        loc_cReffs     = ALLTRIM(Reffs)
                        loc_cMoevs     = ALLTRIM(MoeVs)
                        loc_nPvens     = NVL(PVens, 0)
                        loc_dDtvalid   = DtValid
                        loc_nSituas    = NVL(Situas, 0)
                        loc_cColecoes  = ALLTRIM(Colecoes)
                        loc_cCodcors   = ALLTRIM(CodCors)
                        loc_cCodtams   = ALLTRIM(CodTams)

                        loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                   "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                   "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCpros) + ", " + ;
                                   EscaparSQL(loc_cIfors) + ", " + ;
                                   EscaparSQL(loc_cReffs) + ", " + ;
                                   EscaparSQL(loc_cMoevs) + ", " + ;
                                   FormatarNumeroSQL(loc_nPvens, 2) + ", " + ;
                                   IIF(ISNULL(loc_dDtvalid) OR EMPTY(loc_dDtvalid), ;
                                       "NULL", FormatarDataSQL(loc_dDtvalid)) + ", " + ;
                                   FormatarNumeroSQL(loc_nSituas, 0) + ", " + ;
                                   EscaparSQL(loc_cColecoes) + ", " + ;
                                   EscaparSQL(loc_cCodcors) + ", " + ;
                                   EscaparSQL(loc_cCodtams) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet < 0
                            MsgErro("Erro ao inserir fornecedor " + loc_cIfors + " em SigPrFnc.", ;
                                    "Erro em SalvarAlteracoes")
                            EXIT
                        ENDIF

                        SELECT crSigPrFnc
                    ENDSCAN

                    IF loc_nRet >= 0
                        SELECT crSigPrFnc
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarAlteracoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
    *===========================================================================
    * Mapeia campos do cursor para propriedades do BO.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_cCpros     = TratarNulo(cPros, "C")
                THIS.this_cIfors     = TratarNulo(iFors, "C")
                THIS.this_cRClis     = TratarNulo(rClis, "C")
                THIS.this_cReffs     = TratarNulo(Reffs, "C")
                THIS.this_cMoevs     = TratarNulo(MoeVs, "C")
                THIS.this_nPvens     = NVL(PVens, 0)
                THIS.this_dDtvalid   = NVL(DtValid, {})
                THIS.this_nSituas    = NVL(Situas, 0)
                THIS.this_cColecoes  = TratarNulo(Colecoes, "C")
                THIS.this_cCodcors   = TratarNulo(CodCors, "C")
                THIS.this_cCodtams   = TratarNulo(CodTams, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED FUNCTION GerarCidChaves()
    *===========================================================================
    * Gera chave unica de 20 chars para CidChaves (replica fUniqueIds do legado).
    * Usa NEWID() do SQL Server (GUID sem hifens, truncado em 20 chars).
    *---------------------------------------------------------------------------
        LOCAL loc_cChave

        loc_cChave = ""

        TRY
            IF SQLEXEC(gnConnHandle, ;
                       "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS nk", ;
                       "crChaveTemp") > 0
                SELECT crChaveTemp
                loc_cChave = ALLTRIM(TRANSFORM(crChaveTemp.nk))
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            * Fallback local se SQL Server nao disponivel
        ENDTRY

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(STRTRAN(STRTRAN(STRTRAN(TRANSFORM(DATETIME()), "/", ""), " ", ""), ":", "") + ;
                              SYS(3) + SYS(3), 20)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    PROCEDURE Inserir()
    *===========================================================================
    * Insere UM registro individual de SigPrFnc usando as propriedades this_*.
    * Chamado internamente por SalvarAlteracoes ou standalone via CarregarDoCursor.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cChave

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCpros)
                MsgAviso("Produto n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
                            IF EMPTY(loc_cChave)
                                loc_cChave = THIS.GerarCidChaves()
                                THIS.this_cCidChaves = loc_cChave
                            ENDIF

                            loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                       "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                       "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                       "VALUES (" + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cIfors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cReffs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cMoevs)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nPvens, 2) + ", " + ;
                                       IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodcors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodtams)) + ")"

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao inserir fornecedor do produto no SQL Server.", ;
                                        "Erro em Inserir")
                            ELSE
                                THIS.RegistrarAuditoria("INCLUSAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE Atualizar()
    *===========================================================================
    * Atualiza UM registro individual de SigPrFnc pela chave primaria CidChaves.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada. N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                        "vel atualizar.", "Erro em Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cSQL = "UPDATE SigPrFnc SET " + ;
                                       "cPros = "    + EscaparSQL(ALLTRIM(THIS.this_cCpros))    + ", " + ;
                                       "iFors = "    + EscaparSQL(ALLTRIM(THIS.this_cIfors))    + ", " + ;
                                       "Reffs = "    + EscaparSQL(ALLTRIM(THIS.this_cReffs))    + ", " + ;
                                       "MoeVs = "    + EscaparSQL(ALLTRIM(THIS.this_cMoevs))    + ", " + ;
                                       "PVens = "    + FormatarNumeroSQL(THIS.this_nPvens, 2)   + ", " + ;
                                       "DtValid = "  + IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       "Situas = "   + FormatarNumeroSQL(THIS.this_nSituas, 0)  + ", " + ;
                                       "Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       "CodCors = "  + EscaparSQL(ALLTRIM(THIS.this_cCodcors))  + ", " + ;
                                       "CodTams = "  + EscaparSQL(ALLTRIM(THIS.this_cCodtams))  + " " + ;
                                       "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao atualizar fornecedor do produto no SQL Server.", ;
                                        "Erro em Atualizar")
                            ELSE
                                THIS.RegistrarAuditoria("ALTERACAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    * Executa DELETE de UM registro individual pela chave CidChaves.
    * Chamado por BusinessBase.Excluir() (PUBLIC).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada.", "Erro em ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("EXCLUSAO")

                loc_cSQL = "DELETE FROM SigPrFnc WHERE CidChaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir fornecedor do produto no SQL Server.", ;
                            "Erro em ExecutarExclusao")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE LiberarCursores()
    *===========================================================================
    * Libera todos os cursores do BO. Chamar no Destroy do Form.
    *---------------------------------------------------------------------------
        TRY
            IF USED("crSigPrFnc")
                TABLEREVERT(.T., "crSigPrFnc")
                USE IN crSigPrFnc
            ENDIF
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF
            IF USED("crAuxDupli")
                USE IN crAuxDupli
            ENDIF
            IF USED("crChaveTemp")
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LiberarCursores")
        ENDTRY
    ENDPROC

ENDDEFINE


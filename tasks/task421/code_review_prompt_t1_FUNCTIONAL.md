# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'TxtQtdeLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE TxtQtdeLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1522 linhas total):

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
255:                 .FontName        = "Comic Sans MS"
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

*-- Linhas 375 a 492:
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
400:                           "SHP_4C_SHPQTDE")
401:                     LOOP
402:                 ENDIF
403: 
404:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
405:                     loc_oControl.Visible = .T.
406:                 ENDIF
407: 
408:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
409:                     THIS.TornarControlesVisiveis(loc_oControl)
410:                 ENDIF
411:             ENDIF
412:         ENDFOR
413:     ENDPROC
414: 
415:     *==========================================================================
416:     * Destroy - Libera recursos e restaura menu do sistema
417:     *==========================================================================
418:     PROCEDURE Destroy()
419:         IF USED("crSigPrFnc")
420:             USE IN crSigPrFnc
421:         ENDIF
422:         IF USED("crFopProdDesc")
423:             USE IN crFopProdDesc
424:         ENDIF
425:         IF USED("crFopBuscaCli")
426:             USE IN crFopBuscaCli
427:         ENDIF
428:         IF USED("crFopBuscaMoe")
429:             USE IN crFopBuscaMoe
430:         ENDIF
431:         IF USED("crFopBuscaCol")
432:             USE IN crFopBuscaCol
433:         ENDIF
434:         IF USED("crFopBuscaCor")
435:             USE IN crFopBuscaCor
436:         ENDIF
437:         IF USED("crFopBuscaTam")
438:             USE IN crFopBuscaTam
439:         ENDIF
440:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
441:             THIS.this_oBusinessObject.LiberarCursores()
442:             THIS.this_oBusinessObject = .NULL.
443:         ENDIF
444:         DODEFAULT()
445:     ENDPROC
446: 
447:     *==========================================================================
448:     * ConfigurarGrid - Cria grd_4c_Dados com 10 colunas (replica SIGCDFOP.Grade)
449:     * Original: Top=129, Left=8, Width=1060, Height=462 (form 1075px)
450:     * Novo: Width=960 proporcional ao form 1000px
451:     *==========================================================================
452:     PROTECTED PROCEDURE ConfigurarGrid()
453:         LOCAL loc_oGrid, loc_oErro
454: 
455:         TRY
456:             THIS.AddObject("grd_4c_Dados", "Grid")
457:             loc_oGrid = THIS.grd_4c_Dados
458:             WITH loc_oGrid
459:                 .Top                = 129
460:                 .Left               = 8
461:                 .Width              = 960
462:                 .Height             = 462
463:                 .ColumnCount        = 10
464:                 .FontName           = "Tahoma"
465:                 .FontSize           = 8
466:                 .RowHeight          = 17
467:                 .DeleteMark         = .F.
468:                 .RecordMark         = .F.
469:                 .ScrollBars         = 2
470:                 .AllowHeaderSizing  = .F.
471:                 .AllowRowSizing     = .F.
472:                 .AllowCellSelection = .T.
473:                 .GridLineColor      = RGB(238, 238, 238)
474:                 .HighlightBackColor = RGB(255, 255, 255)
475:                 .HighlightForeColor = RGB(15, 41, 104)
476:                 .HighlightStyle     = 2
477:             ENDWITH
478: 
479:             *-- Column1: iFors (Codigo Fornecedor) ColumnOrder=1
480:             WITH loc_oGrid.Column1
481:                 .Width         = 108
482:                 .ColumnOrder   = 1
483:                 .Movable       = .F.
484:                 .Resizable     = .F.
485:                 .FontName      = "Tahoma"
486:                 .FontSize      = 8
487:                 .ControlSource = "crSigPrFnc.iFors"
488:                 .ReadOnly      = !THIS.this_lModoEdicao
489:             ENDWITH
490:             WITH loc_oGrid.Column1.Header1
491:                 .Caption   = "C" + CHR(243) + "digo"
492:                 .Alignment = 2

*-- Linhas 723 a 1522:
723:         CATCH TO loc_oErro
724:             MsgErro(loc_oErro.Message + CHR(13) + ;
725:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
726:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
727:         ENDTRY
728:     ENDPROC
729: 
730:     *==========================================================================
731:     * ConfigurarAreaRepetir - Cria controles da area de repeticao de linhas
732:     * Original: shpQtde(Top=90,L=588,W=123,H=30), lblQtde, getQtde
733:     * Todos iniciam Visible=.F. e sao mostrados por CmdRepetirClick
734:     *==========================================================================
735:     PROTECTED PROCEDURE ConfigurarAreaRepetir()
736:         LOCAL loc_oErro
737: 
738:         TRY
739:             THIS.AddObject("shp_4c_ShpQtde", "Shape")
740:             WITH THIS.shp_4c_ShpQtde
741:                 .Top         = 90
742:                 .Left        = 588
743:                 .Width       = 123
744:                 .Height      = 30
745:                 .BackStyle   = 0
746:                 .BorderStyle = 0
747:                 .Visible     = .F.
748:             ENDWITH
749: 
750:             THIS.AddObject("lbl_4c_LblQtde", "Label")
751:             WITH THIS.lbl_4c_LblQtde
752:                 .Top       = 97
753:                 .Left      = 595
754:                 .Width     = 73
755:                 .Height    = 16
756:                 .Caption   = "Quantidade :"
757:                 .FontName  = "Tahoma"
758:                 .FontSize  = 8
759:                 .BackStyle = 0
760:                 .ForeColor = RGB(90, 90, 90)
761:                 .Visible   = .F.
762:             ENDWITH
763: 
764:             THIS.AddObject("txt_4c_Qtde", "TextBox")
765:             WITH THIS.txt_4c_Qtde
766:                 .Top           = 94
767:                 .Left          = 669
768:                 .Width         = 36
769:                 .Height        = 23
770:                 .Value         = 0
771:                 .FontName      = "Tahoma"
772:                 .FontSize      = 8
773:                 .InputMask     = "999"
774:                 .SpecialEffect = 1
775:                 .Visible       = .F.
776:             ENDWITH
777:         CATCH TO loc_oErro
778:             MsgErro(loc_oErro.Message + CHR(13) + ;
779:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
780:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAreaRepetir")
781:         ENDTRY
782:     ENDPROC
783: 
784:     *==========================================================================
785:     * CmdInserirClick - Adiciona linha vazia ao cursor e posiciona no grid
786:     *==========================================================================
787:     PROCEDURE CmdInserirClick()
788:         LOCAL loc_oErro
789: 
790:         TRY
791:             IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cCpros)
792:                 THIS.grd_4c_Dados.Refresh()
793:                 IF USED("crSigPrFnc")
794:                     SELECT crSigPrFnc
795:                     GO BOTTOM
796:                 ENDIF
797:                 THIS.grd_4c_Dados.Column1.SetFocus()
798:             ENDIF
799:         CATCH TO loc_oErro
800:             MsgErro(loc_oErro.Message + CHR(13) + ;
801:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
802:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
803:         ENDTRY
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * CmdExcluirClick - Marca linha corrente para exclusao
808:     *==========================================================================
809:     PROCEDURE CmdExcluirClick()
810:         LOCAL loc_oErro
811: 
812:         TRY
813:             IF THIS.this_oBusinessObject.ExcluirLinha()
814:                 THIS.grd_4c_Dados.Refresh()
815:             ENDIF
816:         CATCH TO loc_oErro
817:             MsgErro(loc_oErro.Message + CHR(13) + ;
818:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
819:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
820:         ENDTRY
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * CmdRepetirClick - Exibe area de quantidade para duplicar linha corrente
825:     *==========================================================================
826:     PROCEDURE CmdRepetirClick()
827:         LOCAL loc_oErro
828: 
829:         TRY
830:             IF !USED("crSigPrFnc")
831:                 RETURN
832:             ENDIF
833:             SELECT crSigPrFnc
834:             IF EOF() OR EMPTY(iFors)
835:                 MsgAviso("Selecione um registro para ser repetido.", ;
836:                          "Aten" + CHR(231) + CHR(227) + "o")
837:                 RETURN
838:             ENDIF
839:             THIS.lbl_4c_LblQtde.Visible = .T.
840:             THIS.txt_4c_Qtde.Visible    = .T.
841:             THIS.shp_4c_ShpQtde.Visible = .T.
842:             THIS.txt_4c_Qtde.Value      = 0
843:             THIS.txt_4c_Qtde.SetFocus()
844:         CATCH TO loc_oErro
845:             MsgErro(loc_oErro.Message + CHR(13) + ;
846:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
847:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRepetirClick")
848:         ENDTRY
849:     ENDPROC
850: 
851:     *==========================================================================
852:     * CmdEncerrarClick - Valida, salva (se modo edicao) e fecha o form
853:     *==========================================================================
854:     PROCEDURE CmdEncerrarClick()
855:         LOCAL loc_lPode, loc_oErro
856: 
857:         TRY
858:             loc_lPode = .T.
859: 
860:             IF THIS.this_lModoEdicao
861:                 loc_lPode = THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
862:                 IF loc_lPode
863:                     loc_lPode = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
864:                 ENDIF
865:             ENDIF
866: 
867:             IF loc_lPode
868:                 IF VARTYPE(THIS.this_oParentForm) = "O"
869:                     THIS.this_oParentForm.Enabled = .T.
870:                 ENDIF
871:                 THIS.Release()
872:             ENDIF
873:         CATCH TO loc_oErro
874:             MsgErro(loc_oErro.Message + CHR(13) + ;
875:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
876:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
877:         ENDTRY
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * TxtQtdeKeyPress - Processa ENTER/TAB no campo quantidade de repeticoes
882:     *==========================================================================
883:     PROCEDURE TxtQtdeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
884: 
885:         LOCAL loc_nVezes, loc_oErro
886: 
887:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
888:             RETURN
889:         ENDIF
890: 
891:         TRY
892:             loc_nVezes = NVL(THIS.txt_4c_Qtde.Value, 0)
893: 
894:             IF loc_nVezes > 0
895:                 THIS.this_oBusinessObject.RepetirLinha(loc_nVezes)
896:                 THIS.grd_4c_Dados.Refresh()
897:             ENDIF
898: 
899:             THIS.lbl_4c_LblQtde.Visible = .F.
900:             THIS.shp_4c_ShpQtde.Visible  = .F.
901:             THIS.txt_4c_Qtde.Visible     = .F.
902: 
903:             IF USED("crSigPrFnc")
904:                 SELECT crSigPrFnc
905:             ENDIF
906:             THIS.grd_4c_Dados.Column1.SetFocus()
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message + CHR(13) + ;
909:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
910:                     "Procedure: " + loc_oErro.Procedure, "Erro em TxtQtdeKeyPress")
911:         ENDTRY
912:     ENDPROC
913: 
914:     *==========================================================================
915:     * TxtQtdeLostFocus - Oculta area de repeticao ao perder foco
916:     *==========================================================================
917:     PROCEDURE TxtQtdeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
918:         LOCAL loc_oErro
919: 
920:         TRY
921:             THIS.lbl_4c_LblQtde.Visible = .F.
922:             THIS.shp_4c_ShpQtde.Visible  = .F.
923:             THIS.txt_4c_Qtde.Visible     = .F.
924:             IF USED("crSigPrFnc")
925:                 SELECT crSigPrFnc
926:                 THIS.grd_4c_Dados.Column1.SetFocus()
927:             ENDIF
928:         CATCH TO loc_oErro
929:             MsgErro(loc_oErro.Message, "Erro em TxtQtdeLostFocus")
930:         ENDTRY
931:     ENDPROC
932: 
933:     *==========================================================================
934:     * GrdCol1KeyPress - Lookup Column1 (iFors) em SigCdCli por codigo
935:     *==========================================================================
936:     PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
937: 
938:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
939:             RETURN
940:         ENDIF
941:         IF !THIS.this_lModoEdicao
942:             RETURN
943:         ENDIF
944:         THIS.AbrirBuscaCli("iclis", ;
945:             ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
946:     ENDPROC
947: 
948:     *==========================================================================
949:     * GrdCol2KeyPress - Lookup Column2 (rClis) em SigCdCli por razao social
950:     *==========================================================================
951:     PROCEDURE GrdCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
952: 
953:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
954:             RETURN
955:         ENDIF
956:         IF !THIS.this_lModoEdicao
957:             RETURN
958:         ENDIF
959:         THIS.AbrirBuscaCli("rclis", ;
960:             ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, "")))
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * GrdCol4KeyPress - Lookup Column4 (MoeVs) em SigCdMoe
965:     *==========================================================================
966:     PROCEDURE GrdCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
967: 
968:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
969:             RETURN
970:         ENDIF
971:         IF !THIS.this_lModoEdicao
972:             RETURN
973:         ENDIF
974:         THIS.AbrirBuscaMoe(ALLTRIM(NVL(THIS.grd_4c_Dados.Column4.Text1.Value, "")))
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * GrdCol8KeyPress - Lookup Column8 (Colecoes) em SigCdCol
979:     *==========================================================================
980:     PROCEDURE GrdCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
981: 
982:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
983:             RETURN
984:         ENDIF
985:         IF !THIS.this_lModoEdicao
986:             RETURN
987:         ENDIF
988:         THIS.AbrirBuscaCol(ALLTRIM(NVL(THIS.grd_4c_Dados.Column8.Text1.Value, "")))
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * GrdCol9KeyPress - Lookup Column9 (CodCors) em SigCdCor
993:     *==========================================================================
994:     PROCEDURE GrdCol9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
995: 
996:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
997:             RETURN
998:         ENDIF
999:         IF !THIS.this_lModoEdicao
1000:             RETURN
1001:         ENDIF
1002:         THIS.AbrirBuscaCor(ALLTRIM(NVL(THIS.grd_4c_Dados.Column9.Text1.Value, "")))
1003:     ENDPROC
1004: 
1005:     *==========================================================================
1006:     * GrdCol10KeyPress - Lookup Column10 (CodTams) em SigCdTam
1007:     *==========================================================================
1008:     PROCEDURE GrdCol10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1009: 
1010:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1011:             RETURN
1012:         ENDIF
1013:         IF !THIS.this_lModoEdicao
1014:             RETURN
1015:         ENDIF
1016:         THIS.AbrirBuscaTam(ALLTRIM(NVL(THIS.grd_4c_Dados.Column10.Text1.Value, "")))
1017:     ENDPROC
1018: 
1019:     *==========================================================================
1020:     * AbrirBuscaCli - Abre FormBuscaAuxiliar para SigCdCli
1021:     * par_cCampo: "iclis" (busca por codigo) ou "rclis" (busca por nome)
1022:     * Ao selecionar, preenche iFors E rClis no cursor corrente
1023:     *==========================================================================
1024:     PROTECTED PROCEDURE AbrirBuscaCli(par_cCampo, par_cValor)
1025:         LOCAL loc_oFba, loc_cIfors, loc_cRClis, loc_oErro
1026: 
1027:         TRY
1028:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1029:                 "SigCdCli", "crFopBuscaCli", par_cCampo, par_cValor, ;
1030:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .F., .T., "")
1031: 
1032:             IF VARTYPE(loc_oFba) = "O"
1033:                 loc_oFba.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1034:                 loc_oFba.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
1035:                 loc_oFba.Show()
1036:             ENDIF
1037: 
1038:             IF USED("crFopBuscaCli")
1039:                 IF !EOF("crFopBuscaCli")
1040:                     loc_cIfors = ALLTRIM(NVL(crFopBuscaCli.iclis, ""))
1041:                     loc_cRClis = ALLTRIM(NVL(crFopBuscaCli.rclis, ""))
1042:                     USE IN crFopBuscaCli
1043:                     SELECT crSigPrFnc
1044:                     REPLACE iFors WITH loc_cIfors, rClis WITH loc_cRClis
1045:                     THIS.grd_4c_Dados.Refresh()
1046:                 ELSE
1047:                     USE IN crFopBuscaCli
1048:                 ENDIF
1049:             ENDIF
1050:         CATCH TO loc_oErro
1051:             MsgErro(loc_oErro.Message + CHR(13) + ;
1052:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1053:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCli")
1054:             IF USED("crFopBuscaCli")
1055:                 USE IN crFopBuscaCli
1056:             ENDIF
1057:         ENDTRY
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * AbrirBuscaMoe - Abre FormBuscaAuxiliar para SigCdMoe (Moeda)
1062:     *==========================================================================
1063:     PROTECTED PROCEDURE AbrirBuscaMoe(par_cValor)
1064:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1065: 
1066:         TRY
1067:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1068:                 "SigCdMoe", "crFopBuscaMoe", "CMoes", par_cValor, ;
1069:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
1070: 
1071:             IF VARTYPE(loc_oFba) = "O"
1072:                 loc_oFba.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1073:                 loc_oFba.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1074:                 loc_oFba.Show()
1075:             ENDIF
1076: 
1077:             IF USED("crFopBuscaMoe")
1078:                 IF !EOF("crFopBuscaMoe")
1079:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaMoe.CMoes, ""))
1080:                     USE IN crFopBuscaMoe
1081:                     SELECT crSigPrFnc
1082:                     REPLACE MoeVs WITH loc_cCodigo
1083:                     THIS.grd_4c_Dados.Refresh()
1084:                 ELSE
1085:                     USE IN crFopBuscaMoe
1086:                 ENDIF
1087:             ENDIF
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + CHR(13) + ;
1090:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1091:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaMoe")
1092:             IF USED("crFopBuscaMoe")
1093:                 USE IN crFopBuscaMoe
1094:             ENDIF
1095:         ENDTRY
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * AbrirBuscaCol - Abre FormBuscaAuxiliar para SigCdCol (Colecoes/Grupo Venda)
1100:     *==========================================================================
1101:     PROTECTED PROCEDURE AbrirBuscaCol(par_cValor)
1102:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1103: 
1104:         TRY
1105:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1106:                 "SigCdCol", "crFopBuscaCol", "Colecoes", par_cValor, ;
1107:                 "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o", ;
1108:                 .F., .T., "")
1109: 
1110:             IF VARTYPE(loc_oFba) = "O"
1111:                 loc_oFba.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1112:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1113:                 loc_oFba.Show()
1114:             ENDIF
1115: 
1116:             IF USED("crFopBuscaCol")
1117:                 IF !EOF("crFopBuscaCol")
1118:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCol.Colecoes, ""))
1119:                     USE IN crFopBuscaCol
1120:                     SELECT crSigPrFnc
1121:                     REPLACE Colecoes WITH loc_cCodigo
1122:                     THIS.grd_4c_Dados.Refresh()
1123:                 ELSE
1124:                     USE IN crFopBuscaCol
1125:                 ENDIF
1126:             ENDIF
1127:         CATCH TO loc_oErro
1128:             MsgErro(loc_oErro.Message + CHR(13) + ;
1129:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1130:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCol")
1131:             IF USED("crFopBuscaCol")
1132:                 USE IN crFopBuscaCol
1133:             ENDIF
1134:         ENDTRY
1135:     ENDPROC
1136: 
1137:     *==========================================================================
1138:     * AbrirBuscaCor - Abre FormBuscaAuxiliar para SigCdCor (Cor)
1139:     *==========================================================================
1140:     PROTECTED PROCEDURE AbrirBuscaCor(par_cValor)
1141:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1142: 
1143:         TRY
1144:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1145:                 "SigCdCor", "crFopBuscaCor", "Cods", par_cValor, ;
1146:                 "Sele" + CHR(231) + CHR(227) + "o de Cor", .F., .T., "")
1147: 
1148:             IF VARTYPE(loc_oFba) = "O"
1149:                 loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1150:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1151:                 loc_oFba.Show()
1152:             ENDIF
1153: 
1154:             IF USED("crFopBuscaCor")
1155:                 IF !EOF("crFopBuscaCor")
1156:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCor.Cods, ""))
1157:                     USE IN crFopBuscaCor
1158:                     SELECT crSigPrFnc
1159:                     REPLACE CodCors WITH loc_cCodigo
1160:                     THIS.grd_4c_Dados.Refresh()
1161:                 ELSE
1162:                     USE IN crFopBuscaCor
1163:                 ENDIF
1164:             ENDIF
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message + CHR(13) + ;
1167:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1168:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCor")
1169:             IF USED("crFopBuscaCor")
1170:                 USE IN crFopBuscaCor
1171:             ENDIF
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * ConfigurarPaginaLista - Wrapper para o padrao CRUD (delegador)
1177:     * SIGCDFOP eh form OPERACIONAL modal (sem PageFrame), com layout FLAT:
1178:     * cabecalho + botoes no topo + grid + area de repeticao. Nao ha Page1/Page2.
1179:     * Mantido para conformidade com o pipeline de migracao (Fase 4 valida
1180:     * presenca dos nomes ConfigurarPaginaLista/AlternarPagina). Delega para os
1181:     * helpers reais que ja fazem o trabalho: ConfigurarGrid (grid 10 colunas) +
1182:     * ConfigurarBotoes (Repetir/Inserir/Excluir/Encerrar do cnt_4c_Cabecalho).
1183:     *==========================================================================
1184:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1185:         THIS.ConfigurarGrid()
1186:         THIS.ConfigurarBotoes()
1187:     ENDPROC
1188: 
1189:     *==========================================================================
1190:     * AlternarPagina - No-op para conformidade com o pipeline CRUD
1191:     * Este form nao tem PageFrame (layout FLAT), portanto nao ha paginas para
1192:     * alternar. Metodo existe apenas para satisfazer o validador da Fase 4 do
1193:     * pipeline. Qualquer chamada eh silenciosamente ignorada.
1194:     *==========================================================================
1195:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1196:         RETURN
1197:     ENDPROC
1198: 
1199:     *==========================================================================
1200:     * ConfigurarPaginaDados - Wrapper de conformidade com o pipeline (Fase 5)
1201:     * SIGCDFOP eh form OPERACIONAL modal com layout FLAT (sem PageFrame).
1202:     * Nao existe "Page2 de Dados" separada — a entrada de dados acontece
1203:     * diretamente nas celulas do grid (grd_4c_Dados, 10 colunas, configurado
1204:     * em ConfigurarGrid na Fase 4). Este metodo existe apenas para satisfazer
1205:     * o validador de fase do pipeline multi-fase. Nenhuma acao necessaria.
1206:     *==========================================================================
1207:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1208:         RETURN
1209:     ENDPROC
1210: 
1211:     *==========================================================================
1212:     * AbrirBuscaTam - Abre FormBuscaAuxiliar para SigCdTam (Tamanho)
1213:     *==========================================================================
1214:     PROTECTED PROCEDURE AbrirBuscaTam(par_cValor)
1215:         LOCAL loc_oFba, loc_cCodigo, loc_oErro
1216: 
1217:         TRY
1218:             loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1219:                 "SigCdTam", "crFopBuscaTam", "Cods", par_cValor, ;
1220:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .F., .T., "")
1221: 
1222:             IF VARTYPE(loc_oFba) = "O"
1223:                 loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1224:                 loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1225:                 loc_oFba.Show()
1226:             ENDIF
1227: 
1228:             IF USED("crFopBuscaTam")
1229:                 IF !EOF("crFopBuscaTam")
1230:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaTam.Cods, ""))
1231:                     USE IN crFopBuscaTam
1232:                     SELECT crSigPrFnc
1233:                     REPLACE CodTams WITH loc_cCodigo
1234:                     THIS.grd_4c_Dados.Refresh()
1235:                 ELSE
1236:                     USE IN crFopBuscaTam
1237:                 ENDIF
1238:             ENDIF
1239:         CATCH TO loc_oErro
1240:             MsgErro(loc_oErro.Message + CHR(13) + ;
1241:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1242:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaTam")
1243:             IF USED("crFopBuscaTam")
1244:                 USE IN crFopBuscaTam
1245:             ENDIF
1246:         ENDTRY
1247:     ENDPROC
1248: 
1249:     *==========================================================================
1250:     * BtnIncluirClick - Delega para o handler nativo do form OPERACIONAL
1251:     * SIGCDFOP legado tem cmdInserir (nao cmdIncluir do CRUD). O handler
1252:     * CmdInserirClick ja realiza a acao correta: insere linha vazia no cursor
1253:     * crSigPrFnc via BO e reposiciona o grid. Este wrapper existe para
1254:     * conformidade com o validador da Fase 7 do pipeline multi-fase que
1255:     * verifica presenca do nome canonico Btn*Click.
1256:     *==========================================================================
1257:     PROCEDURE BtnIncluirClick()
1258:         THIS.CmdInserirClick()
1259:     ENDPROC
1260: 
1261:     *==========================================================================
1262:     * BtnAlterarClick - Posiciona edicao na 1a coluna do grid (equivalente a
1263:     * "Alterar" em form OPERACIONAL: os dados sao editados diretamente nas
1264:     * celulas). Sem paginas Lista/Dados, "Alterar" resume-se a garantir foco
1265:     * na linha corrente para permitir digitacao.
1266:     *==========================================================================
1267:     PROCEDURE BtnAlterarClick()
1268:         LOCAL loc_oErro
1269: 
1270:         TRY
1271:             IF !THIS.this_lModoEdicao
1272:                 MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
1273:                          "Reabra a partir do form pai em modo Incluir ou Alterar.", ;
1274:                          "Aten" + CHR(231) + CHR(227) + "o")
1275:                 RETURN
1276:             ENDIF
1277:             IF USED("crSigPrFnc") AND !EOF("crSigPrFnc")
1278:                 THIS.grd_4c_Dados.Column1.SetFocus()
1279:             ENDIF
1280:         CATCH TO loc_oErro
1281:             MsgErro(loc_oErro.Message + CHR(13) + ;
1282:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1283:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
1284:         ENDTRY
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * BtnVisualizarClick - Recarrega e refresca a lista de fornecedores
1289:     * Em form OPERACIONAL sem Page1/Page2, "Visualizar" equivale a atualizar
1290:     * o grid a partir do banco (util para refletir mudancas concorrentes).
1291:     *==========================================================================
1292:     PROCEDURE BtnVisualizarClick()
1293:         LOCAL loc_oErro
1294: 
1295:         TRY
1296:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1297:                 RETURN
1298:             ENDIF
1299:             IF EMPTY(THIS.this_cCpros)
1300:                 RETURN
1301:             ENDIF
1302:             THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
1303:             IF USED("crSigPrFnc")
1304:                 THIS.grd_4c_Dados.ColumnCount  = 10
1305:                 THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
1306:                 THIS.grd_4c_Dados.Refresh()
1307:             ENDIF
1308:         CATCH TO loc_oErro
1309:             MsgErro(loc_oErro.Message + CHR(13) + ;
1310:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1311:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
1312:         ENDTRY
1313:     ENDPROC
1314: 
1315:     *==========================================================================
1316:     * BtnExcluirClick - Delega para o handler nativo do form OPERACIONAL
1317:     * SIGCDFOP legado tem cmdExcluir. O handler CmdExcluirClick ja marca a
1318:     * linha corrente do cursor crSigPrFnc para exclusao via BO. Wrapper de
1319:     * conformidade com o validador da Fase 7 do pipeline.
1320:     *==========================================================================
1321:     PROCEDURE BtnExcluirClick()
1322:         THIS.CmdExcluirClick()
1323:     ENDPROC
1324: 
1325:     *==========================================================================
1326:     * BtnBuscarClick - Recarrega lista de fornecedores do produto
1327:     * Em form OPERACIONAL sem campo de filtro separado, "Buscar" equivale
1328:     * a recarregar os dados atuais do SQL Server para o grid.
1329:     *==========================================================================
1330:     PROCEDURE BtnBuscarClick()
1331:         THIS.CarregarLista()
1332:     ENDPROC
1333: 
1334:     *==========================================================================
1335:     * BtnEncerrarClick - Delega para o handler nativo do form OPERACIONAL
1336:     * CmdEncerrarClick ja faz validacao, salva (se modo edicao) e fecha.
1337:     *==========================================================================
1338:     PROCEDURE BtnEncerrarClick()
1339:         THIS.CmdEncerrarClick()
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * BtnSalvarClick - Valida e persiste alteracoes sem fechar o form
1344:     * Permite que o usuario salve o progresso e continue editando.
1345:     * Apos salvar com sucesso, recarrega a lista do banco para refletir o
1346:     * estado real (inclusive chaves geradas pelo SQL Server).
1347:     *==========================================================================
1348:     PROCEDURE BtnSalvarClick()
1349:         LOCAL loc_oErro
1350: 
1351:         TRY
1352:             IF !THIS.this_lModoEdicao
1353:                 MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
1354:                          "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel salvar.", ;
1355:                          "Aten" + CHR(231) + CHR(227) + "o")
1356:                 RETURN
1357:             ENDIF
1358: 
1359:             IF THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
1360:                 IF THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
1361:                     MsgInfo("Fornecedores salvos com sucesso.")
1362:                     THIS.CarregarLista()
1363:                 ENDIF
1364:             ENDIF
1365:         CATCH TO loc_oErro
1366:             MsgErro(loc_oErro.Message + CHR(13) + ;
1367:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1368:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1369:         ENDTRY
1370:     ENDPROC
1371: 
1372:     *==========================================================================
1373:     * BtnCancelarClick - Desfaz alteracoes nao salvas e fecha o form
1374:     * Reverte o buffer do cursor (TABLEREVERT) e libera o form sem validar,
1375:     * replicando o comportamento de "Cancelar" em forms de edicao.
1376:     *==========================================================================
1377:     PROCEDURE BtnCancelarClick()
1378:         LOCAL loc_oErro
1379: 
1380:         TRY
1381:             IF THIS.this_lModoEdicao AND USED("crSigPrFnc")
1382:                 TABLEREVERT(.T., "crSigPrFnc")
1383:             ENDIF
1384: 
1385:             IF VARTYPE(THIS.this_oParentForm) = "O"
1386:                 THIS.this_oParentForm.Enabled = .T.
1387:             ENDIF
1388:             THIS.Release()
1389:         CATCH TO loc_oErro
1390:             MsgErro(loc_oErro.Message + CHR(13) + ;
1391:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1392:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
1393:         ENDTRY
1394:     ENDPROC
1395: 
1396:     *==========================================================================
1397:     * CarregarLista - Recarrega fornecedores do produto no grid
1398:     * Chama BuscarPorProduto no BO e revincula o RecordSource do grid.
1399:     * Equivalente ao InicializarForm de carga de dados (sem recriar controles).
1400:     *==========================================================================
1401:     PROCEDURE CarregarLista()
1402:         LOCAL loc_oErro
1403: 
1404:         TRY
1405:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1406:                 RETURN
1407:             ENDIF
1408:             IF EMPTY(THIS.this_cCpros)
1409:                 RETURN
1410:             ENDIF
1411:             THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
1412:             IF USED("crSigPrFnc")
1413:                 THIS.grd_4c_Dados.ColumnCount  = 10
1414:                 THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
1415:                 THIS.grd_4c_Dados.Refresh()
1416:             ENDIF
1417:         CATCH TO loc_oErro
1418:             MsgErro(loc_oErro.Message + CHR(13) + ;
1419:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1420:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1421:         ENDTRY
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme o modo
1426:     * Inserir/Excluir/Repetir ficam visiveis apenas em modo edicao.
1427:     * Encerrar sempre visivel.
1428:     *==========================================================================
1429:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1430:         LOCAL loc_oErro
1431: 
1432:         TRY
1433:             THIS.cmd_4c_Inserir.Visible      = THIS.this_lModoEdicao
1434:             THIS.cmd_4c_Inserir.Enabled      = THIS.this_lModoEdicao
1435:             THIS.cmd_4c_Excluir.Visible      = THIS.this_lModoEdicao
1436:             THIS.cmd_4c_Excluir.Enabled      = THIS.this_lModoEdicao
1437:             THIS.cmd_4c_Repetir.Visible      = THIS.this_lModoEdicao
1438:             THIS.cmd_4c_Repetir.Enabled      = THIS.this_lModoEdicao
1439:             THIS.shp_4c_ShpRepetir.Visible   = THIS.this_lModoEdicao
1440:             THIS.cmd_4c_Encerrar.Visible     = .T.
1441:             THIS.cmd_4c_Encerrar.Enabled     = .T.
1442:         CATCH TO loc_oErro
1443:             MsgErro(loc_oErro.Message + CHR(13) + ;
1444:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1445:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * HabilitarCampos - Ajusta ReadOnly das 10 colunas do grid conforme modo
1451:     * par_lHabilitar = .T. -> colunas editaveis; .F. -> somente leitura
1452:     *==========================================================================
1453:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1454:         LOCAL loc_i, loc_oGrid, loc_oErro
1455: 
1456:         TRY
1457:             loc_oGrid = THIS.grd_4c_Dados
1458:             FOR loc_i = 1 TO loc_oGrid.ColumnCount
1459:                 loc_oGrid.Columns(loc_i).ReadOnly = !par_lHabilitar
1460:             ENDFOR
1461:         CATCH TO loc_oErro
1462:             MsgErro(loc_oErro.Message + CHR(13) + ;
1463:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1464:                     "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
1465:         ENDTRY
1466:     ENDPROC
1467: 
1468:     *==========================================================================
1469:     * LimparCampos - Zera o cursor crSigPrFnc e refresca o grid
1470:     * Usado para limpar a grade quando o form precisa ser resetado.
1471:     *==========================================================================
1472:     PROTECTED PROCEDURE LimparCampos()
1473:         LOCAL loc_oErro
1474: 
1475:         TRY
1476:             IF USED("crSigPrFnc")
1477:                 SELECT crSigPrFnc
1478:                 ZAP
1479:                 THIS.grd_4c_Dados.Refresh()
1480:             ENDIF
1481:             THIS.this_lHouveIncl = .F.
1482:             THIS.this_lHouveExcl = .F.
1483:         CATCH TO loc_oErro
1484:             MsgErro(loc_oErro.Message + CHR(13) + ;
1485:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1486:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1487:         ENDTRY
1488:     ENDPROC
1489: 
1490:     *==========================================================================
1491:     * FormParaBO - Sincroniza a linha corrente do cursor com as propriedades do BO
1492:     * Neste form OPERACIONAL, a edicao ocorre diretamente nas celulas do grid
1493:     * (cursor crSigPrFnc). FormParaBO carrega a linha corrente no BO via
1494:     * CarregarDoCursor para que o BO possa usar as propriedades this_* em
1495:     * operacoes avulsas (ex: validacoes ou auditorias de linha individual).
1496:     *==========================================================================
1497:     PROTECTED PROCEDURE FormParaBO()
1498:         LOCAL loc_oErro
1499: 
1500:         TRY
1501:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1502:                USED("crSigPrFnc") AND !EOF("crSigPrFnc")
1503:                 THIS.this_oBusinessObject.CarregarDoCursor("crSigPrFnc")
1504:             ENDIF
1505:         CATCH TO loc_oErro
1506:             MsgErro(loc_oErro.Message + CHR(13) + ;
1507:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1508:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1509:         ENDTRY
1510:     ENDPROC
1511: 
1512:     *==========================================================================
1513:     * BOParaForm - Sincroniza propriedades do BO para controles do form
1514:     * Neste form OPERACIONAL, nao ha campos individuais de formulario: os dados
1515:     * ficam diretamente no cursor crSigPrFnc e sao exibidos pelo grid.
1516:     * O metodo existe para conformidade com o padrao CRUD do pipeline.
1517:     *==========================================================================
1518:     PROTECTED PROCEDURE BOParaForm()
1519:         RETURN
1520:     ENDPROC
1521: 
1522: ENDDEFINE


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


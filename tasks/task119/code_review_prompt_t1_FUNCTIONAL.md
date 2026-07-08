# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarFiltros()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_IfvTmpBase' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'optGtprel' (parent: SIGREIFV): Top original=84 vs migrado 'obj_4c_OptGtprel' Top=5 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optGtprel' (parent: SIGREIFV): Left original=161 vs migrado 'obj_4c_OptGtprel' Left=0 (diff=161px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGREIFV): Top original=189 vs migrado 'lbl_4c_Lbl_moeda' Top=109 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmdApgEmp' (parent: SIGREIFV): Top original=372 vs migrado 'cmd_4c_CmdApgEmp' Top=292 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdSelemp' (parent: SIGREIFV): Top original=332 vs migrado 'cmd_4c_CmdSelemp' Top=252 (diff=80px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1919 linhas total):

*-- Linhas 18 a 175:
18: *
19: * FASE 7/8 - Eventos Principais (COMPLETO)
20: *   * Propriedades visuais do form (exatas do original)
21: *   * Init() / InicializarForm() / Destroy()
22: *   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
23: *   * ConfigurarBotoes() (Visualizar / Imprimir / Excel / Encerrar)
24: *   * ConfigurarPageFrame() (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
25: *   * ConfigurarPaginaLista() - filtros, grid empresas, bot" + CHR(245) + "es Sel/Desel
26: *   * ConfigurarPaginaDados() - BINDEVENTs de todos os campos e bot" + CHR(245) + "es
27: *   * Validar*/Abrir*/Tecla* - handlers de lookup para todos os campos
28: *   * AjustarVisibilidadePorTipo() - oculta/exibe controles por tipo
29: *   * FormParaRelatorio() - transfere filtros para o BO
30: *   * ValidarFiltros() - valida campos obrigat" + CHR(243) + "rios antes de gerar
31: *   * BtnVisualizarClick() / BtnImprimirClick() / BtnExcelClick() / BtnEncerrarClick()
32: *   * CmdSelempClick() / CmdApgEmpClick() - marcar/desmarcar empresas no grid
33: *==============================================================================
34: 
35: DEFINE CLASS FormSigReIfv AS FormBase
36: 
37:     *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=424)
38:     Height      = 424
39:     Width       = 800
40:     DataSession = 2
41:     ShowWindow  = 1
42:     WindowType  = 1
43:     AutoCenter  = .T.
44:     BorderStyle = 2
45:     ControlBox  = .F.
46:     MaxButton   = .F.
47:     MinButton   = .F.
48:     TitleBar    = 0
49:     Themes      = .F.
50:     ShowTips    = .T.
51: 
52:     *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
53:     this_oRelatorio    = .NULL.
54:     this_cMensagemErro = ""
55: 
56:     *--------------------------------------------------------------------------
57:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
58:     *--------------------------------------------------------------------------
59:     PROCEDURE Init()
60:         RETURN DODEFAULT()
61:     ENDPROC
62: 
63:     *--------------------------------------------------------------------------
64:     * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
65:     *   1. Define Caption / Picture (fundo)
66:     *   2. Cria SigReIfvBO e carrega cursores auxiliares (pula em modo UI)
67:     *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
68:     *--------------------------------------------------------------------------
69:     PROTECTED PROCEDURE InicializarForm()
70:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
71:         loc_lSucesso   = .F.
72:         loc_lContinuar = .T.
73:         TRY
74:             THIS.Caption = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
75: 
76:             IF TYPE("gc_4c_CaminhoIcones") = "U"
77:                 gc_4c_CaminhoIcones = ""
78:             ENDIF
79:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
80: 
81:             *-- Instanciar BO do relat" + CHR(243) + "rio
82:             THIS.this_oRelatorio = CREATEOBJECT("SigReIfvBO")
83:             IF VARTYPE(THIS.this_oRelatorio) != "O"
84:                 MsgErro("Erro ao criar SigReIfvBO" + CHR(13) + ;
85:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
86:                 loc_lContinuar = .F.
87:             ENDIF
88: 
89:             *-- Carregar cursores auxiliares (CrSigCdEmp, CsBases, etc.)
90:             *   Equivalente ao Init() original que fazia SqlExecute de SigCdEmp.
91:             *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
92:             IF loc_lContinuar AND ;
93:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
94:                 IF !THIS.this_oRelatorio.CarregarDadosAuxiliares()
95:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
96:                     loc_lContinuar = .F.
97:                 ENDIF
98:             ENDIF
99: 
100:             IF loc_lContinuar
101:                 *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
102:                 THIS.ConfigurarCabecalho()
103: 
104:                 *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
105:                 THIS.ConfigurarBotoes()
106: 
107:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
108:                 THIS.ConfigurarPageFrame()
109:                 THIS.ConfigurarPaginaLista()
110: 
111:                 *-- BINDEVENTs dos campos de filtro (primeira metade: empresa, datas)
112:                 THIS.ConfigurarPaginaDados()
113: 
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                 THIS.LimparCampos()
118:                 THIS.Visible = .T.
119:                 loc_lSucesso = .T.
120:             ENDIF
121:         CATCH TO loc_oErro
122:             THIS.this_cMensagemErro = loc_oErro.Message
123:             MsgErro(loc_oErro.Message + CHR(13) + ;
124:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
125:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
126:         ENDTRY
127:         RETURN loc_lSucesso
128:     ENDPROC
129: 
130:     *--------------------------------------------------------------------------
131:     * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
132:     *   Equivalente ao cntSombra do frmrelatorio legado.
133:     *   Largura = Width do form (cobre toda a faixa superior).
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
137:         WITH THIS.cnt_4c_Cabecalho
138:             .Top         = 0
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = 80
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .BorderWidth = 0
145:             .Visible     = .T.
146: 
147:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
148:             .AddObject("lbl_4c_Sombra", "Label")
149:             WITH .lbl_4c_Sombra
150:                 .Top       = 22
151:                 .Left      = 22
152:                 .Width     = THIS.Width
153:                 .Height    = 30
154:                 .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
155:                 .FontName  = "Tahoma"
156:                 .FontSize  = 14
157:                 .FontBold  = .T.
158:                 .ForeColor = RGB(0, 0, 0)
159:                 .BackStyle = 0
160:                 .Visible   = .T.
161:             ENDWITH
162: 
163:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Top       = 20
167:                 .Left      = 20
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(255, 255, 255)
175:                 .BackStyle = 0

*-- Linhas 182 a 227:
182:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
183:     *   Original: btnReport.Left=529, Height=80, Width=273
184:     *   Bot" + CHR(245) + "es: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
185:     *   Eventos Click vinculados em ConfigurarPaginaDados() via BINDEVENT.
186:     *--------------------------------------------------------------------------
187:     PROTECTED PROCEDURE ConfigurarBotoes()
188:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
189:         WITH THIS.cmg_4c_Botoes
190:             .Top           = 0
191:             .Left          = 529
192:             .Width         = 273
193:             .Height        = 80
194:             .ButtonCount   = 4
195:             .BackStyle     = 0
196:             .BorderStyle   = 0
197:             .BorderColor   = RGB(136, 189, 188)
198:             .SpecialEffect = 1
199:             .Themes        = .F.
200:             .Visible       = .T.
201: 
202:             *-- Visualizar (preview em tela)
203:             WITH .Buttons(1)
204:                 .Top             = 5
205:                 .Left            = 5
206:                 .Width           = 65
207:                 .Height          = 70
208:                 .Caption         = "Visualizar"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .BackColor       = RGB(255, 255, 255)
212:                 .ForeColor       = RGB(90, 90, 90)
213:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
214:                 .PicturePosition = 13
215:                 .SpecialEffect   = 0
216:                 .MousePointer    = 15
217:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
218:                 .Themes          = .F.
219:                 .Visible         = .T.
220:             ENDWITH
221: 
222:             *-- Imprimir (impressora padr" + CHR(227) + "o)
223:             WITH .Buttons(2)
224:                 .Top             = 5
225:                 .Left            = 71
226:                 .Width           = 65
227:                 .Height          = 70

*-- Linhas 293 a 376:
293:     *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form.
294:     *   Os campos de filtro s" + CHR(227) + "o adicionados em ConfigurarPaginaLista() (Fase 4+).
295:     *--------------------------------------------------------------------------
296:     PROTECTED PROCEDURE ConfigurarPageFrame()
297:         LOCAL loc_oPgf
298: 
299:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
300:         loc_oPgf = THIS.pgf_4c_Paginas
301: 
302:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
303:         loc_oPgf.PageCount = 1
304: 
305:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho ate o fim do form
306:         loc_oPgf.Top    = 85
307:         loc_oPgf.Left   = -1
308:         loc_oPgf.Width  = THIS.Width + 2
309:         loc_oPgf.Height = THIS.Height - 85
310:         loc_oPgf.Tabs   = .F.
311: 
312:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
313:         loc_oPgf.Page1.Caption   = "Filtros"
314:         loc_oPgf.Page1.FontName  = "Tahoma"
315:         loc_oPgf.Page1.FontSize  = 8
316:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
317:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
318:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
319: 
320:         loc_oPgf.Visible    = .T.
321:         loc_oPgf.ActivePage = 1
322:     ENDPROC
323: 
324:     *--------------------------------------------------------------------------
325:     * ConfigurarPaginaLista - Adiciona campos de filtro e grid de empresas
326:     *   Equivalente aos controles diretos do form original (SIGREIFV):
327:     *   optGtprel, campos empresa/data/moeda/grupo/conta/barra, GrdEmp
328:     *   Posicoes calculadas: Original_Top - 80 (PageFrame inicia em Top=85)
329:     *--------------------------------------------------------------------------
330:     PROTECTED PROCEDURE ConfigurarPaginaLista()
331:         LOCAL loc_oPag, loc_oGrd
332:         loc_oPag = THIS.pgf_4c_Paginas.Page1
333: 
334:         *-- OptionGroup Tipo: Anal" + CHR(237) + "tico(1) / Sint" + CHR(233) + "tico(2) / Consulta Barra(3)
335:         *   Original: Top=84, Left=161, Width=247, Height=27, ButtonCount=3
336:         loc_oPag.AddObject("obj_4c_OptGtprel", "OptionGroup")
337:         WITH loc_oPag.obj_4c_OptGtprel
338:             .Top         = 5
339:             .Left        = 161
340:             .Width       = 247
341:             .Height      = 27
342:             .ButtonCount = 3
343:             .BackStyle   = 0
344:             .BorderStyle = 0
345:             .Themes      = .F.
346:             .Value       = 1
347:             .Visible     = .T.
348: 
349:             WITH .Buttons(1)
350:                 .Caption  = "Anal" + CHR(237) + "tico"
351:                 .Width    = 80
352:                 .Left     = 0
353:             ENDWITH
354:             WITH .Buttons(2)
355:                 .Caption  = "Sint" + CHR(233) + "tico"
356:                 .Width    = 80
357:                 .Left     = 83
358:                 .FontName = "Tahoma"
359:                 .FontSize = 8
360:             ENDWITH
361:             WITH .Buttons(3)
362:                 .Caption  = "Consulta Barra"
363:                 .Width    = 84
364:                 .Left     = 163
365:                 .FontName = "Tahoma"
366:                 .FontSize = 8
367:             ENDWITH
368:         ENDWITH
369: 
370:         *-- Label "Tipo :" (Say2 original: Top=90, Left=131)
371:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
372:         WITH loc_oPag.lbl_4c_Label2
373:             .Top       = 10
374:             .Left      = 131
375:             .Width     = 29
376:             .Height    = 18

*-- Linhas 702 a 1919:
702:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
703:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
704:         ENDIF
705: 
706:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
707:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
708:         WITH loc_oPag.cmd_4c_CmdSelemp
709:             .Top           = 252
710:             .Left          = 508
711:             .Width         = 40
712:             .Height        = 40
713:             .Caption       = ""
714:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
715:             .ToolTipText   = "Marcar Todas as Empresas"
716:             .FontName      = "Tahoma"
717:             .FontSize      = 8
718:             .Themes        = .F.
719:             .SpecialEffect = 0
720:             .MousePointer  = 15
721:             .Visible       = .F.
722:         ENDWITH
723: 
724:         *-- Bot" + CHR(227) + "o Desmarcar Todas as Empresas (CmdApgEmp original: Top=372, Left=508, W=40, H=40)
725:         loc_oPag.AddObject("cmd_4c_CmdApgEmp", "CommandButton")
726:         WITH loc_oPag.cmd_4c_CmdApgEmp
727:             .Top           = 292
728:             .Left          = 508
729:             .Width         = 40
730:             .Height        = 40
731:             .Caption       = ""
732:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
733:             .ToolTipText   = "Desmarcar Todas as Empresas"
734:             .FontName      = "Tahoma"
735:             .FontSize      = 8
736:             .Themes        = .F.
737:             .SpecialEffect = 0
738:             .MousePointer  = 15
739:             .Visible       = .F.
740:         ENDWITH
741:     ENDPROC
742: 
743:     *--------------------------------------------------------------------------
744:     * AjustarVisibilidadePorTipo - Exibe/oculta controles conforme tipo
745:     *   Tipo=1 (Anal" + CHR(237) + "tico)     : empresa, sem grid, sem barra, sem DtBaseAnt
746:     *   Tipo=2 (Sint" + CHR(233) + "tico)     : grid+bot" + CHR(245) + "es, sem empresa, com DtBaseAnt
747:     *   Tipo=3 (Consulta Barra): empresa, com campo barra, sem grid
748:     *   Chamado via BINDEVENT do obj_4c_OptGtprel.InteractiveChange (Fase 7)
749:     *--------------------------------------------------------------------------
750:     PROCEDURE AjustarVisibilidadePorTipo()
751:         LOCAL loc_nTipo, loc_oPag
752:         loc_nTipo = THIS.pgf_4c_Paginas.Page1.obj_4c_OptGtprel.Value
753:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
754: 
755:         IF loc_nTipo = 2
756:             loc_oPag.grd_4c_Dados.Visible     = .T.
757:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .T.
758:             loc_oPag.cmd_4c_CmdSelemp.Visible = .T.
759:             loc_oPag.lbl_4c_Label3.Visible    = .F.
760:             loc_oPag.txt_4c_Empresa.Visible   = .F.
761:             loc_oPag.txt_4c_Dempresa.Visible  = .F.
762:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .T.
763:             loc_oPag.txt_4c_DtBasea.Visible   = .T.
764:             loc_oPag.lbl_4c_Barra.Visible     = .F.
765:             loc_oPag.txt_4c_IBarra.Visible    = .F.
766:         ELSE
767:             loc_oPag.grd_4c_Dados.Visible     = .F.
768:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .F.
769:             loc_oPag.cmd_4c_CmdSelemp.Visible = .F.
770:             loc_oPag.lbl_4c_Label3.Visible    = .T.
771:             loc_oPag.txt_4c_Empresa.Visible   = .T.
772:             loc_oPag.txt_4c_Dempresa.Visible  = .T.
773:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .F.
774:             loc_oPag.txt_4c_DtBasea.Visible   = .F.
775:             loc_oPag.lbl_4c_Barra.Visible     = (loc_nTipo = 3)
776:             loc_oPag.txt_4c_IBarra.Visible    = (loc_nTipo = 3)
777:         ENDIF
778: 
779:         THIS.Refresh
780:     ENDPROC
781: 
782:     *--------------------------------------------------------------------------
783:     * AlternarPagina - Navega para a p" + CHR(225) + "gina especificada no PageFrame
784:     *   Este form tem 1 p" + CHR(225) + "gina (Filtros); m" + CHR(233) + "todo preparado para expans" + CHR(227) + "o
785:     *--------------------------------------------------------------------------
786:     PROCEDURE AlternarPagina(par_nPagina)
787:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
788:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
789:         ENDIF
790:     ENDPROC
791: 
792:     *--------------------------------------------------------------------------
793:     * Destroy - Limpeza de recursos
794:     *   BO " + CHR(233) + " objeto Custom - usar = .NULL. (NAO .Release())
795:     *--------------------------------------------------------------------------
796:     PROCEDURE Destroy()
797:         IF VARTYPE(THIS.this_oRelatorio) = "O"
798:             THIS.this_oRelatorio = .NULL.
799:         ENDIF
800:         DODEFAULT()
801:     ENDPROC
802: 
803:     *--------------------------------------------------------------------------
804:     * ConfigurarPaginaDados - Configura BINDEVENTs dos campos de filtro
805:     *   Fase 5: OptGtprel, Empresa cod/desc, DtBase, DtBasea
806:     *   Fase 6 completa: Moeda, GrupoEstoque, ContaEstoque, IBarra, botoes
807:     *--------------------------------------------------------------------------
808:     PROTECTED PROCEDURE ConfigurarPaginaDados()
809:         LOCAL loc_oPag
810:         loc_oPag = THIS.pgf_4c_Paginas.Page1
811: 
812:         *-- OptGtprel -> AjustarVisibilidadePorTipo (metodo PUBLIC)
813:         BINDEVENT(loc_oPag.obj_4c_OptGtprel, "InteractiveChange", ;
814:                   THIS, "AjustarVisibilidadePorTipo")
815: 
816:         *-- Empresa codigo: ENTER(13)/TAB(9)/F4(115)
817:         BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")
818: 
819:         *-- Empresa descricao: ENTER(13)/TAB(9)/F4(115)
820:         BINDEVENT(loc_oPag.txt_4c_Dempresa, "KeyPress", THIS, "TeclaDEmpresa")
821: 
822:         *-- Data Base MM/YYYY: ENTER(13)/TAB(9)/F4(115)
823:         BINDEVENT(loc_oPag.txt_4c_DtBase, "KeyPress", THIS, "TeclaDtBase")
824: 
825:         *-- Data Base Anterior MM/YYYY: ENTER(13)/TAB(9)/F4(115)
826:         BINDEVENT(loc_oPag.txt_4c_DtBasea, "KeyPress", THIS, "TeclaDtBasea")
827: 
828:         *-- Moeda codigo: ENTER(13)/TAB(9)/F4(115)
829:         BINDEVENT(loc_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
830: 
831:         *-- Moeda descricao: ENTER(13)/TAB(9)/F4(115)
832:         BINDEVENT(loc_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
833: 
834:         *-- Grupo Estoque codigo: ENTER(13)/TAB(9)/F4(115)
835:         BINDEVENT(loc_oPag.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
836: 
837:         *-- Grupo Estoque descricao: ENTER(13)/TAB(9)/F4(115)
838:         BINDEVENT(loc_oPag.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
839: 
840:         *-- Conta Estoque codigo: ENTER(13)/TAB(9)/F4(115)
841:         BINDEVENT(loc_oPag.txt_4c_Cd_Estoque, "KeyPress", THIS, "TeclaCdEstoque")
842: 
843:         *-- Conta Estoque descricao: ENTER(13)/TAB(9)/F4(115)
844:         BINDEVENT(loc_oPag.txt_4c_Ds_Estoque, "KeyPress", THIS, "TeclaDsEstoque")
845: 
846:         *-- Numero de Barra/Etiqueta: ENTER(13)/TAB(9) valida
847:         BINDEVENT(loc_oPag.txt_4c_IBarra, "KeyPress", THIS, "TeclaIBarra")
848: 
849:         *-- Botoes do CommandGroup: Visualizar / Imprimir / Excel / Encerrar
850:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
851:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
852:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
853:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
854: 
855:         *-- Botoes de controle do grid de selecao de empresas (Tipo=2)
856:         BINDEVENT(loc_oPag.cmd_4c_CmdSelemp, "Click", THIS, "CmdSelempClick")
857:         BINDEVENT(loc_oPag.cmd_4c_CmdApgEmp, "Click", THIS, "CmdApgEmpClick")
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * LimparCampos - Reseta todos os campos de filtro para estado inicial
862:     *--------------------------------------------------------------------------
863:     PROCEDURE LimparCampos()
864:         LOCAL loc_oPag
865:         loc_oPag = THIS.pgf_4c_Paginas.Page1
866: 
867:         loc_oPag.obj_4c_OptGtprel.Value     = 1
868:         loc_oPag.txt_4c_IBarra.Value        = 0
869:         loc_oPag.txt_4c_Empresa.Value       = ""
870:         loc_oPag.txt_4c_Dempresa.Value      = ""
871:         loc_oPag.txt_4c_DtBase.Value        = ""
872:         loc_oPag.txt_4c_DtBasea.Value       = ""
873:         loc_oPag.txt_4c__cd_moeda.Value     = ""
874:         loc_oPag.txt_4c__ds_moeda.Value     = ""
875:         loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
876:         loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
877:         loc_oPag.txt_4c_Cd_Estoque.Value    = ""
878:         loc_oPag.txt_4c_Ds_Estoque.Value    = ""
879: 
880:         THIS.AjustarVisibilidadePorTipo()
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * TeclaEmpresa - KeyPress do campo codigo de empresa
885:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo
886:     *--------------------------------------------------------------------------
887:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
888:         IF par_nKeyCode = 115
889:             THIS.AbrirBuscaEmpresa()
890:         ELSE
891:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
892:             THIS.ValidarEmpresa()
893:             ENDIF
894:         ENDIF
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * ValidarEmpresa - Valida codigo de empresa em CrSigCdEmp e preenche Razas
899:     *--------------------------------------------------------------------------
900:     PROCEDURE ValidarEmpresa()
901:         LOCAL loc_cCodigo
902:         loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
903: 
904:         IF EMPTY(loc_cCodigo)
905:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ""
906:             RETURN
907:         ENDIF
908: 
909:         IF USED("CrSigCdEmp")
910:             SELECT CrSigCdEmp
911:             SET ORDER TO CEmps
912:             IF SEEK(loc_cCodigo)
913:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
914:                 RETURN
915:             ENDIF
916:         ENDIF
917: 
918:         THIS.AbrirBuscaEmpresa()
919:     ENDPROC
920: 
921:     *--------------------------------------------------------------------------
922:     * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
923:     *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
924:     *--------------------------------------------------------------------------
925:     PROCEDURE AbrirBuscaEmpresa()
926:         LOCAL loc_oBusca, loc_cValor, loc_oPag
927:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
928:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
929: 
930:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
931:             "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cValor, ;
932:             "Empresa")
933: 
934:         IF VARTYPE(loc_oBusca) != "O"
935:             MsgErro("Erro ao abrir busca de empresas", "Erro")
936:             RETURN
937:         ENDIF
938: 
939:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
940:             loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
941:             loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
942:         ELSE
943:             IF !loc_oBusca.this_lAchouRegistro
944:             loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
945:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
946:             loc_oBusca.Show()
947:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
948:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
949:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
950:             ENDIF
951:             ENDIF
952:         ENDIF
953: 
954:         loc_oBusca.Release()
955:         IF USED("cursor_4c_BuscaEmp")
956:             USE IN cursor_4c_BuscaEmp
957:         ENDIF
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * TeclaDEmpresa - KeyPress do campo descricao de empresa
962:     *   F4(115)/ENTER(13)/TAB(9): busca empresa por Razas e preenche CEmps
963:     *--------------------------------------------------------------------------
964:     PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShift)
965:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
966:             THIS.ValidarDEmpresa()
967:         ENDIF
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     * ValidarDEmpresa - Busca empresa por descricao (Razas) e preenche CEmps
972:     *   LOCATE em CrSigCdEmp; se nao achar, abre FormBuscaAuxiliar
973:     *--------------------------------------------------------------------------
974:     PROCEDURE ValidarDEmpresa()
975:         LOCAL loc_cDesc, loc_oPag, loc_oBusca
976:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
977:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)
978: 
979:         IF EMPTY(loc_cDesc)
980:             loc_oPag.txt_4c_Empresa.Value  = ""
981:             loc_oPag.txt_4c_Dempresa.Value = ""
982:             RETURN
983:         ENDIF
984: 
985:         IF USED("CrSigCdEmp")
986:             SELECT CrSigCdEmp
987:             LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
988:             IF FOUND()
989:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
990:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
991:                 RETURN
992:             ENDIF
993:         ENDIF
994: 
995:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
996:             "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
997:             "Empresa")
998: 
999:         IF VARTYPE(loc_oBusca) != "O"
1000:             RETURN
1001:         ENDIF
1002: 
1003:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1004:             loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1005:             loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1006:         ELSE
1007:             IF !loc_oBusca.this_lAchouRegistro
1008:             loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
1009:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
1010:             loc_oBusca.Show()
1011:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1012:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1013:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1014:             ENDIF
1015:             ENDIF
1016:         ENDIF
1017: 
1018:         loc_oBusca.Release()
1019:         IF USED("cursor_4c_BuscaEmp")
1020:             USE IN cursor_4c_BuscaEmp
1021:         ENDIF
1022:     ENDPROC
1023: 
1024:     *--------------------------------------------------------------------------
1025:     * TeclaDtBase - KeyPress do campo Data Base (formato MM/YYYY)
1026:     *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
1027:     *--------------------------------------------------------------------------
1028:     PROCEDURE TeclaDtBase(par_nKeyCode, par_nShift)
1029:         IF par_nKeyCode = 115
1030:             THIS.AbrirBuscaDtBase("DtBase")
1031:         ELSE
1032:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1033:             THIS.ValidarDtBase()
1034:             ENDIF
1035:         ENDIF
1036:     ENDPROC
1037: 
1038:     *--------------------------------------------------------------------------
1039:     * ValidarDtBase - Valida Data Base contra cursor CsBases (formato MM/YYYY)
1040:     *--------------------------------------------------------------------------
1041:     PROCEDURE ValidarDtBase()
1042:         LOCAL loc_cValor
1043:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value)
1044: 
1045:         IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
1046:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ""
1047:             RETURN
1048:         ENDIF
1049: 
1050:         IF USED("CsBases")
1051:             SELECT CsBases
1052:             SET ORDER TO Bases
1053:             IF SEEK(loc_cValor)
1054:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
1055:                 RETURN
1056:             ENDIF
1057:         ENDIF
1058: 
1059:         THIS.AbrirBuscaDtBase("DtBase")
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
1064:     *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE AbrirBuscaDtBase(par_cCampo)
1067:         LOCAL loc_oBusca, loc_oPag, loc_cSel
1068:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1069: 
1070:         IF !USED("CsBases")
1071:             MsgAviso("Datas base n" + CHR(227) + "o carregadas.", "Busca")
1072:             RETURN
1073:         ENDIF
1074: 
1075:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1076:         IF VARTYPE(loc_oBusca) != "O"
1077:             MsgErro("Erro ao abrir busca de datas base", "Erro")
1078:             RETURN
1079:         ENDIF
1080: 
1081:         loc_oBusca.this_cCursorDestino = "CsBases"
1082:         loc_oBusca.this_cTitulo        = "Data Base"
1083:         loc_oBusca.mAddColuna("Bases", "XXXXXXXXXX", "Data Base")
1084:         loc_oBusca.Show()
1085: 
1086:         IF loc_oBusca.this_lSelecionou AND USED("CsBases")
1087:             loc_cSel = ALLTRIM(CsBases.Bases)
1088:             IF par_cCampo = "DtBase"
1089:                 loc_oPag.txt_4c_DtBase.Value  = loc_cSel
1090:             ELSE
1091:                 loc_oPag.txt_4c_DtBasea.Value = loc_cSel
1092:             ENDIF
1093:         ENDIF
1094: 
1095:         loc_oBusca.Release()
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     * TeclaDtBasea - KeyPress do campo Data Base Anterior (formato MM/YYYY)
1100:     *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
1101:     *--------------------------------------------------------------------------
1102:     PROCEDURE TeclaDtBasea(par_nKeyCode, par_nShift)
1103:         IF par_nKeyCode = 115
1104:             THIS.AbrirBuscaDtBase("DtBasea")
1105:         ELSE
1106:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1107:             THIS.ValidarDtBasea()
1108:             ENDIF
1109:         ENDIF
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * ValidarDtBasea - Valida Data Base Anterior contra cursor CsBases (MM/YYYY)
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE ValidarDtBasea()
1116:         LOCAL loc_cValor
1117:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value)
1118: 
1119:         IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
1120:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ""
1121:             RETURN
1122:         ENDIF
1123: 
1124:         IF USED("CsBases")
1125:             SELECT CsBases
1126:             SET ORDER TO Bases
1127:             IF SEEK(loc_cValor)
1128:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
1129:                 RETURN
1130:             ENDIF
1131:         ENDIF
1132: 
1133:         THIS.AbrirBuscaDtBase("DtBasea")
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * TeclaCdMoeda - KeyPress do campo codigo de moeda
1138:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
1139:     *--------------------------------------------------------------------------
1140:     PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
1141:         IF par_nKeyCode = 115
1142:             THIS.AbrirBuscaMoeda()
1143:         ELSE
1144:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1145:             THIS.ValidarCdMoeda()
1146:             ENDIF
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * ValidarCdMoeda - Valida codigo de moeda em CrSigCdMoe e preenche DMoes
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE ValidarCdMoeda()
1154:         LOCAL loc_cCodigo, loc_oPag
1155:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1156:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1157: 
1158:         IF EMPTY(loc_cCodigo)
1159:             loc_oPag.txt_4c__ds_moeda.Value = ""
1160:             RETURN
1161:         ENDIF
1162: 
1163:         IF USED("CrSigCdMoe")
1164:             SELECT CrSigCdMoe
1165:             SET ORDER TO CMoes
1166:             IF SEEK(loc_cCodigo)
1167:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1168:                 RETURN
1169:             ENDIF
1170:         ENDIF
1171: 
1172:         THIS.AbrirBuscaMoeda()
1173:     ENDPROC
1174: 
1175:     *--------------------------------------------------------------------------
1176:     * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
1177:     *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
1178:     *--------------------------------------------------------------------------
1179:     PROCEDURE AbrirBuscaMoeda()
1180:         LOCAL loc_oBusca, loc_cValor, loc_oPag
1181:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1182:         loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1183: 
1184:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1185:             "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
1186:             "Moeda")
1187: 
1188:         IF VARTYPE(loc_oBusca) != "O"
1189:             MsgErro("Erro ao abrir busca de moedas", "Erro")
1190:             RETURN
1191:         ENDIF
1192: 
1193:         IF loc_oBusca.this_lAchouRegistro
1194:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1195:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1196:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1197:             ENDIF
1198:         ELSE
1199:             loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
1200:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1201:             loc_oBusca.Show()
1202:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1203:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1204:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1205:             ENDIF
1206:         ENDIF
1207: 
1208:         loc_oBusca.Release()
1209:         IF USED("cursor_4c_BuscaMoe")
1210:             USE IN cursor_4c_BuscaMoe
1211:         ENDIF
1212:     ENDPROC
1213: 
1214:     *--------------------------------------------------------------------------
1215:     * TeclaDsMoeda - KeyPress do campo descricao de moeda
1216:     *   F4(115)/ENTER(13)/TAB(9): busca moeda por DMoes e preenche CMoes
1217:     *--------------------------------------------------------------------------
1218:     PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
1219:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1220:             THIS.ValidarDsMoeda()
1221:         ENDIF
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * ValidarDsMoeda - Busca moeda por descricao (DMoes) em CrSigCdMoe
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE ValidarDsMoeda()
1228:         LOCAL loc_cDesc, loc_oPag, loc_oBusca
1229:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1230:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
1231: 
1232:         IF EMPTY(loc_cDesc)
1233:             loc_oPag.txt_4c__cd_moeda.Value = ""
1234:             loc_oPag.txt_4c__ds_moeda.Value = ""
1235:             RETURN
1236:         ENDIF
1237: 
1238:         IF USED("CrSigCdMoe")
1239:             SELECT CrSigCdMoe
1240:             LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
1241:             IF FOUND()
1242:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
1243:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1244:                 RETURN
1245:             ENDIF
1246:         ENDIF
1247: 
1248:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1249:             "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
1250:             "Moeda")
1251: 
1252:         IF VARTYPE(loc_oBusca) != "O"
1253:             RETURN
1254:         ENDIF
1255: 
1256:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1257:             loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1258:             loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1259:         ELSE
1260:             IF !loc_oBusca.this_lAchouRegistro
1261:             loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
1262:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1263:             loc_oBusca.Show()
1264:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1265:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1266:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1267:             ENDIF
1268:             ENDIF
1269:         ENDIF
1270: 
1271:         loc_oBusca.Release()
1272:         IF USED("cursor_4c_BuscaMoe")
1273:             USE IN cursor_4c_BuscaMoe
1274:         ENDIF
1275:     ENDPROC
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * TeclaCdGrEstoque - KeyPress do campo codigo do grupo de estoque
1279:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdGcr
1280:     *--------------------------------------------------------------------------
1281:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
1282:         IF par_nKeyCode = 115
1283:             THIS.AbrirBuscaGrEstoque()
1284:         ELSE
1285:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1286:             THIS.ValidarCdGrEstoque()
1287:             ENDIF
1288:         ENDIF
1289:     ENDPROC
1290: 
1291:     *--------------------------------------------------------------------------
1292:     * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
1293:     *   Equivalente ao fAcessoContab(Usuar,'C',...) do sistema legado
1294:     *--------------------------------------------------------------------------
1295:     PROCEDURE ValidarCdGrEstoque()
1296:         LOCAL loc_cCodigo, loc_oPag, loc_cSQL, loc_nResult
1297:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1298:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1299: 
1300:         IF EMPTY(loc_cCodigo)
1301:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
1302:             RETURN
1303:         ENDIF
1304: 
1305:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
1306:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1307: 
1308:         IF loc_nResult > 0
1309:             SELECT cursor_4c_ValGrEst
1310:             IF !EOF()
1311:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1312:                 USE IN cursor_4c_ValGrEst
1313:                 RETURN
1314:             ENDIF
1315:             IF USED("cursor_4c_ValGrEst")
1316:                 USE IN cursor_4c_ValGrEst
1317:             ENDIF
1318:         ENDIF
1319: 
1320:         THIS.AbrirBuscaGrEstoque()
1321:     ENDPROC
1322: 
1323:     *--------------------------------------------------------------------------
1324:     * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque
1325:     *   Tabela: SigCdGcr | Cod: codigos | Desc: descrs
1326:     *--------------------------------------------------------------------------
1327:     PROCEDURE AbrirBuscaGrEstoque()
1328:         LOCAL loc_oBusca, loc_cValor, loc_oPag
1329:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1330:         loc_cValor = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1331: 
1332:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1333:             "SigCdGcr", "cursor_4c_BuscaGrEst", "codigos", loc_cValor, ;
1334:             "Grupo de Estoque")
1335: 
1336:         IF VARTYPE(loc_oBusca) != "O"
1337:             MsgErro("Erro ao abrir busca de grupos de estoque", "Erro")
1338:             RETURN
1339:         ENDIF
1340: 
1341:         IF loc_oBusca.this_lAchouRegistro
1342:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1343:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1344:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1345:             ENDIF
1346:         ELSE
1347:             loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1348:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1349:             loc_oBusca.Show()
1350:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1351:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1352:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1353:             ENDIF
1354:         ENDIF
1355: 
1356:         loc_oBusca.Release()
1357:         IF USED("cursor_4c_BuscaGrEst")
1358:             USE IN cursor_4c_BuscaGrEst
1359:         ENDIF
1360:     ENDPROC
1361: 
1362:     *--------------------------------------------------------------------------
1363:     * TeclaDsGrEstoque - KeyPress do campo descricao do grupo de estoque
1364:     *   F4(115)/ENTER(13)/TAB(9): busca grupo por descrs e preenche codigos
1365:     *--------------------------------------------------------------------------
1366:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
1367:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1368:             THIS.ValidarDsGrEstoque()
1369:         ENDIF
1370:     ENDPROC
1371: 
1372:     *--------------------------------------------------------------------------
1373:     * ValidarDsGrEstoque - Busca grupo de estoque por descricao em SigCdGcr
1374:     *   Equivalente ao fAcessoContab(Usuar,'D',...) do sistema legado
1375:     *--------------------------------------------------------------------------
1376:     PROCEDURE ValidarDsGrEstoque()
1377:         LOCAL loc_cDesc, loc_oPag, loc_oBusca, loc_cSQL, loc_nResult
1378:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1379:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)
1380: 
1381:         IF EMPTY(loc_cDesc)
1382:             loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
1383:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
1384:             RETURN
1385:         ENDIF
1386: 
1387:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
1388:                       UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
1389:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1390: 
1391:         IF loc_nResult > 0
1392:             SELECT cursor_4c_ValGrEst
1393:             IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
1394:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
1395:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1396:                 USE IN cursor_4c_ValGrEst
1397:                 RETURN
1398:             ENDIF
1399:             IF USED("cursor_4c_ValGrEst")
1400:                 USE IN cursor_4c_ValGrEst
1401:             ENDIF
1402:         ENDIF
1403: 
1404:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1405:             "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
1406:             "Grupo de Estoque")
1407: 
1408:         IF VARTYPE(loc_oBusca) != "O"
1409:             RETURN
1410:         ENDIF
1411: 
1412:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1413:             loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1414:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1415:         ELSE
1416:             IF !loc_oBusca.this_lAchouRegistro
1417:             loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1418:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1419:             loc_oBusca.Show()
1420:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1421:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1422:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1423:             ENDIF
1424:             ENDIF
1425:         ENDIF
1426: 
1427:         loc_oBusca.Release()
1428:         IF USED("cursor_4c_BuscaGrEst")
1429:             USE IN cursor_4c_BuscaGrEst
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     *--------------------------------------------------------------------------
1434:     * TeclaCdEstoque - KeyPress do campo codigo da conta de estoque
1435:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdBal
1436:     *--------------------------------------------------------------------------
1437:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShift)
1438:         IF par_nKeyCode = 115
1439:             THIS.AbrirBuscaEstoque()
1440:         ELSE
1441:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1442:             THIS.ValidarCdEstoque()
1443:             ENDIF
1444:         ENDIF
1445:     ENDPROC
1446: 
1447:     *--------------------------------------------------------------------------
1448:     * ValidarCdEstoque - Valida codigo de conta de estoque em SigCdBal
1449:     *   Equivalente ao fAcessoContas(Usuar,Grupo,'C',...) do sistema legado
1450:     *   Filtra por Grupos se o campo de grupo estiver preenchido
1451:     *--------------------------------------------------------------------------
1452:     PROCEDURE ValidarCdEstoque()
1453:         LOCAL loc_cCodigo, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
1454:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1455:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
1456:         loc_cGrupo  = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1457: 
1458:         IF EMPTY(loc_cCodigo)
1459:             loc_oPag.txt_4c_Ds_Estoque.Value = ""
1460:             RETURN
1461:         ENDIF
1462: 
1463:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas = " + EscaparSQL(loc_cCodigo)
1464:         IF !EMPTY(loc_cGrupo)
1465:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1466:         ENDIF
1467: 
1468:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
1469: 
1470:         IF loc_nResult > 0
1471:             SELECT cursor_4c_ValEst
1472:             IF !EOF()
1473:                 loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
1474:                 USE IN cursor_4c_ValEst
1475:                 RETURN
1476:             ENDIF
1477:             IF USED("cursor_4c_ValEst")
1478:                 USE IN cursor_4c_ValEst
1479:             ENDIF
1480:         ENDIF
1481: 
1482:         THIS.AbrirBuscaEstoque()
1483:     ENDPROC
1484: 
1485:     *--------------------------------------------------------------------------
1486:     * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque
1487:     *   Busca contas distintas em SigCdBal filtradas pelo grupo selecionado
1488:     *   Equivalente ao fAcessoContas(Usuar,Grupo,...) do sistema legado
1489:     *--------------------------------------------------------------------------
1490:     PROCEDURE AbrirBuscaEstoque()
1491:         LOCAL loc_oBusca, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
1492:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1493:         loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1494: 
1495:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas IS NOT NULL AND LEN(RTRIM(Contas)) > 0"
1496:         IF !EMPTY(loc_cGrupo)
1497:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1498:         ENDIF
1499:         loc_cSQL    = loc_cSQL + " ORDER BY Contas"
1500:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1501: 
1502:         IF loc_nResult < 1
1503:             MsgErro("Erro ao buscar contas de estoque", "Erro")
1504:             RETURN
1505:         ENDIF
1506: 
1507:         SELECT cursor_4c_BuscaEst
1508:         GO TOP
1509: 
1510:         IF EOF()
1511:             MsgAviso("Nenhuma conta encontrada" + ;
1512:                 IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
1513:                 "Busca")
1514:             USE IN cursor_4c_BuscaEst
1515:             RETURN
1516:         ENDIF
1517: 
1518:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1519:         IF VARTYPE(loc_oBusca) != "O"
1520:             MsgErro("Erro ao abrir busca de contas", "Erro")
1521:             USE IN cursor_4c_BuscaEst
1522:             RETURN
1523:         ENDIF
1524: 
1525:         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEst"
1526:         loc_oBusca.this_cTitulo        = "Conta de Estoque"
1527:         loc_oBusca.mAddColuna("Contas", "XXXXXXXX", "Conta")
1528:         loc_oBusca.Show()
1529: 
1530:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEst")
1531:             loc_oPag.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
1532:             loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
1533:         ENDIF
1534: 
1535:         loc_oBusca.Release()
1536:         IF USED("cursor_4c_BuscaEst")
1537:             USE IN cursor_4c_BuscaEst
1538:         ENDIF
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * TeclaDsEstoque - KeyPress do campo descricao da conta de estoque
1543:     *   F4(115)/ENTER(13)/TAB(9): abre busca de contas de estoque
1544:     *--------------------------------------------------------------------------
1545:     PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShift)
1546:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1547:             THIS.ValidarDsEstoque()
1548:         ENDIF
1549:     ENDPROC
1550: 
1551:     *--------------------------------------------------------------------------
1552:     * ValidarDsEstoque - Busca conta de estoque por valor digitado na descricao
1553:     *   Como Contas nao tem descricao separada, abre lookup para selecao
1554:     *--------------------------------------------------------------------------
1555:     PROCEDURE ValidarDsEstoque()
1556:         LOCAL loc_cDesc, loc_oPag
1557:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1558:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)
1559: 
1560:         IF EMPTY(loc_cDesc)
1561:             loc_oPag.txt_4c_Cd_Estoque.Value = ""
1562:             loc_oPag.txt_4c_Ds_Estoque.Value = ""
1563:             RETURN
1564:         ENDIF
1565: 
1566:         THIS.AbrirBuscaEstoque()
1567:     ENDPROC
1568: 
1569:     *--------------------------------------------------------------------------
1570:     * TeclaIBarra - KeyPress do campo numero de barra/etiqueta
1571:     *   ENTER(13)/TAB(9): valida numero em SigOpEtq
1572:     *--------------------------------------------------------------------------
1573:     PROCEDURE TeclaIBarra(par_nKeyCode, par_nShift)
1574:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1575:             THIS.ValidarIBarra()
1576:         ENDIF
1577:     ENDPROC
1578: 
1579:     *--------------------------------------------------------------------------
1580:     * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
1581:     *   Equivalente ao Valid original de GetiBarra:
1582:     *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
1583:     *--------------------------------------------------------------------------
1584:     PROCEDURE ValidarIBarra()
1585:         LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
1586:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1587:         loc_nBarra = loc_oPag.txt_4c_IBarra.Value
1588: 
1589:         IF loc_nBarra = 0
1590:             RETURN
1591:         ENDIF
1592: 
1593:         loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
1594:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")
1595: 
1596:         IF loc_nResult > 0
1597:             SELECT cursor_4c_ValBarra
1598:             IF EOF()
1599:                 IF USED("cursor_4c_ValBarra")
1600:                     USE IN cursor_4c_ValBarra
1601:                 ENDIF
1602:                 MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
1603:                     "Valida" + CHR(231) + CHR(227) + "o")
1604:                 loc_oPag.txt_4c_IBarra.Value = 0
1605:                 RETURN
1606:             ENDIF
1607:             IF USED("cursor_4c_ValBarra")
1608:                 USE IN cursor_4c_ValBarra
1609:             ENDIF
1610:         ELSE
1611:             MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
1612:         ENDIF
1613:     ENDPROC
1614: 
1615:     *--------------------------------------------------------------------------
1616:     * FormParaRelatorio - Transfere valores dos filtros do form para o BO
1617:     *   Chamado antes de Visualizar() ou Imprimir()
1618:     *--------------------------------------------------------------------------
1619:     PROTECTED PROCEDURE FormParaRelatorio()
1620:         LOCAL loc_oPag
1621:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1622: 
1623:         WITH THIS.this_oRelatorio
1624:             .this_nTipo        = loc_oPag.obj_4c_OptGtprel.Value
1625:             .this_cDtBase      = ALLTRIM(loc_oPag.txt_4c_DtBase.Value)
1626:             .this_cDtBaseA     = ALLTRIM(loc_oPag.txt_4c_DtBasea.Value)
1627:             .this_cCdEmpresa   = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
1628:             .this_cDsEmpresa   = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)
1629:             .this_cCdMoeda     = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1630:             .this_cDsMoeda     = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
1631:             .this_cCdGrEstoque = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1632:             .this_cDsGrEstoque = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)
1633:             .this_cCdEstoque   = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
1634:             .this_cDsEstoque   = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)
1635:             .this_nIBarra      = loc_oPag.txt_4c_IBarra.Value
1636:         ENDWITH
1637:     ENDPROC
1638: 
1639:     *--------------------------------------------------------------------------
1640:     * ValidarFiltros - Verifica campos obrigatorios antes de gerar relatorio
1641:     *   Equivalente as validacoes do Click original do botao de relatorio
1642:     *--------------------------------------------------------------------------
1643:     PROTECTED FUNCTION ValidarFiltros()
1644:         LOCAL loc_nTipo, loc_oPag
1645:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1646:         loc_nTipo = loc_oPag.obj_4c_OptGtprel.Value
1647: 
1648:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_DtBase.Value)) OR ;
1649:            ALLTRIM(loc_oPag.txt_4c_DtBase.Value) = "  /    "
1650:             MsgAviso("Data Base Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1651:             loc_oPag.txt_4c_DtBase.SetFocus
1652:             RETURN .F.
1653:         ENDIF
1654: 
1655:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)) AND ;
1656:            INLIST(loc_nTipo, 1, 2)
1657:             MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1658:             loc_oPag.txt_4c__cd_moeda.SetFocus
1659:             RETURN .F.
1660:         ENDIF
1661: 
1662:         IF loc_nTipo = 1
1663:             IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Empresa.Value))
1664:                 MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1665:                 loc_oPag.txt_4c_Empresa.SetFocus
1666:                 RETURN .F.
1667:             ENDIF
1668:         ENDIF
1669: 
1670:         IF loc_nTipo = 3
1671:             IF loc_oPag.txt_4c_IBarra.Value = 0
1672:                 MsgAviso("N" + CHR(250) + "mero de Barra Inv" + CHR(225) + "lido !!!", ;
1673:                     "Campo Obrigat" + CHR(243) + "rio")
1674:                 loc_oPag.txt_4c_IBarra.SetFocus
1675:                 RETURN .F.
1676:             ENDIF
1677:         ENDIF
1678: 
1679:         RETURN .T.
1680:     ENDFUNC
1681: 
1682:     *--------------------------------------------------------------------------
1683:     * BtnVisualizarClick - Visualiza relatorio em tela (preview)
1684:     *   Equivalente ao btnReport.Visualiza.Click original
1685:     *--------------------------------------------------------------------------
1686:     PROCEDURE BtnVisualizarClick()
1687:         IF !THIS.ValidarFiltros()
1688:             RETURN
1689:         ENDIF
1690:         THIS.FormParaRelatorio()
1691:         IF !THIS.this_oRelatorio.Visualizar()
1692:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1693:         ENDIF
1694:     ENDPROC
1695: 
1696:     *--------------------------------------------------------------------------
1697:     * BtnImprimirClick - Envia relatorio para impressora
1698:     *   Equivalente ao btnReport.Imprime.Click original
1699:     *--------------------------------------------------------------------------
1700:     PROCEDURE BtnImprimirClick()
1701:         IF !THIS.ValidarFiltros()
1702:             RETURN
1703:         ENDIF
1704:         THIS.FormParaRelatorio()
1705:         IF !THIS.this_oRelatorio.Imprimir()
1706:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1707:         ENDIF
1708:     ENDPROC
1709: 
1710:     *--------------------------------------------------------------------------
1711:     * BtnExcelClick - Exporta dados do relatorio para planilha Excel
1712:     *   Equivalente ao btnReport.DocExcel.Click original
1713:     *--------------------------------------------------------------------------
1714:     PROCEDURE BtnExcelClick()
1715:         IF !THIS.ValidarFiltros()
1716:             RETURN
1717:         ENDIF
1718:         THIS.FormParaRelatorio()
1719:         IF !THIS.this_oRelatorio.PrepararDados()
1720:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1721:             RETURN
1722:         ENDIF
1723:         IF !USED("CsRelatorio")
1724:             MsgAviso("Nenhum dado para exportar.", "Excel")
1725:             RETURN
1726:         ENDIF
1727:         LOCAL loc_cArquivo
1728:         loc_cArquivo = GETFILE("XLS", "Salvar como...", "Salvar", 0, "Exportar para Excel")
1729:         IF EMPTY(loc_cArquivo)
1730:             RETURN
1731:         ENDIF
1732:         COPY TO (loc_cArquivo) TYPE XLS
1733:         MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * BtnEncerrarClick - Fecha o formulario
1738:     *   Equivalente ao btnReport.Sair.Click original (Cancel=.T. ja trata ESC)
1739:     *--------------------------------------------------------------------------
1740:     PROCEDURE BtnEncerrarClick()
1741:         THIS.Release()
1742:     ENDPROC
1743: 
1744:     *--------------------------------------------------------------------------
1745:     * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
1746:     *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
1747:     *--------------------------------------------------------------------------
1748:     PROCEDURE CmdSelempClick()
1749:         IF USED("CsSigCdEmp")
1750:             SELECT CsSigCdEmp
1751:             REPLACE ALL lMarca WITH 1
1752:             GO TOP
1753:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1754:         ENDIF
1755:     ENDPROC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
1759:     *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
1760:     *--------------------------------------------------------------------------
1761:     PROCEDURE CmdApgEmpClick()
1762:         IF USED("CsSigCdEmp")
1763:             SELECT CsSigCdEmp
1764:             REPLACE ALL lMarca WITH 0
1765:             GO TOP
1766:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *==========================================================================
1771:     * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
1772:     *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
1773:     *   metodos existem para compatibilidade com o pipeline generico do sistema
1774:     *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
1775:     *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
1776:     *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
1777:     *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
1778:     *==========================================================================
1779: 
1780:     *--------------------------------------------------------------------------
1781:     * BtnIncluirClick - Em REPORT delega para Visualizar (gerar relatorio)
1782:     *--------------------------------------------------------------------------
1783:     PROCEDURE BtnIncluirClick()
1784:         THIS.BtnVisualizarClick()
1785:     ENDPROC
1786: 
1787:     *--------------------------------------------------------------------------
1788:     * BtnAlterarClick - Em REPORT limpa filtros e devolve foco ao 1o campo
1789:     *--------------------------------------------------------------------------
1790:     PROCEDURE BtnAlterarClick()
1791:         LOCAL loc_oErro
1792:         THIS.LimparCampos()
1793:         TRY
1794:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.SetFocus()
1795:         CATCH TO loc_oErro
1796:             MsgErro(loc_oErro.Message, "Erro")
1797:         ENDTRY
1798:     ENDPROC
1799: 
1800:     *--------------------------------------------------------------------------
1801:     * BtnExcluirClick - Em REPORT delega para LimparCampos (excluir = limpar)
1802:     *--------------------------------------------------------------------------
1803:     PROCEDURE BtnExcluirClick()
1804:         THIS.LimparCampos()
1805:     ENDPROC
1806: 
1807:     *--------------------------------------------------------------------------
1808:     * BtnBuscarClick - Em REPORT busca = visualizar relatorio em tela
1809:     *--------------------------------------------------------------------------
1810:     PROCEDURE BtnBuscarClick()
1811:         THIS.BtnVisualizarClick()
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * BtnSalvarClick - Em REPORT salvar = imprimir relatorio
1816:     *--------------------------------------------------------------------------
1817:     PROCEDURE BtnSalvarClick()
1818:         THIS.BtnImprimirClick()
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * BtnCancelarClick - Em REPORT cancelar = limpar todos os filtros
1823:     *--------------------------------------------------------------------------
1824:     PROCEDURE BtnCancelarClick()
1825:         THIS.LimparCampos()
1826:     ENDPROC
1827: 
1828:     *--------------------------------------------------------------------------
1829:     * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
1830:     *   Transfere valores dos filtros do form para as propriedades do BO
1831:     *--------------------------------------------------------------------------
1832:     PROCEDURE FormParaBO()
1833:         THIS.FormParaRelatorio()
1834:     ENDPROC
1835: 
1836:     *--------------------------------------------------------------------------
1837:     * BOParaForm - Carrega propriedades do BO de volta nos campos do form
1838:     *   Em REPORT, os filtros sao definidos pelo usuario; BO nao tem estado
1839:     *   persistente a recarregar. Metodo existe para compatibilidade de pipeline.
1840:     *--------------------------------------------------------------------------
1841:     PROCEDURE BOParaForm()
1842:         LOCAL loc_oPag
1843:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1844: 
1845:         WITH THIS.this_oRelatorio
1846:             loc_oPag.obj_4c_OptGtprel.Value     = .this_nTipo
1847:             loc_oPag.txt_4c_DtBase.Value        = .this_cDtBase
1848:             loc_oPag.txt_4c_DtBasea.Value       = .this_cDtBaseA
1849:             loc_oPag.txt_4c_Empresa.Value       = .this_cCdEmpresa
1850:             loc_oPag.txt_4c_Dempresa.Value      = .this_cDsEmpresa
1851:             loc_oPag.txt_4c__cd_moeda.Value     = .this_cCdMoeda
1852:             loc_oPag.txt_4c__ds_moeda.Value     = .this_cDsMoeda
1853:             loc_oPag.txt_4c__Cd_GrEstoque.Value = .this_cCdGrEstoque
1854:             loc_oPag.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
1855:             loc_oPag.txt_4c_Cd_Estoque.Value    = .this_cCdEstoque
1856:             loc_oPag.txt_4c_Ds_Estoque.Value    = .this_cDsEstoque
1857:             loc_oPag.txt_4c_IBarra.Value        = .this_nIBarra
1858:         ENDWITH
1859: 
1860:         THIS.AjustarVisibilidadePorTipo()
1861:     ENDPROC
1862: 
1863:     *--------------------------------------------------------------------------
1864:     * HabilitarCampos - Habilita ou desabilita controles de filtro
1865:     *   Em REPORT todos os filtros ficam sempre editaveis (sem modo VISUALIZAR)
1866:     *   par_lHabilitar: .T. para habilitar, .F. para desabilitar
1867:     *--------------------------------------------------------------------------
1868:     PROCEDURE HabilitarCampos(par_lHabilitar)
1869:         LOCAL loc_oPag
1870:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1871: 
1872:         loc_oPag.obj_4c_OptGtprel.Enabled     = par_lHabilitar
1873:         loc_oPag.txt_4c_IBarra.Enabled        = par_lHabilitar
1874:         loc_oPag.txt_4c_Empresa.Enabled       = par_lHabilitar
1875:         loc_oPag.txt_4c_Dempresa.Enabled      = par_lHabilitar
1876:         loc_oPag.txt_4c_DtBase.Enabled        = par_lHabilitar
1877:         loc_oPag.txt_4c_DtBasea.Enabled       = par_lHabilitar
1878:         loc_oPag.txt_4c__cd_moeda.Enabled     = par_lHabilitar
1879:         loc_oPag.txt_4c__ds_moeda.Enabled     = par_lHabilitar
1880:         loc_oPag.txt_4c__Cd_GrEstoque.Enabled = par_lHabilitar
1881:         loc_oPag.txt_4c__Ds_GrEstoque.Enabled = par_lHabilitar
1882:         loc_oPag.txt_4c_Cd_Estoque.Enabled    = par_lHabilitar
1883:         loc_oPag.txt_4c_Ds_Estoque.Enabled    = par_lHabilitar
1884:     ENDPROC
1885: 
1886:     *--------------------------------------------------------------------------
1887:     * CarregarLista - Em REPORT nao ha lista; recarrega grid de empresas se aberto
1888:     *   Chamado quando tipo=2 (Sint" + CHR(233) + "tico) e grid de empresas precisa ser atualizado
1889:     *--------------------------------------------------------------------------
1890:     PROCEDURE CarregarLista()
1891:         LOCAL loc_oGrd, loc_oPag
1892:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1893:         loc_oGrd = loc_oPag.grd_4c_Dados
1894: 
1895:         IF USED("CsSigCdEmp")
1896:             loc_oGrd.RecordSource          = "CsSigCdEmp"
1897:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1898:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1899:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1900:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1901:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1902:             loc_oGrd.Refresh
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------
1907:     * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
1908:     *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE AjustarBotoesPorModo()
1911:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1912:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1913:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1914:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1915:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1916:         ENDIF
1917:     ENDPROC
1918: 
1919: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIfvBO.prg):
*==============================================================================
* SIGREIFVBO.PRG
* Business Object para Relatorio de Fechamento de Inventario
* Herda de RelatorioBase
*
* Relatorio original: SIGREIFV.SCX (frmrelatorio)
* FRX: SigReIf1 (Analitico), SigReIf0 (Sintetico), SigReIf9 (Consulta Barra)
*==============================================================================

DEFINE CLASS SigReIfvBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cTituloRel     = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"

    *-- Filtros: tipo de relatorio
    *-- 1 = Analitico (empresa unica)
    *-- 2 = Sintetico (multiplas empresas via grid)
    *-- 3 = Consulta Barra (por numero de etiqueta)
    this_nTipo          = 1

    *-- Filtros: datas (formato MM/YYYY - InputMask "99/9999")
    this_cDtBase        = ""
    this_cDtBaseA       = ""

    *-- Filtros: empresa (codigo + descricao)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: moeda (codigo + descricao)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: grupo de estoque/contabilidade (codigo + descricao)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: conta de estoque (codigo + descricao)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: numero de barra/etiqueta (apenas tipo 3)
    this_nIBarra        = 0

    *-- Nomes dos arquivos FRX por tipo
    this_cFrxAnalitico     = "SigReIf1"
    this_cFrxSintetico     = "SigReIf0"
    this_cFrxConsultaBarra = "SigReIf9"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de fechamento de inventario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para o relatorio
    * Deve ser chamado pelo Form durante InicializarForm()
    * Carrega: CrSigCdEmp, CrSigCdMoe, CrSigCdCot, CrSigBaOco, CsBases
    * Cria: CsSigCdEmp (cursor editavel para grid de selecao de empresas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdEmp", "CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresas (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar moedas (CrSigCdMoe)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON CMoes TAG CMoes
            GO TOP

            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cota" + CHR(231) + CHR(245) + "es (CrSigCdCot)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdCot
            INDEX ON CMoes + DTOS(TTOD(Datas)) TAG CMoeData
            GO TOP

            IF USED("CrSigBaOco")
                USE IN CrSigBaOco
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigBaOco", "CrSigBaOco")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar ocorr" + CHR(234) + "ncias (CrSigBaOco)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigBaOco
            INDEX ON Tipos + Codigos TAG TipCods
            GO TOP

            *-- CsBases: datas base disponiveis (para lookup de data base no form)
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF
            CREATE CURSOR cursor_4c_IfvTmpBase (Bases c(7))
            INSERT INTO cursor_4c_IfvTmpBase (Bases) VALUES ("  /    ")

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DtBases FROM SigCdBal WHERE DtBases IS NOT NULL", ;
                "cursor_4c_IfvTmpBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar bases (SigCdBal)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("CsBases")
                USE IN CsBases
            ENDIF
            SELECT SUBSTR(DTOS(DtBases),5,2) + "/" + LEFT(DTOS(DtBases),4) AS Bases ;
            FROM cursor_4c_IfvTmpBal ;
            GROUP BY 1 ;
            UNION ALL ;
            SELECT Bases FROM cursor_4c_IfvTmpBase ;
            GROUP BY 1 ;
            INTO CURSOR CsBases READWRITE

            SELECT CsBases
            INDEX ON Bases TAG Bases
            GO TOP

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF

            *-- CsSigCdEmp: cursor editavel para grid de selecao de empresas (tipo 2)
            IF USED("CsSigCdEmp")
                USE IN CsSigCdEmp
            ENDIF
            SELECT IIF(Ativas = 1, 1, 0) AS lMarca, CEmps, Razas, Ativas, Nums ;
            FROM CrSigCdEmp ;
            WHERE !EMPTY(CEmps) AND !EMPTY(Razas) ;
            INTO CURSOR CsSigCdEmp READWRITE

            SELECT CsSigCdEmp
            INDEX ON Razas TAG Razas
            INDEX ON CEmps TAG CEmps
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta os cursores de dados para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Resultado: cursores CsCabecalho e CsRelatorio prontos para REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cDtBase, loc_cDtBaseA, loc_nTipo
        LOCAL loc_cEmp, loc_cMoe, loc_cGrupo, loc_cConta, loc_nBarra
        LOCAL loc_nResult, loc_cNomeEmpresa, loc_cEmpresaCab
        LOCAL loc_cTitulo, loc_cSubTitulo, loc_lProcess

        loc_lSucesso = .F.
        TRY
            loc_cDtBase  = RIGHT(ALLTRIM(THIS.this_cDtBase), 4)  + LEFT(ALLTRIM(THIS.this_cDtBase), 2)
            loc_cDtBaseA = RIGHT(ALLTRIM(THIS.this_cDtBaseA), 4) + LEFT(ALLTRIM(THIS.this_cDtBaseA), 2)
            loc_nTipo    = THIS.this_nTipo
            loc_cEmp     = ALLTRIM(THIS.this_cCdEmpresa)
            loc_cMoe     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_nBarra   = THIS.this_nIBarra

            loc_cNomeEmpresa = ""
            IF USED("CrSigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "CrSigCdEmp", "CEmps")
                    loc_cNomeEmpresa = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF
            loc_cEmpresaCab = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cNomeEmpresa

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (;
                Empresa   c(80), ;
                Titulo    c(80), ;
                SubTitulo c(80), ;
                DtBase    c(7),  ;
                DtBaseA   c(7)   ;
            )

            IF loc_nTipo = 3
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase) ;
                VALUES (loc_cEmpresaCab, ;
                        "Consulta Barra", ;
                        ALLTRIM(STR(loc_nBarra, 8)), ;
                        THIS.this_cDtBase)
            ELSE
                loc_cTitulo = "Invent" + CHR(225) + "rio Data Base " + THIS.this_cDtBase
                IF loc_nTipo = 1
                    loc_cSubTitulo = "Lj: " + loc_cEmp + "   " + ;
                                     "Anal" + CHR(237) + "tico de Apura" + CHR(231) + CHR(227) + "o - " + loc_cMoe
                ELSE
                    loc_cSubTitulo = "Sint" + CHR(233) + "tico - " + loc_cMoe
                ENDIF
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase, DtBaseA) ;
                VALUES (loc_cEmpresaCab, loc_cTitulo, loc_cSubTitulo, ;
                        THIS.this_cDtBase, THIS.this_cDtBaseA)
            ENDIF

            IF USED("CsBal")
                USE IN CsBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdBal", "CsBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar balan" + CHR(231) + "o (CsBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsBal
            GO TOP

            IF USED("Balancos")
                USE IN Balancos
            ENDIF

            IF loc_nTipo <> 2
                SELECT *, LEFT(DTOS(DtBases),6) AS Bases ;
                FROM CsBal ;
                WHERE IIF(loc_nTipo = 1, Emps = loc_cEmp, .T.) ;
                ORDER BY Emps ;
                INTO CURSOR Balancos
            ELSE
                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
                SELECT * FROM CsSigCdEmp WHERE lMarca = 1 INTO CURSOR cursor_4c_IfvEmps

                SELECT a.*, LEFT(DTOS(a.DtBases),6) AS Bases ;
                FROM CsBal a, cursor_4c_IfvEmps b ;
                WHERE a.Emps = b.CEmps ;
                ORDER BY a.Emps ;
                INTO CURSOR Balancos

                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
            ENDIF

            DO CASE
                CASE loc_nTipo = 1
                    loc_lProcess = THIS.ProcessarAnalitico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                CASE loc_nTipo = 2
                    loc_lProcess = THIS.ProcessarSintetico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                OTHERWISE
                    loc_lProcess = THIS.ProcessarConsultaBarra(loc_cDtBase, loc_cMoe, loc_nBarra)
            ENDCASE

            IF loc_lProcess
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFrxAtual - Retorna nome do arquivo FRX conforme tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterFrxAtual()
        DO CASE
            CASE THIS.this_nTipo = 1
                RETURN THIS.this_cFrxAnalitico
            CASE THIS.this_nTipo = 2
                RETURN THIS.this_cFrxSintetico
            OTHERWISE
                RETURN THIS.this_cFrxConsultaBarra
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("CrSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT CrSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = CrSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(CrSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(CrSigCdCot.Datas) <= par_dData
                    loc_nCotacao = CrSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarAnalitico - Processa relatorio analitico empresa unica (Tipo 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAnalitico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Ocorrencia c(10),   Barras     n(8),    Barra2s   n(8),    ;
            CCustos    n(12,2), CCusto2s   n(12,2), DifCustos n(12,2), ;
            Ocor2s     c(10),   DesOco     c(40),   Obs2s     m,       ;
            DPros      c(40),   Pesos      n(12,2)  ;
        )
        INDEX ON Ocorrencia + STR(Barras,8) TAG Produto

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "LEFT JOIN SigOpEtq c ON c.CBars = a.Barras " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                SCATTER MEMVAR MEMO

                loc_lAchou = SEEK("O" + m.Ocorrencia, "CrSigBaOco", "TipCods")
                IF CrSigBaOco.Apuras <> "S"
                    LOOP
                ENDIF

                m.DPros  = IIF(EMPTY(m.Obs), m.DPros, m.Obs)
                m.DesOco = CrSigBaOco.Descrs

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe,  DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas,  DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos   = m.CCustos  * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.CCusto2s  = m.CCusto2s * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.DifCustos = (m.CCustos - m.CCusto2s)
                m.Obs2s     = NVL(m.Obs2s, "")
                m.Pesos     = NVL(m.Pesos, 0)

                INSERT INTO CsRelatorio FROM MEMVAR

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSintetico - Processa relatorio sintetico multi-empresa (Tipo 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSintetico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_lAchou
        LOCAL loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs
        LOCAL loc_cDataBase, loc_nColuna, loc_nQtde, loc_nDif
        LOCAL loc_cCusto, loc_cQtde

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps    c(3),    DtBals  d(8),    ;
            Qtde1   n(12,2), Custo1  n(12,2), ;
            Qtde2   n(12,2), Custo2  n(12,2), ;
            Qtde3   n(12,2), Custo3  n(12,2), ;
            Custo3d n(12,2), Dif3d   n(12,2), ;
            Qtde4   n(12,2), Custo4  n(12,2), ;
            Qtde5   n(12,2), Custo5  n(12,2), ;
            Contac  n(12,2)  ;
        )
        INDEX ON Emps TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = Balancos.Bases
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            SELECT CsRelatorio
            SEEK Balancos.Emps
            IF EOF()
                INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
            ENDIF
            IF loc_cDataBase = par_cDtBase
                REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
            ENDIF

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF
            SELECT a.*, b.Lancas, b.Opers ;
            FROM Tratamento a, CrSigBaOco b ;
            WHERE "O" + a.Ocorrencia = b.Tipos + b.Codigos AND b.Apuras = "S" ;
            INTO CURSOR cursor_4c_IfvConsulta

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT cursor_4c_IfvConsulta
            GO TOP
            SCAN
                SELECT CsRelatorio
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_IfvConsulta
                SCATTER MEMVAR MEMO

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe, DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas, DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos  = m.CCustos  * IIF(m.Opers = "DB", -1, 1)
                m.CCusto2s = m.CCusto2s * IIF(m.Opers = "DB", -1, 1)

                loc_nDif    = (m.CCustos - m.CCusto2s)
                loc_nColuna = 0

                DO CASE
                    CASE m.Ocorrencia = "FB"
                        IF loc_cDataBase = par_cDtBase
                            loc_nColuna = 2
                        ELSE
                            loc_nColuna = 1
                        ENDIF
                    CASE m.Ocorrencia = "ET" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 3
                    CASE m.Ocorrencia = "SB" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 4
                    CASE m.Ocorrencia = "FE" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 5
                ENDCASE

                IF loc_nColuna = 0
                    SELECT cursor_4c_IfvConsulta
                    LOOP
                ENDIF

                loc_cCusto = "Custo" + STR(loc_nColuna, 1)
                loc_cQtde  = "Qtde"  + STR(loc_nColuna, 1)
                loc_nQtde  = m.Falta + m.Sobra

                SELECT CsRelatorio
                SEEK ALLTRIM(Balancos.Emps)
                IF EOF()
                    INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
                ENDIF
                IF loc_cDataBase = par_cDtBase
                    REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
                ENDIF
                REPLACE &loc_cCusto. WITH &loc_cCusto. + m.CCustos, ;
                        &loc_cQtde.  WITH &loc_cQtde.  + IIF(loc_nQtde = 0, m.Apurado, (m.Falta + m.Sobra))

                IF m.Ocorrencia = "ET"
                    REPLACE Custo3d WITH Custo3d + m.CCusto2s, ;
                            Dif3d   WITH Custo3  - Custo3d
                ENDIF

                IF m.Lancas = "S" AND loc_nColuna <> 1
                    REPLACE Contac WITH Contac + loc_nDif IN CsRelatorio
                ENDIF

                SELECT cursor_4c_IfvConsulta
            ENDSCAN

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConsultaBarra - Processa consulta por numero de barra (Tipo 3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarConsultaBarra(par_cDtBase, par_cMoe, par_nBarra)
        LOCAL loc_nResult, loc_cSQL, loc_cDataBase, loc_cObss, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps       c(3),  ;
            DtBals     d(8),  ;
            DtBases    c(7),  ;
            Ocorrencia c(10), ;
            DesOco     c(40), ;
            Obss       m      ;
        )
        INDEX ON Emps + DtBases TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = RIGHT(Balancos.Bases,2) + "/" + LEFT(Balancos.Bases,4)

            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "AND a.Barras = " + ALLTRIM(STR(par_nBarra, 8)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                loc_lAchou = SEEK("O" + Tratamento.Ocorrencia, "CrSigBaOco", "TipCods")
                loc_cObss = IIF(EMPTY(Tratamento.Obs), ;
                               NVL(Tratamento.DPros, ""), ;
                               NVL(Tratamento.Obs, ""))

                INSERT INTO CsRelatorio (Emps, DtBals, DtBases, Ocorrencia, DesOco, Obss) ;
                VALUES (ALLTRIM(Balancos.Emps), Balancos.DataInis, loc_cDataBase, ;
                        ALLTRIM(Tratamento.Ocorrencia), ALLTRIM(CrSigBaOco.Descrs), loc_cObss)

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarFiltros()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'optGtprel' (parent: SIGREIFV): Top original=84 vs migrado 'obj_4c_OptGtprel' Top=0 (diff=84px, tolerancia=30px)
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1920 linhas total):

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
338:             .Top         = 4
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
351:                 .Top      = 0
352:                 .Left     = 0
353:                 .Width    = 80
354:                 .Height   = 27
355:                 .AutoSize = .F.
356:             ENDWITH
357:             WITH .Buttons(2)
358:                 .Caption  = "Sint" + CHR(233) + "tico"
359:                 .Top      = 0
360:                 .Left     = 83
361:                 .Width    = 80
362:                 .Height   = 27
363:                 .AutoSize = .F.
364:                 .FontName = "Tahoma"
365:                 .FontSize = 8
366:             ENDWITH
367:             WITH .Buttons(3)
368:                 .Caption  = "Consulta Barra"
369:                 .Top      = 0
370:                 .Left     = 163
371:                 .Width    = 84
372:                 .Height   = 27
373:                 .AutoSize = .F.
374:                 .FontName = "Tahoma"
375:                 .FontSize = 8
376:             ENDWITH

*-- Linhas 711 a 1920:
711:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
712:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
713:         ENDIF
714: 
715:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
716:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
717:         WITH loc_oPag.cmd_4c_CmdSelemp
718:             .Top           = 252
719:             .Left          = 508
720:             .Width         = 40
721:             .Height        = 40
722:             .Caption       = ""
723:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
724:             .ToolTipText   = "Marcar Todas as Empresas"
725:             .FontName      = "Tahoma"
726:             .FontSize      = 8
727:             .Themes        = .F.
728:             .SpecialEffect = 0
729:             .MousePointer  = 15
730:             .Visible       = .F.
731:         ENDWITH
732: 
733:         *-- Bot" + CHR(227) + "o Desmarcar Todas as Empresas (CmdApgEmp original: Top=372, Left=508, W=40, H=40)
734:         loc_oPag.AddObject("cmd_4c_CmdApgEmp", "CommandButton")
735:         WITH loc_oPag.cmd_4c_CmdApgEmp
736:             .Top           = 292
737:             .Left          = 508
738:             .Width         = 40
739:             .Height        = 40
740:             .Caption       = ""
741:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
742:             .ToolTipText   = "Desmarcar Todas as Empresas"
743:             .FontName      = "Tahoma"
744:             .FontSize      = 8
745:             .Themes        = .F.
746:             .SpecialEffect = 0
747:             .MousePointer  = 15
748:             .Visible       = .F.
749:         ENDWITH
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * AjustarVisibilidadePorTipo - Exibe/oculta controles conforme tipo
754:     *   Tipo=1 (Anal" + CHR(237) + "tico)     : empresa, sem grid, sem barra, sem DtBaseAnt
755:     *   Tipo=2 (Sint" + CHR(233) + "tico)     : grid+bot" + CHR(245) + "es, sem empresa, com DtBaseAnt
756:     *   Tipo=3 (Consulta Barra): empresa, com campo barra, sem grid
757:     *   Chamado via BINDEVENT do obj_4c_OptGtprel.InteractiveChange (Fase 7)
758:     *--------------------------------------------------------------------------
759:     PROCEDURE AjustarVisibilidadePorTipo()
760:         LOCAL loc_nTipo, loc_oPag
761:         loc_nTipo = THIS.pgf_4c_Paginas.Page1.obj_4c_OptGtprel.Value
762:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
763: 
764:         IF loc_nTipo = 2
765:             loc_oPag.grd_4c_Dados.Visible     = .T.
766:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .T.
767:             loc_oPag.cmd_4c_CmdSelemp.Visible = .T.
768:             loc_oPag.lbl_4c_Label3.Visible    = .F.
769:             loc_oPag.txt_4c_Empresa.Visible   = .F.
770:             loc_oPag.txt_4c_Dempresa.Visible  = .F.
771:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .T.
772:             loc_oPag.txt_4c_DtBasea.Visible   = .T.
773:             loc_oPag.lbl_4c_Barra.Visible     = .F.
774:             loc_oPag.txt_4c_IBarra.Visible    = .F.
775:         ELSE
776:             loc_oPag.grd_4c_Dados.Visible     = .F.
777:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .F.
778:             loc_oPag.cmd_4c_CmdSelemp.Visible = .F.
779:             loc_oPag.lbl_4c_Label3.Visible    = .T.
780:             loc_oPag.txt_4c_Empresa.Visible   = .T.
781:             loc_oPag.txt_4c_Dempresa.Visible  = .T.
782:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .F.
783:             loc_oPag.txt_4c_DtBasea.Visible   = .F.
784:             loc_oPag.lbl_4c_Barra.Visible     = (loc_nTipo = 3)
785:             loc_oPag.txt_4c_IBarra.Visible    = (loc_nTipo = 3)
786:         ENDIF
787: 
788:         THIS.Refresh
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * AlternarPagina - Navega para a p" + CHR(225) + "gina especificada no PageFrame
793:     *   Este form tem 1 p" + CHR(225) + "gina (Filtros); m" + CHR(233) + "todo preparado para expans" + CHR(227) + "o
794:     *--------------------------------------------------------------------------
795:     PROCEDURE AlternarPagina(par_nPagina)
796:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
797:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
798:         ENDIF
799:     ENDPROC
800: 
801:     *--------------------------------------------------------------------------
802:     * Destroy - Limpeza de recursos
803:     *   BO " + CHR(233) + " objeto Custom - usar = .NULL. (NAO .Release())
804:     *--------------------------------------------------------------------------
805:     PROCEDURE Destroy()
806:         IF VARTYPE(THIS.this_oRelatorio) = "O"
807:             THIS.this_oRelatorio = .NULL.
808:         ENDIF
809:         DODEFAULT()
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * ConfigurarPaginaDados - Configura BINDEVENTs dos campos de filtro
814:     *   Fase 5: OptGtprel, Empresa cod/desc, DtBase, DtBasea
815:     *   Fase 6 completa: Moeda, GrupoEstoque, ContaEstoque, IBarra, botoes
816:     *--------------------------------------------------------------------------
817:     PROTECTED PROCEDURE ConfigurarPaginaDados()
818:         LOCAL loc_oPag
819:         loc_oPag = THIS.pgf_4c_Paginas.Page1
820: 
821:         *-- OptGtprel -> AjustarVisibilidadePorTipo (metodo PUBLIC)
822:         BINDEVENT(loc_oPag.obj_4c_OptGtprel, "InteractiveChange", ;
823:                   THIS, "AjustarVisibilidadePorTipo")
824: 
825:         *-- Empresa codigo: ENTER(13)/TAB(9)/F4(115)
826:         BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")
827: 
828:         *-- Empresa descricao: ENTER(13)/TAB(9)/F4(115)
829:         BINDEVENT(loc_oPag.txt_4c_Dempresa, "KeyPress", THIS, "TeclaDEmpresa")
830: 
831:         *-- Data Base MM/YYYY: ENTER(13)/TAB(9)/F4(115)
832:         BINDEVENT(loc_oPag.txt_4c_DtBase, "KeyPress", THIS, "TeclaDtBase")
833: 
834:         *-- Data Base Anterior MM/YYYY: ENTER(13)/TAB(9)/F4(115)
835:         BINDEVENT(loc_oPag.txt_4c_DtBasea, "KeyPress", THIS, "TeclaDtBasea")
836: 
837:         *-- Moeda codigo: ENTER(13)/TAB(9)/F4(115)
838:         BINDEVENT(loc_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
839: 
840:         *-- Moeda descricao: ENTER(13)/TAB(9)/F4(115)
841:         BINDEVENT(loc_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
842: 
843:         *-- Grupo Estoque codigo: ENTER(13)/TAB(9)/F4(115)
844:         BINDEVENT(loc_oPag.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
845: 
846:         *-- Grupo Estoque descricao: ENTER(13)/TAB(9)/F4(115)
847:         BINDEVENT(loc_oPag.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
848: 
849:         *-- Conta Estoque codigo: ENTER(13)/TAB(9)/F4(115)
850:         BINDEVENT(loc_oPag.txt_4c_Cd_Estoque, "KeyPress", THIS, "TeclaCdEstoque")
851: 
852:         *-- Conta Estoque descricao: ENTER(13)/TAB(9)/F4(115)
853:         BINDEVENT(loc_oPag.txt_4c_Ds_Estoque, "KeyPress", THIS, "TeclaDsEstoque")
854: 
855:         *-- Numero de Barra/Etiqueta: ENTER(13)/TAB(9) valida
856:         BINDEVENT(loc_oPag.txt_4c_IBarra, "KeyPress", THIS, "TeclaIBarra")
857: 
858:         *-- Botoes do CommandGroup: Visualizar / Imprimir / Excel / Encerrar
859:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
860:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
861:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
862:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
863: 
864:         *-- Botoes de controle do grid de selecao de empresas (Tipo=2)
865:         BINDEVENT(loc_oPag.cmd_4c_CmdSelemp, "Click", THIS, "CmdSelempClick")
866:         BINDEVENT(loc_oPag.cmd_4c_CmdApgEmp, "Click", THIS, "CmdApgEmpClick")
867:     ENDPROC
868: 
869:     *--------------------------------------------------------------------------
870:     * LimparCampos - Reseta todos os campos de filtro para estado inicial
871:     *--------------------------------------------------------------------------
872:     PROCEDURE LimparCampos()
873:         LOCAL loc_oPag
874:         loc_oPag = THIS.pgf_4c_Paginas.Page1
875: 
876:         loc_oPag.obj_4c_OptGtprel.Value     = 1
877:         loc_oPag.txt_4c_IBarra.Value        = 0
878:         loc_oPag.txt_4c_Empresa.Value       = ""
879:         loc_oPag.txt_4c_Dempresa.Value      = ""
880:         loc_oPag.txt_4c_DtBase.Value        = ""
881:         loc_oPag.txt_4c_DtBasea.Value       = ""
882:         loc_oPag.txt_4c__cd_moeda.Value     = ""
883:         loc_oPag.txt_4c__ds_moeda.Value     = ""
884:         loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
885:         loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
886:         loc_oPag.txt_4c_Cd_Estoque.Value    = ""
887:         loc_oPag.txt_4c_Ds_Estoque.Value    = ""
888: 
889:         THIS.AjustarVisibilidadePorTipo()
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * TeclaEmpresa - KeyPress do campo codigo de empresa
894:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo
895:     *--------------------------------------------------------------------------
896:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
897:         IF par_nKeyCode = 115
898:             THIS.AbrirBuscaEmpresa()
899:         ELSE
900:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
901:             THIS.ValidarEmpresa()
902:             ENDIF
903:         ENDIF
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * ValidarEmpresa - Valida codigo de empresa em CrSigCdEmp e preenche Razas
908:     *--------------------------------------------------------------------------
909:     PROCEDURE ValidarEmpresa()
910:         LOCAL loc_cCodigo
911:         loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
912: 
913:         IF EMPTY(loc_cCodigo)
914:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ""
915:             RETURN
916:         ENDIF
917: 
918:         IF USED("CrSigCdEmp")
919:             SELECT CrSigCdEmp
920:             SET ORDER TO CEmps
921:             IF SEEK(loc_cCodigo)
922:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
923:                 RETURN
924:             ENDIF
925:         ENDIF
926: 
927:         THIS.AbrirBuscaEmpresa()
928:     ENDPROC
929: 
930:     *--------------------------------------------------------------------------
931:     * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
932:     *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
933:     *--------------------------------------------------------------------------
934:     PROCEDURE AbrirBuscaEmpresa()
935:         LOCAL loc_oBusca, loc_cValor, loc_oPag
936:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
937:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
938: 
939:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
940:             "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cValor, ;
941:             "Empresa")
942: 
943:         IF VARTYPE(loc_oBusca) != "O"
944:             MsgErro("Erro ao abrir busca de empresas", "Erro")
945:             RETURN
946:         ENDIF
947: 
948:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
949:             loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
950:             loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
951:         ELSE
952:             IF !loc_oBusca.this_lAchouRegistro
953:             loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
954:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
955:             loc_oBusca.Show()
956:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
957:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
958:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
959:             ENDIF
960:             ENDIF
961:         ENDIF
962: 
963:         loc_oBusca.Release()
964:         IF USED("cursor_4c_BuscaEmp")
965:             USE IN cursor_4c_BuscaEmp
966:         ENDIF
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     * TeclaDEmpresa - KeyPress do campo descricao de empresa
971:     *   F4(115)/ENTER(13)/TAB(9): busca empresa por Razas e preenche CEmps
972:     *--------------------------------------------------------------------------
973:     PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShift)
974:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
975:             THIS.ValidarDEmpresa()
976:         ENDIF
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * ValidarDEmpresa - Busca empresa por descricao (Razas) e preenche CEmps
981:     *   LOCATE em CrSigCdEmp; se nao achar, abre FormBuscaAuxiliar
982:     *--------------------------------------------------------------------------
983:     PROCEDURE ValidarDEmpresa()
984:         LOCAL loc_cDesc, loc_oPag, loc_oBusca
985:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
986:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)
987: 
988:         IF EMPTY(loc_cDesc)
989:             loc_oPag.txt_4c_Empresa.Value  = ""
990:             loc_oPag.txt_4c_Dempresa.Value = ""
991:             RETURN
992:         ENDIF
993: 
994:         IF USED("CrSigCdEmp")
995:             SELECT CrSigCdEmp
996:             LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
997:             IF FOUND()
998:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
999:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
1000:                 RETURN
1001:             ENDIF
1002:         ENDIF
1003: 
1004:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1005:             "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
1006:             "Empresa")
1007: 
1008:         IF VARTYPE(loc_oBusca) != "O"
1009:             RETURN
1010:         ENDIF
1011: 
1012:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1013:             loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1014:             loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1015:         ELSE
1016:             IF !loc_oBusca.this_lAchouRegistro
1017:             loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
1018:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
1019:             loc_oBusca.Show()
1020:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1021:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1022:                 loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1023:             ENDIF
1024:             ENDIF
1025:         ENDIF
1026: 
1027:         loc_oBusca.Release()
1028:         IF USED("cursor_4c_BuscaEmp")
1029:             USE IN cursor_4c_BuscaEmp
1030:         ENDIF
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * TeclaDtBase - KeyPress do campo Data Base (formato MM/YYYY)
1035:     *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
1036:     *--------------------------------------------------------------------------
1037:     PROCEDURE TeclaDtBase(par_nKeyCode, par_nShift)
1038:         IF par_nKeyCode = 115
1039:             THIS.AbrirBuscaDtBase("DtBase")
1040:         ELSE
1041:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1042:             THIS.ValidarDtBase()
1043:             ENDIF
1044:         ENDIF
1045:     ENDPROC
1046: 
1047:     *--------------------------------------------------------------------------
1048:     * ValidarDtBase - Valida Data Base contra cursor CsBases (formato MM/YYYY)
1049:     *--------------------------------------------------------------------------
1050:     PROCEDURE ValidarDtBase()
1051:         LOCAL loc_cValor
1052:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value)
1053: 
1054:         IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
1055:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ""
1056:             RETURN
1057:         ENDIF
1058: 
1059:         IF USED("CsBases")
1060:             SELECT CsBases
1061:             SET ORDER TO Bases
1062:             IF SEEK(loc_cValor)
1063:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
1064:                 RETURN
1065:             ENDIF
1066:         ENDIF
1067: 
1068:         THIS.AbrirBuscaDtBase("DtBase")
1069:     ENDPROC
1070: 
1071:     *--------------------------------------------------------------------------
1072:     * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
1073:     *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE AbrirBuscaDtBase(par_cCampo)
1076:         LOCAL loc_oBusca, loc_oPag, loc_cSel
1077:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1078: 
1079:         IF !USED("CsBases")
1080:             MsgAviso("Datas base n" + CHR(227) + "o carregadas.", "Busca")
1081:             RETURN
1082:         ENDIF
1083: 
1084:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1085:         IF VARTYPE(loc_oBusca) != "O"
1086:             MsgErro("Erro ao abrir busca de datas base", "Erro")
1087:             RETURN
1088:         ENDIF
1089: 
1090:         loc_oBusca.this_cCursorDestino = "CsBases"
1091:         loc_oBusca.this_cTitulo        = "Data Base"
1092:         loc_oBusca.mAddColuna("Bases", "XXXXXXXXXX", "Data Base")
1093:         loc_oBusca.Show()
1094: 
1095:         IF loc_oBusca.this_lSelecionou AND USED("CsBases")
1096:             loc_cSel = ALLTRIM(CsBases.Bases)
1097:             IF par_cCampo = "DtBase"
1098:                 loc_oPag.txt_4c_DtBase.Value  = loc_cSel
1099:             ELSE
1100:                 loc_oPag.txt_4c_DtBasea.Value = loc_cSel
1101:             ENDIF
1102:         ENDIF
1103: 
1104:         loc_oBusca.Release()
1105:     ENDPROC
1106: 
1107:     *--------------------------------------------------------------------------
1108:     * TeclaDtBasea - KeyPress do campo Data Base Anterior (formato MM/YYYY)
1109:     *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
1110:     *--------------------------------------------------------------------------
1111:     PROCEDURE TeclaDtBasea(par_nKeyCode, par_nShift)
1112:         IF par_nKeyCode = 115
1113:             THIS.AbrirBuscaDtBase("DtBasea")
1114:         ELSE
1115:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1116:             THIS.ValidarDtBasea()
1117:             ENDIF
1118:         ENDIF
1119:     ENDPROC
1120: 
1121:     *--------------------------------------------------------------------------
1122:     * ValidarDtBasea - Valida Data Base Anterior contra cursor CsBases (MM/YYYY)
1123:     *--------------------------------------------------------------------------
1124:     PROCEDURE ValidarDtBasea()
1125:         LOCAL loc_cValor
1126:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value)
1127: 
1128:         IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
1129:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ""
1130:             RETURN
1131:         ENDIF
1132: 
1133:         IF USED("CsBases")
1134:             SELECT CsBases
1135:             SET ORDER TO Bases
1136:             IF SEEK(loc_cValor)
1137:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
1138:                 RETURN
1139:             ENDIF
1140:         ENDIF
1141: 
1142:         THIS.AbrirBuscaDtBase("DtBasea")
1143:     ENDPROC
1144: 
1145:     *--------------------------------------------------------------------------
1146:     * TeclaCdMoeda - KeyPress do campo codigo de moeda
1147:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
1148:     *--------------------------------------------------------------------------
1149:     PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
1150:         IF par_nKeyCode = 115
1151:             THIS.AbrirBuscaMoeda()
1152:         ELSE
1153:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1154:             THIS.ValidarCdMoeda()
1155:             ENDIF
1156:         ENDIF
1157:     ENDPROC
1158: 
1159:     *--------------------------------------------------------------------------
1160:     * ValidarCdMoeda - Valida codigo de moeda em CrSigCdMoe e preenche DMoes
1161:     *--------------------------------------------------------------------------
1162:     PROCEDURE ValidarCdMoeda()
1163:         LOCAL loc_cCodigo, loc_oPag
1164:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1165:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1166: 
1167:         IF EMPTY(loc_cCodigo)
1168:             loc_oPag.txt_4c__ds_moeda.Value = ""
1169:             RETURN
1170:         ENDIF
1171: 
1172:         IF USED("CrSigCdMoe")
1173:             SELECT CrSigCdMoe
1174:             SET ORDER TO CMoes
1175:             IF SEEK(loc_cCodigo)
1176:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1177:                 RETURN
1178:             ENDIF
1179:         ENDIF
1180: 
1181:         THIS.AbrirBuscaMoeda()
1182:     ENDPROC
1183: 
1184:     *--------------------------------------------------------------------------
1185:     * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
1186:     *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
1187:     *--------------------------------------------------------------------------
1188:     PROCEDURE AbrirBuscaMoeda()
1189:         LOCAL loc_oBusca, loc_cValor, loc_oPag
1190:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1191:         loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1192: 
1193:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1194:             "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
1195:             "Moeda")
1196: 
1197:         IF VARTYPE(loc_oBusca) != "O"
1198:             MsgErro("Erro ao abrir busca de moedas", "Erro")
1199:             RETURN
1200:         ENDIF
1201: 
1202:         IF loc_oBusca.this_lAchouRegistro
1203:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1204:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1205:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1206:             ENDIF
1207:         ELSE
1208:             loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
1209:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1210:             loc_oBusca.Show()
1211:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1212:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1213:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1214:             ENDIF
1215:         ENDIF
1216: 
1217:         loc_oBusca.Release()
1218:         IF USED("cursor_4c_BuscaMoe")
1219:             USE IN cursor_4c_BuscaMoe
1220:         ENDIF
1221:     ENDPROC
1222: 
1223:     *--------------------------------------------------------------------------
1224:     * TeclaDsMoeda - KeyPress do campo descricao de moeda
1225:     *   F4(115)/ENTER(13)/TAB(9): busca moeda por DMoes e preenche CMoes
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
1228:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1229:             THIS.ValidarDsMoeda()
1230:         ENDIF
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------
1234:     * ValidarDsMoeda - Busca moeda por descricao (DMoes) em CrSigCdMoe
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE ValidarDsMoeda()
1237:         LOCAL loc_cDesc, loc_oPag, loc_oBusca
1238:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1239:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
1240: 
1241:         IF EMPTY(loc_cDesc)
1242:             loc_oPag.txt_4c__cd_moeda.Value = ""
1243:             loc_oPag.txt_4c__ds_moeda.Value = ""
1244:             RETURN
1245:         ENDIF
1246: 
1247:         IF USED("CrSigCdMoe")
1248:             SELECT CrSigCdMoe
1249:             LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
1250:             IF FOUND()
1251:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
1252:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
1253:                 RETURN
1254:             ENDIF
1255:         ENDIF
1256: 
1257:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1258:             "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
1259:             "Moeda")
1260: 
1261:         IF VARTYPE(loc_oBusca) != "O"
1262:             RETURN
1263:         ENDIF
1264: 
1265:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1266:             loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1267:             loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1268:         ELSE
1269:             IF !loc_oBusca.this_lAchouRegistro
1270:             loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
1271:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1272:             loc_oBusca.Show()
1273:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1274:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1275:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
1276:             ENDIF
1277:             ENDIF
1278:         ENDIF
1279: 
1280:         loc_oBusca.Release()
1281:         IF USED("cursor_4c_BuscaMoe")
1282:             USE IN cursor_4c_BuscaMoe
1283:         ENDIF
1284:     ENDPROC
1285: 
1286:     *--------------------------------------------------------------------------
1287:     * TeclaCdGrEstoque - KeyPress do campo codigo do grupo de estoque
1288:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdGcr
1289:     *--------------------------------------------------------------------------
1290:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
1291:         IF par_nKeyCode = 115
1292:             THIS.AbrirBuscaGrEstoque()
1293:         ELSE
1294:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1295:             THIS.ValidarCdGrEstoque()
1296:             ENDIF
1297:         ENDIF
1298:     ENDPROC
1299: 
1300:     *--------------------------------------------------------------------------
1301:     * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
1302:     *   Equivalente ao fAcessoContab(Usuar,'C',...) do sistema legado
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE ValidarCdGrEstoque()
1305:         LOCAL loc_cCodigo, loc_oPag, loc_cSQL, loc_nResult
1306:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1307:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1308: 
1309:         IF EMPTY(loc_cCodigo)
1310:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
1311:             RETURN
1312:         ENDIF
1313: 
1314:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
1315:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1316: 
1317:         IF loc_nResult > 0
1318:             SELECT cursor_4c_ValGrEst
1319:             IF !EOF()
1320:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1321:                 USE IN cursor_4c_ValGrEst
1322:                 RETURN
1323:             ENDIF
1324:             IF USED("cursor_4c_ValGrEst")
1325:                 USE IN cursor_4c_ValGrEst
1326:             ENDIF
1327:         ENDIF
1328: 
1329:         THIS.AbrirBuscaGrEstoque()
1330:     ENDPROC
1331: 
1332:     *--------------------------------------------------------------------------
1333:     * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque
1334:     *   Tabela: SigCdGcr | Cod: codigos | Desc: descrs
1335:     *--------------------------------------------------------------------------
1336:     PROCEDURE AbrirBuscaGrEstoque()
1337:         LOCAL loc_oBusca, loc_cValor, loc_oPag
1338:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1339:         loc_cValor = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1340: 
1341:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1342:             "SigCdGcr", "cursor_4c_BuscaGrEst", "codigos", loc_cValor, ;
1343:             "Grupo de Estoque")
1344: 
1345:         IF VARTYPE(loc_oBusca) != "O"
1346:             MsgErro("Erro ao abrir busca de grupos de estoque", "Erro")
1347:             RETURN
1348:         ENDIF
1349: 
1350:         IF loc_oBusca.this_lAchouRegistro
1351:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1352:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1353:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1354:             ENDIF
1355:         ELSE
1356:             loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1357:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1358:             loc_oBusca.Show()
1359:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1360:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1361:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1362:             ENDIF
1363:         ENDIF
1364: 
1365:         loc_oBusca.Release()
1366:         IF USED("cursor_4c_BuscaGrEst")
1367:             USE IN cursor_4c_BuscaGrEst
1368:         ENDIF
1369:     ENDPROC
1370: 
1371:     *--------------------------------------------------------------------------
1372:     * TeclaDsGrEstoque - KeyPress do campo descricao do grupo de estoque
1373:     *   F4(115)/ENTER(13)/TAB(9): busca grupo por descrs e preenche codigos
1374:     *--------------------------------------------------------------------------
1375:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
1376:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1377:             THIS.ValidarDsGrEstoque()
1378:         ENDIF
1379:     ENDPROC
1380: 
1381:     *--------------------------------------------------------------------------
1382:     * ValidarDsGrEstoque - Busca grupo de estoque por descricao em SigCdGcr
1383:     *   Equivalente ao fAcessoContab(Usuar,'D',...) do sistema legado
1384:     *--------------------------------------------------------------------------
1385:     PROCEDURE ValidarDsGrEstoque()
1386:         LOCAL loc_cDesc, loc_oPag, loc_oBusca, loc_cSQL, loc_nResult
1387:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1388:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)
1389: 
1390:         IF EMPTY(loc_cDesc)
1391:             loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
1392:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
1393:             RETURN
1394:         ENDIF
1395: 
1396:         loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
1397:                       UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
1398:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
1399: 
1400:         IF loc_nResult > 0
1401:             SELECT cursor_4c_ValGrEst
1402:             IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
1403:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
1404:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
1405:                 USE IN cursor_4c_ValGrEst
1406:                 RETURN
1407:             ENDIF
1408:             IF USED("cursor_4c_ValGrEst")
1409:                 USE IN cursor_4c_ValGrEst
1410:             ENDIF
1411:         ENDIF
1412: 
1413:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1414:             "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
1415:             "Grupo de Estoque")
1416: 
1417:         IF VARTYPE(loc_oBusca) != "O"
1418:             RETURN
1419:         ENDIF
1420: 
1421:         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1422:             loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1423:             loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1424:         ELSE
1425:             IF !loc_oBusca.this_lAchouRegistro
1426:             loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1427:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1428:             loc_oBusca.Show()
1429:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
1430:                 loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
1431:                 loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
1432:             ENDIF
1433:             ENDIF
1434:         ENDIF
1435: 
1436:         loc_oBusca.Release()
1437:         IF USED("cursor_4c_BuscaGrEst")
1438:             USE IN cursor_4c_BuscaGrEst
1439:         ENDIF
1440:     ENDPROC
1441: 
1442:     *--------------------------------------------------------------------------
1443:     * TeclaCdEstoque - KeyPress do campo codigo da conta de estoque
1444:     *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdBal
1445:     *--------------------------------------------------------------------------
1446:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShift)
1447:         IF par_nKeyCode = 115
1448:             THIS.AbrirBuscaEstoque()
1449:         ELSE
1450:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1451:             THIS.ValidarCdEstoque()
1452:             ENDIF
1453:         ENDIF
1454:     ENDPROC
1455: 
1456:     *--------------------------------------------------------------------------
1457:     * ValidarCdEstoque - Valida codigo de conta de estoque em SigCdBal
1458:     *   Equivalente ao fAcessoContas(Usuar,Grupo,'C',...) do sistema legado
1459:     *   Filtra por Grupos se o campo de grupo estiver preenchido
1460:     *--------------------------------------------------------------------------
1461:     PROCEDURE ValidarCdEstoque()
1462:         LOCAL loc_cCodigo, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
1463:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1464:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
1465:         loc_cGrupo  = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1466: 
1467:         IF EMPTY(loc_cCodigo)
1468:             loc_oPag.txt_4c_Ds_Estoque.Value = ""
1469:             RETURN
1470:         ENDIF
1471: 
1472:         loc_cSQL    = "SELECT DISTINCT Contas FROM SigCdBal"
1473:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
1474: 
1475:         IF loc_nResult > 0
1476:             SELECT cursor_4c_ValEst
1477:             IF !EOF()
1478:                 loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
1479:                 USE IN cursor_4c_ValEst
1480:                 RETURN
1481:             ENDIF
1482:             IF USED("cursor_4c_ValEst")
1483:                 USE IN cursor_4c_ValEst
1484:             ENDIF
1485:         ENDIF
1486: 
1487:         THIS.AbrirBuscaEstoque()
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque
1492:     *   Busca contas distintas em SigCdBal filtradas pelo grupo selecionado
1493:     *   Equivalente ao fAcessoContas(Usuar,Grupo,...) do sistema legado
1494:     *--------------------------------------------------------------------------
1495:     PROCEDURE AbrirBuscaEstoque()
1496:         LOCAL loc_oBusca, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
1497:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1498:         loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1499: 
1500:         loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal ORDER BY Contas"
1501:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1502: 
1503:         IF loc_nResult < 1
1504:             MsgErro("Erro ao buscar contas de estoque", "Erro")
1505:             RETURN
1506:         ENDIF
1507: 
1508:         SELECT cursor_4c_BuscaEst
1509:         GO TOP
1510: 
1511:         IF EOF()
1512:             MsgAviso("Nenhuma conta encontrada" + ;
1513:                 IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
1514:                 "Busca")
1515:             USE IN cursor_4c_BuscaEst
1516:             RETURN
1517:         ENDIF
1518: 
1519:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1520:         IF VARTYPE(loc_oBusca) != "O"
1521:             MsgErro("Erro ao abrir busca de contas", "Erro")
1522:             USE IN cursor_4c_BuscaEst
1523:             RETURN
1524:         ENDIF
1525: 
1526:         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEst"
1527:         loc_oBusca.this_cTitulo        = "Conta de Estoque"
1528:         loc_oBusca.mAddColuna("Contas", "XXXXXXXX", "Conta")
1529:         loc_oBusca.Show()
1530: 
1531:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEst")
1532:             loc_oPag.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
1533:             loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
1534:         ENDIF
1535: 
1536:         loc_oBusca.Release()
1537:         IF USED("cursor_4c_BuscaEst")
1538:             USE IN cursor_4c_BuscaEst
1539:         ENDIF
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * TeclaDsEstoque - KeyPress do campo descricao da conta de estoque
1544:     *   F4(115)/ENTER(13)/TAB(9): abre busca de contas de estoque
1545:     *--------------------------------------------------------------------------
1546:     PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShift)
1547:         IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
1548:             THIS.ValidarDsEstoque()
1549:         ENDIF
1550:     ENDPROC
1551: 
1552:     *--------------------------------------------------------------------------
1553:     * ValidarDsEstoque - Busca conta de estoque por valor digitado na descricao
1554:     *   Como Contas nao tem descricao separada, abre lookup para selecao
1555:     *--------------------------------------------------------------------------
1556:     PROCEDURE ValidarDsEstoque()
1557:         LOCAL loc_cDesc, loc_oPag
1558:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1559:         loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)
1560: 
1561:         IF EMPTY(loc_cDesc)
1562:             loc_oPag.txt_4c_Cd_Estoque.Value = ""
1563:             loc_oPag.txt_4c_Ds_Estoque.Value = ""
1564:             RETURN
1565:         ENDIF
1566: 
1567:         THIS.AbrirBuscaEstoque()
1568:     ENDPROC
1569: 
1570:     *--------------------------------------------------------------------------
1571:     * TeclaIBarra - KeyPress do campo numero de barra/etiqueta
1572:     *   ENTER(13)/TAB(9): valida numero em SigOpEtq
1573:     *--------------------------------------------------------------------------
1574:     PROCEDURE TeclaIBarra(par_nKeyCode, par_nShift)
1575:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1576:             THIS.ValidarIBarra()
1577:         ENDIF
1578:     ENDPROC
1579: 
1580:     *--------------------------------------------------------------------------
1581:     * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
1582:     *   Equivalente ao Valid original de GetiBarra:
1583:     *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
1584:     *--------------------------------------------------------------------------
1585:     PROCEDURE ValidarIBarra()
1586:         LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
1587:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1588:         loc_nBarra = loc_oPag.txt_4c_IBarra.Value
1589: 
1590:         IF loc_nBarra = 0
1591:             RETURN
1592:         ENDIF
1593: 
1594:         loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
1595:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")
1596: 
1597:         IF loc_nResult > 0
1598:             SELECT cursor_4c_ValBarra
1599:             IF EOF()
1600:                 IF USED("cursor_4c_ValBarra")
1601:                     USE IN cursor_4c_ValBarra
1602:                 ENDIF
1603:                 MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
1604:                     "Valida" + CHR(231) + CHR(227) + "o")
1605:                 loc_oPag.txt_4c_IBarra.Value = 0
1606:                 RETURN
1607:             ENDIF
1608:             IF USED("cursor_4c_ValBarra")
1609:                 USE IN cursor_4c_ValBarra
1610:             ENDIF
1611:         ELSE
1612:             MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
1613:         ENDIF
1614:     ENDPROC
1615: 
1616:     *--------------------------------------------------------------------------
1617:     * FormParaRelatorio - Transfere valores dos filtros do form para o BO
1618:     *   Chamado antes de Visualizar() ou Imprimir()
1619:     *--------------------------------------------------------------------------
1620:     PROTECTED PROCEDURE FormParaRelatorio()
1621:         LOCAL loc_oPag
1622:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1623: 
1624:         WITH THIS.this_oRelatorio
1625:             .this_nTipo        = loc_oPag.obj_4c_OptGtprel.Value
1626:             .this_cDtBase      = ALLTRIM(loc_oPag.txt_4c_DtBase.Value)
1627:             .this_cDtBaseA     = ALLTRIM(loc_oPag.txt_4c_DtBasea.Value)
1628:             .this_cCdEmpresa   = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
1629:             .this_cDsEmpresa   = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)
1630:             .this_cCdMoeda     = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
1631:             .this_cDsMoeda     = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
1632:             .this_cCdGrEstoque = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
1633:             .this_cDsGrEstoque = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)
1634:             .this_cCdEstoque   = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
1635:             .this_cDsEstoque   = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)
1636:             .this_nIBarra      = loc_oPag.txt_4c_IBarra.Value
1637:         ENDWITH
1638:     ENDPROC
1639: 
1640:     *--------------------------------------------------------------------------
1641:     * ValidarFiltros - Verifica campos obrigatorios antes de gerar relatorio
1642:     *   Equivalente as validacoes do Click original do botao de relatorio
1643:     *--------------------------------------------------------------------------
1644:     PROTECTED FUNCTION ValidarFiltros()
1645:         LOCAL loc_nTipo, loc_oPag
1646:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
1647:         loc_nTipo = loc_oPag.obj_4c_OptGtprel.Value
1648: 
1649:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_DtBase.Value)) OR ;
1650:            ALLTRIM(loc_oPag.txt_4c_DtBase.Value) = "  /    "
1651:             MsgAviso("Data Base Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1652:             loc_oPag.txt_4c_DtBase.SetFocus
1653:             RETURN .F.
1654:         ENDIF
1655: 
1656:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)) AND ;
1657:            INLIST(loc_nTipo, 1, 2)
1658:             MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1659:             loc_oPag.txt_4c__cd_moeda.SetFocus
1660:             RETURN .F.
1661:         ENDIF
1662: 
1663:         IF loc_nTipo = 1
1664:             IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Empresa.Value))
1665:                 MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1666:                 loc_oPag.txt_4c_Empresa.SetFocus
1667:                 RETURN .F.
1668:             ENDIF
1669:         ENDIF
1670: 
1671:         IF loc_nTipo = 3
1672:             IF loc_oPag.txt_4c_IBarra.Value = 0
1673:                 MsgAviso("N" + CHR(250) + "mero de Barra Inv" + CHR(225) + "lido !!!", ;
1674:                     "Campo Obrigat" + CHR(243) + "rio")
1675:                 loc_oPag.txt_4c_IBarra.SetFocus
1676:                 RETURN .F.
1677:             ENDIF
1678:         ENDIF
1679: 
1680:         RETURN .T.
1681:     ENDFUNC
1682: 
1683:     *--------------------------------------------------------------------------
1684:     * BtnVisualizarClick - Visualiza relatorio em tela (preview)
1685:     *   Equivalente ao btnReport.Visualiza.Click original
1686:     *--------------------------------------------------------------------------
1687:     PROCEDURE BtnVisualizarClick()
1688:         IF !THIS.ValidarFiltros()
1689:             RETURN
1690:         ENDIF
1691:         THIS.FormParaRelatorio()
1692:         IF !THIS.this_oRelatorio.Visualizar()
1693:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1694:         ENDIF
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * BtnImprimirClick - Envia relatorio para impressora
1699:     *   Equivalente ao btnReport.Imprime.Click original
1700:     *--------------------------------------------------------------------------
1701:     PROCEDURE BtnImprimirClick()
1702:         IF !THIS.ValidarFiltros()
1703:             RETURN
1704:         ENDIF
1705:         THIS.FormParaRelatorio()
1706:         IF !THIS.this_oRelatorio.Imprimir()
1707:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1708:         ENDIF
1709:     ENDPROC
1710: 
1711:     *--------------------------------------------------------------------------
1712:     * BtnExcelClick - Exporta dados do relatorio para planilha Excel
1713:     *   Equivalente ao btnReport.DocExcel.Click original
1714:     *--------------------------------------------------------------------------
1715:     PROCEDURE BtnExcelClick()
1716:         IF !THIS.ValidarFiltros()
1717:             RETURN
1718:         ENDIF
1719:         THIS.FormParaRelatorio()
1720:         IF !THIS.this_oRelatorio.PrepararDados()
1721:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1722:             RETURN
1723:         ENDIF
1724:         IF !USED("CsRelatorio")
1725:             MsgAviso("Nenhum dado para exportar.", "Excel")
1726:             RETURN
1727:         ENDIF
1728:         LOCAL loc_cArquivo
1729:         loc_cArquivo = GETFILE("XLS", "Salvar como...", "Salvar", 0, "Exportar para Excel")
1730:         IF EMPTY(loc_cArquivo)
1731:             RETURN
1732:         ENDIF
1733:         COPY TO (loc_cArquivo) TYPE XLS
1734:         MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
1735:     ENDPROC
1736: 
1737:     *--------------------------------------------------------------------------
1738:     * BtnEncerrarClick - Fecha o formulario
1739:     *   Equivalente ao btnReport.Sair.Click original (Cancel=.T. ja trata ESC)
1740:     *--------------------------------------------------------------------------
1741:     PROCEDURE BtnEncerrarClick()
1742:         THIS.Release()
1743:     ENDPROC
1744: 
1745:     *--------------------------------------------------------------------------
1746:     * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
1747:     *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
1748:     *--------------------------------------------------------------------------
1749:     PROCEDURE CmdSelempClick()
1750:         IF USED("CsSigCdEmp")
1751:             SELECT CsSigCdEmp
1752:             REPLACE ALL lMarca WITH 1
1753:             GO TOP
1754:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1755:         ENDIF
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
1760:     *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
1761:     *--------------------------------------------------------------------------
1762:     PROCEDURE CmdApgEmpClick()
1763:         IF USED("CsSigCdEmp")
1764:             SELECT CsSigCdEmp
1765:             REPLACE ALL lMarca WITH 0
1766:             GO TOP
1767:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
1768:         ENDIF
1769:     ENDPROC
1770: 
1771:     *==========================================================================
1772:     * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
1773:     *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
1774:     *   metodos existem para compatibilidade com o pipeline generico do sistema
1775:     *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
1776:     *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
1777:     *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
1778:     *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
1779:     *==========================================================================
1780: 
1781:     *--------------------------------------------------------------------------
1782:     * BtnIncluirClick - Em REPORT delega para Visualizar (gerar relatorio)
1783:     *--------------------------------------------------------------------------
1784:     PROCEDURE BtnIncluirClick()
1785:         THIS.BtnVisualizarClick()
1786:     ENDPROC
1787: 
1788:     *--------------------------------------------------------------------------
1789:     * BtnAlterarClick - Em REPORT limpa filtros e devolve foco ao 1o campo
1790:     *--------------------------------------------------------------------------
1791:     PROCEDURE BtnAlterarClick()
1792:         LOCAL loc_oErro
1793:         THIS.LimparCampos()
1794:         TRY
1795:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.SetFocus()
1796:         CATCH TO loc_oErro
1797:             MsgErro(loc_oErro.Message, "Erro")
1798:         ENDTRY
1799:     ENDPROC
1800: 
1801:     *--------------------------------------------------------------------------
1802:     * BtnExcluirClick - Em REPORT delega para LimparCampos (excluir = limpar)
1803:     *--------------------------------------------------------------------------
1804:     PROCEDURE BtnExcluirClick()
1805:         THIS.LimparCampos()
1806:     ENDPROC
1807: 
1808:     *--------------------------------------------------------------------------
1809:     * BtnBuscarClick - Em REPORT busca = visualizar relatorio em tela
1810:     *--------------------------------------------------------------------------
1811:     PROCEDURE BtnBuscarClick()
1812:         THIS.BtnVisualizarClick()
1813:     ENDPROC
1814: 
1815:     *--------------------------------------------------------------------------
1816:     * BtnSalvarClick - Em REPORT salvar = imprimir relatorio
1817:     *--------------------------------------------------------------------------
1818:     PROCEDURE BtnSalvarClick()
1819:         THIS.BtnImprimirClick()
1820:     ENDPROC
1821: 
1822:     *--------------------------------------------------------------------------
1823:     * BtnCancelarClick - Em REPORT cancelar = limpar todos os filtros
1824:     *--------------------------------------------------------------------------
1825:     PROCEDURE BtnCancelarClick()
1826:         THIS.LimparCampos()
1827:     ENDPROC
1828: 
1829:     *--------------------------------------------------------------------------
1830:     * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
1831:     *   Transfere valores dos filtros do form para as propriedades do BO
1832:     *--------------------------------------------------------------------------
1833:     PROCEDURE FormParaBO()
1834:         THIS.FormParaRelatorio()
1835:     ENDPROC
1836: 
1837:     *--------------------------------------------------------------------------
1838:     * BOParaForm - Carrega propriedades do BO de volta nos campos do form
1839:     *   Em REPORT, os filtros sao definidos pelo usuario; BO nao tem estado
1840:     *   persistente a recarregar. Metodo existe para compatibilidade de pipeline.
1841:     *--------------------------------------------------------------------------
1842:     PROCEDURE BOParaForm()
1843:         LOCAL loc_oPag
1844:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1845: 
1846:         WITH THIS.this_oRelatorio
1847:             loc_oPag.obj_4c_OptGtprel.Value     = .this_nTipo
1848:             loc_oPag.txt_4c_DtBase.Value        = .this_cDtBase
1849:             loc_oPag.txt_4c_DtBasea.Value       = .this_cDtBaseA
1850:             loc_oPag.txt_4c_Empresa.Value       = .this_cCdEmpresa
1851:             loc_oPag.txt_4c_Dempresa.Value      = .this_cDsEmpresa
1852:             loc_oPag.txt_4c__cd_moeda.Value     = .this_cCdMoeda
1853:             loc_oPag.txt_4c__ds_moeda.Value     = .this_cDsMoeda
1854:             loc_oPag.txt_4c__Cd_GrEstoque.Value = .this_cCdGrEstoque
1855:             loc_oPag.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
1856:             loc_oPag.txt_4c_Cd_Estoque.Value    = .this_cCdEstoque
1857:             loc_oPag.txt_4c_Ds_Estoque.Value    = .this_cDsEstoque
1858:             loc_oPag.txt_4c_IBarra.Value        = .this_nIBarra
1859:         ENDWITH
1860: 
1861:         THIS.AjustarVisibilidadePorTipo()
1862:     ENDPROC
1863: 
1864:     *--------------------------------------------------------------------------
1865:     * HabilitarCampos - Habilita ou desabilita controles de filtro
1866:     *   Em REPORT todos os filtros ficam sempre editaveis (sem modo VISUALIZAR)
1867:     *   par_lHabilitar: .T. para habilitar, .F. para desabilitar
1868:     *--------------------------------------------------------------------------
1869:     PROCEDURE HabilitarCampos(par_lHabilitar)
1870:         LOCAL loc_oPag
1871:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1872: 
1873:         loc_oPag.obj_4c_OptGtprel.Enabled     = par_lHabilitar
1874:         loc_oPag.txt_4c_IBarra.Enabled        = par_lHabilitar
1875:         loc_oPag.txt_4c_Empresa.Enabled       = par_lHabilitar
1876:         loc_oPag.txt_4c_Dempresa.Enabled      = par_lHabilitar
1877:         loc_oPag.txt_4c_DtBase.Enabled        = par_lHabilitar
1878:         loc_oPag.txt_4c_DtBasea.Enabled       = par_lHabilitar
1879:         loc_oPag.txt_4c__cd_moeda.Enabled     = par_lHabilitar
1880:         loc_oPag.txt_4c__ds_moeda.Enabled     = par_lHabilitar
1881:         loc_oPag.txt_4c__Cd_GrEstoque.Enabled = par_lHabilitar
1882:         loc_oPag.txt_4c__Ds_GrEstoque.Enabled = par_lHabilitar
1883:         loc_oPag.txt_4c_Cd_Estoque.Enabled    = par_lHabilitar
1884:         loc_oPag.txt_4c_Ds_Estoque.Enabled    = par_lHabilitar
1885:     ENDPROC
1886: 
1887:     *--------------------------------------------------------------------------
1888:     * CarregarLista - Em REPORT nao ha lista; recarrega grid de empresas se aberto
1889:     *   Chamado quando tipo=2 (Sint" + CHR(233) + "tico) e grid de empresas precisa ser atualizado
1890:     *--------------------------------------------------------------------------
1891:     PROCEDURE CarregarLista()
1892:         LOCAL loc_oGrd, loc_oPag
1893:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1894:         loc_oGrd = loc_oPag.grd_4c_Dados
1895: 
1896:         IF USED("CsSigCdEmp")
1897:             loc_oGrd.RecordSource          = "CsSigCdEmp"
1898:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1899:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1900:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1901:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1902:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1903:             loc_oGrd.Refresh
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
1909:     *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
1910:     *--------------------------------------------------------------------------
1911:     PROCEDURE AjustarBotoesPorModo()
1912:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1913:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1914:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1915:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1916:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1917:         ENDIF
1918:     ENDPROC
1919: 
1920: ENDDEFINE


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
            SET NULL ON
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

            SET NULL OFF
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


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (49)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_BOTOES. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] OptionGroup 'opt_4c_Pagos' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Opcao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_CotEm' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Cancs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Concs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Prorrogs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_FilGrd2' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTokenSerializado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterRazaoSocial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DataFimDiaSQL()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NAVEGACAO-PAGINA] Metodo 'BtnCancelarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Top original=158 vs migrado 'lbl_4c_Say17' Top=262 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=122 vs migrado 'lbl_4c_Say17' Left=451 (diff=329px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=119 vs migrado 'lbl_4c_Say20' Left=440 (diff=321px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'getFiltros' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=190 vs migrado 'obj_4c_GetFiltros' Left=510 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Top original=335 vs migrado 'cmd_4c_ApagaG2' Top=648 (diff=313px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say25' Top=210 (diff=384px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=212 vs migrado 'lbl_4c_Say25' Left=456 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=646 vs migrado 'lbl_4c_Say9' Top=369 (diff=277px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say9' Left=124 (diff=416px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=648 vs migrado 'lbl_4c_Say8' Top=349 (diff=299px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=362 vs migrado 'lbl_4c_Say8' Left=109 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=619 vs migrado 'lbl_4c_Say7' Top=287 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say7' Left=108 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say6' Top=262 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=366 vs migrado 'lbl_4c_Say6' Left=90 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=592 vs migrado 'lbl_4c_Say5' Top=329 (diff=263px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say5' Left=146 (diff=394px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say3' Top=308 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=403 vs migrado 'lbl_4c_Say3' Left=123 (diff=280px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=566 vs migrado 'lbl_4c_Say20' Top=158 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say20' Left=440 (diff=100px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=568 vs migrado 'lbl_4c_Say17' Top=262 (diff=306px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=403 vs migrado 'lbl_4c_Say17' Left=451 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say20' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say20' Top=158 (diff=436px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say20' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=23 vs migrado 'lbl_4c_Say20' Left=440 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say13' Top=210 (diff=411px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=207 vs migrado 'lbl_4c_Say13' Left=145 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=643 vs migrado 'cnt_4c_Botoes' Top=1 (diff=642px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=199 vs migrado 'cnt_4c_Botoes' Left=1 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=152 vs migrado 'lbl_4c_Say11' Top=236 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=511 vs migrado 'lbl_4c_Say11' Left=436 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=648 vs migrado 'lbl_4c_Say10' Top=388 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=19 vs migrado 'lbl_4c_Say10' Left=118 (diff=99px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=568 vs migrado 'lbl_4c_Say4' Top=133 (diff=435px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=34 vs migrado 'lbl_4c_Say4' Left=466 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say12' Top=184 (diff=437px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=17 vs migrado 'lbl_4c_Say12' Left=434 (diff=417px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5909 linhas total):

*-- Linhas 57 a 320:
57: 
58:     *--------------------------------------------------------------------------
59:     * Guarda de reentrancia dos lookups de Page1 (regra #37/#47 do CLAUDE.md) -
60:     * o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que
61:     * redispara o proprio LostFocus; a flag eh ligada dentro de cada
62:     * AbrirLookup*, que eh o funil de todas as entradas daquele campo.
63:     *--------------------------------------------------------------------------
64:     this_lEmLookup = .F.
65: 
66:     *--------------------------------------------------------------------------
67:     * Guarda de "valor nao mudou" dos lookups de LostFocus de Page1 - no
68:     * legado o Valid so dispara quando o valor MUDA, mas LostFocus dispara
69:     * SEMPRE que o campo perde o foco (ex.: usuario so navega com Tab sem
70:     * alterar nada). Sem isto, cada LostFocus reabre a consulta ao SQL
71:     * Server mesmo sem mudanca no campo.
72:     *--------------------------------------------------------------------------
73:     this_cUltimoValidarCMoesValidado           = ""
74:     this_cUltimoValidarDMoesValidado           = ""
75:     this_cUltimoValidarCMoesCValidado          = ""
76:     this_cUltimoValidarDMoesCValidado          = ""
77:     this_cUltimoValidarMoeSaldoValidado        = ""
78:     this_cUltimoValidarCFPublisValidado        = ""
79:     this_cUltimoValidarDFPublisValidado        = ""
80:     this_cUltimoValidarEspecieNfsFiltroValidado = ""
81:     this_cUltimoValidarTitBansFiltroValidado   = ""
82: 
83:     *--------------------------------------------------------------------------
84:     * Init - Chama FormBase.Init() que dispara InicializarForm()
85:     *--------------------------------------------------------------------------
86:     PROCEDURE Init()
87:         RETURN DODEFAULT()
88:     ENDPROC
89: 
90:     *--------------------------------------------------------------------------
91:     * InicializarForm - Cria o Business Object e monta a estrutura base
92:     * (PageFrame com as 2 paginas). Grid, filtros, botoes e eventos sao
93:     * adicionados nas fases seguintes.
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE InicializarForm()
96:         LOCAL loc_lSucesso, loc_oErro
97:         loc_lSucesso = .F.
98: 
99:         TRY
100:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCGFBO")
101: 
102:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
103:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPCGFBO", "Erro")
104:             ELSE
105:                 THIS.ConfigurarPageFrame()
106:                 THIS.CriarCursoresFiltros()
107:                 THIS.ConfigurarPaginaFiltros()
108:                 THIS.ConfigurarPaginaDados()
109: 
110:                 THIS.pgf_4c_Paginas.Visible    = .T.
111:                 THIS.pgf_4c_Paginas.ActivePage = 1
112:                 THIS.this_cModoAtual           = "FILTROS"
113: 
114:                 THIS.TornarControlesVisiveis(THIS)
115: 
116:                 *-- Aplica o contrato de digitacao dos PROCEDURE When do
117:                 *-- legado (filtros digitaveis na Page1; campos de detalhe da
118:                 *-- Page2 somente exibicao) - ver HabilitarCampos().
119:                 THIS.HabilitarCampos(.T.)
120: 
121:                 *-- SQL de carga (tipos de operacao + filtros nomeados salvos)
122:                 *-- fica fora do modo de validacao de UI/teste automatizado,
123:                 *-- igual ao padrao CarregarLista() dos forms CRUD.
124:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
125:                    (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
126:                     THIS.CarregarTiposOperacao()
127:                     THIS.CarregarFiltrosSalvos()
128:                 ENDIF
129: 
130:                 loc_lSucesso = .T.
131:             ENDIF
132:         CATCH TO loc_oErro
133:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
134:                     " PROC=" + loc_oErro.Procedure, "Erro")
135:         ENDTRY
136: 
137:         RETURN loc_lSucesso
138:     ENDPROC
139: 
140:     *--------------------------------------------------------------------------
141:     * ConfigurarPageFrame - Cria o PageFrame com as 2 paginas (Filtros/Dados).
142:     * Abas OCULTAS (Tabs = .F., como no legado) - a navegacao entre paginas eh
143:     * feita pelos CommandGroups cmgFiltros/cmgRetornar, criados na Fase 4.
144:     *--------------------------------------------------------------------------
145:     PROTECTED PROCEDURE ConfigurarPageFrame()
146:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
147: 
148:         WITH THIS.pgf_4c_Paginas
149:             .Top       = 0
150:             .Left      = 0
151:             .Width     = THIS.Width
152:             .Height    = THIS.Height
153:             .PageCount = 2
154:             .Tabs      = .F.
155:             .Visible   = .F.
156: 
157:             .Page1.Caption   = "Filtros"
158:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
159:             .Page1.FontName  = "Verdana"
160:             .Page1.FontSize  = 8
161:             .Page1.FontBold  = .T.
162:             .Page1.BackColor = RGB(255, 255, 255)
163:             .Page1.ForeColor = RGB(36, 84, 155)
164: 
165:             .Page2.Caption   = "Dados"
166:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
167:             .Page2.FontName  = "Verdana"
168:             .Page2.FontSize  = 8
169:             .Page2.FontBold  = .T.
170:             .Page2.BackColor = RGB(255, 255, 255)
171:             .Page2.ForeColor = RGB(36, 84, 155)
172:         ENDWITH
173:     ENDPROC
174: 
175:     *--------------------------------------------------------------------------
176:     * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
177:     * controles filhos (Pages de PageFrame + Controls de Container). AddObject
178:     * cria os controles com Visible=.F. por padrao.
179:     *--------------------------------------------------------------------------
180:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
181:         LOCAL loc_nI, loc_nP, loc_oControl
182: 
183:         FOR loc_nI = 1 TO par_oContainer.ControlCount
184:             loc_oControl = par_oContainer.Controls(loc_nI)
185: 
186:             IF VARTYPE(loc_oControl) = "O"
187:                 *-- Controles deliberadamente ocultos no Init (toggle de UI
188:                 *-- do legado - txt_4c_NewFiltro so aparece apos CmdAddFiltroClick,
189:                 *-- no mesmo Top/Left de txt_4c_Filtros) NAO podem ser forcados a
190:                 *-- Visible=.T. por este metodo recursivo, senao os dois ficam
191:                 *-- sobrepostos e visiveis desde a abertura do form.
192:                 IF !INLIST(UPPER(loc_oControl.Name), "TXT_4C_NEWFILTRO")
193:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
194:                         loc_oControl.Visible = .T.
195:                     ENDIF
196:                 ENDIF
197: 
198:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
199:                     FOR loc_nP = 1 TO loc_oControl.PageCount
200:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
201:                     ENDFOR
202:                 ENDIF
203: 
204:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
205:                     THIS.TornarControlesVisiveis(loc_oControl)
206:                 ENDIF
207:             ENDIF
208:         ENDFOR
209:     ENDPROC
210: 
211:     *==========================================================================
212:     * FASE 4 - Page1 (pgFiltros): cursores de trabalho, grid completo
213:     * (grdTipo + Grd_Clientes + Grd_Clientes2) e botoes CRUD de linha/filtro.
214:     * Nomes e geometria transcritos de tasks\task691\SIGOPCGF_form_codigo_
215:     * fonte.txt (SECAO 2: PROPRIEDADES CUSTOMIZADAS). AlternarPagina() navega
216:     * entre Filtros/Dados; a consulta financeira completa (LocalDados) e o
217:     * grid/botoes da Page2 ficam para a fase seguinte.
218:     *==========================================================================
219: 
220:     *--------------------------------------------------------------------------
221:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
222:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
223:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
224:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
225:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
226:     *--------------------------------------------------------------------------
227:     PROTECTED PROCEDURE CriarCursoresFiltros()
228:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
229: 
230:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
231:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
232:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
233:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
234: 
235:         IF !USED(loc_cTipos)
236:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
237:             INDEX ON Dopes TAG Dopes
238:         ENDIF
239: 
240:         IF !USED(loc_cClientes)
241:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
242:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
243:             SELECT (loc_cClientes)
244:             APPEND BLANK
245:         ENDIF
246: 
247:         IF !USED(loc_cClientes2)
248:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
249:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
250:             SELECT (loc_cClientes2)
251:             APPEND BLANK
252:         ENDIF
253: 
254:         IF !USED(loc_cFiltros)
255:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
256:         ENDIF
257:     ENDPROC
258: 
259:     *--------------------------------------------------------------------------
260:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
261:     * campos de filtro, OptionGroups, grades e botoes).
262:     *--------------------------------------------------------------------------
263:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
264:         LOCAL loc_oPag
265:         loc_oPag = THIS.pgf_4c_Paginas.Page1
266: 
267:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
268:         THIS.ConfigurarCamposFiltros(loc_oPag)
269:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
270:         THIS.ConfigurarGradesFiltros(loc_oPag)
271:         THIS.ConfigurarBotoesFiltros(loc_oPag)
272:     ENDPROC
273: 
274:     *--------------------------------------------------------------------------
275:     * ConfigurarCabecalhoFiltros - Faixa de titulo (cntSombra) + CommandGroup
276:     * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
277:     * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
278:     * cadastro_sair_60.jpg.
279:     *--------------------------------------------------------------------------
280:     PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
281:         par_oPag.AddObject("cnt_4c_Sombra", "Container")
282:         WITH par_oPag.cnt_4c_Sombra
283:             .Top         = 0
284:             .Left        = 0
285:             .Width       = THIS.Width
286:             .Height      = 80
287:             .BackColor   = RGB(100, 100, 100)
288:             .BorderWidth = 0
289: 
290:             .AddObject("lbl_4c_Sombra", "Label")
291:             WITH .lbl_4c_Sombra
292:                 .Top       = 25
293:                 .Left      = 10
294:                 .Width     = THIS.Width
295:                 .Height    = 40
296:                 .AutoSize  = .F.
297:                 .BackStyle = 0
298:                 .WordWrap  = .T.
299:                 .FontName  = "Tahoma"
300:                 .FontSize  = 18
301:                 .FontBold  = .T.
302:                 .ForeColor = RGB(0, 0, 0)
303:                 .Caption   = THIS.Caption
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             .AddObject("lbl_4c_TituloCabecalho", "Label")
308:             WITH .lbl_4c_TituloCabecalho
309:                 .Top       = 24
310:                 .Left      = 10
311:                 .Width     = THIS.Width
312:                 .Height    = 46
313:                 .AutoSize  = .F.
314:                 .BackStyle = 0
315:                 .WordWrap  = .T.
316:                 .FontName  = "Tahoma"
317:                 .FontSize  = 18
318:                 .FontBold  = .T.
319:                 .ForeColor = RGB(255, 255, 255)
320:                 .Caption   = THIS.Caption

*-- Linhas 375 a 427:
375:             .Visible = .T.
376:         ENDWITH
377: 
378:         BINDEVENT(par_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")
379:     ENDPROC
380: 
381:     *--------------------------------------------------------------------------
382:     * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
383:     * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
384:     * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
385:     * dump do SCX legado.
386:     *--------------------------------------------------------------------------
387:     PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
388:         LOCAL loc_cAte
389:         loc_cAte = "at" + CHR(233)
390: 
391:         *-- Emissao
392:         par_oPag.AddObject("lbl_4c_SayPed", "Label")
393:         WITH par_oPag.lbl_4c_SayPed
394:             .Top = 132
395:             .Left = 139
396:             .Width = 47
397:             .FontName = "Tahoma"
398:             .FontSize = 8
399:             .ForeColor = RGB(90, 90, 90)
400:             .Caption = "Emiss" + CHR(227) + "o :"
401:             .Visible = .T.
402:         ENDWITH
403: 
404:         par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
405:         WITH par_oPag.txt_4c_DtEmiI
406:             .Top = 128
407:             .Left = 190
408:             .Width = 80
409:             .Height = 23
410:             .Alignment = 3
411:             .Value = {}
412:             .FontName = "Tahoma"
413:             .SpecialEffect = 1
414:             .Visible = .T.
415:         ENDWITH
416: 
417:         par_oPag.AddObject("lbl_4c_Label2", "Label")
418:         WITH par_oPag.lbl_4c_Label2
419:             .Top = 132
420:             .Left = 275
421:             .Width = 18
422:             .FontName = "Tahoma"
423:             .FontSize = 8
424:             .BackStyle = 0
425:             .ForeColor = RGB(90, 90, 90)
426:             .Caption = loc_cAte
427:             .Visible = .T.

*-- Linhas 901 a 944:
901:             .Visible = .T.
902:         ENDWITH
903: 
904:         *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
905:         par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
906:         WITH par_oPag.chk_4c_ValPends
907:             .Top = 309
908:             .Left = 409
909:             .Width = 82
910:             .Height = 13
911:             .FontSize = 7
912:             .Alignment = 0
913:             .Caption = "Valor Pendente"
914:             .Value = 0
915:             .SpecialEffect = 1
916:             .Visible = .T.
917:         ENDWITH
918: 
919:         *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
920:         par_oPag.AddObject("lbl_4c_Say14", "Label")
921:         WITH par_oPag.lbl_4c_Say14
922:             .Top = 103
923:             .Left = 148
924:             .Width = 38
925:             .FontName = "Tahoma"
926:             .ForeColor = RGB(90, 90, 90)
927:             .Caption = "Filtros :"
928:             .Visible = .T.
929:         ENDWITH
930: 
931:         par_oPag.AddObject("txt_4c_Filtros", "TextBox")
932:         WITH par_oPag.txt_4c_Filtros
933:             .Top = 99
934:             .Left = 190
935:             .Width = 312
936:             .Height = 23
937:             .Value = ""
938:             .Format = "K!"
939:             .BackStyle = 1
940:             .FontName = "Tahoma"
941:             .SpecialEffect = 1
942:             .Visible = .T.
943:         ENDWITH
944: 

*-- Linhas 956 a 1059:
956:             .Visible = .F.
957:         ENDWITH
958: 
959:         BINDEVENT(par_oPag.txt_4c_Filtros, "LostFocus", THIS, "GetFiltrosLostFocus")
960: 
961:         *-- Lookups (regra #47 - LostFocus, nao KeyPress, para nao abrir o
962:         *-- picker a cada tecla). Implementados em AbrirLookup* mais abaixo.
963:         BINDEVENT(par_oPag.txt_4c_CMoes,      "LostFocus", THIS, "ValidarCMoes")
964:         BINDEVENT(par_oPag.txt_4c_DMoes,      "LostFocus", THIS, "ValidarDMoes")
965:         BINDEVENT(par_oPag.txt_4c_CMoesC,     "LostFocus", THIS, "ValidarCMoesC")
966:         BINDEVENT(par_oPag.txt_4c_DMoesC,     "LostFocus", THIS, "ValidarDMoesC")
967:         BINDEVENT(par_oPag.txt_4c_MoeSaldo,   "LostFocus", THIS, "ValidarMoeSaldo")
968:         BINDEVENT(par_oPag.txt_4c_CFPublis,   "LostFocus", THIS, "ValidarCFPublis")
969:         BINDEVENT(par_oPag.txt_4c_DFPublis,   "LostFocus", THIS, "ValidarDFPublis")
970:         BINDEVENT(par_oPag.txt_4c_EspecieNfs, "LostFocus", THIS, "ValidarEspecieNfsFiltro")
971:         BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")
972: 
973:         *-- Textos fixos sobre as duas grades de clientes
974:         par_oPag.AddObject("lbl_4c_Say15", "Label")
975:         WITH par_oPag.lbl_4c_Say15
976:             .Top = 410
977:             .Left = 81
978:             .Width = 351
979:             .FontBold = .T.
980:             .FontSize = 8
981:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
982:             .Visible = .T.
983:         ENDWITH
984: 
985:         par_oPag.AddObject("lbl_4c_Say16", "Label")
986:         WITH par_oPag.lbl_4c_Say16
987:             .Top = 559
988:             .Left = 81
989:             .Width = 574
990:             .FontBold = .T.
991:             .FontSize = 8
992:             .ForeColor = RGB(255, 255, 255)
993:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
994:             .Visible = .T.
995:         ENDWITH
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     * ConfigurarOptionGroupsFiltros - optPagos/optOpcao/optCotEm/optCancs/
1000:     * optConcs/optProrrogs/optFilGrd2. Legendas/ordem transcritas do dump
1001:     * (regra #45) - a ORDEM do botao e o valor gravado.
1002:     *--------------------------------------------------------------------------
1003:     PROTECTED PROCEDURE ConfigurarOptionGroupsFiltros(par_oPag)
1004:         LOCAL loc_cNao
1005:         loc_cNao = "N" + CHR(227) + "o"
1006: 
1007:         *-- Pagamento
1008:         par_oPag.AddObject("lbl_4c_Say3", "Label")
1009:         WITH par_oPag.lbl_4c_Say3
1010:             .Top = 308
1011:             .Left = 123
1012:             .Width = 63
1013:             .FontName = "Tahoma"
1014:             .ForeColor = RGB(90, 90, 90)
1015:             .Caption = "Pagamento :"
1016:             .Visible = .T.
1017:         ENDWITH
1018: 
1019:         par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
1020:         WITH par_oPag.opt_4c_Pagos
1021:             .Top = 303
1022:             .Left = 185
1023:             .Width = 217
1024:             .Height = 25
1025:             .ButtonCount = 3
1026:             .BackStyle = 0
1027:             .BorderStyle = 0
1028:             .Value = 1
1029:             WITH .Buttons(1)
1030:                 .Top = 5
1031:                 .Left = 5
1032:                 .Width = 43
1033:                 .FontName = "Tahoma"
1034:                 .FontSize = 8
1035:                 .BackStyle = 0
1036:                 .Caption = "Geral"
1037:                 .ForeColor = RGB(90, 90, 90)
1038:             ENDWITH
1039:             WITH .Buttons(2)
1040:                 .Top = 5
1041:                 .Left = 85
1042:                 .Width = 34
1043:                 .FontName = "Tahoma"
1044:                 .FontSize = 8
1045:                 .BackStyle = 0
1046:                 .Caption = "Sim"
1047:                 .ForeColor = RGB(90, 90, 90)
1048:             ENDWITH
1049:             WITH .Buttons(3)
1050:                 .Top = 5
1051:                 .Left = 175
1052:                 .Width = 37
1053:                 .FontName = "Tahoma"
1054:                 .FontSize = 8
1055:                 .BackStyle = 0
1056:                 .Caption = loc_cNao
1057:                 .ForeColor = RGB(90, 90, 90)
1058:             ENDWITH
1059:             .Visible = .T.

*-- Linhas 1069 a 1114:
1069:             .ForeColor = RGB(90, 90, 90)
1070:             .Caption = "Op" + CHR(231) + CHR(227) + "o :"
1071:             .Visible = .T.
1072:         ENDWITH
1073: 
1074:         par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
1075:         WITH par_oPag.opt_4c_Opcao
1076:             .Top = 324
1077:             .Left = 185
1078:             .Width = 217
1079:             .Height = 25
1080:             .ButtonCount = 3
1081:             .BackStyle = 0
1082:             .BorderStyle = 0
1083:             .Value = 1
1084:             WITH .Buttons(1)
1085:                 .Top = 5
1086:                 .Left = 5
1087:                 .Width = 43
1088:                 .FontName = "Tahoma"
1089:                 .FontSize = 8
1090:                 .BackStyle = 0
1091:                 .Caption = "Geral"
1092:                 .ForeColor = RGB(90, 90, 90)
1093:             ENDWITH
1094:             WITH .Buttons(2)
1095:                 .Top = 5
1096:                 .Left = 85
1097:                 .Width = 34
1098:                 .FontName = "Tahoma"
1099:                 .FontSize = 8
1100:                 .BackStyle = 0
1101:                 .Caption = "Sim"
1102:                 .ForeColor = RGB(90, 90, 90)
1103:             ENDWITH
1104:             WITH .Buttons(3)
1105:                 .Top = 5
1106:                 .Left = 175
1107:                 .Width = 37
1108:                 .FontName = "Tahoma"
1109:                 .FontSize = 8
1110:                 .BackStyle = 0
1111:                 .Caption = loc_cNao
1112:                 .ForeColor = RGB(90, 90, 90)
1113:             ENDWITH
1114:             .Visible = .T.

*-- Linhas 1124 a 1169:
1124:             .ForeColor = RGB(90, 90, 90)
1125:             .Caption = "Convers" + CHR(227) + "o em :"
1126:             .Visible = .T.
1127:         ENDWITH
1128: 
1129:         par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
1130:         WITH par_oPag.opt_4c_CotEm
1131:             .Top = 282
1132:             .Left = 185
1133:             .Width = 405
1134:             .Height = 25
1135:             .ButtonCount = 5
1136:             .BackStyle = 0
1137:             .BorderStyle = 0
1138:             .Value = 1
1139:             WITH .Buttons(1)
1140:                 .Top = 5
1141:                 .Left = 5
1142:                 .Width = 56
1143:                 .FontName = "Tahoma"
1144:                 .FontSize = 8
1145:                 .BackStyle = 0
1146:                 .Caption = "Emiss" + CHR(227) + "o"
1147:                 .ForeColor = RGB(90, 90, 90)
1148:             ENDWITH
1149:             WITH .Buttons(2)
1150:                 .Top = 5
1151:                 .Left = 85
1152:                 .Width = 73
1153:                 .FontName = "Tahoma"
1154:                 .FontSize = 8
1155:                 .BackStyle = 0
1156:                 .Caption = "Vencimento"
1157:                 .ForeColor = RGB(90, 90, 90)
1158:             ENDWITH
1159:             WITH .Buttons(3)
1160:                 .Top = 5
1161:                 .Left = 175
1162:                 .Width = 76
1163:                 .FontName = "Tahoma"
1164:                 .FontSize = 8
1165:                 .BackStyle = 0
1166:                 .Caption = "Lan" + CHR(231) + "amento"
1167:                 .ForeColor = RGB(90, 90, 90)
1168:             ENDWITH
1169:             WITH .Buttons(4)

*-- Linhas 1199 a 1244:
1199:             .ForeColor = RGB(90, 90, 90)
1200:             .Caption = "Cancelamento :"
1201:             .Visible = .T.
1202:         ENDWITH
1203: 
1204:         par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
1205:         WITH par_oPag.opt_4c_Cancs
1206:             .Top = 344
1207:             .Left = 185
1208:             .Width = 217
1209:             .Height = 25
1210:             .ButtonCount = 3
1211:             .BackStyle = 0
1212:             .BorderStyle = 0
1213:             .Value = 1
1214:             WITH .Buttons(1)
1215:                 .Top = 5
1216:                 .Left = 5
1217:                 .Width = 43
1218:                 .FontName = "Tahoma"
1219:                 .FontSize = 8
1220:                 .BackStyle = 0
1221:                 .Caption = "Geral"
1222:                 .ForeColor = RGB(90, 90, 90)
1223:             ENDWITH
1224:             WITH .Buttons(2)
1225:                 .Top = 5
1226:                 .Left = 85
1227:                 .Width = 34
1228:                 .FontName = "Tahoma"
1229:                 .FontSize = 8
1230:                 .BackStyle = 0
1231:                 .Caption = "Sim"
1232:                 .ForeColor = RGB(90, 90, 90)
1233:             ENDWITH
1234:             WITH .Buttons(3)
1235:                 .Top = 5
1236:                 .Left = 175
1237:                 .Width = 37
1238:                 .FontName = "Tahoma"
1239:                 .FontSize = 8
1240:                 .BackStyle = 0
1241:                 .Caption = loc_cNao
1242:                 .ForeColor = RGB(90, 90, 90)
1243:             ENDWITH
1244:             .Visible = .T.

*-- Linhas 1254 a 1299:
1254:             .ForeColor = RGB(90, 90, 90)
1255:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
1256:             .Visible = .T.
1257:         ENDWITH
1258: 
1259:         par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
1260:         WITH par_oPag.opt_4c_Concs
1261:             .Top = 364
1262:             .Left = 185
1263:             .Width = 217
1264:             .Height = 25
1265:             .ButtonCount = 3
1266:             .BackStyle = 0
1267:             .BorderStyle = 0
1268:             .Value = 1
1269:             WITH .Buttons(1)
1270:                 .Top = 5
1271:                 .Left = 5
1272:                 .Width = 43
1273:                 .FontName = "Tahoma"
1274:                 .FontSize = 8
1275:                 .BackStyle = 0
1276:                 .Caption = "Geral"
1277:                 .ForeColor = RGB(90, 90, 90)
1278:             ENDWITH
1279:             WITH .Buttons(2)
1280:                 .Top = 5
1281:                 .Left = 85
1282:                 .Width = 34
1283:                 .FontName = "Tahoma"
1284:                 .FontSize = 8
1285:                 .BackStyle = 0
1286:                 .Caption = "Sim"
1287:                 .ForeColor = RGB(90, 90, 90)
1288:             ENDWITH
1289:             WITH .Buttons(3)
1290:                 .Top = 5
1291:                 .Left = 175
1292:                 .Width = 37
1293:                 .FontName = "Tahoma"
1294:                 .FontSize = 8
1295:                 .BackStyle = 0
1296:                 .Caption = loc_cNao
1297:                 .ForeColor = RGB(90, 90, 90)
1298:             ENDWITH
1299:             .Visible = .T.

*-- Linhas 1309 a 1442:
1309:             .ForeColor = RGB(90, 90, 90)
1310:             .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
1311:             .Visible = .T.
1312:         ENDWITH
1313: 
1314:         par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
1315:         WITH par_oPag.opt_4c_Prorrogs
1316:             .Top = 383
1317:             .Left = 185
1318:             .Width = 217
1319:             .Height = 25
1320:             .ButtonCount = 3
1321:             .BackStyle = 0
1322:             .BorderStyle = 0
1323:             .Value = 1
1324:             WITH .Buttons(1)
1325:                 .Top = 5
1326:                 .Left = 5
1327:                 .Width = 43
1328:                 .FontName = "Tahoma"
1329:                 .FontSize = 8
1330:                 .BackStyle = 0
1331:                 .Caption = "Geral"
1332:                 .ForeColor = RGB(90, 90, 90)
1333:             ENDWITH
1334:             WITH .Buttons(2)
1335:                 .Top = 5
1336:                 .Left = 85
1337:                 .Width = 34
1338:                 .FontName = "Tahoma"
1339:                 .FontSize = 8
1340:                 .BackStyle = 0
1341:                 .Caption = "Sim"
1342:                 .ForeColor = RGB(90, 90, 90)
1343:             ENDWITH
1344:             WITH .Buttons(3)
1345:                 .Top = 5
1346:                 .Left = 175
1347:                 .Width = 37
1348:                 .FontName = "Tahoma"
1349:                 .FontSize = 8
1350:                 .BackStyle = 0
1351:                 .Caption = loc_cNao
1352:                 .ForeColor = RGB(90, 90, 90)
1353:             ENDWITH
1354:             .Visible = .T.
1355:         ENDWITH
1356: 
1357:         *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
1358:         par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
1359:         WITH par_oPag.opt_4c_FilGrd2
1360:             .Top = 557
1361:             .Left = 748
1362:             .Width = 139
1363:             .Height = 17
1364:             .ButtonCount = 2
1365:             .AutoSize = .F.
1366:             .BackStyle = 0
1367:             .BorderStyle = 0
1368:             .Value = 1
1369:             WITH .Buttons(1)
1370:                 .Top = 1
1371:                 .Left = 5
1372:                 .Width = 58
1373:                 .FontName = "Verdana"
1374:                 .FontSize = 8
1375:                 .FontBold = .T.
1376:                 .BackStyle = 0
1377:                 .Caption = "Todas"
1378:                 .ForeColor = RGB(255, 255, 255)
1379:             ENDWITH
1380:             WITH .Buttons(2)
1381:                 .Top = 1
1382:                 .Left = 68
1383:                 .Width = 68
1384:                 .FontName = "Verdana"
1385:                 .FontSize = 8
1386:                 .FontBold = .T.
1387:                 .BackStyle = 0
1388:                 .Caption = "Alguma"
1389:                 .ForeColor = RGB(255, 255, 255)
1390:             ENDWITH
1391:             .Visible = .T.
1392:         ENDWITH
1393:     ENDPROC
1394: 
1395:     *--------------------------------------------------------------------------
1396:     * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
1397:     * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
1398:     * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
1399:     * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
1400:     * visual NAO segue a ordem numerica das colunas).
1401:     *--------------------------------------------------------------------------
1402:     PROTECTED PROCEDURE ConfigurarGradesFiltros(par_oPag)
1403:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2
1404:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
1405:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
1406:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
1407: 
1408:         *-- grdTipo
1409:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
1410:         WITH par_oPag.grd_4c_Tipos
1411:             .Top = 100
1412:             .Left = 624
1413:             .Width = 259
1414:             .Height = 275
1415:             .FontName = "Tahoma"
1416:             .AllowHeaderSizing = .F.
1417:             .AllowRowSizing = .F.
1418:             .DeleteMark = .F.
1419:             .RecordMark = .F.
1420:             .HeaderHeight = 17
1421:             .RowHeight = 17
1422:             .ScrollBars = 2
1423:             .GridLineColor = RGB(238, 238, 238)
1424:         ENDWITH
1425: 
1426:         *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
1427:         *-- .Column1/.Column2 - evita 'Unknown member COLUMN1'.
1428:         par_oPag.grd_4c_Tipos.ColumnCount  = 2
1429:         par_oPag.grd_4c_Tipos.RecordSource = loc_cTipos
1430: 
1431:         WITH par_oPag.grd_4c_Tipos
1432:             .Column1.ControlSource = loc_cTipos + ".Imps"
1433:             .Column1.Width = 17
1434:             .Column1.Alignment = 0
1435:             .Column1.Sparse = .F.
1436:             .Column1.Header1.Caption = ""
1437:             .Column1.AddObject("Check1", "CheckBox")
1438:             .Column1.Check1.Top = 23
1439:             .Column1.Check1.Left = 35
1440:             .Column1.Check1.Width = 60
1441:             .Column1.Check1.Height = 17
1442:             .Column1.Check1.Caption = ""

*-- Linhas 1455 a 1546:
1455:             .Visible = .T.
1456:         ENDWITH
1457: 
1458:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1459:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1460:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")
1461:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "Click", THIS, "ChkTipoClick")
1462: 
1463:         *-- Grd_Clientes / Grd_Clientes2 (mesma estrutura)
1464:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes", loc_cClientes, 426, 130)
1465:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes2", loc_cClientes2, 575, 112)
1466: 
1467:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "KeyPress",   THIS, "ChkCliEKeyPress")
1468:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseUp",    THIS, "ChkCliEMouseUp")
1469:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseDown",  THIS, "ChkCliEMouseDown")
1470:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "Click",      THIS, "ChkCliEClick")
1471:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "KeyPress",   THIS, "ChkCliPKeyPress")
1472:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseUp",    THIS, "ChkCliPMouseUp")
1473:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseDown",  THIS, "ChkCliPMouseDown")
1474:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "Click",      THIS, "ChkCliPClick")
1475:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "KeyPress",   THIS, "ChkCliCKeyPress")
1476:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseUp",    THIS, "ChkCliCMouseUp")
1477:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseDown",  THIS, "ChkCliCMouseDown")
1478:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "Click",      THIS, "ChkCliCClick")
1479:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "KeyPress",   THIS, "ChkCliAKeyPress")
1480:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseUp",    THIS, "ChkCliAMouseUp")
1481:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseDown",  THIS, "ChkCliAMouseDown")
1482:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "Click",      THIS, "ChkCliAClick")
1483: 
1484:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "KeyPress",   THIS, "ChkCli2EKeyPress")
1485:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseUp",    THIS, "ChkCli2EMouseUp")
1486:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseDown",  THIS, "ChkCli2EMouseDown")
1487:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "Click",      THIS, "ChkCli2EClick")
1488:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "KeyPress",   THIS, "ChkCli2PKeyPress")
1489:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseUp",    THIS, "ChkCli2PMouseUp")
1490:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseDown",  THIS, "ChkCli2PMouseDown")
1491:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "Click",      THIS, "ChkCli2PClick")
1492:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "KeyPress",   THIS, "ChkCli2CKeyPress")
1493:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseUp",    THIS, "ChkCli2CMouseUp")
1494:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseDown",  THIS, "ChkCli2CMouseDown")
1495:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "Click",      THIS, "ChkCli2CClick")
1496:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "KeyPress",   THIS, "ChkCli2AKeyPress")
1497:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseUp",    THIS, "ChkCli2AMouseUp")
1498:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseDown",  THIS, "ChkCli2AMouseDown")
1499:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "Click",      THIS, "ChkCli2AClick")
1500:     ENDPROC
1501: 
1502:     *--------------------------------------------------------------------------
1503:     * ConfigurarGradeClientes - helper compartilhado por Grd_Clientes e
1504:     * Grd_Clientes2 (mesma estrutura de 8 colunas no legado).
1505:     *--------------------------------------------------------------------------
1506:     PROTECTED PROCEDURE ConfigurarGradeClientes(par_oPag, par_cNomeGrid, par_cCursor, par_nTop, par_nHeight)
1507:         LOCAL loc_oGrid
1508: 
1509:         par_oPag.AddObject(par_cNomeGrid, "Grid")
1510:         loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)
1511: 
1512:         WITH loc_oGrid
1513:             .Top = par_nTop
1514:             .Left = 81
1515:             .Width = 802
1516:             .Height = par_nHeight
1517:             .FontName = "Tahoma"
1518:             .AllowHeaderSizing = .F.
1519:             .AllowRowSizing = .F.
1520:             .DeleteMark = .F.
1521:             .RecordMark = .F.
1522:             .ScrollBars = 2
1523:             .GridLineColor = RGB(238, 238, 238)
1524:         ENDWITH
1525: 
1526:         *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
1527:         *-- .Column1..8 - evita 'Unknown member COLUMN1'.
1528:         loc_oGrid.ColumnCount  = 8
1529:         loc_oGrid.RecordSource = par_cCursor
1530: 
1531:         WITH loc_oGrid
1532:             .Column1.ControlSource = par_cCursor + ".Grupo"
1533:             .Column1.Width = 90
1534:             .Column1.Movable = .F.
1535:             .Column1.Resizable = .F.
1536:             .Column1.Text1.MaxLength = 10
1537:             .Column1.Header1.Caption = "Grupo"
1538:             .Column1.Header1.Alignment = 2
1539:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1540: 
1541:             .Column4.ColumnOrder = 2
1542:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1543:             .Column4.Width = 166
1544:             .Column4.Text1.MaxLength = 20
1545:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1546:             .Column4.Header1.Alignment = 2

*-- Linhas 1643 a 1686:
1643:     * SelTudo/Apaga/ApagaG1/G2) e do filtro nomeado (AddFiltro/DelFiltro/
1644:     * RecFiltro/Carregar). Icones e ToolTip transcritos do dump do SCX.
1645:     *--------------------------------------------------------------------------
1646:     PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
1647:         *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
1648:         par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
1649:         WITH par_oPag.cmd_4c_SelTudo
1650:             .Top = 295
1651:             .Left = 892
1652:             .Width = 40
1653:             .Height = 40
1654:             .FontName = "Verdana"
1655:             .FontSize = 8
1656:             .WordWrap = .T.
1657:             .Caption = ""
1658:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1659:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1660:             .ToolTipText = "Seleciona Tudo"
1661:             .ForeColor = RGB(36, 84, 155)
1662:             .BackColor = RGB(255, 255, 255)
1663:             .Themes = .T.
1664:             .Visible = .T.
1665:         ENDWITH
1666: 
1667:         par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
1668:         WITH par_oPag.cmd_4c_Apaga
1669:             .Top = 335
1670:             .Left = 892
1671:             .Width = 40
1672:             .Height = 40
1673:             .FontName = "Verdana"
1674:             .FontSize = 8
1675:             .WordWrap = .T.
1676:             .Caption = ""
1677:             .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1678:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1679:             .ToolTipText = "Apaga Tudo"
1680:             .ForeColor = RGB(36, 84, 155)
1681:             .BackColor = RGB(255, 255, 255)
1682:             .Themes = .T.
1683:             .Visible = .T.
1684:         ENDWITH
1685: 
1686:         *-- Grd_Clientes: Inserir/Excluir/ApagaG1

*-- Linhas 1778 a 1799:
1778:             .BackColor = RGB(255, 255, 255)
1779:             .Themes = .T.
1780:             .Visible = .T.
1781:         ENDWITH
1782: 
1783:         par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
1784:         WITH par_oPag.cmd_4c_ApagaG2
1785:             .Top = 648
1786:             .Left = 892
1787:             .Width = 40
1788:             .Height = 40
1789:             .FontName = "Verdana"
1790:             .FontSize = 8
1791:             .WordWrap = .T.
1792:             .Caption = ""
1793:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1794:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1795:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1796:             .ForeColor = RGB(36, 84, 155)
1797:             .BackColor = RGB(255, 255, 255)
1798:             .Themes = .T.
1799:             .Visible = .T.

*-- Linhas 1877 a 2595:
1877:             .Visible = .T.
1878:         ENDWITH
1879: 
1880:         BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
1881:         BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
1882:         BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
1883:         BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
1884:         BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
1885:         BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
1886:         BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
1887:         BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
1888:         BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
1889:         BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
1890:         BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
1891:         BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
1896:     * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE
1897:     * Valid originais (fwbuscaext/fwBuscaSel) - ligados em "LostFocus" (regra
1898:     * #47 do CLAUDE.md), nunca em "KeyPress" sem testar a tecla, para nao
1899:     * abrir o picker a cada caractere digitado. Guarda de reentrancia
1900:     * (this_lEmLookup) porque o picker eh MODAL e redispara o proprio
1901:     * LostFocus ao tirar o foco do campo (regra #37).
1902:     *==========================================================================
1903: 
1904:     *--------------------------------------------------------------------------
1905:     * ValidarCMoes/ValidarDMoes - Moeda Filtro (SigCdMoe.CMoes/DMoes)
1906:     *--------------------------------------------------------------------------
1907:     PROCEDURE ValidarCMoes()
1908:         LOCAL loc_oPag, loc_cValor
1909:         IF THIS.this_lEmLookup
1910:             RETURN
1911:         ENDIF
1912:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1913:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoes.Value)
1914:         IF loc_cValor == THIS.this_cUltimoValidarCMoesValidado
1915:             RETURN
1916:         ENDIF
1917:         THIS.this_cUltimoValidarCMoesValidado = loc_cValor
1918:         IF EMPTY(loc_cValor)
1919:             loc_oPag.txt_4c_DMoes.Value = ""
1920:             RETURN
1921:         ENDIF
1922:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1923:     ENDPROC
1924: 
1925:     PROCEDURE ValidarDMoes()
1926:         LOCAL loc_oPag, loc_cValor
1927:         IF THIS.this_lEmLookup
1928:             RETURN
1929:         ENDIF
1930:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1931:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoes.Value)
1932:         IF loc_cValor == THIS.this_cUltimoValidarDMoesValidado
1933:             RETURN
1934:         ENDIF
1935:         THIS.this_cUltimoValidarDMoesValidado = loc_cValor
1936:         IF EMPTY(loc_cValor)
1937:             loc_oPag.txt_4c_CMoes.Value = ""
1938:             RETURN
1939:         ENDIF
1940:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1941:     ENDPROC
1942: 
1943:     *--------------------------------------------------------------------------
1944:     * ValidarCMoesC/ValidarDMoesC - Moeda Conversao (SigCdMoe.CMoes/DMoes)
1945:     *--------------------------------------------------------------------------
1946:     PROCEDURE ValidarCMoesC()
1947:         LOCAL loc_oPag, loc_cValor
1948:         IF THIS.this_lEmLookup
1949:             RETURN
1950:         ENDIF
1951:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1952:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoesC.Value)
1953:         IF loc_cValor == THIS.this_cUltimoValidarCMoesCValidado
1954:             RETURN
1955:         ENDIF
1956:         THIS.this_cUltimoValidarCMoesCValidado = loc_cValor
1957:         IF EMPTY(loc_cValor)
1958:             loc_oPag.txt_4c_DMoesC.Value = ""
1959:             RETURN
1960:         ENDIF
1961:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1962:     ENDPROC
1963: 
1964:     PROCEDURE ValidarDMoesC()
1965:         LOCAL loc_oPag, loc_cValor
1966:         IF THIS.this_lEmLookup
1967:             RETURN
1968:         ENDIF
1969:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1970:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoesC.Value)
1971:         IF loc_cValor == THIS.this_cUltimoValidarDMoesCValidado
1972:             RETURN
1973:         ENDIF
1974:         THIS.this_cUltimoValidarDMoesCValidado = loc_cValor
1975:         IF EMPTY(loc_cValor)
1976:             loc_oPag.txt_4c_CMoesC.Value = ""
1977:             RETURN
1978:         ENDIF
1979:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1980:     ENDPROC
1981: 
1982:     *--------------------------------------------------------------------------
1983:     * AbrirLookupMoeda - Funil compartilhado pelas 2 moedas (Filtro/
1984:     * Conversao). par_cCampoBusca indica qual coluna buscar (CMoes se o
1985:     * usuario editou o codigo, DMoes se editou a descricao) - igual ao par
1986:     * de PROCEDURE Valid simetricos do legado.
1987:     *--------------------------------------------------------------------------
1988:     PROTECTED PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValor, par_oTxtCod, par_oTxtDesc)
1989:         LOCAL loc_oBusca, loc_oErro
1990: 
1991:         THIS.this_lEmLookup = .T.
1992:         TRY
1993:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1994:                 "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValor, ;
1995:                 "Moedas")
1996: 
1997:             IF VARTYPE(loc_oBusca) = "O"
1998:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1999:                     IF USED("cursor_4c_BuscaMoeda")
2000:                         par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2001:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
2002:                     ENDIF
2003:                 ELSE
2004:                     IF !loc_oBusca.this_lAchouRegistro
2005:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2006:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2007:                         loc_oBusca.Show()
2008:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2009:                             par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2010:                             par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
2011:                         ENDIF
2012:                     ENDIF
2013:                 ENDIF
2014:                 loc_oBusca.Release()
2015:             ENDIF
2016:         CATCH TO loc_oErro
2017:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
2018:         ENDTRY
2019:         THIS.this_lEmLookup = .F.
2020: 
2021:         IF USED("cursor_4c_BuscaMoeda")
2022:             USE IN cursor_4c_BuscaMoeda
2023:         ENDIF
2024:     ENDPROC
2025: 
2026:     *--------------------------------------------------------------------------
2027:     * ValidarMoeSaldo/AbrirLookupMoedaSaldo - Moeda do Saldo Inicial (so o
2028:     * codigo, sem campo de descricao ao lado - igual ao legado).
2029:     *--------------------------------------------------------------------------
2030:     PROCEDURE ValidarMoeSaldo()
2031:         LOCAL loc_oPag, loc_cValor
2032:         IF THIS.this_lEmLookup
2033:             RETURN
2034:         ENDIF
2035:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2036:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_MoeSaldo.Value)
2037:         IF loc_cValor == THIS.this_cUltimoValidarMoeSaldoValidado
2038:             RETURN
2039:         ENDIF
2040:         THIS.this_cUltimoValidarMoeSaldoValidado = loc_cValor
2041:         IF EMPTY(loc_cValor)
2042:             RETURN
2043:         ENDIF
2044:         THIS.AbrirLookupMoedaSaldo(loc_cValor)
2045:     ENDPROC
2046: 
2047:     PROTECTED PROCEDURE AbrirLookupMoedaSaldo(par_cValor)
2048:         LOCAL loc_oBusca, loc_oErro
2049: 
2050:         THIS.this_lEmLookup = .T.
2051:         TRY
2052:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2053:                 "SigCdMoe", "cursor_4c_BuscaMoeSaldo", "CMoes", par_cValor, ;
2054:                 "Moedas")
2055: 
2056:             IF VARTYPE(loc_oBusca) = "O"
2057:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2058:                     IF USED("cursor_4c_BuscaMoeSaldo")
2059:                         THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2060:                     ENDIF
2061:                 ELSE
2062:                     IF !loc_oBusca.this_lAchouRegistro
2063:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2064:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2065:                         loc_oBusca.Show()
2066:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeSaldo")
2067:                             THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2068:                         ENDIF
2069:                     ENDIF
2070:                 ENDIF
2071:                 loc_oBusca.Release()
2072:             ENDIF
2073:         CATCH TO loc_oErro
2074:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
2075:         ENDTRY
2076:         THIS.this_lEmLookup = .F.
2077: 
2078:         IF USED("cursor_4c_BuscaMoeSaldo")
2079:             USE IN cursor_4c_BuscaMoeSaldo
2080:         ENDIF
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     * ValidarCFPublis/ValidarDFPublis - Forma de Publicidade (SigCdFpb.Cods/
2085:     * Descs)
2086:     *--------------------------------------------------------------------------
2087:     PROCEDURE ValidarCFPublis()
2088:         LOCAL loc_oPag, loc_cValor
2089:         IF THIS.this_lEmLookup
2090:             RETURN
2091:         ENDIF
2092:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2093:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
2094:         IF loc_cValor == THIS.this_cUltimoValidarCFPublisValidado
2095:             RETURN
2096:         ENDIF
2097:         THIS.this_cUltimoValidarCFPublisValidado = loc_cValor
2098:         IF EMPTY(loc_cValor)
2099:             loc_oPag.txt_4c_DFPublis.Value = ""
2100:             RETURN
2101:         ENDIF
2102:         THIS.AbrirLookupPublicidade("Cods", loc_cValor)
2103:     ENDPROC
2104: 
2105:     PROCEDURE ValidarDFPublis()
2106:         LOCAL loc_oPag, loc_cValor
2107:         IF THIS.this_lEmLookup
2108:             RETURN
2109:         ENDIF
2110:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2111:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DFPublis.Value)
2112:         IF loc_cValor == THIS.this_cUltimoValidarDFPublisValidado
2113:             RETURN
2114:         ENDIF
2115:         THIS.this_cUltimoValidarDFPublisValidado = loc_cValor
2116:         IF EMPTY(loc_cValor)
2117:             loc_oPag.txt_4c_CFPublis.Value = ""
2118:             RETURN
2119:         ENDIF
2120:         THIS.AbrirLookupPublicidade("Descs", loc_cValor)
2121:     ENDPROC
2122: 
2123:     PROTECTED PROCEDURE AbrirLookupPublicidade(par_cCampoBusca, par_cValor)
2124:         LOCAL loc_oBusca, loc_oPag, loc_oErro
2125:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2126: 
2127:         THIS.this_lEmLookup = .T.
2128:         TRY
2129:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2130:                 "SigCdFpb", "cursor_4c_BuscaPublis", par_cCampoBusca, par_cValor, ;
2131:                 "Forma de Publicidade")
2132: 
2133:             IF VARTYPE(loc_oBusca) = "O"
2134:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2135:                     IF USED("cursor_4c_BuscaPublis")
2136:                         loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2137:                         loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2138:                     ENDIF
2139:                 ELSE
2140:                     IF !loc_oBusca.this_lAchouRegistro
2141:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2142:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2143:                         loc_oBusca.Show()
2144:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPublis")
2145:                             loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2146:                             loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2147:                         ENDIF
2148:                     ENDIF
2149:                 ENDIF
2150:                 loc_oBusca.Release()
2151:             ENDIF
2152:         CATCH TO loc_oErro
2153:             MsgErro("Erro ao buscar forma de publicidade: " + loc_oErro.Message, "Erro")
2154:         ENDTRY
2155:         THIS.this_lEmLookup = .F.
2156: 
2157:         IF USED("cursor_4c_BuscaPublis")
2158:             USE IN cursor_4c_BuscaPublis
2159:         ENDIF
2160:     ENDPROC
2161: 
2162:     *--------------------------------------------------------------------------
2163:     * ValidarEspecieNfsFiltro/AbrirLookupEspecieFiltro - Especie da Nota
2164:     * Fiscal (SigCdEsp.Especies), campo unico (sem descricao ao lado).
2165:     *--------------------------------------------------------------------------
2166:     PROCEDURE ValidarEspecieNfsFiltro()
2167:         LOCAL loc_oPag, loc_cValor
2168:         IF THIS.this_lEmLookup
2169:             RETURN
2170:         ENDIF
2171:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2172:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_EspecieNfs.Value)
2173:         IF loc_cValor == THIS.this_cUltimoValidarEspecieNfsFiltroValidado
2174:             RETURN
2175:         ENDIF
2176:         THIS.this_cUltimoValidarEspecieNfsFiltroValidado = loc_cValor
2177:         IF EMPTY(loc_cValor)
2178:             RETURN
2179:         ENDIF
2180:         THIS.AbrirLookupEspecieFiltro(loc_cValor)
2181:     ENDPROC
2182: 
2183:     PROTECTED PROCEDURE AbrirLookupEspecieFiltro(par_cValor)
2184:         LOCAL loc_oBusca, loc_oErro
2185: 
2186:         THIS.this_lEmLookup = .T.
2187:         TRY
2188:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2189:                 "SigCdEsp", "cursor_4c_BuscaEspecie", "Especies", par_cValor, ;
2190:                 "Esp" + CHR(233) + "cie da Nota Fiscal")
2191: 
2192:             IF VARTYPE(loc_oBusca) = "O"
2193:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2194:                     IF USED("cursor_4c_BuscaEspecie")
2195:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2196:                     ENDIF
2197:                 ELSE
2198:                     IF !loc_oBusca.this_lAchouRegistro
2199:                         loc_oBusca.mAddColuna("Especies", "", "Esp" + CHR(233) + "cie")
2200:                         loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2201:                         loc_oBusca.Show()
2202:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEspecie")
2203:                             THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2204:                         ENDIF
2205:                     ENDIF
2206:                 ENDIF
2207:                 loc_oBusca.Release()
2208:             ENDIF
2209:         CATCH TO loc_oErro
2210:             MsgErro("Erro ao buscar esp" + CHR(233) + "cie da nota fiscal: " + loc_oErro.Message, "Erro")
2211:         ENDTRY
2212:         THIS.this_lEmLookup = .F.
2213: 
2214:         IF USED("cursor_4c_BuscaEspecie")
2215:             USE IN cursor_4c_BuscaEspecie
2216:         ENDIF
2217:     ENDPROC
2218: 
2219:     *--------------------------------------------------------------------------
2220:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2221:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2222:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2223:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2224:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2225:     *--------------------------------------------------------------------------
2226:     PROCEDURE ValidarTitBansFiltro()
2227:         LOCAL loc_oPag, loc_cValor
2228:         IF THIS.this_lEmLookup
2229:             RETURN
2230:         ENDIF
2231:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2232:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2233:         IF loc_cValor == THIS.this_cUltimoValidarTitBansFiltroValidado
2234:             RETURN
2235:         ENDIF
2236:         THIS.this_cUltimoValidarTitBansFiltroValidado = loc_cValor
2237:         IF EMPTY(loc_cValor)
2238:             RETURN
2239:         ENDIF
2240:         THIS.AbrirLookupTitBans(loc_cValor)
2241:     ENDPROC
2242: 
2243:     PROTECTED PROCEDURE AbrirLookupTitBans(par_cValor)
2244:         LOCAL loc_oBusca, loc_oErro
2245: 
2246:         THIS.this_lEmLookup = .T.
2247:         TRY
2248:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2249:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2250:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2251:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2252: 
2253:             IF VARTYPE(loc_oBusca) = "O"
2254:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2255:                     IF USED("cursor_4c_BuscaTitBan")
2256:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2257:                     ENDIF
2258:                 ELSE
2259:                     IF !loc_oBusca.this_lAchouRegistro
2260:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2261:                         loc_oBusca.Show()
2262:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2263:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2264:                         ENDIF
2265:                     ENDIF
2266:                 ENDIF
2267:                 loc_oBusca.Release()
2268:             ENDIF
2269:         CATCH TO loc_oErro
2270:             MsgErro("Erro ao buscar t" + CHR(237) + "tulo banco: " + loc_oErro.Message, "Erro")
2271:         ENDTRY
2272:         THIS.this_lEmLookup = .F.
2273: 
2274:         IF USED("cursor_4c_BuscaTitBan")
2275:             USE IN cursor_4c_BuscaTitBan
2276:         ENDIF
2277:     ENDPROC
2278: 
2279:     *==========================================================================
2280:     * FASE 5 - Page2 (pgDados): fileira de botoes de acao (Movimento/
2281:     * Recebimento/FollowUp/Impressao/Planilha) + CommandGroup cmgRetornar +
2282:     * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
2283:     * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
2284:     * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
2285:     * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
2286:     * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
2287:     * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
2288:     *==========================================================================
2289: 
2290:     *--------------------------------------------------------------------------
2291:     * ConfigurarPaginaDados - Monta o conteudo da Page2 (resultado da
2292:     * consulta). Chamada a partir de InicializarForm(), apos a Page1.
2293:     *--------------------------------------------------------------------------
2294:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2295:         LOCAL loc_oPag
2296:         loc_oPag = THIS.pgf_4c_Paginas.Page2
2297: 
2298:         THIS.ConfigurarBotoesAcaoDados(loc_oPag)
2299:         THIS.ConfigurarCamposDados1(loc_oPag)
2300:         THIS.ConfigurarCamposDados2(loc_oPag)
2301:         THIS.ConfigurarGradeDados(loc_oPag)
2302:     ENDPROC
2303: 
2304:     *--------------------------------------------------------------------------
2305:     * ConfigurarBotoesAcaoDados - Shape1 (moldura ao redor da fileira de
2306:     * botoes), CommandGroup cmgRetornar (volta para a Page1) e os 6 botoes de
2307:     * acao (Recebimento/Movimento/FollowUp Conta/FollowUp Lancamento/
2308:     * Impressao/Planilha). SCX: Shape1 Top=83,Left=6,W=462,H=88; botoes
2309:     * Top=88, H=75 W=75, FontName="Comic Sans MS".
2310:     *--------------------------------------------------------------------------
2311:     PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
2312:         par_oPag.AddObject("shp_4c_Shape1", "Shape")
2313:         WITH par_oPag.shp_4c_Shape1
2314:             .Top         = 83
2315:             .Left        = 6
2316:             .Width       = 462
2317:             .Height      = 88
2318:             .BackStyle   = 0
2319:             .BorderStyle = 0
2320:             .BorderColor = RGB(136, 189, 188)
2321:             .Visible     = .T.
2322:         ENDWITH
2323: 
2324:         *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
2325:         par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
2326:         WITH par_oPag.obj_4c_CmgRetornar
2327:             .Top         = -2
2328:             .Left        = 918
2329:             .Width       = 85
2330:             .Height      = 85
2331:             .ButtonCount = 1
2332:             .BackStyle   = 0
2333:             .BorderStyle = 0
2334:             .Themes      = .F.
2335:             .Visible     = .T.
2336: 
2337:             WITH .Buttons(1)
2338:                 .Top         = 5
2339:                 .Left        = 5
2340:                 .Width       = 75
2341:                 .Height      = 75
2342:                 .FontName    = "Comic Sans MS"
2343:                 .FontSize    = 8
2344:                 .FontBold    = .T.
2345:                 .FontItalic  = .T.
2346:                 .Caption     = "Retornar"
2347:                 .ToolTipText = "Retornar aos Filtros"
2348:                 .ForeColor   = RGB(90, 90, 90)
2349:                 .BackColor   = RGB(255, 255, 255)
2350:                 .Themes      = .F.
2351:                 .Cancel      = .T.
2352:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2353:             ENDWITH
2354:         ENDWITH
2355:         BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")
2356: 
2357:         *-- Recebimento
2358:         par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
2359:         WITH par_oPag.cmd_4c_BtnRecebe
2360:             .Top             = 88
2361:             .Left            = 12
2362:             .Width           = 75
2363:             .Height          = 75
2364:             .FontName        = "Comic Sans MS"
2365:             .FontSize        = 8
2366:             .FontBold        = .T.
2367:             .FontItalic      = .T.
2368:             .Caption         = "\<Recebimento"
2369:             .ToolTipText     = "Recebimentos"
2370:             .ForeColor       = RGB(90, 90, 90)
2371:             .BackColor       = RGB(255, 255, 255)
2372:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2373:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2374:             .Themes          = .T.
2375:             .Visible         = .T.
2376:         ENDWITH
2377:         BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")
2378: 
2379:         *-- Movimento
2380:         par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
2381:         WITH par_oPag.cmd_4c_BtnMovimento
2382:             .Top             = 88
2383:             .Left            = 87
2384:             .Width           = 75
2385:             .Height          = 75
2386:             .FontName        = "Comic Sans MS"
2387:             .FontSize        = 8
2388:             .FontBold        = .T.
2389:             .FontItalic      = .T.
2390:             .Caption         = "\<Movimento"
2391:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
2392:             .ForeColor       = RGB(90, 90, 90)
2393:             .BackColor       = RGB(255, 255, 255)
2394:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2395:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2396:             .Themes          = .T.
2397:             .Visible         = .T.
2398:         ENDWITH
2399:         BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")
2400: 
2401:         *-- Follow-up da Conta
2402:         par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
2403:         WITH par_oPag.cmd_4c_BtnFollowUpC
2404:             .Top             = 88
2405:             .Left            = 162
2406:             .Width           = 75
2407:             .Height          = 75
2408:             .FontName        = "Comic Sans MS"
2409:             .FontSize        = 8
2410:             .FontBold        = .T.
2411:             .FontItalic      = .T.
2412:             .WordWrap        = .T.
2413:             .Caption         = "Follo\<w-up Conta"
2414:             .ToolTipText     = "Follow-up da Conta "
2415:             .ForeColor       = RGB(90, 90, 90)
2416:             .BackColor       = RGB(255, 255, 255)
2417:             .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2418:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2419:             .Themes          = .T.
2420:             .Visible         = .T.
2421:         ENDWITH
2422:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")
2423: 
2424:         *-- Follow-up do Lancamento (Titulo)
2425:         par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
2426:         WITH par_oPag.cmd_4c_BtnFollowUpL
2427:             .Top             = 88
2428:             .Left            = 237
2429:             .Width           = 75
2430:             .Height          = 75
2431:             .FontName        = "Comic Sans MS"
2432:             .FontSize        = 8
2433:             .FontBold        = .T.
2434:             .FontItalic      = .T.
2435:             .WordWrap        = .T.
2436:             .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
2437:             .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
2438:             .ForeColor       = RGB(90, 90, 90)
2439:             .BackColor       = RGB(255, 255, 255)
2440:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2441:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2442:             .Themes          = .T.
2443:             .Visible         = .T.
2444:         ENDWITH
2445:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")
2446: 
2447:         *-- Impressao
2448:         par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
2449:         WITH par_oPag.cmd_4c_BtnImprimir
2450:             .Top             = 88
2451:             .Left            = 312
2452:             .Width           = 75
2453:             .Height          = 75
2454:             .FontName        = "Comic Sans MS"
2455:             .FontSize        = 8
2456:             .FontBold        = .T.
2457:             .FontItalic      = .T.
2458:             .Caption         = "Im\<press" + CHR(227) + "o"
2459:             .ToolTipText     = "Impress" + CHR(227) + "o"
2460:             .ForeColor       = RGB(90, 90, 90)
2461:             .BackColor       = RGB(255, 255, 255)
2462:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2463:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2464:             .Themes          = .T.
2465:             .Visible         = .T.
2466:         ENDWITH
2467:         BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2468: 
2469:         *-- Planilha (Excel)
2470:         par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
2471:         WITH par_oPag.cmd_4c_BtnPlanilha
2472:             .Top             = 88
2473:             .Left            = 387
2474:             .Width           = 75
2475:             .Height          = 75
2476:             .FontName        = "Comic Sans MS"
2477:             .FontSize        = 8
2478:             .FontBold        = .T.
2479:             .FontItalic      = .T.
2480:             .Caption         = "Pla\<nilha"
2481:             .ToolTipText     = "Impress" + CHR(227) + "o"
2482:             .ForeColor       = RGB(90, 90, 90)
2483:             .BackColor       = RGB(255, 255, 255)
2484:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2485:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2486:             .Themes          = .T.
2487:             .Visible         = .T.
2488:         ENDWITH
2489:         BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
2490:     ENDPROC
2491: 
2492:     *--------------------------------------------------------------------------
2493:     * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
2494:     * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
2495:     * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
2496:     * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
2497:     *--------------------------------------------------------------------------
2498:     PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
2499:         *-- Ordem da Grade (Moeda + ...)
2500:         par_oPag.AddObject("lbl_4c_Ordem", "Label")
2501:         WITH par_oPag.lbl_4c_Ordem
2502:             .Top       = 152
2503:             .Left      = 511
2504:             .Width     = 153
2505:             .AutoSize  = .T.
2506:             .FontName  = "Tahoma"
2507:             .FontSize  = 8
2508:             .ForeColor = RGB(90, 90, 90)
2509:             .Caption   = "\<Ordem da Grade (Moeda + ...) "
2510:             .Visible   = .T.
2511:         ENDWITH
2512: 
2513:         par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
2514:         WITH par_oPag.cbo_4c_Ordem
2515:             .Top               = 170
2516:             .Left              = 510
2517:             .Width             = 182
2518:             .Height            = 23
2519:             .Style             = 2
2520:             .RowSourceType     = 1
2521:             .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"
2522:             .Value             = 1
2523:             .FontName          = "Courier New"
2524:             .SpecialEffect     = 1
2525:             .BorderColor       = RGB(36, 84, 155)
2526:             .DisabledBackColor = RGB(255, 255, 255)
2527:             .DisabledForeColor = RGB(36, 84, 155)
2528:             .ToolTipText       = "Ordem dos Dados da Grade (Sempre Moeda + Ordem Selecionada)"
2529:             .Visible           = .T.
2530:         ENDWITH
2531:         BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")
2532: 
2533:         *-- Nota Fiscal
2534:         par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
2535:         WITH par_oPag.lbl_4c_NotaFiscal
2536:             .Top       = 594
2537:             .Left      = 23
2538:             .FontName  = "Tahoma"
2539:             .ForeColor = RGB(90, 90, 90)
2540:             .Caption   = "Nota Fiscal :"
2541:             .Visible   = .T.
2542:         ENDWITH
2543: 
2544:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
2545:         WITH par_oPag.txt_4c_NFs
2546:             .Top           = 590
2547:             .Left          = 89
2548:             .Width         = 100
2549:             .Height        = 23
2550:             .Value         = ""
2551:             .Format        = "K!"
2552:             .FontName      = "Tahoma"
2553:             .ForeColor     = RGB(0, 0, 0)
2554:             .SpecialEffect = 1
2555:             *-- legado getNFs: PROCEDURE When -> Return .f. (campo de exibicao)
2556:             .ReadOnly      = .T.
2557:             .Visible       = .T.
2558:         ENDWITH
2559: 
2560:         *-- Especie (da Nota Fiscal)
2561:         par_oPag.AddObject("lbl_4c_Especie", "Label")
2562:         WITH par_oPag.lbl_4c_Especie
2563:             .Top       = 594
2564:             .Left      = 212
2565:             .Width     = 45
2566:             .FontName  = "Tahoma"
2567:             .ForeColor = RGB(90, 90, 90)
2568:             .Caption   = "Esp" + CHR(233) + "cie :"
2569:             .Visible   = .T.
2570:         ENDWITH
2571: 
2572:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
2573:         WITH par_oPag.txt_4c_EspecieNfs
2574:             .Top           = 590
2575:             .Left          = 262
2576:             .Width         = 52
2577:             .Height        = 23
2578:             .Value         = ""
2579:             .FontName      = "Tahoma"
2580:             .ForeColor     = RGB(0, 0, 0)
2581:             .SpecialEffect = 1
2582:             *-- legado getEspecieNfs (pgDados): When -> Return .f.
2583:             .ReadOnly      = .T.
2584:             .Visible       = .T.
2585:         ENDWITH
2586: 
2587:         *-- Empresa
2588:         par_oPag.AddObject("lbl_4c_Empresa", "Label")
2589:         WITH par_oPag.lbl_4c_Empresa
2590:             .Top       = 621
2591:             .Left      = 207
2592:             .Width     = 50
2593:             .Height    = 15
2594:             .FontName  = "Tahoma"
2595:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 2636 a 2679:
2636:             .ForeColor     = RGB(0, 0, 0)
2637:             .SpecialEffect = 1
2638:             *-- FIEL ao legado: getContEms eh o UNICO campo de detalhe da
2639:             *-- pgDados que NAO declara "PROCEDURE When -> Return .f." no SCX,
2640:             *-- entao continua focavel. Nao transformar em ReadOnly.
2641:             .Visible       = .T.
2642:         ENDWITH
2643: 
2644:         par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
2645:         WITH par_oPag.lbl_4c_BarraEmitente
2646:             .Top       = 566
2647:             .Left      = 540
2648:             .FontName  = "Tahoma"
2649:             .FontSize  = 10
2650:             .FontBold  = .T.
2651:             .ForeColor = RGB(90, 90, 90)
2652:             .Caption   = "/"
2653:             .Visible   = .T.
2654:         ENDWITH
2655: 
2656:         par_oPag.AddObject("txt_4c_DContEms", "TextBox")
2657:         WITH par_oPag.txt_4c_DContEms
2658:             .Top           = 564
2659:             .Left          = 632
2660:             .Width         = 360
2661:             .Height        = 23
2662:             .Value         = ""
2663:             .FontName      = "Tahoma"
2664:             .FontSize      = 8
2665:             .ForeColor     = RGB(0, 0, 0)
2666:             .SpecialEffect = 1
2667:             *-- legado getDContEms: When -> Return .f.
2668:             .ReadOnly      = .T.
2669:             .Visible       = .T.
2670:         ENDWITH
2671: 
2672:         *-- Portador (codigo + razao social)
2673:         par_oPag.AddObject("lbl_4c_Portador", "Label")
2674:         WITH par_oPag.lbl_4c_Portador
2675:             .Top       = 594
2676:             .Left      = 403
2677:             .FontName  = "Tahoma"
2678:             .ForeColor = RGB(90, 90, 90)
2679:             .Caption   = "Portador :"

*-- Linhas 2731 a 2781:
2731:     * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
2732:     * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
2733:     * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
2734:     * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
2735:     * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
2736:     * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
2737:     * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
2738:     * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
2739:     * esses sao os metodos customizados do form, listados no ClassInfo).
2740:     *--------------------------------------------------------------------------
2741:     PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
2742:         *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
2743:         par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
2744:         WITH par_oPag.txt_4c_GrupEms
2745:             .Top           = 564
2746:             .Left          = 459
2747:             .Width         = 80
2748:             .Height        = 23
2749:             .Value         = ""
2750:             .Format        = "K!"
2751:             .FontName      = "Tahoma"
2752:             .ForeColor     = RGB(0, 0, 0)
2753:             .SpecialEffect = 1
2754:             .ReadOnly      = .T.
2755:             .Visible       = .T.
2756:         ENDWITH
2757: 
2758:         *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
2759:         par_oPag.AddObject("txt_4c_Grupo", "TextBox")
2760:         WITH par_oPag.txt_4c_Grupo
2761:             .Top           = 590
2762:             .Left          = 459
2763:             .Width         = 80
2764:             .Height        = 23
2765:             .Value         = ""
2766:             .Format        = "K!"
2767:             .FontName      = "Tahoma"
2768:             .ForeColor     = RGB(0, 0, 0)
2769:             .SpecialEffect = 1
2770:             .ReadOnly      = .T.
2771:             .Visible       = .T.
2772:         ENDWITH
2773: 
2774:         *-- Centro de Custo (Grupo + codigo + "/" + descricao)
2775:         par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
2776:         WITH par_oPag.lbl_4c_CentroCusto
2777:             .Top       = 621
2778:             .Left      = 366
2779:             .FontName  = "Tahoma"
2780:             .ForeColor = RGB(90, 90, 90)
2781:             .Caption   = "Centro de Custo :"

*-- Linhas 3008 a 3071:
3008:             .BackStyle   = 0
3009:             .Visible     = .T.
3010:         ENDWITH
3011:         BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")
3012: 
3013:         *-- Memo com a descricao dos filtros aplicados na consulta (somente
3014:         *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
3015:         par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
3016:         WITH par_oPag.obj_4c_GetFiltros
3017:             .Top           = 83
3018:             .Left          = 510
3019:             .Width         = 381
3020:             .Height        = 66
3021:             .Value         = ""
3022:             .ReadOnly      = .T.
3023:             .FontName      = "Tahoma"
3024:             .SpecialEffect = 1
3025:             .Visible       = .T.
3026:         ENDWITH
3027:         BINDEVENT(par_oPag.obj_4c_GetFiltros, "Click", THIS, "GetFiltrosDadosClick")
3028: 
3029:         *-- Botoes (indicadores de status do titulo - Cancelado/Baixado/
3030:         *-- Conciliado/Prorrogado). TextBoxes read-only coloridos, nunca
3031:         *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
3032:         par_oPag.AddObject("cnt_4c_Botoes", "Container")
3033:         WITH par_oPag.cnt_4c_Botoes
3034:             .Top         = 643
3035:             .Left        =  542
3036:             .Width       = 115
3037:             .Height      = 24
3038:             .BackStyle   = 0
3039:             .BorderWidth = 0
3040:             .Visible     = .T.
3041: 
3042:             .AddObject("txt_4c_Botao1", "TextBox")
3043:             WITH .txt_4c_Botao1
3044:                 .Top         = 1
3045:                 .Left        = 1
3046:                 .Width       = 29
3047:                 .Height      = 23
3048:                 .Alignment   = 0
3049:                 .Value       = ""
3050:                 .FontBold    = .T.
3051:                 .FontSize    = 12
3052:                 .BackColor   = RGB(255, 0, 0)
3053:                 .ToolTipText = "T" + CHR(237) + "tulo Cancelado"
3054:                 .ReadOnly    = .T.
3055:                 .TabStop     = .F.
3056:                 .Themes      = .F.
3057:                 .Visible     = .T.
3058:             ENDWITH
3059: 
3060:             .AddObject("txt_4c_Botao2", "TextBox")
3061:             WITH .txt_4c_Botao2
3062:                 .Top         = 1
3063:                 .Left        = 29
3064:                 .Width       = 29
3065:                 .Height      = 23
3066:                 .Alignment   = 0
3067:                 .Value       = ""
3068:                 .FontBold    = .T.
3069:                 .FontSize    = 12
3070:                 .BackColor   = RGB(0, 128, 0)
3071:                 .ToolTipText = "T" + CHR(237) + "tulo Baixado"

*-- Linhas 3117 a 3683:
3117:     * GetFiltrosDadosClick - Expande/retrai o memo de filtros aplicados
3118:     * (igual ao Click original do getFiltros da Page2 - alterna Height).
3119:     *--------------------------------------------------------------------------
3120:     PROCEDURE GetFiltrosDadosClick()
3121:         LOCAL loc_oMemo
3122:         loc_oMemo = THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros
3123: 
3124:         IF loc_oMemo.Height = 66
3125:             loc_oMemo.Height = 200
3126:         ELSE
3127:             loc_oMemo.Height = 66
3128:         ENDIF
3129:     ENDPROC
3130: 
3131:     *--------------------------------------------------------------------------
3132:     * CmgRetornarClick / Btn*Click (Page2) - navegacao e acoes. A logica
3133:     * completa (abrir SigCdPgr/SigCdLch, montar relatorio/planilha) e
3134:     * implementada na fase de eventos; aqui o botao ja volta para a Page1
3135:     * (unico comportamento que nao depende de registro selecionado na grade).
3136:     *--------------------------------------------------------------------------
3137:     PROCEDURE CmgRetornarClick()
3138:         *-- cmgRetornar do legado volta para a pagina de filtros. Delega ao
3139:         *-- funil unico de "abandonar a pagina corrente" (BtnCancelarClick).
3140:         THIS.BtnCancelarClick()
3141:     ENDPROC
3142: 
3143:     *--------------------------------------------------------------------------
3144:     * AlternarPagina - FUNIL de navegacao entre Filtros/Dados. Alem de trocar
3145:     * o ActivePage e o modo, repoe o estado que depende da pagina ativa:
3146:     *
3147:     *   - HabilitarCampos(): aplica o contrato de edicao de cada pagina
3148:     *     (filtros editaveis na Page1; campos de exibicao da Page2 sempre
3149:     *     somente-leitura, como os "PROCEDURE When -> Return .f." do legado).
3150:     *   - CarregarLista(): REPINTA a grade de resultado. Processamento()
3151:     *     popula cursor_4c_Dados com a Page2 ainda OCULTA e Refresh em pagina
3152:     *     oculta NAO pinta (regra #21/#46 do CLAUDE.md) - por isso a
3153:     *     repintura tem de acontecer AQUI, DEPOIS do ActivePage.
3154:     *--------------------------------------------------------------------------
3155:     PROCEDURE AlternarPagina(par_nPagina)
3156:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3157: 
3158:         DO CASE
3159:         CASE par_nPagina = 1
3160:             THIS.this_cModoAtual = "FILTROS"
3161:             THIS.HabilitarCampos(.T.)
3162:         CASE par_nPagina = 2
3163:             THIS.this_cModoAtual = "DADOS"
3164:             THIS.HabilitarCampos(.F.)
3165:             THIS.CarregarLista()
3166:         ENDCASE
3167:     ENDPROC
3168: 
3169:     *--------------------------------------------------------------------------
3170:     * CmgFiltrosClick - Buttons(1)=Consultar valida as 4 faixas de data e
3171:     * segue para a Page2; Buttons(2)=Sair fecha o form (Cancel=.T., tambem
3172:     * dispara por ESC).
3173:     *--------------------------------------------------------------------------
3174:     PROCEDURE CmgFiltrosClick()
3175:         LOCAL loc_oGrupo, loc_nBotao
3176: 
3177:         loc_oGrupo = THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros
3178:         loc_nBotao = loc_oGrupo.Value
3179: 
3180:         DO CASE
3181:         CASE loc_nBotao = 1
3182:             THIS.BtnBuscarClick()
3183:         CASE loc_nBotao = 2
3184:             THIS.BtnCancelarClick()
3185:         ENDCASE
3186:     ENDPROC
3187: 
3188:     *--------------------------------------------------------------------------
3189:     * ValidarFiltrosData - Transcricao literal das 4 checagens "Inicial nao
3190:     * pode ser maior que a Final" do Click original (Emissao/Vencimento
3191:     * confirmados no dump; Lancamento/Acerto seguem o MESMO padrao simetrico).
3192:     *--------------------------------------------------------------------------
3193:     PROTECTED PROCEDURE ValidarFiltrosData()
3194:         LOCAL loc_oPag
3195:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3196: 
3197:         IF !EMPTY(loc_oPag.txt_4c_DtEmiI.Value) AND !EMPTY(loc_oPag.txt_4c_DtEmiF.Value) AND ;
3198:            (loc_oPag.txt_4c_DtEmiI.Value > loc_oPag.txt_4c_DtEmiF.Value)
3199:             MsgAviso("A Data de Emiss" + CHR(227) + "o Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3200:             loc_oPag.txt_4c_DtEmiI.SetFocus()
3201:             RETURN .F.
3202:         ENDIF
3203: 
3204:         IF !EMPTY(loc_oPag.txt_4c_VencsI.Value) AND !EMPTY(loc_oPag.txt_4c_VencsF.Value) AND ;
3205:            (loc_oPag.txt_4c_VencsI.Value > loc_oPag.txt_4c_VencsF.Value)
3206:             MsgAviso("A Data de Vencimento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3207:             loc_oPag.txt_4c_VencsI.SetFocus()
3208:             RETURN .F.
3209:         ENDIF
3210: 
3211:         IF !EMPTY(loc_oPag.txt_4c_DatasI.Value) AND !EMPTY(loc_oPag.txt_4c_DatasF.Value) AND ;
3212:            (loc_oPag.txt_4c_DatasI.Value > loc_oPag.txt_4c_DatasF.Value)
3213:             MsgAviso("A Data de Lan" + CHR(231) + "amento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3214:             loc_oPag.txt_4c_DatasI.SetFocus()
3215:             RETURN .F.
3216:         ENDIF
3217: 
3218:         IF !EMPTY(loc_oPag.txt_4c_DtBxI.Value) AND !EMPTY(loc_oPag.txt_4c_DtBxF.Value) AND ;
3219:            (loc_oPag.txt_4c_DtBxI.Value > loc_oPag.txt_4c_DtBxF.Value)
3220:             MsgAviso("A Data de Acerto Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3221:             loc_oPag.txt_4c_DtBxI.SetFocus()
3222:             RETURN .F.
3223:         ENDIF
3224: 
3225:         RETURN .T.
3226:     ENDPROC
3227: 
3228:     *--------------------------------------------------------------------------
3229:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3230:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3231:     *--------------------------------------------------------------------------
3232:     PROCEDURE ApagaClick()
3233:         LOCAL loc_cCursor
3234:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3235: 
3236:         IF USED(loc_cCursor)
3237:             SELECT (loc_cCursor)
3238:             REPLACE ALL Imps WITH 0
3239:             GO TOP
3240:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3241:         ENDIF
3242:     ENDPROC
3243: 
3244:     PROCEDURE SelTudoClick()
3245:         LOCAL loc_cCursor
3246:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3247: 
3248:         IF USED(loc_cCursor)
3249:             SELECT (loc_cCursor)
3250:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3251:             GO TOP
3252:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3253:         ENDIF
3254:     ENDPROC
3255: 
3256:     *--------------------------------------------------------------------------
3257:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3258:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3259:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3260:     * TmpCliente2).
3261:     *--------------------------------------------------------------------------
3262:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3263:         IF !USED(par_cCursor)
3264:             RETURN
3265:         ENDIF
3266: 
3267:         SELECT (par_cCursor)
3268:         GO TOP
3269:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3270:         IF EOF()
3271:             APPEND BLANK
3272:             GO BOTTOM
3273:         ENDIF
3274: 
3275:         par_oGrid.Refresh()
3276:         par_oGrid.SetFocus()
3277:         par_oGrid.Column1.SetFocus()
3278:     ENDPROC
3279: 
3280:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3281:         IF !USED(par_cCursor)
3282:             RETURN
3283:         ENDIF
3284: 
3285:         SELECT (par_cCursor)
3286:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3287:             DELETE
3288:         ENDIF
3289: 
3290:         GO TOP
3291:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3292:         IF EOF()
3293:             APPEND BLANK
3294:             GO BOTTOM
3295:         ENDIF
3296: 
3297:         par_oGrid.Refresh()
3298:         par_oGrid.SetFocus()
3299:         par_oGrid.Column1.SetFocus()
3300:     ENDPROC
3301: 
3302:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3303:         IF !USED(par_cCursor)
3304:             RETURN
3305:         ENDIF
3306: 
3307:         ZAP IN (par_cCursor)
3308:         SELECT (par_cCursor)
3309:         APPEND BLANK
3310:         par_oGrid.Refresh()
3311:     ENDPROC
3312: 
3313:     PROCEDURE BtnInserirClick()
3314:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3315:     ENDPROC
3316: 
3317:     PROCEDURE BtnExcluirClick()
3318:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3319:     ENDPROC
3320: 
3321:     PROCEDURE BtnInserir2Click()
3322:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3323:     ENDPROC
3324: 
3325:     PROCEDURE BtnExcluir2Click()
3326:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3327:     ENDPROC
3328: 
3329:     PROCEDURE BtnApagaG1Click()
3330:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3331:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3332:         ENDIF
3333:     ENDPROC
3334: 
3335:     PROCEDURE BtnApagaG2Click()
3336:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3337:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3338:         ENDIF
3339:     ENDPROC
3340: 
3341:     *--------------------------------------------------------------------------
3342:     * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
3343:     * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
3344:     * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
3345:     *--------------------------------------------------------------------------
3346:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3347:         IF USED(par_cCursor)
3348:             SELECT (par_cCursor)
3349:             IF !EOF()
3350:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3351:             ENDIF
3352:         ENDIF
3353:         par_oGrid.Refresh()
3354:     ENDPROC
3355: 
3356:     *-- grdTipo.Column1.Check1 (Imps)
3357:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3358:         IF INLIST(par_nKeyCode, 13, 32)
3359:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3360:             NODEFAULT
3361:         ENDIF
3362:     ENDPROC
3363:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3364:         THIS.ChkTipoKeyPress(13, 0)
3365:         NODEFAULT
3366:     ENDPROC
3367:     PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3368:         NODEFAULT
3369:     ENDPROC
3370:     PROCEDURE ChkTipoClick()
3371:         NODEFAULT
3372:     ENDPROC
3373: 
3374:     *-- Grd_Clientes.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3375:     PROCEDURE ChkCliEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3376:         IF INLIST(par_nKeyCode, 13, 32)
3377:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3378:             NODEFAULT
3379:         ENDIF
3380:     ENDPROC
3381:     PROCEDURE ChkCliEMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3382:         THIS.ChkCliEKeyPress(13, 0)
3383:         NODEFAULT
3384:     ENDPROC
3385:     PROCEDURE ChkCliEMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3386:         NODEFAULT
3387:     ENDPROC
3388:     PROCEDURE ChkCliEClick()
3389:         NODEFAULT
3390:     ENDPROC
3391: 
3392:     PROCEDURE ChkCliPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3393:         IF INLIST(par_nKeyCode, 13, 32)
3394:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3395:             NODEFAULT
3396:         ENDIF
3397:     ENDPROC
3398:     PROCEDURE ChkCliPMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3399:         THIS.ChkCliPKeyPress(13, 0)
3400:         NODEFAULT
3401:     ENDPROC
3402:     PROCEDURE ChkCliPMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3403:         NODEFAULT
3404:     ENDPROC
3405:     PROCEDURE ChkCliPClick()
3406:         NODEFAULT
3407:     ENDPROC
3408: 
3409:     PROCEDURE ChkCliCKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3410:         IF INLIST(par_nKeyCode, 13, 32)
3411:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3412:             NODEFAULT
3413:         ENDIF
3414:     ENDPROC
3415:     PROCEDURE ChkCliCMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3416:         THIS.ChkCliCKeyPress(13, 0)
3417:         NODEFAULT
3418:     ENDPROC
3419:     PROCEDURE ChkCliCMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3420:         NODEFAULT
3421:     ENDPROC
3422:     PROCEDURE ChkCliCClick()
3423:         NODEFAULT
3424:     ENDPROC
3425: 
3426:     PROCEDURE ChkCliAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3427:         IF INLIST(par_nKeyCode, 13, 32)
3428:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3429:             NODEFAULT
3430:         ENDIF
3431:     ENDPROC
3432:     PROCEDURE ChkCliAMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3433:         THIS.ChkCliAKeyPress(13, 0)
3434:         NODEFAULT
3435:     ENDPROC
3436:     PROCEDURE ChkCliAMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3437:         NODEFAULT
3438:     ENDPROC
3439:     PROCEDURE ChkCliAClick()
3440:         NODEFAULT
3441:     ENDPROC
3442: 
3443:     *-- Grd_Clientes2.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3444:     PROCEDURE ChkCli2EKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3445:         IF INLIST(par_nKeyCode, 13, 32)
3446:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3447:             NODEFAULT
3448:         ENDIF
3449:     ENDPROC
3450:     PROCEDURE ChkCli2EMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3451:         THIS.ChkCli2EKeyPress(13, 0)
3452:         NODEFAULT
3453:     ENDPROC
3454:     PROCEDURE ChkCli2EMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3455:         NODEFAULT
3456:     ENDPROC
3457:     PROCEDURE ChkCli2EClick()
3458:         NODEFAULT
3459:     ENDPROC
3460: 
3461:     PROCEDURE ChkCli2PKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3462:         IF INLIST(par_nKeyCode, 13, 32)
3463:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3464:             NODEFAULT
3465:         ENDIF
3466:     ENDPROC
3467:     PROCEDURE ChkCli2PMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3468:         THIS.ChkCli2PKeyPress(13, 0)
3469:         NODEFAULT
3470:     ENDPROC
3471:     PROCEDURE ChkCli2PMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3472:         NODEFAULT
3473:     ENDPROC
3474:     PROCEDURE ChkCli2PClick()
3475:         NODEFAULT
3476:     ENDPROC
3477: 
3478:     PROCEDURE ChkCli2CKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3479:         IF INLIST(par_nKeyCode, 13, 32)
3480:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3481:             NODEFAULT
3482:         ENDIF
3483:     ENDPROC
3484:     PROCEDURE ChkCli2CMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3485:         THIS.ChkCli2CKeyPress(13, 0)
3486:         NODEFAULT
3487:     ENDPROC
3488:     PROCEDURE ChkCli2CMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3489:         NODEFAULT
3490:     ENDPROC
3491:     PROCEDURE ChkCli2CClick()
3492:         NODEFAULT
3493:     ENDPROC
3494: 
3495:     PROCEDURE ChkCli2AKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3496:         IF INLIST(par_nKeyCode, 13, 32)
3497:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3498:             NODEFAULT
3499:         ENDIF
3500:     ENDPROC
3501:     PROCEDURE ChkCli2AMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3502:         THIS.ChkCli2AKeyPress(13, 0)
3503:         NODEFAULT
3504:     ENDPROC
3505:     PROCEDURE ChkCli2AMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3506:         NODEFAULT
3507:     ENDPROC
3508:     PROCEDURE ChkCli2AClick()
3509:         NODEFAULT
3510:     ENDPROC
3511: 
3512:     *--------------------------------------------------------------------------
3513:     * CmdAddFiltroClick - Abre o campo de digitacao do nome de um filtro novo
3514:     * (equivalente ao legado: esconde getFiltros, mostra getNewFiltro).
3515:     *--------------------------------------------------------------------------
3516:     PROCEDURE CmdAddFiltroClick()
3517:         WITH THIS.pgf_4c_Paginas.Page1
3518:             .txt_4c_Filtros.Visible   = .F.
3519:             .txt_4c_NewFiltro.Visible = .T.
3520:             .txt_4c_NewFiltro.Value   = ""
3521:             .txt_4c_NewFiltro.SetFocus()
3522:         ENDWITH
3523:     ENDPROC
3524: 
3525:     *--------------------------------------------------------------------------
3526:     * BtnRecFiltroClick/CmdDelFiltroClick - Gravar/Apagar filtro nomeado em
3527:     * SigSyPar (cidparams = "SIGOPCGF" + nome, padrao determinado para
3528:     * permitir localizar e regravar o mesmo filtro). Substitui o
3529:     * ThisForm.poSigSyPar.fGravaUserCfg() do Framework legado (objeto nao
3530:     * portado) por SQL direto; mxmls guarda os valores atuais dos campos de
3531:     * filtro (SerializarFiltros/RestaurarFiltros), nao o XML original.
3532:     *--------------------------------------------------------------------------
3533:     PROCEDURE BtnRecFiltroClick()
3534:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cValores, loc_nExiste, loc_cSQL, loc_oErro
3535: 
3536:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3537:         loc_cNome = IIF(loc_oPag.txt_4c_NewFiltro.Visible, ALLTRIM(loc_oPag.txt_4c_NewFiltro.Value), ALLTRIM(loc_oPag.txt_4c_Filtros.Value))
3538: 
3539:         IF EMPTY(loc_cNome)
3540:             MsgAviso("Informe o nome do filtro antes de grav" + CHR(225) + "-lo.", "Aten" + CHR(231) + CHR(227) + "o")
3541:             RETURN
3542:         ENDIF
3543: 
3544:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3545:             RETURN
3546:         ENDIF
3547: 
3548:         TRY
3549:             loc_cId      = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3550:             loc_cValores = THIS.SerializarFiltros()
3551:             loc_nExiste  = 0
3552: 
3553:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3554:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3555:                 USE IN cursor_4c_FiltroExiste
3556:             ENDIF
3557: 
3558:             IF loc_nExiste > 0
3559:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3560:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3561:             ELSE
3562:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3563:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3564:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3565:             ENDIF
3566: 
3567:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3568:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3569:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3570:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3571:                 THIS.CarregarFiltrosSalvos()
3572:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3573:             ELSE
3574:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3575:             ENDIF
3576:         CATCH TO loc_oErro
3577:             MsgErro(loc_oErro.Message, "Erro")
3578:         ENDTRY
3579:     ENDPROC
3580: 
3581:     PROCEDURE CmdDelFiltroClick()
3582:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro
3583: 
3584:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3585:         loc_cNome = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3586: 
3587:         IF EMPTY(loc_cNome)
3588:             RETURN
3589:         ENDIF
3590: 
3591:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do filtro [" + loc_cNome + "]?", "Excluir Filtro")
3592:             RETURN
3593:         ENDIF
3594: 
3595:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3596:             RETURN
3597:         ENDIF
3598: 
3599:         TRY
3600:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3601:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3602: 
3603:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3604:                 loc_oPag.txt_4c_Filtros.Value = ""
3605:                 THIS.CarregarFiltrosSalvos()
3606:             ELSE
3607:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3608:             ENDIF
3609:         CATCH TO loc_oErro
3610:             MsgErro(loc_oErro.Message, "Erro")
3611:         ENDTRY
3612:     ENDPROC
3613: 
3614:     *--------------------------------------------------------------------------
3615:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3616:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3617:     * (equivalente ao mLerCfg() do Framework legado).
3618:     *--------------------------------------------------------------------------
3619:     PROCEDURE GetFiltrosLostFocus()
3620:         LOCAL loc_oPag, loc_cNome, loc_cCursor
3621: 
3622:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
3623:         loc_cNome  = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3624:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorFiltros
3625: 
3626:         IF EMPTY(loc_cNome) OR !USED(loc_cCursor)
3627:             RETURN
3628:         ENDIF
3629: 
3630:         SELECT (loc_cCursor)
3631:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3632: 
3633:         IF FOUND()
3634:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3635:         ENDIF
3636:     ENDPROC
3637: 
3638:     *--------------------------------------------------------------------------
3639:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3640:     * separador) dos campos de filtro para gravar/recarregar um filtro
3641:     * nomeado em SigSyPar.Mxmls.
3642:     *--------------------------------------------------------------------------
3643:     PROTECTED PROCEDURE SerializarFiltros()
3644:         LOCAL loc_oBO
3645: 
3646:         *-- FONTE UNICA: captura a tela nas propriedades do BO e serializa a
3647:         *-- partir DELAS, para nao haver duas leituras divergentes dos mesmos
3648:         *-- controles. Ordem e formato das 27 posicoes inalterados.
3649:         THIS.FormParaBO()
3650:         loc_oBO = THIS.this_oBusinessObject
3651: 
3652:         RETURN ;
3653:             TRANSFORM(loc_oBO.this_dDtEmiI)    + CHR(9) + ;
3654:             TRANSFORM(loc_oBO.this_dDtEmiF)    + CHR(9) + ;
3655:             TRANSFORM(loc_oBO.this_dVencsI)    + CHR(9) + ;
3656:             TRANSFORM(loc_oBO.this_dVencsF)    + CHR(9) + ;
3657:             TRANSFORM(loc_oBO.this_dDatasI)    + CHR(9) + ;
3658:             TRANSFORM(loc_oBO.this_dDatasF)    + CHR(9) + ;
3659:             TRANSFORM(loc_oBO.this_dDtBxI)     + CHR(9) + ;
3660:             TRANSFORM(loc_oBO.this_dDtBxF)     + CHR(9) + ;
3661:             ALLTRIM(loc_oBO.this_cTitulos)     + CHR(9) + ;
3662:             ALLTRIM(loc_oBO.this_cTitBans)     + CHR(9) + ;
3663:             ALLTRIM(loc_oBO.this_cEspecieNfs)  + CHR(9) + ;
3664:             ALLTRIM(loc_oBO.this_cNFs)         + CHR(9) + ;
3665:             ALLTRIM(loc_oBO.this_cCMoes)       + CHR(9) + ;
3666:             ALLTRIM(loc_oBO.this_cCMoesC)      + CHR(9) + ;
3667:             ALLTRIM(loc_oBO.this_cMoeSaldo)    + CHR(9) + ;
3668:             TRANSFORM(loc_oBO.this_nSaldo)     + CHR(9) + ;
3669:             ALLTRIM(loc_oBO.this_cCFPublis)    + CHR(9) + ;
3670:             ALLTRIM(loc_oBO.this_cEmpresa)     + CHR(9) + ;
3671:             TRANSFORM(IIF(loc_oBO.this_lBrancos, 1, 0))  + CHR(9) + ;
3672:             TRANSFORM(IIF(loc_oBO.this_lValPends, 1, 0)) + CHR(9) + ;
3673:             TRANSFORM(loc_oBO.this_nPagos)     + CHR(9) + ;
3674:             TRANSFORM(loc_oBO.this_nOpcao)     + CHR(9) + ;
3675:             TRANSFORM(loc_oBO.this_nCotEm)     + CHR(9) + ;
3676:             TRANSFORM(loc_oBO.this_nCancs)     + CHR(9) + ;
3677:             TRANSFORM(loc_oBO.this_nConcs)     + CHR(9) + ;
3678:             TRANSFORM(loc_oBO.this_nProrrogs)  + CHR(9) + ;
3679:             TRANSFORM(loc_oBO.this_nFilGrd2)
3680:     ENDPROC
3681: 
3682:     *--------------------------------------------------------------------------
3683:     * ObterTokenSerializado - Devolve a par_nPos-esima posicao de uma string

*-- Linhas 3689 a 3757:
3689:     * uma posicao vazia por filtro nao preenchido), usar GETWORDNUM faz o
3690:     * filtro nomeado voltar com os valores nos campos ERRADOS, em silencio -
3691:     * medido no VFP9 em 2026-10-24: com 4 posicoes vazias antes dele, o
3692:     * "Titulo" recebia o valor do 21o campo (indice do OptionGroup Pagamento).
3693:     *--------------------------------------------------------------------------
3694:     PROTECTED FUNCTION ObterTokenSerializado(par_cTexto, par_nPos)
3695:         LOCAL loc_nIni, loc_nFim, loc_cToken
3696:         loc_cToken = ""
3697: 
3698:         IF par_nPos <= 1
3699:             loc_nIni = 1
3700:         ELSE
3701:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos - 1)
3702:             loc_nIni = IIF(loc_nFim = 0, 0, loc_nFim + 1)
3703:         ENDIF
3704: 
3705:         IF loc_nIni > 0
3706:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos)
3707:             IF loc_nFim = 0
3708:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni)
3709:             ELSE
3710:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni, loc_nFim - loc_nIni)
3711:             ENDIF
3712:         ENDIF
3713: 
3714:         RETURN loc_cToken
3715:     ENDFUNC
3716: 
3717:     PROTECTED PROCEDURE RestaurarFiltros(par_cSerializado)
3718:         LOCAL loc_oBO, loc_nI
3719:         LOCAL ARRAY loc_aPartes[27]
3720: 
3721:         IF EMPTY(par_cSerializado)
3722:             RETURN
3723:         ENDIF
3724: 
3725:         FOR loc_nI = 1 TO 27
3726:             loc_aPartes[loc_nI] = THIS.ObterTokenSerializado(par_cSerializado, loc_nI)
3727:         ENDFOR
3728: 
3729:         *-- Captura a tela ANTES de sobrescrever: o blob guarda SO as 27
3730:         *-- posicoes de filtro, e o que nao esta nele (descricoes dos lookups,
3731:         *-- nome do filtro, ordem/totalizadores da Page2) tem de voltar ao
3732:         *-- BOParaForm com o valor que ja estava na tela, nao com um residuo.
3733:         THIS.FormParaBO()
3734:         loc_oBO = THIS.this_oBusinessObject
3735: 
3736:         loc_oBO.this_dDtEmiI    = ConverterParaData(loc_aPartes[1])
3737:         loc_oBO.this_dDtEmiF    = ConverterParaData(loc_aPartes[2])
3738:         loc_oBO.this_dVencsI    = ConverterParaData(loc_aPartes[3])
3739:         loc_oBO.this_dVencsF    = ConverterParaData(loc_aPartes[4])
3740:         loc_oBO.this_dDatasI    = ConverterParaData(loc_aPartes[5])
3741:         loc_oBO.this_dDatasF    = ConverterParaData(loc_aPartes[6])
3742:         loc_oBO.this_dDtBxI     = ConverterParaData(loc_aPartes[7])
3743:         loc_oBO.this_dDtBxF     = ConverterParaData(loc_aPartes[8])
3744:         loc_oBO.this_cTitulos   = loc_aPartes[9]
3745:         loc_oBO.this_cTitBans   = loc_aPartes[10]
3746:         loc_oBO.this_cEspecieNfs = loc_aPartes[11]
3747:         loc_oBO.this_cNFs       = loc_aPartes[12]
3748:         loc_oBO.this_cCMoes     = loc_aPartes[13]
3749:         loc_oBO.this_cCMoesC    = loc_aPartes[14]
3750:         loc_oBO.this_cMoeSaldo  = loc_aPartes[15]
3751:         loc_oBO.this_nSaldo     = VAL(loc_aPartes[16])
3752:         loc_oBO.this_cCFPublis  = loc_aPartes[17]
3753:         loc_oBO.this_cEmpresa   = loc_aPartes[18]
3754:         loc_oBO.this_lBrancos   = (VAL(loc_aPartes[19]) = 1)
3755:         loc_oBO.this_lValPends  = (VAL(loc_aPartes[20]) = 1)
3756:         loc_oBO.this_nPagos     = IIF(BETWEEN(VAL(loc_aPartes[21]), 1, 3), VAL(loc_aPartes[21]), 1)
3757:         loc_oBO.this_nOpcao     = IIF(BETWEEN(VAL(loc_aPartes[22]), 1, 3), VAL(loc_aPartes[22]), 1)

*-- Linhas 3769 a 3967:
3769:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3770:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3771:     *--------------------------------------------------------------------------
3772:     PROTECTED PROCEDURE CarregarTiposOperacao()
3773:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3774: 
3775:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3776:             RETURN
3777:         ENDIF
3778: 
3779:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3780:         loc_cCursorTmp = loc_cCursor + "Tmp"
3781:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3782: 
3783:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3784:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3785:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3786:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3787:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3788:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3789:             SELECT (loc_cCursor)
3790:             ZAP
3791:             APPEND FROM DBF(loc_cCursorTmp)
3792:             IF USED(loc_cCursorTmp)
3793:                 USE IN (loc_cCursorTmp)
3794:             ENDIF
3795: 
3796:             SELECT (loc_cCursor)
3797:             APPEND BLANK
3798:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3799:             GO TOP
3800: 
3801:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3802:         ENDIF
3803:     ENDPROC
3804: 
3805:     *--------------------------------------------------------------------------
3806:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3807:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3808:     * por "SIGOPCGF").
3809:     *--------------------------------------------------------------------------
3810:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3811:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId
3812: 
3813:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3814:             RETURN
3815:         ENDIF
3816: 
3817:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorFiltros
3818:         loc_cCursorTmp = loc_cCursor + "Tmp"
3819:         loc_cId        = PADR("SIGOPCGF", 8)
3820: 
3821:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3822:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3823: 
3824:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3825:             SELECT (loc_cCursor)
3826:             ZAP
3827:             APPEND FROM DBF(loc_cCursorTmp)
3828:             IF USED(loc_cCursorTmp)
3829:                 USE IN (loc_cCursorTmp)
3830:             ENDIF
3831:             SELECT (loc_cCursor)
3832:             GO TOP
3833:         ENDIF
3834:     ENDPROC
3835: 
3836:     *--------------------------------------------------------------------------
3837:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3838:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3839:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3840:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3841:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3842:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3843:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3844:     * restringir o universo de clientes.
3845:     *--------------------------------------------------------------------------
3846:     PROCEDURE BtnCarregarClick()
3847:         LOCAL loc_oPag
3848:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3849: 
3850:         IF EMPTY(loc_oPag.txt_4c_CFPublis.Value)
3851:             MsgAviso("Forma de Publicidade Para Filtro N" + CHR(227) + "o foi Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3852:             loc_oPag.txt_4c_CFPublis.SetFocus()
3853:             RETURN
3854:         ENDIF
3855: 
3856:         THIS.CarregarFPubs()
3857:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, loc_oPag.grd_4c_Clientes)
3858:     ENDPROC
3859: 
3860:     PROTECTED PROCEDURE CarregarFPubs()
3861:         LOCAL loc_oPag, loc_cPub, loc_cCursor, loc_cCursorTmp, loc_cSQL
3862: 
3863:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3864:             RETURN
3865:         ENDIF
3866: 
3867:         loc_oPag       = THIS.pgf_4c_Paginas.Page1
3868:         loc_cPub       = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
3869:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3870:         loc_cCursorTmp = loc_cCursor + "Tmp"
3871: 
3872:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3873:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3874:                    "FROM SigCdCli a, SigCdGcr b " + ;
3875:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3876: 
3877:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3878:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3879:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3880:             SELECT (loc_cCursor)
3881:             ZAP
3882:             APPEND FROM DBF(loc_cCursorTmp)
3883:             IF USED(loc_cCursorTmp)
3884:                 USE IN (loc_cCursorTmp)
3885:             ENDIF
3886:             SELECT (loc_cCursor)
3887:             GO TOP
3888:             loc_oPag.grd_4c_Clientes.Refresh()
3889:         ELSE
3890:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3891:         ENDIF
3892:     ENDPROC
3893: 
3894:     *--------------------------------------------------------------------------
3895:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3896:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3897:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3898:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3899:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3900:     * ControlSource de cursor que ainda nao existe derruba o Init).
3901:     *--------------------------------------------------------------------------
3902:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3903:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3904:         WITH par_oPag.grd_4c_Dados
3905:             .Top               = 202
3906:             .Left              = 7
3907:             .Width             = 986
3908:             .Height            = 355
3909:             .DeleteMark        = .F.
3910:             .RecordMark        = .F.
3911:             .ReadOnly          = .T.
3912:             .AllowHeaderSizing = .F.
3913:             .AllowRowSizing    = .F.
3914:             .GridLineColor     = RGB(238, 238, 238)
3915:             .ScrollBars        = 2
3916:             .Visible           = .T.
3917:         ENDWITH
3918:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3919:     ENDPROC
3920: 
3921:     *--------------------------------------------------------------------------
3922:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3923:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3924:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre
3925:     * chamado depois de Processamento() repovoar o cursor.
3926:     *--------------------------------------------------------------------------
3927:     PROTECTED PROCEDURE MontarGradeDados()
3928:         LOCAL loc_oGrid, loc_cCursor, loc_cCor
3929: 
3930:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
3931:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
3932: 
3933:         loc_cCor = "IIF(" + loc_cCursor + ".Nopers=9999998, RGB(255,253,179), " + ;
3934:                    "IIF(" + loc_cCursor + ".Nopers=9999999, RGB(221,252,255), " + ;
3935:                    "IIF(" + loc_cCursor + ".SInis=1, RGB(255,202,205), RGB(255,255,255))))"
3936: 
3937:         *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
3938:         *-- .Column1..12 - evita 'Unknown member COLUMN1'.
3939:         loc_oGrid.RecordSource = ""
3940:         loc_oGrid.ColumnCount  = 12
3941:         loc_oGrid.RecordSource = loc_cCursor
3942: 
3943:         WITH loc_oGrid
3944:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3945:             .Column1.Width           = 64
3946:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3947: 
3948:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3949:             .Column2.Width           = 64
3950:             .Column2.Header1.Caption = "Vencto."
3951: 
3952:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3953:             .Column3.Width           = 64
3954:             .Column3.Header1.Caption = "Lancto."
3955: 
3956:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3957:             .Column4.Width           = 64
3958:             .Column4.Header1.Caption = "Baixa"
3959: 
3960:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3961:             .Column5.Width           = 70
3962:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3963: 
3964:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3965:             .Column6.Width           = 240
3966:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3967: 

*-- Linhas 4006 a 4052:
4006:     * GrdDadosAfterRowColChange - equivalente ao AfterRowColChange de
4007:     * grdDados1: carrega a linha corrente (via BO.CarregarDoCursor), espelha
4008:     * os campos de detalhe da Page2 e os 4 indicadores de status (Botao1..4),
4009:     * e habilita/desabilita os botoes de acao conforme o PROCEDURE When do
4010:     * legado (linha "real" x linha sintetica de totalizador).
4011:     *--------------------------------------------------------------------------
4012:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
4013:         LOCAL loc_oPag, loc_oBO, loc_lTot
4014: 
4015:         IF !USED(THIS.this_oBusinessObject.this_cCursorDados)
4016:             RETURN
4017:         ENDIF
4018:         IF !THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
4019:             RETURN
4020:         ENDIF
4021: 
4022:         loc_oPag = THIS.pgf_4c_Paginas.Page2
4023:         loc_oBO  = THIS.this_oBusinessObject
4024: 
4025:         *-- Bloco de limpeza do AfterRowColChange legado, extraido para o funil
4026:         *-- unico LimparCampos(). O legado limpa SEMPRE as 4 descricoes e, SO
4027:         *-- quando a linha e sintetica (llTot), os outros 14 campos; como o
4028:         *-- ramo "IF !loc_lTot" abaixo reatribui TODOS os 18, limpar os 18 de
4029:         *-- uma vez produz exatamente o mesmo resultado nos dois caminhos.
4030:         THIS.LimparCampos()
4031: 
4032:         loc_lTot = (loc_oBO.this_nLinNopers > 9999997) OR (loc_oBO.this_nLinSInis = 1)
4033: 
4034:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = IIF(!loc_lTot AND loc_oBO.this_nLinTitCancs = 1, " X", "")
4035:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = IIF(!loc_lTot AND loc_oBO.this_cLinPagos = "0", " X", "")
4036:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = IIF(!loc_lTot AND loc_oBO.this_lLinConcs, " X", "")
4037:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = IIF(!loc_lTot AND !EMPTY(loc_oBO.this_dLinProrrogs), " X", "")
4038: 
4039:         IF !loc_lTot
4040:             loc_oPag.txt_4c_NFs.Value        = loc_oBO.this_cLinNFs
4041:             loc_oPag.txt_4c_TitBans.Value    = loc_oBO.this_cLinTitBans
4042:             loc_oPag.txt_4c_EspecieNfs.Value = loc_oBO.this_cLinEspecieNfs
4043:             loc_oPag.txt_4c_Hist2s.Value     = loc_oBO.this_cLinHist2s
4044:             loc_oPag.txt_4c_Emps.Value       = loc_oBO.this_cLinEmps
4045:             loc_oPag.txt_4c_ValOcurs.Value   = loc_oBO.this_nLinValOcurs
4046:             loc_oPag.txt_4c_GrupEms.Value    = loc_oBO.this_cLinGrupEms
4047:             loc_oPag.txt_4c_ContEms.Value    = loc_oBO.this_cLinContEms
4048:             loc_oPag.txt_4c_Grupo.Value      = loc_oBO.this_cLinGrupos
4049:             loc_oPag.txt_4c_Contas.Value     = loc_oBO.this_cLinContas
4050:             loc_oPag.txt_4c_SGrupos.Value    = loc_oBO.this_cLinSGrupos
4051:             loc_oPag.txt_4c_SContas.Value    = loc_oBO.this_cLinSContas
4052:             loc_oPag.txt_4c_GrupAges.Value   = loc_oBO.this_cLinGrupAges

*-- Linhas 4058 a 4223:
4058:             loc_oPag.txt_4c_DContAges.Value = THIS.ObterRazaoSocial(loc_oBO.this_cLinContAges)
4059:         ENDIF
4060: 
4061:         *-- PROCEDURE When dos botoes de acao, extraido para o funil unico
4062:         *-- AjustarBotoesPorModo() (tambem chamado por CarregarLista, para a
4063:         *-- PRIMEIRA linha exibida, que nunca dispara AfterRowColChange).
4064:         THIS.AjustarBotoesPorModo()
4065:     ENDPROC
4066: 
4067:     *--------------------------------------------------------------------------
4068:     * ObterRazaoSocial - cache de razao social (IClis/RClis), equivalente ao
4069:     * cursor TmpContas do legado. Consulta SigCdCli SO na primeira vez que o
4070:     * codigo aparece; demais chamadas usam o SEEK no cache local.
4071:     *--------------------------------------------------------------------------
4072:     PROTECTED FUNCTION ObterRazaoSocial(par_cCodigo)
4073:         LOCAL loc_cCursor, loc_cCodigo, loc_cSQL, loc_cResultado
4074:         loc_cResultado = ""
4075:         loc_cCodigo    = ALLTRIM(NVL(par_cCodigo, ""))
4076: 
4077:         IF EMPTY(loc_cCodigo)
4078:             RETURN loc_cResultado
4079:         ENDIF
4080: 
4081:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4082:         IF !USED(loc_cCursor)
4083:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4084:             INDEX ON IClis TAG IClis
4085:         ENDIF
4086: 
4087:         SELECT (loc_cCursor)
4088:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4089:             RETURN ALLTRIM(RClis)
4090:         ENDIF
4091: 
4092:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4093:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4094:             IF !EOF("cursor_4c_RazaoTmp")
4095:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4096:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4097:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4098:             ENDIF
4099:             IF USED("cursor_4c_RazaoTmp")
4100:                 USE IN cursor_4c_RazaoTmp
4101:             ENDIF
4102:         ENDIF
4103: 
4104:         RETURN loc_cResultado
4105:     ENDFUNC
4106: 
4107:     *--------------------------------------------------------------------------
4108:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4109:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4110:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).
4111:     *--------------------------------------------------------------------------
4112:     PROCEDURE CboOrdemInteractiveChange()
4113:         LOCAL loc_oCbo, loc_oBO
4114:         loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem
4115:         loc_oBO  = THIS.this_oBusinessObject
4116: 
4117:         DO CASE
4118:         CASE loc_oCbo.Value = 1
4119:             loc_oBO.this_cOrdem = "DtEmis"
4120:         CASE loc_oCbo.Value = 2
4121:             loc_oBO.this_cOrdem = "Vencs"
4122:         CASE loc_oCbo.Value = 3
4123:             loc_oBO.this_cOrdem = "Datas"
4124:         CASE loc_oCbo.Value = 4
4125:             loc_oBO.this_cOrdem = "DtBaixa"
4126:         CASE loc_oCbo.Value = 5
4127:             loc_oBO.this_cOrdem = "Titulos"
4128:         CASE loc_oCbo.Value = 6
4129:             loc_oBO.this_cOrdem = "Hists"
4130:         CASE loc_oCbo.Value = 7
4131:             loc_oBO.this_cOrdem = "ContEms"
4132:         CASE loc_oCbo.Value = 8
4133:             loc_oBO.this_cOrdem = "Contas"
4134:         ENDCASE
4135:         loc_oBO.this_nOrdem = loc_oCbo.Value
4136: 
4137:         THIS.OrdenaGrade()
4138: 
4139:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4140:     ENDPROC
4141: 
4142:     PROCEDURE ChkTotaisClick()
4143:         THIS.OrdenaGrade()
4144:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4145:     ENDPROC
4146: 
4147:     *--------------------------------------------------------------------------
4148:     * OrdenaGrade - equivalente a ThisForm.OrdenaGrade: alterna entre o TAG
4149:     * filtrado (exclui linhas sinteticas) e o TAG cheio conforme
4150:     * chk_4c_Totais, recalcula os saldos (CalcSaldo/CalcSaldoCta conforme a
4151:     * ordem corrente) e repinta a grade.
4152:     *--------------------------------------------------------------------------
4153:     PROCEDURE OrdenaGrade()
4154:         LOCAL loc_cCursor, loc_cOrd, loc_oBO
4155:         loc_oBO     = THIS.this_oBusinessObject
4156:         loc_cCursor = loc_oBO.this_cCursorDados
4157: 
4158:         IF !USED(loc_cCursor)
4159:             RETURN
4160:         ENDIF
4161: 
4162:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4163: 
4164:         SELECT (loc_cCursor)
4165:         SET ORDER TO TAG (loc_cOrd)
4166: 
4167:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4168:             THIS.CalcSaldoCta()
4169:         ELSE
4170:             THIS.CalcSaldo()
4171:         ENDIF
4172: 
4173:         GO TOP IN (loc_cCursor)
4174:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4175:     ENDPROC
4176: 
4177:     *--------------------------------------------------------------------------
4178:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4179:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas
4180:     * sinteticas de "Saldo Inicial"/"Saldo da Moeda"/"Saldo do dia" conforme
4181:     * a troca de moeda/data na ordenacao corrente.
4182:     *--------------------------------------------------------------------------
4183:     PROTECTED PROCEDURE CalcSaldo()
4184:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4185:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4186:         LOCAL loc_cMsd, loc_nOrd, loc_dDat, loc_dRla, loc_cMoe, loc_nVal
4187: 
4188:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4189:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4190:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4191:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4192: 
4193:         SELECT (loc_cCursor)
4194:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4195: 
4196:         loc_nSdD = 0
4197:         loc_nSD1 = 0
4198:         loc_nSC1 = 0
4199:         loc_nSD2 = 0
4200:         loc_nSC2 = 0
4201:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4202:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4203:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4204: 
4205:         IF USED(loc_cTotais)
4206:             USE IN (loc_cTotais)
4207:         ENDIF
4208:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4209: 
4210:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4211: 
4212:         SELECT (loc_cCursor)
4213:         GO TOP
4214:         loc_dDat = TTOD(DtEmis)
4215:         DO CASE
4216:         CASE loc_nOrd = 2
4217:             loc_dDat = TTOD(Vencs)
4218:         CASE loc_nOrd = 3
4219:             loc_dDat = TTOD(Datas)
4220:         CASE loc_nOrd = 4
4221:             loc_dDat = TTOD(DtBaixa)
4222:         ENDCASE
4223: 

*-- Linhas 4383 a 4426:
4383:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4384:     * compondo a linha sintetica de saldo.
4385:     *--------------------------------------------------------------------------
4386:     PROTECTED PROCEDURE CalcSaldoCta()
4387:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4388:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4389:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4390: 
4391:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4392:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4393:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4394:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4395: 
4396:         SELECT (loc_cCursor)
4397:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4398: 
4399:         loc_nSdD = 0
4400:         loc_nSD1 = 0
4401:         loc_nSC1 = 0
4402:         loc_nSD2 = 0
4403:         loc_nSC2 = 0
4404:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4405:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4406: 
4407:         IF USED(loc_cTotais)
4408:             USE IN (loc_cTotais)
4409:         ENDIF
4410:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4411: 
4412:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4413: 
4414:         SELECT (loc_cCursor)
4415:         GO TOP
4416:         loc_dDat = TTOD(DtEmis)
4417:         loc_cMoe = ALLTRIM(Moedas)
4418:         loc_cEmi = ALLTRIM(ContEms)
4419:         loc_cPor = ALLTRIM(Contas)
4420: 
4421:         SCAN
4422:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4423:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4424:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4425: 
4426:                 SCATTER MEMVAR

*-- Linhas 4538 a 4648:
4538:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4539:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4540:     *--------------------------------------------------------------------------
4541:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4542:         LOCAL loc_cWhere
4543: 
4544:         IF EMPTY(par_cColGrupo)
4545:             RETURN
4546:         ENDIF
4547: 
4548:         DO CASE
4549:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4550:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "' AND " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4551:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4552:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "'"
4553:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4554:             loc_cWhere = par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4555:         OTHERWISE
4556:             RETURN
4557:         ENDCASE
4558: 
4559:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4560:     ENDPROC
4561: 
4562:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4563:         LOCAL loc_cWhere
4564: 
4565:         IF EMPTY(par_cColGrupo)
4566:             RETURN
4567:         ENDIF
4568: 
4569:         DO CASE
4570:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4571:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4572:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4573:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4574:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4575:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4576:         OTHERWISE
4577:             RETURN
4578:         ENDCASE
4579: 
4580:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4581:     ENDPROC
4582: 
4583:     *--------------------------------------------------------------------------
4584:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4585:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4586:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4587:     *--------------------------------------------------------------------------
4588:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4589:         LOCAL loc_dData
4590:         loc_dData = par_dData
4591:         IF EMPTY(loc_dData)
4592:             loc_dData = {^2099-12-31}
4593:         ENDIF
4594:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4595:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"
4596:     ENDFUNC
4597: 
4598:     *--------------------------------------------------------------------------
4599:     * Processamento - transcricao do Processamento/ThisForm.Processamento do
4600:     * legado: monta a consulta financeira (SigMvCcr + filtros de Page1),
4601:     * aplica os filtros de Grupo/Conta das duas grades auxiliares, preenche
4602:     * a Data de Baixa e converte moeda quando necessario, cria os indices de
4603:     * ordenacao e deixa cursor_4c_Dados pronto para a Page2. Retorna .T. se
4604:     * encontrou dados (e so nesse caso o CmgFiltrosClick avanca para a
4605:     * Page2); .F. mantem o usuario na Page1 (igual ao ActivePage=1 do
4606:     * legado nos dois pontos de "Dados Nao Encontrados").
4607:     *--------------------------------------------------------------------------
4608:     PROCEDURE Processamento()
4609:         LOCAL loc_oPag1, loc_oBO, loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cRes
4610:         LOCAL loc_cEmp, loc_cDem, loc_cDvc, loc_cDla, loc_cMoe, loc_cPag, loc_cOpc
4611:         LOCAL loc_cCan, loc_cCcl, loc_cTit, loc_cNfs, loc_cTba, loc_cEsp, loc_cOpT
4612:         LOCAL loc_cCodEmp, loc_dDeI, loc_dDeF, loc_dDvI, loc_dDvF, loc_dDlI, loc_dDlF
4613:         LOCAL loc_nFl2, loc_nOpe, loc_lPrimeira, loc_nNop, loc_dPbI, loc_dPbF
4614:         LOCAL loc_cMdO, loc_dTDat, loc_nCtO, loc_nCtD, loc_nVlD, loc_nVlO, loc_nVlP, loc_nVlA
4615: 
4616:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4617:         loc_oBO     = THIS.this_oBusinessObject
4618:         loc_cCursor = loc_oBO.this_cCursorDados
4619:         loc_cRes    = ""
4620: 
4621:         *-- Espelha os filtros da tela nas propriedades do BO ANTES de montar
4622:         *-- a consulta, para que o BO reflita exatamente os criterios que
4623:         *-- foram aplicados (consumido por Imprimir/Planilha e pela
4624:         *-- serializacao do filtro nomeado).
4625:         THIS.FormParaBO()
4626: 
4627:         *-- Empresa (EmpCcs tem precedencia sobre Emps - ajuste do legado
4628:         *-- para checar lancamento em outra empresa gravado no EmpCcs)
4629:         loc_cEmp = ""
4630:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4631:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4632:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4633:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4634:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4635:         ENDIF
4636: 
4637:         *-- Emissao
4638:         loc_cDem = ""
4639:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4640:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4641:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4642:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4643:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4644:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4645:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4646:         ENDIF
4647: 
4648:         *-- Vencimento

*-- Linhas 4680 a 4736:
4680:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4681:         ENDIF
4682: 
4683:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4684:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4685:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4686:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4687:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4688:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4689:         ENDIF
4690: 
4691:         *-- Pagamento
4692:         loc_cPag = ""
4693:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4694:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")
4695:             loc_cRes = loc_cRes + " / Pagamento: " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "Sim", "N" + CHR(227) + "o")
4696:         ENDIF
4697: 
4698:         *-- Opcao (NFs preenchida ou nao)
4699:         loc_cOpc = ""
4700:         IF loc_oPag1.opt_4c_Opcao.Value <> 1
4701:             loc_cOpc = " AND " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "LTRIM(RTRIM(a.NFs)) <> ''", "LTRIM(RTRIM(a.NFs)) = ''")
4702:             loc_cRes = loc_cRes + " / Op" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "Sim", "N" + CHR(227) + "o")
4703:         ENDIF
4704: 
4705:         *-- Cancelamento
4706:         loc_cCan = ""
4707:         IF loc_oPag1.opt_4c_Cancs.Value <> 1
4708:             loc_cCan = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "", "NOT ") + "a.TitCancs = 1"
4709:             loc_cRes = loc_cRes + " / Cancelamento: " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "Sim", "N" + CHR(227) + "o")
4710:         ENDIF
4711: 
4712:         *-- Conciliacao - o legado testa optCancs.Value=3 (nao optConcs) no
4713:         *-- IIF interno; preservado literalmente (regra #17).
4714:         loc_cCcl = ""
4715:         IF loc_oPag1.opt_4c_Concs.Value <> 1
4716:             loc_cCcl = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 3, "", "NOT ") + "a.Concs = 1"
4717:             loc_cRes = loc_cRes + " / Concilia" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Concs.Value = 2, "Sim", "N" + CHR(227) + "o")
4718:         ENDIF
4719: 
4720:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4721:             loc_cRes = loc_cRes + " / Prorroga" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Prorrogs.Value = 2, "Sim", "N" + CHR(227) + "o")
4722:         ENDIF
4723: 
4724:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4725:         loc_cTit = ""
4726:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4727:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4728:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4729:         ENDIF
4730: 
4731:         loc_cNfs = ""
4732:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4733:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4734:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4735:         ENDIF
4736: 

*-- Linhas 4825 a 4888:
4825:         SELECT (loc_cCursor)
4826:         GO TOP
4827:         IF EOF()
4828:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4829:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4830:             RETURN .F.
4831:         ENDIF
4832: 
4833:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4834:             REPLACE ALL Valors WITH Valors - ValPags
4835:         ENDIF
4836: 
4837:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4838:         SELECT (loc_oBO.this_cCursorClientes)
4839:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4840:         IF FOUND()
4841:             UPDATE (loc_cCursor) SET ManterDados = 0
4842: 
4843:             SELECT (loc_oBO.this_cCursorClientes)
4844:             SCAN
4845:                 IF CheckE = 1
4846:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4847:                 ENDIF
4848:                 IF CheckP = 1
4849:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4850:                 ENDIF
4851:                 IF CheckC = 1
4852:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4853:                 ENDIF
4854:                 IF CheckA = 1
4855:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4856:                 ENDIF
4857:             ENDSCAN
4858: 
4859:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4860:             SELECT (loc_oBO.this_cCursorClientes)
4861:             SCAN
4862:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4863:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4864:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4865:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4866:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4867:             ENDSCAN
4868: 
4869:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4870:         ENDIF
4871: 
4872:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4873:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4874:         SELECT (loc_oBO.this_cCursorClientes2)
4875:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4876:         IF FOUND()
4877:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4878: 
4879:             SELECT (loc_oBO.this_cCursorClientes2)
4880:             SCAN
4881:                 IF loc_nFl2 = 1
4882:                     IF CheckE = 1
4883:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4884:                     ENDIF
4885:                     IF CheckP = 1
4886:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4887:                     ENDIF
4888:                     IF CheckC = 1

*-- Linhas 4919 a 4940:
4919: 
4920:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4921:         ENDIF
4922: 
4923:         *-- Filtrando os Titulos Prorrogados
4924:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4925:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4926:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4927:             ELSE
4928:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4929:             ENDIF
4930:         ENDIF
4931: 
4932:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4933:         SELECT (loc_cCursor)
4934:         SCAN FOR Pagos = "0"
4935:             loc_nNop = Nopers
4936:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4937:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4938:                        "ORDER BY b.DatarCs DESC"
4939:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4940:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")

*-- Linhas 4977 a 5003:
4977:             SELECT (loc_cCursor)
4978:             SCAN
4979:                 IF ALLTRIM(Moedas) <> loc_cMdO
4980:                     loc_dTDat = TTOD(DtEmis)
4981:                     DO CASE
4982:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4983:                         loc_dTDat = TTOD(Vencs)
4984:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4985:                         loc_dTDat = TTOD(Datas)
4986:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4987:                         loc_dTDat = DATE()
4988:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4989:                         IF !EMPTY(DtBaixa)
4990:                             loc_dTDat = TTOD(DtBaixa)
4991:                         ENDIF
4992:                     ENDCASE
4993:                     IF EMPTY(loc_dTDat)
4994:                         loc_dTDat = TTOD(Datas)
4995:                     ENDIF
4996: 
4997:                     loc_nCtO = fBuscarCotacao(loc_cMdO, loc_dTDat, gnConnHandle)
4998:                     loc_nCtD = fBuscarCotacao(ALLTRIM(Moedas), loc_dTDat, gnConnHandle)
4999:                     loc_nVlD = (Valors   / loc_nCtO) * loc_nCtD
5000:                     loc_nVlO = (ValOcurs / loc_nCtO) * loc_nCtD
5001:                     loc_nVlP = (ValPrev  / loc_nCtO) * loc_nCtD
5002:                     loc_nVlA = (ValPags  / loc_nCtO) * loc_nCtD
5003: 

*-- Linhas 5013 a 5156:
5013:         SELECT (loc_cCursor)
5014:         GO TOP
5015:         IF EOF()
5016:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
5017:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
5018:             RETURN .F.
5019:         ENDIF
5020: 
5021:         SELECT (loc_cCursor)
5022:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
5023:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
5024:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
5025:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
5026:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
5027:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
5028:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
5029:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
5030: 
5031:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
5032:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
5033:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
5034:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
5035:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
5036:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists
5037:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG ContEms
5038:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG Contas
5039: 
5040:         loc_oBO.this_cOrdem = "DtEmis"
5041:         loc_oBO.this_nOrdem = 1
5042:         THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value = 1
5043: 
5044:         THIS.MontarGradeDados()
5045:         THIS.OrdenaGrade()
5046: 
5047:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
5048:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
5049: 
5050:         SELECT (loc_cCursor)
5051:         GO TOP
5052: 
5053:         RETURN .T.
5054:     ENDPROC
5055: 
5056:     *--------------------------------------------------------------------------
5057:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
5058:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
5059:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
5060:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
5061:     *--------------------------------------------------------------------------
5062:     PROCEDURE BtnMovimentoClick()
5063:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
5064: 
5065:         loc_oBO = THIS.this_oBusinessObject
5066: 
5067:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
5068:             RETURN
5069:         ENDIF
5070: 
5071:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5072: 
5073:         *-- SigCdPgr (titulo em carteira de pagamento)
5074:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5075:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5076:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5077:         loc_nQtd = 0
5078:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5079:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5080:             USE IN cursor_4c_ChkPgr
5081:         ENDIF
5082:         IF loc_nQtd > 0
5083:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5084:             RETURN
5085:         ENDIF
5086: 
5087:         *-- SigMvCab (movimento de estoque)
5088:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5089:         loc_nQtd = 0
5090:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5091:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5092:             USE IN cursor_4c_ChkMvCab
5093:         ENDIF
5094:         IF loc_nQtd > 0
5095:             IF WEXIST("FORM_")
5096:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5097:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5098:             ELSE
5099:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5100:             ENDIF
5101:             RETURN
5102:         ENDIF
5103: 
5104:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5105:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5106:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5107:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5108:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5109:                 RETURN
5110:             ENDIF
5111:             IF !EOF("cursor_4c_ChkOpOpe")
5112:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5113:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5114:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5115:                 ELSE
5116:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5117:                 ENDIF
5118:                 IF USED("cursor_4c_ChkOpOpe")
5119:                     USE IN cursor_4c_ChkOpOpe
5120:                 ENDIF
5121:                 RETURN
5122:             ENDIF
5123:             IF USED("cursor_4c_ChkOpOpe")
5124:                 USE IN cursor_4c_ChkOpOpe
5125:             ENDIF
5126:         ENDIF
5127: 
5128:         *-- SigCqChm (cheque)
5129:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5130:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5131:         loc_nQtd = 0
5132:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5133:             loc_nQtd = cursor_4c_ChkChm.Nreg
5134:             USE IN cursor_4c_ChkChm
5135:         ENDIF
5136:         IF loc_nQtd > 0
5137:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5138:             RETURN
5139:         ENDIF
5140: 
5141:         *-- SigPrCtb (contabilizacao)
5142:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5143:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5144:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5145:         loc_nQtd = 0
5146:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5147:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5148:             USE IN cursor_4c_ChkCtb
5149:         ENDIF
5150:         IF loc_nQtd > 0
5151:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5152:             RETURN
5153:         ENDIF
5154: 
5155:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5156:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;

*-- Linhas 5170 a 5396:
5170:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5171:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5172:     *--------------------------------------------------------------------------
5173:     PROCEDURE BtnRecebeClick()
5174:         LOCAL loc_oBO, loc_cSQL
5175: 
5176:         loc_oBO = THIS.this_oBusinessObject
5177: 
5178:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5179:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5180:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5181:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5182:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5183: 
5184:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5185:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5186:             RETURN
5187:         ENDIF
5188: 
5189:         IF !EOF("cursor_4c_ConsPgt")
5190:             IF USED("cursor_4c_ConsPgt")
5191:                 USE IN cursor_4c_ConsPgt
5192:             ENDIF
5193:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5194:             RETURN
5195:         ENDIF
5196:         IF USED("cursor_4c_ConsPgt")
5197:             USE IN cursor_4c_ConsPgt
5198:         ENDIF
5199: 
5200:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5201:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5202:                    "FROM SigTtCcr " + ;
5203:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5204:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5205: 
5206:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5207:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5208:             RETURN
5209:         ENDIF
5210: 
5211:         IF !EOF("cursor_4c_ConsPgt")
5212:             IF USED("cursor_4c_ConsPgt")
5213:                 USE IN cursor_4c_ConsPgt
5214:             ENDIF
5215:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5216:         ELSE
5217:             IF USED("cursor_4c_ConsPgt")
5218:                 USE IN cursor_4c_ConsPgt
5219:             ENDIF
5220:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5221:         ENDIF
5222:     ENDPROC
5223: 
5224:     *--------------------------------------------------------------------------
5225:     * BtnFollowUpCClick/BtnFollowUpLClick - equivalentes aos Click de
5226:     * btnFollowUpC/btnFollowUpL: abrem o follow-up da conta (so o emitente)
5227:     * ou do lancamento (emitente + numero da operacao).
5228:     *--------------------------------------------------------------------------
5229:     PROCEDURE BtnFollowUpCClick()
5230:         LOCAL loc_oBO
5231:         loc_oBO = THIS.this_oBusinessObject
5232: 
5233:         IF !EMPTY(loc_oBO.this_cLinContEms)
5234:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId
5235:         ENDIF
5236:     ENDPROC
5237: 
5238:     PROCEDURE BtnFollowUpLClick()
5239:         LOCAL loc_oBO
5240:         loc_oBO = THIS.this_oBusinessObject
5241: 
5242:         IF !EMPTY(loc_oBO.this_cLinContEms) AND !EMPTY(loc_oBO.this_nLinNopers)
5243:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId, loc_oBO.this_nLinNopers
5244:         ENDIF
5245:     ENDPROC
5246: 
5247:     *--------------------------------------------------------------------------
5248:     * BtnImprimirClick/BtnPlanilhaClick - delegam para Imprimir()/Planilha(),
5249:     * igual ao Click original (ThisForm.Imprimir / ThisForm.Planilha).
5250:     *--------------------------------------------------------------------------
5251:     PROCEDURE BtnImprimirClick()
5252:         THIS.Imprimir()
5253:     ENDPROC
5254: 
5255:     PROCEDURE BtnPlanilhaClick()
5256:         THIS.Planilha()
5257:     ENDPROC
5258: 
5259:     *--------------------------------------------------------------------------
5260:     * Imprimir - transcricao de ThisForm.Imprimir: monta um cursor reduzido
5261:     * (equivalente a crMccr) com os campos do relatorio, indexa pela ordem
5262:     * corrente e dispara REPORT FORM SigReCgf. O FRX legado nao foi portado
5263:     * para o acervo (nao existe em nenhuma pasta do projeto) - o guard de
5264:     * arquivo abaixo documenta essa pendencia em vez de falhar calado.
5265:     *--------------------------------------------------------------------------
5266:     *-- ============================================================
5267:     *-- PROCEDURE ExecutarReportForm (Pattern #117)
5268:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
5269:     *-- exibe MostrarErro descritivo com o path faltante.
5270:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
5271:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
5272:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
5273:     *-- fontes em runtime e mostra asteriscos em campos numericos.
5274:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
5275:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
5276:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
5277:     *-- ============================================================
5278:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
5279:         LOCAL loc_cFRX
5280:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
5281: 
5282:         IF NOT FILE(loc_cFRX)
5283:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
5284:                 loc_cFRX + CHR(13) + CHR(13) + ;
5285:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5286:             RETURN .F.
5287:         ENDIF
5288: 
5289:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
5290:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
5291:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
5292:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
5293:                     "Aten" + CHR(231) + CHR(227) + "o")
5294:                 RETURN .F.
5295:             ENDIF
5296:         ENDIF
5297: 
5298:         *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
5299:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
5300:         loc_cPointOrig    = SET("POINT")
5301:         loc_cSepOrig      = SET("SEPARATOR")
5302:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
5303:         SET POINT TO "."
5304:         SET SEPARATOR TO ","
5305:         SET REPORTBEHAVIOR 80
5306: 
5307:         DO CASE
5308:             CASE par_cModo == "PREVIEW"
5309:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
5310:             CASE par_cModo == "PRINTER_PROMPT"
5311:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
5312:             CASE par_cModo == "PRINTER"
5313:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
5314:         ENDCASE
5315: 
5316:         SET POINT TO (loc_cPointOrig)
5317:         SET SEPARATOR TO (loc_cSepOrig)
5318:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
5319: 
5320:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
5321:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
5322:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
5323:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
5324:         TRY
5325:             SET SYSMENU TO DEFAULT
5326:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
5327:             CriarMenuPrincipal()
5328:         CATCH
5329:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
5330:         ENDTRY
5331: 
5332:         RETURN .T.
5333:     ENDPROC
5334: 
5335:     PROCEDURE Imprimir()
5336:         LOCAL loc_cCursor, loc_cFrx, loc_cTit, loc_cSub, loc_cRes, loc_cFor
5337: 
5338:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5339: 
5340:         IF !USED(loc_cCursor)
5341:             RETURN
5342:         ENDIF
5343: 
5344:         IF USED("cursor_4c_RelFin")
5345:             USE IN cursor_4c_RelFin
5346:         ENDIF
5347:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5348:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5349:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5350:           FROM (loc_cCursor) ;
5351:           INTO CURSOR cursor_4c_RelFin READWRITE
5352: 
5353:         SELECT cursor_4c_RelFin
5354:         GO TOP
5355:         IF EOF()
5356:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5357:             USE IN cursor_4c_RelFin
5358:             RETURN
5359:         ENDIF
5360: 
5361:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5362:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5363:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5364:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5365: 
5366:         IF USED("cursor_4c_RelFinCab")
5367:             USE IN cursor_4c_RelFinCab
5368:         ENDIF
5369:         SET NULL ON
5370:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5371:         SET NULL OFF
5372:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5373:         GO TOP IN cursor_4c_RelFinCab
5374: 
5375:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5376: 
5377:         SELECT cursor_4c_RelFin
5378:         DO CASE
5379:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5380:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5381:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5382:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5383:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5384:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5385:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5386:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5387:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5388:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5389:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5390:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5391:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5392:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5393:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5394:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5395:         ENDCASE
5396: 

*-- Linhas 5415 a 5729:
5415:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5416:     * fLimpaTexto ja portadas em utils/functions.prg).
5417:     *--------------------------------------------------------------------------
5418:     PROCEDURE Planilha()
5419:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5420: 
5421:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5422: 
5423:         IF !USED(loc_cCursor)
5424:             RETURN
5425:         ENDIF
5426: 
5427:         loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")
5428: 
5429:         IF EMPTY(loc_cArq)
5430:             RETURN
5431:         ENDIF
5432: 
5433:         IF fVerificaPasta(loc_cArq, 2)
5434:             loc_cDeb = fLimpaTexto(STRTRAN(PROPER("D" + CHR(233) + "bito"), " ", "_"))
5435:             loc_cCrd = fLimpaTexto(STRTRAN(PROPER("Cr" + CHR(233) + "dito"), " ", "_"))
5436: 
5437:             IF USED("cursor_4c_RelExcel")
5438:                 USE IN cursor_4c_RelExcel
5439:             ENDIF
5440:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5441:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5442:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5443:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5444:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5445:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5446:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5447:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5448:               FROM (loc_cCursor) ;
5449:               INTO CURSOR cursor_4c_RelExcel
5450: 
5451:             SELECT cursor_4c_RelExcel
5452:             GO TOP
5453: 
5454:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5455:                 COPY TO (loc_cArq) TYPE XLS
5456:             ELSE
5457:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5458:             ENDIF
5459: 
5460:             IF FILE(loc_cArq)
5461:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5462:             ENDIF
5463: 
5464:             USE IN cursor_4c_RelExcel
5465:         ELSE
5466:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5467:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5468:         ENDIF
5469: 
5470:         SELECT (loc_cCursor)
5471:         GO TOP
5472:     ENDPROC
5473: 
5474:     *==========================================================================
5475:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5476:     *
5477:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5478:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5479:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5480:     * acionado pelo handler do controle que o SCX legado realmente tem.
5481:     *
5482:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5483:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5484:     *                           cmgFiltros.Buttons(2) "Sair"
5485:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)
5486:     *   CarregarLista        <- repintura da grade de resultado (grdDados1)
5487:     *   LimparCampos         <- bloco de limpeza do AfterRowColChange legado
5488:     *   AjustarBotoesPorModo <- PROCEDURE When de btnMovimento / btnRecebe /
5489:     *                           btnFollowUpC / btnFollowUpL / btnImprimir
5490:     *   HabilitarCampos      <- PROCEDURE When "Return .f." dos campos de
5491:     *                           exibicao da pgDados e "Return Empty(<codigo>)"
5492:     *                           dos campos de descricao dos lookups da pgFiltros
5493:     *   FormParaBO/BOParaForm<- transferencia dos filtros da pgFiltros para as
5494:     *                           propriedades do BO e de volta
5495:     *
5496:     * Esta tela NAO tem botao de gravar: o SCX legado nao declara btnSalvar /
5497:     * btnGravar nem mGravaDados - "Consulta Global Financeira" apura o
5498:     * resultado so no cursor local (LocalDados) e os registros que ela abre
5499:     * pertencem a outras entidades, cada uma com seu proprio BO (ver o
5500:     * cabecalho de SIGOPCGFBO.prg). Por isso nao existe BtnSalvarClick aqui.
5501:     *==========================================================================
5502: 
5503:     *--------------------------------------------------------------------------
5504:     * BtnBuscarClick - Acao principal da tela (cmgFiltros.Buttons(1),
5505:     * "Consultar"): valida as faixas de data, executa a consulta e, so com
5506:     * resultado, passa para a pagina de Dados. AlternarPagina(2) e quem
5507:     * repinta a grade (ver CarregarLista).
5508:     *--------------------------------------------------------------------------
5509:     PROCEDURE BtnBuscarClick()
5510:         LOCAL loc_lResultado
5511:         loc_lResultado = .F.
5512: 
5513:         IF THIS.ValidarFiltrosData()
5514:             IF THIS.Processamento()
5515:                 THIS.AlternarPagina(2)
5516:                 loc_lResultado = .T.
5517:             ENDIF
5518:         ENDIF
5519: 
5520:         RETURN loc_lResultado
5521:     ENDPROC
5522: 
5523:     *--------------------------------------------------------------------------
5524:     * BtnCancelarClick - Funil unico de "abandonar a pagina corrente", com o
5525:     * comportamento que o legado da a cada pagina:
5526:     *   Page2 (Dados)   -> volta para os Filtros   (cmgRetornar.Click)
5527:     *   Page1 (Filtros) -> fecha o form            (cmgFiltros.Buttons(2))
5528:     *--------------------------------------------------------------------------
5529:     PROCEDURE BtnCancelarClick()
5530:         IF THIS.pgf_4c_Paginas.ActivePage = 2
5531:             THIS.AlternarPagina(1)
5532:         ELSE
5533:             THIS.BtnEncerrarClick()
5534:         ENDIF
5535: 
5536:         RETURN .T.
5537:     ENDPROC
5538: 
5539:     *--------------------------------------------------------------------------
5540:     * BtnEncerrarClick - Encerra a tela (ThisForm.Release do Click de
5541:     * cmgFiltros.Buttons(2) "Sair"). FormBase.Destroy() cuida da liberacao do
5542:     * BO e da restauracao dos popups do menu.
5543:     *--------------------------------------------------------------------------
5544:     PROCEDURE BtnEncerrarClick()
5545:         THIS.Release()
5546:     ENDPROC
5547: 
5548:     *--------------------------------------------------------------------------
5549:     * CarregarLista - FUNIL unico de repintura da grade de resultado.
5550:     *
5551:     * Processamento() popula cursor_4c_Dados e chama MontarGradeDados()/
5552:     * OrdenaGrade() com a Page2 ainda OCULTA, e Refresh em pagina oculta NAO
5553:     * pinta (regra #21/#46 do CLAUDE.md) - por isso AlternarPagina(2) chama
5554:     * este metodo DEPOIS de trocar o ActivePage.
5555:     *
5556:     * Tambem sincroniza os campos de detalhe e os botoes de acao com a linha
5557:     * corrente: a PRIMEIRA linha exibida nunca dispara AfterRowColChange, e
5558:     * sem isso ela ficaria com os campos/botoes da consulta anterior.
5559:     *--------------------------------------------------------------------------
5560:     PROCEDURE CarregarLista()
5561:         LOCAL loc_cCursor, loc_lResultado
5562:         loc_lResultado = .F.
5563: 
5564:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5565:             RETURN .F.
5566:         ENDIF
5567: 
5568:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5569: 
5570:         IF !USED(loc_cCursor)
5571:             RETURN .F.
5572:         ENDIF
5573: 
5574:         SELECT (loc_cCursor)
5575:         GO TOP
5576:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5577: 
5578:         IF EOF(loc_cCursor)
5579:             THIS.LimparCampos()
5580:             THIS.AjustarBotoesPorModo()
5581:         ELSE
5582:             THIS.GrdDadosAfterRowColChange(1)
5583:         ENDIF
5584: 
5585:         loc_lResultado = .T.
5586:         RETURN loc_lResultado
5587:     ENDPROC
5588: 
5589:     *--------------------------------------------------------------------------
5590:     * AjustarBotoesPorModo - Reproduz os PROCEDURE When dos botoes de acao da
5591:     * pgDados, que no legado sao reavaliados a cada troca de linha:
5592:     *
5593:     *   btnMovimento / btnRecebe / btnFollowUpC / btnFollowUpL
5594:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0)
5595:     *   btnImprimir
5596:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0) ;
5597:     *              Or InList(ThisForm.Ordem, [ContEms], [Contas])
5598:     *
5599:     * Sem linha corrente (cursor vazio) os When do legado leem um registro
5600:     * que nao existe - aqui isso equivale a desabilitar as acoes.
5601:     *--------------------------------------------------------------------------
5602:     PROCEDURE AjustarBotoesPorModo()
5603:         LOCAL loc_oPag, loc_oBO, loc_cCursor, loc_lHabilita
5604: 
5605:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5606:             RETURN
5607:         ENDIF
5608: 
5609:         loc_oBO     = THIS.this_oBusinessObject
5610:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
5611:         loc_cCursor = loc_oBO.this_cCursorDados
5612: 
5613:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
5614:             loc_lHabilita = .F.
5615:         ELSE
5616:             loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
5617:         ENDIF
5618: 
5619:         loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
5620:         loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
5621:         loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
5622:         loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita
5623: 
5624:         *-- O When do Imprimir tambem libera quando a ordem corrente e por
5625:         *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
5626:         loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
5627:             INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
5628:     ENDPROC
5629: 
5630:     *--------------------------------------------------------------------------
5631:     * LimparCampos - Bloco de limpeza que o legado executa no inicio do
5632:     * AfterRowColChange de grdDados1: zera os campos de detalhe da pgDados e
5633:     * os quatro indicadores de status (Botao1..Botao4).
5634:     *
5635:     * O legado limpa SEMPRE as 4 descricoes (getDContEms/getDContas/
5636:     * getDSContas/getDContAges) e, SO quando a linha e sintetica (llTot), os
5637:     * outros 14 campos; como o ramo "If Not llTot" reatribui TODOS os 18,
5638:     * limpar os 18 de uma vez produz o MESMO resultado nos dois caminhos.
5639:     *--------------------------------------------------------------------------
5640:     PROTECTED PROCEDURE LimparCampos()
5641:         LOCAL loc_oPag
5642: 
5643:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5644:             RETURN
5645:         ENDIF
5646: 
5647:         loc_oPag = THIS.pgf_4c_Paginas.Page2
5648: 
5649:         loc_oPag.txt_4c_DContEms.Value   = ""
5650:         loc_oPag.txt_4c_DContas.Value    = ""
5651:         loc_oPag.txt_4c_DSContas.Value   = ""
5652:         loc_oPag.txt_4c_DContAges.Value  = ""
5653: 
5654:         loc_oPag.txt_4c_NFs.Value        = ""
5655:         loc_oPag.txt_4c_TitBans.Value    = ""
5656:         loc_oPag.txt_4c_EspecieNfs.Value = ""
5657:         loc_oPag.txt_4c_Hist2s.Value     = ""
5658:         loc_oPag.txt_4c_Emps.Value       = ""
5659:         loc_oPag.txt_4c_ValOcurs.Value   = 0
5660:         loc_oPag.txt_4c_GrupEms.Value    = ""
5661:         loc_oPag.txt_4c_ContEms.Value    = ""
5662:         loc_oPag.txt_4c_Grupo.Value      = ""
5663:         loc_oPag.txt_4c_Contas.Value     = ""
5664:         loc_oPag.txt_4c_SGrupos.Value    = ""
5665:         loc_oPag.txt_4c_SContas.Value    = ""
5666:         loc_oPag.txt_4c_GrupAges.Value   = ""
5667:         loc_oPag.txt_4c_ContAges.Value   = ""
5668: 
5669:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = ""
5670:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = ""
5671:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = ""
5672:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = ""
5673:     ENDPROC
5674: 
5675:     *--------------------------------------------------------------------------
5676:     * HabilitarCampos - Aplica, num lugar so, o contrato de digitacao que o
5677:     * legado expressa nos PROCEDURE When de cada campo:
5678:     *
5679:     *   pgDados : TODOS os campos de detalhe declaram "Return .f." no SCX, ou
5680:     *             seja sao SOMENTE EXIBICAO. UNICA excecao fiel: getContEms,
5681:     *             que NAO declara When e por isso continua focavel.
5682:     *   pgFiltros: os campos de DESCRICAO dos lookups declaram
5683:     *             "Return Empty(This.Parent.get<Codigo>.Value)" - a descricao
5684:     *             so aceita digitacao enquanto o CODIGO esta vazio.
5685:     *
5686:     * par_lHabilitar = .T. na pagina de Filtros (filtros digitaveis) e .F. na
5687:     * pagina de Dados (nada a digitar). Chamado pelo funil AlternarPagina().
5688:     *--------------------------------------------------------------------------
5689:     PROCEDURE HabilitarCampos(par_lHabilitar)
5690:         LOCAL loc_oPag1, loc_oPag2, loc_lFiltros
5691: 
5692:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5693:             RETURN
5694:         ENDIF
5695: 
5696:         loc_lFiltros = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
5697:         loc_oPag1    = THIS.pgf_4c_Paginas.Page1
5698:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
5699: 
5700:         *-- pgFiltros: campos de filtro digitaveis
5701:         loc_oPag1.txt_4c_DtEmiI.ReadOnly     = !loc_lFiltros
5702:         loc_oPag1.txt_4c_DtEmiF.ReadOnly     = !loc_lFiltros
5703:         loc_oPag1.txt_4c_VencsI.ReadOnly     = !loc_lFiltros
5704:         loc_oPag1.txt_4c_VencsF.ReadOnly     = !loc_lFiltros
5705:         loc_oPag1.txt_4c_DatasI.ReadOnly     = !loc_lFiltros
5706:         loc_oPag1.txt_4c_DatasF.ReadOnly     = !loc_lFiltros
5707:         loc_oPag1.txt_4c_DtBxI.ReadOnly      = !loc_lFiltros
5708:         loc_oPag1.txt_4c_DtBxF.ReadOnly      = !loc_lFiltros
5709:         loc_oPag1.txt_4c_Titulos.ReadOnly    = !loc_lFiltros
5710:         loc_oPag1.txt_4c_TitBans.ReadOnly    = !loc_lFiltros
5711:         loc_oPag1.txt_4c_EspecieNfs.ReadOnly = !loc_lFiltros
5712:         loc_oPag1.txt_4c_NFs.ReadOnly        = !loc_lFiltros
5713:         loc_oPag1.txt_4c_CMoes.ReadOnly      = !loc_lFiltros
5714:         loc_oPag1.txt_4c_CMoesC.ReadOnly     = !loc_lFiltros
5715:         loc_oPag1.txt_4c_MoeSaldo.ReadOnly   = !loc_lFiltros
5716:         loc_oPag1.txt_4c_Saldo.ReadOnly      = !loc_lFiltros
5717:         loc_oPag1.txt_4c_CFPublis.ReadOnly   = !loc_lFiltros
5718:         loc_oPag1.txt_4c_Empresa.ReadOnly    = !loc_lFiltros
5719:         loc_oPag1.txt_4c_Filtros.ReadOnly    = !loc_lFiltros
5720:         loc_oPag1.txt_4c_NewFiltro.ReadOnly  = !loc_lFiltros
5721: 
5722:         *-- pgFiltros: When "Return Empty(<codigo>)" dos campos de descricao
5723:         loc_oPag1.txt_4c_DMoes.ReadOnly    = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
5724:         loc_oPag1.txt_4c_DMoesC.ReadOnly   = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
5725:         loc_oPag1.txt_4c_DFPublis.ReadOnly = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CFPublis.Value)
5726: 
5727:         *-- pgDados: "Return .f." em todo campo de detalhe (somente exibicao).
5728:         *-- txt_4c_ContEms fica FORA desta lista de proposito - getContEms e o
5729:         *-- unico campo da pgDados que nao declara When no SCX legado.

*-- Linhas 5743 a 5909:
5743:         loc_oPag2.txt_4c_DContAges.ReadOnly  = .T.
5744:         loc_oPag2.txt_4c_Hist2s.ReadOnly     = .T.
5745:         loc_oPag2.txt_4c_TitBans.ReadOnly    = .T.
5746:         loc_oPag2.txt_4c_ValOcurs.ReadOnly   = .T.
5747: 
5748:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao1.ReadOnly = .T.
5749:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao2.ReadOnly = .T.
5750:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao3.ReadOnly = .T.
5751:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao4.ReadOnly = .T.
5752:     ENDPROC
5753: 
5754:     *--------------------------------------------------------------------------
5755:     * FormParaBO - Espelha TODOS os filtros da tela nas propriedades do
5756:     * Business Object. E a fonte unica de leitura dos controles de filtro:
5757:     * chamado por Processamento() (antes de montar a consulta), por
5758:     * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
5759:     * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
5760:     *
5761:     * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
5762:     * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
5763:     * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
5764:     * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
5765:     *--------------------------------------------------------------------------
5766:     PROTECTED PROCEDURE FormParaBO()
5767:         LOCAL loc_oPag1, loc_oPag2, loc_oBO, loc_xSaldo
5768: 
5769:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5770:             RETURN .F.
5771:         ENDIF
5772: 
5773:         loc_oBO   = THIS.this_oBusinessObject
5774:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5775:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5776: 
5777:         *-- Faixas de data (ConverterParaData normaliza DATE/DATETIME/CHAR)
5778:         loc_oBO.this_dDtEmiI = ConverterParaData(loc_oPag1.txt_4c_DtEmiI.Value)
5779:         loc_oBO.this_dDtEmiF = ConverterParaData(loc_oPag1.txt_4c_DtEmiF.Value)
5780:         loc_oBO.this_dVencsI = ConverterParaData(loc_oPag1.txt_4c_VencsI.Value)
5781:         loc_oBO.this_dVencsF = ConverterParaData(loc_oPag1.txt_4c_VencsF.Value)
5782:         loc_oBO.this_dDatasI = ConverterParaData(loc_oPag1.txt_4c_DatasI.Value)
5783:         loc_oBO.this_dDatasF = ConverterParaData(loc_oPag1.txt_4c_DatasF.Value)
5784:         loc_oBO.this_dDtBxI  = ConverterParaData(loc_oPag1.txt_4c_DtBxI.Value)
5785:         loc_oBO.this_dDtBxF  = ConverterParaData(loc_oPag1.txt_4c_DtBxF.Value)
5786: 
5787:         *-- Titulo / Titulo Banco / Especie / Nota Fiscal
5788:         loc_oBO.this_cTitulos    = ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
5789:         loc_oBO.this_cTitBans    = ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
5790:         loc_oBO.this_cEspecieNfs = ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
5791:         loc_oBO.this_cNFs        = ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
5792: 
5793:         *-- Moeda de filtro / de conversao / do saldo inicial
5794:         loc_oBO.this_cCMoes    = ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
5795:         loc_oBO.this_cDMoes    = ALLTRIM(loc_oPag1.txt_4c_DMoes.Value)
5796:         loc_oBO.this_cCMoesC   = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
5797:         loc_oBO.this_cDMoesC   = ALLTRIM(loc_oPag1.txt_4c_DMoesC.Value)
5798:         loc_oBO.this_cMoeSaldo = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
5799: 
5800:         loc_xSaldo          = loc_oPag1.txt_4c_Saldo.Value
5801:         loc_oBO.this_nSaldo = IIF(VARTYPE(loc_xSaldo) = "N", loc_xSaldo, VAL(TRANSFORM(loc_xSaldo)))
5802: 
5803:         *-- Forma de Publicidade / Empresa
5804:         loc_oBO.this_cCFPublis = ALLTRIM(loc_oPag1.txt_4c_CFPublis.Value)
5805:         loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
5806:         loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
5807: 
5808:         *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
5809:         loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
5810:         loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
5811:         loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)
5812: 
5813:         *-- OptionGroup.Value e o INDICE 1-based do botao selecionado
5814:         loc_oBO.this_nPagos    = loc_oPag1.opt_4c_Pagos.Value
5815:         loc_oBO.this_nOpcao    = loc_oPag1.opt_4c_Opcao.Value
5816:         loc_oBO.this_nCotEm    = loc_oPag1.opt_4c_CotEm.Value
5817:         loc_oBO.this_nCancs    = loc_oPag1.opt_4c_Cancs.Value
5818:         loc_oBO.this_nConcs    = loc_oPag1.opt_4c_Concs.Value
5819:         loc_oBO.this_nProrrogs = loc_oPag1.opt_4c_Prorrogs.Value
5820:         loc_oBO.this_nFilGrd2  = loc_oPag1.opt_4c_FilGrd2.Value
5821: 
5822:         *-- Filtro nomeado (SigSyPar) e ordem corrente da grade.
5823:         *-- this_cOrdem NAO e escrito aqui: a fonte unica dele e
5824:         *-- CboOrdemInteractiveChange(), que traduz o indice do combo no nome
5825:         *-- da coluna usada pelo SET ORDER TO TAG.
5826:         loc_oBO.this_cFiltros   = ALLTRIM(loc_oPag1.txt_4c_Filtros.Value)
5827:         loc_oBO.this_cNewFiltro = ALLTRIM(loc_oPag1.txt_4c_NewFiltro.Value)
5828:         loc_oBO.this_nOrdem     = loc_oPag2.cbo_4c_Ordem.Value
5829: 
5830:         RETURN .T.
5831:     ENDPROC
5832: 
5833:     *--------------------------------------------------------------------------
5834:     * BOParaForm - Caminho inverso de FormParaBO: repoe na tela os filtros
5835:     * guardados nas propriedades do BO. Usado por RestaurarFiltros() ao
5836:     * carregar um filtro nomeado de SigSyPar.
5837:     *
5838:     * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
5839:     * para nunca atribuir 0 a um controle de indice (regra dos controles
5840:     * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
5841:     *--------------------------------------------------------------------------
5842:     PROTECTED PROCEDURE BOParaForm()
5843:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
5844: 
5845:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5846:             RETURN .F.
5847:         ENDIF
5848: 
5849:         loc_oBO   = THIS.this_oBusinessObject
5850:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5851:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5852: 
5853:         loc_oPag1.txt_4c_DtEmiI.Value = ConverterParaData(loc_oBO.this_dDtEmiI)
5854:         loc_oPag1.txt_4c_DtEmiF.Value = ConverterParaData(loc_oBO.this_dDtEmiF)
5855:         loc_oPag1.txt_4c_VencsI.Value = ConverterParaData(loc_oBO.this_dVencsI)
5856:         loc_oPag1.txt_4c_VencsF.Value = ConverterParaData(loc_oBO.this_dVencsF)
5857:         loc_oPag1.txt_4c_DatasI.Value = ConverterParaData(loc_oBO.this_dDatasI)
5858:         loc_oPag1.txt_4c_DatasF.Value = ConverterParaData(loc_oBO.this_dDatasF)
5859:         loc_oPag1.txt_4c_DtBxI.Value  = ConverterParaData(loc_oBO.this_dDtBxI)
5860:         loc_oPag1.txt_4c_DtBxF.Value  = ConverterParaData(loc_oBO.this_dDtBxF)
5861: 
5862:         loc_oPag1.txt_4c_Titulos.Value    = loc_oBO.this_cTitulos
5863:         loc_oPag1.txt_4c_TitBans.Value    = loc_oBO.this_cTitBans
5864:         loc_oPag1.txt_4c_EspecieNfs.Value = loc_oBO.this_cEspecieNfs
5865:         loc_oPag1.txt_4c_NFs.Value        = loc_oBO.this_cNFs
5866: 
5867:         loc_oPag1.txt_4c_CMoes.Value    = loc_oBO.this_cCMoes
5868:         loc_oPag1.txt_4c_DMoes.Value    = loc_oBO.this_cDMoes
5869:         loc_oPag1.txt_4c_CMoesC.Value   = loc_oBO.this_cCMoesC
5870:         loc_oPag1.txt_4c_DMoesC.Value   = loc_oBO.this_cDMoesC
5871:         loc_oPag1.txt_4c_MoeSaldo.Value = loc_oBO.this_cMoeSaldo
5872:         loc_oPag1.txt_4c_Saldo.Value    = loc_oBO.this_nSaldo
5873: 
5874:         loc_oPag1.txt_4c_CFPublis.Value = loc_oBO.this_cCFPublis
5875:         loc_oPag1.txt_4c_DFPublis.Value = loc_oBO.this_cDFPublis
5876:         loc_oPag1.txt_4c_Empresa.Value  = loc_oBO.this_cEmpresa
5877: 
5878:         loc_oPag1.chk_4c_Brancos.Value  = IIF(loc_oBO.this_lBrancos, 1, 0)
5879:         loc_oPag1.chk_4c_ValPends.Value = IIF(loc_oBO.this_lValPends, 1, 0)
5880:         loc_oPag2.chk_4c_Totais.Value   = IIF(loc_oBO.this_lTotais, 1, 0)
5881: 
5882:         loc_oPag1.opt_4c_Pagos.Value    = IIF(BETWEEN(loc_oBO.this_nPagos, 1, 3), loc_oBO.this_nPagos, 1)
5883:         loc_oPag1.opt_4c_Opcao.Value    = IIF(BETWEEN(loc_oBO.this_nOpcao, 1, 3), loc_oBO.this_nOpcao, 1)
5884:         loc_oPag1.opt_4c_CotEm.Value    = IIF(BETWEEN(loc_oBO.this_nCotEm, 1, 5), loc_oBO.this_nCotEm, 1)
5885:         loc_oPag1.opt_4c_Cancs.Value    = IIF(BETWEEN(loc_oBO.this_nCancs, 1, 3), loc_oBO.this_nCancs, 1)
5886:         loc_oPag1.opt_4c_Concs.Value    = IIF(BETWEEN(loc_oBO.this_nConcs, 1, 3), loc_oBO.this_nConcs, 1)
5887:         loc_oPag1.opt_4c_Prorrogs.Value = IIF(BETWEEN(loc_oBO.this_nProrrogs, 1, 3), loc_oBO.this_nProrrogs, 1)
5888:         loc_oPag1.opt_4c_FilGrd2.Value  = IIF(BETWEEN(loc_oBO.this_nFilGrd2, 1, 2), loc_oBO.this_nFilGrd2, 1)
5889: 
5890:         loc_oPag1.txt_4c_Filtros.Value   = loc_oBO.this_cFiltros
5891:         loc_oPag1.txt_4c_NewFiltro.Value = loc_oBO.this_cNewFiltro
5892:         loc_oPag2.cbo_4c_Ordem.Value     = IIF(BETWEEN(loc_oBO.this_nOrdem, 1, 8), loc_oBO.this_nOrdem, 1)
5893: 
5894:         *-- O When "Return Empty(<codigo>)" dos campos de descricao depende do
5895:         *-- codigo que acabou de ser reposto - reavaliar o contrato.
5896:         THIS.HabilitarCampos(THIS.pgf_4c_Paginas.ActivePage = 1)
5897: 
5898:         RETURN .T.
5899:     ENDPROC
5900: 
5901:     *--------------------------------------------------------------------------
5902:     * Destroy - FormBase.Destroy() cuida da liberacao do BusinessObject e da
5903:     * restauracao dos popups do menu (Erro58). DODEFAULT() SEMPRE por ultimo.
5904:     *--------------------------------------------------------------------------
5905:     PROCEDURE Destroy()
5906:         DODEFAULT()
5907:     ENDPROC
5908: 
5909: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPCGFBO.prg):
*============================================================================
* SIGOPCGFBO.prg - Business Object para Consulta Global Financeira
*
* Form OPERACIONAL (sem tabela/PK unica) - consulta sobre titulos financeiros
* (SigCdPit) movimentados contra contas (SigCdCli), com filtros amplos de
* data, titulo, moeda, publicidade, empresa e grupos de contas selecionaveis
* em duas grades auxiliares (equivalentes a TmpCliente/TmpCliente2 do legado).
*
* Legado  : SIGOPCGF.SCX (form generico "form", NAO frmcadastro)
* Cursores de trabalho (equivalentes ao LocalDados/LocalTotais/crSigOpOpe/
* TmpCliente/TmpCliente2/TmpContas/crFiltros do legado):
*   cursor_4c_Dados     - resultado da consulta (um registro por titulo)
*   cursor_4c_Totais    - estrutura vazia usada para acumular totalizadores
*   cursor_4c_Tipos     - tipos de operacao de titulo (SigOpOpe) com flag de
*                         selecao (Imps) para o filtro por tipo de movimento
*   cursor_4c_Clientes  - grade 1 de contas/grupos selecionaveis no filtro
*   cursor_4c_Clientes2 - grade 2 de contas/grupos selecionaveis no filtro
*   cursor_4c_Contas    - cache de contas (IClis/RClis) usado pelas grades
*   cursor_4c_Filtros   - filtros nomeados salvos (SigSyPar)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGOPCGFBO AS BusinessBase

    *==========================================================================
    * Nomes dos cursores de trabalho (constantes de instancia - usados pelos
    * metodos de carga/consulta criados nas proximas fases)
    *==========================================================================
    this_cCursorDados     = "cursor_4c_Dados"
    this_cCursorTotais    = "cursor_4c_Totais"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorClientes2 = "cursor_4c_Clientes2"
    this_cCursorContas    = "cursor_4c_Contas"
    this_cCursorFiltros   = "cursor_4c_Filtros"

    *==========================================================================
    * Filtros de data (getDtEmiI/F, getVencsI/F, getDatasI/F, getDtBxI/F)
    *==========================================================================
    this_dDtEmiI = {}    && Emissao - de
    this_dDtEmiF = {}    && Emissao - ate
    this_dVencsI = {}    && Vencimento - de
    this_dVencsF = {}    && Vencimento - ate
    this_dDatasI = {}    && Lancamento - de
    this_dDatasF = {}    && Lancamento - ate
    this_dDtBxI  = {}    && Baixa - de
    this_dDtBxF  = {}    && Baixa - ate

    *==========================================================================
    * Filtros de texto/codigo (getTitulos, getTitBans, getEspecieNfs, getNFs)
    *==========================================================================
    this_cTitulos    = ""    && Titulo (SigCdPit.Titulos)
    this_cTitBans    = ""    && Titulo Banco (SigCdPgr.FPags, busca local fwBuscaSel)
    this_cEspecieNfs = ""    && Especie da NF - codigo (SigCdEsp.Especies)
    this_cNFs        = ""    && Numero da Nota Fiscal

    *==========================================================================
    * Moeda (getCMoes/getDMoes, getCMoesC/getDMoesC, getMoeSaldo)
    *==========================================================================
    this_cCMoes    = ""    && Moeda Filtro - codigo (SigCdMoe.CMoes)
    this_cDMoes    = ""    && Moeda Filtro - descricao (SigCdMoe.DMoes)
    this_cCMoesC   = ""    && Moeda Conversao - codigo (SigCdMoe.CMoes)
    this_cDMoesC   = ""    && Moeda Conversao - descricao (SigCdMoe.DMoes)
    this_cMoeSaldo = ""    && Moeda do Saldo Inicial - codigo (SigCdMoe.CMoes)
    this_nSaldo    = 0     && Saldo Inicial (valor digitado pelo usuario)

    *==========================================================================
    * Publicidade (getCFPublis/getDFPublis)
    *==========================================================================
    this_cCFPublis = ""    && Forma de Publicidade - codigo (SigCdFpb.Cods)
    this_cDFPublis = ""    && Forma de Publicidade - descricao (SigCdFpb.Descs)

    *==========================================================================
    * Empresa (Get_Empresa)
    *==========================================================================
    this_cEmpresa = ""    && Empresa - codigo (SigCdEmp.Cemps)

    *==========================================================================
    * Flags de filtro (chkBrancos, chkValpags, chkTotais)
    *==========================================================================
    this_lBrancos  = .F.    && Branco (chkBrancos) - filtra lancamentos em branco
    this_lValPends = .F.    && Valor Pendente (chkValpags)
    this_lTotais   = .T.    && Exibir Totalizadores (chkTotais)

    *==========================================================================
    * OptionGroups de filtro - indice 1-based, espelha o Value do grupo
    * (optPagos, optOpcao, optCotEm, optCancs, optConcs, optProrrogs,
    * optFilGrd2)
    *==========================================================================
    this_nPagos    = 1    && Pagamento (3 opcoes)
    this_nOpcao    = 1    && Opcao (3 opcoes)
    this_nCotEm    = 1    && Conversao em (5 opcoes)
    this_nCancs    = 1    && Cancelamento (3 opcoes)
    this_nConcs    = 1    && Conciliacao (3 opcoes)
    this_nProrrogs = 1    && Prorrogacao (3 opcoes)
    this_nFilGrd2  = 1    && Filtro da grade 2 (2 opcoes)

    *==========================================================================
    * Ordenacao da grade de resultado (cmbOrdem.Value + ThisForm.Ordem legado)
    *==========================================================================
    this_nOrdem = 1          && Indice selecionado no combo de ordem
    this_cOrdem = "DtEmis"   && Nome da coluna correspondente, usado no SET ORDER

    *==========================================================================
    * Filtro nomeado (getFiltros/getNewFiltro - SigSyPar)
    *==========================================================================
    this_cFiltros   = ""    && Nome do filtro selecionado/carregado
    this_cNewFiltro = ""    && Nome digitado ao cadastrar um novo filtro

    *==========================================================================
    * Totalizadores calculados sobre cursor_4c_Dados (CalcSaldo/CalcSaldoCta)
    *==========================================================================
    this_nSaldoDia = 0
    this_nSaldoTot = 0
    this_nDebitos  = 0
    this_nCreditos = 0

    *==========================================================================
    * Linha corrente de cursor_4c_Dados (equivalente ao registro corrente de
    * LocalDados no legado) - carregada por CarregarDoCursor() quando o
    * usuario seleciona uma linha na grade, e consumida pelos botoes de
    * acao (Movimento/Recebimento/FollowUp/Imprimir) das proximas fases.
    *==========================================================================
    this_nLinNopers     = 0     && Numero da operacao (chave de navegacao)
    this_cLinTipos      = ""    && Tipo do lancamento
    this_nLinSaldoDia   = 0     && Saldo do dia (linha)
    this_nLinSaldoTot   = 0     && Saldo total/progressivo (linha)
    this_nLinDebitos    = 0     && Debito (linha)
    this_nLinCreditos   = 0     && Credito (linha)
    this_cLinContaCobs  = ""    && Conta cobradora
    this_cLinGrupos     = ""    && Grupo da conta
    this_cLinContas     = ""    && Codigo da conta/portador
    this_cLinContEms    = ""    && Codigo do emitente/cliente
    this_cLinOrdHs      = ""    && Ordem do historico
    this_cLinHists      = ""    && Historico
    this_cLinHist2s     = ""    && Historico complementar
    this_cLinNFs        = ""    && Nota Fiscal
    this_dLinDatas      = {}    && Data de lancamento
    this_dLinVencs      = {}    && Data de vencimento
    this_dLinDtEmis     = {}    && Data de emissao
    this_dLinDtBaixa    = {}    && Data de baixa
    this_cLinTitulos    = ""    && Numero do titulo
    this_cLinMoedas     = ""    && Codigo da moeda
    this_nLinSInis      = 0     && Flag "e totalizador/sintetico" (SInis)
    this_cLinRClis      = ""    && Razao social do cliente/emitente
    this_cLinEmps       = ""    && Empresa (chave de movimento)
    this_cLinDopes      = ""    && Documento de origem (chave de movimento)
    this_nLinNumes      = 0     && Numero do movimento (chave de movimento)
    this_cLinVOpers     = ""    && Movimento vinculado (ContEms+Numos)
    this_nLinAcertos    = 0     && Flag de acerto (usado no Recebimento)
    this_cLinGrupEms    = ""    && Grupo do emitente
    this_cLinSGrupos    = ""    && Grupo do centro de custo
    this_cLinSContas    = ""    && Codigo do centro de custo
    this_cLinGrupAges   = ""    && Grupo do agente cobrador
    this_cLinContAges   = ""    && Codigo do agente cobrador
    this_cLinTitBans    = ""    && Titulo no banco (SigCdPgr.FPags)
    this_cLinEspecieNfs = ""    && Especie da Nota Fiscal
    this_nLinValOcurs   = 0     && Valor ocorrido
    this_nLinTitCancs   = 0     && Flag "titulo cancelado" (Botao1)
    this_cLinPagos      = ""    && Flag/codigo de pagamento - "0"=pendente (Botao2)
    this_lLinConcs      = .F.   && Flag "titulo conciliado" (Botao3)
    this_dLinProrrogs   = {}    && Data de prorrogacao, vazia = nao prorrogado (Botao4)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form de consulta sem tabela/PK unica (nao eh CRUD) - this_cTabela e
    * this_cCampoChave ficam vazios de proposito; a consulta principal eh
    * montada dinamicamente (varias tabelas) nos metodos das proximas fases.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE de cursor_4c_Dados (grade
    * de resultado da consulta) para as propriedades this_nLin*/this_cLin*/
    * this_dLin*, equivalente a ler LocalDados.<campo> diretamente no legado
    * (AfterRowColChange/Click dos botoes de acao). Chamado pelo Form sempre
    * que a linha selecionada na grade mudar.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        THIS.this_nLinNopers    = TratarNulo(Nopers, 0)
        THIS.this_cLinTipos     = TratarNulo(Tipos, "")
        THIS.this_nLinSaldoDia  = TratarNulo(SaldoDia, 0)
        THIS.this_nLinSaldoTot  = TratarNulo(SaldoTot, 0)
        THIS.this_nLinDebitos   = TratarNulo(Debitos, 0)
        THIS.this_nLinCreditos  = TratarNulo(Creditos, 0)
        THIS.this_cLinContaCobs = TratarNulo(ContaCobs, "")
        THIS.this_cLinGrupos    = TratarNulo(Grupos, "")
        THIS.this_cLinContas    = TratarNulo(Contas, "")
        THIS.this_cLinContEms   = TratarNulo(ContEms, "")
        THIS.this_cLinOrdHs     = TratarNulo(OrdHs, "")
        THIS.this_cLinHists     = TratarNulo(Hists, "")
        THIS.this_cLinHist2s    = TratarNulo(Hist2s, "")
        THIS.this_cLinNFs       = TratarNulo(NFs, "")
        THIS.this_dLinDatas     = TratarNulo(Datas, {})
        THIS.this_dLinVencs     = TratarNulo(Vencs, {})
        THIS.this_dLinDtEmis    = TratarNulo(DtEmis, {})
        THIS.this_dLinDtBaixa   = TratarNulo(DtBaixa, {})
        THIS.this_cLinTitulos   = TratarNulo(Titulos, "")
        THIS.this_cLinMoedas    = TratarNulo(Moedas, "")
        THIS.this_nLinSInis     = TratarNulo(SInis, 0)
        THIS.this_cLinRClis     = TratarNulo(RClis, "")

        IF TYPE("Emps") = "C"
            THIS.this_cLinEmps = TratarNulo(Emps, "")
        ENDIF
        IF TYPE("Dopes") = "C"
            THIS.this_cLinDopes = TratarNulo(Dopes, "")
        ENDIF
        IF TYPE("Numes") = "N"
            THIS.this_nLinNumes = TratarNulo(Numes, 0)
        ENDIF
        IF TYPE("VOpers") = "C"
            THIS.this_cLinVOpers = TratarNulo(VOpers, "")
        ENDIF
        IF TYPE("Acertos") = "N"
            THIS.this_nLinAcertos = TratarNulo(Acertos, 0)
        ENDIF
        IF TYPE("GrupEms") = "C"
            THIS.this_cLinGrupEms = TratarNulo(GrupEms, "")
        ENDIF
        IF TYPE("SGrupos") = "C"
            THIS.this_cLinSGrupos = TratarNulo(SGrupos, "")
        ENDIF
        IF TYPE("SContas") = "C"
            THIS.this_cLinSContas = TratarNulo(SContas, "")
        ENDIF
        IF TYPE("GrupAges") = "C"
            THIS.this_cLinGrupAges = TratarNulo(GrupAges, "")
        ENDIF
        IF TYPE("ContAges") = "C"
            THIS.this_cLinContAges = TratarNulo(ContAges, "")
        ENDIF
        IF TYPE("TitBans") = "C"
            THIS.this_cLinTitBans = TratarNulo(TitBans, "")
        ENDIF
        IF TYPE("EspecieNfs") = "C"
            THIS.this_cLinEspecieNfs = TratarNulo(EspecieNfs, "")
        ENDIF
        IF TYPE("ValOcurs") = "N"
            THIS.this_nLinValOcurs = TratarNulo(ValOcurs, 0)
        ENDIF
        IF TYPE("TitCancs") = "N"
            THIS.this_nLinTitCancs = TratarNulo(TitCancs, 0)
        ENDIF
        IF TYPE("Pagos") = "C"
            THIS.this_cLinPagos = TratarNulo(Pagos, "")
        ENDIF
        IF TYPE("Concs") = "L"
            THIS.this_lLinConcs = TratarNulo(Concs, .F.)
        ENDIF
        IF TYPE("Prorrogs") = "D" OR TYPE("Prorrogs") = "T"
            THIS.this_dLinProrrogs = TratarNulo(Prorrogs, {})
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCGF e um form OPERACIONAL de consulta ("Consulta Global
    * Financeira"): o legado apura o resultado so no cursor local LocalDados
    * (via SqlExecute + filtros), nunca grava numa tabela propria do SQL
    * Server - os dados persistidos que ele le/altera pertencem a outras
    * entidades (SigCdPit/SigMvCab/SigCdPgr/SigSyPar, etc), cada uma com seu
    * proprio BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios;
    * o comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o numero
    * da operacao (Nopers) da linha corrente como chave de referencia.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nLinNopers)
    ENDPROC

ENDDEFINE


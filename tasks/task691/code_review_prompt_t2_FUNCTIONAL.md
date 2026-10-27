# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (53)
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
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_RelFinCab' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5888 linhas total):

*-- Linhas 57 a 313:
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
187:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
188:                     loc_oControl.Visible = .T.
189:                 ENDIF
190: 
191:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
192:                     FOR loc_nP = 1 TO loc_oControl.PageCount
193:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
194:                     ENDFOR
195:                 ENDIF
196: 
197:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
198:                     THIS.TornarControlesVisiveis(loc_oControl)
199:                 ENDIF
200:             ENDIF
201:         ENDFOR
202:     ENDPROC
203: 
204:     *==========================================================================
205:     * FASE 4 - Page1 (pgFiltros): cursores de trabalho, grid completo
206:     * (grdTipo + Grd_Clientes + Grd_Clientes2) e botoes CRUD de linha/filtro.
207:     * Nomes e geometria transcritos de tasks\task691\SIGOPCGF_form_codigo_
208:     * fonte.txt (SECAO 2: PROPRIEDADES CUSTOMIZADAS). AlternarPagina() navega
209:     * entre Filtros/Dados; a consulta financeira completa (LocalDados) e o
210:     * grid/botoes da Page2 ficam para a fase seguinte.
211:     *==========================================================================
212: 
213:     *--------------------------------------------------------------------------
214:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
215:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
216:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
217:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
218:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
219:     *--------------------------------------------------------------------------
220:     PROTECTED PROCEDURE CriarCursoresFiltros()
221:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
222: 
223:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
224:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
225:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
226:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
227: 
228:         IF !USED(loc_cTipos)
229:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
230:             INDEX ON Dopes TAG Dopes
231:         ENDIF
232: 
233:         IF !USED(loc_cClientes)
234:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
235:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
236:             SELECT (loc_cClientes)
237:             APPEND BLANK
238:         ENDIF
239: 
240:         IF !USED(loc_cClientes2)
241:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
242:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
243:             SELECT (loc_cClientes2)
244:             APPEND BLANK
245:         ENDIF
246: 
247:         IF !USED(loc_cFiltros)
248:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
249:         ENDIF
250:     ENDPROC
251: 
252:     *--------------------------------------------------------------------------
253:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
254:     * campos de filtro, OptionGroups, grades e botoes).
255:     *--------------------------------------------------------------------------
256:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
257:         LOCAL loc_oPag
258:         loc_oPag = THIS.pgf_4c_Paginas.Page1
259: 
260:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
261:         THIS.ConfigurarCamposFiltros(loc_oPag)
262:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
263:         THIS.ConfigurarGradesFiltros(loc_oPag)
264:         THIS.ConfigurarBotoesFiltros(loc_oPag)
265:     ENDPROC
266: 
267:     *--------------------------------------------------------------------------
268:     * ConfigurarCabecalhoFiltros - Faixa de titulo (cntSombra) + CommandGroup
269:     * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
270:     * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
271:     * cadastro_sair_60.jpg.
272:     *--------------------------------------------------------------------------
273:     PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
274:         par_oPag.AddObject("cnt_4c_Sombra", "Container")
275:         WITH par_oPag.cnt_4c_Sombra
276:             .Top         = 0
277:             .Left        = 0
278:             .Width       = THIS.Width
279:             .Height      = 80
280:             .BackColor   = RGB(100, 100, 100)
281:             .BorderWidth = 0
282: 
283:             .AddObject("lbl_4c_Sombra", "Label")
284:             WITH .lbl_4c_Sombra
285:                 .Top       = 25
286:                 .Left      = 10
287:                 .Width     = THIS.Width
288:                 .Height    = 40
289:                 .AutoSize  = .F.
290:                 .BackStyle = 0
291:                 .WordWrap  = .T.
292:                 .FontName  = "Tahoma"
293:                 .FontSize  = 18
294:                 .FontBold  = .T.
295:                 .ForeColor = RGB(0, 0, 0)
296:                 .Caption   = THIS.Caption
297:                 .Visible   = .T.
298:             ENDWITH
299: 
300:             .AddObject("lbl_4c_TituloCabecalho", "Label")
301:             WITH .lbl_4c_TituloCabecalho
302:                 .Top       = 24
303:                 .Left      = 10
304:                 .Width     = THIS.Width
305:                 .Height    = 46
306:                 .AutoSize  = .F.
307:                 .BackStyle = 0
308:                 .WordWrap  = .T.
309:                 .FontName  = "Tahoma"
310:                 .FontSize  = 18
311:                 .FontBold  = .T.
312:                 .ForeColor = RGB(255, 255, 255)
313:                 .Caption   = THIS.Caption

*-- Linhas 368 a 420:
368:             .Visible = .T.
369:         ENDWITH
370: 
371:         BINDEVENT(par_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
376:     * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
377:     * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
378:     * dump do SCX legado.
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
381:         LOCAL loc_cAte
382:         loc_cAte = "at" + CHR(233)
383: 
384:         *-- Emissao
385:         par_oPag.AddObject("lbl_4c_SayPed", "Label")
386:         WITH par_oPag.lbl_4c_SayPed
387:             .Top = 132
388:             .Left = 139
389:             .Width = 47
390:             .FontName = "Tahoma"
391:             .FontSize = 8
392:             .ForeColor = RGB(90, 90, 90)
393:             .Caption = "Emiss" + CHR(227) + "o :"
394:             .Visible = .T.
395:         ENDWITH
396: 
397:         par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
398:         WITH par_oPag.txt_4c_DtEmiI
399:             .Top = 128
400:             .Left = 190
401:             .Width = 80
402:             .Height = 23
403:             .Alignment = 3
404:             .Value = {}
405:             .FontName = "Tahoma"
406:             .SpecialEffect = 1
407:             .Visible = .T.
408:         ENDWITH
409: 
410:         par_oPag.AddObject("lbl_4c_Label2", "Label")
411:         WITH par_oPag.lbl_4c_Label2
412:             .Top = 132
413:             .Left = 275
414:             .Width = 18
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:             .BackStyle = 0
418:             .ForeColor = RGB(90, 90, 90)
419:             .Caption = loc_cAte
420:             .Visible = .T.

*-- Linhas 894 a 937:
894:             .Visible = .T.
895:         ENDWITH
896: 
897:         *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
898:         par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
899:         WITH par_oPag.chk_4c_ValPends
900:             .Top = 309
901:             .Left = 409
902:             .Width = 82
903:             .Height = 13
904:             .FontSize = 7
905:             .Alignment = 0
906:             .Caption = "Valor Pendente"
907:             .Value = 0
908:             .SpecialEffect = 1
909:             .Visible = .T.
910:         ENDWITH
911: 
912:         *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
913:         par_oPag.AddObject("lbl_4c_Say14", "Label")
914:         WITH par_oPag.lbl_4c_Say14
915:             .Top = 103
916:             .Left = 148
917:             .Width = 38
918:             .FontName = "Tahoma"
919:             .ForeColor = RGB(90, 90, 90)
920:             .Caption = "Filtros :"
921:             .Visible = .T.
922:         ENDWITH
923: 
924:         par_oPag.AddObject("txt_4c_Filtros", "TextBox")
925:         WITH par_oPag.txt_4c_Filtros
926:             .Top = 99
927:             .Left = 190
928:             .Width = 312
929:             .Height = 23
930:             .Value = ""
931:             .Format = "K!"
932:             .BackStyle = 1
933:             .FontName = "Tahoma"
934:             .SpecialEffect = 1
935:             .Visible = .T.
936:         ENDWITH
937: 

*-- Linhas 949 a 1052:
949:             .Visible = .F.
950:         ENDWITH
951: 
952:         BINDEVENT(par_oPag.txt_4c_Filtros, "LostFocus", THIS, "GetFiltrosLostFocus")
953: 
954:         *-- Lookups (regra #47 - LostFocus, nao KeyPress, para nao abrir o
955:         *-- picker a cada tecla). Implementados em AbrirLookup* mais abaixo.
956:         BINDEVENT(par_oPag.txt_4c_CMoes,      "LostFocus", THIS, "ValidarCMoes")
957:         BINDEVENT(par_oPag.txt_4c_DMoes,      "LostFocus", THIS, "ValidarDMoes")
958:         BINDEVENT(par_oPag.txt_4c_CMoesC,     "LostFocus", THIS, "ValidarCMoesC")
959:         BINDEVENT(par_oPag.txt_4c_DMoesC,     "LostFocus", THIS, "ValidarDMoesC")
960:         BINDEVENT(par_oPag.txt_4c_MoeSaldo,   "LostFocus", THIS, "ValidarMoeSaldo")
961:         BINDEVENT(par_oPag.txt_4c_CFPublis,   "LostFocus", THIS, "ValidarCFPublis")
962:         BINDEVENT(par_oPag.txt_4c_DFPublis,   "LostFocus", THIS, "ValidarDFPublis")
963:         BINDEVENT(par_oPag.txt_4c_EspecieNfs, "LostFocus", THIS, "ValidarEspecieNfsFiltro")
964:         BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")
965: 
966:         *-- Textos fixos sobre as duas grades de clientes
967:         par_oPag.AddObject("lbl_4c_Say15", "Label")
968:         WITH par_oPag.lbl_4c_Say15
969:             .Top = 410
970:             .Left = 81
971:             .Width = 351
972:             .FontBold = .T.
973:             .FontSize = 8
974:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
975:             .Visible = .T.
976:         ENDWITH
977: 
978:         par_oPag.AddObject("lbl_4c_Say16", "Label")
979:         WITH par_oPag.lbl_4c_Say16
980:             .Top = 559
981:             .Left = 81
982:             .Width = 574
983:             .FontBold = .T.
984:             .FontSize = 8
985:             .ForeColor = RGB(255, 255, 255)
986:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
987:             .Visible = .T.
988:         ENDWITH
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * ConfigurarOptionGroupsFiltros - optPagos/optOpcao/optCotEm/optCancs/
993:     * optConcs/optProrrogs/optFilGrd2. Legendas/ordem transcritas do dump
994:     * (regra #45) - a ORDEM do botao e o valor gravado.
995:     *--------------------------------------------------------------------------
996:     PROTECTED PROCEDURE ConfigurarOptionGroupsFiltros(par_oPag)
997:         LOCAL loc_cNao
998:         loc_cNao = "N" + CHR(227) + "o"
999: 
1000:         *-- Pagamento
1001:         par_oPag.AddObject("lbl_4c_Say3", "Label")
1002:         WITH par_oPag.lbl_4c_Say3
1003:             .Top = 308
1004:             .Left = 123
1005:             .Width = 63
1006:             .FontName = "Tahoma"
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .Caption = "Pagamento :"
1009:             .Visible = .T.
1010:         ENDWITH
1011: 
1012:         par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
1013:         WITH par_oPag.opt_4c_Pagos
1014:             .Top = 303
1015:             .Left = 185
1016:             .Width = 217
1017:             .Height = 25
1018:             .ButtonCount = 3
1019:             .BackStyle = 0
1020:             .BorderStyle = 0
1021:             .Value = 1
1022:             WITH .Buttons(1)
1023:                 .Top = 5
1024:                 .Left = 5
1025:                 .Width = 43
1026:                 .FontName = "Tahoma"
1027:                 .FontSize = 8
1028:                 .BackStyle = 0
1029:                 .Caption = "Geral"
1030:                 .ForeColor = RGB(90, 90, 90)
1031:             ENDWITH
1032:             WITH .Buttons(2)
1033:                 .Top = 5
1034:                 .Left = 85
1035:                 .Width = 34
1036:                 .FontName = "Tahoma"
1037:                 .FontSize = 8
1038:                 .BackStyle = 0
1039:                 .Caption = "Sim"
1040:                 .ForeColor = RGB(90, 90, 90)
1041:             ENDWITH
1042:             WITH .Buttons(3)
1043:                 .Top = 5
1044:                 .Left = 175
1045:                 .Width = 37
1046:                 .FontName = "Tahoma"
1047:                 .FontSize = 8
1048:                 .BackStyle = 0
1049:                 .Caption = loc_cNao
1050:                 .ForeColor = RGB(90, 90, 90)
1051:             ENDWITH
1052:             .Visible = .T.

*-- Linhas 1062 a 1107:
1062:             .ForeColor = RGB(90, 90, 90)
1063:             .Caption = "Op" + CHR(231) + CHR(227) + "o :"
1064:             .Visible = .T.
1065:         ENDWITH
1066: 
1067:         par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
1068:         WITH par_oPag.opt_4c_Opcao
1069:             .Top = 324
1070:             .Left = 185
1071:             .Width = 217
1072:             .Height = 25
1073:             .ButtonCount = 3
1074:             .BackStyle = 0
1075:             .BorderStyle = 0
1076:             .Value = 1
1077:             WITH .Buttons(1)
1078:                 .Top = 5
1079:                 .Left = 5
1080:                 .Width = 43
1081:                 .FontName = "Tahoma"
1082:                 .FontSize = 8
1083:                 .BackStyle = 0
1084:                 .Caption = "Geral"
1085:                 .ForeColor = RGB(90, 90, 90)
1086:             ENDWITH
1087:             WITH .Buttons(2)
1088:                 .Top = 5
1089:                 .Left = 85
1090:                 .Width = 34
1091:                 .FontName = "Tahoma"
1092:                 .FontSize = 8
1093:                 .BackStyle = 0
1094:                 .Caption = "Sim"
1095:                 .ForeColor = RGB(90, 90, 90)
1096:             ENDWITH
1097:             WITH .Buttons(3)
1098:                 .Top = 5
1099:                 .Left = 175
1100:                 .Width = 37
1101:                 .FontName = "Tahoma"
1102:                 .FontSize = 8
1103:                 .BackStyle = 0
1104:                 .Caption = loc_cNao
1105:                 .ForeColor = RGB(90, 90, 90)
1106:             ENDWITH
1107:             .Visible = .T.

*-- Linhas 1117 a 1162:
1117:             .ForeColor = RGB(90, 90, 90)
1118:             .Caption = "Convers" + CHR(227) + "o em :"
1119:             .Visible = .T.
1120:         ENDWITH
1121: 
1122:         par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
1123:         WITH par_oPag.opt_4c_CotEm
1124:             .Top = 282
1125:             .Left = 185
1126:             .Width = 405
1127:             .Height = 25
1128:             .ButtonCount = 5
1129:             .BackStyle = 0
1130:             .BorderStyle = 0
1131:             .Value = 1
1132:             WITH .Buttons(1)
1133:                 .Top = 5
1134:                 .Left = 5
1135:                 .Width = 56
1136:                 .FontName = "Tahoma"
1137:                 .FontSize = 8
1138:                 .BackStyle = 0
1139:                 .Caption = "Emiss" + CHR(227) + "o"
1140:                 .ForeColor = RGB(90, 90, 90)
1141:             ENDWITH
1142:             WITH .Buttons(2)
1143:                 .Top = 5
1144:                 .Left = 85
1145:                 .Width = 73
1146:                 .FontName = "Tahoma"
1147:                 .FontSize = 8
1148:                 .BackStyle = 0
1149:                 .Caption = "Vencimento"
1150:                 .ForeColor = RGB(90, 90, 90)
1151:             ENDWITH
1152:             WITH .Buttons(3)
1153:                 .Top = 5
1154:                 .Left = 175
1155:                 .Width = 76
1156:                 .FontName = "Tahoma"
1157:                 .FontSize = 8
1158:                 .BackStyle = 0
1159:                 .Caption = "Lan" + CHR(231) + "amento"
1160:                 .ForeColor = RGB(90, 90, 90)
1161:             ENDWITH
1162:             WITH .Buttons(4)

*-- Linhas 1192 a 1237:
1192:             .ForeColor = RGB(90, 90, 90)
1193:             .Caption = "Cancelamento :"
1194:             .Visible = .T.
1195:         ENDWITH
1196: 
1197:         par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
1198:         WITH par_oPag.opt_4c_Cancs
1199:             .Top = 344
1200:             .Left = 185
1201:             .Width = 217
1202:             .Height = 25
1203:             .ButtonCount = 3
1204:             .BackStyle = 0
1205:             .BorderStyle = 0
1206:             .Value = 1
1207:             WITH .Buttons(1)
1208:                 .Top = 5
1209:                 .Left = 5
1210:                 .Width = 43
1211:                 .FontName = "Tahoma"
1212:                 .FontSize = 8
1213:                 .BackStyle = 0
1214:                 .Caption = "Geral"
1215:                 .ForeColor = RGB(90, 90, 90)
1216:             ENDWITH
1217:             WITH .Buttons(2)
1218:                 .Top = 5
1219:                 .Left = 85
1220:                 .Width = 34
1221:                 .FontName = "Tahoma"
1222:                 .FontSize = 8
1223:                 .BackStyle = 0
1224:                 .Caption = "Sim"
1225:                 .ForeColor = RGB(90, 90, 90)
1226:             ENDWITH
1227:             WITH .Buttons(3)
1228:                 .Top = 5
1229:                 .Left = 175
1230:                 .Width = 37
1231:                 .FontName = "Tahoma"
1232:                 .FontSize = 8
1233:                 .BackStyle = 0
1234:                 .Caption = loc_cNao
1235:                 .ForeColor = RGB(90, 90, 90)
1236:             ENDWITH
1237:             .Visible = .T.

*-- Linhas 1247 a 1292:
1247:             .ForeColor = RGB(90, 90, 90)
1248:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
1249:             .Visible = .T.
1250:         ENDWITH
1251: 
1252:         par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
1253:         WITH par_oPag.opt_4c_Concs
1254:             .Top = 364
1255:             .Left = 185
1256:             .Width = 217
1257:             .Height = 25
1258:             .ButtonCount = 3
1259:             .BackStyle = 0
1260:             .BorderStyle = 0
1261:             .Value = 1
1262:             WITH .Buttons(1)
1263:                 .Top = 5
1264:                 .Left = 5
1265:                 .Width = 43
1266:                 .FontName = "Tahoma"
1267:                 .FontSize = 8
1268:                 .BackStyle = 0
1269:                 .Caption = "Geral"
1270:                 .ForeColor = RGB(90, 90, 90)
1271:             ENDWITH
1272:             WITH .Buttons(2)
1273:                 .Top = 5
1274:                 .Left = 85
1275:                 .Width = 34
1276:                 .FontName = "Tahoma"
1277:                 .FontSize = 8
1278:                 .BackStyle = 0
1279:                 .Caption = "Sim"
1280:                 .ForeColor = RGB(90, 90, 90)
1281:             ENDWITH
1282:             WITH .Buttons(3)
1283:                 .Top = 5
1284:                 .Left = 175
1285:                 .Width = 37
1286:                 .FontName = "Tahoma"
1287:                 .FontSize = 8
1288:                 .BackStyle = 0
1289:                 .Caption = loc_cNao
1290:                 .ForeColor = RGB(90, 90, 90)
1291:             ENDWITH
1292:             .Visible = .T.

*-- Linhas 1302 a 1435:
1302:             .ForeColor = RGB(90, 90, 90)
1303:             .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
1304:             .Visible = .T.
1305:         ENDWITH
1306: 
1307:         par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
1308:         WITH par_oPag.opt_4c_Prorrogs
1309:             .Top = 383
1310:             .Left = 185
1311:             .Width = 217
1312:             .Height = 25
1313:             .ButtonCount = 3
1314:             .BackStyle = 0
1315:             .BorderStyle = 0
1316:             .Value = 1
1317:             WITH .Buttons(1)
1318:                 .Top = 5
1319:                 .Left = 5
1320:                 .Width = 43
1321:                 .FontName = "Tahoma"
1322:                 .FontSize = 8
1323:                 .BackStyle = 0
1324:                 .Caption = "Geral"
1325:                 .ForeColor = RGB(90, 90, 90)
1326:             ENDWITH
1327:             WITH .Buttons(2)
1328:                 .Top = 5
1329:                 .Left = 85
1330:                 .Width = 34
1331:                 .FontName = "Tahoma"
1332:                 .FontSize = 8
1333:                 .BackStyle = 0
1334:                 .Caption = "Sim"
1335:                 .ForeColor = RGB(90, 90, 90)
1336:             ENDWITH
1337:             WITH .Buttons(3)
1338:                 .Top = 5
1339:                 .Left = 175
1340:                 .Width = 37
1341:                 .FontName = "Tahoma"
1342:                 .FontSize = 8
1343:                 .BackStyle = 0
1344:                 .Caption = loc_cNao
1345:                 .ForeColor = RGB(90, 90, 90)
1346:             ENDWITH
1347:             .Visible = .T.
1348:         ENDWITH
1349: 
1350:         *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
1351:         par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
1352:         WITH par_oPag.opt_4c_FilGrd2
1353:             .Top = 557
1354:             .Left = 748
1355:             .Width = 139
1356:             .Height = 17
1357:             .ButtonCount = 2
1358:             .AutoSize = .F.
1359:             .BackStyle = 0
1360:             .BorderStyle = 0
1361:             .Value = 1
1362:             WITH .Buttons(1)
1363:                 .Top = 1
1364:                 .Left = 5
1365:                 .Width = 58
1366:                 .FontName = "Verdana"
1367:                 .FontSize = 8
1368:                 .FontBold = .T.
1369:                 .BackStyle = 0
1370:                 .Caption = "Todas"
1371:                 .ForeColor = RGB(255, 255, 255)
1372:             ENDWITH
1373:             WITH .Buttons(2)
1374:                 .Top = 1
1375:                 .Left = 68
1376:                 .Width = 68
1377:                 .FontName = "Verdana"
1378:                 .FontSize = 8
1379:                 .FontBold = .T.
1380:                 .BackStyle = 0
1381:                 .Caption = "Alguma"
1382:                 .ForeColor = RGB(255, 255, 255)
1383:             ENDWITH
1384:             .Visible = .T.
1385:         ENDWITH
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
1390:     * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
1391:     * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
1392:     * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
1393:     * visual NAO segue a ordem numerica das colunas).
1394:     *--------------------------------------------------------------------------
1395:     PROTECTED PROCEDURE ConfigurarGradesFiltros(par_oPag)
1396:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2
1397:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
1398:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
1399:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
1400: 
1401:         *-- grdTipo
1402:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
1403:         WITH par_oPag.grd_4c_Tipos
1404:             .Top = 100
1405:             .Left = 624
1406:             .Width = 259
1407:             .Height = 275
1408:             .FontName = "Tahoma"
1409:             .AllowHeaderSizing = .F.
1410:             .AllowRowSizing = .F.
1411:             .DeleteMark = .F.
1412:             .RecordMark = .F.
1413:             .HeaderHeight = 17
1414:             .RowHeight = 17
1415:             .ScrollBars = 2
1416:             .GridLineColor = RGB(238, 238, 238)
1417:             .ColumnCount = 2
1418:             .RecordSource = loc_cTipos
1419: 
1420:             .Column1.ControlSource = loc_cTipos + ".Imps"
1421:             .Column1.Width = 17
1422:             .Column1.Alignment = 0
1423:             .Column1.Sparse = .F.
1424:             .Column1.Header1.Caption = ""
1425:             .Column1.AddObject("Check1", "CheckBox")
1426:             .Column1.Check1.Top = 23
1427:             .Column1.Check1.Left = 35
1428:             .Column1.Check1.Width = 60
1429:             .Column1.Check1.Height = 17
1430:             .Column1.Check1.Caption = ""
1431:             .Column1.CurrentControl = "Check1"
1432: 
1433:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1434:             .Column2.Width = 220
1435:             .Column2.Movable = .F.

*-- Linhas 1443 a 1534:
1443:             .Visible = .T.
1444:         ENDWITH
1445: 
1446:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1447:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1448:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")
1449:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "Click", THIS, "ChkTipoClick")
1450: 
1451:         *-- Grd_Clientes / Grd_Clientes2 (mesma estrutura)
1452:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes", loc_cClientes, 426, 130)
1453:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes2", loc_cClientes2, 575, 112)
1454: 
1455:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "KeyPress",   THIS, "ChkCliEKeyPress")
1456:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseUp",    THIS, "ChkCliEMouseUp")
1457:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseDown",  THIS, "ChkCliEMouseDown")
1458:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "Click",      THIS, "ChkCliEClick")
1459:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "KeyPress",   THIS, "ChkCliPKeyPress")
1460:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseUp",    THIS, "ChkCliPMouseUp")
1461:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseDown",  THIS, "ChkCliPMouseDown")
1462:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "Click",      THIS, "ChkCliPClick")
1463:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "KeyPress",   THIS, "ChkCliCKeyPress")
1464:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseUp",    THIS, "ChkCliCMouseUp")
1465:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseDown",  THIS, "ChkCliCMouseDown")
1466:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "Click",      THIS, "ChkCliCClick")
1467:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "KeyPress",   THIS, "ChkCliAKeyPress")
1468:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseUp",    THIS, "ChkCliAMouseUp")
1469:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseDown",  THIS, "ChkCliAMouseDown")
1470:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "Click",      THIS, "ChkCliAClick")
1471: 
1472:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "KeyPress",   THIS, "ChkCli2EKeyPress")
1473:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseUp",    THIS, "ChkCli2EMouseUp")
1474:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseDown",  THIS, "ChkCli2EMouseDown")
1475:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "Click",      THIS, "ChkCli2EClick")
1476:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "KeyPress",   THIS, "ChkCli2PKeyPress")
1477:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseUp",    THIS, "ChkCli2PMouseUp")
1478:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseDown",  THIS, "ChkCli2PMouseDown")
1479:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "Click",      THIS, "ChkCli2PClick")
1480:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "KeyPress",   THIS, "ChkCli2CKeyPress")
1481:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseUp",    THIS, "ChkCli2CMouseUp")
1482:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseDown",  THIS, "ChkCli2CMouseDown")
1483:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "Click",      THIS, "ChkCli2CClick")
1484:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "KeyPress",   THIS, "ChkCli2AKeyPress")
1485:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseUp",    THIS, "ChkCli2AMouseUp")
1486:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseDown",  THIS, "ChkCli2AMouseDown")
1487:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "Click",      THIS, "ChkCli2AClick")
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * ConfigurarGradeClientes - helper compartilhado por Grd_Clientes e
1492:     * Grd_Clientes2 (mesma estrutura de 8 colunas no legado).
1493:     *--------------------------------------------------------------------------
1494:     PROTECTED PROCEDURE ConfigurarGradeClientes(par_oPag, par_cNomeGrid, par_cCursor, par_nTop, par_nHeight)
1495:         LOCAL loc_oGrid
1496: 
1497:         par_oPag.AddObject(par_cNomeGrid, "Grid")
1498:         loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)
1499: 
1500:         WITH loc_oGrid
1501:             .Top = par_nTop
1502:             .Left = 81
1503:             .Width = 802
1504:             .Height = par_nHeight
1505:             .FontName = "Tahoma"
1506:             .AllowHeaderSizing = .F.
1507:             .AllowRowSizing = .F.
1508:             .DeleteMark = .F.
1509:             .RecordMark = .F.
1510:             .ScrollBars = 2
1511:             .GridLineColor = RGB(238, 238, 238)
1512:             .ColumnCount = 8
1513:             .RecordSource = par_cCursor
1514: 
1515:             .Column1.ControlSource = par_cCursor + ".Grupo"
1516:             .Column1.Width = 90
1517:             .Column1.Movable = .F.
1518:             .Column1.Resizable = .F.
1519:             .Column1.Text1.MaxLength = 10
1520:             .Column1.Header1.Caption = "Grupo"
1521:             .Column1.Header1.Alignment = 2
1522:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1523: 
1524:             .Column4.ColumnOrder = 2
1525:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1526:             .Column4.Width = 166
1527:             .Column4.Text1.MaxLength = 20
1528:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1529:             .Column4.Header1.Alignment = 2
1530:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1531: 
1532:             .Column2.ColumnOrder = 3
1533:             .Column2.ControlSource = par_cCursor + ".Conta"
1534:             .Column2.Width = 90

*-- Linhas 1626 a 1669:
1626:     * SelTudo/Apaga/ApagaG1/G2) e do filtro nomeado (AddFiltro/DelFiltro/
1627:     * RecFiltro/Carregar). Icones e ToolTip transcritos do dump do SCX.
1628:     *--------------------------------------------------------------------------
1629:     PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
1630:         *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
1631:         par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
1632:         WITH par_oPag.cmd_4c_SelTudo
1633:             .Top = 295
1634:             .Left = 892
1635:             .Width = 40
1636:             .Height = 40
1637:             .FontName = "Verdana"
1638:             .FontSize = 8
1639:             .WordWrap = .T.
1640:             .Caption = ""
1641:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1642:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1643:             .ToolTipText = "Seleciona Tudo"
1644:             .ForeColor = RGB(36, 84, 155)
1645:             .BackColor = RGB(255, 255, 255)
1646:             .Themes = .T.
1647:             .Visible = .T.
1648:         ENDWITH
1649: 
1650:         par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
1651:         WITH par_oPag.cmd_4c_Apaga
1652:             .Top = 335
1653:             .Left = 892
1654:             .Width = 40
1655:             .Height = 40
1656:             .FontName = "Verdana"
1657:             .FontSize = 8
1658:             .WordWrap = .T.
1659:             .Caption = ""
1660:             .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1661:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1662:             .ToolTipText = "Apaga Tudo"
1663:             .ForeColor = RGB(36, 84, 155)
1664:             .BackColor = RGB(255, 255, 255)
1665:             .Themes = .T.
1666:             .Visible = .T.
1667:         ENDWITH
1668: 
1669:         *-- Grd_Clientes: Inserir/Excluir/ApagaG1

*-- Linhas 1761 a 1782:
1761:             .BackColor = RGB(255, 255, 255)
1762:             .Themes = .T.
1763:             .Visible = .T.
1764:         ENDWITH
1765: 
1766:         par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
1767:         WITH par_oPag.cmd_4c_ApagaG2
1768:             .Top = 648
1769:             .Left = 892
1770:             .Width = 40
1771:             .Height = 40
1772:             .FontName = "Verdana"
1773:             .FontSize = 8
1774:             .WordWrap = .T.
1775:             .Caption = ""
1776:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1777:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1778:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1779:             .ForeColor = RGB(36, 84, 155)
1780:             .BackColor = RGB(255, 255, 255)
1781:             .Themes = .T.
1782:             .Visible = .T.

*-- Linhas 1860 a 2578:
1860:             .Visible = .T.
1861:         ENDWITH
1862: 
1863:         BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
1864:         BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
1865:         BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
1866:         BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
1867:         BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
1868:         BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
1869:         BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
1870:         BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
1871:         BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
1872:         BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
1873:         BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
1874:         BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
1875:     ENDPROC
1876: 
1877:     *==========================================================================
1878:     * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
1879:     * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE
1880:     * Valid originais (fwbuscaext/fwBuscaSel) - ligados em "LostFocus" (regra
1881:     * #47 do CLAUDE.md), nunca em "KeyPress" sem testar a tecla, para nao
1882:     * abrir o picker a cada caractere digitado. Guarda de reentrancia
1883:     * (this_lEmLookup) porque o picker eh MODAL e redispara o proprio
1884:     * LostFocus ao tirar o foco do campo (regra #37).
1885:     *==========================================================================
1886: 
1887:     *--------------------------------------------------------------------------
1888:     * ValidarCMoes/ValidarDMoes - Moeda Filtro (SigCdMoe.CMoes/DMoes)
1889:     *--------------------------------------------------------------------------
1890:     PROCEDURE ValidarCMoes()
1891:         LOCAL loc_oPag, loc_cValor
1892:         IF THIS.this_lEmLookup
1893:             RETURN
1894:         ENDIF
1895:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1896:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoes.Value)
1897:         IF loc_cValor == THIS.this_cUltimoValidarCMoesValidado
1898:             RETURN
1899:         ENDIF
1900:         THIS.this_cUltimoValidarCMoesValidado = loc_cValor
1901:         IF EMPTY(loc_cValor)
1902:             loc_oPag.txt_4c_DMoes.Value = ""
1903:             RETURN
1904:         ENDIF
1905:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1906:     ENDPROC
1907: 
1908:     PROCEDURE ValidarDMoes()
1909:         LOCAL loc_oPag, loc_cValor
1910:         IF THIS.this_lEmLookup
1911:             RETURN
1912:         ENDIF
1913:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1914:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoes.Value)
1915:         IF loc_cValor == THIS.this_cUltimoValidarDMoesValidado
1916:             RETURN
1917:         ENDIF
1918:         THIS.this_cUltimoValidarDMoesValidado = loc_cValor
1919:         IF EMPTY(loc_cValor)
1920:             loc_oPag.txt_4c_CMoes.Value = ""
1921:             RETURN
1922:         ENDIF
1923:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1924:     ENDPROC
1925: 
1926:     *--------------------------------------------------------------------------
1927:     * ValidarCMoesC/ValidarDMoesC - Moeda Conversao (SigCdMoe.CMoes/DMoes)
1928:     *--------------------------------------------------------------------------
1929:     PROCEDURE ValidarCMoesC()
1930:         LOCAL loc_oPag, loc_cValor
1931:         IF THIS.this_lEmLookup
1932:             RETURN
1933:         ENDIF
1934:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1935:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoesC.Value)
1936:         IF loc_cValor == THIS.this_cUltimoValidarCMoesCValidado
1937:             RETURN
1938:         ENDIF
1939:         THIS.this_cUltimoValidarCMoesCValidado = loc_cValor
1940:         IF EMPTY(loc_cValor)
1941:             loc_oPag.txt_4c_DMoesC.Value = ""
1942:             RETURN
1943:         ENDIF
1944:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1945:     ENDPROC
1946: 
1947:     PROCEDURE ValidarDMoesC()
1948:         LOCAL loc_oPag, loc_cValor
1949:         IF THIS.this_lEmLookup
1950:             RETURN
1951:         ENDIF
1952:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1953:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoesC.Value)
1954:         IF loc_cValor == THIS.this_cUltimoValidarDMoesCValidado
1955:             RETURN
1956:         ENDIF
1957:         THIS.this_cUltimoValidarDMoesCValidado = loc_cValor
1958:         IF EMPTY(loc_cValor)
1959:             loc_oPag.txt_4c_CMoesC.Value = ""
1960:             RETURN
1961:         ENDIF
1962:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1963:     ENDPROC
1964: 
1965:     *--------------------------------------------------------------------------
1966:     * AbrirLookupMoeda - Funil compartilhado pelas 2 moedas (Filtro/
1967:     * Conversao). par_cCampoBusca indica qual coluna buscar (CMoes se o
1968:     * usuario editou o codigo, DMoes se editou a descricao) - igual ao par
1969:     * de PROCEDURE Valid simetricos do legado.
1970:     *--------------------------------------------------------------------------
1971:     PROTECTED PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValor, par_oTxtCod, par_oTxtDesc)
1972:         LOCAL loc_oBusca, loc_oErro
1973: 
1974:         THIS.this_lEmLookup = .T.
1975:         TRY
1976:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1977:                 "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValor, ;
1978:                 "Moedas")
1979: 
1980:             IF VARTYPE(loc_oBusca) = "O"
1981:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1982:                     IF USED("cursor_4c_BuscaMoeda")
1983:                         par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1984:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1985:                     ENDIF
1986:                 ELSE
1987:                     IF !loc_oBusca.this_lAchouRegistro
1988:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1989:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1990:                         loc_oBusca.Show()
1991:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1992:                             par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1993:                             par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1994:                         ENDIF
1995:                     ENDIF
1996:                 ENDIF
1997:                 loc_oBusca.Release()
1998:             ENDIF
1999:         CATCH TO loc_oErro
2000:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
2001:         ENDTRY
2002:         THIS.this_lEmLookup = .F.
2003: 
2004:         IF USED("cursor_4c_BuscaMoeda")
2005:             USE IN cursor_4c_BuscaMoeda
2006:         ENDIF
2007:     ENDPROC
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * ValidarMoeSaldo/AbrirLookupMoedaSaldo - Moeda do Saldo Inicial (so o
2011:     * codigo, sem campo de descricao ao lado - igual ao legado).
2012:     *--------------------------------------------------------------------------
2013:     PROCEDURE ValidarMoeSaldo()
2014:         LOCAL loc_oPag, loc_cValor
2015:         IF THIS.this_lEmLookup
2016:             RETURN
2017:         ENDIF
2018:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2019:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_MoeSaldo.Value)
2020:         IF loc_cValor == THIS.this_cUltimoValidarMoeSaldoValidado
2021:             RETURN
2022:         ENDIF
2023:         THIS.this_cUltimoValidarMoeSaldoValidado = loc_cValor
2024:         IF EMPTY(loc_cValor)
2025:             RETURN
2026:         ENDIF
2027:         THIS.AbrirLookupMoedaSaldo(loc_cValor)
2028:     ENDPROC
2029: 
2030:     PROTECTED PROCEDURE AbrirLookupMoedaSaldo(par_cValor)
2031:         LOCAL loc_oBusca, loc_oErro
2032: 
2033:         THIS.this_lEmLookup = .T.
2034:         TRY
2035:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2036:                 "SigCdMoe", "cursor_4c_BuscaMoeSaldo", "CMoes", par_cValor, ;
2037:                 "Moedas")
2038: 
2039:             IF VARTYPE(loc_oBusca) = "O"
2040:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2041:                     IF USED("cursor_4c_BuscaMoeSaldo")
2042:                         THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2043:                     ENDIF
2044:                 ELSE
2045:                     IF !loc_oBusca.this_lAchouRegistro
2046:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2047:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2048:                         loc_oBusca.Show()
2049:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeSaldo")
2050:                             THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2051:                         ENDIF
2052:                     ENDIF
2053:                 ENDIF
2054:                 loc_oBusca.Release()
2055:             ENDIF
2056:         CATCH TO loc_oErro
2057:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
2058:         ENDTRY
2059:         THIS.this_lEmLookup = .F.
2060: 
2061:         IF USED("cursor_4c_BuscaMoeSaldo")
2062:             USE IN cursor_4c_BuscaMoeSaldo
2063:         ENDIF
2064:     ENDPROC
2065: 
2066:     *--------------------------------------------------------------------------
2067:     * ValidarCFPublis/ValidarDFPublis - Forma de Publicidade (SigCdFpb.Cods/
2068:     * Descs)
2069:     *--------------------------------------------------------------------------
2070:     PROCEDURE ValidarCFPublis()
2071:         LOCAL loc_oPag, loc_cValor
2072:         IF THIS.this_lEmLookup
2073:             RETURN
2074:         ENDIF
2075:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2076:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
2077:         IF loc_cValor == THIS.this_cUltimoValidarCFPublisValidado
2078:             RETURN
2079:         ENDIF
2080:         THIS.this_cUltimoValidarCFPublisValidado = loc_cValor
2081:         IF EMPTY(loc_cValor)
2082:             loc_oPag.txt_4c_DFPublis.Value = ""
2083:             RETURN
2084:         ENDIF
2085:         THIS.AbrirLookupPublicidade("Cods", loc_cValor)
2086:     ENDPROC
2087: 
2088:     PROCEDURE ValidarDFPublis()
2089:         LOCAL loc_oPag, loc_cValor
2090:         IF THIS.this_lEmLookup
2091:             RETURN
2092:         ENDIF
2093:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2094:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DFPublis.Value)
2095:         IF loc_cValor == THIS.this_cUltimoValidarDFPublisValidado
2096:             RETURN
2097:         ENDIF
2098:         THIS.this_cUltimoValidarDFPublisValidado = loc_cValor
2099:         IF EMPTY(loc_cValor)
2100:             loc_oPag.txt_4c_CFPublis.Value = ""
2101:             RETURN
2102:         ENDIF
2103:         THIS.AbrirLookupPublicidade("Descs", loc_cValor)
2104:     ENDPROC
2105: 
2106:     PROTECTED PROCEDURE AbrirLookupPublicidade(par_cCampoBusca, par_cValor)
2107:         LOCAL loc_oBusca, loc_oPag, loc_oErro
2108:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2109: 
2110:         THIS.this_lEmLookup = .T.
2111:         TRY
2112:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2113:                 "SigCdFpb", "cursor_4c_BuscaPublis", par_cCampoBusca, par_cValor, ;
2114:                 "Forma de Publicidade")
2115: 
2116:             IF VARTYPE(loc_oBusca) = "O"
2117:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2118:                     IF USED("cursor_4c_BuscaPublis")
2119:                         loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2120:                         loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2121:                     ENDIF
2122:                 ELSE
2123:                     IF !loc_oBusca.this_lAchouRegistro
2124:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2125:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2126:                         loc_oBusca.Show()
2127:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPublis")
2128:                             loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2129:                             loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2130:                         ENDIF
2131:                     ENDIF
2132:                 ENDIF
2133:                 loc_oBusca.Release()
2134:             ENDIF
2135:         CATCH TO loc_oErro
2136:             MsgErro("Erro ao buscar forma de publicidade: " + loc_oErro.Message, "Erro")
2137:         ENDTRY
2138:         THIS.this_lEmLookup = .F.
2139: 
2140:         IF USED("cursor_4c_BuscaPublis")
2141:             USE IN cursor_4c_BuscaPublis
2142:         ENDIF
2143:     ENDPROC
2144: 
2145:     *--------------------------------------------------------------------------
2146:     * ValidarEspecieNfsFiltro/AbrirLookupEspecieFiltro - Especie da Nota
2147:     * Fiscal (SigCdEsp.Especies), campo unico (sem descricao ao lado).
2148:     *--------------------------------------------------------------------------
2149:     PROCEDURE ValidarEspecieNfsFiltro()
2150:         LOCAL loc_oPag, loc_cValor
2151:         IF THIS.this_lEmLookup
2152:             RETURN
2153:         ENDIF
2154:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2155:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_EspecieNfs.Value)
2156:         IF loc_cValor == THIS.this_cUltimoValidarEspecieNfsFiltroValidado
2157:             RETURN
2158:         ENDIF
2159:         THIS.this_cUltimoValidarEspecieNfsFiltroValidado = loc_cValor
2160:         IF EMPTY(loc_cValor)
2161:             RETURN
2162:         ENDIF
2163:         THIS.AbrirLookupEspecieFiltro(loc_cValor)
2164:     ENDPROC
2165: 
2166:     PROTECTED PROCEDURE AbrirLookupEspecieFiltro(par_cValor)
2167:         LOCAL loc_oBusca, loc_oErro
2168: 
2169:         THIS.this_lEmLookup = .T.
2170:         TRY
2171:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2172:                 "SigCdEsp", "cursor_4c_BuscaEspecie", "Especies", par_cValor, ;
2173:                 "Esp" + CHR(233) + "cie da Nota Fiscal")
2174: 
2175:             IF VARTYPE(loc_oBusca) = "O"
2176:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2177:                     IF USED("cursor_4c_BuscaEspecie")
2178:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2179:                     ENDIF
2180:                 ELSE
2181:                     IF !loc_oBusca.this_lAchouRegistro
2182:                         loc_oBusca.mAddColuna("Especies", "", "Esp" + CHR(233) + "cie")
2183:                         loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2184:                         loc_oBusca.Show()
2185:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEspecie")
2186:                             THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2187:                         ENDIF
2188:                     ENDIF
2189:                 ENDIF
2190:                 loc_oBusca.Release()
2191:             ENDIF
2192:         CATCH TO loc_oErro
2193:             MsgErro("Erro ao buscar esp" + CHR(233) + "cie da nota fiscal: " + loc_oErro.Message, "Erro")
2194:         ENDTRY
2195:         THIS.this_lEmLookup = .F.
2196: 
2197:         IF USED("cursor_4c_BuscaEspecie")
2198:             USE IN cursor_4c_BuscaEspecie
2199:         ENDIF
2200:     ENDPROC
2201: 
2202:     *--------------------------------------------------------------------------
2203:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2204:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2205:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2206:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2207:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2208:     *--------------------------------------------------------------------------
2209:     PROCEDURE ValidarTitBansFiltro()
2210:         LOCAL loc_oPag, loc_cValor
2211:         IF THIS.this_lEmLookup
2212:             RETURN
2213:         ENDIF
2214:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2215:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2216:         IF loc_cValor == THIS.this_cUltimoValidarTitBansFiltroValidado
2217:             RETURN
2218:         ENDIF
2219:         THIS.this_cUltimoValidarTitBansFiltroValidado = loc_cValor
2220:         IF EMPTY(loc_cValor)
2221:             RETURN
2222:         ENDIF
2223:         THIS.AbrirLookupTitBans(loc_cValor)
2224:     ENDPROC
2225: 
2226:     PROTECTED PROCEDURE AbrirLookupTitBans(par_cValor)
2227:         LOCAL loc_oBusca, loc_oErro
2228: 
2229:         THIS.this_lEmLookup = .T.
2230:         TRY
2231:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2232:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2233:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2234:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2235: 
2236:             IF VARTYPE(loc_oBusca) = "O"
2237:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2238:                     IF USED("cursor_4c_BuscaTitBan")
2239:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2240:                     ENDIF
2241:                 ELSE
2242:                     IF !loc_oBusca.this_lAchouRegistro
2243:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2244:                         loc_oBusca.Show()
2245:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2246:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2247:                         ENDIF
2248:                     ENDIF
2249:                 ENDIF
2250:                 loc_oBusca.Release()
2251:             ENDIF
2252:         CATCH TO loc_oErro
2253:             MsgErro("Erro ao buscar t" + CHR(237) + "tulo banco: " + loc_oErro.Message, "Erro")
2254:         ENDTRY
2255:         THIS.this_lEmLookup = .F.
2256: 
2257:         IF USED("cursor_4c_BuscaTitBan")
2258:             USE IN cursor_4c_BuscaTitBan
2259:         ENDIF
2260:     ENDPROC
2261: 
2262:     *==========================================================================
2263:     * FASE 5 - Page2 (pgDados): fileira de botoes de acao (Movimento/
2264:     * Recebimento/FollowUp/Impressao/Planilha) + CommandGroup cmgRetornar +
2265:     * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
2266:     * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
2267:     * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
2268:     * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
2269:     * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
2270:     * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
2271:     *==========================================================================
2272: 
2273:     *--------------------------------------------------------------------------
2274:     * ConfigurarPaginaDados - Monta o conteudo da Page2 (resultado da
2275:     * consulta). Chamada a partir de InicializarForm(), apos a Page1.
2276:     *--------------------------------------------------------------------------
2277:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2278:         LOCAL loc_oPag
2279:         loc_oPag = THIS.pgf_4c_Paginas.Page2
2280: 
2281:         THIS.ConfigurarBotoesAcaoDados(loc_oPag)
2282:         THIS.ConfigurarCamposDados1(loc_oPag)
2283:         THIS.ConfigurarCamposDados2(loc_oPag)
2284:         THIS.ConfigurarGradeDados(loc_oPag)
2285:     ENDPROC
2286: 
2287:     *--------------------------------------------------------------------------
2288:     * ConfigurarBotoesAcaoDados - Shape1 (moldura ao redor da fileira de
2289:     * botoes), CommandGroup cmgRetornar (volta para a Page1) e os 6 botoes de
2290:     * acao (Recebimento/Movimento/FollowUp Conta/FollowUp Lancamento/
2291:     * Impressao/Planilha). SCX: Shape1 Top=83,Left=6,W=462,H=88; botoes
2292:     * Top=88, H=75 W=75, FontName="Comic Sans MS".
2293:     *--------------------------------------------------------------------------
2294:     PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
2295:         par_oPag.AddObject("shp_4c_Shape1", "Shape")
2296:         WITH par_oPag.shp_4c_Shape1
2297:             .Top         = 83
2298:             .Left        = 6
2299:             .Width       = 462
2300:             .Height      = 88
2301:             .BackStyle   = 0
2302:             .BorderStyle = 0
2303:             .BorderColor = RGB(136, 189, 188)
2304:             .Visible     = .T.
2305:         ENDWITH
2306: 
2307:         *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
2308:         par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
2309:         WITH par_oPag.obj_4c_CmgRetornar
2310:             .Top         = -2
2311:             .Left        = 918
2312:             .Width       = 85
2313:             .Height      = 85
2314:             .ButtonCount = 1
2315:             .BackStyle   = 0
2316:             .BorderStyle = 0
2317:             .Themes      = .F.
2318:             .Visible     = .T.
2319: 
2320:             WITH .Buttons(1)
2321:                 .Top         = 5
2322:                 .Left        = 5
2323:                 .Width       = 75
2324:                 .Height      = 75
2325:                 .FontName    = "Comic Sans MS"
2326:                 .FontSize    = 8
2327:                 .FontBold    = .T.
2328:                 .FontItalic  = .T.
2329:                 .Caption     = "Retornar"
2330:                 .ToolTipText = "Retornar aos Filtros"
2331:                 .ForeColor   = RGB(90, 90, 90)
2332:                 .BackColor   = RGB(255, 255, 255)
2333:                 .Themes      = .F.
2334:                 .Cancel      = .T.
2335:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2336:             ENDWITH
2337:         ENDWITH
2338:         BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")
2339: 
2340:         *-- Recebimento
2341:         par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
2342:         WITH par_oPag.cmd_4c_BtnRecebe
2343:             .Top             = 88
2344:             .Left            = 12
2345:             .Width           = 75
2346:             .Height          = 75
2347:             .FontName        = "Comic Sans MS"
2348:             .FontSize        = 8
2349:             .FontBold        = .T.
2350:             .FontItalic      = .T.
2351:             .Caption         = "\<Recebimento"
2352:             .ToolTipText     = "Recebimentos"
2353:             .ForeColor       = RGB(90, 90, 90)
2354:             .BackColor       = RGB(255, 255, 255)
2355:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2356:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2357:             .Themes          = .T.
2358:             .Visible         = .T.
2359:         ENDWITH
2360:         BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")
2361: 
2362:         *-- Movimento
2363:         par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
2364:         WITH par_oPag.cmd_4c_BtnMovimento
2365:             .Top             = 88
2366:             .Left            = 87
2367:             .Width           = 75
2368:             .Height          = 75
2369:             .FontName        = "Comic Sans MS"
2370:             .FontSize        = 8
2371:             .FontBold        = .T.
2372:             .FontItalic      = .T.
2373:             .Caption         = "\<Movimento"
2374:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
2375:             .ForeColor       = RGB(90, 90, 90)
2376:             .BackColor       = RGB(255, 255, 255)
2377:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2378:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2379:             .Themes          = .T.
2380:             .Visible         = .T.
2381:         ENDWITH
2382:         BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")
2383: 
2384:         *-- Follow-up da Conta
2385:         par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
2386:         WITH par_oPag.cmd_4c_BtnFollowUpC
2387:             .Top             = 88
2388:             .Left            = 162
2389:             .Width           = 75
2390:             .Height          = 75
2391:             .FontName        = "Comic Sans MS"
2392:             .FontSize        = 8
2393:             .FontBold        = .T.
2394:             .FontItalic      = .T.
2395:             .WordWrap        = .T.
2396:             .Caption         = "Follo\<w-up Conta"
2397:             .ToolTipText     = "Follow-up da Conta "
2398:             .ForeColor       = RGB(90, 90, 90)
2399:             .BackColor       = RGB(255, 255, 255)
2400:             .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2401:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2402:             .Themes          = .T.
2403:             .Visible         = .T.
2404:         ENDWITH
2405:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")
2406: 
2407:         *-- Follow-up do Lancamento (Titulo)
2408:         par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
2409:         WITH par_oPag.cmd_4c_BtnFollowUpL
2410:             .Top             = 88
2411:             .Left            = 237
2412:             .Width           = 75
2413:             .Height          = 75
2414:             .FontName        = "Comic Sans MS"
2415:             .FontSize        = 8
2416:             .FontBold        = .T.
2417:             .FontItalic      = .T.
2418:             .WordWrap        = .T.
2419:             .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
2420:             .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
2421:             .ForeColor       = RGB(90, 90, 90)
2422:             .BackColor       = RGB(255, 255, 255)
2423:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2424:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2425:             .Themes          = .T.
2426:             .Visible         = .T.
2427:         ENDWITH
2428:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")
2429: 
2430:         *-- Impressao
2431:         par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
2432:         WITH par_oPag.cmd_4c_BtnImprimir
2433:             .Top             = 88
2434:             .Left            = 312
2435:             .Width           = 75
2436:             .Height          = 75
2437:             .FontName        = "Comic Sans MS"
2438:             .FontSize        = 8
2439:             .FontBold        = .T.
2440:             .FontItalic      = .T.
2441:             .Caption         = "Im\<press" + CHR(227) + "o"
2442:             .ToolTipText     = "Impress" + CHR(227) + "o"
2443:             .ForeColor       = RGB(90, 90, 90)
2444:             .BackColor       = RGB(255, 255, 255)
2445:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2446:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2447:             .Themes          = .T.
2448:             .Visible         = .T.
2449:         ENDWITH
2450:         BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2451: 
2452:         *-- Planilha (Excel)
2453:         par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
2454:         WITH par_oPag.cmd_4c_BtnPlanilha
2455:             .Top             = 88
2456:             .Left            = 387
2457:             .Width           = 75
2458:             .Height          = 75
2459:             .FontName        = "Comic Sans MS"
2460:             .FontSize        = 8
2461:             .FontBold        = .T.
2462:             .FontItalic      = .T.
2463:             .Caption         = "Pla\<nilha"
2464:             .ToolTipText     = "Impress" + CHR(227) + "o"
2465:             .ForeColor       = RGB(90, 90, 90)
2466:             .BackColor       = RGB(255, 255, 255)
2467:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2468:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2469:             .Themes          = .T.
2470:             .Visible         = .T.
2471:         ENDWITH
2472:         BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
2473:     ENDPROC
2474: 
2475:     *--------------------------------------------------------------------------
2476:     * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
2477:     * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
2478:     * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
2479:     * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
2480:     *--------------------------------------------------------------------------
2481:     PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
2482:         *-- Ordem da Grade (Moeda + ...)
2483:         par_oPag.AddObject("lbl_4c_Ordem", "Label")
2484:         WITH par_oPag.lbl_4c_Ordem
2485:             .Top       = 152
2486:             .Left      = 511
2487:             .Width     = 153
2488:             .AutoSize  = .T.
2489:             .FontName  = "Tahoma"
2490:             .FontSize  = 8
2491:             .ForeColor = RGB(90, 90, 90)
2492:             .Caption   = "\<Ordem da Grade (Moeda + ...) "
2493:             .Visible   = .T.
2494:         ENDWITH
2495: 
2496:         par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
2497:         WITH par_oPag.cbo_4c_Ordem
2498:             .Top               = 170
2499:             .Left              = 510
2500:             .Width             = 182
2501:             .Height            = 23
2502:             .Style             = 2
2503:             .RowSourceType     = 1
2504:             .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"
2505:             .Value             = 1
2506:             .FontName          = "Courier New"
2507:             .SpecialEffect     = 1
2508:             .BorderColor       = RGB(36, 84, 155)
2509:             .DisabledBackColor = RGB(255, 255, 255)
2510:             .DisabledForeColor = RGB(36, 84, 155)
2511:             .ToolTipText       = "Ordem dos Dados da Grade (Sempre Moeda + Ordem Selecionada)"
2512:             .Visible           = .T.
2513:         ENDWITH
2514:         BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")
2515: 
2516:         *-- Nota Fiscal
2517:         par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
2518:         WITH par_oPag.lbl_4c_NotaFiscal
2519:             .Top       = 594
2520:             .Left      = 23
2521:             .FontName  = "Tahoma"
2522:             .ForeColor = RGB(90, 90, 90)
2523:             .Caption   = "Nota Fiscal :"
2524:             .Visible   = .T.
2525:         ENDWITH
2526: 
2527:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
2528:         WITH par_oPag.txt_4c_NFs
2529:             .Top           = 590
2530:             .Left          = 89
2531:             .Width         = 100
2532:             .Height        = 23
2533:             .Value         = ""
2534:             .Format        = "K!"
2535:             .FontName      = "Tahoma"
2536:             .ForeColor     = RGB(0, 0, 0)
2537:             .SpecialEffect = 1
2538:             *-- legado getNFs: PROCEDURE When -> Return .f. (campo de exibicao)
2539:             .ReadOnly      = .T.
2540:             .Visible       = .T.
2541:         ENDWITH
2542: 
2543:         *-- Especie (da Nota Fiscal)
2544:         par_oPag.AddObject("lbl_4c_Especie", "Label")
2545:         WITH par_oPag.lbl_4c_Especie
2546:             .Top       = 594
2547:             .Left      = 212
2548:             .Width     = 45
2549:             .FontName  = "Tahoma"
2550:             .ForeColor = RGB(90, 90, 90)
2551:             .Caption   = "Esp" + CHR(233) + "cie :"
2552:             .Visible   = .T.
2553:         ENDWITH
2554: 
2555:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
2556:         WITH par_oPag.txt_4c_EspecieNfs
2557:             .Top           = 590
2558:             .Left          = 262
2559:             .Width         = 52
2560:             .Height        = 23
2561:             .Value         = ""
2562:             .FontName      = "Tahoma"
2563:             .ForeColor     = RGB(0, 0, 0)
2564:             .SpecialEffect = 1
2565:             *-- legado getEspecieNfs (pgDados): When -> Return .f.
2566:             .ReadOnly      = .T.
2567:             .Visible       = .T.
2568:         ENDWITH
2569: 
2570:         *-- Empresa
2571:         par_oPag.AddObject("lbl_4c_Empresa", "Label")
2572:         WITH par_oPag.lbl_4c_Empresa
2573:             .Top       = 621
2574:             .Left      = 207
2575:             .Width     = 50
2576:             .Height    = 15
2577:             .FontName  = "Tahoma"
2578:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 2619 a 2662:
2619:             .ForeColor     = RGB(0, 0, 0)
2620:             .SpecialEffect = 1
2621:             *-- FIEL ao legado: getContEms eh o UNICO campo de detalhe da
2622:             *-- pgDados que NAO declara "PROCEDURE When -> Return .f." no SCX,
2623:             *-- entao continua focavel. Nao transformar em ReadOnly.
2624:             .Visible       = .T.
2625:         ENDWITH
2626: 
2627:         par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
2628:         WITH par_oPag.lbl_4c_BarraEmitente
2629:             .Top       = 566
2630:             .Left      = 540
2631:             .FontName  = "Tahoma"
2632:             .FontSize  = 10
2633:             .FontBold  = .T.
2634:             .ForeColor = RGB(90, 90, 90)
2635:             .Caption   = "/"
2636:             .Visible   = .T.
2637:         ENDWITH
2638: 
2639:         par_oPag.AddObject("txt_4c_DContEms", "TextBox")
2640:         WITH par_oPag.txt_4c_DContEms
2641:             .Top           = 564
2642:             .Left          = 632
2643:             .Width         = 360
2644:             .Height        = 23
2645:             .Value         = ""
2646:             .FontName      = "Tahoma"
2647:             .FontSize      = 8
2648:             .ForeColor     = RGB(0, 0, 0)
2649:             .SpecialEffect = 1
2650:             *-- legado getDContEms: When -> Return .f.
2651:             .ReadOnly      = .T.
2652:             .Visible       = .T.
2653:         ENDWITH
2654: 
2655:         *-- Portador (codigo + razao social)
2656:         par_oPag.AddObject("lbl_4c_Portador", "Label")
2657:         WITH par_oPag.lbl_4c_Portador
2658:             .Top       = 594
2659:             .Left      = 403
2660:             .FontName  = "Tahoma"
2661:             .ForeColor = RGB(90, 90, 90)
2662:             .Caption   = "Portador :"

*-- Linhas 2714 a 2764:
2714:     * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
2715:     * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
2716:     * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
2717:     * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
2718:     * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
2719:     * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
2720:     * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
2721:     * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
2722:     * esses sao os metodos customizados do form, listados no ClassInfo).
2723:     *--------------------------------------------------------------------------
2724:     PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
2725:         *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
2726:         par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
2727:         WITH par_oPag.txt_4c_GrupEms
2728:             .Top           = 564
2729:             .Left          = 459
2730:             .Width         = 80
2731:             .Height        = 23
2732:             .Value         = ""
2733:             .Format        = "K!"
2734:             .FontName      = "Tahoma"
2735:             .ForeColor     = RGB(0, 0, 0)
2736:             .SpecialEffect = 1
2737:             .ReadOnly      = .T.
2738:             .Visible       = .T.
2739:         ENDWITH
2740: 
2741:         *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
2742:         par_oPag.AddObject("txt_4c_Grupo", "TextBox")
2743:         WITH par_oPag.txt_4c_Grupo
2744:             .Top           = 590
2745:             .Left          = 459
2746:             .Width         = 80
2747:             .Height        = 23
2748:             .Value         = ""
2749:             .Format        = "K!"
2750:             .FontName      = "Tahoma"
2751:             .ForeColor     = RGB(0, 0, 0)
2752:             .SpecialEffect = 1
2753:             .ReadOnly      = .T.
2754:             .Visible       = .T.
2755:         ENDWITH
2756: 
2757:         *-- Centro de Custo (Grupo + codigo + "/" + descricao)
2758:         par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
2759:         WITH par_oPag.lbl_4c_CentroCusto
2760:             .Top       = 621
2761:             .Left      = 366
2762:             .FontName  = "Tahoma"
2763:             .ForeColor = RGB(90, 90, 90)
2764:             .Caption   = "Centro de Custo :"

*-- Linhas 2991 a 3054:
2991:             .BackStyle   = 0
2992:             .Visible     = .T.
2993:         ENDWITH
2994:         BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")
2995: 
2996:         *-- Memo com a descricao dos filtros aplicados na consulta (somente
2997:         *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
2998:         par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
2999:         WITH par_oPag.obj_4c_GetFiltros
3000:             .Top           = 83
3001:             .Left          = 510
3002:             .Width         = 381
3003:             .Height        = 66
3004:             .Value         = ""
3005:             .ReadOnly      = .T.
3006:             .FontName      = "Tahoma"
3007:             .SpecialEffect = 1
3008:             .Visible       = .T.
3009:         ENDWITH
3010:         BINDEVENT(par_oPag.obj_4c_GetFiltros, "Click", THIS, "GetFiltrosDadosClick")
3011: 
3012:         *-- Botoes (indicadores de status do titulo - Cancelado/Baixado/
3013:         *-- Conciliado/Prorrogado). TextBoxes read-only coloridos, nunca
3014:         *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
3015:         par_oPag.AddObject("cnt_4c_Botoes", "Container")
3016:         WITH par_oPag.cnt_4c_Botoes
3017:             .Top         = 643
3018:             .Left        =  542
3019:             .Width       = 115
3020:             .Height      = 24
3021:             .BackStyle   = 0
3022:             .BorderWidth = 0
3023:             .Visible     = .T.
3024: 
3025:             .AddObject("txt_4c_Botao1", "TextBox")
3026:             WITH .txt_4c_Botao1
3027:                 .Top         = 1
3028:                 .Left        = 1
3029:                 .Width       = 29
3030:                 .Height      = 23
3031:                 .Alignment   = 0
3032:                 .Value       = ""
3033:                 .FontBold    = .T.
3034:                 .FontSize    = 12
3035:                 .BackColor   = RGB(255, 0, 0)
3036:                 .ToolTipText = "T" + CHR(237) + "tulo Cancelado"
3037:                 .ReadOnly    = .T.
3038:                 .TabStop     = .F.
3039:                 .Themes      = .F.
3040:                 .Visible     = .T.
3041:             ENDWITH
3042: 
3043:             .AddObject("txt_4c_Botao2", "TextBox")
3044:             WITH .txt_4c_Botao2
3045:                 .Top         = 1
3046:                 .Left        = 29
3047:                 .Width       = 29
3048:                 .Height      = 23
3049:                 .Alignment   = 0
3050:                 .Value       = ""
3051:                 .FontBold    = .T.
3052:                 .FontSize    = 12
3053:                 .BackColor   = RGB(0, 128, 0)
3054:                 .ToolTipText = "T" + CHR(237) + "tulo Baixado"

*-- Linhas 3100 a 3666:
3100:     * GetFiltrosDadosClick - Expande/retrai o memo de filtros aplicados
3101:     * (igual ao Click original do getFiltros da Page2 - alterna Height).
3102:     *--------------------------------------------------------------------------
3103:     PROCEDURE GetFiltrosDadosClick()
3104:         LOCAL loc_oMemo
3105:         loc_oMemo = THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros
3106: 
3107:         IF loc_oMemo.Height = 66
3108:             loc_oMemo.Height = 200
3109:         ELSE
3110:             loc_oMemo.Height = 66
3111:         ENDIF
3112:     ENDPROC
3113: 
3114:     *--------------------------------------------------------------------------
3115:     * CmgRetornarClick / Btn*Click (Page2) - navegacao e acoes. A logica
3116:     * completa (abrir SigCdPgr/SigCdLch, montar relatorio/planilha) e
3117:     * implementada na fase de eventos; aqui o botao ja volta para a Page1
3118:     * (unico comportamento que nao depende de registro selecionado na grade).
3119:     *--------------------------------------------------------------------------
3120:     PROCEDURE CmgRetornarClick()
3121:         *-- cmgRetornar do legado volta para a pagina de filtros. Delega ao
3122:         *-- funil unico de "abandonar a pagina corrente" (BtnCancelarClick).
3123:         THIS.BtnCancelarClick()
3124:     ENDPROC
3125: 
3126:     *--------------------------------------------------------------------------
3127:     * AlternarPagina - FUNIL de navegacao entre Filtros/Dados. Alem de trocar
3128:     * o ActivePage e o modo, repoe o estado que depende da pagina ativa:
3129:     *
3130:     *   - HabilitarCampos(): aplica o contrato de edicao de cada pagina
3131:     *     (filtros editaveis na Page1; campos de exibicao da Page2 sempre
3132:     *     somente-leitura, como os "PROCEDURE When -> Return .f." do legado).
3133:     *   - CarregarLista(): REPINTA a grade de resultado. Processamento()
3134:     *     popula cursor_4c_Dados com a Page2 ainda OCULTA e Refresh em pagina
3135:     *     oculta NAO pinta (regra #21/#46 do CLAUDE.md) - por isso a
3136:     *     repintura tem de acontecer AQUI, DEPOIS do ActivePage.
3137:     *--------------------------------------------------------------------------
3138:     PROCEDURE AlternarPagina(par_nPagina)
3139:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3140: 
3141:         DO CASE
3142:         CASE par_nPagina = 1
3143:             THIS.this_cModoAtual = "FILTROS"
3144:             THIS.HabilitarCampos(.T.)
3145:         CASE par_nPagina = 2
3146:             THIS.this_cModoAtual = "DADOS"
3147:             THIS.HabilitarCampos(.F.)
3148:             THIS.CarregarLista()
3149:         ENDCASE
3150:     ENDPROC
3151: 
3152:     *--------------------------------------------------------------------------
3153:     * CmgFiltrosClick - Buttons(1)=Consultar valida as 4 faixas de data e
3154:     * segue para a Page2; Buttons(2)=Sair fecha o form (Cancel=.T., tambem
3155:     * dispara por ESC).
3156:     *--------------------------------------------------------------------------
3157:     PROCEDURE CmgFiltrosClick()
3158:         LOCAL loc_oGrupo, loc_nBotao
3159: 
3160:         loc_oGrupo = THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros
3161:         loc_nBotao = loc_oGrupo.Value
3162: 
3163:         DO CASE
3164:         CASE loc_nBotao = 1
3165:             THIS.BtnBuscarClick()
3166:         CASE loc_nBotao = 2
3167:             THIS.BtnCancelarClick()
3168:         ENDCASE
3169:     ENDPROC
3170: 
3171:     *--------------------------------------------------------------------------
3172:     * ValidarFiltrosData - Transcricao literal das 4 checagens "Inicial nao
3173:     * pode ser maior que a Final" do Click original (Emissao/Vencimento
3174:     * confirmados no dump; Lancamento/Acerto seguem o MESMO padrao simetrico).
3175:     *--------------------------------------------------------------------------
3176:     PROTECTED PROCEDURE ValidarFiltrosData()
3177:         LOCAL loc_oPag
3178:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3179: 
3180:         IF !EMPTY(loc_oPag.txt_4c_DtEmiI.Value) AND !EMPTY(loc_oPag.txt_4c_DtEmiF.Value) AND ;
3181:            (loc_oPag.txt_4c_DtEmiI.Value > loc_oPag.txt_4c_DtEmiF.Value)
3182:             MsgAviso("A Data de Emiss" + CHR(227) + "o Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3183:             loc_oPag.txt_4c_DtEmiI.SetFocus()
3184:             RETURN .F.
3185:         ENDIF
3186: 
3187:         IF !EMPTY(loc_oPag.txt_4c_VencsI.Value) AND !EMPTY(loc_oPag.txt_4c_VencsF.Value) AND ;
3188:            (loc_oPag.txt_4c_VencsI.Value > loc_oPag.txt_4c_VencsF.Value)
3189:             MsgAviso("A Data de Vencimento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3190:             loc_oPag.txt_4c_VencsI.SetFocus()
3191:             RETURN .F.
3192:         ENDIF
3193: 
3194:         IF !EMPTY(loc_oPag.txt_4c_DatasI.Value) AND !EMPTY(loc_oPag.txt_4c_DatasF.Value) AND ;
3195:            (loc_oPag.txt_4c_DatasI.Value > loc_oPag.txt_4c_DatasF.Value)
3196:             MsgAviso("A Data de Lan" + CHR(231) + "amento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3197:             loc_oPag.txt_4c_DatasI.SetFocus()
3198:             RETURN .F.
3199:         ENDIF
3200: 
3201:         IF !EMPTY(loc_oPag.txt_4c_DtBxI.Value) AND !EMPTY(loc_oPag.txt_4c_DtBxF.Value) AND ;
3202:            (loc_oPag.txt_4c_DtBxI.Value > loc_oPag.txt_4c_DtBxF.Value)
3203:             MsgAviso("A Data de Acerto Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3204:             loc_oPag.txt_4c_DtBxI.SetFocus()
3205:             RETURN .F.
3206:         ENDIF
3207: 
3208:         RETURN .T.
3209:     ENDPROC
3210: 
3211:     *--------------------------------------------------------------------------
3212:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3213:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3214:     *--------------------------------------------------------------------------
3215:     PROCEDURE ApagaClick()
3216:         LOCAL loc_cCursor
3217:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3218: 
3219:         IF USED(loc_cCursor)
3220:             SELECT (loc_cCursor)
3221:             REPLACE ALL Imps WITH 0
3222:             GO TOP
3223:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3224:         ENDIF
3225:     ENDPROC
3226: 
3227:     PROCEDURE SelTudoClick()
3228:         LOCAL loc_cCursor
3229:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3230: 
3231:         IF USED(loc_cCursor)
3232:             SELECT (loc_cCursor)
3233:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3234:             GO TOP
3235:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3236:         ENDIF
3237:     ENDPROC
3238: 
3239:     *--------------------------------------------------------------------------
3240:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3241:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3242:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3243:     * TmpCliente2).
3244:     *--------------------------------------------------------------------------
3245:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3246:         IF !USED(par_cCursor)
3247:             RETURN
3248:         ENDIF
3249: 
3250:         SELECT (par_cCursor)
3251:         GO TOP
3252:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3253:         IF EOF()
3254:             APPEND BLANK
3255:             GO BOTTOM
3256:         ENDIF
3257: 
3258:         par_oGrid.Refresh()
3259:         par_oGrid.SetFocus()
3260:         par_oGrid.Column1.SetFocus()
3261:     ENDPROC
3262: 
3263:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3264:         IF !USED(par_cCursor)
3265:             RETURN
3266:         ENDIF
3267: 
3268:         SELECT (par_cCursor)
3269:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3270:             DELETE
3271:         ENDIF
3272: 
3273:         GO TOP
3274:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3275:         IF EOF()
3276:             APPEND BLANK
3277:             GO BOTTOM
3278:         ENDIF
3279: 
3280:         par_oGrid.Refresh()
3281:         par_oGrid.SetFocus()
3282:         par_oGrid.Column1.SetFocus()
3283:     ENDPROC
3284: 
3285:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3286:         IF !USED(par_cCursor)
3287:             RETURN
3288:         ENDIF
3289: 
3290:         ZAP IN (par_cCursor)
3291:         SELECT (par_cCursor)
3292:         APPEND BLANK
3293:         par_oGrid.Refresh()
3294:     ENDPROC
3295: 
3296:     PROCEDURE BtnInserirClick()
3297:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3298:     ENDPROC
3299: 
3300:     PROCEDURE BtnExcluirClick()
3301:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3302:     ENDPROC
3303: 
3304:     PROCEDURE BtnInserir2Click()
3305:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3306:     ENDPROC
3307: 
3308:     PROCEDURE BtnExcluir2Click()
3309:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3310:     ENDPROC
3311: 
3312:     PROCEDURE BtnApagaG1Click()
3313:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3314:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3315:         ENDIF
3316:     ENDPROC
3317: 
3318:     PROCEDURE BtnApagaG2Click()
3319:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3320:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3321:         ENDIF
3322:     ENDPROC
3323: 
3324:     *--------------------------------------------------------------------------
3325:     * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
3326:     * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
3327:     * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
3328:     *--------------------------------------------------------------------------
3329:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3330:         IF USED(par_cCursor)
3331:             SELECT (par_cCursor)
3332:             IF !EOF()
3333:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3334:             ENDIF
3335:         ENDIF
3336:         par_oGrid.Refresh()
3337:     ENDPROC
3338: 
3339:     *-- grdTipo.Column1.Check1 (Imps)
3340:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3341:         IF INLIST(par_nKeyCode, 13, 32)
3342:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3343:             NODEFAULT
3344:         ENDIF
3345:     ENDPROC
3346:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3347:         THIS.ChkTipoKeyPress(13, 0)
3348:         NODEFAULT
3349:     ENDPROC
3350:     PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3351:         NODEFAULT
3352:     ENDPROC
3353:     PROCEDURE ChkTipoClick()
3354:         NODEFAULT
3355:     ENDPROC
3356: 
3357:     *-- Grd_Clientes.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3358:     PROCEDURE ChkCliEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3359:         IF INLIST(par_nKeyCode, 13, 32)
3360:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3361:             NODEFAULT
3362:         ENDIF
3363:     ENDPROC
3364:     PROCEDURE ChkCliEMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3365:         THIS.ChkCliEKeyPress(13, 0)
3366:         NODEFAULT
3367:     ENDPROC
3368:     PROCEDURE ChkCliEMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3369:         NODEFAULT
3370:     ENDPROC
3371:     PROCEDURE ChkCliEClick()
3372:         NODEFAULT
3373:     ENDPROC
3374: 
3375:     PROCEDURE ChkCliPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3376:         IF INLIST(par_nKeyCode, 13, 32)
3377:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3378:             NODEFAULT
3379:         ENDIF
3380:     ENDPROC
3381:     PROCEDURE ChkCliPMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3382:         THIS.ChkCliPKeyPress(13, 0)
3383:         NODEFAULT
3384:     ENDPROC
3385:     PROCEDURE ChkCliPMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3386:         NODEFAULT
3387:     ENDPROC
3388:     PROCEDURE ChkCliPClick()
3389:         NODEFAULT
3390:     ENDPROC
3391: 
3392:     PROCEDURE ChkCliCKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3393:         IF INLIST(par_nKeyCode, 13, 32)
3394:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3395:             NODEFAULT
3396:         ENDIF
3397:     ENDPROC
3398:     PROCEDURE ChkCliCMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3399:         THIS.ChkCliCKeyPress(13, 0)
3400:         NODEFAULT
3401:     ENDPROC
3402:     PROCEDURE ChkCliCMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3403:         NODEFAULT
3404:     ENDPROC
3405:     PROCEDURE ChkCliCClick()
3406:         NODEFAULT
3407:     ENDPROC
3408: 
3409:     PROCEDURE ChkCliAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3410:         IF INLIST(par_nKeyCode, 13, 32)
3411:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3412:             NODEFAULT
3413:         ENDIF
3414:     ENDPROC
3415:     PROCEDURE ChkCliAMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3416:         THIS.ChkCliAKeyPress(13, 0)
3417:         NODEFAULT
3418:     ENDPROC
3419:     PROCEDURE ChkCliAMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3420:         NODEFAULT
3421:     ENDPROC
3422:     PROCEDURE ChkCliAClick()
3423:         NODEFAULT
3424:     ENDPROC
3425: 
3426:     *-- Grd_Clientes2.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3427:     PROCEDURE ChkCli2EKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3428:         IF INLIST(par_nKeyCode, 13, 32)
3429:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3430:             NODEFAULT
3431:         ENDIF
3432:     ENDPROC
3433:     PROCEDURE ChkCli2EMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3434:         THIS.ChkCli2EKeyPress(13, 0)
3435:         NODEFAULT
3436:     ENDPROC
3437:     PROCEDURE ChkCli2EMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3438:         NODEFAULT
3439:     ENDPROC
3440:     PROCEDURE ChkCli2EClick()
3441:         NODEFAULT
3442:     ENDPROC
3443: 
3444:     PROCEDURE ChkCli2PKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3445:         IF INLIST(par_nKeyCode, 13, 32)
3446:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3447:             NODEFAULT
3448:         ENDIF
3449:     ENDPROC
3450:     PROCEDURE ChkCli2PMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3451:         THIS.ChkCli2PKeyPress(13, 0)
3452:         NODEFAULT
3453:     ENDPROC
3454:     PROCEDURE ChkCli2PMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3455:         NODEFAULT
3456:     ENDPROC
3457:     PROCEDURE ChkCli2PClick()
3458:         NODEFAULT
3459:     ENDPROC
3460: 
3461:     PROCEDURE ChkCli2CKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3462:         IF INLIST(par_nKeyCode, 13, 32)
3463:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3464:             NODEFAULT
3465:         ENDIF
3466:     ENDPROC
3467:     PROCEDURE ChkCli2CMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3468:         THIS.ChkCli2CKeyPress(13, 0)
3469:         NODEFAULT
3470:     ENDPROC
3471:     PROCEDURE ChkCli2CMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3472:         NODEFAULT
3473:     ENDPROC
3474:     PROCEDURE ChkCli2CClick()
3475:         NODEFAULT
3476:     ENDPROC
3477: 
3478:     PROCEDURE ChkCli2AKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3479:         IF INLIST(par_nKeyCode, 13, 32)
3480:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3481:             NODEFAULT
3482:         ENDIF
3483:     ENDPROC
3484:     PROCEDURE ChkCli2AMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3485:         THIS.ChkCli2AKeyPress(13, 0)
3486:         NODEFAULT
3487:     ENDPROC
3488:     PROCEDURE ChkCli2AMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3489:         NODEFAULT
3490:     ENDPROC
3491:     PROCEDURE ChkCli2AClick()
3492:         NODEFAULT
3493:     ENDPROC
3494: 
3495:     *--------------------------------------------------------------------------
3496:     * CmdAddFiltroClick - Abre o campo de digitacao do nome de um filtro novo
3497:     * (equivalente ao legado: esconde getFiltros, mostra getNewFiltro).
3498:     *--------------------------------------------------------------------------
3499:     PROCEDURE CmdAddFiltroClick()
3500:         WITH THIS.pgf_4c_Paginas.Page1
3501:             .txt_4c_Filtros.Visible   = .F.
3502:             .txt_4c_NewFiltro.Visible = .T.
3503:             .txt_4c_NewFiltro.Value   = ""
3504:             .txt_4c_NewFiltro.SetFocus()
3505:         ENDWITH
3506:     ENDPROC
3507: 
3508:     *--------------------------------------------------------------------------
3509:     * BtnRecFiltroClick/CmdDelFiltroClick - Gravar/Apagar filtro nomeado em
3510:     * SigSyPar (cidparams = "SIGOPCGF" + nome, padrao determinado para
3511:     * permitir localizar e regravar o mesmo filtro). Substitui o
3512:     * ThisForm.poSigSyPar.fGravaUserCfg() do Framework legado (objeto nao
3513:     * portado) por SQL direto; mxmls guarda os valores atuais dos campos de
3514:     * filtro (SerializarFiltros/RestaurarFiltros), nao o XML original.
3515:     *--------------------------------------------------------------------------
3516:     PROCEDURE BtnRecFiltroClick()
3517:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cValores, loc_nExiste, loc_cSQL, loc_oErro
3518: 
3519:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3520:         loc_cNome = IIF(loc_oPag.txt_4c_NewFiltro.Visible, ALLTRIM(loc_oPag.txt_4c_NewFiltro.Value), ALLTRIM(loc_oPag.txt_4c_Filtros.Value))
3521: 
3522:         IF EMPTY(loc_cNome)
3523:             MsgAviso("Informe o nome do filtro antes de grav" + CHR(225) + "-lo.", "Aten" + CHR(231) + CHR(227) + "o")
3524:             RETURN
3525:         ENDIF
3526: 
3527:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3528:             RETURN
3529:         ENDIF
3530: 
3531:         TRY
3532:             loc_cId      = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3533:             loc_cValores = THIS.SerializarFiltros()
3534:             loc_nExiste  = 0
3535: 
3536:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3537:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3538:                 USE IN cursor_4c_FiltroExiste
3539:             ENDIF
3540: 
3541:             IF loc_nExiste > 0
3542:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3543:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3544:             ELSE
3545:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3546:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3547:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3548:             ENDIF
3549: 
3550:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3551:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3552:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3553:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3554:                 THIS.CarregarFiltrosSalvos()
3555:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3556:             ELSE
3557:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3558:             ENDIF
3559:         CATCH TO loc_oErro
3560:             MsgErro(loc_oErro.Message, "Erro")
3561:         ENDTRY
3562:     ENDPROC
3563: 
3564:     PROCEDURE CmdDelFiltroClick()
3565:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro
3566: 
3567:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3568:         loc_cNome = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3569: 
3570:         IF EMPTY(loc_cNome)
3571:             RETURN
3572:         ENDIF
3573: 
3574:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do filtro [" + loc_cNome + "]?", "Excluir Filtro")
3575:             RETURN
3576:         ENDIF
3577: 
3578:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3579:             RETURN
3580:         ENDIF
3581: 
3582:         TRY
3583:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3584:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3585: 
3586:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3587:                 loc_oPag.txt_4c_Filtros.Value = ""
3588:                 THIS.CarregarFiltrosSalvos()
3589:             ELSE
3590:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3591:             ENDIF
3592:         CATCH TO loc_oErro
3593:             MsgErro(loc_oErro.Message, "Erro")
3594:         ENDTRY
3595:     ENDPROC
3596: 
3597:     *--------------------------------------------------------------------------
3598:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3599:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3600:     * (equivalente ao mLerCfg() do Framework legado).
3601:     *--------------------------------------------------------------------------
3602:     PROCEDURE GetFiltrosLostFocus()
3603:         LOCAL loc_oPag, loc_cNome, loc_cCursor
3604: 
3605:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
3606:         loc_cNome  = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3607:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorFiltros
3608: 
3609:         IF EMPTY(loc_cNome) OR !USED(loc_cCursor)
3610:             RETURN
3611:         ENDIF
3612: 
3613:         SELECT (loc_cCursor)
3614:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3615: 
3616:         IF FOUND()
3617:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3618:         ENDIF
3619:     ENDPROC
3620: 
3621:     *--------------------------------------------------------------------------
3622:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3623:     * separador) dos campos de filtro para gravar/recarregar um filtro
3624:     * nomeado em SigSyPar.Mxmls.
3625:     *--------------------------------------------------------------------------
3626:     PROTECTED PROCEDURE SerializarFiltros()
3627:         LOCAL loc_oBO
3628: 
3629:         *-- FONTE UNICA: captura a tela nas propriedades do BO e serializa a
3630:         *-- partir DELAS, para nao haver duas leituras divergentes dos mesmos
3631:         *-- controles. Ordem e formato das 27 posicoes inalterados.
3632:         THIS.FormParaBO()
3633:         loc_oBO = THIS.this_oBusinessObject
3634: 
3635:         RETURN ;
3636:             TRANSFORM(loc_oBO.this_dDtEmiI)    + CHR(9) + ;
3637:             TRANSFORM(loc_oBO.this_dDtEmiF)    + CHR(9) + ;
3638:             TRANSFORM(loc_oBO.this_dVencsI)    + CHR(9) + ;
3639:             TRANSFORM(loc_oBO.this_dVencsF)    + CHR(9) + ;
3640:             TRANSFORM(loc_oBO.this_dDatasI)    + CHR(9) + ;
3641:             TRANSFORM(loc_oBO.this_dDatasF)    + CHR(9) + ;
3642:             TRANSFORM(loc_oBO.this_dDtBxI)     + CHR(9) + ;
3643:             TRANSFORM(loc_oBO.this_dDtBxF)     + CHR(9) + ;
3644:             ALLTRIM(loc_oBO.this_cTitulos)     + CHR(9) + ;
3645:             ALLTRIM(loc_oBO.this_cTitBans)     + CHR(9) + ;
3646:             ALLTRIM(loc_oBO.this_cEspecieNfs)  + CHR(9) + ;
3647:             ALLTRIM(loc_oBO.this_cNFs)         + CHR(9) + ;
3648:             ALLTRIM(loc_oBO.this_cCMoes)       + CHR(9) + ;
3649:             ALLTRIM(loc_oBO.this_cCMoesC)      + CHR(9) + ;
3650:             ALLTRIM(loc_oBO.this_cMoeSaldo)    + CHR(9) + ;
3651:             TRANSFORM(loc_oBO.this_nSaldo)     + CHR(9) + ;
3652:             ALLTRIM(loc_oBO.this_cCFPublis)    + CHR(9) + ;
3653:             ALLTRIM(loc_oBO.this_cEmpresa)     + CHR(9) + ;
3654:             TRANSFORM(IIF(loc_oBO.this_lBrancos, 1, 0))  + CHR(9) + ;
3655:             TRANSFORM(IIF(loc_oBO.this_lValPends, 1, 0)) + CHR(9) + ;
3656:             TRANSFORM(loc_oBO.this_nPagos)     + CHR(9) + ;
3657:             TRANSFORM(loc_oBO.this_nOpcao)     + CHR(9) + ;
3658:             TRANSFORM(loc_oBO.this_nCotEm)     + CHR(9) + ;
3659:             TRANSFORM(loc_oBO.this_nCancs)     + CHR(9) + ;
3660:             TRANSFORM(loc_oBO.this_nConcs)     + CHR(9) + ;
3661:             TRANSFORM(loc_oBO.this_nProrrogs)  + CHR(9) + ;
3662:             TRANSFORM(loc_oBO.this_nFilGrd2)
3663:     ENDPROC
3664: 
3665:     *--------------------------------------------------------------------------
3666:     * ObterTokenSerializado - Devolve a par_nPos-esima posicao de uma string

*-- Linhas 3672 a 3740:
3672:     * uma posicao vazia por filtro nao preenchido), usar GETWORDNUM faz o
3673:     * filtro nomeado voltar com os valores nos campos ERRADOS, em silencio -
3674:     * medido no VFP9 em 2026-10-24: com 4 posicoes vazias antes dele, o
3675:     * "Titulo" recebia o valor do 21o campo (indice do OptionGroup Pagamento).
3676:     *--------------------------------------------------------------------------
3677:     PROTECTED FUNCTION ObterTokenSerializado(par_cTexto, par_nPos)
3678:         LOCAL loc_nIni, loc_nFim, loc_cToken
3679:         loc_cToken = ""
3680: 
3681:         IF par_nPos <= 1
3682:             loc_nIni = 1
3683:         ELSE
3684:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos - 1)
3685:             loc_nIni = IIF(loc_nFim = 0, 0, loc_nFim + 1)
3686:         ENDIF
3687: 
3688:         IF loc_nIni > 0
3689:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos)
3690:             IF loc_nFim = 0
3691:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni)
3692:             ELSE
3693:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni, loc_nFim - loc_nIni)
3694:             ENDIF
3695:         ENDIF
3696: 
3697:         RETURN loc_cToken
3698:     ENDFUNC
3699: 
3700:     PROTECTED PROCEDURE RestaurarFiltros(par_cSerializado)
3701:         LOCAL loc_oBO, loc_nI
3702:         LOCAL ARRAY loc_aPartes[27]
3703: 
3704:         IF EMPTY(par_cSerializado)
3705:             RETURN
3706:         ENDIF
3707: 
3708:         FOR loc_nI = 1 TO 27
3709:             loc_aPartes[loc_nI] = THIS.ObterTokenSerializado(par_cSerializado, loc_nI)
3710:         ENDFOR
3711: 
3712:         *-- Captura a tela ANTES de sobrescrever: o blob guarda SO as 27
3713:         *-- posicoes de filtro, e o que nao esta nele (descricoes dos lookups,
3714:         *-- nome do filtro, ordem/totalizadores da Page2) tem de voltar ao
3715:         *-- BOParaForm com o valor que ja estava na tela, nao com um residuo.
3716:         THIS.FormParaBO()
3717:         loc_oBO = THIS.this_oBusinessObject
3718: 
3719:         loc_oBO.this_dDtEmiI    = ConverterParaData(loc_aPartes[1])
3720:         loc_oBO.this_dDtEmiF    = ConverterParaData(loc_aPartes[2])
3721:         loc_oBO.this_dVencsI    = ConverterParaData(loc_aPartes[3])
3722:         loc_oBO.this_dVencsF    = ConverterParaData(loc_aPartes[4])
3723:         loc_oBO.this_dDatasI    = ConverterParaData(loc_aPartes[5])
3724:         loc_oBO.this_dDatasF    = ConverterParaData(loc_aPartes[6])
3725:         loc_oBO.this_dDtBxI     = ConverterParaData(loc_aPartes[7])
3726:         loc_oBO.this_dDtBxF     = ConverterParaData(loc_aPartes[8])
3727:         loc_oBO.this_cTitulos   = loc_aPartes[9]
3728:         loc_oBO.this_cTitBans   = loc_aPartes[10]
3729:         loc_oBO.this_cEspecieNfs = loc_aPartes[11]
3730:         loc_oBO.this_cNFs       = loc_aPartes[12]
3731:         loc_oBO.this_cCMoes     = loc_aPartes[13]
3732:         loc_oBO.this_cCMoesC    = loc_aPartes[14]
3733:         loc_oBO.this_cMoeSaldo  = loc_aPartes[15]
3734:         loc_oBO.this_nSaldo     = VAL(loc_aPartes[16])
3735:         loc_oBO.this_cCFPublis  = loc_aPartes[17]
3736:         loc_oBO.this_cEmpresa   = loc_aPartes[18]
3737:         loc_oBO.this_lBrancos   = (VAL(loc_aPartes[19]) = 1)
3738:         loc_oBO.this_lValPends  = (VAL(loc_aPartes[20]) = 1)
3739:         loc_oBO.this_nPagos     = IIF(BETWEEN(VAL(loc_aPartes[21]), 1, 3), VAL(loc_aPartes[21]), 1)
3740:         loc_oBO.this_nOpcao     = IIF(BETWEEN(VAL(loc_aPartes[22]), 1, 3), VAL(loc_aPartes[22]), 1)

*-- Linhas 3752 a 3950:
3752:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3753:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3754:     *--------------------------------------------------------------------------
3755:     PROTECTED PROCEDURE CarregarTiposOperacao()
3756:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3757: 
3758:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3759:             RETURN
3760:         ENDIF
3761: 
3762:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3763:         loc_cCursorTmp = loc_cCursor + "Tmp"
3764:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3765: 
3766:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3767:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3768:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3769:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3770:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3771:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3772:             SELECT (loc_cCursor)
3773:             ZAP
3774:             APPEND FROM DBF(loc_cCursorTmp)
3775:             IF USED(loc_cCursorTmp)
3776:                 USE IN (loc_cCursorTmp)
3777:             ENDIF
3778: 
3779:             SELECT (loc_cCursor)
3780:             APPEND BLANK
3781:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3782:             GO TOP
3783: 
3784:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3785:         ENDIF
3786:     ENDPROC
3787: 
3788:     *--------------------------------------------------------------------------
3789:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3790:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3791:     * por "SIGOPCGF").
3792:     *--------------------------------------------------------------------------
3793:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3794:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId
3795: 
3796:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3797:             RETURN
3798:         ENDIF
3799: 
3800:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorFiltros
3801:         loc_cCursorTmp = loc_cCursor + "Tmp"
3802:         loc_cId        = PADR("SIGOPCGF", 8)
3803: 
3804:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3805:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3806: 
3807:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3808:             SELECT (loc_cCursor)
3809:             ZAP
3810:             APPEND FROM DBF(loc_cCursorTmp)
3811:             IF USED(loc_cCursorTmp)
3812:                 USE IN (loc_cCursorTmp)
3813:             ENDIF
3814:             SELECT (loc_cCursor)
3815:             GO TOP
3816:         ENDIF
3817:     ENDPROC
3818: 
3819:     *--------------------------------------------------------------------------
3820:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3821:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3822:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3823:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3824:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3825:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3826:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3827:     * restringir o universo de clientes.
3828:     *--------------------------------------------------------------------------
3829:     PROCEDURE BtnCarregarClick()
3830:         LOCAL loc_oPag
3831:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3832: 
3833:         IF EMPTY(loc_oPag.txt_4c_CFPublis.Value)
3834:             MsgAviso("Forma de Publicidade Para Filtro N" + CHR(227) + "o foi Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3835:             loc_oPag.txt_4c_CFPublis.SetFocus()
3836:             RETURN
3837:         ENDIF
3838: 
3839:         THIS.CarregarFPubs()
3840:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, loc_oPag.grd_4c_Clientes)
3841:     ENDPROC
3842: 
3843:     PROTECTED PROCEDURE CarregarFPubs()
3844:         LOCAL loc_oPag, loc_cPub, loc_cCursor, loc_cCursorTmp, loc_cSQL
3845: 
3846:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3847:             RETURN
3848:         ENDIF
3849: 
3850:         loc_oPag       = THIS.pgf_4c_Paginas.Page1
3851:         loc_cPub       = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
3852:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3853:         loc_cCursorTmp = loc_cCursor + "Tmp"
3854: 
3855:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3856:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3857:                    "FROM SigCdCli a, SigCdGcr b " + ;
3858:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3859: 
3860:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3861:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3862:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3863:             SELECT (loc_cCursor)
3864:             ZAP
3865:             APPEND FROM DBF(loc_cCursorTmp)
3866:             IF USED(loc_cCursorTmp)
3867:                 USE IN (loc_cCursorTmp)
3868:             ENDIF
3869:             SELECT (loc_cCursor)
3870:             GO TOP
3871:             loc_oPag.grd_4c_Clientes.Refresh()
3872:         ELSE
3873:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3874:         ENDIF
3875:     ENDPROC
3876: 
3877:     *--------------------------------------------------------------------------
3878:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3879:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3880:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3881:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3882:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3883:     * ControlSource de cursor que ainda nao existe derruba o Init).
3884:     *--------------------------------------------------------------------------
3885:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3886:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3887:         WITH par_oPag.grd_4c_Dados
3888:             .Top               = 202
3889:             .Left              = 7
3890:             .Width             = 986
3891:             .Height            = 355
3892:             .DeleteMark        = .F.
3893:             .RecordMark        = .F.
3894:             .ReadOnly          = .T.
3895:             .AllowHeaderSizing = .F.
3896:             .AllowRowSizing    = .F.
3897:             .GridLineColor     = RGB(238, 238, 238)
3898:             .ScrollBars        = 2
3899:             .Visible           = .T.
3900:         ENDWITH
3901:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3902:     ENDPROC
3903: 
3904:     *--------------------------------------------------------------------------
3905:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3906:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3907:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre
3908:     * chamado depois de Processamento() repovoar o cursor.
3909:     *--------------------------------------------------------------------------
3910:     PROTECTED PROCEDURE MontarGradeDados()
3911:         LOCAL loc_oGrid, loc_cCursor, loc_cCor
3912: 
3913:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
3914:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
3915: 
3916:         loc_cCor = "IIF(" + loc_cCursor + ".Nopers=9999998, RGB(255,253,179), " + ;
3917:                    "IIF(" + loc_cCursor + ".Nopers=9999999, RGB(221,252,255), " + ;
3918:                    "IIF(" + loc_cCursor + ".SInis=1, RGB(255,202,205), RGB(255,255,255))))"
3919: 
3920:         WITH loc_oGrid
3921:             .RecordSource = ""
3922:             .ColumnCount  = 12
3923:             .RecordSource = loc_cCursor
3924: 
3925:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3926:             .Column1.Width           = 64
3927:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3928: 
3929:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3930:             .Column2.Width           = 64
3931:             .Column2.Header1.Caption = "Vencto."
3932: 
3933:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3934:             .Column3.Width           = 64
3935:             .Column3.Header1.Caption = "Lancto."
3936: 
3937:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3938:             .Column4.Width           = 64
3939:             .Column4.Header1.Caption = "Baixa"
3940: 
3941:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3942:             .Column5.Width           = 70
3943:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3944: 
3945:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3946:             .Column6.Width           = 240
3947:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3948: 
3949:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3950:             .Column7.Width           = 20

*-- Linhas 3987 a 4033:
3987:     * GrdDadosAfterRowColChange - equivalente ao AfterRowColChange de
3988:     * grdDados1: carrega a linha corrente (via BO.CarregarDoCursor), espelha
3989:     * os campos de detalhe da Page2 e os 4 indicadores de status (Botao1..4),
3990:     * e habilita/desabilita os botoes de acao conforme o PROCEDURE When do
3991:     * legado (linha "real" x linha sintetica de totalizador).
3992:     *--------------------------------------------------------------------------
3993:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
3994:         LOCAL loc_oPag, loc_oBO, loc_lTot
3995: 
3996:         IF !USED(THIS.this_oBusinessObject.this_cCursorDados)
3997:             RETURN
3998:         ENDIF
3999:         IF !THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
4000:             RETURN
4001:         ENDIF
4002: 
4003:         loc_oPag = THIS.pgf_4c_Paginas.Page2
4004:         loc_oBO  = THIS.this_oBusinessObject
4005: 
4006:         *-- Bloco de limpeza do AfterRowColChange legado, extraido para o funil
4007:         *-- unico LimparCampos(). O legado limpa SEMPRE as 4 descricoes e, SO
4008:         *-- quando a linha e sintetica (llTot), os outros 14 campos; como o
4009:         *-- ramo "IF !loc_lTot" abaixo reatribui TODOS os 18, limpar os 18 de
4010:         *-- uma vez produz exatamente o mesmo resultado nos dois caminhos.
4011:         THIS.LimparCampos()
4012: 
4013:         loc_lTot = (loc_oBO.this_nLinNopers > 9999997) OR (loc_oBO.this_nLinSInis = 1)
4014: 
4015:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = IIF(!loc_lTot AND loc_oBO.this_nLinTitCancs = 1, " X", "")
4016:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = IIF(!loc_lTot AND loc_oBO.this_cLinPagos = "0", " X", "")
4017:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = IIF(!loc_lTot AND loc_oBO.this_lLinConcs, " X", "")
4018:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = IIF(!loc_lTot AND !EMPTY(loc_oBO.this_dLinProrrogs), " X", "")
4019: 
4020:         IF !loc_lTot
4021:             loc_oPag.txt_4c_NFs.Value        = loc_oBO.this_cLinNFs
4022:             loc_oPag.txt_4c_TitBans.Value    = loc_oBO.this_cLinTitBans
4023:             loc_oPag.txt_4c_EspecieNfs.Value = loc_oBO.this_cLinEspecieNfs
4024:             loc_oPag.txt_4c_Hist2s.Value     = loc_oBO.this_cLinHist2s
4025:             loc_oPag.txt_4c_Emps.Value       = loc_oBO.this_cLinEmps
4026:             loc_oPag.txt_4c_ValOcurs.Value   = loc_oBO.this_nLinValOcurs
4027:             loc_oPag.txt_4c_GrupEms.Value    = loc_oBO.this_cLinGrupEms
4028:             loc_oPag.txt_4c_ContEms.Value    = loc_oBO.this_cLinContEms
4029:             loc_oPag.txt_4c_Grupo.Value      = loc_oBO.this_cLinGrupos
4030:             loc_oPag.txt_4c_Contas.Value     = loc_oBO.this_cLinContas
4031:             loc_oPag.txt_4c_SGrupos.Value    = loc_oBO.this_cLinSGrupos
4032:             loc_oPag.txt_4c_SContas.Value    = loc_oBO.this_cLinSContas
4033:             loc_oPag.txt_4c_GrupAges.Value   = loc_oBO.this_cLinGrupAges

*-- Linhas 4039 a 4204:
4039:             loc_oPag.txt_4c_DContAges.Value = THIS.ObterRazaoSocial(loc_oBO.this_cLinContAges)
4040:         ENDIF
4041: 
4042:         *-- PROCEDURE When dos botoes de acao, extraido para o funil unico
4043:         *-- AjustarBotoesPorModo() (tambem chamado por CarregarLista, para a
4044:         *-- PRIMEIRA linha exibida, que nunca dispara AfterRowColChange).
4045:         THIS.AjustarBotoesPorModo()
4046:     ENDPROC
4047: 
4048:     *--------------------------------------------------------------------------
4049:     * ObterRazaoSocial - cache de razao social (IClis/RClis), equivalente ao
4050:     * cursor TmpContas do legado. Consulta SigCdCli SO na primeira vez que o
4051:     * codigo aparece; demais chamadas usam o SEEK no cache local.
4052:     *--------------------------------------------------------------------------
4053:     PROTECTED FUNCTION ObterRazaoSocial(par_cCodigo)
4054:         LOCAL loc_cCursor, loc_cCodigo, loc_cSQL, loc_cResultado
4055:         loc_cResultado = ""
4056:         loc_cCodigo    = ALLTRIM(NVL(par_cCodigo, ""))
4057: 
4058:         IF EMPTY(loc_cCodigo)
4059:             RETURN loc_cResultado
4060:         ENDIF
4061: 
4062:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4063:         IF !USED(loc_cCursor)
4064:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4065:             INDEX ON IClis TAG IClis
4066:         ENDIF
4067: 
4068:         SELECT (loc_cCursor)
4069:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4070:             RETURN ALLTRIM(RClis)
4071:         ENDIF
4072: 
4073:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4074:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4075:             IF !EOF("cursor_4c_RazaoTmp")
4076:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4077:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4078:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4079:             ENDIF
4080:             IF USED("cursor_4c_RazaoTmp")
4081:                 USE IN cursor_4c_RazaoTmp
4082:             ENDIF
4083:         ENDIF
4084: 
4085:         RETURN loc_cResultado
4086:     ENDFUNC
4087: 
4088:     *--------------------------------------------------------------------------
4089:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4090:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4091:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).
4092:     *--------------------------------------------------------------------------
4093:     PROCEDURE CboOrdemInteractiveChange()
4094:         LOCAL loc_oCbo, loc_oBO
4095:         loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem
4096:         loc_oBO  = THIS.this_oBusinessObject
4097: 
4098:         DO CASE
4099:         CASE loc_oCbo.Value = 1
4100:             loc_oBO.this_cOrdem = "DtEmis"
4101:         CASE loc_oCbo.Value = 2
4102:             loc_oBO.this_cOrdem = "Vencs"
4103:         CASE loc_oCbo.Value = 3
4104:             loc_oBO.this_cOrdem = "Datas"
4105:         CASE loc_oCbo.Value = 4
4106:             loc_oBO.this_cOrdem = "DtBaixa"
4107:         CASE loc_oCbo.Value = 5
4108:             loc_oBO.this_cOrdem = "Titulos"
4109:         CASE loc_oCbo.Value = 6
4110:             loc_oBO.this_cOrdem = "Hists"
4111:         CASE loc_oCbo.Value = 7
4112:             loc_oBO.this_cOrdem = "ContEms"
4113:         CASE loc_oCbo.Value = 8
4114:             loc_oBO.this_cOrdem = "Contas"
4115:         ENDCASE
4116:         loc_oBO.this_nOrdem = loc_oCbo.Value
4117: 
4118:         THIS.OrdenaGrade()
4119: 
4120:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4121:     ENDPROC
4122: 
4123:     PROCEDURE ChkTotaisClick()
4124:         THIS.OrdenaGrade()
4125:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4126:     ENDPROC
4127: 
4128:     *--------------------------------------------------------------------------
4129:     * OrdenaGrade - equivalente a ThisForm.OrdenaGrade: alterna entre o TAG
4130:     * filtrado (exclui linhas sinteticas) e o TAG cheio conforme
4131:     * chk_4c_Totais, recalcula os saldos (CalcSaldo/CalcSaldoCta conforme a
4132:     * ordem corrente) e repinta a grade.
4133:     *--------------------------------------------------------------------------
4134:     PROCEDURE OrdenaGrade()
4135:         LOCAL loc_cCursor, loc_cOrd, loc_oBO
4136:         loc_oBO     = THIS.this_oBusinessObject
4137:         loc_cCursor = loc_oBO.this_cCursorDados
4138: 
4139:         IF !USED(loc_cCursor)
4140:             RETURN
4141:         ENDIF
4142: 
4143:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4144: 
4145:         SELECT (loc_cCursor)
4146:         SET ORDER TO TAG (loc_cOrd)
4147: 
4148:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4149:             THIS.CalcSaldoCta()
4150:         ELSE
4151:             THIS.CalcSaldo()
4152:         ENDIF
4153: 
4154:         GO TOP IN (loc_cCursor)
4155:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4156:     ENDPROC
4157: 
4158:     *--------------------------------------------------------------------------
4159:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4160:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas
4161:     * sinteticas de "Saldo Inicial"/"Saldo da Moeda"/"Saldo do dia" conforme
4162:     * a troca de moeda/data na ordenacao corrente.
4163:     *--------------------------------------------------------------------------
4164:     PROTECTED PROCEDURE CalcSaldo()
4165:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4166:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4167:         LOCAL loc_cMsd, loc_nOrd, loc_dDat, loc_dRla, loc_cMoe, loc_nVal
4168: 
4169:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4170:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4171:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4172:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4173: 
4174:         SELECT (loc_cCursor)
4175:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4176: 
4177:         loc_nSdD = 0
4178:         loc_nSD1 = 0
4179:         loc_nSC1 = 0
4180:         loc_nSD2 = 0
4181:         loc_nSC2 = 0
4182:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4183:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4184:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4185: 
4186:         IF USED(loc_cTotais)
4187:             USE IN (loc_cTotais)
4188:         ENDIF
4189:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4190: 
4191:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4192: 
4193:         SELECT (loc_cCursor)
4194:         GO TOP
4195:         loc_dDat = TTOD(DtEmis)
4196:         DO CASE
4197:         CASE loc_nOrd = 2
4198:             loc_dDat = TTOD(Vencs)
4199:         CASE loc_nOrd = 3
4200:             loc_dDat = TTOD(Datas)
4201:         CASE loc_nOrd = 4
4202:             loc_dDat = TTOD(DtBaixa)
4203:         ENDCASE
4204: 

*-- Linhas 4364 a 4407:
4364:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4365:     * compondo a linha sintetica de saldo.
4366:     *--------------------------------------------------------------------------
4367:     PROTECTED PROCEDURE CalcSaldoCta()
4368:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4369:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4370:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4371: 
4372:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4373:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4374:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4375:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4376: 
4377:         SELECT (loc_cCursor)
4378:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4379: 
4380:         loc_nSdD = 0
4381:         loc_nSD1 = 0
4382:         loc_nSC1 = 0
4383:         loc_nSD2 = 0
4384:         loc_nSC2 = 0
4385:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4386:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4387: 
4388:         IF USED(loc_cTotais)
4389:             USE IN (loc_cTotais)
4390:         ENDIF
4391:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4392: 
4393:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4394: 
4395:         SELECT (loc_cCursor)
4396:         GO TOP
4397:         loc_dDat = TTOD(DtEmis)
4398:         loc_cMoe = ALLTRIM(Moedas)
4399:         loc_cEmi = ALLTRIM(ContEms)
4400:         loc_cPor = ALLTRIM(Contas)
4401: 
4402:         SCAN
4403:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4404:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4405:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4406: 
4407:                 SCATTER MEMVAR

*-- Linhas 4519 a 4629:
4519:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4520:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4521:     *--------------------------------------------------------------------------
4522:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4523:         LOCAL loc_cWhere
4524: 
4525:         IF EMPTY(par_cColGrupo)
4526:             RETURN
4527:         ENDIF
4528: 
4529:         DO CASE
4530:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4531:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "' AND " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4532:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4533:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "'"
4534:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4535:             loc_cWhere = par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4536:         OTHERWISE
4537:             RETURN
4538:         ENDCASE
4539: 
4540:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4541:     ENDPROC
4542: 
4543:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4544:         LOCAL loc_cWhere
4545: 
4546:         IF EMPTY(par_cColGrupo)
4547:             RETURN
4548:         ENDIF
4549: 
4550:         DO CASE
4551:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4552:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4553:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4554:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4555:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4556:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4557:         OTHERWISE
4558:             RETURN
4559:         ENDCASE
4560: 
4561:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4562:     ENDPROC
4563: 
4564:     *--------------------------------------------------------------------------
4565:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4566:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4567:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4568:     *--------------------------------------------------------------------------
4569:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4570:         LOCAL loc_dData
4571:         loc_dData = par_dData
4572:         IF EMPTY(loc_dData)
4573:             loc_dData = {^2099-12-31}
4574:         ENDIF
4575:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4576:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"
4577:     ENDFUNC
4578: 
4579:     *--------------------------------------------------------------------------
4580:     * Processamento - transcricao do Processamento/ThisForm.Processamento do
4581:     * legado: monta a consulta financeira (SigMvCcr + filtros de Page1),
4582:     * aplica os filtros de Grupo/Conta das duas grades auxiliares, preenche
4583:     * a Data de Baixa e converte moeda quando necessario, cria os indices de
4584:     * ordenacao e deixa cursor_4c_Dados pronto para a Page2. Retorna .T. se
4585:     * encontrou dados (e so nesse caso o CmgFiltrosClick avanca para a
4586:     * Page2); .F. mantem o usuario na Page1 (igual ao ActivePage=1 do
4587:     * legado nos dois pontos de "Dados Nao Encontrados").
4588:     *--------------------------------------------------------------------------
4589:     PROCEDURE Processamento()
4590:         LOCAL loc_oPag1, loc_oBO, loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cRes
4591:         LOCAL loc_cEmp, loc_cDem, loc_cDvc, loc_cDla, loc_cMoe, loc_cPag, loc_cOpc
4592:         LOCAL loc_cCan, loc_cCcl, loc_cTit, loc_cNfs, loc_cTba, loc_cEsp, loc_cOpT
4593:         LOCAL loc_cCodEmp, loc_dDeI, loc_dDeF, loc_dDvI, loc_dDvF, loc_dDlI, loc_dDlF
4594:         LOCAL loc_nFl2, loc_nOpe, loc_lPrimeira, loc_nNop, loc_dPbI, loc_dPbF
4595:         LOCAL loc_cMdO, loc_dTDat, loc_nCtO, loc_nCtD, loc_nVlD, loc_nVlO, loc_nVlP, loc_nVlA
4596: 
4597:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4598:         loc_oBO     = THIS.this_oBusinessObject
4599:         loc_cCursor = loc_oBO.this_cCursorDados
4600:         loc_cRes    = ""
4601: 
4602:         *-- Espelha os filtros da tela nas propriedades do BO ANTES de montar
4603:         *-- a consulta, para que o BO reflita exatamente os criterios que
4604:         *-- foram aplicados (consumido por Imprimir/Planilha e pela
4605:         *-- serializacao do filtro nomeado).
4606:         THIS.FormParaBO()
4607: 
4608:         *-- Empresa (EmpCcs tem precedencia sobre Emps - ajuste do legado
4609:         *-- para checar lancamento em outra empresa gravado no EmpCcs)
4610:         loc_cEmp = ""
4611:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4612:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4613:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4614:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4615:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4616:         ENDIF
4617: 
4618:         *-- Emissao
4619:         loc_cDem = ""
4620:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4621:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4622:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4623:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4624:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4625:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4626:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4627:         ENDIF
4628: 
4629:         *-- Vencimento

*-- Linhas 4661 a 4717:
4661:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4662:         ENDIF
4663: 
4664:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4665:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4666:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4667:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4668:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4669:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4670:         ENDIF
4671: 
4672:         *-- Pagamento
4673:         loc_cPag = ""
4674:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4675:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")
4676:             loc_cRes = loc_cRes + " / Pagamento: " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "Sim", "N" + CHR(227) + "o")
4677:         ENDIF
4678: 
4679:         *-- Opcao (NFs preenchida ou nao)
4680:         loc_cOpc = ""
4681:         IF loc_oPag1.opt_4c_Opcao.Value <> 1
4682:             loc_cOpc = " AND " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "LTRIM(RTRIM(a.NFs)) <> ''", "LTRIM(RTRIM(a.NFs)) = ''")
4683:             loc_cRes = loc_cRes + " / Op" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "Sim", "N" + CHR(227) + "o")
4684:         ENDIF
4685: 
4686:         *-- Cancelamento
4687:         loc_cCan = ""
4688:         IF loc_oPag1.opt_4c_Cancs.Value <> 1
4689:             loc_cCan = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "", "NOT ") + "a.TitCancs = 1"
4690:             loc_cRes = loc_cRes + " / Cancelamento: " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "Sim", "N" + CHR(227) + "o")
4691:         ENDIF
4692: 
4693:         *-- Conciliacao - o legado testa optCancs.Value=3 (nao optConcs) no
4694:         *-- IIF interno; preservado literalmente (regra #17).
4695:         loc_cCcl = ""
4696:         IF loc_oPag1.opt_4c_Concs.Value <> 1
4697:             loc_cCcl = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 3, "", "NOT ") + "a.Concs = 1"
4698:             loc_cRes = loc_cRes + " / Concilia" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Concs.Value = 2, "Sim", "N" + CHR(227) + "o")
4699:         ENDIF
4700: 
4701:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4702:             loc_cRes = loc_cRes + " / Prorroga" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Prorrogs.Value = 2, "Sim", "N" + CHR(227) + "o")
4703:         ENDIF
4704: 
4705:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4706:         loc_cTit = ""
4707:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4708:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4709:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4710:         ENDIF
4711: 
4712:         loc_cNfs = ""
4713:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4714:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4715:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4716:         ENDIF
4717: 

*-- Linhas 4806 a 4869:
4806:         SELECT (loc_cCursor)
4807:         GO TOP
4808:         IF EOF()
4809:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4810:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4811:             RETURN .F.
4812:         ENDIF
4813: 
4814:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4815:             REPLACE ALL Valors WITH Valors - ValPags
4816:         ENDIF
4817: 
4818:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4819:         SELECT (loc_oBO.this_cCursorClientes)
4820:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4821:         IF FOUND()
4822:             UPDATE (loc_cCursor) SET ManterDados = 0
4823: 
4824:             SELECT (loc_oBO.this_cCursorClientes)
4825:             SCAN
4826:                 IF CheckE = 1
4827:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4828:                 ENDIF
4829:                 IF CheckP = 1
4830:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4831:                 ENDIF
4832:                 IF CheckC = 1
4833:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4834:                 ENDIF
4835:                 IF CheckA = 1
4836:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4837:                 ENDIF
4838:             ENDSCAN
4839: 
4840:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4841:             SELECT (loc_oBO.this_cCursorClientes)
4842:             SCAN
4843:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4844:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4845:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4846:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4847:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4848:             ENDSCAN
4849: 
4850:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4851:         ENDIF
4852: 
4853:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4854:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4855:         SELECT (loc_oBO.this_cCursorClientes2)
4856:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4857:         IF FOUND()
4858:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4859: 
4860:             SELECT (loc_oBO.this_cCursorClientes2)
4861:             SCAN
4862:                 IF loc_nFl2 = 1
4863:                     IF CheckE = 1
4864:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4865:                     ENDIF
4866:                     IF CheckP = 1
4867:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4868:                     ENDIF
4869:                     IF CheckC = 1

*-- Linhas 4900 a 4921:
4900: 
4901:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4902:         ENDIF
4903: 
4904:         *-- Filtrando os Titulos Prorrogados
4905:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4906:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4907:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4908:             ELSE
4909:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4910:             ENDIF
4911:         ENDIF
4912: 
4913:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4914:         SELECT (loc_cCursor)
4915:         SCAN FOR Pagos = "0"
4916:             loc_nNop = Nopers
4917:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4918:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4919:                        "ORDER BY b.DatarCs DESC"
4920:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4921:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")

*-- Linhas 4958 a 4984:
4958:             SELECT (loc_cCursor)
4959:             SCAN
4960:                 IF ALLTRIM(Moedas) <> loc_cMdO
4961:                     loc_dTDat = TTOD(DtEmis)
4962:                     DO CASE
4963:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4964:                         loc_dTDat = TTOD(Vencs)
4965:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4966:                         loc_dTDat = TTOD(Datas)
4967:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4968:                         loc_dTDat = DATE()
4969:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4970:                         IF !EMPTY(DtBaixa)
4971:                             loc_dTDat = TTOD(DtBaixa)
4972:                         ENDIF
4973:                     ENDCASE
4974:                     IF EMPTY(loc_dTDat)
4975:                         loc_dTDat = TTOD(Datas)
4976:                     ENDIF
4977: 
4978:                     loc_nCtO = fBuscarCotacao(loc_cMdO, loc_dTDat, gnConnHandle)
4979:                     loc_nCtD = fBuscarCotacao(ALLTRIM(Moedas), loc_dTDat, gnConnHandle)
4980:                     loc_nVlD = (Valors   / loc_nCtO) * loc_nCtD
4981:                     loc_nVlO = (ValOcurs / loc_nCtO) * loc_nCtD
4982:                     loc_nVlP = (ValPrev  / loc_nCtO) * loc_nCtD
4983:                     loc_nVlA = (ValPags  / loc_nCtO) * loc_nCtD
4984: 

*-- Linhas 4994 a 5137:
4994:         SELECT (loc_cCursor)
4995:         GO TOP
4996:         IF EOF()
4997:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4998:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4999:             RETURN .F.
5000:         ENDIF
5001: 
5002:         SELECT (loc_cCursor)
5003:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
5004:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
5005:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
5006:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
5007:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
5008:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
5009:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
5010:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
5011: 
5012:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
5013:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
5014:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
5015:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
5016:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
5017:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists
5018:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG ContEms
5019:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG Contas
5020: 
5021:         loc_oBO.this_cOrdem = "DtEmis"
5022:         loc_oBO.this_nOrdem = 1
5023:         THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value = 1
5024: 
5025:         THIS.MontarGradeDados()
5026:         THIS.OrdenaGrade()
5027: 
5028:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
5029:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
5030: 
5031:         SELECT (loc_cCursor)
5032:         GO TOP
5033: 
5034:         RETURN .T.
5035:     ENDPROC
5036: 
5037:     *--------------------------------------------------------------------------
5038:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
5039:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
5040:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
5041:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
5042:     *--------------------------------------------------------------------------
5043:     PROCEDURE BtnMovimentoClick()
5044:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
5045: 
5046:         loc_oBO = THIS.this_oBusinessObject
5047: 
5048:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
5049:             RETURN
5050:         ENDIF
5051: 
5052:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5053: 
5054:         *-- SigCdPgr (titulo em carteira de pagamento)
5055:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5056:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5057:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5058:         loc_nQtd = 0
5059:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5060:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5061:             USE IN cursor_4c_ChkPgr
5062:         ENDIF
5063:         IF loc_nQtd > 0
5064:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5065:             RETURN
5066:         ENDIF
5067: 
5068:         *-- SigMvCab (movimento de estoque)
5069:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5070:         loc_nQtd = 0
5071:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5072:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5073:             USE IN cursor_4c_ChkMvCab
5074:         ENDIF
5075:         IF loc_nQtd > 0
5076:             IF WEXIST("FORM_")
5077:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5078:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5079:             ELSE
5080:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5081:             ENDIF
5082:             RETURN
5083:         ENDIF
5084: 
5085:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5086:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5087:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5088:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5089:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5090:                 RETURN
5091:             ENDIF
5092:             IF !EOF("cursor_4c_ChkOpOpe")
5093:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5094:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5095:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5096:                 ELSE
5097:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5098:                 ENDIF
5099:                 IF USED("cursor_4c_ChkOpOpe")
5100:                     USE IN cursor_4c_ChkOpOpe
5101:                 ENDIF
5102:                 RETURN
5103:             ENDIF
5104:             IF USED("cursor_4c_ChkOpOpe")
5105:                 USE IN cursor_4c_ChkOpOpe
5106:             ENDIF
5107:         ENDIF
5108: 
5109:         *-- SigCqChm (cheque)
5110:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5111:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5112:         loc_nQtd = 0
5113:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5114:             loc_nQtd = cursor_4c_ChkChm.Nreg
5115:             USE IN cursor_4c_ChkChm
5116:         ENDIF
5117:         IF loc_nQtd > 0
5118:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5119:             RETURN
5120:         ENDIF
5121: 
5122:         *-- SigPrCtb (contabilizacao)
5123:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5124:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5125:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5126:         loc_nQtd = 0
5127:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5128:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5129:             USE IN cursor_4c_ChkCtb
5130:         ENDIF
5131:         IF loc_nQtd > 0
5132:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5133:             RETURN
5134:         ENDIF
5135: 
5136:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5137:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;

*-- Linhas 5151 a 5708:
5151:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5152:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5153:     *--------------------------------------------------------------------------
5154:     PROCEDURE BtnRecebeClick()
5155:         LOCAL loc_oBO, loc_cSQL
5156: 
5157:         loc_oBO = THIS.this_oBusinessObject
5158: 
5159:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5160:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5161:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5162:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5163:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5164: 
5165:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5166:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5167:             RETURN
5168:         ENDIF
5169: 
5170:         IF !EOF("cursor_4c_ConsPgt")
5171:             IF USED("cursor_4c_ConsPgt")
5172:                 USE IN cursor_4c_ConsPgt
5173:             ENDIF
5174:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5175:             RETURN
5176:         ENDIF
5177:         IF USED("cursor_4c_ConsPgt")
5178:             USE IN cursor_4c_ConsPgt
5179:         ENDIF
5180: 
5181:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5182:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5183:                    "FROM SigTtCcr " + ;
5184:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5185:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5186: 
5187:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5188:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5189:             RETURN
5190:         ENDIF
5191: 
5192:         IF !EOF("cursor_4c_ConsPgt")
5193:             IF USED("cursor_4c_ConsPgt")
5194:                 USE IN cursor_4c_ConsPgt
5195:             ENDIF
5196:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5197:         ELSE
5198:             IF USED("cursor_4c_ConsPgt")
5199:                 USE IN cursor_4c_ConsPgt
5200:             ENDIF
5201:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5202:         ENDIF
5203:     ENDPROC
5204: 
5205:     *--------------------------------------------------------------------------
5206:     * BtnFollowUpCClick/BtnFollowUpLClick - equivalentes aos Click de
5207:     * btnFollowUpC/btnFollowUpL: abrem o follow-up da conta (so o emitente)
5208:     * ou do lancamento (emitente + numero da operacao).
5209:     *--------------------------------------------------------------------------
5210:     PROCEDURE BtnFollowUpCClick()
5211:         LOCAL loc_oBO
5212:         loc_oBO = THIS.this_oBusinessObject
5213: 
5214:         IF !EMPTY(loc_oBO.this_cLinContEms)
5215:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId
5216:         ENDIF
5217:     ENDPROC
5218: 
5219:     PROCEDURE BtnFollowUpLClick()
5220:         LOCAL loc_oBO
5221:         loc_oBO = THIS.this_oBusinessObject
5222: 
5223:         IF !EMPTY(loc_oBO.this_cLinContEms) AND !EMPTY(loc_oBO.this_nLinNopers)
5224:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId, loc_oBO.this_nLinNopers
5225:         ENDIF
5226:     ENDPROC
5227: 
5228:     *--------------------------------------------------------------------------
5229:     * BtnImprimirClick/BtnPlanilhaClick - delegam para Imprimir()/Planilha(),
5230:     * igual ao Click original (ThisForm.Imprimir / ThisForm.Planilha).
5231:     *--------------------------------------------------------------------------
5232:     PROCEDURE BtnImprimirClick()
5233:         THIS.Imprimir()
5234:     ENDPROC
5235: 
5236:     PROCEDURE BtnPlanilhaClick()
5237:         THIS.Planilha()
5238:     ENDPROC
5239: 
5240:     *--------------------------------------------------------------------------
5241:     * Imprimir - transcricao de ThisForm.Imprimir: monta um cursor reduzido
5242:     * (equivalente a crMccr) com os campos do relatorio, indexa pela ordem
5243:     * corrente e dispara REPORT FORM SigReCgf. O FRX legado nao foi portado
5244:     * para o acervo (nao existe em nenhuma pasta do projeto) - o guard de
5245:     * arquivo abaixo documenta essa pendencia em vez de falhar calado.
5246:     *--------------------------------------------------------------------------
5247:     *-- ============================================================
5248:     *-- PROCEDURE ExecutarReportForm (Pattern #117)
5249:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
5250:     *-- exibe MostrarErro descritivo com o path faltante.
5251:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
5252:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
5253:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
5254:     *-- fontes em runtime e mostra asteriscos em campos numericos.
5255:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
5256:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
5257:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
5258:     *-- ============================================================
5259:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
5260:         LOCAL loc_cFRX
5261:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
5262: 
5263:         IF NOT FILE(loc_cFRX)
5264:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
5265:                 loc_cFRX + CHR(13) + CHR(13) + ;
5266:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5267:             RETURN .F.
5268:         ENDIF
5269: 
5270:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
5271:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
5272:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
5273:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
5274:                     "Aten" + CHR(231) + CHR(227) + "o")
5275:                 RETURN .F.
5276:             ENDIF
5277:         ENDIF
5278: 
5279:         *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
5280:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
5281:         loc_cPointOrig    = SET("POINT")
5282:         loc_cSepOrig      = SET("SEPARATOR")
5283:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
5284:         SET POINT TO "."
5285:         SET SEPARATOR TO ","
5286:         SET REPORTBEHAVIOR 80
5287: 
5288:         DO CASE
5289:             CASE par_cModo == "PREVIEW"
5290:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
5291:             CASE par_cModo == "PRINTER_PROMPT"
5292:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
5293:             CASE par_cModo == "PRINTER"
5294:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
5295:         ENDCASE
5296: 
5297:         SET POINT TO (loc_cPointOrig)
5298:         SET SEPARATOR TO (loc_cSepOrig)
5299:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
5300: 
5301:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
5302:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
5303:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
5304:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
5305:         TRY
5306:             SET SYSMENU TO DEFAULT
5307:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
5308:             CriarMenuPrincipal()
5309:         CATCH
5310:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
5311:         ENDTRY
5312: 
5313:         RETURN .T.
5314:     ENDPROC
5315: 
5316:     PROCEDURE Imprimir()
5317:         LOCAL loc_cCursor, loc_cFrx, loc_cTit, loc_cSub, loc_cRes, loc_cFor
5318: 
5319:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5320: 
5321:         IF !USED(loc_cCursor)
5322:             RETURN
5323:         ENDIF
5324: 
5325:         IF USED("cursor_4c_RelFin")
5326:             USE IN cursor_4c_RelFin
5327:         ENDIF
5328:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5329:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5330:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5331:           FROM (loc_cCursor) ;
5332:           INTO CURSOR cursor_4c_RelFin READWRITE
5333: 
5334:         SELECT cursor_4c_RelFin
5335:         GO TOP
5336:         IF EOF()
5337:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5338:             USE IN cursor_4c_RelFin
5339:             RETURN
5340:         ENDIF
5341: 
5342:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5343:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5344:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5345:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5346: 
5347:         IF USED("cursor_4c_RelFinCab")
5348:             USE IN cursor_4c_RelFinCab
5349:         ENDIF
5350:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5351:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5352:         GO TOP IN cursor_4c_RelFinCab
5353: 
5354:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5355: 
5356:         SELECT cursor_4c_RelFin
5357:         DO CASE
5358:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5359:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5360:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5361:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5362:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5363:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5364:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5365:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5366:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5367:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5368:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5369:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5370:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5371:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5372:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5373:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5374:         ENDCASE
5375: 
5376:         SELECT cursor_4c_RelFin
5377:         GO TOP
5378: 
5379:         IF !FILE(FULLPATH(loc_cFrx + ".frx"))
5380:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
5381:         ELSE
5382:             THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
5383:         ENDIF
5384: 
5385:         USE IN cursor_4c_RelFinCab
5386:         USE IN cursor_4c_RelFin
5387: 
5388:         SELECT (loc_cCursor)
5389:         GO TOP
5390:     ENDPROC
5391: 
5392:     *--------------------------------------------------------------------------
5393:     * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
5394:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5395:     * fLimpaTexto ja portadas em utils/functions.prg).
5396:     *--------------------------------------------------------------------------
5397:     PROCEDURE Planilha()
5398:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5399: 
5400:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5401: 
5402:         IF !USED(loc_cCursor)
5403:             RETURN
5404:         ENDIF
5405: 
5406:         loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")
5407: 
5408:         IF EMPTY(loc_cArq)
5409:             RETURN
5410:         ENDIF
5411: 
5412:         IF fVerificaPasta(loc_cArq, 2)
5413:             loc_cDeb = fLimpaTexto(STRTRAN(PROPER("D" + CHR(233) + "bito"), " ", "_"))
5414:             loc_cCrd = fLimpaTexto(STRTRAN(PROPER("Cr" + CHR(233) + "dito"), " ", "_"))
5415: 
5416:             IF USED("cursor_4c_RelExcel")
5417:                 USE IN cursor_4c_RelExcel
5418:             ENDIF
5419:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5420:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5421:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5422:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5423:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5424:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5425:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5426:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5427:               FROM (loc_cCursor) ;
5428:               INTO CURSOR cursor_4c_RelExcel
5429: 
5430:             SELECT cursor_4c_RelExcel
5431:             GO TOP
5432: 
5433:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5434:                 COPY TO (loc_cArq) TYPE XLS
5435:             ELSE
5436:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5437:             ENDIF
5438: 
5439:             IF FILE(loc_cArq)
5440:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5441:             ENDIF
5442: 
5443:             USE IN cursor_4c_RelExcel
5444:         ELSE
5445:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5446:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5447:         ENDIF
5448: 
5449:         SELECT (loc_cCursor)
5450:         GO TOP
5451:     ENDPROC
5452: 
5453:     *==========================================================================
5454:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5455:     *
5456:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5457:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5458:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5459:     * acionado pelo handler do controle que o SCX legado realmente tem.
5460:     *
5461:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5462:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5463:     *                           cmgFiltros.Buttons(2) "Sair"
5464:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)
5465:     *   CarregarLista        <- repintura da grade de resultado (grdDados1)
5466:     *   LimparCampos         <- bloco de limpeza do AfterRowColChange legado
5467:     *   AjustarBotoesPorModo <- PROCEDURE When de btnMovimento / btnRecebe /
5468:     *                           btnFollowUpC / btnFollowUpL / btnImprimir
5469:     *   HabilitarCampos      <- PROCEDURE When "Return .f." dos campos de
5470:     *                           exibicao da pgDados e "Return Empty(<codigo>)"
5471:     *                           dos campos de descricao dos lookups da pgFiltros
5472:     *   FormParaBO/BOParaForm<- transferencia dos filtros da pgFiltros para as
5473:     *                           propriedades do BO e de volta
5474:     *
5475:     * Esta tela NAO tem botao de gravar: o SCX legado nao declara btnSalvar /
5476:     * btnGravar nem mGravaDados - "Consulta Global Financeira" apura o
5477:     * resultado so no cursor local (LocalDados) e os registros que ela abre
5478:     * pertencem a outras entidades, cada uma com seu proprio BO (ver o
5479:     * cabecalho de SIGOPCGFBO.prg). Por isso nao existe BtnSalvarClick aqui.
5480:     *==========================================================================
5481: 
5482:     *--------------------------------------------------------------------------
5483:     * BtnBuscarClick - Acao principal da tela (cmgFiltros.Buttons(1),
5484:     * "Consultar"): valida as faixas de data, executa a consulta e, so com
5485:     * resultado, passa para a pagina de Dados. AlternarPagina(2) e quem
5486:     * repinta a grade (ver CarregarLista).
5487:     *--------------------------------------------------------------------------
5488:     PROCEDURE BtnBuscarClick()
5489:         LOCAL loc_lResultado
5490:         loc_lResultado = .F.
5491: 
5492:         IF THIS.ValidarFiltrosData()
5493:             IF THIS.Processamento()
5494:                 THIS.AlternarPagina(2)
5495:                 loc_lResultado = .T.
5496:             ENDIF
5497:         ENDIF
5498: 
5499:         RETURN loc_lResultado
5500:     ENDPROC
5501: 
5502:     *--------------------------------------------------------------------------
5503:     * BtnCancelarClick - Funil unico de "abandonar a pagina corrente", com o
5504:     * comportamento que o legado da a cada pagina:
5505:     *   Page2 (Dados)   -> volta para os Filtros   (cmgRetornar.Click)
5506:     *   Page1 (Filtros) -> fecha o form            (cmgFiltros.Buttons(2))
5507:     *--------------------------------------------------------------------------
5508:     PROCEDURE BtnCancelarClick()
5509:         IF THIS.pgf_4c_Paginas.ActivePage = 2
5510:             THIS.AlternarPagina(1)
5511:         ELSE
5512:             THIS.BtnEncerrarClick()
5513:         ENDIF
5514: 
5515:         RETURN .T.
5516:     ENDPROC
5517: 
5518:     *--------------------------------------------------------------------------
5519:     * BtnEncerrarClick - Encerra a tela (ThisForm.Release do Click de
5520:     * cmgFiltros.Buttons(2) "Sair"). FormBase.Destroy() cuida da liberacao do
5521:     * BO e da restauracao dos popups do menu.
5522:     *--------------------------------------------------------------------------
5523:     PROCEDURE BtnEncerrarClick()
5524:         THIS.Release()
5525:     ENDPROC
5526: 
5527:     *--------------------------------------------------------------------------
5528:     * CarregarLista - FUNIL unico de repintura da grade de resultado.
5529:     *
5530:     * Processamento() popula cursor_4c_Dados e chama MontarGradeDados()/
5531:     * OrdenaGrade() com a Page2 ainda OCULTA, e Refresh em pagina oculta NAO
5532:     * pinta (regra #21/#46 do CLAUDE.md) - por isso AlternarPagina(2) chama
5533:     * este metodo DEPOIS de trocar o ActivePage.
5534:     *
5535:     * Tambem sincroniza os campos de detalhe e os botoes de acao com a linha
5536:     * corrente: a PRIMEIRA linha exibida nunca dispara AfterRowColChange, e
5537:     * sem isso ela ficaria com os campos/botoes da consulta anterior.
5538:     *--------------------------------------------------------------------------
5539:     PROCEDURE CarregarLista()
5540:         LOCAL loc_cCursor, loc_lResultado
5541:         loc_lResultado = .F.
5542: 
5543:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5544:             RETURN .F.
5545:         ENDIF
5546: 
5547:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5548: 
5549:         IF !USED(loc_cCursor)
5550:             RETURN .F.
5551:         ENDIF
5552: 
5553:         SELECT (loc_cCursor)
5554:         GO TOP
5555:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5556: 
5557:         IF EOF(loc_cCursor)
5558:             THIS.LimparCampos()
5559:             THIS.AjustarBotoesPorModo()
5560:         ELSE
5561:             THIS.GrdDadosAfterRowColChange(1)
5562:         ENDIF
5563: 
5564:         loc_lResultado = .T.
5565:         RETURN loc_lResultado
5566:     ENDPROC
5567: 
5568:     *--------------------------------------------------------------------------
5569:     * AjustarBotoesPorModo - Reproduz os PROCEDURE When dos botoes de acao da
5570:     * pgDados, que no legado sao reavaliados a cada troca de linha:
5571:     *
5572:     *   btnMovimento / btnRecebe / btnFollowUpC / btnFollowUpL
5573:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0)
5574:     *   btnImprimir
5575:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0) ;
5576:     *              Or InList(ThisForm.Ordem, [ContEms], [Contas])
5577:     *
5578:     * Sem linha corrente (cursor vazio) os When do legado leem um registro
5579:     * que nao existe - aqui isso equivale a desabilitar as acoes.
5580:     *--------------------------------------------------------------------------
5581:     PROCEDURE AjustarBotoesPorModo()
5582:         LOCAL loc_oPag, loc_oBO, loc_cCursor, loc_lHabilita
5583: 
5584:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5585:             RETURN
5586:         ENDIF
5587: 
5588:         loc_oBO     = THIS.this_oBusinessObject
5589:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
5590:         loc_cCursor = loc_oBO.this_cCursorDados
5591: 
5592:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
5593:             loc_lHabilita = .F.
5594:         ELSE
5595:             loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
5596:         ENDIF
5597: 
5598:         loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
5599:         loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
5600:         loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
5601:         loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita
5602: 
5603:         *-- O When do Imprimir tambem libera quando a ordem corrente e por
5604:         *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
5605:         loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
5606:             INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
5607:     ENDPROC
5608: 
5609:     *--------------------------------------------------------------------------
5610:     * LimparCampos - Bloco de limpeza que o legado executa no inicio do
5611:     * AfterRowColChange de grdDados1: zera os campos de detalhe da pgDados e
5612:     * os quatro indicadores de status (Botao1..Botao4).
5613:     *
5614:     * O legado limpa SEMPRE as 4 descricoes (getDContEms/getDContas/
5615:     * getDSContas/getDContAges) e, SO quando a linha e sintetica (llTot), os
5616:     * outros 14 campos; como o ramo "If Not llTot" reatribui TODOS os 18,
5617:     * limpar os 18 de uma vez produz o MESMO resultado nos dois caminhos.
5618:     *--------------------------------------------------------------------------
5619:     PROTECTED PROCEDURE LimparCampos()
5620:         LOCAL loc_oPag
5621: 
5622:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5623:             RETURN
5624:         ENDIF
5625: 
5626:         loc_oPag = THIS.pgf_4c_Paginas.Page2
5627: 
5628:         loc_oPag.txt_4c_DContEms.Value   = ""
5629:         loc_oPag.txt_4c_DContas.Value    = ""
5630:         loc_oPag.txt_4c_DSContas.Value   = ""
5631:         loc_oPag.txt_4c_DContAges.Value  = ""
5632: 
5633:         loc_oPag.txt_4c_NFs.Value        = ""
5634:         loc_oPag.txt_4c_TitBans.Value    = ""
5635:         loc_oPag.txt_4c_EspecieNfs.Value = ""
5636:         loc_oPag.txt_4c_Hist2s.Value     = ""
5637:         loc_oPag.txt_4c_Emps.Value       = ""
5638:         loc_oPag.txt_4c_ValOcurs.Value   = 0
5639:         loc_oPag.txt_4c_GrupEms.Value    = ""
5640:         loc_oPag.txt_4c_ContEms.Value    = ""
5641:         loc_oPag.txt_4c_Grupo.Value      = ""
5642:         loc_oPag.txt_4c_Contas.Value     = ""
5643:         loc_oPag.txt_4c_SGrupos.Value    = ""
5644:         loc_oPag.txt_4c_SContas.Value    = ""
5645:         loc_oPag.txt_4c_GrupAges.Value   = ""
5646:         loc_oPag.txt_4c_ContAges.Value   = ""
5647: 
5648:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = ""
5649:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = ""
5650:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = ""
5651:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = ""
5652:     ENDPROC
5653: 
5654:     *--------------------------------------------------------------------------
5655:     * HabilitarCampos - Aplica, num lugar so, o contrato de digitacao que o
5656:     * legado expressa nos PROCEDURE When de cada campo:
5657:     *
5658:     *   pgDados : TODOS os campos de detalhe declaram "Return .f." no SCX, ou
5659:     *             seja sao SOMENTE EXIBICAO. UNICA excecao fiel: getContEms,
5660:     *             que NAO declara When e por isso continua focavel.
5661:     *   pgFiltros: os campos de DESCRICAO dos lookups declaram
5662:     *             "Return Empty(This.Parent.get<Codigo>.Value)" - a descricao
5663:     *             so aceita digitacao enquanto o CODIGO esta vazio.
5664:     *
5665:     * par_lHabilitar = .T. na pagina de Filtros (filtros digitaveis) e .F. na
5666:     * pagina de Dados (nada a digitar). Chamado pelo funil AlternarPagina().
5667:     *--------------------------------------------------------------------------
5668:     PROCEDURE HabilitarCampos(par_lHabilitar)
5669:         LOCAL loc_oPag1, loc_oPag2, loc_lFiltros
5670: 
5671:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5672:             RETURN
5673:         ENDIF
5674: 
5675:         loc_lFiltros = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
5676:         loc_oPag1    = THIS.pgf_4c_Paginas.Page1
5677:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
5678: 
5679:         *-- pgFiltros: campos de filtro digitaveis
5680:         loc_oPag1.txt_4c_DtEmiI.ReadOnly     = !loc_lFiltros
5681:         loc_oPag1.txt_4c_DtEmiF.ReadOnly     = !loc_lFiltros
5682:         loc_oPag1.txt_4c_VencsI.ReadOnly     = !loc_lFiltros
5683:         loc_oPag1.txt_4c_VencsF.ReadOnly     = !loc_lFiltros
5684:         loc_oPag1.txt_4c_DatasI.ReadOnly     = !loc_lFiltros
5685:         loc_oPag1.txt_4c_DatasF.ReadOnly     = !loc_lFiltros
5686:         loc_oPag1.txt_4c_DtBxI.ReadOnly      = !loc_lFiltros
5687:         loc_oPag1.txt_4c_DtBxF.ReadOnly      = !loc_lFiltros
5688:         loc_oPag1.txt_4c_Titulos.ReadOnly    = !loc_lFiltros
5689:         loc_oPag1.txt_4c_TitBans.ReadOnly    = !loc_lFiltros
5690:         loc_oPag1.txt_4c_EspecieNfs.ReadOnly = !loc_lFiltros
5691:         loc_oPag1.txt_4c_NFs.ReadOnly        = !loc_lFiltros
5692:         loc_oPag1.txt_4c_CMoes.ReadOnly      = !loc_lFiltros
5693:         loc_oPag1.txt_4c_CMoesC.ReadOnly     = !loc_lFiltros
5694:         loc_oPag1.txt_4c_MoeSaldo.ReadOnly   = !loc_lFiltros
5695:         loc_oPag1.txt_4c_Saldo.ReadOnly      = !loc_lFiltros
5696:         loc_oPag1.txt_4c_CFPublis.ReadOnly   = !loc_lFiltros
5697:         loc_oPag1.txt_4c_Empresa.ReadOnly    = !loc_lFiltros
5698:         loc_oPag1.txt_4c_Filtros.ReadOnly    = !loc_lFiltros
5699:         loc_oPag1.txt_4c_NewFiltro.ReadOnly  = !loc_lFiltros
5700: 
5701:         *-- pgFiltros: When "Return Empty(<codigo>)" dos campos de descricao
5702:         loc_oPag1.txt_4c_DMoes.ReadOnly    = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
5703:         loc_oPag1.txt_4c_DMoesC.ReadOnly   = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
5704:         loc_oPag1.txt_4c_DFPublis.ReadOnly = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CFPublis.Value)
5705: 
5706:         *-- pgDados: "Return .f." em todo campo de detalhe (somente exibicao).
5707:         *-- txt_4c_ContEms fica FORA desta lista de proposito - getContEms e o
5708:         *-- unico campo da pgDados que nao declara When no SCX legado.

*-- Linhas 5722 a 5888:
5722:         loc_oPag2.txt_4c_DContAges.ReadOnly  = .T.
5723:         loc_oPag2.txt_4c_Hist2s.ReadOnly     = .T.
5724:         loc_oPag2.txt_4c_TitBans.ReadOnly    = .T.
5725:         loc_oPag2.txt_4c_ValOcurs.ReadOnly   = .T.
5726: 
5727:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao1.ReadOnly = .T.
5728:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao2.ReadOnly = .T.
5729:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao3.ReadOnly = .T.
5730:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao4.ReadOnly = .T.
5731:     ENDPROC
5732: 
5733:     *--------------------------------------------------------------------------
5734:     * FormParaBO - Espelha TODOS os filtros da tela nas propriedades do
5735:     * Business Object. E a fonte unica de leitura dos controles de filtro:
5736:     * chamado por Processamento() (antes de montar a consulta), por
5737:     * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
5738:     * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
5739:     *
5740:     * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
5741:     * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
5742:     * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
5743:     * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
5744:     *--------------------------------------------------------------------------
5745:     PROTECTED PROCEDURE FormParaBO()
5746:         LOCAL loc_oPag1, loc_oPag2, loc_oBO, loc_xSaldo
5747: 
5748:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5749:             RETURN .F.
5750:         ENDIF
5751: 
5752:         loc_oBO   = THIS.this_oBusinessObject
5753:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5754:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5755: 
5756:         *-- Faixas de data (ConverterParaData normaliza DATE/DATETIME/CHAR)
5757:         loc_oBO.this_dDtEmiI = ConverterParaData(loc_oPag1.txt_4c_DtEmiI.Value)
5758:         loc_oBO.this_dDtEmiF = ConverterParaData(loc_oPag1.txt_4c_DtEmiF.Value)
5759:         loc_oBO.this_dVencsI = ConverterParaData(loc_oPag1.txt_4c_VencsI.Value)
5760:         loc_oBO.this_dVencsF = ConverterParaData(loc_oPag1.txt_4c_VencsF.Value)
5761:         loc_oBO.this_dDatasI = ConverterParaData(loc_oPag1.txt_4c_DatasI.Value)
5762:         loc_oBO.this_dDatasF = ConverterParaData(loc_oPag1.txt_4c_DatasF.Value)
5763:         loc_oBO.this_dDtBxI  = ConverterParaData(loc_oPag1.txt_4c_DtBxI.Value)
5764:         loc_oBO.this_dDtBxF  = ConverterParaData(loc_oPag1.txt_4c_DtBxF.Value)
5765: 
5766:         *-- Titulo / Titulo Banco / Especie / Nota Fiscal
5767:         loc_oBO.this_cTitulos    = ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
5768:         loc_oBO.this_cTitBans    = ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
5769:         loc_oBO.this_cEspecieNfs = ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
5770:         loc_oBO.this_cNFs        = ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
5771: 
5772:         *-- Moeda de filtro / de conversao / do saldo inicial
5773:         loc_oBO.this_cCMoes    = ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
5774:         loc_oBO.this_cDMoes    = ALLTRIM(loc_oPag1.txt_4c_DMoes.Value)
5775:         loc_oBO.this_cCMoesC   = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
5776:         loc_oBO.this_cDMoesC   = ALLTRIM(loc_oPag1.txt_4c_DMoesC.Value)
5777:         loc_oBO.this_cMoeSaldo = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
5778: 
5779:         loc_xSaldo          = loc_oPag1.txt_4c_Saldo.Value
5780:         loc_oBO.this_nSaldo = IIF(VARTYPE(loc_xSaldo) = "N", loc_xSaldo, VAL(TRANSFORM(loc_xSaldo)))
5781: 
5782:         *-- Forma de Publicidade / Empresa
5783:         loc_oBO.this_cCFPublis = ALLTRIM(loc_oPag1.txt_4c_CFPublis.Value)
5784:         loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
5785:         loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
5786: 
5787:         *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
5788:         loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
5789:         loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
5790:         loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)
5791: 
5792:         *-- OptionGroup.Value e o INDICE 1-based do botao selecionado
5793:         loc_oBO.this_nPagos    = loc_oPag1.opt_4c_Pagos.Value
5794:         loc_oBO.this_nOpcao    = loc_oPag1.opt_4c_Opcao.Value
5795:         loc_oBO.this_nCotEm    = loc_oPag1.opt_4c_CotEm.Value
5796:         loc_oBO.this_nCancs    = loc_oPag1.opt_4c_Cancs.Value
5797:         loc_oBO.this_nConcs    = loc_oPag1.opt_4c_Concs.Value
5798:         loc_oBO.this_nProrrogs = loc_oPag1.opt_4c_Prorrogs.Value
5799:         loc_oBO.this_nFilGrd2  = loc_oPag1.opt_4c_FilGrd2.Value
5800: 
5801:         *-- Filtro nomeado (SigSyPar) e ordem corrente da grade.
5802:         *-- this_cOrdem NAO e escrito aqui: a fonte unica dele e
5803:         *-- CboOrdemInteractiveChange(), que traduz o indice do combo no nome
5804:         *-- da coluna usada pelo SET ORDER TO TAG.
5805:         loc_oBO.this_cFiltros   = ALLTRIM(loc_oPag1.txt_4c_Filtros.Value)
5806:         loc_oBO.this_cNewFiltro = ALLTRIM(loc_oPag1.txt_4c_NewFiltro.Value)
5807:         loc_oBO.this_nOrdem     = loc_oPag2.cbo_4c_Ordem.Value
5808: 
5809:         RETURN .T.
5810:     ENDPROC
5811: 
5812:     *--------------------------------------------------------------------------
5813:     * BOParaForm - Caminho inverso de FormParaBO: repoe na tela os filtros
5814:     * guardados nas propriedades do BO. Usado por RestaurarFiltros() ao
5815:     * carregar um filtro nomeado de SigSyPar.
5816:     *
5817:     * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
5818:     * para nunca atribuir 0 a um controle de indice (regra dos controles
5819:     * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
5820:     *--------------------------------------------------------------------------
5821:     PROTECTED PROCEDURE BOParaForm()
5822:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
5823: 
5824:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5825:             RETURN .F.
5826:         ENDIF
5827: 
5828:         loc_oBO   = THIS.this_oBusinessObject
5829:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5830:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5831: 
5832:         loc_oPag1.txt_4c_DtEmiI.Value = ConverterParaData(loc_oBO.this_dDtEmiI)
5833:         loc_oPag1.txt_4c_DtEmiF.Value = ConverterParaData(loc_oBO.this_dDtEmiF)
5834:         loc_oPag1.txt_4c_VencsI.Value = ConverterParaData(loc_oBO.this_dVencsI)
5835:         loc_oPag1.txt_4c_VencsF.Value = ConverterParaData(loc_oBO.this_dVencsF)
5836:         loc_oPag1.txt_4c_DatasI.Value = ConverterParaData(loc_oBO.this_dDatasI)
5837:         loc_oPag1.txt_4c_DatasF.Value = ConverterParaData(loc_oBO.this_dDatasF)
5838:         loc_oPag1.txt_4c_DtBxI.Value  = ConverterParaData(loc_oBO.this_dDtBxI)
5839:         loc_oPag1.txt_4c_DtBxF.Value  = ConverterParaData(loc_oBO.this_dDtBxF)
5840: 
5841:         loc_oPag1.txt_4c_Titulos.Value    = loc_oBO.this_cTitulos
5842:         loc_oPag1.txt_4c_TitBans.Value    = loc_oBO.this_cTitBans
5843:         loc_oPag1.txt_4c_EspecieNfs.Value = loc_oBO.this_cEspecieNfs
5844:         loc_oPag1.txt_4c_NFs.Value        = loc_oBO.this_cNFs
5845: 
5846:         loc_oPag1.txt_4c_CMoes.Value    = loc_oBO.this_cCMoes
5847:         loc_oPag1.txt_4c_DMoes.Value    = loc_oBO.this_cDMoes
5848:         loc_oPag1.txt_4c_CMoesC.Value   = loc_oBO.this_cCMoesC
5849:         loc_oPag1.txt_4c_DMoesC.Value   = loc_oBO.this_cDMoesC
5850:         loc_oPag1.txt_4c_MoeSaldo.Value = loc_oBO.this_cMoeSaldo
5851:         loc_oPag1.txt_4c_Saldo.Value    = loc_oBO.this_nSaldo
5852: 
5853:         loc_oPag1.txt_4c_CFPublis.Value = loc_oBO.this_cCFPublis
5854:         loc_oPag1.txt_4c_DFPublis.Value = loc_oBO.this_cDFPublis
5855:         loc_oPag1.txt_4c_Empresa.Value  = loc_oBO.this_cEmpresa
5856: 
5857:         loc_oPag1.chk_4c_Brancos.Value  = IIF(loc_oBO.this_lBrancos, 1, 0)
5858:         loc_oPag1.chk_4c_ValPends.Value = IIF(loc_oBO.this_lValPends, 1, 0)
5859:         loc_oPag2.chk_4c_Totais.Value   = IIF(loc_oBO.this_lTotais, 1, 0)
5860: 
5861:         loc_oPag1.opt_4c_Pagos.Value    = IIF(BETWEEN(loc_oBO.this_nPagos, 1, 3), loc_oBO.this_nPagos, 1)
5862:         loc_oPag1.opt_4c_Opcao.Value    = IIF(BETWEEN(loc_oBO.this_nOpcao, 1, 3), loc_oBO.this_nOpcao, 1)
5863:         loc_oPag1.opt_4c_CotEm.Value    = IIF(BETWEEN(loc_oBO.this_nCotEm, 1, 5), loc_oBO.this_nCotEm, 1)
5864:         loc_oPag1.opt_4c_Cancs.Value    = IIF(BETWEEN(loc_oBO.this_nCancs, 1, 3), loc_oBO.this_nCancs, 1)
5865:         loc_oPag1.opt_4c_Concs.Value    = IIF(BETWEEN(loc_oBO.this_nConcs, 1, 3), loc_oBO.this_nConcs, 1)
5866:         loc_oPag1.opt_4c_Prorrogs.Value = IIF(BETWEEN(loc_oBO.this_nProrrogs, 1, 3), loc_oBO.this_nProrrogs, 1)
5867:         loc_oPag1.opt_4c_FilGrd2.Value  = IIF(BETWEEN(loc_oBO.this_nFilGrd2, 1, 2), loc_oBO.this_nFilGrd2, 1)
5868: 
5869:         loc_oPag1.txt_4c_Filtros.Value   = loc_oBO.this_cFiltros
5870:         loc_oPag1.txt_4c_NewFiltro.Value = loc_oBO.this_cNewFiltro
5871:         loc_oPag2.cbo_4c_Ordem.Value     = IIF(BETWEEN(loc_oBO.this_nOrdem, 1, 8), loc_oBO.this_nOrdem, 1)
5872: 
5873:         *-- O When "Return Empty(<codigo>)" dos campos de descricao depende do
5874:         *-- codigo que acabou de ser reposto - reavaliar o contrato.
5875:         THIS.HabilitarCampos(THIS.pgf_4c_Paginas.ActivePage = 1)
5876: 
5877:         RETURN .T.
5878:     ENDPROC
5879: 
5880:     *--------------------------------------------------------------------------
5881:     * Destroy - FormBase.Destroy() cuida da liberacao do BusinessObject e da
5882:     * restauracao dos popups do menu (Erro58). DODEFAULT() SEMPRE por ultimo.
5883:     *--------------------------------------------------------------------------
5884:     PROCEDURE Destroy()
5885:         DODEFAULT()
5886:     ENDPROC
5887: 
5888: ENDDEFINE


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


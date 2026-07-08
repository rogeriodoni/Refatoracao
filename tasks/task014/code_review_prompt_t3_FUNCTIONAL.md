# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGruccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGruccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarContaccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarContaccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarClfiscal' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarClfiscalValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOrigmerc' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOrigmercValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSittricms' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSittricmsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodServs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodServsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTptribs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTptribsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarMoedaEstimada' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarMoedaEstimadaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDescSgru()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=473 (diff=441px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=542 (diff=537px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=161 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label24' Top=542 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=58 vs migrado 'lbl_4c_Label24' Left=324 (diff=266px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblAltura' Top=250 (diff=224px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=749 vs migrado 'lbl_4c_LblAltura' Left=881 (diff=132px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (13624 linhas total):

*-- Linhas 51 a 413:
51:     this_cUltTptribs        = ""    && Ultimo tptribs validado
52: 
53:     *-- Guardias para LostFocus de composicao e campos fiscais descritivos
54:     this_cUltimoTabCompo_DescLostFocusValidado    = ""
55:     this_cUltimoTabCompo_MatPLostFocusValidado    = ""
56:     this_cUltimoTabCompo_DesccpLostFocusValidado  = ""
57:     this_cUltimoTabCompo_MatsubLostFocusValidado  = ""
58:     this_cUltimoTabCompo_CmkpcLostFocusValidado   = ""
59:     this_cUltimoTabCompo_MoedaLostFocusValidado   = ""
60:     this_cUltimoTabCompo_FtioLostFocusValidado    = ""
61:     this_cUltimoTabCompo_MoepvLostFocusValidado   = ""
62:     this_cUltimoTabCompo_MoevLostFocusValidado    = ""
63:     this_cUltimoTabCompo_MoecLostFocusValidado    = ""
64:     this_cUltimoTabCompo_MoecusfLostFocusValidado = ""
65:     this_cUltimoValidarDgruccusValidado           = ""
66:     this_cUltimoValidarDcontaccusValidado         = ""
67:     this_cUltimoValidarDclfiscalValidado          = ""
68:     this_cUltimoValidarDorigmercValidado          = ""
69:     this_cUltimoValidarDsittricmsValidado         = ""
70: 
71:     *--------------------------------------------------------------------------
72:     * Init - Inicializacao do formulario
73:     *--------------------------------------------------------------------------
74:     PROCEDURE Init()
75:         RETURN DODEFAULT()
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     * InicializarForm - Configuracao inicial do formulario
80:     *--------------------------------------------------------------------------
81:     PROTECTED PROCEDURE InicializarForm()
82:         LOCAL loc_lSucesso
83:         loc_lSucesso = .F.
84: 
85:         TRY
86:             *-- Guard: evitar loops de SQL durante validacao UI
87:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
88:                 gb_4c_ValidandoUI = .F.
89:             ENDIF
90: 
91:             *-- Criar instancia do Business Object
92:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
93: 
94:             IF ISNULL(THIS.this_oBusinessObject)
95:                 MsgErro("Erro ao criar Business Object ProdutoBO", "FormProduto.InicializarForm")
96:                 loc_lSucesso = .F.
97:             ELSE
98:                 THIS.ConfigurarPageFrame()
99:                 THIS.ConfigurarPaginaLista()
100:                 THIS.ConfigurarPaginaDados()
101:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
102: 
103:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
104:                     IF !THIS.CarregarLista()
105:                         *-- Se falhar ao carregar, nao impede abertura
106:                     ENDIF
107:                 ENDIF
108: 
109:                 THIS.pgf_4c_Paginas.Visible    = .T.
110:                 THIS.pgf_4c_Paginas.ActivePage = 1
111:                 THIS.this_cModoAtual           = "LISTA"
112:                 loc_lSucesso = .T.
113:             ENDIF
114: 
115:         CATCH TO loc_oErro
116:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.InicializarForm")
117:             loc_lSucesso = .F.
118:         ENDTRY
119: 
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarPageFrame - Configura o PageFrame principal (2 paginas)
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarPageFrame()
127:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
128: 
129:         WITH THIS.pgf_4c_Paginas
130:             .Top       = -29
131:             .Left      = 0
132:             .Width     = 1003
133:             .Height    = 660
134:             .PageCount = 2
135:             .Tabs      = .F.
136:             .Visible   = .T.
137: 
138:             .Page1.Caption  = "Lista"
139:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140:             .Page1.BackColor = RGB(255, 255, 255)
141: 
142:             .Page2.Caption  = "Dados"
143:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
144:             .Page2.BackColor = RGB(255, 255, 255)
145:         ENDWITH
146:     ENDPROC
147: 
148:     *--------------------------------------------------------------------------
149:     * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
150:     * Compensacao +29: Top_legado + 29
151:     * Grid legado: Grade top=173, left=38, width=922, height=409
152:     *--------------------------------------------------------------------------
153:     PROTECTED PROCEDURE ConfigurarPaginaLista()
154:         LOCAL loc_oPagina
155:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
156: 
157:         *-- Container cabecalho
158:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
159:         WITH loc_oPagina.cnt_4c_Cabecalho
160:             .Top         = 31
161:             .Left        = 0
162:             .Width       = 1020
163:             .Height      = 80
164:             .BackStyle   = 1
165:             .BackColor   = RGB(53, 53, 53)
166:             .BorderWidth = 0
167:             .Visible     = .T.
168:         ENDWITH
169: 
170:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
171:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
172:             .Caption   = "Cadastro de Produtos"
173:             .Top       = 20
174:             .Left      = 20
175:             .Width     = 400
176:             .Height    = 30
177:             .FontName  = "Tahoma"
178:             .FontSize  = 14
179:             .FontBold  = .T.
180:             .BackStyle = 0
181:             .ForeColor = RGB(255, 255, 255)
182:             .Visible   = .T.
183:         ENDWITH
184: 
185:         *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
186:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
187:         WITH loc_oPagina.cnt_4c_Botoes
188:             .Top         = 29
189:             .Left        = 542
190:             .Width       = 380
191:             .Height      = 85
192:             .BackStyle = 1
193:             .BackColor = RGB(53, 53, 53)
194:             .BorderWidth = 0
195:             .Visible     = .T.
196:         ENDWITH
197: 
198:         *-- Botao Incluir (Left=5)
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
201:             .Caption         = "Incluir"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
203:             .PicturePosition = 13
204:             .Width           = 75
205:             .Height          = 75
206:             .Left            = 5
207:             .Top             = 5
208:             .FontName        = "Tahoma"
209:             .FontSize        = 8
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .BackColor       = RGB(255, 255, 255)
213:             .ForeColor       = RGB(90, 90, 90)
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
217: 
218:         *-- Botao Visualizar (Left=80)
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
221:             .Caption         = "Visualizar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
223:             .PicturePosition = 13
224:             .Width           = 75
225:             .Height          = 75
226:             .Left            = 80
227:             .Top             = 5
228:             .FontName        = "Tahoma"
229:             .FontSize        = 8
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
237: 
238:         *-- Botao Alterar (Left=155)
239:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
240:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
241:             .Caption         = "Alterar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
243:             .PicturePosition = 13
244:             .Width           = 75
245:             .Height          = 75
246:             .Left            = 155
247:             .Top             = 5
248:             .FontName        = "Tahoma"
249:             .FontSize        = 8
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .BackColor       = RGB(255, 255, 255)
253:             .ForeColor       = RGB(90, 90, 90)
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir (Left=230)
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Width           = 75
265:             .Height          = 75
266:             .Left            = 230
267:             .Top             = 5
268:             .FontName        = "Tahoma"
269:             .FontSize        = 8
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .BackColor       = RGB(255, 255, 255)
273:             .ForeColor       = RGB(90, 90, 90)
274:             .Visible         = .T.
275:         ENDWITH
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277: 
278:         *-- Botao Buscar (Left=305)
279:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
281:             .Caption         = "Buscar"
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
283:             .PicturePosition = 13
284:             .Width           = 75
285:             .Height          = 75
286:             .Left            = 305
287:             .Top             = 5
288:             .FontName        = "Tahoma"
289:             .FontSize        = 8
290:             .Themes          = .F.
291:             .SpecialEffect   = 0
292:             .BackColor       = RGB(255, 255, 255)
293:             .ForeColor       = RGB(90, 90, 90)
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container de saida separado (Left=917, Top=29)
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle = 1
306:             .BackColor = RGB(53, 53, 53)
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         *-- Botao Encerrar
312:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
313:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
314:             .Caption         = "Encerrar"
315:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
316:             .PicturePosition = 13
317:             .Width           = 75
318:             .Height          = 75
319:             .Left            = 5
320:             .Top             = 5
321:             .FontName        = "Tahoma"
322:             .FontSize        = 8
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .BackColor       = RGB(255, 255, 255)
326:             .ForeColor       = RGB(90, 90, 90)
327:             .Visible         = .T.
328:         ENDWITH
329:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
330: 
331:         *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
332:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
333:         WITH loc_oPagina.cnt_4c_Filtros
334:             .Top         = 120
335:             .Left        = 12
336:             .Width       = 940
337:             .Height      = 55
338:             .BackStyle   = 0
339:             .BorderWidth = 0
340:             .Visible     = .T.
341:         ENDWITH
342: 
343:         *-- Filtro: Label Grupo
344:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
345:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
346:             .Caption   = "Grupo:"
347:             .Left      = 5
348:             .Top       = 8
349:             .Width     = 40
350:             .Height    = 15
351:             .FontName  = "Tahoma"
352:             .FontSize  = 8
353:             .BackStyle = 0
354:             .ForeColor = RGB(90, 90, 90)
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         *-- Filtro: Codigo do grupo
359:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
360:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
361:             .Value         = ""
362:             .Left          = 47
363:             .Top           = 3
364:             .Width         = 35
365:             .Height        = 22
366:             .FontName      = "Tahoma"
367:             .FontSize      = 8
368:             .SpecialEffect = 1
369:             .MaxLength     = 3
370:             .Visible       = .T.
371:         ENDWITH
372:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "FiltroGrupo_KeyPress")
373:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "LostFocus", THIS, "ValidarFiltroGrupo")
374: 
375:         *-- Filtro: Descricao do grupo (leitura)
376:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
377:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
378:             .Value         = ""
379:             .Left          = 84
380:             .Top           = 3
381:             .Width         = 156
382:             .Height        = 22
383:             .FontName      = "Tahoma"
384:             .FontSize      = 8
385:             .SpecialEffect = 1
386:             .ReadOnly      = .T.
387:             .Enabled       = .F.
388:             .Visible       = .T.
389:         ENDWITH
390: 
391:         *-- Filtro: Label Ultima alteracao
392:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
393:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
394:             .Caption   = "Ult. Alt.:"
395:             .Left      = 248
396:             .Top       = 8
397:             .Width     = 52
398:             .Height    = 15
399:             .FontName  = "Tahoma"
400:             .FontSize  = 8
401:             .BackStyle = 0
402:             .ForeColor = RGB(90, 90, 90)
403:             .Visible   = .T.
404:         ENDWITH
405: 
406:         *-- Filtro: Data Inicio
407:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
408:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
409:             .Value         = {}
410:             .Left          = 302
411:             .Top           = 3
412:             .Width         = 80
413:             .Height        = 22

*-- Linhas 447 a 645:
447:         ENDWITH
448: 
449:         *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
450:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
451:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
452:             .Left        = 500
453:             .Top         = 3
454:             .Width       = 200
455:             .Height      = 25
456:             .ButtonCount = 3
457:             .BorderStyle = 0
458:             .Themes      = .F.
459:             .Value       = 1
460:             .Visible     = .T.
461:         ENDWITH
462:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
463:             .Buttons(1).Caption   = "Todos"
464:             .Buttons(1).Left      = 0
465:             .Buttons(1).Top       = 0
466:             .Buttons(1).AutoSize  = .T.
467:             .Buttons(1).Themes    = .F.
468:             .Buttons(1).FontName  = "Tahoma"
469:             .Buttons(1).FontSize  = 8
470:             .Buttons(2).Caption   = "Ativos"
471:             .Buttons(2).Left      = 65
472:             .Buttons(2).Top       = 0
473:             .Buttons(2).AutoSize  = .T.
474:             .Buttons(2).Themes    = .F.
475:             .Buttons(2).FontName  = "Tahoma"
476:             .Buttons(2).FontSize  = 8
477:             .Buttons(3).Caption   = "Inativos"
478:             .Buttons(3).Left      = 130
479:             .Buttons(3).Top       = 0
480:             .Buttons(3).AutoSize  = .T.
481:             .Buttons(3).Themes    = .F.
482:             .Buttons(3).FontName  = "Tahoma"
483:             .Buttons(3).FontSize  = 8
484:         ENDWITH
485:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")
486: 
487:         *-- Botao Pesquisar
488:         loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
489:         WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
490:             .Caption         = "Pesquisar"
491:             .Left            = 708
492:             .Top             = 2
493:             .Width           = 75
494:             .Height          = 22
495:             .FontName        = "Tahoma"
496:             .FontSize        = 8
497:             .Themes          = .F.
498:             .SpecialEffect   = 0
499:             .BackColor       = RGB(255, 255, 255)
500:             .ForeColor       = RGB(90, 90, 90)
501:             .Visible         = .T.
502:         ENDWITH
503:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")
504: 
505:         *-- Label contador de produtos (legado: lblProdutos top=584)
506:         loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
507:         WITH loc_oPagina.lbl_4c_ContadorProdutos
508:             .Caption   = "0 produto(s)"
509:             .Top       = 583
510:             .Left      = 38
511:             .Width     = 200
512:             .Height    = 15
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .BackStyle = 0
516:             .ForeColor = RGB(90, 90, 90)
517:             .Visible   = .T.
518:         ENDWITH
519: 
520:         *-- Grid de lista (Grade: top=173, left=38, width=922, height=409)
521:         *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
522:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
523:         WITH loc_oPagina.grd_4c_Lista
524:             .Top               = 182
525:             .Left              = 12
526:             .Width             = 940
527:             .Height            = 395
528:             .ReadOnly          = .T.
529:             .DeleteMark        = .F.
530:             .RecordMark        = .F.
531:             .ScrollBars        = 3
532:             .GridLines         = 3
533:             .ColumnCount       = 7
534:             .AllowHeaderSizing = .T.
535:             .Visible           = .T.
536:         ENDWITH
537:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
538: 
539:         THIS.TornarControlesVisiveis(loc_oPagina)
540:     ENDPROC
541: 
542:     *--------------------------------------------------------------------------
543:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
544:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54
545:     *--------------------------------------------------------------------------
546:     PROTECTED PROCEDURE ConfigurarPaginaDados()
547:         LOCAL loc_oPagina
548:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
549: 
550:         *-- Container de botoes Salvar/Cancelar (Top=34, Left=819)
551:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
552:         WITH loc_oPagina.cnt_4c_BotoesDados
553:             .Top         = 34
554:             .Left        = 819
555:             .Width       = 165
556:             .Height      = 85
557:             .BackStyle = 1
558:             .BackColor = RGB(53, 53, 53)
559:             .BorderWidth = 0
560:             .Visible     = .T.
561:         ENDWITH
562: 
563:         *-- Botao Salvar (Left=7, Top=5)
564:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
565:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
566:             .Caption         = "Salvar"
567:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
568:             .PicturePosition = 13
569:             .Width           = 75
570:             .Height          = 75
571:             .Left            = 7
572:             .Top             = 5
573:             .FontName        = "Tahoma"
574:             .FontSize        = 8
575:             .Themes          = .F.
576:             .SpecialEffect   = 0
577:             .BackColor       = RGB(255, 255, 255)
578:             .ForeColor       = RGB(90, 90, 90)
579:             .Visible         = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
582: 
583:         *-- Botao Cancelar (Left=83, Top=5)
584:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
585:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
586:             .Caption         = "Cancelar"
587:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
588:             .PicturePosition = 13
589:             .Width           = 75
590:             .Height          = 75
591:             .Left            = 83
592:             .Top             = 5
593:             .FontName        = "Tahoma"
594:             .FontSize        = 8
595:             .Themes          = .F.
596:             .SpecialEffect   = 0
597:             .BackColor       = RGB(255, 255, 255)
598:             .ForeColor       = RGB(90, 90, 90)
599:             .Visible         = .T.
600:         ENDWITH
601:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
602: 
603:         *-- OptionGroup para navegacao entre abas internas
604:         *-- Legado: Optiongroup1 top=5->34, left=5, width=535, height=85, buttonCount=7
605:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
606:         WITH loc_oPagina.opt_4c_Abas
607:             .Left        = 5
608:             .Top         = 34
609:             .Width       = 800
610:             .Height      = 85
611:             .ButtonCount = 7
612:             .BorderStyle = 0
613:             .Themes      = .F.
614:             .Value       = 1
615:             .Visible     = .T.
616:         ENDWITH
617:         WITH loc_oPagina.opt_4c_Abas
618:             .Buttons(1).Caption   = "Principal"
619:             .Buttons(1).Left      = 0
620:             .Buttons(1).Top       = 25
621:             .Buttons(1).Width     = 85
622:             .Buttons(1).Height    = 30
623:             .Buttons(1).Themes    = .F.
624:             .Buttons(1).FontName  = "Tahoma"
625:             .Buttons(1).FontSize  = 8
626:             .Buttons(1).ForeColor = RGB(50, 50, 50)
627:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
628:             .Buttons(2).Left      = 90
629:             .Buttons(2).Top       = 25
630:             .Buttons(2).Width     = 90
631:             .Buttons(2).Height    = 30
632:             .Buttons(2).Themes    = .F.
633:             .Buttons(2).FontName  = "Tahoma"
634:             .Buttons(2).FontSize  = 8
635:             .Buttons(2).ForeColor = RGB(50, 50, 50)
636:             .Buttons(3).Caption   = "Custos"
637:             .Buttons(3).Left      = 185
638:             .Buttons(3).Top       = 25
639:             .Buttons(3).Width     = 75
640:             .Buttons(3).Height    = 30
641:             .Buttons(3).Themes    = .F.
642:             .Buttons(3).FontName  = "Tahoma"
643:             .Buttons(3).FontSize  = 8
644:             .Buttons(3).ForeColor = RGB(50, 50, 50)
645:             .Buttons(4).Caption   = "Dados Fiscais"

*-- Linhas 679 a 771:
679:             .Buttons(7).FontSize  = 8
680:             .Buttons(7).ForeColor = RGB(50, 50, 50)
681:         ENDWITH
682:         BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OpcaoAbasChange")
683: 
684:         *-- PageFrame interno (pgframeDados legado: top=-54, left=-1, width=1003, height=656)
685:         *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
686:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
687:         WITH loc_oPagina.pgf_4c_Dados
688:             .Top       = -54
689:             .Left      = -1
690:             .Width     = 1003
691:             .Height    = 685
692:             .PageCount = 7
693:             .Tabs      = .F.
694:             .Visible   = .T.
695: 
696:             .Page1.Caption  = "Principal"
697:             .Page1.BackColor = RGB(255, 255, 255)
698:             .Page2.Caption  = "Composicao"
699:             .Page2.BackColor = RGB(255, 255, 255)
700:             .Page3.Caption  = "Custos"
701:             .Page3.BackColor = RGB(255, 255, 255)
702:             .Page4.Caption  = "Dados Fiscais"
703:             .Page4.BackColor = RGB(255, 255, 255)
704:             .Page5.Caption  = "Designer"
705:             .Page5.BackColor = RGB(255, 255, 255)
706:             .Page6.Caption  = "Consulta"
707:             .Page6.BackColor = RGB(255, 255, 255)
708:             .Page7.Caption  = "Fases"
709:             .Page7.BackColor = RGB(255, 255, 255)
710:         ENDWITH
711: 
712:         *-- Configurar conteudo de cada aba
713:         THIS.ConfigurarTabPrincipal()
714:         THIS.ConfigurarTabComposicao()
715:         THIS.ConfigurarTabCustos()
716:         THIS.ConfigurarTabDadosFiscais()
717:         THIS.ConfigurarPgpgDadosFiscais()
718:         THIS.ConfigurarTabDesigner()
719:         THIS.ConfigurarPgpgDesigner()
720:         THIS.ConfigurarTabConsulta()
721:         THIS.ConfigurarTabFases()
722: 
723:         THIS.TornarControlesVisiveis(loc_oPagina)
724:     ENDPROC
725: 
726:     *--------------------------------------------------------------------------
727:     * ConfigurarTabPrincipal - Aba 1: Dados principais do produto (pgDados)
728:     * Legado: pgframeDados.pgDados (167 controles)
729:     * Posicoes direto do layout.json (sem compensacao - dentro de pgf_4c_Dados)
730:     *--------------------------------------------------------------------------
731:     PROTECTED PROCEDURE ConfigurarTabPrincipal()
732:         LOCAL loc_oPg
733:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
734: 
735:         *-- === CODIGO e DESCRICAO =============================================
736: 
737:         loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
738:         WITH loc_oPg.lbl_4c_LblCpros
739:             .Caption = "Produto :"
740:             .Top = 134
741:             .Left = 58
742:             .Width = 53
743:             .Height = 15
744:             .FontName = "Tahoma"
745:             .FontSize = 8
746:             .BackStyle = 0
747:             .ForeColor = RGB(90,90,90)
748:         ENDWITH
749: 
750:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
751:         WITH loc_oPg.txt_4c_Cpros
752:             .Value = ""
753:             .Top = 130
754:             .Left = 113
755:             .Width = 108
756:             .Height = 23
757:             .FontName = "Tahoma"
758:             .FontSize = 8
759:             .SpecialEffect = 1
760:             .MaxLength = 14
761:         ENDWITH
762: 
763:         loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
764:         WITH loc_oPg.lbl_4c_LblDpros
765:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
766:             .Top = 134
767:             .Left = 222
768:             .Width = 70
769:             .Height = 15
770:             .FontName = "Tahoma"
771:             .FontSize = 8

*-- Linhas 839 a 883:
839:             .SpecialEffect = 1
840:             .MaxLength = 3
841:         ENDWITH
842:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruKeyPress")
843:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "LostFocus", THIS, "TabPrincipal_CgruLostFocus")
844: 
845:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
846:         WITH loc_oPg.txt_4c_Dgrus
847:             .Value = ""
848:             .Top = 178
849:             .Left = 145
850:             .Width = 171
851:             .Height = 23
852:             .FontName = "Tahoma"
853:             .FontSize = 8
854:             .SpecialEffect = 1
855:             .ReadOnly = .T.
856:             .Enabled = .F.
857:         ENDWITH
858: 
859:         loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
860:         WITH loc_oPg.lbl_4c_LblSgrus
861:             .Caption = "Subgrupo :"
862:             .Top = 206
863:             .Left = 56
864:             .Width = 55
865:             .Height = 15
866:             .FontName = "Tahoma"
867:             .FontSize = 8
868:             .BackStyle = 0
869:             .ForeColor = RGB(90,90,90)
870:         ENDWITH
871: 
872:         loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
873:         WITH loc_oPg.txt_4c_Csgrus
874:             .Value = ""
875:             .Top = 202
876:             .Left = 113
877:             .Width = 52
878:             .Height = 23
879:             .FontName = "Tahoma"
880:             .FontSize = 8
881:             .SpecialEffect = 1
882:             .MaxLength = 6
883:         ENDWITH

*-- Linhas 923 a 1053:
923:             .SpecialEffect = 1
924:             .MaxLength = 10
925:         ENDWITH
926:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasKeyPress")
927:         BINDEVENT(loc_oPg.txt_4c_Linhas, "LostFocus", THIS, "TabPrincipal_LinhasLostFocus")
928: 
929:         loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
930:         WITH loc_oPg.txt_4c_Dlinhas
931:             .Value = ""
932:             .Top = 226
933:             .Left = 194
934:             .Width = 318
935:             .Height = 23
936:             .FontName = "Tahoma"
937:             .FontSize = 8
938:             .SpecialEffect = 1
939:             .ReadOnly = .T.
940:             .Enabled = .F.
941:         ENDWITH
942: 
943:         loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
944:         WITH loc_oPg.lbl_4c_LblColecoes
945:             .Caption = "Grupo de Venda :"
946:             .Top = 253
947:             .Left = 25
948:             .Width = 86
949:             .Height = 15
950:             .FontName = "Tahoma"
951:             .FontSize = 8
952:             .BackStyle = 0
953:             .ForeColor = RGB(90,90,90)
954:         ENDWITH
955: 
956:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
957:         WITH loc_oPg.txt_4c_Colecoes
958:             .Value = ""
959:             .Top = 250
960:             .Left = 113
961:             .Width = 80
962:             .Height = 23
963:             .FontName = "Tahoma"
964:             .FontSize = 8
965:             .SpecialEffect = 1
966:             .MaxLength = 10
967:         ENDWITH
968:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesKeyPress")
969:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "LostFocus", THIS, "TabPrincipal_ColecoesLostFocus")
970: 
971:         loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
972:         WITH loc_oPg.txt_4c_Dcolecoes
973:             .Value = ""
974:             .Top = 250
975:             .Left = 194
976:             .Width = 318
977:             .Height = 23
978:             .FontName = "Tahoma"
979:             .FontSize = 8
980:             .SpecialEffect = 1
981:             .ReadOnly = .T.
982:             .Enabled = .F.
983:         ENDWITH
984: 
985:         *-- === FORNECEDOR / REF ==============================================
986: 
987:         loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
988:         WITH loc_oPg.lbl_4c_LblIfors
989:             .Caption = "Fornecedor :"
990:             .Top = 278
991:             .Left = 47
992:             .Width = 64
993:             .Height = 15
994:             .FontName = "Tahoma"
995:             .FontSize = 8
996:             .BackStyle = 0
997:             .ForeColor = RGB(90,90,90)
998:         ENDWITH
999: 
1000:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
1001:         WITH loc_oPg.txt_4c_Ifors
1002:             .Value = ""
1003:             .Top = 274
1004:             .Left = 113
1005:             .Width = 80
1006:             .Height = 23
1007:             .FontName = "Tahoma"
1008:             .FontSize = 8
1009:             .SpecialEffect = 1
1010:             .MaxLength = 10
1011:         ENDWITH
1012:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsKeyPress")
1013:         BINDEVENT(loc_oPg.txt_4c_Ifors, "LostFocus", THIS, "TabPrincipal_IforsLostFocus")
1014: 
1015:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
1016:         WITH loc_oPg.txt_4c_Dfors
1017:             .Value = ""
1018:             .Top = 274
1019:             .Left = 194
1020:             .Width = 318
1021:             .Height = 23
1022:             .FontName = "Tahoma"
1023:             .FontSize = 8
1024:             .SpecialEffect = 1
1025:             .ReadOnly = .T.
1026:             .Enabled = .F.
1027:         ENDWITH
1028: 
1029:         loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
1030:         WITH loc_oPg.lbl_4c_LblReffs
1031:             .Caption = "Ref. Fornecedor :"
1032:             .Top = 301
1033:             .Left = 23
1034:             .Width = 88
1035:             .Height = 15
1036:             .FontName = "Tahoma"
1037:             .FontSize = 8
1038:             .BackStyle = 0
1039:             .ForeColor = RGB(90,90,90)
1040:         ENDWITH
1041: 
1042:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1043:         WITH loc_oPg.txt_4c_Reffs
1044:             .Value = ""
1045:             .Top = 298
1046:             .Left = 113
1047:             .Width = 152
1048:             .Height = 23
1049:             .FontName = "Tahoma"
1050:             .FontSize = 8
1051:             .SpecialEffect = 1
1052:             .MaxLength = 40
1053:         ENDWITH

*-- Linhas 1159 a 1202:
1159:             .SpecialEffect = 1
1160:             .MaxLength = 14
1161:         ENDWITH
1162:         BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")
1163: 
1164:         loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
1165:         WITH loc_oPg.lbl_4c_LblCbars
1166:             .Caption = "Barra :"
1167:             .Top = 157
1168:             .Left = 590
1169:             .Width = 35
1170:             .Height = 15
1171:             .FontName = "Tahoma"
1172:             .FontSize = 8
1173:             .BackStyle = 0
1174:             .ForeColor = RGB(90,90,90)
1175:         ENDWITH
1176: 
1177:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
1178:         WITH loc_oPg.txt_4c_Cbars
1179:             .Value = 0
1180:             .Top = 155
1181:             .Left = 626
1182:             .Width = 108
1183:             .Height = 21
1184:             .FontName = "Tahoma"
1185:             .FontSize = 8
1186:             .SpecialEffect = 1
1187:         ENDWITH
1188: 
1189:         loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
1190:         WITH loc_oPg.lbl_4c_LblEan13
1191:             .Caption = "EAN/GTIN :"
1192:             .Top = 181
1193:             .Left = 568
1194:             .Width = 57
1195:             .Height = 15
1196:             .FontName = "Tahoma"
1197:             .FontSize = 8
1198:             .BackStyle = 0
1199:             .ForeColor = RGB(90,90,90)
1200:         ENDWITH
1201: 
1202:         loc_oPg.AddObject("txt_4c_Ean13", "TextBox")

*-- Linhas 1213 a 1283:
1213: 
1214:         *-- === SITUACAO / DATA SITUACAO ======================================
1215: 
1216:         loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
1217:         WITH loc_oPg.opt_4c_Situas
1218:             .Top = 130
1219:             .Left = 735
1220:             .Width = 142
1221:             .Height = 25
1222:             .ButtonCount = 2
1223:             .BorderStyle = 0
1224:             .Themes = .F.
1225:             .Value = 1
1226:         ENDWITH
1227:         WITH loc_oPg.opt_4c_Situas
1228:             .Buttons(1).Caption = "Ativo"
1229:             .Buttons(1).Left = 0
1230:             .Buttons(1).Top = 0
1231:             .Buttons(1).AutoSize = .T.
1232:             .Buttons(1).Themes = .F.
1233:             .Buttons(1).FontName = "Tahoma"
1234:             .Buttons(1).FontSize = 8
1235:             .Buttons(2).Caption = "Inativo"
1236:             .Buttons(2).Left = 60
1237:             .Buttons(2).Top = 0
1238:             .Buttons(2).AutoSize = .T.
1239:             .Buttons(2).Themes = .F.
1240:             .Buttons(2).FontName = "Tahoma"
1241:             .Buttons(2).FontSize = 8
1242:         ENDWITH
1243:         BINDEVENT(loc_oPg.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
1244: 
1245:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1246:         WITH loc_oPg.txt_4c_DtSituas
1247:             .Value = {}
1248:             .Top = 132
1249:             .Left = 878
1250:             .Width = 80
1251:             .Height = 21
1252:             .FontName = "Tahoma"
1253:             .FontSize = 8
1254:             .SpecialEffect = 1
1255:             .ReadOnly = .T.
1256:             .Enabled = .F.
1257:         ENDWITH
1258: 
1259:         *-- === LOTE MINIMO ===================================================
1260: 
1261:         loc_oPg.AddObject("lbl_4c_LblLtmins", "Label")
1262:         WITH loc_oPg.lbl_4c_LblLtmins
1263:             .Caption = "Lote M" + CHR(237) + "nimo :"
1264:             .Top = 157
1265:             .Left = 812
1266:             .Width = 65
1267:             .Height = 15
1268:             .FontName = "Tahoma"
1269:             .FontSize = 8
1270:             .BackStyle = 0
1271:             .ForeColor = RGB(90,90,90)
1272:         ENDWITH
1273: 
1274:         loc_oPg.AddObject("txt_4c_Ltminsv", "TextBox")
1275:         WITH loc_oPg.txt_4c_Ltminsv
1276:             .Value = 0
1277:             .Top = 154
1278:             .Left = 878
1279:             .Width = 80
1280:             .Height = 21
1281:             .FontName = "Tahoma"
1282:             .FontSize = 8
1283:             .SpecialEffect = 1

*-- Linhas 1575 a 1659:
1575:             .SpecialEffect = 1
1576:             .MaxLength = 3
1577:         ENDWITH
1578:         BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1579:         BINDEVENT(loc_oPg.txt_4c_Moecs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1580: 
1581:         loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
1582:         WITH loc_oPg.lbl_4c_LblPvens
1583:             .Caption = "Valor de Venda :"
1584:             .Top = 400
1585:             .Left = 505
1586:             .Width = 120
1587:             .Height = 15
1588:             .FontName = "Tahoma"
1589:             .FontSize = 8
1590:             .BackStyle = 0
1591:             .ForeColor = RGB(90,90,90)
1592:         ENDWITH
1593: 
1594:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1595:         WITH loc_oPg.txt_4c_Pvens
1596:             .Value = 0
1597:             .Top = 397
1598:             .Left = 626
1599:             .Width = 127
1600:             .Height = 21
1601:             .FontName = "Tahoma"
1602:             .FontSize = 8
1603:             .SpecialEffect = 1
1604:         ENDWITH
1605: 
1606:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1607:         WITH loc_oPg.txt_4c_Moepvs
1608:             .Value = ""
1609:             .Top = 397
1610:             .Left = 754
1611:             .Width = 31
1612:             .Height = 21
1613:             .FontName = "Tahoma"
1614:             .FontSize = 8
1615:             .SpecialEffect = 1
1616:             .MaxLength = 3
1617:         ENDWITH
1618:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1619:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1620: 
1621:         loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
1622:         WITH loc_oPg.lbl_4c_LblFvendas
1623:             .Caption = "Fator  de Venda :"
1624:             .Top = 422
1625:             .Left = 539
1626:             .Width = 86
1627:             .Height = 15
1628:             .FontName = "Tahoma"
1629:             .FontSize = 8
1630:             .BackStyle = 0
1631:             .ForeColor = RGB(90,90,90)
1632:         ENDWITH
1633: 
1634:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1635:         WITH loc_oPg.txt_4c_Fvendas
1636:             .Value = 0
1637:             .Top = 419
1638:             .Left = 626
1639:             .Width = 127
1640:             .Height = 21
1641:             .FontName = "Tahoma"
1642:             .FontSize = 8
1643:             .SpecialEffect = 1
1644:         ENDWITH
1645: 
1646:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1647:         WITH loc_oPg.txt_4c_Moevs
1648:             .Value = ""
1649:             .Top = 419
1650:             .Left = 754
1651:             .Width = 31
1652:             .Height = 21
1653:             .FontName = "Tahoma"
1654:             .FontSize = 8
1655:             .SpecialEffect = 1
1656:             .MaxLength = 3
1657:         ENDWITH
1658: 
1659:         *-- === AUDITORIA (ReadOnly) ==========================================

*-- Linhas 1780 a 1866:
1780:             .SpecialEffect = 1
1781:             .MaxLength = 3
1782:         ENDWITH
1783:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisKeyPress")
1784:         BINDEVENT(loc_oPg.txt_4c_Cunis, "LostFocus", THIS, "TabPrincipal_CunisLostFocus")
1785: 
1786:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1787:         WITH loc_oPg.txt_4c_Dunis
1788:             .Value = ""
1789:             .Top = 394
1790:             .Left = 145
1791:             .Width = 150
1792:             .Height = 23
1793:             .FontName = "Tahoma"
1794:             .FontSize = 8
1795:             .SpecialEffect = 1
1796:             .ReadOnly = .T.
1797:             .Enabled = .F.
1798:         ENDWITH
1799: 
1800:         loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
1801:         WITH loc_oPg.lbl_4c_LblCunips
1802:             .Caption = "(2) :"
1803:             .Top = 398
1804:             .Left = 301
1805:             .Width = 23
1806:             .Height = 15
1807:             .FontName = "Tahoma"
1808:             .FontSize = 8
1809:             .BackStyle = 0
1810:             .ForeColor = RGB(90,90,90)
1811:         ENDWITH
1812: 
1813:         loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
1814:         WITH loc_oPg.txt_4c_Cunips
1815:             .Value = ""
1816:             .Top = 394
1817:             .Left = 330
1818:             .Width = 31
1819:             .Height = 23
1820:             .FontName = "Tahoma"
1821:             .FontSize = 8
1822:             .SpecialEffect = 1
1823:             .MaxLength = 3
1824:         ENDWITH
1825:         BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsKeyPress")
1826:         BINDEVENT(loc_oPg.txt_4c_Cunips, "LostFocus", THIS, "TabPrincipal_CunipsLostFocus")
1827: 
1828:         loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
1829:         WITH loc_oPg.txt_4c_Dunips
1830:             .Value = ""
1831:             .Top = 394
1832:             .Left = 362
1833:             .Width = 150
1834:             .Height = 23
1835:             .FontName = "Tahoma"
1836:             .FontSize = 8
1837:             .SpecialEffect = 1
1838:             .ReadOnly = .T.
1839:             .Enabled = .F.
1840:         ENDWITH
1841: 
1842:         *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================
1843: 
1844:         loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
1845:         WITH loc_oPg.lbl_4c_LblCclass
1846:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
1847:             .Top = 374
1848:             .Left = 7
1849:             .Width = 104
1850:             .Height = 15
1851:             .FontName = "Tahoma"
1852:             .FontSize = 8
1853:             .BackStyle = 0
1854:             .ForeColor = RGB(90,90,90)
1855:         ENDWITH
1856: 
1857:         loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
1858:         WITH loc_oPg.txt_4c_Cclass
1859:             .Value = ""
1860:             .Top = 370
1861:             .Left = 113
1862:             .Width = 31
1863:             .Height = 23
1864:             .FontName = "Tahoma"
1865:             .FontSize = 8
1866:             .SpecialEffect = 1

*-- Linhas 1946 a 1990:
1946:             .SpecialEffect = 1
1947:             .MaxLength = 3
1948:         ENDWITH
1949:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsKeyPress")
1950:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "LostFocus", THIS, "TabPrincipal_CodacbsLostFocus")
1951: 
1952:         loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
1953:         WITH loc_oPg.txt_4c_Dcodacbs
1954:             .Value = ""
1955:             .Top = 346
1956:             .Left = 145
1957:             .Width = 150
1958:             .Height = 23
1959:             .FontName = "Tahoma"
1960:             .FontSize = 8
1961:             .SpecialEffect = 1
1962:             .ReadOnly = .T.
1963:             .Enabled = .F.
1964:         ENDWITH
1965: 
1966:         loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
1967:         WITH loc_oPg.lbl_4c_LblLocals
1968:             .Caption = "Local :"
1969:             .Top = 374
1970:             .Left = 364
1971:             .Width = 33
1972:             .Height = 15
1973:             .FontName = "Tahoma"
1974:             .FontSize = 8
1975:             .BackStyle = 0
1976:             .ForeColor = RGB(90,90,90)
1977:         ENDWITH
1978: 
1979:         loc_oPg.AddObject("txt_4c_Locals", "TextBox")
1980:         WITH loc_oPg.txt_4c_Locals
1981:             .Value = ""
1982:             .Top = 370
1983:             .Left = 401
1984:             .Width = 111
1985:             .Height = 23
1986:             .FontName = "Tahoma"
1987:             .FontSize = 8
1988:             .SpecialEffect = 1
1989:             .MaxLength = 10
1990:         ENDWITH

*-- Linhas 2066 a 2137:
2066:             .SpecialEffect = 1
2067:             .MaxLength = 4
2068:         ENDWITH
2069:         BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
2070:         BINDEVENT(loc_oPg.txt_4c_Codcors, "LostFocus", THIS, "TabPrincipal_CodcorsLostFocus")
2071: 
2072:         loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
2073:         WITH loc_oPg.lbl_4c_LblCodtams
2074:             .Caption = "Tam:"
2075:             .Top = 302
2076:             .Left = 442
2077:             .Width = 30
2078:             .Height = 15
2079:             .FontName = "Tahoma"
2080:             .FontSize = 8
2081:             .BackStyle = 0
2082:             .ForeColor = RGB(90,90,90)
2083:         ENDWITH
2084: 
2085:         loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
2086:         WITH loc_oPg.txt_4c_Codtams
2087:             .Value = ""
2088:             .Top = 298
2089:             .Left = 474
2090:             .Width = 38
2091:             .Height = 23
2092:             .FontName = "Tahoma"
2093:             .FontSize = 8
2094:             .SpecialEffect = 1
2095:             .MaxLength = 4
2096:         ENDWITH
2097:         BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")
2098: 
2099:         loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
2100:         WITH loc_oPg.lbl_4c_LblCodident
2101:             .Caption = "Cod. Identidade :"
2102:             .Top = 422
2103:             .Left = 24
2104:             .Width = 87
2105:             .Height = 15
2106:             .FontName = "Tahoma"
2107:             .FontSize = 8
2108:             .BackStyle = 0
2109:             .ForeColor = RGB(90,90,90)
2110:         ENDWITH
2111: 
2112:         loc_oPg.AddObject("txt_4c_Codident", "TextBox")
2113:         WITH loc_oPg.txt_4c_Codident
2114:             .Value = ""
2115:             .Top = 418
2116:             .Left = 113
2117:             .Width = 182
2118:             .Height = 23
2119:             .FontName = "Tahoma"
2120:             .FontSize = 8
2121:             .SpecialEffect = 1
2122:             .MaxLength = 20
2123:         ENDWITH
2124: 
2125:         *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================
2126: 
2127:         loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
2128:         WITH loc_oPg.lbl_4c_LblDiasgar
2129:             .Caption = "Garantia :"
2130:             .Top = 228
2131:             .Left = 827
2132:             .Width = 50
2133:             .Height = 15
2134:             .FontName = "Tahoma"
2135:             .FontSize = 8
2136:             .BackStyle = 0
2137:             .ForeColor = RGB(90,90,90)

*-- Linhas 2188 a 2314:
2188:             .ForeColor = RGB(90,90,90)
2189:         ENDWITH
2190: 
2191:         loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
2192:         WITH loc_oPg.opt_4c_ProdWeb
2193:             .Top = 172
2194:             .Left = 879
2195:             .Width = 117
2196:             .Height = 42
2197:             .ButtonCount = 4
2198:             .BorderStyle = 0
2199:             .Themes = .F.
2200:             .Value = 1
2201:         ENDWITH
2202:         WITH loc_oPg.opt_4c_ProdWeb
2203:             .Buttons(1).Caption = "N" + CHR(227) + "o"
2204:             .Buttons(1).Left = 0 
2205:             .Buttons(1).Top = 0
2206:             .Buttons(1).AutoSize = .T.
2207:             .Buttons(1).Themes = .F.
2208:             .Buttons(1).FontName = "Tahoma"
2209:             .Buttons(1).FontSize = 8
2210:             .Buttons(2).Caption = "Sim"  
2211:             .Buttons(2).Left = 35
2212:             .Buttons(2).Top = 0
2213:             .Buttons(2).AutoSize = .T.
2214:             .Buttons(2).Themes = .F.
2215:             .Buttons(2).FontName = "Tahoma"
2216:             .Buttons(2).FontSize = 8
2217:             .Buttons(3).Caption = "Img"  
2218:             .Buttons(3).Left = 65
2219:             .Buttons(3).Top = 0
2220:             .Buttons(3).AutoSize = .T.
2221:             .Buttons(3).Themes = .F.
2222:             .Buttons(3).FontName = "Tahoma"
2223:             .Buttons(3).FontSize = 8
2224:             .Buttons(4).Caption = "Sim+Img"
2225:             .Buttons(4).Left = 0
2226:             .Buttons(4).Top = 22
2227:             .Buttons(4).AutoSize = .T.
2228:             .Buttons(4).Themes = .F.
2229:             .Buttons(4).FontName = "Tahoma"
2230:             .Buttons(4).FontSize = 8
2231:         ENDWITH
2232:         BINDEVENT(loc_oPg.opt_4c_ProdWeb, "InteractiveChange", THIS, "OptProdWebChange")
2233: 
2234:         loc_oPg.AddObject("lbl_4c_LblVariacao", "Label")
2235:         WITH loc_oPg.lbl_4c_LblVariacao
2236:             .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
2237:             .Top = 207
2238:             .Left = 827
2239:             .Width = 50
2240:             .Height = 15
2241:             .FontName = "Tahoma"
2242:             .FontSize = 8
2243:             .BackStyle = 0
2244:             .ForeColor = RGB(90,90,90)
2245:         ENDWITH
2246: 
2247:         loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
2248:         WITH loc_oPg.opt_4c_Varias
2249:             .Top = 203
2250:             .Left = 874
2251:             .Width = 107
2252:             .Height = 22
2253:             .ButtonCount = 2
2254:             .BorderStyle = 0
2255:             .Themes = .F.
2256:             .Value = 2
2257:         ENDWITH
2258:         WITH loc_oPg.opt_4c_Varias
2259:             .Buttons(1).Caption = "Sim"        
2260:             .Buttons(1).Left = 0 
2261:             .Buttons(1).Top = 0
2262:             .Buttons(1).AutoSize = .T.
2263:             .Buttons(1).Themes = .F.
2264:             .Buttons(1).FontName = "Tahoma"
2265:             .Buttons(1).FontSize = 8
2266:             .Buttons(2).Caption = "N" + CHR(227) + "o"
2267:             .Buttons(2).Left = 42
2268:             .Buttons(2).Top = 0
2269:             .Buttons(2).AutoSize = .T.
2270:             .Buttons(2).Themes = .F.
2271:             .Buttons(2).FontName = "Tahoma"
2272:             .Buttons(2).FontSize = 8
2273:         ENDWITH
2274:         BINDEVENT(loc_oPg.opt_4c_Varias, "InteractiveChange", THIS, "OptVariasChange")
2275: 
2276:         *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =
2277: 
2278:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
2279:         WITH loc_oPg.lbl_4c_LblAltura
2280:             .Caption = "Altura :"
2281:             .Top = 250
2282:             .Left = 881
2283:             .Width = 38
2284:             .Height = 15
2285:             .FontName = "Tahoma"
2286:             .FontSize = 8
2287:             .BackStyle = 0
2288:             .ForeColor = RGB(90,90,90)
2289:         ENDWITH
2290:         loc_oPg.AddObject("txt_4c_Altura", "TextBox")
2291:         WITH loc_oPg.txt_4c_Altura
2292:             .Value = 0
2293:             .Top = 247
2294:             .Left = 923
2295:             .Width = 48
2296:             .Height = 21
2297:             .FontName = "Tahoma"
2298:             .FontSize = 8
2299:             .SpecialEffect = 1
2300:         ENDWITH
2301:         loc_oPg.AddObject("lbl_4c_MmAltura", "Label")
2302:         WITH loc_oPg.lbl_4c_MmAltura
2303:             .Caption = "MM"
2304:             .Top = 251
2305:             .Left = 976
2306:             .Width = 18
2307:             .Height = 15
2308:             .FontName = "Tahoma"
2309:             .FontSize = 8
2310:             .BackStyle = 0
2311:             .ForeColor = RGB(90,90,90)
2312:         ENDWITH
2313: 
2314:         loc_oPg.AddObject("lbl_4c_LblLargura", "Label")

*-- Linhas 2771 a 2814:
2771:     * ConfigurarTabComposicao - Aba 2: Composicao de materiais (pgComposicao)
2772:     * IMPLEMENTADO NA FASE 5
2773:     *--------------------------------------------------------------------------
2774:     PROTECTED PROCEDURE ConfigurarTabComposicao()
2775:         LOCAL loc_oPg
2776:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2777: 
2778:         *-- GradeGRUPO (top=34, left=582, width=229, height=107, 3 cols)
2779:         *-- Mostra totais por grupo de composicao
2780:         loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
2781:         WITH loc_oPg.grd_4c_GrupoCompo
2782:             .Top         = 34
2783:             .Left        = 582
2784:             .Width       = 229
2785:             .Height      = 107
2786:             .ReadOnly    = .T.
2787:             .DeleteMark  = .F.
2788:             .RecordMark  = .F.
2789:             .ScrollBars  = 3
2790:             .GridLines   = 3
2791:             .ColumnCount = 3
2792:             .FontName    = "Verdana"
2793:             .FontSize    = 8
2794:             .Visible     = .T.
2795:         ENDWITH
2796:         WITH loc_oPg.grd_4c_GrupoCompo
2797:             .Column1.Header1.Caption = "Grupo"
2798:             .Column1.Width = 70
2799:             .Column2.Header1.Caption = "Total"
2800:             .Column2.Width = 95
2801:             .Column3.Header1.Caption = "Moe"
2802:             .Column3.Width = 50
2803:         ENDWITH
2804: 
2805:         *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
2806:         *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
2807:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
2808:         WITH loc_oPg.grd_4c_Compo
2809:             .Top         = 148
2810:             .Left        = 6
2811:             .Width       = 943
2812:             .Height      = 147
2813:             .ReadOnly    = .T.
2814:             .DeleteMark  = .F.

*-- Linhas 3179 a 3345:
3179:             .ToolTipText     = "Incluir"
3180:             .Visible         = .T.
3181:         ENDWITH
3182:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")
3183: 
3184:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
3185:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
3186:             .Caption         = "-"
3187:             .Top             = 42
3188:             .Left            = 0
3189:             .Width           = 50
3190:             .Height          = 42
3191:             .FontName        = "Tahoma"
3192:             .FontSize        = 14
3193:             .FontBold        = .T.
3194:             .Themes          = .F.
3195:             .SpecialEffect   = 0
3196:             .BackColor       = RGB(255,255,255)
3197:             .ForeColor       = RGB(180,0,0)
3198:             .ToolTipText     = "Excluir"
3199:             .Visible         = .T.
3200:         ENDWITH
3201:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")
3202: 
3203:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
3204:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
3205:             .Caption         = CHR(8635)
3206:             .Top             = 84
3207:             .Left            = 0
3208:             .Width           = 50
3209:             .Height          = 42
3210:             .FontName        = "Tahoma"
3211:             .FontSize        = 10
3212:             .Themes          = .F.
3213:             .SpecialEffect   = 0
3214:             .BackColor       = RGB(255,255,255)
3215:             .ForeColor       = RGB(0,0,180)
3216:             .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
3217:             .Visible         = .T.
3218:         ENDWITH
3219:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")
3220: 
3221:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
3222:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
3223:             .Caption         = "Kg"
3224:             .Top             = 126
3225:             .Left            = 0
3226:             .Width           = 50
3227:             .Height          = 42
3228:             .FontName        = "Tahoma"
3229:             .FontSize        = 8
3230:             .Themes          = .F.
3231:             .SpecialEffect   = 0
3232:             .BackColor       = RGB(255,255,255)
3233:             .ForeColor       = RGB(90,90,90)
3234:             .ToolTipText     = "Atualizar Pesos"
3235:             .Visible         = .T.
3236:         ENDWITH
3237:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")
3238: 
3239:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
3240:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
3241:             .Caption         = "="
3242:             .Top             = 168
3243:             .Left            = 0
3244:             .Width           = 50
3245:             .Height          = 42
3246:             .FontName        = "Tahoma"
3247:             .FontSize        = 14
3248:             .Themes          = .F.
3249:             .SpecialEffect   = 0
3250:             .BackColor       = RGB(255,255,255)
3251:             .ForeColor       = RGB(90,90,90)
3252:             .ToolTipText     = "Recalcular"
3253:             .Visible         = .T.
3254:         ENDWITH
3255:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")
3256: 
3257:         *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
3258:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
3259:         WITH loc_oPg.obj_4c_CmdgSubCp
3260:             .Top         = 345
3261:             .Left        = 947
3262:             .Width       = 50
3263:             .Height      = 90
3264:             .BackStyle   = 0
3265:             .BorderWidth = 0
3266:             .Visible     = .T.
3267:         ENDWITH
3268: 
3269:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
3270:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
3271:             .Caption         = "+"
3272:             .Top             = 0
3273:             .Left            = 0
3274:             .Width           = 50
3275:             .Height          = 45
3276:             .FontName        = "Tahoma"
3277:             .FontSize        = 14
3278:             .FontBold        = .T.
3279:             .Themes          = .F.
3280:             .SpecialEffect   = 0
3281:             .BackColor       = RGB(255,255,255)
3282:             .ForeColor       = RGB(0,128,0)
3283:             .ToolTipText     = "Incluir Sub-Componente"
3284:             .Visible         = .T.
3285:         ENDWITH
3286:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")
3287: 
3288:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
3289:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
3290:             .Caption         = "-"
3291:             .Top             = 45
3292:             .Left            = 0
3293:             .Width           = 50
3294:             .Height          = 45
3295:             .FontName        = "Tahoma"
3296:             .FontSize        = 14
3297:             .FontBold        = .T.
3298:             .Themes          = .F.
3299:             .SpecialEffect   = 0
3300:             .BackColor       = RGB(255,255,255)
3301:             .ForeColor       = RGB(180,0,0)
3302:             .ToolTipText     = "Excluir Sub-Componente"
3303:             .Visible         = .T.
3304:         ENDWITH
3305:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")
3306: 
3307:         *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
3308:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
3309:         WITH loc_oPg.lbl_4c_Label4
3310:             .Caption   = "Obs. da OF :"
3311:             .Top       = 300
3312:             .Left      = 36
3313:             .Width     = 64
3314:             .Height    = 15
3315:             .FontName  = "Tahoma"
3316:             .FontSize  = 8
3317:             .BackStyle = 0
3318:             .ForeColor = RGB(90,90,90)
3319:         ENDWITH
3320: 
3321:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
3322:         WITH loc_oPg.txt_4c_ObsOFs
3323:             .Value    = ""
3324:             .Top      = 297
3325:             .Left     = 99
3326:             .Width    = 850
3327:             .Height   = 21
3328:             .FontName = "Tahoma"
3329:             .FontSize = 8
3330:             .MaxLength = 100
3331:         ENDWITH
3332: 
3333:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
3334:         WITH loc_oPg.lbl_4c_Label16
3335:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3336:             .Top       = 324
3337:             .Left      = 45
3338:             .Width     = 55
3339:             .Height    = 15
3340:             .FontName  = "Tahoma"
3341:             .FontSize  = 8
3342:             .BackStyle = 0
3343:             .ForeColor = RGB(90,90,90)
3344:         ENDWITH
3345: 

*-- Linhas 3353 a 3505:
3353:             .FontName = "Tahoma"
3354:             .FontSize = 8
3355:         ENDWITH
3356:         BINDEVENT(loc_oPg.txt_4c_Desc, "LostFocus", THIS, "TabCompo_DescLostFocus")
3357: 
3358:         loc_oPg.AddObject("lbl_4c_Label15", "Label")
3359:         WITH loc_oPg.lbl_4c_Label15
3360:             .Caption   = "Material Principal :"
3361:             .Top       = 324
3362:             .Left      = 421
3363:             .Width     = 89
3364:             .Height    = 15
3365:             .FontName  = "Tahoma"
3366:             .FontSize  = 8
3367:             .BackStyle = 0
3368:             .ForeColor = RGB(90,90,90)
3369:         ENDWITH
3370: 
3371:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
3372:         WITH loc_oPg.txt_4c_MatP
3373:             .Value    = ""
3374:             .Top      = 321
3375:             .Left     = 517
3376:             .Width    = 108
3377:             .Height   = 21
3378:             .FontName = "Tahoma"
3379:             .FontSize = 8
3380:         ENDWITH
3381:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TabCompo_MatPLostFocus")
3382: 
3383:         *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
3384:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
3385:         WITH loc_oPg.lbl_4c_Label3
3386:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3387:             .Top       = 435
3388:             .Left      = 39
3389:             .Width     = 55
3390:             .Height    = 15
3391:             .FontName  = "Tahoma"
3392:             .FontSize  = 8
3393:             .BackStyle = 0
3394:             .ForeColor = RGB(90,90,90)
3395:         ENDWITH
3396: 
3397:         loc_oPg.AddObject("txt_4c__desccp", "TextBox")
3398:         WITH loc_oPg.txt_4c__desccp
3399:             .Value    = ""
3400:             .Top      = 432
3401:             .Left     = 99
3402:             .Width    = 298
3403:             .Height   = 21
3404:             .FontName = "Tahoma"
3405:             .FontSize = 8
3406:         ENDWITH
3407:         BINDEVENT(loc_oPg.txt_4c__desccp, "LostFocus", THIS, "TabCompo_DesccpLostFocus")
3408: 
3409:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
3410:         WITH loc_oPg.lbl_4c_Label5
3411:             .Caption   = "Substitui :"
3412:             .Top       = 435
3413:             .Left      = 465
3414:             .Width     = 50
3415:             .Height    = 15
3416:             .FontName  = "Tahoma"
3417:             .FontSize  = 8
3418:             .BackStyle = 0
3419:             .ForeColor = RGB(90,90,90)
3420:         ENDWITH
3421: 
3422:         loc_oPg.AddObject("txt_4c__matsub", "TextBox")
3423:         WITH loc_oPg.txt_4c__matsub
3424:             .Value    = ""
3425:             .Top      = 432
3426:             .Left     = 517
3427:             .Width    = 108
3428:             .Height   = 21
3429:             .FontName = "Tahoma"
3430:             .FontSize = 8
3431:         ENDWITH
3432:         BINDEVENT(loc_oPg.txt_4c__matsub, "LostFocus", THIS, "TabCompo_MatsubLostFocus")
3433: 
3434:         *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
3435:         loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
3436:         WITH loc_oPg.chk_4c_ChkLiberaCusto
3437:             .Caption   = "Custo"
3438:             .Value     = .F.
3439:             .Top       = 458
3440:             .Left      = 9
3441:             .Width     = 39
3442:             .Height    = 38
3443:             .FontName  = "Tahoma"
3444:             .FontSize  = 8
3445:             .BackStyle = 0
3446:             .Themes    = .F.
3447:             .Visible   = .T.
3448:         ENDWITH
3449:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
3450: 
3451:         loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
3452:         WITH loc_oPg.chk_4c_ChkLiberaVenda
3453:             .Caption   = "Venda"
3454:             .Value     = .F.
3455:             .Top       = 459
3456:             .Left      = 323
3457:             .Width     = 39
3458:             .Height    = 38
3459:             .FontName  = "Tahoma"
3460:             .FontSize  = 8
3461:             .BackStyle = 0
3462:             .Themes    = .F.
3463:             .Visible   = .T.
3464:         ENDWITH
3465:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
3466: 
3467:         *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
3468:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
3469:         WITH loc_oPg.lbl_4c_Label1
3470:             .Caption   = " Custo "
3471:             .Top       = 473
3472:             .Left      = 47
3473:             .Width     = 46
3474:             .Height    = 16
3475:             .FontName  = "Tahoma"
3476:             .FontSize  = 8
3477:             .BackStyle = 1
3478:             .BackColor = RGB(220,220,220)
3479:             .ForeColor = RGB(50,50,50)
3480:         ENDWITH
3481: 
3482:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
3483:         WITH loc_oPg.lbl_4c_Label2
3484:             .Caption   = " Venda "
3485:             .Top       = 474
3486:             .Left      = 361
3487:             .Width     = 48
3488:             .Height    = 16
3489:             .FontName  = "Tahoma"
3490:             .FontSize  = 8
3491:             .BackStyle = 1
3492:             .BackColor = RGB(220,220,220)
3493:             .ForeColor = RGB(50,50,50)
3494:         ENDWITH
3495: 
3496:         *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
3497:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
3498:         WITH loc_oPg.shp_4c_Shape6
3499:             .Top         = 497
3500:             .Left        = 9
3501:             .Width       = 158
3502:             .Height      = 2
3503:             .BackColor   = RGB(180,180,180)
3504:             .BackStyle   = 1
3505:             .BorderColor = RGB(180,180,180)

*-- Linhas 3603 a 3673:
3603:             .ToolTipText     = "Calcular Peso"
3604:             .Visible         = .T.
3605:         ENDWITH
3606:         BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")
3607: 
3608:         *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
3609:         loc_oPg.AddObject("lbl_4c_Label22", "Label")
3610:         WITH loc_oPg.lbl_4c_Label22
3611:             .Caption   = "MKP"
3612:             .Top       = 542
3613:             .Left      = 9
3614:             .Width     = 22
3615:             .Height    = 15
3616:             .FontName  = "Tahoma"
3617:             .FontSize  = 8
3618:             .BackStyle = 0
3619:             .ForeColor = RGB(90,90,90)
3620:         ENDWITH
3621: 
3622:         *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
3623:         loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
3624:         WITH loc_oPg.txt_4c_Cmkpc
3625:             .Value    = ""
3626:             .Top      = 557
3627:             .Left     = 9
3628:             .Width    = 24
3629:             .Height   = 23
3630:             .FontName = "Tahoma"
3631:             .FontSize = 8
3632:         ENDWITH
3633:         BINDEVENT(loc_oPg.txt_4c_Cmkpc, "LostFocus", THIS, "TabCompo_CmkpcLostFocus")
3634: 
3635:         *-- lblValAdics (top=542, left=64): "Valor Adicional"
3636:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3637:         WITH loc_oPg.lbl_4c_LblValAdics
3638:             .Caption   = "Valor Adicional"
3639:             .Top       = 542
3640:             .Left      = 64
3641:             .Width     = 71
3642:             .Height    = 15
3643:             .FontName  = "Tahoma"
3644:             .FontSize  = 8
3645:             .BackStyle = 0
3646:             .ForeColor = RGB(90,90,90)
3647:         ENDWITH
3648: 
3649:         *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
3650:         loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
3651:         WITH loc_oPg.txt_4c__pftioc
3652:             .Value    = 0
3653:             .Top      = 557
3654:             .Left     = 64
3655:             .Width    = 94
3656:             .Height   = 23
3657:             .FontName = "Tahoma"
3658:             .FontSize = 8
3659:             .ReadOnly = .T.
3660:         ENDWITH
3661: 
3662:         *-- chkPlanCus (top=556, left=36): planejamento custo
3663:         loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
3664:         WITH loc_oPg.chk_4c_ChkPlanCus
3665:             .Caption   = ""
3666:             .Value     = .F.
3667:             .Top       = 556
3668:             .Left      = 36
3669:             .Width     = 25
3670:             .Height    = 25
3671:             .BackStyle = 0
3672:             .Themes    = .F.
3673:             .Visible   = .T.

*-- Linhas 3699 a 3782:
3699:             .FontName = "Tahoma"
3700:             .FontSize = 8
3701:         ENDWITH
3702:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TabCompo_MargemLostFocus")
3703: 
3704:         *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
3705:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
3706:         WITH loc_oPg.lbl_4c_LblIdeal
3707:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3708:             .Top       = 503
3709:             .Left      = 416
3710:             .Width     = 111
3711:             .Height    = 15
3712:             .FontName  = "Tahoma"
3713:             .FontSize  = 8
3714:             .BackStyle = 0
3715:             .ForeColor = RGB(90,90,90)
3716:         ENDWITH
3717: 
3718:         *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
3719:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3720:         WITH loc_oPg.txt_4c_Pvideal
3721:             .Value    = 0
3722:             .Top      = 517
3723:             .Left     = 416
3724:             .Width    = 110
3725:             .Height   = 23
3726:             .FontName = "Tahoma"
3727:             .FontSize = 8
3728:             .ReadOnly = .T.
3729:         ENDWITH
3730: 
3731:         *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
3732:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
3733:         WITH loc_oPg.txt_4c_Moeda
3734:             .Value    = ""
3735:             .Top      = 517
3736:             .Left     = 529
3737:             .Width    = 31
3738:             .Height   = 23
3739:             .FontName = "Tahoma"
3740:             .FontSize = 8
3741:         ENDWITH
3742:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TabCompo_MoedaLostFocus")
3743: 
3744:         *-- lblFIdeals "Fator Ideal" (top=503, left=563)
3745:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3746:         WITH loc_oPg.lbl_4c_LblFIdeals
3747:             .Caption   = "Fator Ideal"
3748:             .Top       = 503
3749:             .Left      = 563
3750:             .Width     = 55
3751:             .Height    = 15
3752:             .FontName  = "Tahoma"
3753:             .FontSize  = 8
3754:             .BackStyle = 0
3755:             .ForeColor = RGB(90,90,90)
3756:         ENDWITH
3757: 
3758:         *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
3759:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
3760:         WITH loc_oPg.txt_4c_FIdeals
3761:             .Value    = 0
3762:             .Top      = 517
3763:             .Left     = 563
3764:             .Width    = 110
3765:             .Height   = 23
3766:             .FontName = "Tahoma"
3767:             .FontSize = 8
3768:             .ReadOnly = .T.
3769:         ENDWITH
3770: 
3771:         *-- Say14 "MKP" (top=542, left=360) - label para Getftio
3772:         loc_oPg.AddObject("lbl_4c_Label14", "Label")
3773:         WITH loc_oPg.lbl_4c_Label14
3774:             .Caption   = "MKP"
3775:             .Top       = 542
3776:             .Left      = 360
3777:             .Width     = 22
3778:             .Height    = 15
3779:             .FontName  = "Tahoma"
3780:             .FontSize  = 8
3781:             .BackStyle = 0
3782:             .ForeColor = RGB(90,90,90)

*-- Linhas 3793 a 3836:
3793:             .FontName = "Tahoma"
3794:             .FontSize = 8
3795:         ENDWITH
3796:         BINDEVENT(loc_oPg.txt_4c_Ftio, "LostFocus", THIS, "TabCompo_FtioLostFocus")
3797: 
3798:         *-- Say13 "Valor Adicional" (top=542, left=416)
3799:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
3800:         WITH loc_oPg.lbl_4c_Label13
3801:             .Caption   = "Valor Adicional"
3802:             .Top       = 542
3803:             .Left      = 416
3804:             .Width     = 71
3805:             .Height    = 15
3806:             .FontName  = "Tahoma"
3807:             .FontSize  = 8
3808:             .BackStyle = 0
3809:             .ForeColor = RGB(90,90,90)
3810:         ENDWITH
3811: 
3812:         *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
3813:         loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
3814:         WITH loc_oPg.txt_4c_Pftio
3815:             .Value    = 0
3816:             .Top      = 557
3817:             .Left     = 416
3818:             .Width    = 110
3819:             .Height   = 23
3820:             .FontName = "Tahoma"
3821:             .FontSize = 8
3822:             .ReadOnly = .T.
3823:         ENDWITH
3824: 
3825:         *-- Say12 "Fator" (top=542, left=563)
3826:         loc_oPg.AddObject("lbl_4c_Label12", "Label")
3827:         WITH loc_oPg.lbl_4c_Label12
3828:             .Caption   = "Fator"
3829:             .Top       = 542
3830:             .Left      = 563
3831:             .Width     = 28
3832:             .Height    = 15
3833:             .FontName  = "Tahoma"
3834:             .FontSize  = 8
3835:             .BackStyle = 0
3836:             .ForeColor = RGB(90,90,90)

*-- Linhas 3847 a 4013:
3847:             .FontName = "Tahoma"
3848:             .FontSize = 8
3849:         ENDWITH
3850:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TabCompo_FvendaLostFocus")
3851: 
3852:         *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
3853:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
3854:         WITH loc_oPg.txt_4c_Moepv
3855:             .Value    = ""
3856:             .Top      = 557
3857:             .Left     = 677
3858:             .Width    = 31
3859:             .Height   = 23
3860:             .FontName = "Tahoma"
3861:             .FontSize = 8
3862:         ENDWITH
3863:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TabCompo_MoepvLostFocus")
3864: 
3865:         *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
3866:         loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
3867:         WITH loc_oPg.txt_4c_Mftio
3868:             .Value    = 0
3869:             .Top      = 557
3870:             .Left     = 529
3871:             .Width    = 31
3872:             .Height   = 23
3873:             .FontName = "Tahoma"
3874:             .FontSize = 8
3875:             .ReadOnly = .T.
3876:         ENDWITH
3877: 
3878:         *-- Say24 "Sts" (top=542, left=324) - label para getStatus
3879:         loc_oPg.AddObject("lbl_4c_Label24", "Label")
3880:         WITH loc_oPg.lbl_4c_Label24
3881:             .Caption   = "Sts"
3882:             .Top       = 542
3883:             .Left      = 324
3884:             .Width     = 17
3885:             .Height    = 15
3886:             .FontName  = "Tahoma"
3887:             .FontSize  = 8
3888:             .BackStyle = 0
3889:             .ForeColor = RGB(90,90,90)
3890:         ENDWITH
3891: 
3892:         *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
3893:         loc_oPg.AddObject("txt_4c_Status", "TextBox")
3894:         WITH loc_oPg.txt_4c_Status
3895:             .Value    = ""
3896:             .Top      = 557
3897:             .Left     = 324
3898:             .Width    = 31
3899:             .Height   = 23
3900:             .FontName = "Tahoma"
3901:             .FontSize = 8
3902:         ENDWITH
3903:         BINDEVENT(loc_oPg.txt_4c_Status, "LostFocus", THIS, "TabCompo_StatusLostFocus")
3904: 
3905:         *-- chkPlanVen (top=556, left=387): planejamento venda
3906:         loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3907:         WITH loc_oPg.chk_4c_ChkPlanVen
3908:             .Caption   = ""
3909:             .Value     = .F.
3910:             .Top       = 556
3911:             .Left      = 387
3912:             .Width     = 25
3913:             .Height    = 25
3914:             .BackStyle = 0
3915:             .Themes    = .F.
3916:             .Visible   = .T.
3917:         ENDWITH
3918: 
3919:         *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
3920:         loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
3921:         WITH loc_oPg.chk_4c_ChkPvenda
3922:             .Caption   = ""
3923:             .Value     = .F.
3924:             .Top       = 595
3925:             .Left      = 387
3926:             .Width     = 25
3927:             .Height    = 25
3928:             .BackStyle = 0
3929:             .Themes    = .F.
3930:             .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
3931:             .Visible   = .T.
3932:         ENDWITH
3933:         BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")
3934: 
3935:         *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
3936:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
3937:         WITH loc_oPg.lbl_4c_LblVenda
3938:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3939:             .Top       = 581
3940:             .Left      = 416
3941:             .Width     = 115
3942:             .Height    = 15
3943:             .FontName  = "Tahoma"
3944:             .FontSize  = 8
3945:             .BackStyle = 0
3946:             .ForeColor = RGB(90,90,90)
3947:         ENDWITH
3948: 
3949:         *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
3950:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
3951:         WITH loc_oPg.txt_4c_Pven
3952:             .Value    = 0
3953:             .Top      = 596
3954:             .Left     = 416
3955:             .Width    = 110
3956:             .Height   = 23
3957:             .FontName = "Tahoma"
3958:             .FontSize = 8
3959:             .ReadOnly = .T.
3960:         ENDWITH
3961: 
3962:         *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
3963:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
3964:         WITH loc_oPg.txt_4c_Moev
3965:             .Value    = ""
3966:             .Top      = 596
3967:             .Left     = 529
3968:             .Width    = 31
3969:             .Height   = 23
3970:             .FontName = "Tahoma"
3971:             .FontSize = 8
3972:         ENDWITH
3973:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TabCompo_MoevLostFocus")
3974: 
3975:         *-- lblFAtuals "Fator Atual" (top=581, left=563)
3976:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3977:         WITH loc_oPg.lbl_4c_LblFAtuals
3978:             .Caption   = "Fator Atual"
3979:             .Top       = 581
3980:             .Left      = 563
3981:             .Width     = 56
3982:             .Height    = 15
3983:             .FontName  = "Tahoma"
3984:             .FontSize  = 8
3985:             .BackStyle = 0
3986:             .ForeColor = RGB(90,90,90)
3987:         ENDWITH
3988: 
3989:         *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
3990:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
3991:         WITH loc_oPg.txt_4c_FAtuals
3992:             .Value    = 0
3993:             .Top      = 596
3994:             .Left     = 563
3995:             .Width    = 110
3996:             .Height   = 23
3997:             .FontName = "Tahoma"
3998:             .FontSize = 8
3999:             .ReadOnly = .T.
4000:         ENDWITH
4001: 
4002:         *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
4003:         loc_oPg.AddObject("lbl_4c_Label25", "Label")
4004:         WITH loc_oPg.lbl_4c_Label25
4005:             .Caption   = "Financeiro"
4006:             .Top       = 581
4007:             .Left      = 678
4008:             .Width     = 51
4009:             .Height    = 15
4010:             .FontName  = "Tahoma"
4011:             .FontSize  = 8
4012:             .BackStyle = 0
4013:             .ForeColor = RGB(90,90,90)

*-- Linhas 4057 a 4108:
4057:             .ToolTipText     = "Calcular Valores"
4058:             .Visible         = .T.
4059:         ENDWITH
4060:         BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
4061: 
4062:         *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
4063:         BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "LostFocus", THIS, "TabCompo_MoecLostFocus")
4064:         BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"LostFocus", THIS, "TabCompo_MoecusfLostFocus")
4065: 
4066:         *-- BINDEVENT para AfterRowColChange dos grids
4067:         BINDEVENT(loc_oPg.grd_4c_Compo,    "AfterRowColChange", THIS, "CompoGrd_AfterRowColChange")
4068:         BINDEVENT(loc_oPg.grd_4c_SubCompo, "AfterRowColChange", THIS, "SubCompoGrd_AfterRowColChange")
4069: 
4070:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4071:         IF !USED("cursor_4c_Compo")
4072:             SET NULL ON
4073:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4074:             SET NULL OFF
4075:         ENDIF
4076:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4077:         WITH loc_oPg.grd_4c_Compo
4078:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4079:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4080:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4081:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4082:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4083:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4084:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4085:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4086:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4087:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4088:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4089:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4090:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4091:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4092:         ENDWITH
4093: 
4094:         IF !USED("cursor_4c_SubCompo")
4095:             SET NULL ON
4096:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4097:             SET NULL OFF
4098:         ENDIF
4099:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4100:         WITH loc_oPg.grd_4c_SubCompo
4101:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4102:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4103:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4104:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4105:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4106:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4107:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4108:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"

*-- Linhas 4131 a 4309:
4131:     *--------------------------------------------------------------------------
4132:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4133:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4134:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4135:     *--------------------------------------------------------------------------
4136:     PROTECTED PROCEDURE ConfigurarTabCustos()
4137:         LOCAL loc_oPg
4138:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4139: 
4140:         *-- Label "Tipo :" (top=159, left=112)
4141:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4142:         WITH loc_oPg.lbl_4c_TipoCusto
4143:             .Caption   = "Tipo :"
4144:             .Top       = 159
4145:             .Left      = 112
4146:             .Width     = 29
4147:             .Height    = 15
4148:             .FontName  = "Tahoma"
4149:             .FontSize  = 8
4150:             .BackStyle = 0
4151:             .ForeColor = RGB(90, 90, 90)
4152:         ENDWITH
4153: 
4154:         *-- ComboBox cmbTipos (top=154, left=143, width=187)
4155:         *-- Filtra o grid de custos por tipo de calculo de custo
4156:         loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
4157:         WITH loc_oPg.cmb_4c_TiposCusto
4158:             .Top       = 154
4159:             .Left      = 143
4160:             .Width     = 187
4161:             .Height    = 23
4162:             .Style     = 2
4163:             .FontName  = "Tahoma"
4164:             .FontSize  = 8
4165:         ENDWITH
4166:         WITH loc_oPg.cmb_4c_TiposCusto
4167:             .AddItem("Todos")
4168:             .AddItem("Custo Completo")
4169:             .AddItem("Custo Parcial")
4170:             .AddItem("Custo Calculado")
4171:             .ListIndex = 1
4172:         ENDWITH
4173:         BINDEVENT(loc_oPg.cmb_4c_TiposCusto, "LostFocus", THIS, "CmbTiposCustoValid")
4174: 
4175:         *-- grdCompo - Grid de composicao de custo (top=178, left=34, width=813, height=230, 12 cols)
4176:         *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
4177:         loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
4178:         WITH loc_oPg.grd_4c_CompoCusto
4179:             .Top         = 178
4180:             .Left        = 34
4181:             .Width       = 813
4182:             .Height      = 230
4183:             .ReadOnly    = .F.
4184:             .DeleteMark  = .F.
4185:             .RecordMark  = .F.
4186:             .ScrollBars  = 3
4187:             .GridLines   = 3
4188:             .ColumnCount = 12
4189:             .FontName    = "Verdana"
4190:             .FontSize    = 8
4191:             .Visible     = .T.
4192:         ENDWITH
4193:         WITH loc_oPg.grd_4c_CompoCusto
4194:             .Column1.Header1.Caption  = "Item"
4195:             .Column1.Width  = 80
4196:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4197:             .Column2.Width  = 180
4198:             .Column3.Header1.Caption  = "Un"
4199:             .Column3.Width  = 35
4200:             .Column4.Header1.Caption  = "Valor"
4201:             .Column4.Width  = 75
4202:             .Column5.Header1.Caption  = "Qtd"
4203:             .Column5.Width  = 60
4204:             .Column6.Header1.Caption  = "Total"
4205:             .Column6.Width  = 75
4206:             .Column7.Header1.Caption  = "Moe"
4207:             .Column7.Width  = 35
4208:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4209:             .Column8.Width  = 75
4210:             .Column9.Header1.Caption  = "Etiq"
4211:             .Column9.Width  = 35
4212:             .Column10.Header1.Caption = "Consumo"
4213:             .Column10.Width = 70
4214:             .Column11.Header1.Caption = "Qtd"
4215:             .Column11.Width = 55
4216:             .Column12.Header1.Caption = "Un"
4217:             .Column12.Width = 35
4218:         ENDWITH
4219:         BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")
4220: 
4221:         *-- Botoes Incluir/Excluir para grid de custo
4222:         *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
4223:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
4224:         WITH loc_oPg.cnt_4c_BotoesCusto
4225:             .Top         = 178
4226:             .Left        = 851
4227:             .Width       = 50
4228:             .Height      = 90
4229:             .BackStyle = 1
4230:             .BackColor = RGB(53, 53, 53)
4231:             .BorderWidth = 0
4232:             .Visible     = .T.
4233:         ENDWITH
4234: 
4235:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
4236:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
4237:             .Caption       = "+"
4238:             .Top           = 0
4239:             .Left          = 0
4240:             .Width         = 50
4241:             .Height        = 45
4242:             .FontName      = "Tahoma"
4243:             .FontSize      = 14
4244:             .FontBold      = .T.
4245:             .Themes        = .F.
4246:             .SpecialEffect = 0
4247:             .BackColor     = RGB(230, 255, 230)
4248:             .ForeColor     = RGB(0, 128, 0)
4249:             .Visible       = .T.
4250:         ENDWITH
4251:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")
4252: 
4253:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
4254:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
4255:             .Caption       = "-"
4256:             .Top           = 45
4257:             .Left          = 0
4258:             .Width         = 50
4259:             .Height        = 45
4260:             .FontName      = "Tahoma"
4261:             .FontSize      = 14
4262:             .FontBold      = .T.
4263:             .Themes        = .F.
4264:             .SpecialEffect = 0
4265:             .BackColor     = RGB(255, 230, 230)
4266:             .ForeColor     = RGB(192, 0, 0)
4267:             .Visible       = .T.
4268:         ENDWITH
4269:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")
4270: 
4271:         *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
4272:         loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
4273:         WITH loc_oPg.shp_4c_SepCusto
4274:             .Top         = 460
4275:             .Left        = 35
4276:             .Width       = 158
4277:             .Height      = 2
4278:             .FillColor   = RGB(180, 180, 180)
4279:             .BackColor   = RGB(180, 180, 180)
4280:             .BorderColor = RGB(180, 180, 180)
4281:         ENDWITH
4282: 
4283:         *-- Label "Descricao :" (Say16: top=415, left=52)
4284:         loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
4285:         WITH loc_oPg.lbl_4c_DescCusto
4286:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4287:             .Top       = 415
4288:             .Left      = 52
4289:             .Width     = 62
4290:             .Height    = 15
4291:             .FontName  = "Tahoma"
4292:             .FontSize  = 8
4293:             .BackStyle = 0
4294:             .ForeColor = RGB(90, 90, 90)
4295:         ENDWITH
4296: 
4297:         *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
4298:         loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
4299:         WITH loc_oPg.txt_4c_DescCusto
4300:             .Value    = ""
4301:             .Top      = 412
4302:             .Left     = 116
4303:             .Width    = 304
4304:             .Height   = 21
4305:             .FontName = "Tahoma"
4306:             .FontSize = 8
4307:             .ReadOnly = .T.
4308:         ENDWITH
4309: 

*-- Linhas 4414 a 4486:
4414:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4415:     * IMPLEMENTADO NA FASE 6
4416:     *--------------------------------------------------------------------------
4417:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4418:         LOCAL loc_oPg
4419:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4420: 
4421:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4422:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4423:         WITH loc_oPg.lbl_4c_Clfiscal
4424:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
4425:             .Top       = 216
4426:             .Left      = 102
4427:             .Width     = 99
4428:             .Height    = 15
4429:             .FontName  = "Tahoma"
4430:             .FontSize  = 8
4431:             .BackStyle = 0
4432:             .ForeColor = RGB(90,90,90)
4433:         ENDWITH
4434: 
4435:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
4436:         WITH loc_oPg.txt_4c_Clfiscal
4437:             .Value    = ""
4438:             .Top      = 211
4439:             .Left     = 206
4440:             .Width    = 94
4441:             .Height   = 23
4442:             .FontName = "Tahoma"
4443:             .FontSize = 8
4444:             .MaxLength = 10
4445:         ENDWITH
4446:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")
4447: 
4448:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
4449:         WITH loc_oPg.txt_4c_Dclfiscal
4450:             .Value    = ""
4451:             .Top      = 211
4452:             .Left     = 303
4453:             .Width    = 303
4454:             .Height   = 23
4455:             .FontName = "Tahoma"
4456:             .FontSize = 8
4457:             .ReadOnly = .T.
4458:         ENDWITH
4459: 
4460:         *-- Origem Mercadoria (top=236, left=206, width=17)
4461:         loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
4462:         WITH loc_oPg.lbl_4c_Origmerc
4463:             .Caption   = "Origem da Mercadoria :"
4464:             .Top       = 241
4465:             .Left      = 87
4466:             .Width     = 114
4467:             .Height    = 15
4468:             .FontName  = "Tahoma"
4469:             .FontSize  = 8
4470:             .BackStyle = 0
4471:             .ForeColor = RGB(90,90,90)
4472:         ENDWITH
4473: 
4474:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
4475:         WITH loc_oPg.txt_4c_Origmerc
4476:             .Value    = ""
4477:             .Top      = 236
4478:             .Left     = 206
4479:             .Width    = 17
4480:             .Height   = 23
4481:             .FontName = "Tahoma"
4482:             .FontSize = 8
4483:             .MaxLength = 1
4484:         ENDWITH
4485: 
4486:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")

*-- Linhas 4692 a 4774:
4692:             .FontSize = 8
4693:             .MaxLength = 2
4694:         ENDWITH
4695:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")
4696: 
4697:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4698:         WITH loc_oPg.txt_4c_DesMetal
4699:             .Value    = ""
4700:             .Top      = 429
4701:             .Left     = 564
4702:             .Width    = 150
4703:             .Height   = 23
4704:             .FontName = "Tahoma"
4705:             .FontSize = 8
4706:             .ReadOnly = .T.
4707:         ENDWITH
4708: 
4709:         *-- Teor (top=454, left=537)
4710:         loc_oPg.AddObject("lbl_4c_Teor", "Label")
4711:         WITH loc_oPg.lbl_4c_Teor
4712:             .Caption   = "Teor :"
4713:             .Top       = 454
4714:             .Left      = 490
4715:             .Width     = 45
4716:             .Height    = 15
4717:             .FontName  = "Tahoma"
4718:             .FontSize  = 8
4719:             .BackStyle = 0
4720:             .ForeColor = RGB(90,90,90)
4721:         ENDWITH
4722: 
4723:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4724:         WITH loc_oPg.txt_4c_Teor
4725:             .Value    = ""
4726:             .Top      = 454
4727:             .Left     = 537
4728:             .Width    = 24
4729:             .Height   = 23
4730:             .FontName = "Tahoma"
4731:             .FontSize = 8
4732:             .MaxLength = 2
4733:         ENDWITH
4734:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")
4735: 
4736:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4737:         WITH loc_oPg.txt_4c_DesTeor
4738:             .Value    = ""
4739:             .Top      = 454
4740:             .Left     = 564
4741:             .Width    = 150
4742:             .Height   = 23
4743:             .FontName = "Tahoma"
4744:             .FontSize = 8
4745:             .ReadOnly = .T.
4746:         ENDWITH
4747: 
4748:         *-- Descricao ECF (top=429, left=206, width=213)
4749:         loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
4750:         WITH loc_oPg.lbl_4c_DescEcf
4751:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
4752:             .Top       = 433
4753:             .Left      = 124
4754:             .Width     = 77
4755:             .Height    = 15
4756:             .FontName  = "Tahoma"
4757:             .FontSize  = 8
4758:             .BackStyle = 0
4759:             .ForeColor = RGB(90,90,90)
4760:         ENDWITH
4761: 
4762:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4763:         WITH loc_oPg.txt_4c_DescEcfs
4764:             .Value    = ""
4765:             .Top      = 429
4766:             .Left     = 206
4767:             .Width    = 213
4768:             .Height   = 23
4769:             .FontName = "Tahoma"
4770:             .FontSize = 8
4771:             .MaxLength = 29
4772:         ENDWITH
4773: 
4774:         *-- Valor Estimado (top=454, left=206)

*-- Linhas 4811 a 5039:
4811: 
4812:     *--------------------------------------------------------------------------
4813:     * ConfigurarPgpgDadosFiscais - Completa Aba 4 Dados Fiscais
4814:     * Adiciona controles restantes + BINDEVENTs de todos os campos do tab fiscal
4815:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDadosFiscais()
4816:     *--------------------------------------------------------------------------
4817:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
4818:         LOCAL loc_oPg
4819:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4820: 
4821:         *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============
4822: 
4823:         loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
4824:         WITH loc_oPg.lbl_4c_Gruccus
4825:             .Caption   = "Grupo C.C. :"
4826:             .Top       = 165
4827:             .Left      = 138
4828:             .Width     = 63
4829:             .Height    = 15
4830:             .FontName  = "Tahoma"
4831:             .FontSize  = 8
4832:             .BackStyle = 0
4833:             .ForeColor = RGB(90, 90, 90)
4834:         ENDWITH
4835: 
4836:         loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
4837:         WITH loc_oPg.txt_4c__gruccus
4838:             .Value         = ""
4839:             .Top           = 161
4840:             .Left          = 206
4841:             .Width         = 80
4842:             .Height        = 23
4843:             .FontName      = "Tahoma"
4844:             .FontSize      = 8
4845:             .MaxLength     = 10
4846:             .SpecialEffect = 1
4847:         ENDWITH
4848:         BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus", THIS, "ValidarGruccus")
4849: 
4850:         loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
4851:         WITH loc_oPg.txt_4c__dgruccus
4852:             .Value    = ""
4853:             .Top      = 161
4854:             .Left     = 288
4855:             .Width    = 318
4856:             .Height   = 23
4857:             .FontName = "Tahoma"
4858:             .FontSize = 8
4859:             .ReadOnly = .T.
4860:         ENDWITH
4861:         BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus", THIS, "ValidarDgruccus")
4862: 
4863:         *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========
4864: 
4865:         loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
4866:         WITH loc_oPg.lbl_4c_Contaccus
4867:             .Caption   = "Conta C.C. :"
4868:             .Top       = 189
4869:             .Left      = 138
4870:             .Width     = 63
4871:             .Height    = 15
4872:             .FontName  = "Tahoma"
4873:             .FontSize  = 8
4874:             .BackStyle = 0
4875:             .ForeColor = RGB(90, 90, 90)
4876:         ENDWITH
4877: 
4878:         loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
4879:         WITH loc_oPg.txt_4c__contaccus
4880:             .Value         = ""
4881:             .Top           = 186
4882:             .Left          = 206
4883:             .Width         = 80
4884:             .Height        = 23
4885:             .FontName      = "Tahoma"
4886:             .FontSize      = 8
4887:             .MaxLength     = 10
4888:             .SpecialEffect = 1
4889:         ENDWITH
4890:         BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus", THIS, "ValidarContaccus")
4891: 
4892:         loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
4893:         WITH loc_oPg.txt_4c__dcontaccus
4894:             .Value    = ""
4895:             .Top      = 186
4896:             .Left     = 288
4897:             .Width    = 318
4898:             .Height   = 23
4899:             .FontName = "Tahoma"
4900:             .FontSize = 8
4901:             .ReadOnly = .T.
4902:         ENDWITH
4903:         BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus", THIS, "ValidarDcontaccus")
4904: 
4905:         *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========
4906: 
4907:         loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
4908:         WITH loc_oPg.lbl_4c_AliqIPI
4909:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
4910:             .Top       = 316
4911:             .Left      = 327
4912:             .Width     = 90
4913:             .Height    = 15
4914:             .FontName  = "Tahoma"
4915:             .FontSize  = 8
4916:             .BackStyle = 0
4917:             .ForeColor = RGB(90, 90, 90)
4918:         ENDWITH
4919: 
4920:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4921:         WITH loc_oPg.txt_4c_AliqIPI
4922:             .Value    = 0
4923:             .Top      = 311
4924:             .Left     = 425
4925:             .Width    = 45
4926:             .Height   = 25
4927:             .FontName = "Tahoma"
4928:             .FontSize = 8
4929:         ENDWITH
4930:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4931: 
4932:         *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======
4933: 
4934:         loc_oPg.AddObject("lbl_4c_Extipi", "Label")
4935:         WITH loc_oPg.lbl_4c_Extipi
4936:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
4937:             .Top       = 316
4938:             .Left      = 495
4939:             .Width     = 98
4940:             .Height    = 15
4941:             .FontName  = "Tahoma"
4942:             .FontSize  = 8
4943:             .BackStyle = 0
4944:             .ForeColor = RGB(90, 90, 90)
4945:         ENDWITH
4946: 
4947:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4948:         WITH loc_oPg.txt_4c_Extipi
4949:             .Value     = ""
4950:             .Top       = 311
4951:             .Left      = 601
4952:             .Width     = 35
4953:             .Height    = 25
4954:             .FontName  = "Tahoma"
4955:             .FontSize  = 8
4956:             .MaxLength = 3
4957:         ENDWITH
4958:         BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")
4959: 
4960:         *-- === IAT (getiat: top=286, left=589, width=17) ========================
4961: 
4962:         loc_oPg.AddObject("lbl_4c_Iat", "Label")
4963:         WITH loc_oPg.lbl_4c_Iat
4964:             .Caption   = "IAT :"
4965:             .Top       = 290
4966:             .Left      = 558
4967:             .Width     = 26
4968:             .Height    = 15
4969:             .FontName  = "Tahoma"
4970:             .FontSize  = 8
4971:             .BackStyle = 0
4972:             .ForeColor = RGB(90, 90, 90)
4973:         ENDWITH
4974: 
4975:         loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
4976:         WITH loc_oPg.lbl_4c_IatDesc
4977:             .Caption   = "[A]rredondamento [T]runcamento"
4978:             .Top       = 290
4979:             .Left      = 609
4980:             .Width     = 165
4981:             .Height    = 15
4982:             .FontName  = "Tahoma"
4983:             .FontSize  = 8
4984:             .BackStyle = 0
4985:             .ForeColor = RGB(120, 120, 120)
4986:         ENDWITH
4987: 
4988:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4989:         WITH loc_oPg.txt_4c_Iat
4990:             .Value     = ""
4991:             .Top       = 286
4992:             .Left      = 589
4993:             .Width     = 17
4994:             .Height    = 23
4995:             .FontName  = "Tahoma"
4996:             .FontSize  = 8
4997:             .MaxLength = 1
4998:         ENDWITH
4999:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
5000: 
5001:         *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
5002:         *-- Campo de exibicao calculado: nao armazenado, somente leitura
5003: 
5004:         loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
5005:         WITH loc_oPg.lbl_4c_IPPTCST
5006:             .Caption   = "IPPT/CST :"
5007:             .Top       = 483
5008:             .Left      = 147
5009:             .Width     = 54
5010:             .Height    = 15
5011:             .FontName  = "Tahoma"
5012:             .FontSize  = 8
5013:             .BackStyle = 0
5014:             .ForeColor = RGB(90, 90, 90)
5015:         ENDWITH
5016: 
5017:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
5018:         WITH loc_oPg.txt_4c_IPPTCST
5019:             .Value    = ""
5020:             .Top      = 479
5021:             .Left     = 206
5022:             .Width    = 108
5023:             .Height   = 23
5024:             .FontName = "Tahoma"
5025:             .FontSize = 8
5026:             .ReadOnly = .T.
5027:         ENDWITH
5028: 
5029:         *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
5030:         *-- 3 colunas: Periodo, Valor Custo GR, Moe
5031: 
5032:         loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
5033:         WITH loc_oPg.lbl_4c_CmvTitulo
5034:             .Caption   = "Valor do Grama Produzido"
5035:             .Top       = 320
5036:             .Left      = 756
5037:             .Width     = 125
5038:             .Height    = 15
5039:             .FontName  = "Tahoma"

*-- Linhas 5096 a 5161:
5096:             .SpecialEffect   = 0
5097:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5098:         ENDWITH
5099:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")
5100: 
5101:         *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
5102:         *-- Adicionar LostFocus nos campos lookup existentes
5103: 
5104:         BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "LostFocus", THIS, "ValidarClfiscal")
5105:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "ValidarDclfiscal")
5106:         BINDEVENT(loc_oPg.txt_4c_Origmerc,  "LostFocus", THIS, "ValidarOrigmerc")
5107:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "LostFocus", THIS, "ValidarDorigmerc")
5108:         BINDEVENT(loc_oPg.txt_4c_Sittricms, "LostFocus", THIS, "ValidarSittricms")
5109:         BINDEVENT(loc_oPg.txt_4c_Dsittricms,"LostFocus", THIS, "ValidarDsittricms")
5110:         BINDEVENT(loc_oPg.txt_4c_CodServs,  "LostFocus", THIS, "ValidarCodServs")
5111:         BINDEVENT(loc_oPg.txt_4c_Tptribs,   "LostFocus", THIS, "ValidarTptribs")
5112:         BINDEVENT(loc_oPg.txt_4c_Metal,     "LostFocus", THIS, "ValidarMetal")
5113:         BINDEVENT(loc_oPg.txt_4c_Teor,      "LostFocus", THIS, "ValidarTeor")
5114:         BINDEVENT(loc_oPg.txt_4c_Moedas,    "LostFocus", THIS, "ValidarMoedaEstimada")
5115:     ENDPROC
5116: 
5117:     *--------------------------------------------------------------------------
5118:     * ConfigurarTabDesigner - Aba 5: Designer/arquivos (pgDesigner)
5119:     * IMPLEMENTADO NA FASE 7
5120:     *--------------------------------------------------------------------------
5121:     PROTECTED PROCEDURE ConfigurarTabDesigner()
5122:         LOCAL loc_oPg
5123:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5124: 
5125:         *-- grdDesigner (top=160, left=10, width=495, height=238, 4 cols)
5126:         *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
5127:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
5128:         WITH loc_oPg.grd_4c_Designer
5129:             .Top         = 160
5130:             .Left        = 10
5131:             .Width       = 495
5132:             .Height      = 238
5133:             .ReadOnly    = .T.
5134:             .DeleteMark  = .F.
5135:             .RecordMark  = .F.
5136:             .ScrollBars  = 3
5137:             .GridLines   = 3
5138:             .ColumnCount = 4
5139:             .FontName    = "Verdana"
5140:             .FontSize    = 8
5141:             .Visible     = .T.
5142:         ENDWITH
5143:         WITH loc_oPg.grd_4c_Designer
5144:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5145:             .Column1.Width = 110
5146:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5147:             .Column2.Width = 120
5148:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5149:             .Column3.Width = 100
5150:             .Column4.Header1.Caption = "Tarefa"
5151:             .Column4.Width = 160
5152:         ENDWITH
5153: 
5154:         *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
5155:         loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
5156:         WITH loc_oPg.lbl_4c_ObsTarefa
5157:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5158:             .Top       = 144
5159:             .Left      = 583
5160:             .Width     = 130
5161:             .Height    = 15

*-- Linhas 5190 a 5408:
5190:             .Themes  = .F.
5191:             .Visible = .T.
5192:         ENDWITH
5193:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
5194: 
5195:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
5196:         WITH loc_oPg.cmd_4c_FimTarefa
5197:             .Caption = "Fim"
5198:             .Top     = 203
5199:             .Left    = 509
5200:             .Width   = 42
5201:             .Height  = 42
5202:             .FontName = "Tahoma"
5203:             .FontSize = 7
5204:             .Themes  = .F.
5205:             .Visible = .T.
5206:         ENDWITH
5207:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
5208: 
5209:         *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
5210:         *-- Dados: sigprarq - Arquivos do designer
5211:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
5212:         WITH loc_oPg.grd_4c_Arquivos
5213:             .Top         = 415
5214:             .Left        = 10
5215:             .Width       = 495
5216:             .Height      = 202
5217:             .ReadOnly    = .T.
5218:             .DeleteMark  = .F.
5219:             .RecordMark  = .F.
5220:             .ScrollBars  = 3
5221:             .GridLines   = 3
5222:             .ColumnCount = 1
5223:             .FontName    = "Verdana"
5224:             .FontSize    = 8
5225:             .Visible     = .T.
5226:         ENDWITH
5227:         WITH loc_oPg.grd_4c_Arquivos
5228:             .Column1.Header1.Caption = "Arquivos Para Designer"
5229:             .Column1.Width = 492
5230:         ENDWITH
5231: 
5232:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5233:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
5234:         WITH loc_oPg.cmd_4c_InsArqs
5235:             .Caption = "Inserir"
5236:             .Top     = 416
5237:             .Left    = 509
5238:             .Width   = 42
5239:             .Height  = 42
5240:             .FontName = "Tahoma"
5241:             .FontSize = 7
5242:             .Themes  = .F.
5243:             .Visible = .T.
5244:         ENDWITH
5245:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
5246: 
5247:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
5248:         WITH loc_oPg.cmd_4c_ExcArqs
5249:             .Caption = "Excluir"
5250:             .Top     = 458
5251:             .Left    = 509
5252:             .Width   = 42
5253:             .Height  = 42
5254:             .FontName = "Tahoma"
5255:             .FontSize = 7
5256:             .Themes  = .F.
5257:             .Visible = .T.
5258:         ENDWITH
5259:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
5260: 
5261:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
5262:         WITH loc_oPg.cmd_4c_OpnArqs
5263:             .Caption = "Abrir"
5264:             .Top     = 500
5265:             .Left    = 509
5266:             .Width   = 42
5267:             .Height  = 42
5268:             .FontName = "Tahoma"
5269:             .FontSize = 7
5270:             .Themes  = .F.
5271:             .Visible = .T.
5272:         ENDWITH
5273:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
5274: 
5275:         *-- Criar cursors placeholder
5276:         IF !USED("cursor_4c_Designer")
5277:             SET NULL ON
5278:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5279:             SET NULL OFF
5280:         ENDIF
5281:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5282:         WITH loc_oPg.grd_4c_Designer
5283:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5284:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5285:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5286:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5287:         ENDWITH
5288: 
5289:         IF !USED("cursor_4c_Arquivos")
5290:             SET NULL ON
5291:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5292:             SET NULL OFF
5293:         ENDIF
5294:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5295:         WITH loc_oPg.grd_4c_Arquivos
5296:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5297:         ENDWITH
5298:     ENDPROC
5299: 
5300:     *--------------------------------------------------------------------------
5301:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5302:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5303:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5304:     *--------------------------------------------------------------------------
5305:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5306:         LOCAL loc_oPg
5307:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5308: 
5309:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5310:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5311:         loc_oPg.grd_4c_Designer.ReadOnly = .F.
5312: 
5313:         *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
5314:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
5315:         WITH loc_oPg.shp_4c_Shape1
5316:             .Top         = 415
5317:             .Left        = 584
5318:             .Width       = 407
5319:             .Height      = 202
5320:             .BorderColor = RGB(128, 128, 128)
5321:             .BorderWidth = 1
5322:             .BackStyle   = 0
5323:             .Visible     = .T.
5324:         ENDWITH
5325: 
5326:         *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
5327:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
5328:         WITH loc_oPg.img_4c_ImgArqJpg
5329:             .Top     = 417
5330:             .Left    = 586
5331:             .Width   = 403
5332:             .Height  = 198
5333:             .Stretch = 2
5334:             .Visible = .F.
5335:         ENDWITH
5336:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
5337: 
5338:         *-- BINDEVENTs para AfterRowColChange dos grids
5339:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "DesignerGrd_AfterRowColChange")
5340:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "ArquivosGrd_AfterRowColChange")
5341: 
5342:         *-- BINDEVENTs Colunas 1/2/3 do grd_4c_Designer (somente leitura sempre)
5343:         BINDEVENT(loc_oPg.grd_4c_Designer.Column1.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5344:         BINDEVENT(loc_oPg.grd_4c_Designer.Column2.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5345:         BINDEVENT(loc_oPg.grd_4c_Designer.Column3.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5346: 
5347:         *-- BINDEVENTs Coluna 4 do grd_4c_Designer (Tarefa: editavel condicionalmente)
5348:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
5349:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
5350:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
5351: 
5352:         *-- BINDEVENT Column1 do grd_4c_Arquivos (editavel em INCLUIR/ALTERAR)
5353:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
5354: 
5355:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5356:         IF !USED("cursor_4c_Tarefas")
5357:             SET NULL ON
5358:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5359:             SET NULL OFF
5360:         ENDIF
5361:     ENDPROC
5362: 
5363:     *--------------------------------------------------------------------------
5364:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5365:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5366:     * IMPLEMENTADO NA FASE 9
5367:     *--------------------------------------------------------------------------
5368:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5369:         LOCAL loc_oPg
5370:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5371: 
5372:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5373:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5374:         IF !USED("cursor_4c_Consulta")
5375:             SET NULL ON
5376:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5377:             SET NULL OFF
5378:         ENDIF
5379: 
5380:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5381:         IF !USED("cursor_4c_Temp")
5382:             SET NULL ON
5383:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5384:             SET NULL OFF
5385:         ENDIF
5386: 
5387:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5388:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5389:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5390:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5391:         WITH loc_oPg.grd_4c_Consulta
5392:             .Top         = 155
5393:             .Left        = 6
5394:             .Width       = 987
5395:             .Height      = 362
5396:             .ReadOnly    = .F.
5397:             .DeleteMark  = .F.
5398:             .RecordMark  = .F.
5399:             .ScrollBars  = 3
5400:             .GridLines   = 3
5401:             .ColumnCount = 9
5402:             .FontName    = "Verdana"
5403:             .FontSize    = 8
5404:             .Visible     = .T.
5405:         ENDWITH
5406:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5407:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5408:         WITH loc_oPg.grd_4c_Consulta

*-- Linhas 5439 a 5482:
5439:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5440:             .Column9.ReadOnly        = .T.
5441:         ENDWITH
5442:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5443: 
5444:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5445:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5446:         WITH loc_oPg.lbl_4c_QtdCpnt
5447:             .Caption   = "Qtde Componentes : "
5448:             .Top       = 523
5449:             .Left      = 25
5450:             .Width     = 115
5451:             .Height    = 15
5452:             .FontName  = "Tahoma"
5453:             .FontSize  = 8
5454:             .BackStyle = 0
5455:             .ForeColor = RGB(90, 90, 90)
5456:         ENDWITH
5457: 
5458:         *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
5459:         loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
5460:         WITH loc_oPg.txt_4c_QtdCpnt
5461:             .Top           = 519
5462:             .Left          = 131
5463:             .Width         = 31
5464:             .Height        = 23
5465:             .Value         = 0
5466:             .ReadOnly      = .T.
5467:             .SpecialEffect = 1
5468:             .FontName      = "Tahoma"
5469:             .FontSize      = 8
5470:         ENDWITH
5471: 
5472:         *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
5473:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5474:         WITH loc_oPg.chk_4c_ChkFund
5475:             .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5476:             .Top      = 544
5477:             .Left     = 10
5478:             .Width    = 200
5479:             .Height   = 15
5480:             .FontName = "Tahoma"
5481:             .FontSize = 8
5482:             .Value    = 0

*-- Linhas 5531 a 5574:
5531:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5532:     * IMPLEMENTADO NA FASE 7
5533:     *--------------------------------------------------------------------------
5534:     PROTECTED PROCEDURE ConfigurarTabFases()
5535:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5536:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5537: 
5538:         *-- Cursor placeholder para GradFase (SigCdPrf)
5539:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5540:         IF !USED("cursor_4c_Fases")
5541:             SET NULL ON
5542:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5543:             SET NULL OFF
5544:         ENDIF
5545: 
5546:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5547:         IF !USED("cursor_4c_Matrizes")
5548:             SET NULL ON
5549:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5550:             SET NULL OFF
5551:         ENDIF
5552: 
5553:         *======================================================
5554:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5555:         *======================================================
5556:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5557:         WITH loc_oPg.lbl_4c_Qmin
5558:             .Top      = 156
5559:             .Left     = 33
5560:             .Width    = 102
5561:             .Height   = 15
5562:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5563:             .AutoSize = .F.
5564:             .FontName = "Tahoma"
5565:             .FontSize = 8
5566:             .Visible  = .T.
5567:         ENDWITH
5568: 
5569:         *======================================================
5570:         *-- TEXTBOX: getQmin - Qtde minima fabricacao
5571:         *======================================================
5572:         loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
5573:         WITH loc_oPg.txt_4c_Qminfab
5574:             .Top           = 152

*-- Linhas 6007 a 6349:
6007:             .Stretch = 2
6008:             .Visible = .F.
6009:         ENDWITH
6010:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
6011: 
6012:         *======================================================
6013:         *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
6014:         *-- top=152, left=482
6015:         *======================================================
6016:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
6017:         WITH loc_oPg.cmd_4c_CmdFicha
6018:             .Caption       = "Ficha"
6019:             .Top           = 152
6020:             .Left          = 482
6021:             .Width         = 38
6022:             .Height        = 23
6023:             .FontName      = "Tahoma"
6024:             .FontSize      = 8
6025:             .Themes        = .F.
6026:             .SpecialEffect = 0
6027:             .BackColor     = RGB(255, 255, 255)
6028:             .ForeColor     = RGB(90, 90, 90)
6029:             .Visible       = .T.
6030:         ENDWITH
6031:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
6032: 
6033:         *======================================================
6034:         *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
6035:         *-- top=192, left=482
6036:         *======================================================
6037:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
6038:         WITH loc_oPg.cmd_4c_CmdgFigura
6039:             .Caption       = "..."
6040:             .Top           = 192
6041:             .Left          = 482
6042:             .Width         = 38
6043:             .Height        = 23
6044:             .FontName      = "Tahoma"
6045:             .FontSize      = 8
6046:             .Themes        = .F.
6047:             .SpecialEffect = 0
6048:             .BackColor     = RGB(255, 255, 255)
6049:             .ForeColor     = RGB(90, 90, 90)
6050:             .Visible       = .T.
6051:         ENDWITH
6052:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
6053: 
6054:         *======================================================
6055:         *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
6056:         *-- top=232, left=482
6057:         *======================================================
6058:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
6059:         WITH loc_oPg.cmd_4c_CmdgFigCam
6060:             .Caption       = "..."
6061:             .Top           = 232
6062:             .Left          = 482
6063:             .Width         = 38
6064:             .Height        = 23
6065:             .FontName      = "Tahoma"
6066:             .FontSize      = 8
6067:             .Themes        = .F.
6068:             .SpecialEffect = 0
6069:             .BackColor     = RGB(255, 255, 255)
6070:             .ForeColor     = RGB(90, 90, 90)
6071:             .Visible       = .T.
6072:         ENDWITH
6073:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
6074: 
6075:         *======================================================
6076:         *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
6077:         *-- top=152, left=950
6078:         *======================================================
6079:         loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
6080:         WITH loc_oPg.cmd_4c_InserirFase
6081:             .Caption       = "Inserir"
6082:             .Top           = 152
6083:             .Left          = 950
6084:             .Width         = 45
6085:             .Height        = 23
6086:             .FontName      = "Tahoma"
6087:             .FontSize      = 8
6088:             .Themes        = .F.
6089:             .SpecialEffect = 0
6090:             .BackColor     = RGB(255, 255, 255)
6091:             .ForeColor     = RGB(90, 90, 90)
6092:             .Visible       = .T.
6093:         ENDWITH
6094:         BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
6095: 
6096:         *======================================================
6097:         *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
6098:         *-- top=192, left=950
6099:         *======================================================
6100:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
6101:         WITH loc_oPg.cmd_4c_ExcluirFase
6102:             .Caption       = "Excluir"
6103:             .Top           = 192
6104:             .Left          = 950
6105:             .Width         = 45
6106:             .Height        = 23
6107:             .FontName      = "Tahoma"
6108:             .FontSize      = 8
6109:             .Themes        = .F.
6110:             .SpecialEffect = 0
6111:             .BackColor     = RGB(255, 255, 255)
6112:             .ForeColor     = RGB(90, 90, 90)
6113:             .Visible       = .T.
6114:         ENDWITH
6115:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
6116: 
6117:         *======================================================
6118:         *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
6119:         *-- top=232, left=950
6120:         *======================================================
6121:         loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
6122:         WITH loc_oPg.cmd_4c_Alternativa
6123:             .Caption       = "Altern."
6124:             .Top           = 232
6125:             .Left          = 950
6126:             .Width         = 45
6127:             .Height        = 23
6128:             .FontName      = "Tahoma"
6129:             .FontSize      = 8
6130:             .Themes        = .F.
6131:             .SpecialEffect = 0
6132:             .BackColor     = RGB(255, 255, 255)
6133:             .ForeColor     = RGB(90, 90, 90)
6134:             .Visible       = .T.
6135:         ENDWITH
6136:         BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
6137: 
6138:         *======================================================
6139:         *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
6140:         *-- top=380, left=258
6141:         *======================================================
6142:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
6143:         WITH loc_oPg.cmd_4c_BtnInsereMtx
6144:             .Caption       = "+"
6145:             .Top           = 380
6146:             .Left          = 258
6147:             .Width         = 23
6148:             .Height        = 23
6149:             .FontName      = "Tahoma"
6150:             .FontSize      = 10
6151:             .FontBold      = .T.
6152:             .Themes        = .F.
6153:             .SpecialEffect = 0
6154:             .BackColor     = RGB(255, 255, 255)
6155:             .ForeColor     = RGB(90, 90, 90)
6156:             .Visible       = .T.
6157:         ENDWITH
6158:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")
6159: 
6160:         *======================================================
6161:         *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
6162:         *-- top=420, left=258
6163:         *======================================================
6164:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
6165:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
6166:             .Caption       = "-"
6167:             .Top           = 420
6168:             .Left          = 258
6169:             .Width         = 23
6170:             .Height        = 23
6171:             .FontName      = "Tahoma"
6172:             .FontSize      = 10
6173:             .FontBold      = .T.
6174:             .Themes        = .F.
6175:             .SpecialEffect = 0
6176:             .BackColor     = RGB(255, 255, 255)
6177:             .ForeColor     = RGB(90, 90, 90)
6178:             .Visible       = .T.
6179:         ENDWITH
6180:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")
6181: 
6182:         *======================================================
6183:         *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
6184:         *-- top=464, left=258, width=236, height=156
6185:         *======================================================
6186:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
6187:         WITH loc_oPg.shp_4c_ShpBorracha
6188:             .Top         = 464
6189:             .Left        = 258
6190:             .Width       = 236
6191:             .Height      = 156
6192:             .BorderColor = RGB(150, 150, 150)
6193:             .BorderWidth = 1
6194:             .FillStyle   = 1
6195:             .Curvature   = 0
6196:             .Visible     = .T.
6197:         ENDWITH
6198: 
6199:         *======================================================
6200:         *-- IMAGE: img_4c_ImgBorracha - Imagem da borracha (molde)
6201:         *-- top=465, left=260, width=232, height=154
6202:         *======================================================
6203:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
6204:         WITH loc_oPg.img_4c_ImgBorracha
6205:             .Top     = 465
6206:             .Left    = 260
6207:             .Width   = 232
6208:             .Height  = 154
6209:             .Stretch = 2
6210:             .Visible = .F.
6211:         ENDWITH
6212: 
6213:         *======================================================
6214:         *-- BINDEVENTs para grids (AfterRowColChange)
6215:         *======================================================
6216:         BINDEVENT(loc_oPg.grd_4c_Fases,    "AfterRowColChange", THIS, "GrdFasesAfterRowColChange")
6217:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
6218: 
6219:         *======================================================
6220:         *-- BINDEVENTs para lookups da aba Fases
6221:         *======================================================
6222:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsKeyPress")
6223:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "LostFocus", THIS, "TabFases_CodcorsLostFocus")
6224:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsKeyPress")
6225:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "LostFocus", THIS, "TabFases_CodtamsLostFocus")
6226:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsKeyPress")
6227:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "LostFocus", THIS, "TabFases_CodacbsLostFocus")
6228:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaKeyPress")
6229:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "LostFocus", THIS, "TabFases_ConquilhaLostFocus")
6230:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraKeyPress")
6231:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "LostFocus", THIS, "TabFases_GarraLostFocus")
6232: 
6233:     ENDPROC
6234: 
6235:     *--------------------------------------------------------------------------
6236:     * OptSituasChange - OptionGroup Situacao muda Ativo/Inativo
6237:     *--------------------------------------------------------------------------
6238:     PROCEDURE OptSituasChange()
6239:         LOCAL loc_oPg
6240:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6241:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6242:             IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6243:                 IF loc_oPg.opt_4c_Situas.Value = 2
6244:                     loc_oPg.txt_4c_DtSituas.Value = DATE()
6245:                 ENDIF
6246:             ENDIF
6247:         ENDIF
6248:     ENDPROC
6249: 
6250:     *--------------------------------------------------------------------------
6251:     * OptProdWebChange - OptionGroup Produto Web muda valor
6252:     *--------------------------------------------------------------------------
6253:     PROCEDURE OptProdWebChange()
6254:         RETURN
6255:     ENDPROC
6256: 
6257:     *--------------------------------------------------------------------------
6258:     * OptVariasChange - OptionGroup Variacao muda valor
6259:     *--------------------------------------------------------------------------
6260:     PROCEDURE OptVariasChange()
6261:         RETURN
6262:     ENDPROC
6263: 
6264:     *--------------------------------------------------------------------------
6265:     * OpcaoAbasChange - Navegacao entre abas pelo OptionGroup
6266:     * Legado: Optiongroup1.InteractiveChange
6267:     *--------------------------------------------------------------------------
6268:     PROCEDURE OpcaoAbasChange()
6269:         LOCAL loc_nAba, loc_lTemProduto
6270:         loc_nAba      = THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
6271:         loc_lTemProduto = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
6272: 
6273:         DO CASE
6274:             CASE loc_nAba = 1   && Principal
6275:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
6276:             CASE loc_nAba = 2   && Composicao
6277:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
6278:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6279:                     THIS.CarregarComposicao()
6280:                 ENDIF
6281:             CASE loc_nAba = 3   && Custos
6282:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 3
6283:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6284:                     THIS.CarregarCustos()
6285:                 ENDIF
6286:             CASE loc_nAba = 4   && Dados Fiscais
6287:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 4
6288:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6289:                     THIS.CarregarDadosFiscais()
6290:                 ENDIF
6291:             CASE loc_nAba = 5   && Designer
6292:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 5
6293:             CASE loc_nAba = 6   && Consulta P.
6294:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 6
6295:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6296:                     THIS.CarregarConsultaP()
6297:                 ENDIF
6298:             CASE loc_nAba = 7   && Fases
6299:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 7
6300:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6301:                     THIS.CarregarFases()
6302:                 ENDIF
6303:         ENDCASE
6304:     ENDPROC
6305: 
6306:     *--------------------------------------------------------------------------
6307:     * CarregarLista - Busca e exibe lista de produtos no grid
6308:     *--------------------------------------------------------------------------
6309:     PROCEDURE CarregarLista()
6310:         LOCAL loc_oGrid, loc_lResultado, loc_cFiltro, loc_cWhere
6311:         LOCAL loc_cCgru, loc_dIni, loc_dFim, loc_nSit
6312:         loc_lResultado = .F.
6313: 
6314:         TRY
6315:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
6316: 
6317:             *-- Montar filtro a partir dos controles
6318:             loc_cWhere = ""
6319:             loc_cFiltro = ""
6320: 
6321:             *-- Filtro grupo
6322:             loc_cCgru = ""
6323:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6324:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru, "Value", 5)
6325:                     loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
6326:                 ENDIF
6327:             ENDIF
6328: 
6329:             IF !EMPTY(loc_cCgru)
6330:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6331:             ENDIF
6332: 
6333:             *-- Filtro situacao
6334:             loc_nSit = 1
6335:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6336:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6337:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6338:                 ENDIF
6339:             ENDIF
6340: 
6341:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6342:                 IF !EMPTY(loc_cFiltro)
6343:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6344:                 ELSE
6345:                     loc_cFiltro = "p.situas = 1"
6346:                 ENDIF
6347:             ENDIF
6348:             IF loc_nSit = 3   && Apenas inativos (situas=2)
6349:                 IF !EMPTY(loc_cFiltro)

*-- Linhas 6422 a 6465:
6422:     * FormParaBO - Transfere dados do formulario para o Business Object
6423:     * Todos os campos editaveis da aba Principal
6424:     *--------------------------------------------------------------------------
6425:     PROTECTED PROCEDURE FormParaBO()
6426:         LOCAL loc_oBO, loc_oPg
6427:         loc_oBO = THIS.this_oBusinessObject
6428:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6429: 
6430:         *-- Identificacao
6431:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6432:             loc_oBO.this_cCpros  = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
6433:         ENDIF
6434:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6435:             loc_oBO.this_cDpros  = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
6436:         ENDIF
6437:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6438:             loc_oBO.this_cDpro2s = ALLTRIM(loc_oPg.txt_4c_Dpro2s.Value)
6439:         ENDIF
6440: 
6441:         *-- Grupo / Subgrupo
6442:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6443:             loc_oBO.this_cCgrus  = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
6444:         ENDIF
6445:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6446:             loc_oBO.this_cSgrus  = ALLTRIM(loc_oPg.txt_4c_Csgrus.Value)
6447:         ENDIF
6448: 
6449:         *-- Linha / Colecao / Fornecedor / Referencia
6450:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6451:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
6452:         ENDIF
6453:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
6454:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
6455:         ENDIF
6456:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
6457:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
6458:         ENDIF
6459:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
6460:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
6461:         ENDIF
6462: 
6463:         *-- Tipo / Identificador / Conjunto / Equivalente
6464:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
6465:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Mercs.Value)

*-- Linhas 6482 a 6525:
6482:             loc_oBO.this_nEan13 = loc_oPg.txt_4c_Ean13.Value
6483:         ENDIF
6484: 
6485:         *-- Situacao (OptionGroup Value=1=Ativo, Value=2=Inativo -> nSituas)
6486:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6487:             loc_oBO.this_nSituas = loc_oPg.opt_4c_Situas.Value
6488:         ENDIF
6489: 
6490:         *-- Lote Minimo / Qtde
6491:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6492:             loc_oBO.this_nLtminsv = loc_oPg.txt_4c_Ltminsv.Value
6493:         ENDIF
6494:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6495:             loc_oBO.this_nQmins   = loc_oPg.txt_4c_Qmins.Value
6496:         ENDIF
6497:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6498:             loc_oBO.this_nQtped   = loc_oPg.txt_4c_Qtped.Value
6499:         ENDIF
6500: 
6501:         *-- Observacoes curtas
6502:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6503:             loc_oBO.this_cObsetqs = ALLTRIM(loc_oPg.txt_4c_Obsetqs.Value)
6504:         ENDIF
6505:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6506:             loc_oBO.this_cObspeds = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
6507:         ENDIF
6508:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6509:             loc_oBO.this_cObspes  = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
6510:         ENDIF
6511: 
6512:         *-- Custo / Moeda custo
6513:         IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
6514:             loc_oBO.this_nCustofs = loc_oPg.txt_4c_Custofs.Value
6515:         ENDIF
6516:         IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
6517:             loc_oBO.this_cMoecs   = ALLTRIM(loc_oPg.txt_4c_Moecs.Value)
6518:         ENDIF
6519: 
6520:         *-- Preco / Moeda preco
6521:         IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
6522:             loc_oBO.this_nPvens   = loc_oPg.txt_4c_Pvens.Value
6523:         ENDIF
6524:         IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
6525:             loc_oBO.this_cMoepvs  = ALLTRIM(loc_oPg.txt_4c_Moepvs.Value)

*-- Linhas 6730 a 6773:
6730:     * BOParaForm - Transfere dados do Business Object para o formulario
6731:     * Inclui carga de descricoes de campos lookup via SQL
6732:     *--------------------------------------------------------------------------
6733:     PROTECTED PROCEDURE BOParaForm()
6734:         LOCAL loc_oBO, loc_oPg
6735:         loc_oBO = THIS.this_oBusinessObject
6736:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6737: 
6738:         *-- Identificacao
6739:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6740:             loc_oPg.txt_4c_Cpros.Value  = loc_oBO.this_cCpros
6741:         ENDIF
6742:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6743:             loc_oPg.txt_4c_Dpros.Value  = loc_oBO.this_cDpros
6744:         ENDIF
6745:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6746:             loc_oPg.txt_4c_Dpro2s.Value = loc_oBO.this_cDpro2s
6747:         ENDIF
6748: 
6749:         *-- Grupo + descricao
6750:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6751:             loc_oPg.txt_4c_Cgrus.Value = loc_oBO.this_cCgrus
6752:         ENDIF
6753:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
6754:             loc_oPg.txt_4c_Dgrus.Value = THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus")
6755:         ENDIF
6756: 
6757:         *-- Subgrupo + descricao
6758:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6759:             loc_oPg.txt_4c_Csgrus.Value = loc_oBO.this_cSgrus
6760:         ENDIF
6761:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
6762:             loc_oPg.txt_4c_Dsgrus.Value = THIS.CarregarDescSgru(loc_oBO.this_cCgrus, loc_oBO.this_cSgrus)
6763:         ENDIF
6764: 
6765:         *-- Linha + descricao
6766:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6767:             loc_oPg.txt_4c_Linhas.Value  = loc_oBO.this_cLinhas
6768:         ENDIF
6769:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
6770:             loc_oPg.txt_4c_Dlinhas.Value = THIS.CarregarDesc("SigCdLin", "Linhas", loc_oBO.this_cLinhas, "Descs")
6771:         ENDIF
6772: 
6773:         *-- Colecao + descricao

*-- Linhas 6813 a 6856:
6813:             loc_oPg.txt_4c_Ean13.Value = loc_oBO.this_nEan13
6814:         ENDIF
6815: 
6816:         *-- Situacao (nSituas 1=Ativo, 2=Inativo -> OptionGroup.Value)
6817:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6818:             loc_oPg.opt_4c_Situas.Value = IIF(loc_oBO.this_nSituas >= 1, loc_oBO.this_nSituas, 1)
6819:         ENDIF
6820:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6821:             loc_oPg.txt_4c_DtSituas.Value = NVL(loc_oBO.this_dDtsituas, {})
6822:         ENDIF
6823: 
6824:         *-- Lote Minimo / Qtde
6825:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6826:             loc_oPg.txt_4c_Ltminsv.Value = loc_oBO.this_nLtminsv
6827:         ENDIF
6828:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6829:             loc_oPg.txt_4c_Qmins.Value   = loc_oBO.this_nQmins
6830:         ENDIF
6831:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6832:             loc_oPg.txt_4c_Qtped.Value   = loc_oBO.this_nQtped
6833:         ENDIF
6834: 
6835:         *-- Observacoes curtas
6836:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6837:             loc_oPg.txt_4c_Obsetqs.Value = loc_oBO.this_cObsetqs
6838:         ENDIF
6839:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6840:             loc_oPg.txt_4c_Obspeds.Value = loc_oBO.this_cObspeds
6841:         ENDIF
6842:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6843:             loc_oPg.txt_4c_Obspes.Value  = loc_oBO.this_cObspes
6844:         ENDIF
6845: 
6846:         *-- Ultima Compra (ReadOnly)
6847:         IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
6848:             loc_oPg.txt_4c_Dtucp.Value      = NVL(loc_oBO.this_dUltcomps, {})
6849:         ENDIF
6850:         IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
6851:             loc_oPg.txt_4c_Vucp.Value       = loc_oBO.this_nVultcomps
6852:         ENDIF
6853:         IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
6854:             loc_oPg.txt_4c_Mucp.Value       = loc_oBO.this_cMultcomps
6855:         ENDIF
6856:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)

*-- Linhas 7210 a 7253:
7210:     *--------------------------------------------------------------------------
7211:     * LimparCampos - Limpa todos os campos do formulario (aba Principal)
7212:     *--------------------------------------------------------------------------
7213:     PROTECTED PROCEDURE LimparCampos()
7214:         LOCAL loc_oPg
7215:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7216: 
7217:         *-- Identificacao
7218:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7219:             loc_oPg.txt_4c_Cpros.Value  = ""
7220:         ENDIF
7221:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7222:             loc_oPg.txt_4c_Dpros.Value  = ""
7223:         ENDIF
7224:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7225:             loc_oPg.txt_4c_Dpro2s.Value = ""
7226:         ENDIF
7227: 
7228:         *-- Grupo / Subgrupo
7229:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7230:             loc_oPg.txt_4c_Cgrus.Value  = ""
7231:         ENDIF
7232:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
7233:             loc_oPg.txt_4c_Dgrus.Value  = ""
7234:         ENDIF
7235:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7236:             loc_oPg.txt_4c_Csgrus.Value = ""
7237:         ENDIF
7238:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
7239:             loc_oPg.txt_4c_Dsgrus.Value = ""
7240:         ENDIF
7241: 
7242:         *-- Linha / Colecao / Fornecedor / Ref
7243:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7244:             loc_oPg.txt_4c_Linhas.Value    = ""
7245:         ENDIF
7246:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
7247:             loc_oPg.txt_4c_Dlinhas.Value   = ""
7248:         ENDIF
7249:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7250:             loc_oPg.txt_4c_Colecoes.Value  = ""
7251:         ENDIF
7252:         IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
7253:             loc_oPg.txt_4c_Dcolecoes.Value = ""

*-- Linhas 7717 a 7760:
7717:     * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
7718:     * par_lHabilitar: .T. = edicao/inclusao, .F. = visualizacao
7719:     *--------------------------------------------------------------------------
7720:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
7721:         LOCAL loc_oPg, loc_lNovoReg
7722:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7723:         loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")
7724: 
7725:         *-- Codigo: editavel SOMENTE na inclusao (PK nao se altera)
7726:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7727:             loc_oPg.txt_4c_Cpros.ReadOnly = !loc_lNovoReg
7728:         ENDIF
7729: 
7730:         *-- Campos texto editaveis
7731:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7732:             loc_oPg.txt_4c_Dpros.ReadOnly    = !par_lHabilitar
7733:         ENDIF
7734:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7735:             loc_oPg.txt_4c_Dpro2s.ReadOnly   = !par_lHabilitar
7736:         ENDIF
7737:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7738:             loc_oPg.txt_4c_Cgrus.ReadOnly    = !par_lHabilitar
7739:         ENDIF
7740:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7741:             loc_oPg.txt_4c_Csgrus.ReadOnly   = !par_lHabilitar
7742:         ENDIF
7743:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7744:             loc_oPg.txt_4c_Linhas.ReadOnly   = !par_lHabilitar
7745:         ENDIF
7746:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7747:             loc_oPg.txt_4c_Colecoes.ReadOnly = !par_lHabilitar
7748:         ENDIF
7749:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
7750:             loc_oPg.txt_4c_Ifors.ReadOnly    = !par_lHabilitar
7751:         ENDIF
7752:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
7753:             loc_oPg.txt_4c_Reffs.ReadOnly    = !par_lHabilitar
7754:         ENDIF
7755:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
7756:             loc_oPg.txt_4c_Mercs.ReadOnly    = !par_lHabilitar
7757:         ENDIF
7758:         IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
7759:             loc_oPg.txt_4c_Idecpros.ReadOnly  = !par_lHabilitar
7760:         ENDIF

*-- Linhas 7873 a 7916:
7873:             loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
7874:         ENDIF
7875: 
7876:         *-- OptionGroups e CheckBoxes: Enabled
7877:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7878:             loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
7879:         ENDIF
7880:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7881:             loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar
7882:         ENDIF
7883:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
7884:             loc_oPg.opt_4c_Varias.Enabled     = par_lHabilitar
7885:         ENDIF
7886:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7887:             loc_oPg.chk_4c_Chkgarvit.Enabled  = par_lHabilitar
7888:         ENDIF
7889:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
7890:             loc_oPg.chk_4c_Consigs.Enabled    = par_lHabilitar
7891:         ENDIF
7892:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
7893:             loc_oPg.chk_4c_Fabrproprs.Enabled = par_lHabilitar
7894:         ENDIF
7895:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
7896:             loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
7897:         ENDIF
7898: 
7899:         *-- EditBoxes (Memo)
7900:         IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
7901:             loc_oPg.edt_4c_Dsccompras.ReadOnly = !par_lHabilitar
7902:         ENDIF
7903:         IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
7904:             loc_oPg.edt_4c_Dpro3s.ReadOnly     = !par_lHabilitar
7905:         ENDIF
7906:         IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
7907:             loc_oPg.edt_4c_Obscompras.ReadOnly  = !par_lHabilitar
7908:         ENDIF
7909: 
7910:         *-- Tab 7: Fases - campos e botoes de operacao
7911:         LOCAL loc_oPg7
7912:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
7913: 
7914:         IF PEMSTATUS(loc_oPg7, "txt_4c_Qminfab", 5)
7915:             loc_oPg7.txt_4c_Qminfab.ReadOnly   = !par_lHabilitar
7916:         ENDIF

*-- Linhas 7978 a 9271:
7978:     *--------------------------------------------------------------------------
7979:     * BtnIncluirClick - Incluir novo produto
7980:     *--------------------------------------------------------------------------
7981:     PROCEDURE BtnIncluirClick()
7982:         THIS.this_oBusinessObject.NovoRegistro()
7983:         THIS.LimparCampos()
7984:         THIS.this_cModoAtual = "INCLUIR"
7985:         THIS.HabilitarCampos(.T.)
7986:         THIS.AjustarBotoesPorModo()
7987:         THIS.AlternarPagina(2)
7988:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7989:         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7990:     ENDPROC
7991: 
7992:     *--------------------------------------------------------------------------
7993:     * BtnVisualizarClick - Visualizar produto selecionado
7994:     *--------------------------------------------------------------------------
7995:     PROCEDURE BtnVisualizarClick()
7996:         LOCAL loc_cCodigo
7997: 
7998:         IF !USED("cursor_4c_Dados")
7999:             MsgAviso("Nenhum produto selecionado!")
8000:             RETURN
8001:         ENDIF
8002:         IF RECCOUNT("cursor_4c_Dados") = 0
8003:             MsgAviso("Nenhum produto selecionado!")
8004:             RETURN
8005:         ENDIF
8006: 
8007:         SELECT cursor_4c_Dados
8008:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8009: 
8010:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8011:             THIS.BOParaForm()
8012:             THIS.this_cModoAtual = "VISUALIZAR"
8013:             THIS.HabilitarCampos(.F.)
8014:             THIS.AjustarBotoesPorModo()
8015:             THIS.AlternarPagina(2)
8016:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8017:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8018:         ENDIF
8019:     ENDPROC
8020: 
8021:     *--------------------------------------------------------------------------
8022:     * BtnAlterarClick - Alterar produto selecionado
8023:     *--------------------------------------------------------------------------
8024:     PROCEDURE BtnAlterarClick()
8025:         LOCAL loc_cCodigo
8026: 
8027:         IF !USED("cursor_4c_Dados")
8028:             MsgAviso("Nenhum produto selecionado!")
8029:             RETURN
8030:         ENDIF
8031:         IF RECCOUNT("cursor_4c_Dados") = 0
8032:             MsgAviso("Nenhum produto selecionado!")
8033:             RETURN
8034:         ENDIF
8035: 
8036:         SELECT cursor_4c_Dados
8037:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8038: 
8039:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8040:             THIS.this_oBusinessObject.EditarRegistro()
8041:             THIS.BOParaForm()
8042:             THIS.this_cModoAtual = "ALTERAR"
8043:             THIS.HabilitarCampos(.T.)
8044:             THIS.AjustarBotoesPorModo()
8045:             THIS.AlternarPagina(2)
8046:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8047:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8048:         ENDIF
8049:     ENDPROC
8050: 
8051:     *--------------------------------------------------------------------------
8052:     * BtnExcluirClick - Excluir produto selecionado
8053:     * Legado: verifica se produto e usado em pedidos/fichas tecnicas
8054:     *--------------------------------------------------------------------------
8055:     PROCEDURE BtnExcluirClick()
8056:         LOCAL loc_cCodigo, loc_cSQL, loc_nResultado
8057: 
8058:         IF !USED("cursor_4c_Dados")
8059:             MsgAviso("Nenhum produto selecionado!")
8060:             RETURN
8061:         ENDIF
8062:         IF RECCOUNT("cursor_4c_Dados") = 0
8063:             MsgAviso("Nenhum produto selecionado!")
8064:             RETURN
8065:         ENDIF
8066: 
8067:         SELECT cursor_4c_Dados
8068:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8069: 
8070:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8071: 
8072:             *-- Verificar uso em itens de pedido (SigMvCIte)
8073:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8074:                 SELECT COUNT(*) AS nExiste
8075:                 FROM SigMvCIte
8076:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8077:             ENDTEXT
8078: 
8079:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8080: 
8081:             IF loc_nResultado < 0
8082:                 MsgErro("Falha ao verificar uso do produto!")
8083:                 IF USED("cursor_4c_VerPro")
8084:                     USE IN cursor_4c_VerPro
8085:                 ENDIF
8086:                 RETURN
8087:             ENDIF
8088: 
8089:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8090:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8091:                 IF USED("cursor_4c_VerPro")
8092:                     USE IN cursor_4c_VerPro
8093:                 ENDIF
8094:                 RETURN
8095:             ENDIF
8096: 
8097:             IF USED("cursor_4c_VerPro")
8098:                 USE IN cursor_4c_VerPro
8099:             ENDIF
8100: 
8101:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCodigo + "'?")
8102:                 IF THIS.this_oBusinessObject.Excluir()
8103:                     MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
8104:                     THIS.CarregarLista()
8105:                 ENDIF
8106:             ENDIF
8107:         ENDIF
8108:     ENDPROC
8109: 
8110:     *--------------------------------------------------------------------------
8111:     * BtnSalvarClick - Salvar produto
8112:     *--------------------------------------------------------------------------
8113:     PROCEDURE BtnSalvarClick()
8114:         LOCAL loc_oPg, loc_cCodNovo, loc_cSQLDup, loc_nDup
8115: 
8116:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8117: 
8118:         *-- Validacao: codigo obrigatorio
8119:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8120:             IF EMPTY(loc_oPg.txt_4c_Cpros.Value)
8121:                 MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o pode ficar em branco!")
8122:                 IF PEMSTATUS(loc_oPg.txt_4c_Cpros, "SetFocus", 5)
8123:                     loc_oPg.txt_4c_Cpros.SetFocus()
8124:                 ENDIF
8125:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8126:                 THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8127:                 RETURN
8128:             ENDIF
8129:         ENDIF
8130: 
8131:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
8132:         IF THIS.this_cModoAtual = "INCLUIR"
8133:             IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8134:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8135: 
8136:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8137:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8138:                 ENDTEXT
8139: 
8140:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8141: 
8142:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8143:                     IF USED("cursor_4c_DupPro")
8144:                         USE IN cursor_4c_DupPro
8145:                     ENDIF
8146:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8147:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8148:                         loc_oPg.txt_4c_Cpros.SetFocus()
8149:                     ENDIF
8150:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8151:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8152:                     RETURN
8153:                 ENDIF
8154: 
8155:                 IF USED("cursor_4c_DupPro")
8156:                     USE IN cursor_4c_DupPro
8157:                 ENDIF
8158:             ENDIF
8159:         ENDIF
8160: 
8161:         THIS.FormParaBO()
8162: 
8163:         IF THIS.this_oBusinessObject.Salvar()
8164:             MsgSucesso("Produto salvo com sucesso!")
8165:             THIS.AlternarPagina(1)
8166:             THIS.CarregarLista()
8167:         ENDIF
8168:     ENDPROC
8169: 
8170:     *--------------------------------------------------------------------------
8171:     * BtnCancelarClick - Cancelar edicao
8172:     *--------------------------------------------------------------------------
8173:     PROCEDURE BtnCancelarClick()
8174:         THIS.this_cModoAtual = "LISTA"
8175:         THIS.AlternarPagina(1)
8176:         THIS.CarregarLista()
8177:     ENDPROC
8178: 
8179:     *--------------------------------------------------------------------------
8180:     * BtnBuscarClick - Abre FormBuscaAuxiliar para busca de produtos
8181:     *--------------------------------------------------------------------------
8182:     PROCEDURE BtnBuscarClick()
8183:         LOCAL loc_oBusca, loc_cCodigo
8184: 
8185:         TRY
8186:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
8187: 
8188:             loc_oBusca.mAddColuna("cpros", "", "Produto")
8189:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8190:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8191: 
8192:             loc_oBusca.Show()
8193: 
8194:             IF loc_oBusca.this_lSelecionou
8195:                 IF USED("cursor_4c_Busca")
8196:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
8197: 
8198:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8199:                         THIS.BOParaForm()
8200:                         THIS.this_cModoAtual = "VISUALIZAR"
8201:                         THIS.HabilitarCampos(.F.)
8202:                         THIS.AjustarBotoesPorModo()
8203:                         THIS.AlternarPagina(2)
8204:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8205:                         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8206:                     ENDIF
8207:                 ENDIF
8208:             ENDIF
8209: 
8210:             IF USED("cursor_4c_Busca")
8211:                 USE IN cursor_4c_Busca
8212:             ENDIF
8213:             loc_oBusca.Release()
8214: 
8215:         CATCH TO loc_oErro
8216:             MsgErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.BtnBuscarClick")
8217:         ENDTRY
8218:     ENDPROC
8219: 
8220:     *--------------------------------------------------------------------------
8221:     * BtnEncerrarClick - Fechar formulario
8222:     *--------------------------------------------------------------------------
8223:     PROCEDURE BtnEncerrarClick()
8224:         THIS.Release()
8225:     ENDPROC
8226: 
8227:     *--------------------------------------------------------------------------
8228:     * BtnPesquisarClick - Recarregar lista com filtros aplicados
8229:     *--------------------------------------------------------------------------
8230:     PROCEDURE BtnPesquisarClick()
8231:         THIS.CarregarLista()
8232:     ENDPROC
8233: 
8234:     *--------------------------------------------------------------------------
8235:     * GrdLista_DblClick - Duplo clique na grade abre visualizacao
8236:     *--------------------------------------------------------------------------
8237:     PROCEDURE GrdLista_DblClick()
8238:         THIS.BtnVisualizarClick()
8239:     ENDPROC
8240: 
8241:     *--------------------------------------------------------------------------
8242:     * FiltroGrupo_KeyPress - F4 no filtro de grupo abre lookup de grupos
8243:     *--------------------------------------------------------------------------
8244:     PROCEDURE FiltroGrupo_KeyPress
8245:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8246:         IF par_nKeyCode = 115    && F4=115 (VFP9)
8247:             THIS.AbrirLookupFiltroGrupo()
8248:         ENDIF
8249:     ENDPROC
8250: 
8251:     *--------------------------------------------------------------------------
8252:     * ValidarFiltroGrupo - LostFocus no filtro de grupo
8253:     *--------------------------------------------------------------------------
8254:     PROCEDURE ValidarFiltroGrupo()
8255:         LOCAL loc_cCgru, loc_cSQL, loc_nRes, loc_oBusca
8256:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8257: 
8258:         IF loc_cCgru == THIS.this_cUltFiltroGru
8259:             RETURN
8260:         ENDIF
8261:         THIS.this_cUltFiltroGru = loc_cCgru
8262: 
8263:         IF EMPTY(loc_cCgru)
8264:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8265:             RETURN
8266:         ENDIF
8267: 
8268:         TRY
8269:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8270:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8271:             ENDTEXT
8272: 
8273:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8274: 
8275:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8276:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8277:             ELSE
8278:                 *-- Codigo nao encontrado: abrir lookup
8279:                 THIS.AbrirLookupFiltroGrupo()
8280:             ENDIF
8281: 
8282:             IF USED("cursor_4c_VerGru")
8283:                 USE IN cursor_4c_VerGru
8284:             ENDIF
8285:         CATCH TO loc_oErro
8286:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8287:         ENDTRY
8288:     ENDPROC
8289: 
8290:     *--------------------------------------------------------------------------
8291:     * AbrirLookupFiltroGrupo - Lookup F4 no filtro de grupo
8292:     *--------------------------------------------------------------------------
8293:     PROTECTED PROCEDURE AbrirLookupFiltroGrupo()
8294:         LOCAL loc_oBusca, loc_cValor
8295:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8296: 
8297:         TRY
8298:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Gru", "cgrus", loc_cValor, "Selecionar Grupo")
8299:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8300:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8301:             loc_oBusca.Show()
8302: 
8303:             IF loc_oBusca.this_lSelecionou
8304:                 IF USED("cursor_4c_Gru")
8305:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ALLTRIM(cursor_4c_Gru.cgrus)
8306:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_Gru.dgrus)
8307:                 ENDIF
8308:             ELSE
8309:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ""
8310:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8311:             ENDIF
8312: 
8313:             IF USED("cursor_4c_Gru")
8314:                 USE IN cursor_4c_Gru
8315:             ENDIF
8316:             loc_oBusca.Release()
8317:         CATCH TO loc_oErro
8318:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFiltroGrupo")
8319:         ENDTRY
8320:     ENDPROC
8321: 
8322:     *--------------------------------------------------------------------------
8323:     * FiltroSituas_InteractiveChange - Mudar filtro de situacao
8324:     *--------------------------------------------------------------------------
8325:     PROCEDURE FiltroSituas_InteractiveChange()
8326:         THIS.CarregarLista()
8327:     ENDPROC
8328: 
8329:     *--------------------------------------------------------------------------
8330:     * FormatarGridLista - Formata visual do grid da lista
8331:     *--------------------------------------------------------------------------
8332:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
8333:         WITH par_oGrid
8334:             IF .ColumnCount > 0
8335:                 .FontName = "Tahoma"
8336:                 .FontSize = 8
8337:             ENDIF
8338:         ENDWITH
8339:     ENDPROC
8340: 
8341:     *--------------------------------------------------------------------------
8342:     * TornarControlesVisiveis - Torna todos os controles visiveis
8343:     * Filtra por nome para evitar tornar containers flutuantes visiveis
8344:     *--------------------------------------------------------------------------
8345:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
8346:         LOCAL loc_nI, loc_oObjeto, loc_cNome
8347: 
8348:         FOR loc_nI = 1 TO par_oContainer.ControlCount
8349:             loc_oObjeto = par_oContainer.Controls(loc_nI)
8350: 
8351:             IF VARTYPE(loc_oObjeto) = "O"
8352:                 loc_cNome = LOWER(loc_oObjeto.Name)
8353: 
8354:                 *-- Nao tornar visiveis containers flutuantes (Visible=.F. por design)
8355:                 IF INLIST(loc_cNome, "cntmensagem", "cntacabado", "cnt_4c_cabecalho")
8356:                     LOOP
8357:                 ENDIF
8358: 
8359:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
8360:                     loc_oObjeto.Visible = .T.
8361:                 ENDIF
8362: 
8363:                 *-- Trata PageFrame - itera Pages
8364:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
8365:                     LOCAL loc_nP
8366:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
8367:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
8368:                     ENDFOR
8369:                 ENDIF
8370: 
8371:                 *-- Trata containers com ControlCount
8372:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
8373:                     THIS.TornarControlesVisiveis(loc_oObjeto)
8374:                 ENDIF
8375:             ENDIF
8376:         ENDFOR
8377:     ENDPROC
8378: 
8379:     *--------------------------------------------------------------------------
8380:     * Destroy - Limpar recursos ao fechar
8381:     *--------------------------------------------------------------------------
8382:     PROCEDURE Destroy()
8383:         IF USED("cursor_4c_Dados")
8384:             USE IN cursor_4c_Dados
8385:         ENDIF
8386:         IF USED("cursor_4c_Busca")
8387:             USE IN cursor_4c_Busca
8388:         ENDIF
8389:         IF USED("cursor_4c_Registro")
8390:             USE IN cursor_4c_Registro
8391:         ENDIF
8392: 
8393:         IF !ISNULL(THIS.this_oBusinessObject)
8394:             THIS.this_oBusinessObject = .NULL.
8395:         ENDIF
8396: 
8397:         DODEFAULT()
8398:     ENDPROC
8399: 
8400:     *==========================================================================
8401:     * === METODOS PUBLICOS DE LOOKUP / VALIDACAO (Tab Principal) ==============
8402:     * BINDEVENT requer metodos PUBLIC
8403:     *==========================================================================
8404: 
8405:     *--------------------------------------------------------------------------
8406:     * TabPrincipal_CgruKeyPress - F4 no campo Grupo abre lookup
8407:     *--------------------------------------------------------------------------
8408:     PROCEDURE TabPrincipal_CgruKeyPress
8409:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8410:         IF par_nKeyCode = 115    && F4=115 em VFP9
8411:             THIS.AbrirLookupGrupo()
8412:         ENDIF
8413:     ENDPROC
8414: 
8415:     *--------------------------------------------------------------------------
8416:     * TabPrincipal_CgruLostFocus - LostFocus valida e carrega descricao do grupo
8417:     *--------------------------------------------------------------------------
8418:     PROCEDURE TabPrincipal_CgruLostFocus()
8419:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8420:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8421:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8422:             RETURN
8423:         ENDIF
8424:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8425: 
8426:         IF loc_cCod == THIS.this_cUltCgrus
8427:             RETURN
8428:         ENDIF
8429:         THIS.this_cUltCgrus = loc_cCod
8430: 
8431:         IF EMPTY(loc_cCod)
8432:             IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8433:                 loc_oPg.txt_4c_Dgrus.Value = ""
8434:             ENDIF
8435:             RETURN
8436:         ENDIF
8437: 
8438:         TRY
8439:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8440:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8441:             ENDTEXT
8442:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8443:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8444:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8445:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8446:                 ENDIF
8447:             ELSE
8448:                 THIS.AbrirLookupGrupo()
8449:             ENDIF
8450:             IF USED("cursor_4c_VGrp")
8451:                 USE IN cursor_4c_VGrp
8452:             ENDIF
8453:         CATCH TO loc_oErro
8454:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8455:         ENDTRY
8456:     ENDPROC
8457: 
8458:     *--------------------------------------------------------------------------
8459:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
8460:     *--------------------------------------------------------------------------
8461:     PROTECTED PROCEDURE AbrirLookupGrupo()
8462:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8463:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8464:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5), ALLTRIM(loc_oPg.txt_4c_Cgrus.Value), "")
8465: 
8466:         TRY
8467:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Grp", "cgrus", loc_cVal, "Selecionar Grupo")
8468:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8469:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8470:             loc_oBusca.Show()
8471: 
8472:             IF loc_oBusca.this_lSelecionou
8473:                 IF USED("cursor_4c_Grp")
8474:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8475:                         loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(cursor_4c_Grp.cgrus)
8476:                     ENDIF
8477:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8478:                         loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_Grp.dgrus)
8479:                     ENDIF
8480:                 ENDIF
8481:             ELSE
8482:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8483:                     loc_oPg.txt_4c_Cgrus.Value = ""
8484:                 ENDIF
8485:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8486:                     loc_oPg.txt_4c_Dgrus.Value = ""
8487:                 ENDIF
8488:             ENDIF
8489: 
8490:             IF USED("cursor_4c_Grp")
8491:                 USE IN cursor_4c_Grp
8492:             ENDIF
8493:             loc_oBusca.Release()
8494:         CATCH TO loc_oErro
8495:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGrupo")
8496:         ENDTRY
8497:     ENDPROC
8498: 
8499:     *--------------------------------------------------------------------------
8500:     * TabPrincipal_LinhasKeyPress - F4 no campo Linha abre lookup
8501:     *--------------------------------------------------------------------------
8502:     PROCEDURE TabPrincipal_LinhasKeyPress
8503:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8504:         IF par_nKeyCode = 115
8505:             THIS.AbrirLookupLinha()
8506:         ENDIF
8507:     ENDPROC
8508: 
8509:     *--------------------------------------------------------------------------
8510:     * TabPrincipal_LinhasLostFocus - LostFocus valida e carrega descricao da linha
8511:     *--------------------------------------------------------------------------
8512:     PROCEDURE TabPrincipal_LinhasLostFocus()
8513:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8514:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8515:         IF !PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8516:             RETURN
8517:         ENDIF
8518:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
8519: 
8520:         IF loc_cCod == THIS.this_cUltLinhas
8521:             RETURN
8522:         ENDIF
8523:         THIS.this_cUltLinhas = loc_cCod
8524: 
8525:         IF EMPTY(loc_cCod)
8526:             IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8527:                 loc_oPg.txt_4c_Dlinhas.Value = ""
8528:             ENDIF
8529:             RETURN
8530:         ENDIF
8531: 
8532:         TRY
8533:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8534:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8535:             ENDTEXT
8536:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8537:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8538:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8539:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8540:                 ENDIF
8541:             ELSE
8542:                 THIS.AbrirLookupLinha()
8543:             ENDIF
8544:             IF USED("cursor_4c_VLin")
8545:                 USE IN cursor_4c_VLin
8546:             ENDIF
8547:         CATCH TO loc_oErro
8548:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8549:         ENDTRY
8550:     ENDPROC
8551: 
8552:     *--------------------------------------------------------------------------
8553:     * AbrirLookupLinha - Abre FormBuscaAuxiliar para selecionar linha de produto
8554:     *--------------------------------------------------------------------------
8555:     PROTECTED PROCEDURE AbrirLookupLinha()
8556:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8557:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8558:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5), ALLTRIM(loc_oPg.txt_4c_Linhas.Value), "")
8559: 
8560:         TRY
8561:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Lin", "Linhas", loc_cVal, "Selecionar Linha")
8562:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
8563:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
8564:             loc_oBusca.Show()
8565: 
8566:             IF loc_oBusca.this_lSelecionou
8567:                 IF USED("cursor_4c_Lin")
8568:                     IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8569:                         loc_oPg.txt_4c_Linhas.Value  = ALLTRIM(cursor_4c_Lin.Linhas)
8570:                     ENDIF
8571:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8572:                         loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_Lin.Descs)
8573:                     ENDIF
8574:                 ENDIF
8575:             ELSE
8576:                 IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8577:                     loc_oPg.txt_4c_Linhas.Value  = ""
8578:                 ENDIF
8579:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8580:                     loc_oPg.txt_4c_Dlinhas.Value = ""
8581:                 ENDIF
8582:             ENDIF
8583: 
8584:             IF USED("cursor_4c_Lin")
8585:                 USE IN cursor_4c_Lin
8586:             ENDIF
8587:             loc_oBusca.Release()
8588:         CATCH TO loc_oErro
8589:             MsgErro("Erro no lookup de linha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupLinha")
8590:         ENDTRY
8591:     ENDPROC
8592: 
8593:     *--------------------------------------------------------------------------
8594:     * TabPrincipal_ColecoesKeyPress - F4 no campo Grupo de Venda abre lookup
8595:     *--------------------------------------------------------------------------
8596:     PROCEDURE TabPrincipal_ColecoesKeyPress
8597:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8598:         IF par_nKeyCode = 115
8599:             THIS.AbrirLookupColecao()
8600:         ENDIF
8601:     ENDPROC
8602: 
8603:     *--------------------------------------------------------------------------
8604:     * TabPrincipal_ColecoesLostFocus - LostFocus valida e carrega descricao
8605:     *--------------------------------------------------------------------------
8606:     PROCEDURE TabPrincipal_ColecoesLostFocus()
8607:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8608:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8609:         IF !PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8610:             RETURN
8611:         ENDIF
8612:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
8613: 
8614:         IF loc_cCod == THIS.this_cUltColecoes
8615:             RETURN
8616:         ENDIF
8617:         THIS.this_cUltColecoes = loc_cCod
8618: 
8619:         IF EMPTY(loc_cCod)
8620:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8621:                 loc_oPg.txt_4c_Dcolecoes.Value = ""
8622:             ENDIF
8623:             RETURN
8624:         ENDIF
8625: 
8626:         TRY
8627:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8628:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8629:             ENDTEXT
8630:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8631:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8632:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8633:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8634:                 ENDIF
8635:             ELSE
8636:                 THIS.AbrirLookupColecao()
8637:             ENDIF
8638:             IF USED("cursor_4c_VCol")
8639:                 USE IN cursor_4c_VCol
8640:             ENDIF
8641:         CATCH TO loc_oErro
8642:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8643:         ENDTRY
8644:     ENDPROC
8645: 
8646:     *--------------------------------------------------------------------------
8647:     * AbrirLookupColecao - Abre FormBuscaAuxiliar para selecionar grupo de venda
8648:     *--------------------------------------------------------------------------
8649:     PROTECTED PROCEDURE AbrirLookupColecao()
8650:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8651:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8652:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5), ALLTRIM(loc_oPg.txt_4c_Colecoes.Value), "")
8653: 
8654:         TRY
8655:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Col", "Colecoes", loc_cVal, "Selecionar Grupo de Venda")
8656:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
8657:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
8658:             loc_oBusca.Show()
8659: 
8660:             IF loc_oBusca.this_lSelecionou
8661:                 IF USED("cursor_4c_Col")
8662:                     IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8663:                         loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(cursor_4c_Col.Colecoes)
8664:                     ENDIF
8665:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8666:                         loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_Col.Descs)
8667:                     ENDIF
8668:                 ENDIF
8669:             ELSE
8670:                 IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8671:                     loc_oPg.txt_4c_Colecoes.Value  = ""
8672:                 ENDIF
8673:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8674:                     loc_oPg.txt_4c_Dcolecoes.Value = ""
8675:                 ENDIF
8676:             ENDIF
8677: 
8678:             IF USED("cursor_4c_Col")
8679:                 USE IN cursor_4c_Col
8680:             ENDIF
8681:             loc_oBusca.Release()
8682:         CATCH TO loc_oErro
8683:             MsgErro("Erro no lookup de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupColecao")
8684:         ENDTRY
8685:     ENDPROC
8686: 
8687:     *--------------------------------------------------------------------------
8688:     * TabPrincipal_IforsKeyPress - F4 no campo Fornecedor abre lookup
8689:     *--------------------------------------------------------------------------
8690:     PROCEDURE TabPrincipal_IforsKeyPress
8691:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8692:         IF par_nKeyCode = 115
8693:             THIS.AbrirLookupFornecedor()
8694:         ENDIF
8695:     ENDPROC
8696: 
8697:     *--------------------------------------------------------------------------
8698:     * TabPrincipal_IforsLostFocus - LostFocus valida e carrega nome do fornecedor
8699:     *--------------------------------------------------------------------------
8700:     PROCEDURE TabPrincipal_IforsLostFocus()
8701:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8702:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8703:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8704:             RETURN
8705:         ENDIF
8706:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
8707: 
8708:         IF loc_cCod == THIS.this_cUltIfors
8709:             RETURN
8710:         ENDIF
8711:         THIS.this_cUltIfors = loc_cCod
8712: 
8713:         IF EMPTY(loc_cCod)
8714:             IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8715:                 loc_oPg.txt_4c_Dfors.Value = ""
8716:             ENDIF
8717:             RETURN
8718:         ENDIF
8719: 
8720:         TRY
8721:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8722:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8723:             ENDTEXT
8724:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8725:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8726:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8727:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8728:                 ENDIF
8729:             ELSE
8730:                 THIS.AbrirLookupFornecedor()
8731:             ENDIF
8732:             IF USED("cursor_4c_VFor")
8733:                 USE IN cursor_4c_VFor
8734:             ENDIF
8735:         CATCH TO loc_oErro
8736:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8737:         ENDTRY
8738:     ENDPROC
8739: 
8740:     *--------------------------------------------------------------------------
8741:     * AbrirLookupFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
8742:     *--------------------------------------------------------------------------
8743:     PROTECTED PROCEDURE AbrirLookupFornecedor()
8744:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8745:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8746:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5), ALLTRIM(loc_oPg.txt_4c_Ifors.Value), "")
8747: 
8748:         TRY
8749:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_For", "IClis", loc_cVal, "Selecionar Fornecedor")
8750:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
8751:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
8752:             loc_oBusca.Show()
8753: 
8754:             IF loc_oBusca.this_lSelecionou
8755:                 IF USED("cursor_4c_For")
8756:                     IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8757:                         loc_oPg.txt_4c_Ifors.Value = ALLTRIM(cursor_4c_For.IClis)
8758:                     ENDIF
8759:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8760:                         loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_For.Rclis)
8761:                     ENDIF
8762:                 ENDIF
8763:             ELSE
8764:                 IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8765:                     loc_oPg.txt_4c_Ifors.Value = ""
8766:                 ENDIF
8767:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8768:                     loc_oPg.txt_4c_Dfors.Value = ""
8769:                 ENDIF
8770:             ENDIF
8771: 
8772:             IF USED("cursor_4c_For")
8773:                 USE IN cursor_4c_For
8774:             ENDIF
8775:             loc_oBusca.Release()
8776:         CATCH TO loc_oErro
8777:             MsgErro("Erro no lookup de fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFornecedor")
8778:         ENDTRY
8779:     ENDPROC
8780: 
8781:     *--------------------------------------------------------------------------
8782:     * TabPrincipal_CproeqsKeyPress - F4 no campo Produto Equivalente
8783:     *--------------------------------------------------------------------------
8784:     PROCEDURE TabPrincipal_CproeqsKeyPress
8785:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8786:         IF par_nKeyCode = 115
8787:             THIS.AbrirLookupEquivalente()
8788:         ENDIF
8789:     ENDPROC
8790: 
8791:     *--------------------------------------------------------------------------
8792:     * AbrirLookupEquivalente - Abre FormBuscaAuxiliar para produto equivalente
8793:     *--------------------------------------------------------------------------
8794:     PROTECTED PROCEDURE AbrirLookupEquivalente()
8795:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8796:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8797:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5), ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value), "")
8798: 
8799:         TRY
8800:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Eq", "cpros", loc_cVal, "Selecionar Produto Equivalente")
8801:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8802:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8803:             loc_oBusca.Show()
8804: 
8805:             IF loc_oBusca.this_lSelecionou
8806:                 IF USED("cursor_4c_Eq")
8807:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8808:                         loc_oPg.txt_4c_Cproeqs.Value = ALLTRIM(cursor_4c_Eq.cpros)
8809:                     ENDIF
8810:                 ENDIF
8811:             ELSE
8812:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8813:                     loc_oPg.txt_4c_Cproeqs.Value = ""
8814:                 ENDIF
8815:             ENDIF
8816: 
8817:             IF USED("cursor_4c_Eq")
8818:                 USE IN cursor_4c_Eq
8819:             ENDIF
8820:             loc_oBusca.Release()
8821:         CATCH TO loc_oErro
8822:             MsgErro("Erro no lookup de equivalente:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupEquivalente")
8823:         ENDTRY
8824:     ENDPROC
8825: 
8826:     *--------------------------------------------------------------------------
8827:     * TabPrincipal_MoeKeyPress - F4 nos campos de moeda abre lookup
8828:     *--------------------------------------------------------------------------
8829:     PROCEDURE TabPrincipal_MoeKeyPress
8830:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8831:         IF par_nKeyCode = 115
8832:             THIS.AbrirLookupMoeda()
8833:         ENDIF
8834:     ENDPROC
8835: 
8836:     *--------------------------------------------------------------------------
8837:     * TabPrincipal_MoeLostFocus - LostFocus nos campos de moeda (sem acao)
8838:     * Validacao de moeda ocorre no BO.Validar() ao salvar
8839:     *--------------------------------------------------------------------------
8840:     PROCEDURE TabPrincipal_MoeLostFocus()
8841:         RETURN
8842:     ENDPROC
8843: 
8844:     *--------------------------------------------------------------------------
8845:     * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecionar moeda
8846:     *--------------------------------------------------------------------------
8847:     PROTECTED PROCEDURE AbrirLookupMoeda()
8848:         LOCAL loc_oBusca, loc_oPg, loc_cMoeCod
8849:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8850: 
8851:         TRY
8852:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_Moe", "CMoes", "", "Selecionar Moeda")
8853:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
8854:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
8855:             loc_oBusca.Show()
8856: 
8857:             IF loc_oBusca.this_lSelecionou
8858:                 IF USED("cursor_4c_Moe")
8859:                     loc_cMoeCod = ALLTRIM(cursor_4c_Moe.CMoes)
8860:                     *-- Aplicar ao campo de moeda que nao estiver ReadOnly
8861:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
8862:                         IF !loc_oPg.txt_4c_Moecs.ReadOnly
8863:                             loc_oPg.txt_4c_Moecs.Value = loc_cMoeCod
8864:                         ENDIF
8865:                     ENDIF
8866:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
8867:                         IF !loc_oPg.txt_4c_Moepvs.ReadOnly
8868:                             loc_oPg.txt_4c_Moepvs.Value = loc_cMoeCod
8869:                         ENDIF
8870:                     ENDIF
8871:                 ENDIF
8872:             ENDIF
8873: 
8874:             IF USED("cursor_4c_Moe")
8875:                 USE IN cursor_4c_Moe
8876:             ENDIF
8877:             loc_oBusca.Release()
8878:         CATCH TO loc_oErro
8879:             MsgErro("Erro no lookup de moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupMoeda")
8880:         ENDTRY
8881:     ENDPROC
8882: 
8883:     *--------------------------------------------------------------------------
8884:     * TabPrincipal_CunisKeyPress - F4 no campo Unidade 1 abre lookup
8885:     *--------------------------------------------------------------------------
8886:     PROCEDURE TabPrincipal_CunisKeyPress
8887:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8888:         IF par_nKeyCode = 115
8889:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8890:         ENDIF
8891:     ENDPROC
8892: 
8893:     *--------------------------------------------------------------------------
8894:     * TabPrincipal_CunisLostFocus - LostFocus valida unidade 1
8895:     *--------------------------------------------------------------------------
8896:     PROCEDURE TabPrincipal_CunisLostFocus()
8897:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8898:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8899:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
8900:             RETURN
8901:         ENDIF
8902:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
8903: 
8904:         IF loc_cCod == THIS.this_cUltCunis
8905:             RETURN
8906:         ENDIF
8907:         THIS.this_cUltCunis = loc_cCod
8908: 
8909:         IF EMPTY(loc_cCod)
8910:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8911:                 loc_oPg.txt_4c_Dunis.Value = ""
8912:             ENDIF
8913:             RETURN
8914:         ENDIF
8915: 
8916:         TRY
8917:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8918:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8919:             ENDTEXT
8920:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8921:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8922:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8923:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8924:                 ENDIF
8925:             ELSE
8926:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8927:             ENDIF
8928:             IF USED("cursor_4c_VUni")
8929:                 USE IN cursor_4c_VUni
8930:             ENDIF
8931:         CATCH TO loc_oErro
8932:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8933:         ENDTRY
8934:     ENDPROC
8935: 
8936:     *--------------------------------------------------------------------------
8937:     * TabPrincipal_CunipsKeyPress - F4 no campo Unidade 2 abre lookup
8938:     *--------------------------------------------------------------------------
8939:     PROCEDURE TabPrincipal_CunipsKeyPress
8940:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8941:         IF par_nKeyCode = 115
8942:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8943:         ENDIF
8944:     ENDPROC
8945: 
8946:     *--------------------------------------------------------------------------
8947:     * TabPrincipal_CunipsLostFocus - LostFocus valida unidade 2
8948:     *--------------------------------------------------------------------------
8949:     PROCEDURE TabPrincipal_CunipsLostFocus()
8950:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8951:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8952:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
8953:             RETURN
8954:         ENDIF
8955:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)
8956: 
8957:         IF loc_cCod == THIS.this_cUltCunips
8958:             RETURN
8959:         ENDIF
8960:         THIS.this_cUltCunips = loc_cCod
8961: 
8962:         IF EMPTY(loc_cCod)
8963:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8964:                 loc_oPg.txt_4c_Dunips.Value = ""
8965:             ENDIF
8966:             RETURN
8967:         ENDIF
8968: 
8969:         TRY
8970:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8971:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8972:             ENDTEXT
8973:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8974:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8975:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8976:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8977:                 ENDIF
8978:             ELSE
8979:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8980:             ENDIF
8981:             IF USED("cursor_4c_VUn2")
8982:                 USE IN cursor_4c_VUn2
8983:             ENDIF
8984:         CATCH TO loc_oErro
8985:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8986:         ENDTRY
8987:     ENDPROC
8988: 
8989:     *--------------------------------------------------------------------------
8990:     * AbrirLookupUnidade - Abre FormBuscaAuxiliar para selecionar unidade
8991:     * par_cKeyField: campo chave na SigCdUni
8992:     * par_cTxtCode: nome do TextBox de codigo na Page1
8993:     * par_cTxtDesc: nome do TextBox de descricao na Page1
8994:     *--------------------------------------------------------------------------
8995:     PROTECTED PROCEDURE AbrirLookupUnidade(par_cKeyField, par_cTxtCode, par_cTxtDesc)
8996:         LOCAL loc_oBusca, loc_oPg, loc_cVal, loc_cTxtCodeRef, loc_cTxtDescRef
8997:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8998:         loc_cVal = IIF(PEMSTATUS(loc_oPg, par_cTxtCode, 5), ALLTRIM(loc_oPg.&par_cTxtCode..Value), "")
8999: 
9000:         TRY
9001:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", "cursor_4c_Uni", par_cKeyField, loc_cVal, "Selecionar Unidade")
9002:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
9003:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
9004:             loc_oBusca.Show()
9005: 
9006:             IF loc_oBusca.this_lSelecionou
9007:                 IF USED("cursor_4c_Uni")
9008:                     IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
9009:                         loc_oPg.&par_cTxtCode..Value = ALLTRIM(cursor_4c_Uni.cunis)
9010:                     ENDIF
9011:                     IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
9012:                         loc_oPg.&par_cTxtDesc..Value = ALLTRIM(cursor_4c_Uni.dunis)
9013:                     ENDIF
9014:                 ENDIF
9015:             ELSE
9016:                 IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
9017:                     loc_oPg.&par_cTxtCode..Value = ""
9018:                 ENDIF
9019:                 IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
9020:                     loc_oPg.&par_cTxtDesc..Value = ""
9021:                 ENDIF
9022:             ENDIF
9023: 
9024:             IF USED("cursor_4c_Uni")
9025:                 USE IN cursor_4c_Uni
9026:             ENDIF
9027:             loc_oBusca.Release()
9028:         CATCH TO loc_oErro
9029:             MsgErro("Erro no lookup de unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupUnidade")
9030:         ENDTRY
9031:     ENDPROC
9032: 
9033:     *--------------------------------------------------------------------------
9034:     * TabPrincipal_CodacbsKeyPress - F4 no campo Acabamento abre lookup
9035:     *--------------------------------------------------------------------------
9036:     PROCEDURE TabPrincipal_CodacbsKeyPress
9037:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9038:         IF par_nKeyCode = 115
9039:             THIS.AbrirLookupAcabamento()
9040:         ENDIF
9041:     ENDPROC
9042: 
9043:     *--------------------------------------------------------------------------
9044:     * TabPrincipal_CodacbsLostFocus - LostFocus valida acabamento
9045:     *--------------------------------------------------------------------------
9046:     PROCEDURE TabPrincipal_CodacbsLostFocus()
9047:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9048:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9049:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9050:             RETURN
9051:         ENDIF
9052:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)
9053: 
9054:         IF loc_cCod == THIS.this_cUltCodacbs
9055:             RETURN
9056:         ENDIF
9057:         THIS.this_cUltCodacbs = loc_cCod
9058: 
9059:         IF EMPTY(loc_cCod)
9060:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9061:                 loc_oPg.txt_4c_Dcodacbs.Value = ""
9062:             ENDIF
9063:             RETURN
9064:         ENDIF
9065: 
9066:         TRY
9067:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9068:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
9069:             ENDTEXT
9070:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
9071:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
9072:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9073:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
9074:                 ENDIF
9075:             ELSE
9076:                 THIS.AbrirLookupAcabamento()
9077:             ENDIF
9078:             IF USED("cursor_4c_VAcb")
9079:                 USE IN cursor_4c_VAcb
9080:             ENDIF
9081:         CATCH TO loc_oErro
9082:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9083:         ENDTRY
9084:     ENDPROC
9085: 
9086:     *--------------------------------------------------------------------------
9087:     * AbrirLookupAcabamento - Abre FormBuscaAuxiliar para selecionar acabamento
9088:     *--------------------------------------------------------------------------
9089:     PROTECTED PROCEDURE AbrirLookupAcabamento()
9090:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9091:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9092:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5), ALLTRIM(loc_oPg.txt_4c_Codacbs.Value), "")
9093: 
9094:         TRY
9095:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_Acb", "cods", loc_cVal, "Selecionar Acabamento")
9096:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
9097:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9098:             loc_oBusca.Show()
9099: 
9100:             IF loc_oBusca.this_lSelecionou
9101:                 IF USED("cursor_4c_Acb")
9102:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9103:                         loc_oPg.txt_4c_Codacbs.Value  = ALLTRIM(cursor_4c_Acb.cods)
9104:                     ENDIF
9105:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9106:                         loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_Acb.descrs)
9107:                     ENDIF
9108:                 ENDIF
9109:             ELSE
9110:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9111:                     loc_oPg.txt_4c_Codacbs.Value  = ""
9112:                 ENDIF
9113:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9114:                     loc_oPg.txt_4c_Dcodacbs.Value = ""
9115:                 ENDIF
9116:             ENDIF
9117: 
9118:             IF USED("cursor_4c_Acb")
9119:                 USE IN cursor_4c_Acb
9120:             ENDIF
9121:             loc_oBusca.Release()
9122:         CATCH TO loc_oErro
9123:             MsgErro("Erro no lookup de acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamento")
9124:         ENDTRY
9125:     ENDPROC
9126: 
9127:     *--------------------------------------------------------------------------
9128:     * TabPrincipal_CodcorsKeyPress - F4 no campo Cor abre lookup
9129:     *--------------------------------------------------------------------------
9130:     PROCEDURE TabPrincipal_CodcorsKeyPress
9131:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9132:         IF par_nKeyCode = 115
9133:             THIS.AbrirLookupCor()
9134:         ENDIF
9135:     ENDPROC
9136: 
9137:     *--------------------------------------------------------------------------
9138:     * TabPrincipal_CodcorsLostFocus - LostFocus valida cor
9139:     *--------------------------------------------------------------------------
9140:     PROCEDURE TabPrincipal_CodcorsLostFocus()
9141:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9142:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9143:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9144:             RETURN
9145:         ENDIF
9146:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)
9147: 
9148:         IF loc_cCod == THIS.this_cUltCodcors
9149:             RETURN
9150:         ENDIF
9151:         THIS.this_cUltCodcors = loc_cCod
9152: 
9153:         IF EMPTY(loc_cCod)
9154:             RETURN
9155:         ENDIF
9156: 
9157:         TRY
9158:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9159:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9160:             ENDTEXT
9161:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9162:             IF loc_nR <= 0
9163:                 THIS.AbrirLookupCor()
9164:             ELSE
9165:                 IF EOF("cursor_4c_VCor")
9166:                     THIS.AbrirLookupCor()
9167:                 ENDIF
9168:             ENDIF
9169:             IF USED("cursor_4c_VCor")
9170:                 USE IN cursor_4c_VCor
9171:             ENDIF
9172:         CATCH TO loc_oErro
9173:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9174:         ENDTRY
9175:     ENDPROC
9176: 
9177:     *--------------------------------------------------------------------------
9178:     * AbrirLookupCor - Abre FormBuscaAuxiliar para selecionar cor
9179:     *--------------------------------------------------------------------------
9180:     PROTECTED PROCEDURE AbrirLookupCor()
9181:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9182:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9183:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5), ALLTRIM(loc_oPg.txt_4c_Codcors.Value), "")
9184: 
9185:         TRY
9186:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Cor", "cods", loc_cVal, "Selecionar Cor")
9187:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
9188:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9189:             loc_oBusca.Show()
9190: 
9191:             IF loc_oBusca.this_lSelecionou
9192:                 IF USED("cursor_4c_Cor")
9193:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9194:                         loc_oPg.txt_4c_Codcors.Value = ALLTRIM(cursor_4c_Cor.cods)
9195:                     ENDIF
9196:                 ENDIF
9197:             ELSE
9198:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9199:                     loc_oPg.txt_4c_Codcors.Value = ""
9200:                 ENDIF
9201:             ENDIF
9202: 
9203:             IF USED("cursor_4c_Cor")
9204:                 USE IN cursor_4c_Cor
9205:             ENDIF
9206:             loc_oBusca.Release()
9207:         CATCH TO loc_oErro
9208:             MsgErro("Erro no lookup de cor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCor")
9209:         ENDTRY
9210:     ENDPROC
9211: 
9212:     *--------------------------------------------------------------------------
9213:     * TabPrincipal_CodtamsKeyPress - F4 no campo Tamanho abre lookup
9214:     *--------------------------------------------------------------------------
9215:     PROCEDURE TabPrincipal_CodtamsKeyPress
9216:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9217:         IF par_nKeyCode = 115
9218:             THIS.AbrirLookupTamanho()
9219:         ENDIF
9220:     ENDPROC
9221: 
9222:     *--------------------------------------------------------------------------
9223:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar para selecionar tamanho
9224:     *--------------------------------------------------------------------------
9225:     PROTECTED PROCEDURE AbrirLookupTamanho()
9226:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9227:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9228:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5), ALLTRIM(loc_oPg.txt_4c_Codtams.Value), "")
9229: 
9230:         TRY
9231:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Tam", "cods", loc_cVal, "Selecionar Tamanho")
9232:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9233:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9234:             loc_oBusca.Show()
9235: 
9236:             IF loc_oBusca.this_lSelecionou
9237:                 IF USED("cursor_4c_Tam")
9238:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9239:                         loc_oPg.txt_4c_Codtams.Value = ALLTRIM(cursor_4c_Tam.cods)
9240:                     ENDIF
9241:                 ENDIF
9242:             ELSE
9243:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9244:                     loc_oPg.txt_4c_Codtams.Value = ""
9245:                 ENDIF
9246:             ENDIF
9247: 
9248:             IF USED("cursor_4c_Tam")
9249:                 USE IN cursor_4c_Tam
9250:             ENDIF
9251:             loc_oBusca.Release()
9252:         CATCH TO loc_oErro
9253:             MsgErro("Erro no lookup de tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanho")
9254:         ENDTRY
9255:     ENDPROC
9256: 
9257:     *--------------------------------------------------------------------------
9258:     * CarregarDesc - Helper: carrega descricao de um campo lookup via SQL
9259:     * Retorna "" se nao encontrado ou valor vazio
9260:     *--------------------------------------------------------------------------
9261:     PROTECTED FUNCTION CarregarDesc(par_cTabela, par_cCampoChave, par_cValor, par_cCampoDesc)
9262:         LOCAL loc_cDesc, loc_cSQL, loc_nR, loc_cAliasField
9263:         loc_cDesc = ""
9264: 
9265:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9266:             TRY
9267:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9268:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9269:                 ENDTEXT
9270:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9271:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")

*-- Linhas 9287 a 9330:
9287:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9288:     * Tabela: SIGPRCPO JOIN SigCdPro
9289:     *--------------------------------------------------------------------------
9290:     PROTECTED PROCEDURE CarregarComposicao()
9291:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9292:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9293:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9294: 
9295:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9296:             RETURN
9297:         ENDIF
9298: 
9299:         TRY
9300:             *-- Composicao principal
9301:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9302:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9303:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9304:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9305:                 FROM SIGPRCPO c
9306:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9307:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9308:                 ORDER BY c.ordems
9309:             ENDTEXT
9310:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9311:             IF loc_nR > 0
9312:                 IF USED("cursor_4c_Compo")
9313:                     SELECT cursor_4c_Compo
9314:                     ZAP
9315:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9316:                 ENDIF
9317:                 IF USED("cursor_4c_CompoTmp")
9318:                     USE IN cursor_4c_CompoTmp
9319:                 ENDIF
9320:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9321:                     loc_oPg.grd_4c_Compo.Refresh()
9322:                 ENDIF
9323:             ENDIF
9324: 
9325:             *-- Sub-composicao
9326:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9327:                 SELECT sc.mats, m.dpros AS dcompos, sc.unicompos, sc.pcompos, sc.qtds,
9328:                        sc.totas, sc.moeds, sc.obscompos, sc.etiqs, sc.qtscons,
9329:                        sc.qtdcvs, sc.cunips, sc.ordems, sc.matsubs, sc.codtams
9330:                 FROM sigsubcp sc

*-- Linhas 9357 a 9400:
9357:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9358:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9359:     *--------------------------------------------------------------------------
9360:     PROTECTED PROCEDURE CarregarConsultaP()
9361:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9362:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9363:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9364: 
9365:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9366:             RETURN
9367:         ENDIF
9368: 
9369:         TRY
9370:             *-- Carregar componentes com descricao de fase e categoria
9371:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9372:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9373:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9374:                        c.ordems, c.qtscons, c.cats,
9375:                        ISNULL(cat.descs, '') AS dscgrp
9376:                 FROM SIGPRCPO c
9377:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9378:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9379:                 ORDER BY c.ordems, c.mats
9380:             ENDTEXT
9381:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9382:             IF loc_nR > 0
9383:                 IF USED("cursor_4c_Consulta")
9384:                     SELECT cursor_4c_Consulta
9385:                     ZAP
9386:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9387:                 ENDIF
9388:                 IF USED("cursor_4c_ConsultaTmp")
9389:                     USE IN cursor_4c_ConsultaTmp
9390:                 ENDIF
9391:                 *-- Atualizar contagem de componentes
9392:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9393:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9394:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9395:                 ENDIF
9396:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9397:                     loc_oPg.grd_4c_Consulta.Refresh()
9398:                 ENDIF
9399:             ENDIF
9400: 

*-- Linhas 9432 a 9475:
9432:     * CarregarCustos - Carrega grid de custo da composicao (Tab 3 - pgCusto)
9433:     * Tabela: SIGPRCPO filtrado por Tipos (tipo de calculo de custo)
9434:     *--------------------------------------------------------------------------
9435:     PROTECTED PROCEDURE CarregarCustos()
9436:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
9437:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9438:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9439: 
9440:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9441:             RETURN
9442:         ENDIF
9443: 
9444:         TRY
9445:             *-- Obter tipo selecionado no combo (0=Todos, 1/2/3=tipo especifico)
9446:             loc_nTipo = 0
9447:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
9448:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1) - 1
9449:             ENDIF
9450: 
9451:             *-- Composicao de custo
9452:             IF loc_nTipo = 0
9453:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9454:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9455:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9456:                            c.qtdcvs, c.cunips
9457:                     FROM SIGPRCPO c
9458:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9459:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9460:                     AND c.tipos IS NOT NULL
9461:                     ORDER BY c.mats
9462:                 ENDTEXT
9463:             ELSE
9464:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9465:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9466:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9467:                            c.qtdcvs, c.cunips
9468:                     FROM SIGPRCPO c
9469:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9470:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9471:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9472:                     ORDER BY c.mats
9473:                 ENDTEXT
9474:             ENDIF
9475: 

*-- Linhas 9543 a 9586:
9543:     * CarregarFases - Carrega grid de fases (Tab 7)
9544:     * Tabela: SigCdPrf
9545:     *--------------------------------------------------------------------------
9546:     PROTECTED PROCEDURE CarregarFases()
9547:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_oBO
9548:         loc_oBO    = THIS.this_oBusinessObject
9549:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
9550:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9551: 
9552:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9553:             RETURN
9554:         ENDIF
9555: 
9556:         TRY
9557:             *-- Fases de producao
9558:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9559:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9560:                 FROM SigCdPrf
9561:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9562:                 ORDER BY ordems
9563:             ENDTEXT
9564:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9565:             IF loc_nR > 0
9566:                 IF USED("cursor_4c_Fases")
9567:                     SELECT cursor_4c_Fases
9568:                     ZAP
9569:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9570:                 ENDIF
9571:                 IF USED("cursor_4c_FasesTmp")
9572:                     USE IN cursor_4c_FasesTmp
9573:                 ENDIF
9574:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9575:                     loc_oPg.grd_4c_Fases.Refresh()
9576:                 ENDIF
9577:             ENDIF
9578: 
9579:             *-- Matrizes
9580:             THIS.CarregarMatrizes()
9581: 
9582:             *-- Preencher campos do BO nas textboxes da tab
9583:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9584:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs
9585:             ENDIF
9586:             IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)

*-- Linhas 9626 a 9669:
9626:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9627:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9628:     *--------------------------------------------------------------------------
9629:     PROTECTED PROCEDURE CarregarMatrizes()
9630:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9631:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9632:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9633: 
9634:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9635:             RETURN
9636:         ENDIF
9637: 
9638:         TRY
9639:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9640:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9641:                 FROM SigPrMtz a
9642:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9643:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9644:             ENDTEXT
9645:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9646:             IF loc_nR > 0
9647:                 IF USED("cursor_4c_Matrizes")
9648:                     SELECT cursor_4c_Matrizes
9649:                     ZAP
9650:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9651:                 ENDIF
9652:                 IF USED("cursor_4c_MatrizesTmp")
9653:                     USE IN cursor_4c_MatrizesTmp
9654:                 ENDIF
9655:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9656:                     loc_oPg.grd_4c_Matrizes.Refresh()
9657:                 ENDIF
9658:             ENDIF
9659: 
9660:         CATCH TO loc_oErro
9661:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9662:         ENDTRY
9663:     ENDPROC
9664: 
9665:     *--------------------------------------------------------------------------
9666:     * CarregarDescSgru - Carrega descricao do subgrupo (SigCdPsg com filtro grupo)
9667:     *--------------------------------------------------------------------------
9668:     PROTECTED FUNCTION CarregarDescSgru(par_cCgrus, par_cSgrus)
9669:         LOCAL loc_cDesc, loc_cSQL, loc_nR

*-- Linhas 9694 a 9851:
9694:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
9695:     * par_nPagina: 1=Lista, 2=Dados
9696:     *--------------------------------------------------------------------------
9697:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
9698:         LOCAL loc_lResultado
9699:         loc_lResultado = .F.
9700: 
9701:         TRY
9702:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
9703:                 loc_lResultado = .F.
9704:             ELSE
9705:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
9706: 
9707:                 IF par_nPagina = 1
9708:                     THIS.CarregarLista()
9709:                 ENDIF
9710: 
9711:                 loc_lResultado = .T.
9712:             ENDIF
9713: 
9714:         CATCH TO loc_oErro
9715:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormProduto.AlternarPagina")
9716:             loc_lResultado = .F.
9717:         ENDTRY
9718: 
9719:         RETURN loc_lResultado
9720:     ENDPROC
9721: 
9722:     *--------------------------------------------------------------------------
9723:     * TabFiscal_ClfiscalKeyPress - F4 no campo Classif. Fiscal abre lookup
9724:     *--------------------------------------------------------------------------
9725:     PROCEDURE TabFiscal_ClfiscalKeyPress
9726:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9727:         IF par_nKeyCode = 115
9728:             THIS.AbrirLookupClassFiscal()
9729:         ENDIF
9730:     ENDPROC
9731: 
9732:     *--------------------------------------------------------------------------
9733:     * AbrirLookupClassFiscal - Abre FormBuscaAuxiliar para Classif. Fiscal
9734:     * Tabela: SigCdClf | Chave: clfiscals | Desc: dclfiscals
9735:     *--------------------------------------------------------------------------
9736:     PROTECTED PROCEDURE AbrirLookupClassFiscal()
9737:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9738:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9739:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5), ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "")
9740: 
9741:         TRY
9742:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_Clf", "clfiscals", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9743:             loc_oBusca.mAddColuna("clfiscals",  "", "C" + CHR(243) + "digo")
9744:             loc_oBusca.mAddColuna("dclfiscals", "", "Descri" + CHR(231) + CHR(227) + "o")
9745:             loc_oBusca.Show()
9746: 
9747:             IF loc_oBusca.this_lSelecionou
9748:                 IF USED("cursor_4c_Clf")
9749:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9750:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_Clf.clfiscals)
9751:                     ENDIF
9752:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9753:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_Clf.dclfiscals)
9754:                     ENDIF
9755:                 ENDIF
9756:             ELSE
9757:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9758:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9759:                 ENDIF
9760:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9761:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9762:                 ENDIF
9763:             ENDIF
9764: 
9765:             IF USED("cursor_4c_Clf")
9766:                 USE IN cursor_4c_Clf
9767:             ENDIF
9768:             loc_oBusca.Release()
9769:         CATCH TO loc_oErro
9770:             MsgErro("Erro no lookup de classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupClassFiscal")
9771:         ENDTRY
9772:     ENDPROC
9773: 
9774:     *--------------------------------------------------------------------------
9775:     * TabFiscal_MetalKeyPress - KeyPress no campo Metal (sem lookup auxiliar)
9776:     * Metal e Teor sao campos de classificacao IPI preenchidos manualmente
9777:     *--------------------------------------------------------------------------
9778:     PROCEDURE TabFiscal_MetalKeyPress
9779:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9780:         *-- Sem lookup: Metal e Teor sao codigos livres no contexto IPI
9781:     ENDPROC
9782: 
9783:     *--------------------------------------------------------------------------
9784:     * TabFiscal_TeorKeyPress - KeyPress no campo Teor (sem lookup auxiliar)
9785:     *--------------------------------------------------------------------------
9786:     PROCEDURE TabFiscal_TeorKeyPress
9787:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9788:         *-- Sem lookup: Teor e codigo livre no contexto IPI
9789:     ENDPROC
9790: 
9791:     *--------------------------------------------------------------------------
9792:     * ValidarClfiscal - LostFocus no campo Classificacao Fiscal
9793:     * Tabela: SigCdClf | Chave: Codigos | Desc: Descricaos
9794:     * Ao selecionar, popula AliqIPI com aliqipis da classificacao
9795:     *--------------------------------------------------------------------------
9796:     PROCEDURE ValidarClfiscal()
9797:         LOCAL loc_oPg, loc_cVal
9798:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9799:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9800:             RETURN
9801:         ENDIF
9802:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9803: 
9804:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltClassFiscal
9805:             RETURN
9806:         ENDIF
9807:         THIS.this_cUltClassFiscal = loc_cVal
9808: 
9809:         TRY
9810:             LOCAL loc_oBusca, loc_cSQL, loc_nR
9811:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfV", "Codigos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9812:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9813:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9814:             loc_oBusca.Show()
9815: 
9816:             IF loc_oBusca.this_lSelecionou
9817:                 IF USED("cursor_4c_ClfV")
9818:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9819:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfV.Codigos)
9820:                     ENDIF
9821:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9822:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfV.Descricaos)
9823:                     ENDIF
9824:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9825:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9826:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9827:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9828:                         ENDTEXT
9829:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9830:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9831:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9832:                         ENDIF
9833:                         IF USED("cursor_4c_ClfAliq")
9834:                             USE IN cursor_4c_ClfAliq
9835:                         ENDIF
9836:                     ENDIF
9837:                 ENDIF
9838:             ELSE
9839:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9840:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9841:                 ENDIF
9842:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9843:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9844:                 ENDIF
9845:                 THIS.this_cUltClassFiscal = ""
9846:             ENDIF
9847: 
9848:             IF USED("cursor_4c_ClfV")
9849:                 USE IN cursor_4c_ClfV
9850:             ENDIF
9851:             loc_oBusca.Release()

*-- Linhas 9862 a 10735:
9862:     * ValidarDclfiscal - LostFocus no campo Descricao Classificacao Fiscal
9863:     * Busca por descricao e preenche codigo
9864:     *--------------------------------------------------------------------------
9865:     PROCEDURE ValidarDclfiscal()
9866:         LOCAL loc_oPg, loc_cVal
9867:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9868:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9869:             RETURN
9870:         ENDIF
9871:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9872: 
9873:         *-- So abre busca se o codigo estiver vazio (getDclfiscal.When logic)
9874:         IF EMPTY(loc_cVal)
9875:             RETURN
9876:         ENDIF
9877:         IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9878:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9879:                 RETURN
9880:             ENDIF
9881:         ENDIF
9882:         IF loc_cVal == THIS.this_cUltimoValidarDclfiscalValidado
9883:             RETURN
9884:         ENDIF
9885:         THIS.this_cUltimoValidarDclfiscalValidado = loc_cVal
9886: 
9887:         TRY
9888:             LOCAL loc_oBusca
9889:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfD", "Descricaos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9890:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9891:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9892:             loc_oBusca.Show()
9893: 
9894:             IF loc_oBusca.this_lSelecionou
9895:                 IF USED("cursor_4c_ClfD")
9896:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9897:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfD.Codigos)
9898:                     ENDIF
9899:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9900:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfD.Descricaos)
9901:                     ENDIF
9902:                     THIS.this_cUltClassFiscal = ALLTRIM(cursor_4c_ClfD.Codigos)
9903:                 ENDIF
9904:             ELSE
9905:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9906:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9907:                 ENDIF
9908:             ENDIF
9909: 
9910:             IF USED("cursor_4c_ClfD")
9911:                 USE IN cursor_4c_ClfD
9912:             ENDIF
9913:             loc_oBusca.Release()
9914:         CATCH TO loc_oErro
9915:             MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDclfiscal")
9916:         ENDTRY
9917:     ENDPROC
9918: 
9919:     *--------------------------------------------------------------------------
9920:     * ValidarOrigmerc - LostFocus no campo Origem Mercadoria
9921:     * Tabela: SigCdOrg | Chave: Codigos | Desc: Descricaos
9922:     *--------------------------------------------------------------------------
9923:     PROCEDURE ValidarOrigmerc()
9924:         LOCAL loc_oPg, loc_cVal
9925:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9926:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9927:             RETURN
9928:         ENDIF
9929:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9930: 
9931:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltOrganizacao
9932:             RETURN
9933:         ENDIF
9934:         THIS.this_cUltOrganizacao = loc_cVal
9935: 
9936:         TRY
9937:             LOCAL loc_oBusca
9938:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_Org", "Codigos", loc_cVal, "Origem da Mercadoria")
9939:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9940:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9941:             loc_oBusca.Show()
9942: 
9943:             IF loc_oBusca.this_lSelecionou
9944:                 IF USED("cursor_4c_Org")
9945:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9946:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_Org.Codigos)
9947:                     ENDIF
9948:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9949:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_Org.Descricaos)
9950:                     ENDIF
9951:                 ENDIF
9952:             ELSE
9953:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9954:                     loc_oPg.txt_4c_Origmerc.Value  = ""
9955:                 ENDIF
9956:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9957:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9958:                 ENDIF
9959:                 THIS.this_cUltOrganizacao = ""
9960:             ENDIF
9961: 
9962:             IF USED("cursor_4c_Org")
9963:                 USE IN cursor_4c_Org
9964:             ENDIF
9965:             loc_oBusca.Release()
9966:         CATCH TO loc_oErro
9967:             MsgErro("Erro ao validar origem da mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarOrigmerc")
9968:         ENDTRY
9969:     ENDPROC
9970: 
9971:     *--------------------------------------------------------------------------
9972:     * ValidarDorigmerc - LostFocus no campo Descricao Origem Mercadoria
9973:     * Busca por descricao, preenche codigo (so se codigo estiver vazio)
9974:     *--------------------------------------------------------------------------
9975:     PROCEDURE ValidarDorigmerc()
9976:         LOCAL loc_oPg, loc_cVal
9977:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9978:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9979:             RETURN
9980:         ENDIF
9981:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9982: 
9983:         IF EMPTY(loc_cVal)
9984:             RETURN
9985:         ENDIF
9986:         IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9987:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9988:                 RETURN
9989:             ENDIF
9990:         ENDIF
9991:         IF loc_cVal == THIS.this_cUltimoValidarDorigmercValidado
9992:             RETURN
9993:         ENDIF
9994:         THIS.this_cUltimoValidarDorigmercValidado = loc_cVal
9995: 
9996:         TRY
9997:             LOCAL loc_oBusca
9998:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_OrgD", "Descricaos", loc_cVal, "Origem da Mercadoria")
9999:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10000:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10001:             loc_oBusca.Show()
10002: 
10003:             IF loc_oBusca.this_lSelecionou
10004:                 IF USED("cursor_4c_OrgD")
10005:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10006:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_OrgD.Codigos)
10007:                     ENDIF
10008:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10009:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgD.Descricaos)
10010:                     ENDIF
10011:                     THIS.this_cUltOrganizacao = ALLTRIM(cursor_4c_OrgD.Codigos)
10012:                 ENDIF
10013:             ELSE
10014:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10015:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
10016:                 ENDIF
10017:             ENDIF
10018: 
10019:             IF USED("cursor_4c_OrgD")
10020:                 USE IN cursor_4c_OrgD
10021:             ENDIF
10022:             loc_oBusca.Release()
10023:         CATCH TO loc_oErro
10024:             MsgErro("Erro ao buscar origem mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDorigmerc")
10025:         ENDTRY
10026:     ENDPROC
10027: 
10028:     *--------------------------------------------------------------------------
10029:     * ValidarSittricms - LostFocus no campo Situacao Tributaria ICMS
10030:     * Tabela: SigCdIcm | Chave: Codigos | Desc: Descricaos
10031:     *--------------------------------------------------------------------------
10032:     PROCEDURE ValidarSittricms()
10033:         LOCAL loc_oPg, loc_cVal
10034:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10035:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10036:             RETURN
10037:         ENDIF
10038:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)
10039: 
10040:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10041:             RETURN
10042:         ENDIF
10043:         THIS.this_cUltIcm = loc_cVal
10044: 
10045:         TRY
10046:             LOCAL loc_oBusca
10047:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_Icm", "Codigos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10048:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10049:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10050:             loc_oBusca.Show()
10051: 
10052:             IF loc_oBusca.this_lSelecionou
10053:                 IF USED("cursor_4c_Icm")
10054:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10055:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_Icm.Codigos)
10056:                     ENDIF
10057:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10058:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_Icm.Descricaos)
10059:                     ENDIF
10060:                 ENDIF
10061:             ELSE
10062:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10063:                     loc_oPg.txt_4c_Sittricms.Value  = ""
10064:                 ENDIF
10065:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10066:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10067:                 ENDIF
10068:                 THIS.this_cUltIcm = ""
10069:             ENDIF
10070: 
10071:             IF USED("cursor_4c_Icm")
10072:                 USE IN cursor_4c_Icm
10073:             ENDIF
10074:             loc_oBusca.Release()
10075:         CATCH TO loc_oErro
10076:             MsgErro("Erro ao validar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarSittricms")
10077:         ENDTRY
10078:     ENDPROC
10079: 
10080:     *--------------------------------------------------------------------------
10081:     * ValidarDsittricms - LostFocus no campo Descricao Situacao Tributaria ICMS
10082:     * Busca por descricao (so se codigo estiver vazio)
10083:     *--------------------------------------------------------------------------
10084:     PROCEDURE ValidarDsittricms()
10085:         LOCAL loc_oPg, loc_cVal
10086:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10087:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10088:             RETURN
10089:         ENDIF
10090:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dsittricms.Value)
10091: 
10092:         IF EMPTY(loc_cVal)
10093:             RETURN
10094:         ENDIF
10095:         IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10096:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricms.Value))
10097:                 RETURN
10098:             ENDIF
10099:         ENDIF
10100:         IF loc_cVal == THIS.this_cUltimoValidarDsittricmsValidado
10101:             RETURN
10102:         ENDIF
10103:         THIS.this_cUltimoValidarDsittricmsValidado = loc_cVal
10104: 
10105:         TRY
10106:             LOCAL loc_oBusca
10107:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_IcmD", "Descricaos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10108:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10109:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10110:             loc_oBusca.Show()
10111: 
10112:             IF loc_oBusca.this_lSelecionou
10113:                 IF USED("cursor_4c_IcmD")
10114:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10115:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_IcmD.Codigos)
10116:                     ENDIF
10117:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10118:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_IcmD.Descricaos)
10119:                     ENDIF
10120:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_IcmD.Codigos)
10121:                 ENDIF
10122:             ELSE
10123:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10124:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10125:                 ENDIF
10126:             ENDIF
10127: 
10128:             IF USED("cursor_4c_IcmD")
10129:                 USE IN cursor_4c_IcmD
10130:             ENDIF
10131:             loc_oBusca.Release()
10132:         CATCH TO loc_oErro
10133:             MsgErro("Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDsittricms")
10134:         ENDTRY
10135:     ENDPROC
10136: 
10137:     *--------------------------------------------------------------------------
10138:     * ValidarCodServs - LostFocus no campo Codigo de Servicos ICMS
10139:     * Tabela: SigCdIcm | tambem preenche getSittricm quando seleciona
10140:     *--------------------------------------------------------------------------
10141:     PROCEDURE ValidarCodServs()
10142:         LOCAL loc_oPg, loc_cVal
10143:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10144:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10145:             RETURN
10146:         ENDIF
10147:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
10148: 
10149:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10150:             RETURN
10151:         ENDIF
10152:         THIS.this_cUltIcm = loc_cVal
10153: 
10154:         TRY
10155:             LOCAL loc_oBusca
10156:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_CodServ", "Codigos", loc_cVal, "C" + CHR(243) + "digo Servi" + CHR(231) + "os ICMS")
10157:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10158:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10159:             loc_oBusca.Show()
10160: 
10161:             IF loc_oBusca.this_lSelecionou
10162:                 IF USED("cursor_4c_CodServ")
10163:                     IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10164:                         loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10165:                     ENDIF
10166:                     *-- Tambem preenche Sittricms (como no legado)
10167:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10168:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10169:                     ENDIF
10170:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10171:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_CodServ.Descricaos)
10172:                     ENDIF
10173:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_CodServ.Codigos)
10174:                 ENDIF
10175:             ELSE
10176:                 IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10177:                     loc_oPg.txt_4c_CodServs.Value = ""
10178:                 ENDIF
10179:             ENDIF
10180: 
10181:             IF USED("cursor_4c_CodServ")
10182:                 USE IN cursor_4c_CodServ
10183:             ENDIF
10184:             loc_oBusca.Release()
10185:         CATCH TO loc_oErro
10186:             MsgErro("Erro ao validar c" + CHR(243) + "digo de servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarCodServs")
10187:         ENDTRY
10188:     ENDPROC
10189: 
10190:     *--------------------------------------------------------------------------
10191:     * ValidarTptribs - LostFocus no campo Tipo de Tributacao
10192:     * Tabela: SigPrTri | Chave: Tipos | Desc: Descs
10193:     *--------------------------------------------------------------------------
10194:     PROCEDURE ValidarTptribs()
10195:         LOCAL loc_oPg, loc_cVal
10196:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10197:         IF !PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10198:             RETURN
10199:         ENDIF
10200:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)
10201: 
10202:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltTptribs
10203:             RETURN
10204:         ENDIF
10205:         THIS.this_cUltTptribs = loc_cVal
10206: 
10207:         TRY
10208:             LOCAL loc_oBusca
10209:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", "cursor_4c_TpTrib", "Tipos", loc_cVal, "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10210:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10211:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10212:             loc_oBusca.Show()
10213: 
10214:             IF loc_oBusca.this_lSelecionou
10215:                 IF USED("cursor_4c_TpTrib")
10216:                     IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10217:                         loc_oPg.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_TpTrib.Tipos)
10218:                     ENDIF
10219:                     THIS.this_cUltTptribs = ALLTRIM(cursor_4c_TpTrib.Tipos)
10220:                 ENDIF
10221:             ELSE
10222:                 IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10223:                     loc_oPg.txt_4c_Tptribs.Value = ""
10224:                 ENDIF
10225:                 THIS.this_cUltTptribs = ""
10226:             ENDIF
10227: 
10228:             IF USED("cursor_4c_TpTrib")
10229:                 USE IN cursor_4c_TpTrib
10230:             ENDIF
10231:             loc_oBusca.Release()
10232:         CATCH TO loc_oErro
10233:             MsgErro("Erro ao validar tipo de tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarTptribs")
10234:         ENDTRY
10235:     ENDPROC
10236: 
10237:     *--------------------------------------------------------------------------
10238:     * ValidarIat - LostFocus no campo IAT
10239:     * Aceita apenas: 'A' (arredondamento), 'T' (truncamento) ou vazio
10240:     *--------------------------------------------------------------------------
10241:     PROCEDURE ValidarIat()
10242:         LOCAL loc_oPg, loc_cVal
10243:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10244:         IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10245:             RETURN
10246:         ENDIF
10247:         loc_cVal = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))
10248: 
10249:         IF EMPTY(loc_cVal)
10250:             RETURN
10251:         ENDIF
10252: 
10253:         IF !INLIST(loc_cVal, "A", "T")
10254:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida. Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
10255:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10256:                 loc_oPg.txt_4c_Iat.Value = ""
10257:             ENDIF
10258:         ELSE
10259:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10260:                 loc_oPg.txt_4c_Iat.Value = loc_cVal
10261:             ENDIF
10262:         ENDIF
10263:     ENDPROC
10264: 
10265:     *--------------------------------------------------------------------------
10266:     * ValidarAliqIPI - LostFocus no campo Aliquota IPI
10267:     * Avisa se identica a aliquota da classificacao fiscal
10268:     *--------------------------------------------------------------------------
10269:     PROCEDURE ValidarAliqIPI()
10270:         LOCAL loc_oPg, loc_nVal, loc_cSQL, loc_nR, loc_nAliqClf
10271:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10272:         IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
10273:             RETURN
10274:         ENDIF
10275:         loc_nVal = loc_oPg.txt_4c_AliqIPI.Value
10276: 
10277:         IF loc_nVal = 0
10278:             RETURN
10279:         ENDIF
10280:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10281:             RETURN
10282:         ENDIF
10283:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
10284:             RETURN
10285:         ENDIF
10286: 
10287:         TRY
10288:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10289:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10290:             ENDTEXT
10291:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10292:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10293:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10294:                 IF loc_nVal = loc_nAliqClf
10295:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10296:                 ENDIF
10297:             ENDIF
10298:             IF USED("cursor_4c_ClfAliqV")
10299:                 USE IN cursor_4c_ClfAliqV
10300:             ENDIF
10301:         CATCH TO loc_oErro
10302:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10303:         ENDTRY
10304:         THIS.CarregarDadosFiscais()
10305:     ENDPROC
10306: 
10307:     *--------------------------------------------------------------------------
10308:     * ValidarMetal - LostFocus no campo Metal (codigo livre IPI)
10309:     *--------------------------------------------------------------------------
10310:     PROCEDURE ValidarMetal()
10311:         RETURN
10312:     ENDPROC
10313: 
10314:     *--------------------------------------------------------------------------
10315:     * ValidarTeor - LostFocus no campo Teor (codigo livre IPI)
10316:     *--------------------------------------------------------------------------
10317:     PROCEDURE ValidarTeor()
10318:         RETURN
10319:     ENDPROC
10320: 
10321:     *--------------------------------------------------------------------------
10322:     * ValidarMoedaEstimada - LostFocus no campo Moeda Valor Estimado
10323:     * Tabela: SigCdMoe | Chave: CMoes | Desc: DMoes
10324:     *--------------------------------------------------------------------------
10325:     PROCEDURE ValidarMoedaEstimada()
10326:         LOCAL loc_oPg, loc_cVal
10327:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10328:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10329:             RETURN
10330:         ENDIF
10331:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)
10332: 
10333:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltMoeda
10334:             RETURN
10335:         ENDIF
10336:         THIS.this_cUltMoeda = loc_cVal
10337: 
10338:         TRY
10339:             LOCAL loc_oBusca
10340:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_MoeEstim", "CMoes", loc_cVal, "Moeda")
10341:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
10342:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10343:             loc_oBusca.Show()
10344: 
10345:             IF loc_oBusca.this_lSelecionou
10346:                 IF USED("cursor_4c_MoeEstim")
10347:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10348:                         loc_oPg.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10349:                     ENDIF
10350:                     THIS.this_cUltMoeda = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10351:                 ENDIF
10352:             ELSE
10353:                 IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10354:                     loc_oPg.txt_4c_Moedas.Value = ""
10355:                 ENDIF
10356:                 THIS.this_cUltMoeda = ""
10357:             ENDIF
10358: 
10359:             IF USED("cursor_4c_MoeEstim")
10360:                 USE IN cursor_4c_MoeEstim
10361:             ENDIF
10362:             loc_oBusca.Release()
10363:         CATCH TO loc_oErro
10364:             MsgErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarMoedaEstimada")
10365:         ENDTRY
10366:     ENDPROC
10367: 
10368:     *--------------------------------------------------------------------------
10369:     * ValidarGruccus - LostFocus no campo Grupo Conta Corrente Custo
10370:     * Tabela: SigCdGcr | Chave: Codigos | Desc: Descrs
10371:     *--------------------------------------------------------------------------
10372:     PROCEDURE ValidarGruccus()
10373:         LOCAL loc_oPg, loc_cVal
10374:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10375:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10376:             RETURN
10377:         ENDIF
10378:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10379: 
10380:         IF EMPTY(loc_cVal)
10381:             IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10382:                 loc_oPg.txt_4c__dgruccus.Value  = ""
10383:             ENDIF
10384:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10385:                 loc_oPg.txt_4c__contaccus.Value = ""
10386:             ENDIF
10387:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10388:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10389:             ENDIF
10390:             THIS.this_cUltGrupoCC = ""
10391:             RETURN
10392:         ENDIF
10393: 
10394:         IF loc_cVal = THIS.this_cUltGrupoCC
10395:             RETURN
10396:         ENDIF
10397:         THIS.this_cUltGrupoCC = loc_cVal
10398: 
10399:         TRY
10400:             LOCAL loc_oBusca
10401:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_Gcr", "Codigos", loc_cVal, "Grupo Conta Corrente")
10402:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10403:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10404:             loc_oBusca.Show()
10405: 
10406:             IF loc_oBusca.this_lSelecionou
10407:                 IF USED("cursor_4c_Gcr")
10408:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10409:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_Gcr.Codigos)
10410:                     ENDIF
10411:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10412:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
10413:                     ENDIF
10414:                 ENDIF
10415:             ELSE
10416:                 IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10417:                     loc_oPg.txt_4c__gruccus.Value  = ""
10418:                 ENDIF
10419:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10420:                     loc_oPg.txt_4c__dgruccus.Value = ""
10421:                 ENDIF
10422:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10423:                     loc_oPg.txt_4c__contaccus.Value = ""
10424:                 ENDIF
10425:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10426:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10427:                 ENDIF
10428:                 THIS.this_cUltGrupoCC = ""
10429:             ENDIF
10430: 
10431:             IF USED("cursor_4c_Gcr")
10432:                 USE IN cursor_4c_Gcr
10433:             ENDIF
10434:             loc_oBusca.Release()
10435:         CATCH TO loc_oErro
10436:             MsgErro("Erro ao validar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarGruccus")
10437:         ENDTRY
10438:     ENDPROC
10439: 
10440:     *--------------------------------------------------------------------------
10441:     * ValidarDgruccus - LostFocus na Descricao do Grupo Conta Corrente
10442:     * Busca por descricao (so se codigo estiver vazio)
10443:     *--------------------------------------------------------------------------
10444:     PROCEDURE ValidarDgruccus()
10445:         LOCAL loc_oPg, loc_cVal
10446:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10447:         IF !PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10448:             RETURN
10449:         ENDIF
10450:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10451: 
10452:         IF EMPTY(loc_cVal)
10453:             RETURN
10454:         ENDIF
10455:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10456:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10457:                 RETURN
10458:             ENDIF
10459:         ENDIF
10460:         IF loc_cVal == THIS.this_cUltimoValidarDgruccusValidado
10461:             RETURN
10462:         ENDIF
10463:         THIS.this_cUltimoValidarDgruccusValidado = loc_cVal
10464: 
10465:         TRY
10466:             LOCAL loc_oBusca
10467:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_GcrD", "Descrs", loc_cVal, "Grupo Conta Corrente")
10468:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10469:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10470:             loc_oBusca.Show()
10471: 
10472:             IF loc_oBusca.this_lSelecionou
10473:                 IF USED("cursor_4c_GcrD")
10474:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10475:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_GcrD.Codigos)
10476:                     ENDIF
10477:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10478:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_GcrD.Descrs)
10479:                     ENDIF
10480:                     THIS.this_cUltGrupoCC = ALLTRIM(cursor_4c_GcrD.Codigos)
10481:                 ENDIF
10482:             ELSE
10483:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10484:                     loc_oPg.txt_4c__dgruccus.Value = ""
10485:                 ENDIF
10486:             ENDIF
10487: 
10488:             IF USED("cursor_4c_GcrD")
10489:                 USE IN cursor_4c_GcrD
10490:             ENDIF
10491:             loc_oBusca.Release()
10492:         CATCH TO loc_oErro
10493:             MsgErro("Erro ao buscar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDgruccus")
10494:         ENDTRY
10495:     ENDPROC
10496: 
10497:     *--------------------------------------------------------------------------
10498:     * ValidarContaccus - LostFocus no campo Conta Corrente Custo
10499:     * Tabela: SigCdCli | Chave: IClis | Desc: Rclis
10500:     * So acessivel quando grupo gruccus preenchido
10501:     *--------------------------------------------------------------------------
10502:     PROCEDURE ValidarContaccus()
10503:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10504:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10505:         IF !PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10506:             RETURN
10507:         ENDIF
10508:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10509:         loc_cGrupo = ""
10510:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10511:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10512:         ENDIF
10513: 
10514:         *-- Grupo obrigatorio para acessar conta
10515:         IF EMPTY(loc_cGrupo)
10516:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10517:                 loc_oPg.txt_4c__contaccus.Value = ""
10518:             ENDIF
10519:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10520:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10521:             ENDIF
10522:             RETURN
10523:         ENDIF
10524: 
10525:         IF EMPTY(loc_cVal)
10526:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10527:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10528:             ENDIF
10529:             THIS.this_cUltContaCC = ""
10530:             RETURN
10531:         ENDIF
10532: 
10533:         IF loc_cVal = THIS.this_cUltContaCC
10534:             RETURN
10535:         ENDIF
10536:         THIS.this_cUltContaCC = loc_cVal
10537: 
10538:         TRY
10539:             LOCAL loc_oBusca
10540:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCC", "IClis", loc_cVal, "Conta Corrente")
10541:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10542:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10543:             loc_oBusca.Show()
10544: 
10545:             IF loc_oBusca.this_lSelecionou
10546:                 IF USED("cursor_4c_ContaCC")
10547:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10548:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCC.IClis)
10549:                     ENDIF
10550:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10551:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCC.Rclis)
10552:                     ENDIF
10553:                 ENDIF
10554:             ELSE
10555:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10556:                     loc_oPg.txt_4c__contaccus.Value  = ""
10557:                 ENDIF
10558:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10559:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10560:                 ENDIF
10561:                 THIS.this_cUltContaCC = ""
10562:             ENDIF
10563: 
10564:             IF USED("cursor_4c_ContaCC")
10565:                 USE IN cursor_4c_ContaCC
10566:             ENDIF
10567:             loc_oBusca.Release()
10568:         CATCH TO loc_oErro
10569:             MsgErro("Erro ao validar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarContaccus")
10570:         ENDTRY
10571:     ENDPROC
10572: 
10573:     *--------------------------------------------------------------------------
10574:     * ValidarDcontaccus - LostFocus na Descricao Conta Corrente
10575:     * Busca por nome (so se codigo estiver vazio e grupo preenchido)
10576:     *--------------------------------------------------------------------------
10577:     PROCEDURE ValidarDcontaccus()
10578:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10579:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10580:         IF !PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10581:             RETURN
10582:         ENDIF
10583:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10584:         loc_cGrupo = ""
10585:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10586:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10587:         ENDIF
10588: 
10589:         IF EMPTY(loc_cVal) OR EMPTY(loc_cGrupo)
10590:             RETURN
10591:         ENDIF
10592:         IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10593:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10594:                 RETURN
10595:             ENDIF
10596:         ENDIF
10597:         IF loc_cVal == THIS.this_cUltimoValidarDcontaccusValidado
10598:             RETURN
10599:         ENDIF
10600:         THIS.this_cUltimoValidarDcontaccusValidado = loc_cVal
10601: 
10602:         TRY
10603:             LOCAL loc_oBusca
10604:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCCD", "Rclis", loc_cVal, "Conta Corrente")
10605:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10606:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10607:             loc_oBusca.Show()
10608: 
10609:             IF loc_oBusca.this_lSelecionou
10610:                 IF USED("cursor_4c_ContaCCD")
10611:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10612:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCCD.IClis)
10613:                     ENDIF
10614:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10615:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCCD.Rclis)
10616:                     ENDIF
10617:                     THIS.this_cUltContaCC = ALLTRIM(cursor_4c_ContaCCD.IClis)
10618:                 ENDIF
10619:             ELSE
10620:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10621:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10622:                 ENDIF
10623:             ENDIF
10624: 
10625:             IF USED("cursor_4c_ContaCCD")
10626:                 USE IN cursor_4c_ContaCCD
10627:             ENDIF
10628:             loc_oBusca.Release()
10629:         CATCH TO loc_oErro
10630:             MsgErro("Erro ao buscar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDcontaccus")
10631:         ENDTRY
10632:     ENDPROC
10633: 
10634:     *--------------------------------------------------------------------------
10635:     * TabFiscal_ExtIpiGotFocus - GotFocus no campo Excecao da TIPI
10636:     * Verifica se campo deve estar habilitado (IpiProds = 'S' em SigCdClf)
10637:     *--------------------------------------------------------------------------
10638:     PROCEDURE TabFiscal_ExtIpiGotFocus()
10639:         LOCAL loc_oPg, loc_cClf, loc_cSQL, loc_nR, loc_lHabilitar
10640:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10641:         loc_lHabilitar = .F.
10642: 
10643:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10644:             RETURN
10645:         ENDIF
10646:         loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10647: 
10648:         IF EMPTY(loc_cClf)
10649:             RETURN
10650:         ENDIF
10651: 
10652:         TRY
10653:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10654:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10655:             ENDTEXT
10656:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10657:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10658:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10659:             ENDIF
10660:             IF USED("cursor_4c_ClfIpi")
10661:                 USE IN cursor_4c_ClfIpi
10662:             ENDIF
10663:         CATCH TO loc_oErro
10664:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10665:         ENDTRY
10666: 
10667:         IF !loc_lHabilitar
10668:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10669:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10670:             ENDIF
10671:         ENDIF
10672:     ENDPROC
10673: 
10674:     *--------------------------------------------------------------------------
10675:     * BtnDescFisClick - Gerar Descricao Fiscal automaticamente
10676:     * Equivalente ao legacy fGerDescFis - stub funcional
10677:     *--------------------------------------------------------------------------
10678:     PROCEDURE BtnDescFisClick()
10679:         LOCAL loc_oPg, loc_cCpros
10680:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10681:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10682: 
10683:         IF EMPTY(loc_cCpros)
10684:             MsgAviso("Selecione um produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10685:             RETURN
10686:         ENDIF
10687: 
10688:         MsgAviso("Funcionalidade de gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica de descri" + CHR(231) + CHR(227) + "o fiscal n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + "Edite a descri" + CHR(231) + CHR(227) + "o fiscal diretamente no campo.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10689:     ENDPROC
10690: 
10691:     *--------------------------------------------------------------------------
10692:     * CarregarDadosFiscais - Carrega grid CMV (custos gramas) da aba Fiscal
10693:     * Tabela: SigCdCmv | Colunas: Datas, ValCuss, Moedas
10694:     *--------------------------------------------------------------------------
10695:     PROTECTED PROCEDURE CarregarDadosFiscais()
10696:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10697:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10698:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10699: 
10700:         IF EMPTY(loc_cCpros)
10701:             IF USED("cursor_4c_Cmv")
10702:                 ZAP IN cursor_4c_Cmv
10703:             ENDIF
10704:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10705:                 loc_oPg.grd_4c_Cmv.Refresh()
10706:             ENDIF
10707:             RETURN
10708:         ENDIF
10709: 
10710:         TRY
10711:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10712:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10713:                 FROM SigCdCmv
10714:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10715:                 ORDER BY Datas DESC
10716:             ENDTEXT
10717: 
10718:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10719: 
10720:             IF USED("cursor_4c_Cmv")
10721:                 ZAP IN cursor_4c_Cmv
10722:             ENDIF
10723: 
10724:             IF loc_nR > 0
10725:                 IF !USED("cursor_4c_Cmv")
10726:                     SET NULL ON
10727:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10728:                     SET NULL OFF
10729:                 ENDIF
10730:                 IF USED("cursor_4c_CmvTemp")
10731:                     SELECT cursor_4c_Cmv
10732:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10733:                 ENDIF
10734:             ENDIF
10735: 

*-- Linhas 10755 a 10950:
10755:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10756:     * Tabela: sigprtar (cpros, dtinis, usuars)
10757:     *--------------------------------------------------------------------------
10758:     PROCEDURE BtnIniTarefaClick()
10759:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10760:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10761: 
10762:         IF EMPTY(loc_cCpros)
10763:             MsgAviso("Selecione um produto antes de iniciar tarefa.", "Tarefa Designer")
10764:             RETURN
10765:         ENDIF
10766: 
10767:         TRY
10768:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10769:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10770:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10771:             ENDTEXT
10772:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10773:             IF loc_nR > 0
10774:                 THIS.CarregarDesigner()
10775:             ELSE
10776:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10777:             ENDIF
10778:         CATCH TO loc_oErro
10779:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10780:         ENDTRY
10781:     ENDPROC
10782: 
10783:     *--------------------------------------------------------------------------
10784:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10785:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10786:     *--------------------------------------------------------------------------
10787:     PROCEDURE BtnFimTarefaClick()
10788:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10789:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10790: 
10791:         IF EMPTY(loc_cCpros)
10792:             MsgAviso("Selecione um produto antes de finalizar tarefa.", "Tarefa Designer")
10793:             RETURN
10794:         ENDIF
10795: 
10796:         TRY
10797:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10798:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10799:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10800:             ENDTEXT
10801:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10802:             IF loc_nR > 0
10803:                 THIS.CarregarDesigner()
10804:             ELSE
10805:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10806:             ENDIF
10807:         CATCH TO loc_oErro
10808:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10809:         ENDTRY
10810:     ENDPROC
10811: 
10812:     *--------------------------------------------------------------------------
10813:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10814:     * Tabela: sigprarq (cpros, arquivos)
10815:     *--------------------------------------------------------------------------
10816:     PROCEDURE BtnInsArqsClick()
10817:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10818:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10819: 
10820:         IF EMPTY(loc_cCpros)
10821:             MsgAviso("Selecione um produto para inserir arquivo.", "Arquivos Designer")
10822:             RETURN
10823:         ENDIF
10824: 
10825:         loc_cArquivo = GETFILE("*.*", "Selecionar Arquivo para Designer")
10826:         IF EMPTY(loc_cArquivo)
10827:             RETURN
10828:         ENDIF
10829: 
10830:         TRY
10831:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10832:                 INSERT INTO sigprarq (cpros, arquivos)
10833:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10834:             ENDTEXT
10835:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10836:             IF loc_nR > 0
10837:                 THIS.CarregarDesigner()
10838:             ELSE
10839:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10840:             ENDIF
10841:         CATCH TO loc_oErro
10842:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10843:         ENDTRY
10844:     ENDPROC
10845: 
10846:     *--------------------------------------------------------------------------
10847:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10848:     *--------------------------------------------------------------------------
10849:     PROCEDURE BtnExcArqsClick()
10850:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10851:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10852: 
10853:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10854:             MsgAviso("Selecione um arquivo para excluir.", "Arquivos Designer")
10855:             RETURN
10856:         ENDIF
10857: 
10858:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10859: 
10860:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10861:             TRY
10862:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10863:                     DELETE FROM sigprarq
10864:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10865:                 ENDTEXT
10866:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10867:                 IF loc_nR > 0
10868:                     THIS.CarregarDesigner()
10869:                 ELSE
10870:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10871:                 ENDIF
10872:             CATCH TO loc_oErro
10873:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10874:             ENDTRY
10875:         ENDIF
10876:     ENDPROC
10877: 
10878:     *--------------------------------------------------------------------------
10879:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10880:     *--------------------------------------------------------------------------
10881:     PROCEDURE BtnOpnArqsClick()
10882:         LOCAL loc_cArquivo
10883: 
10884:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10885:             MsgAviso("Selecione um arquivo para abrir.", "Arquivos Designer")
10886:             RETURN
10887:         ENDIF
10888: 
10889:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10890: 
10891:         IF EMPTY(loc_cArquivo)
10892:             MsgAviso("Caminho do arquivo n" + CHR(227) + "o informado.", "Arquivos Designer")
10893:             RETURN
10894:         ENDIF
10895: 
10896:         TRY
10897:             DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
10898:                 INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
10899:                 STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
10900:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
10901:         CATCH TO loc_oErro
10902:             MsgErro("Erro ao abrir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnOpnArqsClick")
10903:         ENDTRY
10904:     ENDPROC
10905: 
10906:     *--------------------------------------------------------------------------
10907:     * CarregarDesigner - Carrega grids de tarefas e arquivos do Designer (Tab 5)
10908:     * Tabelas: sigprtar (tarefas), sigprarq (arquivos)
10909:     *--------------------------------------------------------------------------
10910:     PROTECTED PROCEDURE CarregarDesigner()
10911:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10912:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10913:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
10914: 
10915:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
10916:             RETURN
10917:         ENDIF
10918: 
10919:         TRY
10920:             *-- Tarefas do Designer
10921:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10922:                 SELECT dtinis, dtfims, usuars, tarefas
10923:                 FROM sigprtar
10924:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10925:                 ORDER BY dtinis DESC
10926:             ENDTEXT
10927:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10928:             IF loc_nR > 0
10929:                 IF USED("cursor_4c_Designer")
10930:                     SELECT cursor_4c_Designer
10931:                     ZAP
10932:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10933:                 ENDIF
10934:                 IF USED("cursor_4c_DesignerTmp")
10935:                     USE IN cursor_4c_DesignerTmp
10936:                 ENDIF
10937:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10938:                     loc_oPg.grd_4c_Designer.Refresh()
10939:                 ENDIF
10940:             ENDIF
10941: 
10942:             *-- Arquivos do Designer
10943:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10944:                 SELECT arquivos FROM sigprarq
10945:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10946:                 ORDER BY arquivos
10947:             ENDTEXT
10948:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10949:             IF loc_nR > 0
10950:                 IF USED("cursor_4c_Arquivos")

*-- Linhas 10989 a 12135:
10989:     * Salvar: habilitado apenas em INCLUIR e ALTERAR
10990:     * Cancelar: sempre habilitado em Page2
10991:     *--------------------------------------------------------------------------
10992:     PROCEDURE AjustarBotoesPorModo()
10993:         LOCAL loc_oBotoesDados, loc_lEmEdicao
10994:         loc_oBotoesDados = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
10995:         loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10996: 
10997:         TRY
10998:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
10999:                 loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
11000:             ENDIF
11001:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
11002:                 loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
11003:             ENDIF
11004:         CATCH TO loc_oErro
11005:             MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
11006:         ENDTRY
11007:     ENDPROC
11008: 
11009:     *--------------------------------------------------------------------------
11010:     * CompoGrd_AfterRowColChange - Grid composicao: ao mover linha/coluna
11011:     * Atualiza campos Get_Desc e getObsOFs com dados da linha atual
11012:     *--------------------------------------------------------------------------
11013:     PROCEDURE CompoGrd_AfterRowColChange(par_nColIndex)
11014:         LOCAL loc_oPg
11015:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11016: 
11017:         TRY
11018:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
11019:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11020:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_Compo.dcompos, ""))
11021:                 ENDIF
11022:             ENDIF
11023:         CATCH TO loc_oErro
11024:             MsgErro(loc_oErro.Message, "FormProduto.CompoGrd_AfterRowColChange")
11025:         ENDTRY
11026:     ENDPROC
11027: 
11028:     *--------------------------------------------------------------------------
11029:     * SubCompoGrd_AfterRowColChange - Grid sub-componente: ao mover linha
11030:     * Atualiza campos get_desccp e get_matsub com dados da linha atual
11031:     *--------------------------------------------------------------------------
11032:     PROCEDURE SubCompoGrd_AfterRowColChange(par_nColIndex)
11033:         LOCAL loc_oPg
11034:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11035: 
11036:         TRY
11037:             IF USED("cursor_4c_SubCompo") AND !EOF("cursor_4c_SubCompo")
11038:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11039:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(NVL(cursor_4c_SubCompo.dcompos, ""))
11040:                 ENDIF
11041:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11042:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(NVL(cursor_4c_SubCompo.matsubs, ""))
11043:                 ENDIF
11044:             ENDIF
11045:         CATCH TO loc_oErro
11046:             MsgErro(loc_oErro.Message, "FormProduto.SubCompoGrd_AfterRowColChange")
11047:         ENDTRY
11048:     ENDPROC
11049: 
11050:     *--------------------------------------------------------------------------
11051:     * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
11052:     *--------------------------------------------------------------------------
11053:     PROCEDURE ChkLiberaCustoClick()
11054:         LOCAL loc_oPg, loc_lLibera
11055:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11056:         loc_lLibera = .F.
11057: 
11058:         TRY
11059:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
11060:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
11061:             ENDIF
11062:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
11063:                 loc_oPg.txt_4c_Pcus.ReadOnly     = !loc_lLibera
11064:             ENDIF
11065:             IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11066:                 loc_oPg.txt_4c_PcusMoe.ReadOnly  = !loc_lLibera
11067:             ENDIF
11068:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
11069:                 loc_oPg.txt_4c_Fcusto.ReadOnly   = !loc_lLibera
11070:             ENDIF
11071:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11072:                 loc_oPg.txt_4c_Cmkpc.ReadOnly    = !loc_lLibera
11073:             ENDIF
11074:         CATCH TO loc_oErro
11075:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaCustoClick")
11076:         ENDTRY
11077:     ENDPROC
11078: 
11079:     *--------------------------------------------------------------------------
11080:     * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
11081:     *--------------------------------------------------------------------------
11082:     PROCEDURE ChkLiberaVendaClick()
11083:         LOCAL loc_oPg, loc_lLibera
11084:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11085:         loc_lLibera = .F.
11086: 
11087:         TRY
11088:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
11089:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
11090:             ENDIF
11091:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
11092:                 loc_oPg.txt_4c_Margem.ReadOnly   = !loc_lLibera
11093:             ENDIF
11094:             IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11095:                 loc_oPg.txt_4c_Moeda.ReadOnly    = !loc_lLibera
11096:             ENDIF
11097:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11098:                 loc_oPg.txt_4c_Ftio.ReadOnly     = !loc_lLibera
11099:             ENDIF
11100:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
11101:                 loc_oPg.txt_4c_Fvenda.ReadOnly   = !loc_lLibera
11102:             ENDIF
11103:             IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11104:                 loc_oPg.txt_4c_Moepv.ReadOnly    = !loc_lLibera
11105:             ENDIF
11106:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11107:                 loc_oPg.txt_4c_Moev.ReadOnly     = !loc_lLibera
11108:             ENDIF
11109:         CATCH TO loc_oErro
11110:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaVendaClick")
11111:         ENDTRY
11112:     ENDPROC
11113: 
11114:     *--------------------------------------------------------------------------
11115:     * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
11116:     *--------------------------------------------------------------------------
11117:     PROCEDURE ChkPvendaClick()
11118:         LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
11119:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11120: 
11121:         TRY
11122:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
11123:                 loc_nPvideal = loc_oPg.txt_4c_Pvideal.Value
11124:             ELSE
11125:                 loc_nPvideal = 0
11126:             ENDIF
11127:             IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
11128:                 loc_nEncarg = loc_oPg.txt_4c_Encarg.Value
11129:             ELSE
11130:                 loc_nEncarg = 1
11131:             ENDIF
11132:             IF loc_nEncarg = 0
11133:                 loc_nEncarg = 1
11134:             ENDIF
11135:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
11136:                 loc_oPg.txt_4c_Pven.Value = loc_nPvideal / loc_nEncarg
11137:             ENDIF
11138:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11139:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moeda.Value
11140:             ENDIF
11141:         CATCH TO loc_oErro
11142:             MsgErro(loc_oErro.Message, "FormProduto.ChkPvendaClick")
11143:         ENDTRY
11144:     ENDPROC
11145: 
11146:     *--------------------------------------------------------------------------
11147:     * TabCompo_MoecLostFocus - LostFocus de txt_4c_PcusMoe (getMoec)
11148:     * Valida codigo de moeda de custo - lookup em SigCdMoe
11149:     *--------------------------------------------------------------------------
11150:     PROCEDURE TabCompo_MoecLostFocus()
11151:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11152:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11153:         loc_lResultado = .T.
11154: 
11155:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11156:             RETURN
11157:         ENDIF
11158: 
11159:         TRY
11160:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11161:                 RETURN
11162:             ENDIF
11163:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_PcusMoe.Value)
11164:             IF EMPTY(loc_cCod)
11165:                 RETURN
11166:             ENDIF
11167:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoecLostFocusValidado
11168:                 RETURN
11169:             ENDIF
11170:             THIS.this_cUltimoTabCompo_MoecLostFocusValidado = loc_cCod
11171: 
11172:             gb_4c_ValidandoUI = .T.
11173:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11174:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11175:             gb_4c_ValidandoUI = .F.
11176: 
11177:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11178:                 *-- Nao encontrou: abre lookup
11179:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11180:                 loc_oForm.Caption = "Moedas"
11181:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11182:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11183:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11184:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11185:                 loc_oForm.Show()
11186:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11187:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11188:                     USE IN cursor_4c_BuscaAux
11189:                 ELSE
11190:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11191:                 ENDIF
11192:                 loc_oForm.Release()
11193:             ENDIF
11194:             IF USED("cursor_4c_MoecTmp")
11195:                 USE IN cursor_4c_MoecTmp
11196:             ENDIF
11197:         CATCH TO loc_oErro
11198:             gb_4c_ValidandoUI = .F.
11199:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")
11200:         ENDTRY
11201:     ENDPROC
11202: 
11203:     *--------------------------------------------------------------------------
11204:     * TabCompo_MoecusfLostFocus - LostFocus de txt_4c_MoecusFoe (getMoecusf)
11205:     * Valida codigo de moeda de custo com feitio - lookup em SigCdMoe
11206:     *--------------------------------------------------------------------------
11207:     PROCEDURE TabCompo_MoecusfLostFocus()
11208:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11209:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11210: 
11211:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11212:             RETURN
11213:         ENDIF
11214: 
11215:         TRY
11216:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
11217:                 RETURN
11218:             ENDIF
11219:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MoecusFoe.Value)
11220:             IF EMPTY(loc_cCod)
11221:                 RETURN
11222:             ENDIF
11223:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado
11224:                 RETURN
11225:             ENDIF
11226:             THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado = loc_cCod
11227: 
11228:             gb_4c_ValidandoUI = .T.
11229:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11230:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11231:             gb_4c_ValidandoUI = .F.
11232: 
11233:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11234:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11235:                 loc_oForm.Caption = "Moedas"
11236:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11237:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11238:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11239:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11240:                 loc_oForm.Show()
11241:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11242:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11243:                     USE IN cursor_4c_BuscaAux
11244:                 ELSE
11245:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11246:                 ENDIF
11247:                 loc_oForm.Release()
11248:             ENDIF
11249:             IF USED("cursor_4c_MoecusfTmp")
11250:                 USE IN cursor_4c_MoecusfTmp
11251:             ENDIF
11252:         CATCH TO loc_oErro
11253:             gb_4c_ValidandoUI = .F.
11254:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")
11255:         ENDTRY
11256:     ENDPROC
11257: 
11258:     *--------------------------------------------------------------------------
11259:     * TabCompo_MoedaLostFocus - LostFocus de txt_4c_Moeda (getMoeda)
11260:     * Valida moeda de venda - lookup em SigCdMoe
11261:     *--------------------------------------------------------------------------
11262:     PROCEDURE TabCompo_MoedaLostFocus()
11263:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11264:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11265: 
11266:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11267:             RETURN
11268:         ENDIF
11269: 
11270:         TRY
11271:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11272:                 RETURN
11273:             ENDIF
11274:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
11275:             IF EMPTY(loc_cCod)
11276:                 RETURN
11277:             ENDIF
11278:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoedaLostFocusValidado
11279:                 RETURN
11280:             ENDIF
11281:             THIS.this_cUltimoTabCompo_MoedaLostFocusValidado = loc_cCod
11282: 
11283:             gb_4c_ValidandoUI = .T.
11284:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11285:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11286:             gb_4c_ValidandoUI = .F.
11287: 
11288:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11289:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11290:                 loc_oForm.Caption = "Moedas"
11291:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11292:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11293:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11294:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11295:                 loc_oForm.Show()
11296:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11297:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11298:                     USE IN cursor_4c_BuscaAux
11299:                 ELSE
11300:                     loc_oPg.txt_4c_Moeda.Value = ""
11301:                 ENDIF
11302:                 loc_oForm.Release()
11303:             ENDIF
11304:             IF USED("cursor_4c_MoedaTmp")
11305:                 USE IN cursor_4c_MoedaTmp
11306:             ENDIF
11307:         CATCH TO loc_oErro
11308:             gb_4c_ValidandoUI = .F.
11309:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")
11310:         ENDTRY
11311:     ENDPROC
11312: 
11313:     *--------------------------------------------------------------------------
11314:     * TabCompo_MoepvLostFocus - LostFocus de txt_4c_Moepv (getMoepv)
11315:     * Valida moeda do preco de venda - lookup em SigCdMoe
11316:     *--------------------------------------------------------------------------
11317:     PROCEDURE TabCompo_MoepvLostFocus()
11318:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11319:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11320: 
11321:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11322:             RETURN
11323:         ENDIF
11324: 
11325:         TRY
11326:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11327:                 RETURN
11328:             ENDIF
11329:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
11330:             IF EMPTY(loc_cCod)
11331:                 RETURN
11332:             ENDIF
11333:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoepvLostFocusValidado
11334:                 RETURN
11335:             ENDIF
11336:             THIS.this_cUltimoTabCompo_MoepvLostFocusValidado = loc_cCod
11337: 
11338:             gb_4c_ValidandoUI = .T.
11339:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11340:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11341:             gb_4c_ValidandoUI = .F.
11342: 
11343:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11344:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11345:                 loc_oForm.Caption = "Moedas"
11346:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11347:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11348:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11349:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11350:                 loc_oForm.Show()
11351:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11352:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11353:                     USE IN cursor_4c_BuscaAux
11354:                 ELSE
11355:                     loc_oPg.txt_4c_Moepv.Value = ""
11356:                 ENDIF
11357:                 loc_oForm.Release()
11358:             ENDIF
11359:             IF USED("cursor_4c_MoepvTmp")
11360:                 USE IN cursor_4c_MoepvTmp
11361:             ENDIF
11362:         CATCH TO loc_oErro
11363:             gb_4c_ValidandoUI = .F.
11364:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")
11365:         ENDTRY
11366:     ENDPROC
11367: 
11368:     *--------------------------------------------------------------------------
11369:     * TabCompo_MoevLostFocus - LostFocus de txt_4c_Moev (getMoev)
11370:     * Valida moeda do valor de venda - lookup em SigCdMoe
11371:     *--------------------------------------------------------------------------
11372:     PROCEDURE TabCompo_MoevLostFocus()
11373:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11374:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11375: 
11376:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11377:             RETURN
11378:         ENDIF
11379: 
11380:         TRY
11381:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11382:                 RETURN
11383:             ENDIF
11384:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
11385:             IF EMPTY(loc_cCod)
11386:                 RETURN
11387:             ENDIF
11388:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoevLostFocusValidado
11389:                 RETURN
11390:             ENDIF
11391:             THIS.this_cUltimoTabCompo_MoevLostFocusValidado = loc_cCod
11392: 
11393:             gb_4c_ValidandoUI = .T.
11394:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11395:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11396:             gb_4c_ValidandoUI = .F.
11397: 
11398:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11399:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11400:                 loc_oForm.Caption = "Moedas"
11401:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11402:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11403:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11404:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11405:                 loc_oForm.Show()
11406:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11407:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11408:                     USE IN cursor_4c_BuscaAux
11409:                 ELSE
11410:                     loc_oPg.txt_4c_Moev.Value = ""
11411:                 ENDIF
11412:                 loc_oForm.Release()
11413:             ENDIF
11414:             IF USED("cursor_4c_MoevTmp")
11415:                 USE IN cursor_4c_MoevTmp
11416:             ENDIF
11417:         CATCH TO loc_oErro
11418:             gb_4c_ValidandoUI = .F.
11419:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")
11420:         ENDTRY
11421:     ENDPROC
11422: 
11423:     *--------------------------------------------------------------------------
11424:     * TabCompo_FtioLostFocus - LostFocus de txt_4c_Ftio (Getftio)
11425:     * Valida codigo de feitio de venda - lookup em SigPrFti (Tipos<>1)
11426:     *--------------------------------------------------------------------------
11427:     PROCEDURE TabCompo_FtioLostFocus()
11428:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11429:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11430: 
11431:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11432:             RETURN
11433:         ENDIF
11434: 
11435:         TRY
11436:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11437:                 RETURN
11438:             ENDIF
11439:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
11440:             IF EMPTY(loc_cCod)
11441:                 THIS.CarregarComposicao()
11442:                 RETURN
11443:             ENDIF
11444:             IF loc_cCod == THIS.this_cUltimoTabCompo_FtioLostFocusValidado
11445:                 RETURN
11446:             ENDIF
11447:             THIS.this_cUltimoTabCompo_FtioLostFocusValidado = loc_cCod
11448: 
11449:             gb_4c_ValidandoUI = .T.
11450:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11451:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11452:             gb_4c_ValidandoUI = .F.
11453: 
11454:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11455:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11456:                 loc_oForm.Caption = "Feitios"
11457:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11458:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11459:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11460:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11461:                 loc_oForm.Show()
11462:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11463:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11464:                     USE IN cursor_4c_BuscaAux
11465:                 ELSE
11466:                     loc_oPg.txt_4c_Ftio.Value = ""
11467:                     IF USED("cursor_4c_FtioTmp")
11468:                         USE IN cursor_4c_FtioTmp
11469:                     ENDIF
11470:                     THIS.CarregarComposicao()
11471:                     RETURN
11472:                 ENDIF
11473:                 loc_oForm.Release()
11474:             ENDIF
11475:             IF USED("cursor_4c_FtioTmp")
11476:                 USE IN cursor_4c_FtioTmp
11477:             ENDIF
11478:             THIS.CarregarComposicao()
11479:         CATCH TO loc_oErro
11480:             gb_4c_ValidandoUI = .F.
11481:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FtioLostFocus")
11482:         ENDTRY
11483:     ENDPROC
11484: 
11485:     *--------------------------------------------------------------------------
11486:     * TabCompo_CmkpcLostFocus - LostFocus de txt_4c_Cmkpc (Get_cmkpc)
11487:     * Valida codigo de feitio de custo - lookup em SigPrFti (Tipos=1)
11488:     *--------------------------------------------------------------------------
11489:     PROCEDURE TabCompo_CmkpcLostFocus()
11490:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11491:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11492: 
11493:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11494:             RETURN
11495:         ENDIF
11496: 
11497:         TRY
11498:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11499:                 RETURN
11500:             ENDIF
11501:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
11502:             IF EMPTY(loc_cCod)
11503:                 THIS.CarregarComposicao()
11504:                 RETURN
11505:             ENDIF
11506:             IF loc_cCod == THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado
11507:                 RETURN
11508:             ENDIF
11509:             THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado = loc_cCod
11510: 
11511:             gb_4c_ValidandoUI = .T.
11512:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11513:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11514:             gb_4c_ValidandoUI = .F.
11515: 
11516:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11517:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11518:                 loc_oForm.Caption = "Feitios de Custo"
11519:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11520:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11521:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11522:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11523:                 loc_oForm.Show()
11524:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11525:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11526:                     USE IN cursor_4c_BuscaAux
11527:                 ELSE
11528:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11529:                     IF USED("cursor_4c_CmkpcTmp")
11530:                         USE IN cursor_4c_CmkpcTmp
11531:                     ENDIF
11532:                     THIS.CarregarComposicao()
11533:                     RETURN
11534:                 ENDIF
11535:                 loc_oForm.Release()
11536:             ENDIF
11537:             IF USED("cursor_4c_CmkpcTmp")
11538:                 USE IN cursor_4c_CmkpcTmp
11539:             ENDIF
11540:             THIS.CarregarComposicao()
11541:         CATCH TO loc_oErro
11542:             gb_4c_ValidandoUI = .F.
11543:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_CmkpcLostFocus")
11544:         ENDTRY
11545:     ENDPROC
11546: 
11547:     *--------------------------------------------------------------------------
11548:     * TabCompo_StatusLostFocus - LostFocus de txt_4c_Status (getStatus)
11549:     * Atualiza composicao apos mudanca de status
11550:     *--------------------------------------------------------------------------
11551:     PROCEDURE TabCompo_StatusLostFocus()
11552:         TRY
11553:             THIS.CarregarComposicao()
11554:         CATCH TO loc_oErro
11555:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_StatusLostFocus")
11556:         ENDTRY
11557:     ENDPROC
11558: 
11559:     *--------------------------------------------------------------------------
11560:     * TabCompo_MargemLostFocus - LostFocus de txt_4c_Margem (getMargem)
11561:     * Recalcula preco de venda ao mudar margem/markup
11562:     *--------------------------------------------------------------------------
11563:     PROCEDURE TabCompo_MargemLostFocus()
11564:         TRY
11565:             THIS.CarregarComposicao()
11566:         CATCH TO loc_oErro
11567:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MargemLostFocus")
11568:         ENDTRY
11569:     ENDPROC
11570: 
11571:     *--------------------------------------------------------------------------
11572:     * TabCompo_FvendaLostFocus - LostFocus de txt_4c_Fvenda (getFvenda)
11573:     * Recalcula preco de venda ao mudar fator
11574:     *--------------------------------------------------------------------------
11575:     PROCEDURE TabCompo_FvendaLostFocus()
11576:         TRY
11577:             THIS.CarregarComposicao()
11578:         CATCH TO loc_oErro
11579:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FvendaLostFocus")
11580:         ENDTRY
11581:     ENDPROC
11582: 
11583:     *--------------------------------------------------------------------------
11584:     * TabCompo_DescLostFocus - LostFocus de txt_4c_Desc (Get_Desc)
11585:     * Valida/atualiza descricao do material de composicao
11586:     *--------------------------------------------------------------------------
11587:     PROCEDURE TabCompo_DescLostFocus()
11588:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11589:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11590: 
11591:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11592:             RETURN
11593:         ENDIF
11594: 
11595:         TRY
11596:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11597:                 RETURN
11598:             ENDIF
11599:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
11600:             IF EMPTY(loc_cDesc)
11601:                 RETURN
11602:             ENDIF
11603:             IF loc_cDesc == THIS.this_cUltimoTabCompo_DescLostFocusValidado
11604:                 RETURN
11605:             ENDIF
11606:             THIS.this_cUltimoTabCompo_DescLostFocusValidado = loc_cDesc
11607: 
11608:             gb_4c_ValidandoUI = .T.
11609:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11610:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11611:             gb_4c_ValidandoUI = .F.
11612: 
11613:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11614:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11615:                 loc_oForm.Caption = "Produtos"
11616:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11617:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11618:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11619:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11620:                 loc_oForm.Show()
11621:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11622:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11623:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11624:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11625:                     ENDIF
11626:                     USE IN cursor_4c_BuscaAux
11627:                 ELSE
11628:                     loc_oPg.txt_4c_Desc.Value = ""
11629:                 ENDIF
11630:                 loc_oForm.Release()
11631:             ELSE
11632:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11633:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11634:                 ENDIF
11635:             ENDIF
11636:             IF USED("cursor_4c_DescTmp")
11637:                 USE IN cursor_4c_DescTmp
11638:             ENDIF
11639:         CATCH TO loc_oErro
11640:             gb_4c_ValidandoUI = .F.
11641:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DescLostFocus")
11642:         ENDTRY
11643:     ENDPROC
11644: 
11645:     *--------------------------------------------------------------------------
11646:     * TabCompo_MatPLostFocus - LostFocus de txt_4c_MatP (Get_MatP)
11647:     * Valida codigo de material principal - lookup em SigCdPro
11648:     *--------------------------------------------------------------------------
11649:     PROCEDURE TabCompo_MatPLostFocus()
11650:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11651:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11652: 
11653:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11654:             RETURN
11655:         ENDIF
11656: 
11657:         TRY
11658:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11659:                 RETURN
11660:             ENDIF
11661:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
11662:             IF EMPTY(loc_cCod)
11663:                 RETURN
11664:             ENDIF
11665:             IF loc_cCod == THIS.this_cUltimoTabCompo_MatPLostFocusValidado
11666:                 RETURN
11667:             ENDIF
11668:             THIS.this_cUltimoTabCompo_MatPLostFocusValidado = loc_cCod
11669: 
11670:             gb_4c_ValidandoUI = .T.
11671:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11672:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11673:             gb_4c_ValidandoUI = .F.
11674: 
11675:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11676:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11677:                 loc_oForm.Caption = "Material Principal"
11678:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11679:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11680:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11681:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11682:                 loc_oForm.Show()
11683:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11684:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11685:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11686:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11687:                     ENDIF
11688:                     USE IN cursor_4c_BuscaAux
11689:                 ELSE
11690:                     loc_oPg.txt_4c_MatP.Value = ""
11691:                 ENDIF
11692:                 loc_oForm.Release()
11693:             ELSE
11694:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11695:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11696:                 ENDIF
11697:             ENDIF
11698:             IF USED("cursor_4c_MatPTmp")
11699:                 USE IN cursor_4c_MatPTmp
11700:             ENDIF
11701:         CATCH TO loc_oErro
11702:             gb_4c_ValidandoUI = .F.
11703:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatPLostFocus")
11704:         ENDTRY
11705:     ENDPROC
11706: 
11707:     *--------------------------------------------------------------------------
11708:     * TabCompo_DesccpLostFocus - LostFocus de txt_4c__desccp (get_desccp)
11709:     * Valida descricao de sub-componente - lookup em SigCdPro
11710:     *--------------------------------------------------------------------------
11711:     PROCEDURE TabCompo_DesccpLostFocus()
11712:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11713:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11714: 
11715:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11716:             RETURN
11717:         ENDIF
11718: 
11719:         TRY
11720:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11721:                 RETURN
11722:             ENDIF
11723:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__desccp.Value)
11724:             IF EMPTY(loc_cDesc)
11725:                 RETURN
11726:             ENDIF
11727:             IF loc_cDesc == THIS.this_cUltimoTabCompo_DesccpLostFocusValidado
11728:                 RETURN
11729:             ENDIF
11730:             THIS.this_cUltimoTabCompo_DesccpLostFocusValidado = loc_cDesc
11731: 
11732:             gb_4c_ValidandoUI = .T.
11733:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11734:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11735:             gb_4c_ValidandoUI = .F.
11736: 
11737:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11738:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11739:                 loc_oForm.Caption = "Sub-Componentes"
11740:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11741:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11742:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11743:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11744:                 loc_oForm.Show()
11745:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11746:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11747:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11748:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11749:                     ENDIF
11750:                     USE IN cursor_4c_BuscaAux
11751:                 ELSE
11752:                     loc_oPg.txt_4c__desccp.Value = ""
11753:                 ENDIF
11754:                 loc_oForm.Release()
11755:             ELSE
11756:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11757:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11758:                 ENDIF
11759:             ENDIF
11760:             IF USED("cursor_4c_DesccpTmp")
11761:                 USE IN cursor_4c_DesccpTmp
11762:             ENDIF
11763:         CATCH TO loc_oErro
11764:             gb_4c_ValidandoUI = .F.
11765:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DesccpLostFocus")
11766:         ENDTRY
11767:     ENDPROC
11768: 
11769:     *--------------------------------------------------------------------------
11770:     * TabCompo_MatsubLostFocus - LostFocus de txt_4c__matsub (get_matsub)
11771:     * Valida codigo do substituto - lookup em SigCdPro
11772:     *--------------------------------------------------------------------------
11773:     PROCEDURE TabCompo_MatsubLostFocus()
11774:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11775:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11776: 
11777:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11778:             RETURN
11779:         ENDIF
11780: 
11781:         TRY
11782:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11783:                 RETURN
11784:             ENDIF
11785:             loc_cCod = ALLTRIM(loc_oPg.txt_4c__matsub.Value)
11786:             IF EMPTY(loc_cCod)
11787:                 RETURN
11788:             ENDIF
11789:             IF loc_cCod == THIS.this_cUltimoTabCompo_MatsubLostFocusValidado
11790:                 RETURN
11791:             ENDIF
11792:             THIS.this_cUltimoTabCompo_MatsubLostFocusValidado = loc_cCod
11793: 
11794:             gb_4c_ValidandoUI = .T.
11795:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11796:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11797:             gb_4c_ValidandoUI = .F.
11798: 
11799:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11800:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11801:                 loc_oForm.Caption = "Produto Substituto"
11802:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11803:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11804:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11805:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11806:                 loc_oForm.Show()
11807:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11808:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11809:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11810:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11811:                     ENDIF
11812:                     USE IN cursor_4c_BuscaAux
11813:                 ELSE
11814:                     loc_oPg.txt_4c__matsub.Value = ""
11815:                 ENDIF
11816:                 loc_oForm.Release()
11817:             ELSE
11818:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11819:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11820:                 ENDIF
11821:             ENDIF
11822:             IF USED("cursor_4c_MatsubTmp")
11823:                 USE IN cursor_4c_MatsubTmp
11824:             ENDIF
11825:         CATCH TO loc_oErro
11826:             gb_4c_ValidandoUI = .F.
11827:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatsubLostFocus")
11828:         ENDTRY
11829:     ENDPROC
11830: 
11831:     *--------------------------------------------------------------------------
11832:     * CmdCompoIncluirClick - Botao incluir linha na composicao (grdCompo)
11833:     *--------------------------------------------------------------------------
11834:     PROCEDURE CmdCompoIncluirClick()
11835:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
11836:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11837:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11838: 
11839:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11840:             RETURN
11841:         ENDIF
11842:         IF EMPTY(loc_cCpros)
11843:             RETURN
11844:         ENDIF
11845: 
11846:         TRY
11847:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11848:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11849:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11850:             IF loc_nR > 0
11851:                 THIS.CarregarComposicao()
11852:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11853:                     loc_oPg.grd_4c_Compo.SetFocus()
11854:                 ENDIF
11855:             ELSE
11856:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11857:             ENDIF
11858:         CATCH TO loc_oErro
11859:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11860:         ENDTRY
11861:     ENDPROC
11862: 
11863:     *--------------------------------------------------------------------------
11864:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)
11865:     *--------------------------------------------------------------------------
11866:     PROCEDURE CmdCompoExcluirClick()
11867:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11868:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11869:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11870: 
11871:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11872:             RETURN
11873:         ENDIF
11874:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11875:             RETURN
11876:         ENDIF
11877: 
11878:         TRY
11879:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11880:             IF EMPTY(loc_cMats)
11881:                 RETURN
11882:             ENDIF
11883:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11884:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11885:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11886:             IF loc_nR > 0
11887:                 THIS.CarregarComposicao()
11888:             ELSE
11889:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11890:             ENDIF
11891:         CATCH TO loc_oErro
11892:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11893:         ENDTRY
11894:     ENDPROC
11895: 
11896:     *--------------------------------------------------------------------------
11897:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11898:     *--------------------------------------------------------------------------
11899:     PROCEDURE CmdCompoAtualizarClick()
11900:         TRY
11901:             THIS.CarregarComposicao()
11902:         CATCH TO loc_oErro
11903:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtualizarClick")
11904:         ENDTRY
11905:     ENDPROC
11906: 
11907:     *--------------------------------------------------------------------------
11908:     * CmdCompoAtuPesosClick - Botao atualizar pesos da composicao
11909:     *--------------------------------------------------------------------------
11910:     PROCEDURE CmdCompoAtuPesosClick()
11911:         TRY
11912:             THIS.CarregarComposicao()
11913:         CATCH TO loc_oErro
11914:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtuPesosClick")
11915:         ENDTRY
11916:     ENDPROC
11917: 
11918:     *--------------------------------------------------------------------------
11919:     * CmdCompoRecalcClick - Botao recalcular todos os precos
11920:     *--------------------------------------------------------------------------
11921:     PROCEDURE CmdCompoRecalcClick()
11922:         TRY
11923:             THIS.CarregarComposicao()
11924:         CATCH TO loc_oErro
11925:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoRecalcClick")
11926:         ENDTRY
11927:     ENDPROC
11928: 
11929:     *--------------------------------------------------------------------------
11930:     * CmdSubCpIncluirClick - Botao incluir sub-componente (grdsubcp)
11931:     *--------------------------------------------------------------------------
11932:     PROCEDURE CmdSubCpIncluirClick()
11933:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11934:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11935:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11936: 
11937:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11938:             RETURN
11939:         ENDIF
11940:         IF EMPTY(loc_cCpros)
11941:             RETURN
11942:         ENDIF
11943:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11944:             MsgErro("Selecione um item na composi" + CHR(231) + CHR(227) + "o principal primeiro.", "FormProduto.CmdSubCpIncluirClick")
11945:             RETURN
11946:         ENDIF
11947: 
11948:         TRY
11949:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11950:             IF EMPTY(loc_cMats)
11951:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11952:                 RETURN
11953:             ENDIF
11954:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
11955:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
11956:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11957:             IF loc_nR > 0
11958:                 THIS.CarregarComposicao()
11959:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11960:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11961:                 ENDIF
11962:             ELSE
11963:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11964:             ENDIF
11965:         CATCH TO loc_oErro
11966:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11967:         ENDTRY
11968:     ENDPROC
11969: 
11970:     *--------------------------------------------------------------------------
11971:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)
11972:     *--------------------------------------------------------------------------
11973:     PROCEDURE CmdSubCpExcluirClick()
11974:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR
11975:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11976: 
11977:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11978:             RETURN
11979:         ENDIF
11980:         IF NOT USED("cursor_4c_SubCompo") OR EOF("cursor_4c_SubCompo")
11981:             RETURN
11982:         ENDIF
11983: 
11984:         TRY
11985:             loc_cMats = ALLTRIM(NVL(cursor_4c_SubCompo.mats, ""))
11986:             IF EMPTY(loc_cMats)
11987:                 RETURN
11988:             ENDIF
11989:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11990:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11991:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11992:             IF loc_nR > 0
11993:                 THIS.CarregarComposicao()
11994:             ELSE
11995:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11996:             ENDIF
11997:         CATCH TO loc_oErro
11998:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11999:         ENDTRY
12000:     ENDPROC
12001: 
12002:     *--------------------------------------------------------------------------
12003:     * CmdCalcValsClick - Botao calcular valores de preco/custo
12004:     *--------------------------------------------------------------------------
12005:     PROCEDURE CmdCalcValsClick()
12006:         TRY
12007:             THIS.CarregarComposicao()
12008:         CATCH TO loc_oErro
12009:             MsgErro(loc_oErro.Message, "FormProduto.CmdCalcValsClick")
12010:         ENDTRY
12011:     ENDPROC
12012: 
12013:     *--------------------------------------------------------------------------
12014:     * CmdPesoMClick - Botao calcular/atualizar peso medio
12015:     *--------------------------------------------------------------------------
12016:     PROCEDURE CmdPesoMClick()
12017:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_nR
12018:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
12019:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12020: 
12021:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12022:             RETURN
12023:         ENDIF
12024: 
12025:         TRY
12026:             *-- Busca peso calculado a partir da composicao
12027:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
12028:                        "FROM SIGPRCPO c " + ;
12029:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
12030:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
12031:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
12032:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
12033:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
12034:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
12035:                 ENDIF
12036:             ENDIF
12037:             IF USED("cursor_4c_PesoMTmp")
12038:                 USE IN cursor_4c_PesoMTmp
12039:             ENDIF
12040:         CATCH TO loc_oErro
12041:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
12042:         ENDTRY
12043:     ENDPROC
12044: 
12045:     *--------------------------------------------------------------------------
12046:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna
12047:     * Atualiza campos txt_4c_DescCusto e txt_4c_DGruCompos com dados do item
12048:     *--------------------------------------------------------------------------
12049:     PROCEDURE CustosGrd_AfterRowColChange(par_nColIndex)
12050:         LOCAL loc_oPg, loc_cMats, loc_cSQL, loc_nR
12051:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12052: 
12053:         TRY
12054:             IF USED("cursor_4c_CompoCusto") AND !EOF("cursor_4c_CompoCusto")
12055:                 *-- Atualizar campo Descricao
12056:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescCusto", 5)
12057:                     loc_oPg.txt_4c_DescCusto.Value = ALLTRIM(NVL(cursor_4c_CompoCusto.dcompos, ""))
12058:                 ENDIF
12059: 
12060:                 *-- Buscar descricao do grupo com base no material
12061:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12062:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12063:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
12064:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
12065:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
12066:                     gb_4c_ValidandoUI = .T.
12067:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
12068:                     gb_4c_ValidandoUI = .F.
12069:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
12070:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12071:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
12072:                         ENDIF
12073:                     ENDIF
12074:                     IF USED("cursor_4c_GrupoTmpC")
12075:                         USE IN cursor_4c_GrupoTmpC
12076:                     ENDIF
12077:                 ELSE
12078:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12079:                         loc_oPg.txt_4c_DGruCompos.Value = ""
12080:                     ENDIF
12081:                 ENDIF
12082:             ENDIF
12083:         CATCH TO loc_oErro
12084:             gb_4c_ValidandoUI = .F.
12085:             MsgErro(loc_oErro.Message, "FormProduto.CustosGrd_AfterRowColChange")
12086:         ENDTRY
12087:     ENDPROC
12088: 
12089:     *--------------------------------------------------------------------------
12090:     * ConsultaGrd_AfterRowColChange - Grid GrdCons consulta: ao sair de coluna
12091:     * Col4 (Fase/Grupos): busca descricao em SigCdPrf; se nao encontrado abre lookup
12092:     * Col5 (Descricao fase): busca grupos em SigCdPrf por descricao
12093:     * Col8 (Cat): busca descricao em SigCdCat; se nao encontrado abre lookup
12094:     *--------------------------------------------------------------------------
12095:     PROCEDURE ConsultaGrd_AfterRowColChange(par_nColIndex)
12096:         LOCAL loc_oPg, loc_cSQL, loc_nR, loc_cGrupos, loc_cCats, loc_cDcompos
12097:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12098: 
12099:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
12100:             RETURN
12101:         ENDIF
12102: 
12103:         IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12104:             RETURN
12105:         ENDIF
12106: 
12107:         TRY
12108:             DO CASE
12109: 
12110:             *-- Coluna 4 (Fase/Grupos): busca descricao da fase em SigCdPrf
12111:             CASE par_nColIndex = 4
12112:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12113:                 IF !EMPTY(loc_cGrupos)
12114:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
12115:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
12116:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
12117:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
12118:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12119:                             loc_oPg.grd_4c_Consulta.Refresh()
12120:                         ENDIF
12121:                     ELSE
12122:                         THIS.AbrirLookupConsultaFase()
12123:                     ENDIF
12124:                     IF USED("cursor_4c_PrfDesc")
12125:                         USE IN cursor_4c_PrfDesc
12126:                     ENDIF
12127:                 ENDIF
12128: 
12129:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
12130:             CASE par_nColIndex = 5
12131:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
12132:                 IF !EMPTY(loc_cDcompos)
12133:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
12134:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
12135:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")

*-- Linhas 12172 a 12405:
12172:     *--------------------------------------------------------------------------
12173:     * AbrirLookupConsultaFase - Abre lookup SigCdPrf para selecionar fase (col 4)
12174:     *--------------------------------------------------------------------------
12175:     PROCEDURE AbrirLookupConsultaFase()
12176:         LOCAL loc_oPg, loc_oBusca, loc_cGrupos, loc_cDescrs
12177: 
12178:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12179: 
12180:         TRY
12181:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12182:                 RETURN
12183:             ENDIF
12184: 
12185:             loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12186:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", "cursor_4c_PrfSel", "grupos", loc_cGrupos, "Selecionar Fase")
12187:             loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
12188:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12189:             loc_oBusca.Show()
12190: 
12191:             IF loc_oBusca.this_lSelecionou
12192:                 IF USED("cursor_4c_PrfSel")
12193:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_PrfSel.grupos, ""))
12194:                     loc_cDescrs = ALLTRIM(NVL(cursor_4c_PrfSel.descrs, ""))
12195:                     REPLACE cursor_4c_Consulta.grupos  WITH loc_cGrupos
12196:                     REPLACE cursor_4c_Consulta.dcompos WITH loc_cDescrs
12197:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12198:                         loc_oPg.grd_4c_Consulta.Refresh()
12199:                     ENDIF
12200:                 ENDIF
12201:             ELSE
12202:                 REPLACE cursor_4c_Consulta.grupos  WITH ""
12203:                 REPLACE cursor_4c_Consulta.dcompos WITH ""
12204:             ENDIF
12205: 
12206:             IF USED("cursor_4c_PrfSel")
12207:                 USE IN cursor_4c_PrfSel
12208:             ENDIF
12209:             loc_oBusca.Release()
12210:             loc_oBusca = .NULL.
12211: 
12212:         CATCH TO loc_oErro
12213:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaFase")
12214:         ENDTRY
12215:     ENDPROC
12216: 
12217:     *--------------------------------------------------------------------------
12218:     * AbrirLookupConsultaCat - Abre lookup SigCdCat para selecionar categoria (col 8)
12219:     *--------------------------------------------------------------------------
12220:     PROCEDURE AbrirLookupConsultaCat()
12221:         LOCAL loc_oPg, loc_oBusca, loc_cCods, loc_cDescs
12222: 
12223:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12224: 
12225:         TRY
12226:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12227:                 RETURN
12228:             ENDIF
12229: 
12230:             loc_cCods  = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12231:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", "cursor_4c_CatSel", "cods", loc_cCods, "Selecionar Categoria")
12232:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12233:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12234:             loc_oBusca.Show()
12235: 
12236:             IF loc_oBusca.this_lSelecionou
12237:                 IF USED("cursor_4c_CatSel")
12238:                     loc_cCods  = ALLTRIM(NVL(cursor_4c_CatSel.cods,  ""))
12239:                     loc_cDescs = ALLTRIM(NVL(cursor_4c_CatSel.descs, ""))
12240:                     REPLACE cursor_4c_Consulta.cats   WITH loc_cCods
12241:                     REPLACE cursor_4c_Consulta.dscgrp WITH loc_cDescs
12242:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12243:                         loc_oPg.grd_4c_Consulta.Refresh()
12244:                     ENDIF
12245:                 ENDIF
12246:             ELSE
12247:                 REPLACE cursor_4c_Consulta.cats   WITH ""
12248:                 REPLACE cursor_4c_Consulta.dscgrp WITH ""
12249:             ENDIF
12250: 
12251:             IF USED("cursor_4c_CatSel")
12252:                 USE IN cursor_4c_CatSel
12253:             ENDIF
12254:             loc_oBusca.Release()
12255:             loc_oBusca = .NULL.
12256: 
12257:         CATCH TO loc_oErro
12258:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaCat")
12259:         ENDTRY
12260:     ENDPROC
12261: 
12262:     *--------------------------------------------------------------------------
12263:     * CmbTiposCustoValid - ComboBox tipo custo: ao mudar selecao, recarrega grid
12264:     *--------------------------------------------------------------------------
12265:     PROCEDURE CmbTiposCustoValid()
12266:         TRY
12267:             THIS.CarregarCustos()
12268:         CATCH TO loc_oErro
12269:             MsgErro(loc_oErro.Message, "FormProduto.CmbTiposCustoValid")
12270:         ENDTRY
12271:     ENDPROC
12272: 
12273:     *--------------------------------------------------------------------------
12274:     * CmdCustoIncluirClick - Botao incluir linha no grid de custo
12275:     * Insere novo registro em SIGPRCPO com Tipos = valor selecionado no combo
12276:     *--------------------------------------------------------------------------
12277:     PROCEDURE CmdCustoIncluirClick()
12278:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
12279:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12280:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12281: 
12282:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12283:             RETURN
12284:         ENDIF
12285:         IF EMPTY(loc_cCpros)
12286:             RETURN
12287:         ENDIF
12288: 
12289:         TRY
12290:             loc_nTipo = 1
12291:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
12292:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1)
12293:                 *-- ListIndex 1=Todos: usar tipo 1; demais: usar o proprio valor
12294:                 IF loc_nTipo < 1
12295:                     loc_nTipo = 1
12296:                 ENDIF
12297:             ENDIF
12298: 
12299:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12300:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12301:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12302:             IF loc_nR > 0
12303:                 THIS.CarregarCustos()
12304:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12305:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12306:                 ENDIF
12307:             ELSE
12308:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12309:             ENDIF
12310:         CATCH TO loc_oErro
12311:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12312:         ENDTRY
12313:     ENDPROC
12314: 
12315:     *--------------------------------------------------------------------------
12316:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo
12317:     * Remove registro de SIGPRCPO com base no material selecionado
12318:     *--------------------------------------------------------------------------
12319:     PROCEDURE CmdCustoExcluirClick()
12320:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg, loc_lConfirma
12321:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12322:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12323: 
12324:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12325:             RETURN
12326:         ENDIF
12327:         IF NOT USED("cursor_4c_CompoCusto") OR EOF("cursor_4c_CompoCusto")
12328:             RETURN
12329:         ENDIF
12330: 
12331:         TRY
12332:             loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12333: 
12334:             IF EMPTY(loc_cMats)
12335:                 MsgAviso("Selecione um item para excluir.", "FormProduto")
12336:                 RETURN
12337:             ENDIF
12338: 
12339:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do item '" + loc_cMats + "'?", "FormProduto")
12340:             IF !loc_lConfirma
12341:                 RETURN
12342:             ENDIF
12343: 
12344:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12345:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12346:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12347:             IF loc_nR > 0
12348:                 THIS.CarregarCustos()
12349:             ELSE
12350:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12351:             ENDIF
12352:         CATCH TO loc_oErro
12353:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12354:         ENDTRY
12355:     ENDPROC
12356: 
12357:     *==========================================================================
12358:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12359:     *==========================================================================
12360: 
12361:     *--------------------------------------------------------------------------
12362:     * GrdFasesAfterRowColChange - Atualiza imagem + descricao ao navegar no grid
12363:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12364:     *--------------------------------------------------------------------------
12365:     PROCEDURE GrdFasesAfterRowColChange
12366:         LPARAMETERS par_nColIndex
12367:         LOCAL loc_oPg, loc_cCpros, loc_cGrupos, loc_cSQL, loc_nR, loc_cArquivo
12368:         LOCAL loc_nOrdems
12369: 
12370:         TRY
12371:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12372:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12373: 
12374:             IF EMPTY(loc_cCpros) OR !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12375:                 RETURN
12376:             ENDIF
12377: 
12378:             loc_cGrupos  = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12379:             loc_nOrdems  = NVL(cursor_4c_Fases.ordems, 0)
12380: 
12381:             *-- Limpar imagem anterior
12382:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12383:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
12384:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
12385:             ENDIF
12386: 
12387:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12388:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12389:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12390:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12391:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12392:                     AND ordems = <<loc_nOrdems>>
12393:                 ENDTEXT
12394:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12395:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12396:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12397:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12398:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12399:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12400:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12401:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12402:                             ENDIF
12403:                         ENDIF
12404:                     ENDIF
12405:                 ENDIF

*-- Linhas 12442 a 12487:
12442: 
12443:     *--------------------------------------------------------------------------
12444:     * GrdMatrizesAfterRowColChange - Atualiza imagem ao navegar no grid de matrizes
12445:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12446:     *--------------------------------------------------------------------------
12447:     PROCEDURE GrdMatrizesAfterRowColChange
12448:         LPARAMETERS par_nColIndex
12449:         LOCAL loc_oPg, loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFigB64
12450: 
12451:         TRY
12452:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12453: 
12454:             *-- Limpar imagem anterior
12455:             IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5)
12456:                 loc_oPg.img_4c_ImgBorracha.Picture = ""
12457:                 loc_oPg.img_4c_ImgBorracha.Visible = .F.
12458:             ENDIF
12459: 
12460:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
12461:                 RETURN
12462:             ENDIF
12463: 
12464:             loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
12465:             IF EMPTY(loc_cCmats) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12466:                 RETURN
12467:             ENDIF
12468: 
12469:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12470:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12471:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12472:             ENDTEXT
12473:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12474:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12475:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12476:                 IF !EMPTY(loc_cFigB64)
12477:                     *-- Converter de Base64 para binario
12478:                     LOCAL loc_cFigBin
12479:                     loc_cFigBin = STRCONV( ;
12480:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12481:                             "data:image/png;base64,", ""), ;
12482:                             "data:image/jpeg;base64,", ""), ;
12483:                             "data:image/jpg;base64,", ""), 14)
12484:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12485:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12486:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12487:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo

*-- Linhas 12502 a 13224:
12502:     *--------------------------------------------------------------------------
12503:     * ImgFigJpgClick - Clique na imagem da fase: abre zoom
12504:     *--------------------------------------------------------------------------
12505:     PROCEDURE ImgFigJpgClick()
12506:         LOCAL loc_oPg, loc_cArquivo
12507:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12508:         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12509:             loc_cArquivo = loc_oPg.img_4c_ImgFigJpg.Picture
12510:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
12511:                 MsgInfo("Zoom de imagem: " + loc_cArquivo, "Imagem da Fase")
12512:             ENDIF
12513:         ENDIF
12514:     ENDPROC
12515: 
12516:     *--------------------------------------------------------------------------
12517:     * TabFases_CodcorsKeyPress - F4 no campo Cor (aba Fases) abre lookup
12518:     *--------------------------------------------------------------------------
12519:     PROCEDURE TabFases_CodcorsKeyPress
12520:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12521:         IF par_nKeyCode = 115
12522:             THIS.AbrirLookupCorFas()
12523:         ENDIF
12524:     ENDPROC
12525: 
12526:     *--------------------------------------------------------------------------
12527:     * TabFases_CodcorsLostFocus - LostFocus valida cor na aba Fases
12528:     *--------------------------------------------------------------------------
12529:     PROCEDURE TabFases_CodcorsLostFocus()
12530:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12531:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12532:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
12533:             RETURN
12534:         ENDIF
12535:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
12536:         IF loc_cCod == THIS.this_cUltCorFas
12537:             RETURN
12538:         ENDIF
12539:         THIS.this_cUltCorFas = loc_cCod
12540:         IF EMPTY(loc_cCod)
12541:             RETURN
12542:         ENDIF
12543:         TRY
12544:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12545:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12546:             ENDTEXT
12547:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12548:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12549:                 THIS.AbrirLookupCorFas()
12550:             ELSE
12551:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12552:             ENDIF
12553:             IF USED("cursor_4c_VCorFas")
12554:                 USE IN cursor_4c_VCorFas
12555:             ENDIF
12556:         CATCH TO loc_oErro
12557:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12558:         ENDTRY
12559:     ENDPROC
12560: 
12561:     *--------------------------------------------------------------------------
12562:     * AbrirLookupCorFas - Lookup Cor para a aba Fases
12563:     * Atualiza Page7 e Page1 (campos sincronizados)
12564:     *--------------------------------------------------------------------------
12565:     PROTECTED PROCEDURE AbrirLookupCorFas()
12566:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12567:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12568:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12569:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodcorsFas.Value), "")
12570: 
12571:         TRY
12572:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_CorFas", "cods", loc_cVal, "Selecionar Cor")
12573:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12574:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12575:             loc_oBusca.Show()
12576: 
12577:             IF loc_oBusca.this_lSelecionou
12578:                 IF USED("cursor_4c_CorFas")
12579:                     LOCAL loc_cCodSel
12580:                     loc_cCodSel = ALLTRIM(cursor_4c_CorFas.cods)
12581:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12582:                         loc_oPg7.txt_4c_CodcorsFas.Value = loc_cCodSel
12583:                     ENDIF
12584:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codcors", 5)
12585:                         loc_oPg1.txt_4c_Codcors.Value = loc_cCodSel
12586:                     ENDIF
12587:                     THIS.this_oBusinessObject.this_cCodcors = loc_cCodSel
12588:                 ENDIF
12589:             ELSE
12590:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12591:                     loc_oPg7.txt_4c_CodcorsFas.Value = ""
12592:                 ENDIF
12593:             ENDIF
12594: 
12595:             IF USED("cursor_4c_CorFas")
12596:                 USE IN cursor_4c_CorFas
12597:             ENDIF
12598:             loc_oBusca.Release()
12599:         CATCH TO loc_oErro
12600:             MsgErro("Erro no lookup de cor (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCorFas")
12601:         ENDTRY
12602:     ENDPROC
12603: 
12604:     *--------------------------------------------------------------------------
12605:     * TabFases_CodtamsKeyPress - F4 no campo Tamanho (aba Fases) abre lookup
12606:     *--------------------------------------------------------------------------
12607:     PROCEDURE TabFases_CodtamsKeyPress
12608:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12609:         IF par_nKeyCode = 115
12610:             THIS.AbrirLookupTamanhoFas()
12611:         ENDIF
12612:     ENDPROC
12613: 
12614:     *--------------------------------------------------------------------------
12615:     * TabFases_CodtamsLostFocus - LostFocus valida tamanho na aba Fases
12616:     *--------------------------------------------------------------------------
12617:     PROCEDURE TabFases_CodtamsLostFocus()
12618:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12619:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12620:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
12621:             RETURN
12622:         ENDIF
12623:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
12624:         IF loc_cCod == THIS.this_cUltTamFas
12625:             RETURN
12626:         ENDIF
12627:         THIS.this_cUltTamFas = loc_cCod
12628:         IF EMPTY(loc_cCod)
12629:             RETURN
12630:         ENDIF
12631:         TRY
12632:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12633:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12634:             ENDTEXT
12635:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12636:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12637:                 THIS.AbrirLookupTamanhoFas()
12638:             ELSE
12639:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12640:             ENDIF
12641:             IF USED("cursor_4c_VTamFas")
12642:                 USE IN cursor_4c_VTamFas
12643:             ENDIF
12644:         CATCH TO loc_oErro
12645:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12646:         ENDTRY
12647:     ENDPROC
12648: 
12649:     *--------------------------------------------------------------------------
12650:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases
12651:     *--------------------------------------------------------------------------
12652:     PROTECTED PROCEDURE AbrirLookupTamanhoFas()
12653:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12654:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12655:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12656:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodtamsFas.Value), "")
12657: 
12658:         TRY
12659:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_TamFas", "Cods", loc_cVal, "Selecionar Tamanho")
12660:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
12661:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12662:             loc_oBusca.Show()
12663: 
12664:             IF loc_oBusca.this_lSelecionou
12665:                 IF USED("cursor_4c_TamFas")
12666:                     LOCAL loc_cCodSel
12667:                     loc_cCodSel = ALLTRIM(cursor_4c_TamFas.Cods)
12668:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12669:                         loc_oPg7.txt_4c_CodtamsFas.Value = loc_cCodSel
12670:                     ENDIF
12671:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codtams", 5)
12672:                         loc_oPg1.txt_4c_Codtams.Value = loc_cCodSel
12673:                     ENDIF
12674:                     THIS.this_oBusinessObject.this_cCodtams = loc_cCodSel
12675:                 ENDIF
12676:             ELSE
12677:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12678:                     loc_oPg7.txt_4c_CodtamsFas.Value = ""
12679:                 ENDIF
12680:             ENDIF
12681: 
12682:             IF USED("cursor_4c_TamFas")
12683:                 USE IN cursor_4c_TamFas
12684:             ENDIF
12685:             loc_oBusca.Release()
12686:         CATCH TO loc_oErro
12687:             MsgErro("Erro no lookup de tamanho (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanhoFas")
12688:         ENDTRY
12689:     ENDPROC
12690: 
12691:     *--------------------------------------------------------------------------
12692:     * TabFases_CodacbsKeyPress - F4 no campo Acabamento (aba Fases) abre lookup
12693:     *--------------------------------------------------------------------------
12694:     PROCEDURE TabFases_CodacbsKeyPress
12695:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12696:         IF par_nKeyCode = 115
12697:             THIS.AbrirLookupAcabamentoFas()
12698:         ENDIF
12699:     ENDPROC
12700: 
12701:     *--------------------------------------------------------------------------
12702:     * TabFases_CodacbsLostFocus - LostFocus valida acabamento na aba Fases
12703:     *--------------------------------------------------------------------------
12704:     PROCEDURE TabFases_CodacbsLostFocus()
12705:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12706:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12707:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
12708:             RETURN
12709:         ENDIF
12710:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
12711:         IF loc_cCod == THIS.this_cUltAcbFas
12712:             RETURN
12713:         ENDIF
12714:         THIS.this_cUltAcbFas = loc_cCod
12715:         IF EMPTY(loc_cCod)
12716:             IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12717:                 loc_oPg.txt_4c_DacbsFas.Value = ""
12718:             ENDIF
12719:             RETURN
12720:         ENDIF
12721:         TRY
12722:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12723:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12724:             ENDTEXT
12725:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12726:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12727:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12728:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12729:                 ENDIF
12730:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12731:             ELSE
12732:                 THIS.AbrirLookupAcabamentoFas()
12733:             ENDIF
12734:             IF USED("cursor_4c_VAcbFas")
12735:                 USE IN cursor_4c_VAcbFas
12736:             ENDIF
12737:         CATCH TO loc_oErro
12738:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12739:         ENDTRY
12740:     ENDPROC
12741: 
12742:     *--------------------------------------------------------------------------
12743:     * AbrirLookupAcabamentoFas - Lookup Acabamento para a aba Fases
12744:     *--------------------------------------------------------------------------
12745:     PROTECTED PROCEDURE AbrirLookupAcabamentoFas()
12746:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12747:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12748:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12749:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodacbsFas.Value), "")
12750: 
12751:         TRY
12752:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_AcbFas", "cods", loc_cVal, "Selecionar Acabamento")
12753:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
12754:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12755:             loc_oBusca.Show()
12756: 
12757:             IF loc_oBusca.this_lSelecionou
12758:                 IF USED("cursor_4c_AcbFas")
12759:                     LOCAL loc_cCodSel, loc_cDescSel
12760:                     loc_cCodSel  = ALLTRIM(cursor_4c_AcbFas.cods)
12761:                     loc_cDescSel = ALLTRIM(cursor_4c_AcbFas.descrs)
12762:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12763:                         loc_oPg7.txt_4c_CodacbsFas.Value = loc_cCodSel
12764:                     ENDIF
12765:                     IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12766:                         loc_oPg7.txt_4c_DacbsFas.Value = loc_cDescSel
12767:                     ENDIF
12768:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codacbs", 5)
12769:                         loc_oPg1.txt_4c_Codacbs.Value = loc_cCodSel
12770:                     ENDIF
12771:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Dcodacbs", 5)
12772:                         loc_oPg1.txt_4c_Dcodacbs.Value = loc_cDescSel
12773:                     ENDIF
12774:                     THIS.this_oBusinessObject.this_cCodacbs = loc_cCodSel
12775:                 ENDIF
12776:             ELSE
12777:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12778:                     loc_oPg7.txt_4c_CodacbsFas.Value = ""
12779:                 ENDIF
12780:                 IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12781:                     loc_oPg7.txt_4c_DacbsFas.Value = ""
12782:                 ENDIF
12783:             ENDIF
12784: 
12785:             IF USED("cursor_4c_AcbFas")
12786:                 USE IN cursor_4c_AcbFas
12787:             ENDIF
12788:             loc_oBusca.Release()
12789:         CATCH TO loc_oErro
12790:             MsgErro("Erro no lookup de acabamento (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamentoFas")
12791:         ENDTRY
12792:     ENDPROC
12793: 
12794:     *--------------------------------------------------------------------------
12795:     * TabFases_ConquilhaKeyPress - F4 no campo Conquilha abre lookup
12796:     *--------------------------------------------------------------------------
12797:     PROCEDURE TabFases_ConquilhaKeyPress
12798:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12799:         IF par_nKeyCode = 115
12800:             THIS.AbrirLookupConquilha()
12801:         ENDIF
12802:     ENDPROC
12803: 
12804:     *--------------------------------------------------------------------------
12805:     * TabFases_ConquilhaLostFocus - LostFocus valida conquilha
12806:     *--------------------------------------------------------------------------
12807:     PROCEDURE TabFases_ConquilhaLostFocus()
12808:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12809:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12810:         IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12811:             RETURN
12812:         ENDIF
12813:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
12814:         IF loc_cCod == THIS.this_cUltConquilha
12815:             RETURN
12816:         ENDIF
12817:         THIS.this_cUltConquilha = loc_cCod
12818:         IF EMPTY(loc_cCod)
12819:             RETURN
12820:         ENDIF
12821:         TRY
12822:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12823:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12824:             ENDTEXT
12825:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12826:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12827:                 THIS.AbrirLookupConquilha()
12828:             ELSE
12829:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12830:             ENDIF
12831:             IF USED("cursor_4c_VCnq")
12832:                 USE IN cursor_4c_VCnq
12833:             ENDIF
12834:         CATCH TO loc_oErro
12835:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12836:         ENDTRY
12837:     ENDPROC
12838: 
12839:     *--------------------------------------------------------------------------
12840:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)
12841:     *--------------------------------------------------------------------------
12842:     PROTECTED PROCEDURE AbrirLookupConquilha()
12843:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12844:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12845:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5), ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value), "")
12846: 
12847:         TRY
12848:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", "cursor_4c_Cnq", "conquilhas", loc_cVal, "Selecionar Conquilha")
12849:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
12850:             loc_oBusca.Show()
12851: 
12852:             IF loc_oBusca.this_lSelecionou
12853:                 IF USED("cursor_4c_Cnq")
12854:                     LOCAL loc_cCodSel
12855:                     loc_cCodSel = ALLTRIM(cursor_4c_Cnq.conquilhas)
12856:                     IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12857:                         loc_oPg.txt_4c_Conquilhas.Value = loc_cCodSel
12858:                     ENDIF
12859:                     THIS.this_oBusinessObject.this_cConquilhas = loc_cCodSel
12860:                 ENDIF
12861:             ELSE
12862:                 IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12863:                     loc_oPg.txt_4c_Conquilhas.Value = ""
12864:                 ENDIF
12865:             ENDIF
12866: 
12867:             IF USED("cursor_4c_Cnq")
12868:                 USE IN cursor_4c_Cnq
12869:             ENDIF
12870:             loc_oBusca.Release()
12871:         CATCH TO loc_oErro
12872:             MsgErro("Erro no lookup de conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupConquilha")
12873:         ENDTRY
12874:     ENDPROC
12875: 
12876:     *--------------------------------------------------------------------------
12877:     * TabFases_GarraKeyPress - F4 no campo Garra abre lookup
12878:     *--------------------------------------------------------------------------
12879:     PROCEDURE TabFases_GarraKeyPress
12880:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12881:         IF par_nKeyCode = 115
12882:             THIS.AbrirLookupGarra()
12883:         ENDIF
12884:     ENDPROC
12885: 
12886:     *--------------------------------------------------------------------------
12887:     * TabFases_GarraLostFocus - LostFocus valida garra
12888:     *--------------------------------------------------------------------------
12889:     PROCEDURE TabFases_GarraLostFocus()
12890:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12891:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12892:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12893:             RETURN
12894:         ENDIF
12895:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
12896:         IF loc_cCod == THIS.this_cUltGarra
12897:             RETURN
12898:         ENDIF
12899:         THIS.this_cUltGarra = loc_cCod
12900:         IF EMPTY(loc_cCod)
12901:             RETURN
12902:         ENDIF
12903:         TRY
12904:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12905:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12906:             ENDTEXT
12907:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12908:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12909:                 THIS.AbrirLookupGarra()
12910:             ELSE
12911:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12912:             ENDIF
12913:             IF USED("cursor_4c_VGar")
12914:                 USE IN cursor_4c_VGar
12915:             ENDIF
12916:         CATCH TO loc_oErro
12917:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12918:         ENDTRY
12919:     ENDPROC
12920: 
12921:     *--------------------------------------------------------------------------
12922:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)
12923:     *--------------------------------------------------------------------------
12924:     PROTECTED PROCEDURE AbrirLookupGarra()
12925:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12926:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12927:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5), ALLTRIM(loc_oPg.txt_4c_Codgarras.Value), "")
12928: 
12929:         TRY
12930:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGar", "cursor_4c_Gar", "codgarras", loc_cVal, "Selecionar Garra")
12931:             loc_oBusca.mAddColuna("codgarras", "", "C" + CHR(243) + "digo")
12932:             loc_oBusca.Show()
12933: 
12934:             IF loc_oBusca.this_lSelecionou
12935:                 IF USED("cursor_4c_Gar")
12936:                     LOCAL loc_cCodSel
12937:                     loc_cCodSel = ALLTRIM(cursor_4c_Gar.codgarras)
12938:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12939:                         loc_oPg.txt_4c_Codgarras.Value = loc_cCodSel
12940:                     ENDIF
12941:                     THIS.this_oBusinessObject.this_cCodgarras = loc_cCodSel
12942:                 ENDIF
12943:             ELSE
12944:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12945:                     loc_oPg.txt_4c_Codgarras.Value = ""
12946:                 ENDIF
12947:             ENDIF
12948: 
12949:             IF USED("cursor_4c_Gar")
12950:                 USE IN cursor_4c_Gar
12951:             ENDIF
12952:             loc_oBusca.Release()
12953:         CATCH TO loc_oErro
12954:             MsgErro("Erro no lookup de garra:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGarra")
12955:         ENDTRY
12956:     ENDPROC
12957: 
12958:     *--------------------------------------------------------------------------
12959:     * BtnInserirFaseClick - Inserir nova fase de producao em SigCdPrf
12960:     *--------------------------------------------------------------------------
12961:     PROCEDURE BtnInserirFaseClick()
12962:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nProxOrdem, loc_nMaxOrdem
12963: 
12964:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12965:             MsgAviso("Salve ou edite o produto antes de inserir fases.", "FormProduto")
12966:             RETURN
12967:         ENDIF
12968: 
12969:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12970:         IF EMPTY(loc_cCpros)
12971:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
12972:             RETURN
12973:         ENDIF
12974: 
12975:         TRY
12976:             *-- Calcular proximo numero de ordem
12977:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12978:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12979:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12980:             ENDTEXT
12981:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12982:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12983:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12984:             ELSE
12985:                 loc_nProxOrdem = 1
12986:             ENDIF
12987:             IF USED("cursor_4c_MaxOrdem")
12988:                 USE IN cursor_4c_MaxOrdem
12989:             ENDIF
12990: 
12991:             *-- Inserir nova fase
12992:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12993:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12994:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12995:             ENDTEXT
12996:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12997:             IF loc_nR > 0
12998:                 THIS.CarregarFases()
12999:                 LOCAL loc_oPg7
13000:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13001:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
13002:                     loc_oPg7.grd_4c_Fases.SetFocus()
13003:                 ENDIF
13004:             ELSE
13005:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
13006:             ENDIF
13007:         CATCH TO loc_oErro
13008:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
13009:         ENDTRY
13010:     ENDPROC
13011: 
13012:     *--------------------------------------------------------------------------
13013:     * BtnExcluirFaseClick - Excluir fase de producao selecionada
13014:     *--------------------------------------------------------------------------
13015:     PROCEDURE BtnExcluirFaseClick()
13016:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_lConfirma
13017: 
13018:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13019:             RETURN
13020:         ENDIF
13021: 
13022:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
13023:             MsgAviso("Selecione uma fase para excluir.", "FormProduto")
13024:             RETURN
13025:         ENDIF
13026: 
13027:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13028:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
13029: 
13030:         IF loc_nOrdems <= 0
13031:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida para excluir.", "FormProduto")
13032:             RETURN
13033:         ENDIF
13034: 
13035:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da fase " + TRANSFORM(loc_nOrdems) + "?", "FormProduto")
13036:         IF !loc_lConfirma
13037:             RETURN
13038:         ENDIF
13039: 
13040:         TRY
13041:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13042:                 DELETE FROM SigCdPrf
13043:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13044:                 AND ordems = <<loc_nOrdems>>
13045:             ENDTEXT
13046:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13047:             IF loc_nR > 0
13048:                 THIS.CarregarFases()
13049:             ELSE
13050:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
13051:             ENDIF
13052:         CATCH TO loc_oErro
13053:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
13054:         ENDTRY
13055:     ENDPROC
13056: 
13057:     *--------------------------------------------------------------------------
13058:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
13059:     *--------------------------------------------------------------------------
13060:     PROCEDURE BtnAlternativaFaseClick()
13061:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem
13062: 
13063:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13064:             MsgAviso("Salve ou edite o produto antes de inserir alternativas.", "FormProduto")
13065:             RETURN
13066:         ENDIF
13067: 
13068:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13069:         IF EMPTY(loc_cCpros)
13070:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
13071:             RETURN
13072:         ENDIF
13073: 
13074:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
13075:             MsgAviso("Selecione uma fase base para criar a alternativa.", "FormProduto")
13076:             RETURN
13077:         ENDIF
13078: 
13079:         loc_cGrupoAtual = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
13080:         IF EMPTY(loc_cGrupoAtual)
13081:             MsgAviso("A fase selecionada precisa ter um grupo definido.", "FormProduto")
13082:             RETURN
13083:         ENDIF
13084: 
13085:         TRY
13086:             *-- Calcular proximo numero de ordem
13087:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13088:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13089:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13090:             ENDTEXT
13091:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
13092:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
13093:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
13094:             ELSE
13095:                 loc_nProxOrdem = 1
13096:             ENDIF
13097:             IF USED("cursor_4c_MaxOrdAlt")
13098:                 USE IN cursor_4c_MaxOrdAlt
13099:             ENDIF
13100: 
13101:             *-- Inserir fase alternativa copiando o grupo da fase atual
13102:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13103:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13104:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
13105:             ENDTEXT
13106:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13107:             IF loc_nR > 0
13108:                 THIS.CarregarFases()
13109:             ELSE
13110:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
13111:             ENDIF
13112:         CATCH TO loc_oErro
13113:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
13114:         ENDTRY
13115:     ENDPROC
13116: 
13117:     *--------------------------------------------------------------------------
13118:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
13119:     *--------------------------------------------------------------------------
13120:     PROCEDURE CmdFichaClick()
13121:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO
13122: 
13123:         loc_oBO    = THIS.this_oBusinessObject
13124:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
13125: 
13126:         IF EMPTY(loc_cCpros)
13127:             MsgAviso("Nenhum produto selecionado.", "FormProduto")
13128:             RETURN
13129:         ENDIF
13130: 
13131:         TRY
13132:             *-- Criar cursor de cabecalho para o relatorio
13133:             IF USED("CsCabecalho")
13134:                 USE IN CsCabecalho
13135:             ENDIF
13136:             CREATE CURSOR CsCabecalho ( ;
13137:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
13138:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
13139:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
13140:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
13141: 
13142:             INSERT INTO CsCabecalho ;
13143:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
13144:                 VALUES( ;
13145:                     go_4c_Sistema.cEmpresa, ;
13146:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
13147:                     loc_cCpros, ;
13148:                     loc_oBO.this_cDpros, ;
13149:                     loc_oBO.this_cCgrus, ;
13150:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
13151:                     THIS.this_cModoAtual)
13152: 
13153:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
13154: 
13155:             IF USED("CsCabecalho")
13156:                 USE IN CsCabecalho
13157:             ENDIF
13158: 
13159:         CATCH TO loc_oErro
13160:             MsgErro("Erro ao gerar ficha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdFichaClick")
13161:         ENDTRY
13162:     ENDPROC
13163: 
13164:     *--------------------------------------------------------------------------
13165:     * CmdgFiguraClick - Carregar/remover imagem da fase selecionada (FigProcs)
13166:     *--------------------------------------------------------------------------
13167:     PROCEDURE CmdgFiguraClick()
13168:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig
13169:         LOCAL loc_oPg, loc_lConfirma
13170: 
13171:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13172:             RETURN
13173:         ENDIF
13174: 
13175:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
13176:             MsgAviso("Selecione uma fase para carregar a imagem.", "FormProduto")
13177:             RETURN
13178:         ENDIF
13179: 
13180:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13181:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
13182: 
13183:         IF loc_nOrdems <= 0
13184:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida.", "FormProduto")
13185:             RETURN
13186:         ENDIF
13187: 
13188:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13189: 
13190:         TRY
13191:             *-- Verificar se ja tem imagem
13192:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13193:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13194:                 FROM SigCdPrf
13195:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13196:             ENDTEXT
13197:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13198:             LOCAL loc_lTemFig
13199:             loc_lTemFig = .F.
13200:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13201:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13202:             ENDIF
13203:             IF USED("cursor_4c_VerFig")
13204:                 USE IN cursor_4c_VerFig
13205:             ENDIF
13206: 
13207:             IF loc_lTemFig
13208:                 *-- Oferecer opcoes: substituir ou remover
13209:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13210:                 IF loc_lConfirma
13211:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13212:                         UPDATE SigCdPrf SET FigProcs = NULL
13213:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13214:                     ENDTEXT
13215:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13216:                     IF loc_nR > 0
13217:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13218:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13219:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13220:                         ENDIF
13221:                         MsgInfo("Imagem removida.", "FormProduto")
13222:                     ENDIF
13223:                     RETURN
13224:                 ENDIF

*-- Linhas 13264 a 13624:
13264:     * CmdgFigCamClick - Carregar/remover imagem de borracha (camera/molde)
13265:     * Equivalente ao cmdgFigCam do legado: camera para imagem da borracha
13266:     *--------------------------------------------------------------------------
13267:     PROCEDURE CmdgFigCamClick()
13268:         LOCAL loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig, loc_oPg
13269: 
13270:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13271:             RETURN
13272:         ENDIF
13273: 
13274:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
13275:             MsgAviso("Selecione uma matriz para carregar a imagem.", "FormProduto")
13276:             RETURN
13277:         ENDIF
13278: 
13279:         loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
13280:         IF EMPTY(loc_cCmats)
13281:             MsgAviso("Selecione uma matriz v" + CHR(225) + "lida.", "FormProduto")
13282:             RETURN
13283:         ENDIF
13284: 
13285:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13286: 
13287:         TRY
13288:             *-- Selecionar arquivo de imagem
13289:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Borracha:")
13290:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13291:                 RETURN
13292:             ENDIF
13293: 
13294:             *-- Converter para Base64 e salvar em SigCdPro.FigJpgs
13295:             LOCAL loc_cBinImg, loc_cB64
13296:             loc_cBinImg = FILETOSTR(loc_cFig)
13297:             IF EMPTY(loc_cBinImg)
13298:                 MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFigCamClick")
13299:                 RETURN
13300:             ENDIF
13301: 
13302:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13303: 
13304:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13305:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13306:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13307:             ENDTEXT
13308:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13309:             IF loc_nR > 0
13310:                 *-- Exibir imagem
13311:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13312:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13313:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13314:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13315:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13316:                 ENDIF
13317:             ELSE
13318:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13319:             ENDIF
13320: 
13321:         CATCH TO loc_oErro
13322:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13323:         ENDTRY
13324:     ENDPROC
13325: 
13326:     *--------------------------------------------------------------------------
13327:     * BtnInserirMatrizClick - Inserir nova linha na grade de matrizes (SigPrMtz)
13328:     *--------------------------------------------------------------------------
13329:     PROCEDURE BtnInserirMatrizClick()
13330:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
13331: 
13332:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13333:             MsgAviso("Salve ou edite o produto antes de inserir matrizes.", "FormProduto")
13334:             RETURN
13335:         ENDIF
13336: 
13337:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13338:         IF EMPTY(loc_cCpros)
13339:             MsgAviso("Produto n" + CHR(227) + "o identificado.", "FormProduto")
13340:             RETURN
13341:         ENDIF
13342: 
13343:         TRY
13344:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13345:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13346:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13347:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13348:             ENDTEXT
13349:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13350:             IF loc_nR > 0
13351:                 THIS.CarregarMatrizes()
13352:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13353:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13354:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13355:                 ENDIF
13356:             ELSE
13357:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13358:             ENDIF
13359:         CATCH TO loc_oErro
13360:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13361:         ENDTRY
13362:     ENDPROC
13363: 
13364:     *--------------------------------------------------------------------------
13365:     * BtnExcluirMatrizClick - Excluir linha selecionada da grade de matrizes
13366:     *--------------------------------------------------------------------------
13367:     PROCEDURE BtnExcluirMatrizClick()
13368:         LOCAL loc_cCpros, loc_cCidChaves, loc_cSQL, loc_nR, loc_lConfirma
13369: 
13370:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13371:             RETURN
13372:         ENDIF
13373: 
13374:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
13375:             MsgAviso("Selecione uma matriz para excluir.", "FormProduto")
13376:             RETURN
13377:         ENDIF
13378: 
13379:         loc_cCpros     = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13380:         loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Matrizes.cidchaves, ""))
13381: 
13382:         IF EMPTY(loc_cCidChaves)
13383:             MsgAviso("Selecione uma linha v" + CHR(225) + "lida para excluir.", "FormProduto")
13384:             RETURN
13385:         ENDIF
13386: 
13387:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o desta matriz?", "FormProduto")
13388:         IF !loc_lConfirma
13389:             RETURN
13390:         ENDIF
13391: 
13392:         TRY
13393:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13394:                 DELETE FROM SigPrMtz
13395:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13396:             ENDTEXT
13397:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13398:             IF loc_nR > 0
13399:                 THIS.CarregarMatrizes()
13400:             ELSE
13401:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13402:             ENDIF
13403:         CATCH TO loc_oErro
13404:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13405:         ENDTRY
13406:     ENDPROC
13407: 
13408:     *--------------------------------------------------------------------------
13409:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13410:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13411:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13412:     *--------------------------------------------------------------------------
13413:     PROCEDURE DesignerGrd_AfterRowColChange(par_nColIndex)
13414:         LOCAL loc_oPg, loc_cCodTarefa, loc_cDesTarefa
13415:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13416: 
13417:         TRY
13418:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13419:                 loc_cCodTarefa = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13420:                 loc_cDesTarefa = ""
13421: 
13422:                 *-- Buscar descricao no cursor de tarefas
13423:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13424:                     SELECT cursor_4c_Tarefas
13425:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13426:                     IF !EOF("cursor_4c_Tarefas")
13427:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13428:                     ENDIF
13429:                 ENDIF
13430: 
13431:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13432:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13433:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13434:                 ENDIF
13435:             ENDIF
13436:         CATCH TO loc_oErro
13437:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13438:         ENDTRY
13439:     ENDPROC
13440: 
13441:     *--------------------------------------------------------------------------
13442:     * ArquivosGrd_AfterRowColChange - Grid arquivos: ao navegar linha/coluna
13443:     * Exibe preview de imagem em img_4c_ImgArqJpg se arquivo for JPG/ICO/BMP/JPEG
13444:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13445:     *--------------------------------------------------------------------------
13446:     PROCEDURE ArquivosGrd_AfterRowColChange(par_nColIndex)
13447:         LOCAL loc_oPg, loc_cArq, loc_cExt
13448:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13449: 
13450:         TRY
13451:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
13452:                 RETURN
13453:             ENDIF
13454: 
13455:             *-- Limpar preview
13456:             CLEAR RESOURCES
13457:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
13458:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
13459: 
13460:             IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13461:                 loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13462: 
13463:                 IF !EMPTY(loc_cArq)
13464:                     loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
13465: 
13466:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
13467:                         loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArq
13468:                         loc_oPg.img_4c_ImgArqJpg.Visible = .T.
13469:                     ENDIF
13470:                 ENDIF
13471:             ENDIF
13472:         CATCH TO loc_oErro
13473:             MsgErro(loc_oErro.Message, "FormProduto.ArquivosGrd_AfterRowColChange")
13474:         ENDTRY
13475:     ENDPROC
13476: 
13477:     *--------------------------------------------------------------------------
13478:     * GrdDesignerColReadOnlyWhen - Colunas 1/2/3 do grd_4c_Designer: sempre somente leitura
13479:     * Retorna .F. para bloquear edicao (original: Return .f.)
13480:     *--------------------------------------------------------------------------
13481:     PROCEDURE GrdDesignerColReadOnlyWhen()
13482:         RETURN .F.
13483:     ENDPROC
13484: 
13485:     *--------------------------------------------------------------------------
13486:     * GrdDesignerCol4When - Column4 do grd_4c_Designer (Tarefa): editavel condicionalmente
13487:     * Editavel apenas em INSERIR/ALTERAR, para o usuario atual, sem DtFims
13488:     * Original: Return InList(pcEscolha, INSERIR, ALTERAR) And Usuars=Usuar And IsEmpty(DtFims)
13489:     *--------------------------------------------------------------------------
13490:     PROCEDURE GrdDesignerCol4When()
13491:         LOCAL loc_lEditavel, loc_cUsuars, loc_cDtFims
13492: 
13493:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13494:             RETURN .F.
13495:         ENDIF
13496: 
13497:         IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13498:             loc_cUsuars = ALLTRIM(NVL(cursor_4c_Designer.usuars, ""))
13499:             loc_cDtFims = NVL(cursor_4c_Designer.dtfims, {})
13500: 
13501:             IF loc_cUsuars <> ALLTRIM(gc_4c_UsuarioLogado)
13502:                 RETURN .F.
13503:             ENDIF
13504: 
13505:             IF !EMPTY(loc_cDtFims)
13506:                 RETURN .F.
13507:             ENDIF
13508: 
13509:             RETURN .T.
13510:         ENDIF
13511: 
13512:         RETURN .F.
13513:     ENDPROC
13514: 
13515:     *--------------------------------------------------------------------------
13516:     * GrdDesignerCol4Valid - Column4 do grd_4c_Designer: valida/lookup de tarefa
13517:     * Se cursor_4c_Tarefas tem dados: valida codigo; se nao encontrado, limpa campo
13518:     * Se cursor_4c_Tarefas vazio (tabela SigPrTrf inexistente): aceita qualquer valor
13519:     * Original: fwBuscaInt em crTarefas (CodCads/DesCads)
13520:     *--------------------------------------------------------------------------
13521:     PROCEDURE GrdDesignerCol4Valid()
13522:         LOCAL loc_oPg, loc_cValor, loc_cCodTarefa, loc_cDesTarefa, loc_lEncontrou
13523:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13524: 
13525:         TRY
13526:             *-- Obter valor atual da celula via cursor_4c_Designer
13527:             loc_cValor = ""
13528:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13529:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13530:             ENDIF
13531: 
13532:             IF EMPTY(loc_cValor)
13533:                 loc_lResultado = .T.
13534:             ENDIF
13535: 
13536:             *-- Cursor de tarefas vazio: tabela mestre nao disponivel, aceitar qualquer valor
13537:             IF !USED("cursor_4c_Tarefas") OR RECCOUNT("cursor_4c_Tarefas") = 0
13538:                 loc_lResultado = .T.
13539:             ENDIF
13540: 
13541:             *-- Verificar se codigo existe no cursor de tarefas
13542:             loc_lEncontrou = .F.
13543:             loc_cCodTarefa = ""
13544:             loc_cDesTarefa = ""
13545: 
13546:             SELECT cursor_4c_Tarefas
13547:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13548:             IF !EOF("cursor_4c_Tarefas")
13549:                 loc_lEncontrou = .T.
13550:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13551:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13552:             ENDIF
13553: 
13554:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13555:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13556:                 IF loc_lEncontrou
13557:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13558:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13559:                     ENDIF
13560:                 ELSE
13561:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")
13562:                     REPLACE cursor_4c_Designer.tarefas WITH ""
13563:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13564:                         loc_oPg.txt_4c_ObsTarefas.Value = ""
13565:                     ENDIF
13566:                 ENDIF
13567:             ENDIF
13568: 
13569:         CATCH TO loc_oErro
13570:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4Valid")
13571:         ENDTRY
13572: 
13573:         RETURN .T.
13574:     ENDPROC
13575: 
13576:     *--------------------------------------------------------------------------
13577:     * GrdDesignerCol4LostFocus - Column4 perde foco: navega para txt_4c_ObsTarefas ao Enter
13578:     * Original: If Not Empty(This.Value) And (Lastkey()=13) -> getObsTarefas.SetFocus
13579:     *--------------------------------------------------------------------------
13580:     PROCEDURE GrdDesignerCol4LostFocus()
13581:         LOCAL loc_oPg
13582:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13583: 
13584:         TRY
13585:             IF LASTKEY() = 13
13586:                 IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13587:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Designer.tarefas, "")))
13588:                         IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13589:                             loc_oPg.txt_4c_ObsTarefas.SetFocus()
13590:                         ENDIF
13591:                     ENDIF
13592:                 ENDIF
13593:             ENDIF
13594:         CATCH TO loc_oErro
13595:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4LostFocus")
13596:         ENDTRY
13597:     ENDPROC
13598: 
13599:     *--------------------------------------------------------------------------
13600:     * GrdArquivosCol1When - Column1 do grd_4c_Arquivos: editavel em INCLUIR/ALTERAR
13601:     * Original: Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
13602:     *--------------------------------------------------------------------------
13603:     PROCEDURE GrdArquivosCol1When()
13604:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13605:     ENDPROC
13606: 
13607:     *--------------------------------------------------------------------------
13608:     * ImgArqJpgClick - Clique na imagem: exibe caminho do arquivo
13609:     * Original: Do Form SigOpZom (zoom view) - forma simplificada: exibe path
13610:     *--------------------------------------------------------------------------
13611:     PROCEDURE ImgArqJpgClick()
13612:         LOCAL loc_cArq
13613:         loc_cArq = ""
13614: 
13615:         IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13616:             loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13617:         ENDIF
13618: 
13619:         IF !EMPTY(loc_cArq)
13620:             MsgAviso(loc_cArq, "Arquivo Selecionado")
13621:         ENDIF
13622:     ENDPROC
13623: 
13624: ENDDEFINE


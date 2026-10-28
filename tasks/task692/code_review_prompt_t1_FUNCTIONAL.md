# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.PodeConsultarBanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (656 linhas total):

*-- Linhas 15 a 287:
15: * DataSession), Init(par_nBarras) guardando o parametro de filtro antes de
16: * DODEFAULT() (equivalente ao "LParameters pBar" do legado - regra do
17: * projeto de armazenar parametros ANTES de delegar, mesmo padrao de
18: * FormCliente/FormHOR), InicializarForm() criando o Business Object e
19: * validando o parametro (equivalente ao guard "If (Type('pBar')<>'N') Or
20: * Empty(pBar) / ThisForm.Release" do legado - aqui via retorno .F. em vez de
21: * Release() no meio da inicializacao), e o cabecalho (cntSombra/lblSombra/
22: * lblTitulo) com geometria TRANSCRITA do dump.
23: *
24: * Fase 4/8 - GRID E BOTAO DE SAIDA: o legado nao tem CRUD (eh um dialogo de
25: * consulta), entao esta fase acrescenta so o que o SCX realmente tem -
26: * grd_4c_Dados (grdHistorico, 6 colunas Data/Hora/Atual/Novo/Usuario/
27: * Operacao, geometria e ReadOnly/Movable/Resizable TRANSCRITOS do dump) e
28: * cmg_4c_Botoes (CommandGroup de 1 botao, Encerrar/btnSair, mesmo padrao
29: * de Formsigopcgb). ConfigurarGrid() so cuida de LAYOUT (Top/Left/Width/
30: * ColumnCount/Header.Caption) - NUNCA ControlSource aqui, porque
31: * cursor_4c_HistoricoCgl ainda nao existe neste ponto (regra #41: Column.
32: * ControlSource de cursor inexistente derruba o Init e a tela nao abre).
33: * O bind real (RecordSource + ControlSource + Width/Header, porque
34: * RecordSource reseta os dois - Problema 48) e a carga de dados via
35: * SigOpCglBO.CarregarHistorico() ficam em CarregarDados(), chamado no
36: * fim de InicializarForm so quando PodeConsultarBanco() (regra do projeto -
37: * pula SQLEXEC em gb_4c_ValidandoUI/gb_4c_ModoTeste).
38: *
39: * Fase 5/8 - AUDITORIA DE PROPRIEDADES: o legado NAO TEM campos de dados (20
40: * objetos no dump, todos cabecalho/botao/grade - zero TextBox fora das colunas,
41: * zero PageFrame, zero Page2), entao nao ha "campos da Page2" para acrescentar
42: * e inventar algum violaria o PILAR 1. O trabalho desta fase eh o que a Fase 4
43: * descartou ao criar tudo de uma vez: as 8 propriedades da CLASSE fwgrade
44: * (medidas no framework.vcx, nao deduzidas - fwgrade eh Tahoma 8 com
45: * HighlightBackColor ESCURO, o "Verdana" do framework_frmcadastro_layout.md eh
46: * override da instancia CRUD), as 5 propriedades dos 6 Column.Text1,
47: * cmg_4c_Botoes.AutoSize, Rotation dos dois labels, e os 3 TabIndex (como
48: * ORDINAL 1..N - o VFP clampeia pela contagem de irmaos, ver o metodo) em
49: * ConfigurarPaginaDados() - metodo com corpo REAL e efetivamente CHAMADO do
50: * ConfigurarPageFrame depois de todos os AddObject - nunca um stub de uma
51: * linha so, orfao e nunca chamado, que eh codigo morto que gate nenhum pega.
52: *
53: * Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: sem trabalho adicional neste form, e
54: * por construcao, nao por omissao. Confirmado lendo o codigo fonte INTEIRO do
55: * legado (tasks/task692/SigOpCgl_form_codigo_fonte.txt, Secao 3): o Init tem
56: * 3 linhas de preparo (fConfigGeral/Caption) + o guard de parametro + UM
57: * SqlExecute + o bind do grid + SetFocus no botao - nenhum CreateObject de
58: * fwBuscaExt/fwBuscaSel, nenhuma chamada a sigacess(), nenhum PROCEDURE Valid.
59: * Os 20 objetos do dump (Secao 1) sao TODOS cabecalho, grade (6x Header1/Text1)
60: * ou botao - zero TextBox/ComboBox/CheckBox fora das colunas da grade, que ja
61: * foram o "campo" entregue com ControlSource em CarregarDados() na Fase 4.
62: * Criar lookup ou campo solto aqui inventaria funcionalidade que o legado nao
63: * tem (viola o PILAR 1); um ConfigurarLookups() vazio seria stub disfarcado
64: * (proibido). "=fConfigGeral()" do Init legado segue a decisao ja tomada em
65: * outros forms OPERACIONAIS (FormSIGPRVTX/FormSigPrTar/FormSigMvMen/
66: * FormSigMvExp): NAO PORTAR a chamada - o wrapper utils\fconfiggeral.prg
67: * existe so para o p-code dos VCX legado que ainda o chamam no Load deles,
68: * e a configuracao que fConfigGeral fazia no legado (globals/ambiente) ja eh
69: * coberta por config.prg na arquitetura nova.
70: *
71: * Fase 7/8 - EVENTOS PRINCIPAIS: o template generico desta fase pede os
72: * 4 handlers CRUD (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
73: * BtnExcluirClick), mas o dump do legado (tasks/task692/layout.json +
74: * comportamento.json, Secoes 1 e 3) prova que SIGOPCGL nao tem NENHUM dos
75: * quatro verbos: a arvore de objetos inteira (20 entradas) e so cabecalho
76: * (cntSombra + 2 Label), grade (grdHistorico + 6 pares Header1/Text1) e UM
77: * unico CommandGroup (cmdBtnForm, ButtonCount=1) cujo Click e
78: * "ThisForm.Release" - sem Grupo_Op, sem pcEscolha, sem frmcadastro na
79: * cadeia de heranca (Class: form puro). Inventar Incluir/Alterar/
80: * Visualizar/Excluir aqui criaria funcionalidade que o legado nao tem
81: * (viola o PILAR 1) e um metodo so para satisfazer nome seria stub
82: * disfarcado (proibido pela regra de completude).
83: *
84: * O "evento principal" real deste form - o unico botao que o SCX declara -
85: * ja foi implementado na Fase 4: BtnEncerrarClick(), amarrado via BINDEVENT
86: * ao cmg_4c_Botoes.Buttons(1) em ConfigurarBotoes(), replica EXATAMENTE o
87: * "PROCEDURE btnSair.Click / ThisForm.Release" do legado. Com 1 botao no
88: * dump e 1 handler real no form, a superficie de evento esta completa -
89: * nao ha segundo botao para inventar handler.
90: *
91: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: o template generico
92: * desta fase pede BtnBuscarClick/BtnSalvarClick/BtnCancelarClick,
93: * FormParaBO/BOParaForm completos, HabilitarCampos/LimparCampos,
94: * CarregarLista e AjustarBotoesPorModo - nenhum desses se aplica aqui, e por
95: * construcao (mesma prova documental das Fases 6 e 7, apoiada no dump
96: * completo de tasks/task692): SIGOPCGL nao tem Buscar/Salvar/Cancelar (o
97: * unico botao e o Sair, ja coberto por BtnEncerrarClick), nao tem Page2 de
98: * dados editaveis (logo nao ha o que transferir em FormParaBO/BOParaForm,
99: * nem campo para HabilitarCampos/LimparCampos gerenciarem) e nao alterna
100: * modo (AjustarBotoesPorModo pressupoe INCLUIR/ALTERAR/VISUALIZAR, que este
101: * dialogo somente-leitura nao tem). FormBase.prg (linhas 276-292) ja define
102: * esses metodos como no-op protegidos, chamados apenas por Novo/Salvar/
103: * Excluir/Cancelar do proprio FormBase - metodos que FormSigOpCgl nunca
104: * invoca (o unico fluxo e InicializarForm -> CarregarDados -> Encerrar).
105: * Sobrescrever qualquer um deles so para "preencher o nome" seria stub
106: * disfarcado (proibido pela regra de completude) e inventaria
107: * funcionalidade que o legado nao tem (viola o PILAR 1). CarregarLista() ja
108: * existe sob o nome CarregarDados() (Fase 4), que cumpre o mesmo papel -
109: * popular o cursor via BO e rebindar o grid - nao ha necessidade de um
110: * segundo metodo so para bater o nome do template.
111: *
112: * Integracao final (fecha o checklist "New entity" do CLAUDE.md): BO e Form
113: * sao carregados automaticamente pelo ADIR() de config.prg (classes\*BO.prg
114: * e forms\operacionais\Form*.prg) - sem SET PROCEDURE manual. Item de menu
115: * adicionado em popMovimentos (BAR 157, "Historico de Locais") chamando
116: * PROCEDURE AbrirFormSigOpCgl() no final de menu.prg: como o legado recebe
117: * o codigo de barras por parametro (sem tela de busca propria - quem chama
118: * ja sabe o codigo), o helper pede o valor via INPUTBOX antes de instanciar,
119: * mesmo padrao usado para AbrirFormsigreinr/AbrirFormSigReIr1 (relatorio
120: * parametrizado por numero).
121: *==============================================================================
122: 
123: DEFINE CLASS FormSigOpCgl AS FormBase
124: 
125:     Height       = 240
126:     Width        = 800
127:     Caption      = ""
128:     TitleBar     = 0
129:     ShowWindow   = 1
130:     ControlBox   = .F.
131:     Closable     = .F.
132:     MaxButton    = .F.
133:     MinButton    = .F.
134:     ClipControls = .F.
135:     WindowType   = 0
136:     AlwaysOnTop  = .T.
137:     DataSession  = 2
138:     BorderStyle  = 2
139:     AutoCenter   = .T.
140:     FontName     = "Tahoma"
141:     FontSize     = 8
142: 
143:     *-- Business Object
144:     this_oBusinessObject = .NULL.
145: 
146:     *-- Parametro de filtro recebido no Init (SigCdMlc.barras - numeric(14,0))
147:     this_nBarras = 0
148: 
149:     *--------------------------------------------------------------------------
150:     * Init - armazena o parametro de barras e define Caption com CHR() antes
151:     * de delegar ao FormBase (equivalente a "LParameters pBar" do legado).
152:     *--------------------------------------------------------------------------
153:     PROCEDURE Init(par_nBarras)
154:         THIS.Caption = "Hist" + CHR(243) + "rico de Locais"
155: 
156:         THIS.this_nBarras = IIF(VARTYPE(par_nBarras) = "N", par_nBarras, 0)
157: 
158:         *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
159:         *-- definida com WindowType=0; producao restaura para modal aqui, fora
160:         *-- de teste/validacao de UI (mesmo padrao de FormSigOpCcl/FormSigOpBcb).
161:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
162:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
163:             THIS.WindowType  = 1
164:             THIS.ShowWindow  = 1
165:         ENDIF
166: 
167:         RETURN DODEFAULT()
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * InicializarForm - cria o Business Object, valida o parametro de barras
172:     * (equivalente ao guard do legado que fecha o form sem parametro valido)
173:     * e monta a estrutura base (cabecalho).
174:     *--------------------------------------------------------------------------
175:     PROTECTED PROCEDURE InicializarForm()
176:         LOCAL loc_lSucesso, loc_oErro
177:         loc_lSucesso = .F.
178: 
179:         TRY
180:             IF THIS.this_nBarras = 0
181:                 *-- Legado: "If (Type('pBar')<>'N') Or Empty(pBar) / ThisForm.Release"
182:                 MsgErro("Par" + CHR(226) + "metro de c" + CHR(243) + "digo de barras " + ;
183:                         "n" + CHR(227) + "o informado.", "Erro em InicializarForm")
184:             ELSE
185:                 THIS.this_oBusinessObject = CREATEOBJECT("SigOpCglBO")
186: 
187:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
188:                     MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCglBO." + CHR(13) + ;
189:                             "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
190:                             "Erro em InicializarForm")
191:                 ELSE
192:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
193: 
194:                     THIS.ConfigurarPageFrame()
195: 
196:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
197:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
198: 
199:                     THIS.TornarControlesVisiveis(THIS)
200: 
201:                     *-- Legado: SqlExecute falhando mostra MessageBox e "Return 0"
202:                     *-- (aborta o Init) - aqui equivalente a loc_lSucesso = .F.
203:                     *-- MsgErro ja foi exibido dentro de CarregarDados().
204:                     IF THIS.PodeConsultarBanco()
205:                         IF THIS.CarregarDados()
206:                             *-- Legado: "ThisForm.CmdBtnForm.BtnSair.SetFocus"
207:                             THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
208:                             loc_lSucesso = .T.
209:                         ENDIF
210:                     ELSE
211:                         loc_lSucesso = .T.
212:                     ENDIF
213:                 ENDIF
214:             ENDIF
215:         CATCH TO loc_oErro
216:             MsgErro(loc_oErro.Message + CHR(13) + ;
217:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
218:                     "Procedure: " + loc_oErro.Procedure, ;
219:                     "Erro em InicializarForm")
220:         ENDTRY
221: 
222:         RETURN loc_lSucesso
223:     ENDPROC
224: 
225:     *--------------------------------------------------------------------------
226:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
227:     * Nao ha PageFrame real (o legado SIGOPCGL e flat, sem Pagina.Lista/
228:     * Dados); metodo mantem o nome por conformidade com o contrato do
229:     * pipeline. Botoes DEPOIS do cabecalho (flutuam por cima dele, mesma
230:     * regra do cnt_4c_Saida canonico - regra #11/CLAUDE.md).
231:     *--------------------------------------------------------------------------
232:     PROTECTED PROCEDURE ConfigurarPageFrame()
233:         THIS.ConfigurarCabecalho()
234:         THIS.ConfigurarBotoes()
235:         THIS.ConfigurarGrid()
236: 
237:         *-- DEPOIS de todos os AddObject: TabIndex nao pode ser atribuido a
238:         *-- controle que ainda nao existe.
239:         THIS.ConfigurarPaginaDados()
240:     ENDPROC
241: 
242:     *--------------------------------------------------------------------------
243:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
244:     * labels de titulo sobrepostos (sombra preta + titulo branco). Geometria
245:     * TRANSCRITA do dump: SIGOPCGL.cntSombra/lblSombra/lblTitulo.
246:     *--------------------------------------------------------------------------
247:     PROTECTED PROCEDURE ConfigurarCabecalho()
248:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
249:         WITH THIS.cnt_4c_Cabecalho
250:             .Top         = 0
251:             .Left        = 0
252:             .Width       = THIS.Width
253:             .Height      = 80
254:             .BackColor   = RGB(100, 100, 100)
255:             .BackStyle   = 1
256:             .BorderWidth = 0
257:             .Visible     = .T.
258:         ENDWITH
259: 
260:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
261:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
262:             .Top           = 18
263:             .Left          = 10
264:             .Width         = 769
265:             .Height        = 40
266:             .AutoSize      = .F.
267:             .BackStyle     = 0
268:             .WordWrap      = .T.
269:             .Alignment     = 0
270:             .FontName      = "Tahoma"
271:             .FontSize      = 18
272:             .FontBold      = .T.
273:             .FontUnderline = .F.
274:             .ForeColor     = RGB(0, 0, 0)
275:             .Rotation      = 0
276:             .Caption       = THIS.Caption
277:         ENDWITH
278: 
279:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
280:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
281:             .Top         = 17
282:             .Left        = 10
283:             .Width       = 769
284:             .Height      = 46
285:             .AutoSize    = .F.
286:             .BackStyle   = 0
287:             .WordWrap    = .T.

*-- Linhas 302 a 403:
302:     * nunca inventar nome de icone). Themes = .F. no grupo e no botao
303:     * (padrao canonico do CommandGroup - nao e botao standalone).
304:     *--------------------------------------------------------------------------
305:     PROTECTED PROCEDURE ConfigurarBotoes()
306:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
307:         WITH THIS.cmg_4c_Botoes
308:             .Top           = -2
309:             .Left          = 720
310:             .Width         = 85
311:             .Height        = 85
312:             .ButtonCount   = 1
313:             *-- Dump: AutoSize = .T. com Width/Height = 85 e btnSair 75x75 em
314:             *-- 5,5 - ou seja 5 + 75 + 5 = 85 nos dois eixos: a geometria fixa
315:             *-- JA EH o auto-size que o Form Designer calculou. Fixar com
316:             *-- AutoSize = .F. reproduz o legado e evita o risco da regra #23
317:             *-- (AutoSize descartando Width/Height em controle de AddObject).
318:             .AutoSize      = .F.
319:             .BackStyle     = 0
320:             .BorderStyle   = 0
321:             .SpecialEffect = 1
322:             .BorderColor   = RGB(136, 189, 188)
323:             .Themes        = .F.
324:             .Visible       = .T.
325:         ENDWITH
326: 
327:         WITH THIS.cmg_4c_Botoes.Buttons(1)
328:             .Top        = 5
329:             .Left       = 5
330:             .Width      = 75
331:             .Height     = 75
332:             .FontBold   = .T.
333:             .FontItalic = .T.
334:             .FontName   = "Comic Sans MS"
335:             .FontSize   = 8
336:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
337:             .Cancel     = .T.
338:             .Caption    = "Encerrar"
339:             .ToolTipText = "Sair [ESC]"
340:             .ForeColor  = RGB(90, 90, 90)
341:             .BackColor  = RGB(255, 255, 255)
342:             .Themes     = .F.
343:         ENDWITH
344: 
345:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnEncerrarClick")
346:     ENDPROC
347: 
348:     *--------------------------------------------------------------------------
349:     * BtnEncerrarClick - cmg_4c_Botoes.Buttons(1), legado:
350:     * "PROCEDURE btnSair.Click / ThisForm.Release".
351:     *--------------------------------------------------------------------------
352:     PROCEDURE BtnEncerrarClick()
353:         THIS.Release()
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarGrid - grd_4c_Dados (grdHistorico do legado). So LAYOUT
358:     * (posicao/ColumnCount/Header.Caption/ReadOnly/Movable/Resizable) -
359:     * NUNCA ControlSource aqui: cursor_4c_HistoricoCgl ainda nao existe
360:     * neste ponto (regra #41). RecordSource/ControlSource reais vao em
361:     * CarregarDados(), depois que o BO cria o cursor.
362:     *--------------------------------------------------------------------------
363:     PROTECTED PROCEDURE ConfigurarGrid()
364:         THIS.AddObject("grd_4c_Dados", "Grid")
365:         WITH THIS.grd_4c_Dados
366:             .Top         = 98
367:             .Left        = 117
368:             .Width       = 565
369:             .Height      = 130
370:             .HeaderHeight       = 0
371:             .ColumnCount = 6
372:             .DeleteMark  = .F.
373:             .RecordMark  = .F.
374: 
375:             *-- Propriedades da CLASSE fwgrade (framework.vcx), que o SCX NAO
376:             *-- sobrescreve - medidas no proprio .vcx em 2026-10-24, nao
377:             *-- deduzidas: ColumnCount 0 / FontName "Tahoma" / FontSize 8 /
378:             *-- AllowHeaderSizing .F. / AllowRowSizing .F. / DeleteMark .F. /
379:             *-- Height 200 / RowHeight 16 / ScrollBars 2 / Width 578 /
380:             *-- GridLineColor 238,238,238 / HighlightBackColor 90,90,90.
381:             *-- ATENCAO: fwgrade eh Tahoma 8 e HighlightBackColor ESCURO - o
382:             *-- "Verdana" + HighlightBackColor branco de
383:             *-- docs\framework_frmcadastro_layout.md sao override da INSTANCIA
384:             *-- "Grade" dentro de frmcadastro (form CRUD), nao da classe.
385:             .FontName          = "Tahoma"
386:             .FontSize          = 8
387:             .AllowHeaderSizing = .F.
388:             .AllowRowSizing    = .F.
389:             .RowHeight         = 18
390:             .ScrollBars        = 2
391:             .GridLineColor     = RGB(238, 238, 238)
392:             .HighlightBackColor = RGB(90, 90, 90)
393: 
394:             *-- Grid.ReadOnly NAO eh atribuido de proposito: o legado trava a
395:             *-- grade pelas COLUNAS (loop "For lnCol = 1 To .ColumnCount" do
396:             *-- Init, que faz .Column<N>.ReadOnly = .T.), e Grid.ReadOnly
397:             *-- PROPAGA para as colunas sobrescrevendo-as (regra #18/#46).
398:             .Visible     = .T.
399: 
400:             .Column1.Width      = 68
401:             .Column1.Movable    = .F.
402:             .Column1.Resizable  = .F.
403:             .Column1.ReadOnly   = .T.

*-- Linhas 502 a 523:
502:     * inventar o que o legado nao tem".
503:     *
504:     * Entao o trabalho REAL que sobra para esta fase eh o que a Fase 4
505:     * descartou ao criar todos os controles de uma vez: as propriedades
506:     * "pequenas" do dump. Transcritas agora:
507:     *   - grd_4c_Dados: as 8 propriedades da classe fwgrade (ver ConfigurarGrid)
508:     *   - grd_4c_Dados.ColumnN.Text1: BorderStyle/Margin/ReadOnly/ForeColor/
509:     *     BackColor dos 6 Text1 (ver ConfigurarGrid)
510:     *   - cmg_4c_Botoes: AutoSize (ver ConfigurarBotoes)
511:     *   - lbl_4c_Sombra / lbl_4c_Titulo: Rotation (ver ConfigurarCabecalho)
512:     *   - os 3 TabIndex, aqui
513:     *
514:     * TabIndex fica em metodo proprio porque PRECISA rodar DEPOIS de todos os
515:     * AddObject (atribuir em controle inexistente estoura), e vai em ordem
516:     * ASCENDENTE.
517:     *
518:     * ATENCAO - os numeros do dump NAO sao transcritos literalmente, e o
519:     * motivo foi MEDIDO no VFP9 em 2026-10-24 (nao deduzido): TabIndex eh um
520:     * ORDINAL 1..N dentro do container, CLAMPEADO pela quantidade de irmaos -
521:     * nao eh inteiro livre. O dump traz btnSair = 3, grdHistorico = 18 e
522:     * cmdBtnForm = 24, mas SIGOPCGL tem so TRES filhos diretos, entao o VFP
523:     * colapsa 18 -> 2 e 24 -> 3 (medido: atribuir 3/18/24 e atribuir 1/2/3

*-- Linhas 534 a 581:
534:     * Column.Text1 nao tem TabIndex no dump (celula de grade nao entra na
535:     * ordem de tabulacao do form) - nada a fazer la.
536:     *--------------------------------------------------------------------------
537:     PROTECTED PROCEDURE ConfigurarPaginaDados()
538:         *-- Dump: Command1.TabIndex = 3. btnSair eh o UNICO membro do
539:         *-- CommandGroup, entao o ordinal dele eh fixo em 1 - a atribuicao
540:         *-- existe para deixar a transcricao completa e conferivel.
541:         THIS.cmg_4c_Botoes.Buttons(1).TabIndex = 1
542: 
543:         *-- Dump: SIGOPCGL.grdHistorico / TabIndex = 18 -> ordinal 2
544:         *-- (cnt_4c_Cabecalho ocupa o 1, como cntSombra no legado, que
545:         *-- tambem nao declara TabIndex).
546:         THIS.grd_4c_Dados.TabIndex = 2
547: 
548:         *-- Dump: SIGOPCGL.cmdBtnForm / TabIndex = 24 -> ordinal 3
549:         THIS.cmg_4c_Botoes.TabIndex = 3
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * CarregarDados - delega ao BO (SigOpCglBO.CarregarHistorico) a
554:     * consulta filtrada por this_nBarras, depois rebinda o grid
555:     * (RecordSource + Column.ControlSource + Width/Header.Caption - a
556:     * reatribuicao de RecordSource reseta os dois ultimos, Problema 48) e
557:     * repinta (GO TOP + Refresh - regra #21, cursor novo nao repinta a
558:     * grade por si so).
559:     *--------------------------------------------------------------------------
560:     PROTECTED FUNCTION CarregarDados()
561:         LOCAL loc_lSucesso
562: 
563:         loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico(THIS.this_nBarras)
564: 
565:         IF loc_lSucesso
566:             WITH THIS.grd_4c_Dados
567:                 .RecordSource = "cursor_4c_HistoricoCgl"
568: 
569:                 .Column1.ControlSource = "cursor_4c_HistoricoCgl.Datas"
570:                 .Column2.ControlSource = "cursor_4c_HistoricoCgl.Horas"
571:                 .Column3.ControlSource = "cursor_4c_HistoricoCgl.Locatus"
572:                 .Column4.ControlSource = "cursor_4c_HistoricoCgl.Locnews"
573:                 .Column5.ControlSource = "cursor_4c_HistoricoCgl.Usuars"
574:                 .Column6.ControlSource = "cursor_4c_HistoricoCgl.Empdopnums"
575: 
576:                 .Column1.Width = 68
577:                 .Column1.Header1.Caption = "Data"
578:                 .Column2.Width = 60
579:                 .Column2.Header1.Caption = "Hora"
580:                 .Column3.Width = 55
581:                 .Column3.Header1.Caption = "Atual"

*-- Linhas 587 a 607:
587:                 .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
588:             ENDWITH
589: 
590:             SELECT cursor_4c_HistoricoCgl
591:             GO TOP
592:             THIS.grd_4c_Dados.Refresh()
593:         ENDIF
594: 
595:         RETURN loc_lSucesso
596:     ENDFUNC
597: 
598:     *--------------------------------------------------------------------------
599:     * PodeConsultarBanco - .T. quando ha conexao real e o form NAO esta
600:     * rodando sob validacao de UI/teste automatizado (mesmo helper canonico
601:     * de Formsigopcgb.PodeConsultarBanco).
602:     *--------------------------------------------------------------------------
603:     FUNCTION PodeConsultarBanco()
604:         LOCAL loc_lPode
605: 
606:         loc_lPode = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
607: 

*-- Linhas 617 a 656:
617:     ENDFUNC
618: 
619:     *--------------------------------------------------------------------------
620:     * Destroy - equivalente ao "PROCEDURE Release" do form legado
621:     * ("ThisForm.poDataMgr.Release"). O cursor de historico
622:     * (cursor_4c_HistoricoCgl, criado em SigOpCglBO.CarregarHistorico - Fase
623:     * 4) vive na data session PRIVADA do form (DataSession = 2, igual ao
624:     * legado) e e fechado automaticamente pelo VFP quando o form e destruido
625:     * - nao exige fechamento explicito aqui.
626:     *
627:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
628:     * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
629:     * os pads do menu principal depois de uma tela modal fechar - sem ele o
630:     * menu do sistema aparece encolhido.
631:     *--------------------------------------------------------------------------
632:     PROCEDURE Destroy()
633:         DODEFAULT()
634:     ENDPROC
635: 
636:     *--------------------------------------------------------------------------
637:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
638:     * FILTRO: nenhum container flutuante neste form
639:     *--------------------------------------------------------------------------
640:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
641:         LOCAL loc_i, loc_oControl
642: 
643:         FOR loc_i = 1 TO par_oContainer.ControlCount
644:             loc_oControl = par_oContainer.Controls(loc_i)
645:             IF VARTYPE(loc_oControl) = "O"
646:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
647:                     loc_oControl.Visible = .T.
648:                 ENDIF
649:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
650:                     THIS.TornarControlesVisiveis(loc_oControl)
651:                 ENDIF
652:             ENDIF
653:         ENDFOR
654:     ENDPROC
655: 
656: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCglBO.prg):
*==============================================================================
* SIGOPCGLBO.PRG
* Business Object - Historico de Locais (SigCdMlc)
* Origem legado: SIGOPCGL.SCX (form generico, filtro por barras)
* Form: FormSigOpCgl.prg (OPERACIONAL - somente leitura)
*
* O legado (Init do SCX) faz APENAS um Select filtrado por barras e exibe o
* resultado num grid - nao ha Insert/Update/Delete em lugar nenhum do dump
* (nenhum TABLEUPDATE, nenhum .AddCursor). SigCdMlc eh log de movimentacao de
* local, populado por outro processo; este form so CONSULTA. Por isso
* Inserir()/Atualizar()/ExecutarExclusao() sao sobrescritos apenas para
* informar que a operacao nao e suportada por este BO - nunca para inventar
* INSERT/UPDATE que o legado nao faz. Metodos presentes nesta fase:
* CarregarHistorico (Select real), CarregarDoCursor (mapeia as colunas do
* cursor para as propriedades), ObterChavePrimaria, Inserir, Atualizar.
*==============================================================================

DEFINE CLASS SigOpCglBO AS BusinessBase

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_nBarras      = 0    && SigCdMlc.barras - numeric(14,0) - chave de filtro (parametro do form)
    this_dDatas       = {}   && SigCdMlc.datas - datetime
    this_cHoras       = ""   && SigCdMlc.horas - char(8)
    this_cLocatus     = ""   && SigCdMlc.locatus - char(10) - local atual (antes da alteracao)
    this_cLocnews     = ""   && SigCdMlc.locnews - char(10) - local novo (depois da alteracao)
    this_cUsuars      = ""   && SigCdMlc.usuars - char(10)
    this_cEmpdopnums  = ""   && SigCdMlc.empdopnums - char(29) - identificacao da operacao

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigCdMlc"
        THIS.this_cCampoChave  = "cidchaves"

        DODEFAULT("SigCdMlc")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Executa o Select do legado (SigCdMlc filtrado por
    * barras) e popula cursor_4c_HistoricoCgl, que o Grid da Lista consome.
    *   par_nBarras = codigo de barras cujo historico de locais sera exibido
    * Retorna .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarHistorico(par_nBarras)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder identico ao que o SQLEXEC vai popular
            SET NULL ON
            IF USED("cursor_4c_HistoricoCgl")
                USE IN cursor_4c_HistoricoCgl
            ENDIF
            CREATE CURSOR cursor_4c_HistoricoCgl ;
                (Datas      T     NULL, ;
                 Horas      C(8)  NULL, ;
                 Locatus    C(10) NULL, ;
                 Locnews    C(10) NULL, ;
                 Usuars     C(10) NULL, ;
                 Empdopnums C(29) NULL)
            SET NULL OFF

            THIS.this_nBarras = par_nBarras

            *-- Select identico ao Init do SCX legado (ordem das colunas e do
            *-- Order By transcritos sem alteracao)
            loc_cSQL = "SELECT datas, horas, locatus, locnews, usuars, empdopnums " + ;
                       "FROM SigCdMlc " + ;
                       "WHERE barras = " + FormatarNumeroSQL(par_nBarras, 0) + " " + ;
                       "ORDER BY datas, horas, locatus, locnews, usuars, empdopnums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistCglTemp")

            IF loc_nResult >= 0
                SELECT cursor_4c_HistoricoCgl
                ZAP
                APPEND FROM DBF("cursor_4c_HistCglTemp")
                IF USED("cursor_4c_HistCglTemp")
                    USE IN cursor_4c_HistCglTemp
                ENDIF
                SELECT cursor_4c_HistoricoCgl
                GO TOP
                loc_lSucesso = .T.
            ELSE
                LOCAL loc_aErroSQL[1]
                AERROR(loc_aErroSQL)
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico de locais:" + CHR(13) + ;
                        loc_aErroSQL[2], "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente de cursor_4c_HistoricoCgl
    * (ou do alias informado) para as propriedades da instancia
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, "cursor_4c_HistoricoCgl")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de hist" + CHR(243) + "rico n" + CHR(227) + ;
                                      "o est" + CHR(225) + " aberto: " + loc_cAlias
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        IF RECCOUNT() = 0 OR EOF()
            RETURN .F.
        ENDIF

        THIS.this_dDatas      = TratarNulo(datas, {})
        THIS.this_cHoras      = TratarNulo(horas, "")
        THIS.this_cLocatus    = TratarNulo(locatus, "")
        THIS.this_cLocnews    = TratarNulo(locnews, "")
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional eh somente consulta; nao ha uma
    * unica coluna-chave exibida (a PK real da tabela, cidchaves, nem entra no
    * Select do legado)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Historico de Locais eh SOMENTE LEITURA
    *   SigCdMlc eh log de movimentacao de local, gravado por outro processo
    *   (movimentacao de produto/local). Este BO nunca grava nela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de INSER" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Historico de Locais eh SOMENTE LEITURA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de ATUALIZA" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Historico de Locais eh SOMENTE LEITURA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de EXCLUS" + CHR(195) + ;
                                  "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE


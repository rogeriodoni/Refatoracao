# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_MENSAGEM, CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Opera' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Resumo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Visualizar' (parent: SIGOPCFE): Left original=650 vs migrado 'cmd_4c_Visualizar' Left=840 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Processa' (parent: SIGOPCFE): Left original=500 vs migrado 'cmd_4c_Processa' Left=690 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGOPCFE): Left original=725 vs migrado 'cmd_4c_Saida' Left=915 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imprimir' (parent: SIGOPCFE): Left original=575 vs migrado 'cmd_4c_Imprimir' Left=765 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCFE.cntMensagem): Top original=19 vs migrado 'lbl_4c_Label1' Top=183 (diff=164px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCFE.cntMensagem): Left original=82 vs migrado 'lbl_4c_Label1' Left=126 (diff=44px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCFE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1686 linhas total):

*-- Linhas 16 a 905:
16: * Fase 5/8 - Filtros, parte 1: Material (txt_4c_Mat/txt_4c_DMat) + lookup
17: *            em SigCdPro + FormParaBO (sincroniza a tela com o BO).
18: * Fase 6/8 - Filtros, parte 2: Grupo (txt_4c_Grupo/txt_4c__Dgrupo) com
19: *            lookup via fAcessoContab(), Conta (txt_4c_Conta/txt_4c_Dconta)
20: *            com lookup via cursor_4c_Cli/FormBuscaAuxiliar, as opcoes
21: *            Chk_Saldo/chkFalha e o container cnt_4c_Mensagem ("Aguarde...").
22: * Fase 7/8 - Eventos principais: CmdProcessaClick/CmdVisualizarClick/
23: *            CmdImprimirClick ligados a logica REAL no BO
24: *            (SIGOPCFEBO.ProcessarSaldos/ExibirRelatorio) - apuracao
25: *            completa do saldo (SigCdPro/SigCdCli/SigMvEst/SigCdNec/
26: *            SigMvCab/SigCdPsc/SigOpCfe, transcricao literal do
27: *            Processa.Click legado) e emissao do SigOpCfe.frx (copiado do
28: *            legado para projeto\app\reports\).
29: * Fase 8/8 - Eventos auxiliares e consolidacao final:
30: *            - AjustarOrdemTabulacao(): os 17 TabIndex declarados no SCX
31: *              (ordem de tabulacao eh comportamento visivel - PILAR 1).
32: *            - HabilitarCampos(par_lHabilitar): fonte UNICA do .Enabled dos
33: *              filtros, reproduzindo os PROCEDURE When do legado (o When de
34: *              Get_DMat so libera a busca por descricao enquanto o codigo
35: *              do material esta vazio).
36: *            - AjustarBotoesPorModo(): fonte UNICA de grd_4c_Dados.Visible e
37: *              de cmd_4c_Visualizar/cmd_4c_Imprimir.Enabled, antes espalhada
38: *              entre ValidarMatExec e CmdProcessaClick - e que por isso nao
39: *              desligava os botoes no caminho "Nenhum Saldo Selecionado!!!".
40: *            - FormParaBO (agora PUBLIC) / BOParaForm / LimparCampos: par de
41: *              transferencia tela<->BO e estado inicial consolidado.
42: *            - Imprimir(): FormParaBO antes de emitir, porque o legado monta
43: *              o subtitulo do FRX lendo Get_Mat/Get_DMat da TELA.
44: *
45: * NAO existem BtnSalvarClick/BtnCancelarClick/BtnBuscarClick/CarregarLista
46: * neste form: o SIGOPCFE.SCX nao tem Page1(Lista)/Page2(Dados), nem modo
47: * INCLUIR/ALTERAR/EXCLUIR, nem botao de gravar/cancelar/buscar - os botoes
48: * REAIS do legado sao quatro (Processa/Visualizar/Imprimir/Saida) e todos
49: * tem handler (CmdProcessaClick/CmdVisualizarClick/CmdImprimirClick/
50: * CmdSaidaClick). Criar aqueles nomes exigiria inventar superficie que o
51: * legado nao tem (viola o PILAR 1) ou escrever metodo vazio (proibido pela
52: * regra de completude). A carga da grade vive em CarregarDados().
53: *==============================================================================
54: 
55: DEFINE CLASS FormSIGOPCFE AS FormBase
56: 
57:     *-- Propriedades visuais (analise.json: Width=1000, Height=600, Tahoma 8)
58:     Height       = 600
59:     Width        = 1000
60:     Caption      = "Pesquisa de Saldos por Funcion" + CHR(225) + "rio"
61:     AutoCenter   = .T.
62:     ShowWindow   = 1
63:     WindowType   = 1
64:     ControlBox   = .F.
65:     TitleBar     = 0
66:     Themes       = .F.
67:     BorderStyle  = 2
68: 
69:     *-- Propriedades de estado
70:     this_oBusinessObject = .NULL.
71: 
72:     *-- Guarda de reentrancia dos lookups de filtro (regra #37/#47 -
73:     *-- FormBuscaAuxiliar eh MODAL e tira o foco do TextBox, o que
74:     *-- redispara o proprio LostFocus; e guarda de valor-ja-validado,
75:     *-- para nao reabrir o picker quando o valor nao mudou)
76:     this_lEmLookup              = .F.
77:     this_cUltimoMatValidado     = ""
78:     this_cUltimoDMatValidado    = ""
79:     this_cUltimoGrupoValidado   = ""
80:     this_cUltimoDGrupoValidado  = ""
81:     this_cUltimoContaValidado   = ""
82:     this_cUltimoDContaValidado  = ""
83: 
84:     *-- Estado do resultado apurado, consumido por AjustarBotoesPorModo()
85:     *-- (fonte UNICA do estado de grd_4c_Dados/cmd_4c_Visualizar/
86:     *-- cmd_4c_Imprimir). Nasce .T. porque o SCX legado NAO declara
87:     *-- Grade.Visible nem Visualizar/Imprimir.Enabled - isto eh, a tela abre
88:     *-- com a grade visivel e os dois botoes habilitados; o legado so os
89:     *-- derruba no Valid de Get_Mat (material trocado invalida o resultado) e
90:     *-- os reacende no fim do Processa.Click.
91:     this_lResultadoValido       = .T.
92: 
93:     *==========================================================================
94:     * Init - Apenas DODEFAULT(). FormBase.Init() ja chama InicializarForm()
95:     *==========================================================================
96:     PROCEDURE Init()
97:         RETURN DODEFAULT()
98:     ENDPROC
99: 
100:     *==========================================================================
101:     * InicializarForm - Instancia o BO e monta a estrutura visual
102:     *==========================================================================
103:     PROTECTED PROCEDURE InicializarForm()
104:         LOCAL loc_lSucesso, loc_oErro
105:         loc_lSucesso = .F.
106: 
107:         TRY
108:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
109:             SET DATE TO BRITISH
110:             SET CENTURY ON
111: 
112:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCFEBO")
113:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
114: 
115:                 *-- Estrutura visual base (Fase 3) via orquestrador
116:                 THIS.ConfigurarPageFrame()
117: 
118:                 *-- Sincronizar caption nos labels do cabecalho
119:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
120:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
121: 
122:                 *-- Cursores de referencia (SigCdPam/Pac/OpOpt/Ope/Opd/Gcr/Pro/Cli/Gccr)
123:                 *-- Pulados em validacao de UI (sem conexao SQL - Problema 4 FORMCOR_LICOES)
124:                 *-- cnt_4c_Mensagem replica o "Aguarde! Preparando arquivos."
125:                 *-- do Init() legado (CntMensagem.Visible = .t. ... .Refresh
126:                 *-- ... CarregarCursoresReferencia ... CntMensagem.Visible = .f.)
127:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
128:                     THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde! Preparando arquivos."
129:                     THIS.cnt_4c_Mensagem.Visible = .T.
130:                     THIS.Refresh()
131:                     THIS.this_oBusinessObject.CarregarCursoresReferencia()
132:                     THIS.cnt_4c_Mensagem.Visible = .F.
133:                 ENDIF
134: 
135:                 THIS.TornarControlesVisiveis(THIS)
136: 
137:                 *-- Estado inicial consolidado (Fase 8/8): LimparCampos()
138:                 *-- zera os filtros, o BO e a grade de resultado, e fecha
139:                 *-- chamando HabilitarCampos()/AjustarBotoesPorModo(). Roda
140:                 *-- DEPOIS de TornarControlesVisiveis porque aquele forca
141:                 *-- Visible = .T. em tudo e sobrescreveria o estado da grade.
142:                 THIS.LimparCampos()
143: 
144:                 THIS.Visible = .T.
145:                 loc_lSucesso = .T.
146:             ELSE
147:                 MsgErro("Falha ao criar SIGOPCFEBO.", "Erro em InicializarForm")
148:             ENDIF
149:         CATCH TO loc_oErro
150:             MsgErro(loc_oErro.Message + CHR(13) + ;
151:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
152:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
153:         ENDTRY
154: 
155:         RETURN loc_lSucesso
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarPageFrame - Orquestrador de montagem visual
160:     * SIGOPCFE.SCX e Form PLANO sem PageFrame (cntSombra + filtros + grade +
161:     * botoes direto no form). Mantido o nome "ConfigurarPageFrame" so para
162:     * preservar o papel arquitetural de ponto de entrada da montagem visual
163:     * (mesmo padrao de FormFop/FormDCC), delegando para helpers dedicados.
164:     * Fase 3: cabecalho. Fase 4: grade de resultado + botoes de acao.
165:     * Fase 5: filtros, parte 1 - Material (txt_4c_Mat/txt_4c_DMat) + Shape1.
166:     * Fase 6: filtros, parte 2 - Grupo/Conta/checkboxes/cnt_4c_Mensagem
167:     * (ConfigurarFiltros() completo).
168:     *==========================================================================
169:     PROTECTED PROCEDURE ConfigurarPageFrame()
170:         THIS.ConfigurarCabecalho()
171:         THIS.ConfigurarFiltros()
172:         THIS.ConfigurarGrade()
173:         THIS.ConfigurarBotoes()
174: 
175:         *-- Ordem de tabulacao (Fase 8/8): depende de TODOS os controles ja
176:         *-- criados, por isso fecha a montagem visual.
177:         THIS.AjustarOrdemTabulacao()
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * AjustarOrdemTabulacao - Transcreve os TabIndex declarados no SCX
182:     * legado (PILAR 1: a ordem de tabulacao eh comportamento visivel). O
183:     * dump declara 17 indices nos filhos diretos da Form, nesta ordem:
184:     *
185:     *    1 Get_grupo    -> txt_4c_Grupo          10 Say1        -> lbl_4c_Label1
186:     *    2 get_Dgrupo   -> txt_4c__Dgrupo        11 cntMensagem -> cnt_4c_Mensagem
187:     *    3 Get_conta    -> txt_4c_Conta          12 Grade       -> grd_4c_Dados
188:     *    4 Get_dconta   -> txt_4c_Dconta         13 Visualizar  -> cmd_4c_Visualizar
189:     *    5 Get_Mat      -> txt_4c_Mat            14 Imprimir    -> cmd_4c_Imprimir
190:     *    6 Get_DMat     -> txt_4c_DMat           15 Saida       -> cmd_4c_Saida
191:     *    7 Chk_Saldo    -> chk_4c_Chk_Saldo      16 Say2        -> lbl_4c_Label2
192:     *    8 chkFalha     -> chk_4c_ChkFalha       17 Say5        -> lbl_4c_Label5
193:     *    9 Processa     -> cmd_4c_Processa
194:     *
195:     * Atribuidos em ordem CRESCENTE de proposito: em VFP9 atribuir TabIndex
196:     * reposiciona o controle na sequencia e DESLOCA os irmaos, entao so
197:     * percorrendo 1..N na ordem desejada o resultado final eh o pretendido.
198:     *
199:     * shp_4c_Shape1 fica de fora porque a classe base Shape NAO tem TabIndex
200:     * (conferido em automation\propriedades_baseclasses.txt - regra #33:
201:     * atribuir propriedade inexistente derruba o Init e a tela nao abre), e
202:     * cnt_4c_Sombra tambem - o cntSombra do legado nao declara TabIndex.
203:     *==========================================================================
204:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
205:         LOCAL loc_oErro
206:         TRY
207:             THIS.txt_4c_Grupo.TabIndex      = 1
208:             THIS.txt_4c__Dgrupo.TabIndex    = 2
209:             THIS.txt_4c_Conta.TabIndex      = 3
210:             THIS.txt_4c_Dconta.TabIndex     = 4
211:             THIS.txt_4c_Mat.TabIndex        = 5
212:             THIS.txt_4c_DMat.TabIndex       = 6
213:             THIS.chk_4c_Chk_Saldo.TabIndex  = 7
214:             THIS.chk_4c_ChkFalha.TabIndex   = 8
215:             THIS.cmd_4c_Processa.TabIndex   = 9
216:             THIS.lbl_4c_Label1.TabIndex     = 10
217:             THIS.cnt_4c_Mensagem.TabIndex   = 11
218:             THIS.grd_4c_Dados.TabIndex      = 12
219:             THIS.cmd_4c_Visualizar.TabIndex = 13
220:             THIS.cmd_4c_Imprimir.TabIndex   = 14
221:             THIS.cmd_4c_Saida.TabIndex      = 15
222:             THIS.lbl_4c_Label2.TabIndex     = 16
223:             THIS.lbl_4c_Label5.TabIndex     = 17
224:         CATCH TO loc_oErro
225:             MsgErro(loc_oErro.Message + CHR(13) + ;
226:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
227:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarOrdemTabulacao")
228:         ENDTRY
229:     ENDPROC
230: 
231:     *==========================================================================
232:     * ConfigurarFiltros - Cria os filtros de pesquisa do SIGOPCFE.SCX.
233:     * Fase 5/8 (parte 1 de 2): Shape1 (decorativo) + Material (Get_Mat/
234:     * Get_DMat -> txt_4c_Mat/txt_4c_DMat).
235:     * Fase 6/8 (parte 2 de 2): Grupo (Get_grupo/get_Dgrupo -> txt_4c_Grupo/
236:     * txt_4c__Dgrupo), Conta (Get_conta/Get_dconta -> txt_4c_Conta/
237:     * txt_4c_Dconta), os CheckBoxes (Chk_Saldo/chkFalha) e o cnt_4c_Mensagem
238:     * (equivalente ao CntMensagem do legado - nasce oculto, Fase 7/8 exibe
239:     * durante o processamento).
240:     * Posicoes/propriedades EXATAS do dump (SIGOPCFE.SCX):
241:     *   Shape1     Top=7/Left=563/Width=229/Height=110, BorderColor=136,189,188
242:     *   Say1       "Material : " Top=183/Left=126/Width=58
243:     *   Get_Mat    Top=180/Left=186/Width=108/MaxLength=14  (SigCdPro.CPros)
244:     *   Get_DMat   Top=180/Left=295/Width=303/MaxLength=40  (SigCdPro.DPros)
245:     *   Say5       "Grupo : "  Top=123/Left=146 (classe say pura - regra #23)
246:     *   Get_grupo  Top=119/Left=186/Width=80   (SigCdGcr.Codigos)
247:     *   get_Dgrupo Top=119/Left=268/Width=302/MaxLength=40 (SigCdGcr.Descrs)
248:     *   Say2       "Conta :"   Top=150/Left=146
249:     *   Get_conta  Top=146/Left=186/Width=80   (SigCdCli.IClis)
250:     *   Get_dconta Top=146/Left=268/Width=302  (SigCdCli.RClis)
251:     *   Chk_Saldo  "Nao Mostrar Saldos Zerados" Top=207/Left=188/W=153/H=15
252:     *   chkFalha   "Nao checar falha" Top=207/Left=385/W=99/H=15
253:     *   cntMensagem Top=268/Left=151/W=497/H=63 (Visible=.F. - exibido so
254:     *               durante o processamento, Fase 7/8)
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarFiltros()
257:         LOCAL loc_oErro
258:         TRY
259:             THIS.AddObject("shp_4c_Shape1", "Shape")
260:             WITH THIS.shp_4c_Shape1
261:                 .Top         = 7
262:                 .Left        = 563
263:                 .Width       = 229
264:                 .Height      = 110
265:                 .BackStyle   = 0
266:                 .BorderStyle = 0
267:                 .BorderColor = RGB(136, 189, 188)
268:                 .Visible     = .T.
269:             ENDWITH
270: 
271:             THIS.AddObject("lbl_4c_Label1", "Label")
272:             WITH THIS.lbl_4c_Label1
273:                 .FontBold  = .T.
274:                 .FontName  = "Tahoma"
275:                 .FontSize  = 8
276:                 .Alignment = 0
277:                 .BackStyle = 0
278:                 .AutoSize  = .F.
279:                 .Caption   = "Material : "
280:                 .Left      = 126
281:                 .Top       = 183
282:                 .Width     = 58
283:                 .Height    = 17
284:                 .ForeColor = RGB(90, 90, 90)
285:                 .Visible   = .T.
286:             ENDWITH
287: 
288:             THIS.AddObject("txt_4c_Mat", "TextBox")
289:             WITH THIS.txt_4c_Mat
290:                 .FontName      = "Tahoma"
291:                 .FontSize      = 8
292:                 .Height        = 23
293:                 .Left          = 186
294:                 .Top           = 180
295:                 .Width         = 108
296:                 .MaxLength     = 14
297:                 .SpecialEffect = 1
298:                 .ForeColor     = RGB(0, 0, 0)
299:                 .BorderColor   = RGB(100, 100, 100)
300:                 .Value         = ""
301:                 .Visible       = .T.
302:             ENDWITH
303:             BINDEVENT(THIS.txt_4c_Mat, "LostFocus", THIS, "ValidarMat")
304: 
305:             THIS.AddObject("txt_4c_DMat", "TextBox")
306:             WITH THIS.txt_4c_DMat
307:                 .FontName      = "Tahoma"
308:                 .FontSize      = 8
309:                 .Height        = 23
310:                 .Left          = 295
311:                 .Top           = 180
312:                 .Width         = 303
313:                 .MaxLength     = 40
314:                 .SpecialEffect = 1
315:                 .ForeColor     = RGB(0, 0, 0)
316:                 .BorderColor   = RGB(100, 100, 100)
317:                 .Value         = ""
318:                 .Visible       = .T.
319:             ENDWITH
320:             BINDEVENT(THIS.txt_4c_DMat, "LostFocus", THIS, "ValidarDMat")
321: 
322:             *-- Grupo (Get_grupo/get_Dgrupo -> SigCdGcr.Codigos/Descrs)
323:             THIS.AddObject("lbl_4c_Label5", "Label")
324:             WITH THIS.lbl_4c_Label5
325:                 .FontBold  = .T.
326:                 .FontName  = "Tahoma"
327:                 .FontSize  = 8
328:                 .Alignment = 0
329:                 .BackStyle = 0
330:                 .AutoSize  = .F.
331:                 .Caption   = "Grupo :"
332:                 .Left      = 146
333:                 .Top       = 123
334:                 .Width     = 45
335:                 .Height    = 17
336:                 .ForeColor = RGB(90, 90, 90)
337:                 .Visible   = .T.
338:             ENDWITH
339: 
340:             THIS.AddObject("txt_4c_Grupo", "TextBox")
341:             WITH THIS.txt_4c_Grupo
342:                 .FontName          = "Tahoma"
343:                 .FontSize          = 8
344:                 .Height            = 23
345:                 .Left              = 186
346:                 .Top               = 119
347:                 .Width             = 80
348:                 .MaxLength         = 10
349:                 .SpecialEffect     = 1
350:                 .ForeColor         = RGB(0, 0, 0)
351:                 .DisabledBackColor = RGB(255, 255, 255)
352:                 .DisabledForeColor = RGB(0, 0, 128)
353:                 .BorderColor       = RGB(100, 100, 100)
354:                 .Value             = ""
355:                 .Visible           = .T.
356:             ENDWITH
357:             BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")
358: 
359:             THIS.AddObject("txt_4c__Dgrupo", "TextBox")
360:             WITH THIS.txt_4c__Dgrupo
361:                 .FontName          = "Tahoma"
362:                 .FontSize          = 8
363:                 .Height            = 23
364:                 .Left              = 268
365:                 .Top               = 119
366:                 .Width             = 302
367:                 .MaxLength         = 40
368:                 .SpecialEffect     = 1
369:                 .ForeColor         = RGB(0, 0, 0)
370:                 .DisabledBackColor = RGB(255, 255, 255)
371:                 .DisabledForeColor = RGB(0, 0, 128)
372:                 .BorderColor       = RGB(100, 100, 100)
373:                 .Value             = ""
374:                 .Visible           = .T.
375:             ENDWITH
376:             BINDEVENT(THIS.txt_4c__Dgrupo, "LostFocus", THIS, "ValidarDGrupo")
377: 
378:             *-- Conta/Funcionario (Get_conta/Get_dconta -> SigCdCli.IClis/RClis)
379:             THIS.AddObject("lbl_4c_Label2", "Label")
380:             WITH THIS.lbl_4c_Label2
381:                 .FontBold  = .T.
382:                 .FontName  = "Tahoma"
383:                 .FontSize  = 8
384:                 .Alignment = 0
385:                 .BackStyle = 0
386:                 .AutoSize  = .F.
387:                 .Caption   = "Conta :"
388:                 .Left      = 146
389:                 .Top       = 150
390:                 .Width     = 40
391:                 .Height    = 17
392:                 .ForeColor = RGB(90, 90, 90)
393:                 .Visible   = .T.
394:             ENDWITH
395: 
396:             THIS.AddObject("txt_4c_Conta", "TextBox")
397:             WITH THIS.txt_4c_Conta
398:                 .FontName          = "Tahoma"
399:                 .FontSize          = 8
400:                 .Height            = 23
401:                 .Left              = 186
402:                 .Top               = 146
403:                 .Width             = 80
404:                 .MaxLength         = 10
405:                 .SpecialEffect     = 1
406:                 .ForeColor         = RGB(0, 0, 0)
407:                 .DisabledBackColor = RGB(255, 255, 255)
408:                 .DisabledForeColor = RGB(0, 0, 128)
409:                 .BorderColor       = RGB(100, 100, 100)
410:                 .Value             = ""
411:                 .Visible           = .T.
412:             ENDWITH
413:             BINDEVENT(THIS.txt_4c_Conta, "LostFocus", THIS, "ValidarConta")
414: 
415:             THIS.AddObject("txt_4c_Dconta", "TextBox")
416:             WITH THIS.txt_4c_Dconta
417:                 .FontName          = "Tahoma"
418:                 .FontSize          = 8
419:                 .Height            = 23
420:                 .Left              = 268
421:                 .Top               = 146
422:                 .Width             = 302
423:                 .MaxLength         = 50
424:                 .SpecialEffect     = 1
425:                 .ForeColor         = RGB(0, 0, 0)
426:                 .DisabledBackColor = RGB(255, 255, 255)
427:                 .DisabledForeColor = RGB(0, 0, 128)
428:                 .BorderColor       = RGB(100, 100, 100)
429:                 .Value             = ""
430:                 .Visible           = .T.
431:             ENDWITH
432:             BINDEVENT(THIS.txt_4c_Dconta, "LostFocus", THIS, "ValidarDConta")
433: 
434:             *-- Opcoes de processamento (Chk_Saldo/chkFalha). AutoSize=.T. no
435:             *-- SCX eh NO-OP em CheckBox criado por AddObject (regra #23/
436:             *-- "autosize_noop_em_checkbox") - usar AutoSize=.F. + Width/
437:             *-- Height EXATOS do dump (ja calculados pelo Form Designer).
438:             THIS.AddObject("chk_4c_Chk_Saldo", "CheckBox")
439:             WITH THIS.chk_4c_Chk_Saldo
440:                 .Top       = 207
441:                 .Left      = 188
442:                 .Width     = 153
443:                 .Height    = 15
444:                 .FontName  = "Tahoma"
445:                 .FontSize  = 8
446:                 .AutoSize  = .F.
447:                 .Alignment = 0
448:                 .BackStyle = 0
449:                 .Caption   = CHR(78) + CHR(227) + "o Mostrar Saldos Zerados"
450:                 .ForeColor = RGB(90, 90, 90)
451:                 .Themes    = .F.
452:                 .Value     = 0
453:                 .Visible   = .T.
454:             ENDWITH
455: 
456:             THIS.AddObject("chk_4c_ChkFalha", "CheckBox")
457:             WITH THIS.chk_4c_ChkFalha
458:                 .Top         = 207
459:                 .Left        = 385
460:                 .Width       = 99
461:                 .Height      = 15
462:                 .FontName    = "Tahoma"
463:                 .FontSize    = 8
464:                 .AutoSize    = .F.
465:                 .Alignment   = 0
466:                 .BackStyle   = 0
467:                 .Caption     = CHR(78) + CHR(227) + "o checar falha"
468:                 .ToolTipText = CHR(78) + CHR(227) + "o calcula e  n" + CHR(227) + "o subtrai a falha do saldo final"
469:                 .ForeColor   = RGB(90, 90, 90)
470:                 .Themes      = .F.
471:                 .Value       = 0
472:                 .Visible     = .T.
473:             ENDWITH
474: 
475:             *-- cntMensagem - nasce OCULTO (so aparece durante o
476:             *-- processamento, "Aguarde..." - Fase 7/8 completa o uso em
477:             *-- Processar). TornarControlesVisiveis() tem excecao explicita
478:             *-- para CNT_4C_MENSAGEM (nao forca Visible=.T. no container,
479:             *-- so nos filhos dele).
480:             THIS.AddObject("cnt_4c_Mensagem", "Container")
481:             WITH THIS.cnt_4c_Mensagem
482:                 .Top           = 268
483:                 .Left          = 151
484:                 .Width         = 497
485:                 .Height        = 63
486:                 .SpecialEffect = 0
487:                 .BackColor     = RGB(255, 255, 255)
488:                 .Visible       = .F.
489:             ENDWITH
490: 
491:             THIS.cnt_4c_Mensagem.AddObject("lbl_4c_Label1", "Label")
492:             WITH THIS.cnt_4c_Mensagem.lbl_4c_Label1
493:                 .FontBold   = .T.
494:                 .FontItalic = .F.
495:                 .FontName   = "Tahoma"
496:                 .FontSize   = 14
497:                 .Alignment  = 2
498:                 .BackStyle  = 0
499:                 .AutoSize   = .F.
500:                 .Caption    = "Aguarde! Preparando arquivos."
501:                 .Height     = 25
502:                 .Left       = 82
503:                 .Top        = 19
504:                 .Width      = 295
505:                 .ForeColor  = RGB(255, 0, 0)
506:                 .Visible    = .T.
507:             ENDWITH
508:         CATCH TO loc_oErro
509:             MsgErro(loc_oErro.Message + CHR(13) + ;
510:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
511:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
512:         ENDTRY
513:     ENDPROC
514: 
515:     *==========================================================================
516:     * ValidarMat - BINDEVENT de LostFocus em txt_4c_Mat (legado: PROCEDURE
517:     * Valid de Get_Mat). PUBLIC (alvo de BINDEVENT - regra #3).
518:     *==========================================================================
519:     PROCEDURE ValidarMat()
520:         IF THIS.this_lEmLookup
521:             RETURN
522:         ENDIF
523:         THIS.this_lEmLookup = .T.
524:         THIS.ValidarMatExec()
525:         THIS.this_lEmLookup = .F.
526:     ENDPROC
527: 
528:     *==========================================================================
529:     * ValidarMatExec - Replica PROCEDURE Valid de Get_Mat: campo vazio limpa
530:     * Mat/DMat; campo preenchido abre o lookup (AbrirBuscaMat) e invalida o
531:     * resultado anterior (ThisForm.Grade.Visible=.f. / Visualizar.Enabled=.f.
532:     * / Imprimir.Enabled=.f. no legado - aqui grd_4c_Dados/cmd_4c_Visualizar/
533:     * cmd_4c_Imprimir, criados na Fase 4).
534:     *==========================================================================
535:     PROTECTED PROCEDURE ValidarMatExec()
536:         LOCAL loc_cValor
537:         loc_cValor = ALLTRIM(THIS.txt_4c_Mat.Value)
538: 
539:         IF loc_cValor == THIS.this_cUltimoMatValidado
540:             RETURN
541:         ENDIF
542:         THIS.this_cUltimoMatValidado = loc_cValor
543: 
544:         IF EMPTY(loc_cValor)
545:             THIS.txt_4c_Mat.Value  = ""
546:             THIS.txt_4c_DMat.Value = ""
547:             THIS.txt_4c_Mat.Refresh()
548:             THIS.txt_4c_DMat.Refresh()
549:         ELSE
550:             THIS.AbrirBuscaMat()
551: 
552:             *-- Material trocado invalida o resultado apurado (legado:
553:             *-- Grade.Visible/Visualizar.Enabled/Imprimir.Enabled = .f.),
554:             *-- agora pelo funil unico AjustarBotoesPorModo (Fase 8/8).
555:             THIS.this_lResultadoValido = .F.
556:             THIS.AjustarBotoesPorModo()
557:         ENDIF
558: 
559:         *-- When de Get_DMat depende de Get_Mat estar vazio: reavaliar em
560:         *-- AMBOS os ramos (regra #40 - reabilitar no funil de volta).
561:         THIS.HabilitarCampos(.T.)
562:     ENDPROC
563: 
564:     *==========================================================================
565:     * AbrirBuscaMat - Lookup de Material em SigCdPro (CPros/DPros), padrao
566:     * canonico FormBuscaAuxiliar (regra #37): Init ja tenta match exato; so
567:     * mostra o picker quando nao encontra sozinho.
568:     *==========================================================================
569:     PROTECTED PROCEDURE AbrirBuscaMat()
570:         LOCAL loc_cValorAtual, loc_oBusca
571:         loc_cValorAtual = ALLTRIM(THIS.txt_4c_Mat.Value)
572: 
573:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
574:             gnConnHandle, ;
575:             "SigCdPro", ;
576:             "cursor_4c_BuscaMat", ;
577:             "CPros", ;
578:             loc_cValorAtual, ;
579:             "Sele" + CHR(231) + CHR(227) + "o", ;
580:             .F.)
581: 
582:         IF VARTYPE(loc_oBusca) = "O"
583:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
584:                 IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
585:                     THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
586:                     THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
587:                     THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
588:                 ENDIF
589:             ELSE
590:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
591:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
592:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
593:                     loc_oBusca.Show()
594: 
595:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
596:                         THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
597:                         THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
598:                         THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
599:                     ELSE
600:                         THIS.txt_4c_Mat.Value  = ""
601:                         THIS.txt_4c_DMat.Value = ""
602:                         THIS.this_cUltimoMatValidado = ""
603:                     ENDIF
604:                 ENDIF
605:             ENDIF
606:             loc_oBusca.Release()
607:         ENDIF
608: 
609:         IF USED("cursor_4c_BuscaMat")
610:             USE IN cursor_4c_BuscaMat
611:         ENDIF
612: 
613:         THIS.txt_4c_Mat.Refresh()
614:         THIS.txt_4c_DMat.Refresh()
615:     ENDPROC
616: 
617:     *==========================================================================
618:     * ValidarDMat - BINDEVENT de LostFocus em txt_4c_DMat (legado: PROCEDURE
619:     * Valid de Get_DMat). PUBLIC (alvo de BINDEVENT - regra #3).
620:     *==========================================================================
621:     PROCEDURE ValidarDMat()
622:         IF THIS.this_lEmLookup
623:             RETURN
624:         ENDIF
625:         THIS.this_lEmLookup = .T.
626:         THIS.ValidarDMatExec()
627:         THIS.this_lEmLookup = .F.
628:     ENDPROC
629: 
630:     *==========================================================================
631:     * ValidarDMatExec - Replica PROCEDURE Valid de Get_DMat: busca reversa
632:     * por descricao. Ao contrario de Get_Mat, o legado NAO toca
633:     * Grade.Visible/Visualizar.Enabled/Imprimir.Enabled aqui.
634:     *==========================================================================
635:     PROTECTED PROCEDURE ValidarDMatExec()
636:         LOCAL loc_cValor
637:         loc_cValor = ALLTRIM(THIS.txt_4c_DMat.Value)
638: 
639:         IF loc_cValor == THIS.this_cUltimoDMatValidado
640:             RETURN
641:         ENDIF
642:         THIS.this_cUltimoDMatValidado = loc_cValor
643: 
644:         IF EMPTY(loc_cValor)
645:             THIS.txt_4c_Mat.Value  = ""
646:             THIS.txt_4c_DMat.Value = ""
647:             THIS.txt_4c_Mat.Refresh()
648:             THIS.txt_4c_DMat.Refresh()
649:         ELSE
650:             THIS.AbrirBuscaDMat()
651:         ENDIF
652: 
653:         *-- A busca reversa PREENCHE txt_4c_Mat, e o When de Get_DMat passa a
654:         *-- recusar o campo (legado: Return Empty(ThisForm.Get_Mat.Value)) -
655:         *-- por isso o funil tambem roda aqui (Fase 8/8).
656:         THIS.HabilitarCampos(.T.)
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * AbrirBuscaDMat - Lookup reverso de Material em SigCdPro por DPros.
661:     *==========================================================================
662:     PROTECTED PROCEDURE AbrirBuscaDMat()
663:         LOCAL loc_cValorAtual, loc_oBusca
664:         loc_cValorAtual = ALLTRIM(THIS.txt_4c_DMat.Value)
665: 
666:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
667:             gnConnHandle, ;
668:             "SigCdPro", ;
669:             "cursor_4c_BuscaMat", ;
670:             "DPros", ;
671:             loc_cValorAtual, ;
672:             "Sele" + CHR(231) + CHR(227) + "o", ;
673:             .F.)
674: 
675:         IF VARTYPE(loc_oBusca) = "O"
676:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
677:                 IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
678:                     THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
679:                     THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
680:                     THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
681:                 ENDIF
682:             ELSE
683:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
684:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
685:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
686:                     loc_oBusca.Show()
687: 
688:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
689:                         THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
690:                         THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
691:                         THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
692:                     ELSE
693:                         THIS.txt_4c_Mat.Value  = ""
694:                         THIS.txt_4c_DMat.Value = ""
695:                         THIS.this_cUltimoMatValidado = ""
696:                     ENDIF
697:                 ENDIF
698:             ENDIF
699:             loc_oBusca.Release()
700:         ENDIF
701: 
702:         IF USED("cursor_4c_BuscaMat")
703:             USE IN cursor_4c_BuscaMat
704:         ENDIF
705: 
706:         THIS.txt_4c_Mat.Refresh()
707:         THIS.txt_4c_DMat.Refresh()
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * ValidarGrupo / ValidarDGrupo - BINDEVENT de LostFocus em txt_4c_Grupo/
712:     * txt_4c__Dgrupo (legado: PROCEDURE Valid de Get_grupo/get_Dgrupo).
713:     * PUBLIC (alvo de BINDEVENT - regra #3).
714:     * Delegam para fAcessoContab() (utils\functions.prg), que faz sozinho o
715:     * lookup (SEEK em SigCdGcr + browse fwBuscaSimples quando necessario),
716:     * a checagem de acesso do usuario ao grupo contabil E preenche os DOIS
717:     * TextBox (pCod/pDsc) - padrao canonico do projeto (ver
718:     * Formsigrepes.prg ValidarGrpEstoque/ValidarDsGrpEstoque).
719:     *==========================================================================
720:     PROCEDURE ValidarGrupo()
721:         IF THIS.this_lEmLookup
722:             RETURN
723:         ENDIF
724:         THIS.this_lEmLookup = .T.
725:         THIS.ValidarGrupoExec()
726:         THIS.this_lEmLookup = .F.
727:     ENDPROC
728: 
729:     PROTECTED PROCEDURE ValidarGrupoExec()
730:         LOCAL loc_cValor
731:         loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
732: 
733:         IF loc_cValor == THIS.this_cUltimoGrupoValidado
734:             RETURN
735:         ENDIF
736: 
737:         IF EMPTY(loc_cValor)
738:             THIS.txt_4c__Dgrupo.Value = ""
739:             THIS.txt_4c__Dgrupo.Refresh()
740:         ELSE
741:             =fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
742:         ENDIF
743: 
744:         THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
745:         THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
746:     ENDPROC
747: 
748:     PROCEDURE ValidarDGrupo()
749:         IF THIS.this_lEmLookup
750:             RETURN
751:         ENDIF
752:         THIS.this_lEmLookup = .T.
753:         THIS.ValidarDGrupoExec()
754:         THIS.this_lEmLookup = .F.
755:     ENDPROC
756: 
757:     PROTECTED PROCEDURE ValidarDGrupoExec()
758:         LOCAL loc_cValor
759:         loc_cValor = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
760: 
761:         IF loc_cValor == THIS.this_cUltimoDGrupoValidado
762:             RETURN
763:         ENDIF
764: 
765:         IF EMPTY(loc_cValor)
766:             THIS.txt_4c_Grupo.Value = ""
767:             THIS.txt_4c_Grupo.Refresh()
768:         ELSE
769:             =fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
770:         ENDIF
771: 
772:         THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
773:         THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * ValidarConta / ValidarDConta - BINDEVENT de LostFocus em txt_4c_Conta/
778:     * txt_4c_Dconta (legado: PROCEDURE Valid de Get_conta/Get_dconta).
779:     * PUBLIC (alvo de BINDEVENT - regra #3).
780:     * NAO usa fAcessoContas() aqui (regra de memoria "facessocontas_lookup_
781:     * ux" - a funcao auto-popula com o 1o match parcial sem selecao
782:     * explicita do usuario). Em vez disso: SEEK no cursor_4c_Cli (ja
783:     * carregado por CarregarCursoresReferencia, filtrado GerBals = 1, igual
784:     * ao TmpCli do legado) e, sem match exato, abre o picker canonico.
785:     *==========================================================================
786:     PROCEDURE ValidarConta()
787:         IF THIS.this_lEmLookup
788:             RETURN
789:         ENDIF
790:         THIS.this_lEmLookup = .T.
791:         THIS.ValidarContaExec()
792:         THIS.this_lEmLookup = .F.
793:     ENDPROC
794: 
795:     PROTECTED PROCEDURE ValidarContaExec()
796:         LOCAL loc_cValor
797:         loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)
798: 
799:         IF loc_cValor == THIS.this_cUltimoContaValidado
800:             RETURN
801:         ENDIF
802: 
803:         IF EMPTY(loc_cValor)
804:             THIS.txt_4c_Dconta.Value = ""
805:             THIS.txt_4c_Dconta.Refresh()
806:         ELSE
807:             IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalCodigo")
808:                 THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
809:                 THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
810:             ELSE
811:                 THIS.AbrirBuscaConta("IClis", loc_cValor)
812:             ENDIF
813:             THIS.txt_4c_Conta.Refresh()
814:             THIS.txt_4c_Dconta.Refresh()
815:         ENDIF
816: 
817:         THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
818:         THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
819:     ENDPROC
820: 
821:     PROCEDURE ValidarDConta()
822:         IF THIS.this_lEmLookup
823:             RETURN
824:         ENDIF
825:         THIS.this_lEmLookup = .T.
826:         THIS.ValidarDContaExec()
827:         THIS.this_lEmLookup = .F.
828:     ENDPROC
829: 
830:     PROTECTED PROCEDURE ValidarDContaExec()
831:         LOCAL loc_cValor
832:         loc_cValor = ALLTRIM(THIS.txt_4c_Dconta.Value)
833: 
834:         IF loc_cValor == THIS.this_cUltimoDContaValidado
835:             RETURN
836:         ENDIF
837: 
838:         IF EMPTY(loc_cValor)
839:             THIS.txt_4c_Conta.Value = ""
840:             THIS.txt_4c_Conta.Refresh()
841:         ELSE
842:             IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalNome")
843:                 THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
844:                 THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
845:             ELSE
846:                 THIS.AbrirBuscaConta("RClis", loc_cValor)
847:             ENDIF
848:             THIS.txt_4c_Conta.Refresh()
849:             THIS.txt_4c_Dconta.Refresh()
850:         ENDIF
851: 
852:         THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
853:         THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * AbrirBuscaConta - Lookup de Conta/Funcionario em SigCdCli (IClis/
858:     * RClis), filtrado a GerBals = 1 (mesmo filtro de cursor_4c_Cli/TmpCli -
859:     * so contas habilitadas para balanco). par_cCampo indica o campo de
860:     * busca inicial ("IClis" ou "RClis" - chamado por ValidarConta/
861:     * ValidarDConta respectivamente).
862:     *==========================================================================
863:     PROTECTED PROCEDURE AbrirBuscaConta(par_cCampo, par_cValor)
864:         LOCAL loc_oBusca
865:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
866:             gnConnHandle, ;
867:             "SigCdCli", ;
868:             "cursor_4c_BuscaConta", ;
869:             par_cCampo, ;
870:             par_cValor, ;
871:             "Cadastro de Contas", ;
872:             .F., ;
873:             .F., ;
874:             "GerBals = 1")
875: 
876:         IF VARTYPE(loc_oBusca) = "O"
877:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
878:                 IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
879:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
880:                     THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
881:                 ENDIF
882:             ELSE
883:                 IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
884:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
885:                     loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
886:                     loc_oBusca.mAddColuna("Grupos", "", "Grupo")
887:                     loc_oBusca.Show()
888: 
889:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
890:                         THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
891:                         THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
892:                     ELSE
893:                         THIS.txt_4c_Conta.Value  = ""
894:                         THIS.txt_4c_Dconta.Value = ""
895:                     ENDIF
896:                 ELSE
897:                     THIS.txt_4c_Conta.Value  = ""
898:                     THIS.txt_4c_Dconta.Value = ""
899:                 ENDIF
900:             ENDIF
901:             loc_oBusca.Release()
902:         ENDIF
903: 
904:         IF USED("cursor_4c_BuscaConta")
905:             USE IN cursor_4c_BuscaConta

*-- Linhas 914 a 1143:
914:     * NUMERICO, regra #36: comparar com = 1, nunca atribuir direto a
915:     * property LOGICAL do BO).
916:     *==========================================================================
917:     *-- PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
918:     *-- FormParaBO, e em VFP9 a subclasse NAO alarga escopo herdado - escrever
919:     *-- "PROCEDURE FormParaBO" sem o modificador nao torna o metodo publico,
920:     *-- so esconde que ele continua protegido (medido: chamada de fora estoura
921:     *-- "Property FORMPARABO is not found", e PEMSTATUS(...,5) devolve .T.
922:     *-- porque so responde "existe?", nao "da para chamar daqui?").
923:     PROTECTED PROCEDURE FormParaBO()
924:         THIS.this_oBusinessObject.this_cMaterial     = ALLTRIM(THIS.txt_4c_Mat.Value)
925:         THIS.this_oBusinessObject.this_cDescMaterial = ALLTRIM(THIS.txt_4c_DMat.Value)
926:         THIS.this_oBusinessObject.this_cGrupo        = ALLTRIM(THIS.txt_4c_Grupo.Value)
927:         THIS.this_oBusinessObject.this_cDescGrupo    = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
928:         THIS.this_oBusinessObject.this_cConta        = ALLTRIM(THIS.txt_4c_Conta.Value)
929:         THIS.this_oBusinessObject.this_cDescConta    = ALLTRIM(THIS.txt_4c_Dconta.Value)
930:         THIS.this_oBusinessObject.this_lNaoMostrarSaldosZerados = (THIS.chk_4c_Chk_Saldo.Value = 1)
931:         THIS.this_oBusinessObject.this_lNaoChecarFalha          = (THIS.chk_4c_ChkFalha.Value = 1)
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * BOParaForm - Reciproco de FormParaBO (Fase 8/8): espelha os filtros e as
936:     * opcoes do Business Object de volta nos controles da tela. Usado por
937:     * LimparCampos(), depois de THIS.this_oBusinessObject.LimparDados() - o BO
938:     * eh a fonte do estado zerado e a tela passa a refleti-lo, em vez de cada
939:     * metodo repetir a lista de valores iniciais.
940:     *
941:     * CheckBox.Value eh NUMERICO (regra #36/CLAUDE.md): converter o LOGICAL do
942:     * BO com IIF(..., 1, 0), nunca atribuir o logico direto.
943:     *
944:     * PROTECTED obrigatorio, pelo mesmo motivo de FormParaBO: FormBase.prg
945:     * declara PROTECTED PROCEDURE BOParaForm e o escopo herdado nao se alarga.
946:     *==========================================================================
947:     PROTECTED PROCEDURE BOParaForm()
948:         LOCAL loc_oBO
949:         loc_oBO = THIS.this_oBusinessObject
950: 
951:         IF VARTYPE(loc_oBO) != "O"
952:             RETURN
953:         ENDIF
954: 
955:         THIS.txt_4c_Mat.Value       = loc_oBO.this_cMaterial
956:         THIS.txt_4c_DMat.Value      = loc_oBO.this_cDescMaterial
957:         THIS.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
958:         THIS.txt_4c__Dgrupo.Value   = loc_oBO.this_cDescGrupo
959:         THIS.txt_4c_Conta.Value     = loc_oBO.this_cConta
960:         THIS.txt_4c_Dconta.Value    = loc_oBO.this_cDescConta
961: 
962:         THIS.chk_4c_Chk_Saldo.Value = IIF(loc_oBO.this_lNaoMostrarSaldosZerados, 1, 0)
963:         THIS.chk_4c_ChkFalha.Value  = IIF(loc_oBO.this_lNaoChecarFalha, 1, 0)
964: 
965:         *-- Guardas de "valor ja validado" acompanham a tela: sem isto o
966:         *-- proximo LostFocus compararia o valor novo com o antigo e pularia
967:         *-- o lookup (regra #37).
968:         THIS.this_cUltimoMatValidado    = ALLTRIM(loc_oBO.this_cMaterial)
969:         THIS.this_cUltimoDMatValidado   = ALLTRIM(loc_oBO.this_cDescMaterial)
970:         THIS.this_cUltimoGrupoValidado  = ALLTRIM(loc_oBO.this_cGrupo)
971:         THIS.this_cUltimoDGrupoValidado = ALLTRIM(loc_oBO.this_cDescGrupo)
972:         THIS.this_cUltimoContaValidado  = ALLTRIM(loc_oBO.this_cConta)
973:         THIS.this_cUltimoDContaValidado = ALLTRIM(loc_oBO.this_cDescConta)
974: 
975:         THIS.txt_4c_Mat.Refresh()
976:         THIS.txt_4c_DMat.Refresh()
977:         THIS.txt_4c_Grupo.Refresh()
978:         THIS.txt_4c__Dgrupo.Refresh()
979:         THIS.txt_4c_Conta.Refresh()
980:         THIS.txt_4c_Dconta.Refresh()
981:     ENDPROC
982: 
983:     *==========================================================================
984:     * HabilitarCampos - Fonte UNICA do .Enabled dos campos de filtro
985:     * (Fase 8/8). Reproduz os PROCEDURE When do SCX legado, que sao o que
986:     * decide se o campo aceita entrada:
987:     *
988:     *   Get_DMat.When   -> Return Empty(ThisForm.Get_Mat.Value)
989:     *   Get_grupo.When  -> Return .t.
990:     *   Get_conta.When  -> Return .t.
991:     *   Get_dconta.When -> Return .y.   (.Y. eh .T. em VFP9)
992:     *   get_Dgrupo.When -> Return .y.
993:     *   Get_Mat / Chk_Saldo / chkFalha  -> sem When (sempre acessiveis)
994:     *
995:     * Ou seja: a busca reversa por descricao de material (txt_4c_DMat) so
996:     * esta disponivel enquanto o codigo (txt_4c_Mat) esta vazio - exatamente
997:     * como no legado, onde o When de Get_DMat recusa o foco depois que o
998:     * codigo foi preenchido. Por isso este metodo tem de ser chamado em TODO
999:     * caminho que altera txt_4c_Mat (os validadores e os lookups), nao so na
1000:     * inicializacao (regra #40: quem desabilita tem de reabilitar no funil).
1001:     *
1002:     * par_lHabilitar eh a chave mestra, usada por CmdProcessaClick para
1003:     * bloquear a digitacao enquanto o painel "Aguarde..." esta na tela.
1004:     * Omitido/invalido = .T.
1005:     *==========================================================================
1006:     PROCEDURE HabilitarCampos(par_lHabilitar)
1007:         LOCAL loc_lHabilitar
1008:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1009: 
1010:         THIS.txt_4c_Grupo.Enabled     = loc_lHabilitar
1011:         THIS.txt_4c__Dgrupo.Enabled   = loc_lHabilitar
1012:         THIS.txt_4c_Conta.Enabled     = loc_lHabilitar
1013:         THIS.txt_4c_Dconta.Enabled    = loc_lHabilitar
1014:         THIS.txt_4c_Mat.Enabled       = loc_lHabilitar
1015:         THIS.chk_4c_Chk_Saldo.Enabled = loc_lHabilitar
1016:         THIS.chk_4c_ChkFalha.Enabled  = loc_lHabilitar
1017: 
1018:         *-- When de Get_DMat: so enquanto o codigo do material esta vazio
1019:         THIS.txt_4c_DMat.Enabled = loc_lHabilitar AND EMPTY(ALLTRIM(THIS.txt_4c_Mat.Value))
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * AjustarBotoesPorModo - Fonte UNICA do estado da grade de resultado e dos
1024:     * dois botoes de emissao (Fase 8/8), governada por this_lResultadoValido:
1025:     *
1026:     *   legado, fim do Processa.Click (apurou saldo):
1027:     *       ThisForm.Grade.Visible = .t. / Visualizar.Enabled = .t. /
1028:     *       Imprimir.Enabled = .t. / Grade.Refresh
1029:     *   legado, Valid de Get_Mat (material trocado invalida o resultado):
1030:     *       ThisForm.Grade.Visible = .f. / Visualizar.Enabled = .f. /
1031:     *       Imprimir.Enabled = .f.
1032:     *   legado, Processa.Click com EOF ("Nenhum Saldo Selecionado!!!"):
1033:     *       Return ANTES das tres linhas - os botoes PERMANECEM desligados.
1034:     *
1035:     * Antes da Fase 8 essas atribuicoes estavam espalhadas em dois metodos; o
1036:     * caminho de EOF do processamento nao as derrubava e a tela ficava
1037:     * oferecendo Video/Impressora sobre um resultado que nao veio.
1038:     *
1039:     * PUBLIC (sem PROTECTED): alvo dos harness de verificacao e de
1040:     * TesteAutomatico.prg, que chamam THIS.oForm.AjustarBotoesPorModo() de
1041:     * fora da classe (regra #3).
1042:     *==========================================================================
1043:     PROCEDURE AjustarBotoesPorModo()
1044:         THIS.grd_4c_Dados.Visible      = THIS.this_lResultadoValido
1045:         THIS.cmd_4c_Visualizar.Enabled = THIS.this_lResultadoValido
1046:         THIS.cmd_4c_Imprimir.Enabled   = THIS.this_lResultadoValido
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     * LimparCampos - Estado inicial consolidado (Fase 8/8): zera o BO
1051:     * (LimparDados), espelha o BO na tela (BOParaForm), descarta o resultado
1052:     * apurado e repoe o .Enabled dos campos e o estado dos botoes.
1053:     *
1054:     * Chamado por InicializarForm() para que o estado de abertura da tela
1055:     * tenha UMA origem, em vez de ficar implicito nos .Value = "" espalhados
1056:     * pelo ConfigurarFiltros.
1057:     *
1058:     * PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
1059:     * LimparCampos (ver nota em FormParaBO).
1060:     *
1061:     * O ZAP eh seguro aqui: cursor_4c_Saldo nasce de CREATE CURSOR, logo com
1062:     * Buffering = 1 (regra #52), e o Form nao declara DataSession = 2.
1063:     *
1064:     * this_lResultadoValido volta a .T. de proposito - e NAO a .F.: o SCX
1065:     * legado nao declara Grade.Visible nem Visualizar/Imprimir.Enabled, logo
1066:     * a tela ABRE com a grade (vazia) visivel e os dois botoes habilitados, e
1067:     * quem clicar em Video/Impressora antes de processar recebe o aviso
1068:     * "Nenhuma Informacao Selecionada!!!" do proprio metodo de emissao.
1069:     * Derrubar os botoes aqui seria desvio do PILAR 1.
1070:     *==========================================================================
1071:     PROTECTED PROCEDURE LimparCampos()
1072:         LOCAL loc_oErro
1073:         TRY
1074:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1075:                 THIS.this_oBusinessObject.LimparDados()
1076:                 THIS.BOParaForm()
1077:             ENDIF
1078: 
1079:             IF USED("cursor_4c_Saldo")
1080:                 SELECT cursor_4c_Saldo
1081:                 ZAP
1082:             ENDIF
1083: 
1084:             THIS.this_lResultadoValido = .T.
1085:             THIS.AjustarBotoesPorModo()
1086:             THIS.HabilitarCampos(.T.)
1087:             THIS.CarregarDados()
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + CHR(13) + ;
1090:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1091:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1092:         ENDTRY
1093:     ENDPROC
1094: 
1095:     *==========================================================================
1096:     * ConfigurarCabecalho - Cria cnt_4c_Sombra com labels de titulo
1097:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80 (BackColor=100,100,100)
1098:     * Novo: Top=0, Width=THIS.Width (1000, regra #11 - nunca subtrair largura)
1099:     * Largura dos labels reduzida (THIS.Width - 370) para abrir espaco aos
1100:     * botoes de acao (Processar/Video/Impressora/Encerrar) da Fase 4, que
1101:     * ficam sobre o canto direito do proprio cnt_4c_Sombra.
1102:     *==========================================================================
1103:     PROTECTED PROCEDURE ConfigurarCabecalho()
1104:         LOCAL loc_oErro
1105:         TRY
1106:             THIS.AddObject("cnt_4c_Sombra", "Container")
1107:             WITH THIS.cnt_4c_Sombra
1108:                 .Top         = 0
1109:                 .Left        = 0
1110:                 .Width       = THIS.Width
1111:                 .Height      = 80
1112:                 .BackStyle   = 1
1113:                 .BackColor   = RGB(100, 100, 100)
1114:                 .BorderWidth = 0
1115:                 .Visible     = .T.
1116:             ENDWITH
1117: 
1118:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
1119:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
1120:                 .FontBold      = .T.
1121:                 .FontName      = "Tahoma"
1122:                 .FontSize      = 16
1123:                 .FontUnderline = .F.
1124:                 .WordWrap      = .T.
1125:                 .Alignment     = 0
1126:                 .BackStyle     = 0
1127:                 .AutoSize      = .F.
1128:                 .Caption       = THIS.Caption
1129:                 .Height        = 40
1130:                 .Left          = 10
1131:                 .Top           = 15
1132:                 .Width         = THIS.Width - 370
1133:                 .ForeColor     = RGB(0, 0, 0)
1134:                 .Visible       = .T.
1135:             ENDWITH
1136: 
1137:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
1138:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
1139:                 .FontBold      = .T.
1140:                 .FontName      = "Tahoma"
1141:                 .FontSize      = 16
1142:                 .FontUnderline = .F.
1143:                 .WordWrap      = .T.

*-- Linhas 1156 a 1268:
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message + CHR(13) + ;
1158:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1159:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *==========================================================================
1164:     * ConfigurarGrade - Cria grd_4c_Dados (equivalente a Grade do legado) e
1165:     * o cursor placeholder cursor_4c_Saldo (equivalente a TmpSaldo, criado no
1166:     * Load do legado: Codigo c(10), Nome c(50), Fase c(10), Saldo n(12,3),
1167:     * Data d). O resultado real so eh populado quando Processar (Fase 7/8)
1168:     * roda; aqui a grade nasce vazia mas com a estrutura final.
1169:     * Posicao/propriedades EXATAS do dump: Top=230, Left=119, Width=561,
1170:     * Height=326 (nao escala com o form - a area de dados nao precisou
1171:     * crescer, so o cabecalho/botoes usam a largura nova de 1000px).
1172:     *==========================================================================
1173:     PROTECTED PROCEDURE ConfigurarGrade()
1174:         LOCAL loc_oErro
1175:         TRY
1176:             IF !USED("cursor_4c_Saldo")
1177:                 SET NULL ON
1178:                 CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
1179:                                                 Saldo N(12,3), Data D)
1180:                 SET NULL OFF
1181:                 INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
1182:                 INDEX ON Codigo + Fase TAG Codigo
1183:                 INDEX ON Fase + Codigo TAG Carrega
1184:             ENDIF
1185: 
1186:             THIS.AddObject("grd_4c_Dados", "Grid")
1187:             WITH THIS.grd_4c_Dados
1188:                 .Top               = 230
1189:                 .Left              = 119
1190:                 .Width             = 561
1191:                 .Height            = 326
1192:                 .FontName          = "Tahoma"
1193:                 .FontSize          = 8
1194:                 .AllowHeaderSizing = .F.
1195:                 .AllowRowSizing    = .F.
1196:                 .DeleteMark        = .F.
1197:                 .RecordMark        = .F.
1198:                 .ScrollBars        = 2
1199:                 .RowHeight         = 17
1200:                 .GridLineColor     = RGB(238, 238, 238)
1201:                 .ReadOnly          = .T.
1202:                 .ColumnCount       = 5
1203:                 .Visible           = .T.
1204:             ENDWITH
1205: 
1206:             THIS.CarregarDados()
1207:         CATCH TO loc_oErro
1208:             MsgErro(loc_oErro.Message + CHR(13) + ;
1209:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1210:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
1211:         ENDTRY
1212:     ENDPROC
1213: 
1214:     *==========================================================================
1215:     * CarregarDados - Vincula/revincula grd_4c_Dados a cursor_4c_Saldo.
1216:     * Este eh o metodo Carregar* que alimenta a grade neste form (nao ha
1217:     * "CarregarLista": a lista do SIGOPCFE nao eh uma listagem CRUD
1218:     * independente, eh o RESULTADO do processamento disparado pelos campos de
1219:     * filtro - ver nota de Fase 8/8 no cabecalho do arquivo). PUBLIC para ser
1220:     * alcancavel por LimparCampos() e pelos harness de verificacao.
1221:     * Column.Width/Header1 sao redefinidos DEPOIS do ControlSource (Problema
1222:     * 48 CLAUDE.md: RecordSource reseta Width para 90 e Header1.Caption para
1223:     * "Header1"). Chamado agora (grade vazia) e sera chamado de novo quando
1224:     * Processar (fase futura) repopular cursor_4c_Saldo - por isso tambem
1225:     * fecha com GO TOP + Refresh (regra #21: popular cursor nao repinta a
1226:     * grade por si so).
1227:     *==========================================================================
1228:     PROCEDURE CarregarDados()
1229:         LOCAL loc_oErro, loc_oGrid
1230:         TRY
1231:             IF !USED("cursor_4c_Saldo")
1232:                 SET NULL ON
1233:                 CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
1234:                                                 Saldo N(12,3), Data D)
1235:                 SET NULL OFF
1236:                 INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
1237:                 INDEX ON Codigo + Fase TAG Codigo
1238:                 INDEX ON Fase + Codigo TAG Carrega
1239:             ENDIF
1240: 
1241:             loc_oGrid = THIS.grd_4c_Dados
1242:             loc_oGrid.RecordSource = ""
1243:             loc_oGrid.RecordSource = "cursor_4c_Saldo"
1244: 
1245:             loc_oGrid.Column1.ControlSource = "cursor_4c_Saldo.Codigo"
1246:             loc_oGrid.Column2.ControlSource = "cursor_4c_Saldo.Nome"
1247:             loc_oGrid.Column3.ControlSource = "cursor_4c_Saldo.Fase"
1248:             loc_oGrid.Column4.ControlSource = "cursor_4c_Saldo.Saldo"
1249:             loc_oGrid.Column5.ControlSource = "cursor_4c_Saldo.Data"
1250: 
1251:             WITH loc_oGrid.Column1
1252:                 .FontName  = "Tahoma"
1253:                 .FontSize  = 8
1254:                 .Width     = 80
1255:                 .Movable   = .F.
1256:                 .Resizable = .F.
1257:                 .ReadOnly  = .T.
1258:                 .Header1.Caption   = "Funcion" + CHR(225) + "rio"
1259:                 .Header1.Alignment = 2
1260:                 .Header1.FontName  = "Tahoma"
1261:                 .Header1.FontSize  = 8
1262:                 .Header1.ForeColor = RGB(0, 0, 0)
1263:                 .Text1.BorderStyle = 0
1264:                 .Text1.Margin      = 0
1265:                 .Text1.ReadOnly    = .T.
1266:                 .Text1.ForeColor   = RGB(0, 0, 0)
1267:                 .Text1.BackColor   = RGB(255, 255, 255)
1268:                 .Text1.FontName    = "Tahoma"

*-- Linhas 1359 a 1677:
1359:         CATCH TO loc_oErro
1360:             MsgErro(loc_oErro.Message + CHR(13) + ;
1361:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1362:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1363:         ENDTRY
1364:     ENDPROC
1365: 
1366:     *==========================================================================
1367:     * ConfigurarBotoes - Cria os 4 botoes de acao reais do SIGOPCFE.SCX
1368:     * (Processar/Video/Impressora/Encerrar - este form OPERACIONAL nao tem
1369:     * CRUD Incluir/Alterar/Excluir). Standalone CommandButton com Picture
1370:     * usa Themes=.T. + DisabledPicture (nao o Themes=.F. literal do SCX) -
1371:     * Visualizar/Imprimir sao Enabled/Disabled durante o processamento
1372:     * (legado: ThisForm.Visualizar.Enabled / ThisForm.Imprimir.Enabled) e
1373:     * sem isso o icone desaparece quando Enabled=.F.
1374:     * Posicoes: Top=3/Width=75/Height=75 iguais ao legado; Left deslocado
1375:     * para a direita (mesma ordem/espacamento contiguo de 75px do SCX) para
1376:     * ocupar a largura nova do form (1000 contra 800 do legado), sobre o
1377:     * canto direito do cnt_4c_Sombra (criado antes, logo os botoes
1378:     * desenham por cima).
1379:     *==========================================================================
1380:     PROTECTED PROCEDURE ConfigurarBotoes()
1381:         LOCAL loc_oErro
1382:         TRY
1383:             THIS.AddObject("cmd_4c_Processa", "CommandButton")
1384:             WITH THIS.cmd_4c_Processa
1385:                 .Top             = 3
1386:                 .Left            = 690
1387:                 .Width           = 75
1388:                 .Height          = 75
1389:                 .FontBold        = .T.
1390:                 .FontItalic      = .T.
1391:                 .FontName        = "Comic Sans MS"
1392:                 .FontSize        = 8
1393:                 .FontExtend      = .F.
1394:                 .WordWrap        = .T.
1395:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1396:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1397:                 .Caption         = "Processar"
1398:                 .PicturePosition = 13
1399:                 .ForeColor       = RGB(90, 90, 90)
1400:                 .BackColor       = RGB(255, 255, 255)
1401:                 .Themes          = .T.
1402:                 .Cancel          = .F.
1403:                 .Visible         = .T.
1404:             ENDWITH
1405:             BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "CmdProcessaClick")
1406: 
1407:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
1408:             WITH THIS.cmd_4c_Imprimir
1409:                 .Top             = 3
1410:                 .Left            = 765
1411:                 .Width           = 75
1412:                 .Height          = 75
1413:                 .FontBold        = .T.
1414:                 .FontItalic      = .T.
1415:                 .FontName        = "Comic Sans MS"
1416:                 .FontSize        = 8
1417:                 .FontExtend      = .F.
1418:                 .WordWrap        = .F.
1419:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1420:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1421:                 .Caption         = "Impressora"
1422:                 .PicturePosition = 13
1423:                 .ForeColor       = RGB(90, 90, 90)
1424:                 .BackColor       = RGB(255, 255, 255)
1425:                 .Themes          = .T.
1426:                 .Cancel          = .F.
1427:                 .Visible         = .T.
1428:             ENDWITH
1429:             BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")
1430: 
1431:             THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
1432:             WITH THIS.cmd_4c_Visualizar
1433:                 .Top             = 3
1434:                 .Left            = 840
1435:                 .Width           = 75
1436:                 .Height          = 75
1437:                 .FontBold        = .T.
1438:                 .FontItalic      = .T.
1439:                 .FontName        = "Comic Sans MS"
1440:                 .FontSize        = 8
1441:                 .FontExtend      = .F.
1442:                 .WordWrap        = .F.
1443:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
1444:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
1445:                 .Caption         = "V" + CHR(237) + "deo"
1446:                 .PicturePosition = 13
1447:                 .ForeColor       = RGB(90, 90, 90)
1448:                 .BackColor       = RGB(255, 255, 255)
1449:                 .Themes          = .T.
1450:                 .Cancel          = .F.
1451:                 .Visible         = .T.
1452:             ENDWITH
1453:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "CmdVisualizarClick")
1454: 
1455:             THIS.AddObject("cmd_4c_Saida", "CommandButton")
1456:             WITH THIS.cmd_4c_Saida
1457:                 .Top             = 3
1458:                 .Left            = 915
1459:                 .Width           = 75
1460:                 .Height          = 75
1461:                 .FontBold        = .T.
1462:                 .FontItalic      = .T.
1463:                 .FontName        = "Comic Sans MS"
1464:                 .FontSize        = 8
1465:                 .FontExtend      = .F.
1466:                 .WordWrap        = .T.
1467:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1468:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1469:                 .Caption         = "Encerrar"
1470:                 .PicturePosition = 13
1471:                 .ForeColor       = RGB(90, 90, 90)
1472:                 .BackColor       = RGB(255, 255, 255)
1473:                 .Themes          = .T.
1474:                 .Cancel          = .T.
1475:                 .Visible         = .T.
1476:             ENDWITH
1477:             BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "CmdSaidaClick")
1478:         CATCH TO loc_oErro
1479:             MsgErro(loc_oErro.Message + CHR(13) + ;
1480:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1481:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
1482:         ENDTRY
1483:     ENDPROC
1484: 
1485:     *==========================================================================
1486:     * CmdSaidaClick - Encerra o form (legado: PROCEDURE Saida.Click = 1
1487:     * linha, "Thisform.Release"). PUBLIC (sem PROTECTED) - alvo de BINDEVENT.
1488:     *==========================================================================
1489:     PROCEDURE CmdSaidaClick()
1490:         THIS.Release()
1491:     ENDPROC
1492: 
1493:     *==========================================================================
1494:     * CmdProcessaClick - Dispara o processamento de saldos (Fase 7/8).
1495:     * Guarda transcrita literalmente do inicio do Processa.Click do legado
1496:     * (If Empty(ThisForm.Get_Mat.Value) / Messagebox('O Produto Deve Ser
1497:     * Informado!!!') / ThisForm.Get_Mat.SetFocus / Return 0); o restante do
1498:     * algoritmo (apuracao de saldo cruzando SigCdPro/SigCdCli/SigMvEst/
1499:     * SigCdNec/SigMvCab/SigCdPsc, ~900 linhas no legado) fica no BO -
1500:     * THIS.this_oBusinessObject.ProcessarSaldos() - que ja recebe os
1501:     * filtros via FormParaBO().
1502:     *
1503:     * O container "Aguarde..." (cnt_4c_Mensagem, Fase 6) replica o
1504:     * CntMensagem.Visible = .t./.f. que envolve a primeira consulta
1505:     * (crSigMvEst) do legado; o restante do processamento (varios
1506:     * fwprogressbar) fica no BO.
1507:     *==========================================================================
1508:     PROCEDURE CmdProcessaClick()
1509:         LOCAL loc_lSucesso, loc_oErro
1510: 
1511:         THIS.FormParaBO()
1512: 
1513:         IF EMPTY(THIS.this_oBusinessObject.this_cMaterial)
1514:             MsgAviso("O Produto Deve Ser Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1515:             THIS.txt_4c_Mat.SetFocus()
1516:             RETURN
1517:         ENDIF
1518: 
1519:         loc_lSucesso = .F.
1520: 
1521:         THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..."
1522:         THIS.cnt_4c_Mensagem.Top     = 112
1523:         THIS.cnt_4c_Mensagem.Visible = .T.
1524:         THIS.HabilitarCampos(.F.)
1525:         THIS.Refresh()
1526: 
1527:         *-- TRY/CATCH so em volta do processamento (Fase 8/8): ProcessarSaldos
1528:         *-- devolve .F. nos caminhos previstos, mas uma falha inesperada
1529:         *-- (fwprogressbar, SQLEXEC) nao pode deixar a tela com o painel
1530:         *-- "Aguarde..." no ar e os campos desabilitados para sempre - o
1531:         *-- restabelecimento abaixo roda em qualquer saida. Sem RETURN dentro
1532:         *-- do bloco (regra #1).
1533:         TRY
1534:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarSaldos()
1535:         CATCH TO loc_oErro
1536:             loc_lSucesso = .F.
1537:             MsgErro(loc_oErro.Message + CHR(13) + ;
1538:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1539:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdProcessaClick")
1540:         ENDTRY
1541: 
1542:         THIS.cnt_4c_Mensagem.Visible = .F.
1543:         THIS.HabilitarCampos(.T.)
1544: 
1545:         *-- Grade/Video/Impressora pelo funil unico: no legado as tres linhas
1546:         *-- que os religam ficam DEPOIS do "Return" do caminho de EOF, ou
1547:         *-- seja, resultado vazio mantem tudo desligado (Fase 8/8).
1548:         THIS.this_lResultadoValido = loc_lSucesso
1549:         THIS.AjustarBotoesPorModo()
1550: 
1551:         IF loc_lSucesso
1552:             THIS.CarregarDados()
1553:         ELSE
1554:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1555:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
1556:             ENDIF
1557:         ENDIF
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * CmdVisualizarClick / CmdImprimirClick - Video e Impressora (legado:
1562:     * Visualizar.Click chama Impressao('V'), Imprimir.Click chama
1563:     * Impressao('I')). Delegam para o metodo Imprimir(), que por sua vez
1564:     * delega ao BO (THIS.this_oBusinessObject.ExibirRelatorio) - que monta
1565:     * TmpCabec e dispara o SigOpCfe.frx via ExecutarReportForm.
1566:     *==========================================================================
1567:     PROCEDURE CmdVisualizarClick()
1568:         THIS.Imprimir("V")
1569:     ENDPROC
1570: 
1571:     PROCEDURE CmdImprimirClick()
1572:         THIS.Imprimir("I")
1573:     ENDPROC
1574: 
1575:     PROTECTED PROCEDURE Imprimir(par_cSaida)
1576:         LOCAL loc_lSucesso
1577: 
1578:         *-- FormParaBO ANTES de emitir (Fase 8/8): o subtitulo do SigOpCfe.frx
1579:         *-- eh montado pelo BO a partir de this_cMaterial/this_cDescMaterial,
1580:         *-- e o legado le os DOIS campos direto da TELA no momento da emissao
1581:         *-- ('Material : ' + Alltrim(This.Get_Mat.Value) + ' - ' +
1582:         *-- Alltrim(This.Get_DMat.Value)). Sem esta linha, trocar o material
1583:         *-- depois de processar imprimia o cabecalho com o material ANTERIOR.
1584:         THIS.FormParaBO()
1585: 
1586:         loc_lSucesso = THIS.this_oBusinessObject.ExibirRelatorio(par_cSaida)
1587: 
1588:         IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1589:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
1590:         ENDIF
1591:     ENDPROC
1592: 
1593:     *==========================================================================
1594:     * TornarControlesVisiveis - Torna os controles visiveis recursivamente
1595:     * EXCECOES: cnt_4c_Mensagem (equivalente ao CntMensagem do legado, que
1596:     * nasce com Visible=.F. e so e exibido durante o processamento/Aguarde) e
1597:     * cnt_4c_Sombra (cabecalho - sempre visivel, mas nao deve ser forcado por
1598:     * este metodo generico) - os containers em si NAO sao forcados a
1599:     * Visible=.T. aqui, mas os filhos deles sao preparados recursivamente
1600:     * para que aparecam corretamente quando exibidos.
1601:     *==========================================================================
1602:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1603:         LOCAL loc_nI, loc_oControl, loc_nP
1604: 
1605:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1606:             loc_oControl = par_oContainer.Controls(loc_nI)
1607: 
1608:             IF VARTYPE(loc_oControl) = "O"
1609:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_MENSAGEM", "CNT_4C_SOMBRA")
1610:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1611:                         THIS.TornarControlesVisiveis(loc_oControl)
1612:                     ENDIF
1613:                     LOOP
1614:                 ENDIF
1615: 
1616:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1617:                     loc_oControl.Visible = .T.
1618:                 ENDIF
1619: 
1620:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1621:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1622:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1623:                     ENDFOR
1624:                 ENDIF
1625: 
1626:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1627:                     THIS.TornarControlesVisiveis(loc_oControl)
1628:                 ENDIF
1629:             ENDIF
1630:         ENDFOR
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * Destroy - Fecha cursores de referencia e restaura o menu do sistema
1635:     * (DODEFAULT() ao final - FormBase.Destroy() faz o fix do menu encolhido)
1636:     *==========================================================================
1637:     PROCEDURE Destroy()
1638:         LOCAL loc_aCursores[31], loc_nI
1639: 
1640:         loc_aCursores[1]  = "cursor_4c_Pam"
1641:         loc_aCursores[2]  = "cursor_4c_Pac"
1642:         loc_aCursores[3]  = "cursor_4c_OpOpt"
1643:         loc_aCursores[4]  = "cursor_4c_Ope"
1644:         loc_aCursores[5]  = "cursor_4c_Opd"
1645:         loc_aCursores[6]  = "cursor_4c_Gcr"
1646:         loc_aCursores[7]  = "cursor_4c_Pro"
1647:         loc_aCursores[8]  = "cursor_4c_Cli"
1648:         loc_aCursores[9]  = "cursor_4c_Gccr"
1649:         loc_aCursores[10] = "cursor_4c_Saldo"
1650:         *-- Cursores de trabalho do processamento (Fase 7/8 - ProcessarSaldos)
1651:         loc_aCursores[11] = "cursor_4c_Resumo"
1652:         loc_aCursores[12] = "cursor_4c_Opera"
1653:         loc_aCursores[13] = "cursor_4c_MvEst"
1654:         loc_aCursores[14] = "cursor_4c_CliDet"
1655:         loc_aCursores[15] = "cursor_4c_Fcx"
1656:         loc_aCursores[16] = "cursor_4c_Nens"
1657:         loc_aCursores[17] = "cursor_4c_NensI"
1658:         loc_aCursores[18] = "cursor_4c_Opi"
1659:         loc_aCursores[19] = "cursor_4c_Gru"
1660:         loc_aCursores[20] = "cursor_4c_Ggrp"
1661:         loc_aCursores[21] = "cursor_4c_Eest"
1662:         loc_aCursores[22] = "cursor_4c_EestI"
1663:         loc_aCursores[23] = "cursor_4c_Esti2"
1664:         loc_aCursores[24] = "cursor_4c_Pesa"
1665:         loc_aCursores[25] = "cursor_4c_PesaI"
1666:         loc_aCursores[26] = "cursor_4c_Uni"
1667:         loc_aCursores[27] = "cursor_4c_UltBal"
1668:         loc_aCursores[28] = "cursor_4c_SaldoI"
1669:         loc_aCursores[29] = "cursor_4c_Total"
1670:         loc_aCursores[30] = "cursor_4c_Empresa"
1671:         loc_aCursores[31] = "TmpCabec"
1672: 
1673:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
1674:             IF USED(loc_aCursores[loc_nI])
1675:                 USE IN (loc_aCursores[loc_nI])
1676:             ENDIF
1677:         ENDFOR


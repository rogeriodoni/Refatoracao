# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPBOL.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (692 linhas total):

*-- Linhas 12 a 335:
12: * (compartilhar a datasession do chamador). As demais propriedades do dialogo
13: * (vcTitEnvelope/vcEmp/vcDope/vnNum/vnDev/vnVias/vnQBols) NAO chegam via
14: * LPARAMETERS - nascem com default .F. no SCX e sao atribuidas pelo form
15: * chamador DIRETO (ThisForm.vcEmp = ..., etc.) depois do CREATEOBJECT e antes
16: * do Show(), padrao classico de "dialogo com propriedades publicas".
17: *
18: * Nesta migracao, poForm NAO eh reproduzido: seu unico uso no legado era
19: * herdar a DataSession do chamador para dar ao Cmd_Imprimir.Click acesso ao
20: * cursor pCursor por alias compartilhado (uso que, alias, esta COMENTADO no
21: * proprio Click legado - *!* Select (lcCursor) / *!* Replace cImps With
22: * lcImp - o codigo ATIVO so LE as propriedades e repassa para SigBlBol). O
23: * nome do cursor/tabela a imprimir (pCursor) continua chegando como STRING,
24: * exatamente como no legado - no eh preciso herdar DataSession para isso.
25: *
26: * Historico de fases:
27: *   Fase 1/2: SIGOPBOLBO.prg (propriedades + metodos de negocio:
28: *             DefinirTipoBoleto, ObterTituloPorTipoBoleto,
29: *             CarregarImpressorasConfiguradas, ObterImpressorasDisponiveis,
30: *             ExecutarImpressao). BO somente-leitura (nao sobrescreve
31: *             Inserir/Atualizar/ExecutarExclusao - nao ha tabela propria).
32: *   Fase 3:   FormSIGOPBOL.prg - estrutura base (Init, InicializarForm,
33: *             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
34: *             lbl_4c_LblTitulo, Destroy). Form FLAT: o legado nao tem
35: *             PageFrame nem Page nenhuma - nenhum pgf_4c_* eh criado neste
36: *             form. Opt_Impressora/Lbl_Impressora/Lbl_Erro/btnReport ficam
37: *             para as proximas fases (sao campos/eventos, nao estrutura).
38: *   Fase 4:   ConfigurarControles() (Opt_Impressora/Lbl_Impressora/Lbl_Erro/
39: *             btnReport), AplicarVisibilidadeImpressoras(), AjustarAlturaForm()
40: *             e CmdImprimirClick(). ATENCAO: o template generico de Fase 4
41: *             do orquestrador ("Grid e botoes CRUD na Page1") NAO se aplica
42: *             a este form - SIGOPBOL eh um dialogo FLAT de selecao de
43: *             impressora (ver SIGOPBOL_form_codigo_fonte.txt): nao ha Page1,
44: *             nao ha grid, nao ha Incluir/Alterar/Excluir/Buscar no legado.
45: *             Fabricar esses botoes violaria o PILAR 1 (inventar UX que o
46: *             legado nao tem). Esta fase, em vez disso, completa os
47: *             controles REAIS que faltavam (Opt_Impressora/Lbl_Erro/
48: *             btnReport) e a logica de negocio do PROCEDURE Init/
49: *             Cmd_Imprimir.Click legados, usando os metodos do BO criados
50: *             nas Fases 1/2 (CarregarImpressorasConfiguradas,
51: *             ObterImpressorasDisponiveis, ExecutarImpressao).
52: *   Fase 5:   NAO ha "Page2 - campos" a adicionar neste form. O inventario do
53: *             SCX legado tem 8 objetos (SIGOPBOL, Opt_Impressora,
54: *             Lbl_Impressora, Lbl_Erro, cntSombra, lblSombra, lblTitulo,
55: *             btnReport) e os 8 ja existem - o form eh FLAT, sem PageFrame,
56: *             sem Page2 e sem nenhum campo de dados a migrar. Fabricar um
57: *             ConfigurarPaginaDados()/Page2 violaria o PILAR 1 (inventar UX
58: *             que o legado nao tem). Esta fase, em vez disso, AUDITOU o que
59: *             as fases anteriores perderam ou inventaram, propriedade a
60: *             propriedade, contra o dump do SCX:
61: *               (a) TabIndex NUNCA transcrito. O SCX declara Lbl_Impressora=1,
62: *                   Opt_Impressora=2, Option1=1, Lbl_Erro=1, btnReport=4.
63: *                   Transcritos SO onde o valor gruda e significa algo: os
64: *                   dois controles FOCALIZAVEIS (Opt_Impressora=2,
65: *                   obj_4c_BtnReport=4) e Option1=1 dentro do grupo.
66: *                   HONESTIDADE SOBRE O GANHO: isto eh fidelidade ao dump, NAO
67: *                   conserto de comportamento. Medido no VFP9 (2026-10-17), a
68: *                   navegacao por Tab eh IDENTICA com e sem a transcricao,
69: *                   porque os unicos dois tab-stops do form sao Opt_Impressora
70: *                   e btnReport e em ambos os casos Opt vem antes (2<4 na
71: *                   transcricao, 4<5 na ordem de criacao da fase 4).
72: *               (b) Option1.Style = 0 nao transcrito.
73: *               (c) Closable/MaxButton/MinButton = .F. INVENTADOS pela fase
74: *                   anterior (o SCX nao os declara) - removidos, ver o bloco
75: *                   de propriedades visuais. Medido no VFP9.
76: *               (d) lblSombra/lblTitulo com o Caption literal "Cadastro de
77: *                   Testes" -> THIS.Caption (regra #11).
78: *             Conferido e CORRETO (nao mexer): Load legado (=fConfigGeral())
79: *             nao portado de proposito - utils/fconfiggeral.prg eh um no-op
80: *             documentado que existe SO para o p-code dos VCX legado, e o
81: *             proprio arquivo determina que codigo NOSSO nunca o chame (o que
82: *             fConfigGeral fazia ja acontece em config.prg/main.prg);
83: *             Lbl_Erro tem WordWrap = .T. e NAO tem AutoSize, que eh
84: *             exatamente o exigido pela regra #23; .Picture dos dois sites
85: *             aponta para arquivo existente (regra #25).
86: *   Fase 6:   NAO ha "campos restantes" nem "lookups" a acrescentar neste
87: *             form. Os 8 objetos do inventario do SCX legado (SIGOPBOL,
88: *             Opt_Impressora, Lbl_Impressora, Lbl_Erro, cntSombra,
89: *             lblSombra, lblTitulo, btnReport) ja foram TODOS migrados nas
90: *             Fases 3/4/5 (ConfigurarPageFrame + ConfigurarControles), com
91: *             BINDEVENT do unico botao (CmdImprimirClick) ja ligado. Nao ha
92: *             campo de dados a migrar (o form nao tem Page2/area de dados -
93: *             eh um dialogo FLAT) e nao ha NENHUM lookup no legado: a busca
94: *             em SIGOPBOL_form_codigo_fonte.txt por "fwbuscaext", "fwBuscaSel",
95: *             "sigacess(" e "CreateObject(" nao retorna NENHUMA ocorrencia
96: *             (confirmado em 2026-10-17) - o unico CreateObject do form eh o
97: *             que o PROPRIO form chamador faz para instanciar este dialogo
98: *             (CREATEOBJECT("FormSIGOPBOL", ...)), nao um lookup interno.
99: *             Fabricar um campo ou lookup aqui violaria o PILAR 1 (inventar
100: *             UX que o legado nao tem) e a regra de nao criar stub
101: *             disfarcado. Mesma familia do Erro178 (form OPERACIONAL cujo
102: *             legado nao tem "campos soltos" nem lookup para a Fase 6).
103: *   Fase 7:   NAO ha BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
104: *             BtnExcluirClick a adicionar neste form. O template generico da
105: *             Fase 7 ("eventos principais dos botoes CRUD") pressupoe um
106: *             frmcadastro com barra Incluir/Alterar/Visualizar/Excluir, que
107: *             este legado NAO tem (ver Fase 4): SIGOPBOL eh um dialogo de
108: *             selecao de impressora com UM UNICO botao
109: *             (btnReport/Cmd_Imprimir, CommandGroup com ButtonCount=1 no
110: *             dump - layout.json), ja migrado como CmdImprimirClick() na
111: *             Fase 4 (linha ~560), com o codigo ativo do Cmd_Imprimir.Click
112: *             legado transcrito (grava this_cImpressoraSelecionada +
113: *             propriedades publicas no BO + ExecutarImpressao() + Release).
114: *             Inventar os 4 nomes CRUD fabricaria UX que o legado nao tem
115: *             (PILAR 1) e, pior, criaria metodo SEM contrapartida no SCX -
116: *             stub disfarcado proibido. A superficie de botao que o dump
117: *             PROVA existir (1 CommandGroup com ButtonCount=1; o
118: *             Opt_Impressora eh OptionGroup/radio, nao conta como botao de
119: *             acao) ja tem handler correspondente nomeado pelo prefixo
120: *             canonico Cmd*Click - mesma familia do Erro178/SIGMVCTH
121: *             (visualizador de um botao so) e de Formsigprdft (handler
122: *             renomeado para o prefixo Cmd/Btn, nao para o nome do objeto
123: *             legado).
124: *   Fase 8:   NAO ha BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
125: *             BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
126: *             LimparCampos/CarregarLista/AjustarBotoesPorModo a adicionar
127: *             neste form. O template generico de Fase 8 ("consolidacao final
128: *             de form CRUD") pressupoe Page1=Lista/Page2=Dados com registro
129: *             proprio para salvar/cancelar/buscar - este dialogo FLAT (ver
130: *             Fases 3/4/6/7) nao tem nenhum dos dois, nao edita registro
131: *             algum (BO somente-leitura, sem tabela propria - ver cabecalho
132: *             de SIGOPBOLBO.prg) e o UNICO botao (Encerrar/Cmd_Imprimir) ja
133: *             foi migrado como CmdImprimirClick() na Fase 4: ele sozinho le
134: *             Opt_Impressora.Value, sincroniza as 7 propriedades publicas no
135: *             BO, chama ExecutarImpressao() e da Release() - exatamente o
136: *             PROCEDURE Cmd_Imprimir.Click legado (codigo ATIVO, nao o bloco
137: *             comentado). Fabricar os 9 metodos do template criaria 9 stubs
138: *             SEM contrapartida no SCX (proibido) e violaria o PILAR 1.
139: *             INTEGRACAO (a parte real desta fase): o form chega completo
140: *             desde a Fase 7, mas FICOU SEM NENHUM CALLER ate agora. O
141: *             legado SIGOPBOL nunca tem entrada de menu propria - e' um
142: *             dialogo invocado SO programaticamente por quem imprime boleto
143: *             (confirmado: nenhuma ocorrencia de "SIGOPBOL" em origem/*.SCX/
144: *             *.SCT fora de origem/SigPrSdd.SCT). Fabricar um item em
145: *             popMovimentos (o padrao generico "Adicionar item no menu")
146: *             inventaria UX que o legado nao tem E abriria o dialogo com
147: *             this_nTpBol=0/this_cCursor="" (titulo errado, cursor nenhum) -
148: *             pior que nao ter entrada nenhuma. O UNICO caller no codigo
149: *             migrado inteiro, FormSigPrSdd.BtnBoletoClick (botao "Boleto"),
150: *             estava com o bug inverso: CREATEOBJECT("FormSigOpBol") SEM
151: *             nenhum parametro, quando o legado (Fwbtng1.Click, SIGPRSDD.SCX,
152: *             PROCEDURE inteira numa linha) faz "Do Form SigOpBol With
153: *             ThisForm,15" - o 15 (pnTpBol) e' obrigatorio e estava sendo
154: *             descartado silenciosamente (IIF do Init absorve a ausencia sem
155: *             erro, mas o Caption sai errado). Corrigido para
156: *             CREATEOBJECT("FormSIGOPBOL", 15) em FormSigPrSdd.prg.
157: *==============================================================================
158: DEFINE CLASS FormSIGOPBOL AS FormBase
159: 
160:     *-- Parametros de entrada recebidos no Init (equivalem a pnTpBol/pCursor
161:     *-- do PROCEDURE Init legado: LParameters poForm, pnTpBol, pCursor)
162:     this_nTpBol = 0
163:     this_cCursor = ""
164: 
165:     *-- Propriedades publicas, setadas pelo FORM CHAMADOR apos o
166:     *-- CREATEOBJECT e antes do Show() - mirror exato das custom properties
167:     *-- do legado (vcTitEnvelope/vcEmp/vcDope/vnNum/vnDev/vnVias/vnQBols),
168:     *-- que no SCX nascem com default .F. e sao atribuidas em runtime pelo
169:     *-- chamador (nao chegam via LPARAMETERS do Init).
170:     this_cTitEnvelope = ""
171:     this_cEmp = ""
172:     this_cDope = ""
173:     this_nNum = 0
174:     this_nDev = 0
175:     this_nVias = 0
176:     this_nQBols = 0
177: 
178:     *-- Resultado da resolucao de impressoras (ObterImpressorasDisponiveis),
179:     *-- guardado para uso em AplicarVisibilidadeImpressoras() - que roda
180:     *-- DEPOIS de TornarControlesVisiveis() e por isso nao pode recalcular
181:     *-- nada que dependa de Visible ter sido forcado para .T. nesse meio tempo
182:     this_cErroImpressoras = ""
183:     this_nImpressorasDisponiveis = 0
184: 
185:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBOL)
186:     Width        = 800
187:     Height       = 197
188:     DataSession  = 2
189:     ShowWindow = 1
190:     BorderStyle  = 2
191:     AutoCenter   = .T.
192:     Caption      = ""
193:     ControlBox   = .F.
194:     Movable      = .F.
195:     ClipControls = .F.
196:     TitleBar     = 0
197:     WindowType   = 1
198:     *-- Closable/MaxButton/MinButton NAO sao declarados: o SCX legado tambem
199:     *-- nao os declara, e medido no VFP9 (2026-10-17) TitleBar = 0 +
200:     *-- ControlBox = .F. NAO os forca para .F. - os tres continuam .T. Fixa-los
201:     *-- em .F. (como a fase anterior fazia) TIRA o Alt+F4, que no legado eh a
202:     *-- UNICA forma de abortar: o unico botao do dialogo (Cmd_Imprimir/
203:     *-- "Encerrar") sempre IMPRIME antes de dar Release, nao ha Cancelar.
204: 
205:     *--------------------------------------------------------------------------
206:     * Init - Recebe o tipo de boleto e o cursor/tabela a imprimir (equivale
207:     * ao LPARAMETERS pnTpBol, pCursor do PROCEDURE Init legado - poForm nao
208:     * eh reproduzido, ver cabecalho). Cria o Business Object, resolve o
209:     * titulo da janela (Do Case legado) e so depois inicializa a parte
210:     * visual (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
211:     *--------------------------------------------------------------------------
212:     PROCEDURE Init(par_nTpBol, par_cCursor)
213:         LOCAL loc_lSucesso, loc_oErro
214:         loc_lSucesso = .F.
215: 
216:         TRY
217:             *-- Iif(Type('pnTpBol') = 'N', pnTpBol, 0) - mesma guarda do legado
218:             THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
219:             THIS.this_cCursor = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "")
220: 
221:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPBOLBO")
222:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
223:                 MsgErro("Erro ao criar SIGOPBOLBO." + CHR(13) + ;
224:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
225:                     "FormSIGOPBOL.Init")
226:             ELSE
227:                 THIS.this_oBusinessObject.DefinirTipoBoleto(THIS.this_nTpBol)
228:                 THIS.this_oBusinessObject.this_cCursor = THIS.this_cCursor
229: 
230:                 *-- Do Case legado que define o Caption conforme o tipo de boleto
231:                 THIS.Caption = THIS.this_oBusinessObject.ObterTituloPorTipoBoleto(THIS.this_nTpBol)
232: 
233:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
234:                 loc_lSucesso = DODEFAULT()
235:             ENDIF
236:         CATCH TO loc_oErro
237:             MsgErro(loc_oErro.Message + CHR(13) + ;
238:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
239:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.Init")
240:         ENDTRY
241: 
242:         RETURN loc_lSucesso
243:     ENDPROC
244: 
245:     *--------------------------------------------------------------------------
246:     * InicializarForm - Monta a estrutura visual base
247:     * (chamado por FormBase.Init via DODEFAULT)
248:     *--------------------------------------------------------------------------
249:     PROTECTED PROCEDURE InicializarForm()
250:         LOCAL loc_lSucesso, loc_oErro
251:         loc_lSucesso = .F.
252: 
253:         TRY
254:             *-- Fundo do form (imagem do Framework Fortyus legado)
255:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
256: 
257:             *-- Monta o cabecalho (cnt_4c_Sombra - Fase 3)
258:             THIS.ConfigurarPageFrame()
259: 
260:             *-- Monta Opt_Impressora/Lbl_Impressora/Lbl_Erro/btnReport e resolve
261:             *-- a lista de impressoras disponiveis (Fase 4)
262:             THIS.ConfigurarControles()
263: 
264:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
265:             THIS.TornarControlesVisiveis(THIS)
266: 
267:             *-- Troca final (lista de impressoras OU mensagem de erro) tem que
268:             *-- vir DEPOIS de TornarControlesVisiveis - ele forca .Visible=.T.
269:             *-- em toda a arvore e desfaria a escolha feita em ConfigurarControles
270:             THIS.AplicarVisibilidadeImpressoras()
271: 
272:             *-- Replica o bloco final do Init legado que alinha Opt_Impressora/
273:             *-- btnReport verticalmente e redimensiona o form
274:             THIS.AjustarAlturaForm()
275: 
276:             loc_lSucesso = .T.
277:         CATCH TO loc_oErro
278:             MsgErro(loc_oErro.Message + CHR(13) + ;
279:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
280:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.InicializarForm")
281:         ENDTRY
282: 
283:         RETURN loc_lSucesso
284:     ENDPROC
285: 
286:     *--------------------------------------------------------------------------
287:     * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
288:     *   Form OPERACIONAL FLAT: o legado (SIGOPBOL.SCX) nao tem PageFrame nem
289:     *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
290:     *   metodo mantido por convencao do orquestrador de migracao (nenhum
291:     *   AddObject("pgf_4c_...") eh feito aqui).
292:     *   Demais controles do legado (Opt_Impressora, Lbl_Impressora, Lbl_Erro,
293:     *   btnReport) entram em fase posterior (campos/eventos de dados).
294:     *--------------------------------------------------------------------------
295:     PROTECTED PROCEDURE ConfigurarPageFrame()
296:         LOCAL loc_oCab, loc_oErro
297:         TRY
298:             *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
299:             THIS.AddObject("cnt_4c_Sombra", "Container")
300:             loc_oCab = THIS.cnt_4c_Sombra
301:             WITH loc_oCab
302:                 .Top         = 0
303:                 .Left        = 0
304:                 .Width       = THIS.Width
305:                 .Height      = 80
306:                 .BorderWidth = 0
307:                 .BackStyle   = 1
308:                 .BackColor   = RGB(100, 100, 100)
309:             ENDWITH
310: 
311:             *-- Labels adicionados FORA do WITH do container (WITH aninhado com
312:             *-- AddObject ignora propriedades silenciosamente - regra conhecida)
313:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
314:             WITH loc_oCab.lbl_4c_LblSombra
315:                 .FontBold      = .T.
316:                 .FontName      = "Tahoma"
317:                 .FontSize      = 18
318:                 .FontUnderline = .F.
319:                 .WordWrap      = .T.
320:                 .AutoSize      = .F.
321:                 .Alignment     = 0
322:                 .BackStyle     = 0
323:                 *-- Regra #11: o rotulo da faixa espelha THIS.Caption (ja resolvido
324:                 *-- pelo Do Case legado no Init, ANTES do DODEFAULT que chega aqui).
325:                 *-- O SCX trazia o literal "Cadastro de Testes" - placeholder do
326:                 *-- frmcadastro que o Init legado nunca atualiza, ou seja no legado a
327:                 *-- faixa de um dialogo de boleto exibe "Cadastro de Testes".
328:                 .Caption       = THIS.Caption
329:                 .Height        = 40
330:                 .Left          = 10
331:                 .Top           = 18
332:                 .Width         = 769
333:                 .ForeColor     = RGB(0, 0, 0)
334:             ENDWITH
335: 

*-- Linhas 353 a 471:
353:         CATCH TO loc_oErro
354:             MsgErro(loc_oErro.Message + CHR(13) + ;
355:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
356:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.ConfigurarPageFrame")
357:         ENDTRY
358:     ENDPROC
359: 
360:     *--------------------------------------------------------------------------
361:     * ConfigurarControles - Monta Opt_Impressora, Lbl_Impressora, Lbl_Erro e
362:     * btnReport (equivalem aos mesmos objetos do SCX legado, todos filhos
363:     * DIRETOS do form - nao ha PageFrame/Page neste form FLAT) e resolve a
364:     * lista de impressoras de boleto disponiveis, reproduzindo o PROCEDURE
365:     * Init legado: CarregarImpressorasConfiguradas() (consulta SigSyImp/
366:     * SigCdAcG/SigCdmp) + ObterImpressorasDisponiveis() (cruza com APRINTERS()).
367:     * A decisao final de qual controle fica visivel (Opt_Impressora OU
368:     * Lbl_Erro) NAO eh aplicada aqui - fica guardada em
369:     * this_cErroImpressoras/this_nImpressorasDisponiveis e so eh aplicada em
370:     * AplicarVisibilidadeImpressoras(), chamado DEPOIS de
371:     * TornarControlesVisiveis() (ver InicializarForm).
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarControles()
374:         LOCAL loc_oErro, loc_nImpres, loc_nI, loc_nTop
375: 
376:         TRY
377:             *-- Lbl_Impressora (SIGOPBOL.Lbl_Impressora)
378:             THIS.AddObject("lbl_4c_Lbl_Impressora", "Label")
379:             WITH THIS.lbl_4c_Lbl_Impressora
380:                 .AutoSize = .T.
381:                 .FontBold = .T.
382:                 .FontName = "Tahoma"
383:                 .FontSize = 8
384:                 .BackStyle = 0
385:                 .Caption = "Impressora"
386:                 .Height = 15
387:                 .Left = 173
388:                 .Top = 88
389:                 .Width = 68
390:                 *-- O SCX declara Lbl_Impressora.TabIndex = 1 e Lbl_Erro.TabIndex = 1,
391:                 *-- mas TabIndex NAO eh transcrito nos dois Labels: medido no VFP9
392:                 *-- (2026-10-17) o valor nao gruda - VFP exige TabIndex unico por
393:                 *-- container e renumera o duplicado (1 -> 3). E Label nunca eh
394:                 *-- tab-stop (nao recebe foco), entao o numero nao afeta navegacao.
395:                 *-- Transcrever daria uma linha que mente sobre o valor efetivo.
396:                 .ForeColor = RGB(90, 90, 90)
397:             ENDWITH
398: 
399:             *-- Lbl_Erro (SIGOPBOL.Lbl_Erro) - nasce oculto no SCX; o
400:             *-- AplicarVisibilidadeImpressoras() decide se aparece
401:             THIS.AddObject("lbl_4c_Lbl_Erro", "Label")
402:             WITH THIS.lbl_4c_Lbl_Erro
403:                 .FontBold = .T.
404:                 .FontName = "Tahoma"
405:                 .FontSize = 8
406:                 .WordWrap = .T.
407:                 .Alignment = 2
408:                 .BackStyle = 0
409:                 .Caption = "N" + CHR(227) + "o Existe Impressora de Boleto Configurada no Seu Computador. Contate o Suporte T" + CHR(233) + "cnico."
410:                 .Height = 40
411:                 .Left = 180
412:                 .Top = 142
413:                 .Width = 210
414:                 *-- TabIndex nao transcrito (ver lbl_4c_Lbl_Impressora)
415:                 .ForeColor = RGB(90, 90, 90)
416:             ENDWITH
417: 
418:             *-- Opt_Impressora (SIGOPBOL.Opt_Impressora) - ButtonCount definitivo
419:             *-- so eh conhecido depois da consulta; cria com o default do SCX
420:             *-- (1 botao) e reconfigura abaixo quando houver impressoras reais
421:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
422:             WITH THIS.obj_4c_Opt_Impressora
423:                 .BackStyle = 0
424:                 .ButtonCount = 1
425:                 .Height = 74
426:                 .Left = 168
427:                 .SpecialEffect = 1
428:                 .Top = 103
429:                 .Width = 230
430:                 *-- TabIndex do SCX. Medido: nos dois controles FOCALIZAVEIS do form
431:                 *-- (OptionGroup/CommandGroup) o valor gruda exato - Opt=2, btnReport=4.
432:                 .TabIndex = 2
433:                 .BorderColor = RGB(136, 189, 188)
434:             ENDWITH
435:             WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
436:                 .FontName = "Tahoma"
437:                 .FontSize = 8
438:                 .BackStyle = 0
439:                 .Caption = "Gen" + CHR(233) + "rico/Somente Texto"
440:                 .Height = 15
441:                 .Left = 9
442:                 .Top = 15
443:                 .Width = 137
444:                 .Style = 0
445:                 .TabIndex = 1
446:                 *-- AutoSize = .T. transcrito do SCX (Option1.AutoSize). Medido no
447:                 *-- VFP9 (2026-10-17) com Tahoma 8: da exatamente os 137x15 que o
448:                 *-- SCX declara, identico a AutoSize = .F. - nao eh o caso da regra #23
449:                 *-- (la o estrago vem de WordWrap = .T., que este botao nao tem).
450:                 .AutoSize = .T.
451:                 .ForeColor = RGB(90, 90, 90)
452:             ENDWITH
453: 
454:             *-- btnReport (SIGOPBOL.btnReport) - CommandGroup com o unico
455:             *-- botao Cmd_Imprimir ("Encerrar"), que dispara a impressao e
456:             *-- fecha o dialogo (Cmd_Imprimir.Click legado)
457:             THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
458:             WITH THIS.obj_4c_BtnReport
459:                 .BackStyle = 0
460:                 .BorderStyle = 0
461:                 .ButtonCount = 1
462:                 .Height = 94
463:                 .Left = 718
464:                 .SpecialEffect = 1
465:                 .Top = 2
466:                 .Width = 81
467:                 .TabIndex = 4
468:                 .BorderColor = RGB(100, 100, 100)
469:             ENDWITH
470:             WITH THIS.obj_4c_BtnReport.Buttons(1)
471:                 .Top = 1

*-- Linhas 483 a 526:
483:                 .BackColor = RGB(255, 255, 255)
484:                 .Themes = .F.
485:             ENDWITH
486:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "CmdImprimirClick")
487: 
488:             *-- Reproduz a resolucao de impressoras do Init legado:
489:             *-- CarregarImpressorasConfiguradas (SigSyImp/SigCdAcG/SigCdmp) +
490:             *-- ObterImpressorasDisponiveis (cruza com APRINTERS()).
491:             loc_nImpres = 0
492:             IF !THIS.this_oBusinessObject.CarregarImpressorasConfiguradas(gc_4c_UsuarioLogado)
493:                 THIS.this_cErroImpressoras = THIS.this_oBusinessObject.this_cMensagemErro
494:             ELSE
495:                 loc_nImpres = THIS.this_oBusinessObject.ObterImpressorasDisponiveis()
496:                 IF THIS.this_oBusinessObject.this_nQtdImp = 0
497:                     *-- "lnCImp = 0" no legado - cobre TANTO o computador sem
498:                     *-- nenhuma impressora instalada QUANTO nenhuma linha de
499:                     *-- SigCdmp batendo o filtro; no legado a 1a mensagem
500:                     *-- ('Seu Computador Nao Apresenta Impressora Configurada')
501:                     *-- fica sempre sobrescrita por esta, porque lnCImp so
502:                     *-- incrementa dentro do mesmo SCAN que depende de haver
503:                     *-- impressora instalada - e' codigo morto, nao reproduzir
504:                     THIS.this_cErroImpressoras = "Sistema N" + CHR(227) + "o Apresenta Impressora(s) de Boleto Configurada(s). Contate o Suporte T" + CHR(233) + "cnico."
505:                 ENDIF
506:             ENDIF
507:             THIS.this_nImpressorasDisponiveis = loc_nImpres
508: 
509:             IF EMPTY(THIS.this_cErroImpressoras) AND loc_nImpres != 0
510:                 *-- Reconfigura Opt_Impressora com 1 botao por impressora
511:                 *-- disponivel (cursor_4c_SigOpBol_Opcoes, Ordem/NomeExibicao/NomeReal)
512:                 THIS.obj_4c_Opt_Impressora.ButtonCount = loc_nImpres
513: 
514:                 loc_nTop = 10
515:                 SELECT cursor_4c_SigOpBol_Opcoes
516:                 GO TOP
517:                 FOR loc_nI = 1 TO loc_nImpres
518:                     *-- Caption/Tag vem do NOME DA IMPRESSORA NO SO (laImpOk no
519:                     *-- legado - NomeReal aqui), NUNCA do nome gravado em
520:                     *-- SigCdmp.Impres (NomeExibicao, usado so para o MATCH)
521:                     WITH THIS.obj_4c_Opt_Impressora.Buttons(loc_nI)
522:                         .AutoSize = .F.
523:                         .Caption  = " \<" + ALLTRIM(STR(loc_nI)) + ". " + ALLTRIM(cursor_4c_SigOpBol_Opcoes.NomeReal)
524:                         .FontSize = 8
525:                         .Tag      = UPPER(ALLTRIM(cursor_4c_SigOpBol_Opcoes.NomeReal))
526:                         .Top      = loc_nTop

*-- Linhas 549 a 692:
549:         CATCH TO loc_oErro
550:             MsgErro(loc_oErro.Message + CHR(13) + ;
551:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
552:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.ConfigurarControles")
553:         ENDTRY
554:     ENDPROC
555: 
556:     *--------------------------------------------------------------------------
557:     * AplicarVisibilidadeImpressoras - Decide qual bloco fica visivel
558:     * (Opt_Impressora + Lbl_Impressora OU Lbl_Erro), com base no resultado
559:     * guardado por ConfigurarControles(). Chamado DEPOIS de
560:     * TornarControlesVisiveis() porque esse metodo forca .Visible = .T. em
561:     * toda a arvore e desfaria esta escolha se rodasse antes.
562:     *--------------------------------------------------------------------------
563:     PROTECTED PROCEDURE AplicarVisibilidadeImpressoras()
564:         LOCAL loc_oErro
565:         TRY
566:             IF EMPTY(THIS.this_cErroImpressoras) AND THIS.this_nImpressorasDisponiveis != 0
567:                 THIS.lbl_4c_Lbl_Erro.Visible = .F.
568:             ELSE
569:                 THIS.obj_4c_Opt_Impressora.Visible   = .F.
570:                 THIS.lbl_4c_Lbl_Impressora.Visible   = .F.
571:                 THIS.lbl_4c_Lbl_Erro.Visible         = .T.
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message + CHR(13) + ;
575:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
576:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.AplicarVisibilidadeImpressoras")
577:         ENDTRY
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * AjustarAlturaForm - Replica o bloco final do Init legado: alinha
582:     * Opt_Impressora/btnReport verticalmente (quando Opt_Impressora termina
583:     * mais abaixo que btnReport, desloca btnReport para o meio) e
584:     * redimensiona THIS.Height para caber o conteudo, igual ao legado.
585:     *--------------------------------------------------------------------------
586:     PROTECTED PROCEDURE AjustarAlturaForm()
587:         LOCAL loc_nBottom1, loc_nBottom2, loc_oErro
588:         TRY
589:             loc_nBottom1 = THIS.obj_4c_Opt_Impressora.Top + THIS.obj_4c_Opt_Impressora.Height
590:             loc_nBottom2 = THIS.obj_4c_BtnReport.Top + THIS.obj_4c_BtnReport.Height
591: 
592:             IF loc_nBottom1 > loc_nBottom2
593:                 THIS.obj_4c_BtnReport.Top = THIS.obj_4c_BtnReport.Top + INT((loc_nBottom1 - loc_nBottom2) / 2)
594:                 THIS.Height = THIS.obj_4c_Opt_Impressora.Top + THIS.obj_4c_Opt_Impressora.Height + 20
595:             ELSE
596:                 THIS.Height = THIS.obj_4c_BtnReport.Top + THIS.obj_4c_BtnReport.Height + 20
597:             ENDIF
598: 
599:             THIS.obj_4c_BtnReport.Buttons(1).SetFocus()
600:         CATCH TO loc_oErro
601:             MsgErro(loc_oErro.Message + CHR(13) + ;
602:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
603:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.AjustarAlturaForm")
604:         ENDTRY
605:     ENDPROC
606: 
607:     *--------------------------------------------------------------------------
608:     * CmdImprimirClick - Equivale ao PROCEDURE Cmd_Imprimir.Click legado
609:     * (codigo ATIVO, nao o bloco comentado *!* no topo): sincroniza as
610:     * propriedades publicas do dialogo (setadas pelo form chamador) no BO,
611:     * le a impressora escolhida em Opt_Impressora e chama
612:     * ExecutarImpressao() (Do SigBlBol With ...). PUBLIC porque eh chamado
613:     * via BINDEVENT (regra CLAUDE.md #3).
614:     *--------------------------------------------------------------------------
615:     PROCEDURE CmdImprimirClick()
616:         LOCAL loc_nIdx, loc_oErro
617: 
618:         TRY
619:             *-- Opt_Impressora.Value / ButtonsTag sao lidos SEMPRE no
620:             *-- legado (o bloco que so lia quando VnQtdimp > 0 esta comentado
621:             *-- - *!* - e nao eh o codigo ativo)
622:             loc_nIdx = THIS.obj_4c_Opt_Impressora.Value
623:             THIS.this_oBusinessObject.this_cImpressoraSelecionada = ;
624:                 THIS.obj_4c_Opt_Impressora.Buttons(loc_nIdx).Tag
625: 
626:             *-- Propriedades publicas atribuidas pelo form chamador
627:             *-- (this_cTitEnvelope/this_cEmp/this_cDope/this_nNum/this_nDev/
628:             *-- this_nVias/this_nQBols) - this_nTpBol e this_cCursor ja foram
629:             *-- sincronizados no Init
630:             WITH THIS.this_oBusinessObject
631:                 .this_cTitEnvelope = THIS.this_cTitEnvelope
632:                 .this_cEmp         = THIS.this_cEmp
633:                 .this_cDope        = THIS.this_cDope
634:                 .this_nNum         = THIS.this_nNum
635:                 .this_nDev         = THIS.this_nDev
636:                 .this_nVias        = THIS.this_nVias
637:                 .this_nQBols       = THIS.this_nQBols
638:             ENDWITH
639: 
640:             THIS.this_oBusinessObject.ExecutarImpressao()
641:         CATCH TO loc_oErro
642:             MsgErro(loc_oErro.Message + CHR(13) + ;
643:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
644:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.CmdImprimirClick")
645:         ENDTRY
646: 
647:         THIS.Release()
648:     ENDPROC
649: 
650:     *--------------------------------------------------------------------------
651:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
652:     *--------------------------------------------------------------------------
653:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
654:         LOCAL loc_i, loc_oControl, loc_oErro
655:         TRY
656:             FOR loc_i = 1 TO par_oContainer.ControlCount
657:                 loc_oControl = par_oContainer.Controls(loc_i)
658:                 IF VARTYPE(loc_oControl) = "O"
659:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
660:                         loc_oControl.Visible = .T.
661:                     ENDIF
662:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
663:                        loc_oControl.ControlCount > 0
664:                         THIS.TornarControlesVisiveis(loc_oControl)
665:                     ENDIF
666:                 ENDIF
667:             ENDFOR
668:         CATCH TO loc_oErro
669:             MsgErro(loc_oErro.Message + CHR(13) + ;
670:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
671:                 "Procedure: " + loc_oErro.Procedure, "FormSIGOPBOL.TornarControlesVisiveis")
672:         ENDTRY
673:     ENDPROC
674: 
675:     *--------------------------------------------------------------------------
676:     * Destroy - Fecha os cursores temporarios abertos pelo Business Object
677:     * (cursor_4c_SigCdmp / cursor_4c_SigOpBol_Opcoes - CarregarImpressorasConfiguradas
678:     * e ObterImpressorasDisponiveis, usados em fase posterior) antes de
679:     * repassar para FormBase.Destroy() via DODEFAULT().
680:     *--------------------------------------------------------------------------
681:     PROCEDURE Destroy()
682:         IF USED("cursor_4c_SigCdmp")
683:             USE IN cursor_4c_SigCdmp
684:         ENDIF
685:         IF USED("cursor_4c_SigOpBol_Opcoes")
686:             USE IN cursor_4c_SigOpBol_Opcoes
687:         ENDIF
688: 
689:         DODEFAULT()
690:     ENDPROC
691: 
692: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPBOLBO.prg):
*==============================================================================
* SIGOPBOLBO.prg
*
* Business Object para SIGOPBOL (Selecao de Impressora de Boleto)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe parametros do form chamador (tipo de boleto, empresa, operacao,
* numero da movimentacao, etc.), permite ao usuario escolher a impressora de
* boletos configurada na estacao e repassa tudo para a rotina legada de
* impressao (Do SigBlBol With ...).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Fase 2/8: Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM
* override - o comportamento padrao herdado de BusinessBase (recusar a
* operacao com mensagem clara) ja eh o correto para este BO, porque nao ha
* NENHUMA tabela proprietaria para gravar (regra CLAUDE.md "BO
* somente-leitura"). CarregarDoCursor()/ObterChavePrimaria() tambem nao se
* aplicam - o dialogo nao exibe/edita um registro de tabela, ele recebe
* parametros do form chamador e exibe uma lista de impressoras.
*
* Nesta fase sao adicionados os metodos que reproduzem a logica REAL do
* Init/Cmd_Imprimir.Click do legado (tasks\task648\SIGOPBOL_form_codigo_fonte.txt):
*   - DefinirTipoBoleto()              : guarda de tipo (Iif(Type()='N',...))
*   - ObterTituloPorTipoBoleto()       : Do Case do titulo da janela
*   - CarregarImpressorasConfiguradas(): consulta SigSyImp/SigCdAcG/SigCdmp
*   - ObterImpressorasDisponiveis()    : cruza APRINTERS() com SigCdmp
*   - ExecutarImpressao()              : Do SigBlBol With ... (rotina legada)
*
* SigBlBol e uma PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
* veio no acervo (sem .prg fonte, sem FRX - ver regra CLAUDE.md #27 "Funcao
* GLOBAL do legado"). Nao ha como reproduzir a impressao real (layout de
* boleto bancario) sem esse fonte. Por isso ExecutarImpressao() TRANSCREVE o
* "Do SigBlBol With ..." exatamente como o legado chama (mesma ordem de
* parametros), dentro de TRY/CATCH que exibe a falha com MsgErro (regra #9,
* CATCH nunca silencioso) - a ausencia fica VISIVEL em vez de virar um stub
* que finge imprimir.
*==============================================================================

DEFINE CLASS SIGOPBOLBO AS BusinessBase

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPBOL)
    this_nTpBol = 0              && vnTpBol - Tipo de Boleto
    this_cTitEnvelope = ""       && vcTitEnvelope - Titulo do Envelope
    this_cEmp = ""               && vcEmp - Codigo da Empresa
    this_cDope = ""              && vcDope - Nome da Operacao de Estoque/Producao
    this_nNum = 0                && vnNum - Numero da Movimentacao de Estoque/Producao
    this_nDev = 0                && vnDev - Valor de Devolucao
    this_nVias = 0               && vnVias - Numero da Via
    this_nQBols = 0              && vnQBols - Quantidade de Boletos
    this_nQtdImp = 0             && vnQtdImp - Quantidade de Impressoras de Boleto Configuradas
    this_cCursor = ""            && vnCursor - Nome do Cursor/Tabela a Imprimir
    this_cImpressoraSelecionada = "" && Nome da impressora escolhida pelo usuario (laPrinters)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_nTpBol = 0
        THIS.this_cTitEnvelope = ""
        THIS.this_cEmp = ""
        THIS.this_cDope = ""
        THIS.this_nNum = 0
        THIS.this_nDev = 0
        THIS.this_nVias = 0
        THIS.this_nQBols = 0
        THIS.this_nQtdImp = 0
        THIS.this_cCursor = ""
        THIS.this_cImpressoraSelecionada = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirTipoBoleto - Guarda de tipo do parametro recebido do form
    * chamador, igual ao legado: Iif(Type('pnTpBol') = 'N', pnTpBol, 0)
    *====================================================================
    PROCEDURE DefinirTipoBoleto(par_nTpBol)
        THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
    ENDPROC

    *====================================================================
    * ObterTituloPorTipoBoleto - Reproduz o Do Case do Init legado que
    * define o Caption da janela conforme o tipo de boleto
    *====================================================================
    FUNCTION ObterTituloPorTipoBoleto(par_nTpBol)
        LOCAL loc_cTitulo

        DO CASE
            CASE par_nTpBol = 1
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cheque"

            CASE INLIST(par_nTpBol, 2, 3, 4, 5, 7, 9)
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto"

            CASE par_nTpBol = 6
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

            CASE par_nTpBol = 8
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Conserto"

            CASE par_nTpBol = 12
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Ordem de Servi" + CHR(231) + CHR(227) + "o"

            OTHERWISE
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto (*)"
        ENDCASE

        RETURN loc_cTitulo
    ENDFUNC

    *====================================================================
    * CarregarImpressorasConfiguradas - Reproduz a consulta do Init legado
    * que traz as impressoras de boleto liberadas para o usuario, via
    * acesso direto (SigSyImp) ou via grupo de acesso (SigCdAcG), e monta
    * a lista DISTINCT por impressora (crSigCdmp no legado).
    *====================================================================
    FUNCTION CarregarImpressorasConfiguradas(par_cUsuario)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        IF USED("cursor_4c_SigOpBol_Acesso")
            USE IN cursor_4c_SigOpBol_Acesso
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b " + ;
                "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " AND a.cImps = b.impres " + ;
                "UNION ALL " + ;
                "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario) + " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpBol_Acesso")

            IF loc_nResultado >= 0
                SET NULL ON
                IF RECCOUNT("cursor_4c_SigOpBol_Acesso") > 0
                    SELECT DISTINCT Impres, nTpImpres, TpBarra, MaxCols ;
                        FROM cursor_4c_SigOpBol_Acesso ;
                        ORDER BY Impres ;
                        INTO CURSOR cursor_4c_SigCdmp READWRITE
                ELSE
                    CREATE CURSOR cursor_4c_SigCdmp (Impres C(30), nTpImpres N(2,0), TpBarra N(2,0), MaxCols N(3,0))
                ENDIF
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar impressoras configuradas" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SigOpBol_Acesso")
            USE IN cursor_4c_SigOpBol_Acesso
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ObterImpressorasDisponiveis - Cruza as impressoras instaladas na
    * estacao (APRINTERS) com as impressoras de boleto configuradas em
    * cursor_4c_SigCdmp (CarregarImpressorasConfiguradas), aplicando o
    * mesmo filtro do legado: tipo texto (vazio ou 1), sem barra e largura
    * minima de 40 colunas. Preenche this_nQtdImp e o cursor
    * cursor_4c_SigOpBol_Opcoes (Ordem/NomeExibicao/NomeReal), que o Form
    * usa para montar os botoes do Opt_Impressora. Retorna a quantidade
    * de impressoras configuradas que tambem estao instaladas na estacao.
    *====================================================================
    FUNCTION ObterImpressorasDisponiveis()
        LOCAL loc_aPrinters[1], loc_nPrinters, loc_nI, loc_nCImp, loc_nImpres
        loc_nPrinters = APRINTERS(loc_aPrinters)
        loc_nCImp = 0
        loc_nImpres = 0

        IF USED("cursor_4c_SigOpBol_Opcoes")
            USE IN cursor_4c_SigOpBol_Opcoes
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_SigOpBol_Opcoes (Ordem N(3,0), NomeExibicao C(60), NomeReal C(254))
        SET NULL OFF

        IF USED("cursor_4c_SigCdmp")
            SELECT cursor_4c_SigCdmp
            SCAN FOR (EMPTY(cursor_4c_SigCdmp.nTpImpres) OR cursor_4c_SigCdmp.nTpImpres = 1) ;
                AND cursor_4c_SigCdmp.TpBarra = 0 ;
                AND cursor_4c_SigCdmp.MaxCols > 39

                loc_nCImp = loc_nCImp + 1

                IF loc_nPrinters > 0
                    FOR loc_nI = 1 TO loc_nPrinters
                        IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(ALLTRIM(cursor_4c_SigCdmp.Impres))
                            loc_nImpres = loc_nImpres + 1
                            INSERT INTO cursor_4c_SigOpBol_Opcoes VALUES ;
                                (loc_nImpres, ALLTRIM(cursor_4c_SigCdmp.Impres), loc_aPrinters[loc_nI, 1])
                            EXIT
                        ENDIF
                    ENDFOR
                ENDIF
            ENDSCAN
        ENDIF

        THIS.this_nQtdImp = loc_nCImp

        RETURN loc_nImpres
    ENDFUNC

    *====================================================================
    * ExecutarImpressao - Reproduz o Cmd_Imprimir.Click do legado: repassa
    * os parametros do dialogo para a rotina global SigBlBol, que efetua a
    * impressao fisica do boleto. SigBlBol.prg nao esta no acervo (ver
    * comentario de cabecalho) - o erro de arquivo ausente, se ocorrer, e
    * capturado e exibido explicitamente, nunca escondido.
    *====================================================================
    FUNCTION ExecutarImpressao()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DO SigBlBol WITH THIS.this_nTpBol, THIS.this_cTitEnvelope, THIS.this_cEmp, ;
                THIS.this_cDope, THIS.this_nNum, THIS.this_nDev, THIS.this_nVias, ;
                THIS.this_nQBols, THIS.this_cImpressoraSelecionada, THIS.this_cCursor

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao executar a impress" + CHR(227) + "o do boleto (SigBlBol):" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


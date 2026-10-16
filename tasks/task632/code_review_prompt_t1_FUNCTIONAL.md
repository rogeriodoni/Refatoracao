# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_BOTOES, CNT_4C_AGUARDE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PrepararCursoresRelatorio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_MovAux' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1391 linhas total):

*-- Linhas 25 a 102:
25: *            empresa (Valid de getEmp1/getDsemp1 do SCX legado -> KeyPress
26: *            Enter/Tab/F4 em txt_4c_Emp1/txt_4c_Dsemp1, usando
27: *            SigPrItbBO.CarregarEmpresa para o match exato e
28: *            FormBuscaAuxiliar para o picker quando nao casa). O When de
29: *            getDsemp1 ("Return Empty(getEmp1.Value)" - so permite buscar
30: *            por razao social quando o codigo esta vazio) e replicado como
31: *            guarda no inicio do handler, padrao ValidarDemp de
32: *            Formsigatcrp.prg (fAcessoEmpresa).
33: *            Fase 7/8 (esta) - ConfigurarAguarde() (cnt_4c_Aguarde + Shape1
34: *            decorativo); eventos dos botoes de acao: cmd_4c_Processar
35: *            (BtnProcessarClick -> valida periodo via SigPrItbBO.
36: *            ValidarPeriodo, confirma e delega para ExecutarProcessamento,
37: *            equivalente ao PROCEDURE "Processamento" do SCX legado);
38: *            cmg_4c_Relatorio Buttons(1)/(2) (BtnImprimirClick/
39: *            BtnVisualizarClick -> REPORT FORM SigPrIct via
40: *            PrepararCursoresRelatorio + ExecutarReportForm - canonico
41: *            #117/#147, mesmo FRX e mesmo contrato de cursores literais
42: *            "Cabecalho"/"SemConta" de FormSigPrIct.prg); cmg_4c_Sair
43: *            Buttons(1) (BtnEncerrarClick -> THIS.Release()).
44: *            Fase 8 (esta) - consolidacao final. Entraram os quatro metodos
45: *            de FUNIL que o legado escreve espalhado em atribuicao inline:
46: *              FormParaBO()/BOParaForm() - par canonico de transporte dos
47: *                quatro campos do filtro (periodo + empresa);
48: *              HabilitarCampos()         - o bloco ".Enabled" dos campos do
49: *                filtro (Init e ramo de inconsistencia do "processamento");
50: *              AjustarBotoesPorModo()    - o bloco ".Enabled" de Processar/
51: *                btnImprimir/btnVisualizar, escrito pelo legado nos MESMOS
52: *                pontos.
53: *            InicializarForm, BtnProcessarClick e ExecutarProcessamento
54: *            passaram a chamar esses metodos no lugar das atribuicoes
55: *            inline, para o estado da tela ter fonte unica.
56: *
57: * DECISOES DE PROJETO REGISTRADAS NA FASE 8
58: * -----------------------------------------
59: * 1) NAO existem CarregarLista(), LimparCampos(), BtnSalvarClick(),
60: *    BtnCancelarClick() nem BtnBuscarClick(): SIGPRITB nao tem grade, nao tem
61: *    lista, nao tem Page1/Page2, nao tem os modos LISTA/INCLUIR/ALTERAR/
62: *    VISUALIZAR e nao grava registro em tabela nenhuma - eh tela de FILTRO +
63: *    PROCESSAMENTO EM LOTE cujo produto eh arquivo TEXTO (um por empresa) em
64: *    SigCdPam.DirContabv. O dump legado tem exatamente 14 metodos com codigo
65: *    (gravar, processamento, Init, Load, Release, getDsemp1.Valid,
66: *    getDsemp1.When, getEmp1.Valid, Botoes_de_Acao.Click, Sair.Click,
67: *    Processar.Click, cntBotoes.Botoes_de_Acao.Click, btnImprimir.Click e
68: *    btnVisualizar.Click) e TODOS estao migrados. Criar aqui metodos de CRUD
69: *    produziria casca vazia sem correspondente no legado, o que a regra de
70: *    completude proibe. Mesma decisao ja registrada em FormSigPrGf1.
71: * 2) O unico botao de fechar do legado eh o CommandGroup "Botoes_de_Acao"
72: *    (membro "Sair", Click = "ThisForm.Release", Cancel = .T.) - o handler
73: *    chama-se BtnEncerrarClick, nao BtnCancelarClick: o Click so faz Release,
74: *    nao desfaz nem interrompe nada. Como o botao migrado mantem
75: *    .Cancel = .T., o ESC continua caindo nesse mesmo handler, igual ao
76: *    legado; batizar o handler de "Cancelar" daria ao botao o verbo de uma
77: *    acao que a tela nao tem e violaria o PILAR 3.
78: * 3) ExecutarGravacaoArquivo() NAO passa por HabilitarCampos()/
79: *    AjustarBotoesPorModo(), de proposito: o "gravar" legado reabilita APENAS
80: *    getData1/getData2 e desabilita APENAS os dois botoes de relatorio - nao
81: *    toca em getEmp1/getDsemp1 nem em Processar. Rotear pelo funil
82: *    reabilitaria esses tres a mais e divergiria do legado (regra #17 -
83: *    transcrever, nunca "melhorar"). As quatro linhas ficam literais la.
84: * 4) O Load legado faz "=fConfigGeral()" e cria o cursor MovAux. O
85: *    utils\fconfiggeral.prg eh wrapper no-op que existe apenas para o p-code
86: *    dos VCX legado (em codigo nosso nunca se chama), e MovAux virou
87: *    cursor_4c_MovAux, criado por SigPrItbBO.Processar() - por isso este form
88: *    nao declara Load.
89: * 5) O Release legado faz "ThisForm.poDataMgr.Release". Nao existe poDataMgr
90: *    no migrado (a conexao eh o gnConnHandle global, de vida mais longa que o
91: *    form), entao o equivalente do Release eh o Destroy, que fecha os
92: *    cursores deste form e encadeia DODEFAULT().
93: *==============================================================================
94: 
95: DEFINE CLASS FormSigPrItb AS FormBase
96: 
97:     *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
98:     *-- SIGPRITB.SCX: BorderStyle=2, Height=229, Width=800, AutoCenter=.T.,
99:     *-- ControlBox=.F., Closable=.F., MinButton=.F., ClipControls=.F.,
100:     *-- TitleBar=0 (todas transcritas do dump - SECAO 2, PROPRIEDADES DE
101:     *-- SIGPRITB). DataSession nao consta do dump - mantem o default herdado
102:     *-- (sessao corrente, regra "DataSession 1 eh a sessao corrente").

*-- Linhas 116 a 303:
116: 
117:     *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
118:     *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
119:     *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
120:     *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido.
121: 
122:     *==========================================================================
123:     * Init - Sem parametros recebidos do chamador (form aberto direto pelo
124:     * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
125:     *==========================================================================
126:     PROCEDURE Init()
127:         RETURN DODEFAULT()
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * InicializarForm - Instancia o BO e monta a estrutura visual base.
132:     * Fase 3 (esta) monta apenas o cabecalho (cnt_4c_Sombra); os demais
133:     * blocos (botoes de acao, filtro de periodo/empresa, aguarde) entram nas
134:     * proximas fases, dentro de ConfigurarPageFrame().
135:     *==========================================================================
136:     PROTECTED PROCEDURE InicializarForm()
137:         LOCAL loc_lSucesso, loc_lModoSemBanco, loc_oErro
138:         loc_lSucesso = .F.
139: 
140:         TRY
141:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrItbBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
144:                 *-- Init legado aborta a tela se "Select DirContabv From
145:                 *-- SigCdPam" falhar (MessageBox + Return 0) - em validacao de
146:                 *-- UI/modo teste nao ha conexao SQL, e o form so monta a
147:                 *-- estrutura visual (mesmo padrao de FormSIGPRIMP.CarregarLista).
148:                 loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
149:                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
150: 
151:                 IF loc_lModoSemBanco OR THIS.this_oBusinessObject.CarregarParametros()
152:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
153: 
154:                     THIS.ConfigurarPageFrame()
155: 
156:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
157:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
158: 
159:                     THIS.TornarControlesVisiveis(THIS)
160: 
161:                     *-- Estado inicial do Init legado (".getData1.Enabled = .t.",
162:                     *-- ".getData2.Enabled = .t.", ".btnImprimir.Enabled = .f." e
163:                     *-- ".btnVisualizar.Enabled = .f.") pelo funil unico da Fase 8
164:                     THIS.this_cModoAtual = "FILTRO"
165:                     THIS.HabilitarCampos(.T.)
166:                     THIS.AjustarBotoesPorModo()
167: 
168:                     THIS.Visible = .T.
169: 
170:                     loc_lSucesso = .T.
171:                 ELSE
172:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigPrItb.InicializarForm")
173:                 ENDIF
174:             ELSE
175:                 MsgErro("Erro ao criar SigPrItbBO. VARTYPE retornou: " + ;
176:                     VARTYPE(THIS.this_oBusinessObject), "FormSigPrItb.InicializarForm")
177:             ENDIF
178:         CATCH TO loc_oErro
179:             MsgErro(loc_oErro.Message + CHR(13) + ;
180:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
181:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrItb.InicializarForm")
182:         ENDTRY
183: 
184:         RETURN loc_lSucesso
185:     ENDPROC
186: 
187:     *==========================================================================
188:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRITB nao tem
189:     * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
190:     * como ponto de entrada arquitetural padrao (mesmo papel em FormSigPrGf1/
191:     * FormSigPrChr/FormFop/FormEnd).
192:     *
193:     * Roteiro:
194:     *   Fase 3 (feita) - ConfigurarCabecalho()
195:     *   Fase 4 (feita) - ConfigurarBotoesAcao()
196:     *   Fase 5 (feita) - ConfigurarFiltroPeriodo() estrutural
197:     *   Fase 6 (feita) - refinamento do filtro (Format/SpecialEffect/Themes) +
198:     *                     BINDEVENT dos handlers de lookup de empresa, dentro
199:     *                     do proprio ConfigurarFiltroPeriodo()
200:     *   Fase 7/8 (feita) - ConfigurarAguarde() (cnt_4c_Aguarde + Shape1) +
201:     *                      BINDEVENT dos botoes de acao, dentro do proprio
202:     *                      ConfigurarBotoesAcao()
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarPageFrame()
205:         THIS.ConfigurarCabecalho()
206:         THIS.ConfigurarBotoesAcao()
207:         THIS.ConfigurarFiltroPeriodo()
208:         THIS.ConfigurarAguarde()
209:     ENDPROC
210: 
211:     *==========================================================================
212:     * ConfigurarBotoesAcao - Botoes de acao do form (layout.json): botao
213:     * "Processar" solto (fwbtng do legado -> CommandButton canonico) e dois
214:     * CommandGroup, EXATAMENTE como no SCX original - este form NAO tem
215:     * botoes CRUD (Incluir/Alterar/Excluir/Buscar): eh tela de PROCESSAMENTO
216:     * EM LOTE (filtro de periodo + empresa -> gera arquivo de integracao
217:     * contabil), sem Lista/Grid e sem Page1/Page2.
218:     *
219:     *   cmd_4c_Processar  - solto no form (SIGPRITB.Processar, Top=3/Left=649)
220:     *   cnt_4c_Botoes     - container (SIGPRITB.cntBotoes, Top=1/Left=496)
221:     *     cmg_4c_Relatorio  - CommandGroup com 2 botoes (legado chama o
222:     *                         container interno de "BtnReport" no codigo -
223:     *                         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.btnImprimir/
224:     *                         btnVisualizar.Enabled = .f./.t. na Fase 7/8):
225:     *                         Buttons(1) Impressora, Buttons(2) Video
226:     *   cmg_4c_Sair       - CommandGroup com 1 botao (SIGPRITB.Botoes_de_Acao,
227:     *                       Top=-2/Left=719) - Buttons(1) Encerrar
228:     *
229:     * Eventos (Click) dos tres sao ligados na Fase 7/8, junto com Shape1 e
230:     * cnt_4c_Aguarde - aqui entra apenas a estrutura visual.
231:     *==========================================================================
232:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
233:         LOCAL loc_oCmg, loc_oErro
234: 
235:         TRY
236:             *-- cmd_4c_Processar (SIGPRITB.Processar, classe fwbtng do legado -
237:             *-- defaults Height=100/Width=80/FontName="Comic Sans MS" herdados
238:             *-- de framework.vcx, mas o canonico do projeto para botao de acao
239:             *-- solto com icone eh 75x75, igual ao FormSIGMVCMV/Processa)
240:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
241:             WITH THIS.cmd_4c_Processar
242:                 .Top             = 3
243:                 .Left            = 649
244:                 .Height          = 75
245:                 .Width           = 75
246:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
247:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
248:                 .Caption         = "\<Processar"
249:                 .FontName        = "Comic Sans MS"
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .FontSize        = 8
253:                 .ForeColor       = RGB(90, 90, 90)
254:                 .BackColor       = RGB(255, 255, 255)
255:                 .Themes          = .T.
256:                 .SpecialEffect   = 0
257:                 .PicturePosition = 13
258:                 .MousePointer    = 15
259:                 .WordWrap        = .T.
260:                 .AutoSize        = .F.
261:                 .Visible         = .T.
262:             ENDWITH
263:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
264: 
265:             *-- cnt_4c_Botoes (SIGPRITB.cntBotoes)
266:             THIS.AddObject("cnt_4c_Botoes", "Container")
267:             WITH THIS.cnt_4c_Botoes
268:                 .Top         = 1
269:                 .Left        =  542
270:                 .Width       = 156
271:                 .Height      = 84
272:                 .BackStyle   = 0
273:                 .BorderWidth = 0
274:                 .Visible     = .T.
275:             ENDWITH
276: 
277:             *-- cmg_4c_Relatorio (SIGPRITB.cntBotoes.Botoes_de_Acao, 2 botoes)
278:             THIS.cnt_4c_Botoes.AddObject("cmg_4c_Relatorio", "CommandGroup")
279:             loc_oCmg = THIS.cnt_4c_Botoes.cmg_4c_Relatorio
280:             WITH loc_oCmg
281:                 .ButtonCount = 2
282:                 .BackStyle   = 0
283:                 .BorderStyle = 0
284:                 .Top         = -3
285:                 .Left        = -2
286:                 .Width       = 160
287:                 .Height      = 85
288:                 .Value       = 1
289:                 WITH .Buttons(1)
290:                     .Top             = 5
291:                     .Left            = 80
292:                     .Height          = 75
293:                     .Width           = 75
294:                     .FontName        = "Comic Sans MS"
295:                     .FontSize        = 8
296:                     .WordWrap        = .T.
297:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
298:                     .Caption         = "\<Impressora"
299:                     .PicturePosition = 13
300:                     .ForeColor       = RGB(90, 90, 90)
301:                     .BackColor       = RGB(255, 255, 255)
302:                     .Themes          = .F.
303:                     *-- Init legado: .cntBotoes.BtnReport.btnImprimir.Enabled = .f.

*-- Linhas 324 a 419:
324:             *-- btnImprimir (Buttons(1)) / btnVisualizar (Buttons(2)) do dump -
325:             *-- o Click do GRUPO (SIGPRITB.cntBotoes.Botoes_de_Acao) eh vazio
326:             *-- no legado, so os botoes individuais tem codigo
327:             BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnImprimirClick")
328:             BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnVisualizarClick")
329: 
330:             *-- cmg_4c_Sair (SIGPRITB.Botoes_de_Acao, 1 botao - Encerrar)
331:             THIS.AddObject("cmg_4c_Sair", "CommandGroup")
332:             loc_oCmg = THIS.cmg_4c_Sair
333:             WITH loc_oCmg
334:                 .ButtonCount   = 1
335:                 .AutoSize      = .T.
336:                 .BackStyle     = 0
337:                 .BorderStyle   = 0
338:                 .SpecialEffect = 1
339:                 .Top           = -2
340:                 .Left          = 719
341:                 .Width         = 85
342:                 .Height        = 85
343:                 .Value         = 0
344:                 WITH .Buttons(1)
345:                     .Top       = 5
346:                     .Left      = 5
347:                     .Height    = 75
348:                     .Width     = 75
349:                     .FontName  = "Comic Sans MS"
350:                     .FontSize  = 8
351:                     .WordWrap  = .T.
352:                     .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
353:                     .Cancel    = .T.
354:                     .Caption   = "Encerrar"
355:                     .ForeColor = RGB(90, 90, 90)
356:                     .BackColor = RGB(255, 255, 255)
357:                     .Themes    = .F.
358:                 ENDWITH
359:             ENDWITH
360:             *-- Sair.Click do dump ("ThisForm.Release") no botao MEMBRO; o
361:             *-- Click do GRUPO (This.Value=0, botao unico) faz a mesma coisa -
362:             *-- bindar so o Buttons(1) cobre os dois, sem fechar duas vezes
363:             BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnEncerrarClick")
364:         CATCH TO loc_oErro
365:             MsgErro(loc_oErro.Message + CHR(13) + ;
366:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
367:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
368:         ENDTRY
369:     ENDPROC
370: 
371:     *==========================================================================
372:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
373:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
374:     * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
375:     * THIS.Width ja eh 800 (identico ao legado). lblSombra/lblTitulo usam
376:     * THIS.Caption (nao o texto literal "Cadastro de Testes" do dump, que eh
377:     * residuo de copia do SCX original e diverge do Caption real do form).
378:     *==========================================================================
379:     PROTECTED PROCEDURE ConfigurarCabecalho()
380:         LOCAL loc_oCnt, loc_oErro
381: 
382:         TRY
383:             THIS.AddObject("cnt_4c_Sombra", "Container")
384:             loc_oCnt = THIS.cnt_4c_Sombra
385:             WITH loc_oCnt
386:                 .Top         = 0
387:                 .Left        = 0
388:                 .Width       = THIS.Width
389:                 .Height      = 80
390:                 .BorderWidth = 0
391:                 .BackColor   = RGB(100, 100, 100)
392:                 .Visible     = .T.
393:             ENDWITH
394: 
395:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
396:             WITH loc_oCnt.lbl_4c_LblSombra
397:                 .FontBold      = .T.
398:                 .FontName      = "Tahoma"
399:                 .FontSize      = 18
400:                 .FontUnderline = .F.
401:                 .WordWrap      = .T.
402:                 .Alignment     = 0
403:                 .BackStyle     = 0
404:                 .AutoSize      = .F.
405:                 .Caption       = THIS.Caption
406:                 .Height        = 40
407:                 .Left          = 10
408:                 .Top           = 18
409:                 .Width         = 769
410:                 .ForeColor     = RGB(0, 0, 0)
411:                 .Visible       = .T.
412:             ENDWITH
413: 
414:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
415:             WITH loc_oCnt.lbl_4c_LblTitulo
416:                 .FontBold   = .T.
417:                 .FontName   = "Tahoma"
418:                 .FontSize   = 18
419:                 .WordWrap   = .T.

*-- Linhas 431 a 495:
431:         CATCH TO loc_oErro
432:             MsgErro(loc_oErro.Message + CHR(13) + ;
433:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
434:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
435:         ENDTRY
436:     ENDPROC
437: 
438:     *==========================================================================
439:     * ConfigurarFiltroPeriodo - Container cnt_4c_Mvt1 (SIGPRITB.cntMvt1, layout.json
440:     * Top=94/Left=132/Width=389/Height=60) com os campos de filtro do
441:     * processamento: periodo (Data Inicial/Data Final, obrigatorio - validado
442:     * por SigPrItbBO.ValidarPeriodo) e empresa (codigo/razao social, OPCIONAL -
443:     * vazio processa TODAS as empresas, regra de SigPrItbBO.Processar que so
444:     * acrescenta "AND Emps = ..." quando THIS.this_cEmpresa nao esta vazio).
445:     *
446:     * Posicoes, tamanhos e valores iniciais espelham o Init do SCX legado
447:     * (getData1.Value=Date(), getData2.Value=Date(), getEmp1.Value=Space(3),
448:     * getDsemp1.Value=Space(40) - comportamento.json, metodo Init).
449:     * Format="K" nos 4 campos + SpecialEffect/Alignment/Themes de getData1/
450:     * getData2 sao transcritos do dump (SECAO 2 do codigo fonte original).
451:     * BINDEVENT KeyPress liga o lookup de empresa (equivalente ao Valid de
452:     * getEmp1/getDsemp1 do SCX legado) aos handlers ValidarEmp1KeyPress/
453:     * ValidarDsemp1KeyPress, definidos apos este metodo.
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
456:         LOCAL loc_oErro
457: 
458:         TRY
459:             *-- cnt_4c_Mvt1 (SIGPRITB.cntMvt1) - container transparente sobre
460:             *-- o fundo do form (new_background.jpg), igual ao cnt_4c_Botoes
461:             *-- da Fase 4
462:             THIS.AddObject("cnt_4c_Mvt1", "Container")
463:             WITH THIS.cnt_4c_Mvt1
464:                 .Top         = 94
465:                 .Left        = 132
466:                 .Width       = 389
467:                 .Height      = 60
468:                 .BackStyle   = 0
469:                 .BorderWidth = 0
470:                 .Visible     = .T.
471:             ENDWITH
472: 
473:             *-- lbl_4c_Lbl_periodo (SIGPRITB.cntMvt1.lbl_periodo, classe say)
474:             THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo", "Label")
475:             WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo
476:                 .Top       = 10
477:                 .Left      = 13
478:                 .Width     = 45
479:                 .Height    = 15
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .BackStyle = 0
483:                 .Alignment = 0
484:                 .AutoSize  = .F.
485:                 .ForeColor = RGB(90, 90, 90)
486:                 .Caption   = "Per" + CHR(237) + "odo :"
487:                 .Visible   = .T.
488:             ENDWITH
489: 
490:             *-- lbl_4c_Lbl_periodo_a (SIGPRITB.cntMvt1.lbl_periodo_a) - "a"
491:             *-- entre as duas datas (Data Inicial "a" Data Final)
492:             THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
493:             WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo_a
494:                 .Top       = 9
495:                 .Left      = 146

*-- Linhas 618 a 866:
618:             *-- KeyPress (nao LostFocus) porque os handlers testam a tecla
619:             *-- (Enter/Tab/F4) antes de abrir qualquer picker - padrao
620:             *-- ValidarEmp/ValidarDemp de Formsigatcrp.prg (fAcessoEmpresa).
621:             *-- Handlers sao PUBLIC (regra BINDEVENT so liga metodo PUBLIC).
622:             BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Emp1, "KeyPress", THIS, "ValidarEmp1KeyPress")
623:             BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1, "KeyPress", THIS, "ValidarDsemp1KeyPress")
624:         CATCH TO loc_oErro
625:             MsgErro(loc_oErro.Message + CHR(13) + ;
626:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
627:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
628:         ENDTRY
629:     ENDPROC
630: 
631:     *==========================================================================
632:     * ValidarEmp1KeyPress - KeyPress em txt_4c_Emp1 (SIGPRITB.cntMvt1.getEmp1.
633:     * Valid do SCX legado). F4 abre o picker direto; Enter/Tab tentam o match
634:     * exato por codigo via SigPrItbBO.CarregarEmpresa e, nao achando, abrem o
635:     * picker com o valor digitado como prefixo (regra #50 - sem MsgAviso e
636:     * sem apagar o codigo digitado, porque ha picker na sequencia). Campo
637:     * vazio (Enter/Tab) limpa a descricao, igual ao Else do Valid legado.
638:     *==========================================================================
639:     PROCEDURE ValidarEmp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
640:         LOCAL loc_oCnt, loc_cVal
641: 
642:         IF par_nKeyCode = 115
643:             THIS.AbrirBuscaEmpresa(.F.)
644:             RETURN
645:         ENDIF
646: 
647:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
648:             RETURN
649:         ENDIF
650: 
651:         loc_oCnt = THIS.cnt_4c_Mvt1
652:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_Emp1.Value)
653: 
654:         IF EMPTY(loc_cVal)
655:             loc_oCnt.txt_4c_Dsemp1.Value = ""
656:             loc_oCnt.txt_4c_Dsemp1.Refresh
657:             RETURN
658:         ENDIF
659: 
660:         IF THIS.this_oBusinessObject.CarregarEmpresa(loc_cVal, .F.)
661:             loc_oCnt.txt_4c_Emp1.Value   = THIS.this_oBusinessObject.this_cEmpresa
662:             loc_oCnt.txt_4c_Dsemp1.Value = THIS.this_oBusinessObject.this_cDescricaoEmpresa
663:         ELSE
664:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
665:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empresa")
666:             ELSE
667:                 THIS.AbrirBuscaEmpresa(.F.)
668:             ENDIF
669:         ENDIF
670: 
671:         loc_oCnt.txt_4c_Emp1.Refresh
672:         loc_oCnt.txt_4c_Dsemp1.Refresh
673:     ENDPROC
674: 
675:     *==========================================================================
676:     * ValidarDsemp1KeyPress - KeyPress em txt_4c_Dsemp1 (getDsemp1.Valid do
677:     * SCX legado). A guarda !EMPTY(txt_4c_Emp1.Value) -> RETURN replica o
678:     * When do legado ("Return Empty(getEmp1.Value)") - busca por razao social
679:     * so eh permitida quando o codigo ainda esta vazio.
680:     *==========================================================================
681:     PROCEDURE ValidarDsemp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
682:         LOCAL loc_oCnt, loc_cVal
683: 
684:         IF par_nKeyCode = 115
685:             THIS.AbrirBuscaEmpresa(.T.)
686:             RETURN
687:         ENDIF
688: 
689:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
690:             RETURN
691:         ENDIF
692: 
693:         loc_oCnt = THIS.cnt_4c_Mvt1
694: 
695:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Emp1.Value))
696:             RETURN
697:         ENDIF
698: 
699:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_Dsemp1.Value)
700: 
701:         IF EMPTY(loc_cVal)
702:             loc_oCnt.txt_4c_Emp1.Value = ""
703:             loc_oCnt.txt_4c_Emp1.Refresh
704:             RETURN
705:         ENDIF
706: 
707:         IF THIS.this_oBusinessObject.CarregarEmpresa(loc_cVal, .T.)
708:             loc_oCnt.txt_4c_Emp1.Value   = THIS.this_oBusinessObject.this_cEmpresa
709:             loc_oCnt.txt_4c_Dsemp1.Value = THIS.this_oBusinessObject.this_cDescricaoEmpresa
710:         ELSE
711:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
712:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empresa")
713:             ELSE
714:                 THIS.AbrirBuscaEmpresa(.T.)
715:             ENDIF
716:         ENDIF
717: 
718:         loc_oCnt.txt_4c_Emp1.Refresh
719:         loc_oCnt.txt_4c_Dsemp1.Refresh
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * AbrirBuscaEmpresa - Picker de SigCdEmp (FormBuscaAuxiliar) quando o
724:     * match exato de CarregarEmpresa nao resolveu. Lista por LIKE 'valor%' no
725:     * campo pesquisado (Cemps ou Razas, conforme par_lPorDescricao) com
726:     * fallback para a lista completa quando o filtro nao acha nada - mesmo
727:     * padrao de Formsigatcrp.AbrirBuscaEmp/AbrirBuscaDemp (fAcessoEmpresa).
728:     * CREATEOBJECT sem parametros + mAddColuna/this_cCursorDestino manuais
729:     * (nao o Init com 9 parametros - regra #36): o cursor ja vem pronto desta
730:     * consulta, SEM re-executar outro SELECT dentro do picker.
731:     *==========================================================================
732:     PROCEDURE AbrirBuscaEmpresa(par_lPorDescricao)
733:         LOCAL loc_oCnt, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, ;
734:               loc_lProsseguir, loc_oErro
735: 
736:         loc_oCnt    = THIS.cnt_4c_Mvt1
737:         loc_cValor  = ALLTRIM(IIF(par_lPorDescricao, loc_oCnt.txt_4c_Dsemp1.Value, loc_oCnt.txt_4c_Emp1.Value))
738:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
739: 
740:         IF USED("cursor_4c_BuscaEmp")
741:             USE IN cursor_4c_BuscaEmp
742:         ENDIF
743: 
744:         loc_lProsseguir = .T.
745:         TRY
746:             IF EMPTY(loc_cValor)
747:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps")
748:             ELSE
749:                 IF par_lPorDescricao
750:                     loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
751:                         EscaparSQL(loc_cValor + "%") + " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
752:                         " ORDER BY Razas"
753:                 ELSE
754:                     loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps LIKE " + ;
755:                         EscaparSQL(loc_cValor + "%") + " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
756:                         " ORDER BY Cemps"
757:                 ENDIF
758:             ENDIF
759:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
760: 
761:             *-- Fallback: se o filtro nao trouxe nada, mostra a lista completa
762:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
763:                     AND !EMPTY(loc_cValor)
764:                 IF USED("cursor_4c_BuscaEmp")
765:                     USE IN cursor_4c_BuscaEmp
766:                 ENDIF
767:                 loc_nResult = SQLEXEC(gnConnHandle, ;
768:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps"), ;
769:                     "cursor_4c_BuscaEmp")
770:             ENDIF
771: 
772:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
773:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
774:                 loc_lProsseguir = .F.
775:             ENDIF
776: 
777:             IF loc_lProsseguir
778:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
779:                 IF VARTYPE(loc_oBusca) = "O"
780:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
781:                     loc_oBusca.this_cTitulo        = loc_cTitulo
782:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
783:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
784:                     IF par_lPorDescricao
785:                         loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
786:                         loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
787:                     ELSE
788:                         loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
789:                         loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
790:                     ENDIF
791:                     loc_oBusca.Show()
792: 
793:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
794:                         SELECT cursor_4c_BuscaEmp
795:                         loc_oCnt.txt_4c_Emp1.Value   = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
796:                         loc_oCnt.txt_4c_Dsemp1.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
797:                     ENDIF
798:                     loc_oBusca.Release()
799:                 ENDIF
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message, "Erro")
803:         ENDTRY
804: 
805:         IF USED("cursor_4c_BuscaEmp")
806:             USE IN cursor_4c_BuscaEmp
807:         ENDIF
808:         loc_oCnt.txt_4c_Emp1.Refresh
809:         loc_oCnt.txt_4c_Dsemp1.Refresh
810:     ENDPROC
811: 
812:     *==========================================================================
813:     * ConfigurarAguarde - cnt_4c_Aguarde (SIGPRITB.cntAguarde), o painel
814:     * "Aguarde... / Processando Dados..." mostrado durante o Processar
815:     * (equivalente a .cntAguarde.Visible = .t./.f. do PROCEDURE "processamento"
816:     * legado), e shp_4c_Shape1 (SIGPRITB.Shape1), linha decorativa sem
817:     * comportamento. cnt_4c_Aguarde nasce Visible=.F. (Init legado:
818:     * .cntAguarde.Visible = .f.) - TornarControlesVisiveis ja pula este
819:     * container por nome (CNT_4C_AGUARDE), entao a atribuicao aqui nao eh
820:     * sobrescrita depois.
821:     *==========================================================================
822:     PROTECTED PROCEDURE ConfigurarAguarde()
823:         LOCAL loc_oErro
824: 
825:         TRY
826:             *-- Shape1 (SIGPRITB.Shape1) - decorativo, sem BINDEVENT
827:             THIS.AddObject("shp_4c_Shape1", "Shape")
828:             WITH THIS.shp_4c_Shape1
829:                 .Top         = 48
830:                 .Left        = 372
831:                 .Height      = 12
832:                 .Width       = 36
833:                 .BackStyle   = 0
834:                 .BorderStyle = 0
835:                 .BorderColor = RGB(136, 189, 188)
836:                 .Visible     = .T.
837:             ENDWITH
838: 
839:             *-- cnt_4c_Aguarde (SIGPRITB.cntAguarde)
840:             THIS.AddObject("cnt_4c_Aguarde", "Container")
841:             WITH THIS.cnt_4c_Aguarde
842:                 .Top         = 163
843:                 .Left        = 284
844:                 .Width       = 207
845:                 .Height      = 49
846:                 .BorderWidth = 5
847:                 .SpecialEffect = 0
848:                 .BackColor   = RGB(255, 255, 255)
849:                 .Visible     = .F.
850:             ENDWITH
851: 
852:             THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label1", "Label")
853:             WITH THIS.cnt_4c_Aguarde.lbl_4c_Label1
854:                 .FontBold  = .T.
855:                 .FontName  = "Verdana"
856:                 .FontSize  = 10
857:                 .BackStyle = 0
858:                 .AutoSize  = .F.
859:                 .Caption   = "Aguarde..."
860:                 .Height    = 18
861:                 .Left      = 68
862:                 .Top       = 7
863:                 .Width     = 78
864:                 .ForeColor = RGB(255, 0, 0)
865:                 .Visible   = .T.
866:             ENDWITH

*-- Linhas 885 a 1391:
885:         CATCH TO loc_oErro
886:             MsgErro(loc_oErro.Message + CHR(13) + ;
887:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
888:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
889:         ENDTRY
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * BtnProcessarClick - Click de cmd_4c_Processar (SIGPRITB.Processar.Click).
894:     * Replica as 3 validacoes do legado (via SigPrItbBO.ValidarPeriodo - mesmas
895:     * mensagens e ordem) + confirmacao "Confirma o Processamento ?"; so entao
896:     * delega para ExecutarProcessamento (PROCEDURE "Processamento" do legado).
897:     * PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao.
898:     *==========================================================================
899:     PROCEDURE BtnProcessarClick()
900:         LOCAL loc_oBO, loc_oErro, loc_lProsseguir
901: 
902:         *-- Regra #1: RETURN (inclusive o BARE de guarda) e PROIBIDO dentro de
903:         *-- TRY/CATCH. O early-exit da validacao do periodo vira flag, e o resto
904:         *-- do bloco fica envolvido em IF loc_lProsseguir (so trocar o RETURN por
905:         *-- atribuicao, sem envolver o resto, descartaria o early-exit e abriria
906:         *-- a confirmacao de processamento com periodo invalido).
907:         loc_lProsseguir = .T.
908: 
909:         TRY
910:             loc_oBO = THIS.this_oBusinessObject
911: 
912:             *-- Transporte Form -> BO pelo funil (Fase 8): o Click legado le
913:             *-- getData1/getData2/getEmp1 direto dos controles, aqui os quatro
914:             *-- campos viajam de uma vez para as properties do BO
915:             THIS.FormParaBO()
916: 
917:             IF !loc_oBO.ValidarPeriodo()
918:                 MsgAviso(loc_oBO.this_cMensagemErro)
919:                 IF EMPTY(loc_oBO.this_dDataInicial)
920:                     THIS.cnt_4c_Mvt1.txt_4c_Data1.SetFocus()
921:                 ELSE
922:                     THIS.cnt_4c_Mvt1.txt_4c_Data2.SetFocus()
923:                 ENDIF
924:                 loc_lProsseguir = .F.
925:             ENDIF
926: 
927:             IF loc_lProsseguir
928:                 IF MsgConfirma("Confirma o Processamento ?")
929:                     THIS.ExecutarProcessamento()
930:                 ENDIF
931:             ENDIF
932:         CATCH TO loc_oErro
933:             MsgErro(loc_oErro.Message + CHR(13) + ;
934:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
935:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
936:         ENDTRY
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * ExecutarProcessamento - PROCEDURE "processamento" do SCX legado: mostra
941:     * cnt_4c_Aguarde durante SigPrItbBO.Processar() e, concluido, decide o
942:     * desfecho pela MESMA ordem do legado:
943:     *   1) ha inconsistencia (this_lTemInconsistencia)  -> trava o filtro e o
944:     *      botao Processar, habilita os botoes de relatorio, avisa
945:     *   2) sem inconsistencia mas com movimento (this_nTotalRegistros > 0) ->
946:     *      avisa "Nenhuma Inconsistencia" e grava o arquivo (ExecutarGravacaoArquivo)
947:     *   3) sem movimento nenhum no periodo -> so avisa
948:     *==========================================================================
949:     PROTECTED PROCEDURE ExecutarProcessamento()
950:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
951: 
952:         loc_oBO = THIS.this_oBusinessObject
953: 
954:         THIS.cnt_4c_Aguarde.Visible = .T.
955:         THIS.Refresh()
956: 
957:         TRY
958:             loc_lSucesso = loc_oBO.Processar()
959:         CATCH TO loc_oErro
960:             loc_lSucesso = .F.
961:             loc_oBO.this_cMensagemErro = loc_oErro.Message
962:         ENDTRY
963: 
964:         THIS.cnt_4c_Aguarde.Visible = .F.
965:         THIS.Refresh()
966: 
967:         IF !loc_lSucesso
968:             MsgErro(loc_oBO.this_cMensagemErro, "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil")
969:             RETURN
970:         ENDIF
971: 
972:         IF loc_oBO.this_lTemInconsistencia
973:             *-- Ramo "If Not Eof('semconta')" do processamento legado: trava os
974:             *-- quatro campos do filtro e o Processar, e libera os dois botoes de
975:             *-- relatorio. As tres linhas abaixo sao o funil desse bloco (Fase 8)
976:             THIS.HabilitarCampos(.F.)
977:             THIS.this_cModoAtual = "INCONSISTENCIA"
978:             THIS.AjustarBotoesPorModo()
979: 
980:             MsgAviso("Existem Inconsist" + CHR(234) + "ncia(s), Favor Checar Pelo Relat" + ;
981:                 CHR(243) + "rio Gerado.", "ATEN" + CHR(199) + CHR(195) + "O")
982:         ELSE
983:             IF loc_oBO.this_nTotalRegistros > 0
984:                 MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada.", "ATEN" + CHR(199) + CHR(195) + "O")
985:                 THIS.ExecutarGravacaoArquivo()
986:             ELSE
987:                 MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + ;
988:                     "o no Per" + CHR(237) + "odo.", "ATEN" + CHR(199) + CHR(195) + "O")
989:             ENDIF
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * ExecutarGravacaoArquivo - PROCEDURE "gravar" do SCX legado: reabilita o
995:     * periodo e desabilita os botoes de relatorio (incondicional, igual ao
996:     * dump), confirma "Confirma a Geracao do Arquivo?" e, so entao, delega a
997:     * geracao do arquivo texto para SigPrItbBO.GerarArquivoContabil().
998:     *==========================================================================
999:     PROTECTED PROCEDURE ExecutarGravacaoArquivo()
1000:         LOCAL loc_oBO
1001: 
1002:         loc_oBO = THIS.this_oBusinessObject
1003: 
1004:         THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled = .T.
1005:         THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled = .T.
1006:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled = .F.
1007:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled = .F.
1008: 
1009:         IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
1010:             IF !loc_oBO.GerarArquivoContabil()
1011:                 MsgErro(loc_oBO.this_cMensagemErro, "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil")
1012:             ENDIF
1013:         ENDIF
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     * BtnImprimirClick - Click do botao "Impressora" (cmg_4c_Relatorio.
1018:     * Buttons(1) = btnImprimir do dump). Legado: "Report Form SigPrIct to
1019:     * Print Prompt NoConsole" - sem chamada a Gravar depois (diferente de
1020:     * FormSigPrIct/SIGPRICT). PUBLIC: ligado via BINDEVENT.
1021:     *==========================================================================
1022:     PROCEDURE BtnImprimirClick()
1023:         LOCAL loc_oErro
1024: 
1025:         TRY
1026:             IF THIS.PrepararCursoresRelatorio()
1027:                 THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
1028:             ENDIF
1029:         CATCH TO loc_oErro
1030:             MsgErro(loc_oErro.Message + CHR(13) + ;
1031:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1032:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnImprimirClick")
1033:         ENDTRY
1034:     ENDPROC
1035: 
1036:     *==========================================================================
1037:     * BtnVisualizarClick - Click do botao "Video" (cmg_4c_Relatorio.
1038:     * Buttons(2) = btnVisualizar do dump). Legado: "Report Form SigPrIct
1039:     * Preview NoConsole". PUBLIC: ligado via BINDEVENT.
1040:     *==========================================================================
1041:     PROCEDURE BtnVisualizarClick()
1042:         LOCAL loc_oErro
1043: 
1044:         TRY
1045:             IF THIS.PrepararCursoresRelatorio()
1046:                 THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
1047:             ENDIF
1048:         CATCH TO loc_oErro
1049:             MsgErro(loc_oErro.Message + CHR(13) + ;
1050:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1051:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
1052:         ENDTRY
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * BtnEncerrarClick - Click de cmg_4c_Sair.Buttons(1) (SIGPRITB.
1057:     * Botoes_de_Acao.Sair.Click + Click do grupo, ambos "ThisForm.Release").
1058:     * PUBLIC: ligado via BINDEVENT.
1059:     *==========================================================================
1060:     PROCEDURE BtnEncerrarClick()
1061:         THIS.Release()
1062:     ENDPROC
1063: 
1064:     *==========================================================================
1065:     * PrepararCursoresRelatorio - monta os dois alias de NOME LITERAL que o
1066:     * SigPrIct.frx consome por contrato (mesmo contrato de
1067:     * FormSigPrIct.PrepararCursoresRelatorio - os nomes NAO levam prefixo
1068:     * cursor_4c_ porque pertencem ao FRX, nao a arquitetura nova; renomear
1069:     * quebraria as expressoes "Cabecalho.Titulo"/"Cabecalho.SubTit"/
1070:     * "Cabecalho.Periodo" gravadas no relatorio e os campos sem prefixo do
1071:     * detalhe, que resolvem contra o ALIAS CORRENTE):
1072:     *
1073:     *   SemConta  - detalhe do relatorio (Contas/Datas/Hists/Valors/Ocors),
1074:     *               espelho ORDENADO de cursor_4c_SemConta (SigPrItbBO.
1075:     *               Processar ja populou). ORDER BY Contas, Datas reproduz o
1076:     *               "Select SemConta / Set Order to ('conta')" do legado - o
1077:     *               TAG Conta eh "Contas + Dtos(Datas)".
1078:     *   Cabecalho - titulo/periodo do cabecalho impresso. cursor_4c_Cabecalho
1079:     *               ja foi montado por SigPrItbBO.Processar() (via o metodo
1080:     *               PROTECTED MontarCabecalhoRelatorio - nunca chamado direto
1081:     *               de fora, regra #51); aqui so se copia o alias.
1082:     *==========================================================================
1083:     PROTECTED FUNCTION PrepararCursoresRelatorio()
1084:         IF !USED("cursor_4c_SemConta") OR RECCOUNT("cursor_4c_SemConta") = 0
1085:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
1086:                 "vel para o relat" + CHR(243) + "rio.")
1087:             RETURN .F.
1088:         ENDIF
1089: 
1090:         IF USED("SemConta")
1091:             USE IN SemConta
1092:         ENDIF
1093:         SELECT * FROM cursor_4c_SemConta ORDER BY Contas, Datas ;
1094:             INTO CURSOR SemConta READWRITE
1095: 
1096:         IF USED("Cabecalho")
1097:             USE IN Cabecalho
1098:         ENDIF
1099:         IF USED("cursor_4c_Cabecalho")
1100:             SELECT * FROM cursor_4c_Cabecalho INTO CURSOR Cabecalho READWRITE
1101:         ELSE
1102:             *-- Defensivo: nao deveria ocorrer no fluxo normal (Processar() ja
1103:             *-- monta cursor_4c_Cabecalho antes de habilitar estes botoes)
1104:             CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
1105:         ENDIF
1106: 
1107:         RETURN .T.
1108:     ENDFUNC
1109: 
1110:     *==========================================================================
1111:     * ExecutarReportForm - helper canonico de REPORT FORM (CorretorAutomatico
1112:     * #117/#147): guard de existencia do FRX, guard de cursor vazio,
1113:     * isolamento de locale (POINT/SEPARATOR/REPORTBEHAVIOR 80 - FRX Fortyus
1114:     * com PICTURE americana) e restauracao do menu (REPORT FORM PREVIEW
1115:     * corrompe o cache visual do _MSYSMENU - Erro63).
1116:     * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
1117:     *==========================================================================
1118:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
1119:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
1120: 
1121:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
1122: 
1123:         IF NOT FILE(loc_cFRX)
1124:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1125:                 loc_cFRX + CHR(13) + CHR(13) + ;
1126:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
1127:             RETURN .F.
1128:         ENDIF
1129: 
1130:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1131:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1132:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1133:                     "Aten" + CHR(231) + CHR(227) + "o")
1134:                 RETURN .F.
1135:             ENDIF
1136:         ENDIF
1137: 
1138:         loc_cPointOrig    = SET("POINT")
1139:         loc_cSepOrig      = SET("SEPARATOR")
1140:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1141:         SET POINT TO "."
1142:         SET SEPARATOR TO ","
1143:         SET REPORTBEHAVIOR 80
1144: 
1145:         DO CASE
1146:             CASE par_cModo == "PREVIEW"
1147:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1148:             CASE par_cModo == "PRINTER_PROMPT"
1149:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1150:             CASE par_cModo == "PRINTER"
1151:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
1152:         ENDCASE
1153: 
1154:         SET POINT TO (loc_cPointOrig)
1155:         SET SEPARATOR TO (loc_cSepOrig)
1156:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1157: 
1158:         TRY
1159:             SET SYSMENU TO DEFAULT
1160:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
1161:             CriarMenuPrincipal()
1162:         CATCH
1163:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
1164:         ENDTRY
1165: 
1166:         RETURN .T.
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * FormParaBO - Transporte Form -> BO dos quatro campos do filtro
1171:     * (SIGPRITB.cntMvt1): periodo (getData1/getData2, que no PROCEDURE
1172:     * "processamento" legado alimentam IniPer/FinPer) e empresa (getEmp1 ->
1173:     * m.lcEmp1 do mesmo metodo; getDsemp1 eh somente exibicao e nao entra em
1174:     * SQL nenhum, mas viaja junto para a property espelho do BO).
1175:     * FUNIL unico: BtnProcessarClick chama este metodo antes de validar, no
1176:     * lugar de atribuir property por property.
1177:     *
1178:     * PROTECTED EXPLICITO e obrigatorio: FormBase declara "PROTECTED PROCEDURE
1179:     * FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever
1180:     * sem PROTECTED nao tornaria o metodo publico, so esconderia que ele
1181:     * continua protegido. Chamar sempre por THIS. de dentro da classe.
1182:     *
1183:     * ConverterParaData() normaliza o Value do TextBox: com DATE (como nasce
1184:     * aqui, .Value = {}) devolve a propria data; com DATETIME devolve a data
1185:     * sem a hora. TTOD() direto estouraria o erro 11 do VFP9 com DATE.
1186:     *==========================================================================
1187:     PROTECTED PROCEDURE FormParaBO()
1188:         LOCAL loc_oBO, loc_oCnt, loc_lResultado
1189: 
1190:         loc_lResultado = .F.
1191: 
1192:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1193:             loc_oBO  = THIS.this_oBusinessObject
1194:             loc_oCnt = THIS.cnt_4c_Mvt1
1195: 
1196:             loc_oBO.this_dDataInicial      = ConverterParaData(loc_oCnt.txt_4c_Data1.Value)
1197:             loc_oBO.this_dDataFinal        = ConverterParaData(loc_oCnt.txt_4c_Data2.Value)
1198:             loc_oBO.this_cEmpresa          = ALLTRIM(loc_oCnt.txt_4c_Emp1.Value)
1199:             loc_oBO.this_cDescricaoEmpresa = ALLTRIM(loc_oCnt.txt_4c_Dsemp1.Value)
1200: 
1201:             loc_lResultado = .T.
1202:         ENDIF
1203: 
1204:         RETURN loc_lResultado
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * BOParaForm - Transporte BO -> Form dos mesmos quatro campos. Reproduz o
1209:     * bloco de carga inicial do Init legado:
1210:     *     .cntMvt1.getData1.Value  = Date()
1211:     *     .cntMvt1.getData2.Value  = Date()
1212:     *     .cntMvt1.getEmp1.Value   = Space(03)
1213:     *     .cntMvt1.getDsemp1.Value = Space(40)
1214:     * (SigPrItbBO.Init ja espelha esses valores nas properties; o ALLTRIM
1215:     * converte os Space(N) em campo vazio, que eh o estado "processa todas as
1216:     * empresas").
1217:     *
1218:     * Chamado SO na carga inicial (ConfigurarFiltroPeriodo). Os handlers de
1219:     * lookup de empresa continuam atribuindo o PAR codigo/descricao direto:
1220:     * rotear o lookup por aqui sobrescreveria as duas datas com o valor que
1221:     * estiver na property no momento, apagando em silencio o periodo que o
1222:     * usuario tivesse acabado de digitar e ainda nao empurrado para o BO.
1223:     *
1224:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara o
1225:     * nome como PROTECTED e o escopo vem da heranca).
1226:     *==========================================================================
1227:     PROTECTED PROCEDURE BOParaForm()
1228:         LOCAL loc_oBO, loc_oCnt, loc_lResultado
1229: 
1230:         loc_lResultado = .F.
1231: 
1232:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1233:             loc_oBO  = THIS.this_oBusinessObject
1234:             loc_oCnt = THIS.cnt_4c_Mvt1
1235: 
1236:             loc_oCnt.txt_4c_Data1.Value  = ConverterParaData(loc_oBO.this_dDataInicial)
1237:             loc_oCnt.txt_4c_Data2.Value  = ConverterParaData(loc_oBO.this_dDataFinal)
1238:             loc_oCnt.txt_4c_Emp1.Value   = ALLTRIM(TratarNulo(loc_oBO.this_cEmpresa, ""))
1239:             loc_oCnt.txt_4c_Dsemp1.Value = ALLTRIM(TratarNulo(loc_oBO.this_cDescricaoEmpresa, ""))
1240: 
1241:             loc_oCnt.txt_4c_Data1.Refresh
1242:             loc_oCnt.txt_4c_Data2.Refresh
1243:             loc_oCnt.txt_4c_Emp1.Refresh
1244:             loc_oCnt.txt_4c_Dsemp1.Refresh
1245: 
1246:             loc_lResultado = .T.
1247:         ENDIF
1248: 
1249:         RETURN loc_lResultado
1250:     ENDPROC
1251: 
1252:     *==========================================================================
1253:     * HabilitarCampos - Funil do bloco ".Enabled" dos QUATRO campos do filtro,
1254:     * que o legado escreve em dois pontos:
1255:     *   Init             -> getData1/getData2.Enabled = .t.
1256:     *   processamento    -> getData1/getData2/getEmp1/getDsemp1.Enabled = .f.
1257:     *                       (ramo "If Not Eof('semconta')")
1258:     * Sem parametro assume .T. (PCOUNT() = 0): parametro ausente em VFP9 chega
1259:     * como .F. logico, e sem esse teste uma chamada sem argumento DESABILITARIA
1260:     * o filtro em vez de habilita-lo.
1261:     *
1262:     * PUBLIC de verdade (HabilitarCampos nao existe em FormBase, logo nao ha
1263:     * escopo herdado para alargar) - eh o que permite ao harness de teste
1264:     * automatizado exercitar o metodo de fora.
1265:     *==========================================================================
1266:     PROCEDURE HabilitarCampos(par_lHabilitar)
1267:         LOCAL loc_lHab, loc_oCnt
1268: 
1269:         IF PCOUNT() = 0
1270:             loc_lHab = .T.
1271:         ELSE
1272:             loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1273:         ENDIF
1274: 
1275:         loc_oCnt = THIS.cnt_4c_Mvt1
1276: 
1277:         loc_oCnt.txt_4c_Data1.Enabled  = loc_lHab
1278:         loc_oCnt.txt_4c_Data2.Enabled  = loc_lHab
1279:         loc_oCnt.txt_4c_Emp1.Enabled   = loc_lHab
1280:         loc_oCnt.txt_4c_Dsemp1.Enabled = loc_lHab
1281:     ENDPROC
1282: 
1283:     *==========================================================================
1284:     * AjustarBotoesPorModo - Funil do bloco ".Enabled" dos TRES botoes, que o
1285:     * legado escreve nos mesmos pontos do HabilitarCampos:
1286:     *   Init          -> btnImprimir/btnVisualizar.Enabled = .f.
1287:     *   processamento -> Processar.Enabled = .f. e
1288:     *                    btnImprimir/btnVisualizar.Enabled = .t.
1289:     *                    (ramo "If Not Eof('semconta')")
1290:     *
1291:     * Os modos deste form NAO sao os do CRUD (LISTA/INCLUIR/ALTERAR/
1292:     * VISUALIZAR) porque nao ha Lista nem edicao de registro - sao os dois
1293:     * estados que o legado de fato tem:
1294:     *   "FILTRO"         - estado inicial e apos a geracao do arquivo: o
1295:     *                      periodo/empresa sao editaveis, Processar ativo e os
1296:     *                      botoes de relatorio desligados (nao ha o que
1297:     *                      imprimir).
1298:     *   "INCONSISTENCIA" - sobraram lancamentos sem conta contabil: o filtro e
1299:     *                      o Processar travam e os dois botoes de relatorio
1300:     *                      ligam, para o usuario conferir o SigPrIct.frx.
1301:     *
1302:     * PUBLIC de verdade (nome ausente em FormBase).
1303:     *==========================================================================
1304:     PROCEDURE AjustarBotoesPorModo()
1305:         LOCAL loc_lInconsistencia
1306: 
1307:         loc_lInconsistencia = (UPPER(ALLTRIM(THIS.this_cModoAtual)) == "INCONSISTENCIA")
1308: 
1309:         THIS.cmd_4c_Processar.Enabled = !loc_lInconsistencia
1310:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled = loc_lInconsistencia
1311:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled = loc_lInconsistencia
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1316:     * padrao; percorre recursivamente Containers/PageFrames tornando tudo
1317:     * visivel, exceto containers que precisam nascer ocultos (cnt_4c_Aguarde,
1318:     * adicionado na Fase 7/8) - esses sao pulados com LOOP mas ainda recursam
1319:     * para que os FILHOS deles nao fiquem hidden quando o container, mais
1320:     * tarde, for exibido.
1321:     *==========================================================================
1322:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1323:         LOCAL loc_nI, loc_oObjeto, loc_nP
1324: 
1325:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1326:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1327: 
1328:             IF VARTYPE(loc_oObjeto) = "O"
1329:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE")
1330:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1331:                     LOOP
1332:                 ENDIF
1333: 
1334:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1335:                     loc_oObjeto.Visible = .T.
1336:                 ENDIF
1337: 
1338:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1339:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1340:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1341:                     ENDFOR
1342:                 ENDIF
1343: 
1344:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1345:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1346:                 ENDIF
1347:             ENDIF
1348:         ENDFOR
1349:     ENDPROC
1350: 
1351:     *==========================================================================
1352:     * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
1353:     * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
1354:     * form). Os cursores de trabalho do processamento moram no BO
1355:     * (cursor_4c_MovAux/cursor_4c_SemConta/cursor_4c_Cabecalho/etc) e sao
1356:     * recriados a cada chamada de Processar() - fecha-los aqui evita vazar
1357:     * work area entre instancias do form. "SemConta"/"Cabecalho" (sem
1358:     * prefixo) sao os alias literais montados por PrepararCursoresRelatorio()
1359:     * para o SigPrIct.frx. DODEFAULT() SEMPRE por ultimo (Destroy sem
1360:     * DODEFAULT deixa o menu do sistema encolhido - regra #145).
1361:     *==========================================================================
1362:     PROCEDURE Destroy()
1363:         IF USED("cursor_4c_MovAux")
1364:             USE IN cursor_4c_MovAux
1365:         ENDIF
1366:         IF USED("cursor_4c_SemConta")
1367:             USE IN cursor_4c_SemConta
1368:         ENDIF
1369:         IF USED("cursor_4c_Cabecalho")
1370:             USE IN cursor_4c_Cabecalho
1371:         ENDIF
1372:         IF USED("cursor_4c_Gcr")
1373:             USE IN cursor_4c_Gcr
1374:         ENDIF
1375:         IF USED("cursor_4c_MvCcr")
1376:             USE IN cursor_4c_MvCcr
1377:         ENDIF
1378:         IF USED("cursor_4c_Cli")
1379:             USE IN cursor_4c_Cli
1380:         ENDIF
1381:         IF USED("SemConta")
1382:             USE IN SemConta
1383:         ENDIF
1384:         IF USED("Cabecalho")
1385:             USE IN Cabecalho
1386:         ENDIF
1387: 
1388:         DODEFAULT()
1389:     ENDPROC
1390: 
1391: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrItbBO.prg):
*==============================================================================
* SIGPRITBBO.PRG
* Business Object do formulario SIGPRITB (Integracao Contabil Total)
* Responsabilidade: processar os lancamentos financeiros do periodo filtrado
* (SigMvCcr), classificar a conta contabil de cada lancamento (SigCdGcr /
* SigCdCli), detectar contas sem conta contabil cadastrada e gerar o arquivo
* texto de integracao contabil (um arquivo por empresa/data) no diretorio
* configurado em SigCdPam.DirContabv.
*
* SIGPRITB e um form OPERACIONAL de PROCESSAMENTO em lote, sem tabela
* mestre nem grid de cadastro - por isso this_cTabela e this_cCampoChave
* permanecem vazios (nao ha CRUD, nao ha chave primaria de registro).
*==============================================================================

DEFINE CLASS SigPrItbBO AS BusinessBase

    *-- Propriedades (espelham os controles/variaveis do form legado)
    this_dDataInicial       = {}    && Periodo inicial do filtro (cntMvt1.getData1.Value / IniPer)
    this_dDataFinal         = {}    && Periodo final do filtro (cntMvt1.getData2.Value / FinPer)
    this_cEmpresa           = ""    && Codigo da empresa filtrada, opcional (cntMvt1.getEmp1.Value / lcEmp1)
    this_cDescricaoEmpresa  = ""    && Razao social da empresa filtrada, somente exibicao (cntMvt1.getDsemp1.Value)
    this_cDiretorioContabil = ""    && Diretorio de geracao do arquivo contabil (crSigCdPam.DirContabv)
    this_nTotalRegistros    = 0     && Total de lancamentos processados no ultimo Processamento (Ncont)
    this_lTemInconsistencia = .F.   && .T. quando sobraram lancamentos sem conta contabil (cursor SemConta)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPRITB nao possui tabela mestre (form de processamento em lote)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        *-- Valores padrao equivalentes ao Init do SCX legado
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal = DATE()
        THIS.this_cEmpresa = SPACE(3)
        THIS.this_cDescricaoEmpresa = SPACE(40)
        THIS.this_cDiretorioContabil = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (SQLEXEC() troca a area selecionada ao criar o cursor de resultado).
    * Convencao adotada: sucesso quando o retorno do SQLEXEC nativo eh >= 0
    * (0 linhas tambem eh sucesso - periodo sem movimento NAO eh erro de
    * conexao, e e tratado depois por THIS.this_nTotalRegistros = 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - le o diretorio de geracao do arquivo contabil
    * (equivalente ao "Select DirContabv From SigCdPam" feito no Init do
    * SCX legado). SigCdPam nao tem filtro de empresa no legado - usa-se o
    * primeiro registro, igual ao original.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF THIS.ExecutarSQL("SELECT DirContabv FROM SigCdPam", "cursor_4c_Pam", "SigCdPam")
            IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                THIS.CarregarDoCursor("cursor_4c_Pam")
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - transfere para as propriedades do BO as colunas
    * remotas que ele guarda, a partir de um cursor ja populado.
    *
    * PUBLIC (sem PROTECTED): a BusinessBase declara este metodo sem
    * modificador e o form chama de fora (regra #51 do CLAUDE.md).
    *
    * Atende os dois cursores que alimentam o BO, porque as colunas nao
    * colidem entre si e o teste de existencia eh feito coluna a coluna:
    *   - cursor de SigCdEmp (Cemps / Razas)   -> filtro de empresa da tela
    *     (equivalente ao "getEmp1.Value = crListaRemota.Cemps" e
    *      "getDsemp1.Value = crListaRemota.Razas" dos Valid do SCX legado)
    *   - cursor de SigCdPam (DirContabv)      -> diretorio de geracao
    *     (equivalente ao Select DirContabv do Init do SCX legado)
    *
    * Existencia de coluna conferida com TYPE(alias + "." + coluna) - NUNCA
    * PEMSTATUS, que exige OBJETO no 1o argumento e dispara erro 11 com
    * nome de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAliasAnt, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        SELECT (par_cAliasCursor)
        IF RECCOUNT(par_cAliasCursor) > 0 AND EOF(par_cAliasCursor)
            GO TOP
        ENDIF

        IF !EOF(par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".Cemps") != "U"
                THIS.this_cEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Cemps"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".Razas") != "U"
                THIS.this_cDescricaoEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Razas"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".DirContabv") != "U"
                THIS.this_cDiretorioContabil = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".DirContabv"), ""))
                loc_lResultado = .T.
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - resolve o filtro de empresa da tela por codigo
    * (Cemps) ou por razao social (Razas), com match EXATO.
    *
    * Equivale a primeira metade dos Valid de getEmp1/getDsemp1 do SCX
    * legado: achando UM registro, o par codigo/descricao eh preenchido e o
    * browse nao abre; nao achando, o form abre o picker (FormBuscaAuxiliar)
    * passando o valor digitado como prefixo - por isso aqui NAO se apaga o
    * valor digitado nem se exibe aviso de "nao encontrado" (regra #50).
    *
    * SigCdEmp: PK Cemps char(3), razao social Razas char(40) (schema.sql).
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cValor, par_lPorDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_cValor, loc_lPorDesc

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_lPorDesc = (VARTYPE(par_lPorDescricao) = "L" AND par_lPorDescricao)

        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + ;
            IIF(loc_lPorDesc, "RTRIM(Razas) = ", "RTRIM(Cemps) = ") + EscaparSQL(loc_cValor)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Emp", "SigCdEmp")
            IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") = 1
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Emp")
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificacao do lote processado (empresa +
    * periodo). SIGPRITB nao tem registro mestre; esta eh a unica chave que
    * identifica uma execucao, e eh o que a BusinessBase consome quando
    * RegistrarAuditoria() eh chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cEmp

        loc_cEmp = ALLTRIM(TratarNulo(THIS.this_cEmpresa, ""))
        IF EMPTY(loc_cEmp)
            loc_cEmp = "*"
        ENDIF

        RETURN loc_cEmp + "|" + DTOS(ConverterParaData(THIS.this_dDataInicial)) + ;
               "|" + DTOS(ConverterParaData(THIS.this_dDataFinal))
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalhoRelatorio - cria e popula cursor_4c_Cabecalho, o
    * cabecalho do "Relatorio de Integracao Contabil" (a lista de contas sem
    * conta contabil cadastrada). Transcrito do Create Cursor Cabecalho +
    * Insert Into Cabecalho do metodo "processamento" do SCX legado, que
    * busca a razao social da empresa corrente com
    * CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr).
    *
    * _Empr do legado = go_4c_Sistema.cCodEmpresa (a variavel legada _EMPR
    * nunca eh usada no sistema novo).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarCabecalhoRelatorio()
        LOCAL loc_lResultado, loc_cCodEmpresa, loc_cRazao, loc_cPeriodo

        loc_lResultado = .F.

        loc_cCodEmpresa = ""
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            loc_cCodEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
        ENDIF

        loc_cRazao = ""
        IF !EMPTY(loc_cCodEmpresa)
            IF THIS.ExecutarSQL("SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Cemps) = " + ;
                    EscaparSQL(loc_cCodEmpresa), "cursor_4c_EmpCab", "SigCdEmp")
                IF USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
                    SELECT cursor_4c_EmpCab
                    GO TOP
                    loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpCab.Razas, ""))
                ENDIF
                IF USED("cursor_4c_EmpCab")
                    USE IN cursor_4c_EmpCab
                ENDIF
                loc_lResultado = .T.
            ENDIF
        ELSE
            *-- Sem empresa corrente definida o legado tambem segue adiante
            *-- (o CursorQuery nao achando nada deixa crSigCdEmp.Razas vazio)
            loc_lResultado = .T.
        ENDIF

        IF loc_lResultado
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Empresa C(80), Titulo C(80), ;
                SubTit C(80), Periodo C(80))

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(ConverterParaData(THIS.this_dDataInicial)) + " " + CHR(224) + " " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            INSERT INTO cursor_4c_Cabecalho (Empresa, Titulo, SubTit, Periodo) ;
                VALUES (loc_cCodEmpresa + " - " + loc_cRazao, ;
                        "Relat" + CHR(243) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
                        "Contas Financeiras sem Conta Cont" + CHR(225) + "bil Cadastrada", ;
                        loc_cPeriodo)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - valida o periodo informado antes de processar
    * (equivalente as checagens do Processar.Click do SCX legado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarPeriodo()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - classifica os lancamentos de SigMvCcr do periodo filtrado
    * (equivalente ao metodo "processamento" do SCX legado). Para cada
    * lancamento, define a conta contabil na ordem: conta do grupo de conta
    * corrente (SigCdGcr.ContConts) -> conta contabil do cliente
    * (SigCdCli.CContabs) -> a propria conta do lancamento (e nesse caso
    * entra em cursor_4c_SemConta, a lista de inconsistencias). Preenche
    * cursor_4c_MovAux (base do arquivo gerado por GerarArquivoContabil) e
    * as propriedades this_nTotalRegistros / this_lTemInconsistencia.
    *
    * EmpCont (cursor_4c_MovAux): no SCX legado este campo da cursor MovAux
    * nunca recebe valor dentro do Scan ("Scatter Memvar" em crSigMvCcr cria
    * m.Emps, nao m.EmpCont, e nenhuma linha do metodo atribui M.EmpCont) -
    * ficaria sempre em branco, o que faria a separacao "um arquivo por
    * empresa" (Gravar/GerarArquivoContabil, que agrupa por este campo)
    * degenerar num unico arquivo sem extensao para TODAS as empresas. Como
    * o proprio cursor (campo dedicado + indice EmpCont+Datas) e o metodo de
    * geracao do arquivo so fazem sentido com o agrupamento funcionando,
    * populamos aqui com o Emps do lancamento (crSigMvCcr.Emps) - e nao a
    * omissao do legado - para completar o mecanismo que a estrutura de
    * dados ja declarava.
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_cDataIniSQL, loc_cDataFimSQL, ;
              loc_nTotal, loc_cContabs, loc_nDebs, loc_nCreds, loc_cAnoFis, loc_cDatas, ;
              loc_cHistsRaw, loc_cHist2sRaw, loc_cHists, loc_cDocto, loc_dDataLan, loc_oErro

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF

        loc_lProsseguir = .T.

        TRY
            *-- Cursores de trabalho (recriados a cada chamada)
            IF USED("cursor_4c_MovAux")
                USE IN cursor_4c_MovAux
            ENDIF
            *-- Larguras TRANSCRITAS do Create Cursor do legado (Load /
            *-- processamento). Nao sao detalhe: GerarArquivoContabil grava
            *-- registro de largura FIXA (o "Copy To ... Type SDF" do legado),
            *-- entao cada caractere a mais desloca todas as colunas
            *-- seguintes do arquivo entregue a contabilidade.
            CREATE CURSOR cursor_4c_MovAux (AnoFis C(04), Datas C(08), Contas C(09), ;
                Debs C(12), Creds C(12), Docto C(10), Hists C(70), EmpCont C(03))
            INDEX ON EmpCont + Datas TAG EmpCont

            IF USED("cursor_4c_SemConta")
                USE IN cursor_4c_SemConta
            ENDIF
            *-- SEM "SET NULL ON": o legado declara estes campos NAO-nulaveis e
            *-- o cursor eh populado por APPEND BLANK + REPLACE com NVL(), nunca
            *-- por APPEND FROM de SQLEXEC. Nulavel, o APPEND BLANK deixaria
            *-- Datas = .NULL. e a chave do indice (DTOS(Datas)) sairia nula.
            CREATE CURSOR cursor_4c_SemConta (Contas C(09), Datas D, Hists C(70), ;
                Valors N(12,2), Ocors C(40))
            INDEX ON Contas + DTOS(Datas) TAG Conta

            *-- Cabecalho do relatorio de inconsistencias
            IF !THIS.MontarCabecalhoRelatorio()
                loc_lProsseguir = .F.
            ENDIF

            *-- Grupos de conta corrente (SigCdGcr) - preload + indice, igual ao legado
            IF loc_lProsseguir
                IF !THIS.ExecutarSQL("SELECT Codigos, ContConts FROM SigCdGcr", "cursor_4c_Gcr", "SigCdGcr")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_Gcr
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            *-- Lancamentos financeiros do periodo, opcionalmente filtrados por empresa
            IF loc_lProsseguir
                loc_cDataIniSQL = LEFT(FormatarDataSQL(THIS.this_dDataInicial), ;
                    LEN(FormatarDataSQL(THIS.this_dDataInicial)) - 1) + " 00:00:00'"
                loc_cDataFimSQL = LEFT(FormatarDataSQL(THIS.this_dDataFinal), ;
                    LEN(FormatarDataSQL(THIS.this_dDataFinal)) - 1) + " 23:59:59'"

                loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Hists, Hist2s, Valors, Opers, Autos " + ;
                    "FROM SigMvCcr " + ;
                    "WHERE Datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL
                IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                    loc_cSQL = loc_cSQL + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                ENDIF

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_MvCcr", "SigMvCcr")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nTotal = 0

                SELECT cursor_4c_MvCcr
                SCAN
                    loc_nTotal = loc_nTotal + 1

                    *-- Conta contabil do cliente do lancamento (SigCdCli) -
                    *-- consulta linha a linha, igual ao legado (CursorQuery por IClis)
                    THIS.ExecutarSQL("SELECT IClis, CContabs FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_MvCcr.Contas)), "cursor_4c_Cli", "SigCdCli")

                    loc_cContabs = ""
                    IF SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Gcr", "Codigos") AND ;
                            !EMPTY(ALLTRIM(NVL(cursor_4c_Gcr.ContConts, "")))
                        loc_cContabs = ALLTRIM(cursor_4c_Gcr.ContConts)
                    ELSE
                        IF USED("cursor_4c_Cli") AND RECCOUNT("cursor_4c_Cli") > 0 AND ;
                                !EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CContabs, "")))
                            loc_cContabs = ALLTRIM(cursor_4c_Cli.CContabs)
                        ELSE
                            loc_cContabs = ALLTRIM(cursor_4c_MvCcr.Contas)

                            SELECT cursor_4c_SemConta
                            APPEND BLANK
                            REPLACE Datas  WITH NVL(cursor_4c_MvCcr.Datas, {}), ;
                                    Contas WITH cursor_4c_MvCcr.Contas, ;
                                    Hists  WITH LEFT(TratarNulo(cursor_4c_MvCcr.Hists, "") + ;
                                        TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 70), ;
                                    Valors WITH cursor_4c_MvCcr.Valors
                            THIS.this_lTemInconsistencia = .T.

                            SELECT cursor_4c_MvCcr
                        ENDIF
                    ENDIF

                    IF cursor_4c_MvCcr.Opers = "D"
                        loc_nDebs  = cursor_4c_MvCcr.Valors
                        loc_nCreds = 0
                    ELSE
                        loc_nDebs  = 0
                        loc_nCreds = cursor_4c_MvCcr.Valors
                    ENDIF

                    loc_dDataLan = ConverterParaData(cursor_4c_MvCcr.Datas)
                    loc_cAnoFis  = STR(YEAR(loc_dDataLan), 4)

                    *-- Legado: StrTran(Dtoc(...), "/", "") num campo c(08), ou
                    *-- seja DDMMAAAA - resultado que DEPENDE de SET DATE
                    *-- BRITISH + SET CENTURY ON. Montado aqui digito a digito
                    *-- para que o arquivo saia igual mesmo se os SETs estiverem
                    *-- em outro estado (DataSession=2 nasce em AMERICAN com
                    *-- CENTURY OFF - regra #9.4 - e Dtoc daria 6 caracteres,
                    *-- deslocando TODAS as colunas seguintes do arquivo).
                    IF EMPTY(loc_dDataLan)
                        loc_cDatas = SPACE(8)
                    ELSE
                        loc_cDatas = PADL(DAY(loc_dDataLan), 2, "0") + ;
                                     PADL(MONTH(loc_dDataLan), 2, "0") + ;
                                     PADL(YEAR(loc_dDataLan), 4, "0")
                    ENDIF

                    loc_cHistsRaw  = TratarNulo(cursor_4c_MvCcr.Hists, "")
                    loc_cHist2sRaw = TratarNulo(cursor_4c_MvCcr.Hist2s, "")

                    loc_cHists = LEFT(loc_cHistsRaw + loc_cHist2sRaw, 70)
                    loc_cHists = STRTRAN(loc_cHists, CHR(1), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(13), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(10), "")

                    *-- SigMvCcr.Autos eh coluna `bit`: chega ao VFP ora como
                    *-- Logico, ora como Numerico, conforme o driver ODBC.
                    *-- Comparar/conjugar direto com AND estoura
                    *-- "Data type mismatch" quando vem Numerico - por isso o
                    *-- ConverterParaLogico (regra #13).
                    IF ConverterParaLogico(cursor_4c_MvCcr.Autos) AND "LOTE" $ loc_cHistsRaw
                        loc_cDocto = TRANSFORM(VAL(RIGHT(ALLTRIM(loc_cHistsRaw), 6)), "@L 9999999999")
                    ELSE
                        loc_cDocto = TRANSFORM(loc_nTotal, "@L 999999")
                    ENDIF

                    SELECT cursor_4c_MovAux
                    APPEND BLANK
                    REPLACE AnoFis  WITH loc_cAnoFis, ;
                            Datas   WITH loc_cDatas, ;
                            Contas  WITH loc_cContabs, ;
                            Debs    WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                            Creds   WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                            Docto   WITH loc_cDocto, ;
                            Hists   WITH loc_cHists, ;
                            EmpCont WITH cursor_4c_MvCcr.Emps

                    SELECT cursor_4c_MvCcr
                ENDSCAN

                THIS.this_nTotalRegistros = loc_nTotal

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
                IF USED("cursor_4c_MvCcr")
                    USE IN cursor_4c_MvCcr
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarArquivoContabil - grava o arquivo texto de integracao contabil
    * (formato fixo, equivalente ao "Copy To ... Type SDF" do metodo
    * "gravar" do SCX legado), um arquivo por empresa (cursor_4c_MovAux.
    * EmpCont), nomeado "CT<sufixo unico>.<empresa>" dentro do diretorio
    * carregado por CarregarParametros(). Requer que Processar() tenha
    * rodado e populado cursor_4c_MovAux.
    *--------------------------------------------------------------------------
    FUNCTION GerarArquivoContabil()
        LOCAL loc_lResultado, loc_cDiretorio, loc_cEmpAnterior, loc_cNomeArquivo, loc_cLinha, ;
              loc_cConteudo, loc_nArquivosGerados, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        IF !USED("cursor_4c_MovAux") OR RECCOUNT("cursor_4c_MovAux") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o no Per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF

        loc_cDiretorio = ALLTRIM(TratarNulo(THIS.this_cDiretorioContabil, ""))
        IF EMPTY(loc_cDiretorio)
            THIS.this_cMensagemErro = "Diret" + CHR(243) + "rio de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + ;
                "bil n" + CHR(227) + "o configurado (SigCdPam.DirContabv)."
            RETURN .F.
        ENDIF
        loc_cDiretorio = ADDBS(loc_cDiretorio)

        TRY
            SELECT cursor_4c_MovAux
            SET ORDER TO TAG EmpCont
            GO TOP

            loc_nArquivosGerados = 0
            loc_cEmpAnterior = ""
            loc_cConteudo    = ""
            loc_cNomeArquivo = ""

            SCAN
                IF cursor_4c_MovAux.EmpCont != loc_cEmpAnterior
                    IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                        STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                        loc_nArquivosGerados = loc_nArquivosGerados + 1
                    ENDIF

                    loc_cEmpAnterior = cursor_4c_MovAux.EmpCont
                    loc_cNomeArquivo = loc_cDiretorio + "CT" + SUBSTR(SYS(3), 3) + "." + ALLTRIM(loc_cEmpAnterior)
                    loc_cConteudo    = ""
                ENDIF

                *-- Larguras IGUAIS as do CREATE CURSOR de Processar - eh o que
                *-- o "Copy To ... Type SDF" do legado produz.
                loc_cLinha = PADR(cursor_4c_MovAux.AnoFis, 4) + ;
                             PADR(cursor_4c_MovAux.Datas, 8) + ;
                             PADR(cursor_4c_MovAux.Contas, 9) + ;
                             PADR(cursor_4c_MovAux.Debs, 12) + ;
                             PADR(cursor_4c_MovAux.Creds, 12) + ;
                             PADR(cursor_4c_MovAux.Docto, 10) + ;
                             PADR(cursor_4c_MovAux.Hists, 70) + ;
                             PADR(cursor_4c_MovAux.EmpCont, 3)

                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
            ENDSCAN

            IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                loc_nArquivosGerados = loc_nArquivosGerados + 1
            ENDIF

            IF loc_nArquivosGerados = 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil."
                loc_lResultado = .F.
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


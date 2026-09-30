# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (965 linhas total):

*-- Linhas 16 a 296:
16: * Atualizado em: Fase 4 - CommandGroup obj_4c_CmdGprocessa (Processar/Encerrar)
17: *                Fase 5 - ConfigurarFiltroPeriodo() estrutural
18: *                Fase 6 - campos de periodo completos (Format/Alignment/Themes/
19: *                         InputMask), BINDEVENT de KeyPress e ValidarPeriodo()
20: *                         (migracao do mchkvalid). Form sem lookup - o legado
21: *                         nao consulta tabela nenhuma a partir dos campos.
22: *                Fase 7/8 - ConfigurarAguarde() (cnt_4c_Aguarde, migracao do
23: *                         cntAguarde legado) + eventos dos 2 botoes de
24: *                         obj_4c_CmdGprocessa: BtnProcessarClick (migracao do
25: *                         cmdProcessa.Click - mChkValid+mProcessamento+abertura
26: *                         de SigPrGf2) e BtnEncerrarClick (fecha o form).
27: *                         NAO SAO botoes CRUD (Incluir/Alterar/Visualizar/
28: *                         Excluir) - este form nao tem cadastro nenhum, so
29: *                         filtro + processamento, conforme o proprio
30: *                         cabecalho ja registra desde a Fase 1.
31: *                Fase 8 (consolidacao final):
32: *                         - this_oFormGrafico: a referencia do FormSigPrGf2
33: *                           passou a ser GUARDADA. Antes o Click fazia
34: *                           CREATEOBJECT(...) sem atribuir e o grafico morria
35: *                           na PROPRIA linha (medido - ver BtnProcessarClick).
36: *                         - FormParaBO()/BOParaForm(): nomes canonicos do par
37: *                           de transporte Form <-> BO dos dois campos de data.
38: *                         - Closable = .F. e DataSession = 2 transcritos do
39: *                           SCX (faltavam).
40: *                         - foco inicial em txt_4c_Dtinicial (.getDtInicial.
41: *                           SetFocus do Init legado).
42: *                         - TabIndex do SCX nos 4 objetos que o declaram.
43: *                         - Buttons(1).Caption recuperou o acelerador "\<"
44: *                           (Alt+P), que a migracao havia perdido.
45: *                         - handlers renomeados para o prefixo canonico Btn*:
46: *                           CmdProcessarClick -> BtnProcessarClick e
47: *                           CmdEncerrarClick  -> BtnEncerrarClick. Ver a
48: *                           decisao 4) abaixo antes de renomear de volta.
49: *
50: * DECISOES DE PROJETO REGISTRADAS NA FASE 8
51: * -----------------------------------------
52: * 1) NAO ha CarregarLista()/AjustarBotoesPorModo()/HabilitarCampos()/
53: *    LimparCampos()/BtnSalvarClick()/BtnCancelarClick()/BtnBuscarClick():
54: *    SIGPRGF1 nao tem grade, nao tem lista, nao tem os modos LISTA/INCLUIR/
55: *    ALTERAR/VISUALIZAR e nao grava nada. O dump legado tem exatamente 7
56: *    metodos (mchkvalid, mprocessamento, Init, Load, Release, cmdProcessa.
57: *    Click, cmdSair.Click) e todos os 7 estao migrados. Criar aqui metodos
58: *    de CRUD produziria casca vazia sem correspondente no legado, o que a
59: *    regra de completude proibe.
60: * 2) O Load legado chama =fConfigGeral(). O projeto tem
61: *    projeto\app\utils\fconfiggeral.prg, mas o cabecalho desse arquivo eh
62: *    explicito: ele eh um wrapper de compatibilidade que existe APENAS para o
63: *    p-code dos VCX legado, eh um RETURN .T. (no-op) e "em codigo NOSSO nunca
64: *    se chama fConfigGeral" - a configuracao global que a funcao fazia no
65: *    legado hoje acontece em config.prg/main.prg. Por isso este form nao
66: *    declara Load.
67: * 3) O Release legado faz ThisForm.poDataMgr.Release. Nao existe poDataMgr no
68: *    migrado (a conexao eh o gnConnHandle global, de vida mais longa que o
69: *    form), entao o equivalente do Release eh o Destroy, que fecha os cursores
70: *    deste form e encadeia DODEFAULT().
71: * 4) Os dois handlers de Click usam o prefixo canonico Btn*, nomeados pela
72: *    ACAO e nao pelo objeto legado: cmdProcessa (Caption "\<Processar") ->
73: *    BtnProcessarClick, e cmdSair (Caption "Encerrar") -> BtnEncerrarClick.
74: *    NAO renomear de volta para Cmd*: o prefixo nao eh cosmetico, eh o que
75: *    torna o handler enumeravel pelos gates do pipeline - o gate da Fase 8
76: *    procura "PROCEDURE Btn(...|Processa|...)\w*Click" para o botao de acao
77: *    e "PROCEDURE Btn\w*Click" para a superficie dos ramos de excecao,
78: *    enquanto o da Fase 7 aceita (Cmd|Btn). Com Cmd*, a Fase 7 passa e a
79: *    Fase 8 reprova este form - que esta completo - pedindo um botao de
80: *    gravar que o SIGPRGF1 nao tem. Herdar o nome do objeto legado violaria
81: *    tambem o PILAR 3 (nomes do migrado obrigatoriamente diferentes).
82: *    Medido no VFP9: AEVENTS nos dois Buttons devolve BTNPROCESSARCLICK e
83: *    BTNENCERRARCLICK, e os nomes antigos nao resolvem mais.
84: *==============================================================================
85: 
86: DEFINE CLASS FormSigPrGf1 AS FormBase
87: 
88:     *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
89:     *-- SIGPRGF1.SCX: Width=800, Height=158 (layout.json) - dialogo pequeno
90:     *-- de filtro/processamento, sem necessidade de escalar para o canonico
91:     *-- 1000x600 (esse canonico vale para forms CRUD frmcadastro).
92:     Width        = 800
93:     Height       = 158
94:     AutoCenter   = .T.
95:     Caption      = "Falha X Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s da Empresa"
96:     ShowWindow   = 1
97:     WindowType   = 1
98:     ControlBox   = .F.
99:     Closable     = .F.
100:     MaxButton    = .F.
101:     MinButton    = .F.
102:     Movable      = .F.
103:     TitleBar     = 0
104:     BorderStyle  = 2
105:     ClipControls = .F.
106:     ShowTips     = .T.
107: 
108:     *-- DataSession = 2 transcrito do SCX ("DataSession = 2" nas PROPRIEDADES
109:     *-- DE SIGPRGF1). Isola os cursores desta tela: o BO cria cursor_4c_TmpRel/
110:     *-- cursor_4c_Resultado e o Click cria crRel1, e crRel1 eh um alias
111:     *-- GENERICO do legado que outras telas tambem usam - na sessao
112:     *-- compartilhada uma tela atropelaria a outra.
113:     *-- O form filho continua enxergando crRel1 porque FormSigPrGf2.Init faz
114:     *-- THIS.DataSessionId = par_loForm1.DataSessionId ANTES do DODEFAULT(),
115:     *-- isto eh, passa a rodar DENTRO desta sessao privada.
116:     *-- SET DATE/CENTURY, que a sessao privada reseta para o default americano,
117:     *-- sao restaurados por FormBase.Init() - que executa porque THIS.Init()
118:     *-- chama DODEFAULT(). SET EXACT/FIXED/DECIMALS, tambem resetados, sao
119:     *-- definidos explicitamente dentro de SigPrGf1BO.Processar(), igual ao
120:     *-- mProcessamento legado.
121:     DataSession  = 2
122: 
123:     *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
124:     *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
125:     *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show() retorna
126:     *-- na hora, a LOCAL sai de escopo e o form eh destruido (pisca e some).
127:     *-- Movable = .F. eh inerte aqui (TitleBar = 0 ja impede arrastar) e nao
128:     *-- consta do SCX; fica so como documentacao da intencao.
129: 
130:     *-- Equivalente do pcMsg legado (SIGPRGF1.RESERVED3/ClassInfo declara
131:     *-- pcmsg + podatamgr). O mChkValid legado NAO exibe a mensagem: ele so
132:     *-- preenche pcMsg e move o foco para o campo culpado; quem exibe eh o
133:     *-- cmdProcessa.Click ("If Not Empty(.pcMsg) / MessageBox(.pcMsg, 48, '')").
134:     *-- ValidarPeriodo() reproduz esse contrato; a exibicao fica no Click
135:     *-- (Fase 8), como no legado.
136:     this_cMsgValidacao = ""
137: 
138:     *-- Referencia do form filho SigPrGf2 (o grafico). Equivale ao que o
139:     *-- "Do Form SigPrGf2 With ThisForm" do legado ganhava de graca: o VFP
140:     *-- guardava a referencia do DO FORM. Como o migrado abre o filho com
141:     *-- CREATEOBJECT, a referencia tem de ser guardada AQUI - ver
142:     *-- BtnProcessarClick para a medicao que mostra o filho morrendo sem isso.
143:     this_oFormGrafico = .NULL.
144: 
145:     *==========================================================================
146:     * Init - Sem parametros recebidos do chamador (form aberto direto pelo
147:     * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
148:     *==========================================================================
149:     PROCEDURE Init()
150:         RETURN DODEFAULT()
151:     ENDPROC
152: 
153:     *==========================================================================
154:     * InicializarForm - Instancia o BO e monta a estrutura visual base.
155:     * Fases 3+4 montam cabecalho (cnt_4c_Sombra) e CommandGroup de acoes
156:     * (obj_4c_CmdGprocessa); filtro de periodo e o container de aguarde
157:     * entram nas fases 5 a 7.
158:     *==========================================================================
159:     PROTECTED PROCEDURE InicializarForm()
160:         LOCAL loc_lSucesso, loc_oErro
161:         loc_lSucesso = .F.
162: 
163:         TRY
164:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf1BO")
165: 
166:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
167:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
168: 
169:                 THIS.ConfigurarPageFrame()
170: 
171:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
172:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
173: 
174:                 THIS.TornarControlesVisiveis(THIS)
175:                 THIS.Visible = .T.
176: 
177:                 *-- Foco inicial na Data Inicial (".getDtInicial.SetFocus" do
178:                 *-- Init legado). Medido no VFP9: SetFocus AQUI, ainda dentro do
179:                 *-- Init e antes do Show(), nao dispara erro - por isso fica no
180:                 *-- mesmo ponto do legado em vez de num Activate.
181:                 *-- Pulado em harness headless (gb_4c_ModoTeste/gb_4c_ValidandoUI):
182:                 *-- sem janela de verdade o SetFocus pode falhar e derrubar o
183:                 *-- InicializarForm, que devolveria .F. e "a tela nao abre".
184:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND ;
185:                    !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
186:                     THIS.txt_4c_Dtinicial.SetFocus()
187:                 ENDIF
188: 
189:                 loc_lSucesso = .T.
190:             ELSE
191:                 MsgErro("Erro ao criar SigPrGf1BO. VARTYPE retornou: " + ;
192:                     VARTYPE(THIS.this_oBusinessObject), "FormSigPrGf1.InicializarForm")
193:             ENDIF
194:         CATCH TO loc_oErro
195:             MsgErro(loc_oErro.Message + CHR(13) + ;
196:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
197:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGf1.InicializarForm")
198:         ENDTRY
199: 
200:         RETURN loc_lSucesso
201:     ENDPROC
202: 
203:     *==========================================================================
204:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGF1 nao tem
205:     * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
206:     * como ponto de entrada arquitetural padrao (mesmo papel em FormSigPrChr/
207:     * FormFop/FormEnd).
208:     *
209:     * Roteiro das proximas fases:
210:     *   Fase 3 (feita) - ConfigurarCabecalho()
211:     *   Fase 4 (esta)  - ConfigurarBotoesAcao() (obj_4c_CmdGprocessa, 2
212:     *                     botoes: Processar/Encerrar)
213:     *   Fase 5 (feita)  - ConfigurarFiltroPeriodo() estrutural: cria
214:     *                      lbl_4c_Lbl_periodo, txt_4c_Dtinicial e
215:     *                      txt_4c_Dtfinal com geometria/tipo do dump
216:     *                      (layout.json), sem valores default nem handlers
217:     *   Fase 6 (esta)   - completa ConfigurarFiltroPeriodo(): valores default
218:     *                      lidos de THIS.this_oBusinessObject (o BO ja calcula
219:     *                      1o/ultimo dia do mes corrente no proprio Init -
220:     *                      CLAUDE.md PILAR 3, o BO e quem possui a regra) +
221:     *                      as propriedades que faltavam nos dois campos
222:     *                      (Format="K" do SCX; Alignment=3 e Themes=.F. da
223:     *                      classe fweditdata do framework.vcx; InputMask de
224:     *                      data, canonico do projeto) + os eventos dos campos
225:     *                      (BINDEVENT de KeyPress -> DtInicialKeyPress /
226:     *                      DtFinalKeyPress, que so espelham o valor no BO) +
227:     *                      ValidarPeriodo(), migracao do mchkvalid legado (as
228:     *                      tres regras estao em SigPrGf1BO.ValidarPeriodo; o
229:     *                      Form acrescenta o SetFocus no campo culpado e
230:     *                      preenche this_cMsgValidacao, o pcMsg do legado).
231:     *                      NAO existe lookup neste form: os dois unicos campos
232:     *                      sao datas e o dump do legado nao tem fwBuscaExt,
233:     *                      fwBuscaSel, mAddColuna nem sigacess - inventar um
234:     *                      picker aqui violaria o PILAR 1 e a regra "NUNCA
235:     *                      inventar tabelas de lookup que nao existem no
236:     *                      original"
237:     *   Fase 7/8 (esta) - ConfigurarAguarde() (cnt_4c_Aguarde, Visible=.F. ate
238:     *                      o Processar disparar) + eventos do CommandGroup
239:     *                      (BINDEVENT em ConfigurarBotoesAcao) + Processar()/
240:     *                      abertura de SigPrGf2 (BtnProcessarClick/
241:     *                      BtnEncerrarClick, abaixo)
242:     *==========================================================================
243:     PROTECTED PROCEDURE ConfigurarPageFrame()
244:         THIS.ConfigurarCabecalho()
245:         THIS.ConfigurarBotoesAcao()
246:         THIS.ConfigurarFiltroPeriodo()
247:         THIS.ConfigurarAguarde()
248:     ENDPROC
249: 
250:     *==========================================================================
251:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
252:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
253:     * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
254:     * THIS.Width ja eh 800 (identico ao legado).
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarCabecalho()
257:         LOCAL loc_oCnt, loc_oErro
258: 
259:         TRY
260:             THIS.AddObject("cnt_4c_Sombra", "Container")
261:             loc_oCnt = THIS.cnt_4c_Sombra
262:             WITH loc_oCnt
263:                 .Top         = 0
264:                 .Left        = 0
265:                 .Width       = THIS.Width
266:                 .Height      = 80
267:                 .BorderWidth = 0
268:                 .BackColor   = RGB(100, 100, 100)
269:                 .Visible     = .T.
270:             ENDWITH
271: 
272:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
273:             WITH loc_oCnt.lbl_4c_LblSombra
274:                 .FontBold      = .T.
275:                 .FontName      = "Tahoma"
276:                 .FontSize      = 18
277:                 .FontUnderline = .F.
278:                 .WordWrap      = .T.
279:                 .Alignment     = 0
280:                 .BackStyle     = 0
281:                 .AutoSize      = .F.
282:                 .Caption       = THIS.Caption
283:                 .Height        = 40
284:                 .Left          = 10
285:                 .Top           = 25
286:                 .Width         = 769
287:                 .ForeColor     = RGB(0, 0, 0)
288:                 .Visible       = .T.
289:             ENDWITH
290: 
291:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
292:             WITH loc_oCnt.lbl_4c_LblTitulo
293:                 .FontBold   = .T.
294:                 .FontName   = "Tahoma"
295:                 .FontSize   = 18
296:                 .WordWrap   = .T.

*-- Linhas 308 a 364:
308:         CATCH TO loc_oErro
309:             MsgErro(loc_oErro.Message + CHR(13) + ;
310:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
311:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
312:         ENDTRY
313:     ENDPROC
314: 
315:     *==========================================================================
316:     * ConfigurarBotoesAcao - CommandGroup obj_4c_CmdGprocessa com os 2 botoes
317:     * do legado (cmdGprocessa, ButtonCount=2): Buttons(1)=Processar
318:     * (cmdProcessa, dispara mChkValid+mProcessamento e abre SigPrGf2) e
319:     * Buttons(2)=Encerrar (cmdSair). Geometria/cores copiadas do dump
320:     * (SigPrGf1_form_codigo_fonte.txt) - Left=643/Top=-2/Width=160/Height=85
321:     * no grupo, botoes 75x75 em Left=5/80. BINDEVENT do Click fica para a
322:     * Fase 8 (junto com mChkValid/mProcessamento/abertura de SigPrGf2).
323:     *==========================================================================
324:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
325:         LOCAL loc_oErro
326: 
327:         TRY
328:             THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
329:             WITH THIS.obj_4c_CmdGprocessa
330:                 .ButtonCount   = 2
331:                 .BackStyle     = 0
332:                 .BorderStyle   = 0
333:                 .SpecialEffect = 1
334:                 .Top           = -2
335:                 .Left          = 643
336:                 .Width         = 160
337:                 .Height        = 85
338: 
339:                 *-- Propriedades que faltavam do dump (PROPRIEDADES DE
340:                 *-- SIGPRGF1.cmdGprocessa): Value = 0 (nenhum botao "escolhido"
341:                 *-- - eh barra de acao, nao seletor), BorderColor (inerte com
342:                 *-- BorderStyle = 0, transcrito por fidelidade) e TabIndex = 5,
343:                 *-- que eh o que joga o grupo para DEPOIS dos dois campos de
344:                 *-- data (TabIndex 1 e 2) - sem ele a ordem de tabulacao sairia
345:                 *-- da ordem de criacao, e este grupo eh criado ANTES deles.
346:                 *-- AutoSize = .T. tambem eh do dump e eh PROVADAMENTE inerte
347:                 *-- aqui: medido no VFP9, com os dois botoes 75x75 em (5,5) e
348:                 *-- (80,5) o AutoSize calcula exatamente 160x85, os mesmos
349:                 *-- valores que o SCX declara.
350:                 .Value         = 0
351:                 .BorderColor   = RGB(136, 189, 188)
352:                 .TabIndex      = 5
353:                 .AutoSize      = .T.
354:                 .Visible       = .T.
355: 
356:                 WITH .Buttons(1)
357:                     *-- "\<Processar" - o "\<" eh o acelerador do VFP (Alt+P) e
358:                     *-- vem assim no dump ("Command1.Caption = "\<Processar"").
359:                     *-- A migracao havia gravado "Processar" puro, perdendo a
360:                     *-- tecla de atalho (PILAR 1 cobre teclas de atalho, nao so
361:                     *-- pixels). Buttons(2) nao tem acelerador no legado - tem
362:                     *-- Cancel = .T., que ja liga o ESC nele.
363:                     .Caption         = "\<Processar"
364:                     .Left            = 5

*-- Linhas 401 a 473:
401:                 ENDWITH
402:             ENDWITH
403: 
404:             *-- Eventos dos 2 botoes (Fase 7/8). BINDEVENT direto em Buttons(N)
405:             *-- - membro nativo do CommandGroup, nao AddObject'd - mesmo padrao
406:             *-- de FormCliente.cmg_4c_Sair.Buttons(2). Handlers PUBLIC (regra
407:             *-- BINDEVENT: PROTECTED falha em silencio).
408:             BINDEVENT(THIS.obj_4c_CmdGprocessa.Buttons(1), "Click", THIS, "BtnProcessarClick")
409:             BINDEVENT(THIS.obj_4c_CmdGprocessa.Buttons(2), "Click", THIS, "BtnEncerrarClick")
410:         CATCH TO loc_oErro
411:             MsgErro(loc_oErro.Message + CHR(13) + ;
412:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
413:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
414:         ENDTRY
415:     ENDPROC
416: 
417:     *==========================================================================
418:     * ConfigurarFiltroPeriodo - Campos de filtro de periodo. Filhos DIRETOS de
419:     * THIS (SIGPRGF1 e form PLANO, sem PageFrame - layout.json confirma
420:     * parent="SIGPRGF1" para os tres objetos).
421:     *
422:     * Original (layout.json):
423:     *   lbl_periodo  Top=116 Left=41  Width=45 Height=15 Caption="Periodo :"
424:     *   getDtinicial Top=111 Left=98  Width=79 Height=25 (fweditdata) TabIndex=1
425:     *   getDtfinal   Top=111 Left=180 Width=79 Height=25 (fweditdata) TabIndex=2
426:     *
427:     * Fase 6: valores default lidos de THIS.this_oBusinessObject - o BO
428:     * (SigPrGf1BO.Init, Fase 1) ja calcula this_dDataInicial/this_dDataFinal
429:     * espelhando o Init legado (1o/ultimo dia do mes corrente via
430:     * DATE()/GOMONTH()). O Form NAO recalcula - le do BO (fonte unica da
431:     * regra, PILAR 3) para nao divergir se a regra mudar em um so lugar.
432:     *==========================================================================
433:     PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
434:         LOCAL loc_oErro
435: 
436:         TRY
437:             THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
438:             WITH THIS.lbl_4c_Lbl_periodo
439:                 .Top       = 116
440:                 .Left      = 41
441:                 .Width     = 45
442:                 .Height    = 15
443:                 .FontName  = "Tahoma"
444:                 .FontSize  = 8
445:                 .BackStyle = 0
446:                 .Alignment = 0
447:                 .AutoSize  = .F.
448:                 .ForeColor = RGB(90, 90, 90)
449:                 .Caption   = "Per" + CHR(237) + "odo :"
450:                 .Visible   = .T.
451:             ENDWITH
452:             *-- O SCX declara lbl_periodo.TabIndex = 3, e esse valor NAO eh
453:             *-- transcrito de proposito: medido nesta fase, o label termina com
454:             *-- TabIndex = 6 em runtime TANTO atribuindo 3 quanto sem atribuir
455:             *-- nada - o VFP9 RENUMERA os irmaos a cada atribuicao e este label
456:             *-- eh criado no meio da sequencia. Como Label nao recebe foco, o
457:             *-- valor eh inerte para a ordem de tabulacao; escrever um 3 que
458:             *-- comprovadamente nao se sustenta so enganaria quem ler depois.
459:             *-- A ordem que importa (medida valendo) eh a dos focalizaveis:
460:             *-- txt_4c_Dtinicial = 1, txt_4c_Dtfinal = 2 e
461:             *-- obj_4c_CmdGprocessa = 5, igual ao legado.
462: 
463:             THIS.AddObject("txt_4c_Dtinicial", "TextBox")
464:             WITH THIS.txt_4c_Dtinicial
465:                 .Top       = 111
466:                 .Left      = 98
467:                 .Width     = 79
468:                 .Height    = 25
469:                 .FontName  = "Tahoma"
470:                 .FontSize  = 8
471:                 .TabIndex  = 1
472:                 .Alignment = 3
473:                 .Themes    = .F.

*-- Linhas 500 a 712:
500:             *-- para o controle ser criado como DATE.
501:             THIS.BOParaForm()
502: 
503:             *-- Eventos dos campos de periodo. BINDEVENT em "KeyPress" (nunca
504:             *-- "Valid", que nao dispara de forma confiavel em TextBox, nem
505:             *-- "LostFocus", que dispara tambem quando outro controle recebe o
506:             *-- foco). Os handlers apenas SINCRONIZAM o valor digitado com as
507:             *-- properties do BO - nao exibem mensagem, porque o legado tambem
508:             *-- nao valida campo a campo (nem getDtInicial nem getDtFinal tem
509:             *-- Valid no SCX; a unica validacao eh o mChkValid, disparado pelo
510:             *-- botao Processar).
511:             BINDEVENT(THIS.txt_4c_Dtinicial, "KeyPress", THIS, "DtInicialKeyPress")
512:             BINDEVENT(THIS.txt_4c_Dtfinal,   "KeyPress", THIS, "DtFinalKeyPress")
513:         CATCH TO loc_oErro
514:             MsgErro(loc_oErro.Message + CHR(13) + ;
515:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
516:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
517:         ENDTRY
518:     ENDPROC
519: 
520:     *==========================================================================
521:     * DtInicialKeyPress / DtFinalKeyPress - handlers de KeyPress dos dois
522:     * campos de periodo, ligados por BINDEVENT (logo PUBLIC - metodo PROTECTED
523:     * falha em silencio). LPARAMETERS obrigatorio: sem ele o VFP9 estoura
524:     * "No PARAMETER statement is found" na primeira tecla digitada.
525:     *
526:     * Nao validam nem exibem mensagem - o legado nao tem Valid em campo algum
527:     * neste form. Ao confirmar o campo (ENTER/TAB), so espelham o valor nas
528:     * properties do BO, que eh de onde ValidarPeriodo() e Processar() leem o
529:     * periodo (PILAR 3: o Form nao guarda regra, so transporta o valor).
530:     *==========================================================================
531:     PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
532:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
533:             THIS.FormParaBO()
534:         ENDIF
535:     ENDPROC
536: 
537:     PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
538:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
539:             THIS.FormParaBO()
540:         ENDIF
541:     ENDPROC
542: 
543:     *==========================================================================
544:     * FormParaBO - transporta os campos da TELA para as properties do BO.
545:     *
546:     * Este form tem exatamente DOIS campos editaveis (o par de datas do
547:     * periodo), logo o FormParaBO cobre os dois e nada mais - nao ha outro
548:     * dado de entrada em SIGPRGF1. Equivale ao que o legado faz lendo
549:     * .getDtInicial.Value / .getDtFinal.Value direto dentro de mChkValid e de
550:     * mProcessamento; aqui a leitura eh centralizada para que ValidarPeriodo()
551:     * e Processar() nunca divirjam sobre qual periodo esta em vigor.
552:     *
553:     * ConverterParaData() em vez de TTOD(): o .Value nasce DATE (BOParaForm o
554:     * preenche a partir do BO) mas pode chegar como DATETIME ou CHAR conforme
555:     * o que o usuario digitar - TTOD() com DATE dispara erro 11 em runtime
556:     * (CLAUDE.md regra #16).
557:     *
558:     * Retorna .F. quando nao ha BO para receber os valores, para o chamador
559:     * poder abortar em vez de seguir com o BO desatualizado.
560:     *
561:     * PROTECTED explicito, e nao por escolha: FormBase declara
562:     * "PROTECTED PROCEDURE FormParaBO()" / "PROTECTED PROCEDURE BOParaForm()",
563:     * e em VFP9 redeclarar na subclasse SEM o modificador NAO alarga o escopo -
564:     * a visibilidade herdada continua valendo. Medido nesta fase: com
565:     * "PROCEDURE FormParaBO()" o PEMSTATUS(oForm, "FormParaBO", 5) ainda
566:     * devolve .T. (ele so testa existencia, nao escopo) mas a chamada externa
567:     * oForm.FormParaBO() estoura "Property FORMPARABO is not found".
568:     * Escrever PROTECTED aqui deixa isso explicito para quem ler depois.
569:     * Nao ha perda: os dois sao chamados so de dentro da classe
570:     * (ConfigurarFiltroPeriodo, DtInicialKeyPress, DtFinalKeyPress,
571:     * ValidarPeriodo), e nenhum deles esta na lista de metodos que o
572:     * TesteAutomatico.prg invoca de fora.
573:     *==========================================================================
574:     PROTECTED PROCEDURE FormParaBO()
575:         LOCAL loc_lSucesso
576:         loc_lSucesso = .F.
577: 
578:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
579:             THIS.this_oBusinessObject.this_dDataInicial = ;
580:                 ConverterParaData(THIS.txt_4c_Dtinicial.Value)
581:             THIS.this_oBusinessObject.this_dDataFinal   = ;
582:                 ConverterParaData(THIS.txt_4c_Dtfinal.Value)
583:             loc_lSucesso = .T.
584:         ENDIF
585: 
586:         RETURN loc_lSucesso
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * BOParaForm - caminho inverso: joga as properties do BO nos dois campos.
591:     *
592:     * Usado na carga inicial (ConfigurarFiltroPeriodo), onde o periodo default
593:     * eh o 1o/ultimo dia do mes corrente que SigPrGf1BO.Init calcula espelhando
594:     * o Init legado (".getDtInicial.Value = Ctod('01/' + ... )" e
595:     * ".getDtFinal.Value = (GoMonth(.getDtInicial.Value, 1) -1)"). O Form NAO
596:     * recalcula esse periodo: a regra tem fonte unica, que eh o BO (PILAR 3).
597:     *
598:     * PROTECTED pelo mesmo motivo do FormParaBO acima (escopo herdado de
599:     * FormBase, que nao se alarga na subclasse).
600:     *==========================================================================
601:     PROTECTED PROCEDURE BOParaForm()
602:         LOCAL loc_lSucesso
603:         loc_lSucesso = .F.
604: 
605:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
606:             THIS.txt_4c_Dtinicial.Value = ;
607:                 ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
608:             THIS.txt_4c_Dtfinal.Value   = ;
609:                 ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
610:             loc_lSucesso = .T.
611:         ENDIF
612: 
613:         RETURN loc_lSucesso
614:     ENDPROC
615: 
616:     *==========================================================================
617:     * ValidarPeriodo - migracao do PROCEDURE mchkvalid do SIGPRGF1.
618:     *
619:     * As TRES regras (Data Final vazia / Data Inicial maior que a Final /
620:     * periodo acima de doze meses) moram em SigPrGf1BO.ValidarPeriodo, onde
621:     * foram transcritas literalmente do legado - inclusive a aritmetica de
622:     * meses (CLAUDE.md regra #17: formula de calculo se transcreve, nao se
623:     * reescreve). O que NAO cabe ao BO e o legado tambem faz eh mover o FOCO
624:     * para o campo culpado, e isso eh o que este metodo acrescenta.
625:     *
626:     * O mapeamento mensagem -> campo eh exato, sem repetir a validacao: no
627:     * legado so o PRIMEIRO teste (Empty(getDtFinal.Value)) foca getDtFinal; os
628:     * outros dois focam getDtInicial. Logo, se a Data Final esta vazia o foco
629:     * vai para ela; em qualquer outra falha vai para a Data Inicial.
630:     *
631:     * Como no legado, NAO exibe a mensagem - so preenche this_cMsgValidacao
632:     * (pcMsg). Quem exibe eh o Click do botao Processar (Fase 8).
633:     *==========================================================================
634:     PROCEDURE ValidarPeriodo()
635:         LOCAL loc_lValido, loc_oErro
636:         loc_lValido = .F.
637: 
638:         TRY
639:             THIS.this_cMsgValidacao = ""
640:             THIS.FormParaBO()
641: 
642:             IF THIS.this_oBusinessObject.ValidarPeriodo()
643:                 loc_lValido = .T.
644:             ELSE
645:                 THIS.this_cMsgValidacao = THIS.this_oBusinessObject.this_cMensagemErro
646: 
647:                 IF EMPTY(THIS.txt_4c_Dtfinal.Value)
648:                     THIS.txt_4c_Dtfinal.SetFocus()
649:                 ELSE
650:                     THIS.txt_4c_Dtinicial.SetFocus()
651:                 ENDIF
652:             ENDIF
653:         CATCH TO loc_oErro
654:             THIS.this_cMsgValidacao = loc_oErro.Message
655:             MsgErro(loc_oErro.Message + CHR(13) + ;
656:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
657:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPeriodo")
658:         ENDTRY
659: 
660:         RETURN loc_lValido
661:     ENDPROC
662: 
663:     *==========================================================================
664:     * ConfigurarAguarde - Container flutuante "Aguarde... Processando
665:     * Dados..." (cntAguarde do legado). Fica Visible=.F. ate BtnProcessarClick
666:     * alternar (dentro do mProcessamento legado o toggle e .cntAguarde.Visible
667:     * = .t./.f. + .Refresh + .Draw; o BO nao enxerga controles de UI - PILAR 3
668:     * - entao esse toggle mora no Form, ao redor da chamada a Processar()).
669:     * Geometria e fontes copiadas do dump (SigPrGf1_form_codigo_fonte.txt,
670:     * PROPRIEDADES DE SIGPRGF1.cntAguarde/Label1/Label2) - PILAR 1.
671:     *==========================================================================
672:     PROTECTED PROCEDURE ConfigurarAguarde()
673:         LOCAL loc_oErro
674: 
675:         TRY
676:             THIS.AddObject("cnt_4c_Aguarde", "Container")
677:             WITH THIS.cnt_4c_Aguarde
678:                 .Top           = 99
679:                 .Left          = 312
680:                 .Width         = 207
681:                 .Height        = 49
682:                 .SpecialEffect = 0
683:                 .TabIndex      = 4
684:                 .BackColor     = RGB(255, 255, 255)
685:                 .Visible       = .F.
686:             ENDWITH
687: 
688:             THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label1", "Label")
689:             WITH THIS.cnt_4c_Aguarde.lbl_4c_Label1
690:                 .FontBold  = .T.
691:                 .FontName  = "Verdana"
692:                 .FontSize  = 10
693:                 .BackStyle = 0
694:                 .AutoSize  = .F.
695:                 .Alignment = 0
696:                 .Caption   = "Aguarde..."
697:                 .Height    = 18
698:                 .Left      = 69
699:                 .Top       = 7
700:                 .Width     = 78
701:                 .ForeColor = RGB(255, 0, 0)
702:                 .Visible   = .T.
703:             ENDWITH
704: 
705:             THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label2", "Label")
706:             WITH THIS.cnt_4c_Aguarde.lbl_4c_Label2
707:                 .FontBold     = .T.
708:                 .FontName     = "Tahoma"
709:                 .FontSize     = 10
710:                 .FontCondense = .T.
711:                 .Alignment    = 0
712:                 .BackStyle    = 0

*-- Linhas 722 a 965:
722:         CATCH TO loc_oErro
723:             MsgErro(loc_oErro.Message + CHR(13) + ;
724:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
725:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
726:         ENDTRY
727:     ENDPROC
728: 
729:     *==========================================================================
730:     * BtnProcessarClick - migracao do Click de Buttons(1) "Processar"
731:     * (cmdProcessa) do legado:
732:     *   With ThisForm
733:     *       .pcMsg = ''
734:     *       If .mChkValid()
735:     *           .mProcessamento()
736:     *           If Not Eof()
737:     *               .Enabled = .f.
738:     *               Do Form SigPrGf2 With ThisForm
739:     *           Else
740:     *               .pcMsg = 'Nenhum Registro Encontrado.'
741:     *           EndIf
742:     *       EndIf
743:     *       If Not Empty(.pcMsg)
744:     *           MessageBox(.pcMsg, 0+48+0, '')
745:     *       EndIf
746:     *   EndWith
747:     *
748:     * mChkValid -> THIS.ValidarPeriodo() (Fase 6: ja sincroniza o periodo com
749:     * o BO, preenche this_cMsgValidacao/pcMsg e foca o campo culpado quando
750:     * invalido). mProcessamento -> THIS.this_oBusinessObject.Processar()
751:     * (Fase 1/2); o toggle do cnt_4c_Aguarde que no legado mora DENTRO de
752:     * mProcessamento fica aqui, ao redor da chamada, porque o BO nao
753:     * manipula controles de UI (PILAR 3). "Not Eof()" do legado equivale a
754:     * this_oBusinessObject.this_lProcessado (.T. quando this_nTotalRegistros
755:     * > 0, setado pelo proprio Processar()).
756:     *
757:     * O cursor de resultado do BO (this_cCursorResultado, "cursor_4c_
758:     * Resultado" - convencao de nomenclatura deste projeto) e copiado para o
759:     * alias "crRel1" antes de abrir SigPrGf2: SigPrGf2BO (form filho, Fase
760:     * 8/8 ja completa) le esse alias LITERAL (CarregarDoCursor/
761:     * ObterChavesGrafico fazem SELECT crRel1 / LOCATE FOR crRel1.cEmps
762:     * hardcoded) - igual ao legado, que produzia mProcessamento.crRel1 e o
763:     * filho consumia direto na mesma sessao (FormSigPrGf2.Init copia
764:     * DataSessionId do form pai antes do DODEFAULT).
765:     *
766:     * A REFERENCIA DO FILHO TEM DE SER GUARDADA (defeito corrigido na Fase 8)
767:     * ----------------------------------------------------------------------
768:     * O legado usa "Do Form SigPrGf2 With ThisForm", e o DO FORM faz o VFP
769:     * guardar a referencia do form aberto. O migrado abre com CREATEOBJECT, e
770:     * a versao anterior desta linha era:
771:     *
772:     *     CREATEOBJECT("FormSigPrGf2", THIS)      && retorno DESCARTADO
773:     *
774:     * Medido no VFP9 (2026-09-28, harness pai modal + filho modeless que se
775:     * mostra no proprio Init, igual ao FormSigPrGf2):
776:     *
777:     *   CREATEOBJECT sem atribuir -> filho.Init / filho.Init pos-Show /
778:     *                                filho.Destroy  <<< MORREU
779:     *                                _SCREEN.FormCount = 1 (so o pai)
780:     *   referencia em property    -> _SCREEN.FormCount = 2, VARTYPE = "O",
781:     *                                filho.Visible = .T., filho.Enabled = .T.
782:     *
783:     * Isto eh: o grafico era destruido na PROPRIA linha do CREATEOBJECT,
784:     * porque FormSigPrGf2 tem WindowType = 0 (modeless) e a ultima referencia
785:     * caia na hora. O Destroy dele reabilita o pai (poform1.Enabled = .T.),
786:     * entao nao sobrava erro, nem log, nem tela travada - o usuario clicava
787:     * Processar, esperava o grafico e "nada acontecia".
788:     *
789:     * Ainda na mesma medicao, com a referencia guardada:
790:     *   - o filho modeless fica NO TOPO mesmo com o pai MODAL
791:     *     (WONTOP() = [FILHO], _SCREEN.ActiveForm = o filho), logo eh
792:     *     utilizavel - nao ha conflito entre o WindowType = 1 do pai
793:     *     (exigencia do menu.prg) e o WindowType = 0 do filho;
794:     *   - filho.Release() (o botao Sair do filho) DISPARA o Destroy mesmo com
795:     *     o pai segurando a referencia, e o pai volta a Enabled = .T.;
796:     *   - depois disso a property do pai vira VARTYPE = "X" (referencia
797:     *     pendurada) - por isso toda checagem usa VARTYPE(...) = "O", nunca
798:     *     ISNULL(), e a property eh limpa antes de abrir outro grafico.
799:     *
800:     * DIVERGENCIA DELIBERADA DO LEGADO: o legado faz ".Enabled = .f." ANTES do
801:     * DO FORM; aqui o Enabled = .F. so entra DEPOIS de confirmar que o filho
802:     * nasceu. Se o CREATEOBJECT falhasse com o pai ja desabilitado, o usuario
803:     * ficaria preso numa tela morta - este form tem TitleBar = 0,
804:     * ControlBox = .F. e Closable = .F., ou seja, nem o Encerrar responderia, e
805:     * quem reabilita o pai eh justamente o filho que nao existe. A ordem nao
806:     * muda nada do ponto de vista visual (o filho se mostra no proprio Init).
807:     *==========================================================================
808:     PROCEDURE BtnProcessarClick()
809:         LOCAL loc_lProcessado, loc_oErro, loc_cCursor
810:         loc_lProcessado = .F.
811: 
812:         *-- ".pcMsg = ''" - primeira linha do cmdProcessa.Click legado. Hoje o
813:         *-- ValidarPeriodo() tambem limpa a mensagem, mas a limpeza pertence ao
814:         *-- Click: sem ela, um caminho que nao chegue ao ValidarPeriodo
815:         *-- reexibiria o aviso do clique ANTERIOR.
816:         THIS.this_cMsgValidacao = ""
817: 
818:         TRY
819:             IF THIS.ValidarPeriodo()
820:                 THIS.cnt_4c_Aguarde.Visible = .T.
821:                 THIS.cnt_4c_Aguarde.ZOrder(0)
822:                 THIS.Refresh()
823: 
824:                 loc_lProcessado = THIS.this_oBusinessObject.Processar()
825: 
826:                 THIS.cnt_4c_Aguarde.Visible = .F.
827:                 THIS.Refresh()
828: 
829:                 IF loc_lProcessado AND THIS.this_oBusinessObject.this_lProcessado
830:                     *-- Nome do cursor numa LOCAL: "SELECT ... FROM (<expressao
831:                     *-- de nome>)" aceita memvar, e medido no VFP9 com
832:                     *-- (m.loc_cCursor) funciona na 1a e na 2a passagem (o
833:                     *-- usuario pode processar mais de um periodo por sessao).
834:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
835: 
836:                     IF USED("crRel1")
837:                         USE IN crRel1
838:                     ENDIF
839:                     SELECT * FROM (m.loc_cCursor) INTO CURSOR crRel1 READWRITE
840: 
841:                     *-- Solta o grafico anterior (se o usuario processou duas
842:                     *-- vezes) antes de abrir o novo, senao a referencia velha
843:                     *-- seguraria um form ja fechado.
844:                     THIS.LiberarFormGrafico()
845: 
846:                     THIS.this_oFormGrafico = CREATEOBJECT("FormSigPrGf2", THIS)
847: 
848:                     IF VARTYPE(THIS.this_oFormGrafico) = "O"
849:                         THIS.Enabled = .F.
850:                     ELSE
851:                         THIS.this_cMsgValidacao = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
852:                             "vel abrir o gr" + CHR(225) + "fico (SigPrGf2)."
853:                     ENDIF
854:                 ELSE
855:                     THIS.this_cMsgValidacao = IIF(!EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
856:                         THIS.this_oBusinessObject.this_cMensagemErro, "Nenhum Registro Encontrado.")
857:                 ENDIF
858:             ENDIF
859:         CATCH TO loc_oErro
860:             THIS.cnt_4c_Aguarde.Visible = .F.
861:             THIS.Enabled = .T.
862:             MsgErro(loc_oErro.Message + CHR(13) + ;
863:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
864:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
865:         ENDTRY
866: 
867:         IF !EMPTY(THIS.this_cMsgValidacao)
868:             MsgAviso(THIS.this_cMsgValidacao, "Aten" + CHR(231) + CHR(227) + "o")
869:         ENDIF
870:     ENDPROC
871: 
872:     *==========================================================================
873:     * LiberarFormGrafico - solta a referencia do FormSigPrGf2 guardada em
874:     * this_oFormGrafico, fechando o form se ele ainda estiver aberto.
875:     *
876:     * Depois que o usuario fecha o grafico pelo botao dele, a property fica
877:     * com uma referencia PENDURADA (VARTYPE = "X", medido) - por isso o teste
878:     * eh VARTYPE(...) = "O" e nao ISNULL(), e o Release() so eh chamado quando
879:     * o objeto ainda responde.
880:     *==========================================================================
881:     PROCEDURE LiberarFormGrafico()
882:         IF VARTYPE(THIS.this_oFormGrafico) = "O"
883:             THIS.this_oFormGrafico.Release()
884:         ENDIF
885: 
886:         THIS.this_oFormGrafico = .NULL.
887:     ENDPROC
888: 
889:     *==========================================================================
890:     * BtnEncerrarClick - migracao do Click de Buttons(2) "Encerrar"
891:     * (cmdProcessa). O segundo Click do dump legado (LockScreen/Release/
892:     * Refresh + bloco de .poForm1/crLstMatLote) e herdado da classe GENERICA
893:     * do CommandGroup compartilhada por varios forms - crLstMatLote e
894:     * poForm1 nao existem neste form (SIGPRGF1 nao tem lote nem form pai),
895:     * entao esse bloco morto nao se aplica aqui. O que resta, valido em
896:     * qualquer form que use esse botao, e fechar a tela.
897:     *==========================================================================
898:     PROCEDURE BtnEncerrarClick()
899:         THIS.Release()
900:     ENDPROC
901: 
902:     *==========================================================================
903:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
904:     * padrao. Percorre recursivamente containers/PageFrames para tornar tudo
905:     * visivel apos a montagem. Filtra cnt_4c_Aguarde (container flutuante de
906:     * "Aguarde... Processando Dados...", que so aparece durante o Processar -
907:     * fase 7): pula o Visible do proprio container, mas recursa nos filhos
908:     * para eles nao ficarem hidden quando o container for mostrado depois.
909:     *==========================================================================
910:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
911:         LOCAL loc_nI, loc_oObjeto, loc_nP
912: 
913:         FOR loc_nI = 1 TO par_oContainer.ControlCount
914:             loc_oObjeto = par_oContainer.Controls(loc_nI)
915: 
916:             IF VARTYPE(loc_oObjeto) = "O"
917:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE")
918:                     THIS.TornarControlesVisiveis(loc_oObjeto)
919:                     LOOP
920:                 ENDIF
921: 
922:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
923:                     loc_oObjeto.Visible = .T.
924:                 ENDIF
925: 
926:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
927:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
928:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
929:                     ENDFOR
930:                 ENDIF
931: 
932:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
933:                     THIS.TornarControlesVisiveis(loc_oObjeto)
934:                 ENDIF
935:             ENDIF
936:         ENDFOR
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
941:     * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
942:     * form). Fecha os cursores criados por esta tela e solta o form do grafico,
943:     * antes de encadear para FormBase.Destroy(), que libera o BO e restaura o
944:     * menu principal. DODEFAULT() SEMPRE por ultimo (Destroy sem DODEFAULT
945:     * deixa o menu do sistema encolhido).
946:     *
947:     * crRel1 tambem eh fechado aqui: ele eh criado por BtnProcessarClick (nao
948:     * pelo BO) e, apesar de viver na datasession privada desta tela, fecha-lo
949:     * explicitamente mantem simetrico quem cria e quem destroi.
950:     *==========================================================================
951:     PROCEDURE Destroy()
952:         THIS.LiberarFormGrafico()
953: 
954:         IF USED("crRel1")
955:             USE IN crRel1
956:         ENDIF
957: 
958:         IF USED("cursor_4c_Resultado")
959:             USE IN cursor_4c_Resultado
960:         ENDIF
961: 
962:         DODEFAULT()
963:     ENDPROC
964: 
965: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf1BO.prg):
*============================================================================
* SigPrGf1BO.prg - Business Object para "Falha X Recuperacao por Mes da
* Empresa" (SIGPRGF1)
*
* Form OPERACIONAL (SIGPRGF1 / FormSigPrGf1): tela de FILTRO que recebe um
* periodo (Data Inicial/Data Final, limitado a 12 meses) e dispara um
* processamento que agrega SigCdFea (Falhas/Pesoccbs) por mes da empresa
* corrente, gravando o resultado num cursor. Nao ha CRUD - o form apenas
* filtra e processa, depois abre SigPrGf2 (grafico) com o resultado.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): SigCdFea e
* SigCdEmp sao apenas consultadas para compor o relatorio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf1BO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - SIGPRGF1.getDtInicial/getDtFinal
    *==========================================================================
    this_dDataInicial = {}   && getDtInicial.Value - inicio do periodo
    this_dDataFinal   = {}   && getDtFinal.Value   - fim do periodo

    *==========================================================================
    * Empresa corrente (equivalente a _Empr do legado - CLAUDE.md regra:
    * NUNCA usar _EMPR, usar go_4c_Sistema.cCodEmpresa) e sua descricao,
    * lida de SigCdEmp (CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,
    * 'Razas') do mProcessamento legado)
    *==========================================================================
    this_cEmpresa     = SPACE(3)    && go_4c_Sistema.cCodEmpresa - SigCdEmp.Cemps
    this_cNomeEmpresa = SPACE(40)   && SigCdEmp.Razas

    *==========================================================================
    * Titulos do relatorio/grafico (mProcessamento monta lcTitulo1/lcTitulo2)
    *==========================================================================
    this_cTitulo1 = ""   && "Falha X Recuperacao por Mes da Empresa " + emp + " - " + razao
    this_cTitulo2 = ""   && faixa de periodo formatada: "[De dd/mm/aaaa a dd/mm/aaaa]"

    *==========================================================================
    * Resultado do processamento (crRel1 do legado - agregado por mes)
    *==========================================================================
    this_cCursorResultado = ""   && nome do cursor com o resultado agregado
    this_nTotalRegistros  = 0    && RECCOUNT do cursor resultado (equivale ao "Not Eof()" legado)
    this_lProcessado      = .F.  && .T. quando mProcessamento rodou com sucesso e ha registros

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela proprietaria (form
    * apenas filtra/processa), entao this_cTabela/this_cCampoChave ficam
    * vazios. Carrega valores padrao de periodo (equivalente ao Init legado:
    * getDtInicial = 1o dia do mes corrente, getDtFinal = ultimo dia do mes
    * corrente) e a empresa corrente.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro, loc_dHoje
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_dHoje = DATE()
            THIS.this_dDataInicial = DATE(YEAR(loc_dHoje), MONTH(loc_dHoje), 1)
            THIS.this_dDataFinal   = GOMONTH(THIS.this_dDataInicial, 1) - 1

            IF TYPE("go_4c_Sistema.cCodEmpresa") = "C"
                THIS.this_cEmpresa = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO (Fase 2 - Metodos CRUD):
    *
    * SigPrGf1 e um form OPERACIONAL de FILTRO/PROCESSAMENTO, sem tabela
    * propria e sem gravacao em banco (this_cTabela fica vazio - ver Init
    * acima). O legado (mProcessamento) so faz LEITURA de SigCdFea/SigCdEmp
    * e agrega o resultado num cursor LOCAL (crRel1, via "Into Cursor ...
    * ReadWrite"); nao ha TableUpdate, AddCursor nem Insert/Update/Delete
    * contra tabela remota.
    *
    * Por isso este BO NAO sobrescreve CarregarDoCursor(), Inserir() e
    * Atualizar(): o comportamento herdado de BusinessBase (CarregarDoCursor
    * generico, Inserir()/Atualizar() recusando a operacao) ja e o correto
    * para um BO somente-leitura. Os metodos reais do form ficam em
    * ValidarPeriodo() (equivalente a mChkValid) e Processar() (equivalente
    * a mProcessamento), implementados abaixo.
    *==========================================================================

    *==========================================================================
    * ValidarPeriodo - Equivalente a SIGPRGF1.mChkValid do legado. Valida o
    * par de datas (getDtInicial/getDtFinal) antes de processar: data final
    * preenchida, data final >= data inicial e periodo nao ultrapassando 12
    * meses. Preenche this_cMensagemErro e retorna .F. no primeiro erro (o
    * SetFocus no campo invalido fica por conta do Form, que le a mensagem
    * e decide qual controle focar).
    *==========================================================================
    FUNCTION ValidarPeriodo()

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF ((YEAR(THIS.this_dDataInicial) = YEAR(THIS.this_dDataFinal) AND ;
            (MONTH(THIS.this_dDataInicial) - MONTH(THIS.this_dDataFinal) + 1) > 12) OR ;
            (YEAR(THIS.this_dDataInicial) != YEAR(THIS.this_dDataFinal) AND ;
            ((12 - MONTH(THIS.this_dDataInicial)) + MONTH(THIS.this_dDataFinal) + 1) > 12))
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Processar - Equivalente a SIGPRGF1.mProcessamento do legado. Busca a
    * empresa corrente em SigCdEmp, consulta SigCdFea no periodo informado
    * (filtrado por Emps) e agrega Falhas/Pesoccbs por mes num cursor local
    * (this_cCursorResultado), no mesmo formato que o legado monta para
    * alimentar o grafico do SigPrGf2.
    *==========================================================================
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nResultado, ;
              loc_cDtIni, loc_cDtFim, loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, ;
              loc_cEmpresaAtual, loc_cNomeEmpresa, ;
              loc_nDecimals, loc_cFixed, loc_cExact

        loc_lResultado = .F.

        *-- Contexto numerico/de comparacao do mProcessamento legado, salvo e
        *-- restaurado igual la ("m.lnDecimals = Set('Decimals',1)" etc. +
        *-- "Set Decimals To 6 / Set Fixed On / Set Exact On"). Nao eh detalhe
        *-- decorativo: o form roda com DataSession = 2 (transcrito do SCX) e a
        *-- datasession privada nasce com esses SETs no default do VFP, nao no
        *-- do sistema - a agregacao abaixo (VAL(STR(SUM(...), 16, 2)) e o
        *-- GROUP BY) tem de ver o mesmo contexto que o legado via.
        *-- Medido no VFP9: SET("Decimals") devolve NUMERIC e SET("Fixed")/
        *-- SET("Exact") devolvem CHARACTER - por isso nenhum deles vai
        *-- envolvido em VAL() (VAL sobre numerico dispara erro 11).
        loc_nDecimals = SET("Decimals")
        loc_cFixed    = SET("Fixed")
        loc_cExact    = SET("Exact")

        SET DECIMALS TO 6
        SET FIXED ON
        SET EXACT ON

        TRY
            THIS.this_lProcessado     = .F.
            THIS.this_nTotalRegistros = 0
            THIS.this_cMensagemErro   = ""

            IF USED("cursor_4c_TmpRel")
                USE IN cursor_4c_TmpRel
            ENDIF
            IF USED("cursor_4c_Resultado")
                USE IN cursor_4c_Resultado
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            * Empresa corrente (equivalente a CursorQuery('SigCdEmp','crSigCdEmp',
            * 'Cemps',_Empr,'Razas') do legado)
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(THIS.this_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o com o Servidor de Banco de Dados (SigCdEmp): " + CapturarErroSQL()
            ELSE
                IF loc_nResultado > 0 AND !EOF("cursor_4c_Emp")
                    THIS.this_cNomeEmpresa = TratarNulo(cursor_4c_Emp.Razas, "")
                ELSE
                    THIS.this_cNomeEmpresa = ""
                ENDIF

                * Faixa de datas (Datas eh datetime; limite final vai ate 23:59:59,
                * igual a fDtoSQL(m.ldData2, '23:59:59') do legado)
                loc_cDtIni = FormatarDataSQL(THIS.this_dDataInicial)
                loc_cDtFim = "'" + PADL(YEAR(THIS.this_dDataFinal), 4, "0") + "-" + ;
                                   PADL(MONTH(THIS.this_dDataFinal), 2, "0") + "-" + ;
                                   PADL(DAY(THIS.this_dDataFinal), 2, "0") + " 23:59:59'"

                loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs " + ;
                           "FROM SigCdFea a LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps " + ;
                           "WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " " + ;
                           "AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRel")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (" + CapturarErroSQL() + ")"
                ELSE
                    * Mes por extenso, blocos de 9 caracteres (transcrito do legado -
                    * "Mar?o" com CHR(231) no lugar do cedilha)
                    loc_cStrgMes = "Janeiro  Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                   "Abril    Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "

                    loc_cTitulo1 = "Falha X Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s da Empresa "

                    IF EMPTY(THIS.this_dDataInicial) AND EMPTY(THIS.this_dDataFinal)
                        loc_cTitulo2 = ""
                    ELSE
                        IF THIS.this_dDataInicial = THIS.this_dDataFinal
                            loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDataInicial) + "]"
                        ELSE
                            IF EMPTY(THIS.this_dDataInicial)
                                loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ELSE
                                loc_cTitulo2 = " [De " + DTOC(THIS.this_dDataInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_cEmpresaAtual = ALLTRIM(THIS.this_cEmpresa)
                    loc_cNomeEmpresa  = ALLTRIM(TratarNulo(THIS.this_cNomeEmpresa, ""))

                    SELECT Emps AS Cemps, ;
                           PADR(DTOS(Datas), 6) AS cAnomess, ;
                           PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                           PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                           m.loc_cTitulo2 AS ctitulo2s, ;
                           PADR(m.loc_cEmpresaAtual + " - " + m.loc_cNomeEmpresa, 100) AS cEmpresas, ;
                           VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                           VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                      FROM cursor_4c_TmpRel ;
                     GROUP BY 1, 2, 3, 4, 5, 6 ;
                      INTO CURSOR cursor_4c_Resultado READWRITE

                    IF USED("cursor_4c_TmpRel")
                        USE IN cursor_4c_TmpRel
                    ENDIF

                    SELECT cursor_4c_Resultado
                    GO TOP

                    THIS.this_cCursorResultado = "cursor_4c_Resultado"
                    THIS.this_cTitulo1         = loc_cTitulo1
                    THIS.this_cTitulo2         = loc_cTitulo2
                    THIS.this_nTotalRegistros  = RECCOUNT("cursor_4c_Resultado")
                    THIS.this_lProcessado      = (THIS.this_nTotalRegistros > 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        *-- Restauracao do contexto (igual ao fim do mProcessamento legado).
        *-- Fica FORA do TRY para valer tambem quando o CATCH dispara - caso
        *-- contrario um erro no meio do processamento deixaria a datasession
        *-- com DECIMALS 6 / FIXED ON para o resto da vida da tela.
        *-- "&loc_cFixed." eh macro-substituicao do proprio valor lido do SET
        *-- ("ON"/"OFF"), como no legado; sem prefixo "m." (o VFP le o nome da
        *-- macro ate o primeiro ponto, e "&m.loc_cFixed." tentaria expandir a
        *-- variavel "m").
        SET DECIMALS TO loc_nDecimals
        SET FIXED &loc_cFixed.
        SET EXACT &loc_cExact.

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.VincularCamposAoCursorOrigem()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCoc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1400 linhas total):

*-- Linhas 14 a 106:
14: *       inversa, entao o que o usuario digitava NUNCA chegava ao BO e o OK
15: *       gravaria o valor carregado na abertura, em silencio.
16: *   (c) os handlers dos campos (ValidarCabecalho / ValidarRodape) ligados por
17: *       BINDEVENT em LostFocus + InteractiveChange, que ocupam o lugar da
18: *       escrita continua que o ControlSource fazia no legado.
19: *   ZERO lookup, MEDIDO (nao suposto): varredura no dump por
20: *   fwbusca|mAddColuna|sigacess\(|Acesso<X>\(|FormBuscaAuxiliar devolve 0
21: *   ocorrencias, e tasks\task705\analise.json declara "lookups": []. O SCX nao
22: *   tem Valid nem KeyPress em getCabs/getRods - os handlers acima por isso NAO
23: *   carregam regra de negocio nenhuma, e nada de dominio foi inventado: cabs e
24: *   rods sao "text" NULL em SigCdOpt, sem tamanho (nada de MaxLength - regra
25: *   #19) e sem lista de valores. Fabricar lookup ou validacao aqui violaria o
26: *   PILAR 1.
27: *   NAO ha "ultimos 50% dos campos" a acrescentar: o dump tem 11 objetos, dos
28: *   quais exatamente 2 de entrada (BaseClass: editbox) e 2 labels de dados, e
29: *   os quatro ja foram entregues INTEGRALMENTE na Fase 5.
30: * Fase 7/8 - Eventos principais dos botoes: BtnOKClick e BtnCancelarClick,
31: *   ligados por BINDEVENT ao Click de cada Buttons(N) do Grupo_Saida (ver o
32: *   fim de ConfigurarBotoesSaida). Sao os DOIS unicos eventos de botao que o
33: *   legado tem, e ate esta fase NENHUM dos dois existia: o dialogo desenhava
34: *   OK e Cancelar e os dois cliques nao faziam NADA - sem gravar, sem fechar.
35: *
36: *   NAO entram aqui os quatro BtnIncluirClick/BtnAlterarClick/
37: *   BtnVisualizarClick/BtnExcluirClick da barra CRUD, porque este legado NAO
38: *   TEM barra CRUD - e isso foi MEDIDO no dump, nao suposto: a raiz eh
39: *   "Class: form" (nao frmcadastro), nao ha Grupo_Op, nao ha objeto cujo nome
40: *   termine em Incluir/Alterar/Visualizar/Excluir e nao ha <X>.Click desses
41: *   verbos. A unica evidencia de modo eh pcEscolha, que chega como PARAMETRO
42: *   do Init ("LParameters pDatasession, pEscolha") - isto eh, quem decide o
43: *   modo eh o form PAI, e este form so o OBEDECE. Inventar os quatro botoes
44: *   violaria o PILAR 1 e criar os quatro metodos vazios violaria a regra de
45: *   completude; o que a fase exige de um legado sem CRUD eh um handler por
46: *   botao que o dump PROVA existir, e o Grupo_Saida tem ButtonCount = 2.
47: *
48: * Fase 8/8 - Eventos auxiliares e CONSOLIDACAO FINAL. Quatro entregas, todas
49: *   com trabalho REAL (nenhum metodo de corpo vazio):
50: *
51: *   (a) FecharDialogo() - CORRECAO DE DEFEITO, nao acabamento. Os dois
52: *       handlers da Fase 7 terminavam em THIS.Release(), transcricao literal
53: *       do "ThisForm.Release" legado. Medido no VFP9 (2026-10-20): Release()
54: *       DESTROI o objeto mesmo havendo variavel externa apontando para ele - a
55: *       referencia do chamador vira VARTYPE "X" e a leitura seguinte estoura
56: *       "is not an object". Form object NAO segue refcount de COM. Como este
57: *       dialogo publica um protocolo de retorno (this_lConfirmado, lido pelo
58: *       PAI depois do Show() - ver "Abertura" no fim deste cabecalho), o
59: *       Release literal tornava esse protocolo INALCANCAVEL. O legado nao
60: *       sofria disso porque abre com "Do Form ... With ..." e nao le retorno
61: *       nenhum: o dado chegava ao pai pelo cursor COMPARTILHADO CrSigCdOpt,
62: *       que o PILAR 3 eliminou. Fecha-se com Hide(), que em form modal TAMBEM
63: *       devolve o Show() (PILAR 1 intacto - para o usuario a tela fecha
64: *       igual); muda so o tempo de vida do objeto, que eh PILAR 3, e eh o
65: *       CHAMADOR quem da o Release() depois de ler. Mesmo desenho que o
66: *       FormBuscaAuxiliar e o Formsigopcks do projeto ja adotam.
67: *
68: *   (b) HabilitarCampos(par_lHabilitar) e AjustarBotoesPorModo() - os nomes
69: *       CANONICOS do projeto para os dois metodos de modo que a Fase 5 e a
70: *       Fase 4 criaram com nome local (AplicarModoNosCampos /
71: *       AplicarModoNosBotoesSaida). RENOMEADOS, nao duplicados: manter as duas
72: *       grafias criaria duas fontes para a MESMA regra, que divergem em
73: *       silencio na primeira alteracao (CLAUDE.md #44, item 6). Passam a
74: *       PUBLIC porque o harness do pipeline (TesteAutomatico.prg) chama
75: *       AjustarBotoesPorModo direto no oForm, de FORA da classe, e
76: *       PEMSTATUS(...,5) devolve .T. mesmo em metodo PROTECTED - o teste entra
77: *       no branch e a chamada real estoura "Property ... is not found".
78: *       Nenhum dos dois esta em FormBase, entao PUBLIC aqui nao alarga escopo
79: *       herdado (regra #51).
80: *
81: *   (c) LimparCampos() - fecha um buraco que o proprio codigo da Fase 6 ja
82: *       prometia. O comentario de CarregarCamposDaOrigem dizia "sem origem
83: *       alcancavel o BO mantem os defaults vazios, e eh esse vazio que tem de
84: *       aparecer na tela - nunca o valor de uma abertura anterior", mas isso
85: *       so era verdade na PRIMEIRA abertura: o BO eh criado uma vez por form e
86: *       CarregarCamposDaOrigem eh PUBLIC/reentrante, entao numa segunda carga
87: *       sem origem o this_cCabs/this_cRods da carga ANTERIOR continuava no BO
88: *       e reaparecia na tela. PROTECTED porque FormBase declara o hook assim
89: *       (regra #51). Nao escreve em campo VINCULADO por ControlSource - ali
90: *       atribuir .Value escreveria no registro do cursor, apagando o dado.
91: *
92: *   (d) this_cOperacaos propagado do BO de origem - sem a chave, o
93: *       ObterChavePrimaria() do SigOpCocBO devolvia "" e o RegistrarAuditoria
94: *       do BusinessBase saia pelo "IF EMPTY(loc_cChave) / RETURN .F.": a
95: *       gravacao funcionava e NAO deixava rastro em LogAuditoria.
96: *
97: *   O QUE NAO ENTRA, e por que (medido no dump, nao suposto):
98: *     - CarregarLista(): NAO existe lista neste legado. A arvore do SCX tem 11
99: *       objetos e ZERO "BaseClass: grid|pageframe|listbox"; nao ha AddCursor,
100: *       pColuna, RecordSource de grade nem objeto chamado Grade/grd. Nao ha o
101: *       que listar - criar o metodo exigiria INVENTAR uma grade (viola o
102: *       PILAR 1) ou gerar corpo vazio (proibido pela regra de completude).
103: *     - BtnBuscarClick() / BtnEncerrarClick() / BtnSalvarClick(): nao ha
104: *       botao "Buscar", "Encerrar" nem "Salvar" no SCX. O Grupo_Saida tem
105: *       ButtonCount = 2 e a SECAO 3 do dump declara exatamente DOIS Click -
106: *       "OK.Click" e "Sair.Click" -, que sao o BtnOKClick e o

*-- Linhas 112 a 132:
112: *       volta para lista nenhuma, ele FECHA.
113: *   Mesma familia documental do FormSIGOPBIN (dialogo de entrada sem CRUD).
114: *
115: * ESTRUTURA DO LEGADO (SIGOPCOC.SCX) - 545 x 291, raiz "form" generico
116: *   SIGOPCOC
117: *     +- cntSombra (Container)        -> cnt_4c_Sombra        (faixa do cabecalho)
118: *     |    +- lblSombra (Label)       -> lbl_4c_LblSombra
119: *     |    +- lblTitulo (Label)       -> lbl_4c_LblTitulo
120: *     +- getCabs  (fwmemo/EditBox)    -> obj_4c_GetCabs       (Fase 5 - AQUI)
121: *     +- getRods  (fwmemo/EditBox)    -> obj_4c_GetRods       (Fase 5 - AQUI)
122: *     +- Say1 "Cabecalho :" (say)     -> lbl_4c_Label1        (Fase 5 - AQUI)
123: *     +- Say2 "Rodape :"    (say)     -> lbl_4c_Label2        (Fase 5 - AQUI)
124: *     +- Grupo_Saida (CommandGroup)   -> obj_4c_Grupo_Saida   (Fase 4)
125: *          OK (Command2) -> .Buttons(2) -> BtnOKClick       (Fase 7 - AQUI)
126: *          Sair (Command1) -> .Buttons(1) -> BtnCancelarClick (Fase 7 - AQUI)
127: *
128: * ESTA FASE (5/8) entrega os QUATRO objetos de dados que faltavam - os dois
129: * sao TODOS os campos do legado, nao metade: o dump tem exatamente 2 controles
130: * de entrada (BaseClass: editbox) e 2 labels de dados, e dividir isso ao meio
131: * deixaria a tela com um campo so, o que a regra "PROIBIDO versao reduzida"
132: * impede. Junto vem o que as fases anteriores deixaram explicitamente para

*-- Linhas 155 a 198:
155: * Abertura (form PAI = FormOpt, botao cmd_4c_BtnCarta; o legado faz
156: * "Do Form SigOpCoc With ThisForm.DataSessionId, ThisForm.pcEscolha"):
157: *
158: *   loForm = CREATEOBJECT("FormSigOpCoc", SET("Datasession"), THIS.this_cModoAtual)
159: *   IF VARTYPE(loForm) = "O"
160: *       loForm.this_oBOOrigem = THIS.this_oBusinessObject   && OptBO
161: *       loForm.CarregarCamposDaOrigem()
162: *       loForm.Show()                      && FORA de TRY - regra #29
163: *       IF loForm.this_lConfirmado         && .T. somente quando deu OK
164: *           *-- Cabs/Rods ja estao no OptBO; o Salvar() do PAI persiste
165: *       ENDIF
166: *   ENDIF
167: *
168: * A ORDEM eh contrato: o dialogo fecha com Hide(), continua legivel depois do
169: * Show() e so morre no Release() do CHAMADOR. Ler DEPOIS do Release estoura
170: * "is not an object"; NAO dar o Release vaza o objeto e o BO dele.
171: *==============================================================================
172: 
173: DEFINE CLASS FormSigOpCoc AS FormBase
174: 
175:     *--------------------------------------------------------------------------
176:     * Propriedades visuais - TRANSCRITAS do SCX legado (PILAR 1)
177:     * Declaradas no dump: BorderStyle, Height, Width, AutoCenter, Caption,
178:     * ControlBox, TitleBar, WindowType. NAO declaradas no dump e por isso NAO
179:     * inventadas aqui: Closable, MaxButton, MinButton - sem barra de titulo
180:     * elas nao DESENHAM, mas Closable segue .T. e o Alt+F4 continua sendo a
181:     * saida de aborto que o legado permitia.
182:     *--------------------------------------------------------------------------
183:     this_cMensagemErro = ""
184:     Width       = 545
185:     Height      = 291
186:     BorderStyle = 2
187:     AutoCenter  = .T.
188:     ControlBox  = .F.
189:     TitleBar    = 0
190:     WindowType  = 1                 && MODAL: o Show() bloqueia e a tela vive
191:     ShowWindow  = 1
192:     Caption     = "Carta de Opera" + CHR(231) + CHR(245) + "es de Cheques"
193: 
194:     *--------------------------------------------------------------------------
195:     * Estado / protocolo do dialogo
196:     *--------------------------------------------------------------------------
197:     this_oBusinessObject    = .NULL.
198:     this_cEscolha           = ""      && pcEscolha do legado (ClassInfo: pcescolha)

*-- Linhas 219 a 383:
219:     *==========================================================================
220:     * Init - recebe os dois parametros do Init legado e delega ao FormBase
221:     * Os parametros sao OPCIONAIS: os harness do pipeline (TestFormWrapper /
222:     * ValidarUIFidelity) instanciam com CREATEOBJECT sem argumento, e nesse
223:     * caso valem os defaults das properties.
224:     * DODEFAULT() eh quem chama InicializarForm() - NAO chamar de novo aqui.
225:     *==========================================================================
226:     PROCEDURE Init(par_nDataSession, par_cEscolha)
227:         *-- guardar ANTES do DODEFAULT: InicializarForm ja le este estado
228:         IF VARTYPE(par_nDataSession) = "N"
229:             THIS.this_nDataSessionOrigem = par_nDataSession
230:         ENDIF
231: 
232:         IF VARTYPE(par_cEscolha) = "C"
233:             THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
234:         ENDIF
235: 
236:         RETURN DODEFAULT()
237:     ENDPROC
238: 
239:     *==========================================================================
240:     * InicializarForm - instancia o BO e desenha a estrutura base
241:     * Sem gate de gnConnHandle: este dialogo nao consulta o SQL Server (o
242:     * legado nao tem Insert/Update/Delete nem AddCursor), entao exigir conexao
243:     * aqui so impediria a tela de abrir em modo de teste.
244:     *==========================================================================
245:     PROTECTED PROCEDURE InicializarForm()
246:         LOCAL loc_lSucesso, loc_oErro
247:         loc_lSucesso = .F.
248: 
249:         TRY
250:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCocBO")
251: 
252:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
253:                 *-- aparencia base da Form (nao ha PageFrame a configurar)
254:                 THIS.ConfigurarPageFrame()
255: 
256:                 *-- faixa cinza do cabecalho: PRIMEIRO AddObject da tela, para
257:                 *-- os containers/botoes criados depois desenharem POR CIMA
258:                 THIS.ConfigurarCabecalho()
259: 
260:                 *-- campos de dados (Say1/getCabs/Say2/getRods). Ficam entre a
261:                 *-- faixa e os botoes so por clareza de leitura: eles vivem em
262:                 *-- Top = 99..268, fora tanto da faixa (0..80) quanto do
263:                 *-- Grupo_Saida (Top -2..83, Left 389..549), entao nao ha
264:                 *-- sobreposicao a resolver por ordem de AddObject.
265:                 THIS.ConfigurarCampos()
266: 
267:                 *-- Grupo_Saida DEPOIS da faixa, para desenhar POR CIMA dela:
268:                 *-- com Top = -2 o grupo invade a area do cabecalho (regra #11)
269:                 THIS.ConfigurarBotoesSaida()
270: 
271:                 THIS.TornarControlesVisiveis()
272: 
273:                 *-- DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
274:                 *-- em tudo: eh AplicarModoEscolha quem ESCONDE o botao OK em
275:                 *-- CONSULTAR/EXCLUIR/PROCURAR, e na ordem inversa a varredura
276:                 *-- apagaria esse Visible = .F.
277:                 THIS.AplicarModoEscolha()
278: 
279:                 *-- carga inicial dos dois campos, equivalente ao
280:                 *-- "Select CrSigCdOpt / getCabs.Value = Cabs" do Init legado.
281:                 *-- Depois de AplicarModoEscolha porque eh ela quem entrega
282:                 *-- this_cCursorOrigem / this_oBOOrigem ao BO.
283:                 THIS.CarregarCamposDaOrigem()
284: 
285:                 loc_lSucesso = .T.
286:             ELSE
287:                 THIS.this_cMensagemErro = "Erro ao criar SigOpCocBO (VARTYPE: " + ;
288:                     VARTYPE(THIS.this_oBusinessObject) + ")"
289:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
290:             ENDIF
291: 
292:         CATCH TO loc_oErro
293:             THIS.this_cMensagemErro = loc_oErro.Message + ;
294:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
295:                 " | Proc: " + loc_oErro.Procedure
296:             MsgErro(THIS.this_cMensagemErro, "Erro ao inicializar FormSigOpCoc")
297:             loc_lSucesso = .F.
298:         ENDTRY
299: 
300:         RETURN loc_lSucesso
301:     ENDPROC
302: 
303:     *==========================================================================
304:     * ConfigurarPageFrame - aparencia base da Form
305:     * NAO cria PageFrame: o SCX legado nao tem nenhum (layout FLAT) e inventar
306:     * um violaria o PILAR 1. O nome do metodo eh mantido porque eh o ponto de
307:     * configuracao base dos forms do projeto - mesmo papel que em
308:     * FormSIGPRSTF, outro dialogo FLAT. O que ele faz aqui eh transcrever o
309:     * Picture de fundo que o SCX declara.
310:     *==========================================================================
311:     PROTECTED PROCEDURE ConfigurarPageFrame()
312:         *-- Picture = ..\framework\imagens\new_background.jpg (SCX legado)
313:         *-- Sem guarda IF FILE(): o arquivo existe no acervo, e mascarar a
314:         *-- ausencia faria o fundo sumir em silencio (regra #25).
315:         THIS.Picture    = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
316:         THIS.ScrollBars = 0
317:         THIS.ShowTips   = .T.
318:         THIS.FontName   = "Tahoma"
319:         THIS.FontSize   = 8
320:     ENDPROC
321: 
322:     *==========================================================================
323:     * ConfigurarCabecalho - faixa cinza do cabecalho (cntSombra do legado)
324:     * Legado: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
325:     *
326:     * O Width=800 do dump eh artefato do Form Designer: o CONTAINER esta
327:     * desenhado 255px mais largo que a propria janela (Form.Width = 545), e os
328:     * labels dentro dele vem com Width=769. Copiar esses literais jogaria o
329:     * texto para fora da area visivel e CORTARIA o titulo - por isso a faixa
330:     * usa THIS.Width e os labels THIS.Width - 20 (eles tem Left = 10).
331:     *==========================================================================
332:     PROTECTED PROCEDURE ConfigurarCabecalho()
333:         THIS.AddObject("cnt_4c_Sombra", "Container")
334:         WITH THIS.cnt_4c_Sombra
335:             .Top           = 0
336:             .Left          = 0
337:             .Width         = THIS.Width
338:             .Height        = 80
339:             .BorderWidth   = 0
340:             .BackStyle     = 1
341:             .BackColor     = RGB(100, 100, 100)
342:             .SpecialEffect = 0
343:             .Visible       = .T.
344:         ENDWITH
345: 
346:         *-- lblSombra: texto PRETO, 1px abaixo do titulo (efeito de sombra)
347:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
348:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
349:             .AutoSize      = .F.
350:             .FontName      = "Tahoma"
351:             .FontSize      = 18
352:             .FontBold      = .T.
353:             .FontUnderline = .F.
354:             .WordWrap      = .T.
355:             .Alignment     = 0
356:             .BackStyle     = 0
357:             .Top           = 18
358:             .Left          = 10
359:             .Height        = 40
360:             .Width         = THIS.Width - 20
361:             .ForeColor     = RGB(0, 0, 0)
362:             .Caption       = THIS.Caption
363:             .Visible       = .T.
364:         ENDWITH
365: 
366:         *-- lblTitulo: texto BRANCO sobre a faixa cinza
367:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
368:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
369:             .AutoSize    = .F.
370:             .FontName    = "Tahoma"
371:             .FontSize    = 18
372:             .FontBold    = .T.
373:             .WordWrap    = .T.
374:             .Alignment   = 0
375:             .BackStyle   = 0
376:             .Top         = 17
377:             .Left        = 10
378:             .Height      = 46
379:             .Width       = THIS.Width - 20
380:             .ForeColor   = RGB(255, 255, 255)
381:             .Caption     = THIS.Caption
382:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
383:             .Visible     = .T.

*-- Linhas 429 a 472:
429:     * atribuido, e nascer logico faria o primeiro BOParaForm estourar
430:     * "Operator/operand type mismatch".
431:     *==========================================================================
432:     PROTECTED PROCEDURE ConfigurarCampos()
433: 
434:         *-- Say1: rotulo do Cabecalho
435:         THIS.AddObject("lbl_4c_Label1", "Label")
436:         WITH THIS.lbl_4c_Label1
437:             .AutoSize  = .F.
438:             .FontName  = "Tahoma"
439:             .FontSize  = 8
440:             .FontBold  = .F.
441:             .BackStyle = 0
442:             .Alignment = 0
443:             .Top       = 99
444:             .Left      = 85
445:             .Width     = 60
446:             .Height    = 15
447:             .ForeColor = RGB(90, 90, 90)
448:             .Caption   = "Cabe" + CHR(231) + "alho :"
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         *-- getCabs: memo do Cabecalho da carta (SigCdOpt.cabs)
453:         THIS.AddObject("obj_4c_GetCabs", "EditBox")
454:         WITH THIS.obj_4c_GetCabs
455:             .FontName          = "Tahoma"
456:             .FontSize          = 8
457:             .Top               = 99
458:             .Left              = 156
459:             .Width             = 276
460:             .Height            = 84
461:             .ScrollBars        = 2
462:             .Themes            = .F.
463:             .DisabledBackColor = RGB(192, 192, 192)
464:             .DisabledForeColor = RGB(0, 0, 0)
465:             .ToolTipText       = "Cabe" + CHR(231) + "alho impresso na carta de opera" + ;
466:                                  CHR(231) + CHR(245) + "es"
467:             .Value             = ""
468:             .Visible           = .T.
469:         ENDWITH
470: 
471:         *-- Say2: rotulo do Rodape
472:         THIS.AddObject("lbl_4c_Label2", "Label")

*-- Linhas 518 a 616:
518:         *-- rods sao "text" NULL em SigCdOpt - sem tamanho e sem dominio a
519:         *-- validar) e inventar validacao violaria o PILAR 1.
520:         *--
521:         *-- "LostFocus" + "InteractiveChange" de proposito: LostFocus eh a
522:         *-- posicao do Valid legado e InteractiveChange reproduz a escrita
523:         *-- CONTINUA que o ControlSource fazia. Nenhum dos dois passa
524:         *-- parametro, por isso os handlers nao declaram nenhum (regra #3); e
525:         *-- como nao abrem dialogo modal, nao ha reentrancia a guardar
526:         *-- (regra #37). Handlers PUBLIC - BINDEVENT falha em SILENCIO com
527:         *-- metodo PROTECTED.
528:         BINDEVENT(THIS.obj_4c_GetCabs, "LostFocus",         THIS, "ValidarCabecalho")
529:         BINDEVENT(THIS.obj_4c_GetCabs, "InteractiveChange", THIS, "ValidarCabecalho")
530:         BINDEVENT(THIS.obj_4c_GetRods, "LostFocus",         THIS, "ValidarRodape")
531:         BINDEVENT(THIS.obj_4c_GetRods, "InteractiveChange", THIS, "ValidarRodape")
532:     ENDPROC
533: 
534:     *==========================================================================
535:     * ConfigurarBotoesSaida - Grupo_Saida do legado (CommandGroup, 2 botoes)
536:     *
537:     * Este eh o UNICO conjunto de botoes do dialogo. O SCX legado NAO tem Grid,
538:     * NAO tem lista e NAO tem os 6 botoes CRUD (Incluir/Visualizar/Alterar/
539:     * Excluir/Buscar/Encerrar): a arvore do dump tem 11 objetos, com ZERO
540:     * "BaseClass: grid|pageframe|listbox" e ZERO AddCursor/pColuna/Grade. Nao
541:     * ha o que listar - fabricar barra CRUD violaria o PILAR 1 e a regra "NUNCA
542:     * inventar". Medido no gate da Fase 4: este legado cai no ramo "layout
543:     * captura" (sem lista + campos de ENTRADA), que dispensa Grid+CRUD.
544:     *
545:     * Legado (SECAO 2 do dump):
546:     *   Grupo_Saida  AutoSize=.T. ButtonCount=2 BackStyle=0 BorderStyle=0
547:     *                Value=1 Top=-2 Left=389 Width=160 Height=85
548:     *                SpecialEffect=1 BorderColor=136,189,188
549:     *   Command2 "OK"        Top=5 Left=5  75x75 cadastro_salvar_60.jpg   TabIndex=1
550:     *   Command1 "Cancelar"  Top=5 Left=80 75x75 cadastro_cancelar_60.jpg TabIndex=2 Cancel=.T.
551:     *
552:     * Enderecamento por .Buttons(N), NAO por .Name: o legado renomeia
553:     * Command1 -> Sair e Command2 -> OK, e renomear membro de grupo quebraria a
554:     * referencia por indice. Mapa fixo deste form:
555:     *   .Buttons(1) = Command1 = Sair/Cancelar     .Buttons(2) = Command2 = OK
556:     *
557:     * .ButtonCount vem ANTES de qualquer .Buttons(N): CommandGroup criado por
558:     * AddObject nasce com ButtonCount = 0, e .Buttons(1) estouraria "BUTTONS is
559:     * not an object" (medido - nao eh problema da sintaxe do WITH).
560:     *
561:     * O grupo NAO recebe ForeColor nem FontName: CommandGroup nao tem essas
562:     * propriedades (medido em automation\propriedades_baseclasses.txt) e
563:     * atribui-las derrubaria o Init - regra #33. A fonte vai em cada botao.
564:     *
565:     * Left=389 + Width=160 = 549 contra Form.Width = 545: os 4px finais do
566:     * CONTAINER sao recortados, exatamente como no legado (mesma geometria e
567:     * mesma largura de janela). Nenhum BOTAO se perde - Sair termina em 544 - e
568:     * o grupo eh BackStyle = 0, entao nada visivel fica de fora (regra #30).
569:     *
570:     * SpecialEffect / PicturePosition / MousePointer / AutoSize dos BOTOES nao
571:     * aparecem no dump porque vem da CLASSE do Framework, nao da instancia; os
572:     * valores estao em docs\framework_frmcadastro_layout.md ("Propriedades
573:     * comuns de TODOS os botoes"). Sem eles, o CommandButton base do VFP9
574:     * desenharia o icone AO LADO do texto, e nao acima dele.
575:     *==========================================================================
576:     PROTECTED PROCEDURE ConfigurarBotoesSaida()
577:         THIS.AddObject("obj_4c_Grupo_Saida", "CommandGroup")
578: 
579:         WITH THIS.obj_4c_Grupo_Saida
580:             *-- PRIMEIRO: sem ButtonCount, .Buttons(N) nao resolve
581:             .ButtonCount = 2
582: 
583:             *-- .Buttons(2) = Command2 do legado = OK (confirma e fecha)
584:             WITH .Buttons(2)
585:                 .Top             = 5
586:                 .Left            = 5
587:                 .Height          = 75
588:                 .Width           = 75
589:                 .Caption         = "\<OK"
590:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
591:                 .FontName        = "Comic Sans MS"
592:                 .FontSize        = 8
593:                 .FontBold        = .T.
594:                 .FontItalic      = .T.
595:                 .WordWrap        = .T.
596:                 .ForeColor       = RGB(90, 90, 90)
597:                 .BackColor       = RGB(255, 255, 255)
598:                 .Themes          = .F.
599:                 .TabIndex        = 1
600:                 .AutoSize        = .F.
601:                 .SpecialEffect   = 0
602:                 .PicturePosition = 13
603:                 .MousePointer    = 15
604:                 .Visible         = .T.
605:             ENDWITH
606: 
607:             *-- .Buttons(1) = Command1 do legado = Sair/Cancelar. Cancel = .T.
608:             *-- faz o ESC acionar este botao, como no legado.
609:             WITH .Buttons(1)
610:                 .Top             = 5
611:                 .Left            = THIS.this_nSairLeftBase
612:                 .Height          = 75
613:                 .Width           = 75
614:                 .Caption         = "\<Cancelar"
615:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
616:                 .FontName        = "Comic Sans MS"

*-- Linhas 655 a 749:
655: 
656:         *----------------------------------------------------------------------
657:         * Fase 7 - eventos dos botoes. O legado tem um Click por BOTAO, nao um
658:         * Click de GRUPO (SECAO 3: "PROCEDURE Sair.Click" e "PROCEDURE
659:         * OK.Click"), entao a ligacao eh feita em cada Buttons(N) e nao no
660:         * CommandGroup - assim nao eh preciso desempatar por .Value, e o botao
661:         * escondido em CONSULTAR/EXCLUIR/PROCURAR simplesmente nao dispara.
662:         *
663:         * Buttons(2) = Command2 do dump = OK      -> BtnOKClick
664:         * Buttons(1) = Command1 do dump = Sair    -> BtnCancelarClick
665:         *
666:         * Handlers PUBLIC: BINDEVENT nao dispara metodo PROTECTED, e falha em
667:         * SILENCIO quando o alvo nao eh alcancavel (regra #3).
668:         *----------------------------------------------------------------------
669:         BINDEVENT(THIS.obj_4c_Grupo_Saida.Buttons(2), "Click", THIS, "BtnOKClick")
670:         BINDEVENT(THIS.obj_4c_Grupo_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
671:     ENDPROC
672: 
673:     *==========================================================================
674:     * AjustarBotoesPorModo - poe nos botoes o estado que o Init legado
675:     * derivava de pcEscolha:
676:     *   If InList(ThisForm.pcEscolha, 'CONSULTAR', 'EXCLUIR', 'PROCURAR')
677:     *       ThisForm.Grupo_Saida.OK.Visible = .f.
678:     *       ThisForm.Grupo_Saida.Left  = ThisForm.Grupo_Saida.Left  + 64
679:     *       ThisForm.Grupo_Saida.Width = ThisForm.Grupo_Saida.Width - 64
680:     *       ThisForm.Grupo_Saida.Sair.Left = 5
681:     *   Endif
682:     *
683:     * Em valor ABSOLUTO (base +/- 64) e com ramo ELSE que REPOE o estado de
684:     * escrita - ver this_nSaidaLeftBase. O legado nao precisa do ELSE porque o
685:     * dialogo dele nasce e morre num unico modo; aqui o metodo eh reentrante.
686:     *
687:     * O .Width eh NO-OP e esta aqui so por fidelidade: medido no VFP9, com
688:     * AutoSize = .T. o CommandGroup descarta toda atribuicao a .Width, entao o
689:     * "Width - 64" do legado tambem nunca surtiu efeito la. Sem consequencia
690:     * visual - o grupo eh BackStyle = 0 e BorderStyle = 0, isto eh, nao desenha
691:     * nada de si mesmo; o que o usuario ve sao os botoes, e esses obedecem
692:     * (medido: em CONSULTAR o grupo vai para Left = 453, o OK desaparece e o
693:     * Cancelar assume Left = 5). NAO trocar por AutoSize = .F. para "fazer o
694:     * Width colar": o dump declara AutoSize = .T. e a troca mudaria o
695:     * dimensionamento do grupo sem ganho nenhum.
696:     *
697:     * NOME CANONICO do projeto (Fase 8) - era AplicarModoNosBotoesSaida.
698:     * PUBLIC de proposito: o harness do pipeline (TesteAutomatico.prg) chama
699:     * AjustarBotoesPorModo direto no oForm, de FORA da classe. Com PROTECTED a
700:     * chamada estoura "Property AJUSTARBOTOESPORMODO is not found" em runtime,
701:     * porque o PEMSTATUS(...,5) que o harness usa como guarda devolve .T. de
702:     * qualquer jeito (so confere EXISTENCIA, nao escopo). O metodo nao existe
703:     * em FormBase, entao PUBLIC aqui nao alarga escopo herdado (regra #51).
704:     *==========================================================================
705:     PROCEDURE AjustarBotoesPorModo()
706:         LOCAL loc_lSoLeitura
707: 
708:         *-- o grupo pode ainda nao existir se AplicarModoEscolha (PUBLIC) for
709:         *-- chamado de fora antes de InicializarForm concluir
710:         IF !PEMSTATUS(THIS, "obj_4c_Grupo_Saida", 5)
711:             RETURN
712:         ENDIF
713: 
714:         loc_lSoLeitura = THIS.this_lSomenteLeitura
715: 
716:         WITH THIS.obj_4c_Grupo_Saida
717:             *-- OK sai de cena em CONSULTAR/EXCLUIR/PROCURAR e volta nos demais
718:             .Buttons(2).Visible = !loc_lSoLeitura
719: 
720:             IF loc_lSoLeitura
721:                 .Left            = THIS.this_nSaidaLeftBase + 64
722:                 .Width           = THIS.this_nSaidaWidthBase - 64
723:                 .Buttons(1).Left = 5
724:             ELSE
725:                 .Left            = THIS.this_nSaidaLeftBase
726:                 .Width           = THIS.this_nSaidaWidthBase
727:                 .Buttons(1).Left = THIS.this_nSairLeftBase
728:             ENDIF
729:         ENDWITH
730:     ENDPROC
731: 
732:     *==========================================================================
733:     * HabilitarCampos - poe nos dois EditBox o estado que o Init legado
734:     * derivava de pcEscolha, no MESMO If dos botoes:
735:     *       ThisForm.getCabs.ReadOnly = .t.
736:     *       ThisForm.getrods.ReadOnly = .t.
737:     *
738:     * Com ramo ELSE que REPOE ReadOnly = .F., pela mesma razao do irmao
739:     * AjustarBotoesPorModo: o legado atravessa esse If UMA vez, num modal de
740:     * vida curta, enquanto aqui o funil AplicarModoEscolha eh PUBLIC e
741:     * reentrante - sem o ELSE, um unico CONSULTAR travaria os campos para
742:     * sempre (regra #31: reaplicar no funil exige estado ABSOLUTO).
743:     *
744:     * Sem mexer em BackColor: o legado so troca ReadOnly, e o cinza de campo
745:     * desabilitado ja vem do DisabledBackColor da classe fwmemo.
746:     *
747:     * NOME CANONICO do projeto (Fase 8) - era AplicarModoNosCampos. Nao esta
748:     * em FormBase, logo PUBLIC aqui nao alarga escopo herdado (regra #51), e
749:     * PUBLIC eh o que permite ao form PAI reaplicar o modo depois de trocar

*-- Linhas 769 a 987:
769:     * entao VARTYPE = "C"/"N" ja prova que veio) - por isso o Init deste form
770:     * continua certo testando VARTYPE.
771:     *==========================================================================
772:     PROCEDURE HabilitarCampos(par_lHabilitar)
773:         LOCAL loc_lSoLeitura
774: 
775:         *-- os campos podem ainda nao existir se AplicarModoEscolha (PUBLIC)
776:         *-- for chamado de fora antes de InicializarForm concluir
777:         IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
778:             RETURN
779:         ENDIF
780: 
781:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
782:             loc_lSoLeitura = !par_lHabilitar
783:         ELSE
784:             loc_lSoLeitura = THIS.this_lSomenteLeitura
785:         ENDIF
786: 
787:         THIS.obj_4c_GetCabs.ReadOnly = loc_lSoLeitura
788:         THIS.obj_4c_GetRods.ReadOnly = loc_lSoLeitura
789:     ENDPROC
790: 
791:     *==========================================================================
792:     * LimparCampos - zera Cabs/Rods no BO e nos dois EditBox (Fase 8)
793:     *
794:     * Fecha o buraco que o comentario de CarregarCamposDaOrigem ja prometia e
795:     * nao cumpria: "sem origem alcancavel o BO mantem os defaults vazios ...
796:     * nunca o valor de uma abertura anterior". Isso valia so na PRIMEIRA
797:     * carga - o BO eh criado UMA vez por form, e CarregarCamposDaOrigem eh
798:     * PUBLIC e reentrante (o form pai a chama depois de atribuir
799:     * this_oBOOrigem), entao numa segunda carga SEM origem o this_cCabs da
800:     * carga anterior continuava no BO e voltava para a tela.
801:     *
802:     * NAO escreve em campo VINCULADO por ControlSource: ali o .Value eh o
803:     * campo do cursor, e atribuir "" APAGARIA o cabecalho/rodape do registro
804:     * - uma gravacao que ninguem pediu. Por isso o teste de ControlSource
805:     * vazio antes de cada atribuicao. No caminho vinculado nao ha o que
806:     * limpar: quem manda na tela eh o proprio registro.
807:     *
808:     * PROTECTED porque FormBase declara o hook assim - em VFP9 a subclasse NAO
809:     * alarga escopo de metodo herdado (regra #51), e omitir o modificador aqui
810:     * so esconderia que ele continua protegido.
811:     *==========================================================================
812:     PROTECTED PROCEDURE LimparCampos()
813:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
814:             THIS.this_oBusinessObject.this_cCabs = ""
815:             THIS.this_oBusinessObject.this_cRods = ""
816:         ENDIF
817: 
818:         IF PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
819:             IF EMPTY(THIS.obj_4c_GetCabs.ControlSource)
820:                 THIS.obj_4c_GetCabs.Value = ""
821:             ENDIF
822:         ENDIF
823: 
824:         IF PEMSTATUS(THIS, "obj_4c_GetRods", 5)
825:             IF EMPTY(THIS.obj_4c_GetRods.ControlSource)
826:                 THIS.obj_4c_GetRods.Value = ""
827:             ENDIF
828:         ENDIF
829:     ENDPROC
830: 
831:     *==========================================================================
832:     * BOParaForm - leva Cabs/Rods do BO para os dois EditBox
833:     * PROTECTED porque FormBase ja declara o hook assim: em VFP9 a subclasse
834:     * NAO alarga escopo, e escrever sem PROTECTED aqui so esconderia que ele
835:     * continua protegido. Quem precisa disparar a carga de fora usa o
836:     * CarregarCamposDaOrigem(), que eh PUBLIC.
837:     *==========================================================================
838:     PROTECTED PROCEDURE BOParaForm()
839:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
840:             RETURN
841:         ENDIF
842: 
843:         IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
844:             RETURN
845:         ENDIF
846: 
847:         *-- TratarNulo porque cabs/rods sao "text" NULL no schema: coluna
848:         *-- vazia chega como .NULL. e atribuir isso ao EditBox trocaria o tipo
849:         *-- do .Value. O 2o argumento eh o valor PADRAO, nao um codigo de tipo:
850:         *-- passar "C" ali gravaria a LETRA "C" no cabecalho da carta.
851:         THIS.obj_4c_GetCabs.Value = TratarNulo(THIS.this_oBusinessObject.this_cCabs, "")
852:         THIS.obj_4c_GetRods.Value = TratarNulo(THIS.this_oBusinessObject.this_cRods, "")
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * FormParaBO - leva o que esta nos dois EditBox para o BO (Fase 6)
857:     *
858:     * Direcao INVERSA do BOParaForm, e a que faltava: sem ela o usuario digita
859:     * e o valor NUNCA chega ao BO, entao o OK gravaria o conteudo CARREGADO na
860:     * abertura e nao o DIGITADO - falha silenciosa, sem erro em tela nenhum.
861:     *
862:     * SEM ALLTRIM: o legado grava o .Value CRU
863:     *       Replace Cabs With ThisForm.getCabs.Value, ;
864:     *               Rods With ThisForm.getrods.Value
865:     * e cabs/rods sao "text" no schema (SigCdOpt) - aparar o texto aqui mudaria
866:     * o dado gravado. TratarNulo entra apenas para proteger o TIPO: coluna
867:     * "text" NULL devolve .NULL. ao EditBox quando o ControlSource esta
868:     * vinculado, e um .NULL. levado ao BO quebraria as operacoes de string do
869:     * REPLACE em SigOpCocBO.GravarNaOrigem.
870:     *
871:     * PROTECTED porque FormBase declara o hook assim - em VFP9 a subclasse NAO
872:     * alarga escopo de metodo herdado (regra #51). Quem precisa disparar de
873:     * fora usa os handlers PUBLIC ValidarCabecalho/ValidarRodape.
874:     *==========================================================================
875:     PROTECTED PROCEDURE FormParaBO()
876:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
877:             RETURN
878:         ENDIF
879: 
880:         IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
881:             RETURN
882:         ENDIF
883: 
884:         THIS.this_oBusinessObject.this_cCabs = TratarNulo(THIS.obj_4c_GetCabs.Value, "")
885:         THIS.this_oBusinessObject.this_cRods = TratarNulo(THIS.obj_4c_GetRods.Value, "")
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * ValidarCabecalho - handler do campo getCabs (Fase 6)
890:     * Ligado por BINDEVENT em "LostFocus" e "InteractiveChange" (ver
891:     * ConfigurarCampos). Ocupa o lugar da ligacao ControlSource do legado:
892:     * normaliza o valor e o devolve ao BO. Nenhuma regra inventada - o SCX
893:     * legado nao tem Valid neste campo e a coluna destino eh "text" NULL.
894:     *
895:     * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
896:     *
897:     * Em somente leitura (CONSULTAR/EXCLUIR/PROCURAR) nao transfere nada: o
898:     * legado deixa os dois campos ReadOnly e esconde o OK, logo nao existe
899:     * valor digitado a levar para o BO.
900:     *==========================================================================
901:     PROCEDURE ValidarCabecalho()
902:         IF THIS.this_lSomenteLeitura
903:             RETURN
904:         ENDIF
905: 
906:         IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
907:             RETURN
908:         ENDIF
909: 
910:         *-- normaliza o proprio campo antes de transferir: .NULL. vindo da
911:         *-- coluna "text" trocaria o tipo do .Value e travaria a digitacao
912:         IF ISNULL(THIS.obj_4c_GetCabs.Value)
913:             THIS.obj_4c_GetCabs.Value = ""
914:         ENDIF
915: 
916:         THIS.FormParaBO()
917:     ENDPROC
918: 
919:     *==========================================================================
920:     * ValidarRodape - handler do campo getRods (Fase 6)
921:     * Gemeo de ValidarCabecalho - mesmas razoes, mesmo escopo PUBLIC.
922:     *==========================================================================
923:     PROCEDURE ValidarRodape()
924:         IF THIS.this_lSomenteLeitura
925:             RETURN
926:         ENDIF
927: 
928:         IF !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
929:             RETURN
930:         ENDIF
931: 
932:         IF ISNULL(THIS.obj_4c_GetRods.Value)
933:             THIS.obj_4c_GetRods.Value = ""
934:         ENDIF
935: 
936:         THIS.FormParaBO()
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * VincularCamposAoCursorOrigem - transcreve o ControlSource dos dois
941:     * EditBox do SCX legado (Fase 6):
942:     *       getCabs.ControlSource = "CrSigCdOpt.Cabs"
943:     *       getRods.ControlSource = "CrSigCdOpt.Rods"
944:     *
945:     * Por que NAO fica em ConfigurarCampos: no Init o alias ainda nao existe, e
946:     * ControlSource apontando para cursor inexistente estoura "Alias ... is not
947:     * found" DENTRO do TRY do InicializarForm - o CREATEOBJECT devolve .F., o
948:     * menu nao entra no IF VARTYPE(loForm) = "O" e o usuario clica e NADA abre,
949:     * sem erro visivel (regra #41). Por isso a vinculacao roda depois, em
950:     * CarregarCamposDaOrigem, e SO quando o alias esta aberto e tem as colunas.
951:     *
952:     * So vincula no caminho do CURSOR, que eh o que o legado literalmente faz
953:     * ("Select CrSigCdOpt"). No caminho canonico desta migracao (this_oBOOrigem
954:     * = o BO do form pai) nao existe cursor a vincular, e vincular ali faria o
955:     * valor vindo do BO ser ESCRITO no alias ja na abertura, ANTES do OK -
956:     * divergencia que o legado nao tem. Nesse caminho a transferencia eh
957:     * explicita, pelo par BOParaForm / FormParaBO.
958:     *
959:     * Fica VISIVEL que, vinculado, o que o usuario digita vai para o cursor na
960:     * hora: eh o comportamento do legado, cujo Sair.Click so faz Release sem
961:     * desfazer nada - NAO acrescentar restauracao que o legado nao tem.
962:     *==========================================================================
963:     PROTECTED FUNCTION VincularCamposAoCursorOrigem()
964:         LOCAL loc_cAlias, loc_lPodeVincular
965: 
966:         IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
967:             RETURN .F.
968:         ENDIF
969: 
970:         loc_cAlias        = ALLTRIM(TratarNulo(THIS.this_cCursorOrigem, ""))
971:         loc_lPodeVincular = .F.
972: 
973:         *-- exige alias ABERTO e com as DUAS colunas: TYPE devolve "U" quando o
974:         *-- campo nao existe e "C"/"M" quando eh texto/memo
975:         IF VARTYPE(THIS.this_oBOOrigem) != "O" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
976:             IF TYPE(loc_cAlias + ".Cabs") $ "CM" AND TYPE(loc_cAlias + ".Rods") $ "CM"
977:                 loc_lPodeVincular = .T.
978:             ENDIF
979:         ENDIF
980: 
981:         IF loc_lPodeVincular
982:             THIS.obj_4c_GetCabs.ControlSource = loc_cAlias + ".Cabs"
983:             THIS.obj_4c_GetRods.ControlSource = loc_cAlias + ".Rods"
984:         ELSE
985:             THIS.obj_4c_GetCabs.ControlSource = ""
986:             THIS.obj_4c_GetRods.ControlSource = ""
987:         ENDIF

*-- Linhas 996 a 1074:
996:     * repaint. Atribuir "" apenas DESLIGA a ligacao, sem consultar o alias,
997:     * entao eh seguro mesmo com o cursor ja fechado.
998:     *==========================================================================
999:     PROTECTED PROCEDURE DesvincularCamposDoCursorOrigem()
1000:         IF PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
1001:             THIS.obj_4c_GetCabs.ControlSource = ""
1002:         ENDIF
1003: 
1004:         IF PEMSTATUS(THIS, "obj_4c_GetRods", 5)
1005:             THIS.obj_4c_GetRods.ControlSource = ""
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * CarregarCamposDaOrigem - carga inicial dos dois campos, equivalente as
1011:     * tres linhas do Init legado:
1012:     *       Select CrSigCdOpt
1013:     *       ThisForm.getCabs.Value = CrSigCdOpt.Cabs
1014:     *       ThisForm.getrods.Value = CrSigCdOpt.Rods
1015:     *
1016:     * O cursor global CrSigCdOpt do Fortyus nao existe nesta migracao, entao a
1017:     * origem eh resolvida nos dois caminhos que o BO ja preve (ver o cabecalho
1018:     * de SigOpCocBO.prg): this_oBOOrigem (o OptBO do form PAI - caminho
1019:     * canonico) e, na falta dele, o alias this_cCursorOrigem quando estiver
1020:     * aberto na sessao de dados - que eh literalmente a situacao do legado,
1021:     * possivel aqui porque o dialogo nao declara DataSession e portanto roda na
1022:     * sessao do chamador.
1023:     *
1024:     * PUBLIC de proposito: o form PAI so consegue atribuir this_oBOOrigem
1025:     * DEPOIS do CREATEOBJECT (o Init legado recebe apenas pDatasession e
1026:     * pEscolha), entao ele precisa poder repetir a carga antes do Show():
1027:     *       loForm = CREATEOBJECT("FormSigOpCoc", SET("Datasession"), "ALTERAR")
1028:     *       loForm.this_oBOOrigem = THIS.this_oBusinessObject
1029:     *       loForm.CarregarCamposDaOrigem()
1030:     *       loForm.Show()
1031:     * Nao eh chamado de dentro de AplicarModoEscolha justamente para nao
1032:     * sobrescrever o que o usuario ja digitou se o funil de modo rodar de novo.
1033:     *==========================================================================
1034:     PROCEDURE CarregarCamposDaOrigem()
1035:         LOCAL loc_lSucesso, loc_oErro, loc_lVinculado
1036:         loc_lSucesso = .F.
1037: 
1038:         TRY
1039:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1040:                 *-- parte do vazio em TODO caminho: sem isto, uma segunda
1041:                 *-- carga sem origem alcancavel exibiria o Cabs/Rods da carga
1042:                 *-- ANTERIOR (o BO eh criado UMA vez por form e este metodo eh
1043:                 *-- PUBLIC/reentrante). Nao toca em campo vinculado por
1044:                 *-- ControlSource - ver LimparCampos.
1045:                 THIS.LimparCampos()
1046: 
1047:                 IF VARTYPE(THIS.this_oBOOrigem) = "O"
1048:                     *-- caminho canonico: le direto o BO do form pai, espelho
1049:                     *-- exato do que SigOpCocBO.GravarNaOrigem escreve de volta
1050:                     THIS.this_oBusinessObject.this_oBOOrigem = THIS.this_oBOOrigem
1051:                     THIS.this_oBusinessObject.this_cCabs = ;
1052:                         TratarNulo(THIS.this_oBOOrigem.this_cCabs, "")
1053:                     THIS.this_oBusinessObject.this_cRods = ;
1054:                         TratarNulo(THIS.this_oBOOrigem.this_cRods, "")
1055: 
1056:                     *-- chave do registro em edicao, SO para a auditoria: sem
1057:                     *-- ela o ObterChavePrimaria do SigOpCocBO devolve "" e o
1058:                     *-- RegistrarAuditoria do BusinessBase sai pelo
1059:                     *-- "IF EMPTY(loc_cChave) / RETURN .F." - a gravacao
1060:                     *-- funciona e nao deixa rastro em LogAuditoria.
1061:                     *-- PEMSTATUS porque o BO de origem eh de OUTRA classe
1062:                     *-- (OptBO hoje) e nao se pode presumir a property.
1063:                     IF PEMSTATUS(THIS.this_oBOOrigem, "this_cOperacaos", 5)
1064:                         THIS.this_oBusinessObject.this_cOperacaos = ;
1065:                             TratarNulo(THIS.this_oBOOrigem.this_cOperacaos, "")
1066:                     ENDIF
1067: 
1068:                     loc_lSucesso = .T.
1069:                 ELSE
1070:                     *-- caminho alternativo: o alias do registro em edicao esta
1071:                     *-- aberto na sessao (o "Select CrSigCdOpt" do legado).
1072:                     *-- CarregarDoCursor ja guarda tambem os valores de entrada
1073:                     *-- que o Cancelar usa para restaurar.
1074:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor( ;

*-- Linhas 1098 a 1158:
1098:             MsgErro("Erro ao carregar Cabe" + CHR(231) + "alho/Rodap" + CHR(233) + ":" + ;
1099:                 CHR(13) + loc_oErro.Message + ;
1100:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1101:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
1102:                 "FormSigOpCoc.CarregarCamposDaOrigem")
1103:             loc_lSucesso = .F.
1104:         ENDTRY
1105: 
1106:         RETURN loc_lSucesso
1107:     ENDPROC
1108: 
1109:     *==========================================================================
1110:     * AplicarModoEscolha - resolve o estado que o Init legado derivava de
1111:     * pcEscolha e propaga o protocolo para o BO:
1112:     *   If InList(pcEscolha, CONSULTAR, EXCLUIR, PROCURAR) -> somente leitura
1113:     * O Grupo_Saida (Fase 4) e os EditBox getCabs/getRods (Fase 5) recebem o
1114:     * estado aqui, por AjustarBotoesPorModo e HabilitarCampos - os
1115:     * dois reentrantes e com ramo ELSE, porque este funil eh PUBLIC.
1116:     * Metodo PUBLIC: o harness do pipeline chama de fora da classe.
1117:     *==========================================================================
1118:     PROCEDURE AplicarModoEscolha()
1119:         *-- Os TRES primeiros nomes sao os do legado, transcritos do Init:
1120:         *--     If InList(ThisForm.pcEscolha, 'CONSULTAR', 'EXCLUIR', 'PROCURAR')
1121:         *-- "VISUALIZAR" entra na Fase 8 por TRADUCAO de vocabulario, nao por
1122:         *-- politica nova: quem passa o modo eh o form PAI (o legado faz
1123:         *-- "Do Form SigOpCoc With ThisForm.DataSessionId, ThisForm.pcEscolha"),
1124:         *-- e no frmcadastro legado o modo de consulta se chama 'CONSULTAR'
1125:         *-- enquanto no sistema novo o this_cModoAtual equivalente se chama
1126:         *-- "VISUALIZAR". Sem o quarto nome, abrir a carta pelo FormOpt em
1127:         *-- VISUALIZAR daria uma tela EDITAVEL com o botao OK a mostra - o
1128:         *-- oposto do legado, sem erro nenhum na tela. "ALTERAR" eh comum as
1129:         *-- duas vocabularios e "INCLUIR"/"INSERIR" sao os dois modos de
1130:         *-- escrita, entao nada mais precisa de traducao.
1131:         THIS.this_lSomenteLeitura = INLIST(ALLTRIM(UPPER(THIS.this_cEscolha)), ;
1132:             "CONSULTAR", "EXCLUIR", "PROCURAR", "VISUALIZAR")
1133: 
1134:         *-- o dialogo nasce sem confirmacao: so o OK marca this_lConfirmado
1135:         THIS.this_lConfirmado = .F.
1136: 
1137:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1138:             THIS.this_oBusinessObject.this_cEscolha        = THIS.this_cEscolha
1139:             THIS.this_oBusinessObject.this_nDataSession    = THIS.this_nDataSessionOrigem
1140:             THIS.this_oBusinessObject.this_lSomenteLeitura = THIS.this_lSomenteLeitura
1141:             THIS.this_oBusinessObject.this_lConfirmado     = .F.
1142:             THIS.this_oBusinessObject.this_cCursorOrigem   = THIS.this_cCursorOrigem
1143: 
1144:             IF VARTYPE(THIS.this_oBOOrigem) = "O"
1145:                 THIS.this_oBusinessObject.this_oBOOrigem = THIS.this_oBOOrigem
1146:             ENDIF
1147:         ENDIF
1148: 
1149:         *-- propaga o estado para os botoes e para os dois EditBox. Sem
1150:         *-- argumento em HabilitarCampos de proposito: o estado desta tela vem
1151:         *-- de this_lSomenteLeitura, que o legado deriva de pcEscolha - passar
1152:         *-- um literal aqui criaria uma SEGUNDA fonte para a mesma regra.
1153:         THIS.AjustarBotoesPorModo()
1154:         THIS.HabilitarCampos()
1155:     ENDPROC
1156: 
1157:     *==========================================================================
1158:     * BtnOKClick - evento do botao OK (Fase 7)

*-- Linhas 1195 a 1240:
1195:     * usuario ve como consulta. Fica ANTES do TRY - RETURN dentro de TRY/CATCH
1196:     * eh proibido (regra #1).
1197:     *
1198:     * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
1199:     *==========================================================================
1200:     PROCEDURE BtnOKClick()
1201:         LOCAL loc_oErro, loc_lGravou
1202: 
1203:         *-- nada a confirmar quando a tela esta em consulta
1204:         IF THIS.this_lSomenteLeitura
1205:             RETURN
1206:         ENDIF
1207: 
1208:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1209:             MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel - " + ;
1210:                 "n" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar Cabe" + CHR(231) + ;
1211:                 "alho/Rodap" + CHR(233) + ".", "FormSigOpCoc")
1212:             RETURN
1213:         ENDIF
1214: 
1215:         loc_lGravou = .F.
1216: 
1217:         TRY
1218:             *-- 1. o que esta na TELA passa a ser o que esta no BO
1219:             THIS.FormParaBO()
1220: 
1221:             *-- 2. o Replace do legado, pela porta PUBLIC do BusinessBase
1222:             IF THIS.this_oBusinessObject.EditarRegistro()
1223:                 loc_lGravou = THIS.this_oBusinessObject.Salvar()
1224:             ELSE
1225:                 *-- EditarRegistro so recusa com this_lNovoRegistro ligado, e
1226:                 *-- ela NAO exibe nada: aqui a falha nao pode ser muda
1227:                 MsgErro(TratarNulo(THIS.this_oBusinessObject.this_cMensagemErro, ;
1228:                     "N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar a edi" + ;
1229:                     CHR(231) + CHR(227) + "o do registro."), "FormSigOpCoc")
1230:             ENDIF
1231: 
1232:             IF loc_lGravou
1233:                 *-- protocolo lido pelo form pai depois do Show(): este flag
1234:                 *-- vive na FORM e sobrevive ao Destroy, que zera o BO
1235:                 THIS.this_lConfirmado = .T.
1236: 
1237:                 *-- 3. ThisForm.Release do legado - ver FecharDialogo, que
1238:                 *-- fecha com Hide() para o pai poder LER este flag
1239:                 THIS.FecharDialogo()
1240:             ELSE

*-- Linhas 1249 a 1400:
1249:         CATCH TO loc_oErro
1250:             MsgErro(loc_oErro.Message + ;
1251:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1252:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
1253:                 "Erro em FormSigOpCoc.BtnOKClick")
1254:         ENDTRY
1255:     ENDPROC
1256: 
1257:     *==========================================================================
1258:     * BtnCancelarClick - evento do botao Sair/Cancelar (Fase 7)
1259:     *
1260:     * TRANSCRICAO do Sair.Click legado, que tem UMA linha so:
1261:     *       ThisForm.Release
1262:     *
1263:     * NAO pede confirmacao e NAO restaura valor nenhum - o legado nao faz as
1264:     * duas coisas, e acrescenta-las mudaria o comportamento da tela (PILAR 1).
1265:     * Em particular: no caminho em que os EditBox estao vinculados por
1266:     * ControlSource ao alias de origem, o que o usuario digitou JA foi escrito
1267:     * no cursor durante a digitacao, e o Sair legado tambem nao desfaz isso -
1268:     * "restaurar" aqui inventaria um desfazer que o legado nunca teve. O que
1269:     * o Cancelar de fato garante eh nao disparar a gravacao do OK: no caminho
1270:     * canonico (BO do form pai) nada chega ao pai sem passar por GravarNaOrigem.
1271:     *
1272:     * CancelarEdicao() (PUBLIC em BusinessBase) devolve o BO ao estado de
1273:     * consulta, para que um OK posterior numa reabertura nao encontre o BO
1274:     * ainda "em edicao" de uma sessao anterior.
1275:     *
1276:     * Fecha pelo MESMO funil do OK (FecharDialogo, com Hide()): o form pai le
1277:     * this_lConfirmado = .F. para saber que nao deve aproveitar nada, e com
1278:     * Release() essa leitura estouraria "is not an object".
1279:     *
1280:     * Este botao tem Cancel = .T. no dump, entao ESC tambem cai aqui.
1281:     *
1282:     * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
1283:     *==========================================================================
1284:     PROCEDURE BtnCancelarClick()
1285:         LOCAL loc_oErro
1286: 
1287:         TRY
1288:             *-- o dialogo sai SEM confirmacao: o form pai le este flag para
1289:             *-- saber que nao deve aproveitar nada
1290:             THIS.this_lConfirmado = .F.
1291: 
1292:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1293:                 THIS.this_oBusinessObject.this_lConfirmado = .F.
1294:                 THIS.this_oBusinessObject.CancelarEdicao()
1295:             ENDIF
1296: 
1297:             *-- ThisForm.Release do legado - ver FecharDialogo
1298:             THIS.FecharDialogo()
1299: 
1300:         CATCH TO loc_oErro
1301:             MsgErro(loc_oErro.Message + ;
1302:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1303:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
1304:                 "Erro em FormSigOpCoc.BtnCancelarClick")
1305:         ENDTRY
1306:     ENDPROC
1307: 
1308:     *==========================================================================
1309:     * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
1310:     * deliberada de PILAR 3: fecha com Hide(), nao com Release().
1311:     *
1312:     * Medido no VFP9 (2026-10-20): THIS.Release() destroi o objeto mesmo
1313:     * havendo variavel externa apontando para ele - form object NAO segue
1314:     * refcount de COM. A referencia do chamador vira VARTYPE "X" e a leitura
1315:     * seguinte estoura "is not an object". Este dialogo PUBLICA um protocolo
1316:     * de retorno (this_lConfirmado, que o form pai le depois do Show() para
1317:     * saber se deve aproveitar a edicao), entao o Release literal tornava esse
1318:     * protocolo inalcancavel - defeito que o legado nao tem porque la o dado
1319:     * chegava ao pai pelo cursor COMPARTILHADO CrSigCdOpt, eliminado pelo
1320:     * PILAR 3.
1321:     *
1322:     * Hide() em form modal TAMBEM devolve o Show(), entao para o usuario a
1323:     * tela fecha igual (PILAR 1 preservado); muda so o tempo de vida do
1324:     * objeto, que eh PILAR 3, e eh o CHAMADOR quem chama Release() depois de
1325:     * ler. Mesmo desenho que o FormBuscaAuxiliar ("Usa Hide() em vez de
1326:     * Release() para permitir leitura de propriedades") e o Formsigopcks do
1327:     * projeto ja adotam.
1328:     *
1329:     * NAO existe PROCEDURE Unload no SCX legado (SECAO 3 declara tres metodos:
1330:     * Init, Sair.Click e OK.Click), entao nao ha contrato de retorno por
1331:     * "DO FORM ... TO <var>" a espelhar aqui - acrescentar um Unload com
1332:     * RETURN inventaria protocolo que o legado nunca teve.
1333:     *
1334:     * Solta o ControlSource ANTES de esconder: entre o Hide() e o Release()
1335:     * do chamador o form continua vivo, e o pai pode fechar o alias de origem
1336:     * nesse intervalo - EditBox vinculado a alias morto estoura no proximo
1337:     * repaint. Desvincular NAO desfaz nada: no caminho vinculado o digitado ja
1338:     * foi escrito no cursor durante a digitacao, e o Sair legado tambem nao
1339:     * desfaz (ver VincularCamposAoCursorOrigem).
1340:     *
1341:     * Funil UNICO dos dois botoes: OK e Cancelar compartilham a decisao de
1342:     * COMO fechar, e so divergem no this_lConfirmado que cada um deixa.
1343:     *==========================================================================
1344:     PROCEDURE FecharDialogo()
1345:         THIS.DesvincularCamposDoCursorOrigem()
1346: 
1347:         THIS.Hide()
1348:     ENDPROC
1349: 
1350:     *==========================================================================
1351:     * TornarControlesVisiveis - AddObject cria os controles com Visible = .F.
1352:     * Percorre os controles da Form e os filhos de cada container. Este
1353:     * dialogo nao tem container flutuante (nenhum objeto do SCX nasce com
1354:     * Visible = .F.), entao nao ha lista de excecao a respeitar.
1355:     *==========================================================================
1356:     PROTECTED PROCEDURE TornarControlesVisiveis()
1357:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
1358: 
1359:         FOR loc_nI = 1 TO THIS.ControlCount
1360:             loc_oControle = THIS.Controls(loc_nI)
1361: 
1362:             IF VARTYPE(loc_oControle) = "O"
1363:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
1364:                     loc_oControle.Visible = .T.
1365:                 ENDIF
1366: 
1367:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
1368:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
1369:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
1370:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
1371:                             loc_oFilho.Visible = .T.
1372:                         ENDIF
1373:                     ENDFOR
1374:                 ENDIF
1375:             ENDIF
1376:         ENDFOR
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * Destroy - libera o BO e as referencias ao form pai
1381:     * DODEFAULT() eh a ULTIMA linha: FormBase.Destroy reconstroi os popups do
1382:     * menu principal, e sem ele o menu encolhe ao fechar o dialogo.
1383:     *==========================================================================
1384:     PROCEDURE Destroy()
1385:         *-- solta o ControlSource antes de tudo: o alias do form pai pode
1386:         *-- ja ter sido fechado, e EditBox vinculado a alias morto estoura
1387:         *-- no proximo repaint
1388:         THIS.DesvincularCamposDoCursorOrigem()
1389: 
1390:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1391:             THIS.this_oBusinessObject = .NULL.
1392:         ENDIF
1393: 
1394:         *-- referencia ao BO do form PAI: soltar sem destruir o objeto dele
1395:         THIS.this_oBOOrigem = .NULL.
1396: 
1397:         DODEFAULT()
1398:     ENDPROC
1399: 
1400: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCocBO.prg):
*==============================================================================
* SigOpCocBO.prg - Business Object para Carta de Operacoes de Cheques
* Origem: SigOpCoc.SCX (task705)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo filho modal, aberto por FormOpt / cmd_4c_BtnCarta)
* Tabela: SigCdOpt | PK: operacaos
* Gerado: Fase 1/8 - Propriedades e Init
*
* CONTRATO DO LEGADO (SIGOPCOC.SCX)
*   Init(pDatasession, pEscolha):
*       Set DataSession to pDatasession
*       ThisForm.pcEscolha = pEscolha
*       Select CrSigCdOpt
*       getCabs.Value = CrSigCdOpt.Cabs
*       getRods.Value = CrSigCdOpt.Rods
*       Se pcEscolha em (CONSULTAR, EXCLUIR, PROCURAR): oculta OK e deixa
*       os dois EditBox com ReadOnly = .T.
*   OK.Click:
*       Select CrSigCdOpt
*       Replace Cabs With getCabs.Value, Rods With getRods.Value
*       ThisForm.Release
*   Sair.Click:
*       ThisForm.Release   (descarta a edicao)
*
* CONSEQUENCIA PARA A MIGRACAO
*   O dialogo NAO grava direto no SQL Server: nao ha Insert Into / Update /
*   Delete From, nao ha TABLEUPDATE e nao ha .AddCursor no dump. A "gravacao"
*   dele, fiel ao legado, eh devolver Cabs/Rods ao registro em edicao do form
*   PAI (FormOpt / OptBO) via Replace - por isso Inserir()/Atualizar() abaixo
*   NAO montam SQL para SigCdOpt (isso inventaria operacao que o legado nao
*   tem): eles delegam para this_oBOOrigem (ou, na falta dele, fazem o Replace
*   direto no alias this_cCursorOrigem). Quem persiste de fato em SigCdOpt
*   continua sendo o OptBO do form pai, no Salvar() dele.
*   ExecutarExclusao() permanece NAO sobrescrito: o legado nao tem exclusao
*   nesta tela, e o comportamento herdado de BusinessBase (recusar e reportar
*   via ExibirFalha) ja eh o correto.
*
*   O cursor global CrSigCdOpt do Fortyus NAO existe nesta migracao (ver
*   FormSigOpChi.prg:3346). A ligacao com o registro em edicao eh feita por
*   this_oBOOrigem (referencia ao OptBO do form pai), com this_cCursorOrigem
*   como caminho alternativo quando o alias estiver aberto na sessao.
*==============================================================================

DEFINE CLASS SigOpCocBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpt"
    this_cCampoChave  = "operacaos"

    *--------------------------------------------------------------------------
    * Dados editados pelo dialogo - colunas de SigCdOpt
    *--------------------------------------------------------------------------
    this_cOperacaos        = ""    && operacaos char(15) - PK do registro em edicao
    this_cCabs             = ""    && cabs      text     - getCabs: cabecalho da carta
    this_cRods             = ""    && rods      text     - getRods: rodape da carta

    *--------------------------------------------------------------------------
    * Valores de entrada - usados para Cancelar e para detectar alteracao
    * O Sair.Click do legado descarta a edicao; guardar o valor que chegou eh
    * o que permite restaurar sem reconsultar a origem.
    *--------------------------------------------------------------------------
    this_cCabsOriginal     = ""    && valor de cabs no momento em que o dialogo abriu
    this_cRodsOriginal     = ""    && valor de rods no momento em que o dialogo abriu

    *--------------------------------------------------------------------------
    * Protocolo do dialogo - parametros do Init legado
    *--------------------------------------------------------------------------
    this_cEscolha          = ""    && pcEscolha: INSERIR / ALTERAR / CONSULTAR / EXCLUIR / PROCURAR
    this_nDataSession      = 0     && pDatasession: id da sessao de dados do form pai
    this_lSomenteLeitura   = .F.   && .T. em CONSULTAR / EXCLUIR / PROCURAR (oculta OK, campos ReadOnly)
    this_lConfirmado       = .F.   && .T. somente quando o usuario acionou OK (nao Cancelar)

    *--------------------------------------------------------------------------
    * Ligacao com a origem dos dados (equivalente ao Select CrSigCdOpt legado)
    *--------------------------------------------------------------------------
    this_cCursorOrigem     = "CrSigCdOpt"   && alias do cursor do registro em edicao, quando aberto
    this_oBOOrigem         = .NULL.         && referencia ao OptBO do form pai (caminho canonico)

    *==========================================================================
    * Init - Configura tabela e campo chave
    * NUNCA devolver .F. daqui: BO.Init() falso mata o form (o CREATEOBJECT
    * do chamador recebe .F. e o dialogo nao abre).
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdOpt"
        THIS.this_cCampoChave = "operacaos"

        *-- O dialogo nasce sem confirmacao: somente o OK marca
        *-- this_lConfirmado. Reset explicito porque o BO pode ser
        *-- reaproveitado entre aberturas do dialogo no mesmo form pai.
        THIS.this_lConfirmado     = .F.
        THIS.this_lSomenteLeitura = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOperacaos)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega operacaos/cabs/rods do cursor em edicao
    * Equivalente ao Init legado: Select CrSigCdOpt / getCabs.Value = Cabs /
    * getRods.Value = Rods. NAO eh PROTECTED: o form chama de fora (THIS.
    * this_oBusinessObject.CarregarDoCursor(...)), igual aos demais BOs CRUD.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("Operacaos") != "U"
                    THIS.this_cOperacaos = TratarNulo(Operacaos, "")
                ENDIF
                IF TYPE("Cabs") != "U"
                    THIS.this_cCabs = TratarNulo(Cabs, "")
                ENDIF
                IF TYPE("Rods") != "U"
                    THIS.this_cRods = TratarNulo(Rods, "")
                ENDIF

                *-- guarda o valor de entrada para o Sair/Cancelar restaurar
                THIS.this_cCabsOriginal = THIS.this_cCabs
                THIS.this_cRodsOriginal = THIS.this_cRods

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "SigOpCocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarNaOrigem - Operacao REAL de gravacao deste dialogo: devolve Cabs/
    * Rods ao registro do form pai, igual ao OK.Click legado (Replace Cabs
    * With getCabs.Value, Rods With getRods.Value In CrSigCdOpt).
    * Chamada por Inserir()/Atualizar() - o legado nao distingue os dois
    * casos (o Click eh unico), por isso os dois delegam para aqui.
    *==========================================================================
    PROTECTED FUNCTION GravarNaOrigem(par_cOperacao)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBOOrigem) = "O"
                *-- caminho canonico: devolve os valores ao BO do form pai
                THIS.this_oBOOrigem.this_cCabs = THIS.this_cCabs
                THIS.this_oBOOrigem.this_cRods = THIS.this_cRods
                loc_lSucesso = .T.
            ELSE
                IF VARTYPE(THIS.this_cCursorOrigem) = "C" AND !EMPTY(THIS.this_cCursorOrigem) ;
                        AND USED(THIS.this_cCursorOrigem)
                    *-- caminho alternativo: Replace direto no alias aberto na sessao
                    SELECT (THIS.this_cCursorOrigem)
                    REPLACE Cabs WITH THIS.this_cCabs, ;
                            Rods WITH THIS.this_cRods
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel localizar o registro de origem para gravar Cabe" + CHR(231) + ;
                        "alho/Rodap" + CHR(233) + "."
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_lConfirmado = .T.
                THIS.RegistrarAuditoria(par_cOperacao)
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao gravar Cabe" + CHR(231) + "alho/Rodap" + CHR(233) + ;
                ": " + loException.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - delega para GravarNaOrigem (o legado nao distingue
    * INSERIR/ALTERAR no Click; os dois produzem o mesmo Replace)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN THIS.GravarNaOrigem("INSERT")
    ENDPROC

    *==========================================================================
    * Atualizar - delega para GravarNaOrigem (caso de uso real deste dialogo:
    * ele sempre edita um registro ja existente no form pai)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN THIS.GravarNaOrigem("UPDATE")
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.AplicarRotuloFormaPagto()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.Grade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.Grade.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPGC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2088 linhas total):

*-- Linhas 23 a 129:
23: * sessao corrente para a do form pai - sem isso o cursor crSigOpFp do pai
24: * ficaria invisivel para este dialogo (sessao privada isolada). Transcrito
25: * fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do Init, ANTES
26: * de DODEFAULT() (que dispara InicializarForm).
27: *
28: * this_oFormPai equivale a property customizada "parentform" do legado
29: * (RESERVED3 ClassInfo: antvalue/gravadados/parentform/podatamgr/saldo/
30: * *mctrlbotoes - comentada). this_nSaldoRecebido equivale a "Saldo" - valor
31: * disponivel para pagamento (poValor), recebido ANTES do Business Object
32: * existir (criado so em InicializarForm) e repassado a
33: * this_oBusinessObject.this_nSaldoInicial/this_nSaldoAtual logo apos a
34: * criacao; a reproducao em tela (txt_4c_Saldo.Value = Saldo, equivalente a
35: * "ThisForm.Get_Saldo.Value = ThisForm.Saldo" do Init legado) entra so na
36: * fase em que o controle Get_Saldo for criado. "antvalue"/"gravadados" e o
37: * "*mctrlbotoes" (comentado no dump) sao reservados no ClassInfo mas NUNCA
38: * referenciados em metodo/evento nenhum da SECAO 3 do dump extraido -
39: * residuo de template copiado de outro form da familia SigOpPxx (o mesmo
40: * fenomeno documentado em Formsigopped.prg para "gravadados") - por isso
41: * NAO sao portados como property (evita inventar estado morto). poDataMgr
42: * (4o parametro do Init legado, pConexao) tambem nao tem equivalente nesta
43: * arquitetura - gnConnHandle eh compartilhado via config.prg - o parametro
44: * eh aceito so por compatibilidade de assinatura com a chamada do form pai
45: * e descartado (mesma decisao de Formsigopped.prg para poDataMgr).
46: *
47: * O cursor LOCAL BarBonus (sem tabela no SQL Server - SIGOPPGCBO.this_cTabela
48: * fica vazio de proposito, ver cabecalho de SIGOPPGCBO.prg) eh criado por
49: * este proprio form, no mesmo padrao de GarantirCursorGrade de
50: * Formsigoppei.prg - entra na Fase 4/8, junto com a grade que o consome
51: * (ColumnCount -> RecordSource -> ControlSource, regra CLAUDE.md #41 -
52: * Column.ControlSource de cursor que ainda nao existe derruba o Init).
53: *
54: * Esta tela NAO eh acessada pelo menu principal (nenhum "Abrir*" em
55: * menu.prg) - eh sempre aberta por um form pai de pagamento que ja mantem
56: * o cursor crSigOpFp e o saldo a distribuir, exatamente como Formsigopped.prg
57: * (tambem sem entrada propria no menu). A carga sob demanda
58: * (start\indice_classes.txt) resolve a dependencia de SIGOPPGCBO.prg
59: * automaticamente quando o form pai instanciar esta classe - nao requer
60: * SET PROCEDURE manual em config.prg (regra CLAUDE.md "Carga SOB DEMANDA").
61: *
62: * Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
63: *
64: * Herda de: FormBase          BO associado: SIGOPPGCBO
65: * Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
66: *
67: * Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
68: * Fase 4/8: Grade (BarBonus, 2 colunas Barra/Valor) + o funil de carga
69: *     (GarantirCursorGrade -> VincularGrade -> CarregarDados, que transcreve
70: *     o bloco "With Thisform.Grade ... .Refresh / ThisForm.Grade.Refresh" do
71: *     Init legado) + os dois botoes de acao (Ok/Cancela) - unico bloco de
72: *     "botoes" real desta tela (nao ha cnt_4c_Botoes/cnt_4c_BotoesAcao
73: *     genericos: o legado nao os tem, e inventa-los violaria o PILAR 1).
74: * Fase 5/8: Shape1 (moldura decorativa) + Label1 (rotulo da forma de
75: *     pagamento, Caption montado em runtime a partir de crSigOpFp.fpags).
76: * Fase 6/8: Label2/Label3 (legenda do saldo e contador de barras validas -
77: *     Get_Saldo ja entrou na Fase 5) + a validacao da celula da grade
78: *     (Grade.Column1.Text1 When/Valid/LostFocus e Grade.Column2.Text1 When do
79: *     legado), em subclasses de TextBox instaladas por CurrentControl, mais o
80: *     funil AtualizarSaldoEQuantidade que da conteudo aos dois labels e ao
81: *     txt_4c_Saldo. Esta tela NAO TEM lookup: o dump nao tem fwBuscaExt/
82: *     fwBuscaSel/fwBuscaInt, mAddColuna nem sigacess/Acesso* - o codigo de
83: *     barra eh DIGITADO e conferido contra SigCdOpe pelo Valid da celula, e
84: *     criar um picker aqui inventaria consulta que o legado nunca faz (viola
85: *     o PILAR 1).
86: * Fase 7/8: os eventos dos botoes - BtnConfirmarClick/BtnCancelarClick
87: *     (Ok.Click/Cancela.Click do legado, nomeados pela ACAO que executam e
88: *     nao pelo OBJETO do SCX, que o PILAR 3 manda renomear) e o funil de
89: *     saida comum aos dois (FecharDialogo), mais o BINDEVENT de Click que a
90: *     Fase 4 deixou em aberto e o resto da orquestracao do Init legado
91: *     (PrepararLinhaInicial: Zap + Append Blank em BarBonus). Get_Saldo.Value
92: *     inicial entrou na Fase 5 e Label1.Caption na Fase 5/6, junto com os
93: *     respectivos controles; o bind da grade entrou na Fase 4, pelo funil
94: *     CarregarDados.
95: *
96: *     Esta tela NAO TEM a barra CRUD do frmcadastro (os quatro Btn<verbo>Click
97: *     de incluir, alterar, visualizar e excluir um registro): o objeto raiz
98: *     do legado eh "form" puro, nao ha Grupo_Op, nao ha variavel de modo e os
99: *     DOIS unicos botoes do dump sao Ok e Cancela. Criar esses quatro aqui
100: *     seria INVENTAR botao que o legado nao tem (viola o PILAR 1) ou escrever
101: *     metodo vazio (proibido pela regra de completude). Os nomes nao sao
102: *     citados por extenso de proposito: os gates procuram o identificador no
103: *     .prg INTEIRO, comentario incluido, e escreve-los aqui faria a fase
104: *     aprovar pelo motivo errado - como se os handlers existissem.
105: * Fase 8/8: consolidacao final - os dois funis de transferencia
106: *     form <-> BO, que ate aqui aconteciam valor a valor, espalhados pelos
107: *     metodos que os consomem:
108: *       FormParaBO(par_oTxt)  - le a celula da grade e entrega ao BO o codigo
109: *           de barra (this_cCodigoBarra, 10 digitos) mais a decisao
110: *           Inserir x Atualizar (this_lNovoRegistro, derivada do _OldCodigo
111: *           capturado pelo When). Consumido por ValidarBarraDigitada.
112: *       BOParaForm()          - espelha na tela os TRES valores que o BO
113: *           calcula (rotulo da forma de pagamento, contador de barras e
114: *           saldo). Consumido por AtualizarSaldoEQuantidade.
115: *       PintarRotuloFormaPagto() - fonte UNICA do Caption de lbl_4c_Label1,
116: *           compartilhada por BOParaForm e por AplicarRotuloFormaPagto (o
117: *           Init), para as duas nao divergirem (CLAUDE.md #44, item 6).
118: *     Nao entram aqui os metodos de ciclo CRUD que o pipeline costuma pedir
119: *     nesta fase (habilitar/limpar campos por modo, ajustar botoes por modo,
120: *     carga de lista): esta tela nao tem modo de edicao, nem campos ligados a
121: *     um registro, nem pagina de lista - cria-los seria INVENTAR superficie
122: *     que o legado nao tem (viola o PILAR 1) ou escrever metodo vazio
123: *     (proibido pela regra de completude). A carga da grade ja tem funil
124: *     proprio desde a Fase 4 (CarregarDados), que eh tambem o nome que o
125: *     harness de teste procura em form OPERACIONAL.
126: *
127: * Eventos do legado SEM equivalente no migrado (unico caso):
128: *   Load ("=fConfigGeral()") - NAO PORTADO. fConfigGeral era funcao GLOBAL da
129: *     aplicacao legado (sig.prg / SIGFUNCS.PRG) que nao veio no acervo; o que

*-- Linhas 147 a 796:
147:     * Propriedades visuais - transcritas do dump do SCX legado (secao
148:     * "PROPRIEDADES DE: SIGOPPGC"). ControlBox/TitleBar: sem X e sem barra de
149:     * titulo - nenhum botao de sistema desenha. Picture (fundo do form) eh
150:     * atribuido em InicializarForm, nao aqui (mesmo padrao de
151:     * Formsigopped.prg), porque depende de gc_4c_CaminhoIcones (so disponivel
152:     * em runtime, apos config.prg ter executado).
153:     *==========================================================================
154:     Height       = 420
155:     Width        = 500
156:     DataSession  = 2
157:     ShowWindow = 1
158:     AutoCenter   = .T.
159:     BorderStyle  = 1
160:     ControlBox   = .F.
161:     MaxButton    = .F.
162:     MinButton    = .F.
163:     Movable      = .F.
164:     ClipControls = .F.
165:     TitleBar     = 0
166:     WindowType   = 1
167:     Caption      = "Informe os Barras"
168: 
169:     *==========================================================================
170:     * this_oFormPai - equivale a property customizada "parentform" do legado
171:     * ("LParameters poForm,pnDataSes,poValor,pConexao" + "Thisform.ParentForm
172:     * = poForm" + "Thisform.ParentForm.Enabled = .F." no Init). Referencia ao
173:     * form de pagamento que abriu este dialogo - reabilitado (Enabled = .T.)
174:     * no funil de saida FecharDialogo, alcancado por BtnConfirmarClick e por
175:     * BtnCancelarClick (mesmo padrao do legado, que faz
176:     * isso no Click de cada botao, nao no Release).
177:     *==========================================================================
178:     this_oFormPai = .NULL.
179: 
180:     *==========================================================================
181:     * this_nSaldoRecebido - equivale a property customizada "Saldo" do legado
182:     * ("ThisForm.Saldo = poValor"). Staging property: o Init recebe o valor
183:     * ANTES do Business Object existir (criado so em InicializarForm, que
184:     * roda depois via DODEFAULT()) - guardado aqui e repassado a
185:     * this_oBusinessObject.this_nSaldoInicial/this_nSaldoAtual logo na
186:     * criacao do BO.
187:     *==========================================================================
188:     this_nSaldoRecebido = 0
189: 
190:     *==========================================================================
191:     * this_cCursorGrade - nome do alias que a grade consome ("BarBonus" no
192:     * legado: "Select BarBonus / Zap / Append Blank" e ".RecordSource =
193:     * 'BarBonus'" no Init). Fonte UNICA do nome, compartilhada por
194:     * GarantirCursorGrade, VincularGrade e CarregarDados - sem isso o alias
195:     * diverge entre as fases seguintes (que ainda vao mexer no mesmo cursor
196:     * no Valid/LostFocus da celula e nos handlers de Ok/Cancela).
197:     *
198:     * O alias eh do form CHAMADOR quando a tela eh aberta pelo pai (o Init
199:     * faz SET DATASESSION TO a sessao dele, entao BarBonus ja esta aberto);
200:     * GarantirCursorGrade so o cria quando ele NAO existe - caso do harness
201:     * de teste e da validacao de UI, que instanciam o form sem chamador.
202:     *==========================================================================
203:     this_cCursorGrade = "BarBonus"
204: 
205:     *==========================================================================
206:     * this_cCursorFormaPagto - nome do alias da forma de pagamento CORRENTE no
207:     * form pai ("crSigOpFp" no legado: "AllTrim(crSigOpFp.fpags)" no Init e
208:     * "Replace Valors With CrSigOpFp.VlrFpgs" no Valid da celula). Fonte UNICA
209:     * do nome, como this_cCursorGrade.
210:     *
211:     * O alias eh do CHAMADOR - este dialogo nunca o abre: o Init faz SET
212:     * DATASESSION TO a sessao do pai, e eh assim que crSigOpFp fica visivel
213:     * aqui. Quando a tela eh instanciada sem chamador (harness de teste,
214:     * validacao de UI) ele simplesmente nao existe, e todo uso eh guardado por
215:     * USED().
216:     *==========================================================================
217:     this_cCursorFormaPagto = "crSigOpFp"
218: 
219:     *==========================================================================
220:     * this_nCodigoBarraAnterior - equivale a "_OldCodigo" do legado
221:     * ("PROCEDURE When / Public _OldCodigo / Set Confirm On / _OldCodigo =
222:     * This.Value / Return(.t.)" em Grade.Column1.Text1): o valor que a celula
223:     * JA tinha quando o usuario entrou nela. No legado a variavel eh PUBLIC e
224:     * NUNCA eh lida de volta - nem neste SCX nem em outro arquivo do acervo
225:     * (conferido no dump: as 2 unicas ocorrencias sao a declaracao e a
226:     * atribuicao), ou seja, la ela eh estado morto, no mesmo nivel de
227:     * "antvalue"/"gravadados" do ClassInfo.
228:     *
229:     * Aqui ela tem uso REAL e eh por isso que foi portada (e nao descartada
230:     * como os outros residuos): eh ela que distingue linha NOVA de CORRECAO de
231:     * uma linha ja digitada, que eh a escolha entre
232:     * SIGOPPGCBO.Inserir()/Atualizar() e, por consequencia, o rotulo
233:     * "INSERT"/"UPDATE" que o BO grava em LogAuditoria
234:     * ("RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, ...))"). Sem ela toda
235:     * barra digitada seria auditada com o mesmo rotulo.
236:     *
237:     * NUMERICA (nao CHARACTER como o "_" do legado sugere): a coluna
238:     * BarBonus.Codigos eh N(10,0) e o legado compara com numero ("If
239:     * This.Value > 0", "Where Codigos = This.Value").
240:     *==========================================================================
241:     this_nCodigoBarraAnterior = 0
242: 
243:     *==========================================================================
244:     * Init - replica "LParameters poForm, pnDataSes, poValor, pConexao" do
245:     * legado. Todos os 4 parametros sao OPCIONAIS: o harness de teste e a
246:     * validacao de UI instanciam o form sem parametro nenhum
247:     * (CREATEOBJECT("FormSIGOPPGC")). par_oConexaoLegado (equivale a
248:     * "pConexao"/"Podatamgr" do legado) eh aceito so por compatibilidade de
249:     * assinatura com a chamada do form pai e DESCARTADO - gnConnHandle eh
250:     * compartilhado via config.prg nesta arquitetura, nao instanciado por
251:     * form (mesma decisao de Formsigopped.prg para poDataMgr).
252:     *
253:     * Ordem EXATA do legado: SET DATASESSION primeiro (senao os cursores do
254:     * form pai, como crSigOpFp, ficariam invisiveis), depois ParentForm
255:     * (assign + Enabled = .F., na mesma linha do legado), depois Saldo.
256:     * NUNCA chamar InicializarForm aqui tambem - DODEFAULT() chamar duas
257:     * vezes estoura "member object already exists" nos AddObject.
258:     *==========================================================================
259:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_nSaldo, par_oConexaoLegado)
260:         IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
261:             SET DATASESSION TO (par_nDataSessionPai)
262:         ENDIF
263: 
264:         IF VARTYPE(par_oFormPai) = "O"
265:             THIS.this_oFormPai = par_oFormPai
266:             THIS.this_oFormPai.Enabled = .F.
267:         ENDIF
268: 
269:         IF VARTYPE(par_nSaldo) = "N"
270:             THIS.this_nSaldoRecebido = par_nSaldo
271:         ENDIF
272: 
273:         RETURN DODEFAULT()
274:     ENDPROC
275: 
276:     *==========================================================================
277:     * InicializarForm - monta a estrutura base: fundo do form, Business
278:     * Object (com o saldo recebido ja repassado) e o cabecalho (unico bloco
279:     * visual entregue nesta fase). Os demais blocos (Grade, botoes Ok/
280:     * Cancela, Shape1, campos) entram em ConfigurarPageFrame nas fases
281:     * seguintes, na mesma ordem do dump do SCX.
282:     *==========================================================================
283:     PROTECTED PROCEDURE InicializarForm()
284:         LOCAL loc_lSucesso, loc_oErro
285:         loc_lSucesso = .F.
286: 
287:         TRY
288:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
289:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
290: 
291:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPPGCBO")
292: 
293:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
294:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPPGCBO.", ;
295:                     "Erro em InicializarForm")
296:             ELSE
297:                 *-- "ThisForm.Saldo = poValor" do Init legado, repassado ao BO
298:                 *-- (Get_Saldo.Value = ThisForm.Saldo entra quando o controle
299:                 *-- for criado - fase 6).
300:                 THIS.this_oBusinessObject.this_nSaldoInicial = THIS.this_nSaldoRecebido
301:                 THIS.this_oBusinessObject.this_nSaldoAtual   = THIS.this_nSaldoRecebido
302: 
303:                 THIS.ConfigurarPageFrame()
304: 
305:                 *-- "With Thisform / .label1.Caption = '[ '+AllTrim(
306:                 *-- crSigOpFp.fpags)+' ]' / EndWith" do Init legado. Roda
307:                 *-- DEPOIS de ConfigurarPageFrame (que cria lbl_4c_Label1) e
308:                 *-- ANTES de CarregarDados, porque tambem eh o que carrega
309:                 *-- this_nValorPorBarra do BO - o valor que cada barra
310:                 *-- digitada grava em BarBonus.Valors. Sem o cursor do
311:                 *-- chamador devolve .F. sem avisar: o rotulo fica com o
312:                 *-- Caption do SCX e a tela abre igual.
313:                 THIS.AplicarRotuloFormaPagto()
314: 
315:                 THIS.TornarControlesVisiveis(THIS)
316: 
317:                 *-- "Select BarBonus / Zap / Append Blank" do Init legado -
318:                 *-- deixa o cursor com UMA linha em branco, pronta para a 1a
319:                 *-- barra. Roda ANTES de CarregarDados (que faz o bind e o
320:                 *-- Refresh), na mesma ordem do legado.
321:                 THIS.PrepararLinhaInicial()
322: 
323:                 *-- Funil de carga da grade - equivale ao bloco final do Init
324:                 *-- legado ("With Thisform.Grade / .RecordSource = 'BarBonus'
325:                 *-- / .Column1.ControlSource ... / .Refresh / EndWith /
326:                 *-- ThisForm.Grade.Refresh"). Chamado DEPOIS de
327:                 *-- TornarControlesVisiveis: Refresh em controle ainda
328:                 *-- invisivel nao pinta (regra CLAUDE.md #21/#46). O retorno
329:                 *-- NAO condiciona loc_lSucesso - sem o cursor do chamador
330:                 *-- (harness/validacao de UI) o bind eh pulado e a tela abre
331:                 *-- do mesmo jeito.
332:                 THIS.CarregarDados()
333: 
334:                 loc_lSucesso = .T.
335:             ENDIF
336:         CATCH TO loc_oErro
337:             MsgErro(loc_oErro.Message + CHR(13) + ;
338:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
339:                 "Procedure: " + loc_oErro.Procedure, ;
340:                 "Erro em InicializarForm")
341:         ENDTRY
342: 
343:         RETURN loc_lSucesso
344:     ENDPROC
345: 
346:     *==========================================================================
347:     * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
348:     * real neste form (objeto raiz do legado eh "Class: form" generico, sem
349:     * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
350:     * convencao com o restante do pipeline (mesmo padrao de Formsigopped.prg/
351:     * Formsigoppei.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
352:     * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
353:     * Shape1/Label1 -> Ok/Cancela -> Grade -> Get_Saldo/Label2/Label3 (fases
354:     * seguintes).
355:     *
356:     * A ORDEM das chamadas eh a ordem dos AddObject, e o AddObject eh quem
357:     * define o z-order (ultimo criado desenha por cima) - por isso ela segue
358:     * EXATAMENTE a SECAO 1 do dump. Shape1 (222..395 x 7..117) cruza a area
359:     * do cmd_4c_Ok (350..425 x 3..78) e Label1 (156..294 x 98..113) cruza
360:     * Shape1: no legado os botoes e o rotulo vem DEPOIS e ficam por cima.
361:     * Inverter a ordem aqui esconderia controle sem dar erro nenhum (mesma
362:     * mecanica da regra CLAUDE.md #11).
363:     *
364:     * ConfigurarRodapeStatus fecha a lista com os dois ULTIMOS objetos do
365:     * dump (Label2/Label3) - entraram junto com o funil que recalcula saldo e
366:     * quantidade (AtualizarSaldoEQuantidade), porque e' esse funil que da
367:     * conteudo a eles.
368:     *==========================================================================
369:     PROTECTED PROCEDURE ConfigurarPageFrame()
370:         THIS.ConfigurarCabecalho()
371:         THIS.ConfigurarMolduraFormaPagto()
372:         THIS.ConfigurarBotoes()
373:         THIS.ConfigurarGrade()
374:         THIS.ConfigurarCampoSaldo()
375:         THIS.ConfigurarRodapeStatus()
376:     ENDPROC
377: 
378:     *==========================================================================
379:     * ConfigurarBotoes - os DOIS botoes de acao do form (Ok/Cancela),
380:     * transcritos do dump da SECAO 2 (secoes "PROPRIEDADES DE: SIGOPPGC.Ok" e
381:     * "PROPRIEDADES DE: SIGOPPGC.Cancela"). Nao ha cnt_4c_Botoes/
382:     * cnt_4c_BotoesAcao/cnt_4c_Saida genericos: no legado os dois botoes sao
383:     * filhos DIRETOS do form, sem container, e inventar um aqui violaria o
384:     * PILAR 1 (mesma decisao de Formsigoppei.prg/Formsigopped.prg para os
385:     * botoes soltos deles).
386:     *
387:     * Objetos: Class/BaseClass = commandbutton (SEM ClassLoc em framework.vcx
388:     * no dump) - todas as propriedades vem EXPLICITAS do SCX, nao da classe
389:     * fwbtn*; nao ha o que completar com docs\FRAMEWORK_class_codigo_fonte.txt.
390:     *
391:     * Width/Height = 75/75 (dump) ja cabem nos limites do form sem ajuste
392:     * (regra #30): Cancela.Left + Width = 425 + 75 = 500 = THIS.Width, e
393:     * Ok/Cancela.Top + Height = 3 + 75 = 78, dentro dos 80 de cnt_4c_Sombra -
394:     * nenhuma das excecoes 75x75-no-lugar-de-80x100 de outros dialogos se
395:     * aplica aqui, porque o SCX deste form ja declara 75x75 direto.
396:     *
397:     * Cancel = .T. nos DOIS botoes eh transcricao literal do dump (as duas
398:     * secoes de propriedades trazem esse valor) - nao "corrigido" para so um
399:     * dos dois, por nao ser erro de migracao e sim o que o SCX legado
400:     * declara.
401:     *
402:     * Themes = .F. (dump) e NAO a excecao Themes = .T. + DisabledPicture de
403:     * botao SOLTO icone-only (CorretorAutomatico #99): essa excecao vale so
404:     * para Caption = "" - aqui os dois tem Caption ("\<Confirmar"/"Cancelar"),
405:     * entao o texto permanece visivel mesmo se o icone nao renderizar com
406:     * Enabled = .F., e o dump nao declara Themes = .T. para nenhum dos dois.
407:     *
408:     * .Picture - cadastro_salvar_60.jpg/cadastro_sair_60.jpg, CONFERIDOS em
409:     * vbmp\ (regra #25 - nome inventado nao da erro, so fica sem icone).
410:     *
411:     * BINDEVENT do Click (Fase 7/8) - liga cada botao ao seu handler. Os dois
412:     * handlers sao PUBLIC e ja existem neste arquivo: BINDEVENT para delegate
413:     * inexistente estoura "Property ... is not found" NA HORA DO BIND (nao no
414:     * disparo do evento), dentro do TRY de InicializarForm, e a tela nao
415:     * abriria.
416:     *
417:     * Nome do handler pela ACAO, nunca pelo OBJETO legado: Ok/Cancela sao
418:     * nomes do SCX e reusa-los (BtnOkClick/BtnCancelaClick) violaria o PILAR 3
419:     * - o Caption do dump ja diz a acao ("\<Confirmar"/"Cancelar"), de onde
420:     * saem BtnConfirmarClick/BtnCancelarClick.
421:     *==========================================================================
422:     PROTECTED PROCEDURE ConfigurarBotoes()
423:         LOCAL loc_oErro
424: 
425:         TRY
426:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
427:             WITH THIS.cmd_4c_Ok
428:                 .Top        = 3
429:                 .Left       = 350
430:                 .Width      = 75
431:                 .Height     = 75
432:                 .TabIndex   = 52
433:                 .Cancel     = .T.
434:                 .Caption    = "\<Confirmar"
435:                 .FontName   = "Comic Sans MS"
436:                 .FontSize   = 8
437:                 .FontBold   = .T.
438:                 .FontItalic = .T.
439:                 .WordWrap   = .T.
440:                 .ForeColor  = RGB(90, 90, 90)
441:                 .BackColor  = RGB(255, 255, 255)
442:                 .Themes           = .T.
443:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
444:                 .Visible    = .T.
445:             ENDWITH
446: 
447:             THIS.AddObject("cmd_4c_Cancela", "CommandButton")
448:             WITH THIS.cmd_4c_Cancela
449:                 .Top        = 3
450:                 .Left       = 425
451:                 .Width      = 75
452:                 .Height     = 75
453:                 .TabIndex   = 51
454:                 .Cancel     = .T.
455:                 .Caption    = "Cancelar"
456:                 .FontName   = "Comic Sans MS"
457:                 .FontSize   = 8
458:                 .FontBold   = .T.
459:                 .FontItalic = .T.
460:                 .WordWrap   = .T.
461:                 .ForeColor  = RGB(90, 90, 90)
462:                 .BackColor  = RGB(255, 255, 255)
463:                 .Themes           = .T.
464:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
465:                 .Visible    = .T.
466:             ENDWITH
467: 
468:             *-- "PROCEDURE Click" de SIGOPPGC.Ok e de SIGOPPGC.Cancela.
469:             BINDEVENT(THIS.cmd_4c_Ok,      "Click", THIS, "BtnConfirmarClick")
470:             BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
471:         CATCH TO loc_oErro
472:             MsgErro(loc_oErro.Message + CHR(13) + ;
473:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
474:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.ConfigurarBotoes")
475:         ENDTRY
476:     ENDPROC
477: 
478:     *==========================================================================
479:     * ConfigurarGrade - a grade de 2 colunas (Barra/Valor), transcrita do
480:     * dump ("PROPRIEDADES DE: SIGOPPGC.Grade"): Top=117, Left=156, Width=188,
481:     * Height=236, ColumnCount=2, FontName="Tahoma", FontSize=8,
482:     * HeaderHeight=16, RowHeight=16, DeleteMark=.F., TabIndex=14. ZOrderSet
483:     * NAO eh transcrito (regra #33 - bookkeeping do Form Designer, sem
484:     * equivalente em runtime).
485:     *
486:     * Classe no legado: fwgrade (ClassLoc ..\framework\framework.vcx) - o que
487:     * o SCX nao sobrepoe vem da classe (docs\FRAMEWORK_class_codigo_fonte.txt,
488:     * secao "PROPRIEDADES DE: fwgrade"): AllowHeaderSizing=.F.,
489:     * AllowRowSizing=.F., ScrollBars=2, GridLineColor=238,238,238,
490:     * HighlightBackColor=90,90,90. RecordMark=.F. tambem por ser form
491:     * OPERACIONAL (regra generica do projeto).
492:     *
493:     * ColumnCount/RecordSource/ControlSource das colunas NAO ficam aqui:
494:     * ficam em VincularGrade, alcancado pelo funil CarregarDados (Problema
495:     * 48/regra #41), porque atribuir ColumnCount RECRIA os objetos Column e
496:     * porque o cursor BarBonus (GarantirCursorGrade, chamado dentro de
497:     * VincularGrade) tem de existir ANTES do ControlSource apontar para ele.
498:     * Este metodo guarda so o que NAO depende de dado - geometria, fonte,
499:     * cores e marcadores da grade - e por isso roda uma unica vez, na
500:     * montagem, enquanto o funil eh reexecutado a cada recarga.
501:     *==========================================================================
502:     PROTECTED PROCEDURE ConfigurarGrade()
503:         LOCAL loc_oErro
504: 
505:         TRY
506:             THIS.AddObject("grd_4c_Dados", "Grid")
507:             WITH THIS.grd_4c_Dados
508:                 .Top                = 117
509:                 .Left               = 156
510:                 .Width              = 188
511:                 .Height             = 236
512:                 .TabIndex           = 14
513:                 .FontName           = "Tahoma"
514:                 .FontSize           = 8
515:                 .HeaderHeight       = 16
516:                 .RowHeight          = 16
517:                 .ScrollBars         = 2
518:                 .AllowHeaderSizing  = .F.
519:                 .AllowRowSizing     = .F.
520:                 .RecordMark         = .F.
521:                 .DeleteMark         = .F.
522:                 .GridLineColor      = RGB(238, 238, 238)
523:                 .HighlightBackColor = RGB(90, 90, 90)
524:                 .Visible            = .T.
525:             ENDWITH
526:         CATCH TO loc_oErro
527:             MsgErro(loc_oErro.Message + CHR(13) + ;
528:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
529:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.ConfigurarGrade")
530:         ENDTRY
531:     ENDPROC
532: 
533:     *==========================================================================
534:     * ConfigurarMolduraFormaPagto - o bloco superior do dump, entre o
535:     * cabecalho e os botoes: a moldura decorativa (Shape1) e o rotulo da
536:     * forma de pagamento (Label1). Transcritos das secoes "PROPRIEDADES DE:
537:     * SIGOPPGC.Shape1" e "PROPRIEDADES DE: SIGOPPGC.Label1".
538:     *
539:     * Shape1 - Top=7, Left=222, Width=173, Height=110, BackStyle=0 (sem
540:     * preenchimento), BorderStyle=0 (sem traco), BorderColor=136,189,188.
541:     * Com BackStyle=0 E BorderStyle=0 a figura nao desenha nada na tela: eh
542:     * residuo de layout do SCX, mas eh transcrita como esta porque mexer em
543:     * BackStyle/BorderStyle para "fazer aparecer" seria inventar desenho que
544:     * o legado nao tem (PILAR 1). ForeColor NAO eh atribuido - Shape nao tem
545:     * essa propriedade e atribui-la derruba o Init com "Property FORECOLOR
546:     * is not found" (regra CLAUDE.md #33); a cor da figura mora em
547:     * BorderColor/FillColor.
548:     *
549:     * Label1 - Top=98, Left=156, Width=138, Height=15, Tahoma 8 bold,
550:     * BackStyle=0, ForeColor=90,90,90 (o canonico de label de dados, regra
551:     * CLAUDE.md #12 - o dump declara justamente esse valor). O dump traz
552:     * AutoSize = .T., que eh NO-OP em Label criado por AddObject: escrever
553:     * AutoSize = .F. com Width/Height EXPLICITOS do SCX eh reproducao fiel,
554:     * porque esses numeros JA SAO o auto-size que o Form Designer calculou
555:     * (regra CLAUDE.md #23). Alignment nao eh declarado no dump (classe
556:     * label pura, alinhada a esquerda) - nao inventar Alignment = 1.
557:     *
558:     * O Caption aqui eh o de projeto ("Condicao de Pagamento"); quem o
559:     * exibe de fato eh AplicarRotuloFormaPagto, que reproduz a linha do Init
560:     * legado (".label1.Caption = '[ '+AllTrim(crSigOpFp.fpags)+' ]'"). Os
561:     * dois convivem de proposito: sem o cursor do chamador (harness de
562:     * teste, validacao de UI) a tela mostra o texto do SCX em vez de um
563:     * rotulo vazio.
564:     *==========================================================================
565:     PROTECTED PROCEDURE ConfigurarMolduraFormaPagto()
566:         LOCAL loc_oErro
567: 
568:         TRY
569:             THIS.AddObject("shp_4c_Shape1", "Shape")
570:             WITH THIS.shp_4c_Shape1
571:                 .Top         = 7
572:                 .Left        = 222
573:                 .Width       = 173
574:                 .Height      = 110
575:                 .BackStyle   = 0
576:                 .BorderStyle = 0
577:                 .BorderColor = RGB(136, 189, 188)
578:                 .Visible     = .T.
579:             ENDWITH
580: 
581:             THIS.AddObject("lbl_4c_Label1", "Label")
582:             WITH THIS.lbl_4c_Label1
583:                 .AutoSize  = .F.
584:                 .Top       = 98
585:                 .Left      = 156
586:                 .Width     = 138
587:                 .Height    = 15
588:                 .FontName  = "Tahoma"
589:                 .FontSize  = 8
590:                 .FontBold  = .T.
591:                 .BackStyle = 0
592:                 .ForeColor = RGB(90, 90, 90)
593:                 .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
594:                 .Visible   = .T.
595:             ENDWITH
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message + CHR(13) + ;
598:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
599:                 "Procedure: " + loc_oErro.Procedure, ;
600:                 "Erro em FormSIGOPPGC.ConfigurarMolduraFormaPagto")
601:         ENDTRY
602:     ENDPROC
603: 
604:     *==========================================================================
605:     * ConfigurarCampoSaldo - o campo de saldo do rodape (Get_Saldo),
606:     * transcrito da secao "PROPRIEDADES DE: SIGOPPGC.Get_Saldo": Top=383,
607:     * Left=206, Width=81, Height=20, TabIndex=41, Tahoma 8 bold,
608:     * Alignment=3, BackStyle=1, BackColor=224,253,254, ForeColor=0,0,0,
609:     * Margin=0, Value=0.
610:     *
611:     * Classe no legado: fwget (ClassLoc ..\framework\framework.vcx) - o que
612:     * o SCX nao sobrepoe vem da classe (docs\FRAMEWORK_class_codigo_fonte.txt,
613:     * secao "PROPRIEDADES DE: fwget"): Format="K", Themes=.F.,
614:     * DisabledBackColor=192,192,192, DisabledForeColor=0,0,0. Height/Width
615:     * da classe (23/100) NAO entram - o SCX os sobrepoe com 20/81.
616:     *
617:     * .InputMask = "999,999.99" eh transcrito do dump: mascara muda o que eh
618:     * exibido E digitado, entao descarta-la seria perda silenciosa (regra
619:     * CLAUDE.md #49). .Value = 0 vem ANTES do InputMask para o TextBox
620:     * nascer NUMERICO - o legado declara Value = 0 e o form faz aritmetica
621:     * com ele ("ThisForm.Saldo - Selecao.Valor", "If ... Value <> 0").
622:     *
623:     * SOMENTE LEITURA: o legado tem "Get_Saldo.When / Return (.F.)", ou
624:     * seja, a caixa NUNCA recebe foco - eh mostrador, nao campo de entrada.
625:     * Sem criar subclasse so para isso, o par equivalente eh ReadOnly = .T.
626:     * (nao aceita digitacao) + TabStop = .F. (o Tab nao para nela), que
627:     * preserva as cores declaradas no dump; Enabled = .F. NAO serve, porque
628:     * trocaria o fundo 224,253,254 pelo DisabledBackColor 192,192,192 da
629:     * classe fwget e mudaria a aparencia da tela.
630:     *
631:     * .Value inicial - "ThisForm.Get_Saldo.Value = ThisForm.Saldo" do Init
632:     * legado, lido do BO (fonte unica: o Init do form guarda o parametro em
633:     * this_nSaldoRecebido e InicializarForm ja o repassou a
634:     * this_nSaldoAtual ANTES de ConfigurarPageFrame). O recalculo a cada
635:     * barra digitada ("ThisForm.Get_Saldo.Value = ThisForm.Saldo -
636:     * Selecao.Valor" no LostFocus da celula) entra na Fase 6/8, junto com
637:     * Label3, num funil unico que atualiza saldo e quantidade.
638:     *==========================================================================
639:     PROTECTED PROCEDURE ConfigurarCampoSaldo()
640:         LOCAL loc_oErro
641: 
642:         TRY
643:             THIS.AddObject("txt_4c_Saldo", "TextBox")
644:             WITH THIS.txt_4c_Saldo
645:                 .Top               = 383
646:                 .Left              = 206
647:                 .Width             = 81
648:                 .Height            = 20
649:                 .TabIndex          = 41
650:                 .FontName          = "Tahoma"
651:                 .FontSize          = 8
652:                 .FontBold          = .T.
653:                 .Alignment         = 3
654:                 .Margin            = 0
655:                 .BackStyle         = 1
656:                 .BackColor         = RGB(224, 253, 254)
657:                 .ForeColor         = RGB(0, 0, 0)
658:                 .DisabledBackColor = RGB(192, 192, 192)
659:                 .DisabledForeColor = RGB(0, 0, 0)
660:                 .Themes            = .F.
661:                 .Value             = 0
662:                 .Format            = "K"
663:                 .InputMask         = "999,999.99"
664:                 .ReadOnly          = .T.
665:                 .TabStop           = .F.
666:                 .Visible           = .T.
667:             ENDWITH
668: 
669:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
670:                 THIS.txt_4c_Saldo.Value = THIS.this_oBusinessObject.this_nSaldoAtual
671:             ENDIF
672:         CATCH TO loc_oErro
673:             MsgErro(loc_oErro.Message + CHR(13) + ;
674:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
675:                 "Procedure: " + loc_oErro.Procedure, ;
676:                 "Erro em FormSIGOPPGC.ConfigurarCampoSaldo")
677:         ENDTRY
678:     ENDPROC
679: 
680:     *==========================================================================
681:     * ConfigurarRodapeStatus - os DOIS ultimos objetos do dump, que formam o
682:     * bloco de status do rodape: Label2 ("Saldo : ", legenda de txt_4c_Saldo)
683:     * e Label3 ("[  ]", contador de barras validas). Transcritos das secoes
684:     * "PROPRIEDADES DE: SIGOPPGC.Label2" e "PROPRIEDADES DE: SIGOPPGC.Label3".
685:     *
686:     * Os dois sao Class/BaseClass = label puro (sem ClassLoc em framework.vcx),
687:     * Tahoma 8 bold, BackStyle = 0 e ForeColor = 90,90,90 - que eh justamente
688:     * o canonico de label de dados (regra CLAUDE.md #12): as duas legendas
689:     * ficam sobre o fundo CLARO do form (Picture new_background.jpg), onde
690:     * branco seria invisivel. Alignment NAO eh declarado no dump (classe
691:     * label pura, alinhada a esquerda) - nao inventar Alignment = 1 (regra
692:     * CLAUDE.md #23).
693:     *
694:     * AutoSize = .F. com Width/Height EXPLICITOS, porque AutoSize eh NO-OP em
695:     * Label criado por AddObject (regra CLAUDE.md #23).
696:     *
697:     * Label2 - Top=385, Left=158, Width=42, Height=15, TabIndex=58,
698:     * BorderStyle=0. Caption FIXO ("Saldo : ") - os 42 do dump sao o
699:     * auto-size que o Form Designer calculou para esse texto, entao fixa-los
700:     * eh reproducao fiel.
701:     *
702:     * Label3 - Top=359, Left=156, Height=15. UNICO desvio de geometria desta
703:     * fase, e deliberado: o dump declara Width = 18, que eh o auto-size do
704:     * Caption de PROJETO ("[  ]"), mas o Caption eh REESCRITO em runtime com
705:     * a contagem de barras ("'[ '+Alltrim(Str(Selecao.Qt))+' ]'" no LostFocus
706:     * legado). No legado o label CRESCE junto, porque AutoSize = .T. funciona
707:     * em label carregado de SCX; aqui ele eh criado por AddObject, onde
708:     * AutoSize eh no-op (medido na regra CLAUDE.md #23, inclusive depois de
709:     * trocar o Caption em runtime) - manter os 18 CORTARIA o numero, e o
710:     * usuario veria "[ 1" no lugar de "[ 12 ]". Width = 60 cobre o maximo que
711:     * a coluna N(10,0) de BarBonus permite contar em Tahoma 8 bold (metrica
712:     * do proprio dump: largura media 6px, "[ 9999 ]" ~ 48px) e nao alcanca
713:     * controle nenhum - a faixa 156..216 no Top 359 esta livre (a grade
714:     * termina em 117+236 = 353 e txt_4c_Saldo comeca no Top 383).
715:     *==========================================================================
716:     PROTECTED PROCEDURE ConfigurarRodapeStatus()
717:         LOCAL loc_oErro
718: 
719:         TRY
720:             THIS.AddObject("lbl_4c_Label2", "Label")
721:             WITH THIS.lbl_4c_Label2
722:                 .AutoSize    = .F.
723:                 .Top         = 385
724:                 .Left        = 158
725:                 .Width       = 42
726:                 .Height      = 15
727:                 .TabIndex    = 58
728:                 .FontName    = "Tahoma"
729:                 .FontSize    = 8
730:                 .FontBold    = .T.
731:                 .BackStyle   = 0
732:                 .BorderStyle = 0
733:                 .ForeColor   = RGB(90, 90, 90)
734:                 .Caption     = "Saldo : "
735:                 .Visible     = .T.
736:             ENDWITH
737: 
738:             THIS.AddObject("lbl_4c_Label3", "Label")
739:             WITH THIS.lbl_4c_Label3
740:                 .AutoSize  = .F.
741:                 .Top       = 359
742:                 .Left      = 156
743:                 .Width     = 60
744:                 .Height    = 15
745:                 .FontName  = "Tahoma"
746:                 .FontSize  = 8
747:                 .FontBold  = .T.
748:                 .BackStyle = 0
749:                 .ForeColor = RGB(90, 90, 90)
750:                 .Caption   = "[  ]"
751:                 .Visible   = .T.
752:             ENDWITH
753:         CATCH TO loc_oErro
754:             MsgErro(loc_oErro.Message + CHR(13) + ;
755:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
756:                 "Procedure: " + loc_oErro.Procedure, ;
757:                 "Erro em FormSIGOPPGC.ConfigurarRodapeStatus")
758:         ENDTRY
759:     ENDPROC
760: 
761:     *==========================================================================
762:     * AplicarRotuloFormaPagto - reproduz o bloco do Init legado que troca o
763:     * texto de Label1 pela descricao da forma de pagamento corrente:
764:     *
765:     *     With Thisform
766:     *         .label1.Caption = '[ '+AllTrim(crSigOpFp.fpags)+' ]'
767:     *     EndWith
768:     *
769:     * Carrega do cursor crSigOpFp (do form PAI, visivel aqui porque o Init
770:     * fez SET DATASESSION TO a sessao dele) as DUAS colunas que o dialogo
771:     * usa: fpags, que vira este rotulo, e VlrFpgs, o valor de cada barra que
772:     * o Valid da celula grava em BarBonus.Valors ("Replace Valors With
773:     * CrSigOpFp.VlrFpgs"). Quem le eh o BO (CarregarDoCursor), e as duas
774:     * ficam em this_cDescFormaPagto/this_nValorPorBarra - fonte unica, ja
775:     * consumida por SIGOPPGCBO.ValidarBarraEAtualizarCursor.
776:     *
777:     * Sem o cursor do chamador (harness de teste, validacao de UI) NAO eh
778:     * erro: o rotulo continua com o Caption do SCX e o metodo devolve .F.
779:     * sem exibir nada - mesma guarda por USED() de VincularGrade/
780:     * CarregarDados.
781:     *
782:     * CarregarDoCursor faz SELECT no alias que recebe, entao a area de
783:     * trabalho corrente eh salva e restaurada aqui: quem chama depois
784:     * (CarregarDados) conta com o alias da grade posicionado por ele mesmo,
785:     * e deixar a area trocada eh fonte classica de leitura na tabela errada.
786:     *
787:     * RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
788:     *==========================================================================
789:     PROTECTED FUNCTION AplicarRotuloFormaPagto()
790:         LOCAL loc_lSucesso, loc_cAliasAnterior, loc_oErro
791:         loc_lSucesso = .F.
792: 
793:         TRY
794:             loc_cAliasAnterior = ALIAS()
795: 
796:             IF USED(THIS.this_cCursorFormaPagto) AND ;

*-- Linhas 809 a 953:
809:         CATCH TO loc_oErro
810:             MsgErro(loc_oErro.Message + CHR(13) + ;
811:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
812:                 "Procedure: " + loc_oErro.Procedure, ;
813:                 "Erro em FormSIGOPPGC.AplicarRotuloFormaPagto")
814:         ENDTRY
815: 
816:         RETURN loc_lSucesso
817:     ENDFUNC
818: 
819:     *==========================================================================
820:     * GarantirCursorGrade - garante que o cursor LOCAL BarBonus existe antes
821:     * de qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41
822:     * - sem isto a tela NAO ABRE: Alias nao encontrado dentro do TRY de
823:     * InicializarForm, que devolve .F., e o usuario clica no menu/form pai e
824:     * nada acontece).
825:     *
826:     * Estrutura: Codigos N(10,0) - This.Value do legado eh comparado/somado
827:     * como numerico ("If This.Value > 0", "Where Codigos = This.Value",
828:     * "Insert Into BarBonus(Codigos) Values(0)"), e o Column1.InputMask do
829:     * dump ("9999999999", 10 noves) confirma largura 10 sem decimais;
830:     * Valors N(14,2) - recebe CrSigOpFp.VlrFpgs (valor monetario por barra),
831:     * mesmo padrao de coluna de valor do projeto.
832:     *
833:     * So CREATE CURSOR (sem Zap/Append Blank): o "Select BarBonus / Zap /
834:     * Append Blank" do Init legado eh orquestracao de ABERTURA de tela (um
835:     * registro em branco pronto para o usuario digitar a 1a barra) e mora em
836:     * PrepararLinhaInicial - aqui so garante que o ALIAS existe, vazio, para
837:     * a grade ter onde ligar.
838:     *
839:     * Os dois andam em sequencia (PrepararLinhaInicial chama este primeiro) e
840:     * este eh idempotente: com o alias ja aberto pelo chamador nao faz nada,
841:     * preservando a estrutura de 3 colunas que o SIGOPPAG cria. Sem chamador
842:     * (harness de teste, validacao de UI) eh ele que abre o cursor de 2
843:     * colunas que esta tela usa.
844:     *==========================================================================
845:     PROTECTED PROCEDURE GarantirCursorGrade()
846:         LOCAL loc_oErro
847: 
848:         TRY
849:             IF !USED(THIS.this_cCursorGrade)
850:                 CREATE CURSOR BarBonus (Codigos N(10, 0), Valors N(14, 2))
851:             ENDIF
852:         CATCH TO loc_oErro
853:             MsgErro(loc_oErro.Message + CHR(13) + ;
854:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
855:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.GarantirCursorGrade")
856:         ENDTRY
857:     ENDPROC
858: 
859:     *==========================================================================
860:     * VincularGrade - liga grd_4c_Dados ao cursor BarBonus e configura as 2
861:     * colunas. NAO eh chamado direto: quem o alcanca eh o funil
862:     * CarregarDados, tanto na montagem quanto em cada recarga das fases
863:     * seguintes (mesmo funil unico de Formsigoppei.prg, Problema 48).
864:     *
865:     * ORDEM obrigatoria: ColumnCount -> RecordSource -> ControlSource -> o
866:     * resto (Width/InputMask/Header1.Caption por ultimo dentro do bloco da
867:     * coluna, pois RecordSource/ControlSource recalculam largura e caption
868:     * para o default). Grid.ReadOnly vem ANTES das colunas (regra #18 - o do
869:     * grid propaga e sobrescreveria).
870:     *
871:     * RecordSource e ControlSource sao condicionados a USED(alias): quando a
872:     * tela eh instanciada SEM chamador (harness de teste, validacao de UI) e
873:     * GarantirCursorGrade nao conseguiu abrir o cursor, o bind eh pulado em
874:     * vez de estourar "Alias is not found" dentro do TRY de InicializarForm -
875:     * que devolveria .F. e faria a tela nao abrir (regra #41). Largura,
876:     * fonte, mascara e caption de cabecalho sao aplicados SEMPRE, inclusive
877:     * nesse caminho, senao a grade ficaria com "Column1"/largura default.
878:     *
879:     * Column1 "Barra" <- BarBonus.Codigos: editavel (eh a celula que o
880:     * usuario digita - Grade.Column1.Text1.When/Valid/LostFocus do legado).
881:     * Width=80 e InputMask="9999999999" transcritos do dump
882:     * (Column1.Width/Column1.InputMask).
883:     *
884:     * Column2 "Valor" <- BarBonus.Valors: o dump NAO declara ReadOnly aqui -
885:     * quem bloqueia a digitacao eh "Grade.Column2.Text1.When / Return .f."
886:     * (a celula nunca recebe foco; o valor so eh gravado por codigo, no
887:     * "Replace Valors With CrSigOpFp.VlrFpgs" do Valid de Column1). Eh esse
888:     * o mecanismo reproduzido, na subclasse de celula - e nao um ReadOnly
889:     * inventado, que daria o mesmo efeito por outra via e esconderia o When
890:     * do legado. Column2.Width NAO eh transcrito: o dump nao declara essa
891:     * propriedade (so Column1.Width aparece), e o default pos-RecordSource
892:     * (~90px) cabe nos 188-80=108px restantes da grade - nao inventar um
893:     * numero que o SCX nao declarou.
894:     *
895:     * As propriedades visuais que o dump declara em ColumnN.Text1
896:     * (BorderStyle/Margin/ForeColor/BackColor) NAO sao aplicadas no Text1
897:     * nativo: com CurrentControl apontando para a subclasse, eh ELA que
898:     * desenha a celula e o Text1 deixa de aparecer (regra CLAUDE.md #18).
899:     * Por isso vao em InstalarCelulasGrade, no objeto que de fato pinta -
900:     * configurar o Text1 aqui seria config MORTA. InstalarCelulasGrade eh
901:     * chamado no FIM deste metodo porque atribuir RecordSource DERRUBA o
902:     * CurrentControl das colunas.
903:     *
904:     * ControlSource vai para BarBonus.Codigos/BarBonus.Valors - o
905:     * "Column1.Text1.ControlSource = tmpoperacao.CODIGOS" do dump eh residuo
906:     * de template (mesma familia de "antvalue"/"gravadados", ver cabecalho da
907:     * classe) e eh SOBRESCRITO em runtime pelo Init legado ("With
908:     * Thisform.Grade / .Column1.ControlSource = 'BarBonus.Codigos' /
909:     * .Column2.ControlSource = 'BarBonus.Valors'") - essa eh a ligacao real,
910:     * transcrita aqui direto (nao ha motivo para esperar a Fase 7 so para
911:     * trocar o residuo pelo valor que o proprio legado atribui).
912:     *==========================================================================
913:     PROTECTED PROCEDURE VincularGrade()
914:         LOCAL loc_oGrid, loc_oErro
915: 
916:         TRY
917:             THIS.GarantirCursorGrade()
918: 
919:             loc_oGrid = THIS.grd_4c_Dados
920: 
921:             WITH loc_oGrid
922:                 .ReadOnly    = .F.
923:                 .ColumnCount = 2
924: 
925:                 IF USED(THIS.this_cCursorGrade)
926:                     .RecordSource = THIS.this_cCursorGrade
927:                 ENDIF
928: 
929:                 WITH .Column1
930:                     IF USED(THIS.this_cCursorGrade)
931:                         .ControlSource = "BarBonus.Codigos"
932:                     ENDIF
933:                     .FontName      = "Tahoma"
934:                     .FontSize      = 8
935:                     .Movable       = .F.
936:                     .Resizable     = .F.
937:                     .InputMask     = "9999999999"
938:                     .Width         = 80
939:                     WITH .Header1
940:                         .FontName  = "Tahoma"
941:                         .FontSize  = 8
942:                         .Alignment = 2
943:                         .Caption   = "Barra"
944:                     ENDWITH
945:                 ENDWITH
946: 
947:                 WITH .Column2
948:                     IF USED(THIS.this_cCursorGrade)
949:                         .ControlSource = "BarBonus.Valors"
950:                     ENDIF
951:                     .FontName      = "Tahoma"
952:                     .FontSize      = 8
953:                     WITH .Header1

*-- Linhas 967 a 1149:
967:         CATCH TO loc_oErro
968:             MsgErro(loc_oErro.Message + CHR(13) + ;
969:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
970:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.VincularGrade")
971:         ENDTRY
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * InstalarCelulasGrade - poe em Column1/Column2 da grade a SUBCLASSE de
976:     * TextBox que carrega o When/Valid daquela celula no legado, e liga cada
977:     * uma por CurrentControl.
978:     *
979:     * ESTE eh o "lookup" desta tela, e ele NAO eh um picker: o legado NAO tem
980:     * lookup nenhum - zero fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna,
981:     * zero sigacess/Acesso* (conferido no dump inteiro). O codigo de barra eh
982:     * DIGITADO e conferido contra SigCdOpe pelo Valid da celula; nao existe
983:     * tabela de apoio para escolher em grade. Criar um AbrirBusca*/
984:     * AbrirLookup* aqui inventaria uma consulta que o legado nunca faz - viola
985:     * o PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup que nao
986:     * existem no original".
987:     *
988:     * POR QUE SUBCLASSE E NAO BINDEVENT no When/Valid (regra CLAUDE.md #46):
989:     * BINDEVENT em "Valid" de TextBox de Column nao eh confiavel e, pior,
990:     * BINDEVENT DESCARTA o retorno do delegate - e aqui o retorno E' o
991:     * mecanismo: o Valid devolvendo .F. eh o que mantem o cursor na celula
992:     * depois de recusar a barra ("This.Value = 0 / Return .f." do legado), e
993:     * o When devolvendo .F. eh o que impede a entrada na celula de Valor
994:     * ("Grade.Column2.Text1.When / Return .f."). Nenhum dos dois efeitos
995:     * sobrevive a um BINDEVENT. AfterRowColChange tambem nao serve: dispara
996:     * DEPOIS de entrar na celula nova e o indice que recebe eh o da coluna de
997:     * DESTINO, nao o da coluna que o usuario acabou de deixar.
998:     *
999:     * O LostFocus, ao contrario, vai por BINDEVENT: ele nao tem retorno com
1000:     * significado (o corpo legado eh puro efeito colateral - recalcula saldo
1001:     * e contador, repinta e avisa), entao nada se perde, e o recalculo tem de
1002:     * ficar num metodo PUBLIC do form porque ele eh o MESMO funil que o
1003:     * legado chama de outros pontos ("ThisForm.label3"/"ThisForm.Get_Saldo"
1004:     * sao do form, nao da celula). Mesmo padrao de BINDEVENT em controle de
1005:     * Column ja usado no projeto para eventos que nao sao Valid/When
1006:     * (Click/MouseUp/KeyPress de CheckBox de coluna).
1007:     *
1008:     * Column.AddObject NAO basta para o controle aparecer (regra CLAUDE.md
1009:     * #18): sem CurrentControl a coluna continua desenhando o Text1 dela - o
1010:     * objeto existe, responde a PEMSTATUS, e o When/Valid NUNCA roda.
1011:     *
1012:     * Sparse fica no default (.T.), como no dump (que nao declara Sparse em
1013:     * coluna nenhuma): as duas subclasses sao TextBox e desenham igual ao
1014:     * Text1 que substituem, e o When/Valid de uma Column roda na celula
1015:     * ATIVA, que eh justamente o que Sparse = .T. instancia. Forcar
1016:     * Sparse = .F. instanciaria um controle por linha visivel sem mudar nada
1017:     * do que se ve (so em CheckBox/OptionGroup o .F. eh obrigatorio).
1018:     *
1019:     * IDEMPOTENTE de proposito: VincularGrade chama este metodo apos CADA
1020:     * rebind (RecordSource derruba CurrentControl) e AddObject duas vezes com
1021:     * o mesmo nome no mesmo alvo estoura "Object is already defined",
1022:     * derrubando o Init. O BINDEVENT fica DENTRO do guard de criacao: re-bind
1023:     * do mesmo par objeto/evento ACUMULA bindings e o handler passaria a
1024:     * rodar duas vezes por LostFocus (contador e saldo recalculados em
1025:     * duplicidade).
1026:     *==========================================================================
1027:     PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
1028:         LOCAL loc_oErro
1029: 
1030:         IF VARTYPE(par_oGrade) != "O"
1031:             RETURN
1032:         ENDIF
1033: 
1034:         TRY
1035:             *-- Column1: a celula do codigo de barra (Grade.Column1.Text1 do
1036:             *-- legado). Propriedades visuais transcritas da secao
1037:             *-- "PROPRIEDADES DE: SIGOPPGC.Grade.Column1.Text1".
1038:             IF !PEMSTATUS(par_oGrade.Column1, "txt_4c_CelBarra", 5)
1039:                 par_oGrade.Column1.AddObject("txt_4c_CelBarra", ;
1040:                                               "TextBoxCelBarraSigOpPgc_4c")
1041: 
1042:                 *-- LostFocus do legado: recalcula saldo/contador. Ligado AQUI
1043:                 *-- (dentro do guard de criacao) para nao acumular bindings.
1044:                 BINDEVENT(par_oGrade.Column1.txt_4c_CelBarra, "LostFocus", ;
1045:                           THIS, "AtualizarSaldoEQuantidade")
1046:             ENDIF
1047:             WITH par_oGrade.Column1.txt_4c_CelBarra
1048:                 .FontName    = "Tahoma"
1049:                 .FontSize    = 8
1050:                 .BorderStyle = 0
1051:                 .Margin      = 0
1052:                 .ForeColor   = RGB(0, 0, 0)
1053:                 .BackColor   = RGB(255, 255, 255)
1054:                 .Visible     = .T.
1055:             ENDWITH
1056:             par_oGrade.Column1.CurrentControl = "txt_4c_CelBarra"
1057: 
1058:             *-- Column2: a celula do valor (Grade.Column2.Text1 do legado),
1059:             *-- cujo When devolve .F. - o usuario nunca entra nela. O valor
1060:             *-- eh gravado por codigo, no Replace do Valid de Column1.
1061:             IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelValor", 5)
1062:                 par_oGrade.Column2.AddObject("txt_4c_CelValor", ;
1063:                                               "TextBoxCelValorSigOpPgc_4c")
1064:             ENDIF
1065:             WITH par_oGrade.Column2.txt_4c_CelValor
1066:                 .FontName    = "Tahoma"
1067:                 .FontSize    = 8
1068:                 .BorderStyle = 0
1069:                 .Margin      = 0
1070:                 .ForeColor   = RGB(0, 0, 0)
1071:                 .BackColor   = RGB(255, 255, 255)
1072:                 .Visible     = .T.
1073:             ENDWITH
1074:             par_oGrade.Column2.CurrentControl = "txt_4c_CelValor"
1075:         CATCH TO loc_oErro
1076:             MsgErro(loc_oErro.Message + CHR(13) + ;
1077:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1078:                 "Procedure: " + loc_oErro.Procedure, ;
1079:                 "Erro em FormSIGOPPGC.InstalarCelulasGrade")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * PrepararCelulaBarra - transcreve "Grade.Column1.Text1.When" do legado:
1085:     *
1086:     *     Public _OldCodigo
1087:     *     Set Confirm On
1088:     *     _OldCodigo = This.Value
1089:     *     Return(.t.)
1090:     *
1091:     * SET CONFIRM ON eh par com o SET CONFIRM OFF do LostFocus (ver
1092:     * AtualizarSaldoEQuantidade): ligado ENQUANTO o usuario esta na celula, a
1093:     * digitacao do 10o digito da mascara nao salta sozinha para a proxima
1094:     * celula - o Enter continua obrigatorio, que eh o que o fluxo de leitura
1095:     * de codigo de barra pressupoe (o leitor emite Enter no fim). Transcrito
1096:     * literalmente, inclusive a ordem (SET antes de guardar o valor).
1097:     *
1098:     * O valor anterior vai para this_nCodigoBarraAnterior (equivalente de
1099:     * _OldCodigo - ver o comentario da property): eh ele que ValidarBarraDigitada
1100:     * usa para decidir entre Inserir() e Atualizar() no BO.
1101:     *
1102:     * Devolve SEMPRE .T., como o legado: a celula do codigo eh a UNICA
1103:     * digitavel da tela e nunca se recusa a entrada nela.
1104:     *
1105:     * PUBLIC: chamado de FORA da classe, pelo When da subclasse de celula
1106:     * (TextBoxCelBarraSigOpPgc_4c) - com PROTECTED estouraria "Property
1107:     * PREPARARCELULABARRA is not found" em runtime (regra CLAUDE.md #51).
1108:     *==========================================================================
1109:     PROCEDURE PrepararCelulaBarra(par_oTxt)
1110:         SET CONFIRM ON
1111: 
1112:         THIS.this_nCodigoBarraAnterior = 0
1113: 
1114:         IF VARTYPE(par_oTxt) = "O"
1115:             IF VARTYPE(par_oTxt.Value) = "N"
1116:                 THIS.this_nCodigoBarraAnterior = par_oTxt.Value
1117:             ELSE
1118:                 THIS.this_nCodigoBarraAnterior = TRANSFORM(par_oTxt.Value)
1119:             ENDIF
1120:         ENDIF
1121: 
1122:         RETURN .T.
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * ValidarBarraDigitada - transcreve "Grade.Column1.Text1.Valid" do legado.
1127:     * Trecho legado, na ordem:
1128:     *
1129:     *     If This.Value > 0
1130:     *         Set Decimals to 0
1131:     *         nDope = Val( Left( Str( This.Value, 10 ), 4 ) )
1132:     *         Nume  = Val( Right( Str( This.Value, 10 ), 6 ) )
1133:     *         lcSql = [Select Dopes From SigCdOpe Where ndopes = ]+Str(nDope)
1134:     *         ThisForm.PodataMgr.Sqlexecute(lcSql,'LocalSnOpe')
1135:     *         If Used('LocalSnOpe') And Reccount('LocalSnOpe') = 0
1136:     *             MessageBox('Barra Invalido!!!!',0+16,'') / This.Value = 0 / Return .f.
1137:     *         EndIf
1138:     *         Select BarBonus / Skip / Skip -1
1139:     *         Select Sum(1) as Qt, Codigos From BarBonus Where Codigos = This.Value ...
1140:     *         If CheckDup.Qt > 1
1141:     *             MessageBox('Barra ja digitado !!!',0+48,'') / This.Value = 0 / Return .F.
1142:     *         Endif
1143:     *         Replace Valors With CrSigOpFp.VlrFpgs in BarBonus
1144:     *         Select BarBonus / Skip
1145:     *         If Eof()
1146:     *             Insert Into BarBonus( Codigos ) Values ( 0 ) / KeyBoard "{DNARROW}"
1147:     *         EndIf
1148:     *     Endif
1149:     *     Return .t.

*-- Linhas 1186 a 1229:
1186:     *
1187:     * PUBLIC: chamado de FORA da classe, pelo Valid da subclasse de celula.
1188:     *==========================================================================
1189:     PROCEDURE ValidarBarraDigitada(par_oTxt)
1190:         LOCAL loc_lValido, loc_nValor, loc_nRecnoAtual, loc_lGravou, loc_oErro
1191:         loc_lValido = .T.
1192: 
1193:         TRY
1194:             *-- Funil unico tela -> BO: le o valor DIGITADO na celula (nunca
1195:             *-- o cursor - regra CLAUDE.md #46), converte para os 10 digitos
1196:             *-- que o legado fatia em nDope/Nume e ja decide, em
1197:             *-- this_lNovoRegistro, se eh linha nova ou correcao.
1198:             loc_nValor = 0
1199:             IF THIS.FormParaBO(par_oTxt)
1200:                 loc_nValor = VAL(THIS.this_oBusinessObject.this_cCodigoBarra)
1201:             ENDIF
1202: 
1203:             IF loc_nValor > 0 AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
1204:                AND USED(THIS.this_cCursorGrade)
1205: 
1206:                 *-- "Select BarBonus / Skip / Skip -1" - descarrega para o
1207:                 *-- cursor a edicao que ainda esta no buffer da celula.
1208:                 SELECT (THIS.this_cCursorGrade)
1209:                 IF RECCOUNT() > 0 AND !EOF()
1210:                     SKIP
1211:                     SKIP -1
1212:                 ENDIF
1213:                 loc_nRecnoAtual = RECNO()
1214: 
1215:                 *-- Inserir x Atualizar: FormParaBO ja resolveu em
1216:                 *-- this_lNovoRegistro, a partir do _OldCodigo que o When da
1217:                 *-- celula capturou. As duas rodam a MESMA validacao no BO -
1218:                 *-- o que muda eh so o rotulo gravado em LogAuditoria.
1219:                 IF THIS.this_oBusinessObject.this_lNovoRegistro
1220:                     loc_lGravou = THIS.this_oBusinessObject.Inserir()
1221:                 ELSE
1222:                     loc_lGravou = THIS.this_oBusinessObject.Atualizar()
1223:                 ENDIF
1224: 
1225:                 *-- Repoe a area/ponteiro que o SELECT-SQL do BO pode ter
1226:                 *-- trocado ("Select BarBonus" do legado apos o Replace).
1227:                 IF USED(THIS.this_cCursorGrade)
1228:                     SELECT (THIS.this_cCursorGrade)
1229:                     IF loc_nRecnoAtual >= 1 AND loc_nRecnoAtual <= RECCOUNT()

*-- Linhas 1266 a 1943:
1266:         CATCH TO loc_oErro
1267:             MsgErro(loc_oErro.Message + CHR(13) + ;
1268:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1269:                 "Procedure: " + loc_oErro.Procedure, ;
1270:                 "Erro em FormSIGOPPGC.ValidarBarraDigitada")
1271:             loc_lValido = .F.
1272:         ENDTRY
1273: 
1274:         RETURN loc_lValido
1275:     ENDPROC
1276: 
1277:     *==========================================================================
1278:     * AtualizarSaldoEQuantidade - FUNIL unico de status do rodape. Transcreve
1279:     * "Grade.Column1.Text1.LostFocus" do legado:
1280:     *
1281:     *     Set Confirm Off
1282:     *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
1283:     *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
1284:     *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
1285:     *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
1286:     *     ThisForm.label3.Refresh
1287:     *     ThisForm.Get_Saldo.Refresh
1288:     *     If ThisForm.Get_Saldo.Value < 0
1289:     *         MessageBox('Quantidade de Barras excedida!!!',0+16,'Valor a Maior')
1290:     *     Endif
1291:     *     If This.Value = 0 And Lastkey() = 13
1292:     *         ThisForm.Ok.SetFocus
1293:     *     EndIf
1294:     *
1295:     * A CONTA eh regra de negocio e tem FONTE UNICA no BO
1296:     * (SIGOPPGCBO.RecalcularSaldoEQuantidade, que soma BarBonus e grava
1297:     * this_nQtdeBarras/this_nSaldoAtual) - regra CLAUDE.md #17. Este metodo
1298:     * so ESPELHA o resultado nos dois controles. O criterio do legado vai
1299:     * junto e eh parte da regra: "Where Codigos <> 0" EXCLUI a linha em
1300:     * branco que o Valid acabou de abrir, senao ela entraria na contagem.
1301:     *
1302:     * SET CONFIRM OFF eh o par do SET CONFIRM ON do When
1303:     * (PrepararCelulaBarra): fora da celula de barra a tela volta ao
1304:     * comportamento normal de tabulacao. Transcrito na mesma posicao
1305:     * (primeira linha).
1306:     *
1307:     * O aviso de saldo negativo eh MsgAviso, nao MsgErro: eh validacao de
1308:     * tela ("Quantidade de Barras excedida"), nao falha tecnica - o usuario
1309:     * continua na tela e corrige. O titulo eh o do legado ("Valor a Maior").
1310:     * O aviso NAO bloqueia: o legado so informa, e eh o Click do Confirmar
1311:     * que recusa o fechamento com saldo diferente de zero
1312:     * (BtnConfirmarClick).
1313:     *
1314:     * O salto para o Confirmar ("This.Value = 0 And Lastkey() = 13") precisa
1315:     * do valor da celula, e LostFocus nao passa parametro nenhum - a celula eh
1316:     * resolvida pelo caminho conhecido na grade, com guarda de PEMSTATUS
1317:     * (regras CLAUDE.md #3 e #34: nunca Controls(<nome>), e PEMSTATUS so
1318:     * prova existencia). Com isso o metodo tambem serve como funil chamado
1319:     * sem argumento pelos outros pontos que mexem em BarBonus.
1320:     *
1321:     * PUBLIC: eh o delegate de um BINDEVENT ("LostFocus" da celula) e tambem
1322:     * eh chamado de fora pelos pontos acima - PROTECTED falharia em silencio
1323:     * no bind e em runtime na chamada (regras CLAUDE.md #3 e #51).
1324:     *==========================================================================
1325:     PROCEDURE AtualizarSaldoEQuantidade()
1326:         LOCAL loc_oCelula, loc_nValorCelula, loc_oErro
1327: 
1328:         SET CONFIRM OFF
1329: 
1330:         TRY
1331:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1332:                 THIS.this_oBusinessObject.RecalcularSaldoEQuantidade(THIS.this_cCursorGrade)
1333: 
1334:                 *-- "ThisForm.label3.Caption = ... / ThisForm.Get_Saldo.Value
1335:                 *-- = ... / ThisForm.label3.Refresh / ThisForm.Get_Saldo.
1336:                 *-- Refresh": espelho tela <- BO, pelo funil unico.
1337:                 THIS.BOParaForm()
1338: 
1339:                 *-- "If ThisForm.Get_Saldo.Value < 0 / MessageBox(
1340:                 *-- 'Quantidade de Barras excedida!!!',0+16,'Valor a Maior')"
1341:                 *-- - aviso INFORMATIVO, que NAO bloqueia: quem recusa o
1342:                 *-- fechamento com saldo diferente de zero eh o Confirmar
1343:                 *-- (BtnConfirmarClick). Fica aqui, e nao em BOParaForm,
1344:                 *-- porque eh fluxo e nao espelho. Le o CONTROLE, como o
1345:                 *-- legado - BOParaForm acabou de pinta-lo a partir do BO,
1346:                 *-- que eh a fonte unica da conta.
1347:                 IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
1348:                     IF THIS.txt_4c_Saldo.Value < 0
1349:                         MsgAviso("Quantidade de Barras excedida!!!", ;
1350:                             "Valor a Maior")
1351:                     ENDIF
1352:                 ENDIF
1353:             ENDIF
1354: 
1355:             *-- "If This.Value = 0 And Lastkey() = 13 / ThisForm.Ok.SetFocus":
1356:             *-- Enter numa celula vazia encerra a leitura e salta para o
1357:             *-- Confirmar.
1358:             IF LASTKEY() = 13 AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1359:                 loc_nValorCelula = -1
1360:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelBarra", 5)
1361:                     loc_oCelula = THIS.grd_4c_Dados.Column1.txt_4c_CelBarra
1362:                     IF VARTYPE(loc_oCelula.Value) = "N"
1363:                         loc_nValorCelula = loc_oCelula.Value
1364:                     ELSE
1365:                         loc_nValorCelula = VAL(TRANSFORM(loc_oCelula.Value))
1366:                     ENDIF
1367:                 ENDIF
1368: 
1369:                 IF loc_nValorCelula = 0 AND PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1370:                     IF THIS.cmd_4c_Ok.Enabled AND THIS.cmd_4c_Ok.Visible
1371:                         THIS.cmd_4c_Ok.SetFocus()
1372:                     ENDIF
1373:                 ENDIF
1374:             ENDIF
1375:         CATCH TO loc_oErro
1376:             MsgErro(loc_oErro.Message + CHR(13) + ;
1377:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1378:                 "Procedure: " + loc_oErro.Procedure, ;
1379:                 "Erro em FormSIGOPPGC.AtualizarSaldoEQuantidade")
1380:         ENDTRY
1381:     ENDPROC
1382: 
1383:     *==========================================================================
1384:     * CarregarDados - FUNIL de carga da grade. Transcreve o bloco que fecha o
1385:     * Init legado:
1386:     *
1387:     *     With Thisform.Grade
1388:     *         .RecordSource          = 'BarBonus'
1389:     *         .Column1.ControlSource = 'BarBonus.Codigos'
1390:     *         .Column2.ControlSource = 'BarBonus.Valors'
1391:     *         .Refresh
1392:     *     EndWith
1393:     *     THisForm.Grade.Refresh
1394:     *
1395:     * Tres passos, nesta ordem: vincular (VincularGrade), posicionar o alias
1396:     * (SELECT + GO TOP) e repintar (Grid.Refresh). O ultimo passo eh o que o
1397:     * migrador costuma jogar fora: encher ou reordenar o cursor NAO repinta a
1398:     * grade ligada a ele (regra CLAUDE.md #21) - sem o Refresh a grade fica
1399:     * visualmente vazia com o cursor cheio, sem erro e sem log, e o sintoma
1400:     * ("a tela nao traz os barras") manda o diagnostico para o SQL.
1401:     *
1402:     * Tem de ser o UNICO caminho de carga: cada ponto das fases seguintes que
1403:     * mexer em BarBonus (o "Insert Into BarBonus(Codigos) Values(0)" do Valid
1404:     * da celula, o "Zap" do Cancela.Click) fecha chamando este metodo, nunca
1405:     * VincularGrade nua - re-atribuir RecordSource reseta Column.Width e
1406:     * Header1.Caption (Problema 48/regra #41) e o funil ja os repoe.
1407:     *
1408:     * PUBLIC de proposito: o harness (TesteAutomatico.prg) procura
1409:     * MontaGrade/CarregarDados/CarregarLista/... com PEMSTATUS(...,5) e chama
1410:     * THIS.oForm.<metodo>() de FORA da classe. PEMSTATUS com atributo 5 so
1411:     * testa EXISTENCIA, nao escopo: com PROTECTED o harness entraria no
1412:     * branch e estouraria "Property CARREGARDADOS is not found" em runtime
1413:     * (regra CLAUDE.md #3).
1414:     *
1415:     * Devolve .F. quando nao ha alias para carregar (tela instanciada sem o
1416:     * form chamador) - mas NAO lanca excecao, porque o harness chama o metodo
1417:     * sem argumento e sem cursor. O RETURN fica FORA do TRY/CATCH, por flag
1418:     * (regra CLAUDE.md #1).
1419:     *==========================================================================
1420:     PROCEDURE CarregarDados()
1421:         LOCAL loc_lSucesso, loc_oErro
1422:         loc_lSucesso = .F.
1423: 
1424:         TRY
1425:             THIS.VincularGrade()
1426: 
1427:             IF USED(THIS.this_cCursorGrade)
1428:                 SELECT (THIS.this_cCursorGrade)
1429:                 GO TOP
1430:                 loc_lSucesso = .T.
1431:             ENDIF
1432: 
1433:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1434:                 THIS.grd_4c_Dados.Refresh()
1435:             ENDIF
1436:         CATCH TO loc_oErro
1437:             MsgErro(loc_oErro.Message + CHR(13) + ;
1438:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1439:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.CarregarDados")
1440:         ENDTRY
1441: 
1442:         RETURN loc_lSucesso
1443:     ENDPROC
1444: 
1445:     *==========================================================================
1446:     * PrepararLinhaInicial - transcreve o bloco do Init legado que deixa o
1447:     * cursor da grade pronto para a leitura das barras:
1448:     *
1449:     *     Select BarBonus
1450:     *     Zap
1451:     *     Append Blank
1452:     *
1453:     * APPEND BLANK eh o que torna a tela USAVEL: sem ele a grade abre com
1454:     * ZERO linha e o usuario nao tem onde digitar a primeira barra - o
1455:     * "Insert Into BarBonus(Codigos) Values(0)" do Valid da celula so abre a
1456:     * linha SEGUINTE, e depende de uma barra ja aceita.
1457:     *
1458:     * ZAP, e NAO "USE IN + CREATE CURSOR": o cursor eh do CHAMADOR - o
1459:     * SIGOPPAG faz "Create Cursor BarBonus (Codigos n(10), Valors n(12,2),
1460:     * Seqs n(3))" ANTES de abrir este dialogo e le o resultado nele depois
1461:     * ("If Reccount('BarBonus') > 0 / Select BarBonus / Scan ..."). ZAP
1462:     * esvazia PRESERVANDO a estrutura - inclusive a coluna Seqs, que esta
1463:     * tela nao usa - e o binding da grade; fechar e recriar o alias
1464:     * derrubaria Grid.RecordSource/Column.ControlSource e a grade ficaria
1465:     * permanentemente vazia com o cursor cheio, sem erro e sem log.
1466:     *
1467:     * SAFETY: este form declara DataSession = 2 e SET SAFETY eh escopado por
1468:     * data session - dentro da sessao privada ele vale ON mesmo com o SET
1469:     * SAFETY OFF do main.prg, e ai o ZAP abre o dialogo modal "Zap ... Are
1470:     * you sure?" e CONGELA a tela esperando um clique que ninguem ve (em
1471:     * teste headless aparece como timeout, nao como erro). Por isso o ZAP vai
1472:     * entre salvar e restaurar o SET("SAFETY").
1473:     *
1474:     * GarantirCursorGrade vem primeiro: quando a tela eh instanciada SEM
1475:     * chamador (harness de teste, validacao de UI) o alias nao existe, e
1476:     * SELECT em alias ausente estouraria dentro do TRY de InicializarForm -
1477:     * que devolveria .F. e faria a tela nao abrir (regra CLAUDE.md #41).
1478:     *
1479:     * Deixa BarBonus como area de trabalho corrente, como o legado: quem roda
1480:     * em seguida eh CarregarDados, que reposiciona o alias da grade ele mesmo
1481:     * (SELECT + GO TOP).
1482:     *==========================================================================
1483:     PROTECTED PROCEDURE PrepararLinhaInicial()
1484:         LOCAL loc_cSafetyAnterior, loc_oErro
1485: 
1486:         TRY
1487:             THIS.GarantirCursorGrade()
1488: 
1489:             IF USED(THIS.this_cCursorGrade)
1490:                 SELECT (THIS.this_cCursorGrade)
1491: 
1492:                 loc_cSafetyAnterior = SET("SAFETY")
1493:                 SET SAFETY OFF
1494:                 ZAP
1495:                 IF loc_cSafetyAnterior = "ON"
1496:                     SET SAFETY ON
1497:                 ENDIF
1498: 
1499:                 APPEND BLANK
1500:             ENDIF
1501:         CATCH TO loc_oErro
1502:             MsgErro(loc_oErro.Message + CHR(13) + ;
1503:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1504:                 "Procedure: " + loc_oErro.Procedure, ;
1505:                 "Erro em FormSIGOPPGC.PrepararLinhaInicial")
1506:         ENDTRY
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * BtnConfirmarClick - "PROCEDURE Click" de SIGOPPGC.Ok (Caption
1511:     * "\<Confirmar"):
1512:     *
1513:     *     If ThisForm.Get_Saldo.Value <> 0
1514:     *         MessageBox('Quantidade de Barras incorretos!!!',0+16,'')
1515:     *         Return .f.
1516:     *     EndIf
1517:     *     Thisform.parentform.enabled = .T.
1518:     *     Thisform.release
1519:     *
1520:     * A regra eh "so fecha com saldo ZERADO": as barras lidas tem de
1521:     * distribuir EXATAMENTE o valor que o form pai mandou (poValor). Saldo
1522:     * positivo significa barra faltando, negativo significa barra sobrando -
1523:     * e o aviso de saldo negativo que o LostFocus da celula ja da
1524:     * ("Quantidade de Barras excedida!!!") eh informativo e NAO bloqueia; eh
1525:     * aqui, no Confirmar, que o legado recusa o fechamento. Transcrito
1526:     * LITERALMENTE, inclusive o criterio "<> 0" (nao "> 0").
1527:     *
1528:     * Le o CONTROLE (txt_4c_Saldo.Value), como o legado - a conta tem fonte
1529:     * unica no BO (SIGOPPGCBO.RecalcularSaldoEQuantidade) e o controle eh o
1530:     * espelho dela, atualizado pelo funil AtualizarSaldoEQuantidade. O
1531:     * VARTYPE eh guarda de tipo, nao escolha de fonte: o TextBox nasce
1532:     * numerico (.Value = 0 antes do InputMask) e deve continuar assim.
1533:     *
1534:     * MESSAGEBOX eh PROIBIDO no projeto: a recusa eh validacao de TELA (o
1535:     * usuario continua nela e corrige), entao MsgAviso - nao MsgErro, que
1536:     * tem dialogo de falha tecnica. O titulo do legado eh vazio; MsgAviso
1537:     * aplica o canonico ("Aten" + CHR(231) + CHR(227) + "o") quando nao se
1538:     * passa titulo.
1539:     *
1540:     * RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1). O
1541:     * valor devolvido reproduz o "Return .f." do legado - BINDEVENT descarta
1542:     * o retorno do delegate e o Click do CommandButton nao o usa, mas
1543:     * manter o contrato documenta a recusa e serve a quem chamar o handler
1544:     * direto (o harness de teste chama metodos Btn*Click de fora da classe).
1545:     *
1546:     * PUBLIC: eh delegate de BINDEVENT ("Click" de cmd_4c_Ok) - PROTECTED
1547:     * falharia em SILENCIO no bind e em runtime na chamada de fora (regras
1548:     * CLAUDE.md #3 e #51).
1549:     *==========================================================================
1550:     PROCEDURE BtnConfirmarClick()
1551:         LOCAL loc_lFechou, loc_nSaldo, loc_oErro
1552:         loc_lFechou = .F.
1553: 
1554:         TRY
1555:             loc_nSaldo = 0
1556:             IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
1557:                 IF VARTYPE(THIS.txt_4c_Saldo.Value) = "N"
1558:                     loc_nSaldo = THIS.txt_4c_Saldo.Value
1559:                 ELSE
1560:                     loc_nSaldo = TRANSFORM(THIS.txt_4c_Saldo.Value)
1561:                 ENDIF
1562:             ENDIF
1563: 
1564:             IF loc_nSaldo != 0
1565:                 MsgAviso("Quantidade de Barras incorretos!!!")
1566:             ELSE
1567:                 THIS.FecharDialogo()
1568:                 loc_lFechou = .T.
1569:             ENDIF
1570:         CATCH TO loc_oErro
1571:             MsgErro(loc_oErro.Message + CHR(13) + ;
1572:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1573:                 "Procedure: " + loc_oErro.Procedure, ;
1574:                 "Erro em FormSIGOPPGC.BtnConfirmarClick")
1575:         ENDTRY
1576: 
1577:         RETURN loc_lFechou
1578:     ENDPROC
1579: 
1580:     *==========================================================================
1581:     * BtnCancelarClick - "PROCEDURE Click" de SIGOPPGC.Cancela (Caption
1582:     * "Cancelar"):
1583:     *
1584:     *     Select BarBonus
1585:     *     Zap
1586:     *     Thisform.parentform.enabled = .T.
1587:     *     Thisform.release
1588:     *
1589:     * O ZAP eh o que COMUNICA o cancelamento: o chamador decide pelo
1590:     * conteudo do cursor ("If Reccount('BarBonus') > 0" no SIGOPPAG), entao
1591:     * esvaziar BarBonus eh como ele distingue cancelar de confirmar - nao eh
1592:     * limpeza cosmetica, e suprimi-lo faria o pai processar as barras lidas
1593:     * como se o usuario tivesse confirmado. Diferente do Confirmar, aqui o
1594:     * cursor NAO recebe APPEND BLANK: fica com RECCOUNT = 0.
1595:     *
1596:     * SAFETY pelo mesmo motivo de PrepararLinhaInicial (DataSession = 2
1597:     * escopa o SET SAFETY e o ZAP congelaria a tela num dialogo modal
1598:     * invisivel).
1599:     *
1600:     * O cursor eh do CHAMADOR e sobrevive ao fechamento deste dialogo (foi
1601:     * criado na data session dele - ver this_cCursorGrade); o USED() cobre a
1602:     * instanciacao sem chamador (harness/validacao de UI), onde nao ha nada
1603:     * a descartar.
1604:     *
1605:     * O fechamento fica FORA do TRY: este dialogo nao tem X nem barra de
1606:     * titulo (ControlBox = .F. / TitleBar = 0) e o form pai esta
1607:     * Enabled = .F. - se uma falha no descarte do cursor impedisse o
1608:     * fechamento, o usuario ficaria preso na tela sem saida nenhuma. O
1609:     * legado nao precisava dessa separacao porque la um erro de cursor
1610:     * interrompia o metodo com Program Error na cara do usuario, em vez de
1611:     * fechar calado.
1612:     *
1613:     * PUBLIC: delegate de BINDEVENT ("Click" de cmd_4c_Cancela) e tambem
1614:     * chamado de FORA da classe pelo harness (TesteAutomatico.prg procura
1615:     * BtnCancelarClick com PEMSTATUS, que so testa EXISTENCIA e nao escopo -
1616:     * com PROTECTED o teste entraria no branch e estouraria em runtime).
1617:     *==========================================================================
1618:     PROCEDURE BtnCancelarClick()
1619:         LOCAL loc_cSafetyAnterior, loc_oErro
1620: 
1621:         TRY
1622:             IF USED(THIS.this_cCursorGrade)
1623:                 SELECT (THIS.this_cCursorGrade)
1624: 
1625:                 loc_cSafetyAnterior = SET("SAFETY")
1626:                 SET SAFETY OFF
1627:                 ZAP
1628:                 IF loc_cSafetyAnterior = "ON"
1629:                     SET SAFETY ON
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             MsgErro(loc_oErro.Message + CHR(13) + ;
1634:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1635:                 "Procedure: " + loc_oErro.Procedure, ;
1636:                 "Erro em FormSIGOPPGC.BtnCancelarClick")
1637:         ENDTRY
1638: 
1639:         THIS.FecharDialogo()
1640:     ENDPROC
1641: 
1642:     *==========================================================================
1643:     * FecharDialogo - FUNIL de saida, compartilhado pelos dois botoes. No
1644:     * legado as duas ultimas linhas de Ok.Click e de Cancela.Click sao
1645:     * IDENTICAS:
1646:     *
1647:     *     Thisform.parentform.enabled = .T.
1648:     *     Thisform.release
1649:     *
1650:     * A reabilitacao do pai mora AQUI e nao no Destroy, como no legado: o
1651:     * form pai fica Enabled = .F. desde o Init deste dialogo ("Thisform.
1652:     * ParentForm.Enabled = .F.") e so volta a aceitar o usuario quando a
1653:     * tela fecha por um dos dois botoes.
1654:     *
1655:     * Hide() e NAO Release(): medido no VFP9 - Release() destroi o objeto
1656:     * mesmo com o chamador segurando a referencia (form nao segue refcount de
1657:     * COM), e a leitura seguinte estoura "is not an object" NO CHAMADOR,
1658:     * longe da causa. Em form MODAL o Hide() tambem devolve o Show(), entao
1659:     * para o usuario a tela fecha igual - muda so o tempo de vida do objeto
1660:     * (PILAR 3), nao o comportamento (PILAR 1). Eh o contrato que o projeto
1661:     * ja adota em FormBuscaAuxiliar ("usa Hide() em vez de Release() para
1662:     * permitir leitura de propriedades / caller deve chamar Release() apos
1663:     * ler valores"), e por isso o CHAMADOR eh quem libera este dialogo
1664:     * depois de ler o cursor BarBonus.
1665:     *
1666:     * Nada a antecipar do Destroy: o Destroy desta classe so faz DODEFAULT()
1667:     * (rebuild dos popups do menu principal) - nao ha efeito externo que o
1668:     * chamador leia na sequencia e que o Hide() atrasaria.
1669:     *
1670:     * PROTECTED: nao eh delegate de BINDEVENT nem alvo do harness - os dois
1671:     * unicos pontos de saida da tela sao os Btn*Click acima, que sao PUBLIC.
1672:     *==========================================================================
1673:     PROTECTED PROCEDURE FecharDialogo()
1674:         IF VARTYPE(THIS.this_oFormPai) = "O"
1675:             THIS.this_oFormPai.Enabled = .T.
1676:         ENDIF
1677: 
1678:         THIS.Hide()
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * FormParaBO - FUNIL unico de transferencia TELA -> Business Object.
1683:     *
1684:     * Esta tela nao tem formulario de campos: o UNICO dado que o usuario
1685:     * informa eh o codigo de barra digitado na celula da grade
1686:     * (Grade.Column1.Text1 do legado). Por isso o metodo transfere DOIS
1687:     * valores, e nao uma lista de campos:
1688:     *
1689:     *   this_cCodigoBarra  <- o valor da celula, como CHARACTER de 10 digitos
1690:     *                         (STR(x, 10)) - exatamente os 10 que o Valid
1691:     *                         legado fatia em nDope ("Val(Left(Str(This.Value,
1692:     *                         10),4))", 4 primeiros) e Nume ("Val(Right(
1693:     *                         Str(This.Value,10),6))", 6 ultimos). O BO
1694:     *                         converte com VAL.
1695:     *   this_lNovoRegistro <- derivado de this_nCodigoBarraAnterior (o
1696:     *                         "_OldCodigo" que o When da celula captura):
1697:     *                         celula que estava em ZERO eh linha NOVA
1698:     *                         (Inserir), celula que ja tinha barra eh
1699:     *                         CORRECAO (Atualizar). As duas rodam a MESMA
1700:     *                         validacao no BO - o que muda eh so o rotulo
1701:     *                         ("INSERT"/"UPDATE") gravado em LogAuditoria.
1702:     *
1703:     * Le o CONTROLE e NUNCA o cursor (regra CLAUDE.md #46): dentro do Valid o
1704:     * cursor ainda tem o valor ANTIGO, entao validar pelo cursor conferiria a
1705:     * barra anterior. Pelo mesmo motivo nao importa que este metodo rode
1706:     * ANTES do "Select BarBonus / Skip / Skip -1" que descarrega o buffer da
1707:     * celula - ele nao depende do cursor.
1708:     *
1709:     * par_oTxt eh OPCIONAL: a celula ativa chega por parametro quando quem
1710:     * chama eh o Valid da subclasse (que a recebe como THIS), e eh resolvida
1711:     * pelo caminho conhecido na grade quando o metodo eh chamado sem
1712:     * argumento. A Column tem UMA instancia do CurrentControl, compartilhada
1713:     * por todas as linhas, entao os dois caminhos alcancam o MESMO objeto.
1714:     * NUNCA Controls(<nome>) para alcancar membro por nome (regra CLAUDE.md
1715:     * #34), e PEMSTATUS so prova EXISTENCIA, nao escopo (regra CLAUDE.md #3).
1716:     *
1717:     * O saldo recebido do form pai (poValor) NAO passa por aqui: ele chega ao
1718:     * BO em InicializarForm, ANTES de qualquer controle existir - eh
1719:     * parametro do Init ("ThisForm.Saldo = poValor"), nao campo de tela.
1720:     *
1721:     * Devolve .F. quando nao ha BO ou nao ha celula a ler (tela instanciada
1722:     * sem o form chamador - harness de teste, validacao de UI), sem exibir
1723:     * nada. RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
1724:     *
1725:     * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase ja declara
1726:     * "PROTECTED PROCEDURE FormParaBO" (formbase.prg:285) e o VFP9 NAO deixa
1727:     * a subclasse ALARGAR o escopo herdado - declarar sem o modificador aqui
1728:     * nao tornaria o metodo publico, so esconderia que ele continua
1729:     * protegido. Medido no VFP9 nesta propria tela: PEMSTATUS(oForm,
1730:     * "FormParaBO", 5) devolve .T. (so testa EXISTENCIA) e
1731:     * PEMSTATUS(..., 2) devolve .T. para Protected, enquanto a chamada de
1732:     * fora estoura "Property FORMPARABO is not found". Por isso o unico
1733:     * chamador eh THIS.FormParaBO(par_oTxt), de dentro de
1734:     * ValidarBarraDigitada (regra CLAUDE.md #8); quem chega do Valid da
1735:     * subclasse de celula entra por ValidarBarraDigitada, que eh PUBLIC.
1736:     * Exercitar este metodo num harness exige subclasse com wrapper publico -
1737:     * script solto nao alcanca membro protegido.
1738:     *==========================================================================
1739:     PROTECTED PROCEDURE FormParaBO(par_oTxt)
1740:         LOCAL loc_lTransferiu, loc_oCelula, loc_nValor, loc_oErro
1741:         loc_lTransferiu = .F.
1742: 
1743:         TRY
1744:             loc_oCelula = .NULL.
1745: 
1746:             IF VARTYPE(par_oTxt) = "O"
1747:                 loc_oCelula = par_oTxt
1748:             ELSE
1749:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1750:                     IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelBarra", 5)
1751:                         loc_oCelula = THIS.grd_4c_Dados.Column1.txt_4c_CelBarra
1752:                     ENDIF
1753:                 ENDIF
1754:             ENDIF
1755: 
1756:             IF VARTYPE(loc_oCelula) = "O" AND VARTYPE(THIS.this_oBusinessObject) = "O"
1757:                 IF VARTYPE(loc_oCelula.Value) = "N"
1758:                     loc_nValor = loc_oCelula.Value
1759:                 ELSE
1760:                     loc_nValor = VAL(TRANSFORM(loc_oCelula.Value))
1761:                 ENDIF
1762: 
1763:                 WITH THIS.this_oBusinessObject
1764:                     .this_cCodigoBarra  = ALLTRIM(STR(loc_nValor, 10))
1765:                     .this_lNovoRegistro = (THIS.this_nCodigoBarraAnterior = 0)
1766:                 ENDWITH
1767: 
1768:                 loc_lTransferiu = .T.
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro(loc_oErro.Message + CHR(13) + ;
1772:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1773:                 "Procedure: " + loc_oErro.Procedure, ;
1774:                 "Erro em FormSIGOPPGC.FormParaBO")
1775:         ENDTRY
1776: 
1777:         RETURN loc_lTransferiu
1778:     ENDPROC
1779: 
1780:     *==========================================================================
1781:     * BOParaForm - contrapartida de FormParaBO: FUNIL unico que espelha na
1782:     * tela o que o Business Object calculou. Sao os TRES unicos pontos desta
1783:     * tela que exibem estado vindo do BO, e todos os tres existem no legado:
1784:     *
1785:     *   lbl_4c_Label1 <- this_cDescFormaPagto  ("'[ '+AllTrim(crSigOpFp.fpags)
1786:     *                                           +' ]'" no Init)
1787:     *   lbl_4c_Label3 <- this_nQtdeBarras      ("'[ '+Alltrim(Str(Selecao.Qt))
1788:     *                                           +' ]'" no LostFocus da celula)
1789:     *   txt_4c_Saldo  <- this_nSaldoAtual      ("ThisForm.Get_Saldo.Value =
1790:     *                                           ThisForm.Saldo - Selecao.Valor")
1791:     *
1792:     * A CONTA nao mora aqui: ela tem fonte unica em
1793:     * SIGOPPGCBO.RecalcularSaldoEQuantidade, e este metodo so pinta o
1794:     * resultado. O Refresh explicito nos dois controles recalculados
1795:     * reproduz "ThisForm.label3.Refresh" / "ThisForm.Get_Saldo.Refresh" do
1796:     * legado - e eh necessario, porque atribuir .Value/.Caption nao repinta
1797:     * sozinho (mesma mecanica da regra CLAUDE.md #21).
1798:     *
1799:     * O aviso de saldo NEGATIVO ("Quantidade de Barras excedida!!!") NAO vem
1800:     * para ca: no legado ele esta no LostFocus, depois do Refresh, e eh fluxo
1801:     * (interrompe o usuario), nao espelho - fica em
1802:     * AtualizarSaldoEQuantidade, que eh quem transcreve aquele evento.
1803:     *
1804:     * NAO eh chamado no Init, de proposito: la o contador ainda nao foi
1805:     * calculado e o legado mantem o Caption de projeto de Label3 ("[  ]")
1806:     * ate o primeiro LostFocus - pintar "[ 0 ]" na abertura seria desvio do
1807:     * PILAR 1. O rotulo da forma de pagamento, que o Init legado DE FATO
1808:     * troca, eh pintado la por PintarRotuloFormaPagto, o mesmo helper que
1809:     * este metodo usa (fonte unica do Caption - CLAUDE.md #44, item 6).
1810:     *
1811:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: FormBase declara
1812:     * "PROTECTED PROCEDURE BOParaForm" (formbase.prg:280) e o escopo herdado
1813:     * NAO se alarga na subclasse. Chamado por THIS.BOParaForm(), de dentro de
1814:     * AtualizarSaldoEQuantidade - que eh PUBLIC e eh por onde o LostFocus da
1815:     * celula chega.
1816:     *==========================================================================
1817:     PROTECTED PROCEDURE BOParaForm()
1818:         LOCAL loc_lEspelhou, loc_oErro
1819:         loc_lEspelhou = .F.
1820: 
1821:         TRY
1822:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1823:                 THIS.PintarRotuloFormaPagto()
1824: 
1825:                 IF PEMSTATUS(THIS, "lbl_4c_Label3", 5)
1826:                     THIS.lbl_4c_Label3.Caption = "[ " + ;
1827:                         ALLTRIM(STR(THIS.this_oBusinessObject.this_nQtdeBarras)) + " ]"
1828:                     THIS.lbl_4c_Label3.Refresh()
1829:                 ENDIF
1830: 
1831:                 IF PEMSTATUS(THIS, "txt_4c_Saldo", 5)
1832:                     THIS.txt_4c_Saldo.Value = THIS.this_oBusinessObject.this_nSaldoAtual
1833:                     THIS.txt_4c_Saldo.Refresh()
1834:                 ENDIF
1835: 
1836:                 loc_lEspelhou = .T.
1837:             ENDIF
1838:         CATCH TO loc_oErro
1839:             MsgErro(loc_oErro.Message + CHR(13) + ;
1840:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1841:                 "Procedure: " + loc_oErro.Procedure, ;
1842:                 "Erro em FormSIGOPPGC.BOParaForm")
1843:         ENDTRY
1844: 
1845:         RETURN loc_lEspelhou
1846:     ENDPROC
1847: 
1848:     *==========================================================================
1849:     * PintarRotuloFormaPagto - FONTE UNICA do Caption de lbl_4c_Label1
1850:     * ("'[ '+AllTrim(crSigOpFp.fpags)+' ]'" do Init legado), consumida pelos
1851:     * DOIS pontos que precisam dele: AplicarRotuloFormaPagto (que CARREGA a
1852:     * forma de pagamento do cursor do chamador para o BO, na abertura) e
1853:     * BOParaForm (o espelho completo). Escrever a expressao nos dois lugares
1854:     * faria as duas copias divergirem em silencio na primeira mudanca de
1855:     * formato (CLAUDE.md #44, item 6).
1856:     *
1857:     * So pinta com descricao PREENCHIDA: sem o cursor do chamador (harness de
1858:     * teste, validacao de UI) this_cDescFormaPagto fica vazia, e pintar
1859:     * "[  ]" por cima APAGARIA o Caption de projeto que o SCX traz
1860:     * ("Condi" + CHR(231) + CHR(227) + "o de Pagamento"). Mesma guarda por
1861:     * conteudo que AplicarRotuloFormaPagto ja aplicava ao condicionar a
1862:     * pintura ao sucesso de CarregarDoCursor.
1863:     *
1864:     * Sem Refresh: o legado nao o faz neste label (so em label3 e Get_Saldo),
1865:     * e aqui a troca acontece antes de a tela ser exibida.
1866:     *
1867:     * PROTECTED: nao eh delegate de BINDEVENT nem alvo do harness - os dois
1868:     * chamadores sao metodos desta propria classe.
1869:     *==========================================================================
1870:     PROTECTED PROCEDURE PintarRotuloFormaPagto()
1871:         IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
1872:            AND PEMSTATUS(THIS, "lbl_4c_Label1", 5)
1873: 
1874:             IF !EMPTY(THIS.this_oBusinessObject.this_cDescFormaPagto)
1875:                 THIS.lbl_4c_Label1.Caption = "[ " + ;
1876:                     ALLTRIM(THIS.this_oBusinessObject.this_cDescFormaPagto) + " ]"
1877:             ENDIF
1878:         ENDIF
1879:     ENDPROC
1880: 
1881:     *==========================================================================
1882:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
1883:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
1884:     * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
1885:     * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
1886:     * "PROPRIEDADES DE: SIGOPPGC.cntSombra" e dos dois labels filhos).
1887:     *
1888:     * Container.Width = THIS.Width (NAO o 800 literal do dump, que eh
1889:     * residuo do template da classe base e excede o Width real do form -
1890:     * regra CLAUDE.md sobre cnt_4c_Cabecalho.Width).
1891:     *
1892:     * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
1893:     * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
1894:     * criado por AddObject e, com WordWrap, descarta a Height).
1895:     *
1896:     * Caption = THIS.Caption - o dump traz "Cadastro de Testes" literal nos
1897:     * dois labels, que eh residuo de template (nao bate com o Caption real
1898:     * do form, "Informe os Barras") - transcrever o texto do template
1899:     * reproduziria o defeito, nao o legado (mesma decisao de
1900:     * Formsigopped.prg e regra CLAUDE.md #11 - ambos os labels usam
1901:     * THIS.Caption).
1902:     *==========================================================================
1903:     PROTECTED PROCEDURE ConfigurarCabecalho()
1904:         LOCAL loc_oCab
1905: 
1906:         THIS.AddObject("cnt_4c_Sombra", "Container")
1907:         loc_oCab = THIS.cnt_4c_Sombra
1908:         WITH loc_oCab
1909:             .Top         = 0
1910:             .Left        = 0
1911:             .Width       = THIS.Width
1912:             .Height      = 80
1913:             .BackStyle   = 1
1914:             .BackColor   = RGB(100, 100, 100)
1915:             .BorderWidth = 0
1916:             .Visible     = .T.
1917:         ENDWITH
1918: 
1919:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
1920:         WITH loc_oCab.lbl_4c_LblSombra
1921:             .AutoSize      = .F.
1922:             .Top           = 18
1923:             .Left          = 10
1924:             .Width         = 769
1925:             .Height        = 40
1926:             .FontName      = "Tahoma"
1927:             .FontSize      = 18
1928:             .FontBold      = .T.
1929:             .FontUnderline = .F.
1930:             .WordWrap      = .T.
1931:             .Alignment     = 0
1932:             .BackStyle     = 0
1933:             .ForeColor     = RGB(0, 0, 0)
1934:             .Caption       = THIS.Caption
1935:             .Visible       = .T.
1936:         ENDWITH
1937: 
1938:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
1939:         WITH loc_oCab.lbl_4c_LblTitulo
1940:             .AutoSize    = .F.
1941:             .Top         = 17
1942:             .Left        = 10
1943:             .Width       = 769

*-- Linhas 1956 a 2088:
1956:     ENDPROC
1957: 
1958:     *==========================================================================
1959:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
1960:     * criados via AddObject (que nascem Visible = .F. por padrao) e desce em
1961:     * PageFrames/Containers. Nao ha containers flutuantes (Visible = .F. por
1962:     * design) nesta tela - sem lista de excecao, diferente de forms com
1963:     * paineis alternaveis.
1964:     *==========================================================================
1965:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1966:         LOCAL loc_i, loc_oObjeto
1967: 
1968:         FOR loc_i = 1 TO par_oContainer.ControlCount
1969:             loc_oObjeto = par_oContainer.Controls(loc_i)
1970: 
1971:             IF VARTYPE(loc_oObjeto) = "O"
1972:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1973:                     loc_oObjeto.Visible = .T.
1974:                 ENDIF
1975: 
1976:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1977:                     LOCAL loc_nP
1978:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1979:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1980:                     ENDFOR
1981:                 ENDIF
1982: 
1983:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1984:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1985:                 ENDIF
1986:             ENDIF
1987:         ENDFOR
1988:     ENDPROC
1989: 
1990:     *==========================================================================
1991:     * Destroy - equivale a "PROCEDURE Release" do legado (nao existe neste
1992:     * dump - a reabilitacao do form pai mora nos Click de Ok/Cancela, fase
1993:     * 8, mesmo padrao de Formsigopped.prg). DODEFAULT() OBRIGATORIO (regra
1994:     * CLAUDE.md Pattern #145 - sem ele os popups do menu principal ficam com
1995:     * cache visual encolhido apos este dialogo modal fechar).
1996:     *==========================================================================
1997:     PROCEDURE Destroy()
1998:         RETURN DODEFAULT()
1999:     ENDPROC
2000: 
2001: ENDDEFINE
2002: 
2003: *==============================================================================
2004: * SUBCLASSES DE CELULA DA GRADE
2005: *
2006: * Levam o When/Valid que o legado tem em SIGOPPGC.Grade.ColumnN.Text1, e sao
2007: * instaladas por FormSIGOPPGC.InstalarCelulasGrade (Column.AddObject +
2008: * CurrentControl - regra CLAUDE.md #18).
2009: *
2010: * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao de
2011: * celula de grade mora no Valid do TextBox da coluna, BINDEVENT em "Valid" de
2012: * TextBox de Column nao eh confiavel e, acima de tudo, BINDEVENT DESCARTA o
2013: * retorno do delegate - e aqui o retorno E' o mecanismo: Valid devolvendo .F.
2014: * recusa a saida da celula, When devolvendo .F. recusa a entrada. Nenhum dos
2015: * dois efeitos sobrevive a um BINDEVENT. (O LostFocus, que nao tem retorno com
2016: * significado, fica por BINDEVENT - ver InstalarCelulasGrade.)
2017: *
2018: * Cada subclasse so decide ENTRAR/SAIR e DELEGA a regra ao metodo PUBLIC
2019: * correspondente do form (fonte unica) - o legado faz o mesmo, chamando
2020: * "ThisForm.label3"/"ThisForm.Get_Saldo" de dentro dos eventos da celula.
2021: *
2022: * O guard PEMSTATUS existe porque estas classes vivem no mesmo arquivo do form
2023: * mas sao instanciadas pelo Grid: se um dia a celula for reusada em outro form
2024: * sem esses metodos, a ausencia vira "a celula nao valida" em vez de "Property
2025: * is not found" derrubando a tela.
2026: *==============================================================================
2027: 
2028: *------------------------------------------------------------------------------
2029: * TextBoxCelBarraSigOpPgc_4c - celula da coluna "Barra"
2030: * (SIGOPPGC.Grade.Column1.Text1), a UNICA digitavel da tela.
2031: *
2032: * When  legado: "Public _OldCodigo / Set Confirm On / _OldCodigo = This.Value /
2033: *               Return(.t.)" - vive em FormSIGOPPGC.PrepararCelulaBarra.
2034: * Valid legado: decodifica a barra, confere a operacao em SigCdOpe, confere
2035: *               duplicidade, grava o valor da forma de pagamento e abre a
2036: *               linha seguinte - vive em FormSIGOPPGC.ValidarBarraDigitada
2037: *               (que delega a regra a SIGOPPGCBO).
2038: *
2039: * THIS eh passado adiante porque o valor DIGITADO so existe em .Value durante
2040: * o Valid - o cursor ainda guarda o valor anterior (regra CLAUDE.md #46).
2041: *------------------------------------------------------------------------------
2042: DEFINE CLASS TextBoxCelBarraSigOpPgc_4c AS TextBox
2043: 
2044:     PROCEDURE When()
2045:         LOCAL loc_lPermite
2046: 
2047:         loc_lPermite = .T.
2048: 
2049:         IF PEMSTATUS(THISFORM, "PrepararCelulaBarra", 5)
2050:             loc_lPermite = THISFORM.PrepararCelulaBarra(THIS)
2051:         ENDIF
2052: 
2053:         RETURN loc_lPermite
2054:     ENDPROC
2055: 
2056:     PROCEDURE Valid()
2057:         LOCAL loc_lValido
2058: 
2059:         loc_lValido = .T.
2060: 
2061:         IF PEMSTATUS(THISFORM, "ValidarBarraDigitada", 5)
2062:             loc_lValido = THISFORM.ValidarBarraDigitada(THIS)
2063:         ENDIF
2064: 
2065:         RETURN loc_lValido
2066:     ENDPROC
2067: 
2068: ENDDEFINE
2069: 
2070: *------------------------------------------------------------------------------
2071: * TextBoxCelValorSigOpPgc_4c - celula da coluna "Valor"
2072: * (SIGOPPGC.Grade.Column2.Text1).
2073: *
2074: * When legado: "Return .f." - a celula NUNCA recebe foco. O valor nao eh
2075: * digitado: eh gravado por codigo, no "Replace Valors With CrSigOpFp.VlrFpgs"
2076: * do Valid da coluna 1 (hoje em SIGOPPGCBO).
2077: *
2078: * Eh este o mecanismo do legado, e por isso a Column NAO leva ReadOnly = .T.
2079: * inventado: daria o mesmo efeito por outra via e esconderia o When que o
2080: * dump declara.
2081: *------------------------------------------------------------------------------
2082: DEFINE CLASS TextBoxCelValorSigOpPgc_4c AS TextBox
2083: 
2084:     PROCEDURE When()
2085:         RETURN .F.
2086:     ENDPROC
2087: 
2088: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPPGCBO.prg):
*==============================================================================
* SIGOPPGCBO.prg - Business Object para FormSIGOPPGC (Informe os Barras)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) aberto por um form pai
* para informar as "barras" (codigos de barra) usadas como forma de pagamento
* por barras/bonus. O dialogo NAO possui tabela propria no SQL Server: ele
* grava os codigos digitados no cursor local BarBonus (criado pelo proprio
* form, no mesmo padrao de SIGOPPED), e por isso this_cTabela fica vazio.
* this_cCampoChave aponta para a coluna que identifica cada linha desse
* cursor (Codigos), usada pelo legado em "Where Codigos = This.Value".
*==============================================================================
DEFINE CLASS SIGOPPGCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (dados manipulados pelo dialogo Informe os Barras)
    *--------------------------------------------------------------------------
    this_nSaldoInicial    = 0    && poValor - saldo recebido do form pai (ThisForm.Saldo)
    this_nSaldoAtual      = 0    && saldo apos descontar a soma dos valores das barras validas (Get_Saldo.Value)
    this_nQtdeBarras      = 0    && quantidade de barras validas digitadas (label3 "[ N ]")
    this_cDescFormaPagto  = ""   && crSigOpFp.fpags - descricao da forma de pagamento (label1.Caption)
    this_nValorPorBarra   = 0    && crSigOpFp.VlrFpgs - valor atribuido a cada barra digitada (Replace Valors)
    this_cCodigoBarra     = ""   && ultimo codigo de barra validado na celula da grade (BarBonus.Codigos)
    this_nDopeBarra       = 0    && nDope - codigo da operacao decodificado dos 4 primeiros digitos da barra
    this_nNumeBarra       = 0    && Nume - numero sequencial decodificado dos 6 ultimos digitos da barra
    this_lBarraValida     = .F.  && resultado da ultima validacao de barra contra SigCdOpe

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Codigos"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da forma de pagamento (cursor crSigOpFp,
    * aberto pelo form pai e repassado na mesma datasession) a descricao
    * (fpags, equivalente ao label1.Caption do Init legado) e o valor
    * atribuido a cada barra (VlrFpgs, equivalente ao Replace Valors do
    * Valid legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cDescFormaPagto = TratarNulo(fpags, "")
                THIS.this_nValorPorBarra  = TratarNulo(VlrFpgs, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo de barra validado por ultimo (Codigos, a
    * mesma coluna usada pelo legado em "Where Codigos = This.Value")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoBarra
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor local BarBonus - ver Init, que por isso deixa
    * this_cTabela vazio de proposito). Sobrescrito aqui so para o log de
    * auditoria identificar o cursor afetado em vez de uma tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("BarBonus") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - A grade aceita uma barra nova por linha (sempre Codigos = 0
    * antes de validar - ver Insert Into BarBonus(Codigos) Values(0) do
    * legado); a validacao e a gravacao sao a MESMA operacao do Valid
    * legado, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Revalida uma barra ja existente na grade (usuario corrige
    * o codigo de uma linha) - mesma operacao de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarraEAtualizarCursor - Transcricao de
    * SIGOPPGC.Grade.Column1.Text1.Valid: decodifica o codigo de barra
    * (this_cCodigoBarra, 10 digitos) nos 4 primeiros digitos (codigo da
    * operacao, this_nDopeBarra) e nos 6 ultimos (numero sequencial,
    * this_nNumeBarra); confere o codigo da operacao contra SigCdOpe;
    * confere duplicidade da mesma barra dentro do cursor local BarBonus; e,
    * se tudo valido, grava o valor da forma de pagamento (this_nValorPorBarra,
    * carregado de crSigOpFp.VlrFpgs em CarregarDoCursor) na linha corrente
    * de BarBonus.Valors.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarBarraEAtualizarCursor()
        LOCAL loc_lResultado, loc_nCodigoBarra, loc_cSqlOpe, loc_nResultado, loc_oErro

        loc_lResultado   = .T.
        loc_nCodigoBarra = VAL(THIS.this_cCodigoBarra)

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        THIS.this_lBarraValida  = .F.
        THIS.this_nDopeBarra    = 0
        THIS.this_nNumeBarra    = 0

        TRY
            IF loc_nCodigoBarra > 0
                SET DECIMALS TO 0
                THIS.this_nDopeBarra = VAL(LEFT(STR(loc_nCodigoBarra, 10), 4))
                THIS.this_nNumeBarra = VAL(RIGHT(STR(loc_nCodigoBarra, 10), 6))

                loc_cSqlOpe = "SELECT Dopes FROM SigCdOpe WHERE ndopes = " + STR(THIS.this_nDopeBarra)

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSqlOpe, "cursor_4c_ValidaOpe")

                IF loc_nResultado < 0 OR !USED("cursor_4c_ValidaOpe") OR RECCOUNT("cursor_4c_ValidaOpe") = 0
                    THIS.this_cMensagemErro = "Barra Inv" + CHR(225) + "lido!!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lResultado = .F.
                ELSE
                    IF USED("BarBonus")
                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF

                        *-- m. OBRIGATORIO: em SELECT VFP local, nome solto eh
                        *-- resolvido primeiro como COLUNA - sem o prefixo a
                        *-- consulta de duplicidade pode estourar "Column
                        *-- LOC_NCODIGOBARRA is not found" em vez de comparar
                        *-- com a variavel.
                        SELECT SUM(1) AS Qt, Codigos FROM BarBonus ;
                            WHERE Codigos = m.loc_nCodigoBarra ;
                            GROUP BY Codigos ;
                            INTO CURSOR cursor_4c_CheckDup

                        IF USED("cursor_4c_CheckDup") AND cursor_4c_CheckDup.Qt > 1
                            THIS.this_cMensagemErro = "Barra j" + CHR(225) + " digitado !!!"
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.
                            loc_lResultado = .F.
                        ELSE
                            REPLACE Valors WITH THIS.this_nValorPorBarra IN BarBonus
                            THIS.this_lBarraValida = .T.
                        ENDIF

                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Cursor de barras (BarBonus) n" + CHR(227) + "o est" + CHR(225) + " aberto."
                        THIS.this_lErroExibido = .T.
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ENDIF

            IF loc_lResultado AND THIS.this_lBarraValida
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar barra: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldoEQuantidade - Transcricao da conta que
    * SIGOPPGC.Grade.Column1.Text1.LostFocus faz no legado:
    *
    *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
    *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
    *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
    *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
    *
    * Fica NO BO porque eh regra de negocio com FONTE UNICA (regra CLAUDE.md
    * #17 - totais calculados pelo BO, o form so espelha): grava
    * this_nQtdeBarras (contador "[ N ]" de label3) e this_nSaldoAtual (saldo
    * restante de Get_Saldo), que FormSIGOPPGC.AtualizarSaldoEQuantidade le
    * para repintar os dois controles.
    *
    * O CRITERIO do legado vai junto e eh parte da regra: "Where Codigos <> 0"
    * EXCLUI a linha em branco que o Valid acabou de abrir (o
    * "Insert Into BarBonus(Codigos) Values(0)"), senao ela entraria na
    * contagem de barras e inflaria o total em um.
    *
    * Cursor vazio / nenhuma barra valida: no legado o GROUP BY devolve ZERO
    * linhas e "Selecao.Qt"/"Selecao.Valor" lidos em EOF valem 0, ou seja
    * contador 0 e saldo = saldo inicial. Reproduzido com guarda EXPLICITA de
    * RECCOUNT, que da o mesmo resultado sem depender da leitura em EOF.
    *
    * A area de trabalho corrente eh salva e restaurada: o SELECT-SQL a troca,
    * e quem chama (o Valid da celula) depende do ponteiro de BarBonus para
    * decidir se abre linha nova.
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularSaldoEQuantidade(par_cAliasGrade)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasGrade) = "C" AND !EMPTY(par_cAliasGrade), ;
                         ALLTRIM(par_cAliasGrade), "BarBonus")

        THIS.this_nQtdeBarras = 0
        THIS.this_nSaldoAtual = THIS.this_nSaldoInicial

        TRY
            IF USED(loc_cAlias)
                loc_cAliasAnterior = ALIAS()
                SELECT (loc_cAlias)
                loc_nRecno = RECNO()

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- FROM por MACRO (&), nao "(loc_cAlias)": o FROM de um
                *-- SELECT-SQL do VFP nao aceita expressao de nome entre
                *-- parenteses - so literal ou substituicao de macro. Sem o
                *-- ponto final o VFP leria o "nome" ate o ";" da continuacao.
                *-- O "[ ] as Agrupar ... group by 1" do legado existe so para
                *-- forcar UMA linha de resultado; a agregacao sem GROUP BY ja
                *-- devolve exatamente uma linha, inclusive quando nenhuma
                *-- barra casa (ai com total zerado), entao a coluna constante
                *-- nao eh reproduzida - ninguem a le.
                SELECT SUM(1) AS Qt, SUM(Valors) AS Valor ;
                    FROM &loc_cAlias. ;
                    WHERE Codigos <> 0 ;
                    INTO CURSOR cursor_4c_Selecao

                IF USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    THIS.this_nQtdeBarras = NVL(cursor_4c_Selecao.Qt, 0)
                    THIS.this_nSaldoAtual = THIS.this_nSaldoInicial - ;
                                            NVL(cursor_4c_Selecao.Valor, 0)
                ENDIF

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- Repoe area e ponteiro para quem chamou (o Valid da celula
                *-- depende do RECNO de BarBonus).
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    IF loc_nRecno >= 1 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao recalcular saldo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


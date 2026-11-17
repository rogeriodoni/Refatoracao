# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2194 linhas total):

*-- Linhas 45 a 141:
45: * Fase 2/8 - sigopsepBO.prg: BuscarLinhas/MarcarTodasLinhas/BuscarProdutos/
46: *            MarcarTodosProdutos/ObterProdutosParaCopia/LimparCursores.
47: * Fase 3/8 - estrutura base do Form: DEFINE CLASS + propriedades visuais do
48: *            dump, Init completo (contexto do pai + BO + InicializarForm),
49: *            cabecalho cinza (cntSombra -> cnt_4c_Sombra) e Destroy.
50: *
51: * Fase 4/8 (ESTA FASE) - as DUAS grades do dialogo e os botoes de acao:
52: *   - cnt_4c_Filtro (CrtFiltro): campos de filtro + grd_4c_Linhas
53: *     (GradeLinhas) + cmd_4c_Marcar/cmd_4c_Desmarcar
54: *   - grd_4c_Itens (GradeItens, direto na Form, 6 colunas)
55: *   - botoes de acao direto na Form: cmd_4c_Processar, cmd_4c_CopiaLista,
56: *     cmd_4c_Encerrar (Sair), cmd_4c_MarcaProd, cmd_4c_DesmarcaProd
57: *   - funis de carga CarregarLinhas()/CarregarDados(), que ligam cada grade
58: *     ao seu cursor e instalam o CheckBox da coluna de marcacao
59: *     (InstalarCheckBoxColuna) - replicam o fecho do SIGOPSEP.Init
60: *
61: * NAO existe aqui PageFrame nem pagina Lista/Dados: o SCX legado NAO tem
62: * Page nenhuma (layout FLAT, controles direto na Form) - igual ao padrao ja
63: * usado em FormSigOpCrd.prg para a mesma familia de dialogos OPERACIONAL.
64: * Inventar PageFrame Lista/Dados violaria o PILAR 1. Os nomes de metodo
65: * ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados seguem o
66: * CONTRATO do pipeline, mas o conteudo de cada um e o que de fato existe no
67: * dump:
68: *
69: *   ConfigurarPageFrame   -> fundo do form (Picture new_background.jpg)
70: *   ConfigurarPaginaLista -> cnt_4c_Filtro (CrtFiltro do legado): campos de
71: *       filtro (Grupo Venda/Produto, Moeda, Acrescimo/Desconto,
72: *       Arredondamento, Situacao) + grd_4c_Linhas + cmd_4c_Marcar/
73: *       cmd_4c_Desmarcar
74: *   ConfigurarPaginaDados -> grd_4c_Itens (GradeItens) + os cinco botoes de
75: *       acao, todos filhos diretos da Form no dump
76: *
77: * mapeamento.json (gerado automaticamente) mapeia GradeLinhas E GradeItens
78: * para o MESMO nome "grd_4c_Dados" - colisao de gerador (mesma familia de
79: * bug ja registrada em outras tasks: alvo duplicado no mapeamento auto).
80: * Por isso os dois grids usam nomes DISTINTOS e explicitos (grd_4c_Linhas /
81: * grd_4c_Itens), escolhidos manualmente, e os botoes cmdMarcaProd/
82: * cmdDesmarcaProd (que marcam PRODUTOS) usam cmd_4c_MarcaProd/
83: * cmd_4c_DesmarcaProd para nao colidir com cmd_4c_Marcar/cmd_4c_Desmarcar
84: * (que marcam LINHAS, dentro de cnt_4c_Filtro).
85: *
86: * Fase 5/8 - FormParaBO()/BOParaForm() dos campos de filtro de cnt_4c_Filtro
87: *   (Grupo Venda/Produto codigo+descricao, Moeda Venda codigo+descricao,
88: *   Acrescimo/Desconto, Arredondamento, Situacao), espelhando 1:1 as
89: *   properties ja existentes em sigopsepBO (Fase 1/8).
90: *
91: * Fase 6/8 (ESTA FASE) - os 6 lookups de cnt_4c_Filtro, transcritos de
92: *   Get_grVenda/Get_DgrVenda (SigCdCol: colecoes/descs),
93: *   Get_grProduto/Get_DgrProduto (SigCdGrp: cgrus/dgrus) e
94: *   Get_moevenda/Get_Dmoevenda (SigCdMoe: cmoes/dmoes) - cada par nos DOIS
95: *   sentidos, via FormBuscaAuxiliar (NAO fwBuscaExt: padrao canonico do
96: *   projeto). O campo de descricao deixou de ser ReadOnly (Fase 4/5 tinha
97: *   essa suposicao errada - o legado o deixa editavel, com mutua exclusao
98: *   via When: so recebe foco quando o campo de codigo irmao esta vazio).
99: *   Validacao em LostFocus, nunca KeyPress (regra #47); guarda de
100: *   reentrancia this_lEmLookup compartilhada entre os 3 pares (picker eh
101: *   modal e tira o foco, regra #37). Tambem entrou aqui o InteractiveChange
102: *   dos 6 campos (FiltroAlterado), que desabilita CopiaLista - mesma
103: *   propriedade de UMA linha so, repetida no dump nos DOIS lados de cada
104: *   par (codigo E descricao, nao so o codigo - corrigido na Fase 8/8,
105: *   faltavam os 3 campos de descricao).
106: *
107: * Fase 7/8 (ESTA FASE) - os eventos restantes:
108: *   - cmd_4c_Marcar/cmd_4c_Desmarcar.Click -> BO.MarcarTodasLinhas(1/0) +
109: *     Refresh de grd_4c_Linhas (Marcar/Desmarcar do legado)
110: *   - cmd_4c_MarcaProd/cmd_4c_DesmarcaProd.Click -> BO.MarcarTodosProdutos
111: *     (1/0) + Refresh de grd_4c_Itens (cmdMarcaProd/cmdDesmarcaProd)
112: *   - chk_4c_MarcaProduto.When -> so edita a celula quando
113: *     cursor_4c_Produtos.lMarcas = 0 (GradeItens.Column1.Check1.When do
114: *     legado, literal)
115: *   - cmd_4c_Processar.Click -> FormParaBO() + BO.BuscarProdutos(""),
116: *     religa grd_4c_Itens (ReligarGradeItens, novo - fatorado de
117: *     CarregarDados porque o BO recria o alias e a grade precisa ser
118: *     religada nas DUAS situacoes) e replica o aviso "Nao existem
119: *     produtos.../habilita CopiaLista" do fim do Processar.Click legado
120: *   - cmd_4c_CopiaLista.Click -> FormParaBO() + BO.ObterProdutosParaCopia
121: *     ("") preenche cursor_4c_ProdutosCopia (cpros/dpros/pvens/pliqs/moevs)
122: *     com os candidatos (flagctabs=1 AND lMarcas=0, filtrados por
123: *     Situacao) - EXATAMENTE o SCAN do CopiaLista.Click legado, so sem a
124: *     parte que pertence ao form PAI (abaixo)
125: *   - cmd_4c_Encerrar Click -> THIS.Release() (literal)
126: *
127: * O QUE CONTINUA DEFERIDO (documentado desde a Fase 3, linhas 35-39): a
128: * gravacao real em CrSigCdLpi - Delete From CrSigCdLpi Where Empty(cpros),
129: * cidchaves via fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs,
130: * vencis/vencfs, e o arredondamento condicional via fArredondamento
131: * (NAO portada - this_oFormPai so guarda a referencia, gnConnHandle. PILAR
132: * 3 impede acessar objeto do pai por nome fixo (Pagina.Dados.Grade), e
133: * nenhum form SIGOPPxx desta familia foi migrado ainda para expor um
134: * CONTRATO conhecido. BtnCopiaListaClick entrega o cursor ja filtrado
135: * (cursor_4c_ProdutosCopia) ao pai atraves de um metodo PUBLIC opcional
136: * (AdicionarProdutosSelecionados), chamado de forma DEFENSIVA via
137: * PEMSTATUS - o mesmo padrao ja usado em ReabilitarFormPai/RepintarFormPai
138: * (e em FormSigOpCrd.LerTextoDoPai) para nunca estourar enquanto o pai nao
139: * existir. BtnProcessarClick passa par_cCursorListaPrecos = "" pelo mesmo
140: * motivo (equivalente a "lista ainda vazia" no legado).
141: *

*-- Linhas 155 a 389:
155: *
156: * Verificacao final contra comportamento.json (26/26 metodos) encontrou UM
157: * gap real: Get_DgrVenda/Get_DgrProduto/Get_Dmoevenda (os 3 campos de
158: * DESCRICAO) tambem tem InteractiveChange -> "ThisForm.CopiaLista.Enabled =
159: * .F." no dump (SIGOPSEP.CrtFiltro.Get_DgrVenda etc, linhas ~1239/1289/1333
160: * do dump) - a Fase 6/8 so tinha ligado os 3 campos de CODIGO. Os 3
161: * BINDEVENT faltantes foram adicionados em ConfigurarPaginaLista, reusando
162: * o mesmo handler FiltroAlterado (PILAR 3: 1 metodo so, igual ao dump que
163: * repete a MESMA linha 6 vezes).
164: *
165: * PROCEDURE Load do legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo
166: * motivo ja registrado em FormSigMvExp.prg/FormSigMvMen.prg e nos demais
167: * BOs da familia SigOp*: fConfigGeral era funcao GLOBAL de inicializacao da
168: * aplicacao Fortyus (sig.prg/SIGFUNCS.PRG), ausente do acervo; o wrapper
169: * utils\fconfiggeral.prg (RETURN .T.) existe so para o p-code de VCX
170: * legado que ainda a invoca, nunca para ser chamado por codigo novo. O que
171: * fConfigGeral fazia (SETs, paths, aliases, conexao) ja ocorre antes deste
172: * dialogo abrir, em config.prg/main.prg.
173: *==============================================================================
174: 
175: DEFINE CLASS Formsigopsep AS FormBase
176: 
177:     *==========================================================================
178:     * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
179:     *
180:     * Declaradas no dump de SIGOPSEP: BorderStyle = 2, Height = 600,
181:     * Width = 800, ControlBox = .F., MaxButton = .F., MinButton = .F.,
182:     * TitleBar = 0, Caption = "Seleciona Produtos".
183:     *
184:     * NAO declaradas no dump e portanto NAO inventadas (regra #25): Closable
185:     * fica no default .T. - sem barra de titulo ele nao desenha, mas
186:     * Closable = .F. mataria o Alt+F4 (nao ha botao Encerrar visivel ate a
187:     * fase 5, e mesmo depois o legado nao declara Closable).
188:     *
189:     * DoCreate = .T. do dump NAO entra: flag de design-time do SCX, nao
190:     * property de runtime (regra #33).
191:     *
192:     * WindowType / ShowWindow NAO vem do SCX (legado abria com "Do Form"):
193:     * canonico do projeto e 1 (modal), igual a FormSigOpCrd - o form e
194:     * criado com CREATEOBJECT + Show().
195:     *==========================================================================
196:     this_cMensagemErro = ""
197:     BorderStyle  = 2
198:     Height       = 600
199:     Width        = 800
200:     ControlBox   = .F.
201:     MaxButton    = .F.
202:     MinButton    = .F.
203:     TitleBar     = 0
204:     WindowType   = 1
205:     ShowWindow   = 1
206:     AutoCenter   = .T.
207:     Caption      = "Seleciona Produtos"
208: 
209:     *==========================================================================
210:     * PROPRIEDADES DE ESTADO
211:     *==========================================================================
212:     this_oBusinessObject = .NULL.
213: 
214:     *-- Form PAI (ParentForm do legado). O legado NAO desabilita o pai no
215:     *-- Init (diferente de SigOpCrd) - por isso nao ha flag
216:     *-- this_lPaiDesabilitado aqui; o Destroy ainda reabilita o pai de forma
217:     *-- defensiva (PEMSTATUS) para nunca deixa-lo travado, mesmo que o
218:     *-- caller venha a desabilita-lo por fora no futuro.
219:     this_oFormPai = .NULL.
220: 
221:     *-- Guarda de reentrancia dos 6 lookups de cnt_4c_Filtro: o picker
222:     *-- (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que redispara
223:     *-- o proprio LostFocus (regra #37). Compartilhada entre os 3 pares
224:     *-- codigo/descricao, igual ao padrao de FormCco.
225:     this_lEmLookup = .F.
226: 
227:     *-- Guarda "valor nao mudou" (Problema 45, complementar a this_lEmLookup
228:     *-- acima - regra #47): o Valid do legado so dispara quando o valor
229:     *-- MUDA, mas LostFocus dispara SEMPRE que o campo perde o foco. Sem
230:     *-- isso, sair do campo sem digitar nada reabre o picker a cada Tab.
231:     *-- Uma property por handler (nao compartilhada, cada campo tem o seu
232:     *-- ultimo valor validado). .NULL. de proposito (nao ""): o PRIMEIRO
233:     *-- LostFocus tem de validar mesmo que o campo esteja vazio.
234:     this_cUltimoValidarGrVendaValidado = .NULL.
235:     this_cUltimoValidarDgrVendaValidado = .NULL.
236:     this_cUltimoValidarGrProdutoValidado = .NULL.
237:     this_cUltimoValidarDgrProdutoValidado = .NULL.
238:     this_cUltimoValidarMoeVendaValidado = .NULL.
239:     this_cUltimoValidarDmoeVendaValidado = .NULL.
240: 
241: 
242:     *==========================================================================
243:     * Init - recebe o contexto do form PAI
244:     *
245:     * A ORDEM aqui e regra, nao estilo: FormBase.Init() chama
246:     * InicializarForm(), logo o contexto vindo por parametro tem de estar
247:     * guardado ANTES do DODEFAULT().
248:     *
249:     * par_oFormPai - form que abriu o dialogo (ParentForm do legado)
250:     *==========================================================================
251:     PROCEDURE Init(par_oFormPai)
252:         IF VARTYPE(par_oFormPai) = "O"
253:             THIS.this_oFormPai = par_oFormPai
254:         ENDIF
255: 
256:         RETURN DODEFAULT()
257:     ENDPROC
258: 
259: 
260:     *==========================================================================
261:     * InicializarForm - monta a estrutura base do dialogo
262:     *==========================================================================
263:     PROTECTED PROCEDURE InicializarForm()
264:         LOCAL loc_lSucesso, loc_oErro
265: 
266:         loc_lSucesso = .F.
267: 
268:         TRY
269:             THIS.this_oBusinessObject = CREATEOBJECT("sigopsepBO")
270: 
271:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
272:                 *-- Fundo do form (new_background.jpg do dump)
273:                 THIS.ConfigurarPageFrame()
274: 
275:                 *-- Cabecalho cinza (cntSombra do legado) - PRIMEIRO AddObject,
276:                 *-- para os controles das fases seguintes desenharem por cima
277:                 *-- (regra #11)
278:                 THIS.ConfigurarCabecalho()
279: 
280:                 *-- Fase 4: filtros + grade de LINHAS (ConfigurarPaginaLista)
281:                 *-- e grade de PRODUTOS + botoes de acao (ConfigurarPaginaDados)
282:                 THIS.ConfigurarPaginaLista()
283:                 THIS.ConfigurarPaginaDados()
284: 
285:                 *-- AddObject cria tudo com Visible = .F.
286:                 THIS.TornarControlesVisiveis()
287: 
288:                 *-- Replica o fecho do SIGOPSEP.Init: popula CsSigCdLin
289:                 *-- (cursor_4c_Linhas), cria CsSigCdPro (cursor_4c_Produtos)
290:                 *-- vazio e liga as DUAS grades. Entra so aqui, depois de
291:                 *-- TornarControlesVisiveis, porque RecordSource/ControlSource
292:                 *-- exigem o cursor ja criado (regra #41) e o CheckBox das
293:                 *-- colunas de marcacao exige o bind feito (ver CarregarLinhas).
294:                 *-- As duas cargas sao independentes: a falha da primeira nao
295:                 *-- deve mascarar o resultado da segunda, por isso o AND vem
296:                 *-- depois das duas chamadas, nao em curto-circuito.
297:                 loc_lSucesso = THIS.CarregarLinhas()
298:                 loc_lSucesso = THIS.CarregarDados() AND loc_lSucesso
299:             ELSE
300:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
301:                         "vel criar o objeto de neg" + CHR(243) + "cio sigopsepBO.", ;
302:                         "Erro ao Inicializar")
303:             ENDIF
304: 
305:         CATCH TO loc_oErro
306:             THIS.this_cMensagemErro = loc_oErro.Message
307:             MsgErro(loc_oErro.Message + ;
308:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
309:                     " | Proc: " + loc_oErro.Procedure, ;
310:                     "Erro ao inicializar Formsigopsep")
311:             loc_lSucesso = .F.
312:         ENDTRY
313: 
314:         RETURN loc_lSucesso
315:     ENDPROC
316: 
317: 
318:     *==========================================================================
319:     * ConfigurarPageFrame - aparencia base do form
320:     *
321:     * O nome e o do contrato do pipeline; NAO ha PageFrame a criar porque o
322:     * SCX legado nao tem Page nenhuma (layout FLAT - ver cabecalho). Picture
323:     * do dump: ..\framework\imagens\new_background.jpg - o caminho NUNCA se
324:     * reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o arquivo
325:     * existe tanto em vbmp\ quanto em Framework\imagens\, e o canonico do
326:     * projeto e gc_4c_CaminhoIcones.
327:     *==========================================================================
328:     PROTECTED PROCEDURE ConfigurarPageFrame()
329:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
330:         THIS.ScrollBars = 0
331: 
332:         RETURN .T.
333:     ENDPROC
334: 
335: 
336:     *==========================================================================
337:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
338:     *
339:     * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
340:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
341:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
342:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
343:     *
344:     * As larguras 800/769 do dump batem com o Width do form (800), entao nao
345:     * ha o artefato do Form Designer visto em outros dumps (container maior
346:     * que o form) - mesmo assim o container e os labels acompanham
347:     * THIS.Width, nunca o literal, para nao quebrar se o Width mudar.
348:     *==========================================================================
349:     PROTECTED PROCEDURE ConfigurarCabecalho()
350:         THIS.AddObject("cnt_4c_Sombra", "Container")
351:         WITH THIS.cnt_4c_Sombra
352:             .Top           = 0
353:             .Left          = 0
354:             .Width         = THIS.Width
355:             .Height        = 80
356:             .BorderWidth   = 0
357:             .BackStyle     = 1
358:             .BackColor     = RGB(100, 100, 100)
359:             .SpecialEffect = 0
360:             .Visible       = .T.
361:         ENDWITH
362: 
363:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
364:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
365:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
366:             *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
367:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
368:             *-- corta o texto (regra #23).
369:             .AutoSize      = .F.
370:             .FontName      = "Tahoma"
371:             .FontSize      = 18
372:             .FontBold      = .T.
373:             .FontUnderline = .F.
374:             .WordWrap      = .T.
375:             .Alignment     = 0
376:             .BackStyle     = 0
377:             .Caption       = THIS.Caption
378:             .Top           = 18
379:             .Left          = 10
380:             .Width         = THIS.Width - 20
381:             .Height        = 40
382:             .ForeColor     = RGB(0, 0, 0)
383:             .Visible       = .T.
384:         ENDWITH
385: 
386:         *-- Label do titulo: branco sobre o cinza do container OPACO - este
387:         *-- e o caso em que o branco esta CORRETO (regra #12)
388:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
389:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo

*-- Linhas 428 a 482:
428:     * explicita que caiba o texto (regra #23/#12). AutoSize=.T. NAO entra:
429:     * eh no-op em Label criado por AddObject.
430:     *
431:     * obj_4c_Situacao (Opc_situacao): OptionGroup com ControlSource
432:     * NUMERICO - Value = INDICE do botao (1=Ativos, 2=Inativos, 3=Todos),
433:     * NUNCA 0/1 (regra #45/#188). Legenda/ordem/Top de cada botao
434:     * transcritos do dump, nunca inventados.
435:     *
436:     * grd_4c_Linhas: estrutura so (ColumnCount, fontes, larguras, headers);
437:     * ControlSource e RecordSource ficam para CarregarLinhas(), chamado
438:     * depois de TornarControlesVisiveis() em InicializarForm - atribuir
439:     * ControlSource contra cursor_4c_Linhas aqui derrubaria o Init, porque
440:     * o cursor ainda nao existe (regra #41).
441:     *==========================================================================
442:     PROTECTED PROCEDURE ConfigurarPaginaLista()
443:         THIS.AddObject("cnt_4c_Filtro", "Container")
444:         WITH THIS.cnt_4c_Filtro
445:             .Top           = 130
446:             .Left          = 62
447:             .Width         = 656
448:             .Height        = 182
449:             .BackStyle     = 0
450:             .BorderWidth   = 0
451:             .SpecialEffect = 2
452:             .Visible       = .T.
453:         ENDWITH
454: 
455:         *-- Labels (Say1..Say7 do legado)
456:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label1", "Label")
457:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label1
458:             .Caption   = "Grupo Venda :"
459:             .Top       = 9
460:             .Left      = 36
461:             .Width     = 69
462:             .Height    = 17
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .Alignment = 0
466:             .BackStyle = 0
467:             .AutoSize  = .F.
468:             .ForeColor = RGB(90, 90, 90)
469:             .Visible   = .T.
470:         ENDWITH
471: 
472:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label2", "Label")
473:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label2
474:             .Caption   = "Moeda Venda :"
475:             .Top       = 57
476:             .Left      = 33
477:             .Width     = 72
478:             .Height    = 17
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .Alignment = 0
482:             .BackStyle = 0

*-- Linhas 579 a 732:
579:             .Value     = ""
580:             .Visible   = .T.
581:         ENDWITH
582:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "LostFocus", THIS, "ValidarGrVenda")
583:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "InteractiveChange", THIS, "FiltroAlterado")
584: 
585:         *-- Get_DgrVenda do legado NAO eh ReadOnly: o When so permite foco
586:         *-- quando txt_4c_GrVenda esta vazio (mutua exclusao), e o Valid faz o
587:         *-- lookup reverso por descricao (colecoes.descs)
588:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrVenda", "TextBox")
589:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrVenda
590:             .Top       = 6
591:             .Left      = 189
592:             .Width     = 366
593:             .Height    = 23
594:             .MaxLength = 40
595:             .ForeColor = RGB(0, 0, 0)
596:             .TabIndex  = 2
597:             .Value     = ""
598:             .Visible   = .T.
599:         ENDWITH
600:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "When",      THIS, "DgrVendaWhenCheck")
601:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "LostFocus", THIS, "ValidarDgrVenda")
602:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "InteractiveChange", THIS, "FiltroAlterado")
603: 
604:         *-- Grupo de Produto: codigo + descricao, lookup SigCdGrp (cgrus/dgrus)
605:         THIS.cnt_4c_Filtro.AddObject("txt_4c_GrProduto", "TextBox")
606:         WITH THIS.cnt_4c_Filtro.txt_4c_GrProduto
607:             .Top       = 30
608:             .Left      = 109
609:             .Width     = 31
610:             .MaxLength = 3
611:             .ForeColor = RGB(0, 0, 0)
612:             .TabIndex  = 3
613:             .Value     = ""
614:             .Visible   = .T.
615:         ENDWITH
616:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "LostFocus", THIS, "ValidarGrProduto")
617:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "InteractiveChange", THIS, "FiltroAlterado")
618: 
619:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrProduto", "TextBox")
620:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrProduto
621:             .Top       = 30
622:             .Left      = 140
623:             .Width     = 150
624:             .MaxLength = 20
625:             .ForeColor = RGB(0, 0, 0)
626:             .TabIndex  = 4
627:             .Value     = ""
628:             .Visible   = .T.
629:         ENDWITH
630:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "When",      THIS, "DgrProdutoWhenCheck")
631:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "LostFocus", THIS, "ValidarDgrProduto")
632:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "InteractiveChange", THIS, "FiltroAlterado")
633: 
634:         *-- Arredondamento (InputMask "9.9" do dump - regra #49)
635:         THIS.cnt_4c_Filtro.AddObject("txt_4c_Arrend", "TextBox")
636:         WITH THIS.cnt_4c_Filtro.txt_4c_Arrend
637:             .Top       = 30
638:             .Left      = 524
639:             .Width     = 31
640:             .MaxLength = 3
641:             .InputMask = "9.9"
642:             .TabIndex  = 5
643:             .Value     = 0
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         *-- Moeda de Venda: codigo + descricao, lookup SigCdMoe (cmoes/dmoes)
648:         THIS.cnt_4c_Filtro.AddObject("txt_4c_MoeVenda", "TextBox")
649:         WITH THIS.cnt_4c_Filtro.txt_4c_MoeVenda
650:             .Top       = 54
651:             .Left      = 109
652:             .Width     = 31
653:             .MaxLength = 3
654:             .ForeColor = RGB(0, 0, 0)
655:             .TabIndex  = 6
656:             .Value     = ""
657:             .Visible   = .T.
658:         ENDWITH
659:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "LostFocus", THIS, "ValidarMoeVenda")
660:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "InteractiveChange", THIS, "FiltroAlterado")
661: 
662:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DmoeVenda", "TextBox")
663:         WITH THIS.cnt_4c_Filtro.txt_4c_DmoeVenda
664:             .Top       = 54
665:             .Left      = 140
666:             .Width     = 115
667:             .MaxLength = 15
668:             .ForeColor = RGB(0, 0, 0)
669:             .TabIndex  = 7
670:             .Value     = ""
671:             .Visible   = .T.
672:         ENDWITH
673:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "When",      THIS, "DmoeVendaWhenCheck")
674:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "LostFocus", THIS, "ValidarDmoeVenda")
675:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "InteractiveChange", THIS, "FiltroAlterado")
676: 
677:         *-- Acrescimo/Desconto percentual (InputMask "9999" do dump)
678:         THIS.cnt_4c_Filtro.AddObject("txt_4c_AcreDesc", "TextBox")
679:         WITH THIS.cnt_4c_Filtro.txt_4c_AcreDesc
680:             .Top       = 54
681:             .Left      = 503
682:             .Width     = 38
683:             .MaxLength = 4
684:             .InputMask = "9999"
685:             .TabIndex  = 8
686:             .Value     = 0
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Situacao (Opc_situacao do legado) - Value = indice do botao
691:         *-- (1=Ativos, 2=Inativos, 3=Todos), transcrito do dump
692:         THIS.cnt_4c_Filtro.AddObject("obj_4c_Situacao", "OptionGroup")
693:         WITH THIS.cnt_4c_Filtro.obj_4c_Situacao
694:             .Top         = 6
695:             .Left        = 569
696:             .Width       = 79
697:             .Height      = 69
698:             .ButtonCount = 3
699:             .BackStyle   = 0
700:             .TabIndex    = 9
701:             .Value       = 1
702:             .Visible     = .T.
703: 
704:             WITH .Buttons(1)
705:                 .FontName  = "Tahoma"
706:                 .Caption   = "\<Ativos"
707:                 .Left      = 10
708:                 .Top       = 5
709:                 .BackStyle = 0
710:                 .ForeColor = RGB(90, 90, 90)
711:             ENDWITH
712: 
713:             WITH .Buttons(2)
714:                 .FontName  = "Tahoma"
715:                 .Caption   = "\<Inativos"
716:                 .Left      = 10
717:                 .Top       = 26
718:                 .BackStyle = 0
719:                 .ForeColor = RGB(90, 90, 90)
720:             ENDWITH
721: 
722:             WITH .Buttons(3)
723:                 .FontName  = "Tahoma"
724:                 .FontSize  = 8
725:                 .BackStyle = 0
726:                 .Caption   = "\<Todos"
727:                 .Height    = 15
728:                 .Left      = 10
729:                 .Top       = 47
730:                 .Width     = 47
731:                 .ForeColor = RGB(90, 90, 90)
732:             ENDWITH

*-- Linhas 813 a 905:
813:             .Themes          = .T.
814:             .Visible         = .T.
815:         ENDWITH
816:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Marcar, "Click", THIS, "BtnMarcarClick")
817: 
818:         THIS.cnt_4c_Filtro.AddObject("cmd_4c_Desmarcar", "CommandButton")
819:         WITH THIS.cnt_4c_Filtro.cmd_4c_Desmarcar
820:             .Top             = 128
821:             .Left            = 573
822:             .Width           = 40
823:             .Height          = 40
824:             .Caption         = ""
825:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
826:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
827:             .FontName        = "Comic Sans MS"
828:             .FontSize        = 8
829:             .FontBold        = .T.
830:             .FontItalic      = .T.
831:             .WordWrap        = .T.
832:             .MousePointer    = 15
833:             .ForeColor       = RGB(90, 90, 90)
834:             .BackColor       = RGB(255, 255, 255)
835:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
836:             .Themes          = .T.
837:             .Visible         = .T.
838:         ENDWITH
839:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")
840: 
841:         RETURN .T.
842:     ENDPROC
843: 
844: 
845:     *==========================================================================
846:     * CarregarLinhas - FUNIL de carga da grade de Linhas (GradeLinhas)
847:     *
848:     * Replica o trecho do SIGOPSEP.Init que popula CsSigCdLin e liga a grade.
849:     * A ORDEM aqui e regra medida, nao estilo:
850:     *   RecordSource -> ControlSource de TODAS as colunas -> Column.AddObject
851:     *   do CheckBox + .Value = 0 -> Sparse = .F. + CurrentControl -> Width /
852:     *   Header1.Caption.
853:     * Motivos: (a) atribuir ControlSource antes do cursor existir estoura
854:     * "Alias not found" dentro do TRY do InicializarForm e a tela nao abre
855:     * (regra #41); (b) Grid sem RecordSource AUTO-BINDA na area de trabalho
856:     * CORRENTE quando o ColumnCount e definido, e um AddObject de CheckBox
857:     * sobre coluna de texto estoura "Data type mismatch" - por isso o CheckBox
858:     * e instalado AQUI, depois do bind, e nao em ConfigurarPaginaLista;
859:     * (c) BuscarLinhas faz USE IN no alias, o que DESTROI o controle posto por
860:     * Column.AddObject (CurrentControl volta a "Text1") preservando
861:     * ColumnCount/Width/Header - perda PARCIAL e silenciosa, por isso a
862:     * instalacao e reentrante; (d) RecordSource reseta Width/Header1.Caption
863:     * para o default (Problema 48), que tem de ser reaplicados DEPOIS do bind.
864:     *==========================================================================
865:     PROTECTED PROCEDURE CarregarLinhas()
866:         LOCAL loc_oGrid
867: 
868:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
869:             RETURN .F.
870:         ENDIF
871: 
872:         IF !THIS.this_oBusinessObject.BuscarLinhas()
873:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
874:                     NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
875:                     "Falha na Conex" + CHR(227) + "o")
876:             RETURN .F.
877:         ENDIF
878: 
879:         loc_oGrid = THIS.cnt_4c_Filtro.grd_4c_Linhas
880: 
881:         loc_oGrid.RecordSource = ""
882:         loc_oGrid.ColumnCount = 3
883:         loc_oGrid.RecordSource = "cursor_4c_Linhas"
884:         loc_oGrid.Column1.ControlSource = "cursor_4c_Linhas.lMarcas"
885:         loc_oGrid.Column2.ControlSource = "cursor_4c_Linhas.linhas"
886:         loc_oGrid.Column3.ControlSource = "cursor_4c_Linhas.descs"
887: 
888:         *-- Column1.Check1 do dump: a coluna de marcacao das Linhas
889:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaLinha")
890: 
891:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
892:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
893:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
894:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
895:         THIS.FormatarGridLista(loc_oGrid)
896: 
897:         *-- RecordSource reseta Width/Header1.Caption para o default, e a
898:         *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
899:         *-- (Problema 48). Header1: Tahoma 8 em todas, Alignment 2 nas de
900:         *-- texto, como no dump de GradeLinhas.
901:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, -1)
902:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 120, ;
903:             "C" + CHR(243) + "digo", 2, -1)
904:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 290, ;
905:             "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, -1)

*-- Linhas 913 a 1355:
913: 
914: 
915:     *==========================================================================
916:     * FiltroAlterado - InteractiveChange dos 6 campos de cnt_4c_Filtro (os 3
917:     * pares codigo/descricao: GrVenda/DgrVenda, GrProduto/DgrProduto,
918:     * MoeVenda/DmoeVenda). Legado: as SEIS propriedades InteractiveChange do
919:     * SCX fazem so "ThisForm.CopiaLista.Enabled = .F." - qualquer alteracao
920:     * no filtro, pelo codigo OU pela descricao, invalida a selecao de
921:     * produtos ja feita.
922:     *==========================================================================
923:     PROCEDURE FiltroAlterado()
924:         THIS.cmd_4c_CopiaLista.Enabled = .F.
925:     ENDPROC
926: 
927: 
928:     *==========================================================================
929:     * Lookups de cnt_4c_Filtro (fase 6/8) - 3 pares codigo/descricao, cada um
930:     * nos DOIS sentidos, transcritos de Get_grVenda/Get_DgrVenda,
931:     * Get_grProduto/Get_DgrProduto e Get_moevenda/Get_Dmoevenda.
932:     *
933:     * Padrao (igual nos 3 pares):
934:     *   - campo CODIGO: Valid do legado sem When - sempre editavel. Vazio
935:     *     limpa so a descricao (This.Parent.Get_DX.Value = ''); preenchido,
936:     *     faz SEEK exato e abre o picker so se nao achou (contrato
937:     *     this_lAchouRegistro - regra #37); ESC/cancelamento LIMPA os DOIS
938:     *     campos (LastKey()<>27 And Used(...) no legado) - diferente da
939:     *     regra #50 (que veda apagar o digitado quando NAO ha picker): aqui
940:     *     o picker SEMPRE abre antes de limpar, e o proprio legado manda
941:     *     limpar no cancelamento.
942:     *   - campo DESCRICAO: so recebe foco quando o campo CODIGO irmao esta
943:     *     vazio (When = Return(Empty(Parent.Get_X.Value)), mutua exclusao -
944:     *     BINDEVENT "When" compartilha o retorno com o nativo). Mesmo
945:     *     contrato do lookup, buscando pela coluna de DESCRICAO.
946:     *
947:     * Guarda this_lEmLookup: o picker eh MODAL e tira o foco do campo, o que
948:     * redispara o proprio LostFocus (regra #37) - compartilhada entre os 3
949:     * pares, igual ao padrao de FormCco.
950:     *==========================================================================
951: 
952:     *--------------------------------------------------------------------------
953:     * Par 1: Grupo de Venda <-> Descricao (SigCdCol: colecoes/descs)
954:     *--------------------------------------------------------------------------
955:     PROCEDURE DgrVendaWhenCheck()
956:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value))
957:     ENDPROC
958: 
959:     PROCEDURE ValidarGrVenda()
960:         LOCAL loc_cValor
961: 
962:         IF THIS.this_lEmLookup
963:             RETURN
964:         ENDIF
965: 
966:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
967: 
968:         IF VARTYPE(THIS.this_cUltimoValidarGrVendaValidado) == "C" AND ;
969:                 loc_cValor == THIS.this_cUltimoValidarGrVendaValidado
970:             RETURN
971:         ENDIF
972: 
973:         IF EMPTY(loc_cValor)
974:             THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
975:         ELSE
976:             THIS.AbrirBuscaGrVenda()
977:         ENDIF
978: 
979:         THIS.this_cUltimoValidarGrVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
980:     ENDPROC
981: 
982:     PROCEDURE ValidarDgrVenda()
983:         LOCAL loc_cValor
984: 
985:         IF THIS.this_lEmLookup
986:             RETURN
987:         ENDIF
988: 
989:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
990: 
991:         IF VARTYPE(THIS.this_cUltimoValidarDgrVendaValidado) == "C" AND ;
992:                 loc_cValor == THIS.this_cUltimoValidarDgrVendaValidado
993:             RETURN
994:         ENDIF
995: 
996:         IF EMPTY(loc_cValor)
997:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value = ""
998:         ELSE
999:             THIS.AbrirBuscaDgrVenda()
1000:         ENDIF
1001: 
1002:         THIS.this_cUltimoValidarDgrVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
1003:     ENDPROC
1004: 
1005:     PROTECTED PROCEDURE AbrirBuscaGrVenda()
1006:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1007: 
1008:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
1009: 
1010:         THIS.this_lEmLookup = .T.
1011:         TRY
1012:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1013:                 "SigCdCol", "cursor_4c_BuscaColecoes", "colecoes", loc_cValor, ;
1014:                 "Cole" + CHR(231) + CHR(245) + "es")
1015: 
1016:             IF VARTYPE(loc_oBusca) = "O"
1017:                 IF !loc_oBusca.this_lAchouRegistro
1018:                     loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1019:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1020:                     loc_oBusca.Show()
1021:                 ENDIF
1022: 
1023:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
1024:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
1025:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
1026:                 ELSE
1027:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
1028:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
1029:                 ENDIF
1030: 
1031:                 loc_oBusca.Release()
1032:             ENDIF
1033:         CATCH TO loc_oErro
1034:             MsgErro("Erro em Formsigopsep.AbrirBuscaGrVenda: " + loc_oErro.Message, "Erro")
1035:         ENDTRY
1036:         THIS.this_lEmLookup = .F.
1037: 
1038:         IF USED("cursor_4c_BuscaColecoes")
1039:             USE IN cursor_4c_BuscaColecoes
1040:         ENDIF
1041:     ENDPROC
1042: 
1043:     PROTECTED PROCEDURE AbrirBuscaDgrVenda()
1044:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1045: 
1046:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
1047: 
1048:         THIS.this_lEmLookup = .T.
1049:         TRY
1050:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1051:                 "SigCdCol", "cursor_4c_BuscaColecoes", "descs", loc_cValor, ;
1052:                 "Cole" + CHR(231) + CHR(245) + "es")
1053: 
1054:             IF VARTYPE(loc_oBusca) = "O"
1055:                 IF !loc_oBusca.this_lAchouRegistro
1056:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1057:                     loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1058:                     loc_oBusca.Show()
1059:                 ENDIF
1060: 
1061:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
1062:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
1063:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
1064:                 ELSE
1065:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
1066:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
1067:                 ENDIF
1068: 
1069:                 loc_oBusca.Release()
1070:             ENDIF
1071:         CATCH TO loc_oErro
1072:             MsgErro("Erro em Formsigopsep.AbrirBuscaDgrVenda: " + loc_oErro.Message, "Erro")
1073:         ENDTRY
1074:         THIS.this_lEmLookup = .F.
1075: 
1076:         IF USED("cursor_4c_BuscaColecoes")
1077:             USE IN cursor_4c_BuscaColecoes
1078:         ENDIF
1079:     ENDPROC
1080: 
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * Par 2: Grupo de Produto <-> Descricao (SigCdGrp: cgrus/dgrus)
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE DgrProdutoWhenCheck()
1086:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value))
1087:     ENDPROC
1088: 
1089:     PROCEDURE ValidarGrProduto()
1090:         LOCAL loc_cValor
1091: 
1092:         IF THIS.this_lEmLookup
1093:             RETURN
1094:         ENDIF
1095: 
1096:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
1097: 
1098:         IF VARTYPE(THIS.this_cUltimoValidarGrProdutoValidado) == "C" AND ;
1099:                 loc_cValor == THIS.this_cUltimoValidarGrProdutoValidado
1100:             RETURN
1101:         ENDIF
1102: 
1103:         IF EMPTY(loc_cValor)
1104:             THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1105:         ELSE
1106:             THIS.AbrirBuscaGrProduto()
1107:         ENDIF
1108: 
1109:         THIS.this_cUltimoValidarGrProdutoValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
1110:     ENDPROC
1111: 
1112:     PROCEDURE ValidarDgrProduto()
1113:         LOCAL loc_cValor
1114: 
1115:         IF THIS.this_lEmLookup
1116:             RETURN
1117:         ENDIF
1118: 
1119:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
1120: 
1121:         IF VARTYPE(THIS.this_cUltimoValidarDgrProdutoValidado) == "C" AND ;
1122:                 loc_cValor == THIS.this_cUltimoValidarDgrProdutoValidado
1123:             RETURN
1124:         ENDIF
1125: 
1126:         IF EMPTY(loc_cValor)
1127:             THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value = ""
1128:         ELSE
1129:             THIS.AbrirBuscaDgrProduto()
1130:         ENDIF
1131: 
1132:         THIS.this_cUltimoValidarDgrProdutoValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
1133:     ENDPROC
1134: 
1135:     PROTECTED PROCEDURE AbrirBuscaGrProduto()
1136:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1137: 
1138:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
1139: 
1140:         THIS.this_lEmLookup = .T.
1141:         TRY
1142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1143:                 "SigCdGrp", "cursor_4c_BuscaGrupos", "cgrus", loc_cValor, ;
1144:                 "Sele" + CHR(231) + CHR(227) + "o")
1145: 
1146:             IF VARTYPE(loc_oBusca) = "O"
1147:                 IF !loc_oBusca.this_lAchouRegistro
1148:                     loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
1149:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1150:                     loc_oBusca.Show()
1151:                 ENDIF
1152: 
1153:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1154:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
1155:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
1156:                 ELSE
1157:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
1158:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1159:                 ENDIF
1160: 
1161:                 loc_oBusca.Release()
1162:             ENDIF
1163:         CATCH TO loc_oErro
1164:             MsgErro("Erro em Formsigopsep.AbrirBuscaGrProduto: " + loc_oErro.Message, "Erro")
1165:         ENDTRY
1166:         THIS.this_lEmLookup = .F.
1167: 
1168:         IF USED("cursor_4c_BuscaGrupos")
1169:             USE IN cursor_4c_BuscaGrupos
1170:         ENDIF
1171:     ENDPROC
1172: 
1173:     PROTECTED PROCEDURE AbrirBuscaDgrProduto()
1174:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1175: 
1176:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
1177: 
1178:         THIS.this_lEmLookup = .T.
1179:         TRY
1180:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1181:                 "SigCdGrp", "cursor_4c_BuscaGrupos", "dgrus", loc_cValor, ;
1182:                 "Sele" + CHR(231) + CHR(227) + "o")
1183: 
1184:             IF VARTYPE(loc_oBusca) = "O"
1185:                 IF !loc_oBusca.this_lAchouRegistro
1186:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1187:                     loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
1188:                     loc_oBusca.Show()
1189:                 ENDIF
1190: 
1191:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1192:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
1193:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
1194:                 ELSE
1195:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1196:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
1197:                 ENDIF
1198: 
1199:                 loc_oBusca.Release()
1200:             ENDIF
1201:         CATCH TO loc_oErro
1202:             MsgErro("Erro em Formsigopsep.AbrirBuscaDgrProduto: " + loc_oErro.Message, "Erro")
1203:         ENDTRY
1204:         THIS.this_lEmLookup = .F.
1205: 
1206:         IF USED("cursor_4c_BuscaGrupos")
1207:             USE IN cursor_4c_BuscaGrupos
1208:         ENDIF
1209:     ENDPROC
1210: 
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * Par 3: Moeda de Venda <-> Descricao (SigCdMoe: cmoes/dmoes)
1214:     *
1215:     * Unica assimetria do trio: Get_Dmoevenda.Valid do legado NAO tem o ramo
1216:     * "If Empty(This.Value) / Parent.Get_MoeVenda.Value = ''" que os outros
1217:     * dois pares tem - so entra no bloco de lookup quando !Empty(This.Value).
1218:     * Com o campo vazio, o codigo e simplesmente IGNORADO (o When ja garante
1219:     * que so se chega aqui com o codigo vazio de qualquer forma). Transcrito
1220:     * literalmente: ValidarDmoeVenda NAO limpa txt_4c_MoeVenda no ramo vazio.
1221:     *--------------------------------------------------------------------------
1222:     PROCEDURE DmoeVendaWhenCheck()
1223:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value))
1224:     ENDPROC
1225: 
1226:     PROCEDURE ValidarMoeVenda()
1227:         LOCAL loc_cValor
1228: 
1229:         IF THIS.this_lEmLookup
1230:             RETURN
1231:         ENDIF
1232: 
1233:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
1234: 
1235:         IF VARTYPE(THIS.this_cUltimoValidarMoeVendaValidado) == "C" AND ;
1236:                 loc_cValor == THIS.this_cUltimoValidarMoeVendaValidado
1237:             RETURN
1238:         ENDIF
1239: 
1240:         IF EMPTY(loc_cValor)
1241:             THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1242:         ELSE
1243:             THIS.AbrirBuscaMoeVenda()
1244:         ENDIF
1245: 
1246:         THIS.this_cUltimoValidarMoeVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
1247:     ENDPROC
1248: 
1249:     PROCEDURE ValidarDmoeVenda()
1250:         LOCAL loc_cValor
1251: 
1252:         IF THIS.this_lEmLookup
1253:             RETURN
1254:         ENDIF
1255: 
1256:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
1257: 
1258:         IF VARTYPE(THIS.this_cUltimoValidarDmoeVendaValidado) == "C" AND ;
1259:                 loc_cValor == THIS.this_cUltimoValidarDmoeVendaValidado
1260:             RETURN
1261:         ENDIF
1262: 
1263:         IF !EMPTY(loc_cValor)
1264:             THIS.AbrirBuscaDmoeVenda()
1265:         ENDIF
1266: 
1267:         THIS.this_cUltimoValidarDmoeVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
1268:     ENDPROC
1269: 
1270:     PROTECTED PROCEDURE AbrirBuscaMoeVenda()
1271:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1272: 
1273:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
1274: 
1275:         THIS.this_lEmLookup = .T.
1276:         TRY
1277:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1278:                 "SigCdMoe", "cursor_4c_BuscaMoedas", "cmoes", loc_cValor, ;
1279:                 "Sele" + CHR(231) + CHR(227) + "o")
1280: 
1281:             IF VARTYPE(loc_oBusca) = "O"
1282:                 IF !loc_oBusca.this_lAchouRegistro
1283:                     loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
1284:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1285:                     loc_oBusca.Show()
1286:                 ENDIF
1287: 
1288:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
1289:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
1290:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
1291:                 ELSE
1292:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
1293:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1294:                 ENDIF
1295: 
1296:                 loc_oBusca.Release()
1297:             ENDIF
1298:         CATCH TO loc_oErro
1299:             MsgErro("Erro em Formsigopsep.AbrirBuscaMoeVenda: " + loc_oErro.Message, "Erro")
1300:         ENDTRY
1301:         THIS.this_lEmLookup = .F.
1302: 
1303:         IF USED("cursor_4c_BuscaMoedas")
1304:             USE IN cursor_4c_BuscaMoedas
1305:         ENDIF
1306:     ENDPROC
1307: 
1308:     PROTECTED PROCEDURE AbrirBuscaDmoeVenda()
1309:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1310: 
1311:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
1312: 
1313:         THIS.this_lEmLookup = .T.
1314:         TRY
1315:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1316:                 "SigCdMoe", "cursor_4c_BuscaMoedas", "dmoes", loc_cValor, ;
1317:                 "Sele" + CHR(231) + CHR(227) + "o")
1318: 
1319:             IF VARTYPE(loc_oBusca) = "O"
1320:                 IF !loc_oBusca.this_lAchouRegistro
1321:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1322:                     loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
1323:                     loc_oBusca.Show()
1324:                 ENDIF
1325: 
1326:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
1327:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
1328:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
1329:                 ELSE
1330:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1331:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
1332:                 ENDIF
1333: 
1334:                 loc_oBusca.Release()
1335:             ENDIF
1336:         CATCH TO loc_oErro
1337:             MsgErro("Erro em Formsigopsep.AbrirBuscaDmoeVenda: " + loc_oErro.Message, "Erro")
1338:         ENDTRY
1339:         THIS.this_lEmLookup = .F.
1340: 
1341:         IF USED("cursor_4c_BuscaMoedas")
1342:             USE IN cursor_4c_BuscaMoedas
1343:         ENDIF
1344:     ENDPROC
1345: 
1346: 
1347:     *==========================================================================
1348:     * ConfigurarPaginaDados - grade de PRODUTOS + botoes de acao
1349:     *
1350:     * O nome vem do contrato do pipeline; nao ha Page a configurar (layout
1351:     * FLAT - ver cabecalho). Aqui entram os objetos que o dump declara direto
1352:     * na Form: GradeItens (grd_4c_Itens) e os cinco CommandButton de acao
1353:     * (Sair/CopiaLista/Processar/cmdMarcaProd/cmdDesmarcaProd).
1354:     *
1355:     * APENAS a estrutura da grade (ColumnCount, fontes, larguras, headers):

*-- Linhas 1371 a 1414:
1371:     * cmdMarcaProd/cmdDesmarcaProd sao fwbtnp (classe: 40x40), icone-only.
1372:     * Picture: todos TRANSCRITOS do dump (regra #25), conferidos em vbmp\.
1373:     *==========================================================================
1374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1375:         *----------------------------------------------------------------------
1376:         * GradeItens -> grd_4c_Itens (dump: Top=316 Left=64 Width=673
1377:         * Height=130 ColumnCount=6 FontName="Courier New" TabIndex=2)
1378:         *
1379:         * RecordMark/DeleteMark nao sao declarados no dump desta grade (ao
1380:         * contrario de GradeLinhas, que declara RecordMark = .F.); ficam .F.
1381:         * por serem o canonico do projeto para grade de dados em OPERACIONAL.
1382:         *----------------------------------------------------------------------
1383:         THIS.AddObject("grd_4c_Itens", "Grid")
1384:         WITH THIS.grd_4c_Itens
1385:             .Top         = 316
1386:             .Left        = 64
1387:             .Width       = 673
1388:             .Height      = 130
1389:             .ColumnCount = 6
1390:             .FontName    = "Courier New"
1391:             .FontSize    = 9
1392:             .ReadOnly    = .F.
1393:             .RecordMark  = .F.
1394:             .DeleteMark  = .F.
1395:             .TabIndex    = 2
1396:             .Visible     = .T.
1397:         ENDWITH
1398: 
1399:         *-- Column1: marcacao (CheckBox). O ReadOnly da COLUNA vem DEPOIS do
1400:         *-- ReadOnly do GRID, que propaga e sobrescreveria (regra #18).
1401:         WITH THIS.grd_4c_Itens.Column1
1402:             .FontName          = "Courier New"
1403:             .Width             = 20
1404:             .Movable           = .F.
1405:             .Resizable         = .F.
1406:             .Sparse            = .F.
1407:             .ReadOnly          = .F.
1408:             .Visible           = .T.
1409:             .Header1.Caption   = ""
1410:             .Header1.FontName  = "Tahoma"
1411:             .Header1.FontSize  = 8
1412:             .Header1.ForeColor = RGB(0, 0, 0)
1413:         ENDWITH
1414: 

*-- Linhas 1548 a 1975:
1548:             .ToolTipText     = "Seleciona os Produtos Conforme os Filtros"
1549:             .Visible         = .T.
1550:         ENDWITH
1551:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1552: 
1553:         *-- Copia p/ Lista (dump: Top=3 Left=576, geral_pendencia_60.jpg,
1554:         *-- PicturePosition = 7)
1555:         THIS.AddObject("cmd_4c_CopiaLista", "CommandButton")
1556:         WITH THIS.cmd_4c_CopiaLista
1557:             .Top             = 3
1558:             .Left            = 576
1559:             .Width           = 75
1560:             .Height          = 75
1561:             .Caption         = "Copia p/ \<Lista"
1562:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1563:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1564:             .PicturePosition = 7
1565:             .FontName        = "Comic Sans MS"
1566:             .FontSize        = 8
1567:             .FontBold        = .T.
1568:             .FontItalic      = .T.
1569:             .WordWrap        = .T.
1570:             .AutoSize        = .F.
1571:             .MousePointer    = 15
1572:             .ForeColor       = RGB(90, 90, 90)
1573:             .BackColor       = RGB(255, 255, 255)
1574:             .Themes          = .T.
1575:             .ToolTipText     = "Copia os Produtos Marcados Para a Lista"
1576:             .Visible         = .T.
1577:         ENDWITH
1578:         BINDEVENT(THIS.cmd_4c_CopiaLista, "Click", THIS, "BtnCopiaListaClick")
1579: 
1580:         *-- Encerrar (Sair do dump: Top=3 Left=725, Cancel = .T. - e o botao
1581:         *-- que responde ao ESC; cadastro_sair_60.jpg)
1582:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1583:         WITH THIS.cmd_4c_Encerrar
1584:             .Top             = 3
1585:             .Left            = 725
1586:             .Width           = 75
1587:             .Height          = 75
1588:             .Caption         = "Encerrar"
1589:             .Cancel          = .T.
1590:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1591:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1592:             .FontName        = "Comic Sans MS"
1593:             .FontSize        = 8
1594:             .FontBold        = .T.
1595:             .FontItalic      = .T.
1596:             .WordWrap        = .T.
1597:             .AutoSize        = .F.
1598:             .MousePointer    = 15
1599:             .ForeColor       = RGB(90, 90, 90)
1600:             .BackColor       = RGB(255, 255, 255)
1601:             .Themes          = .T.
1602:             .ToolTipText     = "Encerra a Sele" + CHR(231) + CHR(227) + "o de Produtos"
1603:             .Visible         = .T.
1604:         ENDWITH
1605:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1606: 
1607:         *-- Marca / Desmarca TODOS os PRODUTOS (cmdMarcaProd/cmdDesmarcaProd
1608:         *-- do dump: Top=455, Left=626/666, fwbtnp 40x40, icone-only).
1609:         *-- Nomes distintos dos irmaos de cnt_4c_Filtro (cmd_4c_Marcar/
1610:         *-- cmd_4c_Desmarcar), que marcam LINHAS e nao PRODUTOS.
1611:         THIS.AddObject("cmd_4c_MarcaProd", "CommandButton")
1612:         WITH THIS.cmd_4c_MarcaProd
1613:             .Top             = 455
1614:             .Left            = 626
1615:             .Width           = 40
1616:             .Height          = 40
1617:             .Caption         = ""
1618:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1619:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1620:             .FontName        = "Comic Sans MS"
1621:             .FontSize        = 8
1622:             .FontBold        = .T.
1623:             .FontItalic      = .T.
1624:             .WordWrap        = .T.
1625:             .MousePointer    = 15
1626:             .ForeColor       = RGB(90, 90, 90)
1627:             .BackColor       = RGB(255, 255, 255)
1628:             .Themes          = .T.
1629:             .ToolTipText     = "Marca Todas as Linhas de Produto"
1630:             .Visible         = .T.
1631:         ENDWITH
1632:         BINDEVENT(THIS.cmd_4c_MarcaProd, "Click", THIS, "BtnMarcaProdClick")
1633: 
1634:         THIS.AddObject("cmd_4c_DesmarcaProd", "CommandButton")
1635:         WITH THIS.cmd_4c_DesmarcaProd
1636:             .Top             = 455
1637:             .Left            = 666
1638:             .Width           = 40
1639:             .Height          = 40
1640:             .Caption         = ""
1641:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
1642:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
1643:             .FontName        = "Comic Sans MS"
1644:             .FontSize        = 8
1645:             .FontBold        = .T.
1646:             .FontItalic      = .T.
1647:             .WordWrap        = .T.
1648:             .MousePointer    = 15
1649:             .ForeColor       = RGB(90, 90, 90)
1650:             .BackColor       = RGB(255, 255, 255)
1651:             .Themes          = .T.
1652:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
1653:             .Visible         = .T.
1654:         ENDWITH
1655:         BINDEVENT(THIS.cmd_4c_DesmarcaProd, "Click", THIS, "BtnDesmarcaProdClick")
1656: 
1657:         RETURN .T.
1658:     ENDPROC
1659: 
1660: 
1661:     *==========================================================================
1662:     * CarregarDados - FUNIL de carga da grade de Produtos (GradeItens)
1663:     *
1664:     * Replica o fecho do SIGOPSEP.Init: cria CsSigCdPro VAZIO, liga a grade,
1665:     * aplica o DynamicForeColor e deixa CopiaLista desabilitado (so Processar
1666:     * habilita, quando trouxer produtos).
1667:     *
1668:     * A estrutura do cursor mora UNICAMENTE no BO (CriarCursorProdutos):
1669:     * repetir o CREATE CURSOR aqui criaria duas versoes do mesmo cursor, e
1670:     * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
1671:     * ControlSource. Serve a toda repintura (aqui e, na fase de eventos, em
1672:     * Processar), pela mesma sequencia medida que CarregarLinhas documenta.
1673:     *==========================================================================
1674:     PROTECTED PROCEDURE CarregarDados()
1675:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1676:             RETURN .F.
1677:         ENDIF
1678: 
1679:         *-- Sem o cursor, atribuir ControlSource estoura "Alias not found"
1680:         *-- dentro do TRY do InicializarForm e a tela nao abre (regra #41)
1681:         THIS.this_oBusinessObject.CriarCursorProdutos()
1682: 
1683:         IF !THIS.ReligarGradeItens()
1684:             RETURN .F.
1685:         ENDIF
1686: 
1687:         *-- SIGOPSEP.Init termina com CopiaLista.Enabled = .F.
1688:         THIS.cmd_4c_CopiaLista.Enabled = .F.
1689: 
1690:         RETURN .T.
1691:     ENDPROC
1692: 
1693: 
1694:     *==========================================================================
1695:     * ReligarGradeItens - (re)liga grd_4c_Itens a cursor_4c_Produtos
1696:     *
1697:     * Fatorado de CarregarDados (Fase 4) porque BO.BuscarProdutos (Fase 7,
1698:     * usado em BtnProcessarClick) RECRIA cursor_4c_Produtos (USE IN +
1699:     * CREATE CURSOR, via CriarCursorProdutos) para popula-lo com dados
1700:     * reais - a MESMA razao, ja documentada em InstalarCheckBoxColuna, pela
1701:     * qual fechar/recriar o alias do RecordSource destroi o CheckBox posto
1702:     * por Column.AddObject. Por isso o bind tem de ser refeito do ZERO
1703:     * depois de QUALQUER recriacao do cursor, nao so na carga inicial.
1704:     *==========================================================================
1705:     PROTECTED PROCEDURE ReligarGradeItens()
1706:         LOCAL loc_oGrid
1707: 
1708:         IF !USED("cursor_4c_Produtos")
1709:             RETURN .F.
1710:         ENDIF
1711: 
1712:         loc_oGrid = THIS.grd_4c_Itens
1713: 
1714:         loc_oGrid.RecordSource = ""
1715:         loc_oGrid.ColumnCount = 6
1716:         loc_oGrid.RecordSource = "cursor_4c_Produtos"
1717:         loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.flagctabs"
1718:         loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.cpros"
1719:         loc_oGrid.Column3.ControlSource = "cursor_4c_Produtos.dpros"
1720:         loc_oGrid.Column4.ControlSource = "cursor_4c_Produtos.pvens"
1721:         loc_oGrid.Column5.ControlSource = "cursor_4c_Produtos.moevs"
1722:         loc_oGrid.Column6.ControlSource = "cursor_4c_Produtos.pliqs"
1723: 
1724:         *-- Column1.Check1 do dump: a coluna de marcacao dos Produtos. O
1725:         *-- objeto acabou de nascer de novo (RecordSource acima destruiu o
1726:         *-- anterior) - religar o When (GradeItens.Column1.Check1.When do
1727:         *-- legado: "Return(CsSigCdPro.lMarcas = 0)") no objeto NOVO.
1728:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaProduto")
1729:         BINDEVENT(loc_oGrid.Column1.chk_4c_MarcaProduto, "When", THIS, "WhenMarcaProduto")
1730: 
1731:         *-- DynamicForeColor do legado: azul no produto que JA esta na lista de
1732:         *-- precos do form pai (lMarcas = 1), preto nos demais. Transcrito do
1733:         *-- SIGOPSEP.Init, com o nome do cursor migrado.
1734:         loc_oGrid.SetAll("DynamicForeColor", ;
1735:             "RGB(0,0,IIF(cursor_4c_Produtos.lMarcas = 0,0,255))", "Column")
1736: 
1737:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
1738:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
1739:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
1740:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
1741:         THIS.FormatarGridLista(loc_oGrid)
1742: 
1743:         *-- RecordSource reseta Width/Header1.Caption para o default, e a
1744:         *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
1745:         *-- (Problema 48). Header1 de GradeItens no dump: Tahoma 8,
1746:         *-- Alignment 2 nas colunas de texto, ForeColor 0,0,0 em todas MENOS
1747:         *-- a de Preco de Venda (C), que o legado pinta de 36,84,155.
1748:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, RGB(0, 0, 0))
1749:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 108, ;
1750:             "C" + CHR(243) + "digo Produto", 2, RGB(0, 0, 0))
1751:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 250, ;
1752:             "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, RGB(0, 0, 0))
1753:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column4, 110, ;
1754:             "Pre" + CHR(231) + "o de Venda (C)", 2, RGB(36, 84, 155))
1755:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column5,  40, "Moeda", 2, RGB(0, 0, 0))
1756:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column6, 110, ;
1757:             "Pre" + CHR(231) + "o de Venda (L)", 2, RGB(0, 0, 0))
1758: 
1759:         SELECT cursor_4c_Produtos
1760:         GO TOP
1761:         loc_oGrid.Refresh()
1762: 
1763:         RETURN .T.
1764:     ENDPROC
1765: 
1766: 
1767:     *==========================================================================
1768:     * WhenMarcaProduto - When do CheckBox de marcacao de grd_4c_Itens
1769:     * (GradeItens.Column1.Check1.When do legado: "Return(CsSigCdPro.lMarcas
1770:     * = 0)", literal). So permite editar a celula quando o produto AINDA
1771:     * NAO esta na lista de precos do pai - produto ja presente (lMarcas=1)
1772:     * fica travado, visualmente distinguido pelo DynamicForeColor azul de
1773:     * ReligarGradeItens.
1774:     *==========================================================================
1775:     PROCEDURE WhenMarcaProduto()
1776:         IF USED("cursor_4c_Produtos")
1777:             RETURN (cursor_4c_Produtos.lMarcas = 0)
1778:         ENDIF
1779: 
1780:         RETURN .T.
1781:     ENDPROC
1782: 
1783: 
1784:     *==========================================================================
1785:     * Eventos dos botoes de acao (Fase 7/8)
1786:     *==========================================================================
1787: 
1788:     *--------------------------------------------------------------------------
1789:     * BtnMarcarClick / BtnDesmarcarClick - Marcar.Click/Desmarcar.Click do
1790:     * legado (marcam/desmarcam TODAS as linhas da grade de filtro).
1791:     *--------------------------------------------------------------------------
1792:     PROCEDURE BtnMarcarClick()
1793:         IF THIS.this_oBusinessObject.MarcarTodasLinhas(1)
1794:             THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
1795:         ENDIF
1796:     ENDPROC
1797: 
1798:     PROCEDURE BtnDesmarcarClick()
1799:         IF THIS.this_oBusinessObject.MarcarTodasLinhas(0)
1800:             THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
1801:         ENDIF
1802:     ENDPROC
1803: 
1804:     *--------------------------------------------------------------------------
1805:     * BtnMarcaProdClick / BtnDesmarcaProdClick - cmdMarcaProd.Click/
1806:     * cmdDesmarcaProd.Click do legado (marcam/desmarcam TODOS os produtos
1807:     * da grade de resultado que ainda nao estao na lista - lMarcas = 0).
1808:     *--------------------------------------------------------------------------
1809:     PROCEDURE BtnMarcaProdClick()
1810:         IF THIS.this_oBusinessObject.MarcarTodosProdutos(1)
1811:             THIS.grd_4c_Itens.Refresh()
1812:         ENDIF
1813:     ENDPROC
1814: 
1815:     PROCEDURE BtnDesmarcaProdClick()
1816:         IF THIS.this_oBusinessObject.MarcarTodosProdutos(0)
1817:             THIS.grd_4c_Itens.Refresh()
1818:         ENDIF
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * BtnProcessarClick - Processar.Click do legado: consulta SigCdPro
1823:     * pelos filtros atuais (FormParaBO sincroniza a UI nas properties do
1824:     * BO) e preenche grd_4c_Itens.
1825:     *
1826:     * par_cCursorListaPrecos de BuscarProdutos() vai "" por ora: o form pai
1827:     * (SIGOPPxx) ainda nao existe migrado, e o nome do cursor de itens dele
1828:     * eh desconhecido neste CONTRATO (PILAR 3 - ver nota no cabecalho do
1829:     * arquivo). BuscarProdutos trata "" como "nenhum item ja esta na
1830:     * lista", que eh exatamente o caso mais comum (Processar roda ANTES de
1831:     * qualquer Copia p/ Lista).
1832:     *--------------------------------------------------------------------------
1833:     PROCEDURE BtnProcessarClick()
1834:         WAIT WINDOW "Aguarde !!! Selecionando Produtos..." NOWAIT
1835: 
1836:         THIS.FormParaBO()
1837: 
1838:         IF !THIS.this_oBusinessObject.BuscarProdutos("")
1839:             WAIT CLEAR
1840:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1841:                     NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
1842:                     "Falha na Conex" + CHR(227) + "o")
1843:             THIS.Release()
1844:             RETURN
1845:         ENDIF
1846: 
1847:         THIS.ReligarGradeItens()
1848: 
1849:         WAIT CLEAR
1850: 
1851:         IF EOF("cursor_4c_Produtos")
1852:             MsgAviso("N" + CHR(227) + "o existem produtos com esses par" + ;
1853:                      CHR(226) + "metros !!!", "Aten" + CHR(231) + CHR(227) + "o")
1854:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.SetFocus()
1855:         ELSE
1856:             THIS.cmd_4c_CopiaLista.Enabled = .T.
1857:             THIS.grd_4c_Itens.SetFocus()
1858:         ENDIF
1859:     ENDPROC
1860: 
1861:     *--------------------------------------------------------------------------
1862:     * BtnCopiaListaClick - CopiaLista.Click do legado: devolve ao form pai
1863:     * os produtos marcados (flagctabs=1) que ainda nao estao na lista
1864:     * (lMarcas=0), respeitando a Situacao do filtro, e encerra o dialogo.
1865:     *
1866:     * BO.ObterProdutosParaCopia("") replica o SCAN inteiro do legado
1867:     * (guard de Situacao incluso) e preenche cursor_4c_ProdutosCopia
1868:     * (cpros/dpros/pvens/pliqs/moevs) - exatamente os candidatos que o
1869:     * legado insere em CrSigCdLpi.
1870:     *
1871:     * A gravacao em si (limpar a linha em branco, cidchaves via
1872:     * fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs, vencis/
1873:     * vencfs, arredondamento condicional via fArredondamento quando
1874:     * CompVenda <> "C") pertence ao form PAI - ele quem conhece
1875:     * CrSigCdLpi/CrSigCdLpc/CompVenda/poDataMgr. Entregar o cursor por um
1876:     * metodo PUBLIC opcional (AdicionarProdutosSelecionados), chamado
1877:     * DEFENSIVAMENTE via PEMSTATUS, eh o mesmo padrao ja usado em
1878:     * ReabilitarFormPai/RepintarFormPai - nao estoura enquanto nenhum form
1879:     * SIGOPPxx desta familia existir migrado.
1880:     *--------------------------------------------------------------------------
1881:     PROCEDURE BtnCopiaListaClick()
1882:         LOCAL loc_oErro
1883: 
1884:         THIS.FormParaBO()
1885: 
1886:         IF !THIS.this_oBusinessObject.ObterProdutosParaCopia("")
1887:             MsgErro(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
1888:                     "Formsigopsep.BtnCopiaListaClick")
1889:             RETURN
1890:         ENDIF
1891: 
1892:         IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
1893:                 PEMSTATUS(THIS.this_oFormPai, "AdicionarProdutosSelecionados", 5)
1894:             TRY
1895:                 THIS.this_oFormPai.AdicionarProdutosSelecionados("cursor_4c_ProdutosCopia")
1896:             CATCH TO loc_oErro
1897:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1898:                         "vel copiar os produtos para a lista: " + loc_oErro.Message, ;
1899:                         "Formsigopsep.BtnCopiaListaClick")
1900:             ENDTRY
1901:         ENDIF
1902: 
1903:         THIS.Release()
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------
1907:     * BtnEncerrarClick - Sair.Click do legado (literal: ThisForm.Release()).
1908:     * Destroy() (abaixo) replica o fecho de SIGOPSEP.Release - cursores
1909:     * locais, repintar e reabilitar o pai.
1910:     *--------------------------------------------------------------------------
1911:     PROCEDURE BtnEncerrarClick()
1912:         THIS.Release()
1913:     ENDPROC
1914: 
1915: 
1916:     *==========================================================================
1917:     * InstalarCheckBoxColuna - instala (ou REINSTALA) o CheckBox de marcacao
1918:     * numa Column de Grid, no estado em que o dump declara Column1.Check1
1919:     * (Top=27 Left=7 Width=60 Height=17 Alignment=0 Caption="" ReadOnly=.F.) -
1920:     * o mesmo nos dois grids do form.
1921:     *
1922:     * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a
1923:     * coluna segue desenhando o Text1 dela, e sem Sparse = .F. o controle
1924:     * aparece so na linha ativa (regra #18).
1925:     *
1926:     * REENTRANTE de proposito: fechar/recriar o alias do RecordSource destroi
1927:     * o objeto adicionado por Column.AddObject (CurrentControl volta a
1928:     * "Text1") preservando ColumnCount/Width/Header - perda PARCIAL e
1929:     * silenciosa. Por isso o AddObject so corre quando o membro sumiu, e todo
1930:     * o resto e sempre reaplicado.
1931:     *
1932:     * par_oColuna - objeto Column, JA ligado via ControlSource
1933:     * par_cNome   - nome do CheckBox a instalar nessa coluna
1934:     *==========================================================================
1935:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNome)
1936:         LOCAL loc_oChk
1937: 
1938:         IF VARTYPE(par_oColuna) != "O" OR VARTYPE(par_cNome) != "C" OR EMPTY(par_cNome)
1939:             RETURN .F.
1940:         ENDIF
1941: 
1942:         IF !PEMSTATUS(par_oColuna, par_cNome, 5)
1943:             par_oColuna.AddObject(par_cNome, "CheckBox")
1944:         ENDIF
1945: 
1946:         *-- Membro alcancado por NOME: EVALUATE na leitura. Controls(<nome>) e
1947:         *-- indexado por NUMERO e estouraria em runtime (regras #15/#34).
1948:         loc_oChk = EVALUATE("par_oColuna." + par_cNome)
1949: 
1950:         IF VARTYPE(loc_oChk) != "O"
1951:             RETURN .F.
1952:         ENDIF
1953: 
1954:         WITH loc_oChk
1955:             .Caption   = ""
1956:             .Alignment = 0
1957:             .Top       = 27
1958:             .Left      = 7
1959:             .Width     = 60
1960:             .Height    = 17
1961:             .ReadOnly  = .F.
1962:             *-- CheckBox.Value e NUMERICO (0/1), nunca .F./.T.: as colunas
1963:             *-- ligadas (lMarcas/flagctabs) sao N(1)
1964:             .Value     = 0
1965:             .Visible   = .T.
1966:         ENDWITH
1967: 
1968:         par_oColuna.Sparse         = .F.
1969:         par_oColuna.CurrentControl = par_cNome
1970:         par_oColuna.ReadOnly       = .F.
1971: 
1972:         RETURN .T.
1973:     ENDPROC
1974: 
1975:     *==========================================================================

*-- Linhas 1990 a 2194:
1990:     *                   NAO declara ForeColor, para nao inventar propriedade
1991:     *                   que o legado deixou no default (regra #25)
1992:     *==========================================================================
1993:     PROTECTED PROCEDURE AplicarCabecalhoColuna(par_oColuna, par_nWidth, ;
1994:             par_cCaption, par_nAlignment, par_nForeColor)
1995: 
1996:         IF VARTYPE(par_oColuna) != "O"
1997:             RETURN .F.
1998:         ENDIF
1999: 
2000:         WITH par_oColuna
2001:             .Width             = par_nWidth
2002:             .Header1.Caption   = par_cCaption
2003:             .Header1.FontName  = "Tahoma"
2004:             .Header1.FontSize  = 8
2005:             .Header1.Alignment = par_nAlignment
2006: 
2007:             IF par_nForeColor >= 0
2008:                 .Header1.ForeColor = par_nForeColor
2009:             ENDIF
2010:         ENDWITH
2011: 
2012:         RETURN .T.
2013:     ENDPROC
2014: 
2015: 
2016:     *==========================================================================
2017:     * FormParaBO - le os campos de cnt_4c_Filtro para as properties do BO.
2018:     *
2019:     * Chamado ANTES de Processar (Fase 6/8): o legado le os mesmos campos
2020:     * direto do container CrtFiltro dentro de Grupo_op.Processar.Click (With
2021:     * ThisForm.CrtFiltro / lcCGrus = ... / lcColecoes = ... / lcMoevs = ...
2022:     * / lnAjuste = 1 + (.Get_AcreDesc.Value/100) / lnArredonda =
2023:     * .Get_Arrend.Value / lnSitua = .Opc_situacao.Value).
2024:     *
2025:     * Os campos de DESCRICAO (txt_4c_DgrVenda/DgrProduto/DmoeVenda) sao
2026:     * ReadOnly e preenchidos so pelo lookup (fase 6/8) - ainda assim sao
2027:     * espelhados aqui porque BOParaForm precisa do caminho inverso simetrico
2028:     * (ex.: reabrir o dialogo com filtro ja preenchido pelo form pai).
2029:     *
2030:     * obj_4c_Situacao.Value JA eh o indice do botao (1/2/3) - nunca 0/1
2031:     * (regra #45/#188), por isso vai direto, sem IIF.
2032:     *==========================================================================
2033:     PROTECTED PROCEDURE FormParaBO()
2034:         WITH THIS.this_oBusinessObject
2035:             .this_cGrupoVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
2036:             .this_cDescGrupoVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
2037:             .this_cGrupoProduto      = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
2038:             .this_cDescGrupoProduto  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
2039:             .this_cMoedaVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
2040:             .this_cDescMoedaVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
2041:             .this_nAcrescimoDesconto = THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value
2042:             .this_nArredondamento    = THIS.cnt_4c_Filtro.txt_4c_Arrend.Value
2043:             .this_nSituacao          = THIS.cnt_4c_Filtro.obj_4c_Situacao.Value
2044:         ENDWITH
2045:     ENDPROC
2046: 
2047: 
2048:     *==========================================================================
2049:     * BOParaForm - caminho inverso de FormParaBO, usado pelo Init (Fase 1/8
2050:     * ja guarda o estado no BO com os defaults do SIGOPSEP.Init - pcMercs
2051:     * vazio) e por qualquer recarga futura do filtro a partir do BO.
2052:     *==========================================================================
2053:     PROTECTED PROCEDURE BOParaForm()
2054:         WITH THIS.this_oBusinessObject
2055:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value    = .this_cGrupoVenda
2056:             THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value   = .this_cDescGrupoVenda
2057:             THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = .this_cGrupoProduto
2058:             THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = .this_cDescGrupoProduto
2059:             THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value   = .this_cMoedaVenda
2060:             THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value  = .this_cDescMoedaVenda
2061:             THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value   = .this_nAcrescimoDesconto
2062:             THIS.cnt_4c_Filtro.txt_4c_Arrend.Value     = .this_nArredondamento
2063:             THIS.cnt_4c_Filtro.obj_4c_Situacao.Value   = .this_nSituacao
2064:         ENDWITH
2065:     ENDPROC
2066: 
2067: 
2068:     *==========================================================================
2069:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
2070:     *
2071:     * Sem parametro (igual FormSigOpCrd): este form nao tem container
2072:     * flutuante a filtrar ate agora. Se uma fase futura introduzir painel
2073:     * Visible=.F. alternado por botao, o filtro entra aqui.
2074:     *==========================================================================
2075:     PROTECTED PROCEDURE TornarControlesVisiveis()
2076:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
2077: 
2078:         FOR loc_nI = 1 TO THIS.ControlCount
2079:             loc_oControle = THIS.Controls(loc_nI)
2080: 
2081:             IF VARTYPE(loc_oControle) = "O"
2082:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
2083:                     loc_oControle.Visible = .T.
2084:                 ENDIF
2085: 
2086:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
2087:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
2088:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
2089:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
2090:                             loc_oFilho.Visible = .T.
2091:                         ENDIF
2092:                     ENDFOR
2093:                 ENDIF
2094:             ENDIF
2095:         ENDFOR
2096: 
2097:         RETURN .T.
2098:     ENDPROC
2099: 
2100: 
2101:     *==========================================================================
2102:     * FormatarGridLista - formatacao visual padrao de grid (fase 4/5 chamam
2103:     * apos popular grd_4c_Linhas / grd_4c_Itens)
2104:     *==========================================================================
2105:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2106:         IF VARTYPE(par_oGrid) != "O"
2107:             RETURN .F.
2108:         ENDIF
2109: 
2110:         par_oGrid.FontName = "Courier New"
2111:         par_oGrid.FontSize = 9
2112:         par_oGrid.Refresh()
2113: 
2114:         RETURN .T.
2115:     ENDPROC
2116: 
2117: 
2118:     *==========================================================================
2119:     * RepintarFormPai - ParentForm.Pagina.Dados.Refresh do legado
2120:     * (SIGOPSEP.Release). THIS.this_oFormPai.Refresh() cascateia para TODOS
2121:     * os controles do form pai (containers/paginas/grids) - o Form.Refresh
2122:     * nativo do VFP9 ja desce a arvore de controles sozinho, entao nao e
2123:     * preciso conhecer os nomes _4c_ do pai (PILAR 3) nem presumir a
2124:     * hierarquia Pagina.Dados.Grade do legado. Serve a QUALQUER form pai
2125:     * desta familia (SIGOPPxx), migrado com qualquer layout.
2126:     *==========================================================================
2127:     PROCEDURE RepintarFormPai()
2128:         LOCAL loc_oErro
2129: 
2130:         IF VARTYPE(THIS.this_oFormPai) != "O"
2131:             RETURN .F.
2132:         ENDIF
2133: 
2134:         TRY
2135:             THIS.this_oFormPai.Refresh()
2136:         CATCH TO loc_oErro
2137:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel repintar a tela de origem: " + ;
2138:                     loc_oErro.Message, "Formsigopsep.RepintarFormPai")
2139:         ENDTRY
2140: 
2141:         RETURN .T.
2142:     ENDPROC
2143: 
2144: 
2145:     *==========================================================================
2146:     * ReabilitarFormPai - ParentForm.Enabled = .T. do legado (SIGOPSEP.Release)
2147:     *
2148:     * O legado faz isso INCONDICIONALMENTE (sem flag de "fomos nos que
2149:     * desabilitamos") - diferente de SigOpCrd. Mantido defensivo via
2150:     * PEMSTATUS para nunca estourar se o pai nao tiver a property.
2151:     *==========================================================================
2152:     PROCEDURE ReabilitarFormPai()
2153:         LOCAL loc_oErro
2154: 
2155:         IF VARTYPE(THIS.this_oFormPai) != "O"
2156:             RETURN .F.
2157:         ENDIF
2158: 
2159:         TRY
2160:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2161:                 THIS.this_oFormPai.Enabled = .T.
2162:             ENDIF
2163:         CATCH TO loc_oErro
2164:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
2165:                     loc_oErro.Message, "Formsigopsep.ReabilitarFormPai")
2166:         ENDTRY
2167: 
2168:         RETURN .T.
2169:     ENDPROC
2170: 
2171: 
2172:     *==========================================================================
2173:     * Destroy - equivalente ao SIGOPSEP.Release: cursores locais, repintar
2174:     * (RepintarFormPai) e reabilitar (ReabilitarFormPai) o pai, na mesma
2175:     * ordem do legado (Refresh antes de Enabled = .T.). SetFocus no Grade
2176:     * do pai (Pagina.Dados.Grade.Column1.SetFocus) fica de fora - exigiria
2177:     * conhecer o nome do grid do pai, violando o PILAR 3 (ver nota de
2178:     * CONTRATO no cabecalho do arquivo); o Refresh em cascata ja garante
2179:     * que os dados aparecam.
2180:     *==========================================================================
2181:     PROCEDURE Destroy()
2182:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2183:             THIS.this_oBusinessObject.LimparCursores()
2184:             THIS.this_oBusinessObject = .NULL.
2185:         ENDIF
2186: 
2187:         THIS.RepintarFormPai()
2188:         THIS.ReabilitarFormPai()
2189:         THIS.this_oFormPai = .NULL.
2190: 
2191:         DODEFAULT()
2192:     ENDPROC
2193: 
2194: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopsepBO.prg):
*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SET NULL OFF
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SET NULL ON
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE
                SET NULL OFF

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))
        SET NULL OFF

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))
                SET NULL OFF

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE


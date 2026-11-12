# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopped.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1493 linhas total):

*-- Linhas 23 a 148:
23: * CsTmpPed do pai ficariam invisiveis para este dialogo (sessao privada
24: * isolada) e nenhum metodo de BtnSalvarClick/Init funcionaria. Transcrito
25: * fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do Init, ANTES
26: * de DODEFAULT() (que dispara InicializarForm).
27: *
28: * this_oFormPai equivale a property customizada "parentform" do legado
29: * (RESERVED3 ClassInfo: antvalue/parentform/podatamgr/*calctotais).
30: * this_cAntValu equivale a "AntValu" (usada em GetPedido.Valid, fase
31: * posterior, para detectar troca de abreviacao digitada). poDataMgr nao tem
32: * equivalente nesta arquitetura (gnConnHandle compartilhado via config.prg).
33: *
34: * Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
35: *
36: * Herda de: FormBase          BO associado: sigoppedBO
37: * Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
38: *
39: * Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
40: * Fase 4/8: CommandGroup de acao "OK" (obj_4c_OK: btnSair/"Retornar" +
41: * btnGravar/"Gravar") - unico bloco de "botoes" real desta tela (nao ha
42: * cnt_4c_Botoes/cnt_4c_BotoesAcao genericos: o legado nao os tem, e
43: * inventa-los violaria o PILAR 1). BtnSalvarClick ja referencia os 8 campos
44: * txt_4c_* que entram na Fase 5 (forward reference resolvida quando aquela
45: * fase adicionar os controles via AddObject).
46: * Fase 5/8: Shape1 (moldura decorativa) + a PRIMEIRA linha de campos
47: * (Produto/Descricao/Cor/Tam./Qtde - getDPros/Say10/get_prod/Say1/getCor/
48: * Say2/getTam/Say4/GetQtde), transcritos do dump com compensacao NENHUMA de
49: * PageFrame (nao existe PageFrame aqui - os Tops do dump sao absolutos).
50: * TabIndex do dump confirma o agrupamento por linha (Say10=1 .. GetQtde=9
51: * na 1a linha; Say3=10 .. getTamanho=17 na 2a).
52: * Fase 6/8: a SEGUNDA linha de campos (Pedido/Repetir/Peso/Tam. -
53: * Say3/GetPedido/Say5/getRepetir/Say6/Get_Peso/Say7/getTamanho) + lookups
54: * completos: ValidarPedido/AbrirBuscaPedido (fwbuscasel sobre o cursor
55: * LOCAL CsTmpPed - FormBuscaAuxiliar.DefinirCursor()/.Mostrar(), regra
56: * CLAUDE.md #36/#37, pois NAO ha SQL Server envolvido),
57: * ValidarTamanho/AbrirLookupTamanho (fwbuscaext/SigCdTam via gnConnHandle,
58: * padrao canonico do projeto) e ValidarRepetir (limite contra
59: * GetQtde.Value, sem lookup). Todos ligados via BINDEVENT "LostFocus"
60: * (regra CLAUDE.md #47 - Valid do legado equivale a validar na SAIDA do
61: * campo, nunca KeyPress sem testar a tecla).
62: * Fase 7/8: a orquestracao completa do Init legado, que nao faz sentido
63: * fatiar em "visibilidade" (fase 7) e "SQL" (fase 8) porque no legado sao o
64: * MESMO bloco - a visibilidade de Say7/getTamanho depende diretamente do
65: * resultado da consulta de crTmpGru. Implementado em dois metodos chamados
66: * no fim de InicializarForm, apos TornarControlesVisiveis (que forca
67: * Visible=.T. em todo AddObject e precisa ser desfeito explicitamente para
68: * os dois controles condicionais):
69: *   - CarregarPedidosDisponiveis(): "lcSql = [Select a.cDopes, ...]" + 2
70: *     INDEX ON do Init - popula CsTmpPed (consumido por ValidarPedido/
71: *     AbrirBuscaPedido, ja implementados na Fase 6). Fonte de cDopes eh o
72: *     cursor TprMvCab do form PAI (visivel aqui via SET DATASESSION TO
73: *     par_nDataSessionPai, no Init).
74: *   - CarregarDadosProduto(): leitura de crTpmMvItn (Qtde via Count For Not
75: *     Empty + Get_Peso.Value = Pesos), as duas consultas de verificacao de
76: *     conexao (crTmpUni/crTmpGru) e a visibilidade condicional de Say7/
77: *     getTamanho (regra: Empty(lcTam) AND crTmpGru.TipoEstos em 3,4).
78: * Em ambos os metodos, falha de SQLEXEC (com conexao disponivel) aborta a
79: * abertura do form - "Return 0" do Init legado equivale a
80: * loc_lSucesso = .F. em InicializarForm (CREATEOBJECT devolve .F.). Sem
81: * conexao/parent form (harness de teste, ValidarUIFidelity) os dois metodos
82: * sao no-op bem-sucedido - mesmo padrao de FormSigOpPec.InicializarForm
83: * (loc_lModoValidacaoOuTeste).
84: *
85: * O "Load" do legado (=fConfigGeral()) NAO eh portado, de proposito: eh o
86: * mesmo caso ja decidido e documentado em FormSigOpOpe.prg/
87: * projeto\app\utils\fconfiggeral.prg - fConfigGeral era funcao GLOBAL da
88: * aplicacao legado que nao veio no acervo, e o que ela fazia (configuracao
89: * global) ja acontece antes: config.prg (SETs/paths/aliases), main.prg
90: * (conexao) e os proprios metodos de carga deste form. Chama-la aqui
91: * mascararia a ausencia em vez de mostra-la - regra #2 do CLAUDE.md: em
92: * codigo NOSSO nunca se chama fConfigGeral.
93: *
94: * "Release" do legado (so chamava ThisForm.poDataMgr.Release + DoDefault) -
95: * ja implementado em Destroy() desde a Fase 4 (poDataMgr nao existe nesta
96: * arquitetura).
97: *
98: * Fase 8/8: consolidacao final. Este form OPERACIONAL nao segue o roteiro
99: * generico de form CRUD (sem Page1=Lista/Page2=Dados, sem BtnBuscar/
100: * BtnEncerrar/BtnCancelar/CarregarLista/HabilitarCampos/LimparCampos/
101: * AjustarBotoesPorModo - o legado nao tem nenhum desses: sao DOIS botoes
102: * no SCX (btnGravar e btnSair), nao ha grade nem modo de edicao
103: * cancelavel, o unico "Buscar" eh o lookup de pedido/tamanho ja entregue
104: * na Fase 6 e o unico "Encerrar" eh BtnSairClick, na Fase 4) - inventa-los
105: * violaria o PILAR 1 e cria-los vazios violaria a regra de completude.
106: * O que esta fase fez:
107: *   - FormParaBO(): THIS.this_oBusinessObject era criado em
108: *     InicializarForm (Fase 3) e nunca usado - o handler do Gravar (Fase 7)
109: *     duplicava inline a mesma logica que
110: *     sigoppedBO.GravarAbreviacaoNosItens ja implementava desde a Fase 2.
111: *     FormParaBO() + THIS.this_oBusinessObject.Atualizar() substituem a
112: *     duplicacao (PILAR 3 - Form nao manipula o cursor de persistencia
113: *     direto).
114: *   - BOParaForm(): contrapartida da transferencia, consumida por
115: *     CarregarDadosProduto - a carga da tela passou a ser cursor -> BO
116: *     (CarregarDoCursor) -> tela, em vez de o Form ler coluna de cursor
117: *     para pintar campo.
118: *   - BtnSalvarClick: o handler do botao "Gravar" usa o NOME canonico do
119: *     projeto (BtnSalvarClick), nao o nome do objeto legado (btnGravar) -
120: *     o Caption continua "Gravar", transcrito do dump (PILAR 1), e o
121: *     handler do botao de abandono segue BtnSairClick, do Caption
122: *     "Retornar". Dentro dele: (a) as 5 leituras vestigiais do legado
123: *     passaram a ser GUARDADAS por USED()/PEMSTATUS - sem guarda, um alias
124: *     ausente estourava e caia no CATCH ANTES da gravacao, isto eh, codigo
125: *     morto matava o unico trabalho real do botao; (b) a falha de gravacao
126: *     deixou de ser muda (regra CLAUDE.md #20 - Atualizar() eh chamado
127: *     direto, fora do Salvar() que chama ExibirFalha()) e o dialogo so
128: *     fecha quando GRAVOU.
129: *   - ReadOnly = .T. nos 5 campos que o legado declara com
130: *     "When / Return .F." (get_prod/getDPros/getCor/getTam/GetQtde) -
131: *     estavam digitaveis no migrado, e produto/cor/tamanho sao justamente
132: *     as 3 chaves que FormParaBO entrega ao BO para localizar o item a
133: *     gravar.
134: *==============================================================================
135: 
136: DEFINE CLASS Formsigopped AS FormBase
137: 
138:     *==========================================================================
139:     * Propriedades visuais - transcritas do dump do SCX legado (secao
140:     * "PROPRIEDADES DE: SIGOPPED"). WindowType = 1: Show() desta classe
141:     * SEMPRE roda modal, mesmo sem parametro. ControlBox/TitleBar: sem X e
142:     * sem barra de titulo - nenhum botao de sistema desenha. AlwaysOnTop +
143:     * AutoCenter: dialogo flutuante centralizado sobre a tela do form pai.
144:     *==========================================================================
145:     Height      = 211
146:     Width       = 773
147:     DataSession = 2
148:     ShowWindow = 1

*-- Linhas 192 a 349:
192:     * esta guarda, tabular pelo campo sem digitar nada reabriria o lookup
193:     * (ou repetiria a validacao de estoque) a cada passagem.
194:     *==========================================================================
195:     this_cUltimoValidarPedidoValidado  = ""
196:     this_cUltimoValidarTamanhoValidado = ""
197: 
198:     *==========================================================================
199:     * Init - replica "LParameters pform, datses" do legado. par_oFormPai e
200:     * par_nDataSessionPai sao OPCIONAIS: o harness de teste e a validacao de
201:     * UI instanciam o form sem parametro nenhum (CREATEOBJECT("Formsigopped")).
202:     * SET DATASESSION TO roda ANTES de DODEFAULT() (que dispara
203:     * InicializarForm via FormBase.Init), replicando a ordem exata do Init
204:     * legado ("Set Datasession To DatSes" eh a 1a linha executavel, antes de
205:     * qualquer SQL). NUNCA chamar InicializarForm aqui tambem - DODEFAULT()
206:     * chamar duas vezes estoura "member object already exists" nos AddObject).
207:     *==========================================================================
208:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai)
209:         IF VARTYPE(par_oFormPai) = "O"
210:             THIS.this_oFormPai = par_oFormPai
211:         ENDIF
212: 
213:         IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
214:             SET DATASESSION TO (par_nDataSessionPai)
215:         ENDIF
216: 
217:         RETURN DODEFAULT()
218:     ENDPROC
219: 
220:     *==========================================================================
221:     * InicializarForm - monta a estrutura base: fundo do form, Business
222:     * Object e o cabecalho (unico bloco visual entregue nesta fase). Os
223:     * demais blocos (CommandGroup OK, Shape1, campos) entram em
224:     * ConfigurarPageFrame nas fases seguintes, na mesma ordem do dump do SCX.
225:     *==========================================================================
226:     PROTECTED PROCEDURE InicializarForm()
227:         LOCAL loc_lSucesso, loc_oErro
228:         loc_lSucesso = .F.
229: 
230:         TRY
231:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
232:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
233: 
234:             *-- Garantir crTpmMvItn para o .ControlSource dos campos de
235:             *-- Produto/Descricao/Cor/Tam. (ConfigurarCamposProduto). Em
236:             *-- producao o cursor ja existe (mantido pelo form PAI, visivel
237:             *-- aqui via SET DATASESSION TO par_nDataSessionPai no Init);
238:             *-- sem form pai (harness de teste/ValidarUIFidelity instancia
239:             *-- sem parametro nenhum, na DataSession PRIVADA desta classe)
240:             *-- o placeholder evita "Alias 'CRTPMMVITN' is not found" ao
241:             *-- vincular o ControlSource. Padrao idem FormEnd.ConfigurarCampos.
242:             IF !USED("crTpmMvItn")
243:                 CREATE CURSOR crTpmMvItn (cItens N(9,0), cPros C(14), DPros C(65), ;
244:                     CodCors C(14), CodTams C(14), Abrevis C(14), cItem2 N(9,0), ;
245:                     Opers C(14), Pesos N(9,3))
246:             ENDIF
247: 
248:             THIS.this_oBusinessObject = CREATEOBJECT("sigoppedBO")
249: 
250:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
251:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigoppedBO.", ;
252:                     "Erro em InicializarForm")
253:             ELSE
254:                 THIS.ConfigurarPageFrame()
255: 
256:                 THIS.TornarControlesVisiveis(THIS)
257: 
258:                 *-- Orquestracao do Init legado (ver comentario de cabecalho -
259:                 *-- "Fase 7/8"). Falha de SQLEXEC com conexao disponivel
260:                 *-- aborta a abertura do form, equivalente ao "Return 0" do
261:                 *-- Init legado.
262:                 IF THIS.CarregarPedidosDisponiveis() AND THIS.CarregarDadosProduto()
263:                     loc_lSucesso = .T.
264:                 ELSE
265:                     loc_lSucesso = .F.
266:                 ENDIF
267:             ENDIF
268:         CATCH TO loc_oErro
269:             MsgErro(loc_oErro.Message + CHR(13) + ;
270:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
271:                 "Procedure: " + loc_oErro.Procedure, ;
272:                 "Erro em InicializarForm")
273:         ENDTRY
274: 
275:         RETURN loc_lSucesso
276:     ENDPROC
277: 
278:     *==========================================================================
279:     * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
280:     * real neste form (objeto raiz do legado eh "Class: form" generico, sem
281:     * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
282:     * convencao com o restante do pipeline (mesmo padrao de FormSigOpPec.prg/
283:     * FormSigOpGar.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
284:     * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
285:     * Shape1 -> OK -> campos (fases seguintes).
286:     *==========================================================================
287:     PROTECTED PROCEDURE ConfigurarPageFrame()
288:         THIS.ConfigurarCabecalho()
289:         THIS.ConfigurarBotaoAcao()
290:         THIS.ConfigurarCamposProduto()
291:         THIS.ConfigurarCamposPedido()
292:     ENDPROC
293: 
294:     *==========================================================================
295:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
296:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
297:     * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
298:     * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
299:     * "PROPRIEDADES DE: SIGOPPED.cntSombra" e dos dois labels filhos).
300:     *
301:     * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
302:     * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
303:     * criado por AddObject e, com WordWrap, descarta a Height).
304:     *
305:     * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
306:     * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
307:     * do Init legado.
308:     *==========================================================================
309:     PROTECTED PROCEDURE ConfigurarCabecalho()
310:         LOCAL loc_oCab
311: 
312:         THIS.AddObject("cnt_4c_Sombra", "Container")
313:         loc_oCab = THIS.cnt_4c_Sombra
314:         WITH loc_oCab
315:             .Top         = 0
316:             .Left        = 0
317:             .Width       = THIS.Width
318:             .Height      = 80
319:             .BackStyle   = 1
320:             .BackColor   = RGB(100, 100, 100)
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
326:         WITH loc_oCab.lbl_4c_LblSombra
327:             .AutoSize      = .F.
328:             .Top           = 18
329:             .Left          = 10
330:             .Width         = 769
331:             .Height        = 40
332:             .FontName      = "Tahoma"
333:             .FontSize      = 18
334:             .FontBold      = .T.
335:             .FontUnderline = .F.
336:             .WordWrap      = .T.
337:             .Alignment     = 0
338:             .BackStyle     = 0
339:             .ForeColor     = RGB(0, 0, 0)
340:             .Caption       = THIS.Caption
341:             .Visible       = .T.
342:         ENDWITH
343: 
344:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
345:         WITH loc_oCab.lbl_4c_LblTitulo
346:             .AutoSize    = .F.
347:             .Top         = 17
348:             .Left        = 10
349:             .Width       = 769

*-- Linhas 365 a 412:
365:     * ConfigurarBotaoAcao - cria obj_4c_OK (CommandGroup "OK" do legado),
366:     * unico bloco de botoes desta tela: Buttons(1) = btnSair ("Retornar",
367:     * Cancel=.T.) e Buttons(2) = btnGravar ("Gravar"). Posicao/propriedades
368:     * EXATAS do dump (secao "PROPRIEDADES DE: SIGOPPED.OK"). BINDEVENT em
369:     * ButtonsClick delegando para metodo PUBLIC (regra CLAUDE.md #3 -
370:     * BINDEVENT exige metodo PUBLIC, PROTECTED falha em silencio).
371:     *==========================================================================
372:     PROTECTED PROCEDURE ConfigurarBotaoAcao()
373:         LOCAL loc_oErro
374: 
375:         TRY
376:             THIS.AddObject("obj_4c_OK", "CommandGroup")
377:             WITH THIS.obj_4c_OK
378:                 .Top          = -2
379:                 .Left         = 616
380:                 .Width        = 160
381:                 .Height       = 85
382:                 .ButtonCount  = 2
383:                 .BackStyle    = 0
384:                 .BorderStyle  = 0
385:                 .SpecialEffect = 1
386:                 .BorderColor  = RGB(136, 189, 188)
387:                 .Themes       = .F.
388:                 .Value        = 0
389:                 .Visible      = .T.
390: 
391:                 WITH .Buttons(1)
392:                     .Top         = 5
393:                     .Left        = 80
394:                     .Width       = 75
395:                     .Height      = 75
396:                     .FontBold    = .T.
397:                     .FontItalic  = .T.
398:                     .FontName    = "Comic Sans MS"
399:                     .FontSize    = 8
400:                     .WordWrap    = .T.
401:                     .Picture     = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
402:                     .Caption     = "Retornar"
403:                     .MousePointer = 15
404:                     .ToolTipText = "[Esc] Voltar Para a Tela Principal da " + ;
405:                         "Opera" + CHR(231) + CHR(227) + "o"
406:                     .SpecialEffect = 0
407:                     .ForeColor   = RGB(90, 90, 90)
408:                     .BackColor   = RGB(255, 255, 255)
409:                     .Themes      = .F.
410:                     .Cancel      = .T.
411:                 ENDWITH
412: 

*-- Linhas 428 a 563:
428:                 ENDWITH
429:             ENDWITH
430: 
431:             BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSairClick")
432:             BINDEVENT(THIS.obj_4c_OK.Buttons(2), "Click", THIS, "BtnSalvarClick")
433:         CATCH TO loc_oErro
434:             MsgErro(loc_oErro.Message + CHR(13) + ;
435:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
436:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoAcao")
437:         ENDTRY
438:     ENDPROC
439: 
440:     *==========================================================================
441:     * ConfigurarCamposProduto - Shape1 (moldura decorativa que emoldura toda
442:     * a area de campos - secao "PROPRIEDADES DE: SIGOPPED.Shape1" do dump,
443:     * BackStyle = 0 e sem BorderColor/FillColor customizados) + a PRIMEIRA
444:     * linha de campos do dump, na ordem do TabIndex (1 a 9): Say10/get_prod/
445:     * getDPros (Produto + descricao), Say1/getCor (Cor), Say2/getTam (Tam.)
446:     * e Say4/GetQtde (Qtde).
447:     *
448:     * Nao ha PageFrame neste form (objeto raiz do legado = "form" generico) -
449:     * os Top/Left sao os ABSOLUTOS do dump, sem qualquer compensacao.
450:     *
451:     * Os labels (classe "say" do legado) declaram Width/sem Alignment no
452:     * dump - transcritos com .Alignment = 0 e a Width EXATA declarada
453:     * (regra CLAUDE.md #23: Width presente no dump e legitima, nao
454:     * inventada). Format/InputMask = "" no dump de get_prod/getCor/getTam
455:     * sao override VAZIO do Form Designer - NAO transcritos (regra #49).
456:     * getDPros declara Format = "K!" (seleciona tudo ao focar + forca
457:     * maiuscula) - transcrito literalmente.
458:     *
459:     * get_prod/getDPros/getCor/getTam replicam o .ControlSource do dump
460:     * legado ("crTpmMvItn.<coluna>") - leitura em tempo real do cursor
461:     * mantido pelo form PAI (visivel aqui via SET DATASESSION TO
462:     * par_nDataSessionPai, no Init). Padrao idem FormEnd.prg/
463:     * FormSigReJur.prg: cursor placeholder garantido em InicializarForm
464:     * (IF !USED("crTpmMvItn") CREATE CURSOR ...) ANTES desta chamada, para
465:     * o binding nao estourar "Alias is not found" quando o form eh
466:     * instanciado sem o pai (harness de teste/ValidarUIFidelity). GetQtde
467:     * NAO tem ControlSource no dump - o legado atribui o .Value por codigo
468:     * (Count For ... + ThisForm.getQtde.Value = lnQtde), o que entra na
469:     * Fase 8 (orquestracao do Init); aqui recebe so o Value inicial 0.
470:     *==========================================================================
471:     PROTECTED PROCEDURE ConfigurarCamposProduto()
472:         LOCAL loc_oErro
473: 
474:         TRY
475:             THIS.AddObject("shp_4c_Shape1", "Shape")
476:             WITH THIS.shp_4c_Shape1
477:                 .Top       = 89
478:                 .Left      = 5
479:                 .Width     = 585
480:                 .Height    = 110
481:                 .BackStyle = 0
482:                 .Visible   = .T.
483:             ENDWITH
484: 
485:             THIS.AddObject("lbl_4c_Label10", "Label")
486:             WITH THIS.lbl_4c_Label10
487:                 .Top       = 92
488:                 .Left      = 11
489:                 .Width     = 40
490:                 .Height    = 15
491:                 .FontName  = "Tahoma"
492:                 .FontSize  = 8
493:                 .AutoSize  = .F.
494:                 .Alignment = 0
495:                 .BackStyle = 0
496:                 .ForeColor = RGB(90, 90, 90)
497:                 .Caption   = "Produto"
498:                 .Visible   = .T.
499:             ENDWITH
500: 
501:             THIS.AddObject("txt_4c__prod", "TextBox")
502:             WITH THIS.txt_4c__prod
503:                 .Top               = 107
504:                 .Left              = 11
505:                 .Width             = 123
506:                 .Height            = 23
507:                 .FontName          = "Tahoma"
508:                 .FontSize          = 8
509:                 .Alignment         = 3
510:                 .MaxLength         = 14
511:                 .SpecialEffect     = 1
512:                 .DisabledBackColor = RGB(255, 255, 255)
513:                 .Visible           = .T.
514:                 .ControlSource     = "crTpmMvItn.cPros"
515:                 *-- "PROCEDURE When / Return .F." do legado (SECAO 3 do dump,
516:                 *-- objetos get_prod/getDPros/getCor/getTam/GetQtde): estes 5
517:                 *-- campos NAO sao digitaveis - exibem o item corrente de
518:                 *-- crTpmMvItn e a quantidade a abreviar, calculados pelo Init.
519:                 *-- ReadOnly = .T. eh a reproducao canonica de "When -> .f."
520:                 *-- no sistema novo e PRESERVA a aparencia do legado, ao
521:                 *-- contrario de Enabled = .F., que acinzentaria o campo
522:                 *-- (violaria o PILAR 1). NUNCA BINDEVENT(..., "When", ...):
523:                 *-- BINDEVENT DESCARTA o retorno do delegate, entao o campo
524:                 *-- continuaria digitavel (regra CLAUDE.md #3) e o usuario
525:                 *-- poderia trocar produto/cor/tamanho - justamente as 3
526:                 *-- chaves que FormParaBO entrega ao BO para localizar o item
527:                 *-- a gravar.
528:                 .ReadOnly          = .T.
529:             ENDWITH
530: 
531:             THIS.AddObject("txt_4c_DPros", "TextBox")
532:             WITH THIS.txt_4c_DPros
533:                 .Top               = 107
534:                 .Left              = 137
535:                 .Width             = 288
536:                 .Height            = 23
537:                 .FontName          = "Tahoma"
538:                 .FontSize          = 8
539:                 .Format            = "K!"
540:                 .SpecialEffect     = 1
541:                 .BackColor         = RGB(255, 255, 255)
542:                 .DisabledBackColor = RGB(255, 255, 255)
543:                 .DisabledForeColor = RGB(192, 192, 192)
544:                 .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
545:                 .Visible           = .T.
546:                 .ControlSource     = "crTpmMvItn.DPros"
547:                 *-- When -> .F. no legado (ver txt_4c__prod)
548:                 .ReadOnly          = .T.
549:             ENDWITH
550: 
551:             THIS.AddObject("lbl_4c_Label1", "Label")
552:             WITH THIS.lbl_4c_Label1
553:                 .Top       = 92
554:                 .Left      = 428
555:                 .Width     = 19
556:                 .Height    = 15
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 8
559:                 .AutoSize  = .F.
560:                 .Alignment = 0
561:                 .BackStyle = 0
562:                 .ForeColor = RGB(90, 90, 90)
563:                 .Caption   = "Cor"

*-- Linhas 652 a 719:
652:         CATCH TO loc_oErro
653:             MsgErro(loc_oErro.Message + CHR(13) + ;
654:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
655:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposProduto")
656:         ENDTRY
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * ConfigurarCamposPedido - a SEGUNDA linha de campos do dump (TabIndex
661:     * 10 a 17): Say3/GetPedido (abreviacao de pedido), Say5/getRepetir
662:     * (quantas vezes repetir a gravacao - a Caption do Say5 no dump legado
663:     * EH "Qtde", igual ao Say4 da 1a linha, mesmo rotulando um campo
664:     * diferente - transcrito literalmente, nao eh erro de digitacao desta
665:     * migracao), Say6/Get_Peso (peso, com InputMask "999999.999" do dump) e
666:     * Say7/getTamanho (tamanho alternativo, visibilidade condicional
667:     * adiada para a Fase 7 - aqui nasce Visible = .T., igual aos demais
668:     * controles criados via AddObject).
669:     *
670:     * GetPedido declara ControlSource = "" no dump (override VAZIO do Form
671:     * Designer, regra CLAUDE.md #49) - NAO transcrito. getTamanho nao
672:     * declara ControlSource/InputMask/Value no dump - sem override.
673:     *
674:     * BINDEVENT em "LostFocus" para os 3 campos com validacao (regra
675:     * CLAUDE.md #47) - ValidarPedido/ValidarTamanho abrem lookup quando o
676:     * valor digitado nao bate com o cursor/tabela de referencia;
677:     * ValidarRepetir so faz a checagem de limite (sem lookup).
678:     *==========================================================================
679:     PROTECTED PROCEDURE ConfigurarCamposPedido()
680:         LOCAL loc_oErro
681: 
682:         TRY
683:             THIS.AddObject("lbl_4c_Label3", "Label")
684:             WITH THIS.lbl_4c_Label3
685:                 .Top       = 136
686:                 .Left      = 11
687:                 .Width     = 34
688:                 .Height    = 15
689:                 .FontName  = "Tahoma"
690:                 .FontSize  = 8
691:                 .AutoSize  = .F.
692:                 .Alignment = 0
693:                 .BackStyle = 0
694:                 .ForeColor = RGB(90, 90, 90)
695:                 .Caption   = "Pedido"
696:                 .Visible   = .T.
697:             ENDWITH
698: 
699:             THIS.AddObject("txt_4c_Pedido", "TextBox")
700:             WITH THIS.txt_4c_Pedido
701:                 .Top               = 150
702:                 .Left              = 11
703:                 .Width             = 49
704:                 .Height            = 23
705:                 .FontName          = "Tahoma"
706:                 .FontSize          = 8
707:                 .Alignment         = 3
708:                 .MaxLength         = 14
709:                 .SpecialEffect     = 1
710:                 .DisabledBackColor = RGB(255, 255, 255)
711:                 .Value             = ""
712:                 .Visible           = .T.
713:             ENDWITH
714: 
715:             THIS.AddObject("lbl_4c_Label5", "Label")
716:             WITH THIS.lbl_4c_Label5
717:                 .Top       = 136
718:                 .Left      = 63
719:                 .Width     = 26

*-- Linhas 809 a 964:
809:                 .Visible           = .T.
810:             ENDWITH
811: 
812:             BINDEVENT(THIS.txt_4c_Pedido,  "LostFocus", THIS, "ValidarPedido")
813:             BINDEVENT(THIS.txt_4c_Repetir, "LostFocus", THIS, "ValidarRepetir")
814:             BINDEVENT(THIS.txt_4c_Tamanho, "LostFocus", THIS, "ValidarTamanho")
815:         CATCH TO loc_oErro
816:             MsgErro(loc_oErro.Message + CHR(13) + ;
817:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
818:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposPedido")
819:         ENDTRY
820:     ENDPROC
821: 
822:     *==========================================================================
823:     * CarregarPedidosDisponiveis - transcricao do bloco inicial do Init
824:     * legado:
825:     *   lcSql = [Select a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs,
826:     *       a.opers, b.abrevs, b.CadProds, b.Desmembs from SigCdMop a,
827:     *       SigCdOpe b, SigOpCdc c, SigOpCdi d
828:     *       Where a.cDopes = '<Dopes>' And a.cnivels = b.dopes And
829:     *       b.Abrevs <> ' ' And b.Dopes = c.Dopes And b.Dopes = d.Dopes And
830:     *       c.OpeInatvs <> 1]
831:     *   If Thisform.PodataMgr.SqlExecute(lcSql,'CsTmpPed') < 1 / Messagebox(
832:     *       'Favor Reinicializar o Processo!!!') / Return 0 / Endif
833:     *   Select CsTmpPed / Index On nCors Tag nCors / Index On Abrevs Tag Abrevs
834:     *
835:     * Popula CsTmpPed - cursor LOCAL consumido por ValidarPedido/
836:     * AbrirBuscaPedido (Fase 6, fwbuscasel). "TprMvCab.Dopes" eh o cursor do
837:     * form PAI de movimentacao (visivel aqui via SET DATASESSION TO
838:     * par_nDataSessionPai, no Init) - sem ele (harness de teste/
839:     * ValidarUIFidelity, instanciado sem form pai) a consulta eh pulada sem
840:     * erro, mesmo padrao das demais chamadas a THIS.this_oFormPai neste
841:     * arquivo. SqlExecute do legado mapeia para SQLEXEC(gnConnHandle, ...)
842:     * direto (regra do projeto - sem fSqlConector nesta arquitetura), mesmo
843:     * padrao de AbrirLookupTamanho.
844:     *
845:     * Retorna .F. somente quando a consulta FOI tentada (conexao e
846:     * TprMvCab disponiveis) e falhou - equivalente ao "Return 0" do Init
847:     * legado, que aborta a abertura do form inteiro.
848:     *==========================================================================
849:     PROTECTED PROCEDURE CarregarPedidosDisponiveis()
850:         LOCAL loc_cDopes, loc_cSQL, loc_nResultado, loc_lResultado, loc_oErro
851: 
852:         loc_lResultado = .T.
853: 
854:         IF !USED("TprMvCab") OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
855:             RETURN loc_lResultado
856:         ENDIF
857: 
858:         TRY
859:             loc_cDopes = TratarNulo(TprMvCab.Dopes, "")
860: 
861:             loc_cSQL = "SELECT a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs, " + ;
862:                 "a.opers, b.abrevs, b.CadProds, b.Desmembs " + ;
863:                 "FROM SigCdMop a, SigCdOpe b, SigOpCdc c, SigOpCdi d " + ;
864:                 "WHERE a.cDopes = " + EscaparSQL(loc_cDopes) + " " + ;
865:                 "AND a.cnivels = b.dopes AND b.Abrevs <> ' ' " + ;
866:                 "AND b.Dopes = c.Dopes AND b.Dopes = d.Dopes AND c.OpeInatvs <> 1"
867: 
868:             IF USED("CsTmpPed")
869:                 USE IN CsTmpPed
870:             ENDIF
871: 
872:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpPed")
873: 
874:             IF loc_nResultado < 1
875:                 MsgAviso("Favor Reinicializar o Processo!!!", ;
876:                     "Falha na Conex" + CHR(227) + "o (CsTmpPed)")
877:                 loc_lResultado = .F.
878:             ELSE
879:                 SELECT CsTmpPed
880:                 INDEX ON nCors  TAG nCors
881:                 INDEX ON Abrevs TAG Abrevs
882:             ENDIF
883:         CATCH TO loc_oErro
884:             MsgErro(loc_oErro.Message + CHR(13) + ;
885:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
886:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarPedidosDisponiveis")
887:             loc_lResultado = .F.
888:         ENDTRY
889: 
890:         RETURN loc_lResultado
891:     ENDPROC
892: 
893:     *==========================================================================
894:     * CarregarDadosProduto - transcricao do restante do Init legado:
895:     *   Select crTpmMvItn / lcCod=Cpros / lcCor=CodCors / lcTam=CodTams
896:     *   Select * from crTpmMvItn Where Cpros=lcCod And CodCors=lcCor And
897:     *       CodTams=lcTam And Empty(Abrevis) Into Cursor csItemAbr ReadWrite
898:     *   Count For Not Empty(Cpros) to lnQtde / getQtde.Value = lnQtde
899:     *   get_Peso.Value = crTpmMvItn.Pesos
900:     *   Say7.Visible=.F. / getTamanho.Visible=.F. / getTamanho.Value=lcTam
901:     *   SqlExecute(Select ... SigCdUni ..., 'crTmpUni') < 1 -> aborta
902:     *   SqlExecute(Select ... SigCdGrp ..., 'crTmpGru') < 1 -> aborta
903:     *   If Empty(lcTam) / If Inlist(crTmpGru.TipoEstos,3,4) / Say7.Visible=.T.
904:     *       / getTamanho.Visible=.T. / Endif / EndIf
905:     *
906:     * Say7/getTamanho nascem ocultos (regra acima) - reaplicado aqui porque
907:     * THIS.TornarControlesVisiveis (chamado antes desta rotina, em
908:     * InicializarForm) forca Visible=.T. em todo controle criado via
909:     * AddObject, inclusive estes dois.
910:     *
911:     * As consultas de SigCdUni/SigCdGrp servem no legado so para abortar a
912:     * tela com "Favor Reinicializar o Processo!!!" se a conexao falhar -
913:     * crTmpUni nunca eh lido depois (unica outra referencia no dump esta
914:     * dentro do bloco de desmembramento, comentado com "*!*" no SCX e NAO
915:     * transcrito - ver cabecalho de BtnSalvarClick); crTmpGru so fornece
916:     * TipoEstos para a visibilidade acima. Por isso os dois sao fechados
917:     * (USE IN) ao final deste metodo.
918:     *
919:     * Puladas (sem erro) em modo de teste/validacao de UI ou sem
920:     * gnConnHandle - mesmo padrao de FormSigOpPec.InicializarForm
921:     * (loc_lModoValidacaoOuTeste). Retorna .F. somente quando a consulta FOI
922:     * tentada e falhou - equivalente ao "Return 0" do Init legado.
923:     *==========================================================================
924:     PROTECTED PROCEDURE CarregarDadosProduto()
925:         LOCAL loc_cCod, loc_cCor, loc_cTam, loc_cSQL, loc_nResultado, ;
926:             loc_nQtdePendente, loc_lResultado, loc_lModoValidacaoOuTeste, ;
927:             loc_oErro
928: 
929:         loc_lResultado = .T.
930: 
931:         THIS.lbl_4c_Label7.Visible  = .F.
932:         THIS.txt_4c_Tamanho.Visible = .F.
933: 
934:         IF !USED("crTpmMvItn")
935:             RETURN loc_lResultado
936:         ENDIF
937: 
938:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
939:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
940: 
941:         TRY
942:             SELECT crTpmMvItn
943:             loc_cCod = TratarNulo(cPros, "")
944:             loc_cCor = TratarNulo(CodCors, "")
945:             loc_cTam = TratarNulo(CodTams, "")
946: 
947:             IF USED("csItemAbr")
948:                 USE IN csItemAbr
949:             ENDIF
950: 
951:             *-- m. explicito nas variaveis locais (regra do projeto - SELECT
952:             *-- VFP local sem m. resolve o identificador como COLUNA e
953:             *-- estoura "Column 'LOC_CXXX' is not found"), mesmo padrao do
954:             *-- SELECT identico em BtnSalvarClick.
955:             SELECT cItens FROM crTpmMvItn ;
956:                 WHERE cPros = m.loc_cCod AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam ;
957:                     AND EMPTY(Abrevis) ;
958:                 INTO CURSOR csItemAbr READWRITE
959: 
960:             loc_nQtdePendente = RECCOUNT("csItemAbr")
961: 
962:             IF USED("csItemAbr")
963:                 USE IN csItemAbr
964:             ENDIF

*-- Linhas 989 a 1120:
989:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpUni")
990: 
991:                 IF loc_nResultado < 1
992:                     MsgAviso("Favor Reinicializar o Processo!!!", ;
993:                         "Falha na Conex" + CHR(227) + "o (crTmpUni)")
994:                     loc_lResultado = .F.
995:                 ELSE
996:                     IF USED("crTmpGru")
997:                         USE IN crTmpGru
998:                     ENDIF
999: 
1000:                     loc_cSQL = "SELECT a.* FROM SigCdGrp a JOIN SigCdPro b ON a.CGrus = b.CGrus " + ;
1001:                         "WHERE b.Cpros = " + EscaparSQL(loc_cCod)
1002:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpGru")
1003: 
1004:                     IF loc_nResultado < 1
1005:                         MsgAviso("Favor Reinicializar o Processo!!!", ;
1006:                             "Falha na Conex" + CHR(227) + "o (crTmpGru)")
1007:                         loc_lResultado = .F.
1008:                     ELSE
1009:                         IF EMPTY(loc_cTam)
1010:                             SELECT crTmpGru
1011:                             IF INLIST(crTmpGru.TipoEstos, 3, 4)
1012:                                 THIS.lbl_4c_Label7.Visible  = .T.
1013:                                 THIS.txt_4c_Tamanho.Visible = .T.
1014:                             ENDIF
1015:                         ENDIF
1016: 
1017:                         IF USED("crTmpGru")
1018:                             USE IN crTmpGru
1019:                         ENDIF
1020:                     ENDIF
1021:                 ENDIF
1022: 
1023:                 IF USED("crTmpUni")
1024:                     USE IN crTmpUni
1025:                 ENDIF
1026:             ENDIF
1027:         CATCH TO loc_oErro
1028:             MsgErro(loc_oErro.Message + CHR(13) + ;
1029:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1030:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDadosProduto")
1031:             loc_lResultado = .F.
1032:         ENDTRY
1033: 
1034:         RETURN loc_lResultado
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * ValidarPedido - equivale ao "PROCEDURE Valid" de GetPedido do legado:
1039:     * valida a abreviacao de pedido digitada contra o cursor LOCAL CsTmpPed
1040:     * (populado pelo Init deste form - Fase 8). fwbuscasel pesquisa um
1041:     * cursor VFP ja em memoria, NUNCA SQL Server - por isso o lookup usa
1042:     * AbrirBuscaPedido/FormBuscaAuxiliar.DefinirCursor() (Pattern A, regra
1043:     * CLAUDE.md #36/#37), nao o Init(gnConnHandle, ...) canonico de tabela.
1044:     *
1045:     * PUBLIC - exigido pelo BINDEVENT (regra #3). Ligado a "LostFocus", nao
1046:     * "KeyPress" (regra #47). Guarda this_lEmLookupPedido evita picker
1047:     * duplicado quando o Show() modal do lookup redispara este LostFocus.
1048:     *
1049:     * SEEK(..., "CsTmpPed", "Abrevs") exige o INDEX ON Abrevs TAG Abrevs do
1050:     * Init legado (ver Fase 8) - aqui so consome, sem recriar o indice.
1051:     *
1052:     * THIS.this_oFormPai.ValidaEstoque()/Calc_valite() sao metodos do form
1053:     * de movimentacao que abre este dialogo - fora do escopo de task779 -
1054:     * chamados so quando o objeto e o metodo existem (regra CLAUDE.md sobre
1055:     * chamada de property/metodo de objeto que o migrado local nao
1056:     * declara), para o form nao estourar "Property X is not found" quando
1057:     * instanciado sem pai (harness de teste/ValidarUIFidelity). O legado
1058:     * referencia "CsPedidos.cNivels" nesta chamada - unica ocorrencia desse
1059:     * nome em todo o dump (provavel residuo de copia de form irmao, ex.
1060:     * SIGOPPRM) - transcrito como "CsTmpPed.cNivels" (cursor e coluna que
1061:     * REALMENTE existem neste form, alimentados pelo mesmo Init que
1062:     * dispara este Valid), guardado por USED("CsTmpPed").
1063:     *
1064:     * Sem RETURN dentro do TRY (regra CLAUDE.md #1) - loc_lEstoqueOk
1065:     * substitui o "Return .f." do meio do metodo legado.
1066:     *==========================================================================
1067:     PROCEDURE ValidarPedido()
1068:         LOCAL loc_cValor, loc_lEstoqueOk, loc_oErro
1069: 
1070:         IF THIS.this_lEmLookupPedido
1071:             RETURN
1072:         ENDIF
1073: 
1074:         loc_cValor = ALLTRIM(THIS.txt_4c_Pedido.Value)
1075: 
1076:         *-- Guarda de valor-nao-mudou (regra CLAUDE.md #47): LostFocus
1077:         *-- dispara sempre, mesmo sem o usuario ter alterado o campo -
1078:         *-- sem isto o lookup/validacao de estoque repetiria a cada
1079:         *-- passagem pelo campo, mesmo sem digitacao nova.
1080:         IF loc_cValor == THIS.this_cUltimoValidarPedidoValidado
1081:             RETURN
1082:         ENDIF
1083: 
1084:         loc_lEstoqueOk = .T.
1085: 
1086:         TRY
1087:             IF !EMPTY(loc_cValor)
1088:                 IF USED("CsTmpPed")
1089:                     SELECT CsTmpPed
1090:                     IF !SEEK(loc_cValor, "CsTmpPed", "Abrevs")
1091:                         THIS.this_lEmLookupPedido = .T.
1092:                         THIS.AbrirBuscaPedido()
1093:                         THIS.this_lEmLookupPedido = .F.
1094:                     ENDIF
1095:                 ENDIF
1096: 
1097:                 IF USED("crTpmMvItn")
1098:                     SELECT crTpmMvItn
1099: 
1100:                     IF TYPE("THIS.txt_4c_Pedido.Value") != TYPE("THIS.this_cAntValu") OR ;
1101:                             THIS.txt_4c_Pedido.Value != THIS.this_cAntValu
1102:                         REPLACE UsuLibSal WITH " " IN crTpmMvItn
1103:                     ENDIF
1104: 
1105:                     IF VARTYPE(THIS.this_oFormPai) = "O" AND USED("CsTmpPed") AND ;
1106:                             PEMSTATUS(THIS.this_oFormPai, "ValidaEstoque", 5)
1107:                         loc_lEstoqueOk = THIS.this_oFormPai.ValidaEstoque(CsTmpPed.cNivels)
1108:                     ENDIF
1109: 
1110:                     IF loc_lEstoqueOk
1111:                         REPLACE ChkAbrevs WITH .F. IN crTpmMvItn
1112:                     ELSE
1113:                         THIS.txt_4c_Pedido.Value = ""
1114:                     ENDIF
1115:                 ENDIF
1116: 
1117:                 IF loc_lEstoqueOk
1118:                     THIS.this_cAntValu = THIS.txt_4c_Pedido.Value
1119:                 ENDIF
1120:             ELSE

*-- Linhas 1128 a 1418:
1128:             *-- so apos a validacao ter rodado sem excecao. Le o valor ATUAL
1129:             *-- do campo (nao loc_cValor) porque o lookup/estoque invalido
1130:             *-- pode te-lo alterado dentro deste mesmo TRY.
1131:             THIS.this_cUltimoValidarPedidoValidado = ALLTRIM(THIS.txt_4c_Pedido.Value)
1132:         CATCH TO loc_oErro
1133:             THIS.this_lEmLookupPedido = .F.
1134:             MsgErro(loc_oErro.Message + CHR(13) + ;
1135:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1136:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedido")
1137:         ENDTRY
1138:     ENDPROC
1139: 
1140:     *==========================================================================
1141:     * AbrirBuscaPedido - replica "CreateObject('fwbuscasel', 'CsTmpPed',
1142:     * 'Abrevs', This.Value, 'Sele??o')" + AddColuna('Abrevs','','Abrev') +
1143:     * AddColuna('cNivels','','Opera??o') do legado. fwbuscasel busca num
1144:     * CURSOR LOCAL ja em memoria - usa FormBuscaAuxiliar.DefinirCursor()/
1145:     * .Mostrar() (Pattern A) em vez do Init(gnConnHandle, <tabela>, ...)
1146:     * canonico de SQL Server (regra CLAUDE.md #36/#37).
1147:     *
1148:     * DefinirCursor() ja chama mAddColuna() internamente com o nome do
1149:     * campo como titulo (Cods/Abrevs) - resetar this_nColunas = 0 e chamar
1150:     * mAddColuna() de novo para usar os titulos reais do legado ("Abrev"/
1151:     * "Opera??o"), sem reimplementar o resto da configuracao do grid.
1152:     *==========================================================================
1153:     PROCEDURE AbrirBuscaPedido()
1154:         LOCAL loc_oBusca, loc_oErro
1155: 
1156:         IF !USED("CsTmpPed")
1157:             RETURN
1158:         ENDIF
1159: 
1160:         TRY
1161:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1162:             loc_oBusca.DefinirCursor("CsTmpPed", "Abrevs", "cNivels", ;
1163:                 "Sele" + CHR(231) + CHR(227) + "o")
1164:             loc_oBusca.this_nColunas = 0
1165:             loc_oBusca.mAddColuna("Abrevs", "", "Abrev")
1166:             loc_oBusca.mAddColuna("cNivels", "", "Opera" + CHR(231) + CHR(227) + "o")
1167: 
1168:             IF loc_oBusca.Mostrar()
1169:                 THIS.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
1170:             ENDIF
1171: 
1172:             loc_oBusca.Release()
1173:         CATCH TO loc_oErro
1174:             MsgErro(loc_oErro.Message + CHR(13) + ;
1175:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaPedido")
1177:         ENDTRY
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * ValidarTamanho - equivale ao "PROCEDURE Valid" de getTamanho do
1182:     * legado: valida o codigo de tamanho digitado contra SigCdTam (tabela
1183:     * SQL Server, via gnConnHandle - lookup canonico FormBuscaAuxiliar,
1184:     * regra CLAUDE.md #36/#37). PUBLIC (regra #3), ligado a "LostFocus"
1185:     * (regra #47). Guarda this_lEmLookupTamanho evita picker duplicado.
1186:     *==========================================================================
1187:     PROCEDURE ValidarTamanho()
1188:         LOCAL loc_cValor, loc_oErro
1189: 
1190:         IF THIS.this_lEmLookupTamanho
1191:             RETURN
1192:         ENDIF
1193: 
1194:         loc_cValor = ALLTRIM(THIS.txt_4c_Tamanho.Value)
1195: 
1196:         *-- Guarda de valor-nao-mudou (regra CLAUDE.md #47): LostFocus
1197:         *-- dispara sempre, mesmo sem o usuario ter alterado o campo -
1198:         *-- sem isto o lookup reabriria a cada passagem pelo campo.
1199:         IF loc_cValor == THIS.this_cUltimoValidarTamanhoValidado
1200:             RETURN
1201:         ENDIF
1202: 
1203:         TRY
1204:             IF !EMPTY(loc_cValor)
1205:                 THIS.this_lEmLookupTamanho = .T.
1206:                 THIS.AbrirLookupTamanho()
1207:                 THIS.this_lEmLookupTamanho = .F.
1208:             ELSE
1209:                 THIS.txt_4c_Tamanho.Value = ""
1210:             ENDIF
1211: 
1212:             *-- Registrada so apos a validacao ter rodado sem excecao.
1213:             THIS.this_cUltimoValidarTamanhoValidado = ALLTRIM(THIS.txt_4c_Tamanho.Value)
1214:         CATCH TO loc_oErro
1215:             THIS.this_lEmLookupTamanho = .F.
1216:             MsgErro(loc_oErro.Message + CHR(13) + ;
1217:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1218:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTamanho")
1219:         ENDTRY
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * AbrirLookupTamanho - replica "CreateObject('fwbuscaext',
1224:     * Thisform.PodataMgr.pnIdConn, 'SigCdTam', 'crListaRemota', 'Cods',
1225:     * Padr(this.Value,4), 'Sele??o', .T.)" + AddColuna('Cods','','C?digo')
1226:     * + AddColuna('Descs','','Descri??o') do legado, no contrato canonico
1227:     * do projeto (regra CLAUDE.md #37): Init ja tenta o match exato
1228:     * (this_lAchouRegistro) - Show() so roda se NAO achou, e a atribuicao
1229:     * so ocorre sob this_lSelecionou AND USED(cursor).
1230:     *==========================================================================
1231:     PROCEDURE AbrirLookupTamanho()
1232:         LOCAL loc_oBusca, loc_oErro
1233: 
1234:         TRY
1235:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
1236:                 "cursor_4c_BuscaTamanho", "Cods", PADR(THIS.txt_4c_Tamanho.Value, 4), ;
1237:                 "Sele" + CHR(231) + CHR(227) + "o")
1238: 
1239:             IF !loc_oBusca.this_lAchouRegistro
1240:                 loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1241:                 loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1242:                 loc_oBusca.Show()
1243:             ENDIF
1244: 
1245:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
1246:                 SELECT cursor_4c_BuscaTamanho
1247:                 THIS.txt_4c_Tamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.Cods)
1248:             ENDIF
1249: 
1250:             IF USED("cursor_4c_BuscaTamanho")
1251:                 USE IN cursor_4c_BuscaTamanho
1252:             ENDIF
1253: 
1254:             loc_oBusca.Release()
1255:         CATCH TO loc_oErro
1256:             MsgErro(loc_oErro.Message + CHR(13) + ;
1257:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1258:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupTamanho")
1259:         ENDTRY
1260:     ENDPROC
1261: 
1262:     *==========================================================================
1263:     * ValidarRepetir - equivale ao "PROCEDURE Valid" de getRepetir do
1264:     * legado: nao eh lookup, apenas limita o valor digitado a GetQtde.Value
1265:     * (quantidade de itens sem abreviacao). MESSAGEBOX do legado substituido por
1266:     * MsgAviso (regra CLAUDE.md - MESSAGEBOX PROIBIDO; validacao de UI usa
1267:     * MsgAviso, nao MsgErro). PUBLIC (regra #3), ligado a "LostFocus".
1268:     *==========================================================================
1269:     PROCEDURE ValidarRepetir()
1270:         IF !EMPTY(THIS.txt_4c_Repetir.Value) AND !EMPTY(THIS.txt_4c_Qtde.Value)
1271:             IF THIS.txt_4c_Repetir.Value > THIS.txt_4c_Qtde.Value
1272:                 MsgAviso("Quantidade Maior que a Quantidade de Itens.", ;
1273:                     "Aten" + CHR(231) + CHR(227) + "o")
1274:                 THIS.txt_4c_Repetir.Value = THIS.txt_4c_Qtde.Value
1275:             ENDIF
1276:         ENDIF
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * BtnSairClick - equivale a "PROCEDURE btnSair.Click" do legado: reabilita
1281:     * o form pai (ficava Enabled=.F. enquanto este dialogo modal estava aberto
1282:     * - ver comportamento.json/this_oFormPai) e fecha o dialogo. PUBLIC -
1283:     * exigido pelo BINDEVENT em ConfigurarBotaoAcao (regra CLAUDE.md #3).
1284:     *==========================================================================
1285:     PROCEDURE BtnSairClick()
1286:         IF VARTYPE(THIS.this_oFormPai) = "O"
1287:             THIS.this_oFormPai.Enabled = .T.
1288:         ENDIF
1289: 
1290:         THIS.Release()
1291:     ENDPROC
1292: 
1293:     *==========================================================================
1294:     * FormParaBO - transfere para o Business Object os campos digitados
1295:     * neste dialogo (Pedido/Repetir/Peso/Tamanho novo - txt_4c_Pedido/
1296:     * txt_4c_Repetir/txt_4c_Peso/txt_4c_Tamanho) junto com o produto/cor/
1297:     * tamanho ATUAL do item (txt_4c__prod/txt_4c_Cor/txt_4c_Tam, ligados por
1298:     * .ControlSource a crTpmMvItn - ver ConfigurarCamposProduto), usados pelo
1299:     * BO para localizar o(s) item(ns) sem abreviacao em crTpmMvItn. Chamado por
1300:     * BtnSalvarClick antes de THIS.this_oBusinessObject.Atualizar() (PILAR 3 -
1301:     * a gravacao passa pela camada de negocio em vez de manipular o cursor
1302:     * direto no Form).
1303:     *==========================================================================
1304:     PROCEDURE FormParaBO()
1305:         WITH THIS.this_oBusinessObject
1306:             .this_cProduto     = ALLTRIM(THIS.txt_4c__prod.Value)
1307:             .this_cCor         = ALLTRIM(THIS.txt_4c_Cor.Value)
1308:             .this_cTamanho     = ALLTRIM(THIS.txt_4c_Tam.Value)
1309:             .this_cTamanhoNovo = ALLTRIM(THIS.txt_4c_Tamanho.Value)
1310:             .this_cPedido      = ALLTRIM(THIS.txt_4c_Pedido.Value)
1311:             .this_nQtde        = THIS.txt_4c_Qtde.Value
1312:             .this_nRepetir     = THIS.txt_4c_Repetir.Value
1313:             .this_nPeso        = THIS.txt_4c_Peso.Value
1314:         ENDWITH
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * BOParaForm - contrapartida de FormParaBO: pinta na tela o que o Business
1319:     * Object carregou do cursor crTpmMvItn (CarregarDoCursor) mais os dois
1320:     * valores que o Init legado CALCULA em vez de ler ("Count For Not
1321:     * Empty(Cpros) to lnQtde" -> this_nQtde e "ThisForm.getTamanho.Value =
1322:     * lcTam" -> this_cTamanhoNovo). Chamado por CarregarDadosProduto, que eh
1323:     * a porta de entrada unica da carga desta tela.
1324:     *
1325:     * NAO toca txt_4c__prod/txt_4c_DPros/txt_4c_Cor/txt_4c_Tam: os quatro tem
1326:     * .ControlSource = "crTpmMvItn.<coluna>" (transcrito do dump - ver
1327:     * ConfigurarCamposProduto) e portanto se pintam sozinhos a partir do
1328:     * cursor; atribuir .Value por cima brigaria com o binding e GRAVARIA no
1329:     * cursor do form PAI o valor atribuido. As properties equivalentes do BO
1330:     * (this_cProduto/this_cDescProduto/this_cCor/this_cTamanho) seguem sendo
1331:     * carregadas - sao elas que FormParaBO entrega de volta ao BO como chave
1332:     * de localizacao do item a gravar.
1333:     *
1334:     * Refresh() explicito nos dois campos pintados por codigo, como o legado
1335:     * faz ("ThisForm.getQtde.Refresh" / "ThisForm.get_Peso.Refresh").
1336:     *==========================================================================
1337:     PROCEDURE BOParaForm()
1338:         WITH THIS.this_oBusinessObject
1339:             THIS.txt_4c_Qtde.Value    = .this_nQtde
1340:             THIS.txt_4c_Peso.Value    = .this_nPeso
1341:             THIS.txt_4c_Tamanho.Value = .this_cTamanhoNovo
1342:         ENDWITH
1343: 
1344:         THIS.txt_4c_Qtde.Refresh()
1345:         THIS.txt_4c_Peso.Refresh()
1346:     ENDPROC
1347: 
1348:     *==========================================================================
1349:     * BtnSalvarClick - equivale a "PROCEDURE btnGravar.Click" do legado:
1350:     * aplica a abreviacao/peso/tamanho digitados neste dialogo nos itens
1351:     * sem abreviacao do cursor crTpmMvItn (mantido pelo form pai, visivel aqui via
1352:     * SET DATASESSION TO par_nDataSessionPai - ver Init), repetindo a
1353:     * operacao THIS.txt_4c_Repetir.Value vezes (um item por repeticao). A
1354:     * gravacao em si (o laco FOR 1 TO Repetir + localizacao do proximo item
1355:     * sem abreviacao + REPLACE Abrevis/Pesos/CodTams, incluindo a replicacao
1356:     * para o item-pai cItem2=0 e para o operador via CsTmpPed.Opers) esta em
1357:     * sigoppedBO.GravarAbreviacaoNosItens() (regra CLAUDE.md PILAR 3 - Form
1358:     * nao manipula cursor de persistencia direto, delega ao Business
1359:     * Object); aqui so FormParaBO() + THIS.this_oBusinessObject.Atualizar()
1360:     * (metodo PUBLIC do BO chamado direto pelo Form, regra CLAUDE.md #51 -
1361:     * nao precisa passar por EditarRegistro()/Salvar() porque este dialogo
1362:     * nao tem o ciclo classico "carregar um registro, editar, salvar": cada
1363:     * clique em Gravar localiza dinamicamente, a cada repeticao, o PROXIMO
1364:     * item ainda sem abreviacao - BusinessBase.Atualizar()/Inserir() sao
1365:     * identicos aqui de proposito, ver Init do BO).
1366:     *
1367:     * Os 5 flags (_CarregaItens, _ChecaQtde, _ChecaOper, _ValidaGrade,
1368:     * _SubNiv) que o legado calcula mas NUNCA consome no restante do metodo
1369:     * em SIGOPPED.SCX sao vestigios de validacao ja removida, sem efeito
1370:     * observavel - mantidos aqui so por fidelidade (leitura pura, sem
1371:     * side-effect, transcrita LITERALMENTE do dump - regra CLAUDE.md #17).
1372:     *
1373:     * O bloco de insercao em crTpmMvIts (desmembramento por Qtds, linhas
1374:     * comentadas com "*!*" no SCX legado) estava DESATIVADO no legado e NAO
1375:     * eh transcrito - reativa-lo seria inventar comportamento que a producao
1376:     * atual nao tem.
1377:     *==========================================================================
1378:     PROCEDURE BtnSalvarClick()
1379:         LOCAL loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper, ;
1380:             loc_lValidaGrade, loc_lSubNiv, loc_lGravou, loc_oErro
1381: 
1382:         loc_lGravou = .F.
1383: 
1384:         TRY
1385:             *-- Flags vestigiais do legado (ver cabecalho): a leitura fica
1386:             *-- GUARDADA por USED()/PEMSTATUS porque, sem guarda, um alias
1387:             *-- ausente estoura e cai no CATCH ANTES da gravacao - codigo
1388:             *-- morto mataria o unico trabalho real do botao. As expressoes
1389:             *-- seguem LITERAIS (regra CLAUDE.md #17); so o acesso eh
1390:             *-- condicionado.
1391:             IF USED("crSigCdOpe") AND USED("crSigOpCdc") AND USED("crSigOpCdi") ;
1392:                     AND USED("crTpmMvItn") AND VARTYPE(THIS.this_oFormPai) = "O" ;
1393:                     AND PEMSTATUS(THIS.this_oFormPai, "Op_escolha", 5)
1394:                 loc_lCarregaItens = INLIST(crSigCdOpe.ItAutos, 1, 3, 4, 5) AND ;
1395:                     THIS.this_oFormPai.Op_escolha = "INSERIR"
1396:                 loc_lChecaQtde = INLIST(crSigCdOpe.ChkQtdss, 1, 3, 4)
1397:                 loc_lChecaOper = (EMPTY(crSigOpCdc.ChkOpers) OR ;
1398:                     crTpmMvItn.Opers = crSigOpCdc.ChkOpers)
1399:                 loc_lValidaGrade = (THIS.this_oFormPai.Op_escolha = "INSERIR" AND ;
1400:                     crSigOpCdi.ValQtdSup = 1)
1401:             ENDIF
1402: 
1403:             IF USED("TmpOperacao")
1404:                 SELECT TmpOperacao
1405:                 loc_lSubNiv = .F.
1406:                 SCAN FOR !EMPTY(Codigos)
1407:                     loc_lSubNiv = .T.
1408:                 ENDSCAN
1409:             ENDIF
1410: 
1411:             THIS.FormParaBO()
1412: 
1413:             *-- Falha de gravacao NUNCA eh muda (regra CLAUDE.md #20): aqui o
1414:             *-- BO eh chamado por Atualizar() direto - fora do Salvar() da
1415:             *-- BusinessBase, que eh quem chama ExibirFalha() -, entao a
1416:             *-- mensagem fica por conta deste chamador quando o BO nao a
1417:             *-- exibiu (this_lErroExibido = .F.). E o dialogo so fecha quando
1418:             *-- GRAVOU: com erro ele permanece aberto para o usuario corrigir

*-- Linhas 1442 a 1493:
1442:         CATCH TO loc_oErro
1443:             MsgErro(loc_oErro.Message + CHR(13) + ;
1444:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1445:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
1451:     * criados via AddObject (que nascem com Visible = .F.). Percorre Pages de
1452:     * PageFrame (nao ha nenhum neste form, mas o metodo fica generico/
1453:     * reutilizavel para as fases seguintes) e Controls de Container.
1454:     *==========================================================================
1455:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1456:         LOCAL loc_nI, loc_oObjeto
1457: 
1458:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1459:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1460: 
1461:             IF VARTYPE(loc_oObjeto) = "O"
1462:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1463:                     loc_oObjeto.Visible = .T.
1464:                 ENDIF
1465: 
1466:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1467:                     LOCAL loc_nP
1468:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1469:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1470:                     ENDFOR
1471:                 ENDIF
1472: 
1473:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1474:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1475:                 ENDIF
1476:             ENDIF
1477:         ENDFOR
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * Destroy - equivale a "PROCEDURE Release" do legado (que so chamava
1482:     * "ThisForm.poDataMgr.Release" + DoDefault). poDataMgr nao existe nesta
1483:     * arquitetura (gnConnHandle eh compartilhado via config.prg, nao
1484:     * instanciado por form) - nada a liberar alem do que FormBase.Destroy()
1485:     * ja faz. DODEFAULT() OBRIGATORIO (regra CLAUDE.md Pattern #145 - sem
1486:     * ele os popups do menu principal ficam com cache visual encolhido apos
1487:     * este dialogo modal fechar).
1488:     *==========================================================================
1489:     PROCEDURE Destroy()
1490:         RETURN DODEFAULT()
1491:     ENDPROC
1492: 
1493: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoppedBO.prg):
*==============================================================================
* sigoppedBO.prg - Business Object para Formsigopped (Informar Pedido)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) que NAO possui tabela
* propria no SQL Server. Ele le/atualiza o cursor crTpmMvItn, que pertence ao
* FORM PAI (tela de movimentacao que abre este dialogo) - por isso
* this_cTabela fica vazio e this_cCampoChave aponta para a chave do ITEM
* dentro desse cursor (cItens), usada pelo legado em
* "Update crTpmMvItn Set ... Where cItens = lnItem".
*==============================================================================
DEFINE CLASS sigoppedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (campos exibidos/manipulados pelo dialogo Informar Pedido)
    *--------------------------------------------------------------------------
    this_cItens        = ""   && cItens - chave do item em crTpmMvItn (form pai)
    this_cProduto      = ""   && crTpmMvItn.cPros - codigo do produto
    this_cDescProduto  = ""   && crTpmMvItn.DPros - descricao do produto
    this_cCor          = ""   && crTpmMvItn.CodCors - codigo da cor
    this_cTamanho      = ""   && crTpmMvItn.CodTams - tamanho atual do item
    this_cTamanhoNovo  = ""   && tamanho escolhido na grade (quando TipoEstos em 3,4)
    this_cPedido       = ""   && CsTmpPed.Abrevs - abreviacao do pedido/vendedor
    this_nQtde         = 0    && quantidade de itens sem abreviacao
    this_nRepetir      = 0    && quantidade de itens a repetir com a mesma abreviacao
    this_nPeso         = 0    && crTpmMvItn.Pesos - peso do item

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
                THIS.this_cCampoChave = "cItens"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega para as propriedades os dados do item
    * corrente de crTpmMvItn (cursor do form pai) - equivalente as leituras
    * lcCod/lcCor/lcTam/Pesos feitas pelo Init do dialogo legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cItens       = TRANSFORM(TratarNulo(cItens, 0))
                THIS.this_cProduto     = TratarNulo(cPros, "")
                THIS.this_cDescProduto = TratarNulo(DPros, "")
                THIS.this_cCor         = TratarNulo(CodCors, "")
                THIS.this_cTamanho     = TratarNulo(CodTams, "")
                THIS.this_nPeso        = TratarNulo(Pesos, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do item em crTpmMvItn (cursor do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cItens
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor crTpmMvItn do form pai via REPLACE - ver Init, que
    * por isso deixa this_cTabela vazio de proposito). Sobrescrito aqui so
    * para o log de auditoria identificar o cursor afetado em vez de uma
    * tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("crTpmMvItn") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este dialogo nunca cria item novo em crTpmMvItn (os itens
    * sem abreviacao ja existem, criados pelo form pai antes de
    * abrir "Informar Pedido"); gravar eh sempre a mesma operacao do legado
    * btnGravar.Click, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava a abreviacao (pedido), o peso e o tamanho novo nos
    * itens sem abreviacao de crTpmMvItn - equivalente ao btnGravar.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarAbreviacaoNosItens - Transcricao de SIGOPPED.OK.btnGravar.Click:
    * para cada repeticao pedida (this_nRepetir), localiza em crTpmMvItn o
    * proximo item do MESMO produto/cor/tamanho ainda sem abreviacao
    * (Abrevis vazio) e grava a abreviacao do pedido, o peso e o tamanho
    * escolhido; replica tambem para o item-pai (cItem2 = 0) e para o
    * operador do pedido (CsTmpPed.Opers), quando existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarAbreviacaoNosItens()
        LOCAL loc_lResultado, loc_nContador, loc_nItem, loc_oErro

        loc_lResultado = .F.

        *-- Estado de erro zerado a cada tentativa, como BusinessBase.Salvar()
        *-- faz: sem isto a mensagem de uma falha anterior sobreviveria e o
        *-- chamador (Formsigopped.BtnSalvarClick) a exibiria de novo.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "Cursor de itens do pedido (crTpmMvItn) n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                FOR loc_nContador = 1 TO THIS.this_nRepetir
                    SELECT cItens FROM crTpmMvItn ;
                        WHERE cPros = THIS.this_cProduto ;
                          AND CodCors = THIS.this_cCor ;
                          AND CodTams = THIS.this_cTamanho ;
                          AND EMPTY(Abrevis) ;
                        INTO CURSOR csItemAbr READWRITE

                    IF RECCOUNT("csItemAbr") > 0
                        loc_nItem = csItemAbr.cItens

                        SELECT crTpmMvItn
                        REPLACE Abrevis WITH THIS.this_cPedido, ;
                                Pesos   WITH THIS.this_nPeso, ;
                                CodTams WITH THIS.this_cTamanhoNovo ;
                            FOR cItens = loc_nItem

                        IF USED("CsTmpPed") AND !EMPTY(CsTmpPed.Opers)
                            SELECT crTpmMvItn
                            REPLACE Opers WITH CsTmpPed.Opers FOR cItem2 = loc_nItem
                        ENDIF

                        *-- Posiciona explicitamente no item gravado (o legado
                        *-- conta com o ponteiro deixado pelo SELECT anterior,
                        *-- o que o VFP9 nao garante) antes de conferir se eh
                        *-- item de topo (cItem2 = 0).
                        SELECT crTpmMvItn
                        LOCATE FOR cItens = loc_nItem

                        IF FOUND() AND crTpmMvItn.cItem2 = 0 AND RECCOUNT("crTpmMvItn") > 0
                            REPLACE Abrevis WITH THIS.this_cPedido FOR cItem2 = loc_nItem
                        ENDIF
                    ENDIF
                ENDFOR

                IF USED("csItemAbr")
                    USE IN csItemAbr
                ENDIF

                loc_lResultado = .T.
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar pedido nos itens: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            *-- Marca a falha como JA exibida para o chamador nao repetir a
            *-- mensagem (mesmo contrato de BusinessBase.ExibirFalha()).
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


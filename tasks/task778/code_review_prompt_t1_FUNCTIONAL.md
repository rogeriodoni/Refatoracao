# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C__PAG. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPPEC.Cnt_Pag): Top original=24 vs migrado 'lbl_4c_Label1' Top=122 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPPEC.Cnt_Pag): Left original=66 vs migrado 'lbl_4c_Label1' Left=2 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command4' (parent: SIGOPPEC.Cnt_Pag): Top original=12 vs migrado 'cmd_4c_Command4' Top=82 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command4' (parent: SIGOPPEC.Cnt_Pag): Left original=223 vs migrado 'cmd_4c_Command4' Left=528 (diff=305px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPec.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2549 linhas total):

*-- Linhas 38 a 94:
38: * BOTOES_CONSULTA.Buttons(4)) e o CommandGroup de navegacao BOTOES_CONSULTA
39: * (Proxima Pagina/Pagina Anterior/Encerrar/Selecionar Pagina).
40: * Fase 5/8: primeiros 4 dos 7 botoes de acao standalone do topo
41: * (cmd_4c_GeraArquivo/cmd_4c_Command2/cmd_4c_Command1/cmd_4c_Exporta).
42: * Fase 6/8: os 3 botoes restantes (cmd_4c_Relpecas/cmd_4c_Command3/
43: * cmd_4c_Command4 - "Imprimir Produtos"/"Desmarcar Todos"/"Selecionar
44: * Todos") e os eventos dos CAMPOS da tela, ligados por BINDEVENT em
45: * VincularEventosCampos:
46: *   - Cnt_Pag.Text1.LostFocus -> ValidarPaginaSelecionada (validacao do
47: *     numero de pagina digitado + posicionamento de CrProdutos/Tmp_Imagens)
48: *   - Cnt_Pag.Command4.Click  -> FecharPainelPaginacao
49: *   - Imagem<N>.Check1.Click  -> ChkImagem<N>Click -> ChkImp(slot, N)
50: *     (marca/desmarca o produto no cursor de selecao CrImagens)
51: * NAO existe lookup nesta tela: o dump do legado nao tem fwBuscaExt/
52: * fwBuscaSel/fwBuscaInt/sigacess/mAddColuna em lugar nenhum, e o unico campo
53: * digitavel (Cnt_Pag.Text1, numero de pagina) nao consulta tabela de apoio -
54: * inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra "NUNCA
55: * inventar tabelas de lookup que nao existem no original". Por isso a Fase 6
56: * entrega a validacao do campo em vez de um picker.
57: * Fase 7/8: eventos principais dos botoes. O prompt padrao do pipeline
58: * (template multi-fase) presume form CRUD e pede BtnIncluirClick/
59: * BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick - esta tela NAO tem
60: * esse conceito (o dump do legado nao tem Incluir/Alterar/Excluir em lugar
61: * nenhum: SIGOPPEC so navega paginas de produtos e marca/desmarca selecao).
62: * Os "eventos principais dos botoes" REAIS desta tela, pelo proprio
63: * roteiro das fases anteriores (comentario acima, Fase 6), sao os 7 botoes
64: * de acao do topo + os 4 botoes de BOTOES_CONSULTA, com a paginacao
65: * (PagInicial/MostFig) como suporte - entregues nesta fase:
66: *   - cmd_4c_GeraArquivo.Click  -> CmdGeraArquivoClick   (Do Form SigOpGar)
67: *   - cmd_4c_Command2.Click     -> CmdDesmarcarTelaClick  (Desmarcar Tela)
68: *   - cmd_4c_Command1.Click     -> CmdSelecionarTelaClick (Selecionar Tela)
69: *   - cmd_4c_Exporta.Click      -> CmdExportaClick        (Exportar Imagens)
70: *   - cmd_4c_Relpecas.Click     -> CmdRelPecasClick        (Imprimir Produtos)
71: *   - cmd_4c_Command3.Click     -> CmdDesmarcarTodosClick (Desmarcar Todos)
72: *   - cmd_4c_Command4.Click     -> CmdSelecionarTodosClick (Selecionar Todos)
73: *   - BOTOES_CONSULTA.Buttons(1) "PROXPAG" -> BotoesConsultaProxPagClick
74: *   - BOTOES_CONSULTA.Buttons(2) "ANTPAG"  -> BotoesConsultaAntPagClick
75: *   - BOTOES_CONSULTA.Buttons(3) "sair"    -> BotoesConsultaSairClick
76: *   - BOTOES_CONSULTA.Buttons(4) "Command1"-> BotoesConsultaSelPaginaClick
77: * Metodos de suporte (transcricao de paginicial/mostfig do legado + blocos
78: * repetidos de redesenho/paginacao, fatorados em metodos unicos por serem
79: * IDENTICOS em varios Click do dump - "a chamada mora no FUNIL"):
80: *   PagInicial, MontarSQLImagens, MostFig, RedesenharPaginaAtual,
81: *   FinalizarPaginacao, ReiniciarPaginacao, ReposicionarTmpImagens,
82: *   AtualizarCaptionPagina, ObterFiltroPromocao.
83: * Fase 8/8: consolidacao final - a orquestracao de abertura do Init legado
84: * inteiro (de "If fChecaAcesso" ate "ThisForm.cnt_Pag.Visible = .F."), que
85: * a Fase 7 anunciou para esta fase, e os metodos de apoio que a fecham:
86: *   - AjustarBotoesPorAcesso         <- "If fChecaAcesso('SigOpPec','EXPORTA')
87: *     / ThisForm.Exporta.Visible = .T. / Else ..." e os dois irmaos
88: *     (GERACAO -> GeraArquivo, IMPRIMIR -> RelPecas)
89: *   - PrepararProdutosModoAutomatico <- "If plAuto / Select * From
90: *     crCatalogo Into Cursor crProdutos ReadWrite / Index On Cpros Tag Cpros"
91: *   - CarregarLista                  <- "Select CrProdutos / Go Top /
92: *     If !Eof() / ThisForm.PagInicial()" mais o bloco "If !ThisForm.TelaInic"
93: *     (contagem, redesenho dos 15 slots, Primeira/Pag1/TotPag/NumPag e
94: *     caption). Funil UNICO de carga + repintura desta tela.

*-- Linhas 124 a 181:
124: * (CmdExportaClick), gerar arquivo (CmdGeraArquivoClick) e imprimir a
125: * relacao de pecas (CmdRelPecasClick).
126: *
127: * O "With ThisForm / .poDataMgr = CreateObject('fSqlConector') / With
128: * .poDataMgr / .AddCursor('SigOpGcp','CIdCHaves','CrSigOpGcp','','')" do
129: * Init legado NAO eh transcrito: na nova arquitetura a conexao eh
130: * gnConnHandle (config.prg) e o cursor CrSigOpGcp aberto por esse AddCursor
131: * nao eh lido em NENHUM ponto do dump - reproduzi-lo custaria um SELECT na
132: * abertura de toda tela sem nada que o consuma (decisao ja registrada no
133: * cabecalho de SigOpPecBO.prg).
134: *==============================================================================
135: 
136: DEFINE CLASS FormSigOpPec AS FormBase
137: 
138:     *==========================================================================
139:     * Propriedades visuais - transcritas do dump do SCX legado (secao
140:     * "PROPRIEDADES DE: SIGOPPEC"). WindowType = 0 (modeless): este form NAO
141:     * eh dialogo modal como os wrappers CREATEOBJECT + Show(1) - a instancia
142:     * eh aberta com "Do Form SigOpPec With <oPai>[, lAuto]" e fica junto com
143:     * o form chamador. ControlBox/Closable = .F. + TitleBar = 0: sem X e sem
144:     * barra de titulo, nenhum botao de sistema desenha.
145:     *==========================================================================
146:     Height       = 675
147:     Width        = 1000
148:     DataSession  = 1
149:     ShowWindow = 1
150:     BorderStyle  = 2
151:     AutoCenter   = .T.
152:     ShowTips     = .T.
153:     ControlBox   = .F.
154:     Closable     = .F.
155:     MaxButton    = .F.
156:     MinButton    = .F.
157:     ClipControls = .F.
158:     TitleBar     = 0
159:     WindowType   = 0
160:     Themes       = .F.
161: 
162:     *==========================================================================
163:     * this_oFormPai - equivale a propriedade customizada poObjForm do legado
164:     * ("Parameters oObjForm" + "ThisForm.poObjForm = oObjForm" no Init).
165:     * Referencia ao form de consulta/selecao de produtos que abriu esta tela
166:     * - usada em fase posterior para ler o filtro de promocao
167:     * (poObjForm.Fld_Principal.Pag_Consulta.Filtro.Principal.Get_Promo.Value)
168:     * e para acessar o cursor de produtos filtrados (CrProdutos) por onde
169:     * este form navega.
170:     *==========================================================================
171:     this_oFormPai = .NULL.
172: 
173:     *==========================================================================
174:     * this_lAuto - equivale a propriedade customizada plauto do legado
175:     * ("Parameters oObjForm, plAuto" + "Thisform.plauto = plAuto" no Init).
176:     * .T. quando a tela eh aberta em modo automatico (sem UI do form pai
177:     * disponivel - rotina em lote): nesse caso o filtro de promocao fica
178:     * vazio (ver Init legado, "If thisform.plAuto / lcPromo = [] / Else...").
179:     *==========================================================================
180:     this_lAuto = .F.
181: 

*-- Linhas 248 a 489:
248:     *==========================================================================
249:     * Init - replica "Parameters oObjForm, plAuto" do legado. par_oObjForm e
250:     * par_lAuto sao OPCIONAIS: o harness de teste e a validacao de UI
251:     * instanciam o form sem parametro nenhum (CREATEOBJECT("FormSigOpPec")).
252:     * NUNCA chamar InicializarForm aqui tambem - DODEFAULT() -> FormBase.Init
253:     * object with this name already exists" nos AddObject.
254:     *==========================================================================
255:     PROCEDURE Init(par_oObjForm, par_lAuto)
256:         THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o de Pe" + CHR(231) + "as"
257: 
258:         IF VARTYPE(par_oObjForm) = "O"
259:             THIS.this_oFormPai = par_oObjForm
260:         ENDIF
261: 
262:         IF VARTYPE(par_lAuto) = "L"
263:             THIS.this_lAuto = par_lAuto
264:         ENDIF
265: 
266:         RETURN DODEFAULT()
267:     ENDPROC
268: 
269:     *==========================================================================
270:     * InicializarForm - monta a estrutura base: fundo do form, Business
271:     * Object e o cabecalho (unico bloco visual entregue nesta fase). Os
272:     * demais blocos (Cnt_Pag, Imagem1..15, BOTOES_CONSULTA, botoes de acao)
273:     * entram em ConfigurarPageFrame nas fases seguintes, na mesma ordem do
274:     * dump do SCX.
275:     *==========================================================================
276:     PROTECTED PROCEDURE InicializarForm()
277:         LOCAL loc_lSucesso, loc_lModoValidacaoOuTeste, loc_oErro
278:         loc_lSucesso = .F.
279: 
280:         *-- Modo validacao de UI / teste automatizado: nao ha conexao SQL
281:         *-- disponivel, e a orquestracao de abertura do Init legado depende
282:         *-- dela em DOIS pontos - fChecaAcesso (que consulta SigCdAcu) e a
283:         *-- consulta das imagens da primeira pagina. Mesmo padrao de
284:         *-- FormSIGPRCOT.InicializarForm.
285:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
286:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
287: 
288:         TRY
289:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
290:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
291: 
292:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpPecBO")
293: 
294:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
295:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpPecBO.", ;
296:                     "Erro em InicializarForm")
297:             ELSE
298:                 *-- Copia o modo (automatico/interativo) recebido no Init para
299:                 *-- o BO, que usa essa flag para decidir se consulta o filtro
300:                 *-- de promocao do form pai (fase posterior).
301:                 THIS.this_oBusinessObject.this_lModoAutomatico = THIS.this_lAuto
302: 
303:                 THIS.CriarCursorImagens()
304:                 THIS.ConfigurarPageFrame()
305: 
306:                 THIS.TornarControlesVisiveis(THIS)
307: 
308:                 *-- "ThisForm.Ordena = 1" do Init legado
309:                 THIS.this_nOrdena = 1
310: 
311:                 *-- Estado inicial da tela (modo automatico, filtro de
312:                 *-- promocao do form pai e paginacao zerada) para o BO.
313:                 THIS.FormParaBO()
314: 
315:                 loc_lSucesso = .T.
316: 
317:                 *-- Orquestracao de abertura do Init legado, na ordem do dump.
318:                 *-- AjustarBotoesPorAcesso roda DEPOIS de
319:                 *-- TornarControlesVisiveis, senao a visibilidade generica
320:                 *-- sobrescreveria o Visible calculado por permissao.
321:                 IF !loc_lModoValidacaoOuTeste
322:                     THIS.AjustarBotoesPorAcesso()
323:                     THIS.PrepararProdutosModoAutomatico()
324: 
325:                     IF THIS.CarregarLista()
326:                         *-- "ThisForm.Command1.Click()" do Init legado: a tela
327:                         *-- abre com TODOS os produtos da primeira pagina ja
328:                         *-- marcados. No legado essa chamada fica ENTRE a
329:                         *-- consulta e o bloco "If !TelaInic"; aqui vem depois
330:                         *-- do funil de carga porque CarregarLista tem de
331:                         *-- terminar repintando os slots (regra #21 - popular
332:                         *-- cursor NAO repinta a grade). O estado final eh o
333:                         *-- mesmo: os dois caminhos deixam flag = 1 em
334:                         *-- Tmp_Imagens, o produto em CrImagens, os 15 slots
335:                         *-- desenhados a partir do topo do cursor e
336:                         *-- this_nPrimeira no mesmo registro (RECNO() depois
337:                         *-- das 15 leituras).
338:                         THIS.CmdSelecionarTelaClick()
339:                     ELSE
340:                         *-- Legado: "Wait Window 'Produtos Nao Encontrados!!!
341:                         *-- Pressione <ENTER>...' / Return 0" - o Init legado
342:                         *-- ABORTA e a tela nao abre. MsgAviso em vez de WAIT
343:                         *-- WINDOW por regra do projeto (dialogo unico, e
344:                         *-- suprimido em modo de teste); loc_lSucesso = .F.
345:                         *-- faz InicializarForm devolver .F., que eh o
346:                         *-- equivalente do "Return 0" nesta arquitetura.
347:                         MsgAviso("Produtos N" + CHR(227) + "o Encontrados!!!", ;
348:                             "Sele" + CHR(231) + CHR(227) + "o de Pe" + CHR(231) + "as")
349:                         loc_lSucesso = .F.
350:                     ENDIF
351:                 ENDIF
352: 
353:                 *-- "ThisForm.cnt_Pag.Visible = .F." - ultima linha do Init
354:                 *-- legado. TornarControlesVisiveis ja deixa este container
355:                 *-- fora da varredura (filtro de container flutuante), mas a
356:                 *-- linha eh transcrita porque qualquer caminho acima pode
357:                 *-- ter exibido o painel.
358:                 THIS.cnt_4c__Pag.Visible = .F.
359:             ENDIF
360:         CATCH TO loc_oErro
361:             MsgErro(loc_oErro.Message + CHR(13) + ;
362:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
363:                 "Procedure: " + loc_oErro.Procedure, ;
364:                 "Erro em InicializarForm")
365:         ENDTRY
366: 
367:         RETURN loc_lSucesso
368:     ENDPROC
369: 
370:     *==========================================================================
371:     * CriarCursorImagens - transcricao de PROCEDURE Load do legado:
372:     *   Create Cursor CrImagens (cpros c(14), dpros c(40), ... cBars c(10))
373:     * No SCX, Load() dispara ANTES do Init() - o cursor de selecao de
374:     * imagens precisa existir durante toda a vida do form, nao so quando
375:     * algum Click roda. Chamado no INICIO de InicializarForm (equivalente
376:     * mais proximo de "antes do Init" nesta arquitetura).
377:     *
378:     * SEM esta criacao, TODOS os metodos que leem/gravam em CrImagens
379:     * (ChkImp, CmdDesmarcarTelaClick, CmdSelecionarTelaClick, CmdExportaClick,
380:     * CmdRelPecasClick, CmdDesmarcarTodosClick, CmdSelecionarTodosClick,
381:     * BotoesConsultaProxPagClick, BotoesConsultaAntPagClick) ficariam mudos -
382:     * os helpers do BO (AdicionarAoCursorSelecao/RemoverDoCursorSelecao/
383:     * ExisteNoCursorSelecao) ja testam USED() e devolvem .F. em silencio, e
384:     * nenhum produto jamais seria marcado para a Relacao de Pecas.
385:     *
386:     * SET NULL ON antes do CREATE CURSOR (figjpgs eh M NULL no dump) - regra
387:     * CLAUDE.md: coluna NULL em cursor local precisa do SET explicito,
388:     * revertido logo depois para nao vazar para o resto do form.
389:     *==========================================================================
390:     PROTECTED PROCEDURE CriarCursorImagens()
391:         IF USED("CrImagens")
392:             USE IN CrImagens
393:         ENDIF
394: 
395:         SET NULL ON
396:         CREATE CURSOR CrImagens (cpros C(14), dpros C(40), linhas C(10), ;
397:             colecoes C(10), pvens N(12,2), moevs C(3), pesoms N(9,2), moepvs C(3), ;
398:             fvendas N(8,3), pcuss N(12,2), moecs C(3), reffs C(40), ifors C(10), ;
399:             datas D, cgrus C(3), cunis C(3), figjpgs M NULL, flag N(1), tconvs N(12,2), ;
400:             mconvs C(3), imppreco N(1), custofs N(12,2), moecusfs C(3), impcusto N(1), ;
401:             impcompo N(1), impreffor N(1), tpconvs N(12,2), mpconvs C(3), ImpFor N(1), ;
402:             dFors C(40), cBars C(10))
403:         SET NULL OFF
404:     ENDPROC
405: 
406:     *==========================================================================
407:     * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
408:     * real neste form (objeto raiz do legado eh "Class: form" generico, sem
409:     * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
410:     * convencao com o restante do pipeline (mesmo padrao de FormSigOpGar.prg,
411:     * outro form OPERACIONAL sem PageFrame). Ordem de criacao conforme o
412:     * dump (ver SECAO 1 do codigo fonte e layout.json): Cnt_Pag ->
413:     * Imagem1..Imagem15 -> Pagina -> GeraArquivo/Command1-4/Exporta/
414:     * relpecas (fase seguinte) -> cntSombra -> BOTOES_CONSULTA. O cabecalho
415:     * (cntSombra) foi criado ANTES (Fase 3) por conveniencia, mas isso nao
416:     * produz sobreposicao: os slots de imagem comecam em Top = 162 e
417:     * Cnt_Pag/Pagina em Top >= 82, fora da faixa Top = 0..80 da sombra.
418:     * BOTOES_CONSULTA (Top = -2, Left = 695) EH criado depois da sombra, de
419:     * proposito - ele se sobrepoe a faixa do cabecalho (legado: navegacao
420:     * flutua sobre a faixa, no canto superior direito).
421:     *==========================================================================
422:     PROTECTED PROCEDURE ConfigurarPageFrame()
423:         THIS.ConfigurarCabecalho()
424:         THIS.ConfigurarPaginacao()
425:         THIS.ConfigurarGradeImagens()
426:         THIS.ConfigurarBotoesAcao()
427:         THIS.ConfigurarBotoesNavegacao()
428:         THIS.VincularEventosCampos()
429:     ENDPROC
430: 
431:     *==========================================================================
432:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
433:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
434:     * efeito de sombra: lblSombra em preto (Top = 25) sob lblTitulo em
435:     * branco (Top = 24). Width/Height/Font/ForeColor transcritos do dump
436:     * (secao "PROPRIEDADES DE: SIGOPPEC.cntSombra" e dos dois labels
437:     * filhos). cntSombra.Width = 1008 (8px mais largo que o Form, que tem
438:     * Width = 1000) - valor do proprio dump, transcrito sem ajuste.
439:     *
440:     * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
441:     * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
442:     * criado por AddObject e, com WordWrap, descarta a Height).
443:     *
444:     * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
445:     * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
446:     * do Init legado - "Cadastro de Testes" no dump e' so o default generico
447:     * do Form Designer, sobrescrito em runtime pelo proprio legado.
448:     *==========================================================================
449:     PROTECTED PROCEDURE ConfigurarCabecalho()
450:         LOCAL loc_oCab
451: 
452:         THIS.AddObject("cnt_4c_Sombra", "Container")
453:         loc_oCab = THIS.cnt_4c_Sombra
454:         WITH loc_oCab
455:             .Top         = 0
456:             .Left        = 0
457:             .Width       = 1008
458:             .Height      = 80
459:             .BackStyle   = 1
460:             .BackColor   = RGB(100, 100, 100)
461:             .BorderWidth = 0
462:             .Visible     = .T.
463:         ENDWITH
464: 
465:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
466:         WITH loc_oCab.lbl_4c_LblSombra
467:             .AutoSize      = .F.
468:             .Top           = 25
469:             .Left          = 10
470:             .Width         = 769
471:             .Height        = 40
472:             .FontName      = "Tahoma"
473:             .FontSize      = 18
474:             .FontBold      = .T.
475:             .FontUnderline = .F.
476:             .WordWrap      = .T.
477:             .Alignment     = 0
478:             .BackStyle     = 0
479:             .ForeColor     = RGB(0, 0, 0)
480:             .Caption       = THIS.Caption
481:             .Visible       = .T.
482:         ENDWITH
483: 
484:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
485:         WITH loc_oCab.lbl_4c_LblTitulo
486:             .AutoSize    = .F.
487:             .Top         = 24
488:             .Left        = 10
489:             .Width       = 769

*-- Linhas 509 a 581:
509:     * nasce com Visible = .F. (dump nao declara Visible explicito, mas o
510:     * comportamento legado - "BOTOES_CONSULTA.Visible = .F. / Cnt_Pag.
511:     * Visible = .T." no Click do botao - so faz sentido se Cnt_Pag comecar
512:     * oculto) e DEVE ser filtrado em TornarControlesVisiveis.
513:     *
514:     * Text1.InputMask = "9999999" (7 digitos) transcrito do dump - o
515:     * usuario digita o numero da pagina. Command4 eh o "Cancelar" deste
516:     * painel (Cancel = .T., Picture = cadastro_salvar_32.jpg - mesmo icone
517:     * usado por engano no legado, transcrito fielmente) que fecha o painel
518:     * sem navegar (fase seguinte implementa o Click). Como eh CommandButton
519:     * standalone com .Picture definido, aplica Themes = .T. + DisabledPicture
520:     * (regra CLAUDE.md sobre icone-only button nao renderizar com
521:     * Themes = .F. + Enabled = .F. futuro).
522:     *==========================================================================
523:     PROTECTED PROCEDURE ConfigurarPaginacao()
524:         LOCAL loc_oPag
525: 
526:         THIS.AddObject("cnt_4c__Pag", "Container")
527:         loc_oPag = THIS.cnt_4c__Pag
528:         WITH loc_oPag
529:             .Top          = 82
530:             .Left         = 696
531:             .Width        = 292
532:             .Height       = 60
533:             .BackStyle    = 0
534:             .BorderWidth  = 0
535:             .SpecialEffect = 2
536:             .BackColor    = RGB(255, 255, 255)
537:             .Visible      = .F.
538:         ENDWITH
539: 
540:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
541:         WITH loc_oPag.lbl_4c_Label1
542:             .AutoSize  = .T.
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .BackStyle = 0
546:             .Caption   = "Selecione a P" + CHR(225) + "gina :"
547:             .Top       = 24
548:             .Left      = 66
549:             .ForeColor = RGB(90, 90, 90)
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPag.AddObject("txt_4c_Text1", "TextBox")
554:         WITH loc_oPag.txt_4c_Text1
555:             .FontSize  = 8
556:             .Height    = 23
557:             .Width     = 52
558:             .Top       = 21
559:             .Left      = 166
560:             .InputMask = "9999999"
561:             .Value     = 0
562:             .Visible   = .T.
563:         ENDWITH
564: 
565:         loc_oPag.AddObject("cmd_4c_Command4", "CommandButton")
566:         WITH loc_oPag.cmd_4c_Command4
567:             .Top             = 12
568:             .Left            = 223
569:             .Height          = 40
570:             .Width           = 40
571:             .FontName        = "Verdana"
572:             .FontSize        = 8
573:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
574:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
575:             .Cancel          = .T.
576:             .Caption         = ""
577:             .ToolTipText     = "Encerrar"
578:             .ForeColor       = RGB(36, 84, 155)
579:             .BackColor       = RGB(255, 255, 255)
580:             .Themes          = .T.
581:             .Visible         = .T.

*-- Linhas 596 a 644:
596:     * texto real) - MostFig() os preenche a cada pagina exibida.
597:     *
598:     * Imagem10.Visible = .F. no dump (unico dos 15): transcrito fielmente,
599:     * mas sem efeito pratico - TornarControlesVisiveis torna todos os 15
600:     * visiveis no Init, e a visibilidade real por pagina (menos de 15
601:     * produtos na ultima pagina) eh controlada em runtime por PagInicial/
602:     * MostFig (fase seguinte), nao neste metodo de montagem.
603:     *==========================================================================
604:     PROTECTED PROCEDURE ConfigurarGradeImagens()
605:         LOCAL loc_nI, loc_nLinha, loc_nColuna, loc_cNome, loc_oImg
606:         LOCAL ARRAY loc_aLeftCol(5), loc_aTopLin(3)
607: 
608:         loc_aLeftCol(1) = 9
609:         loc_aLeftCol(2) = 207
610:         loc_aLeftCol(3) = 405
611:         loc_aLeftCol(4) = 603
612:         loc_aLeftCol(5) = 800
613: 
614:         loc_aTopLin(1) = 162
615:         loc_aTopLin(2) = 317
616:         loc_aTopLin(3) = 472
617: 
618:         FOR loc_nI = 1 TO 15
619:             loc_nLinha  = INT((loc_nI - 1) / 5) + 1
620:             loc_nColuna = MOD(loc_nI - 1, 5) + 1
621:             loc_cNome   = "cnt_4c_Imagem" + TRANSFORM(loc_nI)
622: 
623:             THIS.AddObject(loc_cNome, "Container")
624:             loc_oImg = EVALUATE("THIS." + loc_cNome)
625:             WITH loc_oImg
626:                 .Top         = loc_aTopLin(loc_nLinha)
627:                 .Left        = loc_aLeftCol(loc_nColuna)
628:                 .Width       = 190
629:                 .Height      = 150
630:                 .BackStyle   = 1
631:                 .BorderWidth = 1
632:                 .BackColor   = RGB(207, 241, 241)
633:                 .Visible     = IIF(loc_nI = 10, .F., .T.)
634:             ENDWITH
635: 
636:             loc_oImg.AddObject("img_4c_IMG", "Image")
637:             WITH loc_oImg.img_4c_IMG
638:                 .Stretch = 1
639:                 .Top     = 1
640:                 .Left    = 1
641:                 .Width   = 188
642:                 .Height  = 109
643:                 .Visible = .T.
644:             ENDWITH

*-- Linhas 715 a 758:
715:     * .Visible (fChecaAcesso, Init legado linhas 1997-2010), e essa logica
716:     * de acesso fica para fase posterior (comportamento, nao estrutura).
717:     *==========================================================================
718:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
719:         THIS.AddObject("cmd_4c_GeraArquivo", "CommandButton")
720:         WITH THIS.cmd_4c_GeraArquivo
721:             .Top             = 82
722:             .Left            = 3
723:             .Height          = 40
724:             .Width           = 105
725:             .FontName        = "Comic Sans MS"
726:             .FontBold        = .T.
727:             .FontItalic      = .T.
728:             .FontSize        = 8
729:             .WordWrap        = .T.
730:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
731:             .Caption         = "Gerar Arquivo"
732:             .ToolTipText     = "Gera Arquivo"
733:             .SpecialEffect   = 0
734:             .PicturePosition = 1
735:             .ForeColor       = RGB(90, 90, 90)
736:             .BackColor       = RGB(255, 255, 255)
737:             .Themes           = .T.
738:             .Visible         = .T.
739:         ENDWITH
740: 
741:         THIS.AddObject("cmd_4c_Command2", "CommandButton")
742:         WITH THIS.cmd_4c_Command2
743:             .Top             = 82
744:             .Left            = 423
745:             .Height          = 40
746:             .Width           = 105
747:             .FontName        = "Comic Sans MS"
748:             .FontBold        = .T.
749:             .FontItalic      = .T.
750:             .FontSize        = 8
751:             .WordWrap        = .T.
752:             .Picture         = gc_4c_CaminhoIcones + "simbolosl_erro_60.jpg"
753:             .Caption         = "Desmarcar Tela"
754:             .Enabled         = .T.
755:             .ToolTipText     = "Desmarcar Tudo Nesta Tela"
756:             .SpecialEffect   = 0
757:             .PicturePosition = 1
758:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 834 a 858:
834: 
835:         *-- Command4: "Selecionar Todos" (dump: Top=82 Left=528) - marca
836:         *-- TODOS os produtos do filtro corrente (crProdutos inteiro, nao so
837:         *-- a pagina visivel) - distinto de cmd_4c_Command1 "Selecionar
838:         *-- Tela", que marca so os 15 slots exibidos. Nome igual ao
839:         *-- cmd_4c_Command4 de cnt_4c__Pag (mapeamento.json mapeia os dois
840:         *-- "Command4" do dump para o mesmo nome migrado) - sem colisao em
841:         *-- VFP9 porque sao filhos de PAIS diferentes (THIS vs cnt_4c__Pag).
842:         THIS.AddObject("cmd_4c_Command4", "CommandButton")
843:         WITH THIS.cmd_4c_Command4
844:             .Top             = 82
845:             .Left            = 528
846:             .Height          = 40
847:             .Width           = 105
848:             .FontName        = "Comic Sans MS"
849:             .FontBold        = .T.
850:             .FontItalic      = .T.
851:             .FontSize        = 8
852:             .WordWrap        = .T.
853:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
854:             .Caption         = "Selecionar Todos"
855:             .Enabled         = .T.
856:             .ToolTipText     = "Marcar Tudo Neste Filtro"
857:             .SpecialEffect   = 0
858:             .PicturePosition = 1

*-- Linhas 904 a 949:
904:     * CommandGroup NAO tem ForeColor/BackColor proprios (regra CLAUDE.md
905:     * #33) - cor e fonte vao nos Buttons(N) individualmente, como o dump ja
906:     * declara. WITH .Buttons(N) aninhado dentro do WITH do grupo eh seguro
907:     * (1 nivel de nesting - regra CLAUDE.md sobre OptionGroup/CommandGroup).
908:     *==========================================================================
909:     PROTECTED PROCEDURE ConfigurarBotoesNavegacao()
910:         THIS.AddObject("obj_4c_BOTOES_CONSULTA", "CommandGroup")
911:         WITH THIS.obj_4c_BOTOES_CONSULTA
912:             .Top         = -2
913:             .Left        = 695
914:             .Width       = 310
915:             .Height      = 85
916:             .AutoSize    = .T.
917:             .ButtonCount = 4
918:             .BackStyle   = 0
919:             .BorderStyle = 0
920:             .Themes      = .F.
921:             .Visible     = .T.
922: 
923:             WITH .Buttons(1)
924:                 .Top         = 5
925:                 .Left        = 80
926:                 .Height      = 75
927:                 .Width       = 75
928:                 .FontName    = "Comic Sans MS"
929:                 .FontBold    = .T.
930:                 .FontItalic  = .T.
931:                 .FontSize    = 8
932:                 .WordWrap    = .T.
933:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
934:                 .Caption     = "\<Pr" + CHR(243) + "xima P" + CHR(225) + "gina"
935:                 .ToolTipText = "Pr" + CHR(243) + "xima P" + CHR(225) + "gina"
936:                 .PicturePosition = 7
937:                 .ForeColor   = RGB(90, 90, 90)
938:                 .BackColor   = RGB(255, 255, 255)
939:                 .Themes      = .F.
940:             ENDWITH
941: 
942:             WITH .Buttons(2)
943:                 .Top         = 5
944:                 .Left        = 5
945:                 .Height      = 75
946:                 .Width       = 75
947:                 .FontName    = "Comic Sans MS"
948:                 .FontBold    = .T.
949:                 .FontItalic  = .T.

*-- Linhas 998 a 1295:
998:     ENDPROC
999: 
1000:     *==========================================================================
1001:     * VincularEventosCampos - liga por BINDEVENT os eventos dos CAMPOS desta
1002:     * tela (os controles com que o usuario interage dentro dos containers):
1003:     *
1004:     *   Cnt_Pag.Text1.LostFocus  -> ValidarPaginaSelecionada
1005:     *   Cnt_Pag.Command4.Click   -> FecharPainelPaginacao
1006:     *   Imagem<N>.Check1.Click   -> ChkImagem<N>Click -> ChkImp(slot, N)
1007:     *
1008:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
1009:     * metodo PROTECTED (regra CLAUDE.md #3).
1010:     *
1011:     * O evento do TextBox eh "LostFocus" porque o legado tem a validacao no
1012:     * LostFocus de Cnt_Pag.Text1 (nao no Valid, nao no KeyPress) - ligar em
1013:     * "KeyPress" faria a validacao rodar a cada digito e a tela trocaria de
1014:     * pagina antes de o usuario terminar de digitar o numero (regra
1015:     * CLAUDE.md #47).
1016:     *
1017:     * Os Click dos 7 botoes de acao do topo e dos 4 botoes de
1018:     * BOTOES_CONSULTA (navegacao entre paginas) - entregues nesta fase (7/8) -
1019:     * sao ligados aqui tambem. O BINDEVENT dos botoes do CommandGroup eh feito
1020:     * em CADA .Buttons(N) (nao no grupo): o legado tem o codigo no Click de
1021:     * cada botao - PROXPAG/ANTPAG/sair/Command1 -, e ValidarPaginaSelecionada
1022:     * aciona Buttons(1)/Buttons(2) por chamada direta de .Click(), que so
1023:     * dispara o delegate ligado ao PROPRIO botao.
1024:     *==========================================================================
1025:     PROTECTED PROCEDURE VincularEventosCampos()
1026:         LOCAL loc_nI, loc_oChk
1027: 
1028:         BINDEVENT(THIS.cnt_4c__Pag.txt_4c_Text1, "LostFocus", THIS, "ValidarPaginaSelecionada")
1029: 
1030:         *-- Cnt_Pag.Command4 eh o botao de ABANDONO do painel de selecao de
1031:         *-- pagina (Cancel = .T. no dump, ToolTipText "Encerrar"): o Click
1032:         *-- dele fecha o painel sem navegar. O handler se chama
1033:         *-- BtnCancelarClick por isso, e delega ao funil
1034:         *-- FecharPainelPaginacao - que as duas recusas de
1035:         *-- ValidarPaginaSelecionada tambem chamam, igual as tres copias do
1036:         *-- mesmo bloco de 3 linhas no legado.
1037:         BINDEVENT(THIS.cnt_4c__Pag.cmd_4c_Command4, "Click", THIS, "BtnCancelarClick")
1038: 
1039:         *-- Um handler por slot, igual ao legado: cada Imagem<N>.Check1 tem
1040:         *-- seu proprio "ThisForm.ChkImp(This.Parent, N)". O delegate do
1041:         *-- BINDEVENT nao recebe o objeto de origem, por isso o numero do
1042:         *-- slot vem do NOME do handler, nao de um parametro.
1043:         FOR loc_nI = 1 TO 15
1044:             loc_oChk = EVALUATE("THIS.cnt_4c_Imagem" + TRANSFORM(loc_nI) + ".chk_4c_Check1")
1045:             BINDEVENT(loc_oChk, "Click", THIS, "ChkImagem" + TRANSFORM(loc_nI) + "Click")
1046:         ENDFOR
1047: 
1048:         *-- Botoes de acao standalone do topo (SECAO 3 do dump: GeraArquivo/
1049:         *-- Command2/Command1/Exporta/relpecas/Command3/Command4 - filhos
1050:         *-- diretos de SIGOPPEC).
1051:         BINDEVENT(THIS.cmd_4c_GeraArquivo, "Click", THIS, "CmdGeraArquivoClick")
1052:         BINDEVENT(THIS.cmd_4c_Command2,    "Click", THIS, "CmdDesmarcarTelaClick")
1053:         BINDEVENT(THIS.cmd_4c_Command1,    "Click", THIS, "CmdSelecionarTelaClick")
1054:         BINDEVENT(THIS.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
1055:         BINDEVENT(THIS.cmd_4c_Relpecas,    "Click", THIS, "CmdRelPecasClick")
1056:         BINDEVENT(THIS.cmd_4c_Command3,    "Click", THIS, "CmdDesmarcarTodosClick")
1057:         BINDEVENT(THIS.cmd_4c_Command4,    "Click", THIS, "CmdSelecionarTodosClick")
1058: 
1059:         *-- BOTOES_CONSULTA (CommandGroup de navegacao) - Buttons(N), nome
1060:         *-- legado entre parenteses (ver dump, secao BOTOES_CONSULTA).
1061:         BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(1), "Click", THIS, "BotoesConsultaProxPagClick")  && PROXPAG
1062:         BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(2), "Click", THIS, "BotoesConsultaAntPagClick")   && ANTPAG
1063:         BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(3), "Click", THIS, "BotoesConsultaSairClick")     && sair
1064:         BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(4), "Click", THIS, "BotoesConsultaSelPaginaClick") && Command1
1065:     ENDPROC
1066: 
1067:     *==========================================================================
1068:     * ValidarPaginaSelecionada - transcricao do LostFocus de
1069:     * SIGOPPEC.Cnt_Pag.Text1 (secao 3 do dump): o usuario digita o numero da
1070:     * pagina no painel "Selecione a Pagina :" e, ao sair do campo, a tela
1071:     * posiciona CrProdutos/Tmp_Imagens no inicio dessa pagina, fecha o painel
1072:     * e deixa a navegacao de BOTOES_CONSULTA desenhar as 15 imagens.
1073:     *
1074:     * Fidelidade ao legado, linha a linha:
1075:     *   - Value menor ou igual a 0 -> so fecha o painel (sem mensagem)
1076:     *   - (Value-1)*15 maior que RecCount(CrProdutos) -> avisa e fecha o painel
1077:     *   - Value = 1 -> GO 16 e TotReg = 30 quando ha 16 ou mais produtos;
1078:     *                  senao GO BOTTOM e TotReg = RecCount()
1079:     *   - Value maior que 1 -> GO (Value-1)*15 e TotReg = (Value-1)*15
1080:     *   - Tmp_Imagens -> GO TOP (pagina 1) ou GO BOTTOM, e grava cpros do
1081:     *                    produto corrente de CrProdutos
1082:     *   - Value = 1 -> aciona ANTPAG (Buttons(2)); senao PROXPAG (Buttons(1))
1083:     *
1084:     * O 15 e o 16/30 sao os literais do legado (tamanho da pagina = 15
1085:     * slots), transcritos como estao - nao derivados de outra property.
1086:     *
1087:     * MsgAviso (nao MsgErro) para "Numero de Pagina Superior a Ultima": eh
1088:     * validacao de entrada do usuario, nao falha tecnica. O texto eh o do
1089:     * legado, que nao tem acento - transcrito como esta.
1090:     *
1091:     * Guarda a mais que o legado nao precisava: se CrProdutos nao estiver
1092:     * aberto (painel acionado antes de qualquer carga de produtos), apenas
1093:     * fecha o painel - no legado o cursor eh criado pelo form pai antes de a
1094:     * tela abrir, aqui o SELECT estouraria "Alias not found".
1095:     *==========================================================================
1096:     PROCEDURE ValidarPaginaSelecionada()
1097:         LOCAL loc_oTxt, loc_nPagina, loc_nRegistro, loc_lProsseguir
1098:         LOCAL loc_lPaginaAnterior, loc_oErro
1099: 
1100:         *-- Guarda de reentrancia ANTES do TRY (regra CLAUDE.md #1: nenhum
1101:         *-- RETURN dentro de TRY/CATCH).
1102:         IF THIS.this_lValidandoPagina
1103:             RETURN
1104:         ENDIF
1105: 
1106:         THIS.this_lValidandoPagina = .T.
1107: 
1108:         loc_oTxt            = THIS.cnt_4c__Pag.txt_4c_Text1
1109:         loc_nPagina         = loc_oTxt.Value
1110:         loc_lProsseguir     = .T.
1111:         loc_lPaginaAnterior = .F.
1112: 
1113:         TRY
1114:             IF loc_nPagina <= 0
1115:                 THIS.FecharPainelPaginacao()
1116:                 loc_lProsseguir = .F.
1117:             ENDIF
1118: 
1119:             IF loc_lProsseguir AND !USED("CrProdutos")
1120:                 THIS.FecharPainelPaginacao()
1121:                 loc_lProsseguir = .F.
1122:             ENDIF
1123: 
1124:             IF loc_lProsseguir
1125:                 SELECT CrProdutos
1126: 
1127:                 IF (loc_nPagina - 1) * 15 > RECCOUNT()
1128:                     MsgAviso("Numero de Pagina Superior a Ultima !!!")
1129:                     THIS.FecharPainelPaginacao()
1130:                     loc_lProsseguir = .F.
1131:                 ENDIF
1132:             ENDIF
1133: 
1134:             IF loc_lProsseguir
1135:                 IF loc_nPagina = 1
1136:                     IF RECCOUNT() >= 16
1137:                         GO 16
1138:                         THIS.this_nTotReg = 30
1139:                     ELSE
1140:                         GO BOTTOM
1141:                         THIS.this_nTotReg = RECCOUNT()
1142:                     ENDIF
1143:                 ELSE
1144:                     loc_nRegistro = (loc_nPagina - 1) * 15
1145:                     GO loc_nRegistro
1146:                     THIS.this_nTotReg = loc_nRegistro
1147:                 ENDIF
1148: 
1149:                 IF USED("Tmp_Imagens")
1150:                     SELECT Tmp_Imagens
1151: 
1152:                     IF loc_nPagina = 1
1153:                         GO TOP
1154:                     ELSE
1155:                         GO BOTTOM
1156:                     ENDIF
1157: 
1158:                     REPLACE cpros WITH CrProdutos.cpros
1159:                 ENDIF
1160: 
1161:                 THIS.cnt_4c__Pag.Visible            = .F.
1162:                 THIS.obj_4c_BOTOES_CONSULTA.Visible = .T.
1163: 
1164:                 loc_lPaginaAnterior = (loc_nPagina = 1)
1165:             ENDIF
1166:         CATCH TO loc_oErro
1167:             loc_lProsseguir = .F.
1168:             MsgErro(loc_oErro.Message + CHR(13) + ;
1169:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1170:                 "Procedure: " + loc_oErro.Procedure, ;
1171:                 "Erro ao selecionar p" + CHR(225) + "gina")
1172:         ENDTRY
1173: 
1174:         *-- Flag liberada ANTES de acionar a navegacao: o Click do botao de
1175:         *-- navegacao redesenha a pagina e mexe no foco, e com a flag ainda
1176:         *-- ligada o LostFocus seguinte ficaria mudo para sempre.
1177:         THIS.this_lValidandoPagina = .F.
1178: 
1179:         IF loc_lProsseguir
1180:             IF loc_lPaginaAnterior
1181:                 THIS.obj_4c_BOTOES_CONSULTA.Buttons(2).Click()
1182:             ELSE
1183:                 THIS.obj_4c_BOTOES_CONSULTA.Buttons(1).Click()
1184:             ENDIF
1185:         ENDIF
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * FecharPainelPaginacao - transcricao do Click de
1190:     * SIGOPPEC.Cnt_Pag.Command4: fecha o painel "Selecione a Pagina :" sem
1191:     * navegar, devolve a barra de navegacao e poe o foco no botao
1192:     * "Selecionar Pagina" (no legado "BOTOES_CONSULTA.Command1.SetFocus" -
1193:     * Command1 eh o NOME do 4o botao do grupo, ver a secao de propriedades do
1194:     * dump: Command4.Name = "Command1").
1195:     *
1196:     * Tambem eh o caminho de saida das duas recusas de
1197:     * ValidarPaginaSelecionada, exatamente como no legado (as tres copias do
1198:     * mesmo bloco de 3 linhas).
1199:     *
1200:     * O SetFocus fica em TRY proprio: ele roda com o container do campo
1201:     * sendo escondido no mesmo instante (o legado faz igual) e em VFP9 mover
1202:     * o foco de dentro de um LostFocus pode ser recusado em casos de borda -
1203:     * foco recusado nao pode derrubar o fechamento do painel.
1204:     *==========================================================================
1205:     PROCEDURE FecharPainelPaginacao()
1206:         LOCAL loc_oErro
1207: 
1208:         THIS.cnt_4c__Pag.Visible            = .F.
1209:         THIS.obj_4c_BOTOES_CONSULTA.Visible = .T.
1210: 
1211:         TRY
1212:             THIS.obj_4c_BOTOES_CONSULTA.Buttons(4).SetFocus()
1213:         CATCH TO loc_oErro
1214:             *-- Foco recusado (o controle acabou de ficar invisivel): o painel
1215:             *-- ja esta fechado e a barra de navegacao ja esta visivel, nada a
1216:             *-- desfazer. Sem MsgErro de proposito - o legado nao avisa nada
1217:             *-- aqui, e um dialogo a cada fechamento de painel seria ruido.
1218:         ENDTRY
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * ChkImp - transcricao do PROCEDURE chkimp do legado
1223:     * ("LParameters Imag, nShape"). Marca/desmarca o produto do slot clicado:
1224:     *
1225:     *   1. posiciona Tmp_Imagens em this_nPrimeira (1 registro DEPOIS do
1226:     *      ultimo produto desenhado) e volta (this_nItem - nShape + 1)
1227:     *      registros - a linha do slot clicado;
1228:     *   2. inverte a coluna flag (0 para 1, 1 para 0) e espelha o valor no
1229:     *      CheckBox do slot (o clique nativo do CheckBox alterna sozinho, e o
1230:     *      legado sobrescreve com o valor que de fato ficou no cursor);
1231:     *   3. flag = 0 -> remove o produto do cursor de selecao (CrImagens);
1232:     *      flag = 1 -> insere com o layout de CrImagens (incluindo o codigo
1233:     *      de barras por fAltBar2de5, dentro de AdicionarAoCursorSelecao);
1234:     *   4. reposiciona Tmp_Imagens em this_nPrimeira (o legado repete o mesmo
1235:     *      bloco de posicionamento no fim, para a proxima marcacao partir do
1236:     *      mesmo ponto).
1237:     *
1238:     * O INSERT/DELETE em CrImagens fica no BO (AdicionarAoCursorSelecao com
1239:     * par_lBuscarFornecedor = .F. - o chkimp do legado NAO consulta SigCdCli,
1240:     * diferente de Command1/Command4.Click - e RemoverDoCursorSelecao).
1241:     * CarregarDoCursor eh chamado DEPOIS do REPLACE para que this_nFlag leve
1242:     * ao INSERT o valor novo (1), como no legado, que insere Tmp_Imagens.flag
1243:     * ja invertido.
1244:     *
1245:     * Duas guardas que o legado nao tinha e aqui sao necessarias:
1246:     *   - Tmp_Imagens fechado ou vazio: no legado os 15 slots so aparecem
1247:     *     depois de PagInicial popular o cursor; aqui os containers nascem
1248:     *     visiveis, entao o CheckBox pode ser clicado antes de qualquer
1249:     *     carga. Nada a marcar - sai sem mexer em nada.
1250:     *   - this_nPrimeira maior ou igual a 1: "GO 0" estoura "Record is out of
1251:     *     range". O legado so testa "menor ou igual a RecCount()" porque
1252:     *     nunca chega aqui com Primeira = 0 (PagInicial a define antes de a
1253:     *     tela aparecer).
1254:     *==========================================================================
1255:     PROCEDURE ChkImp(par_oSlot, par_nShape)
1256:         LOCAL loc_nItem, loc_nImp, loc_cCpros, loc_lProsseguir, loc_oErro
1257: 
1258:         loc_lProsseguir = .T.
1259: 
1260:         IF !USED("Tmp_Imagens")
1261:             loc_lProsseguir = .F.
1262:         ELSE
1263:             IF RECCOUNT("Tmp_Imagens") = 0
1264:                 loc_lProsseguir = .F.
1265:             ENDIF
1266:         ENDIF
1267: 
1268:         IF loc_lProsseguir AND VARTYPE(par_oSlot) != "O"
1269:             loc_lProsseguir = .F.
1270:         ENDIF
1271: 
1272:         IF loc_lProsseguir
1273:             TRY
1274:                 SELECT Tmp_Imagens
1275: 
1276:                 IF THIS.this_nPrimeira >= 1 AND THIS.this_nPrimeira <= RECCOUNT()
1277:                     GO THIS.this_nPrimeira
1278:                 ELSE
1279:                     GO BOTTOM
1280:                     IF !EOF()
1281:                         SKIP
1282:                     ENDIF
1283:                 ENDIF
1284: 
1285:                 loc_nItem = THIS.this_nItem - par_nShape
1286:                 loc_nItem = loc_nItem + 1
1287:                 SKIP -loc_nItem
1288: 
1289:                 loc_nImp = IIF(Tmp_Imagens.flag = 0, 1, 0)
1290:                 REPLACE Tmp_Imagens.flag WITH loc_nImp
1291: 
1292:                 par_oSlot.chk_4c_Check1.Value = loc_nImp
1293: 
1294:                 loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
1295: 

*-- Linhas 1314 a 2011:
1314:             CATCH TO loc_oErro
1315:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1316:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1317:                     "Procedure: " + loc_oErro.Procedure, ;
1318:                     "Erro ao marcar produto")
1319:             ENDTRY
1320:         ENDIF
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * ChkImagem<N>Click - um handler por slot, espelhando o Click de cada
1325:     * SIGOPPEC.Imagem<N>.Check1 do legado ("ThisForm.ChkImp(This.Parent, N)").
1326:     * O container do slot entra como parametro porque o ChkImp espelha o
1327:     * valor final no CheckBox daquele slot.
1328:     *==========================================================================
1329:     PROCEDURE ChkImagem1Click()
1330:         THIS.ChkImp(THIS.cnt_4c_Imagem1, 1)
1331:     ENDPROC
1332: 
1333:     PROCEDURE ChkImagem2Click()
1334:         THIS.ChkImp(THIS.cnt_4c_Imagem2, 2)
1335:     ENDPROC
1336: 
1337:     PROCEDURE ChkImagem3Click()
1338:         THIS.ChkImp(THIS.cnt_4c_Imagem3, 3)
1339:     ENDPROC
1340: 
1341:     PROCEDURE ChkImagem4Click()
1342:         THIS.ChkImp(THIS.cnt_4c_Imagem4, 4)
1343:     ENDPROC
1344: 
1345:     PROCEDURE ChkImagem5Click()
1346:         THIS.ChkImp(THIS.cnt_4c_Imagem5, 5)
1347:     ENDPROC
1348: 
1349:     PROCEDURE ChkImagem6Click()
1350:         THIS.ChkImp(THIS.cnt_4c_Imagem6, 6)
1351:     ENDPROC
1352: 
1353:     PROCEDURE ChkImagem7Click()
1354:         THIS.ChkImp(THIS.cnt_4c_Imagem7, 7)
1355:     ENDPROC
1356: 
1357:     PROCEDURE ChkImagem8Click()
1358:         THIS.ChkImp(THIS.cnt_4c_Imagem8, 8)
1359:     ENDPROC
1360: 
1361:     PROCEDURE ChkImagem9Click()
1362:         THIS.ChkImp(THIS.cnt_4c_Imagem9, 9)
1363:     ENDPROC
1364: 
1365:     PROCEDURE ChkImagem10Click()
1366:         THIS.ChkImp(THIS.cnt_4c_Imagem10, 10)
1367:     ENDPROC
1368: 
1369:     PROCEDURE ChkImagem11Click()
1370:         THIS.ChkImp(THIS.cnt_4c_Imagem11, 11)
1371:     ENDPROC
1372: 
1373:     PROCEDURE ChkImagem12Click()
1374:         THIS.ChkImp(THIS.cnt_4c_Imagem12, 12)
1375:     ENDPROC
1376: 
1377:     PROCEDURE ChkImagem13Click()
1378:         THIS.ChkImp(THIS.cnt_4c_Imagem13, 13)
1379:     ENDPROC
1380: 
1381:     PROCEDURE ChkImagem14Click()
1382:         THIS.ChkImp(THIS.cnt_4c_Imagem14, 14)
1383:     ENDPROC
1384: 
1385:     PROCEDURE ChkImagem15Click()
1386:         THIS.ChkImp(THIS.cnt_4c_Imagem15, 15)
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * ObterFiltroPromocao - transcricao do trecho repetido em quase todo
1391:     * metodo do legado:
1392:     *   If thisform.plAuto
1393:     *       lcPromo = []
1394:     *   Else
1395:     *       lcPromo = ThisForm.poObjForm.Fld_Principal.Pag_Consulta.Filtro.
1396:     *                 Principal.Get_Promo.Value
1397:     *   Endif
1398:     *
1399:     * THIS.this_oFormPai eh a referencia ao form de consulta/selecao de
1400:     * produtos (SigOpXxx) que abriu esta tela - fora do escopo desta
1401:     * migracao (task778 eh so SIGOPPEC). Enquanto esse form pai nao existir
1402:     * na nova arquitetura com a MESMA hierarquia de containers do legado
1403:     * (Fld_Principal.Pag_Consulta.Filtro.Principal.Get_Promo), o caminho
1404:     * profundo nao resolve - TRY/CATCH devolve "" exatamente como o ramo
1405:     * plAuto = .T. do legado (sem filtro de promocao), sem fabricar
1406:     * comportamento novo: EVALUATE com caminho pontuado inexistente estoura,
1407:     * o CATCH pega e o resultado eh o MESMO de "nao ha promocao".
1408:     *==========================================================================
1409:     PROTECTED PROCEDURE ObterFiltroPromocao()
1410:         LOCAL loc_cPromo, loc_oErro
1411:         loc_cPromo = ""
1412: 
1413:         IF !THIS.this_lAuto AND VARTYPE(THIS.this_oFormPai) = "O"
1414:             TRY
1415:                 loc_cPromo = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
1416:                     "Pag_Consulta.Filtro.Principal.Get_Promo.Value"), "")
1417:             CATCH TO loc_oErro
1418:                 loc_cPromo = ""
1419:             ENDTRY
1420:         ENDIF
1421: 
1422:         RETURN ALLTRIM(loc_cPromo)
1423:     ENDPROC
1424: 
1425:     *==========================================================================
1426:     * MontarSQLImagens - monta o SELECT usado por PagInicial/PROXPAG/ANTPAG/
1427:     * CmdSelecionarTodosClick (paginicial/PROXPAG.Click/ANTPAG.Click/
1428:     * Command4.Click do legado - os quatro repetem a MESMA lista de colunas,
1429:     * so o WHERE e o "From SigCdPro a[,SigPrPmi p]" com o filtro de promocao
1430:     * mudam). par_cWhereImg ja vem pronto (com os parenteses) de quem chama.
1431:     *
1432:     * Duas transcricoes NAO-literais, documentadas:
1433:     *   1. "a.reffs" aparece DUAS VEZES no SELECT original (coluna Reffs e,
1434:     *      mais adiante, de novo a.reffs no lugar que antecede "0 as flag").
1435:     *      Nenhum ponto do form/BO le a segunda ocorrencia (CarregarDoCursor
1436:     *      so tem THIS.this_cReffs = TratarNulo(reffs,"") UMA vez) - repetir
1437:     *      o nome geraria coluna duplicada na resposta do SQL Server sem
1438:     *      efeito nenhum, por isso nao se repete aqui.
1439:     *   2. impcusto/impcompo/impreffor/tpconvs/mpconvs/ImpFor/dFors NAO estao
1440:     *      no SELECT legado de Tmp_Imagens (ele so tem ate "imppreco" e
1441:     *      "dfors" em branco) - mas SigOpPecBO.CarregarDoCursor() (Fase 1/2)
1442:     *      le TODAS essas colunas de QUALQUER alias que receber, porque o
1443:     *      mesmo metodo atende tanto CrImagens (31 colunas) quanto
1444:     *      Tmp_Imagens. Sem elas aqui, CarregarDoCursor("Tmp_Imagens") (usado
1445:     *      em ChkImp e em CmdSelecionarTelaClick) estouraria "Variable
1446:     *      IMPCUSTO is not found" na PRIMEIRA vez que alguem marcasse um
1447:     *      produto - o cursor nunca tinha sido montado de verdade antes desta
1448:     *      fase para isso aparecer. Os valores adicionados sao EXATAMENTE os
1449:     *      que o legado ja hardcodeia 0/branco no INSERT INTO CrImagens
1450:     *      (chkimp: "...,0,0,0,lcBarra)" para impcusto/impcompo/impreffor) -
1451:     *      nao eh regra de negocio nova, eh completar o layout que o proprio
1452:     *      legado so preenche depois, no destino.
1453:     *==========================================================================
1454:     PROTECTED PROCEDURE MontarSQLImagens(par_cWhereImg, par_lPromo, par_cPromo)
1455:         LOCAL loc_cSQL
1456: 
1457:         loc_cSQL = "SELECT a.cpros, a.dpros, a.linhas, a.colecoes, a.pvens, a.moevs, " + ;
1458:             "a.pesoms, a.moepvs, a.fvendas, a.pcuss, a.cbars, a.moecs, a.reffs, " + ;
1459:             "a.ifors, a.datas, a.cgrus, a.cunis, a.figjpgs, a.custofs, a.moecusfs, " + ;
1460:             "0 AS flag, CAST(0 AS NUMERIC(12,2)) AS tconvs, SPACE(3) AS mconvs, " + ;
1461:             "0 AS imppreco, 0 AS impcusto, 0 AS impcompo, 0 AS impreffor, " + ;
1462:             "CAST(0 AS NUMERIC(12,2)) AS tpconvs, SPACE(3) AS mpconvs, 0 AS ImpFor, " + ;
1463:             "SPACE(40) AS dfors" + IIF(par_lPromo, ", p.pecas", "") + ;
1464:             " FROM SigCdPro a " + IIF(par_lPromo, ", SigPrPmi p", "") + ;
1465:             " WHERE " + par_cWhereImg + ;
1466:             IIF(par_lPromo, " AND p.CPros = a.CPros AND p.Promos = " + EscaparSQL(par_cPromo), "") + ;
1467:             " ORDER BY " + IIF(par_lPromo, "p.Pecas, a.CPros", "a.CPros")
1468: 
1469:         RETURN loc_cSQL
1470:     ENDPROC
1471: 
1472:     *==========================================================================
1473:     * PagInicial - transcricao de PROCEDURE paginicial do legado: monta a
1474:     * janela de ATE 15 produtos a partir da posicao CORRENTE de CrProdutos
1475:     * (quem chama faz GO TOP antes, exatamente como no legado - Init/
1476:     * CmdDesmarcarTodosClick/CmdSelecionarTodosClick) e recarrega Tmp_Imagens
1477:     * com o resultado. NAO reposiciona CrProdutos para o inicio - responsa-
1478:     * bilidade de quem chama, igual ao legado.
1479:     *==========================================================================
1480:     PROCEDURE PagInicial()
1481:         LOCAL loc_cPromo, loc_lPromo, loc_cWhere, loc_nI, loc_cSQL, loc_nResultado, loc_oErro
1482: 
1483:         IF !USED("CrProdutos")
1484:             RETURN
1485:         ENDIF
1486: 
1487:         loc_cPromo = THIS.ObterFiltroPromocao()
1488:         loc_lPromo = !EMPTY(loc_cPromo)
1489: 
1490:         loc_cWhere = "("
1491:         SELECT CrProdutos
1492:         FOR loc_nI = 1 TO 15
1493:             IF !EOF("CrProdutos")
1494:                 loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
1495:                 SKIP IN CrProdutos
1496:             ENDIF
1497:         ENDFOR
1498:         loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"
1499: 
1500:         TRY
1501:             IF USED("Tmp_Imagens")
1502:                 USE IN Tmp_Imagens
1503:             ENDIF
1504: 
1505:             loc_cSQL = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)
1506:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "Tmp_Imagens")
1507: 
1508:             IF loc_nResultado < 0
1509:                 MsgErro("Erro ao consultar produtos para exibi" + CHR(231) + CHR(227) + "o." + ;
1510:                     CHR(13) + CapturarErroSQL(), "Erro SQL")
1511:             ENDIF
1512:         CATCH TO loc_oErro
1513:             MsgErro(loc_oErro.Message + CHR(13) + ;
1514:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1515:                 "Procedure: " + loc_oErro.Procedure, ;
1516:                 "Erro ao montar p" + CHR(225) + "gina de produtos")
1517:         ENDTRY
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * MostFig - transcricao de PROCEDURE mostfig do legado (a variante COM
1522:     * "Clear Resources", que eh a chamada em TODO call site do dump -
1523:     * "mosfig", sem o 't', esta declarada mas nunca referenciada: dead code).
1524:     * Exibe o slot par_nNum (1 a 15) com o registro CORRENTE de Tmp_Imagens e
1525:     * avanca (SKIP) para o proximo - por isso FOR Cnt = 1 TO 15 chamando
1526:     * MostFig(Cnt) em sequencia percorre os ate-15 produtos da pagina.
1527:     *
1528:     * lcImg/xMac do legado (Sys(2015) + numero do slot) viram o nome do
1529:     * arquivo temporario JPG decodificado do base64 - mantido via SYS(2015)
1530:     * (identificador unico por sessao) + SYS(2023) (pasta temp do VFP), para
1531:     * nao colidir nome de arquivo entre instancias/paginas.
1532:     *==========================================================================
1533:     PROCEDURE MostFig(par_nNum)
1534:         LOCAL loc_cMac, loc_cArquivo, loc_cFoto, loc_oImg
1535: 
1536:         IF !USED("Tmp_Imagens")
1537:             RETURN
1538:         ENDIF
1539: 
1540:         loc_cMac = ALLTRIM(STR(par_nNum, 2))
1541:         loc_oImg = EVALUATE("THIS.cnt_4c_Imagem" + loc_cMac)
1542: 
1543:         SELECT Tmp_Imagens
1544:         IF !EOF()
1545:             THIS.this_nItem = THIS.this_nItem + 1
1546:             loc_cArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + loc_cMac + ".jpg"
1547: 
1548:             IF !ISNULL(Tmp_Imagens.figjpgs) AND !EMPTY(Tmp_Imagens.figjpgs)
1549:                 CLEAR RESOURCES
1550:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(Tmp_Imagens.figjpgs, ;
1551:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1552:                     "data:image/jpg;base64,", ""), 14)
1553:                 STRTOFILE(loc_cFoto, loc_cArquivo)
1554:                 loc_oImg.Visible         = .T.
1555:                 loc_oImg.img_4c_IMG.Picture = loc_cArquivo
1556:             ELSE
1557:                 loc_oImg.Visible         = .T.
1558:                 loc_oImg.img_4c_IMG.Picture = ""
1559:             ENDIF
1560: 
1561:             loc_oImg.lbl_4c_Label1.Caption  = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
1562:             loc_oImg.chk_4c_Check1.Value    = Tmp_Imagens.flag
1563:             SKIP
1564:         ELSE
1565:             loc_oImg.Visible = .F.
1566:         ENDIF
1567:     ENDPROC
1568: 
1569:     *==========================================================================
1570:     * RedesenharPaginaAtual - bloco repetido em CmdDesmarcarTelaClick/
1571:     * CmdSelecionarTelaClick e dentro dos blocos maiores (Init/Command2-4/
1572:     * PROXPAG/ANTPAG do legado): "Select Tmp_Imagens / Go Top / Pag1=.F. /
1573:     * Pag2=.F. / Item=0 / For Cnt=1 to 15 / MostFig(Cnt)". So redesenha os
1574:     * slots com o conteudo ATUAL de Tmp_Imagens - nao reconsulta nada.
1575:     *==========================================================================
1576:     PROTECTED PROCEDURE RedesenharPaginaAtual()
1577:         LOCAL loc_nCnt
1578: 
1579:         IF !USED("Tmp_Imagens")
1580:             RETURN
1581:         ENDIF
1582: 
1583:         SELECT Tmp_Imagens
1584:         GO TOP
1585:         THIS.this_lPag1 = .F.
1586:         THIS.this_lPag2 = .F.
1587:         THIS.this_nItem = 0
1588: 
1589:         FOR loc_nCnt = 1 TO 15
1590:             THIS.MostFig(loc_nCnt)
1591:         ENDFOR
1592:     ENDPROC
1593: 
1594:     *==========================================================================
1595:     * FinalizarPaginacao - fecho comum a Init/PROXPAG/ANTPAG/Command3/
1596:     * Command4 do legado, executado IMEDIATAMENTE depois de
1597:     * RedesenharPaginaAtual() e de this_nNumPag (e, quando aplicavel,
1598:     * this_nTotPag) ja estarem atualizados pelo chamador:
1599:     *   ThisForm.Primeira = Recno()
1600:     *   ThisForm.Pag1 = (ThisForm.Item = 15 And Not Eof())
1601:     *   ThisForm.Pagina.Caption = 'Pagina : '+Transf(NumPag,'@ 999')+'/'+...
1602:     *   ThisForm.TelaInic = .T.
1603:     *==========================================================================
1604:     PROTECTED PROCEDURE FinalizarPaginacao()
1605:         IF !USED("Tmp_Imagens")
1606:             RETURN
1607:         ENDIF
1608: 
1609:         THIS.this_nPrimeira = RECNO("Tmp_Imagens")
1610:         THIS.this_lPag1     = (THIS.this_nItem = 15 AND !EOF("Tmp_Imagens"))
1611:         THIS.this_lTelaInic = .T.
1612: 
1613:         *-- O caption da pagina ("Pagina : NNN/NNN") eh a UNICA projecao
1614:         *-- visivel do estado de paginacao, e ele sai do BO: FormParaBO
1615:         *-- empurra os totais recem-calculados e BOParaForm os traz de volta
1616:         *-- e chama AtualizarCaptionPagina. Fonte unica - a tela nunca
1617:         *-- recalcula o numero por conta propria.
1618:         THIS.FormParaBO()
1619:         THIS.BOParaForm()
1620:     ENDPROC
1621: 
1622:     *==========================================================================
1623:     * ReiniciarPaginacao - bloco "primeira pagina" repetido em Init/
1624:     * CmdDesmarcarTodosClick/CmdSelecionarTodosClick do legado:
1625:     *   Select CrProdutos / lTotReg = RecCount() / TotPro = lTotReg /
1626:     *   TotReg = 15 / <redesenha a pagina> / Primeira = Recno() /
1627:     *   Pag1 = (Item=15 And !Eof()) / TotPag = Ceiling(lTotReg/15) /
1628:     *   NumPag = 1 / Pagina.Caption = ... / TelaInic = .T.
1629:     *==========================================================================
1630:     PROTECTED PROCEDURE ReiniciarPaginacao()
1631:         LOCAL loc_nTotReg
1632: 
1633:         IF !USED("CrProdutos")
1634:             RETURN
1635:         ENDIF
1636: 
1637:         loc_nTotReg = RECCOUNT("CrProdutos")
1638:         THIS.this_nTotPro = loc_nTotReg
1639:         THIS.this_nTotReg = 15
1640: 
1641:         THIS.RedesenharPaginaAtual()
1642: 
1643:         THIS.this_nTotPag = CEILING(loc_nTotReg / 15)
1644:         THIS.this_nNumPag = 1
1645:         THIS.FinalizarPaginacao()
1646:     ENDPROC
1647: 
1648:     *==========================================================================
1649:     * AtualizarCaptionPagina - transcricao de
1650:     *   ThisForm.Pagina.Caption = 'Pagina : '+Transf(NumPag,'@ 999')+'/'+
1651:     *                              AllTrim(Transf(TotPag,'@ 999'))
1652:     * NumPag SEM Alltrim (fica com espacos a esquerda, '@ 999'); TotPag COM
1653:     * Alltrim - transcrito como esta, nao eh inconsistencia de migracao.
1654:     *==========================================================================
1655:     PROTECTED PROCEDURE AtualizarCaptionPagina()
1656:         THIS.lbl_4c_Pagina.Caption = "P" + CHR(225) + "gina : " + ;
1657:             TRANSFORM(THIS.this_nNumPag, "@ 999") + "/" + ;
1658:             ALLTRIM(TRANSFORM(THIS.this_nTotPag, "@ 999"))
1659:     ENDPROC
1660: 
1661:     *==========================================================================
1662:     * ReposicionarTmpImagens - bloco repetido ao fim de GeraArquivo/Exporta/
1663:     * relpecas.Click do legado:
1664:     *   Select Tmp_Imagens / If Primeira<=RecCount() / Go Primeira / Else /
1665:     *   Go Bottom / If !Eof() / Skip / EndIf / EndIf
1666:     * Guarda this_nPrimeira >= 1 (igual ao ChkImp) porque "GO 0" estoura
1667:     * "Record is out of range" - o legado nunca chega aqui com Primeira = 0
1668:     * porque PagInicial sempre roda antes; aqui os botoes podem ser clicados
1669:     * antes de qualquer pagina carregada.
1670:     *==========================================================================
1671:     PROTECTED PROCEDURE ReposicionarTmpImagens()
1672:         IF !USED("Tmp_Imagens")
1673:             RETURN
1674:         ENDIF
1675: 
1676:         SELECT Tmp_Imagens
1677:         IF THIS.this_nPrimeira >= 1 AND THIS.this_nPrimeira <= RECCOUNT()
1678:             GO THIS.this_nPrimeira
1679:         ELSE
1680:             GO BOTTOM
1681:             IF !EOF()
1682:                 SKIP
1683:             ENDIF
1684:         ENDIF
1685:     ENDPROC
1686: 
1687:     *==========================================================================
1688:     * CmdGeraArquivoClick - transcricao de SIGOPPEC.GeraArquivo.Click:
1689:     *   Do Form SigOpGar With ThisForm
1690:     *   <reposiciona Tmp_Imagens>
1691:     * SigOpGar JA foi migrado (task738) como classe "Formsigopgar", que
1692:     * aceita o form pai como 1o parametro opcional (Init(par_oFormPai)) -
1693:     * equivalente exato do "With ThisForm" do legado. CREATEOBJECT dentro do
1694:     * TRY, Show() FORA dele (regra CLAUDE.md #29 - Show() de form dentro de
1695:     * TRY faz qualquer erro de runtime do dialogo fechar esta tela).
1696:     *==========================================================================
1697:     PROCEDURE CmdGeraArquivoClick()
1698:         LOCAL loc_oForm, loc_oErro
1699:         loc_oForm = .NULL.
1700: 
1701:         TRY
1702:             loc_oForm = CREATEOBJECT("Formsigopgar", THIS)
1703:         CATCH TO loc_oErro
1704:             MsgErro("Erro ao abrir Gera" + CHR(231) + CHR(227) + "o de Arquivo:" + ;
1705:                 CHR(13) + loc_oErro.Message, "Erro")
1706:             loc_oForm = .NULL.
1707:         ENDTRY
1708: 
1709:         IF VARTYPE(loc_oForm) = "O"
1710:             loc_oForm.Show()
1711:         ENDIF
1712: 
1713:         THIS.ReposicionarTmpImagens()
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * CmdDesmarcarTelaClick - transcricao de SIGOPPEC.Command2.Click
1718:     * ("Desmarcar Tela"): zera flag de TODOS os produtos da pagina CORRENTE
1719:     * em Tmp_Imagens e remove cada um do cursor de selecao (CrImagens),
1720:     * depois redesenha a pagina. Usa RemoverDoCursorSelecao, ja escrito no
1721:     * BO para este exato proposito (ver cabecalho do SigOpPecBO.prg).
1722:     *==========================================================================
1723:     PROCEDURE CmdDesmarcarTelaClick()
1724:         LOCAL loc_cCpros, loc_oErro
1725: 
1726:         IF !USED("Tmp_Imagens")
1727:             RETURN
1728:         ENDIF
1729: 
1730:         TRY
1731:             SELECT Tmp_Imagens
1732:             GO TOP
1733:             SCAN
1734:                 REPLACE Tmp_Imagens.flag WITH 0
1735:                 loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
1736:                 THIS.this_oBusinessObject.RemoverDoCursorSelecao("CrImagens", loc_cCpros)
1737:                 SELECT Tmp_Imagens
1738:             ENDSCAN
1739: 
1740:             THIS.RedesenharPaginaAtual()
1741:         CATCH TO loc_oErro
1742:             MsgErro(loc_oErro.Message + CHR(13) + ;
1743:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1744:                 "Procedure: " + loc_oErro.Procedure, ;
1745:                 "Erro ao desmarcar produtos da tela")
1746:         ENDTRY
1747:     ENDPROC
1748: 
1749:     *==========================================================================
1750:     * CmdSelecionarTelaClick - transcricao de SIGOPPEC.Command1.Click
1751:     * ("Selecionar Tela"): marca flag=1 de TODOS os produtos da pagina
1752:     * CORRENTE e adiciona ao cursor de selecao (CrImagens) os que ainda nao
1753:     * estavam la, buscando o fornecedor (par_lBuscarFornecedor = .T., como o
1754:     * legado - unica diferenca do ChkImp, que nunca busca fornecedor).
1755:     *==========================================================================
1756:     PROCEDURE CmdSelecionarTelaClick()
1757:         LOCAL loc_cCpros, loc_oErro
1758: 
1759:         IF !USED("Tmp_Imagens")
1760:             RETURN
1761:         ENDIF
1762: 
1763:         TRY
1764:             SELECT Tmp_Imagens
1765:             GO TOP
1766:             SCAN
1767:                 REPLACE Tmp_Imagens.flag WITH 1
1768:                 loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
1769: 
1770:                 IF !THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCpros)
1771:                     SELECT Tmp_Imagens
1772:                     THIS.this_oBusinessObject.CarregarDoCursor("Tmp_Imagens")
1773:                     THIS.this_oBusinessObject.AdicionarAoCursorSelecao("CrImagens", .T.)
1774:                 ENDIF
1775: 
1776:                 SELECT Tmp_Imagens
1777:             ENDSCAN
1778: 
1779:             THIS.RedesenharPaginaAtual()
1780:         CATCH TO loc_oErro
1781:             MsgErro(loc_oErro.Message + CHR(13) + ;
1782:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1783:                 "Procedure: " + loc_oErro.Procedure, ;
1784:                 "Erro ao selecionar produtos da tela")
1785:         ENDTRY
1786:     ENDPROC
1787: 
1788:     *==========================================================================
1789:     * CmdExportaClick - transcricao de SIGOPPEC.Exporta.Click ("Exportar
1790:     * Imagens"): confirma com o usuario (MsgConfirma, NAO MessageBox - regra
1791:     * CLAUDE.md), pede o diretorio destino (GetDir - funcao nativa VFP),
1792:     * confere que o diretorio existe e grava um .JPG por produto de
1793:     * CrImagens decodificando a figjpgs base64 (mesma rotina de MostFig).
1794:     *
1795:     * O legado repete a checagem Directory() a CADA iteracao do Scan - aqui
1796:     * ela sai do loop (checagem invariante, nao regra de negocio) porque o
1797:     * resultado NAO muda entre produtos.
1798:     *==========================================================================
1799:     PROCEDURE CmdExportaClick()
1800:         LOCAL loc_cDirImagem, loc_cCodigo, loc_cArquivo, loc_cFoto, loc_oErro
1801: 
1802:         IF !MsgConfirma("Confirma Exporta" + CHR(231) + CHR(227) + "o das Imagens " + ;
1803:                 "Selecionadas ?", "")
1804:             RETURN
1805:         ENDIF
1806: 
1807:         loc_cDirImagem = GETDIR()
1808: 
1809:         IF !DIRECTORY(loc_cDirImagem)
1810:             MsgErro("O Diret" + CHR(243) + "rio de Imagens [" + ALLTRIM(loc_cDirImagem) + "]" + ;
1811:                 CHR(13) + "N" + CHR(227) + "o Foi Encontrado ou o Acesso Foi Negado!!! " + ;
1812:                 "Verifique!!!", "")
1813:             RETURN
1814:         ENDIF
1815: 
1816:         IF !USED("CrImagens")
1817:             RETURN
1818:         ENDIF
1819: 
1820:         WAIT WINDOW "Aguarde Exportando Imagens !" NOWAIT
1821: 
1822:         TRY
1823:             SELECT CrImagens
1824:             GO TOP
1825:             SCAN
1826:                 loc_cCodigo  = STRTRAN(STRTRAN(CrImagens.cpros, "/", ""), " ", "")
1827:                 loc_cArquivo = loc_cDirImagem + ALLTRIM(loc_cCodigo) + ".JPG"
1828: 
1829:                 IF !ISNULL(CrImagens.figjpgs) AND !EMPTY(CrImagens.figjpgs)
1830:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(CrImagens.figjpgs, ;
1831:                         "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1832:                         "data:image/jpg;base64,", ""), 14)
1833:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1834:                 ENDIF
1835:             ENDSCAN
1836: 
1837:             THIS.ReposicionarTmpImagens()
1838: 
1839:             WAIT CLEAR
1840:             MsgInfo("Imagens Exportadas com Sucesso!!!" + CHR(13) + ;
1841:                 "Em " + ALLTRIM(loc_cDirImagem), "Exporta" + CHR(231) + CHR(227) + "o")
1842:         CATCH TO loc_oErro
1843:             WAIT CLEAR
1844:             MsgErro(loc_oErro.Message + CHR(13) + ;
1845:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1846:                 "Procedure: " + loc_oErro.Procedure, ;
1847:                 "Erro ao exportar imagens")
1848:         ENDTRY
1849:     ENDPROC
1850: 
1851:     *==========================================================================
1852:     * CmdRelPecasClick - transcricao de SIGOPPEC.relpecas.Click ("Imprimir
1853:     * Produtos"): le o filtro Operacao/OperacaoI/Empresa do form pai (so
1854:     * quando NAO estiver em modo automatico - igual ao legado), completa
1855:     * dFors em branco em CrImagens via ObterDescricaoFornecedor (ja escrito
1856:     * no BO) e abre o relatorio "SigRePca".
1857:     *
1858:     * "SigRePca" (Relacao de Pecas) esta FORA do escopo desta task (task778
1859:     * eh so SIGOPPEC) e ainda nao foi migrado - diferente de SigOpGar
1860:     * (task738, ja existe como "Formsigopgar"). CREATEOBJECT fica dentro do
1861:     * TRY; se a classe nao existir ainda, o erro cai no CATCH e MsgErro
1862:     * avisa - caminho de erro PADRAO do projeto para dependencia ausente,
1863:     * nao um stub: quando "FormSigRePca" for migrado, este Click passa a
1864:     * abri-lo sem precisar de nenhuma mudanca aqui.
1865:     *==========================================================================
1866:     PROCEDURE CmdRelPecasClick()
1867:         LOCAL loc_cOpe, loc_nNum, loc_cEmp, loc_cDesc, loc_oForm, loc_oErro, loc_lProsseguir
1868:         loc_cOpe = ""
1869:         loc_nNum = 0
1870:         loc_cEmp = ""
1871:         loc_oForm = .NULL.
1872:         loc_lProsseguir = .T.
1873: 
1874:         IF !THIS.this_lAuto AND VARTYPE(THIS.this_oFormPai) = "O"
1875:             TRY
1876:                 loc_cOpe = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
1877:                     "Pag_Consulta.Filtro.Principal.Get_Opera" + CHR(231) + CHR(227) + "o.Value"), "")
1878:                 loc_nNum = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
1879:                     "Pag_Consulta.Filtro.Principal.Get_Opera" + CHR(231) + CHR(227) + "oI.Value"), 0)
1880:                 loc_cEmp = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
1881:                     "Pag_Consulta.Filtro.Principal.getEmps.Value"), "")
1882:             CATCH TO loc_oErro
1883:                 loc_cOpe = ""
1884:                 loc_nNum = 0
1885:                 loc_cEmp = ""
1886:             ENDTRY
1887:         ENDIF
1888: 
1889:         IF USED("CrImagens")
1890:             TRY
1891:                 SELECT CrImagens
1892:                 GO TOP
1893:                 SCAN
1894:                     IF EMPTY(TratarNulo(CrImagens.dFors, ""))
1895:                         loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoFornecedor(CrImagens.ifors)
1896:                         REPLACE dFors WITH loc_cDesc
1897:                     ENDIF
1898:                 ENDSCAN
1899:                 GO TOP IN CrImagens
1900:             CATCH TO loc_oErro
1901:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1902:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1903:                     "Erro ao preparar impress" + CHR(227) + "o")
1904:                 loc_lProsseguir = .F.
1905:             ENDTRY
1906:         ENDIF
1907: 
1908:         IF loc_lProsseguir
1909:             TRY
1910:                 loc_oForm = CREATEOBJECT("FormSigRePca", loc_cOpe, loc_nNum, loc_cEmp)
1911:             CATCH TO loc_oErro
1912:                 MsgErro("Erro ao abrir Relat" + CHR(243) + "rio de Rela" + CHR(231) + CHR(227) + ;
1913:                     "o de Pe" + CHR(231) + "as:" + CHR(13) + loc_oErro.Message, "Erro")
1914:                 loc_oForm = .NULL.
1915:             ENDTRY
1916: 
1917:             IF VARTYPE(loc_oForm) = "O"
1918:                 loc_oForm.Show()
1919:             ENDIF
1920: 
1921:             THIS.ReposicionarTmpImagens()
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     *==========================================================================
1926:     * CmdDesmarcarTodosClick - transcricao de SIGOPPEC.Command3.Click
1927:     * ("Desmarcar Todos"): zera flag em Tmp_Imagens E CrImagens (UPDATE ...
1928:     * SET Flag = 0 - os dois cursores LOCAIS do legado, nao tabela do SQL
1929:     * Server), recarrega a primeira pagina do filtro corrente e redesenha.
1930:     * O bloco grande comentado com "*!*" no dump (Scan produto a produto
1931:     * reconsultando e removendo de CrImagens) esta DESATIVADO no legado -
1932:     * nao transcrito, igual ao original comentado.
1933:     *==========================================================================
1934:     PROCEDURE CmdDesmarcarTodosClick()
1935:         LOCAL loc_oErro
1936: 
1937:         TRY
1938:             IF USED("Tmp_Imagens")
1939:                 UPDATE Tmp_Imagens SET flag = 0
1940:             ENDIF
1941:             IF USED("CrImagens")
1942:                 UPDATE CrImagens SET flag = 0
1943:             ENDIF
1944: 
1945:             IF USED("CrProdutos")
1946:                 SELECT CrProdutos
1947:                 GO TOP
1948:                 IF !EOF()
1949:                     THIS.PagInicial()
1950:                 ENDIF
1951:             ENDIF
1952: 
1953:             THIS.CmdDesmarcarTelaClick()
1954:             THIS.ReiniciarPaginacao()
1955:         CATCH TO loc_oErro
1956:             MsgErro(loc_oErro.Message + CHR(13) + ;
1957:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1958:                 "Procedure: " + loc_oErro.Procedure, ;
1959:                 "Erro ao desmarcar todos os produtos")
1960:         ENDTRY
1961:     ENDPROC
1962: 
1963:     *==========================================================================
1964:     * CmdSelecionarTodosClick - transcricao de SIGOPPEC.Command4.Click
1965:     * ("Selecionar Todos"): percorre TODOS os produtos de CrProdutos (nao so
1966:     * a pagina visivel), um a um - consulta individual via MontarSQLImagens
1967:     * com WHERE de UM produto, igual ao legado -, insere em CrImagens quando
1968:     * ainda nao existe (par_lBuscarFornecedor = .T.) ou so marca flag = 1
1969:     * quando ja existia. Por fim recarrega e redesenha a primeira pagina.
1970:     *==========================================================================
1971:     PROCEDURE CmdSelecionarTodosClick()
1972:         LOCAL loc_cPromo, loc_lPromo, loc_cCodigo, loc_cWhere, loc_cSQL, loc_nResultado, loc_oErro
1973: 
1974:         IF !USED("CrProdutos")
1975:             RETURN
1976:         ENDIF
1977: 
1978:         loc_cPromo = THIS.ObterFiltroPromocao()
1979:         loc_lPromo = !EMPTY(loc_cPromo)
1980: 
1981:         TRY
1982:             SELECT CrProdutos
1983:             GO TOP
1984:             SCAN
1985:                 loc_cCodigo = ALLTRIM(TratarNulo(CrProdutos.cpros, ""))
1986:                 loc_cWhere  = "(a.cpros = " + EscaparSQL(loc_cCodigo) + ")"
1987:                 loc_cSQL    = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)
1988: 
1989:                 IF USED("cursor_4c_LocalImg")
1990:                     USE IN cursor_4c_LocalImg
1991:                 ENDIF
1992:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImg")
1993: 
1994:                 IF loc_nResultado >= 0 AND USED("cursor_4c_LocalImg") AND RECCOUNT("cursor_4c_LocalImg") > 0
1995:                     IF !THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCodigo)
1996:                         SELECT cursor_4c_LocalImg
1997:                         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_LocalImg")
1998:                         THIS.this_oBusinessObject.this_nFlag = 1
1999:                         THIS.this_oBusinessObject.AdicionarAoCursorSelecao("CrImagens", .T.)
2000:                     ELSE
2001:                         SELECT CrImagens
2002:                         GO TOP
2003:                         LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
2004:                         IF FOUND()
2005:                             REPLACE flag WITH 1
2006:                         ENDIF
2007:                     ENDIF
2008:                 ENDIF
2009: 
2010:                 IF USED("cursor_4c_LocalImg")
2011:                     USE IN cursor_4c_LocalImg

*-- Linhas 2025 a 2080:
2025:         CATCH TO loc_oErro
2026:             MsgErro(loc_oErro.Message + CHR(13) + ;
2027:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2028:                 "Procedure: " + loc_oErro.Procedure, ;
2029:                 "Erro ao selecionar todos os produtos")
2030:         ENDTRY
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * BotoesConsultaProxPagClick - transcricao de BOTOES_CONSULTA.PROXPAG.
2035:     * Click (Buttons(1), "Proxima Pagina"): avanca a janela de 15 produtos a
2036:     * partir do ULTIMO cpros exibido em Tmp_Imagens. Se nao houver proximo
2037:     * produto em CrProdutos (fim da lista), reposiciona Tmp_Imagens no
2038:     * produto que estava sendo exibido e nao faz mais nada - igual ao legado.
2039:     *==========================================================================
2040:     PROCEDURE BotoesConsultaProxPagClick()
2041:         LOCAL loc_cPromo, loc_lPromo, loc_cCodAtual, loc_cCodIni, loc_cWhere
2042:         LOCAL loc_cSQL, loc_nResultado, loc_nI, loc_cCpros, loc_oErro
2043: 
2044:         IF !USED("Tmp_Imagens") OR !USED("CrProdutos")
2045:             RETURN
2046:         ENDIF
2047: 
2048:         TRY
2049:             loc_cPromo = THIS.ObterFiltroPromocao()
2050:             loc_lPromo = !EMPTY(loc_cPromo)
2051: 
2052:             THIS.this_nTotReg = IIF((THIS.this_nTotReg / 15) = THIS.this_nTotPag, ;
2053:                 THIS.this_nTotReg, THIS.this_nTotReg + 15)
2054: 
2055:             SELECT Tmp_Imagens
2056:             loc_cCodAtual = Tmp_Imagens.cpros
2057:             GO BOTTOM
2058:             loc_cCodIni = Tmp_Imagens.cpros
2059: 
2060:             loc_cWhere = "("
2061:             SELECT CrProdutos
2062:             GO TOP
2063:             LOCATE FOR ALLTRIM(cpros) == ALLTRIM(loc_cCodIni)
2064: 
2065:             IF FOUND()
2066:                 SKIP
2067:                 IF !EOF()
2068:                     FOR loc_nI = 1 TO 15
2069:                         IF !EOF("CrProdutos")
2070:                             loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
2071:                             SKIP IN CrProdutos
2072:                         ENDIF
2073:                     ENDFOR
2074:                     loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"
2075: 
2076:                     IF USED("Tmp_Imagens")
2077:                         USE IN Tmp_Imagens
2078:                     ENDIF
2079: 
2080:                     loc_cSQL = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)

*-- Linhas 2105 a 2160:
2105:         CATCH TO loc_oErro
2106:             MsgErro(loc_oErro.Message + CHR(13) + ;
2107:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2108:                 "Procedure: " + loc_oErro.Procedure, ;
2109:                 "Erro ao avan" + CHR(231) + "ar de p" + CHR(225) + "gina")
2110:         ENDTRY
2111:     ENDPROC
2112: 
2113:     *==========================================================================
2114:     * BotoesConsultaAntPagClick - transcricao de BOTOES_CONSULTA.ANTPAG.Click
2115:     * (Buttons(2), "Pagina Anterior"): se o primeiro produto exibido JA eh o
2116:     * primeiro de CrProdutos, nao ha pagina anterior - sai sem fazer nada
2117:     * (igual ao legado, "Return(.T.)"). Senao volta 15 posicoes a partir do
2118:     * produto atual e reconstroi a janela.
2119:     *==========================================================================
2120:     PROCEDURE BotoesConsultaAntPagClick()
2121:         LOCAL loc_cPromo, loc_lPromo, loc_cCodAtual, loc_cWhere
2122:         LOCAL loc_cSQL, loc_nResultado, loc_nI, loc_cCpros, loc_oErro
2123: 
2124:         IF !USED("Tmp_Imagens") OR !USED("CrProdutos")
2125:             RETURN
2126:         ENDIF
2127: 
2128:         SELECT Tmp_Imagens
2129:         GO TOP
2130:         loc_cCodAtual = Tmp_Imagens.cpros
2131: 
2132:         SELECT CrProdutos
2133:         GO TOP
2134:         IF ALLTRIM(CrProdutos.cpros) == ALLTRIM(loc_cCodAtual)
2135:             RETURN
2136:         ENDIF
2137: 
2138:         TRY
2139:             loc_cPromo = THIS.ObterFiltroPromocao()
2140:             loc_lPromo = !EMPTY(loc_cPromo)
2141: 
2142:             THIS.this_nTotReg = IIF((THIS.this_nTotReg - 15) < 0, THIS.this_nTotReg, ;
2143:                 THIS.this_nTotReg - 15)
2144: 
2145:             loc_cWhere = "("
2146:             SELECT CrProdutos
2147:             LOCATE FOR ALLTRIM(cpros) == ALLTRIM(loc_cCodAtual)
2148: 
2149:             IF FOUND()
2150:                 SKIP -15 IN CrProdutos
2151: 
2152:                 FOR loc_nI = 1 TO 15
2153:                     SELECT CrProdutos
2154:                     loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
2155:                     SKIP IN CrProdutos
2156:                 ENDFOR
2157:                 loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"
2158: 
2159:                 IF USED("Tmp_Imagens")
2160:                     USE IN Tmp_Imagens

*-- Linhas 2186 a 2549:
2186:         CATCH TO loc_oErro
2187:             MsgErro(loc_oErro.Message + CHR(13) + ;
2188:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2189:                 "Procedure: " + loc_oErro.Procedure, ;
2190:                 "Erro ao voltar de p" + CHR(225) + "gina")
2191:         ENDTRY
2192:     ENDPROC
2193: 
2194:     *==========================================================================
2195:     * BotoesConsultaSairClick - transcricao de BOTOES_CONSULTA.sair.Click
2196:     * (Buttons(3), "[ESC] Encerrar", Cancel = .T.): restaura a ordem de
2197:     * CrProdutos e encerra a tela. THIS.Release() eh o metodo nativo de Form
2198:     * (herdado via FormBase) - equivalente exato de "ThisForm.Release" no
2199:     * legado; FormBase.Destroy() (ja implementado nesta classe, chama
2200:     * DODEFAULT()) roda na sequencia normal de destruicao.
2201:     *==========================================================================
2202:     PROCEDURE BotoesConsultaSairClick()
2203:         IF USED("CrProdutos")
2204:             SELECT CrProdutos
2205:             SET ORDER TO Cpros
2206:         ENDIF
2207: 
2208:         THIS.Release()
2209:     ENDPROC
2210: 
2211:     *==========================================================================
2212:     * BotoesConsultaSelPaginaClick - transcricao de BOTOES_CONSULTA.
2213:     * Command1.Click (Buttons(4), "Selecionar Pagina" - nome do botao no
2214:     * dump eh "Command1", colidido com o cmd_4c_Command1 standalone, mas sao
2215:     * objetos DIFERENTES - um eh Buttons(4) do grupo, outro filho direto do
2216:     * form): abre o painel "Selecione a Pagina :" (cnt_4c__Pag), esconde a
2217:     * barra de navegacao e poe o foco no campo. SetFocus em TRY proprio
2218:     * (mesma razao do FecharPainelPaginacao - o controle acabou de virar
2219:     * visivel e o foco pode ser recusado em casos de borda).
2220:     *==========================================================================
2221:     PROCEDURE BotoesConsultaSelPaginaClick()
2222:         LOCAL loc_oErro
2223: 
2224:         THIS.obj_4c_BOTOES_CONSULTA.Visible  = .F.
2225:         THIS.cnt_4c__Pag.Visible             = .T.
2226:         THIS.cnt_4c__Pag.txt_4c_Text1.Value   = 0
2227: 
2228:         TRY
2229:             THIS.cnt_4c__Pag.txt_4c_Text1.SetFocus()
2230:         CATCH TO loc_oErro
2231:             *-- Foco recusado - o painel ja esta correto (visivel, barra de
2232:             *-- navegacao oculta); sem MsgErro de proposito, mesmo criterio
2233:             *-- do FecharPainelPaginacao.
2234:         ENDTRY
2235:     ENDPROC
2236: 
2237:     *==========================================================================
2238:     * BtnCancelarClick - Click de SIGOPPEC.Cnt_Pag.Command4, o botao do
2239:     * painel "Selecione a Pagina :" que o dump declara com Cancel = .T.
2240:     * (ESC do painel) e ToolTipText "Encerrar":
2241:     *   ThisForm.Cnt_Pag.Visible = .F.
2242:     *   ThisForm.BOTOES_CONSULTA.Visible = .T.
2243:     *   ThisForm.BOTOES_CONSULTA.Command1.SetFocus
2244:     *   Return
2245:     * Abandona a selecao de pagina SEM navegar - nenhuma das tres linhas
2246:     * mexe em CrProdutos/Tmp_Imagens. O corpo mora em FecharPainelPaginacao
2247:     * porque ValidarPaginaSelecionada chama o MESMO bloco nas suas duas
2248:     * recusas (pagina menor ou igual a 0 e pagina acima da ultima), do mesmo
2249:     * jeito que o legado repete as 3 linhas nos tres lugares.
2250:     *==========================================================================
2251:     PROCEDURE BtnCancelarClick()
2252:         THIS.FecharPainelPaginacao()
2253:     ENDPROC
2254: 
2255:     *==========================================================================
2256:     * AjustarBotoesPorAcesso - transcricao do bloco de permissoes do Init
2257:     * legado:
2258:     *   If fChecaAcesso('SigOpPec','EXPORTA')  -> Exporta.Visible    = .T./.F.
2259:     *   If fChecaAcesso('SigOpPec','GERACAO')  -> GeraArquivo.Visible= .T./.F.
2260:     *   If fChecaAcesso('SigOpPec','IMPRIMIR') -> RelPecas.Visible   = .T./.F.
2261:     * Os tres If/Else do legado atribuem exatamente o resultado da funcao,
2262:     * entao a atribuicao direta eh a mesma coisa escrita uma vez.
2263:     *
2264:     * fChecaAcesso eh chamada com DOIS argumentos, como o legado - os tres
2265:     * parametros restantes da funcao de Framework\sigacess.PRG tem fallback
2266:     * proprio (o usuario cai em Usuar). NUNCA chamada em modo validacao de
2267:     * UI / teste: ela consulta SigCdAcu no SQL Server (ver o guard em
2268:     * InicializarForm).
2269:     *
2270:     * Este form NAO tem cascata de Left dependendo de quem ficou visivel (ao
2271:     * contrario de outros forms OPERACIONAIS): no dump os sete botoes do topo
2272:     * tem Left fixo e o legado nao reposiciona nenhum deles.
2273:     *==========================================================================
2274:     PROTECTED PROCEDURE AjustarBotoesPorAcesso()
2275:         THIS.cmd_4c_Exporta.Visible     = fChecaAcesso("SigOpPec", "EXPORTA")
2276:         THIS.cmd_4c_GeraArquivo.Visible = fChecaAcesso("SigOpPec", "GERACAO")
2277:         THIS.cmd_4c_Relpecas.Visible    = fChecaAcesso("SigOpPec", "IMPRIMIR")
2278:     ENDPROC
2279: 
2280:     *==========================================================================
2281:     * PrepararProdutosModoAutomatico - transcricao do ramo plAuto do Init
2282:     * legado:
2283:     *   If plAuto
2284:     *       Select * From crCatalogo Into Cursor crProdutos ReadWrite
2285:     *       Index On Cpros Tag Cpros
2286:     *   Endif
2287:     * Em modo automatico (rotina em lote) nao existe form pai com a consulta
2288:     * de produtos montada: a lista vem do cursor crCatalogo deixado pelo
2289:     * processo que chamou esta tela, e eh copiada para CrProdutos - o cursor
2290:     * por onde TODA a paginacao desta tela navega.
2291:     *
2292:     * Duas guardas que o legado nao tinha: crCatalogo fechado (o legado
2293:     * estouraria "Alias CRCATALOGO is not found") e CrProdutos ja aberto
2294:     * (SELECT ... INTO CURSOR sobre alias em uso eh recusado pelo VFP). Nos
2295:     * dois casos a tela segue para a carga, que trata CrProdutos ausente.
2296:     *==========================================================================
2297:     PROTECTED PROCEDURE PrepararProdutosModoAutomatico()
2298:         LOCAL loc_oErro
2299: 
2300:         IF !THIS.this_lAuto
2301:             RETURN
2302:         ENDIF
2303: 
2304:         IF !USED("crCatalogo")
2305:             RETURN
2306:         ENDIF
2307: 
2308:         TRY
2309:             IF USED("CrProdutos")
2310:                 USE IN CrProdutos
2311:             ENDIF
2312: 
2313:             SELECT * FROM crCatalogo INTO CURSOR CrProdutos READWRITE
2314:             INDEX ON Cpros TAG Cpros
2315:         CATCH TO loc_oErro
2316:             MsgErro(loc_oErro.Message + CHR(13) + ;
2317:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2318:                 "Procedure: " + loc_oErro.Procedure, ;
2319:                 "Erro ao preparar a lista de produtos")
2320:         ENDTRY
2321:     ENDPROC
2322: 
2323:     *==========================================================================
2324:     * CarregarLista - funil UNICO de carga da "lista" desta tela: os ATE 15
2325:     * produtos da pagina corrente (cursor Tmp_Imagens) e a repintura dos 15
2326:     * slots de imagem. Transcricao do bloco de carga do Init legado:
2327:     *
2328:     *   lcWhereImg = '('
2329:     *   Select CrProdutos
2330:     *   Go Top
2331:     *   If !Eof()
2332:     *       ThisForm.PagInicial()
2333:     *   EndIf
2334:     *   ...
2335:     *   If !ThisForm.TelaInic
2336:     *       If !Used('Tmp_Imagens')  -> Wait Window / Return 0
2337:     *       Select CrProdutos / lTotReg = RecCount() / TotPro = lTotReg /
2338:     *       TotReg = 15 / <redesenha os 15 slots> / Primeira = Recno() /
2339:     *       Pag1 = (Item=15 And !Eof()) / TotPag = Ceiling(lTotReg/15) /
2340:     *       NumPag = 1 / Pagina.Caption = ... / TelaInic = .T.
2341:     *   EndIf
2342:     *
2343:     * A segunda metade eh exatamente ReiniciarPaginacao (Fase 7), que ja
2344:     * fatorou esse bloco porque CmdDesmarcarTodosClick e
2345:     * CmdSelecionarTodosClick o repetem. "lcWhereImg = '('" nao eh
2346:     * transcrito: PagInicial monta o proprio WHERE em variavel local.
2347:     *
2348:     * DIFERENCA de proposito em relacao ao legado: aqui a repintura NAO fica
2349:     * sob "If !TelaInic". Como funil, CarregarLista precisa SEMPRE terminar
2350:     * repintando (regra #21 - popular cursor nao repinta a grade; o legado
2351:     * sempre fecha com Go Top + redesenho). Na ABERTURA o comportamento eh
2352:     * identico, porque TelaInic ainda esta .F. na primeira passada - o guard
2353:     * do legado existe para o caso de a tela ja ter sido montada antes, que
2354:     * eh justamente quando repintar eh o certo.
2355:     *
2356:     * Devolve .F. quando nao houve o que exibir (CrProdutos ausente/vazio,
2357:     * ou a consulta nao trouxe produto nenhum - Tmp_Imagens inexistente):
2358:     * eh o caminho do "Wait Window 'Produtos Nao Encontrados!!!' / Return 0"
2359:     * do legado, tratado por quem chama (InicializarForm aborta a abertura).
2360:     *
2361:     * PUBLIC (sem PROTECTED): o harness de teste automatizado chama
2362:     * THIS.oForm.CarregarLista() de FORA da classe (regra CLAUDE.md #3).
2363:     *==========================================================================
2364:     PROCEDURE CarregarLista()
2365:         LOCAL loc_lSucesso, loc_oErro
2366:         loc_lSucesso = .F.
2367: 
2368:         IF !USED("CrProdutos")
2369:             RETURN loc_lSucesso
2370:         ENDIF
2371: 
2372:         TRY
2373:             *-- Estado da tela (modo automatico + filtro de promocao do form
2374:             *-- pai) para o BO ANTES da consulta - PagInicial le o mesmo
2375:             *-- filtro por ObterFiltroPromocao.
2376:             THIS.FormParaBO()
2377: 
2378:             SELECT CrProdutos
2379:             GO TOP
2380:             IF !EOF()
2381:                 THIS.PagInicial()
2382:             ENDIF
2383: 
2384:             IF USED("Tmp_Imagens")
2385:                 THIS.ReiniciarPaginacao()
2386:                 loc_lSucesso = .T.
2387:             ENDIF
2388:         CATCH TO loc_oErro
2389:             MsgErro(loc_oErro.Message + CHR(13) + ;
2390:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2391:                 "Procedure: " + loc_oErro.Procedure, ;
2392:                 "Erro ao carregar a p" + CHR(225) + "gina de produtos")
2393:         ENDTRY
2394: 
2395:         RETURN loc_lSucesso
2396:     ENDPROC
2397: 
2398:     *==========================================================================
2399:     * FormParaBO - leva o estado da TELA para SigOpPecBO, que eh quem guarda
2400:     * o estado de paginacao e o filtro desta migracao (properties declaradas
2401:     * nas Fases 1/2 para este proposito):
2402:     *
2403:     *   this_lAuto    -> this_lModoAutomatico   (plauto do legado)
2404:     *   <filtro pai>  -> this_cPromocao / this_lFiltroPromocao
2405:     *                    (lcPromo/llPromo, recalculados por
2406:     *                    ObterFiltroPromocao - o form pai pode ter mudado o
2407:     *                    Get_Promo entre duas paginas)
2408:     *   this_nOrdena  -> this_nOrdena           (Ordena do legado)
2409:     *   this_nTotPro  -> this_nTotalProdutos    (TotPro)
2410:     *   this_nTotPag  -> this_nTotalPaginas     (TotPag)
2411:     *   this_nNumPag  -> this_nPaginaAtual      (NumPag)
2412:     *
2413:     * Chamado em tres pontos: no fim da montagem (InicializarForm), antes de
2414:     * cada consulta de pagina (CarregarLista) e no fecho de CADA paginacao
2415:     * (FinalizarPaginacao, que atende Init/PROXPAG/ANTPAG/Desmarcar Todos/
2416:     * Selecionar Todos) - o funil, nunca o botao (regra #40).
2417:     *
2418:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
2419:     * e o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
2420:     * nao torna o metodo publico, so esconde que ele continua protegido.
2421:     * Por isso toda chamada eh por THIS. de dentro da classe.
2422:     *
2423:     * NAO escreve nada na tela: a volta eh BOParaForm.
2424:     *==========================================================================
2425:     PROTECTED PROCEDURE FormParaBO()
2426:         LOCAL loc_lSucesso, loc_cPromo
2427:         loc_lSucesso = .F.
2428: 
2429:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2430:             loc_cPromo = THIS.ObterFiltroPromocao()
2431: 
2432:             THIS.this_oBusinessObject.this_lModoAutomatico = THIS.this_lAuto
2433:             THIS.this_oBusinessObject.this_cPromocao       = loc_cPromo
2434:             THIS.this_oBusinessObject.this_lFiltroPromocao = !EMPTY(loc_cPromo)
2435:             THIS.this_oBusinessObject.this_nOrdena         = THIS.this_nOrdena
2436:             THIS.this_oBusinessObject.this_nTotalProdutos  = THIS.this_nTotPro
2437:             THIS.this_oBusinessObject.this_nTotalPaginas   = THIS.this_nTotPag
2438:             THIS.this_oBusinessObject.this_nPaginaAtual    = THIS.this_nNumPag
2439: 
2440:             loc_lSucesso = .T.
2441:         ENDIF
2442: 
2443:         RETURN loc_lSucesso
2444:     ENDPROC
2445: 
2446:     *==========================================================================
2447:     * BOParaForm - traz de volta do BO o estado que FormParaBO empurrou e
2448:     * repinta o unico lugar em que ele aparece para o usuario: o label
2449:     * "Pagina : NNN/NNN" (AtualizarCaptionPagina, transcricao literal do
2450:     * formato do legado). Com isso o numero exibido tem FONTE UNICA - sai
2451:     * sempre do BO, nunca de uma segunda contagem feita na tela.
2452:     *
2453:     * Nao mexe em Primeira/Item/Pag1/Pag2/TelaInic: esses sao estado de
2454:     * NAVEGACAO do cursor (posicao do ponteiro e quantos slots a pagina
2455:     * preencheu), vivem na tela e nao tem par no BO.
2456:     *
2457:     * O caption so eh escrito se o label ja existir: BOParaForm roda a cada
2458:     * paginacao, mas quem o chama primeiro (FinalizarPaginacao) pode ser
2459:     * alcancado por um caminho em que a montagem visual ainda nao terminou.
2460:     *
2461:     * PROTECTED EXPLICITO pela mesma razao de FormParaBO (FormBase declara
2462:     * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da heranca).
2463:     *==========================================================================
2464:     PROTECTED PROCEDURE BOParaForm()
2465:         LOCAL loc_lSucesso
2466:         loc_lSucesso = .F.
2467: 
2468:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2469:             THIS.this_lAuto   = THIS.this_oBusinessObject.this_lModoAutomatico
2470:             THIS.this_nOrdena = THIS.this_oBusinessObject.this_nOrdena
2471:             THIS.this_nTotPro = THIS.this_oBusinessObject.this_nTotalProdutos
2472:             THIS.this_nTotPag = THIS.this_oBusinessObject.this_nTotalPaginas
2473:             THIS.this_nNumPag = THIS.this_oBusinessObject.this_nPaginaAtual
2474: 
2475:             IF TYPE("THIS.lbl_4c_Pagina") = "O"
2476:                 THIS.AtualizarCaptionPagina()
2477:             ENDIF
2478: 
2479:             loc_lSucesso = .T.
2480:         ENDIF
2481: 
2482:         RETURN loc_lSucesso
2483:     ENDPROC
2484: 
2485:     *==========================================================================
2486:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
2487:     * criados por AddObject (que nascem com Visible = .F.). FILTRO de
2488:     * container flutuante: cnt_4c__Pag (Cnt_Pag do legado) NAO recebe
2489:     * Visible = .T. aqui - permanece oculto ate o usuario clicar "Selecionar
2490:     * Pagina" (BOTOES_CONSULTA.Buttons(4), fase seguinte). A recursao para
2491:     * dentro dele AINDA ocorre (regra CLAUDE.md sobre LOOP ter de recursar
2492:     * em containers flutuantes) para que Label1/Text1/Command4 fiquem
2493:     * visiveis assim que o container for exibido.
2494:     *==========================================================================
2495:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2496:         LOCAL loc_nI, loc_oControl, loc_lFlutuante
2497: 
2498:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2499:             loc_oControl = par_oContainer.Controls(loc_nI)
2500: 
2501:             IF VARTYPE(loc_oControl) = "O"
2502:                 loc_lFlutuante = (UPPER(loc_oControl.Name) == "CNT_4C__PAG")
2503: 
2504:                 IF !loc_lFlutuante
2505:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
2506:                         loc_oControl.Visible = .T.
2507:                     ENDIF
2508:                 ENDIF
2509: 
2510:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2511:                     LOCAL loc_nP
2512:                     FOR loc_nP = 1 TO loc_oControl.PageCount
2513:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
2514:                     ENDFOR
2515:                 ENDIF
2516: 
2517:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2518:                     THIS.TornarControlesVisiveis(loc_oControl)
2519:                 ENDIF
2520:             ENDIF
2521:         ENDFOR
2522:     ENDPROC
2523: 
2524:     *==========================================================================
2525:     * Destroy - delega ao FormBase (regra CLAUDE.md: Destroy SEMPRE termina
2526:     * com DODEFAULT(), senao o menu do sistema fica com os popups em cache
2527:     * visual stale). Fecha os cursores locais proprios desta tela -
2528:     * CrImagens (CriarCursorImagens, DataSession = 1/CORRENTE/compartilhada,
2529:     * entao sobrevive ao Form se nao for fechado aqui) e os temporarios que
2530:     * os eventos desta fase podem deixar abertos se o form fechar no meio de
2531:     * um Click. Tmp_Imagens e' do form PAI (CrProdutos/Tmp_Imagens vem dele,
2532:     * ver cabecalho do arquivo) - nao fechado aqui, do mesmo jeito que o
2533:     * legado tambem nao fecha no Release.
2534:     *==========================================================================
2535:     PROCEDURE Destroy()
2536:         IF USED("CrImagens")
2537:             USE IN CrImagens
2538:         ENDIF
2539:         IF USED("cursor_4c_LocalImg")
2540:             USE IN cursor_4c_LocalImg
2541:         ENDIF
2542:         IF USED("cursor_4c_Fornecedor")
2543:             USE IN cursor_4c_Fornecedor
2544:         ENDIF
2545: 
2546:         DODEFAULT()
2547:     ENDPROC
2548: 
2549: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpPecBO.prg):
*==============================================================================
* SIGOPPECBO.PRG
* Business Object para Selecao de Pecas / Imagens de Produtos (SigOpPec)
* Herda de BusinessBase
*
* Legado: SIGOPPEC.SCX - tela que percorre os produtos filtrados pelo form
* pai (cursor CrProdutos, 15 por pagina) e permite ao usuario marcar quais
* produtos entram na selecao de imagens (cursor local CrImagens), para depois
* exportar os JPGs para disco (Exportar Imagens), gerar arquivo (SigOpGar) ou
* imprimir a relacao de pecas (SigRePca). Nao ha INSERT/UPDATE/DELETE em
* tabela do SQL Server nestas acoes - a unica tabela referenciada no Init
* legado via AddCursor eh SigOpGcp/cidchaves.
*==============================================================================

DEFINE CLASS SigOpPecBO AS BusinessBase

    *-- Propriedades espelhando o cursor local CrImagens (Load() do legado) -
    *-- cada produto marcado para selecao de imagem grava um registro com
    *-- este layout (usado depois por Exportar/Imprimir/Gerar Arquivo)
    this_cCpros       = ""
    this_cDpros       = ""
    this_cLinhas      = ""
    this_cColecoes    = ""
    this_nPvens       = 0
    this_cMoevs       = ""
    this_nPesoms      = 0
    this_cMoepvs      = ""
    this_nFvendas     = 0
    this_nPcuss       = 0
    this_cMoecs       = ""
    this_cReffs       = ""
    this_cIfors       = ""
    this_dDatas       = {}
    this_cCgrus       = ""
    this_cCunis       = ""
    this_cFigjpgs     = ""
    this_nFlag        = 0
    this_nTconvs      = 0
    this_cMconvs      = ""
    this_nImppreco    = 0
    this_nCustofs     = 0
    this_cMoecusfs    = ""
    this_nImpcusto    = 0
    this_nImpcompo    = 0
    this_nImpreffor   = 0
    this_nTpconvs     = 0
    this_cMpconvs     = ""
    this_nImpfor      = 0
    this_cDfors       = ""
    this_cCbars       = ""

    *-- Propriedades de controle/paginacao (equivalentes as properties do
    *-- form legado: TotPro, TotPag, TotReg, NumPag, Primeira, Ordena, Pag1,
    *-- Pag2, TelaInic, PlAuto) - a paginacao em si fica no Form (estado de
    *-- UI), mas o BO precisa delas para montar a consulta de cada pagina
    this_nTotalProdutos      = 0
    this_nRegistrosPorPagina = 15
    this_nTotalPaginas       = 0
    this_nPaginaAtual        = 1
    this_nOrdena             = 1
    this_lModoAutomatico     = .F.

    *-- Filtro de promocao (lcPromo/llPromo do legado - Get_Promo do form pai)
    this_cPromocao           = ""
    this_lFiltroPromocao     = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Selecao de Pecas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpGcp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_nTotalProdutos      = 0
            THIS.this_nRegistrosPorPagina = 15
            THIS.this_nTotalPaginas       = 0
            THIS.this_nPaginaAtual        = 1
            THIS.this_nOrdena             = 1
            THIS.this_lModoAutomatico     = .F.
            THIS.this_cPromocao           = ""
            THIS.this_lFiltroPromocao     = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpPecBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * Persistencia desta tela: conforme o cabecalho do arquivo, NAO ha
    * INSERT/UPDATE/DELETE em tabela do SQL Server nas acoes do usuario (a
    * unica tabela citada no Init legado, SigOpGcp/cidchaves, eh so um
    * AddCursor nunca usado no restante do form). Por isso este BO NAO
    * sobrescreve Inserir()/Atualizar()/ExecutarExclusao() - o comportamento
    * padrao herdado de BusinessBase (recusar a operacao com mensagem) ja eh
    * o correto aqui, e RegistrarAuditoria() nao se aplica sem gravacao real.
    * A "gravacao" do usuario eh local: marcar/desmarcar produtos no cursor
    * de selecao (CrImagens no legado) - metodos abaixo espelham isso.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia o registro CORRENTE do cursor informado
    * (layout de CrImagens/Tmp_Imagens - 31 colunas, ver Load() do legado)
    * para as propriedades this_* do BO. PUBLIC (nao PROTECTED como nos BOs
    * CRUD comuns) porque esta tela nao tem CarregarPorCodigo por chave: o
    * Form varre Tmp_Imagens linha a linha (ChkImp/Command1-4) e precisa
    * carregar cada linha direto antes de decidir Adicionar/Remover.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros      = TratarNulo(cpros, "")
            THIS.this_cDpros      = TratarNulo(dpros, "")
            THIS.this_cLinhas     = TratarNulo(linhas, "")
            THIS.this_cColecoes   = TratarNulo(colecoes, "")
            THIS.this_nPvens      = TratarNulo(pvens, 0)
            THIS.this_cMoevs      = TratarNulo(moevs, "")
            THIS.this_nPesoms     = TratarNulo(pesoms, 0)
            THIS.this_cMoepvs     = TratarNulo(moepvs, "")
            THIS.this_nFvendas    = TratarNulo(fvendas, 0)
            THIS.this_nPcuss      = TratarNulo(pcuss, 0)
            THIS.this_cMoecs      = TratarNulo(moecs, "")
            THIS.this_cReffs      = TratarNulo(reffs, "")
            THIS.this_cIfors      = TratarNulo(ifors, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_cCgrus      = TratarNulo(cgrus, "")
            THIS.this_cCunis      = TratarNulo(cunis, "")
            THIS.this_cFigjpgs    = TratarNulo(figjpgs, "")
            THIS.this_nFlag       = TratarNulo(flag, 0)
            THIS.this_nTconvs     = TratarNulo(tconvs, 0)
            THIS.this_cMconvs     = TratarNulo(mconvs, "")
            THIS.this_nImppreco   = TratarNulo(imppreco, 0)
            THIS.this_nCustofs    = TratarNulo(custofs, 0)
            THIS.this_cMoecusfs   = TratarNulo(moecusfs, "")
            THIS.this_nImpcusto   = TratarNulo(impcusto, 0)
            THIS.this_nImpcompo   = TratarNulo(impcompo, 0)
            THIS.this_nImpreffor  = TratarNulo(impreffor, 0)
            THIS.this_nTpconvs    = TratarNulo(tpconvs, 0)
            THIS.this_cMpconvs    = TratarNulo(mpconvs, "")
            THIS.this_nImpfor     = TratarNulo(ImpFor, 0)
            THIS.this_cDfors      = TratarNulo(dFors, "")
            THIS.this_cCbars      = TratarNulo(cBars, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNoCursorSelecao - Equivalente a "Locate for cpros = X / Found()"
    * usado em ChkImp e Command1.Click do legado antes de inserir/remover.
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNoCursorSelecao(par_cAliasDestino, par_cCpros)
        LOCAL loc_lExiste, loc_cAliasAtual
        loc_lExiste = .F.

        IF USED(par_cAliasDestino)
            loc_cAliasAtual = ALIAS()
            SELECT (par_cAliasDestino)
            GO TOP
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(par_cCpros)
            loc_lExiste = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoFornecedor - Select Rclis From SigCdCli Where Iclis = X
    * (mesma consulta do Command1.Click legado, usada para preencher dFors
    * quando o produto marcado ainda nao estava no cursor de selecao)
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoFornecedor(par_cIfors)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF !EMPTY(par_cIfors)
            TRY
                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE RTRIM(Iclis) = " + ;
                           EscaparSQL(ALLTRIM(par_cIfors))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fornecedor")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Fornecedor") > 0
                    loc_cDescricao = TratarNulo(cursor_4c_Fornecedor.Rclis, "")
                ENDIF

                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar fornecedor:" + CHR(13) + loc_oErro.Message, "Erro")
                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarAoCursorSelecao - Insert Into <destino>(...) Values (...) com
    * o layout de CrImagens, usando as propriedades this_* ja carregadas via
    * CarregarDoCursor(). Espelha ChkImp (par_lBuscarFornecedor = .F., sem
    * consultar SigCdCli) e Command1/Command4.Click (par_lBuscarFornecedor
    * = .T., preenche dFors com o Razas do fornecedor). impcusto/impcompo/
    * impreffor/ImpFor SEMPRE gravam 0 no INSERT - no legado esses sinalizam
    * opcoes de impressao marcadas DEPOIS pelo usuario, nunca no momento da
    * selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarAoCursorSelecao(par_cAliasDestino, par_lBuscarFornecedor)
        LOCAL loc_lSucesso, loc_cBarra, loc_cDescFornecedor

        loc_lSucesso = .F.
        loc_cDescFornecedor = ""

        IF USED(par_cAliasDestino)
            TRY
                loc_cBarra = fAltBar2de5(TRANSFORM(THIS.this_cCbars, "@L 99999999"))

                IF par_lBuscarFornecedor
                    loc_cDescFornecedor = THIS.ObterDescricaoFornecedor(THIS.this_cIfors)
                ENDIF

                INSERT INTO (par_cAliasDestino) ;
                    (cpros, dpros, linhas, colecoes, pvens, moevs, pesoms, moepvs, ;
                     fvendas, pcuss, moecs, reffs, ifors, datas, cgrus, cunis, ;
                     figjpgs, flag, tconvs, mconvs, imppreco, custofs, moecusfs, ;
                     impcusto, impcompo, impreffor, tpconvs, mpconvs, ImpFor, dFors, cBars) ;
                VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cLinhas, THIS.this_cColecoes, ;
                     THIS.this_nPvens, THIS.this_cMoevs, THIS.this_nPesoms, THIS.this_cMoepvs, ;
                     THIS.this_nFvendas, THIS.this_nPcuss, THIS.this_cMoecs, THIS.this_cReffs, ;
                     THIS.this_cIfors, THIS.this_dDatas, THIS.this_cCgrus, THIS.this_cCunis, ;
                     THIS.this_cFigjpgs, THIS.this_nFlag, THIS.this_nTconvs, THIS.this_cMconvs, ;
                     THIS.this_nImppreco, THIS.this_nCustofs, THIS.this_cMoecusfs, ;
                     0, 0, 0, THIS.this_nTpconvs, THIS.this_cMpconvs, 0, loc_cDescFornecedor, loc_cBarra)

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro("Erro ao adicionar produto a selecao de imagens:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RemoverDoCursorSelecao - Locate for cpros = X / Delete (ChkImp quando
    * o usuario desmarca, e Command2/Command3.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE RemoverDoCursorSelecao(par_cAliasDestino, par_cCpros)
        LOCAL loc_lSucesso, loc_cAliasAtual
        loc_lSucesso = .F.

        IF USED(par_cAliasDestino)
            loc_cAliasAtual = ALIAS()
            SELECT (par_cAliasDestino)
            GO TOP
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(par_cCpros)
            IF FOUND()
                DELETE
                loc_lSucesso = .T.
            ENDIF
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


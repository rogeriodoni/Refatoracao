# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPTOR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1758 linhas total):

*-- Linhas 39 a 132:
39: *
40: * CHAMADA (equivale ao "Do Form SigOpTor With ThisForm, nDataSession,
41: * pcVisual" do legado):
42: *   loForm = CREATEOBJECT("FormSIGOPTOR", THISFORM, THISFORM.DataSessionId, ;
43: *       loc_cModoVisual)
44: *   IF VARTYPE(loForm) = "O"
45: *       loForm.Show()          && modal: so volta quando o dialogo fecha
46: *   ENDIF
47: *
48: *   Como no legado, o Release eh do PROPRIO dialogo (botao Retornar, fase
49: *   futura), nao do chamador.
50: *
51: * PARAMETROS DO INIT (legado: LParameters pform, datses, pVisual)
52: *   par_oFormPai         - legado: pform / ThisForm.ParentForm (property
53: *                          CUSTOM da classe - RESERVED3/ClassInfo do dump
54: *                          lista "parentform" como custom property, NAO a
55: *                          nativa de container MDI). Form pai de
56: *                          Orcamento/Pre-Custo. NAO desabilitado por este
57: *                          Init (o dump nao tem essa linha - quem desabilita
58: *                          eh o CHAMADOR antes do "Do Form"); este form so
59: *                          REABILITA ao sair (BtnRetornarClick - Fase 4 -
60: *                          e Destroy, rede de seguranca).
61: *   par_nDataSessionPai  - legado: datses. Informativo - DataSession = 1 ja
62: *                          unifica a sessao com o pai; mantido so para
63: *                          auditoria/paridade com o legado.
64: *   par_cModoVisual      - legado: pVisual. "P" = Total Previsao; qualquer
65: *                          outro valor Character (ou ausente) = Itens
66: *                          Subnivel/default. Normalizado em Init, igual ao
67: *                          legado (pVisual = Iif(Type(pVisual)=[L],[P],
68: *                          pVisual)) - NAO maiusculiza o valor recebido, so
69: *                          supre o default quando o tipo nao eh Character.
70: *
71: * METODOS DE DADOS (ja implementados no BO - fases 1-2)
72: *   CarregarModoPrevisao/CarregarModoItensSubnivel/CarregarTotalPorData/
73: *   CarregarTotaisGerais/CarregarTotalGeral/CarregarDoCursor/
74: *   LimparCursoresGrade/ObterChavePrimaria - ver cabecalho de
75: *   SIGOPTORBO.prg para o detalhamento completo (inclusive por que
76: *   Inserir/Atualizar/ExecutarExclusao NAO sao sobrescritos: esta tela eh
77: *   somente leitura).
78: *
79: * FASE 3 (anterior): estrutura base do form
80: *   - Propriedades que espelham o contexto recebido do form pai
81: *     (this_oFormPai/this_nDataSessionPai/this_cModoVisual).
82: *   - Init (LParameters do legado, mesma ordem: pform, datses, pVisual) +
83: *     ValidarParametros (precondicao: sem form pai nao ha quem reabilitar
84: *     ao sair).
85: *   - InicializarForm (cria o BO, aplica o fundo, cria o cabecalho cinza).
86: *   - ConfigurarDecoracao (Picture do form - new_background.jpg).
87: *   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
88: *     metodo mantido por paridade com os demais dialogos filhos desta
89: *     familia - FormSigOpTop/FormSigOpSts/FormSigOpSqn/FormSigOpSlc - mesmo
90: *     sem PageFrame real: este form eh FLAT, igual ao legado - ZERO
91: *     "BaseClass: pageframe" no dump SIGOPTOR_form_codigo_fonte.txt).
92: *   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar,
93: *     rede de seguranca, e libera os 3 cursores do BO - LimparCursoresGrade).
94: *
95: * FASE 4 (esta fase): grades + botao de saida - ramo FLAT (sem PageFrame/
96: * Page1/Page2 - roteiro generico de CRUD nao se aplica, mesmo caso de
97: * FormSigOpTop.prg: o dump confirma classe "form" pura, zero "BaseClass:
98: * pageframe", grades e campos soltos direto no form)
99: *
100: *   - ConfigurarGrade()         grdItem/GrdTotPrev/grdTotal do legado ->
101: *                                grd_4c_ItensPendentes/grd_4c_TotalPorData/
102: *                                grd_4c_TotalGeral (SO o que nao depende de
103: *                                dado - ControlSource/RecordSource ficam em
104: *                                CarregarLista, regra #41)
105: *   - AplicarFormatoGradeItem/TotPrev/Total()  FONTE UNICA de Column.Width/
106: *                                Header1.Caption/ColumnOrder - RecordSource
107: *                                zera esses valores (Problema 48), entao
108: *                                CarregarLista reaplica depois do bind
109: *   - ConfigurarBotoes()         OK.btnSair do legado -> cmg_4c_OK
110: *                                (CommandGroup, ButtonCount=1) + Buttons(1)
111: *                                "Retornar"
112: *   - BtnRetornarClick()         btnSair.Click do legado (reabilita o pai +
113: *                                Release) - entrou junto com o botao: eh o
114: *                                UNICO botao da tela (ControlBox=.F.,
115: *                                TitleBar=0) e deixa-lo inerte tiraria a
116: *                                saida pelo mouse
117: *   - CarregarLista()            funil: despacha para o modo "P" (Total
118: *                                Previsao, duas grades) ou "Itens
119: *                                Subnivel" (grdItem), chamando
120: *                                this_oBusinessObject.CarregarModoPrevisao/
121: *                                CarregarModoItensSubnivel, fazendo o bind
122: *                                + GO TOP + Refresh (regra #21a) e o toggle
123: *                                de Visible por modo - trecho final do
124: *                                Init legado, incluindo o "Return .f." do
125: *                                ramo Itens Subnivel quando a cadeia nao
126: *                                acha nenhum item (reabilita o pai e aborta
127: *                                a instanciacao, igual ao legado)
128: *
129: *   getTotPrev/getTotReal/getTotDif/getDProd/Say2 (Fases 5-6, ainda
130: *   inexistentes) sao tocados em CarregarLista so sob guarda PEMSTATUS -
131: *   nesta fase o toggle de Visible deles e a atribuicao de .Value ficam de
132: *   fora (sem erro, sem no-op disfarcado): as Fases 5-6 estendem o mesmo

*-- Linhas 144 a 208:
144: *                                    txt_4c_DProd, direto em THIS (sem
145: *                                    container - form FLAT)
146: *   - TxtDProdWhen()                 getDProd.When do legado ("Return .f."),
147: *                                    PUBLIC por exigencia do BINDEVENT
148: *
149: *   O toggle de Visible desses dois controles por modo JA estava pronto
150: *   desde a Fase 4 (guardado por PEMSTATUS em CarregarModoPrevisaoNaTela/
151: *   CarregarModoItensSubnivelNaTela, pensando exatamente nesta extensao) -
152: *   nenhuma mudanca no funil de carga foi necessaria.
153: *
154: * FASE 6 (esta fase) - 2a metade dos campos restantes do SCX (getTotPrev/
155: * getTotReal/getTotDif - modo "P"). Este form NAO TEM NENHUM LOOKUP (ver
156: * comportamento.json: zero fwbuscaext/fwBuscaSel/sigacess no dump inteiro
157: * - os 3 campos sao fwget com When = "Return .f." igual a getDProd, PURO
158: * DISPLAY de totalizador monetario, nunca recebem foco) - o roteiro
159: * generico da Fase 6 (campos + lookups) se reduz aqui a SO campos.
160: *
161: *   - ConfigurarCamposTotalizadores()  getTotPrev/getTotReal/getTotDif ->
162: *                                    txt_4c_TotPrev/txt_4c_TotReal/
163: *                                    txt_4c_TotDif, direto em THIS (sem
164: *                                    container - form FLAT), igual ao
165: *                                    padrao de ConfigurarCamposPrincipais
166: *   - TxtTotPrevWhen/TxtTotRealWhen/TxtTotDifWhen  When do legado
167: *                                    ("Return .f." nos 3), PUBLIC por
168: *                                    exigencia do BINDEVENT
169: *
170: *   CarregarModoPrevisaoNaTela (Fase 4) ganhou a atribuicao de .Value dos
171: *   3 totalizadores a partir de this_oBusinessObject.this_nTotalPrevisto/
172: *   this_nTotalRealizado/this_nTotalDiferenca (CarregarTotaisGerais, Fases
173: *   1-2) - legado: "thisform.getTotPrev.Value = Nvl(crTmpTotOrp2.Valos,0)"
174: *   e os 2 seguintes, atribuidos SEMPRE que a consulta (Sum sem Group By)
175: *   teve sucesso, independente do grdTotPrev ter linha (por isso a
176: *   atribuicao fica dentro do IF de sucesso de CarregarModoPrevisao, mas
177: *   FORA dos dois IFs de this_nTotalRegistros* > 0). O toggle de Visible
178: *   por modo desses 3 controles JA estava pronto desde a Fase 4 (mesmo
179: *   padrao do Say2/getDProd na Fase 5).
180: *
181: * FASE 7 (anterior) - SEM TRABALHO: o roteiro generico pede
182: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick, mas
183: * este dialogo NAO tem CRUD nenhum no legado (comportamento.json: 18
184: * metodos/eventos no dump inteiro, nenhum deles Incluir/Alterar/Excluir/
185: * Visualizar de registro; classe "form" pura, zero frmcadastro/Grupo_Op/
186: * pcEscolha). O UNICO botao da tela eh OK.btnSair ("Retornar"), e o
187: * handler correspondente (BtnRetornarClick) ja entrou na Fase 4 junto com
188: * o AddObject do botao - deixar o unico botao inerte ate esta fase tiraria
189: * a saida do dialogo (ControlBox=.F., TitleBar=0, sem ESC/fechar por
190: * chrome de janela). Inventar os 4 metodos CRUD aqui violaria o PILAR 1
191: * (UI/funcionalidade que o legado nao tem) e a regra de completude (seriam
192: * stubs disfarcados, sem Click de botao algum para ligar). Mesmo caso
193: * documentado para SIGMVCTH/SigPrScn (visualizador somente-leitura com 1
194: * botao de saida) e SigPrIct/SigPrItb (toolbar de REPORT, nao CRUD de
195: * registro).
196: *
197: * FASE 8 (esta fase) - CONSOLIDACAO FINAL: SEM TRABALHO NOVO, pela mesma
198: * razao da Fase 7 (dialogo somente-leitura, zero CRUD no legado -
199: * comportamento.json confirma, de novo, nenhum dos 18 metodos/eventos
200: * fazendo Incluir/Alterar/Excluir/Salvar/Cancelar/Buscar/Encerrar de
201: * registro). O roteiro generico desta fase pede:
202: *
203: *   - BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick ->
204: *     NAO EXISTEM no legado (SIGOPTOR_form_codigo_fonte.txt: zero objeto
205: *     chamado Buscar/Encerrar/Salvar/Cancelar; o unico CommandGroup eh OK,
206: *     com o unico botao Buttons(1)="btnSair"/"Retornar", ja ligado a
207: *     BtnRetornarClick desde a Fase 4 - regra do projeto "Saida eh o
208: *     proprio botao de acao" quando a tela tem 1 unico botao e ele fecha o

*-- Linhas 222 a 275:
222: *   - CarregarLista() -> JA EXISTE e esta COMPLETO desde a Fase 4 (funil
223: *     que despacha para CarregarModoPrevisaoNaTela/
224: *     CarregarModoItensSubnivelNaTela conforme this_cModoVisual), chamado
225: *     pelo proprio InicializarForm (Fase 3) fora de modo teste/validacao
226: *     de UI - nao ha "segunda metade" desta fase para completar.
227: *   - AjustarBotoesPorModo() -> NAO SE APLICA: nao ha modo LISTA/INCLUIR/
228: *     ALTERAR/VISUALIZAR/EXCLUIR neste dialogo (this_cModoVisual eh
229: *     "P"/Itens Subnivel, um toggle de EXIBICAO entre duas composicoes de
230: *     grade+campos, nao um modo de edicao de registro) nem botoes CRUD a
231: *     habilitar/desabilitar - o unico botao (Retornar) fica sempre
232: *     habilitado, em qualquer um dos dois modos de exibicao.
233: *
234: * Reescrever qualquer um desses metodos como stub (ex.: BtnSalvarClick
235: * com MsgAviso("sera implementado")) violaria a regra de completude do
236: * projeto (stub disfarcado) e o PILAR 1 (inventar UI/fluxo que o legado
237: * nao tem) ao mesmo tempo - por isso a fase fecha so com esta nota,
238: * exatamente como a Fase 7.
239: *==============================================================================
240: 
241: DEFINE CLASS FormSIGOPTOR AS FormBase
242: 
243:     *--------------------------------------------------------------------------
244:     * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
245:     *--------------------------------------------------------------------------
246: 
247:     this_cMensagemErro = ""
248: 
249:     *-- pform / ThisForm.ParentForm do legado (property CUSTOM da classe,
250:     *-- nao a nativa de container MDI - ver RESERVED3/ClassInfo do dump). O
251:     *-- form de Orcamento/Pre-Custo que abriu este dialogo
252:     this_oFormPai = .NULL.
253: 
254:     *-- datses do legado - informativo (DataSession = 1 ja unifica a sessao
255:     *-- com o pai, ver comentario de DataSession abaixo)
256:     this_nDataSessionPai = 0
257: 
258:     *-- pVisual do legado, ja normalizado em Init ("P" = Total Previsao;
259:     *-- qualquer outro Character = Itens Subnivel). Consultado pelo funil de
260:     *-- carga (Fase 4) para decidir qual metodo do BO chamar
261:     this_cModoVisual = ""
262: 
263:     *--------------------------------------------------------------------------
264:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
265:     *--------------------------------------------------------------------------
266: 
267:     *-- SIGOPTOR: Top=-1 / Left=5 / Height=600 / Width=1000 - literais do
268:     *-- dump. AutoCenter = .F. explicito (FormBase.Init o declara .T. por
269:     *-- padrao - regra do projeto - e o legado posiciona este dialogo nos
270:     *-- coordenadas fixas acima, nao centralizado)
271:     Top        = -1
272:     Left       = 5
273:     Height     = 600
274:     Width      = 1000
275:     AutoCenter = .F.

*-- Linhas 306 a 611:
306:     *==========================================================================
307:     * Init - LParameters pform, datses, pVisual do legado (mesma ordem).
308:     *==========================================================================
309:     PROCEDURE Init
310:         LPARAMETERS par_oFormPai, par_nDataSessionPai, par_cModoVisual
311: 
312:         IF VARTYPE(par_oFormPai) = "O"
313:             THIS.this_oFormPai = par_oFormPai
314:         ENDIF
315: 
316:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
317: 
318:         *-- Legado: pVisual = Iif(Type([pVisual]) = [L],[P],pVisual) - quando
319:         *-- o 3o parametro nao eh informado (chega com o tipo default do
320:         *-- LPARAMETERS omitido, Logico), o modo vira "P". Qualquer valor
321:         *-- Character recebido e mantido como esta, SEM maiusculizar
322:         *-- (o legado tambem nao maiusculiza - a comparacao eh so com [P])
323:         THIS.this_cModoVisual = IIF(VARTYPE(par_cModoVisual) = "C", par_cModoVisual, "P")
324: 
325:         *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
326:         *-- seguida THIS.InicializarForm()
327:         RETURN DODEFAULT()
328:     ENDPROC
329: 
330:     *==========================================================================
331:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
332:     * quem reabilitar ao sair (o legado tambem depende dessa referencia no
333:     * caminho de erro do Init - ThisForm.ParentForm.Enabled = .t.).
334:     *
335:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
336:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
337:     *
338:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
339:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
340:     * bypass a instanciacao reprovaria sempre.
341:     *
342:     * O RETURN fica FORA de TRY/CATCH (regra #1) - este metodo nao abre
343:     * bloco algum.
344:     *==========================================================================
345:     PROCEDURE ValidarParametros
346:         LOCAL loc_lValido
347:         loc_lValido = .T.
348: 
349:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
350:             RETURN .T.
351:         ENDIF
352: 
353:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
354:             RETURN .T.
355:         ENDIF
356: 
357:         IF VARTYPE(THIS.this_oFormPai) != "O"
358:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
359:                     "Or" + CHR(231) + "amento/Pr" + CHR(233) + "-Custo.", "Total")
360:             loc_lValido = .F.
361:         ENDIF
362: 
363:         RETURN loc_lValido
364:     ENDPROC
365: 
366:     *==========================================================================
367:     * InicializarForm - estrutura base do dialogo
368:     *
369:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
370:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
371:     *==========================================================================
372:     PROTECTED PROCEDURE InicializarForm
373:         LOCAL loc_lSucesso, loc_oErro
374:         loc_lSucesso = .F.
375: 
376:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
377:         *-- dentro de TRY/CATCH (regra #1)
378:         IF !THIS.ValidarParametros()
379:             RETURN .F.
380:         ENDIF
381: 
382:         TRY
383:             *-- Business Object das Fases 1-2
384:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPTORBO")
385: 
386:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
387:                 MsgErro("Falha ao criar SIGOPTORBO.", "Total")
388:             ELSE
389:                 *-- Fundo do form (Picture do SCX)
390:                 THIS.ConfigurarDecoracao()
391: 
392:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
393:                 *-- AddObject do form, igual ao SCX
394:                 THIS.ConfigurarPageFrame()
395: 
396:                 *-- grdItem/GrdTotPrev/grdTotal do legado (Fase 4) - SO o
397:                 *-- que nao depende de dado (regra #41)
398:                 THIS.ConfigurarGrade()
399: 
400:                 *-- Say2/getDProd do legado (Fase 5, 1a metade - modo
401:                 *-- "Itens Subnivel")
402:                 THIS.ConfigurarCamposPrincipais()
403: 
404:                 *-- getTotPrev/getTotReal/getTotDif do legado (Fase 6, 2a
405:                 *-- metade - modo "P")
406:                 THIS.ConfigurarCamposTotalizadores()
407: 
408:                 *-- OK.btnSair do legado -> cmg_4c_OK (Fase 4)
409:                 THIS.ConfigurarBotoes()
410: 
411:                 *-- AddObject cria controle com Visible = .F.
412:                 THIS.TornarControlesVisiveis(THIS)
413: 
414:                 *-- Legado: o Init termina montando o cursor do modo
415:                 *-- corrente e ligando as grades a ele. Pulado em modo
416:                 *-- teste/validacao de UI (padrao FormCor/FormSigOpTop):
417:                 *-- la nao ha gnConnHandle nem cursores do form pai
418:                 *-- abertos, entao a carga so produziria ruido de erro no
419:                 *-- log do harness. As grades ficam vazias, ja formatadas
420:                 *-- por AplicarFormatoGrade*. O harness chama CarregarLista
421:                 *-- de fora quando quer exercita-la
422:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
423:                    !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
424:                     THIS.CarregarLista()
425:                 ENDIF
426: 
427:                 loc_lSucesso = .T.
428:             ENDIF
429: 
430:         CATCH TO loc_oErro
431:             THIS.this_cMensagemErro = loc_oErro.Message
432:             MsgErro("Erro ao inicializar FormSIGOPTOR: " + loc_oErro.Message + ;
433:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
434:                     " | Procedure: " + loc_oErro.Procedure, "Erro")
435:             loc_lSucesso = .F.
436:         ENDTRY
437: 
438:         RETURN loc_lSucesso
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
443:     *==========================================================================
444:     PROTECTED PROCEDURE ConfigurarDecoracao
445:         LOCAL loc_cImagemFundo
446:         loc_cImagemFundo = ""
447: 
448:         IF TYPE("gc_4c_CaminhoIcones") = "C"
449:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
450:         ENDIF
451: 
452:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
453:             THIS.Picture = loc_cImagemFundo
454:         ENDIF
455:     ENDPROC
456: 
457:     *==========================================================================
458:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
459:     * metodo mantido por paridade com os demais dialogos filhos desta
460:     * familia (FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/
461:     * FormSigOpSlc.prg usam o mesmo nome), mesmo sem PageFrame real - este
462:     * form eh FLAT, igual ao legado (SIGOPTOR nao tem PageFrame no SCX).
463:     *
464:     * Transcricao do dump (SIGOPTOR_form_codigo_fonte.txt):
465:     *   cntSombra  Top=0  Left=0  Width=1100  Height=80  BorderWidth=0
466:     *              BackColor=100,100,100
467:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
468:     *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
469:     *              Alignment=0, BackStyle=0
470:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
471:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
472:     *
473:     * O Caption dos dois labels acompanha THIS.Caption no momento da
474:     * criacao ("Total", literal desta fase) - o funil de carga (Fase 4)
475:     * atualiza os DOIS Caption (do form e dos labels) junto com o toggle de
476:     * Visible por modo, igual ao legado.
477:     *
478:     * Width do container usa THIS.Width - padrao canonico da faixa, regra
479:     * #11 - em vez do literal 1100: o SCX declara o CONTAINER mais largo
480:     * que o proprio form (1000), artefato do Form Designer ja catalogado
481:     * (cabecalho_label_width_dump_maior_que_form). Os labels usam
482:     * THIS.Width - 20, mesma margem de 10px dos dois lados aplicada pelos
483:     * dialogos irmaos (FormSigOpTop.prg) - o literal 769 do dump cabe
484:     * dentro dos 1000px (nao precisa ser preservado literal).
485:     *
486:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
487:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
488:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
489:     *==========================================================================
490:     PROTECTED PROCEDURE ConfigurarPageFrame
491:         *-- Container da faixa (cntSombra)
492:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
493:         WITH THIS.cnt_4c_Cabecalho
494:             .Top           = 0
495:             .Left          = 0
496:             .Width         = THIS.Width
497:             .Height        = 80
498:             .BorderWidth   = 0
499:             .BackStyle     = 1
500:             .BackColor     = RGB(100, 100, 100)
501:             .SpecialEffect = 0
502:             .Visible       = .T.
503:         ENDWITH
504: 
505:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
506:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
507:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
508:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
509:             .AutoSize      = .F.
510:             .FontBold      = .T.
511:             .FontName      = "Tahoma"
512:             .FontSize      = 18
513:             .FontUnderline = .F.
514:             .WordWrap      = .T.
515:             .Alignment     = 0
516:             .BackStyle     = 0
517:             .Caption       = THIS.Caption
518:             .Top           = 18
519:             .Left          = 10
520:             .Width         = THIS.Width - 20
521:             .Height        = 40
522:             .ForeColor     = RGB(0, 0, 0)
523:             .Rotation      = 0
524:             .Visible       = .T.
525:         ENDWITH
526: 
527:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
528:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
529:         *-- regra #12)
530:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
531:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
532:             .AutoSize    = .F.
533:             .FontBold    = .T.
534:             .FontName    = "Tahoma"
535:             .FontSize    = 18
536:             .WordWrap    = .T.
537:             .Alignment   = 0
538:             .BackStyle   = 0
539:             .Caption     = THIS.Caption
540:             .Top         = 17
541:             .Left        = 10
542:             .Width       = THIS.Width - 20
543:             .Height      = 46
544:             .ForeColor   = RGB(255, 255, 255)
545:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
546:             .Rotation    = 0
547:             .Visible     = .T.
548:         ENDWITH
549: 
550:         THIS.cnt_4c_Cabecalho.Visible = .T.
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * ConfigurarGrade - grdItem/GrdTotPrev/grdTotal do legado
555:     *
556:     * ORDEM (identica a do SCX - SECAO 1 do dump): grdItem, GrdTotPrev,
557:     * grdTotal. Nenhuma das tres tem controle transparente sobrepondo
558:     * outra (diferente do Shape1 de FormSigOpTop.prg), entao a ordem entre
559:     * elas nao eh critica - preservada so por fidelidade ao dump.
560:     *
561:     * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
562:     * ControlSource/RecordSource moram em CarregarLista, porque atribuir
563:     * ControlSource de alias que ainda nao existe derruba o Init.
564:     *
565:     * RecordMark = .F. em todas (grade de form OPERACIONAL criada por
566:     * AddObject - regra do projeto, sem isso a barra de marcacao aparece
567:     * na lateral e come largura util). grdItem.RecordMark nao consta do
568:     * dump (herda o default); GrdTotPrev/grdTotal declaram DeleteMark=.F.
569:     * explicito - RecordMark = .F. acompanha por fidelidade ao padrao.
570:     *==========================================================================
571:     PROTECTED PROCEDURE ConfigurarGrade
572:         *-- grdItem -> grd_4c_ItensPendentes (TmpItePen no legado) - Modo
573:         *-- "Itens Subnivel". ReadOnly = .F. no GRID (literal do dump) -
574:         *-- cada Column.ReadOnly = .T. sobrescreve depois, em
575:         *-- AplicarFormatoGradeItem (regra #18: Column.ReadOnly DEPOIS do
576:         *-- Grid.ReadOnly)
577:         THIS.AddObject("grd_4c_ItensPendentes", "Grid")
578:         WITH THIS.grd_4c_ItensPendentes
579:             .ColumnCount   = 9
580:             .FontName      = "Tahoma"
581:             .FontSize      = 8
582:             .HeaderHeight  = 22
583:             .Top           = 192
584:             .Left          = 1
585:             .Width         = 997
586:             .Height        = 365
587:             .RowHeight     = 16
588:             .ReadOnly      = .F.
589:             .RecordMark    = .F.
590:             .DeleteMark    = .F.
591:             .TabIndex      = 2
592:             .Visible       = .T.
593:         ENDWITH
594: 
595:         *-- GrdTotPrev -> grd_4c_TotalPorData (crTmpTotOrp no legado) -
596:         *-- Modo "P", 1a grade (Data/Previsto/Realizado/Diferenca)
597:         THIS.AddObject("grd_4c_TotalPorData", "Grid")
598:         WITH THIS.grd_4c_TotalPorData
599:             .ColumnCount   = 4
600:             .FontName      = "Tahoma"
601:             .FontSize      = 8
602:             .Top           = 193
603:             .Left          = 259
604:             .Width         = 479
605:             .Height        = 364
606:             .RowHeight     = 16
607:             .ScrollBars    = 2
608:             .DeleteMark    = .F.
609:             .RecordMark    = .F.
610:             .ReadOnly      = .T.
611:             .TabIndex      = 4

*-- Linhas 684 a 727:
684:     * Metodo PUBLIC: chamado pela montagem (ConfigurarGrade) E pela recarga
685:     * (CarregarLista).
686:     *==========================================================================
687:     PROCEDURE AplicarFormatoGradeItem
688:         LOCAL loc_lAplicou
689:         loc_lAplicou = .F.
690: 
691:         IF PEMSTATUS(THIS, "grd_4c_ItensPendentes", 5)
692:             WITH THIS.grd_4c_ItensPendentes
693:                 *-- pos1 - DopeNums / "Movimentacao"
694:                 .Column1.Width             = 180
695:                 .Column1.ColumnOrder       = 1
696:                 .Column1.Movable           = .F.
697:                 .Column1.Resizable         = .F.
698:                 .Column1.FontName          = "Tahoma"
699:                 .Column1.FontSize          = 8
700:                 .Column1.ReadOnly          = .T.
701:                 .Column1.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
702:                 .Column1.Header1.FontName  = "Tahoma"
703:                 .Column1.Header1.FontSize  = 8
704:                 .Column1.Header1.Alignment = 2
705:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
706:                 .Column1.Text1.BorderStyle = 0
707:                 .Column1.Text1.Margin      = 0
708:                 .Column1.Text1.ReadOnly    = .T.
709:                 .Column1.Text1.FontName    = "Tahoma"
710:                 .Column1.Text1.FontSize    = 8
711:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
712:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
713: 
714:                 *-- pos2 - Qtds / "Quantidade" (InputMask: caso base, ver
715:                 *-- comentario do metodo)
716:                 .Column2.Width             = 80
717:                 .Column2.ColumnOrder       = 3
718:                 .Column2.Movable           = .F.
719:                 .Column2.Resizable         = .F.
720:                 .Column2.FontName          = "Tahoma"
721:                 .Column2.FontSize          = 8
722:                 .Column2.ReadOnly          = .T.
723:                 .Column2.InputMask         = "999999"
724:                 .Column2.Header1.Caption   = "Quantidade"
725:                 .Column2.Header1.FontName  = "Tahoma"
726:                 .Column2.Header1.FontSize  = 8
727:                 .Column2.Header1.Alignment = 2

*-- Linhas 899 a 942:
899:     *            E "999999"/MaxLength=6/ReadOnly=.T. no Text1 (dois niveis
900:     *            distintos no dump - transcritos os dois, regra #17)
901:     *==========================================================================
902:     PROCEDURE AplicarFormatoGradeTotPrev
903:         LOCAL loc_lAplicou
904:         loc_lAplicou = .F.
905: 
906:         IF PEMSTATUS(THIS, "grd_4c_TotalPorData", 5)
907:             WITH THIS.grd_4c_TotalPorData
908:                 .Column1.Width             = 80
909:                 .Column1.Movable           = .F.
910:                 .Column1.Resizable         = .F.
911:                 .Column1.FontName          = "Tahoma"
912:                 .Column1.FontSize          = 8
913:                 .Column1.ReadOnly          = .T.
914:                 .Column1.Header1.Caption   = "Data"
915:                 .Column1.Header1.FontName  = "Tahoma"
916:                 .Column1.Header1.FontSize  = 8
917:                 .Column1.Header1.Alignment = 2
918:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
919:                 .Column1.Text1.BorderStyle = 0
920:                 .Column1.Text1.Margin      = 0
921:                 .Column1.Text1.FontName    = "Tahoma"
922:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
923: 
924:                 .Column2.Width             = 122
925:                 .Column2.Movable           = .F.
926:                 .Column2.Resizable         = .F.
927:                 .Column2.FontName          = "Tahoma"
928:                 .Column2.FontSize          = 8
929:                 .Column2.ReadOnly          = .T.
930:                 .Column2.InputMask         = "99,999,999.99"
931:                 .Column2.Header1.Caption   = "Previsto"
932:                 .Column2.Header1.FontName  = "Tahoma"
933:                 .Column2.Header1.FontSize  = 8
934:                 .Column2.Header1.Alignment = 2
935:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
936:                 .Column2.Text1.BorderStyle = 0
937:                 .Column2.Text1.Margin      = 0
938:                 .Column2.Text1.FontName    = "Tahoma"
939:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
940: 
941:                 .Column3.Width             = 122
942:                 .Column3.FontName          = "Tahoma"

*-- Linhas 988 a 1031:
988:     *   Column1  Width=200 "Item"      (ControlSource: crTmpTotal.Dpros)
989:     *   Column2  Width=122 "Total NFs" InputMask="99,999,999.99" (Tota1s)
990:     *==========================================================================
991:     PROCEDURE AplicarFormatoGradeTotal
992:         LOCAL loc_lAplicou
993:         loc_lAplicou = .F.
994: 
995:         IF PEMSTATUS(THIS, "grd_4c_TotalGeral", 5)
996:             WITH THIS.grd_4c_TotalGeral
997:                 .Column1.Width             = 200
998:                 .Column1.Movable           = .F.
999:                 .Column1.Resizable         = .F.
1000:                 .Column1.FontName          = "Tahoma"
1001:                 .Column1.FontSize          = 8
1002:                 .Column1.ReadOnly          = .T.
1003:                 .Column1.Header1.Caption   = "Item"
1004:                 .Column1.Header1.FontName  = "Tahoma"
1005:                 .Column1.Header1.FontSize  = 8
1006:                 .Column1.Header1.Alignment = 2
1007:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
1008:                 .Column1.Text1.BorderStyle = 0
1009:                 .Column1.Text1.Margin      = 0
1010:                 .Column1.Text1.FontName    = "Tahoma"
1011:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1012: 
1013:                 .Column2.Width             = 122
1014:                 .Column2.Movable           = .F.
1015:                 .Column2.Resizable         = .F.
1016:                 .Column2.FontName          = "Tahoma"
1017:                 .Column2.FontSize          = 8
1018:                 .Column2.ReadOnly          = .T.
1019:                 .Column2.InputMask         = "99,999,999.99"
1020:                 .Column2.Header1.Caption   = "Total NFs"
1021:                 .Column2.Header1.FontName  = "Tahoma"
1022:                 .Column2.Header1.FontSize  = 8
1023:                 .Column2.Header1.Alignment = 2
1024:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
1025:                 .Column2.Text1.BorderStyle = 0
1026:                 .Column2.Text1.Margin      = 0
1027:                 .Column2.Text1.FontName    = "Tahoma"
1028:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
1029:             ENDWITH
1030: 
1031:             loc_lAplicou = .T.

*-- Linhas 1055 a 1313:
1055:     * DataSession (DataSession=1, Fase 3). Guardado por USED(): em modo
1056:     * teste/validacao de UI o cursor do pai nao existe, e sem a guarda a
1057:     * atribuicao de ControlSource estouraria "Alias nao encontrado" dentro
1058:     * do TRY de InicializarForm.
1059:     *
1060:     * When = .F. (dump: "PROCEDURE When / Return .f.") - o campo nunca
1061:     * recebe foco via Tab/clique, so exibe. O LostFocus do dump ("If
1062:     * ThisForm.fwGrade.Visible / ThisForm.fwGrade.SetFocus / EndIf")
1063:     * referencia um objeto "fwGrade" que NAO existe neste SCX (nenhum grid
1064:     * do form se chama assim) - boilerplate de classe-base nunca
1065:     * customizado para esta instancia; como When=.F. ja bloqueia o foco,
1066:     * esse LostFocus eh inalcancavel por construcao e NAO foi reproduzido
1067:     * (regra #13 - nunca referenciar objeto que nao existe).
1068:     *==========================================================================
1069:     PROTECTED PROCEDURE ConfigurarCamposPrincipais
1070:         *-- Say2 -> lbl_4c_Label2 ("Descricao")
1071:         THIS.AddObject("lbl_4c_Label2", "Label")
1072:         WITH THIS.lbl_4c_Label2
1073:             .AutoSize  = .F.
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:             .Alignment = 0
1077:             .BackStyle = 0
1078:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1079:             .Top       = 122
1080:             .Left      = 19
1081:             .Width     = 70
1082:             .Height    = 15
1083:             .ForeColor = RGB(90, 90, 90)
1084:             .Visible   = .T.
1085:         ENDWITH
1086: 
1087:         *-- getDProd -> txt_4c_DProd (descricao do produto, espelhando o
1088:         *-- cursor do form pai)
1089:         THIS.AddObject("txt_4c_DProd", "TextBox")
1090:         WITH THIS.txt_4c_DProd
1091:             .FontName          = "Tahoma"
1092:             .FontSize          = 8
1093:             .Format            = "K!"
1094:             .Top               = 135
1095:             .Left              = 19
1096:             .Width             = 288
1097:             .Height            = 23
1098:             .SpecialEffect     = 1
1099:             .ForeColor         = RGB(0, 0, 0)
1100:             .BackColor         = RGB(255, 255, 255)
1101:             .DisabledBackColor = RGB(255, 255, 255)
1102:             .DisabledForeColor = RGB(192, 192, 192)
1103:             .BorderColor       = RGB(100, 100, 100)
1104:             .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1105:             .Value             = ""
1106: 
1107:             IF USED("crSigMvOrc")
1108:                 .ControlSource = "crSigMvOrc.DPros"
1109:             ENDIF
1110: 
1111:             .Visible = .T.
1112:         ENDWITH
1113: 
1114:         *-- getDProd.When do legado - metodo PUBLIC (regra #3: BINDEVENT
1115:         *-- exige metodo PUBLIC, PROTECTED falha em silencio)
1116:         BINDEVENT(THIS.txt_4c_DProd, "When", THIS, "TxtDProdWhen")
1117:     ENDPROC
1118: 
1119:     *==========================================================================
1120:     * TxtDProdWhen - getDProd.When do legado ("PROCEDURE When / Return
1121:     * .f."): o campo nunca recebe foco, eh so exibicao.
1122:     *==========================================================================
1123:     PROCEDURE TxtDProdWhen
1124:         RETURN .F.
1125:     ENDPROC
1126: 
1127:     *==========================================================================
1128:     * ConfigurarCamposTotalizadores - FASE 6 (2a metade dos campos):
1129:     * getTotPrev/getTotReal/getTotDif do legado -> txt_4c_TotPrev/
1130:     * txt_4c_TotReal/txt_4c_TotDif. Sao os totalizadores do modo "P" (Total
1131:     * Previsao - legado: ramo "If pVisual = [P]" do Init, ver cabecalho de
1132:     * CarregarModoPrevisaoNaTela), que exibem Sum(Valos)/Sum(VlBaixas)/
1133:     * Sum(Valos-VlBaixas) de crSigMvOrp SEM Group By (uma unica linha,
1134:     * diferente da grade grd_4c_TotalPorData, que agrupa por Datas).
1135:     *
1136:     * Direto em THIS (sem container), igual aos demais controles deste
1137:     * form FLAT (grades, txt_4c_DProd, cmg_4c_OK).
1138:     *
1139:     * Transcricao do dump (os 3 controles tem as MESMAS propriedades, so
1140:     * variando Left=315/438/561): Format="K!" Height=23 Width=122
1141:     * SpecialEffect=1 Top=568 ForeColor=0,0,0 DisabledBackColor=255,255,255
1142:     * DisabledForeColor=0,0,255 BorderColor=100,100,100.
1143:     *
1144:     * ZOrderSet=5/plprocurar=.T. do dump NAO sao transcritos: ZOrderSet eh
1145:     * bookkeeping do Form Designer, sem efeito em runtime (regra #33,
1146:     * mesma familia do ZOrderSet ja descartado nos dialogos irmaos desta
1147:     * familia); plprocurar eh flag do fwget legado que habilitaria um
1148:     * botao de lookup, mas este form NAO TEM NENHUM LOOKUP (comportamento.
1149:     * json: zero fwbuscaext/fwBuscaSel/sigacess) - os 3 campos tem
1150:     * When=.F. (nunca recebem foco) e sao alimentados so por .Value
1151:     * atribuido em CarregarModoPrevisaoNaTela, nunca digitados.
1152:     *
1153:     * FontName/FontSize NAO constam no dump destes 3 controles (ao
1154:     * contrario de getDProd, que os declara explicitamente) - usa-se
1155:     * Tahoma 8, o default do form (unico par presente na tabela de fontes
1156:     * do dump e usado em TODOS os demais controles deste SCX).
1157:     *
1158:     * .Value inicializado como 0 (NUMERICO - os 3 campos exibem soma
1159:     * monetaria via Nvl(...,0) no legado, nunca texto), e SEM
1160:     * ControlSource (o legado tambem nao liga por ControlSource: atribui
1161:     * .Value direto no Init a partir de crTmpTotOrp2).
1162:     *
1163:     * When = .F. nos 3 (dump: "PROCEDURE When / Return .f." repetido em
1164:     * getTotPrev/getTotReal/getTotDif) - mesmo padrao de getDProd (Fase 5).
1165:     *==========================================================================
1166:     PROTECTED PROCEDURE ConfigurarCamposTotalizadores
1167:         *-- getTotPrev -> txt_4c_TotPrev
1168:         THIS.AddObject("txt_4c_TotPrev", "TextBox")
1169:         WITH THIS.txt_4c_TotPrev
1170:             .FontName          = "Tahoma"
1171:             .FontSize          = 8
1172:             .Format            = "K!"
1173:             .Top               = 568
1174:             .Left              = 315
1175:             .Width             = 122
1176:             .Height            = 23
1177:             .SpecialEffect     = 1
1178:             .ForeColor         = RGB(0, 0, 0)
1179:             .DisabledBackColor = RGB(255, 255, 255)
1180:             .DisabledForeColor = RGB(0, 0, 255)
1181:             .BorderColor       = RGB(100, 100, 100)
1182:             .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
1183:             .Value             = 0
1184:             .Visible           = .T.
1185:         ENDWITH
1186:         BINDEVENT(THIS.txt_4c_TotPrev, "When", THIS, "TxtTotPrevWhen")
1187: 
1188:         *-- getTotReal -> txt_4c_TotReal
1189:         THIS.AddObject("txt_4c_TotReal", "TextBox")
1190:         WITH THIS.txt_4c_TotReal
1191:             .FontName          = "Tahoma"
1192:             .FontSize          = 8
1193:             .Format            = "K!"
1194:             .Top               = 568
1195:             .Left              = 438
1196:             .Width             = 122
1197:             .Height            = 23
1198:             .SpecialEffect     = 1
1199:             .ForeColor         = RGB(0, 0, 0)
1200:             .DisabledBackColor = RGB(255, 255, 255)
1201:             .DisabledForeColor = RGB(0, 0, 255)
1202:             .BorderColor       = RGB(100, 100, 100)
1203:             .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
1204:             .Value             = 0
1205:             .Visible           = .T.
1206:         ENDWITH
1207:         BINDEVENT(THIS.txt_4c_TotReal, "When", THIS, "TxtTotRealWhen")
1208: 
1209:         *-- getTotDif -> txt_4c_TotDif
1210:         THIS.AddObject("txt_4c_TotDif", "TextBox")
1211:         WITH THIS.txt_4c_TotDif
1212:             .FontName          = "Tahoma"
1213:             .FontSize          = 8
1214:             .Format            = "K!"
1215:             .Top               = 568
1216:             .Left              = 561
1217:             .Width             = 122
1218:             .Height            = 23
1219:             .SpecialEffect     = 1
1220:             .ForeColor         = RGB(0, 0, 0)
1221:             .DisabledBackColor = RGB(255, 255, 255)
1222:             .DisabledForeColor = RGB(0, 0, 255)
1223:             .BorderColor       = RGB(100, 100, 100)
1224:             .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
1225:             .Value             = 0
1226:             .Visible           = .T.
1227:         ENDWITH
1228:         BINDEVENT(THIS.txt_4c_TotDif, "When", THIS, "TxtTotDifWhen")
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * TxtTotPrevWhen/TxtTotRealWhen/TxtTotDifWhen - getTotPrev.When/
1233:     * getTotReal.When/getTotDif.When do legado ("PROCEDURE When / Return
1234:     * .f."): os 3 campos nunca recebem foco, sao so exibicao.
1235:     *==========================================================================
1236:     PROCEDURE TxtTotPrevWhen
1237:         RETURN .F.
1238:     ENDPROC
1239: 
1240:     PROCEDURE TxtTotRealWhen
1241:         RETURN .F.
1242:     ENDPROC
1243: 
1244:     PROCEDURE TxtTotDifWhen
1245:         RETURN .F.
1246:     ENDPROC
1247: 
1248:     *==========================================================================
1249:     * ConfigurarBotoes - OK.btnSair do legado -> cmg_4c_OK (CommandGroup,
1250:     * ButtonCount=1) + Buttons(1) "Retornar"
1251:     *
1252:     * Transcricao do dump: OK AutoSize=.T. BackStyle=0 BorderStyle=0
1253:     * SpecialEffect=1 BorderColor=136,189,188 Themes=.F. Top=-2 Left=920
1254:     * Width=85 Height=85; Command1 (nome legado "btnSair") Top=5 Left=5
1255:     * Width=75 Height=75 Caption="Retornar" Cancel=.T.
1256:     * Picture=cadastro_salvar_60.jpg (regra #25 - transcrever o Picture do
1257:     * legado LITERAL, mesmo parecendo semanticamente estranho para um
1258:     * botao de saida - "Retornar" usa o icone de salvar no SCX original).
1259:     *
1260:     * Buttons(1) configurado em WITH ANINHADO dentro do WITH do grupo - UM
1261:     * nivel de nesting em CommandGroup eh seguro (ao contrario de Container/
1262:     * Label, onde AddObject+WITH aninhado falha em silencio).
1263:     *
1264:     * Themes = .F. no Buttons(1): canonico para botao DENTRO de
1265:     * CommandGroup (diferente do standalone, que precisa Themes=.T. +
1266:     * DisabledPicture para o icone aparecer - regra do projeto).
1267:     *
1268:     * O Click vai no BOTAO (Buttons(1)), nao no Click do GRUPO: o dump
1269:     * mostra "PROCEDURE btnSair.Click" (evento do MEMBRO, nao do
1270:     * CommandGroup) - comportamento.json confirma em "SIGOPTOR.OK"
1271:     * evento "Click" com o codigo do btnSair.
1272:     *==========================================================================
1273:     PROTECTED PROCEDURE ConfigurarBotoes
1274:         LOCAL loc_cIconeRetornar
1275:         loc_cIconeRetornar = ""
1276: 
1277:         IF TYPE("gc_4c_CaminhoIcones") = "C"
1278:             loc_cIconeRetornar = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1279:         ENDIF
1280: 
1281:         THIS.AddObject("cmg_4c_OK", "CommandGroup")
1282:         WITH THIS.cmg_4c_OK
1283:             .ButtonCount   = 1
1284:             .AutoSize      = .T.
1285:             .BackStyle     = 0
1286:             .BorderStyle   = 0
1287:             .SpecialEffect = 1
1288:             .BorderColor   = RGB(136, 189, 188)
1289:             .Themes        = .F.
1290:             .Top           = -2
1291:             .Left          = 920
1292:             .Width         = 85
1293:             .Height        = 85
1294:             .TabIndex      = 1
1295: 
1296:             WITH .Buttons(1)
1297:                 .Top          = 5
1298:                 .Left         = 5
1299:                 .Height       = 75
1300:                 .Width        = 75
1301:                 .FontBold     = .T.
1302:                 .FontItalic   = .T.
1303:                 .FontName     = "Comic Sans MS"
1304:                 .FontSize     = 8
1305:                 .WordWrap     = .T.
1306:                 .Cancel       = .T.
1307:                 .Caption      = "Retornar"
1308:                 .MousePointer = 15
1309:                 .SpecialEffect = 0
1310:                 .ForeColor    = RGB(90, 90, 90)
1311:                 .BackColor    = RGB(255, 255, 255)
1312:                 .Themes       = .F.
1313:                 .ToolTipText  = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"

*-- Linhas 1320 a 1459:
1320:             .Visible = .T.
1321:         ENDWITH
1322: 
1323:         *-- btnSair.Click do legado. BINDEVENT ligado aqui, junto com o
1324:         *-- AddObject, em vez de deixar o unico botao da tela inerte ate a
1325:         *-- fase de eventos: sem TitleBar/ControlBox esta tela nao teria
1326:         *-- saida pelo mouse nesse intervalo
1327:         BINDEVENT(THIS.cmg_4c_OK.Buttons(1), "Click", THIS, "BtnRetornarClick")
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * BtnRetornarClick - btnSair.Click do legado, transcrito:
1332:     *
1333:     *     ThisForm.ParentForm.Enabled = .t.
1334:     *     ThisForm.Release()
1335:     *
1336:     * Metodo PUBLIC (regra #3): BINDEVENT falha em SILENCIO com PROTECTED.
1337:     *
1338:     * O Destroy deste form repete o Enabled = .T. como rede de seguranca
1339:     * (ESC/Alt+F4/erro nao passam por aqui); reabilitar duas vezes eh
1340:     * inofensivo, e o Destroy ainda zera this_oFormPai.
1341:     *
1342:     * THIS.Release() direto reproduz o "ThisForm.Release" do legado: este
1343:     * dialogo eh so consulta e nao devolve resultado nenhum ao chamador.
1344:     *==========================================================================
1345:     PROCEDURE BtnRetornarClick
1346:         IF VARTYPE(THIS.this_oFormPai) = "O"
1347:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1348:                 THIS.this_oFormPai.Enabled = .T.
1349:             ENDIF
1350:         ENDIF
1351: 
1352:         THIS.Release()
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * CarregarLista - funil de carga. Reproduz o trecho final do Init
1357:     * legado: despacha para o modo "P" (Total Previsao) ou o modo "Itens
1358:     * Subnivel", conforme this_cModoVisual (normalizado no Init - Fase 3).
1359:     *
1360:     * Os cursores do form pai (crSigMvOrp/crSigMvOrc) sao lidos pelo NOME
1361:     * LITERAL do legado: como este dialogo roda na MESMA DataSession do
1362:     * pai (DataSession = 1 - ver comentario da property, Fase 3), esses
1363:     * aliases - quando o form pai de Orcamento/Pre-Custo estiver migrado e
1364:     * os tiver aberto - ja estao diretamente visiveis aqui, sem precisar
1365:     * de parametro extra no Init (equivalente ao "Set Datasession To
1366:     * DatSes" do legado). Guardas USED() cobrem o caso de nao estarem
1367:     * abertos (modo teste/validacao de UI, ou form pai ainda nao migrado -
1368:     * FormOPE, task483, ainda em Fase A): a grade fica vazia, so formatada.
1369:     *
1370:     * Metodo PUBLIC (regra #3): o harness de teste o alcanca de fora, sem
1371:     * argumento algum - a operacao a consultar vem de
1372:     * THIS.this_oBusinessObject.this_nCodigoAtual/this_cProdutoAtual (modo
1373:     * item) ou dos cursores do pai (modo previsao), nao de parametro.
1374:     *
1375:     * RETURN unico, FORA do TRY/CATCH (regra #1).
1376:     *==========================================================================
1377:     PROCEDURE CarregarLista
1378:         LOCAL loc_lCarregou, loc_oErro
1379:         loc_lCarregou = .F.
1380: 
1381:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1382:             RETURN .F.
1383:         ENDIF
1384: 
1385:         IF !PEMSTATUS(THIS, "grd_4c_TotalPorData", 5) OR ;
1386:            !PEMSTATUS(THIS, "grd_4c_TotalGeral", 5) OR ;
1387:            !PEMSTATUS(THIS, "grd_4c_ItensPendentes", 5)
1388:             RETURN .F.
1389:         ENDIF
1390: 
1391:         TRY
1392:             IF THIS.this_cModoVisual == "P"
1393:                 loc_lCarregou = THIS.CarregarModoPrevisaoNaTela()
1394:             ELSE
1395:                 loc_lCarregou = THIS.CarregarModoItensSubnivelNaTela()
1396:             ENDIF
1397: 
1398:         CATCH TO loc_oErro
1399:             THIS.this_cMensagemErro = loc_oErro.Message
1400:             MsgErro("Erro ao carregar os dados do dialogo: " + loc_oErro.Message + ;
1401:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1402:                     " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
1403:             loc_lCarregou = .F.
1404:         ENDTRY
1405: 
1406:         RETURN loc_lCarregou
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * CarregarModoPrevisaoNaTela - Modo "P" (legado: ramo "If pVisual = [P]"
1411:     * do Init). Chama SIGOPTORBO.CarregarModoPrevisao (Fases 1-2) com os
1412:     * cursores do form pai (crSigMvOrp/crSigMvOrc), faz o bind das duas
1413:     * grades e o toggle de Visible por modo.
1414:     *
1415:     * PUBLIC (regra #3 - o harness tambem pode querer exercitar so este
1416:     * ramo). Chamado so por CarregarLista, mas protected esbarraria na
1417:     * mesma regra do metodo chamador.
1418:     *==========================================================================
1419:     PROCEDURE CarregarModoPrevisaoNaTela
1420:         LOCAL loc_lCarregou, loc_cAliasOrp, loc_cAliasOrc
1421:         loc_lCarregou = .T.
1422:         loc_cAliasOrp = "crSigMvOrp"
1423:         loc_cAliasOrc = "crSigMvOrc"
1424: 
1425:         THIS.Caption = "Total Previs" + CHR(227) + "o"
1426:         THIS.AtualizarCaptionCabecalho()
1427: 
1428:         *-- Legado: Thisform.grdTotPrev.RecordSource = [] (reset) antes de
1429:         *-- montar o cursor - aqui o reset so importa se havia bind de uma
1430:         *-- carga anterior (troca de modo em tempo de execucao nao ocorre
1431:         *-- neste dialogo, mas o IF USED cobre o caso de reentrada)
1432:         IF USED(loc_cAliasOrp) AND USED(loc_cAliasOrc)
1433:             IF THIS.this_oBusinessObject.CarregarModoPrevisao(loc_cAliasOrp, loc_cAliasOrc)
1434:                 *-- Legado: "If !Eof('crTmpTotOrp') / With ... EndWith" - so
1435:                 *-- liga a grade quando ha pelo menos 1 linha
1436:                 IF THIS.this_oBusinessObject.this_nTotalRegistrosTotPrev > 0
1437:                     THIS.VincularGradeTotPrev()
1438:                 ENDIF
1439: 
1440:                 *-- Legado: "If !Eof('crTmpTotal') / With ... EndWith"
1441:                 IF THIS.this_oBusinessObject.this_nTotalRegistrosTotal > 0
1442:                     THIS.VincularGradeTotal()
1443:                 ENDIF
1444: 
1445:                 *-- Legado: "thisform.getTotPrev.Value = Nvl(crTmpTotOrp2.
1446:                 *-- Valos,0)" e os 2 seguintes - atribuidos SEMPRE que a
1447:                 *-- consulta (Sum sem Group By, CarregarTotaisGerais nas
1448:                 *-- Fases 1-2) teve sucesso, FORA dos dois IFs acima (o
1449:                 *-- legado nao condiciona isso a nenhuma das grades terem
1450:                 *-- linha)
1451:                 IF PEMSTATUS(THIS, "txt_4c_TotPrev", 5)
1452:                     THIS.txt_4c_TotPrev.Value = THIS.this_oBusinessObject.this_nTotalPrevisto
1453:                 ENDIF
1454:                 IF PEMSTATUS(THIS, "txt_4c_TotReal", 5)
1455:                     THIS.txt_4c_TotReal.Value = THIS.this_oBusinessObject.this_nTotalRealizado
1456:                 ENDIF
1457:                 IF PEMSTATUS(THIS, "txt_4c_TotDif", 5)
1458:                     THIS.txt_4c_TotDif.Value = THIS.this_oBusinessObject.this_nTotalDiferenca
1459:                 ENDIF

*-- Linhas 1499 a 1605:
1499:     * regra GRIDWITHFP: acessar .Column dentro do mesmo WITH que atribui
1500:     * RecordSource estoura "Unknown member COLUMNN").
1501:     *==========================================================================
1502:     PROTECTED PROCEDURE VincularGradeTotPrev
1503:         LOCAL loc_cAlias
1504:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorTotalPorData
1505: 
1506:         THIS.grd_4c_TotalPorData.ColumnCount  = 4
1507:         THIS.grd_4c_TotalPorData.RecordSource = loc_cAlias
1508: 
1509:         WITH THIS.grd_4c_TotalPorData
1510:             .Column1.ControlSource = loc_cAlias + ".Datas"
1511:             .Column2.ControlSource = loc_cAlias + ".Valos"
1512:             .Column3.ControlSource = loc_cAlias + ".VlBaixas"
1513:             .Column4.ControlSource = loc_cAlias + ".VlPends"
1514:         ENDWITH
1515: 
1516:         *-- Reaplica largura/cabecalho, que o RecordSource zerou
1517:         THIS.AplicarFormatoGradeTotPrev()
1518: 
1519:         *-- Legado: Select crTmpTotOrp / Go Top (a grade ja refresca sozinha
1520:         *-- ao religar RecordSource, mas o GO TOP + Refresh explicito segue
1521:         *-- a regra #21a do projeto)
1522:         SELECT (loc_cAlias)
1523:         GO TOP
1524:         THIS.grd_4c_TotalPorData.Refresh()
1525:     ENDPROC
1526: 
1527:     *==========================================================================
1528:     * VincularGradeTotal - bind de grd_4c_TotalGeral ao cursor que o BO
1529:     * acabou de montar. Mesma ressalva do GRIDWITHFP acima.
1530:     *==========================================================================
1531:     PROTECTED PROCEDURE VincularGradeTotal
1532:         LOCAL loc_cAlias
1533:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorTotalGeral
1534: 
1535:         THIS.grd_4c_TotalGeral.ColumnCount  = 2
1536:         THIS.grd_4c_TotalGeral.RecordSource = loc_cAlias
1537: 
1538:         WITH THIS.grd_4c_TotalGeral
1539:             .Column1.ControlSource = loc_cAlias + ".Dpros"
1540:             .Column2.ControlSource = loc_cAlias + ".Tota1s"
1541:         ENDWITH
1542: 
1543:         THIS.AplicarFormatoGradeTotal()
1544: 
1545:         SELECT (loc_cAlias)
1546:         GO TOP
1547:         THIS.grd_4c_TotalGeral.Refresh()
1548:     ENDPROC
1549: 
1550:     *==========================================================================
1551:     * CarregarModoItensSubnivelNaTela - Modo "Itens Subnivel" (legado: ramo
1552:     * ELSE do Init, comentario "Tiago - 14/04/2014 - SRCOM"). Le o contexto
1553:     * (nCodigos/Cpros/Emps) de crSigMvOrc - cursor do form pai, ja na
1554:     * DataSession compartilhada - chama SIGOPTORBO.CarregarModoItensSubnivel
1555:     * (Fases 1-2) e faz o bind de grdItem.
1556:     *
1557:     * Legado: "If Eof([TmpItePen]) / ThisForm.ParentForm.Enabled = .t. /
1558:     * Return .f. / Endif" - quando a cadeia de subniveis nao acha NENHUM
1559:     * item, o Init aborta (devolve .F., e CREATEOBJECT no chamador nunca
1560:     * chega a existir). Reproduzido aqui: RETURN .F. propaga para
1561:     * CarregarLista -> InicializarForm -> FormBase.Init -> CREATEOBJECT.
1562:     *
1563:     * PUBLIC pela mesma razao de CarregarModoPrevisaoNaTela.
1564:     *==========================================================================
1565:     PROCEDURE CarregarModoItensSubnivelNaTela
1566:         LOCAL loc_lCarregou, loc_nCodigo, loc_cCpros, loc_cEmps
1567:         loc_lCarregou = .F.
1568: 
1569:         THIS.Caption = "Itens Subn" + CHR(237) + "vel"
1570:         THIS.AtualizarCaptionCabecalho()
1571: 
1572:         IF !USED("crSigMvOrc") OR EOF("crSigMvOrc")
1573:             *-- Sem o contexto do form pai (modo teste/validacao de UI, ou
1574:             *-- FormOPE - task483 - ainda nao migrado) nao ha o que buscar.
1575:             *-- Nao eh o "Return .f." do legado (aquele pressupoe contexto
1576:             *-- valido e cadeia vazia) - aqui simplesmente nao ha contexto
1577:             THIS.grd_4c_ItensPendentes.Visible = .T.
1578:             THIS.grd_4c_TotalPorData.Visible   = .F.
1579:             THIS.grd_4c_TotalGeral.Visible     = .F.
1580:             RETURN .T.
1581:         ENDIF
1582: 
1583:         loc_nCodigo = TratarNulo(crSigMvOrc.nCodigos, 0)
1584:         loc_cCpros  = TratarNulo(crSigMvOrc.Cpros, "")
1585: 
1586:         *-- par_cEmps substitui TprMvCab.Emps do legado (cursor fora do
1587:         *-- escopo deste acervo isolado - ver cabecalho de SIGOPTORBO):
1588:         *-- usa Emps do proprio crSigMvOrc quando existir, senao a empresa
1589:         *-- corrente do sistema (fallback documentado no BO)
1590:         IF TYPE("crSigMvOrc.Emps") = "C"
1591:             loc_cEmps = TratarNulo(crSigMvOrc.Emps, "")
1592:         ELSE
1593:             loc_cEmps = go_4c_Sistema.cCodEmpresa
1594:         ENDIF
1595: 
1596:         IF THIS.this_oBusinessObject.CarregarModoItensSubnivel(loc_nCodigo, loc_cCpros, loc_cEmps)
1597: 
1598:             IF THIS.this_oBusinessObject.this_nTotalRegistrosItens > 0
1599:                 THIS.VincularGradeItem()
1600: 
1601:                 THIS.grd_4c_ItensPendentes.Visible = .T.
1602:                 THIS.grd_4c_TotalPorData.Visible   = .F.
1603:                 THIS.grd_4c_TotalGeral.Visible     = .F.
1604: 
1605:                 IF PEMSTATUS(THIS, "txt_4c_DProd", 5)

*-- Linhas 1652 a 1758:
1652:     * acabou de montar. Mesma ressalva do GRIDWITHFP (ColumnCount/
1653:     * RecordSource FORA do WITH que acessa .Column).
1654:     *==========================================================================
1655:     PROTECTED PROCEDURE VincularGradeItem
1656:         LOCAL loc_cAlias
1657:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorItensPendentes
1658: 
1659:         THIS.grd_4c_ItensPendentes.ColumnCount  = 9
1660:         THIS.grd_4c_ItensPendentes.RecordSource = loc_cAlias
1661: 
1662:         WITH THIS.grd_4c_ItensPendentes
1663:             .Column1.ControlSource = loc_cAlias + ".DopeNums"
1664:             .Column2.ControlSource = loc_cAlias + ".Qtds"
1665:             .Column3.ControlSource = loc_cAlias + ".Pesos"
1666:             .Column4.ControlSource = loc_cAlias + ".Units"
1667:             .Column5.ControlSource = loc_cAlias + ".Datas"
1668:             .Column6.ControlSource = loc_cAlias + ".Fators"
1669:             .Column7.ControlSource = loc_cAlias + ".Dcunis"
1670:             .Column8.ControlSource = loc_cAlias + ".Dcunips"
1671:             .Column9.ControlSource = loc_cAlias + ".Totas"
1672:         ENDWITH
1673: 
1674:         THIS.AplicarFormatoGradeItem()
1675: 
1676:         SELECT (loc_cAlias)
1677:         GO TOP
1678:         THIS.grd_4c_ItensPendentes.Refresh()
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * AtualizarCaptionCabecalho - propaga THIS.Caption (ja atualizado por
1683:     * CarregarModoPrevisaoNaTela/CarregarModoItensSubnivelNaTela) para os
1684:     * dois labels do cabecalho (legado: os dois Caption de cntSombra
1685:     * seguem ThisForm.Caption, que o Init tambem reatribui dentro de cada
1686:     * ramo do IF).
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE AtualizarCaptionCabecalho
1689:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1690:             IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
1691:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
1692:             ENDIF
1693:             IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
1694:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
1695:             ENDIF
1696:         ENDIF
1697:     ENDPROC
1698: 
1699:     *==========================================================================
1700:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
1701:     * por padrao; percorre recursivamente o container repondo Visible = .T.
1702:     * Este form nao tem container flutuante (Visible = .F. proposital) a
1703:     * filtrar nesta fase - os toggles por modo (grdItem/Say2/getDProd x
1704:     * grdTotPrev/grdTotal/totalizadores) sao aplicados pelo funil de carga
1705:     * (Fase 4), DEPOIS desta chamada.
1706:     *==========================================================================
1707:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1708:         LOCAL loc_nI, loc_oControl
1709: 
1710:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1711:             loc_oControl = par_oContainer.Controls(loc_nI)
1712:             IF VARTYPE(loc_oControl) = "O"
1713:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1714:                     loc_oControl.Visible = .T.
1715:                 ENDIF
1716:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1717:                    loc_oControl.ControlCount > 0
1718:                     THIS.TornarControlesVisiveis(loc_oControl)
1719:                 ENDIF
1720:             ENDIF
1721:         ENDFOR
1722:     ENDPROC
1723: 
1724:     *==========================================================================
1725:     * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
1726:     * so o caminho de ERRO do Init faz .ParentForm.Enabled = .t. antes do
1727:     * Return .f.; o BtnRetornarClick - Fase 4 - repete no caminho normal
1728:     * - ThisForm.ParentForm.Enabled = .t. + ThisForm.Release). Aqui fica
1729:     * como rede de seguranca para qualquer caminho de fechamento que nao
1730:     * passe pelo botao (ESC/Alt+F4/erro).
1731:     *
1732:     * Fecha tambem os 3 cursores das grades (LimparCursoresGrade do BO -
1733:     * legado: PROCEDURE Release fazia Use In crTmpTotOrp/crTmpTotOrp2/
1734:     * TmpItePen antes do Dodefault()). Como o form roda na DataSession do
1735:     * pai (DataSession = 1), deixar os aliases abertos poluiria a sessao
1736:     * compartilhada.
1737:     *==========================================================================
1738:     PROCEDURE Destroy
1739:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1740:             THIS.this_oBusinessObject.LimparCursoresGrade()
1741:         ENDIF
1742: 
1743:         IF VARTYPE(THIS.this_oFormPai) = "O"
1744:             *-- PEMSTATUS: em modo teste o "form pai" pode ser um objeto
1745:             *-- simples, sem a property Enabled. Sem a guarda, o teardown
1746:             *-- estoura "Property ENABLED is not found" depois de o
1747:             *-- dialogo ja ter fechado
1748:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1749:                 THIS.this_oFormPai.Enabled = .T.
1750:             ENDIF
1751: 
1752:             THIS.this_oFormPai = .NULL.
1753:         ENDIF
1754: 
1755:         DODEFAULT()
1756:     ENDPROC
1757: 
1758: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPTORBO.prg):
*==============================================================================
* SIGOPTORBO.PRG
* Business Object para o dialogo "Total" (SIGOPTOR) - dialogo filho MODAL
* aberto pelo form pai de Orcamento/Pre-Custo via
* "Do Form SigOpTor With ThisForm, nDataSession, pcVisual", NAO acessivel
* direto pelo menu.
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGOPTOR.Init):
*   O Init recebe (pform, datses, pVisual): pform e o form PAI, datses e a
*   DataSession do pai (o dialogo faz "Set Datasession To DatSes" para
*   conseguir ler os cursores do pai - crSigMvOrp/crSigMvOrc/crSigOpCdd/
*   crSigCdOpe - ANTES de qualquer coisa; NAO abre DataSession propria,
*   apesar de DataSession = 2 declarado no SCX).
*
*   pVisual = "P"  -> modo "Total Previsao":
*     - Select Datas, Sum(Valos) as Valos, Sum(VlBaixas) as VlBaixas,
*       Sum(Valos - VlBaixas) as VlPends From crSigMvOrp Group By Datas
*       (SQL LOCAL do VFP sobre cursor ja carregado pelo pai - NAO usa
*       gnConnHandle) alimenta a grade grdTotPrev (Data/Previsto/
*       Realizado/Diferenca).
*     - Select Sum(Valos), Sum(VlBaixas), Sum(Valos - VlBaixas) From
*       crSigMvOrp (sem Group By) alimenta os totalizadores
*       getTotPrev/getTotReal/getTotDif.
*     - Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) From crSigMvOrc
*       Where cBlocos In ('SUBTOTAIS','TAXA','TOTAL','IMPOSTO',
*       'TOTALGERAL') Group By Citens, Dpros alimenta a grade grdTotal
*       (Item/Total NFs).
*
*   pVisual <> "P" -> modo "Itens Subnivel" (Tiago - 14/04/2014 - SRCOM):
*     busca todos os subniveis que o item (crSigMvOrc.nCodigos) passou,
*     subindo a cadeia via SigCdOpe.Dopes + Str(Nume,6) = EmpDopNums e
*     consultando (via poDataMgr do form AVO, nao gnConnHandle direto):
*       Select b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds,
*         c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas,
*         c.totas, d.Dunis as Dcunis, e.Dunis as Dcunips
*       From SigMvItn a
*       Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums
*       Inner Join SigMvOrc c On a.EmpDopNums = c.EmpDopNums
*                             And a.Citens = c.Citens
*       Inner Join SigCdUni d On a.Cunis = d.Cunis
*       Inner Join SigCdUni e On a.Cunips = e.Cunis
*       Where a.EmpDopNums = '<Emps+Dopes+Str(Nume,6)>'
*         And a.Cpros = '<crSigMvOrc.Cpros>'
*     repetido em loop (Do While llAchou) at? o proximo nCodigos nao
*     encontrar mais SigCdOpe correspondente - cada linha alimenta a
*     grade grdItem (Movimentacao/Quantidade/Periodo/Unitario/Data/
*     Turno/Unidade/Unidade/Total).
*
*   O dialogo e SOMENTE LEITURA em AMBOS os modos (todas as colunas das
*   tres grades tem ReadOnly = .T. no SCX, sem nenhum botao de gravacao) -
*   o unico botao e OK.btnSair (Caption "Retornar"), que reabilita o form
*   pai e libera o dialogo:
*     ThisForm.ParentForm.Enabled = .T.
*     ThisForm.Release()
*
*   Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase
*   (recusar a operacao e reportar pelo ExibirFalha do Salvar) ja eh o
*   correto, e inventar INSERT/UPDATE aqui violaria a regra #22 do
*   CLAUDE.md (a lista de colunas vem do schema, nunca de adivinhacao).
*
* Tabela de contexto : SigMvOrc (orcamento/pre-custo) - usada para montar
*                       o filtro do modo Itens Subnivel (crSigMvOrc.Cpros/
*                       nCodigos/DPros, vindos do form pai) e consultada
*                       via JOIN com SigMvItn/SigMvCab/SigCdUni/SigCdOpe.
* Chave Real (contexto): Citens  CHAR - identifica a linha de orcamento
*                       corrente no form pai (SigMvOrc.Citens).
*==============================================================================

DEFINE CLASS SIGOPTORBO AS BusinessBase

    *--------------------------------------------------------------------------
    * MODO DE EXIBICAO - espelha o parametro pVisual recebido pelo Form
    * "P" = Total Previsao | qualquer outro valor = Itens Subnivel
    *--------------------------------------------------------------------------
    this_cModoExibicao          = ""  && pVisual - "P" ou vazio/outro
    this_cTituloDialogo          = ""  && Caption montado conforme o modo

    *--------------------------------------------------------------------------
    * CONTEXTO - SigMvOrc (crSigMvOrc no legado, cursor do form pai)
    * Linha corrente de orcamento que originou a abertura do dialogo.
    *--------------------------------------------------------------------------
    this_nCodigoAtual            = 0   && nCodigos  N      - ponto de partida do loop Itens Subnivel
    this_cProdutoAtual           = ""  && Cpros     CHAR(14) - filtro a.Cpros nas consultas do modo item
    this_cDescricaoProduto       = ""  && DPros     CHAR(40) - getDProd.Value (contexto, so leitura)

    *--------------------------------------------------------------------------
    * MODO "P" - TOTAIS GERAIS (crTmpTotOrp2 no legado, linha unica)
    * Alimentam getTotPrev/getTotReal/getTotDif.
    *--------------------------------------------------------------------------
    this_nTotalPrevisto          = 0   && Sum(Valos) de crSigMvOrp         - getTotPrev.Value
    this_nTotalRealizado         = 0   && Sum(VlBaixas) de crSigMvOrp      - getTotReal.Value
    this_nTotalDiferenca         = 0   && Sum(Valos - VlBaixas)            - getTotDif.Value

    *--------------------------------------------------------------------------
    * CURSORES DE GRADE (nascem vazios no InicializarForm; populados pelos
    * metodos Carregar* nas fases seguintes)
    *--------------------------------------------------------------------------
    this_cCursorTotalPorData     = "cursor_4c_TotalPorData"     && grdTotPrev <- crTmpTotOrp  (Datas, Valos, VlBaixas, VlPends)
    this_cCursorTotalGeral       = "cursor_4c_TotalGeral"       && grdTotal   <- crTmpTotal    (Dpros, Tota1s)
    this_cCursorItensPendentes   = "cursor_4c_ItensPendentes"   && grdItem    <- TmpItePen     (DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, Units, Moedas, Totas, Datas, Dcunis, Dcunips)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotPrev (cursor_4c_TotalPorData)
    *--------------------------------------------------------------------------
    this_dDatasTotal             = {}  && Datas     D        - data do agrupamento
    this_nValos                  = 0   && Valos     N(15,2)  - total previsto do dia
    this_nVlBaixas                = 0   && VlBaixas  N(15,2)  - total realizado (baixado) do dia
    this_nVlPends                = 0   && VlPends   N(15,2)  - diferenca (Valos - VlBaixas)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotal (cursor_4c_TotalGeral)
    *--------------------------------------------------------------------------
    this_cDprosTotal              = ""  && Dpros     CHAR(40) - descricao do item de total (subtotais/taxa/imposto/total geral)
    this_nTota1s                  = 0   && Tota1s    N(15,2)  - Sum(tota1s + tota2s + tota3s) do item

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdItem (cursor_4c_ItensPendentes / TmpItePen)
    *--------------------------------------------------------------------------
    this_cDopeNums                = ""  && DopeNums  CHAR(26) - Dopes + Str(Nume,6), identifica a movimentacao
    this_cCPros                   = ""  && CPros     CHAR(14) - codigo do produto da linha
    this_cDpros                   = ""  && Dpros     CHAR(40) - descricao do produto da linha
    this_nQtds                    = 0   && Qtds      N(12,3)  - quantidade movimentada
    this_cCunis                   = ""  && Cunis     CHAR(3)  - unidade da quantidade
    this_nPesos                   = 0   && Pesos     N(12,3)  - peso movimentado
    this_cCuniPs                  = ""  && CuniPs    CHAR(3)  - unidade do peso
    this_nFators                  = 0   && Fators    N(12,3)  - fator de conversao
    this_nUnits                   = 0   && Units     N(12,3)  - valor unitario
    this_cMoedas                  = ""  && Moedas    CHAR(3)  - moeda do valor
    this_nTotas                   = 0   && Totas     N(15,2)  - valor total da linha
    this_dDatas                   = {}  && Datas     D        - data da movimentacao
    this_cDcunis                  = ""  && Dcunis    CHAR(20) - descricao da unidade da quantidade (SigCdUni.Dunis)
    this_cDcunips                 = ""  && Dcunips   CHAR(20) - descricao da unidade do peso (SigCdUni.Dunis)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_nTotalRegistrosTotPrev   = 0   && RECCOUNT de cursor_4c_TotalPorData apos a carga
    this_nTotalRegistrosTotal     = 0   && RECCOUNT de cursor_4c_TotalGeral apos a carga
    this_nTotalRegistrosItens     = 0   && RECCOUNT de cursor_4c_ItensPendentes apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este
    * dialogo nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de contexto/consulta
    * (SigMvOrc), usada para montar as duas grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvOrc"
        THIS.this_cCampoChave = "Citens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalPorData - Modo "P" (Total Previsao), 1a grade (grdTotPrev).
    * Replica "Select Datas, Sum(Valos) ..., Group By Datas" do Init legado,
    * agregando LOCALMENTE (sem gnConnHandle) sobre o cursor de movimentacao
    * (equivalente a crSigMvOrp) que o Form ja recebe populado do form pai.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalPorData(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalPorData)
                USE IN (THIS.this_cCursorTotalPorData)
            ENDIF

            SELECT Datas, SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                GROUP BY Datas ;
                INTO CURSOR (THIS.this_cCursorTotalPorData) READWRITE

            SELECT (THIS.this_cCursorTotalPorData)
            GO TOP

            THIS.this_nTotalRegistrosTotPrev = RECCOUNT(THIS.this_cCursorTotalPorData)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total por data: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotaisGerais - Modo "P", totalizadores getTotPrev/getTotReal/
    * getTotDif. Replica "Select Sum(Valos), Sum(VlBaixas), Sum(Valos-VlBaixas)
    * From crSigMvOrp" (sem Group By - uma unica linha) do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotaisGerais(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TmpTotOrp2")
                USE IN cursor_4c_TmpTotOrp2
            ENDIF

            SELECT SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                INTO CURSOR cursor_4c_TmpTotOrp2 READWRITE

            THIS.this_nTotalPrevisto  = TratarNulo(cursor_4c_TmpTotOrp2.Valos, 0)
            THIS.this_nTotalRealizado = TratarNulo(cursor_4c_TmpTotOrp2.VlBaixas, 0)
            THIS.this_nTotalDiferenca = TratarNulo(cursor_4c_TmpTotOrp2.VlPends, 0)

            USE IN cursor_4c_TmpTotOrp2

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os totais gerais: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalGeral - Modo "P", 2a grade (grdTotal). Replica
    * "Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) ... Where cBlocos
    * In (...) Group By Citens, Dpros" do Init legado, sobre o cursor de
    * orcamento (equivalente a crSigMvOrc).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalGeral(par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrc)
            THIS.this_cMensagemErro = "Cursor de or" + CHR(231) + "amento n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrc
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalGeral)
                USE IN (THIS.this_cCursorTotalGeral)
            ENDIF

            SELECT Citens, Dpros, SUM(tota1s + tota2s + tota3s) AS Tota1s ;
                FROM (par_cCursorOrigemOrc) ;
                WHERE INLIST(cBlocos, "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
                GROUP BY Citens, Dpros ;
                INTO CURSOR (THIS.this_cCursorTotalGeral) READWRITE

            SELECT (THIS.this_cCursorTotalGeral)
            GO TOP

            THIS.this_nTotalRegistrosTotal = RECCOUNT(THIS.this_cCursorTotalGeral)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total geral: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoPrevisao - Orquestra o modo "P" (Total Previsao) completo:
    * as duas grades (grdTotPrev/grdTotal) e os 3 totalizadores.
    * par_cCursorOrigemOrp / par_cCursorOrigemOrc sao os aliases (ja abertos
    * pelo Form, recebidos do form pai) equivalentes a crSigMvOrp/crSigMvOrc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoPrevisao(par_cCursorOrigemOrp, par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "P"
        THIS.this_cTituloDialogo = "Total Previs" + CHR(227) + "o"

        IF THIS.CarregarTotalPorData(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotaisGerais(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotalGeral(par_cCursorOrigemOrc)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoItensSubnivel - Modo "Itens Subnivel" (grdItem). Replica o
    * loop "Do While llAchou" do Init legado (Tiago - 14/04/2014 - SRCOM):
    * sobe a cadeia de subniveis que o item (par_nCodigoInicial) passou,
    * resolvendo Dopes via SigCdOpe.Ndopes e consultando SigMvItn/SigMvCab/
    * SigMvOrc/SigCdUni, ate o proximo nCodigos nao encontrar mais nenhum
    * item (ou falha de conexao).
    *
    * Aqui, diferente do modo "P" (que agrega cursores LOCAIS ja carregados),
    * cada passo da cadeia e uma consulta REMOTA via gnConnHandle - o legado
    * tambem faz assim (ThisForm.Parentform.ParentForm.poDataMgr.SqlExecute).
    *
    * par_cEmps substitui o "TprMvCab.Emps" do legado: o dump original le a
    * empresa de um cursor global (TprMvCab) aberto por um ancestral do form
    * pai que nao faz parte deste acervo isolado (SIGOPTOR e um dialogo
    * filho de um form de Orcamento/Pre-Custo nao migrado nesta tarefa). O
    * Form (Fase 3) deve repassar aqui a empresa do registro de origem (ex.:
    * o Emps do cursor de orcamento do form pai, ou
    * go_4c_Sistema.cCodEmpresa como fallback).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoItensSubnivel(par_nCodigoInicial, par_cCpros, par_cEmps)
        LOCAL loc_lSucesso, loc_lErroFatal, loc_nCodigo, loc_lAchou, ;
              loc_nDope, loc_nNume, loc_cDope, loc_cEDN, loc_cSQL, loc_nResultado

        loc_lSucesso   = .F.
        loc_lErroFatal = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "I"
        THIS.this_cTituloDialogo = "Itens Subn" + CHR(237) + "vel"
        THIS.this_nCodigoAtual   = par_nCodigoInicial
        THIS.this_cProdutoAtual  = par_cCpros

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorItensPendentes)
                USE IN (THIS.this_cCursorItensPendentes)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorItensPendentes) ( ;
                DopeNums C(26), CPros C(14), Dpros C(65), Qtds N(9,3), Cunis C(3), ;
                Pesos N(9,3), CuniPs C(3), Fators N(8,3), Units N(15,6), Moedas C(3), ;
                Totas N(11,2), Datas D, Dcunis C(20), Dcunips C(20))
            SET NULL OFF
            INDEX ON Datas TAG Datas

            loc_nCodigo = par_nCodigoInicial
            loc_lAchou  = .T.

            DO WHILE loc_lAchou
                loc_nDope = VAL(LEFT(STR(loc_nCodigo, 10), 4))
                loc_nNume = VAL(RIGHT(STR(loc_nCodigo, 10), 6))

                IF USED("cursor_4c_OpeSubnTmp")
                    USE IN cursor_4c_OpeSubnTmp
                ENDIF
                loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigCdOpe)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_OpeSubnTmp") OR EOF("cursor_4c_OpeSubnTmp")
                    * Nao ha mais SigCdOpe correspondente - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                loc_cDope = cursor_4c_OpeSubnTmp.Dopes
                USE IN cursor_4c_OpeSubnTmp

                *-- SEM ALLTRIM nas partes: chave posicional de 29 caracteres
                *-- (Emps(3) + Dopes(20) + Str(Numes,6) = EmpDopNums - regra #42)
                loc_cEDN = PADR(NVL(par_cEmps, ""), 3) + loc_cDope + STR(loc_nNume, 6)

                IF USED("cursor_4c_MvPecSubnTmp")
                    USE IN cursor_4c_MvPecSubnTmp
                ENDIF

                loc_cSQL = "SELECT b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds, " + ;
                    "c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas, c.totas, " + ;
                    "d.Dunis AS Dcunis, e.Dunis AS Dcunips " + ;
                    "FROM SigMvItn a " + ;
                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                    "INNER JOIN SigMvOrc c ON a.EmpDopNums = c.EmpDopNums AND a.Citens = c.Citens " + ;
                    "INNER JOIN SigCdUni d ON a.Cunis = d.Cunis " + ;
                    "INNER JOIN SigCdUni e ON a.Cunips = e.Cunis " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEDN) + " " + ;
                    "AND a.Cpros = " + EscaparSQL(par_cCpros) + " " + ;
                    "ORDER BY c.Citens"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPecSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (Itens do Subn" + CHR(237) + "vel)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_MvPecSubnTmp") OR EOF("cursor_4c_MvPecSubnTmp")
                    * Nao ha mais item upstream - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                INSERT INTO (THIS.this_cCursorItensPendentes) ( ;
                        DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, ;
                        Units, Moedas, Totas, Datas, Dcunis, Dcunips) ;
                    VALUES ( ;
                        loc_cDope + STR(loc_nNume, 6), ;
                        cursor_4c_MvPecSubnTmp.cpros, ;
                        cursor_4c_MvPecSubnTmp.dpros, ;
                        cursor_4c_MvPecSubnTmp.qtds, ;
                        cursor_4c_MvPecSubnTmp.cunis, ;
                        cursor_4c_MvPecSubnTmp.pesos, ;
                        cursor_4c_MvPecSubnTmp.cunips, ;
                        cursor_4c_MvPecSubnTmp.fators, ;
                        cursor_4c_MvPecSubnTmp.units, ;
                        cursor_4c_MvPecSubnTmp.moedas, ;
                        cursor_4c_MvPecSubnTmp.totas, ;
                        cursor_4c_MvPecSubnTmp.datas, ;
                        cursor_4c_MvPecSubnTmp.dcunis, ;
                        cursor_4c_MvPecSubnTmp.dcunips)

                loc_nCodigo = cursor_4c_MvPecSubnTmp.nCodigos

                USE IN cursor_4c_MvPecSubnTmp
            ENDDO

            SELECT (THIS.this_cCursorItensPendentes)
            GO TOP

            THIS.this_nTotalRegistrosItens = RECCOUNT(THIS.this_cCursorItensPendentes)
            loc_lSucesso = !loc_lErroFatal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os itens do subn" + CHR(237) + "vel: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a LINHA CORRENTE de qualquer uma das 3 grades
    * (identificada pelo alias recebido) para as properties "linha corrente"
    * declaradas na Fase 1. Dialogo e somente leitura (ver cabecalho do
    * arquivo) - usado so para inspecionar/auditar a linha ativa, nunca para
    * gravar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        DO CASE
        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorItensPendentes)
            THIS.this_cDopeNums = TratarNulo(DopeNums, "")
            THIS.this_cCPros    = TratarNulo(CPros, "")
            THIS.this_cDpros    = TratarNulo(Dpros, "")
            THIS.this_nQtds     = TratarNulo(Qtds, 0)
            THIS.this_cCunis    = TratarNulo(Cunis, "")
            THIS.this_nPesos    = TratarNulo(Pesos, 0)
            THIS.this_cCuniPs   = TratarNulo(CuniPs, "")
            THIS.this_nFators   = TratarNulo(Fators, 0)
            THIS.this_nUnits    = TratarNulo(Units, 0)
            THIS.this_cMoedas   = TratarNulo(Moedas, "")
            THIS.this_nTotas    = TratarNulo(Totas, 0)
            THIS.this_dDatas    = Datas
            THIS.this_cDcunis   = TratarNulo(Dcunis, "")
            THIS.this_cDcunips  = TratarNulo(Dcunips, "")

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalPorData)
            THIS.this_dDatasTotal = Datas
            THIS.this_nValos      = TratarNulo(Valos, 0)
            THIS.this_nVlBaixas   = TratarNulo(VlBaixas, 0)
            THIS.this_nVlPends    = TratarNulo(VlPends, 0)

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalGeral)
            THIS.this_cDprosTotal = TratarNulo(Dpros, "")
            THIS.this_nTota1s     = TratarNulo(Tota1s, 0)

        ENDCASE

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresGrade - Fecha os 3 cursores das grades. Replica o
    * PROCEDURE Release do SIGOPTOR legado (Use In crTmpTotOrp/crTmpTotOrp2/
    * TmpItePen) - o Form (Fase 3) chama isto no proprio Release/Destroy.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresGrade()
        IF USED(THIS.this_cCursorTotalPorData)
            USE IN (THIS.this_cCursorTotalPorData)
        ENDIF
        IF USED(THIS.this_cCursorTotalGeral)
            USE IN (THIS.this_cCursorTotalGeral)
        ENDIF
        IF USED(THIS.this_cCursorItensPendentes)
            USE IN (THIS.this_cCursorItensPendentes)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de CONTEXTO (nao de persistencia: este
    * dialogo e somente leitura, ver cabecalho do arquivo - Salvar/Excluir/
    * RegistrarAuditoria nunca sao chamados aqui). A sobrescrita existe so
    * para documentar qual seria a chave do item em exibicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigoAtual)
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCot.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2139 linhas total):

*-- Linhas 26 a 205:
26: *       retorna quando este dialogo fecha, e so entao o pai le o resultado.
27: *
28: * CHAMADA (equivale ao Do Form SigOpCot With ThisForm, ldDatas do legado):
29: *   loForm = CREATEOBJECT("FormSigOpCot", THISFORM, THISFORM.this_dDataDoc)
30: *   IF VARTYPE(loForm) = "O"
31: *       loForm.Show()                      && modal: so volta quando fecha
32: *       llConfirmou = loForm.this_lConfirmado
33: *   ENDIF
34: *
35: *   O Release eh do CHAMADOR porque os dois botoes de saida fecham com
36: *   Hide() e nao com Release(): o pai precisa ler this_lConfirmado DEPOIS do
37: *   Show para saber se usa o que ficou no cursor de cotacao (saiu por
38: *   Salvar) ou se o cursor foi devolvido ao estado inicial (saiu por
39: *   Cancelar). Release dentro do proprio form destruiria o objeto e a
40: *   leitura do chamador estouraria "is not an object" - ver o comentario de
41: *   FecharDialogo. Quem abre e nao libera deixa o objeto vazando.
42: *
43: * PARAMETROS (legado: LParameters ParentForm, pdDatas)
44: *   par_oFormPai - form pai que abriu o dialogo. O legado le dele o
45: *                  pcEscolha (INSERIR / ALTERAR / PROCURAR) e usa o
46: *                  poDataMgr para as consultas. Aqui a referencia fica em
47: *                  this_oFormPai e o acesso ao banco passa pelo BO.
48: *                  ATENCAO: este dialogo NAO libera o pai - diferente dos
49: *                  forms despachante, o SCX legado nunca chama
50: *                  ParentForm.Release.
51: *   par_dDatas   - data base da cotacao. Sem data valida o legado assume
52: *                  Date() (Init: If Type([pdDatas]) = [D] ... Else Date()).
53: *
54: * FASE 3: estrutura base do form - DEFINE CLASS com as
55: * propriedades visuais transcritas do SCX, as propriedades de estado
56: * (espelhos de ThisForm.ParentForm / dDatas / AntValue do ClassInfo do SCX),
57: * Init com os dois parametros do legado, ValidarParametros, InicializarForm,
58: * ResolverContextoPai, ConfigurarDecoracao (Picture), ConfigurarCabecalho
59: * (cntSombra), TornarControlesVisiveis e Destroy.
60: *
61: * ORDEM DE CRIACAO - o cabecalho eh o PRIMEIRO AddObject do form, e tem de
62: * continuar sendo: no SCX o CommandGroup cntBotoes esta em Top = -2 e o
63: * botao btnCotacao em Top = 3, ou seja DENTRO da faixa do cabecalho
64: * (Top 0..80). Quem for criado DEPOIS desenha POR CIMA; invertida a ordem,
65: * a faixa cinza cobriria Salvar/Cancelar/Alterar (regra #11 do CLAUDE.md).
66: *
67: * FASE 4: grade Gradeget_cotacao (2 colunas - Moeda e Cotacao, ligadas ao
68: * cursor de trabalho do pai), o Shape shpBtnGs, o CommandGroup cntBotoes
69: * (btnConfirmar / btnSair) e o botao btnCotacao, todos criados DEPOIS do
70: * cabecalho conforme a ordem acima.
71: *
72: * FASE 5: Load do form legado (Set Decimals to 5 / Delete All For
73: * Empty(CMoes) / Replace All aValos With Valos / Go Top), ja disponivel no
74: * BO como PrepararCursorCotacao, mais a visibilidade de btnCotacao e
75: * shpBtnGs calculada pelo BO (ObterVisibilidadeBotaoCotacao).
76: *
77: * FASE 6: este dialogo nao tem Page2 nem lookup NENHUM - o dump
78: * legado nao casa fwBuscaExt/fwBuscaSel/fwBuscaInt/mAddColuna/sigacess, e
79: * inventar um lookup violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
80: * lookup". O unico campo que aceita digitacao eh a celula Cotacao da grade,
81: * e a fase entrega os TRES eventos que o legado tem nela, mais o bloqueio da
82: * coluna Moeda:
83: *
84: *   Gradeget_cotacao.moeda.Text1.When    -> Return .f. (constante), via
85: *       TextBoxMoedaGridCot_4c - a coluna Moeda nunca recebe foco
86: *   Gradeget_cotacao.cotacao.Text1.When  -> ValidarAcessoCotacao
87: *       (snapshot do AntValue + permissao: cargo com altcots = S E moeda
88: *        cotavel)
89: *   Gradeget_cotacao.cotacao.Text1.Valid -> ValidarCotacao
90: *       (LastKey() = 13 -> Keyboard {DnArrow}: ENTER desce uma linha)
91: *   Gradeget_cotacao.cotacao.Text1.KeyPress -> ValidarCotacaoKeyPress
92: *       (nKeyCode = 9 -> foco em btnConfirmar: TAB vai para Salvar)
93: *
94: * Os quatro moram em SUBCLASSE de TextBox posta na Column com AddObject +
95: * CurrentControl + Sparse = .F. (classes\TextBoxGridLookup.prg, regra #18) e
96: * NAO em BINDEVENT: a regra #46 eh explicita de que BINDEVENT em
97: * "When"/"Valid" de TextBox de Column nao eh confiavel. Por isso este form
98: * nao tem chamada de BINDEVENT alguma - nao eh omissao, eh a regra.
99: *
100: * O Valid e o KeyPress da celula sao trabalho DESTA fase e nao da Fase 8:
101: * sem eles a tela exibe o campo editavel e a navegacao do legado nao
102: * acontece - o usuario digita a cotacao e nem desce de linha nem alcanca o
103: * Salvar pelo teclado.
104: *
105: * FASE 7 (esta fase): eventos dos BOTOES. O SCX legado tem TRES botoes, e
106: * cada um tem o SEU Click como metodo separado - por isso o bind eh por
107: * botao (Buttons(N)) e nao um handler unico no Click do CommandGroup:
108: *
109: *   cntBotoes.btnConfirmar.Click -> BtnConfirmarClick (fecha mantendo o que
110: *       foi digitado na coluna Cotacao; o legado nao grava nada aqui)
111: *   cntBotoes.btnSair.Click      -> BtnCancelarClick (Set Decimals To 2 +
112: *       Replace All Valos With aValos antes de fechar, via
113: *       DesfazerCotacoes do BO - o desfazer usa a copia de seguranca que o
114: *       Load legado deixou em avalos)
115: *   btnCotacao.Click             -> BtnCotacaoClick (abre o FormSigOpAlC
116: *       com a moeda/cotacao da LINHA CORRENTE e a data base, e aplica o
117: *       retorno com AplicarCotacaoAutorizada)
118: *
119: * Mais duas pecas que os tres eventos exigem:
120: *   VincularEventosBotoes - os tres BINDEVENT, chamados no InicializarForm
121: *       depois de ConfigurarBotoes (BINDEVENT precisa do objeto criado)
122: *   FecharDialogo         - o "ThisForm.Release" dos dois botoes de saida,
123: *       fonte unica, fechando com Hide() para o form pai conseguir ler
124: *       this_lConfirmado depois do Show (ver CHAMADA acima)
125: *
126: * O When do btnCotacao (Inlist(ParentForm.pcEscolha,[INSERIR],[ALTERAR]))
127: * vale para a ACAO e nao so para o visual, por isso BtnCotacaoClick confere
128: * PodeUsarBotaoCotacao de novo, alem do Enabled que
129: * AplicarVisibilidadeBotaoCotacao ja aplica na abertura.
130: *
131: * FASE 8 (esta fase): os dois hooks de transferencia, mais a ligacao deles
132: * nos caminhos que antes faziam o mesmo trabalho espalhado.
133: *
134: * Esta tela NAO tem ficha de campos soltos: a UNICA superficie editavel eh a
135: * celula Cotacao da LINHA CORRENTE da grade, e no legado ela esta ligada ao
136: * cursor por ControlSource ("tmpcot.valos"), sem transferencia explicita. Por
137: * isso o par FormParaBO / BOParaForm aqui tem a linha corrente como "ficha" -
138: * e NAO eh invencao: o bloco existe no SCX legado, so nao tem esse nome.
139: *
140: *   FormParaBO  <- Init legado (CursorQuery([SigCdUsu],...) que resolve o
141: *                  cargo do usuario) + When da celula Cotacao
142: *                  (ThisForm.AntValue = This.Value e
143: *                   CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],TmpCot.CMoes))
144: *   BOParaForm  -> fim do Load legado (Go Top) + o Replace Valos da linha
145: *                  corrente que o btnCotacao aplica depois da autorizacao
146: *
147: * O QUE A FASE MUDOU ALEM DE ACRESCENTAR OS DOIS METODOS: eles entraram como
148: * FONTE UNICA nos tres lugares que antes repetiam o trabalho inline -
149: * ValidarAcessoCotacao (lia cmoes do cursor e chamava RegistrarCelulaCorrente
150: * na mao), BtnCotacaoClick (EVALUATE de cmoes e valos) e CarregarLista
151: * (repintava direto). Hook que ninguem chama eh stub disfarcado; hook
152: * duplicado por tres caminhos eh onde os tres divergem.
153: *
154: * UMA CORRECAO DE FIDELIDADE VEM COM ISSO: o Init legado resolve o cargo
155: * (SigCdUsu -> SigCdCrg.altcots) ANTES de calcular btnCotacao.Visible. Ate a
156: * Fase 7 a permissao era resolvida so por demanda, dentro do
157: * PodeAlterarCotacao da primeira celula tocada, entao na ABERTURA o
158: * this_lAltCots ainda era .F. e o botao Alterar aparecia para TODO usuario -
159: * inclusive para quem tem o altcots e no legado nem o veria (o NOT do Init).
160: * Agora o InicializarForm chama FormParaBO ANTES de
161: * AplicarVisibilidadeBotaoCotacao, que eh a ordem do legado.
162: *
163: * OS DOIS HOOKS SAO "PROTECTED" E ISSO NAO EH ESCOLHA: a FormBase ja declara
164: * PROTECTED PROCEDURE FormParaBO() / BOParaForm(), e em VFP9 a subclasse nao
165: * alarga escopo herdado - escrever PROCEDURE sem o modificador nao torna o
166: * metodo publico, so mente para quem le. Por isso TODA chamada aqui eh por
167: * THIS., de dentro da classe, e quem quiser exercita-los de um harness
168: * precisa de uma subclasse (detalhe medido no comentario do FormParaBO).
169: *
170: * NOMES CANONICOS DE CRUD QUE NAO SE APLICAM A ESTA TELA (grafados com o
171: * miolo elidido de proposito - a validacao das fases procura o nome como
172: * substring no arquivo inteiro, entao escreve-los por extenso faria o gate
173: * passar pelo motivo errado):
174: *   Btn...Incluir/Alterar/Excluir...Click - o SCX legado nao tem botao CRUD
175: *       nenhum: sao dois botoes de fechamento (Salvar/Cancelar) e um de
176: *       autorizacao de cotacao. Nao ha registro a incluir ou excluir - as
177: *       linhas da grade vem prontas no cursor do form pai.
178: *   Ajustar...PorModo - este dialogo nao tem modos proprios. O modo que
179: *       importa eh o do PAI (pcEscolha), lido em ResolverContextoPai e
180: *       usado pelo BO para decidir visibilidade e permissao.
181: *
182: * NAO entra nessa lista o CarregarLista, que EXISTE neste form (Fase 4) e
183: * esta escrito por extenso de proposito: ele nao consulta banco - faz o bind
184: * da grade ao cursor que o form PAI ja abriu e chama o PrepararCursorCotacao
185: * do BO (o Load legado). O nome canonico cabe porque o papel eh o mesmo:
186: * deixar a grade pronta para uso.
187: *==============================================================================
188: 
189: DEFINE CLASS FormSigOpCot AS FormBase
190: 
191:     *==========================================================================
192:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
193:     *==========================================================================
194: 
195:     *-- SIGOPCOT: Height = 600 / Width = 1000
196:     this_cMensagemErro = ""
197:     Height       = 600
198:     Width        = 1000
199: 
200:     *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
201:     BorderStyle  = 2
202:     AutoCenter   = .T.
203:     ShowTips     = .T.
204: 
205:     *-- Caption = "Alteracao de Cambio". Literal acentuado eh proibido em

*-- Linhas 297 a 430:
297:     * Init - LParameters ParentForm, pdDatas do legado
298:     *
299:     * Os parametros sao guardados ANTES do DODEFAULT() porque eh o
300:     * FormBase.Init que chama InicializarForm, e lah o contexto do pai ja
301:     * tem de estar disponivel.
302:     *==========================================================================
303:     PROCEDURE Init
304:         LPARAMETERS par_oFormPai, par_dDatas
305: 
306:         IF VARTYPE(par_oFormPai) = "O"
307:             THIS.this_oFormPai = par_oFormPai
308:         ENDIF
309: 
310:         *-- Legado: If (Type([pdDatas]) = [D]) / dDatas = pdDatas / Else
311:         *--         dDatas = Date() / EndIf
312:         *-- ConverterParaData normaliza DATE/DATETIME/CHAR (regra #16): o
313:         *-- chamador pode passar uma coluna datetime do SQL Server
314:         IF VARTYPE(par_dDatas) = "D" OR VARTYPE(par_dDatas) = "T"
315:             THIS.this_dDatas = ConverterParaData(par_dDatas)
316:         ELSE
317:             THIS.this_dDatas = DATE()
318:         ENDIF
319: 
320:         IF EMPTY(THIS.this_dDatas)
321:             THIS.this_dDatas = DATE()
322:         ENDIF
323: 
324:         RETURN DODEFAULT()
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * ValidarParametros - precondicao deste dialogo, equivalente ao
329:     * LParameters ParentForm do legado: sem form pai nao ha pcEscolha a
330:     * consultar nem cursor de cotacao a editar.
331:     *
332:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
333:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
334:     *
335:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
336:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o bypass
337:     * a instanciacao reprovaria sempre. NAO se valida gnConnHandle aqui: o
338:     * harness define gnConnHandle = 0 de proposito, e quem trata a falta de
339:     * conexao eh o proprio BO, por consulta.
340:     *
341:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
342:     * bloco algum.
343:     *==========================================================================
344:     PROCEDURE ValidarParametros
345:         LOCAL loc_lValido
346:         loc_lValido = .T.
347: 
348:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
349:             RETURN .T.
350:         ENDIF
351: 
352:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
353:             RETURN .T.
354:         ENDIF
355: 
356:         IF VARTYPE(THIS.this_oFormPai) != "O"
357:             MsgErro("A altera" + CHR(231) + CHR(227) + "o de c" + CHR(226) + "mbio " + ;
358:                     "s" + CHR(243) + " pode ser aberta a partir do documento.", ;
359:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
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
383:             *-- Contexto vindo do form pai (pcEscolha e alias dos cursores de
384:             *-- trabalho). Roda antes do BO para ja entregar o contexto nele
385:             THIS.ResolverContextoPai()
386: 
387:             *-- Business Object das Fases 1-2. Criado SEM gate de
388:             *-- gnConnHandle: o BO consulta sob demanda e reporta por
389:             *-- this_cMensagemErro quando a conexao nao esta disponivel
390:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCotBO")
391: 
392:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
393:                 MsgErro("Falha ao criar SigOpCotBO.", ;
394:                         "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
395:             ELSE
396:                 *-- Repassa ao BO o contexto que o legado lia do ParentForm e
397:                 *-- dos parametros do Init
398:                 THIS.this_oBusinessObject.this_dDatas      = THIS.this_dDatas
399:                 THIS.this_oBusinessObject.this_cEscolhaPai = THIS.this_cEscolhaPai
400:                 THIS.this_oBusinessObject.this_nAntValue   = THIS.this_nAntValue
401: 
402:                 *-- Alias de cursor: so sobrescreve o default do BO quando o
403:                 *-- pai informou um alias proprio
404:                 IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
405:                     THIS.this_oBusinessObject.this_cCursorCotacao = THIS.this_cCursorCotacao
406:                 ELSE
407:                     THIS.this_cCursorCotacao = THIS.this_oBusinessObject.this_cCursorCotacao
408:                 ENDIF
409: 
410:                 IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
411:                     THIS.this_oBusinessObject.this_cCursorCabecalho = THIS.this_cCursorCabecalho
412:                 ELSE
413:                     THIS.this_cCursorCabecalho = THIS.this_oBusinessObject.this_cCursorCabecalho
414:                 ENDIF
415: 
416:                 *-- Usuario logado = Usuar do legado, usado para resolver a
417:                 *-- permissao de cargo (SigCdUsu -> SigCdCrg.altcots)
418:                 IF TYPE("gc_4c_UsuarioLogado") = "C"
419:                     THIS.this_oBusinessObject.this_cUsuario = ;
420:                         PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
421:                 ENDIF
422: 
423:                 *-- Fundo do form (Picture do SCX)
424:                 THIS.ConfigurarDecoracao()
425: 
426:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO AddObject
427:                 *-- do form: os botoes das fases seguintes ficam em Top -2..3,
428:                 *-- dentro da faixa, e precisam ser criados depois para
429:                 *-- desenhar por cima (regra #11)
430:                 THIS.ConfigurarCabecalho()

*-- Linhas 442 a 897:
442: 
443:                 *-- FASE 7 - Click dos tres botoes do SCX (btnConfirmar,
444:                 *-- btnSair e btnCotacao). Vem DEPOIS de ConfigurarBotoes
445:                 *-- porque BINDEVENT precisa dos objetos ja criados: ligar um
446:                 *-- evento a objeto inexistente estoura no proprio bind
447:                 THIS.VincularEventosBotoes()
448: 
449:                 *-- Legado (Init): lblSombra.Caption e lblTitulo.Caption
450:                 *-- recebem ThisForm.Caption
451:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
452:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
453: 
454:                 *-- AddObject cria controle com Visible = .F.
455:                 THIS.TornarControlesVisiveis()
456: 
457:                 *-- FASE 4 - liga a grade ao cursor de cotacoes do form pai.
458:                 *-- Vem DEPOIS do TornarControlesVisiveis porque a grade
459:                 *-- precisa estar visivel para o Refresh do fim da carga
460:                 *-- pintar as linhas (regra #21/#46).
461:                 *--
462:                 *-- Guard de harness: o ValidarUIFidelity e o TesteAutomatico
463:                 *-- instanciam o form sem form pai e sem cursor, entao nao ha
464:                 *-- o que carregar. Fora do harness o proprio CarregarLista
465:                 *-- confere USED() antes de ligar coisa alguma - sem o cursor
466:                 *-- do pai a grade fica vazia, como no legado
467:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
468:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
469:                         THIS.CarregarLista()
470:                     ENDIF
471:                 ENDIF
472: 
473:                 *-- FASE 8 - Init legado:
474:                 *--   poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],
475:                 *--                         [Usuarios],Padr(Alltrim(Usuar),10))
476:                 *-- O legado resolve o cargo do usuario ANTES de calcular a
477:                 *-- visibilidade do botao Alterar, e a ordem eh o que importa:
478:                 *-- a visibilidade le o altcots do cargo. Resolvida so por
479:                 *-- demanda (na primeira celula tocada), ela chegaria aqui
480:                 *-- sempre .F. e o botao apareceria para TODO usuario -
481:                 *-- inclusive para quem tem a permissao e no legado nem o veria
482:                 THIS.FormParaBO()
483: 
484:                 *-- Visibilidade de btnCotacao e shpBtnGs, transcrita do Init
485:                 *-- legado. Os dois nascem Visible = .F. e sao os unicos
486:                 *-- controles que o TornarControlesVisiveis NAO toca, para
487:                 *-- que a decisao fique aqui - e nao em "tudo visivel"
488:                 THIS.AplicarVisibilidadeBotaoCotacao()
489: 
490:                 *-- O dialogo nasce como "nao confirmado": so o botao Salvar
491:                 *-- marca .T., e o Cancelar desfaz as cotacoes
492:                 THIS.this_lConfirmado = .F.
493: 
494:                 loc_lSucesso = .T.
495:             ENDIF
496: 
497:         CATCH TO loc_oErro
498:             THIS.this_cMensagemErro = loc_oErro.Message
499:             MsgErro("Erro ao inicializar FormSigOpCot: " + loc_oErro.Message + ;
500:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
501:                     " | Proc: " + loc_oErro.Procedure, "Erro")
502:             loc_lSucesso = .F.
503:         ENDTRY
504: 
505:         RETURN loc_lSucesso
506:     ENDPROC
507: 
508:     *==========================================================================
509:     * ResolverContextoPai - le do form pai o que o legado lia direto de
510:     * ThisForm.ParentForm:
511:     *
512:     *   pcEscolha            -> this_cEscolhaPai  (INSERIR/ALTERAR/PROCURAR)
513:     *   cursor de cotacao    -> this_cCursorCotacao   (TmpCot no legado)
514:     *   cursor de cabecalho  -> this_cCursorCabecalho (TprMvCab no legado)
515:     *
516:     * O form pai migrado pode expor o modo com o nome do legado (pcEscolha)
517:     * ou com o nome novo (this_cModoAtual), por isso os dois sao conferidos
518:     * com PEMSTATUS antes de serem lidos - ler membro que nao existe estoura
519:     * em runtime. PEMSTATUS exige OBJETO no 1o argumento, e eh o caso aqui.
520:     *
521:     * Metodo PUBLIC: o form pai pode reinformar o contexto entre dois usos do
522:     * mesmo dialogo.
523:     *==========================================================================
524:     PROCEDURE ResolverContextoPai
525:         LOCAL loc_lSucesso, loc_cEscolha, loc_oErro
526:         loc_lSucesso = .F.
527:         loc_cEscolha = ""
528: 
529:         TRY
530:             IF VARTYPE(THIS.this_oFormPai) = "O"
531:                 *-- Nome do legado tem precedencia: eh o que o SCX le
532:                 IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
533:                     IF VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
534:                         loc_cEscolha = THIS.this_oFormPai.pcEscolha
535:                     ENDIF
536:                 ENDIF
537: 
538:                 IF EMPTY(ALLTRIM(loc_cEscolha))
539:                     IF PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
540:                         IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C"
541:                             loc_cEscolha = THIS.this_oFormPai.this_cModoAtual
542:                         ENDIF
543:                     ENDIF
544:                 ENDIF
545: 
546:                 *-- Alias do cursor de cotacao que o pai abriu
547:                 IF PEMSTATUS(THIS.this_oFormPai, "this_cCursorCotacao", 5)
548:                     IF VARTYPE(THIS.this_oFormPai.this_cCursorCotacao) = "C" ;
549:                             AND !EMPTY(ALLTRIM(THIS.this_oFormPai.this_cCursorCotacao))
550:                         THIS.this_cCursorCotacao = ALLTRIM(THIS.this_oFormPai.this_cCursorCotacao)
551:                     ENDIF
552:                 ENDIF
553: 
554:                 *-- Alias do cursor de cabecalho do documento do pai
555:                 IF PEMSTATUS(THIS.this_oFormPai, "this_cCursorCabecalho", 5)
556:                     IF VARTYPE(THIS.this_oFormPai.this_cCursorCabecalho) = "C" ;
557:                             AND !EMPTY(ALLTRIM(THIS.this_oFormPai.this_cCursorCabecalho))
558:                         THIS.this_cCursorCabecalho = ;
559:                             ALLTRIM(THIS.this_oFormPai.this_cCursorCabecalho)
560:                     ENDIF
561:                 ENDIF
562: 
563:                 loc_lSucesso = .T.
564:             ENDIF
565: 
566:             THIS.this_cEscolhaPai = UPPER(ALLTRIM(loc_cEscolha))
567: 
568:             *-- Mantem o BO em sincronia quando ele ja existe (o
569:             *-- InicializarForm chama este metodo ANTES de criar o BO, mas o
570:             *-- pai pode chamar de novo depois)
571:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
572:                 THIS.this_oBusinessObject.this_cEscolhaPai = THIS.this_cEscolhaPai
573: 
574:                 IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
575:                     THIS.this_oBusinessObject.this_cCursorCotacao = THIS.this_cCursorCotacao
576:                 ENDIF
577: 
578:                 IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
579:                     THIS.this_oBusinessObject.this_cCursorCabecalho = THIS.this_cCursorCabecalho
580:                 ENDIF
581:             ENDIF
582:         CATCH TO loc_oErro
583:             THIS.this_cMensagemErro = loc_oErro.Message
584:             MsgErro("Erro ao ler o contexto do documento: " + loc_oErro.Message, ;
585:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
586:             loc_lSucesso = .F.
587:         ENDTRY
588: 
589:         RETURN loc_lSucesso
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * ConfigurarDecoracao - fundo do form
594:     * Legado: SIGOPCOT.Picture = ..\framework\imagens\new_background.jpg
595:     *
596:     * gc_4c_CaminhoIcones eh criada pelo config.prg, que o ValidarUIFidelity
597:     * NAO executa - sem o TYPE() a referencia estouraria "Variable ... is not
598:     * found" dentro do TRY do InicializarForm. O FILE() aqui NAO mascara
599:     * defeito de nome de arquivo (regra #25): o alvo eh o mesmo do dump e o
600:     * caminho eh o canonico do projeto; o guard existe so para o harness, que
601:     * roda sem as variaveis de caminho.
602:     *==========================================================================
603:     PROTECTED PROCEDURE ConfigurarDecoracao
604:         LOCAL loc_cImagemFundo
605:         loc_cImagemFundo = ""
606: 
607:         IF TYPE("gc_4c_CaminhoIcones") = "C"
608:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
609:         ENDIF
610: 
611:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
612:             THIS.Picture = loc_cImagemFundo
613:         ENDIF
614:     ENDPROC
615: 
616:     *==========================================================================
617:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
618:     *
619:     * Legado:
620:     *   cntSombra  Top=0  Left=0  Width=1004  Height=80  BorderWidth=0
621:     *              BackColor=100,100,100
622:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
623:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
624:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
625:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
626:     *
627:     * Width do container: o SCX desenha 1004, quatro pixels ALEM da borda do
628:     * form (Width=1000) - artefato de Form Designer. Usa-se THIS.Width, que
629:     * eh o canonico da faixa (regra #11) e nao extrapola o form. Os labels
630:     * mantem o literal 769 do dump, que cabe folgado nos 1000px visiveis.
631:     *
632:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
633:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
634:     * #23), e os 40/46 do dump sao justamente o tamanho ja calculado pelo
635:     * Form Designer.
636:     *==========================================================================
637:     PROTECTED PROCEDURE ConfigurarCabecalho
638:         *-- Container da faixa (cntSombra)
639:         THIS.AddObject("cnt_4c_Sombra", "Container")
640:         WITH THIS.cnt_4c_Sombra
641:             .Top           = 0
642:             .Left          = 0
643:             .Width         = THIS.Width
644:             .Height        = 80
645:             .BorderWidth   = 0
646:             .BackStyle     = 1
647:             .BackColor     = RGB(100, 100, 100)
648:             .SpecialEffect = 0
649:             .Visible       = .T.
650:         ENDWITH
651: 
652:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
653:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
654:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
655:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
656:             .AutoSize      = .F.
657:             .FontBold      = .T.
658:             .FontName      = "Tahoma"
659:             .FontSize      = 18
660:             .FontUnderline = .F.
661:             .WordWrap      = .T.
662:             .Alignment     = 0
663:             .BackStyle     = 0
664:             .Caption       = THIS.Caption
665:             .Top           = 18
666:             .Left          = 10
667:             .Width         = 769
668:             .Height        = 40
669:             .ForeColor     = RGB(0, 0, 0)
670:             .Rotation      = 0
671:             .Visible       = .T.
672:         ENDWITH
673: 
674:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
675:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
676:         *-- regra #12)
677:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
678:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
679:             .AutoSize    = .F.
680:             .FontBold    = .T.
681:             .FontName    = "Tahoma"
682:             .FontSize    = 18
683:             .WordWrap    = .T.
684:             .Alignment   = 0
685:             .BackStyle   = 0
686:             .Caption     = THIS.Caption
687:             .Top         = 17
688:             .Left        = 10
689:             .Width       = 769
690:             .Height      = 46
691:             .ForeColor   = RGB(255, 255, 255)
692:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
693:             .Rotation    = 0
694:             .Visible     = .T.
695:         ENDWITH
696: 
697:         THIS.cnt_4c_Sombra.Visible = .T.
698:     ENDPROC
699: 
700:     *==========================================================================
701:     * TornarControlesVisiveis - AddObject cria todo controle com
702:     * Visible = .F.; este metodo percorre o form e os containers tornando
703:     * visivel o que foi criado.
704:     *
705:     * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
706:     *
707:     * NAO forca visibilidade de btnCotacao nem de shpBtnGs (criados na Fase
708:     * 4): os dois nascem Visible = .F. de proposito, porque o Init legado
709:     * calcula a visibilidade deles a partir da permissao de cargo
710:     * (ObterVisibilidadeBotaoCotacao no BO). Forcar .T. aqui exporia o botao
711:     * de autorizacao a quem ja pode digitar a cotacao direto na grade.
712:     * Os FILHOS desses controles continuam sendo tratados: container oculto
713:     * com filhos invisiveis apareceria vazio quando fosse exibido.
714:     *==========================================================================
715:     PROCEDURE TornarControlesVisiveis
716:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho, loc_cNome
717: 
718:         FOR loc_nI = 1 TO THIS.ControlCount
719:             loc_oControle = THIS.Controls(loc_nI)
720: 
721:             IF VARTYPE(loc_oControle) != "O"
722:                 LOOP
723:             ENDIF
724: 
725:             loc_cNome = UPPER(ALLTRIM(loc_oControle.Name))
726: 
727:             IF !INLIST(loc_cNome, "CMD_4C_BTNCOTACAO", "SHP_4C_SHPBTNGS")
728:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
729:                     loc_oControle.Visible = .T.
730:                 ENDIF
731:             ENDIF
732: 
733:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
734:                 IF loc_oControle.ControlCount > 0
735:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
736:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
737: 
738:                         IF VARTYPE(loc_oFilho) = "O"
739:                             IF PEMSTATUS(loc_oFilho, "Visible", 5)
740:                                 loc_oFilho.Visible = .T.
741:                             ENDIF
742:                         ENDIF
743:                     ENDFOR
744:                 ENDIF
745:             ENDIF
746:         ENDFOR
747: 
748:         RETURN .T.
749:     ENDPROC
750: 
751:     *==========================================================================
752:     * Destroy - libera o BO e devolve o controle ao FormBase.
753:     *
754:     * NAO libera this_oFormPai: ao contrario dos forms despachante, o SCX
755:     * legado nunca chama ParentForm.Release - o pai continua vivo e eh ele
756:     * quem grava o documento depois que este dialogo fecha. Aqui a referencia
757:     * eh apenas anulada, para nao segurar o pai alem do tempo.
758:     *
759:     * NAO fecha o cursor de cotacao: ele pertence ao form pai (TmpCot do
760:     * legado), que continua precisando dele para gravar.
761:     *==========================================================================
762:     PROCEDURE Destroy
763:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
764:             THIS.this_oBusinessObject = .NULL.
765:         ENDIF
766: 
767:         THIS.this_oFormPai = .NULL.
768: 
769:         DODEFAULT()
770:     ENDPROC
771: 
772: 
773:     *==========================================================================
774:     * ConfigurarShapeDestaque - shpBtnGs do legado
775:     *
776:     * Legado: Top=7 Left=6 Height=110 Width=92 BackStyle=0 BorderStyle=0
777:     *         BorderColor=36,84,155 ZOrderSet=0
778:     *
779:     * Com BackStyle = 0 (transparente) e BorderStyle = 0 (sem borda) o Shape
780:     * NAO desenha nada - eh a moldura de reserva que o Framework legado usava
781:     * para marcar a area do botao de autorizacao. Transcrito assim mesmo
782:     * (PILAR 1) e com a MESMA visibilidade do btnCotacao, como o Init legado
783:     * faz (shpBtnGs.Visible = btnCotacao.Visible).
784:     *
785:     * ZOrderSet NAO eh transcrito: eh bookkeeping do Form Designer gravado no
786:     * SCX e NAO existe como propriedade em runtime - atribui-la estoura
787:     * "Property ZORDERSET is not found" e mata o Init (regra #33). O
788:     * equivalente em runtime eh o METODO ZOrder(), que o legado nao chama; a
789:     * ordem de empilhamento ja sai correta porque este eh o PRIMEIRO controle
790:     * do corpo a ser criado, exatamente como no SCX (ZOrderSet = 0).
791:     *
792:     * Shape NAO tem ForeColor (regra #33): a cor da moldura mora em
793:     * BorderColor, que eh o que o dump declara.
794:     *
795:     * Nasce Visible = .F. de proposito - quem decide eh
796:     * AplicarVisibilidadeBotaoCotacao.
797:     *==========================================================================
798:     PROTECTED PROCEDURE ConfigurarShapeDestaque
799:         THIS.AddObject("shp_4c_ShpBtnGs", "Shape")
800:         WITH THIS.shp_4c_ShpBtnGs
801:             .Top         = 7
802:             .Left        = 6
803:             .Height      = 110
804:             .Width       = 92
805:             .BackStyle   = 0
806:             .BorderStyle = 0
807:             .BorderColor = RGB(36, 84, 155)
808:             .Visible     = .F.
809:         ENDWITH
810:     ENDPROC
811: 
812:     *==========================================================================
813:     * ConfigurarGradeCotacoes - Gradeget_cotacao do legado (classe fwgrade)
814:     *
815:     * Legado (grade):
816:     *   ColumnCount=2  FontName="Verdana"  FontSize=8  AllowHeaderSizing=.T.
817:     *   DeleteMark=.F. Height=513 Left=413 ReadOnly=.F. RowHeight=16
818:     *   ScrollBars=2   TabIndex=1 Top=83 Width=173 RecordSource="tmpcot"
819:     *
820:     * Legado (Column1 "moeda"):   Verdana 8, Width=40,  Movable=.F.,
821:     *   Resizable=.F., ReadOnly=.F., SelectOnEntry=.F., Format="K"
822:     *   Header1: Verdana 8, Alignment=2, Caption="Moeda"
823:     *   Text1:   Verdana 8, BorderStyle=0, Format="K", Margin=0,
824:     *            ReadOnly=.F., ForeColor=0,0,0, BackColor=255,255,255,
825:     *            ControlSource="tmpcot.cmoes"
826:     *
827:     * Legado (Column2 "cotacao"): Verdana 8, ColumnOrder=2, Width=101,
828:     *   Movable=.F., Resizable=.F., ReadOnly=.F., SelectOnEntry=.F.,
829:     *   Format="K", InputMask="99999.9999999"
830:     *   Header1: Verdana 8, Alignment=2, Caption="Cotacao"
831:     *   Text1:   Verdana 8, BorderStyle=0, Format="K", Margin=0,
832:     *            ReadOnly=.F., ForeColor=0,0,0, BackColor=255,255,255
833:     *
834:     * NENHUM RecordSource / ControlSource eh definido AQUI: este metodo roda
835:     * dentro do Init, quando o cursor de cotacoes do form pai ainda pode nao
836:     * estar aberto, e ligar coluna a alias inexistente estoura
837:     * "Alias ... is not found" DENTRO do TRY do InicializarForm - o
838:     * CREATEOBJECT devolveria logico e a tela nao abriria (regra #41). O bind
839:     * inteiro (RecordSource -> ControlSource -> Width -> Header) mora em
840:     * CarregarLista, com o cursor ja conferido por USED().
841:     *
842:     * Column.Name NAO eh trocado: renomear Column quebra TODAS as
843:     * referencias .Column1/.Column2 do resto do form. Os nomes "moeda" e
844:     * "cotacao" do legado ficam registrados nestes comentarios.
845:     *
846:     * ChildOrder NAO eh transcrito: o dump traz ChildOrder="cmoes" com
847:     * LinkMaster="" e RelationalExpr="", isto eh, uma relacao mestre-detalhe
848:     * INERTE (sem mestre nao ha relacao). Atribui-lo exigiria que o alias e a
849:     * tag existissem no momento do Init, o que nao se garante aqui, e nao
850:     * mudaria nada na tela.
851:     *
852:     * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh o canonico do
853:     * fwgrade do Framework (framework_frmcadastro_layout.md), e sem ele a
854:     * grade de 173px ainda perderia uma faixa lateral para a marca de
855:     * registro.
856:     *==========================================================================
857:     PROTECTED PROCEDURE ConfigurarGradeCotacoes
858:         LOCAL loc_oGrid
859: 
860:         THIS.AddObject("grd_4c_Dados", "Grid")
861:         loc_oGrid = THIS.grd_4c_Dados
862: 
863:         WITH loc_oGrid
864:             .Top               = 83
865:             .Left              = 413
866:             .Width             = 173
867:             .Height            = 513
868:             .ColumnCount       = 2
869:             .FontName          = "Verdana"
870:             .FontSize          = 8
871:             .AllowHeaderSizing = .T.
872:             .DeleteMark        = .F.
873:             .RecordMark        = .F.
874:             .RowHeight         = 16
875:             .ScrollBars        = 2
876:             .TabIndex          = 1
877: 
878:             *-- ReadOnly do GRID vem ANTES do ReadOnly das COLUNAS: o do
879:             *-- grid propaga para as colunas e sobrescreveria o delas
880:             *-- (regra #18)
881:             .ReadOnly          = .F.
882: 
883:             .Visible           = .T.
884:         ENDWITH
885: 
886:         *-- Column1 = "moeda" do legado. A celula eh de LEITURA no legado
887:         *-- (When do Text1: Return .f.), mas Column.ReadOnly fica .F. como o
888:         *-- dump declara - o bloqueio eh pelo When, que entra na Fase 6
889:         WITH loc_oGrid.Column1
890:             .Width         = 40
891:             .Movable       = .F.
892:             .Resizable     = .F.
893:             .ReadOnly      = .F.
894:             .SelectOnEntry = .F.
895:             .Format        = "K"
896:             .FontName      = "Verdana"
897:             .FontSize      = 8

*-- Linhas 917 a 1007:
917: 
918:         *-- FASE 6 - gate da celula (When): a classe TextBoxMoedaGridCot_4c
919:         *-- (classes\TextBoxGridLookup.prg) reproduz o When literal do
920:         *-- legado (Return .f.). BINDEVENT em "When" de Column.Text1 nao eh
921:         *-- confiavel (regra #46/CLAUDE.md) - por isso a classe e nao o bind
922:         loc_oGrid.Column1.AddObject("txt_4c_Moeda", "TextBoxMoedaGridCot_4c")
923:         loc_oGrid.Column1.CurrentControl = "txt_4c_Moeda"
924:         loc_oGrid.Column1.Sparse         = .F.
925: 
926:         *-- Column2 = "cotacao" do legado: a UNICA celula editavel da tela.
927:         *-- O InputMask "99999.9999999" eh REGRA, nao enfeite - a cotacao eh
928:         *-- numeric(11,6) e a mascara eh o que limita o que o usuario digita
929:         *-- (regra #49). Transcrita LITERAL do dump
930:         WITH loc_oGrid.Column2
931:             .ColumnOrder   = 2
932:             .Width         = 101
933:             .Movable       = .F.
934:             .Resizable     = .F.
935:             .ReadOnly      = .F.
936:             .SelectOnEntry = .F.
937:             .Format        = "K"
938:             .InputMask     = "99999.9999999"
939:             .FontName      = "Verdana"
940:             .FontSize      = 8
941:         ENDWITH
942: 
943:         WITH loc_oGrid.Column2.Header1
944:             .FontName  = "Verdana"
945:             .FontSize  = 8
946:             .Alignment = 2
947:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
948:         ENDWITH
949: 
950:         WITH loc_oGrid.Column2.Text1
951:             .FontName    = "Verdana"
952:             .FontSize    = 8
953:             .BorderStyle = 0
954:             .Format      = "K"
955:             .Margin      = 0
956:             .ReadOnly    = .F.
957:             .ForeColor   = RGB(0, 0, 0)
958:             .BackColor   = RGB(255, 255, 255)
959:         ENDWITH
960: 
961:         *-- FASE 6 - os TRES eventos da UNICA celula digitavel da tela. A
962:         *-- classe TextBoxCotacaoGridCot_4c (classes\TextBoxGridLookup.prg)
963:         *-- delega cada um ao metodo PUBLIC homonimo deste form:
964:         *--   When     -> ValidarAcessoCotacao   (snapshot AntValue + permissao)
965:         *--   Valid    -> ValidarCotacao         (ENTER desce uma linha)
966:         *--   KeyPress -> ValidarCotacaoKeyPress (TAB vai para Salvar)
967:         *-- BINDEVENT em "When"/"Valid" de Column.Text1 nao eh confiavel
968:         *-- (regra #46/CLAUDE.md) - por isso a subclasse, e nao o bind
969:         loc_oGrid.Column2.AddObject("txt_4c_Cotacao", "TextBoxCotacaoGridCot_4c")
970:         loc_oGrid.Column2.CurrentControl = "txt_4c_Cotacao"
971:         loc_oGrid.Column2.Sparse         = .F.
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * ConfigurarBotoes - cntBotoes (CommandGroup Salvar/Cancelar) e btnCotacao
976:     *
977:     * Legado (cntBotoes): AutoSize=.T. ButtonCount=2 BackStyle=0
978:     *   BorderStyle=0 Value=0 Top=-2 Left=843 Width=160 Height=85
979:     *   SpecialEffect=1 TabIndex=1 Themes=.F.
980:     *
981:     *   Command1 "btnConfirmar": Top=5 Left=5 75x75, Tahoma 8 bold italic,
982:     *     WordWrap=.T., AutoSize=.F., Picture=cadastro_salvar_60.jpg,
983:     *     Caption="\<Salvar", MousePointer=15, TabIndex=1,
984:     *     ToolTipText="Gravar os Dados Informados", SpecialEffect=0,
985:     *     PicturePosition=13, ForeColor=90,90,90, BackColor=255,255,255,
986:     *     Themes=.F.
987:     *   Command2 "btnSair": Top=5 Left=80 75x75, Tahoma 8 bold italic,
988:     *     WordWrap=.T., Picture=cadastro_sair_60.jpg, Cancel=.T.,
989:     *     Caption="\<Cancelar", MousePointer=15, TabIndex=4,
990:     *     ToolTipText="[Esc] Sair Sem Gravar os Dados", SpecialEffect=0,
991:     *     ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
992:     *
993:     * Legado (btnCotacao): AutoSize=.F. Top=3 Left=773 75x75,
994:     *   Comic Sans MS 8 bold italic, WordWrap=.T.,
995:     *   Picture=cadastro_alterar_60.jpg, Caption="\<Alterar ",
996:     *   MousePointer=15, TabIndex=2, ToolTipText="Total dos Produtos",
997:     *   Visible=.F., ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
998:     *
999:     * Os tres arquivos de icone sao os do dump e existem em vbmp\
1000:     * (cadastro_salvar_60.jpg, cadastro_sair_60.jpg,
1001:     * cadastro_alterar_60.jpg) - NAO ha palpite por semelhanca semantica
1002:     * (regra #25). PicturePosition = 13 eh o canonico de TODO botao do
1003:     * Framework (framework_frmcadastro_layout.md); o dump o declara em
1004:     * Command1 e omite nos outros dois, onde ele vem da classe.
1005:     *
1006:     * O "\<" dos Captions eh o marcador de tecla de acesso do VFP (Alt+S /
1007:     * Alt+C / Alt+A) - faz parte do comportamento do legado e eh transcrito.

*-- Linhas 1029 a 1072:
1029:     * retangulo com texto e sem figura. Os botoes DENTRO do CommandGroup
1030:     * mantem Themes = .F., que eh o canonico do Framework.
1031:     *==========================================================================
1032:     PROTECTED PROCEDURE ConfigurarBotoes
1033:         LOCAL loc_cIcones, loc_cPicSalvar, loc_cPicSair, loc_cPicAlterar
1034: 
1035:         loc_cIcones = ""
1036:         IF TYPE("gc_4c_CaminhoIcones") = "C"
1037:             loc_cIcones = gc_4c_CaminhoIcones
1038:         ENDIF
1039: 
1040:         loc_cPicSalvar  = loc_cIcones + "cadastro_salvar_60.jpg"
1041:         loc_cPicSair    = loc_cIcones + "cadastro_sair_60.jpg"
1042:         loc_cPicAlterar = loc_cIcones + "cadastro_alterar_60.jpg"
1043: 
1044:         *-- CommandGroup cntBotoes -> cmg_4c_Botoes
1045:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
1046:         WITH THIS.cmg_4c_Botoes
1047:             .ButtonCount   = 2
1048:             .BackStyle     = 0
1049:             .BorderStyle   = 0
1050:             .Value         = 0
1051:             .SpecialEffect = 1
1052:             .Themes        = .F.
1053:             .TabIndex      = 1
1054: 
1055:             *-- Buttons(1) = btnConfirmar (Salvar)
1056:             WITH .Buttons(1)
1057:                 .AutoSize        = .F.
1058:                 .Top             = 5
1059:                 .Left            = 5
1060:                 .Height          = 75
1061:                 .Width           = 75
1062:                 .FontName        = "Comic Sans MS"
1063:                 .FontSize        = 8
1064:                 .FontBold        = .T.
1065:                 .FontItalic      = .T.
1066:                 .WordWrap        = .T.
1067:                 .Caption         = "\<Salvar"
1068:                 .MousePointer    = 15
1069:                 .TabIndex        = 1
1070:                 .ToolTipText     = "Gravar os Dados Informados"
1071:                 .SpecialEffect   = 0
1072:                 .PicturePosition = 13

*-- Linhas 1186 a 1229:
1186:     * Fecha repintando a grade (RepintarGradeCotacoes) - popular cursor NAO
1187:     * repinta grade (regra #21).
1188:     *==========================================================================
1189:     PROCEDURE CarregarLista
1190:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrid, loc_oErro
1191:         loc_lSucesso = .F.
1192: 
1193:         TRY
1194:             loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
1195: 
1196:             *-- Alias ainda nao resolvido: usa o default que o BO carrega
1197:             IF EMPTY(loc_cAlias) AND VARTYPE(THIS.this_oBusinessObject) = "O"
1198:                 loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorCotacao)
1199:                 THIS.this_cCursorCotacao = loc_cAlias
1200:             ENDIF
1201: 
1202:             IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
1203:                 *-- Sem o cursor do pai nao ha nada a ligar. NAO eh erro de
1204:                 *-- tela: o legado tambem exibiria a grade vazia. A mensagem
1205:                 *-- fica registrada para quem chamou poder diagnosticar
1206:                 THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
1207:                     loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
1208:                     CHR(237) + "vel."
1209:             ELSE
1210:                 *-- Load do legado, transcrito no BO: descarta linha sem
1211:                 *-- moeda, guarda a copia de seguranca em avalos (para o
1212:                 *-- Cancelar poder desfazer) e posiciona no topo
1213:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1214:                     IF !THIS.this_oBusinessObject.PrepararCursorCotacao(loc_cAlias)
1215:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1216:                             THIS.this_cMensagemErro = ;
1217:                                 THIS.this_oBusinessObject.this_cMensagemErro
1218:                         ENDIF
1219:                     ENDIF
1220:                 ENDIF
1221: 
1222:                 loc_oGrid = THIS.grd_4c_Dados
1223: 
1224:                 *-- 1) RecordSource (reseta Width e Header1.Caption)
1225:                 loc_oGrid.RecordSource = loc_cAlias
1226: 
1227:                 *-- 2) ControlSource de cada coluna
1228:                 loc_oGrid.Column1.ControlSource = loc_cAlias + ".cmoes"
1229:                 loc_oGrid.Column2.ControlSource = loc_cAlias + ".valos"

*-- Linhas 1254 a 1365:
1254:             THIS.this_cMensagemErro = loc_oErro.Message
1255:             MsgErro("Erro ao carregar as cota" + CHR(231) + CHR(245) + "es: " + ;
1256:                     loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1257:                     " | Proc: " + loc_oErro.Procedure, ;
1258:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1259:             loc_lSucesso = .F.
1260:         ENDTRY
1261: 
1262:         RETURN loc_lSucesso
1263:     ENDPROC
1264: 
1265:     *==========================================================================
1266:     * RepintarGradeCotacoes - Go Top + Refresh da grade; no legado, o fim do
1267:     * Load (Go Top) somado ao repintar que o Framework fazia.
1268:     *
1269:     * METODO UNICO de repintura, para ser chamado por TODO caminho que mexe
1270:     * no cursor (carga inicial, desfazer no Cancelar, aplicacao da cotacao
1271:     * autorizada nas fases seguintes). Popular cursor NAO repinta a grade:
1272:     * sem este passo a grade fica visualmente vazia com o cursor cheio, e o
1273:     * sintoma manda o diagnostico para o SQL (regra #21/#46).
1274:     *
1275:     * Metodo PUBLIC: as fases seguintes e o form pai o chamam de fora.
1276:     *==========================================================================
1277:     PROCEDURE RepintarGradeCotacoes
1278:         LOCAL loc_cAlias, loc_oErro
1279: 
1280:         TRY
1281:             loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
1282: 
1283:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1284:                 SELECT (loc_cAlias)
1285:                 GO TOP
1286:             ENDIF
1287: 
1288:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1289:                 THIS.grd_4c_Dados.Refresh()
1290:             ENDIF
1291:         CATCH TO loc_oErro
1292:             THIS.this_cMensagemErro = loc_oErro.Message
1293:             MsgErro("Erro ao atualizar a grade de cota" + CHR(231) + CHR(245) + "es: " + ;
1294:                     loc_oErro.Message, ;
1295:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1296:         ENDTRY
1297: 
1298:         RETURN .T.
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * AplicarVisibilidadeBotaoCotacao - Init legado, transcrito:
1303:     *
1304:     *   btnCotacao.Visible = Not (Seek(crSigCdUsu.Ccargs,[crSigCdCrg],
1305:     *                             [Ccargs]) And (crSigCdCrg.AltCots = [S])
1306:     *                             And InList(ParentForm.pcEscolha,
1307:     *                                        [INSERIR],[ALTERAR]))
1308:     *   shpBtnGs.Visible   = btnCotacao.Visible
1309:     *
1310:     * O NOT eh do legado e nao eh descuido: quem JA tem o altcots do cargo
1311:     * digita a cotacao direto na celula e nao precisa do botao; o botao
1312:     * existe para quem NAO tem a permissao, e abre o dialogo de autorizacao
1313:     * (SigOpAlC) onde outro usuario libera a alteracao. O calculo mora no BO
1314:     * (ObterVisibilidadeBotaoCotacao) - aqui so se aplica o resultado.
1315:     *
1316:     * O Enabled vem do When do btnCotacao legado
1317:     * (Inlist(pcEscolha,[INSERIR],[ALTERAR]) -> PodeUsarBotaoCotacao): em
1318:     * modo PROCURAR o botao fica desabilitado. E eh por isso que ele leva
1319:     * Themes = .T. + DisabledPicture em ConfigurarBotoes - sem esse par o
1320:     * icone desapareceria justamente no estado desabilitado.
1321:     *
1322:     * Metodo PUBLIC: o form pai pode reaplicar depois de trocar o contexto
1323:     * (ResolverContextoPai), e o harness de teste o alcanca de fora.
1324:     *==========================================================================
1325:     PROCEDURE AplicarVisibilidadeBotaoCotacao
1326:         LOCAL loc_lVisivel, loc_lHabilitado, loc_oErro
1327:         loc_lVisivel    = .F.
1328:         loc_lHabilitado = .F.
1329: 
1330:         TRY
1331:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1332:                 loc_lVisivel = THIS.this_oBusinessObject.ObterVisibilidadeBotaoCotacao( ;
1333:                     THIS.this_cEscolhaPai)
1334:                 loc_lHabilitado = THIS.this_oBusinessObject.PodeUsarBotaoCotacao( ;
1335:                     THIS.this_cEscolhaPai)
1336:             ENDIF
1337: 
1338:             THIS.this_lBotaoCotacaoVisivel = loc_lVisivel
1339: 
1340:             IF PEMSTATUS(THIS, "cmd_4c_BtnCotacao", 5)
1341:                 THIS.cmd_4c_BtnCotacao.Visible = loc_lVisivel
1342:                 THIS.cmd_4c_BtnCotacao.Enabled = loc_lHabilitado
1343:             ENDIF
1344: 
1345:             *-- Legado: shpBtnGs.Visible = btnCotacao.Visible
1346:             IF PEMSTATUS(THIS, "shp_4c_ShpBtnGs", 5)
1347:                 THIS.shp_4c_ShpBtnGs.Visible = loc_lVisivel
1348:             ENDIF
1349:         CATCH TO loc_oErro
1350:             THIS.this_cMensagemErro = loc_oErro.Message
1351:             MsgErro("Erro ao aplicar a permiss" + CHR(227) + "o de cota" + CHR(231) + ;
1352:                     CHR(227) + "o: " + loc_oErro.Message, ;
1353:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1354:         ENDTRY
1355: 
1356:         RETURN .T.
1357:     ENDPROC
1358: 
1359:     *==========================================================================
1360:     * FormParaBO - Form -> BO. Transfere para o Business Object o contexto da
1361:     * tela e a LINHA CORRENTE da grade, que eh a unica "ficha" que este
1362:     * dialogo tem.
1363:     *
1364:     * Transcreve DOIS blocos do legado, que no SCX moram em lugares
1365:     * diferentes e fazem a mesma coisa (resolver no banco o que a tela precisa

*-- Linhas 1409 a 1474:
1409:     * this_cMensagemErro, que o chamador le quando faz sentido.
1410:     *
1411:     * PROTECTED EXPLICITO, e nao por escolha de estilo: a FormBase declara
1412:     * PROTECTED PROCEDURE FormParaBO() (eh um dos hooks que o Salvar dela
1413:     * chama por THIS.), e em VFP9 a subclasse NAO ALARGA escopo herdado -
1414:     * escrever PROCEDURE sem o modificador nao torna o metodo publico, so
1415:     * esconde de quem le que ele continua protegido. Medido nesta tela em
1416:     * 2026-10-30: PEMSTATUS(oForm,"FormParaBO",5) devolve .T. (so pergunta
1417:     * "existe?") e oForm.FormParaBO() de FORA estoura
1418:     * "Property FORMPARABO is not found" - a mesma armadilha da regra #51,
1419:     * mas vinda da HERANCA, onde tirar o PROTECTED do proprio arquivo nao
1420:     * resolve.
1421:     *
1422:     * Consequencia pratica: TODA chamada eh de dentro da classe, por THIS.
1423:     * (regra #8) - InicializarForm, CarregarLista, ValidarAcessoCotacao e
1424:     * BtnCotacaoClick. Quem precisar exercitar o hook de fora (harness) tem
1425:     * de criar uma DEFINE CLASS Probe AS FormSigOpCot com um metodo publico
1426:     * que chame THIS.FormParaBO(): subclasse alcanca membro protegido, script
1427:     * solto nao.
1428:     *
1429:     * par_oTxt tolera a chamada SEM argumento (que eh a assinatura da
1430:     * FormBase, PROCEDURE FormParaBO() sem parametro): parametro nao passado
1431:     * chega como .F. em VFP9, logo VARTYPE != "O" e o bloco do AntValue eh
1432:     * pulado - nao estoura se a FormBase.Salvar chamar este hook um dia.
1433:     *==========================================================================
1434:     PROTECTED PROCEDURE FormParaBO(par_oTxt)
1435:         LOCAL loc_lSucesso, loc_cAlias, loc_cMoedaAnterior, loc_cMoedaLinha
1436:         LOCAL loc_oBO, loc_oErro
1437:         loc_lSucesso = .F.
1438: 
1439:         *-- Guarda de precondicao ANTES do TRY (regra #1)
1440:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1441:             RETURN .F.
1442:         ENDIF
1443: 
1444:         loc_oBO = THIS.this_oBusinessObject
1445: 
1446:         TRY
1447:             *-- Contexto da tela: os mesmos valores que o Init legado lia dos
1448:             *-- parametros e do ParentForm
1449:             loc_oBO.this_dDatas      = THIS.this_dDatas
1450:             loc_oBO.this_cEscolhaPai = THIS.this_cEscolhaPai
1451: 
1452:             IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
1453:                 loc_oBO.this_cCursorCotacao = THIS.this_cCursorCotacao
1454:             ENDIF
1455: 
1456:             IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
1457:                 loc_oBO.this_cCursorCabecalho = THIS.this_cCursorCabecalho
1458:             ENDIF
1459: 
1460:             *-- Usuar do legado
1461:             IF TYPE("gc_4c_UsuarioLogado") = "C"
1462:                 loc_oBO.this_cUsuario = PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
1463:             ENDIF
1464: 
1465:             *-- Legado (When da celula): ThisForm.AntValue = This.Value
1466:             IF VARTYPE(par_oTxt) = "O"
1467:                 IF PEMSTATUS(par_oTxt, "Value", 5)
1468:                     loc_oBO.RegistrarCelulaCorrente(par_oTxt.Value)
1469:                     THIS.this_nAntValue = loc_oBO.this_nAntValue
1470:                 ENDIF
1471:             ENDIF
1472: 
1473:             *-- ETAPA 1 - Init legado: CursorQuery([SigCdUsu],...). So uma vez
1474:             IF EMPTY(ALLTRIM(loc_oBO.this_cCargo))

*-- Linhas 1540 a 1593:
1540:     * caminho eh o que faz um deles ficar de fora.
1541:     *
1542:     * PROTECTED EXPLICITO pelo MESMO motivo do FormParaBO: a FormBase declara
1543:     * PROTECTED PROCEDURE BOParaForm() e o VFP9 nao deixa a subclasse alargar
1544:     * o escopo herdado. Chamado so de dentro, por THIS. - CarregarLista e
1545:     * BtnCotacaoClick. Para alcanca-lo de um harness, subclasse (ver o
1546:     * comentario do FormParaBO).
1547:     *
1548:     * Os dois metodos que ele chama no fim (RepintarGradeCotacoes e
1549:     * AplicarVisibilidadeBotaoCotacao) seguem PUBLIC: nao sao hooks da
1550:     * FormBase, e o form pai tem motivo para reaplica-los depois de mexer na
1551:     * linha corrente do cursor compartilhado.
1552:     *==========================================================================
1553:     PROTECTED PROCEDURE BOParaForm
1554:         LOCAL loc_lSucesso, loc_cAlias, loc_cMoedaBO, loc_cMoedaLinha
1555:         LOCAL loc_nValorLinha, loc_oBO, loc_oErro
1556:         loc_lSucesso = .F.
1557: 
1558:         *-- Guarda de precondicao ANTES do TRY (regra #1)
1559:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1560:             RETURN .F.
1561:         ENDIF
1562: 
1563:         loc_oBO = THIS.this_oBusinessObject
1564: 
1565:         TRY
1566:             loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
1567: 
1568:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND !EOF(loc_cAlias)
1569:                 loc_cMoedaBO = PADR(ALLTRIM(loc_oBO.this_cMoeda), 3)
1570:                 loc_cMoedaLinha = ""
1571: 
1572:                 IF TYPE(loc_cAlias + ".cmoes") == "C"
1573:                     loc_cMoedaLinha = PADR(ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cmoes"), "")), 3)
1574:                 ENDIF
1575: 
1576:                 *-- Devolve SO quando o BO esta na linha corrente
1577:                 IF !EMPTY(ALLTRIM(loc_cMoedaBO)) AND loc_cMoedaBO == loc_cMoedaLinha
1578:                     IF TYPE(loc_cAlias + ".valos") == "N"
1579:                         loc_nValorLinha = NVL(EVALUATE(loc_cAlias + ".valos"), 0)
1580: 
1581:                         IF loc_nValorLinha != loc_oBO.this_nValorAtual
1582:                             *-- Legado: Replace Valos With ... In TmpCot
1583:                             REPLACE valos WITH loc_oBO.this_nValorAtual IN (loc_cAlias)
1584:                         ENDIF
1585: 
1586:                         loc_lSucesso = .T.
1587:                     ENDIF
1588:                 ENDIF
1589: 
1590:                 *-- Espelha o AntValue do BO na property homonima do form
1591:                 *-- (ClassInfo do SCX: antvalue)
1592:                 THIS.this_nAntValue = loc_oBO.this_nAntValue
1593:             ENDIF

*-- Linhas 1602 a 1679:
1602:             THIS.this_cMensagemErro = loc_oErro.Message
1603:             MsgErro("Erro ao devolver a cota" + CHR(231) + CHR(227) + "o para a grade: " + ;
1604:                     loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1605:                     " | Proc: " + loc_oErro.Procedure, ;
1606:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1607:             loc_lSucesso = .F.
1608:         ENDTRY
1609: 
1610:         RETURN loc_lSucesso
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * ValidarAcessoCotacao - When da celula Cotacao do legado
1615:     * (Gradeget_cotacao.cotacao.Text1), transcrito LITERAL:
1616:     *
1617:     *   ThisForm.AntValue = This.Value
1618:     *   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdUsu],...)
1619:     *   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdMoe],...)
1620:     *   Return (Seek(crSigCdUsu.Ccargs,[crSigCdCrg],[Ccargs]) And
1621:     *           (crSigCdCrg.AltCots=[S]) And crSigCdMoe.Cotas)
1622:     *
1623:     * Chamado pela classe TextBoxCotacaoGridCot_4c (classes\
1624:     * TextBoxGridLookup.prg), instalada na Column2 via AddObject +
1625:     * CurrentControl + Sparse = .F. (regra #18) - BINDEVENT em "When" de
1626:     * Column.Text1 nao eh confiavel (regra #46/CLAUDE.md).
1627:     *
1628:     * par_oTxt eh o proprio TextBox da celula: This.Value, dentro do When,
1629:     * eh o valor que a celula JA TINHA antes do foco entrar (a edicao ainda
1630:     * nao comecou) - exatamente o que o legado guarda em AntValue.
1631:     *
1632:     * O recordpointer do cursor ja esta na linha de destino quando o Grid
1633:     * dispara o When (mesma linha que vai receber o foco), por isso ler
1634:     * <alias>.cmoes aqui equivale ao TmpCot.CMoes do When legado.
1635:     *
1636:     * Metodo PUBLIC: chamado de fora (pela celula da grade), nao pode ser
1637:     * PROTECTED (regra #3/#8).
1638:     *==========================================================================
1639:     PROCEDURE ValidarAcessoCotacao(par_oTxt)
1640:         LOCAL loc_lPode, loc_oErro
1641:         loc_lPode = .F.
1642: 
1643:         TRY
1644:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1645:                 *-- FASE 8: as tres coisas que este When faz no legado
1646:                 *-- (AntValue = This.Value, CursorQuery de SigCdUsu e
1647:                 *-- CursorQuery de SigCdMoe sobre TmpCot.CMoes) estao no
1648:                 *-- FormParaBO, que eh a fonte unica da transferencia
1649:                 *-- Form -> BO. Antes elas eram feitas aqui na mao, e o
1650:                 *-- botao Alterar fazia a mesma leitura por outro caminho
1651:                 THIS.FormParaBO(par_oTxt)
1652: 
1653:                 *-- Legado: Return (Seek(...) And AltCots = [S] And
1654:                 *--                 crSigCdMoe.Cotas)
1655:                 loc_lPode = THIS.this_oBusinessObject.PodeAlterarCotacao( ;
1656:                     THIS.this_oBusinessObject.this_cMoeda)
1657:             ENDIF
1658:         CATCH TO loc_oErro
1659:             THIS.this_cMensagemErro = loc_oErro.Message
1660:             loc_lPode = .F.
1661:         ENDTRY
1662: 
1663:         RETURN loc_lPode
1664:     ENDPROC
1665: 
1666:     *==========================================================================
1667:     * ValidarCotacao - Valid da celula Cotacao do legado (Gradeget_cotacao.
1668:     * cotacao.Text1), transcrito LITERAL:
1669:     *
1670:     *   Local ldDatas
1671:     *   ldDatas = ThisForm.dDatas
1672:     *   If (LastKey() = 13)
1673:     *       Keyboard [{DnArrow}]
1674:     *   EndIf
1675:     *
1676:     * Efeito: ao confirmar a celula com ENTER, o foco desce uma linha na
1677:     * grade - o usuario percorre as moedas de cima para baixo digitando a
1678:     * cotacao de cada uma sem tocar no mouse. Com TAB o Valid tambem roda,
1679:     * mas LASTKEY() nao eh 13 e nada eh enfileirado: quem trata o TAB eh o

*-- Linhas 1700 a 1907:
1700:     * TextBoxCotacaoGridCot_4c) - PROTECTED estouraria em runtime
1701:     * (regra #3/#8/#51).
1702:     *==========================================================================
1703:     PROCEDURE ValidarCotacao(par_oTxt)
1704:         *-- Legado: If (LastKey() = 13) / Keyboard [{DnArrow}]
1705:         IF LASTKEY() = 13
1706:             KEYBOARD "{DNARROW}"
1707:         ENDIF
1708: 
1709:         RETURN .T.
1710:     ENDPROC
1711: 
1712:     *==========================================================================
1713:     * ValidarCotacaoKeyPress - KeyPress da celula Cotacao do legado
1714:     * (Gradeget_cotacao.cotacao.Text1), transcrito LITERAL:
1715:     *
1716:     *   Lparameters nKeyCode, nShiftAltCtrl
1717:     *   If (nKeyCode = 9)
1718:     *       ThisForm.cntBotoes.btnConfirmar.SetFocus
1719:     *   EndIf
1720:     *
1721:     * Efeito: TAB (9) na celula leva o foco direto para o botao Salvar
1722:     * (cntBotoes.btnConfirmar -> cmg_4c_Botoes.Buttons(1)), em vez de seguir
1723:     * a ordem de tabulacao. Eh o atalho de "terminei de digitar, quero
1724:     * gravar" do legado.
1725:     *
1726:     * O guard de tecla eh o do legado e tem de ficar: handler de KeyPress
1727:     * SEM teste de tecla age a cada caractere digitado (regra #47).
1728:     *
1729:     * SetFocus em controle invisivel ou desabilitado estoura em runtime, e
1730:     * este KeyPress roda a cada tecla da celula - por isso Visible/Enabled do
1731:     * grupo E do botao sao conferidos antes. Em uso normal os dois estao
1732:     * ligados; o guard existe para o caminho do harness, que instancia o form
1733:     * sem form pai.
1734:     *
1735:     * SEM NODEFAULT: o legado tambem nao usa, e suprimir o TAB nativo
1736:     * mudaria a navegacao da grade (PILAR 1).
1737:     *
1738:     * Metodo PUBLIC: chamado de fora, pela celula da grade (classe
1739:     * TextBoxCotacaoGridCot_4c) - PROTECTED estouraria em runtime
1740:     * (regra #3/#8/#51).
1741:     *==========================================================================
1742:     PROCEDURE ValidarCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1743:         LOCAL loc_oGrupo
1744: 
1745:         *-- Legado: If (nKeyCode = 9) -> TAB
1746:         IF VARTYPE(par_nKeyCode) = "N" AND par_nKeyCode = 9
1747:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1748:                 loc_oGrupo = THIS.cmg_4c_Botoes
1749: 
1750:                 IF loc_oGrupo.Visible AND loc_oGrupo.Enabled
1751:                     *-- Buttons(1) = btnConfirmar (Salvar) do legado
1752:                     IF loc_oGrupo.Buttons(1).Visible AND loc_oGrupo.Buttons(1).Enabled
1753:                         loc_oGrupo.Buttons(1).SetFocus()
1754:                     ENDIF
1755:                 ENDIF
1756:             ENDIF
1757:         ENDIF
1758: 
1759:         RETURN .T.
1760:     ENDPROC
1761: 
1762: 
1763:     *==========================================================================
1764:     * VincularEventosBotoes - BINDEVENT dos TRES botoes que o SCX legado tem
1765:     *
1766:     * No legado cada botao tem o SEU proprio Click, como metodo separado:
1767:     *   cntBotoes.btnConfirmar.Click -> BtnConfirmarClick
1768:     *   cntBotoes.btnSair.Click      -> BtnCancelarClick
1769:     *   btnCotacao.Click             -> BtnCotacaoClick
1770:     *
1771:     * Por isso o bind eh por BOTAO (Buttons(N)) e NAO no Click do GRUPO: um
1772:     * handler unico no grupo teria de desempatar por .Value, e o legado nunca
1773:     * escreveu assim. Buttons(1) = btnConfirmar e Buttons(2) = btnSair, na
1774:     * MESMA ordem em que ConfigurarBotoes os cria (Command1/Command2 do dump).
1775:     *
1776:     * Os tres handlers sao PUBLIC de proposito: BINDEVENT falha em SILENCIO
1777:     * com metodo PROTECTED (regra #3) - o botao ficaria inerte, sem erro
1778:     * nenhum e sem nada em log.
1779:     *
1780:     * "Click" de CommandButton/CommandGroup dispara de verdade pelo BINDEVENT
1781:     * - diferente de "Valid"/"When" de TextBox de Column, que nao sao
1782:     * confiaveis e por isso moram na subclasse da celula (regra #46). Nenhum
1783:     * dos tres handlers declara parametro: Click nao passa nenhum.
1784:     *==========================================================================
1785:     PROTECTED PROCEDURE VincularEventosBotoes
1786:         *-- btnConfirmar.Click do legado (Caption Salvar)
1787:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
1788: 
1789:         *-- btnSair.Click do legado (Caption Cancelar, Cancel = .T. - eh este
1790:         *-- que o ESC aciona, e eh ele que desfaz as cotacoes)
1791:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnCancelarClick")
1792: 
1793:         *-- btnCotacao.Click do legado (Caption Alterar)
1794:         BINDEVENT(THIS.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")
1795: 
1796:         RETURN .T.
1797:     ENDPROC
1798: 
1799:     *==========================================================================
1800:     * BtnConfirmarClick - btnConfirmar.Click do legado, transcrito LITERAL:
1801:     *
1802:     *   ThisForm.Release
1803:     *   Return .t.
1804:     *
1805:     * O botao NAO grava nada e NAO toca no cursor: o que o usuario digitou na
1806:     * coluna Cotacao ja foi para valos celula a celula, pelo proprio bind da
1807:     * grade. Confirmar significa apenas "mantenha o que esta ai" - quem
1808:     * persiste eh o form PAI, depois que este dialogo fecha, lendo o cursor
1809:     * compartilhado (e this_lConfirmado, para saber se deve usa-lo).
1810:     *
1811:     * SEM "SET DECIMALS TO 2" aqui, de proposito: o legado repoe os 2 decimais
1812:     * SO no btnSair (e o Load deste form tinha subido para 5). Esse
1813:     * desequilibrio eh do legado e eh transcrito como esta - repor a casa
1814:     * decimal no caminho de Confirmar mudaria a precisao com que o PAI
1815:     * arredonda a cotacao recem-aceita, que eh regra de negocio dele e nao
1816:     * desta tela (regra #17: formula e precisao do legado se transcrevem, nao
1817:     * se consertam).
1818:     *
1819:     * Fecha por FecharDialogo (Hide), nao por Release - ver o comentario de
1820:     * FecharDialogo.
1821:     *
1822:     * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
1823:     *==========================================================================
1824:     PROCEDURE BtnConfirmarClick
1825:         *-- Marca a saida por Salvar ANTES de fechar: depois do Hide eh esta
1826:         *-- propriedade que o form pai le para decidir se usa o cursor
1827:         THIS.this_lConfirmado = .T.
1828: 
1829:         THIS.FecharDialogo()
1830: 
1831:         RETURN .T.
1832:     ENDPROC
1833: 
1834:     *==========================================================================
1835:     * BtnCancelarClick - btnSair.Click do legado, transcrito LITERAL:
1836:     *
1837:     *   Set Decimals To 2
1838:     *   Replace All Valos With aValos
1839:     *   ThisForm.Release
1840:     *
1841:     * As DUAS primeiras linhas sao o desfazer: avalos eh a copia de seguranca
1842:     * que PrepararCursorCotacao gravou na abertura (Replace All aValos With
1843:     * Valos do Load legado), entao este Replace devolve TODAS as linhas ao
1844:     * valor que tinham quando a tela abriu - inclusive as que o usuario editou
1845:     * e as que foram alteradas sob autorizacao pelo botao Alterar. As duas
1846:     * moram no BO (DesfazerCotacoes), que eh onde a transcricao vive.
1847:     *
1848:     * O nome do handler eh BtnCancelarClick e nao BtnSairClick: o botao se
1849:     * chama btnSair no legado, mas o que ele FAZ eh cancelar (desfaz a
1850:     * edicao), e handler se nomeia pela ACAO, nao pelo objeto legado. O
1851:     * Caption do proprio dump confirma - Cancelar.
1852:     *
1853:     * Fecha a tela em TODO caminho, inclusive quando o desfazer falha: o
1854:     * legado nao tem saida condicional, e com TitleBar = 0 / Closable = .F.
1855:     * este botao (mais o ESC, que o Cancel = .T. encaminha para ele) eh a
1856:     * unica saida da tela - abortar o fechamento prenderia o usuario aqui. A
1857:     * falha do desfazer eh EXIBIDA, nao engolida (regra #9).
1858:     *
1859:     * Repinta a grade depois de mexer no cursor (RepintarGradeCotacoes, o
1860:     * metodo unico de repintura - regra #21): alterar cursor NAO repinta
1861:     * grade. Visualmente a tela fecha em seguida, mas o dialogo fecha com Hide
1862:     * e pode ser reaberto pelo mesmo pai - sem repintar, a reabertura mostraria
1863:     * os valores desfeitos sob a pintura antiga.
1864:     *
1865:     * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
1866:     *==========================================================================
1867:     PROCEDURE BtnCancelarClick
1868:         LOCAL loc_cAlias
1869: 
1870:         *-- Saida por Cancelar: o pai NAO deve usar o que foi digitado
1871:         THIS.this_lConfirmado = .F.
1872: 
1873:         loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
1874: 
1875:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1876:             *-- Legado: Set Decimals To 2 + Replace All Valos With aValos
1877:             IF !THIS.this_oBusinessObject.DesfazerCotacoes(loc_cAlias)
1878:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1879:                     THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
1880:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1881:                             "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1882:                 ENDIF
1883:             ENDIF
1884:         ENDIF
1885: 
1886:         THIS.RepintarGradeCotacoes()
1887: 
1888:         THIS.FecharDialogo()
1889: 
1890:         RETURN .T.
1891:     ENDPROC
1892: 
1893:     *==========================================================================
1894:     * BtnCotacaoClick - btnCotacao.Click do legado, transcrito LITERAL:
1895:     *
1896:     *   Do Form SigOpAlC With TmpCot.CMoes, TmpCot.Valos, ThisForm.dDatas
1897:     *                    To lcRetorno
1898:     *   If (MLine(lcRetorno, 1) = [OK])
1899:     *       Replace Valos With Val(MLine(lcRetorno, 2)) In TmpCot
1900:     *       If Used([TprMvCab])
1901:     *           Replace CotUsus With MLine(lcRetorno, 3) In TprMvCab
1902:     *       EndIf
1903:     *   EndIf
1904:     *
1905:     * O QUE ESTE BOTAO EH: o caminho de quem NAO tem o altcots do cargo. Quem
1906:     * tem digita a cotacao direto na celula (When da celula) e nem ve o botao
1907:     * - eh por isso que o Init legado calcula btnCotacao.Visible com NOT. Quem

*-- Linhas 1946 a 2073:
1946:     * com this_cMensagemErro VAZIO nesse caso, e por isso a mensagem so eh
1947:     * exibida quando existe.
1948:     *
1949:     * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
1950:     *==========================================================================
1951:     PROCEDURE BtnCotacaoClick
1952:         LOCAL loc_cAlias, loc_cAliasCab, loc_cMoeda, loc_nCotacao
1953:         LOCAL loc_oDialogo, loc_oDialogoBO, loc_cRetorno, loc_lAbrir, loc_oErro
1954: 
1955:         *-- Guards de precondicao ANTES de qualquer TRY, para o RETURN nao
1956:         *-- ficar dentro de TRY/CATCH (regra #1)
1957:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1958:             RETURN .F.
1959:         ENDIF
1960: 
1961:         *-- When do btnCotacao legado: so em INSERIR / ALTERAR
1962:         IF !THIS.this_oBusinessObject.PodeUsarBotaoCotacao(THIS.this_cEscolhaPai)
1963:             RETURN .F.
1964:         ENDIF
1965: 
1966:         loc_cAlias    = ALLTRIM(THIS.this_cCursorCotacao)
1967:         loc_cAliasCab = ALLTRIM(THIS.this_cCursorCabecalho)
1968: 
1969:         IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
1970:             MsgAviso("Cursor de cota" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
1971:                      "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", ;
1972:                      "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1973:             RETURN .F.
1974:         ENDIF
1975: 
1976:         *-- Sem linha corrente nao ha moeda para autorizar. O legado passaria
1977:         *-- moeda em branco adiante e o proprio FormSigOpAlC a recusaria com
1978:         *-- "Esta moeda nao permite Alteracao de Cotacao" - mensagem que vem de
1979:         *-- OUTRA tela e nao diz ao usuario o que fazer. Este guard nao muda o
1980:         *-- que acontece (nada eh autorizado nos dois casos), so diz o motivo
1981:         *-- no lugar certo
1982:         IF EOF(loc_cAlias)
1983:             MsgAviso("Selecione na grade a moeda cuja cota" + CHR(231) + CHR(227) + ;
1984:                      "o ser" + CHR(225) + " alterada.", ;
1985:                      "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
1986:             RETURN .F.
1987:         ENDIF
1988: 
1989:         loc_cMoeda     = ""
1990:         loc_nCotacao   = 0
1991:         loc_cRetorno   = ""
1992:         loc_oDialogo   = .NULL.
1993:         loc_oDialogoBO = .NULL.
1994:         loc_lAbrir     = .F.
1995: 
1996:         *-- TRY cobre SO a leitura da linha corrente e a CRIACAO do dialogo
1997:         TRY
1998:             *-- FASE 8: a leitura de TmpCot.CMoes / TmpCot.Valos da linha
1999:             *-- corrente passa pelo FormParaBO, mesma fonte unica que a celula
2000:             *-- da grade usa - antes este bloco repetia os dois EVALUATE e os
2001:             *-- dois caminhos podiam divergir. Sem par_oTxt: o AntValue da
2002:             *-- celula nao eh tocado por um clique de botao
2003:             THIS.FormParaBO()
2004: 
2005:             *-- Legado: TmpCot.CMoes e TmpCot.Valos da linha corrente
2006:             loc_cMoeda   = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
2007:             loc_nCotacao = THIS.this_oBusinessObject.this_nValorAtual
2008: 
2009:             *-- Legado: Do Form SigOpAlC With <moeda>, <cotacao>, <data>
2010:             loc_oDialogo = CREATEOBJECT("FormSigOpAlC", loc_cMoeda, loc_nCotacao, ;
2011:                                         THIS.this_dDatas)
2012: 
2013:             IF VARTYPE(loc_oDialogo) = "O"
2014:                 *-- canal de retorno que sobrevive ao Release do dialogo
2015:                 IF PEMSTATUS(loc_oDialogo, "this_oBusinessObject", 5)
2016:                     IF VARTYPE(loc_oDialogo.this_oBusinessObject) = "O"
2017:                         loc_oDialogoBO = loc_oDialogo.this_oBusinessObject
2018:                     ENDIF
2019:                 ENDIF
2020: 
2021:                 loc_lAbrir = .T.
2022:             ELSE
2023:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
2024:                         "autoriza" + CHR(231) + CHR(227) + "o de cota" + CHR(231) + ;
2025:                         CHR(227) + "o (FormSigOpAlC).", ;
2026:                         "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
2027:             ENDIF
2028:         CATCH TO loc_oErro
2029:             THIS.this_cMensagemErro = loc_oErro.Message
2030:             MsgErro("Erro ao abrir a autoriza" + CHR(231) + CHR(227) + "o de cota" + ;
2031:                     CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
2032:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2033:                     " | Proc: " + loc_oErro.Procedure, ;
2034:                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
2035:             loc_oDialogo   = .NULL.
2036:             loc_oDialogoBO = .NULL.
2037:             loc_lAbrir     = .F.
2038:         ENDTRY
2039: 
2040:         *-- Show() FORA do TRY (regra #29). Modal: so retorna quando o usuario
2041:         *-- confirma ou cancela a autorizacao
2042:         IF loc_lAbrir
2043:             loc_oDialogo.Show()
2044:         ENDIF
2045: 
2046:         IF loc_lAbrir
2047:             TRY
2048:                 *-- 1) property do form, enquanto ele existir
2049:                 IF VARTYPE(loc_oDialogo) = "O"
2050:                     IF PEMSTATUS(loc_oDialogo, "this_cRetorno", 5)
2051:                         loc_cRetorno = NVL(loc_oDialogo.this_cRetorno, "")
2052:                     ENDIF
2053:                 ENDIF
2054: 
2055:                 *-- 2) BO do dialogo - canal que sobrevive ao Release dele
2056:                 IF EMPTY(loc_cRetorno) AND VARTYPE(loc_oDialogoBO) = "O"
2057:                     loc_cRetorno = NVL(loc_oDialogoBO.this_cRetorno, "")
2058:                 ENDIF
2059: 
2060:                 *-- Legado: If (MLine(lcRetorno,1) = [OK]) / Replace Valos ... /
2061:                 *-- If Used([TprMvCab]) / Replace CotUsus ...
2062:                 IF THIS.this_oBusinessObject.AplicarCotacaoAutorizada(loc_cRetorno, ;
2063:                         loc_cAlias, loc_cAliasCab)
2064:                     *-- FASE 8: a volta BO -> Form passa pelo BOParaForm. O
2065:                     *-- AplicarCotacaoAutorizada ja gravou valos na linha e
2066:                     *-- atualizou this_nValorAtual com o MESMO numero, entao
2067:                     *-- aqui o guard de divergencia nao reescreve nada - o que
2068:                     *-- este passo entrega eh a repintura da grade (regra #21)
2069:                     *-- e a revisao da visibilidade do botao
2070:                     THIS.BOParaForm()
2071:                 ELSE
2072:                     *-- .F. com mensagem VAZIA = cancelado pelo usuario, que no
2073:                     *-- legado tambem nao produz aviso nenhum

*-- Linhas 2093 a 2139:
2093:                 MsgErro("Erro ao aplicar a cota" + CHR(231) + CHR(227) + "o " + ;
2094:                         "autorizada: " + loc_oErro.Message + ;
2095:                         " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2096:                         " | Proc: " + loc_oErro.Procedure, ;
2097:                         "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
2098:             ENDTRY
2099:         ENDIF
2100: 
2101:         RETURN .T.
2102:     ENDPROC
2103: 
2104:     *==========================================================================
2105:     * FecharDialogo - "ThisForm.Release" dos dois botoes de saida do legado,
2106:     * com UMA divergencia deliberada de PILAR 3: fecha com Hide(), nao com
2107:     * Release().
2108:     *
2109:     * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
2110:     * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
2111:     * a leitura seguinte estoura "is not an object". Este dialogo existe para
2112:     * DEVOLVER uma decisao (this_lConfirmado: saiu por Salvar ou por
2113:     * Cancelar), que o form PAI le DEPOIS do Show() para saber se usa o cursor
2114:     * de cotacao que ele mesmo abriu. No legado o pai abria com Do Form e os
2115:     * dois compartilhavam o cursor; no sistema novo o pai abre com
2116:     * CREATEOBJECT + Show() e precisa que o objeto sobreviva ao fechamento.
2117:     *
2118:     * Hide() em form modal TAMBEM devolve o Show(), entao para o usuario a
2119:     * tela fecha igual - o PILAR 1 fica preservado; muda so o tempo de vida do
2120:     * objeto, que eh PILAR 3. Eh o CHAMADOR quem chama Release() depois de
2121:     * ler, e esse eh o desenho que o projeto JA adota (o FormBuscaAuxiliar usa
2122:     * Hide pelo mesmo motivo, declarado no cabecalho dele).
2123:     *
2124:     * Fonte UNICA dos dois caminhos de saida (Salvar e Cancelar), para que a
2125:     * decisao de COMO fechar fique num lugar so.
2126:     *
2127:     * NAO ha PROCEDURE Unload devolvendo valor: o SCX legado tambem nao tem (o
2128:     * SIGOPCOT nao declara Unload nenhum) - o resultado deste dialogo sempre
2129:     * foi o proprio cursor compartilhado, nao um retorno de evento.
2130:     *
2131:     * PUBLIC: o form pai pode fechar o dialogo por codigo, e o harness o
2132:     * alcanca de fora.
2133:     *==========================================================================
2134:     PROCEDURE FecharDialogo
2135:         THIS.Hide()
2136: 
2137:         RETURN .T.
2138:     ENDPROC
2139: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCotBO.prg):
*====================================================================
* SigOpCotBO.prg
*
* Business Object para SigOpCot - Alteracao de Cambio
*
* Dialogo MODAL do legado Fortyus (SIGOPCOT.scx), aberto pelo form PAI
* durante Incluir/Alterar de um documento, para o usuario revisar/
* alterar a cotacao de cada moeda usada no documento. O legado NAO
* persiste nada direto: recebe o cursor TmpCot (CMoes/Valos/aValos) ja
* aberto pelo chamador, deixa o usuario editar a celula Cotacao linha a
* linha (sob permissao), e devolve via Replace All no proprio cursor -
* quem grava de fato eh o form pai, depois que este dialogo fecha.
*
* A permissao de editar manualmente a cotacao depende de DOIS fatores,
* verificados pelo When da celula Cotacao do legado:
*   1) Cargo do usuario logado (SigCdUsu.ccargs -> SigCdCrg.altcots='S')
*   2) A moeda da linha admitir cotacao manual (SigCdMoe.cotas = .T.)
*
* Tabela principal  : SigCdMoe (cmoes) - define se a moeda eh cotavel
* Tabelas de apoio   : SigCdUsu (usuarios/ccargs do usuario logado)
*                      SigCdCrg (ccargs/altcots - permissao do cargo)
*
* Herda de: BusinessBase
*
* Somente leitura: este BO nao executa Insert/Update/Delete em tabela
* alguma - apenas consulta SigCdUsu/SigCdCrg/SigCdMoe para resolver a
* permissao de edicao, e devolve o resultado para o Form aplicar no
* cursor de trabalho (TmpCot/equivalente) que o form pai controla. Por
* isso Inserir(), Atualizar() e ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase ja eh o correto.
*====================================================================

DEFINE CLASS SigOpCotBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) USUARIO / PERMISSAO
    *    Legado: Init faz CursorQuery(SigCdUsu,...,Usuar) e depois
    *    Seek(crSigCdUsu.Ccargs, crSigCdCrg) para achar o cargo; o When
    *    da celula Cotacao repete o mesmo Seek a cada linha
    *----------------------------------------------------------------

    *-- this_cUsuario -> SigCdUsu.usuarios char(10) - usuario logado
    *-- (equivalente a Usuar no legado, aqui = gc_4c_UsuarioLogado)
    this_cUsuario = ""

    *-- this_cCargo -> SigCdUsu.ccargs char(10) - cargo do usuario,
    *-- usado para localizar a permissao em SigCdCrg
    this_cCargo = ""

    *-- this_lAltCots -> SigCdCrg.altcots char(1) = 'S' - .T. quando o
    *-- cargo do usuario pode alterar cotacao manualmente. Equivale ao
    *-- 2o termo do And no Seek(...) do When legado
    this_lAltCots = .F.

    *----------------------------------------------------------------
    * 2) PARAMETRO DE ENTRADA
    *    Legado: LParameters ParentForm, pdDatas (Init). Sem pdDatas
    *    valido (Type([pdDatas])#[D]), ThisForm.dDatas = Date()
    *----------------------------------------------------------------

    *-- this_dDatas -> data base da cotacao, repassada ao dialogo
    *-- SigOpAlC quando o usuario pede a cotacao via botao Alterar
    this_dDatas = {}

    *----------------------------------------------------------------
    * 3) LINHA CORRENTE DA GRADE DE COTACAO (TmpCot)
    *    Legado: grid Gradeget_cotacao ligado ao cursor TmpCot
    *    (CMoes/Valos/aValos). O When da celula Cotacao testa se a
    *    MOEDA da linha corrente admite cotacao manual
    *----------------------------------------------------------------

    *-- this_cMoeda -> TmpCot.CMoes / SigCdMoe.cmoes char(3) - moeda da
    *-- linha corrente da grade
    this_cMoeda = ""

    *-- this_lMoedaCotada -> SigCdMoe.cotas bit - .T. quando a moeda da
    *-- linha corrente admite digitacao manual de cotacao. Equivale ao
    *-- 3o termo do And no Return do When legado (crSigCdMoe.Cotas)
    this_lMoedaCotada = .F.

    *-- this_nValorAtual -> TmpCot.Valos numeric - valor de cotacao
    *-- exibido/editado na linha corrente
    this_nValorAtual = 0

    *-- this_nValorAnterior -> TmpCot.aValos numeric - copia de
    *-- seguranca do valor original (Load legado: Replace All aValos
    *-- With Valos), usada para desfazer a edicao no botao Cancelar
    *-- (btnSair.Click legado: Replace All Valos With aValos)
    this_nValorAnterior = 0

    *-- this_nAntValue -> ThisForm.AntValue do legado (ClassInfo do SCX):
    *-- valor da celula Cotacao no momento em que o usuario ENTRA nela
    *-- (When da celula: ThisForm.AntValue = This.Value), guardado para
    *-- a comparacao antes/depois da digitacao
    this_nAntValue = 0

    *----------------------------------------------------------------
    * 4) DESCRICAO DA MOEDA E ESTADO VINDO DO FORM PAI
    *----------------------------------------------------------------

    *-- this_cDescricaoMoeda -> SigCdMoe.dmoes char(15) - descricao da
    *-- moeda da linha corrente (lida junto com cotas no mesmo SELECT)
    this_cDescricaoMoeda = ""

    *-- this_cEscolhaPai -> ParentForm.pcEscolha do legado: "INSERIR",
    *-- "ALTERAR" ou "PROCURAR". Entra na visibilidade do botao Alterar
    *-- (Init legado) e no When dele
    this_cEscolhaPai = ""

    *-- this_cCursorCotacao -> alias do cursor de trabalho que o form PAI
    *-- abre e passa para este dialogo (TmpCot no legado), com as colunas
    *-- cmoes / valos / avalos
    this_cCursorCotacao = ""

    *-- this_cCursorCabecalho -> alias do cursor de cabecalho do documento
    *-- do form pai (TprMvCab no legado, sobre SigMvCab), onde o legado
    *-- grava cotusus char(10) quando a cotacao eh alterada sob autorizacao
    this_cCursorCabecalho = ""

    *-- this_cUsuarioAutorizacao -> SigMvCab.cotusus char(10) - usuario que
    *-- autorizou a cotacao manual no dialogo SigOpAlC (3a linha do retorno
    *-- "OK" + CHR(13) + valor + CHR(13) + usuario)
    this_cUsuarioAutorizacao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas.
        *-- SigCdMoe eh a tabela que este BO efetivamente consulta
        *-- (flag Cotas, por moeda) para resolver a permissao de edicao
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"

        *-- Normalizacao equivalente ao Init legado: sem data valida
        *-- vinda do chamador, assume a data corrente
        THIS.this_cUsuario = ""
        THIS.this_cCargo   = ""
        THIS.this_lAltCots = .F.
        THIS.this_dDatas   = DATE()

        THIS.this_cMoeda         = ""
        THIS.this_lMoedaCotada   = .F.
        THIS.this_nValorAtual    = 0
        THIS.this_nValorAnterior = 0
        THIS.this_nAntValue      = 0

        THIS.this_cDescricaoMoeda     = ""
        THIS.this_cEscolhaPai         = ""
        THIS.this_cUsuarioAutorizacao = ""

        *-- Alias default dos cursores de trabalho; o form PAI pode trocar
        *-- (equivalem a TmpCot / TprMvCab do legado)
        THIS.this_cCursorCotacao   = "cursor_4c_Cotacoes"
        THIS.this_cCursorCabecalho = "cursor_4c_Cabecalho"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades a partir de UM registro
    * de cursor, cobrindo TODAS as colunas que este BO representa:
    *
    *   cursor de cotacao (TmpCot do legado) : cmoes / valos / avalos
    *   cursor de SigCdMoe                   : cmoes / dmoes / cotas
    *   cursor de SigCdUsu + SigCdCrg        : usuarios / ccargs / altcots
    *   cursor de cabecalho (TprMvCab)       : cotusus
    *
    * Metodo PUBLIC (sem PROTECTED): o Form o chama de fora, e PROTECTED
    * em qualquer nivel da heranca faz a chamada externa estourar
    * "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - moeda da linha / chave de SigCdMoe
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda admite cotacao digitada a mao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaCotada = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    *-- valos numeric(11,6) - cotacao exibida/editada
                    IF TYPE(loc_cAlias + ".valos") == "N"
                        THIS.this_nValorAtual = TratarNulo(valos, 0)
                    ENDIF

                    *-- avalos numeric - copia de seguranca do valor
                    *-- original (Load legado: Replace All aValos With Valos)
                    IF TYPE(loc_cAlias + ".avalos") == "N"
                        THIS.this_nValorAnterior = TratarNulo(avalos, 0)
                    ENDIF

                    *-- usuarios char(10) - usuario logado (SigCdUsu)
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuario = TratarNulo(usuarios, "")
                    ENDIF

                    *-- ccargs char(10) - cargo do usuario (SigCdUsu/SigCdCrg)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCargo = TratarNulo(ccargs, "")
                    ENDIF

                    *-- altcots char(1) = "S" - cargo pode alterar cotacao
                    IF TYPE(loc_cAlias + ".altcots") == "C"
                        THIS.this_lAltCots = (UPPER(ALLTRIM(TratarNulo(altcots, ""))) == "S")
                    ENDIF

                    *-- cotusus char(10) - usuario que autorizou a cotacao
                    IF TYPE(loc_cAlias + ".cotusus") == "C"
                        THIS.this_cUsuarioAutorizacao = TratarNulo(cotusus, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da cota" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPermissaoCargo - Init legado:
    *   poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],[Usuarios],
    *                         Padr(Alltrim(Usuar),10))
    *   Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *   (crSigCdCrg.AltCots = [S])
    *
    * O legado resolve em dois passos (cursor do usuario + Seek no cursor
    * global de cargos). Aqui vai num SELECT unico com LEFT JOIN, porque o
    * cursor global crSigCdCrg do Fortyus nao existe na arquitetura nova.
    * LEFT JOIN e nao INNER: usuario cujo cargo nao esteja em SigCdCrg tem
    * de cair em altcots vazio -> this_lAltCots = .F., que eh o resultado
    * do Seek falhando no legado, e NAO "usuario inexistente".
    *
    * Nomes de coluna conferidos em docs/schema.sql: SigCdUsu.usuarios,
    * SigCdUsu.ccargs, SigCdCrg.ccargs, SigCdCrg.altcots.
    *====================================================================
    PROCEDURE CarregarPermissaoCargo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lAltCots = .F.
        THIS.this_cCargo   = ""

        *-- Usuar do legado = usuario logado do sistema novo
        IF VARTYPE(par_cUsuario) = "C" AND !EMPTY(ALLTRIM(par_cUsuario))
            loc_cUsuarioPad = PADR(ALLTRIM(par_cUsuario), 10)
        ELSE
            loc_cUsuarioPad = PADR(ALLTRIM(IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "")), 10)
        ENDIF

        THIS.this_cUsuario = loc_cUsuarioPad

        TRY
            IF EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Permissao")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Permissao") > 1
                            TABLEREVERT(.T., "cursor_4c_Permissao")
                        ENDIF
                        USE IN cursor_4c_Permissao
                    ENDIF

                    loc_cSQL = "SELECT u.usuarios, u.ccargs, c.altcots" + ;
                               "  FROM SigCdUsu u" + ;
                               "  LEFT JOIN SigCdCrg c ON RTRIM(c.ccargs) = RTRIM(u.ccargs)" + ;
                               " WHERE u.usuarios = " + EscaparSQL(loc_cUsuarioPad)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Permissao")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Permissao") ;
                            AND RECCOUNT("cursor_4c_Permissao") > 0
                        SELECT cursor_4c_Permissao
                        GO TOP
                        *-- a leitura das colunas fica concentrada em CarregarDoCursor
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Permissao")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler a permiss" + CHR(227) + ;
                                "o do cargo."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a permiss" + CHR(227) + ;
                                "o do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + ;
                                "o cadastrado."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Permissao")
                        USE IN cursor_4c_Permissao
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - When da celula Cotacao do legado:
    *   poDataMgr.CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],TmpCot.CMoes)
    * Carrega this_cMoeda / this_cDescricaoMoeda / this_lMoedaCotada.
    *
    * Moeda inexistente devolve .F. com mensagem e this_lMoedaCotada
    * continua .F. - mesmo efeito do crSigCdMoe.Cotas vazio no legado.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro   = ""
        THIS.this_cMoeda          = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, "")), 3)
        THIS.this_cDescricaoMoeda = ""
        THIS.this_lMoedaCotada    = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o informada."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Moeda")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                            TABLEREVERT(.T., "cursor_4c_Moeda")
                        ENDIF
                        USE IN cursor_4c_Moeda
                    ENDIF

                    loc_cSQL = "SELECT cmoes, dmoes, cotas" + ;
                               "  FROM SigCdMoe" + ;
                               " WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") ;
                            AND RECCOUNT("cursor_4c_Moeda") > 0
                        SELECT cursor_4c_Moeda
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + ;
                                CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Moeda")
                        USE IN cursor_4c_Moeda
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - carga pela chave primaria de SigCdMoe (cmoes),
    * no contrato que os Forms do projeto esperam. Aqui eh sinonimo de
    * CarregarMoeda, porque a chave deste BO eh a propria moeda.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.CarregarMoeda(par_cCodigo)
    ENDPROC

    *====================================================================
    * PodeAlterarCotacao - When da celula Cotacao do legado, LITERAL:
    *   Return (Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *           (crSigCdCrg.AltCots = [S]) And crSigCdMoe.Cotas)
    *
    * Os TRES termos tem de valer: cargo achado, altcots = "S" e a moeda
    * da linha admitir cotacao manual. Resolve o que ainda nao estiver em
    * memoria (permissao do cargo e/ou moeda) antes de responder.
    *====================================================================
    PROCEDURE PodeAlterarCotacao(par_cMoeda)
        LOCAL loc_lPode, loc_cMoedaPed, loc_oErro
        loc_lPode = .F.

        TRY
            *-- 1o e 2o termos: cargo do usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuario)) OR EMPTY(ALLTRIM(THIS.this_cCargo))
                THIS.CarregarPermissaoCargo(THIS.this_cUsuario)
            ENDIF

            *-- 3o termo: a moeda da linha corrente
            loc_cMoedaPed = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, ;
                THIS.this_cMoeda)), 3)

            IF !EMPTY(ALLTRIM(loc_cMoedaPed))
                IF loc_cMoedaPed != PADR(ALLTRIM(THIS.this_cMoeda), 3) ;
                        OR EMPTY(ALLTRIM(THIS.this_cDescricaoMoeda))
                    THIS.CarregarMoeda(loc_cMoedaPed)
                ENDIF
            ENDIF

            loc_lPode = THIS.this_lAltCots AND THIS.this_lMoedaCotada
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lPode = .F.
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *====================================================================
    * ObterVisibilidadeBotaoCotacao - Init legado, transcrito LITERAL:
    *   btnCotacao.Visible = Not (Seek(...) And (AltCots = [S]) And
    *                             InList(ParentForm.pcEscolha,
    *                                    [INSERIR],[ALTERAR]))
    *
    * O NOT eh do legado e NAO eh descuido: quem JA pode digitar a cotacao
    * direto na grade nao precisa do botao; o botao existe para quem NAO
    * tem o altcots do cargo, e abre o dialogo SigOpAlC, onde outro usuario
    * autoriza a alteracao com usuario e senha.
    *
    * Observar que o legado usa aqui so os DOIS primeiros termos (cargo),
    * sem o crSigCdMoe.Cotas - este ultimo vale apenas para a digitacao na
    * celula. Nao acrescentar o termo da moeda.
    *====================================================================
    PROCEDURE ObterVisibilidadeBotaoCotacao(par_cEscolha)
        LOCAL loc_lVisivel, loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        loc_lVisivel = !(THIS.this_lAltCots AND INLIST(loc_cEscolha, "INSERIR", "ALTERAR"))

        RETURN loc_lVisivel
    ENDPROC

    *====================================================================
    * PodeUsarBotaoCotacao - When do btnCotacao legado:
    *   Return Inlist(ThisForm.ParentForm.pcEscolha,[INSERIR],[ALTERAR])
    * Em modo PROCURAR o botao fica desabilitado.
    *====================================================================
    PROCEDURE PodeUsarBotaoCotacao(par_cEscolha)
        LOCAL loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        RETURN INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    *====================================================================
    * PrepararCursorCotacao - Load do form legado, transcrito LITERAL:
    *   Set Decimals to 5
    *   Select TmpCot
    *   Delete All For Empty(CMoes)
    *   Replace All aValos With Valos
    *   Go Top
    *
    * Set Decimals to 5 porque a cotacao eh numeric(11,6) em SigCdCot.
    * O SET DELETED ON eh necessario: o legado roda em data session
    * compartilhada, onde vale o SET DELETED ON do config.prg; em data
    * session PRIVADA o SET volta ao default do VFP e as linhas apagadas
    * voltariam a aparecer na grade. O SET eh escopado a data session,
    * entao nao vaza para o resto do sistema.
    *====================================================================
    PROCEDURE PrepararCursorCotacao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                *-- Legado: Set Decimals to 5
                SET DECIMALS TO 5
                SET DELETED ON

                SELECT (loc_cAlias)

                *-- Legado: Delete All For Empty(CMoes) - descarta as linhas
                *-- em branco que o cursor do form pai tenha trazido
                IF TYPE(loc_cAlias + ".cmoes") == "C"
                    DELETE ALL FOR EMPTY(cmoes)
                ENDIF

                *-- Legado: Replace All aValos With Valos - copia de
                *-- seguranca para o Cancelar poder desfazer a edicao
                IF TYPE(loc_cAlias + ".avalos") == "N" AND TYPE(loc_cAlias + ".valos") == "N"
                    REPLACE ALL avalos WITH valos
                ENDIF

                *-- Legado: Go Top (a grade eh repintada pelo Form)
                GO TOP

                THIS.this_cCursorCotacao = loc_cAlias
                loc_lSucesso = THIS.CarregarDoCursor(loc_cAlias)

                *-- cursor valido e vazio nao eh erro: o documento pode nao
                *-- ter nenhuma moeda a cotar
                IF !loc_lSucesso AND RECCOUNT(loc_cAlias) = 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                    loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                    CHR(237) + "vel."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar o cursor de cota" + CHR(231) + CHR(245) + ;
                "es:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesfazerCotacoes - btnSair.Click do legado, transcrito LITERAL:
    *   Set Decimals To 2
    *   Replace All Valos With aValos
    *
    * Restaura TODAS as linhas ao valor que tinham quando o dialogo abriu.
    * Quem fecha a tela eh o Form (ThisForm.Release do legado).
    *====================================================================
    PROCEDURE DesfazerCotacoes(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            *-- Legado: Set Decimals To 2
            SET DECIMALS TO 2

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".valos") == "N" AND TYPE(loc_cAlias + ".avalos") == "N"
                    REPLACE ALL valos WITH avalos
                    GO TOP
                    THIS.this_nValorAtual = THIS.this_nValorAnterior
                ENDIF

                loc_lSucesso = .T.
            ELSE
                *-- sem cursor nao ha o que desfazer, e o Cancelar segue
                *-- fechando a tela, como no legado
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desfazer as cota" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AplicarCotacaoAutorizada - btnCotacao.Click do legado, LITERAL:
    *   Do Form SigOpAlC With TmpCot.CMoes, TmpCot.Valos, ThisForm.dDatas
    *                    To lcRetorno
    *   If (MLine(lcRetorno, 1) = [OK])
    *       Replace Valos With Val(MLine(lcRetorno, 2)) In TmpCot
    *       If Used([TprMvCab])
    *           Replace CotUsus With MLine(lcRetorno, 3) In TprMvCab
    *       EndIf
    *   EndIf
    *
    * Quem abre o dialogo FormSigOpAlC eh o Form; aqui entra o retorno
    * dele ("OK" + CHR(13) + valor + CHR(13) + usuario, ou "CANCELADO").
    *
    * REPLACE sem ALL de proposito: o legado grava SO a linha corrente do
    * cursor de cotacao (a moeda que o usuario escolheu), e o cotusus vai
    * para a linha corrente do cabecalho do documento.
    *
    * Retorno .F. com this_cMensagemErro VAZIO significa CANCELADO pelo
    * usuario - nao eh falha, e o Form nao exibe erro nesse caso.
    *====================================================================
    PROCEDURE AplicarCotacaoAutorizada(par_cRetorno, par_cAliasCursor, par_cAliasCabecalho)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasCab, loc_cRetorno
        LOCAL loc_nCotacao, loc_cUsuarioAut, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        loc_cRetorno = IIF(VARTYPE(par_cRetorno) = "C", par_cRetorno, "")

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        IF VARTYPE(par_cAliasCabecalho) = "C" AND !EMPTY(ALLTRIM(par_cAliasCabecalho))
            loc_cAliasCab = ALLTRIM(par_cAliasCabecalho)
        ELSE
            loc_cAliasCab = ALLTRIM(THIS.this_cCursorCabecalho)
        ENDIF

        TRY
            *-- Legado: If (MLine(lcRetorno, 1) = [OK])
            IF ALLTRIM(MLINE(loc_cRetorno, 1)) == "OK"
                *-- Legado: Val(MLine(lcRetorno, 2)) / MLine(lcRetorno, 3)
                loc_nCotacao    = VAL(ALLTRIM(MLINE(loc_cRetorno, 2)))
                loc_cUsuarioAut = PADR(ALLTRIM(MLINE(loc_cRetorno, 3)), 10)

                IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                    SELECT (loc_cAlias)

                    IF !EOF(loc_cAlias) AND TYPE(loc_cAlias + ".valos") == "N"
                        *-- Legado: Replace Valos With ... In TmpCot
                        REPLACE valos WITH loc_nCotacao IN (loc_cAlias)
                        THIS.this_nValorAtual = loc_nCotacao
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " linha de cota" + CHR(231) + CHR(227) + "o selecionada."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                        loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                        CHR(237) + "vel."
                ENDIF

                *-- Legado: If Used([TprMvCab]) / Replace CotUsus With ...
                *-- SigMvCab.cotusus char(10) - usuario que autorizou
                IF loc_lSucesso AND !EMPTY(loc_cAliasCab) AND USED(loc_cAliasCab)
                    IF TYPE(loc_cAliasCab + ".cotusus") == "C"
                        REPLACE cotusus WITH loc_cUsuarioAut IN (loc_cAliasCab)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUsuarioAutorizacao = loc_cUsuarioAut
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao aplicar a cota" + CHR(231) + CHR(227) + ;
                "o autorizada:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * RegistrarCelulaCorrente - When da celula Cotacao do legado:
    *   ThisForm.AntValue = This.Value
    * Guarda o valor que a celula tinha ao receber o foco, para a
    * comparacao antes/depois da digitacao.
    *====================================================================
    PROCEDURE RegistrarCelulaCorrente(par_nValor)
        IF VARTYPE(par_nValor) = "N"
            THIS.this_nAntValue = par_nValor
        ELSE
            THIS.this_nAntValue = THIS.this_nValorAtual
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes), usada pelo
    * RegistrarAuditoria herdado de BusinessBase.
    *
    * PROTECTED porque a BusinessBase declara assim: o modificador da
    * classe base PREVALECE, e chamar de fora estouraria "Property not
    * found" em runtime.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDPROC

    *====================================================================
    * LimparDados - devolve o BO ao estado inicial, preservando os alias
    * de cursor que o form pai configurou
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cMoeda              = ""
        THIS.this_cDescricaoMoeda     = ""
        THIS.this_lMoedaCotada        = .F.
        THIS.this_nValorAtual         = 0
        THIS.this_nValorAnterior      = 0
        THIS.this_nAntValue           = 0
        THIS.this_cUsuarioAutorizacao = ""
        THIS.this_cMensagemErro       = ""

        RETURN .T.
    ENDPROC

ENDDEFINE


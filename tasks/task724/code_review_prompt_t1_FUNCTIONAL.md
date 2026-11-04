# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeSubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeSubN.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDpe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2317 linhas total):

*-- Linhas 65 a 128:
65: * pelo contrato Salvar() da BusinessBase.
66: *
67: * Fase 3/8 (concluida) - estrutura base do Form: DEFINE CLASS + propriedades
68: * visuais do dump, Init completo (contexto do pai + BO + InicializarForm),
69: * cabecalho cinza (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
70: *
71: * Fase 4/8 (concluida) - corpo da tela: Shape1 decorativo, a grade de 3
72: * colunas (GradeSubN -> grd_4c_Dados) com o bind do cursor, e os DOIS
73: * botoes do dump (cmdExcluir -> cmd_4c_Excluir, cmdSair -> cmd_4c_Encerrar)
74: * com os Click transcritos do legado. SigOpDpeBO.prg ganhou o cursor
75: * READWRITE da grade (this_cCursorDados), CarregarFaixas/InserirLinhaCursor/
76: * ExcluirLinhaCursor/GravarFaixas (lote transacional, mesmo padrao de
77: * SigOpCrdBO.prg) - ver NOTAS DE ARQUITETURA abaixo.
78: *
79: * Fase 5/8 (concluida) - os dois LostFocus de celula do dump (Column2 "Qtd
80: * Dias Final" / Column3 "%") via TextBoxCelulaSigOpDpe_4c, com ValidarQtddFinal/
81: * ValidarPercs e a guarda de reentrancia this_lEmCelula.
82: *
83: * Fase 6/8 (concluida) - CONFERENCIA DE COMPLETUDE: o dump de
84: * SIGOPDPE tem 16 objetos e 7 metodos/eventos com codigo (ver
85: * tasks\task724\SigOpDpe_form_codigo_fonte.txt e comportamento.json), e TODOS
86: * ja estavam cobertos ao final da Fase 5 - este form NAO tem Page2/aba de
87: * Dados, NAO tem campo solto nenhum fora da grade, e NAO tem lookup algum
88: * (fwBuscaExt/fwBuscaSel/sigacess/FormBuscaAuxiliar nao aparecem no dump nem
89: * em comportamento.json). "Campos Restantes e Lookups" desta fase, portanto,
90: * eh o conjunto VAZIO - acrescentar qualquer coisa aqui violaria a regra
91: * "NUNCA inventar" (PILAR 1). O unico item em aberto era de DOCUMENTACAO, resolvido
92: * nesta fase: ver o paragrafo sobre Load/fConfigGeral abaixo.
93: *
94: * Fase 7/8 (concluida, 2026-10-31) - CONFERENCIA DOS "EVENTOS PRINCIPAIS DOS
95: * BOTOES": o SCX legado declara exatamente DOIS CommandButton
96: * (cmdExcluir / cmdSair) - NAO ha frmcadastro, NAO ha Grupo_Op, NAO ha
97: * pcEscolha decidindo o proprio modo, e os quatro verbos
98: * Incluir/Alterar/Visualizar/Excluir do padrao CRUD NAO aparecem juntos em
99: * lugar nenhum do dump (so "Excluir" existe, e sozinho ele eh o verbo
100: * AMBIGUO compartilhado pela barra CRUD e pela toolbar de LINHA de grade -
101: * aqui ele apaga a linha do cursor_4c_Dados, nao um registro do servidor).
102: * Esta tela eh, portanto, um dialogo-filho SEM superficie CRUD, com piso de
103: * 2 handlers reais provados pelo dump (2 CommandButton soltos, sem
104: * CommandGroup) - e os DOIS ja existem desde a Fase 4:
105: *
106: *    cmdExcluir -> CmdExcluirClick()   (ExcluirLinhaCursor + this_lHouveExcl)
107: *    cmdSair    -> CmdEncerrarClick()  (GravarFaixas + ReabilitarFormPai + Release)
108: *
109: * Gerar BtnIncluirClick()/BtnAlterarClick()/BtnVisualizarClick()/
110: * BtnExcluirClick() (os quatro nomes do template generico de fase, pensado
111: * para forms CRUD de frmcadastro) inventaria botoes e comportamento que o
112: * legado nunca teve - PROIBIDO pelo PILAR 1 e pela regra de completude
113: * ("NUNCA criar stub disfarcado"). Aquela fase, portanto, nao acrescentou
114: * codigo: confirmou que a entrega ja satisfazia o deliverable.
115: *
116: * Fase 8/8 (esta fase, 2026-10-31) - CONSOLIDACAO FINAL. Acrescenta os hooks
117: * canonicos de transferencia e de estado, no MESMO desenho ja revisado do
118: * dialogo-irmao FormSigOpCrd.prg (mesmo form pai, mesma estrutura), adaptado
119: * as TRES colunas desta grade (qtddis / qtddfs / percs):
120: *
121: *    BtnEncerrarClick        alias fino -> CmdEncerrarClick (nome que o teste
122: *                            'BtnEncerrarExiste' da etapa 06b procura)
123: *    FormParaBO   PROTECTED  flush da celula em edicao + linha -> BO
124: *    BOParaForm   PROTECTED  BO -> linha corrente (com guarda de identidade)
125: *    HabilitarCampos         abre/fecha a digitacao na grade (3 colunas)
126: *    LimparCampos PROTECTED  zera a linha corrente compondo os dois hooks
127: *    AtualizarEstadoControles  override do hook que FormBase.Init() chama no
128: *                            fim (na base ele eh vazio e presume form CRUD)

*-- Linhas 148 a 203:
148: *
149: * MEDIDO nesta fase, nao deduzido: os dois arquivos COMPILAM limpos no VFP9
150: * (zero erro, sem .err gerado) e o form INSTANCIA com os metodos novos
151: * rodando dentro do InicializarForm - ver automation\Probe724F8.prg e
152: * automation\probe_724f8.txt.
153: *
154: *------------------------------------------------------------------------------
155: * PENDENCIA CONHECIDA, FORA DO ESCOPO DESTA TASK
156: *
157: * Nada no projeto AINDA ABRE este dialogo: o botao que o chamaria eh o
158: * "Depreciacao" do cadastro de Tipos de Operacao, e FormOPE.BtnDepreciaClick
159: * eh um dos 19 stubs da "Fase B" daquele form (MsgAviso "Em
160: * desenvolvimento"). A ligacao, quando feita, eh
161: *     GarantirClasse("FormSigOpDpe")  NAO eh necessario - o indice de
162: *     classes resolve a dependencia de CREATEOBJECT literal dentro de Form -
163: *     e o contrato eh CREATEOBJECT("FormSigOpDpe", THIS, <Dopes da linha
164: *     corrente>, THIS.this_cModoAtual) seguido de .Show().
165: * Os dialogos-irmaos (SigOpCrd, SigOpCcl, SigOpDoc) estao na MESMA situacao,
166: * o que confirma ser pendencia da Fase B do FormOPE e nao desta migracao.
167: *
168: *------------------------------------------------------------------------------
169: * NOTAS DE ARQUITETURA (PILAR 3 - o que muda de proposito)
170: *
171: * DataSession = 2 fica DECLARADO (transcricao do dump), mas o acoplamento
172: * por "Set DataSession to pnDataSes" do legado NAO eh reproduzido: o BO
173: * (SigOpDpeBO) abre seu PROPRIO cursor via SQLEXEC nesta mesma datasession
174: * privada, entao nao ha necessidade de entrar na datasession do pai para
175: * ler crSigCdOpe.Dopes - o valor chega pronto pelo parametro par_cOperacao.
176: *
177: * this_lHouveIns/this_lHouveExcl (Thisform.lHouveIns/lHouveExcl do legado)
178: * ficam declarados no FORM, e nao no BO (ao contrario de SigOpCrdBO, que
179: * move o marcador equivalente para o BO): o dump de SIGOPDPE (RESERVED3 -
180: * ClassInfo) lista lhouveexcl/lhouveins como custom property de SIGOPDPE,
181: * ou seja, no legado elas JA SAO properties do FORM. O BO so manipula o
182: * CURSOR (InserirLinhaCursor/ExcluirLinhaCursor, sem flag); quem liga os
183: * marcadores eh o FORM (InserirLinhaCursor/CmdExcluirClick), e o guard "If
184: * (Thisform.lHouveExcl Or Thisform.lHouveIns)" do cmdSair.Click legado fica
185: * no CmdEncerrarClick do form, nao dentro de GravarFaixas.
186: *
187: * SIGOPDPE.Load (=fConfigGeral()) NAO eh reproduzido neste arquivo - mesma
188: * decisao do dialogo-irmao FormSigOpCrd.prg (e do FormSigOpCcl.prg). No
189: * legado fConfigGeral era funcao GLOBAL da aplicacao Fortyus (sig.prg /
190: * SIGFUNCS.PRG), cujo fonte nao veio no acervo migrado; o wrapper
191: * projeto\app\utils\fconfiggeral.prg existe so para o p-code JA COMPILADO dos
192: * VCX legado (frmceps/fwcep/frmprod/frmcadastro/frmrelatorio) continuar
193: * resolvendo o nome sem estourar "File 'fconfiggeral.prg' does not exist" -
194: * CLAUDE.md regra #2 proibe CODIGO NOSSO chamar esse wrapper. O que
195: * fConfigGeral fazia no legado (configuracao global) ja esta distribuido na
196: * arquitetura nova: config.prg (SETs/paths/aliases), main.prg (conexao) e o
197: * proprio SigOpDpeBO.Init (contexto da operacao + permissao de exclusao).
198: *==============================================================================
199: 
200: DEFINE CLASS FormSigOpDpe AS FormBase
201: 
202:     *==========================================================================
203:     * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX

*-- Linhas 216 a 259:
216:     * property de runtime da classe Form (regra #33).
217:     *
218:     * WindowType / ShowWindow NAO vem do SCX: o legado abria com "Do Form" e
219:     * o default 0 (modeless) bastava. Aqui o form eh criado com CREATEOBJECT +
220:     * Show() e o canonico do projeto eh 1 (modal) - transcrever a ausencia
221:     * destruiria a tela no retorno do Show() (regra: WindowType 0 mata a
222:     * tela). Modal ainda reforca o ParentForm.Enabled = .F. do legado.
223:     *
224:     * AutoCenter = .T. no lugar do calculo de Top/Left relativo ao
225:     * ParentForm.Pagina.Lista.Grade do legado - mesma simplificacao ja
226:     * adotada em FormSigOpCrd.prg (dialogo-irmao, mesmo form pai).
227:     *==========================================================================
228:     this_cMensagemErro = ""
229:     DataSession  = 2
230:     BorderStyle  = 2
231:     Height       = 349
232:     Width        = 600
233:     ControlBox   = .F.
234:     MaxButton    = .F.
235:     ClipControls = .F.
236:     TitleBar     = 0
237:     FontName     = "Verdana"
238:     FontSize     = 8
239: 
240:     *-- ForeColor = 36,84,155 do dump. O bloco de comentario acima ja o
241:     *-- listava como transcrito, mas a atribuicao nunca foi gerada - o
242:     *-- comentario afirmava um valor que o codigo nao tinha.
243:     *-- Form TEM ForeColor (conferido em
244:     *-- automation\propriedades_baseclasses.txt - regra #33), logo nao eh
245:     *-- propriedade so de design-time como o DoCreate: entra por PILAR 1.
246:     *-- Em VFP a ForeColor do Form eh o valor herdado pelo filho que nao
247:     *-- declara a sua; QUAIS filhos desta tela mudam de cor com isso NAO
248:     *-- foi medido (vfp9.exe nesta maquina compila e sai sem executar),
249:     *-- entao o criterio aqui eh so a fidelidade ao dump, nao um efeito
250:     *-- visual previsto. Conferir ao instanciar a tela no VFP9.
251:     ForeColor    = RGB(36, 84, 155)
252:     WindowType   = 1
253:     ShowWindow   = 1
254:     AutoCenter   = .T.
255: 
256:     *-- Caption de projeto do SCX. O Init a substitui pelo titulo dinamico
257:     *-- 'Tabela de Depreciacao da Operacao <Dopes>', como o legado faz.
258:     Caption = "Tabela de Deprecia" + CHR(231) + CHR(227) + "o"
259: 

*-- Linhas 293 a 659:
293:     * Init - recebe o contexto do form PAI
294:     *
295:     * A ORDEM aqui eh regra, nao estilo: FormBase.Init() chama
296:     * InicializarForm(), logo todo contexto vindo por parametro tem de estar
297:     * guardado ANTES do DODEFAULT() - senao InicializarForm instancia o BO
298:     * sem saber qual eh a operacao.
299:     *
300:     * par_oFormPai   - form que abriu o dialogo (ParentForm do legado)
301:     * par_cOperacao  - Dopes da operacao; se ausente, tenta ler do pai
302:     * par_cEscolha   - PcEscolha; se ausente, tenta ler do pai (default INSERIR)
303:     *==========================================================================
304:     PROCEDURE Init(par_oFormPai, par_cOperacao, par_cEscolha)
305:         *-- Form pai
306:         IF VARTYPE(par_oFormPai) = "O"
307:             THIS.this_oFormPai = par_oFormPai
308:         ENDIF
309: 
310:         *-- Operacao dona das faixas
311:         IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(ALLTRIM(par_cOperacao))
312:             THIS.this_cOperacao = ALLTRIM(par_cOperacao)
313:         ENDIF
314: 
315:         *-- Modo de edicao
316:         IF VARTYPE(par_cEscolha) = "C" AND !EMPTY(ALLTRIM(par_cEscolha))
317:             THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
318:         ENDIF
319: 
320:         *-- O que nao veio por parametro, buscar no pai (legado le
321:         *-- poForm.PcEscolha). So agora, para o parametro ter precedencia.
322:         THIS.ResolverContextoDoPai()
323: 
324:         RETURN DODEFAULT()
325:     ENDPROC
326: 
327: 
328:     *==========================================================================
329:     * ResolverContextoDoPai - completa operacao/modo a partir do form pai
330:     *
331:     * Transcreve o Thisform.PcEscolha = IIF(EMPTY(poForm.PcEscolha), "INSERIR",
332:     * poForm.PcEscolha) do legado, mas sem presumir COMO o pai se chama: o
333:     * PILAR 3 renomeia os objetos, entao as properties do pai migrado podem
334:     * ter nome diferente. Cada leitura eh guardada por PEMSTATUS/TYPE e a
335:     * ausencia simplesmente mantem o default - nunca estoura.
336:     *==========================================================================
337:     PROCEDURE ResolverContextoDoPai()
338:         LOCAL loc_cValor
339: 
340:         IF VARTYPE(THIS.this_oFormPai) != "O"
341:             RETURN .F.
342:         ENDIF
343: 
344:         *-- Modo de edicao (PcEscolha / this_cEscolha / this_cModoAtual)
345:         IF EMPTY(ALLTRIM(THIS.this_cEscolha))
346:             loc_cValor = THIS.LerTextoDoPai("this_cEscolha")
347:             IF EMPTY(loc_cValor)
348:                 loc_cValor = THIS.LerTextoDoPai("PcEscolha")
349:             ENDIF
350:             IF EMPTY(loc_cValor)
351:                 loc_cValor = THIS.LerTextoDoPai("this_cModoAtual")
352:             ENDIF
353:             THIS.this_cEscolha = IIF(EMPTY(loc_cValor), "INSERIR", UPPER(loc_cValor))
354:         ENDIF
355: 
356:         *-- Operacao dona (Dopes). O pai eh o cadastro de SigCdOpe, cuja
357:         *-- chave eh a propria descricao da operacao.
358:         IF EMPTY(ALLTRIM(THIS.this_cOperacao))
359:             loc_cValor = THIS.LerTextoDoPai("this_cDopes")
360:             IF EMPTY(loc_cValor)
361:                 loc_cValor = THIS.LerTextoDoPai("this_cOperacao")
362:             ENDIF
363:             THIS.this_cOperacao = loc_cValor
364:         ENDIF
365: 
366:         RETURN .T.
367:     ENDPROC
368: 
369: 
370:     *==========================================================================
371:     * LerTextoDoPai - leitura DEFENSIVA de uma property texto do form pai
372:     *
373:     * PEMSTATUS confere a existencia e TYPE() o tipo antes de ler: property
374:     * ausente devolve string vazia em vez de derrubar o Init do dialogo.
375:     * O acesso por NOME usa EVALUATE - nunca Controls(<nome>), que eh
376:     * indexado por NUMERO (regra #34).
377:     *
378:     * Sem TRY/CATCH de proposito: os tres guards (VARTYPE do pai, PEMSTATUS
379:     * da property e TYPE da expressao) ja cobrem ausencia e referencia morta,
380:     * e um CATCH aqui seria silencioso - engolir erro sem avisar eh proibido
381:     * (regra #9).
382:     *==========================================================================
383:     PROCEDURE LerTextoDoPai(par_cProperty)
384:         LOCAL loc_cRetorno, loc_cExpr
385: 
386:         loc_cRetorno = ""
387: 
388:         IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
389:             RETURN ""
390:         ENDIF
391: 
392:         IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
393:             loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
394:             IF TYPE(loc_cExpr) = "C"
395:                 loc_cRetorno = ALLTRIM(NVL(EVALUATE(loc_cExpr), ""))
396:             ENDIF
397:         ENDIF
398: 
399:         RETURN loc_cRetorno
400:     ENDPROC
401: 
402: 
403:     *==========================================================================
404:     * ValidarParametros - pre-requisitos ANTES de montar a tela
405:     *
406:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
407:     * FORA da classe, e PROTECTED falharia com "Property ... is not found"
408:     * (regra #3).
409:     *
410:     * O bypass de teste vem no TOPO porque o TesteAutomatico.prg NAO conecta
411:     * ao SQL Server - ele define gnConnHandle = 0 como SENTINELA e espera que
412:     * os forms pulem a checagem por gb_4c_ModoTeste / gb_4c_ValidandoUI. Sem
413:     * esse bypass a instanciacao reprovaria SEMPRE, com uma MsgErro de conexao
414:     * que nao corresponde a nenhuma falha real de rede.
415:     *==========================================================================
416:     PROCEDURE ValidarParametros()
417:         LOCAL loc_lValido
418: 
419:         THIS.this_cMotivoBloqueio = ""
420: 
421:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
422:             RETURN .T.
423:         ENDIF
424:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
425:             RETURN .T.
426:         ENDIF
427: 
428:         loc_lValido = .T.
429: 
430:         DO CASE
431:             CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
432:                 THIS.this_cMotivoBloqueio = "Imposs" + CHR(237) + "vel efetuar conex" + ;
433:                     CHR(227) + "o com o servidor de banco de dados."
434:                 loc_lValido = .F.
435: 
436:             CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
437:                 *-- Sem a operacao dona nao ha faixa a editar: o legado lia
438:                 *-- crSigCdOpe.Dopes da datasession do pai e sem isso o
439:                 *-- Insert Into SigOpDup (Dopes, ...) gravaria orfao.
440:                 THIS.this_cMotivoBloqueio = "Opera" + CHR(231) + CHR(227) + ;
441:                     "o inv" + CHR(225) + "lida. Selecione a opera" + CHR(231) + CHR(227) + ;
442:                     "o antes de editar a tabela de deprecia" + CHR(231) + CHR(227) + "o."
443:                 loc_lValido = .F.
444:         ENDCASE
445: 
446:         IF !loc_lValido
447:             MsgAviso(THIS.this_cMotivoBloqueio, "Aten" + CHR(231) + CHR(227) + "o")
448:         ENDIF
449: 
450:         RETURN loc_lValido
451:     ENDPROC
452: 
453: 
454:     *==========================================================================
455:     * InicializarForm - monta a estrutura base do dialogo
456:     *
457:     * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
458:     * TRY/CATCH).
459:     *==========================================================================
460:     PROTECTED PROCEDURE InicializarForm()
461:         LOCAL loc_lSucesso, loc_oErro
462: 
463:         *-- Pre-requisitos primeiro: sem eles nao vale montar tela nenhuma
464:         IF !THIS.ValidarParametros()
465:             RETURN .F.
466:         ENDIF
467: 
468:         loc_lSucesso = .F.
469: 
470:         TRY
471:             *-- Datasession privada (DataSession = 2) nasce com os SETs no
472:             *-- DEFAULT do VFP: o SET DELETED ON / SET EXACT ON do config.prg
473:             *-- ficou na sessao 1 e NAO eh herdado. FormBase.Init() repoe so
474:             *-- DATE/CENTURY. Repor os dois aqui garante o mesmo efeito do
475:             *-- SET DELETED ON global quando a grade (Fase 4) fizer DELETE
476:             *-- local na linha.
477:             SET DELETED ON
478:             SET EXACT ON
479: 
480:             *-- Business Object, com o contexto recebido do pai (operacao +
481:             *-- modo de edicao) - Fase 1/2 (CRUD por linha) + Fase 4 (cursor
482:             *-- da grade e gravacao em lote)
483:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpDpeBO", ;
484:                                                      THIS.this_cOperacao, ;
485:                                                      THIS.this_cEscolha)
486: 
487:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
488:                 *-- Titulo dinamico, como o legado:
489:                 *-- 'Tabela de Depreciacao da Operacao ' + AllTrim(Proper(Dopes))
490:                 THIS.AjustarCaption()
491: 
492:                 *-- Aparencia base do form (fundo)
493:                 THIS.ConfigurarPageFrame()
494: 
495:                 *-- Cabecalho cinza (cntSombra do legado)
496:                 THIS.ConfigurarCabecalho()
497: 
498:                 *-- Shape decorativo, grade de 3 colunas e os dois botoes.
499:                 *-- DEPOIS do cabecalho de proposito: os botoes ficam em
500:                 *-- Top = 3..78, DENTRO da faixa (Top = 0..80), e so aparecem
501:                 *-- se criados depois dela (regra #11).
502:                 THIS.ConfigurarPaginaLista()
503: 
504:                 *-- Ordem de tabulacao: SO AQUI, depois do ULTIMO AddObject.
505:                 *-- Cada AddObject renumera o TabIndex dos irmaos pela ordem
506:                 *-- de criacao, entao atribuir no meio da montagem eh
507:                 *-- desfeito pelos objetos seguintes.
508:                 THIS.ConfigurarPaginaDados()
509: 
510:                 *-- Desabilita o pai (ParentForm.Enabled = .F. do legado)
511:                 THIS.DesabilitarFormPai()
512: 
513:                 *-- AddObject cria tudo com Visible = .F.
514:                 THIS.TornarControlesVisiveis()
515: 
516:                 *-- Carga e bind da grade: so AQUI, nunca em
517:                 *-- ConfigurarPaginaLista. Column.ControlSource exige o cursor
518:                 *-- JA ABERTO, e quando a grade eh criada nao existe cursor
519:                 *-- nenhum - atribuir ali estoura "Alias ... is not found"
520:                 *-- dentro deste TRY, InicializarForm devolve .F. e a tela nao
521:                 *-- abre, sem erro visivel (regra #41).
522:                 THIS.CarregarLista()
523: 
524:                 *-- POR ULTIMO: TornarControlesVisiveis acabou de forcar
525:                 *-- Visible = .T. em cada controle, inclusive no Excluir que o
526:                 *-- legado ESCONDE quando o usuario nao tem acesso. Ajustar
527:                 *-- antes dele seria simplesmente apagado.
528:                 THIS.AjustarBotoesPorModo()
529: 
530:                 loc_lSucesso = .T.
531:             ELSE
532:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
533:                         "vel criar o objeto de neg" + CHR(243) + "cio SigOpDpeBO.", ;
534:                         "Erro ao Inicializar")
535:             ENDIF
536: 
537:         CATCH TO loc_oErro
538:             THIS.this_cMensagemErro = loc_oErro.Message
539:             MsgErro(loc_oErro.Message + ;
540:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
541:                     " | Proc: " + loc_oErro.Procedure, ;
542:                     "Erro ao inicializar FormSigOpDpe")
543:             loc_lSucesso = .F.
544:         ENDTRY
545: 
546:         RETURN loc_lSucesso
547:     ENDPROC
548: 
549: 
550:     *==========================================================================
551:     * AjustarCaption - titulo dinamico da tela e dos labels do cabecalho
552:     *
553:     * Legado: .Caption = 'Tabela de Depreciacao da Operacao ' + ;
554:     *                    AllTrim(Proper(crSigCdOpe.Dopes))
555:     *         ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
556:     *         ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
557:     *
558:     * Sem operacao no contexto o Caption de projeto do SCX eh preservado, para
559:     * a tela nunca exibir "... da Operacao" com o nome em branco.
560:     *==========================================================================
561:     PROCEDURE AjustarCaption()
562:         LOCAL loc_cOperacao
563: 
564:         loc_cOperacao = ALLTRIM(NVL(THIS.this_cOperacao, ""))
565: 
566:         IF !EMPTY(loc_cOperacao)
567:             THIS.Caption = "Tabela de Deprecia" + CHR(231) + CHR(227) + "o da Opera" + ;
568:                            CHR(231) + CHR(227) + "o " + ALLTRIM(PROPER(loc_cOperacao))
569:         ENDIF
570: 
571:         THIS.this_cTituloForm = THIS.Caption
572: 
573:         RETURN .T.
574:     ENDPROC
575: 
576: 
577:     *==========================================================================
578:     * ConfigurarPageFrame - aparencia base do form
579:     *
580:     * O nome eh o do contrato do pipeline; NAO ha PageFrame a criar porque o
581:     * SCX legado NAO tem Page nenhuma (layout FLAT - ver cabecalho). Inventar
582:     * um PageFrame de duas paginas violaria o PILAR 1 e a regra "NUNCA
583:     * inventar". O que este metodo faz eh o que de fato existe no dump: o
584:     * fundo do form.
585:     *
586:     * Picture = ..\framework\imagens\new_background.jpg no dump. O caminho
587:     * NUNCA se reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o
588:     * arquivo existe tanto em vbmp\ quanto em Framework\imagens\ e o canonico
589:     * do projeto eh gc_4c_CaminhoIcones. Picture inexistente falha em SILENCIO
590:     * (regra #25), por isso o nome eh transcrito do dump e nao chutado.
591:     *==========================================================================
592:     PROTECTED PROCEDURE ConfigurarPageFrame()
593:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
594:         THIS.ScrollBars = 0
595: 
596:         RETURN .T.
597:     ENDPROC
598: 
599: 
600:     *==========================================================================
601:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
602:     *
603:     * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
604:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
605:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
606:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
607:     *
608:     * As larguras 800/769 do dump sao MAIORES que o form (600): artefato do
609:     * Form Designer, que desenhou o container 200px alem da borda direita.
610:     * Aplicar os literais faria o titulo (Tahoma 18 bold) ser RECORTADO pelo
611:     * pai sem erro nenhum (regra #30). Container acompanha THIS.Width e os
612:     * labels ficam 20px menores para nao extrapolar o container - mesma
613:     * decisao ja aplicada em FormSigOpCrd.prg (dialogo-irmao).
614:     *
615:     * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
616:     * O cabecalho eh o PRIMEIRO AddObject da tela (regra #11), para que a
617:     * grade e os botoes criados na Fase 4 desenhem POR CIMA dele.
618:     *==========================================================================
619:     PROTECTED PROCEDURE ConfigurarCabecalho()
620:         THIS.AddObject("cnt_4c_Sombra", "Container")
621:         WITH THIS.cnt_4c_Sombra
622:             .Top           = 0
623:             .Left          = 0
624:             .Width         = THIS.Width
625:             .Height        = 80
626:             .BorderWidth   = 0
627:             .BackStyle     = 1
628:             .BackColor     = RGB(100, 100, 100)
629:             .SpecialEffect = 0
630:             .Visible       = .T.
631:         ENDWITH
632: 
633:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
634:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
635:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
636:             *-- AutoSize = .F. explicito: AutoSize eh NO-OP em Label criado
637:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
638:             *-- corta o texto (regra #23).
639:             .AutoSize      = .F.
640:             .FontName      = "Tahoma"
641:             .FontSize      = 18
642:             .FontBold      = .T.
643:             .FontUnderline = .F.
644:             .WordWrap      = .T.
645:             .Alignment     = 0
646:             .BackStyle     = 0
647:             .Caption       = THIS.Caption
648:             .Top           = 18
649:             .Left          = 10
650:             .Width         = THIS.Width - 20
651:             .Height        = 40
652:             .ForeColor     = RGB(0, 0, 0)
653:             *-- Rotation = 0 do dump - default, atribuicao inerte, transcrita
654:             *-- por fidelidade literal (regra #49: diferente de override vazio).
655:             .Rotation      = 0
656:             .Visible       = .T.
657:         ENDWITH
658: 
659:         *-- Label do titulo: branco sobre o cinza do container OPACO - este eh

*-- Linhas 685 a 962:
685:     *==========================================================================
686:     * DesabilitarFormPai - ParentForm.Enabled = .F. do legado
687:     *==========================================================================
688:     PROCEDURE DesabilitarFormPai()
689:         LOCAL loc_oErro
690: 
691:         IF VARTYPE(THIS.this_oFormPai) != "O"
692:             RETURN .F.
693:         ENDIF
694: 
695:         TRY
696:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
697:                 IF THIS.this_oFormPai.Enabled
698:                     THIS.this_oFormPai.Enabled = .F.
699:                     *-- Marca que o bloqueio eh NOSSO: so assim a reabilitacao
700:                     *-- pode acontecer sem risco de reabilitar um form que ja
701:                     *-- estava desabilitado por outro motivo.
702:                     THIS.this_lPaiDesabilitado = .T.
703:                 ENDIF
704:             ENDIF
705:         CATCH TO loc_oErro
706:             MsgErro(loc_oErro.Message, "FormSigOpDpe.DesabilitarFormPai")
707:         ENDTRY
708: 
709:         RETURN THIS.this_lPaiDesabilitado
710:     ENDPROC
711: 
712: 
713:     *==========================================================================
714:     * ReabilitarFormPai - ParentForm.Enabled = .T. do legado
715:     *
716:     * IDEMPOTENTE e chamado pelo FUNIL de volta (aqui o Destroy; na fase do
717:     * botao Encerrar, tambem o cmdSair). Dialogo sem barra de titulo ainda
718:     * fecha por Alt+F4 - se a reabilitacao morasse so no botao, esse caminho
719:     * deixaria o cadastro de Operacoes desabilitado para sempre.
720:     *==========================================================================
721:     PROCEDURE ReabilitarFormPai()
722:         LOCAL loc_oErro
723: 
724:         IF !THIS.this_lPaiDesabilitado OR VARTYPE(THIS.this_oFormPai) != "O"
725:             RETURN .F.
726:         ENDIF
727: 
728:         TRY
729:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
730:                 THIS.this_oFormPai.Enabled = .T.
731:             ENDIF
732:         CATCH TO loc_oErro
733:             *-- O guard de VARTYPE acima ja absorve o caso NORMAL de o pai ter
734:             *-- sido liberado antes, entao chegar aqui eh de fato inesperado -
735:             *-- e a consequencia eh grave: o cadastro de Operacoes continuaria
736:             *-- desabilitado e o usuario ficaria preso. Por isso avisa em vez
737:             *-- de engolir (regra #9).
738:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
739:                     loc_oErro.Message, "FormSigOpDpe.ReabilitarFormPai")
740:         ENDTRY
741: 
742:         *-- Marcador cai nos dois caminhos, para o Destroy nao repetir a
743:         *-- tentativa (e, no caminho de erro, nao repetir o aviso).
744:         THIS.this_lPaiDesabilitado = .F.
745: 
746:         RETURN .T.
747:     ENDPROC
748: 
749: 
750:     *==========================================================================
751:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
752:     *
753:     * Percorre Controls do form e dos containers. Esta tela NAO tem container
754:     * flutuante (painel que nasce oculto e eh alternado por botao), entao nao
755:     * ha lista de excecao a manter aqui.
756:     *==========================================================================
757:     PROTECTED PROCEDURE TornarControlesVisiveis()
758:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
759: 
760:         FOR loc_nI = 1 TO THIS.ControlCount
761:             loc_oControle = THIS.Controls(loc_nI)
762: 
763:             IF VARTYPE(loc_oControle) = "O"
764:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
765:                     loc_oControle.Visible = .T.
766:                 ENDIF
767: 
768:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
769:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
770:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
771:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
772:                             loc_oFilho.Visible = .T.
773:                         ENDIF
774:                     ENDFOR
775:                 ENDIF
776:             ENDIF
777:         ENDFOR
778: 
779:         RETURN .T.
780:     ENDPROC
781: 
782: 
783:     *==========================================================================
784:     * ConfigurarPaginaLista - corpo da tela: Shape, grade e botoes
785:     *
786:     * O nome eh o do contrato do pipeline, como ja acontece com
787:     * ConfigurarPageFrame: NAO existe Page a configurar, porque o SCX legado
788:     * nao tem PageFrame nenhum (layout FLAT - ver cabecalho do arquivo).
789:     * Inventar PageFrame Lista/Dados e os cinco botoes CRUD canonicos
790:     * violaria o PILAR 1 e a regra "NUNCA inventar"; alem disso os botoes
791:     * CRUD ocupam Left = 542..932 e o legado tem exatamente DOIS botoes, em
792:     * 450 e 525. O que este metodo monta eh o que de fato existe no dump.
793:     *
794:     * ORDEM obrigatoria: Shape (decoracao, ao fundo) -> grade -> botoes. Os
795:     * botoes sao os ULTIMOS porque ficam sobre a faixa do cabecalho e o
796:     * AddObject poe o ultimo objeto no topo do z-order.
797:     *==========================================================================
798:     PROTECTED PROCEDURE ConfigurarPaginaLista()
799:         THIS.ConfigurarShapeDecorativo()
800:         THIS.ConfigurarGrade()
801:         THIS.ConfigurarBotoes()
802: 
803:         RETURN .T.
804:     ENDPROC
805: 
806: 
807:     *==========================================================================
808:     * ConfigurarPaginaDados - ordem de tabulacao (TabIndex do dump)
809:     *
810:     * O nome eh o do contrato do pipeline. NAO existe pagina Dados a montar:
811:     * o SCX eh FLAT (sem PageFrame) e seus unicos controles de ENTRADA sao os
812:     * tres Text1 das colunas da grade, entregues junto com ela nesta fase -
813:     * nao ha "metade dos campos" a acrescentar porque nao ha campo solto
814:     * nenhum.
815:     *
816:     * Chamado DEPOIS de todos os AddObject, de proposito: cada AddObject
817:     * renumera o TabIndex dos irmaos pela ordem de criacao, entao atribuicao
818:     * feita no meio da montagem eh reembaralhada pelos objetos seguintes.
819:     *
820:     * ORDEM-ALVO: a mesma mecanica medida no dialogo-irmao FormSigOpCrd.prg
821:     * (estrutura identica - cabecalho sem TabIndex, Shape sem TabIndex, grade
822:     * com TabIndex = 1 do dump, dois botoes com TabIndex = 2/3 do dump):
823:     *
824:     *     grade = 1   cabecalho = 2   Excluir = 3   Encerrar = 4
825:     *
826:     * O 1 da grade SOBREVIVE ao load e empurra o cabecalho para 2 - ou seja o
827:     * Tab do legado comeca na GRADE, que eh o unico lugar onde se digita.
828:     *
829:     * PUBLIC: o harness das etapas de teste chama metodos do form de FORA da
830:     * classe, e PROTECTED falharia com "Property ... is not found" - PEMSTATUS
831:     * devolve .T. mesmo para metodo protegido, entao o teste entra no branch e
832:     * so quebra na chamada real (regra #3).
833:     *==========================================================================
834:     PROCEDURE ConfigurarPaginaDados()
835:         *-- Grade primeiro: eh onde o usuario digita as faixas (SCX:
836:         *-- GradeSubN.TabIndex = 1 - o unico TabIndex declarado no dump)
837:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
838:             THIS.grd_4c_Dados.TabIndex = 1
839:         ENDIF
840: 
841:         *-- Cabecalho: so tem Label dentro, nao para o Tab. Fica em 2 porque
842:         *-- eh o que o load do legado produz, nao por escolha.
843:         IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
844:             THIS.cnt_4c_Sombra.TabIndex = 2
845:         ENDIF
846: 
847:         *-- Botoes, na ordem dos registros do SCX (Left 450, depois 525)
848:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
849:             THIS.cmd_4c_Excluir.TabIndex = 3
850:         ENDIF
851: 
852:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
853:             THIS.cmd_4c_Encerrar.TabIndex = 4
854:         ENDIF
855: 
856:         RETURN .T.
857:     ENDPROC
858: 
859: 
860:     *==========================================================================
861:     * ConfigurarShapeDecorativo - Shape1 do legado
862:     *
863:     * Dump: Top=7 Left=205 Height=110 Width=173
864:     *       BackStyle=0 BorderStyle=0 BorderColor=136,189,188
865:     *
866:     * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) deixa o
867:     * objeto SEM pintura alguma: ele nao aparece na tela. Transcrito mesmo
868:     * assim porque esta no dump (PILAR 1) e porque BorderColor declarado
869:     * indica que o desenhista pretendia uma moldura - mexer em BorderStyle
870:     * para "fazer aparecer" seria inventar UI que o usuario nunca viu.
871:     *
872:     * Shape NAO tem ForeColor (so BorderColor/FillColor) nem ShapeType (essa
873:     * eh do VB; no VFP o equivalente eh Curvature) - nenhuma das duas eh
874:     * atribuida aqui, senao o Init estouraria "Property ... is not found" e a
875:     * tela nao abriria (regra #33).
876:     *==========================================================================
877:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
878:         THIS.AddObject("shp_4c_Shape1", "Shape")
879:         WITH THIS.shp_4c_Shape1
880:             .Top         = 7
881:             .Left        = 205
882:             .Height      = 110
883:             .Width       = 173
884:             .BackStyle   = 0
885:             .BorderStyle = 0
886:             .BorderColor = RGB(136, 189, 188)
887:             .Visible     = .T.
888:         ENDWITH
889: 
890:         RETURN .T.
891:     ENDPROC
892: 
893: 
894:     *==========================================================================
895:     * ConfigurarGrade - GradeSubN do legado (grd_4c_Dados)
896:     *
897:     * Dump: ColumnCount=3 FontName="Tahoma" FontSize=8 DeleteMark=.F.
898:     *       Top=104 Left=159 Width=281 Height=226 RowHeight=16
899:     *       ScrollBars=2 TabIndex=1 ForeColor=0,0,0 GridLineColor=238,238,238
900:     *
901:     * O TabIndex = 1 do dump NAO eh atribuido aqui: TabIndex tem de ser
902:     * aplicado DEPOIS de todos os AddObject, senao cada AddObject seguinte
903:     * renumera os irmaos. Mora em ConfigurarPaginaDados().
904:     *
905:     * Tahoma, e nao Verdana: Verdana eh o canonico da grade de LISTA do
906:     * frmcadastro, e esta tela nao eh um cadastro paginado - o dump declara
907:     * Tahoma 8 no proprio Grid.
908:     *
909:     * Sem compensacao de +29 no Top: sem PageFrame, os Top do dump sao
910:     * absolutos (os -29 do pgf_4c_Paginas nao existem aqui).
911:     *
912:     * RecordMark: o dump declara DeleteMark = .F. e eh SILENCIOSO sobre
913:     * RecordMark (que na BaseClass grid vale .T. por default). Mesmo assim
914:     * fica .F. aqui: eh a regra do projeto para grade de form OPERACIONAL, e
915:     * o CorretorAutomatico (#58/GridRecordMarkDeleteMark) injeta .F. quando a
916:     * propriedade esta ausente. Declarar explicitamente deixa a decisao
917:     * visivel no codigo em vez de ser acrescentada em silencio no proximo
918:     * sweep.
919:     *
920:     * Nada de RecordSource / ControlSource aqui - ver CarregarLista.
921:     *==========================================================================
922:     PROTECTED PROCEDURE ConfigurarGrade()
923:         THIS.AddObject("grd_4c_Dados", "Grid")
924:         WITH THIS.grd_4c_Dados
925:             .ColumnCount    = 3
926:             .Top            = 104
927:             .Left           = 159
928:             .Width          = 281
929:             .Height         = 226
930:             .FontName       = "Tahoma"
931:             .FontSize       = 8
932:             .RowHeight      = 16
933:             .ScrollBars     = 2
934:             .ForeColor      = RGB(0, 0, 0)
935:             .GridLineColor  = RGB(238, 238, 238)
936:             .RecordMark     = .F.
937:             .DeleteMark     = .F.
938:             .Visible        = .T.
939:         ENDWITH
940: 
941:         *-- Propriedades de COLUNA num metodo proprio: elas sao reaplicadas
942:         *-- depois de cada RecordSource (ver ConfigurarColunasGrade).
943:         THIS.ConfigurarColunasGrade()
944: 
945:         RETURN .T.
946:     ENDPROC
947: 
948: 
949:     *==========================================================================
950:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
951:     *
952:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
953:     * larguras para o default 90 e devolver os cabecalhos a "Header1" -
954:     * silenciosamente. Por isso tudo que eh de coluna mora aqui e este metodo
955:     * eh chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de
956:     * novo logo depois de cada bind, em VincularGrade.
957:     *
958:     * Dump, coluna por coluna:
959:     *   Column1 "Qtd Dias Inicial" Width=100 Movable=.F. Resizable=.F.
960:     *           InputMask="9999" ForeColor=0,0,0
961:     *   Column2 "Qtd Dias Final"   Width=100 Movable=.F. Resizable=.F.
962:     *           InputMask="9999"  ForeColor=0,0,0  Text1.ReadOnly=.F.

*-- Linhas 976 a 1019:
976:     * legado so declara ReadOnly = .F. explicito na Column2.Text1, que ja eh
977:     * o default. Travar coluna aqui tiraria do usuario a digitacao das faixas.
978:     *==========================================================================
979:     PROCEDURE ConfigurarColunasGrade()
980:         LOCAL loc_oGrade
981: 
982:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
983:             RETURN .F.
984:         ENDIF
985: 
986:         loc_oGrade = THIS.grd_4c_Dados
987: 
988:         *-- Column1 - "Qtd Dias Inicial" (qtddis)
989:         WITH loc_oGrade.Column1
990:             .Width     = 100
991:             .Movable   = .F.
992:             .Resizable = .F.
993:             .InputMask = "9999"
994:             .ForeColor = RGB(0, 0, 0)
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             WITH .Header1
998:                 .FontName  = "Tahoma"
999:                 .FontSize  = 8
1000:                 .Alignment = 2
1001:                 .Caption   = "Qtd Dias Inicial"
1002:             ENDWITH
1003:             WITH .Text1
1004:                 .FontName    = "Tahoma"
1005:                 .FontSize    = 8
1006:                 .BorderStyle = 0
1007:                 .Margin      = 0
1008:                 .ForeColor   = RGB(0, 0, 0)
1009:                 .BackColor   = RGB(255, 255, 255)
1010:             ENDWITH
1011:         ENDWITH
1012: 
1013:         *-- Column2 - "Qtd Dias Final" (qtddfs)
1014:         WITH loc_oGrade.Column2
1015:             .Width     = 100
1016:             .Movable   = .F.
1017:             .Resizable = .F.
1018:             .InputMask = "9999"
1019:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1094 a 1137:
1094:     * saidas alem do clique - por isso ReabilitarFormPai tambem roda no
1095:     * Destroy.
1096:     *==========================================================================
1097:     PROTECTED PROCEDURE ConfigurarBotoes()
1098:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1099:         WITH THIS.cmd_4c_Excluir
1100:             .Top             = 3
1101:             .Left            = 450
1102:             .Width           = 75
1103:             .Height          = 75
1104:             .Caption         = "Excluir"
1105:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1106:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1107:             .PicturePosition = 13
1108:             .FontName        = "Comic Sans MS"
1109:             .FontSize        = 8
1110:             .FontBold        = .T.
1111:             .FontItalic      = .T.
1112:             .ForeColor       = RGB(90, 90, 90)
1113:             .BackColor       = RGB(255, 255, 255)
1114:             .Themes          = .T.
1115:             .SpecialEffect   = 0
1116:             .MousePointer    = 15
1117:             .WordWrap        = .T.
1118:             .AutoSize        = .F.
1119:             .ToolTipText     = "Excluir a faixa de deprecia" + CHR(231) + CHR(227) + "o selecionada"
1120:             .Visible         = .T.
1121:         ENDWITH
1122: 
1123:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1124:         WITH THIS.cmd_4c_Encerrar
1125:             .Top             = 3
1126:             .Left            = 525
1127:             .Width           = 75
1128:             .Height          = 75
1129:             .Caption         = "Encerrar"
1130:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1131:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1132:             .PicturePosition = 13
1133:             .FontName        = "Comic Sans MS"
1134:             .FontSize        = 8
1135:             .FontBold        = .T.
1136:             .FontItalic      = .T.
1137:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1146 a 1218:
1146:             .Visible         = .T.
1147:         ENDWITH
1148: 
1149:         *-- BINDEVENT so DEPOIS de os dois objetos existirem, e apontando para
1150:         *-- metodos que JA estao definidos nesta classe: delegate inexistente
1151:         *-- estoura no proprio BINDEVENT e derruba o Init.
1152:         BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
1153:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1154: 
1155:         RETURN .T.
1156:     ENDPROC
1157: 
1158: 
1159:     *==========================================================================
1160:     * AjustarBotoesPorModo - espelha a permissao resolvida pelo BO
1161:     *
1162:     * Legado (Init):
1163:     *     .cmdExcluir.Visible = fChecaAcesso('SigOpDup','EXCLUIR') And ;
1164:     *                           Iif( Type('Thisform.PcEscolha') # 'C', .T., ;
1165:     *                           InList( Thisform.PcEscolha, 'INSERIR','ALTERAR' ) )
1166:     *     .cmdExcluir.Enabled = .cmdExcluir.Visible
1167:     *
1168:     * As duas condicoes ja foram resolvidas uma vez no Init do BO e moram em
1169:     * this_lPodeExcluir - aqui so se espelha, para a permissao ter fonte
1170:     * UNICA. O Encerrar nao tem gate no legado: eh a saida da tela e fica
1171:     * sempre ativo (desabilita-lo prenderia o usuario, porque o form nao tem
1172:     * barra de titulo).
1173:     *
1174:     * PUBLIC de proposito: o harness da etapa 06b chama AjustarBotoesPorModo()
1175:     * de FORA da classe e PROTECTED falharia com "Property ... is not found"
1176:     * (regra #3).
1177:     *==========================================================================
1178:     PROCEDURE AjustarBotoesPorModo()
1179:         LOCAL loc_lPodeExcluir
1180: 
1181:         loc_lPodeExcluir = .F.
1182: 
1183:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1184:             loc_lPodeExcluir = THIS.this_oBusinessObject.this_lPodeExcluir
1185:         ENDIF
1186: 
1187:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1188:             THIS.cmd_4c_Excluir.Visible = loc_lPodeExcluir
1189:             THIS.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
1190:         ENDIF
1191: 
1192:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1193:             THIS.cmd_4c_Encerrar.Visible = .T.
1194:             THIS.cmd_4c_Encerrar.Enabled = .T.
1195:         ENDIF
1196: 
1197:         RETURN .T.
1198:     ENDPROC
1199: 
1200: 
1201:     *==========================================================================
1202:     * CarregarLista - carrega as faixas e LIGA a grade ao cursor
1203:     *
1204:     * Transcricao do trecho de carga do Init legado:
1205:     *     With SigCdOpe.poDatamgr
1206:     *         .ReQuery('crSigOpDup') / SELECT crSigOpDup / Go Top
1207:     *     EndWith
1208:     *     Select CrSigOpDup / Goto Top
1209:     *     If Reccount() = 0 And InList(Thisform.PcEscolha,'INSERIR','ALTERAR')
1210:     *         ThisForm.inserelinha()
1211:     *     Endif
1212:     *     With Thisform.GradeSubN
1213:     *         .RecordSource          = 'crSigOpDup'
1214:     *         .Column1.ControlSource = 'crSigOpDup.QtddIs'
1215:     *         ... .Refresh
1216:     *     EndWith
1217:     *
1218:     * A ordem eh regra: carregar -> garantir a linha de digitacao -> LIGAR a

*-- Linhas 1227 a 1345:
1227:     *
1228:     * PUBLIC: o harness chama THIS.oForm.CarregarLista() de fora (regra #3).
1229:     *==========================================================================
1230:     PROCEDURE CarregarLista()
1231:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_oErro
1232: 
1233:         loc_lSucesso = .F.
1234: 
1235:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1236:             RETURN .F.
1237:         ENDIF
1238: 
1239:         loc_oBO    = THIS.this_oBusinessObject
1240:         loc_cAlias = ALLTRIM(loc_oBO.this_cCursorDados)
1241: 
1242:         TRY
1243:             *-- CarregarFaixas prepara o cursor, traz as faixas da operacao e
1244:             *-- deixa o ponteiro no topo. Sem conexao (modo de teste) ou sem
1245:             *-- operacao no contexto ele devolve .T. com o cursor VAZIO, e a
1246:             *-- grade tem de ser ligada do mesmo jeito - senao ela fica um
1247:             *-- retangulo branco sem cabecalho.
1248:             loc_lSucesso = loc_oBO.CarregarFaixas()
1249: 
1250:             *-- Linha em branco de digitacao, como o legado faz no Init - e
1251:             *-- so nos modos editaveis. Marca o flag ANTES, como o legado
1252:             *-- (Thisform.lHouveIns = .T. no topo do inserelinha).
1253:             IF USED(loc_cAlias)
1254:                 IF RECCOUNT(loc_cAlias) = 0 ;
1255:                    AND INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
1256:                     THIS.InserirLinhaCursor()
1257:                 ENDIF
1258:             ENDIF
1259: 
1260:             *-- Bind + reaplicacao das propriedades de coluna
1261:             THIS.VincularGrade()
1262: 
1263:             *-- GO TOP + Refresh: popular o cursor NAO repinta a grade.
1264:             IF USED(loc_cAlias)
1265:                 SELECT (loc_cAlias)
1266:                 GO TOP
1267:             ENDIF
1268:             THIS.RepintarGrade()
1269:         CATCH TO loc_oErro
1270:             THIS.this_cMensagemErro = loc_oErro.Message
1271:             MsgErro("Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1272:                     loc_oErro.Message + CHR(13) + ;
1273:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1274:                     "Procedure: " + loc_oErro.Procedure, ;
1275:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1276:             loc_lSucesso = .F.
1277:         ENDTRY
1278: 
1279:         RETURN loc_lSucesso
1280:     ENDPROC
1281: 
1282: 
1283:     *==========================================================================
1284:     * VincularGrade - RecordSource + ControlSource das 3 colunas
1285:     *
1286:     * Transcricao do With Thisform.GradeSubN do Init legado, com os mesmos
1287:     * pares coluna/campo:
1288:     *     Column1 -> QtddIs    Column2 -> QtddFs    Column3 -> Percs
1289:     *
1290:     * ColumnCount eh reposto ANTES do RecordSource porque o cursor tem SEIS
1291:     * colunas (as cinco de SigOpDup mais o marcador lnovos) e sem ele a
1292:     * grade se auto-expande para todas - o usuario veria cidchaves, dopes e
1293:     * lnovos na tela. O guard IF != 3 existe porque atribuir ColumnCount
1294:     * RECRIA os objetos Column, descartando tudo o que foi posto neles;
1295:     * reatribuir o mesmo valor sem necessidade so cria risco.
1296:     *
1297:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource
1298:     * acabaram de devolver as larguras ao default 90 e os cabecalhos a
1299:     * "Header1".
1300:     *
1301:     * PUBLIC porque tambem eh o ponto de religacao quando o BO avisa, por
1302:     * this_lCursorRecriado, que FECHOU e recriou o alias - fechar o alias
1303:     * derruba o binding da grade EM SILENCIO.
1304:     *==========================================================================
1305:     PROCEDURE VincularGrade()
1306:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
1307: 
1308:         loc_lSucesso = .F.
1309: 
1310:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1311:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1312:             RETURN .F.
1313:         ENDIF
1314: 
1315:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1316:         loc_oGrade = THIS.grd_4c_Dados
1317: 
1318:         IF !USED(loc_cAlias)
1319:             *-- Sem cursor nao ha o que ligar, e atribuir ControlSource agora
1320:             *-- estouraria "Alias ... is not found".
1321:             RETURN .F.
1322:         ENDIF
1323: 
1324:         TRY
1325:             *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
1326:             *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
1327:             *-- mesmo bloco WITH que acabou de abrir, e o acesso a .ColumnN
1328:             *-- logo depois estouraria "Unknown member COLUMNN".
1329:             IF loc_oGrade.ColumnCount != 3
1330:                 loc_oGrade.ColumnCount = 3
1331:             ENDIF
1332: 
1333:             loc_oGrade.RecordSource = loc_cAlias
1334: 
1335:             WITH loc_oGrade
1336:                 .Column1.ControlSource = loc_cAlias + ".qtddis"
1337:                 .Column2.ControlSource = loc_cAlias + ".qtddfs"
1338:                 .Column3.ControlSource = loc_cAlias + ".percs"
1339:             ENDWITH
1340: 
1341:             *-- Larguras e cabecalhos DEPOIS do bind, sempre
1342:             THIS.ConfigurarColunasGrade()
1343: 
1344:             *-- Celulas com evento DEPOIS de ConfigurarColunasGrade: o
1345:             *-- ColumnCount acima pode ter RECRIADO os objetos Column, e com

*-- Linhas 1354 a 1468:
1354:             MsgErro("Erro ao vincular a grade da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1355:                     loc_oErro.Message + CHR(13) + ;
1356:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1357:                     "Procedure: " + loc_oErro.Procedure, ;
1358:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1359:             loc_lSucesso = .F.
1360:         ENDTRY
1361: 
1362:         RETURN loc_lSucesso
1363:     ENDPROC
1364: 
1365: 
1366:     *==========================================================================
1367:     * RepintarGrade - ThisForm.GradeSubN.Refresh do legado
1368:     *
1369:     * Refresh PURO, sem GO TOP: quem precisa do topo (a carga) faz o GO TOP
1370:     * antes de chamar. O Excluir, ao contrario, acabou de reposicionar o
1371:     * ponteiro com o par Skip / Skip -1 do legado e um GO TOP aqui jogaria o
1372:     * usuario para a primeira linha a cada exclusao.
1373:     *
1374:     * PUBLIC: chamado pelos handlers e pelo harness.
1375:     *==========================================================================
1376:     PROCEDURE RepintarGrade()
1377:         LOCAL loc_oErro
1378: 
1379:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1380:             RETURN .F.
1381:         ENDIF
1382: 
1383:         TRY
1384:             THIS.grd_4c_Dados.Refresh()
1385:         CATCH TO loc_oErro
1386:             MsgErro(loc_oErro.Message, "FormSigOpDpe.RepintarGrade")
1387:         ENDTRY
1388: 
1389:         RETURN .T.
1390:     ENDPROC
1391: 
1392: 
1393:     *==========================================================================
1394:     * InstalarCelulasDpe - poe TextBoxCelulaSigOpDpe_4c nas colunas que o
1395:     * legado dota de evento: Column2 (Qtd Dias Final) e Column3 (%)
1396:     *
1397:     * O legado tem LostFocus em DUAS celulas da grade, e so nessas duas:
1398:     *     SIGOPDPE.GradeSubN.Column2.Text1.LostFocus
1399:     *     SIGOPDPE.GradeSubN.Column3.Text1.LostFocus
1400:     * Column1 (Qtd Dias Inicial) nao tem evento algum no dump - instalar
1401:     * celula nela seria acrescentar comportamento que o legado nao tem
1402:     * (PILAR 1), entao ela segue com o Text1 nativo.
1403:     *
1404:     * POR QUE SUBCLASSE E NAO BINDEVENT: BINDEVENT em evento de TextBox dentro
1405:     * de Column nao dispara de forma confiavel no VFP9 - eh a razao de existir
1406:     * classes\TextBoxGridLookup.prg, que documenta isso no proprio cabecalho.
1407:     * O caminho canonico do projeto (regra #46, referencia FormLpr) eh um
1408:     * TextBox subclasse com o evento EMBUTIDO delegando a metodo PUBLIC do
1409:     * form, posto na coluna com AddObject + CurrentControl + Sparse = .F.
1410:     *
1411:     * As TRES linhas finais sao obrigatorias juntas (regra #18):
1412:     *     AddObject         - cria o objeto, mas a coluna segue desenhando o Text1
1413:     *     CurrentControl    - eh o que faz a coluna DESENHAR o novo controle
1414:     *     Sparse = .F.      - senao ele so aparece na linha ATIVA
1415:     * Faltando CurrentControl o controle existe, responde a PEMSTATUS e NUNCA
1416:     * aparece - e o LostFocus nunca roda, sem erro e sem log.
1417:     *
1418:     * As propriedades de Text1 do dump sao reaplicadas AQUI porque
1419:     * ConfigurarColunasGrade configura o .Text1, que nestas duas colunas
1420:     * deixou de ser o controle exibido - sem repetir, as duas celulas sairiam
1421:     * com borda, margem e fonte diferentes das outras. InputMask tambem entra
1422:     * no controle: a mascara da COLUNA nao chega ao TextBox instalado.
1423:     *
1424:     * IDEMPOTENTE (guard PEMSTATUS): eh chamado de VincularGrade, que roda em
1425:     * toda carga, e AddObject com nome repetido estoura "Object ... is already
1426:     * defined" e derruba o Init.
1427:     *==========================================================================
1428:     PROTECTED PROCEDURE InstalarCelulasDpe(par_oGrade)
1429:         LOCAL loc_nI, loc_nCol, loc_oColuna, loc_cCampo, loc_cMascara, loc_oErro
1430: 
1431:         IF VARTYPE(par_oGrade) != "O"
1432:             RETURN .F.
1433:         ENDIF
1434: 
1435:         TRY
1436:             FOR loc_nI = 1 TO 2
1437:                 *-- Column2 -> qtddfs ("9999") ; Column3 -> percs ("999.99")
1438:                 loc_nCol     = IIF(loc_nI = 1, 2, 3)
1439:                 loc_cCampo   = IIF(loc_nI = 1, "qtddfs", "percs")
1440:                 loc_cMascara = IIF(loc_nI = 1, "9999", "999.99")
1441: 
1442:                 IF par_oGrade.ColumnCount < loc_nCol
1443:                     LOOP
1444:                 ENDIF
1445: 
1446:                 loc_oColuna = par_oGrade.Columns(loc_nCol)
1447: 
1448:                 IF !PEMSTATUS(loc_oColuna, "txt_4c_Celula", 5)
1449:                     loc_oColuna.AddObject("txt_4c_Celula", "TextBoxCelulaSigOpDpe_4c")
1450:                 ENDIF
1451: 
1452:                 WITH loc_oColuna.txt_4c_Celula
1453:                     .this_cCampo = loc_cCampo
1454: 
1455:                     *-- Text1 do dump, celula por celula
1456:                     .FontName    = "Tahoma"
1457:                     .FontSize    = 8
1458:                     .BorderStyle = 0
1459:                     .Margin      = 0
1460:                     .ForeColor   = RGB(0, 0, 0)
1461:                     .BackColor   = RGB(255, 255, 255)
1462: 
1463:                     *-- Dump: Column2.InputMask / Column3.InputMask
1464:                     .InputMask   = loc_cMascara
1465: 
1466:                     *-- Dump: so a Column2.Text1 declara ReadOnly = .F.
1467:                     *-- explicito; na Column3 o default .F. ja eh esse valor.
1468:                     .ReadOnly    = .F.

*-- Linhas 1483 a 1839:
1483:             MsgErro("Erro ao instalar as c" + CHR(233) + "lulas da grade:" + CHR(13) + ;
1484:                     loc_oErro.Message + CHR(13) + ;
1485:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1486:                     "Procedure: " + loc_oErro.Procedure, ;
1487:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1488:         ENDTRY
1489: 
1490:         RETURN .T.
1491:     ENDPROC
1492: 
1493: 
1494:     *==========================================================================
1495:     * ValidarQtddFinal - LostFocus da Column2.Text1 (Qtd Dias Final) do legado
1496:     *
1497:     * Legado, LITERAL:
1498:     *     PROCEDURE LostFocus
1499:     *     If IsEmpty(This.Value)
1500:     *         Thisform.cmdSair.SetFocus
1501:     *     EndIf
1502:     *
1503:     * Qtd Dias Final em branco significa "acabei de preencher": o legado leva
1504:     * o usuario direto ao Encerrar, que eh o botao que grava. NAO eh validacao
1505:     * com mensagem - nao existe aviso nenhum aqui, e inventar um mudaria o
1506:     * fluxo da tela (PILAR 1).
1507:     *
1508:     * O valor lido eh par_oTxt.Value, NAO a coluna do cursor: dentro do evento
1509:     * da celula o cursor ainda NAO recebeu o que foi digitado, entao ler do
1510:     * cursor validaria o valor ANTIGO (regra #46).
1511:     *
1512:     * IsEmpty do Fortyus trata .NULL. como vazio, ao contrario do EMPTY nativo
1513:     * do VFP (medido: EMPTY(.NULL.) devolve .F.). Daqui sai o ISNULL em IF
1514:     * SEPARADO - VFP9 nao faz short-circuit em OR, entao ISNULL(x) OR EMPTY(x)
1515:     * avaliaria EMPTY(.NULL.) de qualquer jeito.
1516:     *
1517:     * PUBLIC: chamado pela classe da celula (THISFORM.ValidarQtddFinal) e
1518:     * pelo harness.
1519:     *==========================================================================
1520:     PROCEDURE ValidarQtddFinal(par_oTxt)
1521:         *-- Wrapper fino da guarda de reentrancia. O corpo fica no ...Exec
1522:         *-- porque este metodo tem RETURN antecipado: liberar a flag "no fim
1523:         *-- do corpo" a deixaria travada ligada e MATARIA o handler pelo resto
1524:         *-- da vida do form.
1525:         IF THIS.this_lEmCelula
1526:             RETURN .T.
1527:         ENDIF
1528: 
1529:         THIS.this_lEmCelula = .T.
1530:         THIS.ValidarQtddFinalExec(par_oTxt)
1531:         THIS.this_lEmCelula = .F.
1532: 
1533:         RETURN .T.
1534:     ENDPROC
1535: 
1536: 
1537:     *==========================================================================
1538:     * ValidarQtddFinalExec - corpo de ValidarQtddFinal
1539:     *==========================================================================
1540:     PROTECTED PROCEDURE ValidarQtddFinalExec(par_oTxt)
1541:         LOCAL loc_lVazio, loc_uValor, loc_oErro
1542: 
1543:         IF VARTYPE(par_oTxt) != "O"
1544:             RETURN .F.
1545:         ENDIF
1546: 
1547:         TRY
1548:             loc_uValor = par_oTxt.Value
1549:             loc_lVazio = .F.
1550: 
1551:             *-- IF separado, nunca ISNULL(x) OR EMPTY(x)
1552:             IF ISNULL(loc_uValor)
1553:                 loc_lVazio = .T.
1554:             ELSE
1555:                 IF EMPTY(loc_uValor)
1556:                     loc_lVazio = .T.
1557:                 ENDIF
1558:             ENDIF
1559: 
1560:             IF loc_lVazio
1561:                 IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1562:                     *-- SetFocus falha em controle que nao esta visivel e
1563:                     *-- habilitado (caminho de carga, form ainda nao mostrado).
1564:                     IF THIS.cmd_4c_Encerrar.Visible AND THIS.cmd_4c_Encerrar.Enabled
1565:                         THIS.cmd_4c_Encerrar.SetFocus()
1566:                     ENDIF
1567:                 ENDIF
1568:             ENDIF
1569:         CATCH TO loc_oErro
1570:             THIS.this_cMensagemErro = loc_oErro.Message
1571:             MsgErro("Erro ao sair do campo Qtd Dias Final:" + CHR(13) + ;
1572:                     loc_oErro.Message + CHR(13) + ;
1573:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1574:                     "Procedure: " + loc_oErro.Procedure, ;
1575:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1576:         ENDTRY
1577: 
1578:         RETURN .T.
1579:     ENDPROC
1580: 
1581: 
1582:     *==========================================================================
1583:     * ValidarPercs - LostFocus da Column3.Text1 (%) do legado
1584:     *
1585:     * Legado, LITERAL:
1586:     *     PROCEDURE LostFocus
1587:     *     Select CrSigOpDup
1588:     *     Locate for Qtddfs = 0
1589:     *     If Eof()
1590:     *         Thisform.Inserelinha()
1591:     *     EndIf
1592:     *     Select CrSigOpDup
1593:     *
1594:     * % eh a ULTIMA coluna: ao sair dela o legado garante que exista sempre
1595:     * UMA linha em branco esperando digitacao - se nenhuma linha tem
1596:     * Qtddfs = 0, ele cria. Eh assim que o usuario acrescenta faixas sem
1597:     * nenhum botao de "inserir": preenche a linha e a proxima aparece.
1598:     *
1599:     * Esse LOCATE eh tambem o que, na pratica, liga o marcador de alteracao a
1600:     * gravar que o Encerrar consulta - as linhas vindas do servidor nunca tem
1601:     * Qtddfs = 0, entao InserirLinha roda e marca this_lHouveIns. Por isso
1602:     * adiar este handler deixaria a tela gravando MENOS do que o legado
1603:     * grava.
1604:     *
1605:     * O LOCATE roda sobre o CURSOR (nao sobre par_oTxt.Value): aqui a
1606:     * pergunta eh "existe linha em branco na grade?", nao "o que foi
1607:     * digitado?".
1608:     *
1609:     * PUBLIC: chamado pela classe da celula e pelo harness.
1610:     *==========================================================================
1611:     PROCEDURE ValidarPercs(par_oTxt)
1612:         IF THIS.this_lEmCelula
1613:             RETURN .T.
1614:         ENDIF
1615: 
1616:         THIS.this_lEmCelula = .T.
1617:         THIS.ValidarPercsExec(par_oTxt)
1618:         THIS.this_lEmCelula = .F.
1619: 
1620:         RETURN .T.
1621:     ENDPROC
1622: 
1623: 
1624:     *==========================================================================
1625:     * ValidarPercsExec - corpo de ValidarPercs
1626:     *==========================================================================
1627:     PROTECTED PROCEDURE ValidarPercsExec(par_oTxt)
1628:         LOCAL loc_cAlias, loc_lPrecisaLinha, loc_oErro
1629: 
1630:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1631:             RETURN .F.
1632:         ENDIF
1633: 
1634:         loc_cAlias        = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1635:         loc_lPrecisaLinha = .F.
1636: 
1637:         IF !USED(loc_cAlias)
1638:             RETURN .F.
1639:         ENDIF
1640: 
1641:         TRY
1642:             SELECT (loc_cAlias)
1643:             LOCATE FOR qtddfs = 0
1644: 
1645:             IF EOF()
1646:                 loc_lPrecisaLinha = .T.
1647:             ENDIF
1648: 
1649:             IF loc_lPrecisaLinha
1650:                 THIS.InserirLinha()
1651:             ENDIF
1652: 
1653:             *-- Select final do legado: o LOCATE pode ter deixado o alias
1654:             *-- corrente em outro lugar e o resto da tela conta com este.
1655:             IF USED(loc_cAlias)
1656:                 SELECT (loc_cAlias)
1657:             ENDIF
1658:         CATCH TO loc_oErro
1659:             THIS.this_cMensagemErro = loc_oErro.Message
1660:             MsgErro("Erro ao sair do campo %:" + CHR(13) + ;
1661:                     loc_oErro.Message + CHR(13) + ;
1662:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1663:                     "Procedure: " + loc_oErro.Procedure, ;
1664:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1665:         ENDTRY
1666: 
1667:         RETURN .T.
1668:     ENDPROC
1669: 
1670: 
1671:     *==========================================================================
1672:     * InserirLinhaCursor - marcador + delegacao da parte de DADOS do
1673:     * inserelinha legado
1674:     *
1675:     * Legado:
1676:     *     Thisform.lHouveIns = .T.
1677:     *     Select crSigOpDup
1678:     *     Locate for Qtddfs=0
1679:     *     If Eof()
1680:     *         Insert Into crSigOpDup (Dopes, CidChaves) ;
1681:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1682:     *     EndIf
1683:     *
1684:     * O marcador lHouveIns eh property do FORM (RESERVED3 do dump o lista
1685:     * como custom property de SIGOPDPE, nao do BO) e eh ligado
1686:     * INCONDICIONALMENTE, ANTES do LOCATE - vale mesmo quando a linha em
1687:     * branco ja existia e o INSERT nao roda. Transcrito como esta, e nao
1688:     * "corrigido", porque mexer nisso mudaria quais edicoes chegam a ser
1689:     * gravadas pelo Encerrar.
1690:     *
1691:     * Usado por DOIS chamadores: CarregarLista (carga inicial, sem
1692:     * navegacao de tela) e InserirLinha (fluxo interativo, com
1693:     * Keyboard/Refresh/SetFocus). Os dois precisam do MESMO marcador ligado,
1694:     * por isso ele mora aqui e nao soh no wrapper de tela.
1695:     *
1696:     * PUBLIC: chamado por CarregarLista, por InserirLinha e pelo harness.
1697:     *==========================================================================
1698:     PROCEDURE InserirLinhaCursor()
1699:         THIS.this_lHouveIns = .T.
1700: 
1701:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1702:             RETURN .F.
1703:         ENDIF
1704: 
1705:         RETURN THIS.this_oBusinessObject.InserirLinhaCursor()
1706:     ENDPROC
1707: 
1708: 
1709:     *==========================================================================
1710:     * InserirLinha - parte de TELA do inserelinha legado
1711:     *
1712:     * Legado COMPLETO:
1713:     *     PROCEDURE inserelinha
1714:     *     Thisform.lHouveIns = .T.
1715:     *     Select crSigOpDup
1716:     *     Locate for Qtddfs=0
1717:     *     If Eof()
1718:     *         Insert Into crSigOpDup (Dopes, CidChaves) ;
1719:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1720:     *     EndIf
1721:     *     Select crSigOpDup
1722:     *     Keyboard '{DNARROW}'
1723:     *     ThisForm.GradeSubN.Refresh
1724:     *     Thisform.GradeSubN.Column1.SetFocus
1725:     *
1726:     * A parte de DADOS (marcador + LOCATE + INSERT) esta em
1727:     * InserirLinhaCursor. Aqui ficam as TRES ultimas linhas, que sao de tela
1728:     * e que o migrador costuma descartar junto com o resto do handler - e sao
1729:     * elas que tornam a linha nova USAVEL: sem o Refresh a grade continua
1730:     * mostrando o cursor antigo (popular cursor NAO repinta a grade, regra
1731:     * #21a) e sem o SetFocus o usuario tem de ir com o mouse ate a primeira
1732:     * coluna da linha nova.
1733:     *
1734:     * O Keyboard '{DNARROW}' eh transcrito como esta: ele enfileira a tecla
1735:     * para DEPOIS deste metodo, e eh o que leva o cursor da grade para a
1736:     * linha recem-criada.
1737:     *
1738:     * SetFocus so com o form MOSTRADO: este metodo tambem eh alcancavel pelo
1739:     * caminho de carga via InserirLinhaCursor direto (CarregarLista NAO
1740:     * chama InserirLinha), onde o form ainda nao foi exibido e o SetFocus
1741:     * falharia.
1742:     *
1743:     * PUBLIC: chamado por ValidarPercs e pelo harness.
1744:     *==========================================================================
1745:     PROCEDURE InserirLinha()
1746:         LOCAL loc_lSucesso, loc_oErro
1747: 
1748:         loc_lSucesso = THIS.InserirLinhaCursor()
1749: 
1750:         TRY
1751:             *-- Keyboard do legado: leva a grade para a linha nova
1752:             KEYBOARD "{DNARROW}"
1753: 
1754:             THIS.RepintarGrade()
1755: 
1756:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.Visible
1757:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
1758:                     THIS.grd_4c_Dados.Column1.SetFocus()
1759:                 ENDIF
1760:             ENDIF
1761:         CATCH TO loc_oErro
1762:             *-- Navegacao que falha NAO invalida a linha ja inserida: o
1763:             *-- resultado segue o de InserirLinhaCursor e o usuario so perde
1764:             *-- o posicionamento automatico. Avisar em vez de engolir
1765:             *-- (regra #9).
1766:             MsgErro("Erro ao posicionar a grade na linha nova:" + CHR(13) + ;
1767:                     loc_oErro.Message + CHR(13) + ;
1768:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1769:                     "Procedure: " + loc_oErro.Procedure, ;
1770:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1771:         ENDTRY
1772: 
1773:         RETURN loc_lSucesso
1774:     ENDPROC
1775: 
1776: 
1777:     *==========================================================================
1778:     * CmdExcluirClick - cmdExcluir.Click do legado
1779:     *
1780:     * Legado:
1781:     *     Select crSigOpDup
1782:     *     If Not Eof()
1783:     *         Thisform.lHouveExcl = .T.
1784:     *         Delete / Skip / Skip - 1
1785:     *     Endif
1786:     *     ThisForm.GradeSubN.Refresh
1787:     *
1788:     * A parte de DADOS (DELETE e reposicionamento do ponteiro) mora em
1789:     * ExcluirLinhaCursor, no BO, que devolve .T. exatamente quando a mesma
1790:     * condicao "Not Eof()" do legado abriu o bloco - eh esse retorno que
1791:     * decide se o marcador do FORM (lHouveExcl) eh ligado. O Refresh vem FORA
1792:     * do IF, como no legado: ele repinta tambem quando nada foi excluido.
1793:     *
1794:     * A remocao eh LOCAL - no legado o DELETE so chega ao servidor junto com
1795:     * a gravacao do Encerrar, e eh isso que GravarFaixas (BO) reproduz. Nao
1796:     * ha confirmacao porque o legado nao pede nenhuma, e o Encerrar eh a
1797:     * ultima chance de desistir (fechar sem clicar nele descarta tudo).
1798:     *==========================================================================
1799:     PROCEDURE CmdExcluirClick()
1800:         LOCAL loc_lExcluiu
1801: 
1802:         loc_lExcluiu = .F.
1803: 
1804:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1805:             loc_lExcluiu = THIS.this_oBusinessObject.ExcluirLinhaCursor()
1806:         ENDIF
1807: 
1808:         IF loc_lExcluiu
1809:             THIS.this_lHouveExcl = .T.
1810:         ENDIF
1811: 
1812:         THIS.RepintarGrade()
1813: 
1814:         RETURN loc_lExcluiu
1815:     ENDPROC
1816: 
1817: 
1818:     *==========================================================================
1819:     * CmdEncerrarClick - cmdSair.Click do legado
1820:     *
1821:     * Legado:
1822:     *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1823:     *         ... Delete For Empty(Dopes) or Empty(Qtddfs)
1824:     *         ... Replace CidChaves with fUniqueIds() For Empty(CidChaves)
1825:     *         ... poDataMgr.UpDate / Commit / RollBack
1826:     *         If Not m.lnErro1>0
1827:     *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1828:     *         EndIf
1829:     *     EndIf
1830:     *     Thisform.ParentForm.Enabled = .T.
1831:     *     ThisForm.Release
1832:     *
1833:     * O guard "Thisform.lHouveExcl Or Thisform.lHouveIns" eh property do
1834:     * FORM (ver cabecalho do arquivo) e fica AQUI, e nao no BO: sem
1835:     * insercao nem exclusao, o Encerrar apenas devolve o foco ao form pai e
1836:     * fecha, sem tocar no banco.
1837:     *
1838:     * TRANSCRICAO FIEL, inclusive no ponto incomodo: o legado LIBERA O PAI E
1839:     * FECHA A TELA MESMO QUANDO A GRAVACAO FALHA - o RollBack desfaz no

*-- Linhas 1846 a 1956:
1846:     * referencia morta. ReabilitarFormPai vem antes e eh idempotente - o
1847:     * Destroy, que o proprio Release dispara, chama de novo sem efeito.
1848:     *==========================================================================
1849:     PROCEDURE CmdEncerrarClick()
1850:         LOCAL loc_lGravou
1851: 
1852:         loc_lGravou = .T.
1853: 
1854:         IF (THIS.this_lHouveExcl OR THIS.this_lHouveIns)
1855:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1856:                 loc_lGravou = THIS.this_oBusinessObject.GravarFaixas()
1857:             ENDIF
1858:             *-- GravarFaixas ja exibe o motivo real do SQL Server quando
1859:             *-- falha (regra #20) - nao ha ELSE/MsgErro adicional aqui, senao
1860:             *-- a mensagem sairia duplicada.
1861:         ENDIF
1862: 
1863:         THIS.ReabilitarFormPai()
1864:         THIS.Release()
1865:     ENDPROC
1866: 
1867: 
1868:     *==========================================================================
1869:     * BtnEncerrarClick - alias PUBLIC para o harness de teste automatizado
1870:     *
1871:     * O handler real chama-se CmdEncerrarClick, nomeado pelo objeto
1872:     * cmd_4c_Encerrar (convencao deste form - PILAR 3). O teste
1873:     * 'BtnEncerrarExiste' da etapa 06b procura, por PEMSTATUS, um metodo
1874:     * chamado BtnEncerrarClick / BtnFecharClick / BtnSairClick /
1875:     * FecharDialogo: sem nenhum deles, o teste reprova mesmo com o
1876:     * encerramento funcionando. Wrapper FINO, que so delega - duplicar aqui a
1877:     * gravacao ou o Release criaria uma SEGUNDA porta de saida, com risco de
1878:     * as duas divergirem. Mesmo padrao de FormSigOpCrd.BtnEncerrarClick (o
1879:     * dialogo-irmao, mesmo form pai) e de FormFop.
1880:     *==========================================================================
1881:     PROCEDURE BtnEncerrarClick()
1882:         RETURN THIS.CmdEncerrarClick()
1883:     ENDPROC
1884: 
1885: 
1886:     *==========================================================================
1887:     * FormParaBO - leva a LINHA CORRENTE da grade para as properties do BO
1888:     *
1889:     * Nesta tela nao ha campo solto: as tres colunas tem ControlSource, logo
1890:     * "o campo da tela" EH a linha do cursor. A transferencia tem, por isso,
1891:     * duas partes:
1892:     *
1893:     *   1. FLUSH da celula em edicao. O valor que o usuario acabou de digitar
1894:     *      vive em <celula>.Value e so chega ao cursor quando o foco SAI da
1895:     *      celula (regra #46). Sem este passo, gravar com o cursor ainda
1896:     *      dentro da celula perderia a ultima digitacao - sem erro e sem log.
1897:     *   2. CarregarDoCursor: a linha inteira (as tres colunas visiveis mais
1898:     *      cidchaves e dopes, que nao aparecem na tela) vai para o BO. A
1899:     *      lista de colunas fica, assim, em UM lugar so - o BO.
1900:     *
1901:     * ActiveColumn devolve 0 enquanto a grade nunca recebeu foco (property
1902:     * conferida em automation\propriedades_baseclasses.txt - regra #33); o
1903:     * guard de 1..3 cobre esse caso e tambem um ColumnCount diferente de 3.
1904:     *
1905:     * DO CASE com nomes de campo LITERAIS, de proposito: REPLACE com nome
1906:     * montado funcionaria, mas sao tres pares fixos e escrever os nomes
1907:     * elimina qualquer duvida sobre o campo atingido - esta eh a unica
1908:     * escrita que este metodo faz no cursor.
1909:     *
1910:     * PROTECTED EXPLICITO, e nao eh escolha de estilo: FormBase declara
1911:     * PROTECTED PROCEDURE FormParaBO e o VFP9 NAO deixa a subclasse ALARGAR o
1912:     * escopo - escrever sem o modificador nao torna publico, so esconde que
1913:     * continua protegido (regra #51). PEMSTATUS(...,5) nao ajuda a descobrir
1914:     * isso: ele responde "existe?", nao "da para chamar daqui?" (regra #3).
1915:     *==========================================================================
1916:     PROTECTED PROCEDURE FormParaBO()
1917:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_nAtiva
1918:         LOCAL loc_oColuna, loc_cControle, loc_oCelula, loc_uValor, loc_oErro
1919: 
1920:         loc_lSucesso = .F.
1921: 
1922:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1923:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1924:             RETURN .F.
1925:         ENDIF
1926: 
1927:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1928: 
1929:         IF !USED(loc_cAlias)
1930:             *-- Sem cursor nao ha linha corrente a transferir. Nao eh erro:
1931:             *-- acontece em modo de teste, antes da primeira carga.
1932:             RETURN .F.
1933:         ENDIF
1934: 
1935:         loc_oGrade = THIS.grd_4c_Dados
1936: 
1937:         TRY
1938:             SELECT (loc_cAlias)
1939: 
1940:             IF !EOF()
1941:                 loc_nAtiva = loc_oGrade.ActiveColumn
1942: 
1943:                 IF loc_nAtiva >= 1 AND loc_nAtiva <= 3 ;
1944:                    AND loc_nAtiva <= loc_oGrade.ColumnCount
1945:                     loc_oColuna   = loc_oGrade.Columns(loc_nAtiva)
1946:                     loc_cControle = ALLTRIM(NVL(loc_oColuna.CurrentControl, ""))
1947:                     loc_oCelula   = .NULL.
1948: 
1949:                     *-- Membro alcancado por NOME: EVALUATE na LEITURA, nunca
1950:                     *-- Controls(<nome>) - Controls eh indexado por NUMERO e o
1951:                     *-- nome estoura em runtime (regra #34).
1952:                     IF !EMPTY(loc_cControle) ;
1953:                        AND PEMSTATUS(loc_oColuna, loc_cControle, 5)
1954:                         loc_oCelula = EVALUATE("loc_oColuna." + loc_cControle)
1955:                     ENDIF
1956: 

*-- Linhas 1991 a 2115:
1991:             MsgErro("Erro ao transferir a faixa de deprecia" + CHR(231) + CHR(227) + "o da tela:" + CHR(13) + ;
1992:                     loc_oErro.Message + CHR(13) + ;
1993:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1994:                     "Procedure: " + loc_oErro.Procedure, ;
1995:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
1996:             loc_lSucesso = .F.
1997:         ENDTRY
1998: 
1999:         RETURN loc_lSucesso
2000:     ENDPROC
2001: 
2002: 
2003:     *==========================================================================
2004:     * BOParaForm - escreve as properties do BO na LINHA CORRENTE da grade
2005:     *
2006:     * Sentido inverso do FormParaBO, com o MESMO par coluna/campo de
2007:     * VincularGrade. Como as colunas tem ControlSource, escrever no CURSOR eh
2008:     * escrever "no campo da tela" - nao existe .Value avulso a atualizar; o
2009:     * que falta depois eh so repintar, porque mexer no cursor NAO repinta a
2010:     * grade (regra #21).
2011:     *
2012:     * SO as TRES colunas visiveis sao escritas. cidchaves e dopes ficam de
2013:     * fora de proposito: eles sao a IDENTIDADE da linha (a chave gerada por
2014:     * fUniqueIds no InserirLinhaCursor e a operacao dona das faixas), nao
2015:     * campos de tela. Sobrescreve-los aqui trocaria a linha de registro - ou,
2016:     * pior, a deixaria com dopes vazio, que eh justamente o que o
2017:     * "Delete For Empty(Dopes)" do Encerrar legado joga fora.
2018:     *
2019:     * GUARDA DE IDENTIDADE: com this_cCidChaves preenchido, a escrita so
2020:     * acontece se a linha corrente for essa mesma. O BO eh carregado linha a
2021:     * linha pelo SCAN de GravarFaixas, entao sem essa conferencia uma chamada
2022:     * fora de hora escreveria os valores de uma faixa sobre outra. Com
2023:     * this_cCidChaves VAZIO (o que LimparDados produz) a guarda nao se
2024:     * aplica: ali a intencao eh justamente zerar a linha corrente.
2025:     *
2026:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase declara
2027:     * PROTECTED PROCEDURE BOParaForm e o escopo vem da HERANCA - omitir o
2028:     * modificador nao alarga nada (regra #51).
2029:     *==========================================================================
2030:     PROTECTED PROCEDURE BOParaForm()
2031:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_cChaveBO, loc_oErro
2032: 
2033:         loc_lSucesso = .F.
2034: 
2035:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2036:             RETURN .F.
2037:         ENDIF
2038: 
2039:         loc_oBO      = THIS.this_oBusinessObject
2040:         loc_cAlias   = ALLTRIM(loc_oBO.this_cCursorDados)
2041:         loc_cChaveBO = ALLTRIM(NVL(loc_oBO.this_cCidChaves, ""))
2042: 
2043:         IF !USED(loc_cAlias)
2044:             RETURN .F.
2045:         ENDIF
2046: 
2047:         TRY
2048:             SELECT (loc_cAlias)
2049: 
2050:             DO CASE
2051:             CASE EOF()
2052:                 *-- Sem linha corrente nao ha o que escrever.
2053:                 loc_lSucesso = .F.
2054: 
2055:             CASE !EMPTY(loc_cChaveBO) ;
2056:                  AND ALLTRIM(NVL(cidchaves, "")) != loc_cChaveBO
2057:                 *-- A linha corrente nao eh a que o BO carregou.
2058:                 loc_lSucesso = .F.
2059: 
2060:             OTHERWISE
2061:                 REPLACE qtddis WITH loc_oBO.this_nQtddis, ;
2062:                         qtddfs WITH loc_oBO.this_nQtddfs, ;
2063:                         percs  WITH loc_oBO.this_nPercs   ;
2064:                     IN (loc_cAlias)
2065: 
2066:                 THIS.RepintarGrade()
2067: 
2068:                 loc_lSucesso = .T.
2069:             ENDCASE
2070:         CATCH TO loc_oErro
2071:             THIS.this_cMensagemErro = loc_oErro.Message
2072:             MsgErro("Erro ao exibir a faixa de deprecia" + CHR(231) + CHR(227) + "o na grade:" + CHR(13) + ;
2073:                     loc_oErro.Message + CHR(13) + ;
2074:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2075:                     "Procedure: " + loc_oErro.Procedure, ;
2076:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
2077:             loc_lSucesso = .F.
2078:         ENDTRY
2079: 
2080:         RETURN loc_lSucesso
2081:     ENDPROC
2082: 
2083: 
2084:     *==========================================================================
2085:     * HabilitarCampos - abre ou fecha a digitacao na grade
2086:     *
2087:     * O UNICO campo de entrada desta tela eh a grade, entao "habilitar
2088:     * campos" aqui eh abrir/fechar a grade e as suas tres colunas.
2089:     *
2090:     * NAO HA GATE POR MODO, e isso eh transcricao, nao esquecimento. O legado
2091:     * condiciona ao PcEscolha apenas o cmdExcluir:
2092:     *     .cmdExcluir.Visible = fChecaAcesso('SigOpDup','EXCLUIR') And ;
2093:     *                           Iif( Type( 'Thisform.PcEscolha' ) # 'C', .T., ;
2094:     *                           InList( Thisform.PcEscolha, 'INSERIR', 'ALTERAR' ) )
2095:     * A GRADE continua editavel em TODOS os modos - inclusive em PROCURAR, em
2096:     * que digitar na ultima coluna faz o LostFocus chamar inserelinha, que
2097:     * liga lHouveIns e portanto FAZ a tela gravar. Fechar a grade por modo
2098:     * REMOVERIA uma capacidade que o legado tem (PILAR 1), entao o unico
2099:     * criterio aqui eh o parametro.
2100:     *
2101:     * Grid.ReadOnly vem ANTES de Column.ReadOnly: o do grid PROPAGA para as
2102:     * colunas e sobrescreveria o que fosse posto antes (regras #18 e #46). As
2103:     * TRES colunas sao reabertas, nao apenas as duas que InstalarCelulasDpe
2104:     * toca - Column1 segue com o Text1 nativo e, sem esta passagem, ficaria
2105:     * com o ReadOnly que o grid acabou de propagar.
2106:     *
2107:     * Os botoes NAO entram no caminho de HABILITAR: quem decide o Excluir eh
2108:     * a permissao resolvida pelo BO, e a fonte unica dela eh
2109:     * AjustarBotoesPorModo. No caminho de FECHAR o Excluir acompanha a grade
2110:     * (nao faz sentido apagar linha de uma grade congelada) e o Encerrar fica
2111:     * SEMPRE ativo - o form nao tem barra de titulo e desabilita-lo prenderia
2112:     * o usuario.
2113:     *
2114:     * par_lHabilitar ausente eh tratado como .T.: o harness chama sem
2115:     * argumento. O teste eh PCOUNT(), nunca VARTYPE - em VFP9 parametro NAO

*-- Linhas 2121 a 2317:
2121:     * escopo herdado a respeitar - ao contrario de FormParaBO / BOParaForm /
2122:     * LimparCampos, que sao PROTECTED na base (regra #51).
2123:     *==========================================================================
2124:     PROCEDURE HabilitarCampos(par_lHabilitar)
2125:         LOCAL loc_lHabilitar, loc_nI, loc_oGrade, loc_oErro
2126: 
2127:         loc_lHabilitar = .T.
2128: 
2129:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
2130:             loc_lHabilitar = par_lHabilitar
2131:         ENDIF
2132: 
2133:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2134:             RETURN .F.
2135:         ENDIF
2136: 
2137:         loc_oGrade = THIS.grd_4c_Dados
2138: 
2139:         TRY
2140:             loc_oGrade.Enabled = loc_lHabilitar
2141: 
2142:             *-- Grid PRIMEIRO - ele propaga para as colunas
2143:             loc_oGrade.ReadOnly = !loc_lHabilitar
2144: 
2145:             FOR loc_nI = 1 TO MIN(3, loc_oGrade.ColumnCount)
2146:                 loc_oGrade.Columns(loc_nI).ReadOnly = !loc_lHabilitar
2147:             ENDFOR
2148: 
2149:             IF loc_lHabilitar
2150:                 *-- A permissao do Excluir tem fonte UNICA
2151:                 THIS.AjustarBotoesPorModo()
2152:             ELSE
2153:                 IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2154:                     THIS.cmd_4c_Excluir.Enabled = .F.
2155:                 ENDIF
2156:             ENDIF
2157:         CATCH TO loc_oErro
2158:             THIS.this_cMensagemErro = loc_oErro.Message
2159:             MsgErro("Erro ao ajustar a digita" + CHR(231) + CHR(227) + "o da grade:" + CHR(13) + ;
2160:                     loc_oErro.Message + CHR(13) + ;
2161:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2162:                     "Procedure: " + loc_oErro.Procedure, ;
2163:                     "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
2164:         ENDTRY
2165: 
2166:         RETURN .T.
2167:     ENDPROC
2168: 
2169: 
2170:     *==========================================================================
2171:     * LimparCampos - devolve a linha corrente ao estado "em branco"
2172:     *
2173:     * A linha em branco desta tela eh, por definicao do legado, a que tem
2174:     * qtddfs = 0: eh esse o criterio do "Locate for Qtddfs=0" do inserelinha,
2175:     * do LostFocus da Column3 e do "Delete For ... Empty(Qtddfs)" do
2176:     * Encerrar. Limpar a linha corrente eh, portanto, zerar as tres colunas
2177:     * visiveis - e eh exatamente o estado em que InserirLinhaCursor cria uma
2178:     * linha nova.
2179:     *
2180:     * Composto a partir dos dois hooks, sem duplicar a lista de campos: o BO
2181:     * zera as properties (LimparDados preserva this_cOperacao, entao dopes
2182:     * continua resolvido) e BOParaForm leva isso para a linha e repinta. Como
2183:     * LimparDados tambem esvazia this_cCidChaves, a guarda de identidade do
2184:     * BOParaForm fica fora de alcance e a escrita atinge a linha CORRENTE,
2185:     * que eh a intencao aqui.
2186:     *
2187:     * cidchaves e dopes da LINHA nao sao tocados - a linha continua sendo a
2188:     * mesma, so vazia. Zerar a chave faria a linha perder identidade e o
2189:     * Encerrar a trataria como lixo a descartar.
2190:     *
2191:     * Nenhum caminho do legado chama isto: o SCX nao tem botao de limpar. O
2192:     * metodo existe como hook canonico de transferencia (FormBase o declara
2193:     * e o chama por THIS. nos seus proprios fluxos); NAO foi ligado a botao
2194:     * algum, porque criar um botao de limpar seria inventar superficie que a
2195:     * tela nao tem.
2196:     *
2197:     * PROTECTED EXPLICITO: FormBase declara PROTECTED PROCEDURE LimparCampos,
2198:     * e o escopo herdado nao se alarga - ver o cabecalho do FormParaBO.
2199:     *==========================================================================
2200:     PROTECTED PROCEDURE LimparCampos()
2201:         LOCAL loc_lSucesso
2202: 
2203:         loc_lSucesso = .F.
2204: 
2205:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2206:             RETURN .F.
2207:         ENDIF
2208: 
2209:         THIS.this_oBusinessObject.LimparDados()
2210: 
2211:         loc_lSucesso = THIS.BOParaForm()
2212: 
2213:         RETURN loc_lSucesso
2214:     ENDPROC
2215: 
2216: 
2217:     *==========================================================================
2218:     * AtualizarEstadoControles - hook chamado por FormBase.Init() no final
2219:     *
2220:     * Este dialogo nao tem os cinco botoes CRUD de um cadastro: o dump tem
2221:     * apenas cmdExcluir e cmdSair. O override existe para o hook da base nao
2222:     * cair no comportamento de cadastro, e redireciona para os dois ajustes
2223:     * que esta tela de fato tem.
2224:     *
2225:     * Roda DEPOIS de InicializarForm, que ja chamou AjustarBotoesPorModo. A
2226:     * repeticao eh deliberada e inofensiva (o metodo so espelha
2227:     * this_lPodeExcluir): garante o ajuste mesmo que algum caminho futuro
2228:     * chegue aqui sem ter passado por ele.
2229:     *
2230:     * HabilitarCampos(.T.) no fim porque TornarControlesVisiveis acabou de
2231:     * forcar Visible = .T. em tudo: reabrir a digitacao aqui garante
2232:     * Grid.ReadOnly = .F. e as tres colunas abertas, que eh o estado do
2233:     * legado em TODOS os modos (ver o cabecalho de HabilitarCampos).
2234:     * AjustarBotoesPorModo vem ANTES do HabilitarCampos(.T.) so por clareza:
2235:     * o caminho de habilitar ja o chama de novo, e ele eh idempotente.
2236:     *==========================================================================
2237:     PROCEDURE AtualizarEstadoControles()
2238:         LOCAL loc_lSucesso
2239: 
2240:         loc_lSucesso = THIS.AjustarBotoesPorModo()
2241: 
2242:         THIS.HabilitarCampos(.T.)
2243: 
2244:         RETURN loc_lSucesso
2245:     ENDPROC
2246: 
2247: 
2248:     *==========================================================================
2249:     * Destroy - libera o pai e o BO
2250:     *
2251:     * A reabilitacao do pai vem ANTES de soltar o BO: se algo falhasse ali, o
2252:     * usuario ainda ficaria com o cadastro de Operacoes utilizavel.
2253:     * DODEFAULT() eh a ULTIMA linha - FormBase.Destroy reconstroi os popups do
2254:     * menu principal, e omiti-lo faz o menu encolher visualmente.
2255:     *==========================================================================
2256:     PROCEDURE Destroy()
2257:         THIS.ReabilitarFormPai()
2258: 
2259:         THIS.this_oFormPai = .NULL.
2260: 
2261:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2262:             THIS.this_oBusinessObject = .NULL.
2263:         ENDIF
2264: 
2265:         DODEFAULT()
2266:     ENDPROC
2267: 
2268: ENDDEFINE
2269: 
2270: 
2271: *==============================================================================
2272: * TextBoxCelulaSigOpDpe_4c - celulas COM EVENTO da grade de depreciacao
2273: *
2274: * Transcreve os dois unicos handlers de celula do SIGOPDPE legado:
2275: *     SIGOPDPE.GradeSubN.Column2.Text1.LostFocus  -> qtddfs
2276: *     SIGOPDPE.GradeSubN.Column3.Text1.LostFocus  -> percs
2277: *
2278: * O evento fica EMBUTIDO na classe, e nao ligado por BINDEVENT: BINDEVENT em
2279: * evento de TextBox dentro de Column nao dispara de forma confiavel no VFP9 -
2280: * eh exatamente o motivo de existir classes\TextBoxGridLookup.prg, que
2281: * documenta isso no cabecalho, e eh o padrao canonico do projeto (regra #46,
2282: * referencia FormLpr.TextBoxProdutoLpr_4c).
2283: *
2284: * A classe NAO decide nada: ela so despacha para o metodo PUBLIC do form, que
2285: * eh onde a regra do legado esta transcrita. Assim a logica fica em UM lugar,
2286: * alcancavel pelo harness, e esta classe segue valendo para as duas colunas
2287: * com a unica diferenca sendo this_cCampo.
2288: *
2289: * THISFORM aqui eh o FormSigOpDpe: a celula eh filha de Column, que eh filha
2290: * de Grid, que eh filho do form. O PEMSTATUS antes de cada chamada protege o
2291: * caso de a classe ser reaproveitada num form que nao tenha o metodo - ali o
2292: * handler vira no-op em vez de estourar "Property ... is not found".
2293: *
2294: * LostFocus NAO recebe parametro (ao contrario de KeyPress, regra #3), por
2295: * isso a assinatura eh vazia. E o form passa THIS adiante porque dentro do
2296: * evento da celula o valor digitado esta em .Value e ainda NAO chegou ao
2297: * cursor - quem valida tem de ler o CONTROLE (regra #46).
2298: *==============================================================================
2299: DEFINE CLASS TextBoxCelulaSigOpDpe_4c AS TextBox
2300:     *-- Coluna do cursor que esta celula edita: "qtddfs" ou "percs".
2301:     *-- Definido por InstalarCelulasDpe, no form.
2302:     this_cCampo = "qtddfs"
2303: 
2304:     PROCEDURE LostFocus()
2305:         DO CASE
2306:             CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "qtddfs"
2307:                 IF PEMSTATUS(THISFORM, "ValidarQtddFinal", 5)
2308:                     THISFORM.ValidarQtddFinal(THIS)
2309:                 ENDIF
2310: 
2311:             CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "percs"
2312:                 IF PEMSTATUS(THISFORM, "ValidarPercs", 5)
2313:                     THISFORM.ValidarPercs(THIS)
2314:                 ENDIF
2315:         ENDCASE
2316:     ENDPROC
2317: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDpeBO.prg):
*==============================================================================
* SigOpDpeBO.prg
*
* Business Object para a Tabela de Depreciacao da Operacao (dialogo modal
* aberto a partir da grade de operacoes do Cadastro de Operacoes - SigCdOpe),
* onde o usuario mantem as faixas de dias (Qtd Dias Inicial / Qtd Dias Final)
* e o percentual de depreciacao aplicado a cada faixa.
*
* Tabela gravada: SigOpDup (chave: cidchaves char(20)):
*
*    [cidchaves] char(20)      NOT NULL   (PK)
*    [dopes]     char(20)      NOT NULL   - operacao dona (SigCdOpe.dopes)
*    [qtddis]    numeric(4,0)  NOT NULL   - Column1 "Qtd Dias Inicial"
*    [qtddfs]    numeric(4,0)  NOT NULL   - Column2 "Qtd Dias Final"
*    [percs]     numeric(5,2)  NOT NULL   - Column3 "%"
*
*------------------------------------------------------------------------------
* MODELO DE GRAVACAO (transcrito do legado)
*
* A tela NAO grava linha a linha: ela acumula as alteracoes no cursor da
* grade (crSigOpDup no legado, cursor_4c_Dados aqui) e persiste TUDO de uma
* vez ao encerrar, no cmdSair.Click:
*
*    Select CrSigOpDup
*    Go Top
*    Delete For Empty(Dopes) or Empty(Qtddfs)
*    Replace CidChaves with fUniqueIds() For Empty(CidChaves)
*    ... poDataMgr.UpDate('crSigOpDup') / Commit() / RollBack()
*
* Os dois marcadores lHouveIns / lHouveExcl do legado SAO properties do FORM
* (RESERVED3 do dump lista lhouveexcl/lhouveins como custom property de
* SIGOPDPE, nao do BO) - por isso ficam em FormSigOpDpe (this_lHouveIns/
* this_lHouveExcl), e este BO so executa a manipulacao de DADOS: quem decide
* se a gravacao chega a ser tentada eh o CmdEncerrarClick do form.
*
* IMPORTANTE (regra #22): as CINCO colunas de SigOpDup sao NOT NULL e nenhuma
* tem DEFAULT (conferido em docs/schema.sql, UTF-16, lido com
* Get-Content -Raw). A gravacao cobre todas as cinco.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado nao tem botao de Alterar nem de Buscar: a grade ja abre editavel
* e o unico botao de acao, alem do Encerrar, eh o Excluir (apaga a linha
* corrente do cursor). A remocao definitiva no servidor acontece junto com a
* gravacao do Encerrar, por reconciliacao do conjunto de linhas da operacao,
* e nao por um DELETE disparado a cada clique: ExcluirLinhaCursor apenas marca
* a linha, e GravarFaixas traduz essa marca em DELETE no servidor, dentro do
* mesmo lote transacional dos INSERT e UPDATE. ExecutarExclusao existe e usa o
* MESMO montador de SQL, para o caso de apagar uma faixa isolada pelo
* Excluir() da BusinessBase - assim a lista de colunas e o criterio da chave
* nao podem divergir entre os dois caminhos.
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDpeBO AS BusinessBase

	*--------------------------------------------------------------------------
	* PROPRIEDADES DA ENTIDADE - SigOpDup
	*--------------------------------------------------------------------------
	this_cCidChaves = ""   && cidchaves char(20)     - PK (fUniqueIds)
	this_cDopes     = ""   && dopes     char(20)     - operacao dona
	this_nQtddis    = 0    && qtddis    numeric(4,0) - Column1 "Qtd Dias Inicial"
	this_nQtddfs    = 0    && qtddfs    numeric(4,0) - Column2 "Qtd Dias Final"
	this_nPercs     = 0    && percs     numeric(5,2) - Column3 "%"

	*--------------------------------------------------------------------------
	* CONTEXTO RECEBIDO DO FORM PAI
	*
	* Legado: lcOperacao = crSigCdOpe.Dopes, lido no Init a partir do cursor
	* da operacao que o cadastro de Tipos de Operacao mantem aberto. Aqui o
	* valor chega por parametro e fica guardado nesta property, que eh a
	* FONTE UNICA da coluna dopes de toda linha nova.
	*--------------------------------------------------------------------------
	this_cOperacao = ""         && Dopes da operacao corrente (contexto)
	this_cEscolha  = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR

	*--------------------------------------------------------------------------
	* PERMISSAO DE EXCLUSAO
	*
	* Legado: .cmdExcluir.Visible = fChecaAcesso('SigOpDup','EXCLUIR') And ;
	*                               InList(PcEscolha,'INSERIR','ALTERAR')
	* Resolvida uma vez e guardada aqui, para o form apenas espelhar no
	* Visible/Enabled do botao.
	*--------------------------------------------------------------------------
	this_lPodeExcluir = .F.

	*--------------------------------------------------------------------------
	* CURSORES DE TRABALHO
	*
	* this_cCursorDados eh o alias ligado ao RecordSource da grade - o mesmo
	* papel do crSigOpDup legado. NUNCA receber SQLEXEC direto: SQLEXEC sobre
	* o alias de um Grid fecha e recria o alias, zerando ColumnCount e
	* deixando a grade um retangulo branco. A carga passa por
	* this_cCursorTemp e eh transferida com ZAP + APPEND FROM DBF().
	*
	* A grade tem coluna EDITAVEL, portanto o cursor de dados precisa ser
	* READWRITE - cursor de SQL pass-through nasce somente-leitura e o
	* REPLACE da edicao estouraria.
	*--------------------------------------------------------------------------
	this_cCursorDados = "cursor_4c_Dados"       && alias do Grid (READWRITE)
	this_cCursorTemp  = "cursor_4c_DadosTmp"    && destino do SQLEXEC

	*--------------------------------------------------------------------------
	* ACOMPANHAMENTO DA GRAVACAO
	*--------------------------------------------------------------------------
	this_nRegistrosInseridos   = 0
	this_nRegistrosAtualizados = 0
	this_nRegistrosExcluidos   = 0

	*--------------------------------------------------------------------------
	* LOTE DE COMANDOS SQL
	*
	* A gravacao do Encerrar abrange varias linhas e tem de ser ATOMICA, como
	* o par Update/Commit-RollBack do poDataMgr legado. Os comandos sao
	* acumulados aqui e executados num unico bloco transacional.
	*--------------------------------------------------------------------------
	this_cLoteGravacao = ""

	*--------------------------------------------------------------------------
	* COLUNAS DO CURSOR DA GRADE - fonte UNICA
	*
	* lnovos NAO eh coluna de SigOpDup: eh o marcador de linha ainda nao
	* gravada no servidor. O legado obtinha essa distincao de graca, porque o
	* crSigOpDup era cursor REMOTO e o poDataMgr.UpDate sabia separar INSERT
	* de UPDATE de DELETE. Aqui a grade vive num CREATE CURSOR comum, logo a
	* distincao tem de ser carregada explicitamente.
	*--------------------------------------------------------------------------
	this_cColunasTabela = "cidchaves,dopes,qtddis,qtddfs,percs"
	this_cColunaNovos   = "lnovos"

	*--------------------------------------------------------------------------
	* CONTROLE DA TRANSACAO DO LOTE
	*
	* BEGIN/COMMIT enviados em SQLEXEC separados NAO protegem nada neste
	* ambiente: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
	* portanto um BEGIN proprio apenas ANINHA e o COMMIT correspondente volta
	* para 1 sem efetivar. Dai o SAVE TRANSACTION com nome proprio quando ja
	* ha transacao aberta e o THROW no CATCH, que faz o erro chegar ao
	* retorno do SQLEXEC e deixa CapturarErroSQL() com o texto real do SQL
	* Server.
	*--------------------------------------------------------------------------
	this_cNomeSavepoint = "SigOpDpe4c"

	*--------------------------------------------------------------------------
	* this_lCursorRecriado - avisa ao form que o alias do Grid foi FECHADO e
	* criado de novo, e que portanto RecordSource e os ControlSource das
	* Columns precisam ser religados.
	*--------------------------------------------------------------------------
	this_lCursorRecriado = .F.

	*==========================================================================
	* Init - Inicializa Business Object
	*
	* par_cOperacao - Dopes da operacao dona das faixas (crSigCdOpe.Dopes no
	*                 legado). Opcional: o form pode informar depois, pela
	*                 property this_cOperacao, antes da primeira carga.
	* par_cEscolha  - PcEscolha herdado do form pai. Vazio equivale a
	*                 "INSERIR", como o IIF(EMPTY(...)) do legado.
	*==========================================================================
	PROCEDURE Init(par_cOperacao, par_cEscolha)
		LOCAL loc_lSucesso, loc_cOperacao, loc_cEscolha, loc_oErro
		loc_lSucesso = .F.

		TRY
			DODEFAULT()

			THIS.this_cTabela     = "SigOpDup"
			THIS.this_cCampoChave = "cidchaves"

			loc_cOperacao = ""
			IF VARTYPE(par_cOperacao) = "C"
				loc_cOperacao = ALLTRIM(par_cOperacao)
			ENDIF
			THIS.this_cOperacao = loc_cOperacao
			THIS.this_cDopes    = loc_cOperacao

			loc_cEscolha = ""
			IF VARTYPE(par_cEscolha) = "C"
				loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
			ENDIF
			IF EMPTY(loc_cEscolha)
				loc_cEscolha = "INSERIR"
			ENDIF
			THIS.this_cEscolha = loc_cEscolha

			*-- Permissao de exclusao: fChecaAcesso + modo editavel (legado)
			THIS.this_lPodeExcluir = fChecaAcesso("SigOpDup", "EXCLUIR") ;
									  AND INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

			THIS.this_nRegistrosInseridos   = 0
			THIS.this_nRegistrosAtualizados = 0
			THIS.this_nRegistrosExcluidos   = 0
			THIS.this_cLoteGravacao         = ""

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "SigOpDpeBO.Init")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InicializarValoresPadrao - defaults da LINHA NOVA
	*
	* Transcricao do Insert Into do inserelinha legado:
	*    Insert Into crSigOpDup (Dopes, CidChaves) ;
	*        Values (crSigCdOpe.Dopes, fUniqueIds())
	*==========================================================================
	PROTECTED PROCEDURE InicializarValoresPadrao()
		THIS.this_cCidChaves = fUniqueIds()
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna a chave (cidchaves) da faixa para
	* auditoria (regra #51 - PROTECTED, so o Excluir()/Salvar() da base
	* chamam)
	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC


	*==========================================================================
	* CriarCursorDados - prepara o cursor READWRITE ligado ao Grid
	*
	* O cursor TEM de ser READWRITE: a grade desta tela eh editavel e cursor
	* de SQL pass-through nasce SOMENTE-LEITURA - o REPLACE da edicao
	* estouraria. Por isso o alias da grade nunca recebe SQLEXEC: a carga
	* passa pelo cursor temporario (ver CarregarFaixas).
	*
	* Ponto UNICO de CREATE CURSOR desta tela. A ordem e a grafia das colunas
	* tem de ser identicas em todo lugar que mencione o cursor, porque o
	* APPEND FROM DBF() casa por NOME.
	*
	* Larguras conferidas em docs/schema.sql: numeric(4,0) sem decimal eh
	* N(4,0); numeric(5,2) sao 3 digitos + 2 decimais, que em VFP (onde a
	* largura inclui o ponto) eh N(6,2). Batem com os InputMask do SCX
	* legado ("9999" e "999.99").
	*
	* par_lForcarRecriar - .T. derruba e recria o alias mesmo que ele exista.
	*                      Quem chamar assim fica responsavel por religar o
	*                      Grid; this_lCursorRecriado avisa que eh o caso.
	*==========================================================================
	PROCEDURE CriarCursorDados(par_lForcarRecriar)
		LOCAL loc_lSucesso, loc_lRecriar, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_lCursorRecriado = .F.

		TRY
			loc_lRecriar = .T.

			IF USED(loc_cAlias)
				loc_lRecriar = .F.

				IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
					loc_lRecriar = .T.
				ENDIF

				*-- Alias herdado de outra tela com estrutura diferente eh pior
				*-- que alias ausente: o ZAP apaga as linhas mas PRESERVA as
				*-- colunas do dono anterior, e o APPEND seguinte falha por
				*-- coluna que esta tela nem conhece.
				IF !loc_lRecriar
					IF !THIS.CursorTemEstruturaEsperada(loc_cAlias)
						loc_lRecriar = .T.
					ENDIF
				ENDIF

				IF loc_lRecriar
					USE IN (loc_cAlias)
				ENDIF
			ENDIF

			IF loc_lRecriar
				CREATE CURSOR (loc_cAlias) ( ;
					cidchaves C(20), ;
					dopes     C(20), ;
					qtddis    N(4, 0), ;
					qtddfs    N(4, 0), ;
					percs     N(6, 2), ;
					lnovos    L )

				THIS.this_lCursorRecriado = .T.
			ENDIF

			*-- SET DELETED eh escopado por data session e o form eh
			*-- DataSession = 2: o SET DELETED ON do config.prg roda na sessao
			*-- 1 e NAO alcanca a sessao privada, que nasce com DELETED OFF.
			*-- Sem repor aqui, o DELETE do botao Excluir apenas MARCA a linha
			*-- e ela continua aparecendo na grade - o usuario clica Excluir e
			*-- nada some, sem erro e sem log.
			SET DELETED ON

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao preparar o cursor da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CursorTemEstruturaEsperada - confere se o alias tem as colunas desta tela
	*
	* PEMSTATUS NAO serve para isto: o primeiro argumento tem de ser OBJETO, e
	* passar nome de cursor dispara "Function argument value, type, or count
	* is invalid.". Campo de cursor se confere com TYPE(alias + ".campo").
	*==========================================================================
	PROTECTED FUNCTION CursorTemEstruturaEsperada(par_cAlias)
		LOCAL loc_lOk, loc_cLista, loc_cAlias, loc_cCampo, loc_nI, loc_nTotal

		loc_lOk    = .T.
		loc_cAlias = ALLTRIM(NVL(par_cAlias, ""))
		loc_cLista = ALLTRIM(THIS.this_cColunasTabela) + "," + ALLTRIM(THIS.this_cColunaNovos)

		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
			loc_lOk = .F.
		ELSE
			loc_nTotal = OCCURS(",", loc_cLista) + 1

			FOR loc_nI = 1 TO loc_nTotal
				loc_cCampo = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))

				IF !EMPTY(loc_cCampo)
					IF TYPE(loc_cAlias + "." + loc_cCampo) = "U"
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDIF
			ENDFOR
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarFaixas - traz as faixas de depreciacao da operacao corrente
	*
	* Equivale ao trecho de carga do Init legado:
	*     With SigCdOpe.poDatamgr
	*         .ReQuery('crSigOpDup') / SELECT crSigOpDup / Go Top
	*     EndWith
	*
	* O SELECT vai para um cursor TEMPORARIO e o conteudo eh transferido com
	* ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias do Grid FECHA e
	* RECRIA o alias, zerando ColumnCount: a grade viraria um retangulo
	* branco sem cabecalho e sem coluna, e nada a religaria depois.
	*
	* Filtro por dopes, como o cursor parametrizado do legado - esta tela
	* edita as faixas de UMA operacao. Sem operacao no contexto, cursor vazio
	* eh o resultado CERTO.
	*==========================================================================
	PROCEDURE CarregarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasTmp
		LOCAL loc_cSQL, loc_nResultado, loc_cSafety, loc_oErro

		loc_lSucesso    = .F.
		loc_lProsseguir = .T.
		loc_cAlias      = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)
		loc_cSafety     = ""

		THIS.this_cMensagemErro = ""

		TRY
			IF !THIS.CriarCursorDados()
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(NVL(THIS.this_cOperacao, "")))
					*-- Grade vazia com a estrutura pronta: nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
					*-- Sem conexao (modo de teste / validacao de UI) a grade
					*-- abre vazia, e isso tambem nao eh falha.
					loc_lProsseguir = .F.
					loc_lSucesso    = .T.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- Comparacao sem RTRIM de proposito: dopes eh char(20) e o
				*-- SQL Server compara char com preenchimento de brancos
				*-- (ANSI), entao o = casa e o indice segue utilizavel.
				loc_cSQL = "SELECT cidchaves, dopes, qtddis, qtddfs, percs" + ;
						   " FROM SigOpDup" + ;
						   " WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao)) + ;
						   " ORDER BY qtddis, qtddfs"

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + ;
						"o da opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
					THIS.this_lErroExibido = .T.
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				*-- SET SAFETY tambem eh escopado por data session: com
				*-- DataSession = 2 vale ON mesmo com o SET SAFETY OFF do
				*-- main.prg, e ai o ZAP abre o dialogo modal "Are you sure?"
				*-- e CONGELA a tela esperando um clique que ninguem ve.
				loc_cSafety = SET("SAFETY")
				SET SAFETY OFF

				SELECT (loc_cAlias)
				ZAP

				IF loc_cSafety = "ON"
					SET SAFETY ON
				ENDIF
				loc_cSafety = ""

				*-- lnovos chega .F. em toda linha do servidor, porque o APPEND
				*-- casa por NOME e o cursor temporario nao tem essa coluna -
				*-- que eh exatamente o desejado: linha vinda do banco eh
				*-- UPDATE na gravacao, nunca INSERT.
				SELECT (loc_cAlias)
				APPEND FROM DBF(loc_cAliasTmp)

				SELECT (loc_cAlias)
				GO TOP

				IF USED(loc_cAliasTmp)
					USE IN (loc_cAliasTmp)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao carregar a tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirLinhaCursor - acrescenta a linha EM BRANCO de digitacao
	*
	* Transcricao da parte de DADOS do inserelinha legado:
	*     Select crSigOpDup
	*     Locate for Qtddfs=0
	*     If Eof()
	*         Insert Into crSigOpDup (Dopes, CidChaves) ;
	*             Values (crSigCdOpe.Dopes, fUniqueIds())
	*     EndIf
	*     Select crSigOpDup
	*
	* O marcador Thisform.lHouveIns = .T. do legado eh property do FORM (ver
	* cabecalho) e fica em FormSigOpDpe.InserirLinhaCursor, NAO aqui - este
	* metodo so cuida do CURSOR.
	*
	* O Keyboard '{DNARROW}', o GradeSubN.Refresh e o Column1.SetFocus do
	* legado sao da TELA e ficam no form.
	*
	* A linha nasce so com dopes e cidchaves; a coluna qtddfs fica no valor em
	* branco do cursor, que eh zero - e eh justamente qtddfs = 0 que marca a
	* linha como "em branco", tanto para o LOCATE daqui quanto para o
	* descarte da gravacao.
	*==========================================================================
	PROCEDURE InserirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)
				LOCATE FOR qtddfs = 0

				IF EOF()
					INSERT INTO (loc_cAlias) (cidchaves, dopes, lnovos) ;
						VALUES (LEFT(fUniqueIds(), 20), ;
								LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20), ;
								.T.)
				ENDIF

				SELECT (loc_cAlias)
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao inserir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExcluirLinhaCursor - remove a linha corrente da grade (cmdExcluir.Click)
	*
	* Transcricao da parte de DADOS do cmdExcluir.Click legado:
	*     Select crSigOpDup
	*     If Not Eof()
	*         Thisform.lHouveExcl = .T.
	*         Delete
	*         Skip
	*         Skip - 1
	*     Endif
	*
	* O marcador lHouveExcl eh property do FORM (ver cabecalho) - este metodo
	* devolve .T. quando de fato excluiu (a mesma condicao "Not Eof()" que
	* abre o bloco legado), e o form decide ligar o marcador a partir disso.
	*
	* A remocao eh LOCAL: no legado o DELETE so chega ao servidor junto com a
	* gravacao do Encerrar - o poDataMgr.UpDate propaga INSERT, UPDATE e
	* DELETE do cursor remoto de uma vez. GravarFaixas reproduz isso.
	*
	* O par Skip / Skip -1 reposiciona o ponteiro no registro visivel mais
	* proximo e depende de SET DELETED ON, reposto em CriarCursorDados.
	*==========================================================================
	PROCEDURE ExcluirLinhaCursor()
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

		THIS.this_cMensagemErro = ""

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
			ELSE
				SELECT (loc_cAlias)

				IF !EOF()
					loc_lSucesso = .T.
					DELETE
					SKIP
					SKIP -1
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro ao excluir a linha da tabela de deprecia" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* GravarFaixas - persiste TODAS as faixas de uma vez (cmdSair.Click legado)
	*
	* Transcricao do cmdSair.Click legado:
	*     Select CrSigOpDup
	*     Go Top
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*     ... poDataMgr.UpDate / Commit / RollBack ...
	*     erro -> MessageBox de "Erro na Gravacao dos Dados do Cadastro de Operacoes."
	*
	* O poDataMgr.UpDate de um cursor REMOTO propaga as tres operacoes de uma
	* vez: INSERT das linhas acrescentadas, UPDATE das alteradas e DELETE das
	* marcadas. Aqui a grade vive num CREATE CURSOR comum, entao a
	* reconciliacao eh explicita - e eh para isso que lnovos existe:
	*
	*     linha marcada DELETED, lnovos = .F.  -> DELETE no servidor
	*     linha marcada DELETED, lnovos = .T.  -> nada (nunca foi gravada)
	*     linha viva, lnovos = .T.             -> INSERT
	*     linha viva, lnovos = .F.             -> UPDATE
	*
	* O GUARD "Thisform.lHouveExcl Or Thisform.lHouveIns" do legado mora no
	* CmdEncerrarClick do form (ele eh property do form) - este metodo roda
	* incondicionalmente, varrendo o cursor.
	*==========================================================================
	PROCEDURE GravarFaixas()
		LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasAnterior
		LOCAL loc_cDeleted, loc_nRecnoAnterior, loc_cComando, loc_oErro

		loc_lSucesso       = .T.
		loc_lProsseguir    = .T.
		loc_cAlias         = ALLTRIM(THIS.this_cCursorDados)
		loc_cAliasAnterior = ALIAS()
		loc_cDeleted       = ""
		loc_nRecnoAnterior = 0

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.
		THIS.this_cLoteGravacao = ""

		THIS.this_nRegistrosInseridos   = 0
		THIS.this_nRegistrosAtualizados = 0
		THIS.this_nRegistrosExcluidos   = 0

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor da tabela de deprecia" + CHR(231) + CHR(227) + ;
					"o n" + CHR(227) + "o est" + CHR(225) + " aberto."
				MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
				THIS.this_lErroExibido = .T.
				loc_lProsseguir = .F.
				loc_lSucesso    = .F.
			ENDIF

			IF loc_lProsseguir
				*-- RECNO guardado junto com o alias: o SCAN abaixo varre o
				*-- cursor inteiro e deixa o ponteiro em EOF. Repor so o alias
				*-- devolveria a area de trabalho certa com a LINHA errada, e
				*-- a grade do usuario mudaria de registro sozinha.
				loc_nRecnoAnterior = RECNO(loc_cAlias)

				*-- Descarte do legado: linha sem operacao, ou com qtd dias
				*-- final zerada (a linha "em branco" de digitacao), nao eh
				*-- gravada.
				SELECT (loc_cAlias)
				GO TOP
				DELETE FOR EMPTY(dopes) OR qtddfs = 0

				*-- A PK eh gerada por LINHA. Cada registro recebe um valor
				*-- proprio porque o VFP reavalia a expressao do WITH a cada
				*-- registro - chave repetida colidiria no indice unico a
				*-- partir da segunda linha.
				REPLACE cidchaves WITH LEFT(fUniqueIds(), 20) ;
					FOR EMPTY(cidchaves) IN (loc_cAlias)

				*-- DELETED OFF para o SCAN VER as linhas marcadas: sao elas
				*-- que viram DELETE no servidor. Reposto apos a varredura.
				loc_cDeleted = SET("DELETED")
				SET DELETED OFF

				SELECT (loc_cAlias)
				GO TOP

				SCAN
					loc_cComando = ""

					IF DELETED()
						*-- Linha removida da grade. Se nunca foi gravada, nao
						*-- existe no servidor e nada ha a apagar la.
						IF !lnovos AND !EMPTY(cidchaves)
							THIS.CarregarDoCursor(loc_cAlias)
							loc_cComando = THIS.MontarDeleteLinha()

							IF EMPTY(loc_cComando)
								MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
								THIS.this_lErroExibido = .T.
								loc_lProsseguir = .F.
								loc_lSucesso    = .F.
								EXIT
							ENDIF

							THIS.AcrescentarAoLote(loc_cComando)
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("DELETE"))
							THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
						ENDIF
					ELSE
						THIS.CarregarDoCursor(loc_cAlias)

						*-- Depois do descarte acima nenhuma linha viva deveria
						*-- reprovar. Se reprovar, a gravacao INTEIRA para com
						*-- a mensagem: pular a linha calada gravaria o resto e
						*-- perderia essa sem o usuario saber.
						IF !THIS.ValidarDados()
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						IF lnovos
							loc_cComando = THIS.MontarInsertLinha()
						ELSE
							loc_cComando = THIS.MontarUpdateLinha()
						ENDIF

						IF EMPTY(loc_cComando)
							MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
							THIS.this_lErroExibido = .T.
							loc_lProsseguir = .F.
							loc_lSucesso    = .F.
							EXIT
						ENDIF

						THIS.AcrescentarAoLote(loc_cComando)

						IF lnovos
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("INSERT"))
							THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
						ELSE
							THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("UPDATE"))
							THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
						ENDIF
					ENDIF
				ENDSCAN

				IF loc_cDeleted = "ON"
					SET DELETED ON
				ENDIF
				loc_cDeleted = ""
			ENDIF

			IF loc_lProsseguir
				IF EMPTY(ALLTRIM(THIS.this_cLoteGravacao))
					*-- Nada sobrou: as linhas em aberto eram todas em branco e
					*-- cairam no mesmo descarte do legado.
					loc_lSucesso = .T.
				ELSE
					loc_lSucesso = THIS.ExecutarLoteGravacao()
				ENDIF
			ENDIF

			IF USED(loc_cAlias)
				IF loc_lProsseguir AND loc_lSucesso
					*-- Gravou: as linhas marcadas saem FISICAMENTE do cursor e
					*-- as novas deixam de ser novas. Sem isso, uma segunda
					*-- gravacao reenviaria os mesmos DELETE e repetiria os
					*-- INSERT, colidindo na chave primaria.
					SELECT (loc_cAlias)
					PACK
					REPLACE ALL lnovos WITH .F. IN (loc_cAlias)
					GO TOP IN (loc_cAlias)
				ELSE
					IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(loc_cAlias))
						GO loc_nRecnoAnterior IN (loc_cAlias)
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			IF loc_cDeleted = "ON"
				SET DELETED ON
			ENDIF

			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
				"Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
			SELECT (loc_cAliasAnterior)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* AcrescentarAoLote - enfileira um comando no lote transacional
	*==========================================================================
	PROTECTED FUNCTION AcrescentarAoLote(par_cComando)
		LOCAL loc_lOk, loc_cComando

		loc_lOk      = .F.
		loc_cComando = ALLTRIM(NVL(par_cComando, ""))

		IF !EMPTY(loc_cComando)
			THIS.this_cLoteGravacao = THIS.this_cLoteGravacao + loc_cComando + ;
				";" + CHR(13) + CHR(10)
			loc_lOk = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* ExecutarLoteGravacao - manda o lote num SQLEXEC unico e ATOMICO
	*==========================================================================
	PROTECTED FUNCTION ExecutarLoteGravacao()
		LOCAL loc_lOk, loc_cSQL, loc_cCRLF, loc_cSavepoint
		LOCAL loc_nResultado, loc_lManual

		loc_lOk   = .F.
		loc_cCRLF = CHR(13) + CHR(10)

		IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteGravacao, "")))
			THIS.this_cMensagemErro = "Nada para gravar."
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
			RETURN .F.
		ENDIF

		loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

		*-- Medido: com a conexao em auto-commit o par fica inerte. IF
		*-- ANINHADO mais abaixo de proposito - VFP9 nao faz curto-circuito
		*-- em AND e chamaria o SQLCOMMIT de qualquer jeito.
		loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

		loc_cSQL = "SET NOCOUNT ON;" + loc_cCRLF + ;
			"DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
			"ELSE SAVE TRANSACTION " + loc_cSavepoint + ";" + loc_cCRLF + ;
			"BEGIN TRY" + loc_cCRLF + ;
			THIS.this_cLoteGravacao + ;
			"IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
			"END TRY" + loc_cCRLF + ;
			"BEGIN CATCH" + loc_cCRLF + ;
			"IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
			"ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION " + loc_cSavepoint + "; END;" + loc_cCRLF + ;
			"THROW;" + loc_cCRLF + ;
			"END CATCH"

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

		IF loc_nResultado < 0
			THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
				"o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + "es." + ;
				CHR(13) + CapturarErroSQL()
			loc_lOk = .F.
		ELSE
			loc_lOk = .T.
		ENDIF

		IF loc_lManual
			IF loc_lOk
				= SQLCOMMIT(gnConnHandle)
			ENDIF
		ENDIF

		THIS.this_cLoteGravacao = ""

		IF !loc_lOk
			MsgErro(THIS.this_cMensagemErro, "Tabela de Deprecia" + CHR(231) + CHR(227) + "o")
			THIS.this_lErroExibido = .T.
		ENDIF

		RETURN loc_lOk
	ENDFUNC

	*==========================================================================
	* CarregarDoCursor - Carrega as propriedades da faixa a partir de uma
	* linha do cursor crSigOpDup/cursor_4c_Dados
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*
	* par_cAliasCursor - alias a ler. Omitido, usa o cursor da grade.
	*
	* GUARDA DE EOF obrigatoria: em VFP ler campo com o ponteiro em EOF NAO
	* da erro - devolve o valor EM BRANCO do tipo. Sem o IF EOF() abaixo este
	* metodo zerava as cinco properties e ainda devolvia .T., ou seja relatava
	* SUCESSO sem haver linha nenhuma. Dois estragos, os dois silenciosos:
	*   - this_cCidChaves e this_cDopes ficavam VAZIOS, e a gravacao seguinte
	*     tentaria persistir uma faixa sem chave e sem operacao;
	*   - com this_cCidChaves vazio, a GUARDA DE IDENTIDADE do
	*     FormSigOpDpe.BOParaForm (que compara a chave do BO com a da linha
	*     corrente) deixa de valer e a escrita passa a atingir QUALQUER linha.
	* Medido no VFP9 em 2026-10-31 (automation\Probe724F8.prg, item 8): com o
	* ponteiro em EOF o metodo devolvia .T. Mesma forma do BO do dialogo-irmao
	* SigOpCrdBO.CarregarDoCursor.
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro
		loc_lSucesso = .F.

		loc_cAlias = ALLTRIM(THIS.this_cCursorDados)
		IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
			loc_cAlias = ALLTRIM(par_cAliasCursor)
		ENDIF

		TRY
			IF !USED(loc_cAlias)
				THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ELSE
				SELECT (loc_cAlias)

				IF EOF()
					*-- Sem linha corrente nao ha o que carregar. As properties
					*-- ficam COMO ESTAVAM de proposito: zera-las aqui
					*-- destruiria a faixa que o chamador ja tinha em maos.
					THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
						" linha corrente para carregar."
				ELSE
					THIS.this_cCidChaves = TratarNulo(cidchaves, "")
					THIS.this_cDopes     = TratarNulo(dopes,     "")
					THIS.this_nQtddis    = TratarNulo(qtddis,    0)
					THIS.this_nQtddfs    = TratarNulo(qtddfs,    0)
					THIS.this_nPercs     = TratarNulo(percs,     0)

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigOpDpeBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDados - criterio de aceitacao de UMA faixa
	*
	* O legado NAO tem validacao de tela aqui: a unica regra que ele aplica eh
	* o descarte do cmdSair.Click,
	*     Delete For Empty(Dopes) or Empty(Qtddfs)
	* mais a exigencia implicita de chave,
	*     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
	*
	* Sao essas as tres condicoes conferidas aqui, e NADA ALEM - em especial
	* NAO se exige qtddis <= qtddfs nem percs > 0: o legado aceita tudo isso,
	* e inventar a regra bloquearia gravacao que hoje funciona.
	*==========================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido

		loc_lValido = .F.
		THIS.this_cMensagemErro = ""

		DO CASE
		CASE EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
			THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
				"o da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."

		CASE THIS.this_nQtddfs = 0
			THIS.this_cMensagemErro = "Qtd Dias Final n" + CHR(227) + "o informada."

		CASE EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
			THIS.this_cMensagemErro = "Chave da tabela de deprecia" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o gerada."

		OTHERWISE
			loc_lValido = .T.
		ENDCASE

		RETURN loc_lValido
	ENDPROC

	*==========================================================================
	* MontarInsertLinha - INSERT da faixa corrente, com as CINCO colunas
	*
	* As cinco colunas de SigOpDup sao NOT NULL e nenhuma tem DEFAULT
	* (conferido em docs/schema.sql, UTF-16, lido com Get-Content -Raw). O
	* legado grava o registro INTEIRO - AddCursor sem query eh SELECT * +
	* TABLEUPDATE - entao as duas colunas que nao aparecem na tela (cidchaves
	* e dopes) continuam sendo gravadas.
	*
	* LEFT(...,20) nas duas colunas char: a largura vem do SCHEMA, nunca do
	* tamanho do controle na tela.
	*==========================================================================
	PROTECTED FUNCTION MontarInsertLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - inclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "INSERT INTO SigOpDup" + ;
			" (cidchaves, dopes, qtddis, qtddfs, percs)" + ;
			" VALUES (" + EscaparSQL(loc_cChave) + ", " + ;
			EscaparSQL(loc_cDopes) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddis, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nQtddfs, 0) + ", " + ;
			FormatarNumeroSQL(THIS.this_nPercs, 2) + ")"
	ENDFUNC

	*==========================================================================
	* MontarUpdateLinha - UPDATE da faixa corrente, pela chave primaria
	*
	* dopes entra no SET junto com as duas numericas porque eh coluna de
	* DADOS do registro (e NOT NULL), nao parte da chave: a PK de SigOpDup eh
	* so cidchaves (constraint sigopdup_cidchaves).
	*==========================================================================
	PROTECTED FUNCTION MontarUpdateLinha()
		LOCAL loc_cChave, loc_cDopes

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)
		loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

		IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave ou sem opera" + CHR(231) + CHR(227) + "o - altera" + CHR(231) + CHR(227) + ;
				"o cancelada."
			RETURN ""
		ENDIF

		RETURN "UPDATE SigOpDup SET" + ;
			" dopes = " + EscaparSQL(loc_cDopes) + "," + ;
			" qtddis = " + FormatarNumeroSQL(THIS.this_nQtddis, 0) + "," + ;
			" qtddfs = " + FormatarNumeroSQL(THIS.this_nQtddfs, 0) + "," + ;
			" percs = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ;
			" WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarDeleteLinha - DELETE da faixa corrente, pela chave primaria
	*==========================================================================
	PROTECTED FUNCTION MontarDeleteLinha()
		LOCAL loc_cChave

		loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidChaves, "")), 20)

		IF EMPTY(loc_cChave)
			THIS.this_cMensagemErro = "Faixa da tabela de deprecia" + CHR(231) + CHR(227) + ;
				"o sem chave - exclus" + CHR(227) + "o cancelada."
			RETURN ""
		ENDIF

		RETURN "DELETE FROM SigOpDup WHERE cidchaves = " + EscaparSQL(loc_cChave)
	ENDFUNC

	*==========================================================================
	* MontarInsertAuditoria - comando de auditoria para entrar no MESMO lote
	*
	* Vai junto com a operacao no lote transacional, e nao por SQLEXEC a
	* parte: assim o log nunca registra uma gravacao que foi desfeita.
	*
	* DataHora recebe GETDATE() literal, funcao do servidor - NUNCA
	* GETDATE(), que devolveria a string "NULL" e o INSERT
	* quebraria na coluna NOT NULL.
	*
	* Larguras de LogAuditoria no schema: Tabela varchar(100),
	* Operacao varchar(10), ChaveRegistro varchar(100), Usuario varchar(50).
	*==========================================================================
	PROTECTED FUNCTION MontarInsertAuditoria(par_cOperacao)
		LOCAL loc_cOperacao, loc_cChave, loc_cUsuario

		loc_cOperacao = UPPER(ALLTRIM(NVL(par_cOperacao, "")))
		loc_cChave    = ALLTRIM(NVL(THIS.ObterChavePrimaria(), ""))
		loc_cUsuario  = "SISTEMA"

		IF TYPE("gc_4c_UsuarioLogado") = "C"
			IF !EMPTY(ALLTRIM(gc_4c_UsuarioLogado))
				loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
			ENDIF
		ENDIF

		*-- Sem operacao ou sem chave nao ha o que auditar. Devolver vazio eh
		*-- inocuo: AcrescentarAoLote ignora comando vazio e a gravacao do
		*-- DADO, que eh o que importa, segue adiante.
		IF EMPTY(loc_cOperacao) OR EMPTY(loc_cChave)
			RETURN ""
		ENDIF

		RETURN "INSERT INTO LogAuditoria" + ;
			" (Tabela, Operacao, ChaveRegistro, Usuario, DataHora)" + ;
			" VALUES (" + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTabela), 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
			EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
			EscaparSQL(LEFT(loc_cUsuario, 50)) + ", GETDATE())"
	ENDFUNC

	*==========================================================================
	* Inserir - grava UMA faixa de depreciacao (caminho do Salvar da
	* BusinessBase). O caminho normal desta tela eh a gravacao em LOTE do
	* Encerrar (GravarFaixas) - este metodo cumpre o contrato Salvar() ->
	* Inserir() da BusinessBase e compartilha o MESMO montador de SQL, para
	* que a lista de colunas nao possa divergir entre os dois caminhos.
	*
	* cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22),
	* senao a segunda faixa incluida colide na chave primaria.
	*==========================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
				THIS.this_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20)
			ENDIF

			loc_cSQL = THIS.MontarInsertLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao inserir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Inserir")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - grava a alteracao de UMA faixa (contrato do Salvar)
	* WHERE por cidchaves, a PK real da linha (dopes identifica a operacao
	* proprietaria, nao a faixa individual)
	*==========================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarUpdateLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao atualizar a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.Atualizar")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - apaga UMA faixa no servidor, pela chave primaria
	*
	* PROTECTED de proposito (regra #51): de fora, sempre Excluir() da
	* BusinessBase, que valida o estado, roda os hooks e garante que a falha
	* nunca eh muda.
	*
	* No fluxo da TELA a remocao eh local (ExcluirLinhaCursor) e so chega ao
	* servidor junto com a gravacao do Encerrar, por reconciliacao - que eh o
	* que o poDataMgr.UpDate do cursor remoto fazia. Os dois caminhos usam o
	* MESMO montador de SQL.
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
		loc_lSucesso = .F.
		THIS.this_cMensagemErro = ""

		TRY
			loc_cSQL = THIS.MontarDeleteLinha()

			IF EMPTY(loc_cSQL)
				loc_lSucesso = .F.
			ELSE
				*-- Auditoria ANTES do DELETE: ObterChavePrimaria le a
				*-- property, que o LimparDados do Excluir() zera depois.
				THIS.RegistrarAuditoria("DELETE")

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Erro ao excluir a faixa de deprecia" + CHR(231) + CHR(227) + ;
						"o:" + CHR(13) + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loc_oErro.Message
			MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "SigOpDpeBO.ExecutarExclusao")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* LimparDados - devolve as propriedades ao estado de registro novo
	*
	* dopes volta para a operacao do CONTEXTO, nao para vazio: toda faixa
	* desta tela pertence a operacao que o form pai esta editando.
	*==========================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cCidChaves = ""
		THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
		THIS.this_nQtddis    = 0
		THIS.this_nQtddfs    = 0
		THIS.this_nPercs     = 0

		THIS.this_cLoteGravacao = ""

		RETURN .T.
	ENDPROC

	*==========================================================================
	* Destroy - fecha os cursores desta tela
	*
	* USE IN fecha o alias mesmo com buffer sujo, e por isso NAO ha
	* TABLEREVERT aqui: TABLEREVERT exige buffering e, sobre cursor criado por
	* CREATE CURSOR (que nasce com Buffering = 1), dispara o erro 1586
	* "Function requires row or table buffering mode."
	*==========================================================================
	PROCEDURE Destroy()
		IF USED(ALLTRIM(THIS.this_cCursorTemp))
			USE IN (ALLTRIM(THIS.this_cCursorTemp))
		ENDIF

		IF USED(ALLTRIM(THIS.this_cCursorDados))
			USE IN (ALLTRIM(THIS.this_cCursorDados))
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE


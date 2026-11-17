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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsen.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2333 linhas total):

*-- Linhas 26 a 121:
26: *   Por ser gate de AUTORIZACAO, o estado inicial eh sempre "NAO autorizado"
27: *   (this_lZSen = .F.): falha de qualquer natureza deixa a tela FAIL-CLOSED.
28: *
29: * Correspondencia legado -> migrado (objetos; ver tasks\task799\mapeamento.json)
30: *   SIGOPSEN                     -> Formsigopsen
31: *   SIGOPSEN.cntSombra           -> cnt_4c_Sombra                   (Fase 3)
32: *   SIGOPSEN.cntSombra.lblSombra -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
33: *   SIGOPSEN.cntSombra.lblTitulo -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
34: *   SIGOPSEN.Frase               -> lbl_4c_Frase
35: *   SIGOPSEN.Say2                -> lbl_4c_Label2
36: *   SIGOPSEN.usuario             -> txt_4c_Usuario
37: *   SIGOPSEN.Say3                -> lbl_4c_Label3
38: *   SIGOPSEN.senha               -> txt_4c_Senha
39: *   SIGOPSEN.Image1              -> img_4c_Image1
40: *
41: *   ORDEM DE CRIACAO (importa, e o SCX legado ja a estabelece): a faixa cinza
42: *   cnt_4c_Sombra eh o PRIMEIRO AddObject da tela. O lbl_4c_Frase do legado
43: *   fica em Top = 46..80, isto eh, DENTRO da area da faixa (0..80), e tem
44: *   ForeColor branco justamente porque desenha POR CIMA do cinza - ele eh filho
45: *   da Form, nao do container, e no SCX eh criado depois da faixa. Todo
46: *   controle acrescentado a esta tela entra DEPOIS de ConfigurarCabecalho.
47: *
48: * Correspondencia legado -> migrado (comportamento)
49: *   SIGOPSEN.Init  (Lparameters pTip, pTi1, pTi2, pDoc, pDat, pEmp, pFpg, pVal)
50: *     CreateObject([fSqlConector]) + teste pnIdconn > 0
51: *                                       -> THIS.ValidarParametros()
52: *     normalizacao Type([pDoc]) <> [N] ...
53: *                                       -> THIS.Init() (bloco PCOUNT/VARTYPE)
54: *     zera as 21 flags + .UsuLibs = Usuar
55: *                                       -> sigopsenBO.Init() + THIS.ConfigurarParametrosBO()
56: *     2 CursorQuery (SigCdPam/SigCdPac)  -> THIS.CarregarParametrosSistema()
57: *     Do Case pTip ... (25 ramos)        -> THIS.ConfigurarPorTipo()
58: *     .cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption
59: *                                       -> THIS.ConfigurarCabecalho()
60: *     If (crParam.LiblCreds And ...)     -> THIS.AvaliarSenhaDoDia()
61: *   SIGOPSEN.usuario.When     -> THIS.UsuarioEditavel() (via .Enabled)
62: *   SIGOPSEN.usuario.Valid    -> THIS.UsuarioLostFocus/UsuarioLostFocusExec
63: *   SIGOPSEN.usuario.KeyPress -> THIS.UsuarioKeyPress
64: *   SIGOPSEN.senha.Valid      -> THIS.SenhaLostFocus/SenhaLostFocusExec
65: *     (consultas, senha livre, senha cadastrada x senha do dia e log ficam
66: *      no BO, em sigopsenBO.ConferirSenha(); aqui ficam so as decisoes de
67: *      TELA: o dialogo "Deseja digitar novamente ?", o foco de volta no
68: *      campo e o fechamento publicando o resultado)
69: *   SIGOPSEN.Unload (Return Iif(This.ZSen,[*],[ ]) + This.UsuLibs)
70: *                                       -> THIS.MontarRetorno() / this_cRetorno
71: *   SIGOPSEN.Release (poDataMgr.Release + DoDefault)
72: *                                       -> THIS.FecharDialogo() + THIS.Destroy()
73: *
74: *   O valor de retorno do legado chega ao chamador por "DO FORM ... TO var",
75: *   que depende do Unload. O sistema novo abre o dialogo com CREATEOBJECT, e
76: *   nesse caminho o Unload NAO alimenta variavel nenhuma - por isso a resposta
77: *   eh publicada na property this_cRetorno (montada por MontarRetorno com a
78: *   MESMA expressao do legado) e lida pelo chamador depois do Show().
79: *
80: * Uso (o dialogo DEVOLVE resultado, por isso o chamador eh quem libera):
81: *   loForm = CREATEOBJECT("Formsigopsen", "LIMITE", lcConta, "", 0, DATE())
82: *   IF VARTYPE(loForm) = "O"
83: *       loForm.Show()                      && modal: retorna quando a tela fecha
84: *       IF loForm.this_lZSen               && autorizado?
85: *           lcUsuLib = loForm.this_cUsuLibs
86: *       ENDIF
87: *   ENDIF
88: *==============================================================================
89: 
90: DEFINE CLASS Formsigopsen AS FormBase
91: 
92:     *==========================================================================
93:     * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
94:     *
95:     *   DataSession = 1 / BorderStyle = 2 / Height = 180 / Width = 400
96:     *   AutoCenter = .T. / Caption = "" / ControlBox = .F. / TitleBar = 0
97:     *   WindowType = 1 / BackColor = 255,255,255 / Themes = .F.
98:     *   Picture = ..\framework\imagens\new_background.jpg
99:     *
100:     * DataSession = 1 eh a sessao CORRENTE (compartilhada): esta tela le o
101:     * cursor do movimento aberto pelo form CHAMADOR (TprMvCab) e por isso NAO
102:     * pode ter datasession privada - o dump declara 1, e a transcricao literal
103:     * eh tambem o que faz a tela funcionar.
104:     *
105:     * MaxButton / MinButton / Closable NAO sao declarados aqui porque o dump
106:     * tambem nao os declara: com TitleBar = 0 nao ha barra onde eles aparecam,
107:     * e inventar Closable = .F. so tiraria uma saida que o legado mantem.
108:     *
109:     * BackColor e Picture ficam em ConfigurarAparencia: o primeiro porque RGB()
110:     * eh funcao e nao pode aparecer em inicializador de propriedade de DEFINE
111:     * CLASS, e o segundo porque depende da global gc_4c_CaminhoIcones.
112:     *==========================================================================
113:     this_cMensagemErro = ""
114:     DataSession = 1
115:     ShowWindow = 1
116:     Width       = 400
117:     Height      = 180
118:     AutoCenter  = .T.
119:     BorderStyle = 2
120:     Caption     = ""
121:     ControlBox  = .F.

*-- Linhas 187 a 287:
187:     *     abrir ele tira o foco do campo, o que faz o proprio LostFocus
188:     *     disparar de novo e empilharia um segundo dialogo (regra #37).
189:     *
190:     * this_cUltimoUsuarioValidado - ultimo valor ja resolvido. O legado
191:     *     valida no Valid; aqui a validacao mora no LostFocus (regra #47),
192:     *     que dispara SEMPRE que o campo perde o foco - sem este guard,
193:     *     apenas tabular pelo campo reabriria o picker a cada passagem. O
194:     *     valor inicial eh um SENTINELA mais longo que os 10 caracteres de
195:     *     SigCdUsu.usuarios, para que nenhum valor digitavel possa casar com
196:     *     ele (string vazia casaria com o campo vazio e mataria o caminho de
197:     *     saida do dialogo, que eh justamente "usuario em branco").
198:     *
199:     * this_lDialogoEncerrado - a tela ja se fechou (gate resolvido ou
200:     *     recusado). Depois do Hide() o campo ainda pode disparar LostFocus;
201:     *     sem esta flag a validacao rodaria uma segunda vez sobre um dialogo
202:     *     que ja devolveu resposta ao chamador.
203:     *==========================================================================
204:     this_lEmLookupUsuario       = .F.
205:     this_cUltimoUsuarioValidado = "@@SEM VALIDACAO@@"
206:     this_lDialogoEncerrado      = .F.
207: 
208:     *==========================================================================
209:     * Controle da conferencia da senha (Fase 8)
210:     *
211:     * this_lEmValidacaoSenha - guarda de REENTRANCIA do mesmo tipo da do
212:     *     campo usuario. A conferencia pode exibir o dialogo "Deseja digitar
213:     *     novamente ?", que eh MODAL: ele tira o foco do campo senha e faz o
214:     *     proprio LostFocus disparar de novo, encadeando uma segunda
215:     *     conferencia sobre a mesma senha (regra #37). A flag eh liberada por
216:     *     um wrapper fino, porque o corpo tem RETURN antecipado (regra #47).
217:     *
218:     * this_cUltimaSenhaValidada - ultima senha JA conferida. O legado valida
219:     *     no Valid; aqui a validacao mora no LostFocus (regra #47), que
220:     *     dispara em TODA perda de foco - sem este guard, so tabular pelo
221:     *     campo reconferiria a senha e o usuario levaria o dialogo de
222:     *     conflito de novo sem ter digitado nada. O sentinela eh mais longo
223:     *     que os 10 caracteres de SigCdUsu.senhas para que nenhum valor
224:     *     digitavel possa casar com ele (string vazia casaria com o campo
225:     *     vazio, que eh um caminho de conflito valido). Ele eh LIMPO quando o
226:     *     usuario escolhe redigitar, para a nova tentativa ser conferida.
227:     *==========================================================================
228:     this_lEmValidacaoSenha   = .F.
229:     this_cUltimaSenhaValidada = "@@SEM VALIDACAO@@"
230: 
231:     *--------------------------------------------------------------------------
232:     * Init - Recebe os parametros do chamador e dispara a inicializacao.
233:     *
234:     * Legado: Lparameters pTip, pTi1, pTi2, pDoc, pDat, pEmp, pFpg, pVal, com o
235:     * bloco de normalizacao If (Type([pDoc]) <> [N]) pDoc = 0 / If (Type([pDat])
236:     * <> [D]) pDat = Date() / ... reproduzido abaixo por PCOUNT + VARTYPE.
237:     *
238:     * NENHUM parametro eh obrigatorio: parametro ausente apenas mantem o
239:     * default declarado acima, exatamente como o legado faz. Init que recusa
240:     * instanciacao por falta de parametro reprova o harness de teste (que
241:     * instancia sem argumento) e deixa a tela inalcancavel.
242:     *
243:     * Os valores sao guardados ANTES do DODEFAULT() porque eh o DODEFAULT() que
244:     * chama InicializarForm(), e de la saem o titulo, a frase e as flags de
245:     * permissao - todos derivados destes parametros.
246:     *--------------------------------------------------------------------------
247:     PROCEDURE Init(par_cTipo, par_uTitulo, par_cTitulo2, par_nNroDoc, par_dDatDoc, par_cEmpresa, par_cFpagto, par_nValFpag)
248:         LOCAL loc_lSucesso
249: 
250:         IF PCOUNT() >= 1 AND VARTYPE(par_cTipo) = "C"
251:             THIS.this_cTipo = UPPER(ALLTRIM(par_cTipo))
252:         ENDIF
253: 
254:         *-- pTi1 do legado: texto em 24 ramos, contagem no ramo CHDEVOLVIDO
255:         IF PCOUNT() >= 2
256:             DO CASE
257:                 CASE VARTYPE(par_uTitulo) = "N"
258:                     THIS.this_nTitulo         = par_uTitulo
259:                     THIS.this_cTitulo         = ALLTRIM(STR(par_uTitulo))
260:                     THIS.this_lTituloNumerico = .T.
261:                 CASE VARTYPE(par_uTitulo) = "C"
262:                     THIS.this_cTitulo         = par_uTitulo
263:                     THIS.this_nTitulo         = VAL(par_uTitulo)
264:                     THIS.this_lTituloNumerico = .F.
265:             ENDCASE
266:         ENDIF
267: 
268:         IF PCOUNT() >= 3 AND VARTYPE(par_cTitulo2) = "C"
269:             THIS.this_cTitulo2 = par_cTitulo2
270:         ENDIF
271: 
272:         *-- Legado: If (Type([pDoc]) <> [N]) / pDoc = 0 / EndIf
273:         IF PCOUNT() >= 4 AND VARTYPE(par_nNroDoc) = "N"
274:             THIS.this_nNroDoc = par_nNroDoc
275:         ELSE
276:             THIS.this_nNroDoc = 0
277:         ENDIF
278: 
279:         *-- Legado: If (Type([pDat]) <> [D]) / pDat = Date() / EndIf
280:         IF PCOUNT() >= 5 AND VARTYPE(par_dDatDoc) = "D"
281:             THIS.this_dDatDoc = par_dDatDoc
282:         ELSE
283:             THIS.this_dDatDoc = DATE()
284:         ENDIF
285: 
286:         *-- Legado: If (Type([pEmp]) <> [C]) / pEmp = [] / EndIf
287:         IF PCOUNT() >= 6 AND VARTYPE(par_cEmpresa) = "C"

*-- Linhas 318 a 513:
318: 
319:     *--------------------------------------------------------------------------
320:     * ValidarParametros - Guarda de conexao do Init legado:
321:     *     .poDataMgr = CreateObject([fSqlConector], .Name)
322:     *     If (.poDataMgr.pnIdconn > 0) ... Else
323:     *         =Messagebox([Impossivel Efetuar Conexao Com o Servidor ...])
324:     *         Return .f.
325:     *     EndIf
326:     *
327:     * No sistema novo o equivalente de pnIdconn eh o handle global
328:     * gnConnHandle. A guarda fica num metodo PROPRIO, chamado ANTES do TRY de
329:     * InicializarForm, e com BYPASS no topo para modo de teste / validacao de
330:     * UI: o harness de teste define gnConnHandle = 0 DE PROPOSITO (sentinela,
331:     * para nao esperar o timeout TCP de um servidor inacessivel) e espera que
332:     * os forms pulem o acesso a dados por gb_4c_ModoTeste / gb_4c_ValidandoUI,
333:     * nao por checagem de handle. Sem o bypass, a tela reprovaria SEMPRE no
334:     * teste de instanciacao, sem nenhum erro de SQL no log.
335:     *
336:     * PUBLIC (sem PROTECTED): alcancavel pelo harness, que chama metodos do
337:     * form de fora da classe.
338:     *--------------------------------------------------------------------------
339:     PROCEDURE ValidarParametros()
340:         LOCAL loc_lValido
341: 
342:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
343:             RETURN .T.
344:         ENDIF
345: 
346:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
347:             RETURN .T.
348:         ENDIF
349: 
350:         loc_lValido = .T.
351: 
352:         DO CASE
353:             CASE TYPE("gnConnHandle") != "N"
354:                 loc_lValido = .F.
355:             CASE gnConnHandle <= 0
356:                 loc_lValido = .F.
357:         ENDCASE
358: 
359:         IF !loc_lValido
360:             THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
361:                 "o Com o Servidor de Banco de Dados..."
362:             MsgErro(THIS.this_cMensagemErro, "CreateObject")
363:         ENDIF
364: 
365:         RETURN loc_lValido
366:     ENDPROC
367: 
368:     *--------------------------------------------------------------------------
369:     * InicializarForm - Hook chamado por FormBase.Init().
370:     *
371:     * Monta a estrutura base da tela na ordem do Init legado: conexao, objeto
372:     * de negocio, parametros do sistema, resolucao do TIPO (que define o
373:     * Caption) e so depois a faixa do cabecalho - que copia justamente esse
374:     * Caption, como no legado (.cntSombra.lblSombra.Caption = ThisForm.Caption).
375:     *
376:     * O RETURN da guarda fica FORA do TRY (regra: nunca RETURN dentro de
377:     * TRY/CATCH), e o resultado do bloco protegido vai para loc_lSucesso.
378:     *
379:     * CREATEOBJECT do BO roda INCONDICIONALMENTE dentro do TRY - sem gate de
380:     * gnConnHandle, que ja foi tratado em ValidarParametros().
381:     *--------------------------------------------------------------------------
382:     PROTECTED PROCEDURE InicializarForm()
383:         LOCAL loc_lSucesso, loc_oErro
384: 
385:         IF !THIS.ValidarParametros()
386:             RETURN .F.
387:         ENDIF
388: 
389:         loc_lSucesso = .F.
390: 
391:         TRY
392:             *-- Objeto de negocio (gerado nas fases de BO)
393:             THIS.this_oBusinessObject = CREATEOBJECT("sigopsenBO")
394: 
395:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
396:                 *-- Repassa ao BO os parametros recebidos do chamador
397:                 THIS.ConfigurarParametrosBO()
398: 
399:                 *-- Parametros do sistema (SigCdPam / SigCdPac). Gate de
400:                 *-- AUTORIZACAO: sem eles a tela NAO abre, como no legado.
401:                 IF THIS.CarregarParametrosSistema()
402:                     *-- Titulo, frase e flag de permissao a partir do TIPO
403:                     THIS.ConfigurarPorTipo()
404: 
405:                     *-- Aparencia da janela (fundo e cor de fundo)
406:                     THIS.ConfigurarAparencia()
407: 
408:                     *-- Faixa cinza do cabecalho (cntSombra do legado).
409:                     *-- PRIMEIRO AddObject da tela: os controles de dados
410:                     *-- entram depois, para desenharem por cima dela.
411:                     THIS.ConfigurarCabecalho()
412: 
413:                     *-- Bloco final do Init legado: decide se a tela passa a
414:                     *-- pedir a senha do dia em vez da senha cadastrada
415:                     THIS.AvaliarSenhaDoDia()
416: 
417:                     *-- Campos da tela: frase da liberacao e linha do usuario.
418:                     *-- Depende de ConfigurarPorTipo (frase) e de
419:                     *-- AvaliarSenhaDoDia (campo travado e pre-preenchido).
420:                     THIS.ConfigurarCamposUsuario()
421: 
422:                     *-- Restante dos campos: icone, linha da senha e o
423:                     *-- campo de senha. Criados DEPOIS da linha do usuario
424:                     *-- (ordem do SCX) e DEPOIS de AvaliarSenhaDoDia, que
425:                     *-- decide o rotulo da linha.
426:                     THIS.ConfigurarCamposSenha()
427: 
428:                     *-- Valid / KeyPress dos campos do legado, por BINDEVENT.
429:                     *-- Depois de TODO AddObject: BINDEVENT em controle que
430:                     *-- ainda nao existe estoura no proprio bind.
431:                     THIS.LigarEventos()
432: 
433:                     *-- AddObject cria todo controle com Visible = .F.
434:                     THIS.TornarControlesVisiveis(THIS)
435: 
436:                     *-- Sincroniza a tela com o estado do BO. Roda DEPOIS de
437:                     *-- TornarControlesVisiveis, que forca Visible = .T. em
438:                     *-- tudo: eh este passo que devolve a visibilidade e a
439:                     *-- habilitacao governadas pelo estado do dialogo, para
440:                     *-- a tela nao abrir divergindo do BO.
441:                     THIS.BOParaForm()
442: 
443:                     loc_lSucesso = .T.
444:                 ENDIF
445:             ELSE
446:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
447:                     "vel criar o objeto de neg" + CHR(243) + "cio sigopsenBO"
448:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
449:             ENDIF
450:         CATCH TO loc_oErro
451:             THIS.this_cMensagemErro = loc_oErro.Message
452:             MsgErro(loc_oErro.Message + CHR(13) + ;
453:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
454:                 "Procedure: " + loc_oErro.Procedure, ;
455:                 "Erro ao inicializar Formsigopsen")
456:         ENDTRY
457: 
458:         RETURN loc_lSucesso
459:     ENDPROC
460: 
461:     *--------------------------------------------------------------------------
462:     * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou.
463:     *
464:     * O BO guarda o estado da autorizacao (tipo, documento, empresa, forma de
465:     * pagamento, valor) e eh quem monta a consulta de usuarios e a baixa da
466:     * senha livre; o form eh so a superficie. Os nomes das properties sao os
467:     * declarados em sigopsenBO.prg.
468:     *
469:     * this_cTitulo do BO recebe a forma em TEXTO de pTi1 (o BO declara a
470:     * property como caractere); a forma numerica fica no form, onde eh usada
471:     * pelo ramo CHDEVOLVIDO de ConfigurarPorTipo().
472:     *--------------------------------------------------------------------------
473:     PROTECTED PROCEDURE ConfigurarParametrosBO()
474:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
475:             RETURN
476:         ENDIF
477: 
478:         *-- Legado, no MESMO bloco em que zera as 21 flags de tipo:
479:         *--     .UsuLibs = Usuar
480:         *-- INCONDICIONAL - o liberador nasce sendo o usuario LOGADO, e so
481:         *-- eh substituido quando o fluxo do campo usuario resolve outro
482:         *-- ("thisform.usulibs = this.value") ou quando a conferencia da
483:         *-- senha do dia grava nele a senha gerada. Sem esta linha, um
484:         *-- dialogo RECUSADO sem o usuario ter sido informado (ESC no campo
485:         *-- em branco) devolveria " " em vez do " " + usuario logado que o
486:         *-- Unload legado monta, e o log do ramo de movimento sairia com o
487:         *-- liberador em branco nos tipos em que o campo usuario nasce
488:         *-- travado.
489:         THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
490: 
491:         WITH THIS.this_oBusinessObject
492:             .this_cTipo    = THIS.this_cTipo
493:             .this_cTitulo  = THIS.this_cTitulo
494:             .this_cTitulo2 = THIS.this_cTitulo2
495:             .this_nNroDoc  = THIS.this_nNroDoc
496:             .this_dDatDoc  = THIS.this_dDatDoc
497:             .this_cEmpresa = THIS.this_cEmpresa
498:             .this_cFpagto  = THIS.this_cFpagto
499:             .this_nValFpag = THIS.this_nValFpag
500:             .this_lZSen    = .F.
501:             .this_cUsuLibs = THIS.this_cUsuLibs
502:         ENDWITH
503: 
504:         RETURN
505:     ENDPROC
506: 
507:     *--------------------------------------------------------------------------
508:     * CarregarParametrosSistema - As duas CursorQuery do Init legado:
509:     *
510:     *   .poDataMgr.CursorQuery([SigCdPam], [crParam], .f., .f., [LibLCreds])
511:     *   If Not Used([crParam]) -> MessageBox + Return .f.
512:     *   .poDataMgr.CursorQuery([SigCdPac], [crParac], .f., .f., [SenhDEmps])
513:     *   If Not Used([crParam]) -> MessageBox + Return .f.

*-- Linhas 539 a 582:
539:     * PUBLIC: eh o ponto de recarga dos parametros do sistema e pode ser
540:     * chamado de fora (harness e chamador), nao so de dentro da classe.
541:     *--------------------------------------------------------------------------
542:     PROCEDURE CarregarParametrosSistema()
543:         LOCAL loc_lSucesso, loc_cCursor, loc_nResultado, loc_oErro
544: 
545:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
546:             RETURN .F.
547:         ENDIF
548: 
549:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
550:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
551:             RETURN .T.
552:         ENDIF
553: 
554:         loc_lSucesso = .F.
555: 
556:         TRY
557:             *-- SigCdPam.liblcreds -> crParam do legado
558:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorParam
559: 
560:             IF USED(loc_cCursor)
561:                 USE IN (loc_cCursor)
562:             ENDIF
563: 
564:             loc_nResultado = SQLEXEC(gnConnHandle, "SELECT liblcreds FROM SigCdPam", loc_cCursor)
565: 
566:             IF loc_nResultado < 1 OR !USED(loc_cCursor)
567:                 THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
568:                 MsgErro(THIS.this_cMensagemErro, ;
569:                     "Falha na Conex" + CHR(227) + "o (CursorQuery - crParam)")
570:             ELSE
571:                 SELECT (loc_cCursor)
572:                 GO TOP
573:                 THIS.this_oBusinessObject.this_lLiblCreds = ;
574:                     IIF(EOF(loc_cCursor), .F., ConverterParaLogico(EVALUATE(loc_cCursor + ".liblcreds")))
575: 
576:                 *-- SigCdPac.senhdemps -> crParac do legado
577:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorParac
578: 
579:                 IF USED(loc_cCursor)
580:                     USE IN (loc_cCursor)
581:                 ENDIF
582: 

*-- Linhas 600 a 681:
600:             THIS.this_cMensagemErro = loc_oErro.Message
601:             MsgErro(loc_oErro.Message + CHR(13) + ;
602:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
603:                 "Procedure: " + loc_oErro.Procedure, ;
604:                 "Falha na Conex" + CHR(227) + "o (Par" + CHR(226) + "metros do Sistema)")
605:         ENDTRY
606: 
607:         RETURN loc_lSucesso
608:     ENDPROC
609: 
610:     *--------------------------------------------------------------------------
611:     * ConfigurarPorTipo - Transcricao do "Do Case pTip" do Init legado.
612:     *
613:     * Cada ramo define TRES coisas: o Caption da janela (que a faixa do
614:     * cabecalho copia), o texto do rotulo Frase e a flag de permissao que a
615:     * consulta de usuarios vai exigir. As flags moram no BO, que eh quem monta
616:     * essa consulta.
617:     *
618:     * Os textos sao transcritos LITERALMENTE do dump, com acentos escritos em
619:     * CHR(): sao o que o usuario le para entender QUAL liberacao esta sendo
620:     * pedida, e reescrever a frase mudaria a informacao exibida.
621:     *
622:     * Quatro fidelidades que o ramo-a-ramo exige:
623:     *   - DTENTREGA DESLIGA this_lFinanc em vez de ligar uma flag, exatamente
624:     *     como o legado (.Financ = .f.) - esse tipo cai no ramo "Otherwise" da
625:     *     consulta de usuarios, que exige AltCots.
626:     *   - LIBPRZENT, LIBVMOVDUP e LIBVLM definem SO o Caption; o legado nao
627:     *     toca na Frase nesses tres, e a Frase segue vazia.
628:     *   - MAXIMO concatena o 2o texto no Caption SEM Alltrim, e eh o unico ramo
629:     *     assim.
630:     *   - LIBPRDZ, LIBPRDZ2 e LIBPESO compartilham UM ramo (InList no legado).
631:     *
632:     * O tipo eh comparado com "==" sobre o valor ja passado por UPPER+ALLTRIM,
633:     * para a correspondencia nao depender de SET EXACT nem do tamanho do
634:     * literal (o legado grava "LIBVlM" em caixa mista, que entra aqui como
635:     * LIBVLM).
636:     *
637:     * Nao existe "Otherwise": tipo desconhecido deixa titulo e frase vazios e
638:     * nenhuma flag ligada, e a conferencia de usuario cai no ramo AltCots - o
639:     * mesmo desfecho do legado, que tambem nao tem Otherwise aqui.
640:     *--------------------------------------------------------------------------
641:     PROTECTED PROCEDURE ConfigurarPorTipo()
642:         LOCAL loc_cTipo, loc_cCaption, loc_cFrase
643: 
644:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
645:             RETURN
646:         ENDIF
647: 
648:         loc_cTipo    = UPPER(ALLTRIM(THIS.this_cTipo))
649:         loc_cCaption = ""
650:         loc_cFrase   = ""
651: 
652:         WITH THIS.this_oBusinessObject
653:             DO CASE
654:                 CASE loc_cTipo == "CUSTOPROD"
655:                     loc_cCaption     = "Custo Produto"
656:                     loc_cFrase       = ALLTRIM(THIS.this_cTitulo)
657:                     .this_lCustoProd = .T.
658: 
659:                 CASE loc_cTipo == "DTENTREGA"
660:                     loc_cCaption  = "Prazo de Entrega"
661:                     loc_cFrase    = ALLTRIM(THIS.this_cTitulo) + " Fora do Prazo de Entrega"
662:                     .this_lFinanc = .F.
663: 
664:                 CASE loc_cTipo == "CHDEVOLVIDO"
665:                     loc_cCaption  = "Cheque Devolvido"
666:                     loc_cFrase    = "A Conta " + ALLTRIM(THIS.this_cTitulo2) + " Possui " + ;
667:                         IIF(THIS.this_nTitulo = 1, ;
668:                             "1 Cheque Devolvido Pendente", ;
669:                             ALLTRIM(STR(THIS.this_nTitulo)) + " Cheques Devolvidos Pendentes")
670:                     .this_lFinanc = .T.
671: 
672:                 CASE loc_cTipo == "LIMITE"
673:                     loc_cCaption  = "Limite Excedido"
674:                     loc_cFrase    = "O Limite da Conta " + ALLTRIM(THIS.this_cTitulo) + " Foi Excedido"
675:                     .this_lFinanc = .T.
676: 
677:                 CASE loc_cTipo == "ALTERAIMPOSTO"
678:                     loc_cCaption  = ALLTRIM(THIS.this_cTitulo)
679:                     loc_cFrase    = ALLTRIM(THIS.this_cTitulo2)
680:                     .this_lFinanc = .T.
681: 

*-- Linhas 805 a 905:
805:     * IF FILE(): o arquivo existe no acervo, e esconder a ausencia de imagem
806:     * atras de um guard eh justamente o que faz o fundo desaparecer em silencio.
807:     *--------------------------------------------------------------------------
808:     PROTECTED PROCEDURE ConfigurarAparencia()
809:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
810:         THIS.BackColor  = RGB(255, 255, 255)
811:         THIS.ScrollBars = 0
812: 
813:         RETURN
814:     ENDPROC
815: 
816:     *--------------------------------------------------------------------------
817:     * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
818:     *
819:     * Legado:
820:     *   cntSombra            Top=0  Left=0  Width=800 Height=80
821:     *                        BorderWidth=0 BackColor=100,100,100
822:     *   cntSombra.lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
823:     *   cntSombra.lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
824:     *   ambos: Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
825:     *
826:     * Dois desvios DELIBERADOS do literal do dump, ambos ja catalogados:
827:     *
828:     * (1) WIDTH - o SCX declara o container com 800 e os labels com 769, mas o
829:     *     proprio form tem 400: o Form Designer desenhou a faixa 400px mais
830:     *     larga que a janela. Copiar o literal faria o container e os labels
831:     *     ficarem RECORTADOS pela borda do form, cortando o titulo no meio
832:     *     (controle fora da area do pai eh cortado sem erro e sem log). Usa-se
833:     *     THIS.Width no container e THIS.Width - 20 nos labels (Left = 10 de
834:     *     cada lado), que eh o equivalente responsivo do literal.
835:     *
836:     * (2) CAPTION - o dump traz "Cadastro de Testes" nos dois labels, texto de
837:     *     template que ficou no SCX (o ToolTipText do lblTitulo ainda diz
838:     *     "Titulo do Relatorio"). O titulo real da tela eh o Caption do form,
839:     *     resolvido por ConfigurarPorTipo() a partir do tipo de liberacao - eh
840:     *     exatamente o que o Init legado faz nas duas linhas
841:     *     .cntSombra.lblSombra.Caption = ThisForm.Caption.
842:     *
843:     * AutoSize = .F. explicito: AutoSize eh no-op em Label criado por AddObject
844:     * e, com WordWrap = .T., chega a descartar a Height - o par Width/Height
845:     * transcrito do SCX ja eh o tamanho calculado pelo Designer.
846:     *
847:     * ForeColor branco eh legitimo aqui: o lbl_4c_LblTitulo fica dentro de
848:     * container OPACO escuro (BackStyle = 1 + BackColor RGB(100,100,100)).
849:     *--------------------------------------------------------------------------
850:     PROTECTED PROCEDURE ConfigurarCabecalho()
851:         THIS.AddObject("cnt_4c_Sombra", "Container")
852: 
853:         WITH THIS.cnt_4c_Sombra
854:             .Top           = 0
855:             .Left          = 0
856:             .Width         = THIS.Width
857:             .Height        = 80
858:             .BorderWidth   = 0
859:             .BackStyle     = 1
860:             .BackColor     = RGB(100, 100, 100)
861:             .SpecialEffect = 0
862:             .Visible       = .T.
863:         ENDWITH
864: 
865:         *-- Label de sombra (preto, 1px abaixo do titulo - efeito de relevo)
866:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
867: 
868:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
869:             .AutoSize      = .F.
870:             .FontName      = "Tahoma"
871:             .FontSize      = 18
872:             .FontBold      = .T.
873:             .FontUnderline = .F.
874:             .WordWrap      = .T.
875:             .Alignment     = 0
876:             .BackStyle     = 0
877:             .Caption       = THIS.Caption
878:             .Top           = 18
879:             .Left          = 10
880:             .Width         = THIS.Width - 20
881:             .Height        = 40
882:             .ForeColor     = RGB(0, 0, 0)
883:             .Rotation      = 0
884:             .Visible       = .T.
885:         ENDWITH
886: 
887:         *-- Label do titulo (branco sobre o cinza do container)
888:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
889: 
890:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
891:             .AutoSize    = .F.
892:             .FontName    = "Tahoma"
893:             .FontSize    = 18
894:             .FontBold    = .T.
895:             .WordWrap    = .T.
896:             .Alignment   = 0
897:             .BackStyle   = 0
898:             .Caption     = THIS.Caption
899:             .Top         = 17
900:             .Left        = 10
901:             .Width       = THIS.Width - 20
902:             .Height      = 46
903:             .ForeColor   = RGB(255, 255, 255)
904:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
905:             .Rotation    = 0

*-- Linhas 938 a 1004:
938:     * PUBLIC: eh reavaliada sempre que os parametros do sistema sao
939:     * recarregados, inclusive de fora da classe.
940:     *--------------------------------------------------------------------------
941:     PROCEDURE AvaliarSenhaDoDia()
942:         LOCAL loc_cTipo, loc_lLiblCreds
943: 
944:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
945:             RETURN .F.
946:         ENDIF
947: 
948:         loc_cTipo      = UPPER(ALLTRIM(THIS.this_cTipo))
949:         loc_lLiblCreds = THIS.this_oBusinessObject.this_lLiblCreds
950: 
951:         THIS.this_lSenhaDoDia = (loc_lLiblCreds AND loc_cTipo == "LIMITE") OR ;
952:             INLIST(loc_cTipo, "LIBPRDZ2", "MAXIMO")
953: 
954:         THIS.this_oBusinessObject.this_lSenhaDoDia = THIS.this_lSenhaDoDia
955: 
956:         IF THIS.this_lSenhaDoDia
957:             *-- Legado: .usuario.Value = Usuar
958:             THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
959:             THIS.this_oBusinessObject.this_cUsuario = THIS.this_cUsuLibs
960:             THIS.this_oBusinessObject.this_cUsuLibs = THIS.this_cUsuLibs
961:         ENDIF
962: 
963:         RETURN THIS.this_lSenhaDoDia
964:     ENDPROC
965: 
966:     *--------------------------------------------------------------------------
967:     * ConfigurarCamposUsuario - Primeiro bloco de campos da tela: a frase que
968:     * explica a liberacao e a linha "Usuario :" com o campo de digitacao.
969:     *
970:     * Legado (transcrito do dump - PILAR 1):
971:     *   Frase    AutoSize=.F. FontBold=.T. FontItalic=.T. FontName="Tahoma"
972:     *            WordWrap=.T. Alignment=2 Height=34 Left=2 Top=46 Width=394
973:     *            TabIndex=1 ForeColor=255,255,255   (o Caption vem do Init)
974:     *   Say2     FontBold=.T. FontName="Tahoma" Caption="Usuario : "
975:     *            Left=112 Top=102 TabIndex=2 ForeColor=90,90,90
976:     *   usuario  FontName="Tahoma" FontSize=12 Century=2 Alignment=3
977:     *            Height=30 InputMask="!!!!!!!!!!" Left=168 Top=94 Width=119
978:     *            TabIndex=3 ForeColor=0,0,0
979:     *
980:     * O que o dump NAO declara vem da CLASSE do framework legado, nunca de
981:     * palpite (docs\FRAMEWORK_class_codigo_fonte.txt):
982:     *   say    AutoSize=.T. FontName="Tahoma" FontSize=8 BackStyle=0
983:     *          Height=15 Width=27 ForeColor=90,90,90
984:     *   fwget  FontName="Tahoma" FontSize=8 Format="K" Height=23 Width=100
985:     *          DisabledBackColor=192,192,192 DisabledForeColor=0,0,0 Themes=.F.
986:     *
987:     * ForeColor BRANCO no lbl_4c_Frase eh legitimo e NAO vira RGB(90,90,90):
988:     * Top=46 com Height=34 deixa a frase em 46..80, isto eh, INTEIRAMENTE
989:     * dentro da faixa cnt_4c_Sombra (0..80), que eh container OPACO com
990:     * BackColor RGB(100,100,100). A frase eh filha da Form, nao do container, e
991:     * desenha POR CIMA do cinza - condicao exata da excecao de branco. Eh
992:     * tambem por isso que este metodo roda DEPOIS de ConfigurarCabecalho.
993:     *
994:     * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
995:     * criado por AddObject (a largura fica nos 100 do default) e, com
996:     * WordWrap = .T., chega a DESCARTAR a Height - a frase de duas linhas
997:     * (Height = 34) colapsaria para uma e a segunda linha desapareceria sem
998:     * erro e sem log. Na Frase o par Width/Height vem do dump; no
999:     * lbl_4c_Label2, que herda AutoSize = .T. da classe say e nao declara
1000:     * tamanho nenhum, a Width eh medida para caber a legenda - NUNCA os 27 da
1001:     * classe, que sao a largura do Caption "Label" e cortariam a legenda.
1002:     *
1003:     * Alignment = 0 no lbl_4c_Label2: a classe say desenha da esquerda, e o
1004:     * dump nao declara nem Alignment nem Width. Inventar Alignment = 1 jogaria

*-- Linhas 1012 a 1065:
1012:     * nunca do Width em pixels, e casa com os 10 "!" do InputMask.
1013:     *
1014:     * Enabled reproduz o When do campo usuario no legado, calculado por
1015:     * UsuarioEditavel(). When nao pode ser ligado por BINDEVENT - o bind
1016:     * descarta o retorno do delegate e o gate nao bloquearia nada -, e
1017:     * reproduzir When por Enabled eh o que o projeto ja faz (FormCLC). As cores
1018:     * de desabilitado vem da classe fwget, para o campo travado ficar com a
1019:     * mesma aparencia que tem no legado.
1020:     *
1021:     * Nos tipos em que a tela passa a conferir a senha do dia, o legado
1022:     * preenche o campo com o usuario logado (.usuario.Value = Usuar) - valor ja
1023:     * resolvido por AvaliarSenhaDoDia() em this_cUsuLibs.
1024:     *--------------------------------------------------------------------------
1025:     PROTECTED PROCEDURE ConfigurarCamposUsuario()
1026:         *-- Frase que explica a liberacao pedida (Frase do legado)
1027:         THIS.AddObject("lbl_4c_Frase", "Label")
1028: 
1029:         WITH THIS.lbl_4c_Frase
1030:             .AutoSize   = .F.
1031:             .FontName   = "Tahoma"
1032:             .FontSize   = 8
1033:             .FontBold   = .T.
1034:             .FontItalic = .T.
1035:             .WordWrap   = .T.
1036:             .Alignment  = 2
1037:             .BackStyle  = 0
1038:             .Caption    = THIS.this_cFrase
1039:             .Top        = 46
1040:             .Left       = 2
1041:             .Width      = 394
1042:             .Height     = 34
1043:             .ForeColor  = RGB(255, 255, 255)
1044:             .TabIndex   = 1
1045:             .Visible    = .T.
1046:         ENDWITH
1047: 
1048:         *-- Rotulo "Usuario :" (Say2 do legado)
1049:         THIS.AddObject("lbl_4c_Label2", "Label")
1050: 
1051:         WITH THIS.lbl_4c_Label2
1052:             .AutoSize  = .F.
1053:             .FontName  = "Tahoma"
1054:             .FontSize  = 8
1055:             .FontBold  = .T.
1056:             .WordWrap  = .F.
1057:             .Alignment = 0
1058:             .BackStyle = 0
1059:             .Caption   = "Usu" + CHR(225) + "rio : "
1060:             .Top       = 102
1061:             .Left      = 112
1062:             .Width     = 54
1063:             .Height    = 15
1064:             .ForeColor = RGB(90, 90, 90)
1065:             .TabIndex  = 2

*-- Linhas 1124 a 1167:
1124:     * PUBLIC: eh reavaliado sempre que os parametros do sistema ou o tipo da
1125:     * liberacao mudam, inclusive de fora da classe.
1126:     *--------------------------------------------------------------------------
1127:     PROCEDURE UsuarioEditavel()
1128:         LOCAL loc_cTipo, loc_lLiblCreds, loc_lEditavel
1129: 
1130:         loc_lLiblCreds = .F.
1131: 
1132:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1133:             loc_lLiblCreds = THIS.this_oBusinessObject.this_lLiblCreds
1134:         ENDIF
1135: 
1136:         loc_cTipo = UPPER(ALLTRIM(THIS.this_cTipo))
1137: 
1138:         loc_lEditavel = (!loc_lLiblCreds OR !INLIST(loc_cTipo, "LIMITE", "LIBPRDZ2")) ;
1139:             AND !(loc_cTipo == "MAXIMO")
1140: 
1141:         RETURN loc_lEditavel
1142:     ENDPROC
1143: 
1144:     *--------------------------------------------------------------------------
1145:     * ConfigurarCamposSenha - Restante dos campos da tela: a linha
1146:     * "Senha :" com o campo mascarado e o icone de login.
1147:     *
1148:     * Legado (transcrito do dump - PILAR 1):
1149:     *   Say3   FontBold=.T. FontName="Tahoma" Caption="Senha : "
1150:     *          Left=120 Top=135 Visible=.T. ForeColor=90,90,90
1151:     *   senha  FontName="Tahoma" FontSize=12 Height=30
1152:     *          InputMask="!!!!!!!!!!" Left=168 Top=127 Visible=.T.
1153:     *          Width=119 PasswordChar="*" ForeColor=0,0,0
1154:     *   Image1 Picture=..\framework\imagens\geral_login_60.jpg Stretch=0
1155:     *          Height=32 Left=44 Top=109 Width=32
1156:     *
1157:     * O que o dump nao declara vem da CLASSE, nunca de palpite: say
1158:     * (AutoSize=.T. FontSize=8 BackStyle=0 Height=15) e fwget (FontSize=8
1159:     * Format="K" DisabledBackColor=192,192,192 DisabledForeColor=0,0,0
1160:     * Themes=.F.). O dump nao declara TabIndex para nenhum destes tres, e a
1161:     * ordem dos AddObject (depois da linha do usuario, que tem TabIndex=3)
1162:     * ja reproduz a sequencia de tabulacao do legado.
1163:     *
1164:     * Alignment NAO eh declarado no campo de senha porque o dump tambem nao
1165:     * declara: TextBox criado por AddObject nasce com Alignment = 3 (medido),
1166:     * que eh o mesmo valor que o legado obtem da classe.
1167:     *

*-- Linhas 1198 a 1241:
1198:     * legenda - a de 27 da classe eh a largura do Caption "Label" e
1199:     * cortaria o texto.
1200:     *--------------------------------------------------------------------------
1201:     PROTECTED PROCEDURE ConfigurarCamposSenha()
1202:         LOCAL loc_cCaption, loc_nLeft, loc_nWidth
1203: 
1204:         *-- Legado: no modo senha do dia o Init troca o Caption e reposiciona
1205:         *-- o rotulo (ver o desvio documentado acima)
1206:         IF THIS.this_lSenhaDoDia
1207:             loc_cCaption = "Senha Do Dia :"
1208:             loc_nLeft    = 86
1209:             loc_nWidth   = 80
1210:         ELSE
1211:             loc_cCaption = "Senha : "
1212:             loc_nLeft    = 120
1213:             loc_nWidth   = 46
1214:         ENDIF
1215: 
1216:         *-- Rotulo da linha da senha (Say3 do legado)
1217:         THIS.AddObject("lbl_4c_Label3", "Label")
1218: 
1219:         WITH THIS.lbl_4c_Label3
1220:             .AutoSize  = .F.
1221:             .FontName  = "Tahoma"
1222:             .FontSize  = 8
1223:             .FontBold  = .T.
1224:             .WordWrap  = .F.
1225:             .Alignment = 0
1226:             .BackStyle = 0
1227:             .Caption   = loc_cCaption
1228:             .Top       = 135
1229:             .Left      = loc_nLeft
1230:             .Width     = loc_nWidth
1231:             .Height    = 15
1232:             .ForeColor = RGB(90, 90, 90)
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         *-- Campo da senha (senha do legado, classe fwget)
1237:         THIS.AddObject("txt_4c_Senha", "TextBox")
1238: 
1239:         WITH THIS.txt_4c_Senha
1240:             .Value             = ""
1241:             .FontName          = "Tahoma"

*-- Linhas 1272 a 1387:
1272:     ENDPROC
1273: 
1274:     *--------------------------------------------------------------------------
1275:     * LigarEventos - Liga por BINDEVENT os eventos que o legado escreve nos
1276:     * controles. Roda DEPOIS de todo AddObject: BINDEVENT em controle que
1277:     * ainda nao existe estoura no proprio bind.
1278:     *
1279:     * O legado tem codigo em DOIS eventos do campo usuario:
1280:     *   usuario.Valid    - resolve o usuario (consulta + picker + senha)
1281:     *   usuario.KeyPress - ESC com o campo em branco encerra o dialogo
1282:     *
1283:     * O Valid vai para "LostFocus", nunca para "KeyPress" (regra #47): o
1284:     * Valid legado dispara ao SAIR do campo, e um handler de KeyPress que
1285:     * abre picker sem testar a tecla abriria o dialogo a CADA caractere -
1286:     * digitando "MARCELO" o picker subiria no "M" e o usuario nao
1287:     * conseguiria terminar de digitar. BINDEVENT em "Valid" de TextBox
1288:     * tambem nao dispara de forma confiavel no VFP9.
1289:     *
1290:     * O When do campo usuario NAO eh ligado por BINDEVENT: o bind descarta o
1291:     * retorno do delegate, entao o gate nao bloquearia nada. Ele eh
1292:     * reproduzido por Enabled, calculado por UsuarioEditavel() (ver
1293:     * ConfigurarCamposUsuario).
1294:     *
1295:     * F4 e DblClick sao entradas ADICIONAIS para o mesmo picker, convencao
1296:     * do projeto para campo com lookup. Sao aditivas: nao retiram nem
1297:     * alteram nenhum caminho do legado, apenas dispensam o usuario de
1298:     * digitar um codigo invalido so para a lista aparecer.
1299:     *
1300:     * O campo SENHA tem UM evento no legado - o Valid, que eh o fluxo de
1301:     * ACAO da tela (senha livre de SigPrSnd, senha cadastrada ou senha do
1302:     * dia, log de liberacao e o desfecho do gate). Ele vai para
1303:     * "LostFocus" pelo mesmo motivo do campo usuario, e com mais razao:
1304:     * ligado a "KeyPress" ele conferiria uma senha INCOMPLETA a cada
1305:     * caractere digitado e dispararia o dialogo "Deseja digitar novamente
1306:     * ?" na primeira tecla.
1307:     *
1308:     * O campo senha NAO recebe KeyPress nem DblClick: o legado nao escreve
1309:     * nenhum dos dois nele (nao ha lookup de senha, e o ESC do dialogo mora
1310:     * no campo usuario). Inventar aqui um atalho que o legado nao tem seria
1311:     * acrescentar superficie (PILAR 1) - e a saida do dialogo continua
1312:     * existindo pelos dois caminhos do legado: ESC no campo usuario em
1313:     * branco, e responder "Nao" ao dialogo de conflito.
1314:     *--------------------------------------------------------------------------
1315:     PROTECTED PROCEDURE LigarEventos()
1316:         BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "UsuarioLostFocus")
1317:         BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "UsuarioKeyPress")
1318:         BINDEVENT(THIS.txt_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")
1319: 
1320:         BINDEVENT(THIS.txt_4c_Senha, "LostFocus", THIS, "SenhaLostFocus")
1321: 
1322:         RETURN
1323:     ENDPROC
1324: 
1325:     *--------------------------------------------------------------------------
1326:     * UsuarioLostFocus - Equivalente ao Valid do campo usuario legado.
1327:     *
1328:     * WRAPPER FINO, so para a guarda de reentrancia: o corpo fica em
1329:     * UsuarioLostFocusExec() porque ele tem RETURN antecipado em varios
1330:     * caminhos (campo vazio, valor ja validado, consulta falhou) e, com
1331:     * set/clear no proprio corpo, qualquer um desses RETURN deixaria a flag
1332:     * LIGADA para sempre - e dai o lookup nunca mais abriria (regra #47). O
1333:     * wrapper libera a flag em UMA linha que nenhum RETURN do corpo
1334:     * consegue pular.
1335:     *
1336:     * A reentrancia eh real: o picker eh MODAL, tira o foco do campo e faz o
1337:     * proprio LostFocus disparar de novo; sem a guarda abririam DOIS
1338:     * dialogos empilhados (regra #37).
1339:     *
1340:     * this_lDialogoEncerrado barra a segunda passada depois do Hide(): o
1341:     * dialogo ja devolveu a resposta ao chamador, revalidar o campo ali
1342:     * poderia sobrescrever this_lZSen depois de lido.
1343:     *
1344:     * PUBLIC: BINDEVENT so funciona com metodo PUBLIC - PROTECTED falha em
1345:     * silencio (regra #3).
1346:     *--------------------------------------------------------------------------
1347:     PROCEDURE UsuarioLostFocus()
1348:         IF THIS.this_lEmLookupUsuario OR THIS.this_lDialogoEncerrado
1349:             RETURN
1350:         ENDIF
1351: 
1352:         THIS.this_lEmLookupUsuario = .T.
1353:         THIS.UsuarioLostFocusExec()
1354:         THIS.this_lEmLookupUsuario = .F.
1355: 
1356:         RETURN
1357:     ENDPROC
1358: 
1359:     *--------------------------------------------------------------------------
1360:     * UsuarioLostFocusExec - Corpo do Valid do campo usuario legado.
1361:     *
1362:     * Legado, na ordem:
1363:     *   1. If Empty(This.Value) -> ZSen = .f. / ThisForm.Release / Return .t.
1364:     *   2. Do Case ... monta lcQuery conforme a liberacao pedida
1365:     *   3. If (SqlExecute(lcQuery,'TmpUsu') < 1) -> MessageBox / Return .f.
1366:     *   4. index on usuarios tag usuarios / set near on
1367:     *      if not seek(this.value) -> fwBuscaSel('tmpusu','usuarios',...)
1368:     *   5. thisform.usulibs = this.value
1369:     *   6. If IsEmpty(usual) -> zsen = .F. / release
1370:     *      Else If lastkey() <> 27
1371:     *              If IsEmpty(TmpUsu.senhas) -> autoriza na hora, esconde a
1372:     *                                           linha da senha e fecha
1373:     *              Else -> mostra a linha da senha e espera
1374:     *
1375:     * Os passos 2 e 3 moram no BO (MontarQueryUsuarios /
1376:     * CarregarUsuariosAutorizados): a escolha de QUAL permissao de cargo
1377:     * sera exigida eh regra de negocio, e eh no BO que vivem as 21 flags de
1378:     * liberacao que ConfigurarPorTipo() liga.
1379:     *
1380:     * TRES desvios deliberados, todos documentados:
1381:     *
1382:     * (1) O "index on usuarios tag usuarios" + "set near on" + "seek" do
1383:     *     legado vira LOCALIZACAO POR PREFIXO em LocalizarUsuario(): cursor
1384:     *     de SQL pass-through eh somente-leitura (nao aceita INDEX ON) e,
1385:     *     com o SET EXACT ON que o sistema novo liga no startup, SEEK
1386:     *     exigiria a chave inteira e o codigo parcial nunca casaria - o
1387:     *     oposto do legado, onde o seek casava prefixo.

*-- Linhas 1420 a 1514:
1420:     *
1421:     * PUBLIC: chamado pelo wrapper e pelos testes do harness.
1422:     *--------------------------------------------------------------------------
1423:     PROCEDURE UsuarioLostFocusExec()
1424:         LOCAL loc_oBO, loc_cValor, loc_cCursor, loc_lProsseguir, loc_lAchou, loc_oErro
1425: 
1426:         loc_oBO = THIS.this_oBusinessObject
1427: 
1428:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "txt_4c_Usuario", 5)
1429:             RETURN
1430:         ENDIF
1431: 
1432:         loc_cValor = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
1433: 
1434:         *-- Legado: If Empty(This.Value) -> ZSen = .f. / ThisForm.Release
1435:         IF EMPTY(loc_cValor)
1436:             THIS.this_lZSen    = .F.
1437:             loc_oBO.this_lZSen = .F.
1438:             THIS.FecharDialogo()
1439:             RETURN
1440:         ENDIF
1441: 
1442:         *-- Guard de valor-nao-mudou: o Valid legado roda ao sair do campo;
1443:         *-- o LostFocus roda em toda perda de foco, inclusive na volta do
1444:         *-- proprio picker (ver this_cUltimoUsuarioValidado)
1445:         IF loc_cValor == THIS.this_cUltimoUsuarioValidado
1446:             RETURN
1447:         ENDIF
1448: 
1449:         loc_lProsseguir = .T.
1450:         loc_lAchou      = .F.
1451:         loc_cCursor     = loc_oBO.this_cCursorUsuarios
1452: 
1453:         TRY
1454:             *-- Passos 2 e 3 do legado (Do Case + SqlExecute em TmpUsu)
1455:             IF !loc_oBO.CarregarUsuariosAutorizados()
1456:                 MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
1457:                     "Favor Reinicializar o Processo!!!", loc_oBO.this_cMensagemErro), ;
1458:                     "Falha na Conex" + CHR(227) + "o (TmpUsu)")
1459:                 loc_lProsseguir = .F.
1460:             ENDIF
1461: 
1462:             IF loc_lProsseguir
1463:                 loc_cCursor = loc_oBO.this_cCursorUsuarios
1464:                 loc_lAchou  = THIS.LocalizarUsuario(loc_cValor)
1465: 
1466:                 *-- Legado: if not seek(this.value) -> abre o fwBuscaSel
1467:                 IF !loc_lAchou
1468:                     IF THIS.AbrirBuscaUsuario()
1469:                         loc_cValor = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
1470:                         loc_lAchou = THIS.LocalizarUsuario(loc_cValor)
1471:                     ENDIF
1472:                 ENDIF
1473: 
1474:                 THIS.this_cUltimoUsuarioValidado = loc_cValor
1475: 
1476:                 *-- Legado: thisform.usulibs = this.value
1477:                 THIS.this_cUsuLibs    = loc_cValor
1478:                 loc_oBO.this_cUsuLibs = loc_cValor
1479:                 loc_oBO.this_cUsuario = loc_cValor
1480: 
1481:                 DO CASE
1482:                     CASE loc_lAchou
1483:                         *-- Le a linha do usuario resolvido (usuarios /
1484:                         *-- senhas / ccargs / cativos) para as properties
1485:                         loc_oBO.CarregarDoCursor(loc_cCursor)
1486: 
1487:                         IF EMPTY(ALLTRIM(loc_oBO.this_cSenhaCadastrada))
1488:                             *-- Legado: If IsEmpty(TmpUsu.senhas) -> zsen = .t.
1489:                             *-- say3/senha invisiveis + release
1490:                             loc_oBO.this_lExigeSenha   = .F.
1491:                             THIS.lbl_4c_Label3.Visible = .F.
1492:                             THIS.txt_4c_Senha.Visible  = .F.
1493:                             THIS.this_lZSen            = .T.
1494:                             loc_oBO.this_lZSen         = .T.
1495:                             THIS.FecharDialogo()
1496:                         ELSE
1497:                             *-- Legado: Else -> say3/senha visiveis e espera
1498:                             loc_oBO.this_lExigeSenha   = .T.
1499:                             THIS.lbl_4c_Label3.Visible = .T.
1500:                             THIS.txt_4c_Senha.Visible  = .T.
1501:                         ENDIF
1502: 
1503:                     CASE !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1504:                         *-- Nenhum usuario habilitado a conceder esta
1505:                         *-- liberacao: nega e encerra (cursor vazio no legado
1506:                         *-- deixava "usual" vazio -> zsen = .F. + release).
1507:                         *-- usulibs volta a vazio porque no legado ele recebia
1508:                         *-- o "this.value" lido do cursor VAZIO: dialogo
1509:                         *-- recusado nao devolve nome de liberador.
1510:                         THIS.this_cUsuLibs    = ""
1511:                         loc_oBO.this_cUsuLibs = ""
1512:                         THIS.this_lZSen       = .F.
1513:                         loc_oBO.this_lZSen    = .F.
1514:                         THIS.FecharDialogo()

*-- Linhas 1524 a 1753:
1524:         CATCH TO loc_oErro
1525:             MsgErro(loc_oErro.Message + CHR(13) + ;
1526:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1527:                 "Procedure: " + loc_oErro.Procedure, ;
1528:                 "Erro ao validar o usu" + CHR(225) + "rio")
1529:         ENDTRY
1530: 
1531:         RETURN
1532:     ENDPROC
1533: 
1534:     *--------------------------------------------------------------------------
1535:     * UsuarioKeyPress - KeyPress do campo usuario legado:
1536:     *
1537:     *   If (Lastkey() = 27) And Empty(This.Value)
1538:     *       ZSen = .f. / ThisForm.ZSen = .f. / ThisForm.Release
1539:     *   EndIf
1540:     *
1541:     * ESC com o campo em branco eh a saida do dialogo NEGANDO a liberacao -
1542:     * esta tela nao tem botao algum, e este eh o unico caminho de
1543:     * cancelamento junto com o campo deixado vazio.
1544:     *
1545:     * F4 eh a entrada ADICIONAL do picker (convencao do projeto). Ela chama
1546:     * AbrirBuscaUsuario() DIRETO em vez de delegar ao funil do LostFocus:
1547:     * o funil comeca testando "campo vazio -> encerra o dialogo", e F4 com o
1548:     * campo em branco tem de ABRIR A LISTA, nao fechar a tela.
1549:     *
1550:     * A guarda de reentrancia aqui eh SAVE/RESTORE, nao set/clear: este
1551:     * handler pode ser alcancado de dentro de um fluxo que ja ligou a flag,
1552:     * e um clear simples a liberaria cedo demais (regra #47).
1553:     *
1554:     * Nenhuma outra tecla eh interceptada: o DO CASE sem OTHERWISE deixa a
1555:     * digitacao seguir normalmente.
1556:     *
1557:     * LPARAMETERS obrigatorio - handler de KeyPress sem os parametros do
1558:     * evento estoura a cada tecla (regra #3).
1559:     *
1560:     * PUBLIC: exigencia do BINDEVENT.
1561:     *--------------------------------------------------------------------------
1562:     PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1563:         LOCAL loc_lEmLookupAnt
1564: 
1565:         IF PCOUNT() < 1 OR VARTYPE(par_nKeyCode) != "N"
1566:             RETURN
1567:         ENDIF
1568: 
1569:         DO CASE
1570:             CASE par_nKeyCode = 27
1571:                 IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
1572:                     THIS.this_lZSen = .F.
1573: 
1574:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1575:                         THIS.this_oBusinessObject.this_lZSen = .F.
1576:                     ENDIF
1577: 
1578:                     THIS.FecharDialogo()
1579:                 ENDIF
1580: 
1581:             CASE par_nKeyCode = 115
1582:                 loc_lEmLookupAnt           = THIS.this_lEmLookupUsuario
1583:                 THIS.this_lEmLookupUsuario = .T.
1584:                 THIS.AbrirBuscaUsuario()
1585:                 THIS.this_lEmLookupUsuario = loc_lEmLookupAnt
1586:         ENDCASE
1587: 
1588:         RETURN
1589:     ENDPROC
1590: 
1591:     *--------------------------------------------------------------------------
1592:     * UsuarioDblClick - Terceira entrada do mesmo picker, pela convencao do
1593:     * projeto (duplo clique no campo com lookup). Aditiva, como o F4.
1594:     *
1595:     * Guarda SAVE/RESTORE pelo mesmo motivo do UsuarioKeyPress.
1596:     *
1597:     * PUBLIC: exigencia do BINDEVENT.
1598:     *--------------------------------------------------------------------------
1599:     PROCEDURE UsuarioDblClick()
1600:         LOCAL loc_lEmLookupAnt
1601: 
1602:         loc_lEmLookupAnt           = THIS.this_lEmLookupUsuario
1603:         THIS.this_lEmLookupUsuario = .T.
1604:         THIS.AbrirBuscaUsuario()
1605:         THIS.this_lEmLookupUsuario = loc_lEmLookupAnt
1606: 
1607:         RETURN
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * AbrirBuscaUsuario - Picker de selecao do usuario autorizado.
1612:     *
1613:     * Legado (dentro do Valid do campo usuario):
1614:     *   xBrow    = CreateObject('fwBuscaSel','tmpusu','usuarios',this.value,'Selecao')
1615:     *   xBrowCol = xBrow.AddColuna('usuarios','','Codigo',.t.,'usuarios')
1616:     *   xBrowCol = xBrow.AddColuna('ccargs','','cargo',.F.)
1617:     *   xBrow.Show
1618:     *
1619:     * fwBuscaSel busca num CURSOR LOCAL ja carregado, nao numa tabela do
1620:     * servidor - no sistema novo isso eh o FormBuscaAuxiliar pela API
1621:     * DefinirCursor/Mostrar, que exibe o cursor como ele esta e NAO dispara
1622:     * consulta propria. A API alternativa (CREATEOBJECT com parametros)
1623:     * seria errada aqui: ela monta um SELECT na tabela, e o universo desta
1624:     * busca nao eh "todos os usuarios", eh "os usuarios que podem conceder
1625:     * ESTA liberacao" - a consulta filtrada que o BO acabou de rodar.
1626:     *
1627:     * As legendas das duas colunas sao as do legado ("Codigo" e "cargo",
1628:     * esta em minuscula como escrita la). DefinirCursor cria as duas colunas
1629:     * usando o NOME do campo como titulo, por isso os titulos sao
1630:     * reescritos em seguida em this_aColunas[n, 3].
1631:     *
1632:     * F4/DblClick podem chegar antes de qualquer LostFocus, com o cursor
1633:     * ainda inexistente: nesse caso a lista eh carregada aqui. Pelo caminho
1634:     * do LostFocus ela ja esta carregada e nenhuma consulta eh repetida.
1635:     *
1636:     * Lista vazia nao abre picker vazio (regra #36): devolve .F. e quem
1637:     * chamou decide - pelo LostFocus isso cai no ramo que nega a liberacao e
1638:     * encerra o dialogo, como no legado.
1639:     *
1640:     * O valor eh gravado no campo SOMENTE quando houve selecao, e o codigo
1641:     * digitado NUNCA eh apagado quando nao houve (regras #37 e #50).
1642:     *
1643:     * Release() ao final, depois de ler o resultado: FormBuscaAuxiliar fecha
1644:     * com Hide() justamente para o chamador poder ler as properties.
1645:     *
1646:     * PUBLIC: eh o funil do lookup, chamado pelo LostFocus, pelo F4 e pelo
1647:     * DblClick.
1648:     *--------------------------------------------------------------------------
1649:     PROCEDURE AbrirBuscaUsuario()
1650:         LOCAL loc_oBO, loc_oBusca, loc_cCursor, loc_lSelecionou
1651: 
1652:         loc_lSelecionou = .F.
1653:         loc_oBO         = THIS.this_oBusinessObject
1654: 
1655:         IF VARTYPE(loc_oBO) != "O"
1656:             RETURN .F.
1657:         ENDIF
1658: 
1659:         loc_cCursor = loc_oBO.this_cCursorUsuarios
1660: 
1661:         *-- Entrada por F4/DblClick: a lista ainda pode nao ter sido carregada
1662:         IF !USED(loc_cCursor)
1663:             IF !loc_oBO.CarregarUsuariosAutorizados()
1664:                 MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
1665:                     "Favor Reinicializar o Processo!!!", loc_oBO.this_cMensagemErro), ;
1666:                     "Falha na Conex" + CHR(227) + "o (TmpUsu)")
1667:                 RETURN .F.
1668:             ENDIF
1669:         ENDIF
1670: 
1671:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1672:             RETURN .F.
1673:         ENDIF
1674: 
1675:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1676: 
1677:         IF VARTYPE(loc_oBusca) = "O"
1678:             loc_oBusca.DefinirCursor(loc_cCursor, "usuarios", "ccargs", ;
1679:                 "Sele" + CHR(231) + CHR(227) + "o")
1680:             loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1681:             loc_oBusca.this_aColunas[2, 3] = "cargo"
1682: 
1683:             IF loc_oBusca.Mostrar()
1684:                 THIS.txt_4c_Usuario.Value = loc_oBusca.cCodigoSelecionado
1685:                 THIS.txt_4c_Usuario.Refresh()
1686:                 loc_lSelecionou = .T.
1687:             ENDIF
1688: 
1689:             loc_oBusca.Release()
1690:         ENDIF
1691: 
1692:         RETURN loc_lSelecionou
1693:     ENDPROC
1694: 
1695:     *--------------------------------------------------------------------------
1696:     * LocalizarUsuario - Equivalente do "seek(this.value)" legado sobre o
1697:     * cursor de usuarios autorizados, posicionando-o na linha encontrada
1698:     * (quem chama le o registro corrente depois).
1699:     *
1700:     * Por que LOCATE e nao SEEK: o cursor vem de SQL pass-through e eh
1701:     * somente-leitura, logo nao aceita o "index on usuarios tag usuarios" do
1702:     * legado; e o sistema novo liga SET EXACT ON no startup, com o que SEEK
1703:     * passaria a exigir a chave INTEIRA e um codigo parcial nunca casaria -
1704:     * o contrario do legado, onde o seek casava PREFIXO. O teste explicito
1705:     * UPPER(LEFT(usuarios, LEN(valor))) == valor reproduz esse prefixo e nao
1706:     * depende de SET EXACT nem de SET NEAR.
1707:     *
1708:     * A ordenacao da lista, que no legado vinha do indice, vem do ORDER BY
1709:     * da consulta montada pelo BO.
1710:     *
1711:     * PUBLIC: usado pelo fluxo de validacao e pelos testes do harness.
1712:     *--------------------------------------------------------------------------
1713:     PROCEDURE LocalizarUsuario(par_cValor)
1714:         LOCAL loc_oBO, loc_cCursor, loc_cValor
1715: 
1716:         loc_oBO = THIS.this_oBusinessObject
1717: 
1718:         IF VARTYPE(loc_oBO) != "O"
1719:             RETURN .F.
1720:         ENDIF
1721: 
1722:         loc_cCursor = loc_oBO.this_cCursorUsuarios
1723: 
1724:         IF !USED(loc_cCursor)
1725:             RETURN .F.
1726:         ENDIF
1727: 
1728:         loc_cValor = UPPER(ALLTRIM(NVL(par_cValor, "")))
1729: 
1730:         IF EMPTY(loc_cValor)
1731:             RETURN .F.
1732:         ENDIF
1733: 
1734:         SELECT (loc_cCursor)
1735:         LOCATE FOR UPPER(LEFT(usuarios, LEN(m.loc_cValor))) == m.loc_cValor
1736: 
1737:         RETURN FOUND(loc_cCursor)
1738:     ENDPROC
1739: 
1740:     *--------------------------------------------------------------------------
1741:     * SenhaLostFocus - Equivalente ao Valid do campo senha legado, que eh o
1742:     * fluxo de ACAO desta tela: eh aqui que a liberacao eh concedida ou
1743:     * recusada.
1744:     *
1745:     * WRAPPER FINO, so para a guarda de reentrancia, pelo mesmo desenho do
1746:     * UsuarioLostFocus: o corpo tem RETURN antecipado em varios caminhos
1747:     * (campo de senha oculto, senha ja conferida, usuario nao resolvido) e,
1748:     * com set/clear no proprio corpo, qualquer um desses RETURN deixaria a
1749:     * flag LIGADA para sempre - e dai a senha nunca mais seria conferida e o
1750:     * gate ficaria impossivel de passar (regra #47). O wrapper libera a flag
1751:     * em UMA linha que nenhum RETURN do corpo consegue pular.
1752:     *
1753:     * A reentrancia eh real: o corpo pode exibir o dialogo "Deseja digitar

*-- Linhas 1761 a 1807:
1761:     * nao pode rodar de novo depois de a resposta ter sido publicada em
1762:     * this_cRetorno / this_lZSen.
1763:     *
1764:     * PUBLIC: BINDEVENT so funciona com metodo PUBLIC - PROTECTED falha em
1765:     * silencio (regra #3).
1766:     *--------------------------------------------------------------------------
1767:     PROCEDURE SenhaLostFocus()
1768:         IF THIS.this_lEmValidacaoSenha OR THIS.this_lDialogoEncerrado
1769:             RETURN
1770:         ENDIF
1771: 
1772:         THIS.this_lEmValidacaoSenha = .T.
1773:         THIS.SenhaLostFocusExec()
1774:         THIS.this_lEmValidacaoSenha = .F.
1775: 
1776:         RETURN
1777:     ENDPROC
1778: 
1779:     *--------------------------------------------------------------------------
1780:     * SenhaLostFocusExec - Corpo do Valid do campo senha legado.
1781:     *
1782:     * A regra de negocio inteira (as duas consultas, a baixa da senha livre,
1783:     * a escolha entre senha cadastrada e senha do dia, as duas formas de
1784:     * comparar e o log) esta no BO, em ConferirSenha(). O que fica aqui eh o
1785:     * que eh decisao de TELA:
1786:     *
1787:     *   1. de onde vem a senha digitada (o campo) e para onde ela vai (o BO)
1788:     *   2. o dialogo "Deseja digitar novamente ? (S/N)" do legado
1789:     *   3. para onde volta o foco quando o usuario quer redigitar
1790:     *   4. fechar o dialogo publicando o resultado
1791:     *
1792:     * Desfechos do legado, na mesma ordem:
1793:     *
1794:     *   autorizado           -> Thisform.zsen = .T. / Thisform.release
1795:     *   senha conflitante    -> if messagebox('Deseja digitar novamente ? (S/N)',
1796:     *                              4+256, 'Senha Conflitante...') = 7
1797:     *                              thisform.zsen=.F. / thisform.release
1798:     *                           else
1799:     *                              return 0       && NAO deixa sair do campo
1800:     *                           endif
1801:     *
1802:     * O "return 0" do legado eh o Valid recusando a saida do campo: a tela
1803:     * fica aberta, o texto digitado PERMANECE (o legado nao limpa o campo) e
1804:     * o foco volta para a senha. Reproduzido por SetFocus() no campo mais a
1805:     * limpeza do guard this_cUltimaSenhaValidada - sem limpar o guard, a
1806:     * segunda tentativa com a MESMA senha nao seria reconferida e o usuario
1807:     * conseguiria sair do campo sem resposta, que eh justamente o que o

*-- Linhas 1825 a 1868:
1825:     * oferecer "digitar novamente" so prenderia o usuario num ciclo de erros
1826:     * que redigitar nao resolve.
1827:     *--------------------------------------------------------------------------
1828:     PROCEDURE SenhaLostFocusExec()
1829:         LOCAL loc_oBO, loc_cSenha, loc_cUsuario, loc_oErro
1830: 
1831:         loc_oBO = THIS.this_oBusinessObject
1832: 
1833:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "txt_4c_Senha", 5) ;
1834:                 OR !PEMSTATUS(THIS, "txt_4c_Usuario", 5)
1835:             RETURN
1836:         ENDIF
1837: 
1838:         *-- Campo escondido pelo fluxo do usuario: liberacao sem senha
1839:         IF !THIS.txt_4c_Senha.Visible
1840:             RETURN
1841:         ENDIF
1842: 
1843:         loc_cSenha = NVL(THIS.txt_4c_Senha.Value, "")
1844: 
1845:         IF VARTYPE(loc_cSenha) != "C"
1846:             loc_cSenha = ""
1847:         ENDIF
1848: 
1849:         *-- Guard de valor-nao-mudou: o Valid legado roda ao sair do campo;
1850:         *-- o LostFocus roda em TODA perda de foco, inclusive na volta do
1851:         *-- dialogo de conflito (ver this_cUltimaSenhaValidada)
1852:         IF loc_cSenha == THIS.this_cUltimaSenhaValidada
1853:             RETURN
1854:         ENDIF
1855: 
1856:         loc_cUsuario = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
1857: 
1858:         IF EMPTY(loc_cUsuario)
1859:             RETURN
1860:         ENDIF
1861: 
1862:         THIS.this_cUltimaSenhaValidada = loc_cSenha
1863: 
1864:         TRY
1865:             *-- Leva usuario e senha da tela para o BO antes de conferir
1866:             THIS.FormParaBO()
1867: 
1868:             IF loc_oBO.ConferirSenha(loc_cSenha)

*-- Linhas 1907 a 2025:
1907: 
1908:             MsgErro(loc_oErro.Message + CHR(13) + ;
1909:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1910:                 "Procedure: " + loc_oErro.Procedure, ;
1911:                 "Erro ao conferir a senha")
1912:         ENDTRY
1913: 
1914:         RETURN
1915:     ENDPROC
1916: 
1917:     *--------------------------------------------------------------------------
1918:     * ConfirmarRedigitacaoSenha - O dialogo do ramo de conflito do legado:
1919:     *
1920:     *   if messagebox('Deseja digitar novamente ? (S/N)', 4+256,
1921:     *                 'Senha Conflitante...' ) = 7
1922:     *
1923:     * Devolve .T. quando o usuario quer DIGITAR DE NOVO e .F. quando
1924:     * desiste (o 7 do legado eh o "Nao").
1925:     *
1926:     * MsgConfirma eh a funcao canonica do projeto para Sim/Nao e devolve
1927:     * LOGICAL, nao numerico (regra #7) - MESSAGEBOX direto eh proibido.
1928:     *
1929:     * Duas diferencas em relacao ao MESSAGEBOX legado, as duas sem efeito
1930:     * sobre o desfecho:
1931:     *   - MsgConfirma usa 36 (Sim/Nao + icone de pergunta) onde o legado usa
1932:     *     4+256 (Sim/Nao + segundo botao como default), entao muda o icone e
1933:     *     qual botao nasce com foco;
1934:     *   - em modo de teste automatizado MsgConfirma grava a pergunta em
1935:     *     arquivo e devolve .F. sem abrir dialogo, o que aqui significa
1936:     *     "desistir" - FAIL-CLOSED, o unico desfecho aceitavel para um gate
1937:     *     de autorizacao rodando sem ninguem na frente da tela.
1938:     *
1939:     * O texto vai transcrito do legado, com os acentos em CHR() (regra #4).
1940:     *
1941:     * PUBLIC: usado pelo fluxo de conferencia e pelos testes do harness.
1942:     *--------------------------------------------------------------------------
1943:     PROCEDURE ConfirmarRedigitacaoSenha()
1944:         LOCAL loc_lRedigitar
1945: 
1946:         loc_lRedigitar = MsgConfirma("Deseja digitar novamente ? (S/N)", ;
1947:             "Senha Conflitante...")
1948: 
1949:         RETURN loc_lRedigitar
1950:     ENDPROC
1951: 
1952:     *--------------------------------------------------------------------------
1953:     * FormParaBO - Leva para o BO o conteudo dos campos da tela.
1954:     *
1955:     * Esta tela tem DOIS campos editaveis, e os dois entram aqui:
1956:     *   txt_4c_Usuario -> this_cUsuario  (SigCdUsu.usuarios char(10))
1957:     *   txt_4c_Senha   -> this_cSenha    (conferida contra SigCdUsu.senhas
1958:     *                                     char(10) ou contra a senha do dia)
1959:     *
1960:     * Nao existe terceiro campo a mapear: os demais objetos da tela sao
1961:     * rotulos, a faixa do cabecalho e o icone. Tudo o mais que o BO precisa
1962:     * (tipo, documento, data, empresa, forma de pagamento, valor) nao vem de
1963:     * campo da tela e sim dos PARAMETROS do chamador, repassados uma vez por
1964:     * ConfigurarParametrosBO().
1965:     *
1966:     * O usuario sobe em UPPER+ALLTRIM porque eh assim que o legado o usa na
1967:     * consulta ("usual = upper(usual)"); a senha sobe CRUA, sem UPPER e sem
1968:     * ALLTRIM, porque a comparacao da senha cadastrada eh
1969:     * "Padr(this.value,10) # Padr(senha,10)" - posicional nos 10 caracteres -
1970:     * e trimar ou mudar a caixa aqui mudaria o resultado da comparacao. A
1971:     * caixa alta que o usuario ve vem do InputMask "!!!!!!!!!!" do campo, que
1972:     * eh do legado.
1973:     *
1974:     * this_cUsuLibs NAO eh tocado aqui: quem o resolve eh o fluxo do campo
1975:     * usuario (o "thisform.usulibs = this.value" do legado) ou, nos tipos de
1976:     * senha do dia, o Init atraves de AvaliarSenhaDoDia() - e, no desfecho
1977:     * desse caminho, o proprio ConferirSenha(), que grava nele a senha
1978:     * gerada. Reescrever usulibs a cada transferencia de tela apagaria essas
1979:     * tres resolucoes.
1980:     *
1981:     * PROTECTED: FormParaBO eh hook PROTECTED de FormBase, e subclasse NAO
1982:     * alarga escopo - declarar PUBLIC aqui nao tornaria o metodo chamavel de
1983:     * fora, so divergiria da base (regra #51). Chamado sempre com THIS.
1984:     *--------------------------------------------------------------------------
1985:     PROTECTED PROCEDURE FormParaBO()
1986:         LOCAL loc_oBO, loc_uValor, loc_lResultado
1987: 
1988:         loc_lResultado = .F.
1989:         loc_oBO        = THIS.this_oBusinessObject
1990: 
1991:         IF VARTYPE(loc_oBO) != "O"
1992:             RETURN .F.
1993:         ENDIF
1994: 
1995:         *-- Usuario que concede a liberacao
1996:         IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
1997:             loc_uValor = NVL(THIS.txt_4c_Usuario.Value, "")
1998:             loc_oBO.this_cUsuario = IIF(VARTYPE(loc_uValor) = "C", ;
1999:                 UPPER(ALLTRIM(loc_uValor)), "")
2000:         ENDIF
2001: 
2002:         *-- Senha digitada (CRUA - a comparacao legado eh posicional)
2003:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
2004:             loc_uValor = NVL(THIS.txt_4c_Senha.Value, "")
2005:             loc_oBO.this_cSenha = IIF(VARTYPE(loc_uValor) = "C", loc_uValor, "")
2006:         ENDIF
2007: 
2008:         loc_lResultado = .T.
2009: 
2010:         RETURN loc_lResultado
2011:     ENDPROC
2012: 
2013:     *--------------------------------------------------------------------------
2014:     * BOParaForm - Reflete na tela o estado que o BO mantem.
2015:     *
2016:     * Caminho inverso do FormParaBO, com os mesmos dois campos mais o que o
2017:     * legado altera em runtime a partir do estado do dialogo:
2018:     *
2019:     *   this_cUsuario   -> txt_4c_Usuario.Value
2020:     *   this_cFrase     -> lbl_4c_Frase.Caption   (Frase do legado, resolvida
2021:     *                      pelo tipo da liberacao em ConfigurarPorTipo)
2022:     *   this_lExigeSenha-> lbl_4c_Label3.Visible / txt_4c_Senha.Visible
2023:     *                      (o "thisform.say3.visible / senha.visible" que o
2024:     *                      Valid do usuario legado liga e desliga conforme o
2025:     *                      usuario ter ou nao senha cadastrada)

*-- Linhas 2037 a 2080:
2037:     *
2038:     * PROTECTED: hook PROTECTED de FormBase, como o FormParaBO (regra #51).
2039:     *--------------------------------------------------------------------------
2040:     PROTECTED PROCEDURE BOParaForm()
2041:         LOCAL loc_oBO, loc_cUsuario, loc_lResultado
2042: 
2043:         loc_lResultado = .F.
2044:         loc_oBO        = THIS.this_oBusinessObject
2045: 
2046:         IF VARTYPE(loc_oBO) != "O"
2047:             RETURN .F.
2048:         ENDIF
2049: 
2050:         IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
2051:             loc_cUsuario = NVL(loc_oBO.this_cUsuario, "")
2052:             THIS.txt_4c_Usuario.Value = IIF(VARTYPE(loc_cUsuario) = "C", loc_cUsuario, "")
2053:         ENDIF
2054: 
2055:         *-- Frase que explica a liberacao pedida
2056:         IF PEMSTATUS(THIS, "lbl_4c_Frase", 5)
2057:             THIS.this_cFrase = NVL(loc_oBO.this_cFrase, "")
2058: 
2059:             IF VARTYPE(THIS.this_cFrase) != "C"
2060:                 THIS.this_cFrase = ""
2061:             ENDIF
2062: 
2063:             THIS.lbl_4c_Frase.Caption = THIS.this_cFrase
2064:         ENDIF
2065: 
2066:         *-- Linha da senha: o legado a esconde quando o usuario resolvido
2067:         *-- nao tem senha cadastrada
2068:         IF PEMSTATUS(THIS, "lbl_4c_Label3", 5)
2069:             THIS.lbl_4c_Label3.Visible = loc_oBO.this_lExigeSenha
2070:         ENDIF
2071: 
2072:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
2073:             THIS.txt_4c_Senha.Visible = loc_oBO.this_lExigeSenha
2074:         ENDIF
2075: 
2076:         *-- Dialogo ja resolvido nao aceita mais digitacao
2077:         THIS.HabilitarCampos(!THIS.this_lDialogoEncerrado)
2078: 
2079:         loc_lResultado = .T.
2080: 

*-- Linhas 2088 a 2333:
2088:     * estado que o legado lhe da:
2089:     *
2090:     *   txt_4c_Usuario - o When do campo usuario legado, calculado por
2091:     *       UsuarioEditavel(). O When nao pode ser ligado por BINDEVENT (o
2092:     *       bind descarta o retorno do delegate e o gate nao bloquearia
2093:     *       nada), e reproduzi-lo por Enabled eh o que o projeto ja faz.
2094:     *       Habilitar nao pode IGNORAR esse gate: nos tipos de senha do dia
2095:     *       o campo nasce travado com o usuario logado, e destrava-lo
2096:     *       deixaria o usuario pedir liberacao em nome de outra pessoa.
2097:     *
2098:     *   txt_4c_Senha - editavel enquanto a tela exigir senha
2099:     *       (this_lExigeSenha). Campo de senha que a tela escondeu nao volta
2100:     *       habilitado.
2101:     *
2102:     * Chamado por BOParaForm, que eh o unico lugar que aplica estado de tela
2103:     * - assim nao existem duas regras de habilitacao divergindo.
2104:     *
2105:     * PUBLIC: nao eh hook de FormBase, e o chamador do dialogo (ou o harness)
2106:     * pode precisar trancar a tela por conta propria.
2107:     *--------------------------------------------------------------------------
2108:     PROCEDURE HabilitarCampos(par_lHabilitar)
2109:         LOCAL loc_lHabilitar, loc_oBO, loc_lExigeSenha
2110: 
2111:         loc_lHabilitar = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", ;
2112:             par_lHabilitar, .T.)
2113: 
2114:         loc_oBO        = THIS.this_oBusinessObject
2115:         loc_lExigeSenha = IIF(VARTYPE(loc_oBO) = "O", loc_oBO.this_lExigeSenha, .T.)
2116: 
2117:         IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
2118:             THIS.txt_4c_Usuario.Enabled = loc_lHabilitar AND THIS.UsuarioEditavel()
2119:         ENDIF
2120: 
2121:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
2122:             THIS.txt_4c_Senha.Enabled = loc_lHabilitar AND loc_lExigeSenha
2123:         ENDIF
2124: 
2125:         RETURN
2126:     ENDPROC
2127: 
2128:     *--------------------------------------------------------------------------
2129:     * LimparCampos - Devolve a tela ao estado de "nada informado".
2130:     *
2131:     * Hook PROTECTED de FormBase, chamado por FormBase.Novo(). Nesta tela ele
2132:     * nao tem equivalente no legado (o dialogo vive UM gate e fecha), mas a
2133:     * implementacao herdada nao serve: ela eh vazia, e deixar os guards de
2134:     * validacao apontando para os valores antigos faria a tela aceitar sair
2135:     * dos campos sem reconferir nada - o oposto do que um gate de
2136:     * autorizacao precisa.
2137:     *
2138:     * Limpa os DOIS campos e, junto com eles, os DOIS guards de
2139:     * valor-nao-mudou, que sao estado de validacao e nao de dado: sem
2140:     * devolve-los ao sentinela, o proximo valor digitado poderia casar com o
2141:     * guard e pular a conferencia. O sentinela eh mais longo que as colunas
2142:     * (char(10) nas duas), entao nenhum valor digitavel casa com ele.
2143:     *
2144:     * NAO mexe em this_lZSen nem em this_cUsuLibs: esses sao a RESPOSTA do
2145:     * dialogo, lida pelo chamador depois do Show(), e limpa-los aqui poderia
2146:     * apagar uma autorizacao ja concedida.
2147:     *
2148:     * PROTECTED: hook PROTECTED de FormBase (regra #51).
2149:     *--------------------------------------------------------------------------
2150:     PROTECTED PROCEDURE LimparCampos()
2151:         IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
2152:             THIS.txt_4c_Usuario.Value = ""
2153:         ENDIF
2154: 
2155:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
2156:             THIS.txt_4c_Senha.Value = ""
2157:         ENDIF
2158: 
2159:         THIS.this_cUltimoUsuarioValidado = "@@SEM VALIDACAO@@"
2160:         THIS.this_cUltimaSenhaValidada   = "@@SEM VALIDACAO@@"
2161: 
2162:         RETURN
2163:     ENDPROC
2164: 
2165:     *--------------------------------------------------------------------------
2166:     * MontarRetorno - Expressao do Unload legado:
2167:     *
2168:     *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
2169:     *
2170:     * Autorizado devolve "*" seguido do usuario que liberou; recusado devolve
2171:     * um espaco no lugar do asterisco. O chamador do legado recebia isso em
2172:     * "DO FORM ... TO var"; aqui o resultado eh publicado em this_cRetorno e
2173:     * tambem devolvido, para o chamador poder ler de qualquer um dos dois
2174:     * jeitos depois do Show().
2175:     *
2176:     * O estado vem do BO quando ele existe (eh ele que conclui a conferencia da
2177:     * senha) e espelha nas properties do form, que sao o que o chamador le.
2178:     *
2179:     * PUBLIC: eh o canal de resposta do dialogo.
2180:     *--------------------------------------------------------------------------
2181:     PROCEDURE MontarRetorno()
2182:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2183:             THIS.this_lZSen    = THIS.this_oBusinessObject.this_lZSen
2184:             THIS.this_cUsuLibs = THIS.this_oBusinessObject.this_cUsuLibs
2185:         ENDIF
2186: 
2187:         THIS.this_cRetorno = IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs
2188: 
2189:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2190:             THIS.this_oBusinessObject.this_cRetorno = THIS.this_cRetorno
2191:         ENDIF
2192: 
2193:         RETURN THIS.this_cRetorno
2194:     ENDPROC
2195: 
2196:     *--------------------------------------------------------------------------
2197:     * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
2198:     * deliberada de PILAR 3: fecha com Hide(), nao com Release().
2199:     *
2200:     * Medido no projeto: THIS.Release() destroi o objeto mesmo havendo variavel
2201:     * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
2202:     * a leitura seguinte estoura "is not an object". Esta tela existe para
2203:     * DEVOLVER uma autorizacao, e no legado essa resposta chega por outro
2204:     * caminho: o Unload alimenta o "DO FORM ... TO var" do chamador. Esse canal
2205:     * nao existe no sistema novo, que abre o dialogo com CREATEOBJECT + Show()
2206:     * e le o resultado numa property - entao fechar com Release() aqui
2207:     * destruiria o form antes de o chamador conseguir ler this_lZSen, e o gate
2208:     * de autorizacao ficaria sem como responder.
2209:     *
2210:     * O retorno eh montado ANTES de esconder a tela, para que a resposta esteja
2211:     * publicada no instante em que o Show() devolve o controle ao chamador.
2212:     *
2213:     * Hide() em form modal tambem devolve o Show(), portanto para o usuario a
2214:     * tela fecha igual (PILAR 1 preservado); muda so o tempo de vida do objeto,
2215:     * que eh PILAR 3. Cabe ao CHAMADOR chamar Release() depois de ler (ver o
2216:     * bloco "Uso" do cabecalho). Mesmo desenho que o FormBuscaAuxiliar do
2217:     * projeto ja adota.
2218:     *
2219:     * PUBLIC: eh o unico ponto de fechamento da tela, e o chamador pode
2220:     * precisar fecha-la por conta propria.
2221:     *--------------------------------------------------------------------------
2222:     PROCEDURE FecharDialogo()
2223:         THIS.MontarRetorno()
2224: 
2225:         *-- Marca o dialogo como encerrado ANTES do Hide(): esconder a
2226:         *-- janela faz o campo com foco disparar LostFocus, e a validacao do
2227:         *-- usuario nao pode rodar de novo depois de a resposta ter sido
2228:         *-- publicada em this_cRetorno/this_lZSen.
2229:         THIS.this_lDialogoEncerrado = .T.
2230: 
2231:         THIS.Hide()
2232: 
2233:         RETURN
2234:     ENDPROC
2235: 
2236:     *--------------------------------------------------------------------------
2237:     * TornarControlesVisiveis - Torna visiveis os controles criados por
2238:     * AddObject, que nascem com Visible = .F.
2239:     *
2240:     * O SCX legado declara Visible = .T. explicito em Say3 e senha, e nao
2241:     * declara Visible = .F. em objeto nenhum - nao ha, portanto, controle que
2242:     * deva nascer oculto nesta tela, e nao existe lista de excecao. Os dois
2243:     * campos de senha SAO escondidos em runtime (o Valid do usuario faz
2244:     * thisform.say3.visible=.f. quando o usuario nao tem senha cadastrada), mas
2245:     * isso acontece DEPOIS da abertura, dentro do fluxo de conferencia.
2246:     *
2247:     * NAO recursa dentro de Grid: os "controles" de um Grid sao as Columns, e a
2248:     * visibilidade delas eh gerenciada pelo proprio VFP a partir do
2249:     * ColumnCount - mexer nisso de fora so cria divergencia com o bind.
2250:     *--------------------------------------------------------------------------
2251:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2252:         LOCAL loc_nI, loc_oControle
2253: 
2254:         IF VARTYPE(par_oContainer) != "O"
2255:             RETURN
2256:         ENDIF
2257: 
2258:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
2259:             RETURN
2260:         ENDIF
2261: 
2262:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2263:             loc_oControle = par_oContainer.Controls(loc_nI)
2264: 
2265:             IF VARTYPE(loc_oControle) = "O"
2266:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
2267:                     loc_oControle.Visible = .T.
2268:                 ENDIF
2269: 
2270:                 IF UPPER(ALLTRIM(loc_oControle.BaseClass)) != "GRID" ;
2271:                         AND PEMSTATUS(loc_oControle, "ControlCount", 5) ;
2272:                         AND loc_oControle.ControlCount > 0
2273:                     THIS.TornarControlesVisiveis(loc_oControle)
2274:                 ENDIF
2275:             ENDIF
2276:         ENDFOR
2277: 
2278:         RETURN
2279:     ENDPROC
2280: 
2281:     *--------------------------------------------------------------------------
2282:     * Destroy - Fecha os cursores de trabalho e libera o BO.
2283:     *
2284:     * Legado: ThisForm.poDataMgr.Release + =DoDefault()
2285:     *
2286:     * Os cursores sao os declarados pelo BO (usuarios autorizados, releitura
2287:     * da senha do usuario, os dois de parametro, senha livre, empresa e forma
2288:     * de pagamento). O cursor do MOVIMENTO
2289:     * (TprMvCab) NAO eh fechado aqui: ele pertence ao form CHAMADOR, que abriu
2290:     * esta tela, e fecha-lo deixaria o chamador sem os dados dele depois da
2291:     * autorizacao.
2292:     *
2293:     * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
2294:     * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
2295:     * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
2296:     * existe para o caso em que o buffer de fato tenha algo a descartar).
2297:     *
2298:     * O retorno eh montado antes de soltar o BO - eh a ultima chance de
2299:     * publicar a resposta, caso a tela seja destruida sem passar por
2300:     * FecharDialogo.
2301:     *
2302:     * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
2303:     * restaura os popups do menu principal depois de um form modal.
2304:     *--------------------------------------------------------------------------
2305:     PROCEDURE Destroy()
2306:         LOCAL loc_nI, loc_cCursor
2307:         LOCAL ARRAY loc_aCursores[7]
2308: 
2309:         THIS.MontarRetorno()
2310: 
2311:         loc_aCursores[1] = "cursor_4c_Usuarios"
2312:         loc_aCursores[2] = "cursor_4c_Param"
2313:         loc_aCursores[3] = "cursor_4c_Parac"
2314:         loc_aCursores[4] = "cursor_4c_SenhaLivre"
2315:         loc_aCursores[5] = "cursor_4c_Empresa"
2316:         loc_aCursores[6] = "cursor_4c_Fpagto"
2317:         loc_aCursores[7] = "cursor_4c_SenhaUsuario"
2318: 
2319:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
2320:             loc_cCursor = loc_aCursores[loc_nI]
2321: 
2322:             IF USED(loc_cCursor)
2323:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
2324:                     TABLEREVERT(.T., loc_cCursor)
2325:                 ENDIF
2326:                 USE IN (loc_cCursor)
2327:             ENDIF
2328:         ENDFOR
2329: 
2330:         DODEFAULT()
2331:     ENDPROC
2332: 
2333: ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [METODO-INEXISTENTE] Metodo 'THIS.ConectarTerminalSiTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.TerminalDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarAcessoSenha()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarAcessoSenhaSupervisor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PreencherBuffer()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ComecaCom()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproer.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1246 linhas total):

*-- Linhas 12 a 112:
12: *   pcData, pcValor, pcHora, pcCodEstabs - usados pela integracao com o
13: *   terminal SiTef, implementada nas proximas fases (eventos/hardware).
14: *
15: * FASE 3/8: Estrutura base - DEFINE CLASS, propriedades, Init/InicializarForm
16: *   e o header (faixa cinza com titulo).
17: * FASE 4/8: obj_4c_SAIDA (CommandGroup "Cancelar", mapeado do legado SAIDA/
18: *   CANCELA). Este form NAO tem lista/grid (dialogo modal de captura -
19: *   SIGPROER.Pagina nao existe no legado), entao nao ha Grid+botoes CRUD a
20: *   acrescentar aqui; o unico botao de acao do form (SAIDA) e' o que a fase
21: *   de "botoes" tem para entregar.
22: * FASE 5/8: Primeira metade dos campos de captura (shp_4c_Shape1,
23: *   txt_4c_Senha, lbl_4c_Label3).
24: * FASE 6/8: Campos restantes (txt_4c_SenhaSupervisor, cnt_4c_Container1,
25: *   lbl_4c_Label1) + os eventos DOS CAMPOS, ligados por BINDEVENT.
26: *
27: *   LOOKUPS: este form NAO tem nenhum. O dump do legado nao casa
28: *   fwBuscaExt/fwBuscaSel/fwBuscaInt, mAddColuna, sigacess() nem Acesso*()
29: *   - e' um dialogo de captura via hardware (PIN-pad SiTef), nao um
30: *   cadastro, e nao existe tabela auxiliar a consultar. Inventar um lookup
31: *   violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup".
32: *
33: *   O que esta fase entrega no lugar dos lookups sao os eventos dos dois
34: *   TextBox, que e' o que faz o campo FUNCIONAR:
35: *     GetSenha.When/GotFocus/LostFocus -> ValidarAcessoSenha /
36: *         SenhaGotFocus / ValidarSenha
37: *     SENHA.When/GotFocus/LostFocus    -> ValidarAcessoSenhaSupervisor /
38: *         SenhaSupervisorGotFocus / ValidarSenhaSupervisor
39: *   mais os dois geradores de arquivo de resposta que esses handlers
40: *   chamam (MontarRetorno <- montaretorno, RetornoFalha <- retornofalha) e
41: *   o protocolo da DLL, que foi para o BO (DeclararFuncoesSiTef /
42: *   ReiniciarProtocoloSiTef / ContinuarSiTef) seguindo a arquitetura ja
43: *   usada em sigprdftBO - PILAR 3.
44: *
45: *   Correcao de defeito herdado das fases 5/6 anteriores: o campo SENHA
46: *   tinha sido criado como "txt_4c_SENHA", que COLIDE com "txt_4c_Senha"
47: *   (nomes de membro do VFP9 sao case-insensitive). O AddObject estourava
48: *   "A member object with this name already exists.", o erro caia no TRY
49: *   do InicializarForm e CREATEOBJECT devolvia .F.: a tela NAO ABRIA.
50: *   Renomeado para txt_4c_SenhaSupervisor.
51: *
52: * FASE 7/8: os dois itens que faltavam.
53: *   1) BtnCancelarClick - migrado de SIGPROER.SAIDA.CANCELA.Click
54: *      (ThisForm.RetornoFalha + RELEASE WINDOWS, mesma leitura de
55: *      "RELEASE WINDOWS" = THIS.Release() ja usada nas fases 5/6).
56: *      Ligado por BINDEVENT ao obj_4c_SAIDA.Buttons(1), "Click" - nome
57: *      canonico do projeto para handler de botao (Btn*Click), nao o
58: *      nome do objeto legado (regra: nomear pela ACAO).
59: *   2) ConectarTerminalSiTef - migrado do bloco de hardware de
60: *      SIGPROER.Init (ConfiguraIntSiTefInterativo + IniciaFuncaoSiTef
61: *      Interativo), que no legado roda ANTES do dialogo aparecer. Os
62: *      dois DECLARE/CALL foram para o BO (ConectarSiTef/IniciarSiTef/
63: *      MontarIdTerminal), seguindo a mesma divisao Form/BO ja usada
64: *      nos eventos de campo (PILAR 3). TerminalDisponivel() cobre o
65: *      mesmo gate das fases 5/6: sem DLL (maquina sem PIN-pad) ou em
66: *      modo de teste/validacao de UI, o bloco inteiro eh pulado - regra
67: *      #6 (nada de hardware no pipeline sem supervisao).
68: *
69: *      "RELEASE WINDOWS" apos falha (regra #17 - fluxo do legado
70: *      transcrito literal) virou loc_lSucesso = .F.: o legado NAO
71: *      verifica .f. de Init em lugar nenhum, mas o padrao do projeto
72: *      (InicializarForm retorna .F. -> CREATEOBJECT devolve .F. -> o
73: *      chamador nunca mostra a tela) reproduz a MESMA intencao do
74: *      legado (dialogo sem terminal nunca aparece) sem chamar
75: *      THIS.Release() de dentro do proprio Init - Release() no meio da
76: *      construcao do objeto quebraria a cadeia DODEFAULT() que ainda
77: *      esta em andamento.
78: *
79: *      lcEmp = fConverteStr(CrSigCdEmp.nEmps), a primeira linha do
80: *      bloco de hardware no legado, e' calculada e NUNCA usada depois
81: *      (nem em lsIdTerminal, nem em lcIdTerminal) - dead code do
82: *      legado, nao portado (nenhum efeito observavel se perde).
83: *
84: *      O legado chama IniciaFuncaoSiTefInterativo mesmo quando
85: *      ConfiguraIntSiTefInterativo ja falhou (sem ELSE entre os dois
86: *      IFs) - mas como os dois caminhos de falha gravam a MESMA
87: *      mensagem ("Sem comunicacao com SiTef") no MESMO arquivo SDF via
88: *      RetornoFalha, chamar o segundo depois do primeiro ja ter
89: *      falhado so repetiria a gravacao com conteudo identico. ELSE
90: *      usado aqui pula a repeticao redundante sem mudar o resultado
91: *      observavel.
92: *
93: *   Unload: o legado so tem "*CLEAR DLLS ..." TODO comentado (* no
94: *   inicio de cada linha) - nenhum codigo real para portar. O Destroy
95: *   ja existente (fecha crSiTef) cobre o que o legado de fato faz.
96: *
97: * FASE 8/8: eventos auxiliares e consolidacao final.
98: *
99: *   1) FormParaBO / BOParaForm - os dois hooks canonicos de
100: *      transferencia. NAO sao convencao vazia de CRUD importada para um
101: *      form OPERACIONAL: os dois blocos JA EXISTEM no SCX legado, so sem
102: *      esse nome, e cada um estava DUPLICADO no migrado -
103: *      "Buffer = ALLTRIM(This.Value) + padding / lnContinua = 1000" nos
104: *      dois LostFocus, e o ELSE "mensagem = Buffer / Buffer = Replicate(
105: *      Chr(0),2000) / lnContinua = 0" nos TRES lacos de protocolo.
106: *      Concentrados nos hooks, com os 5 sites passando a chama-los: ponto
107: *      unico de recarga, sem copia para divergir.
108: *
109: *   2) Init - a assinatura estava com SETE parametros e o legado tem
110: *      OITO:
111: *        Parameters EndSitef, pcCaixa, pcNSU, pcData, pcValor, pcdata,
112: *                   pcHora, pcCodEstabs

*-- Linhas 203 a 333:
203:     *==================================================================
204:     * Init - Armazena os parametros do SiTef antes de DODEFAULT()
205:     *==================================================================
206:     PROCEDURE Init(par_cEndSitef, par_cCaixa, par_cNSU, par_cData, par_cValor, ;
207:                    par_cDataTrans, par_cHora, par_cCodEstabs)
208:         LOCAL loc_lResultado
209:         loc_lResultado = .F.
210: 
211:         THIS.this_cEndSitef  = IIF(VARTYPE(par_cEndSitef) = "C", par_cEndSitef, "")
212:         THIS.this_cCaixa     = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
213:         THIS.this_cNSU       = IIF(VARTYPE(par_cNSU) = "C", par_cNSU, "")
214:         THIS.this_cDataSitef = IIF(VARTYPE(par_cData) = "C", par_cData, "")
215:         THIS.this_cValor     = IIF(VARTYPE(par_cValor) = "C", par_cValor, "")
216: 
217:         *-- 6o argumento: a lista do legado eh
218:         *--   Parameters EndSitef, pcCaixa, pcNSU, pcData, pcValor, pcdata, pcHora, pcCodEstabs
219:         *-- e repete 'pcData' (os nomes do VFP9 sao case-insensitive), entao o
220:         *-- 6o argumento SOBRESCREVE o 4o - lsData = pcData acaba valendo
221:         *-- Transacao.cndttrans, nao o lcData montado pelo chamador.
222:         *-- Transcrito como esta (regra #17): o que vai ao terminal eh contrato
223:         *-- com o SiTef, nao se "corrige" na migracao.
224:         *-- Guardado por PCOUNT() para nao zerar o 4o numa chamada mais curta,
225:         *-- em que o legado tambem nao atribuiria nada a pcData pela 2a vez.
226:         IF PCOUNT() >= 6
227:             THIS.this_cDataSitef = IIF(VARTYPE(par_cDataTrans) = "C", par_cDataTrans, "")
228:         ENDIF
229: 
230:         THIS.this_cHora      = IIF(VARTYPE(par_cHora) = "C", par_cHora, "")
231:         THIS.this_cCodEstabs = IIF(VARTYPE(par_cCodEstabs) = "C", par_cCodEstabs, "")
232: 
233:         loc_lResultado = DODEFAULT()
234:         RETURN loc_lResultado
235:     ENDPROC
236: 
237:     *==================================================================
238:     * InicializarForm - Cria o Business Object e monta o header do dialogo
239:     *==================================================================
240:     PROTECTED PROCEDURE InicializarForm()
241:         LOCAL loc_lSucesso, loc_oErro
242:         loc_lSucesso = .F.
243: 
244:         TRY
245:             THIS.this_oBusinessObject = CREATEOBJECT("sigproerBO")
246: 
247:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
248:                 MsgErro("Erro ao criar sigproerBO. VARTYPE retornou: " + ;
249:                     VARTYPE(THIS.this_oBusinessObject), "Formsigproer.InicializarForm")
250:             ELSE
251:                 THIS.ConfigurarCabecalho()
252:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
253:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
254: 
255:                 *-- obj_4c_SAIDA (botao Cancelar) tem de vir DEPOIS do
256:                 *-- cabecalho: Top=-1..84 sobrepoe a faixa (Top=1..81) e
257:                 *-- precisa desenhar POR CIMA (regra do cabecalho - #11)
258:                 THIS.ConfigurarSaida()
259: 
260:                 *-- Campos de captura (completo - FASE 5/8 + FASE 6/8).
261:                 *-- Nao sobrepoe cabecalho/saida (Top >= 94), ordem indiferente.
262:                 THIS.ConfigurarCampos()
263: 
264:                 *-- Eventos de campo do legado (When/GotFocus/LostFocus dos
265:                 *-- dois TextBox) + Click do Cancelar - DEPOIS de
266:                 *-- ConfigurarCampos/ConfigurarSaida, senao o BINDEVENT nao
267:                 *-- tem objeto para ligar.
268:                 THIS.ConfigurarEventosCampos()
269: 
270:                 *-- Hardware SiTef (ConfiguraIntSiTefInterativo +
271:                 *-- IniciaFuncaoSiTefInterativo) - transcricao de
272:                 *-- SIGPROER.Init. Por ultimo: so faz sentido conectar o
273:                 *-- terminal depois que a tela inteira esta montada.
274:                 loc_lSucesso = THIS.ConectarTerminalSiTef()
275:             ENDIF
276:         CATCH TO loc_oErro
277:             MsgErro(loc_oErro.Message + CHR(13) + ;
278:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
279:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigproer.InicializarForm")
280:         ENDTRY
281: 
282:         RETURN loc_lSucesso
283:     ENDPROC
284: 
285:     *==================================================================
286:     * ConfigurarCabecalho - Container cinza escuro com titulo do dialogo
287:     * (cntSombra do legado, mapeado para cnt_4c_Sombra/lbl_4c_LblSombra/
288:     * lbl_4c_LblTitulo). PRIMEIRO AddObject da classe: o obj_4c_SAIDA
289:     * fica no canto superior direito sobre a faixa e precisa ser criado
290:     * DEPOIS (ver ConfigurarSaida) para desenhar por cima (regra do
291:     * cabecalho - CorretorAutomatico #195).
292:     *==================================================================
293:     PROTECTED PROCEDURE ConfigurarCabecalho()
294:         LOCAL loc_oCnt
295:         THIS.AddObject("cnt_4c_Sombra", "Container")
296:         loc_oCnt = THIS.cnt_4c_Sombra
297:         WITH loc_oCnt
298:             .Top         = 1
299:             .Left        = 0
300:             .Width       = THIS.Width
301:             .Height      = 80
302:             .BorderWidth = 0
303:             .BackColor   = RGB(100, 100, 100)
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
308:         WITH loc_oCnt.lbl_4c_LblSombra
309:             .FontBold      = .T.
310:             .FontName      = "Tahoma"
311:             .FontSize      = 18
312:             .FontUnderline = .F.
313:             .WordWrap      = .T.
314:             .Alignment     = 0
315:             .BackStyle     = 0
316:             .AutoSize      = .F.
317:             .Caption       = "Reimpress" + CHR(227) + "o do SiTef"
318:             .Height        = 40
319:             .Left          = 10
320:             .Top           = 18
321:             .Width         = THIS.Width - 20
322:             .ForeColor     = RGB(0, 0, 0)
323:             .Visible       = .T.
324:         ENDWITH
325: 
326:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
327:         WITH loc_oCnt.lbl_4c_LblTitulo
328:             .FontBold    = .T.
329:             .FontName    = "Tahoma"
330:             .FontSize    = 18
331:             .WordWrap    = .T.
332:             .Alignment   = 0
333:             .BackStyle   = 0

*-- Linhas 349 a 392:
349:     * form. O Click (ThisForm.RetornoFalha + Release Windows no legado)
350:     * entra nas proximas fases, junto com a logica de hardware do SiTef.
351:     *==================================================================
352:     PROTECTED PROCEDURE ConfigurarSaida()
353:         LOCAL loc_oGrp
354:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
355:         loc_oGrp = THIS.obj_4c_SAIDA
356:         WITH loc_oGrp
357:             .ButtonCount = 1
358:             WITH .Buttons(1)
359:                 .Top        = 5
360:                 .Left       = 5
361:                 .Width      = 75
362:                 .Height     = 75
363:                 .FontName   = "Comic Sans MS"
364:                 .FontBold   = .T.
365:                 .FontItalic = .T.
366:                 .FontSize   = 8
367:                 .Caption    = "\<Cancelar"
368:                 .Cancel     = .T.
369:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
370:                 .ForeColor  = RGB(90, 90, 90)
371:                 .BackColor  = RGB(255, 255, 255)
372:                 .Themes     = .F.
373:             ENDWITH
374:             .AutoSize    = .T.
375:             .BackStyle   = 0
376:             .BorderStyle = 0
377:             .Top         = -1
378:             .Left        = 320
379:             .Width       = 85
380:             .Height      = 85
381:             .Visible     = .T.
382:         ENDWITH
383:     ENDPROC
384: 
385:     *==================================================================
386:     * ConfigurarCampos - Campos de captura (FASE 5/8 + FASE 6/8)
387:     * Form OPERACIONAL sem PageFrame (dialogo flat) - os controles vao
388:     * direto em THIS. Mapeados do SCX legado (sigproer_form_codigo_
389:     * fonte.txt):
390:     *   shp_4c_Shape1 <- Shape1 (moldura em volta de GetSenha/SENHA)
391:     *   txt_4c_Senha  <- GetSenha (campo legado Enabled=.F. - fica
392:     *                    sempre desabilitado, nunca recebe foco; o SCX

*-- Linhas 402 a 445:
402:     *                    "Digite a Senha do Supervisor" - ver
403:     *                    AguardarTerminalExec, que ja faz essa troca)
404:     *==================================================================
405:     PROTECTED PROCEDURE ConfigurarCampos()
406:         LOCAL loc_oCnt
407: 
408:         THIS.AddObject("shp_4c_Shape1", "Shape")
409:         WITH THIS.shp_4c_Shape1
410:             .Top           = 94
411:             .Left          = 76
412:             .Width         = 247
413:             .Height        = 42
414:             .SpecialEffect = 0
415:             .Visible       = .T.
416:         ENDWITH
417: 
418:         THIS.AddObject("txt_4c_Senha", "TextBox")
419:         WITH THIS.txt_4c_Senha
420:             .Top       = 103
421:             .Left      = 214
422:             .Width     = 100
423:             .Height    = 23
424:             .FontName  = "Tahoma"
425:             .FontSize  = 8
426:             .InputMask = ""
427:             .ForeColor = RGB(90, 90, 90)
428:             .Value     = ""
429:             .Enabled   = .F.
430:             .Visible   = .T.
431:         ENDWITH
432: 
433:         THIS.AddObject("lbl_4c_Label3", "Label")
434:         WITH THIS.lbl_4c_Label3
435:             .AutoSize  = .T.
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .Alignment = 0
439:             .Caption   = "Senha do Supervisor :"
440:             .Height    = 15
441:             .Left      = 90
442:             .Top       = 108
443:             .Width     = 108
444:             .ForeColor = RGB(90, 90, 90)
445:             .Visible   = .T.

*-- Linhas 452 a 496:
452:         *-- membro do VFP9 sao CASE-INSENSITIVE, entao "txt_4c_SENHA" colide
453:         *-- com o "txt_4c_Senha" criado acima e o AddObject estoura
454:         *-- "A member object with this name already exists." (medido no
455:         *-- VFP9) - erro que cai no TRY do InicializarForm, faz
456:         *-- CREATEOBJECT devolver .F. e a tela NAO ABRIR (regras #33/#41).
457:         *-- O legado distingue GetSenha de SENHA so pela caixa das letras;
458:         *-- o PILAR 3 manda renomear de qualquer forma, e o rotulo da tela
459:         *-- ("Senha do Supervisor :") da o nome correto.
460:         THIS.AddObject("txt_4c_SenhaSupervisor", "TextBox")
461:         WITH THIS.txt_4c_SenhaSupervisor
462:             .Top          = 103
463:             .Left         = 214
464:             .Width        = 100
465:             .Height       = 23
466:             .FontBold     = .F.
467:             .FontName     = "Tahoma"
468:             .FontSize     = 8
469:             .BackStyle    = 1
470:             .Format       = ""
471:             .MaxLength    = 0
472:             .PasswordChar = "*"
473:             .ForeColor    = RGB(90, 90, 90)
474:             .BackColor    = RGB(255, 255, 255)
475:             .Value        = ""
476:             .Visible      = .T.
477:         ENDWITH
478: 
479:         THIS.AddObject("cnt_4c_Container1", "Container")
480:         loc_oCnt = THIS.cnt_4c_Container1
481:         WITH loc_oCnt
482:             .Top           = 141
483:             .Left          = 114
484:             .Width         = 171
485:             .Height        = 56
486:             .SpecialEffect = 0
487:             .Visible       = .T.
488:         ENDWITH
489: 
490:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
491:         WITH loc_oCnt.lbl_4c_Label1
492:             .AutoSize  = .F.
493:             .FontBold  = .T.
494:             .FontName  = "Tahoma"
495:             .FontSize  = 10
496:             .Alignment = 2

*-- Linhas 505 a 592:
505:     ENDPROC
506: 
507:     *==================================================================
508:     * ConfigurarEventosCampos - BINDEVENT dos eventos de campo do legado
509:     *
510:     * Mapeamento 1-para-1 com o SCX (sigproer_form_codigo_fonte.txt):
511:     *   GetSenha.When      -> ValidarAcessoSenha
512:     *   GetSenha.GotFocus  -> SenhaGotFocus
513:     *   GetSenha.LostFocus -> ValidarSenha
514:     *   SENHA.When         -> ValidarAcessoSenhaSupervisor
515:     *   SENHA.GotFocus     -> SenhaSupervisorGotFocus
516:     *   SENHA.LostFocus    -> ValidarSenhaSupervisor
517:     *
518:     * Ligados em "LostFocus", NAO em "KeyPress": aqui o legado tem
519:     * LostFocus de verdade nos dois campos (o Valid de GetSenha esta VAZIO
520:     * no SCX e SENHA nao tem Valid). Handler ligado a "KeyPress" sem testar
521:     * a tecla dispararia a cada caractere digitado (regra #47).
522:     *
523:     * O "When" do legado NAO pode ser ligado por BINDEVENT: o retorno do
524:     * delegate eh DESCARTADO, entao um When assim nao bloquearia a entrada
525:     * no campo. Os metodos ValidarAcesso* carregam a regra do legado e sao
526:     * CHAMADOS pelos proprios handlers de GotFocus, que abortam quando o
527:     * campo ja tem valor - mesmo efeito do "Return(EMPTY(This.Value))".
528:     *
529:     * Os delegados existem todos nesta classe: BINDEVENT com delegado
530:     * inexistente estoura no proprio BIND.
531:     *
532:     * obj_4c_SAIDA.Buttons(1).Click -> BtnCancelarClick (SIGPROER.SAIDA.
533:     * CANCELA.Click) entra aqui tambem - mesma regra de "BINDEVENT so
534:     * depois do AddObject do alvo".
535:     *==================================================================
536:     PROTECTED PROCEDURE ConfigurarEventosCampos()
537:         BINDEVENT(THIS.txt_4c_Senha, "GotFocus",  THIS, "SenhaGotFocus")
538:         BINDEVENT(THIS.txt_4c_Senha, "LostFocus", THIS, "ValidarSenha")
539: 
540:         BINDEVENT(THIS.txt_4c_SenhaSupervisor, "GotFocus",  THIS, "SenhaSupervisorGotFocus")
541:         BINDEVENT(THIS.txt_4c_SenhaSupervisor, "LostFocus", THIS, "ValidarSenhaSupervisor")
542: 
543:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
544:     ENDPROC
545: 
546:     *==================================================================
547:     * BtnCancelarClick - handler de SIGPROER.SAIDA.CANCELA.Click:
548:     *     ThisForm.RetornoFalha("Operacao Cancelada pelo Usuario")
549:     *     RELEASE WINDOWS
550:     * PUBLIC: ligado por BINDEVENT.
551:     *==================================================================
552:     PROCEDURE BtnCancelarClick()
553:         THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
554:         THIS.Release()
555:     ENDPROC
556: 
557:     *==================================================================
558:     * ConectarTerminalSiTef - transcricao do bloco de hardware de
559:     * SIGPROER.Init:
560:     *   lcEmp=fConverteStr(CrSigCdEmp.nEmps)                    -- dead code, nao usado depois (ver header)
561:     *   lsIdTerminal = Iif(Empty(pcCodEstabs), "00000"+_Empr, pcCodEstabs)
562:     *   lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + Transform(Val(crSigFiMpF.Cncaixas), "@L 999999")
563:     *   IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
564:     *       RetornoFalha("Sem comunicacao com SiTef") / RELEASE WINDOWS
565:     *   ENDIF
566:     *   lcValores = IIF(!EMPTY(pcValor), StrTran(...,".", ","), "")
567:     *   IF IniciaFuncaoSiTefInterativo(Iif(Empty(pcData),114,113), lcValores, "1","","","","") <> 10000
568:     *       RetornoFalha("Sem comunicacao com SiTef") / RELEASE WINDOWS
569:     *   ENDIF
570:     *
571:     * _Empr (legado) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md - NUNCA _EMPR).
572:     * CrSigCdEmp (AddCursor+Requery do legado) -> this_oBusinessObject.
573:     * CarregarEmpresaAtual() (FASE 2/8), ja populando this_nNumero (nEmps).
574:     *
575:     * Sem terminal disponivel (maquina sem CliSiTef32I.DLL ou pipeline
576:     * em modo de teste/validacao de UI - regra #6), o bloco INTEIRO eh
577:     * pulado e o metodo devolve .T.: a tela abre normalmente, so nao
578:     * conversa com hardware que nao existe nesta maquina.
579:     *==================================================================
580:     PROTECTED FUNCTION ConectarTerminalSiTef()
581:         LOCAL loc_oBO, loc_cIdLoja, loc_cIdTerminal, loc_cValores, loc_lSucesso
582: 
583:         loc_lSucesso = .T.
584: 
585:         IF !THIS.TerminalDisponivel()
586:             RETURN loc_lSucesso
587:         ENDIF
588: 
589:         loc_oBO = THIS.this_oBusinessObject
590:         loc_oBO.CarregarEmpresaAtual()
591: 
592:         loc_cIdLoja = IIF(EMPTY(THIS.this_cCodEstabs), ;

*-- Linhas 635 a 721:
635:     * O corpo mora em AguardarTerminalExec: o wrapper existe para a flag
636:     * de reentrancia ser liberada mesmo quando o corpo sai por RETURN
637:     * antecipado (regra #47 - set/clear no topo do corpo travaria a flag).
638:     * PUBLIC: ligado por BINDEVENT.
639:     *==================================================================
640:     PROCEDURE SenhaGotFocus()
641:         IF THIS.this_lEmProcessamento
642:             RETURN
643:         ENDIF
644:         IF !THIS.ValidarAcessoSenha()
645:             RETURN
646:         ENDIF
647: 
648:         THIS.this_lEmProcessamento = .T.
649:         THIS.AguardarTerminalExec(.F.)
650:         THIS.this_lEmProcessamento = .F.
651:     ENDPROC
652: 
653:     *==================================================================
654:     * SenhaSupervisorGotFocus - handler de SIGPROER.SENHA.GotFocus.
655:     * PUBLIC: ligado por BINDEVENT.
656:     *==================================================================
657:     PROCEDURE SenhaSupervisorGotFocus()
658:         IF THIS.this_lEmProcessamento
659:             RETURN
660:         ENDIF
661:         IF !THIS.ValidarAcessoSenhaSupervisor()
662:             RETURN
663:         ENDIF
664: 
665:         THIS.this_lEmProcessamento = .T.
666:         THIS.AguardarTerminalExec(.T.)
667:         THIS.this_lEmProcessamento = .F.
668:     ENDPROC
669: 
670:     *==================================================================
671:     * AguardarTerminalExec - corpo COMUM de GetSenha.GotFocus e
672:     * SENHA.GotFocus. Os dois eventos do legado tem o MESMO laco de
673:     * protocolo, caractere por caractere; a UNICA diferenca eh a primeira
674:     * linha de SENHA.GotFocus, que troca o texto da moldura.
675:     * par_lSenhaSupervisor = .T. -> comportamento de SENHA.GotFocus.
676:     *
677:     * Laco transcrito literalmente (regra #17 - formula/fluxo do legado
678:     * nao se reescreve), inclusive o envio em DUAS etapas do NSU e da data
679:     * quando ProximoComando = 30 (lnTipo 1 -> 2 -> 3).
680:     *==================================================================
681:     PROTECTED PROCEDURE AguardarTerminalExec(par_lSenhaSupervisor)
682:         LOCAL loc_oBO, loc_nRetorno, loc_oErro
683: 
684:         *-- SENHA.GotFocus:
685:         *--   ThisForm.Container1.Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
686:         IF par_lSenhaSupervisor
687:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = ;
688:                 "Digite a Senha" + CHR(13) + "do Supervisor"
689:         ENDIF
690: 
691:         *-- Sem o CliSiTef32I.DLL (maquina sem PIN-pad) o protocolo nao
692:         *-- roda. O legado trata terminal que nao responde com
693:         *-- RetornoFalha("Sem comunicacao com SiTef") - mesma mensagem que
694:         *-- o Init dele usa - entao o caminho de erro eh o do legado, nao
695:         *-- um dialogo novo.
696:         IF !THIS.TerminalDisponivel()
697:             THIS.RetornoFalha("Sem comunicacao com SiTef")
698:             RETURN
699:         ENDIF
700: 
701:         loc_oBO = THIS.this_oBusinessObject
702: 
703:         *-- ProximoComando=0 / TipoCampo=0 / TamanhoMinimo=0 /
704:         *-- TamanhoMaximo=0 / Buffer=Replicate(Chr(0),2000) / lnContinua=0
705:         loc_oBO.ReiniciarProtocoloSiTef()
706:         THIS.this_cMensagem  = ""     && Mensagem = ""
707:         THIS.this_nTipoEnvio = 1      && lnTipo = 1
708: 
709:         loc_nRetorno = 0
710: 
711:         TRY
712:             DO WHILE loc_oBO.this_nTipoCampo <> 500
713:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
714: 
715:                 IF loc_nRetorno < 0
716:                     THIS.RetornoFalha(THIS.this_cMensagem)
717:                     EXIT
718:                 ENDIF
719: 
720:                 IF loc_oBO.this_nProximoComando = 30 AND !EMPTY(THIS.this_cNSU)
721:                     IF THIS.this_nTipoEnvio = 1

*-- Linhas 742 a 822:
742:         CATCH TO loc_oErro
743:             MsgErro(loc_oErro.Message + CHR(13) + ;
744:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
745:                 "Procedure: " + loc_oErro.Procedure, ;
746:                 "Erro no protocolo SiTef")
747:         ENDTRY
748: 
749:         *-- IF lnRetorno < 0 / RELEASE WINDOWS / ENDIF
750:         IF loc_nRetorno < 0
751:             THIS.Release()
752:         ENDIF
753: 
754:         WAIT CLEAR
755:     ENDPROC
756: 
757:     *==================================================================
758:     * ValidarSenha - handler de SIGPROER.GetSenha.LostFocus.
759:     * PUBLIC: ligado por BINDEVENT. Corpo em ValidarSenhaExec pelo mesmo
760:     * motivo do SenhaGotFocus (flag de reentrancia x RETURN antecipado).
761:     *
762:     * Nota de fidelidade: GetSenha nasce com Enabled = .F. no SCX e nada
763:     * no legado o habilita, entao na pratica este caminho nao dispara -
764:     * quem captura a senha eh SENHA, por cima dele. O handler eh migrado
765:     * porque o codigo existe no SCX e o campo eh o mesmo que a tela mostra.
766:     *==================================================================
767:     PROCEDURE ValidarSenha()
768:         IF THIS.this_lEmProcessamento
769:             RETURN
770:         ENDIF
771: 
772:         THIS.this_lEmProcessamento = .T.
773:         THIS.ValidarSenhaExec()
774:         THIS.this_lEmProcessamento = .F.
775:     ENDPROC
776: 
777:     *==================================================================
778:     * ValidarSenhaExec - corpo de GetSenha.LostFocus, transcrito literal.
779:     * Envia o valor digitado ao terminal e vai acumulando o cupom dos
780:     * TipoCampo 121/122 ate o protocolo encerrar.
781:     *==================================================================
782:     PROTECTED PROCEDURE ValidarSenhaExec()
783:         LOCAL loc_oBO, loc_nRetorno, loc_oErro
784: 
785:         *-- IF EMPTY(This.Value) / RETURN / ENDIF
786:         IF EMPTY(THIS.txt_4c_Senha.Value)
787:             RETURN
788:         ENDIF
789: 
790:         IF !THIS.TerminalDisponivel()
791:             THIS.RetornoFalha("Sem comunicacao com SiTef")
792:             RETURN
793:         ENDIF
794: 
795:         loc_oBO = THIS.this_oBusinessObject
796: 
797:         THIS.this_cCupom    = ""      && lsCupom = ""
798:         THIS.this_cMensagem = ""      && Mensagem = ""
799: 
800:         *-- Buffer=ALLTRIM(This.Value) + padding / lnContinua=1000
801:         THIS.FormParaBO(THIS.txt_4c_Senha)
802:         loc_nRetorno           = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
803:         loc_oBO.this_nContinua = 0
804: 
805:         TRY
806:             DO WHILE loc_nRetorno = 10000
807:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
808: 
809:                 IF loc_nRetorno < 0
810:                     THIS.RetornoFalha(THIS.this_cMensagem)
811:                     EXIT
812:                 ENDIF
813: 
814:                 IF THIS.ComecaCom(UPPER(ALLTRIM(loc_oBO.this_cBuffer)), "DOC INEXISTENTE")
815:                     THIS.RetornoFalha("DOC INEXISTENTE")
816:                     EXIT
817:                 ENDIF
818: 
819:                 *-- lsCupom = Buffer + Buffer: o legado concatena o buffer
820:                 *-- DUAS vezes na primeira via (TipoCampo 121). Transcrito
821:                 *-- como esta - regra #17: o conteudo do cupom eh regra de
822:                 *-- negocio, nao se "corrige" na migracao.

*-- Linhas 840 a 920:
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message + CHR(13) + ;
842:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
843:                 "Procedure: " + loc_oErro.Procedure, ;
844:                 "Erro no protocolo SiTef")
845:         ENDTRY
846: 
847:         IF loc_nRetorno = 0
848:             THIS.MontarRetorno(THIS.this_cCupom)
849:         ENDIF
850: 
851:         THIS.Release()
852:         WAIT CLEAR
853:     ENDPROC
854: 
855:     *==================================================================
856:     * ValidarSenhaSupervisor - handler de SIGPROER.SENHA.LostFocus.
857:     * Este eh o caminho REAL da tela: SENHA eh o campo habilitado.
858:     * PUBLIC: ligado por BINDEVENT.
859:     *==================================================================
860:     PROCEDURE ValidarSenhaSupervisor()
861:         IF THIS.this_lEmProcessamento
862:             RETURN
863:         ENDIF
864: 
865:         THIS.this_lEmProcessamento = .T.
866:         THIS.ValidarSenhaSupervisorExec()
867:         THIS.this_lEmProcessamento = .F.
868:     ENDPROC
869: 
870:     *==================================================================
871:     * ValidarSenhaSupervisorExec - corpo de SENHA.LostFocus, transcrito
872:     * literal. Difere de GetSenha.LostFocus em tres pontos, TODOS do
873:     * legado e nenhum opcional:
874:     *   1) ProximoComando=30 + TipoCampo=515 -> devolve a DATA ao terminal
875:     *   2) ProximoComando=30 + TipoCampo=516 -> devolve o NSU, com mascara
876:     *      de 6 digitos quando ha valor na transacao e de 9 quando nao ha
877:     *   3) llVias: ao ler "VIA A SER REIMPRESSA" o legado responde "3" na
878:     *      iteracao SEGUINTE (escolha da via), e so uma vez
879:     *==================================================================
880:     PROTECTED PROCEDURE ValidarSenhaSupervisorExec()
881:         LOCAL loc_oBO, loc_nRetorno, loc_lVias, loc_oErro
882: 
883:         *-- IF EMPTY(This.Value) / RETURN / ENDIF
884:         IF EMPTY(THIS.txt_4c_SenhaSupervisor.Value)
885:             RETURN
886:         ENDIF
887: 
888:         IF !THIS.TerminalDisponivel()
889:             THIS.RetornoFalha("Sem comunicacao com SiTef")
890:             RETURN
891:         ENDIF
892: 
893:         loc_oBO = THIS.this_oBusinessObject
894: 
895:         THIS.this_cCupom    = ""      && lsCupom = ""
896:         THIS.this_cMensagem = ""      && Mensagem = ""
897: 
898:         *-- Buffer=ALLTRIM(This.Value) + padding / lnContinua=1000
899:         THIS.FormParaBO(THIS.txt_4c_SenhaSupervisor)
900:         loc_nRetorno           = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
901:         loc_oBO.this_nContinua = 0
902:         loc_lVias              = .F.  && llVias = .f.
903: 
904:         TRY
905:             DO WHILE loc_nRetorno = 10000
906:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
907: 
908:                 IF loc_nRetorno < 0
909:                     THIS.RetornoFalha(THIS.this_cMensagem)
910:                     EXIT
911:                 ENDIF
912: 
913:                 IF THIS.ComecaCom(UPPER(ALLTRIM(loc_oBO.this_cBuffer)), "DOC INEXISTENTE")
914:                     THIS.RetornoFalha("DOC INEXISTENTE")
915:                     EXIT
916:                 ENDIF
917: 
918:                 *-- O legado NAO mexe em lnContinua nestes dois ramos:
919:                 *-- preenche o Buffer e volta ao topo do laco.
920:                 IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 515

*-- Linhas 965 a 1008:
965:         CATCH TO loc_oErro
966:             MsgErro(loc_oErro.Message + CHR(13) + ;
967:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
968:                 "Procedure: " + loc_oErro.Procedure, ;
969:                 "Erro no protocolo SiTef")
970:         ENDTRY
971: 
972:         IF loc_nRetorno = 0
973:             THIS.MontarRetorno(THIS.this_cCupom)
974:         ENDIF
975: 
976:         THIS.Release()
977:         WAIT CLEAR
978:     ENDPROC
979: 
980:     *==================================================================
981:     * FormParaBO - hook canonico de transferencia Form -> BO.
982:     *
983:     * Nao eh convencao vazia de CRUD aqui: o bloco JA EXISTE no legado, so
984:     * sem esse nome. Nos DOIS LostFocus do SCX ele aparece identico:
985:     *     Buffer = ALLTRIM(This.Value)
986:     *     Buffer = Buffer + Replicate(Chr(0), 2000 - Len(Buffer))
987:     *     lnContinua = 1000
988:     * ou seja: o que o usuario digitou no campo vai para o buffer do
989:     * protocolo (hoje property do BO - PILAR 3) e arma o envio ao terminal.
990:     * Concentrar os dois sites aqui da' ponto unico de recarga e evita que
991:     * as duas copias divirjam.
992:     *
993:     * par_oCampo eh o TextBox de origem. Omitido, usa txt_4c_SenhaSupervisor
994:     * - o unico campo HABILITADO da tela (txt_4c_Senha nasce Enabled = .F.
995:     * no SCX legado), entao a chamada sem argumento nunca fica ambigua.
996:     *
997:     * Devolve .F. quando nao ha nada a enviar, reproduzindo o
998:     * "IF EMPTY(This.Value) / RETURN" com que os dois LostFocus comecam.
999:     * PROTECTED OBRIGATORIO: FormBase ja declara os dois hooks como
1000:     * PROTECTED e o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o
1001:     * modificador nao os tornaria publicos, so esconderia que continuam
1002:     * protegidos (PEMSTATUS com 3o argumento 5 responde "existe?", nao "da
1003:     * para chamar daqui?"). Chamados sempre por THIS., regra #8.
1004:     *==================================================================
1005:     PROTECTED FUNCTION FormParaBO(par_oCampo)
1006:         LOCAL loc_oCampo, loc_cValor, loc_lSucesso
1007: 
1008:         loc_lSucesso = .F.

*-- Linhas 1044 a 1087:
1044:     * protegidos (PEMSTATUS com 3o argumento 5 responde "existe?", nao "da
1045:     * para chamar daqui?"). Chamados sempre por THIS., regra #8.
1046:     *==================================================================
1047:     PROTECTED PROCEDURE BOParaForm()
1048:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1049:             THIS.this_cMensagem = THIS.this_oBusinessObject.this_cBuffer
1050: 
1051:             THIS.this_oBusinessObject.this_cBuffer   = REPLICATE(CHR(0), 2000)
1052:             THIS.this_oBusinessObject.this_nContinua = 0
1053:         ENDIF
1054:     ENDPROC
1055: 
1056:     *==================================================================
1057:     * PreencherBuffer - reproduz o padding do legado:
1058:     *     Buffer = <valor> + Replicate(Chr(0), 2000 - Len(<valor>))
1059:     * O terminal espera sempre 2000 bytes. MAX(0, ...) evita REPLICATE
1060:     * com contagem negativa quando o valor passa de 2000 caracteres.
1061:     *==================================================================
1062:     PROTECTED FUNCTION PreencherBuffer(par_cValor)
1063:         LOCAL loc_cValor
1064:         loc_cValor = IIF(VARTYPE(par_cValor) = "C", par_cValor, "")
1065:         RETURN loc_cValor + REPLICATE(CHR(0), MAX(0, 2000 - LEN(loc_cValor)))
1066:     ENDFUNC
1067: 
1068:     *==================================================================
1069:     * ComecaCom - compara PREFIXO, reproduzindo o "=" do legado sob
1070:     * SET EXACT OFF.
1071:     *
1072:     * O Buffer chega do terminal com 2000 bytes completados por CHR(0).
1073:     * No legado, "Upper(Buffer) = 'VIA A SER REIMPRESSA'" casava porque o
1074:     * "=" com SET EXACT OFF para a comparacao no fim do operando DIREITO.
1075:     * O config.prg do sistema novo faz SET EXACT ON, onde o mesmo "="
1076:     * passaria a exigir tamanhos iguais e NUNCA casaria - a reimpressao de
1077:     * via e a deteccao de "DOC INEXISTENTE" morreriam em silencio.
1078:     * Comparar o prefixo com "==" eh o equivalente fiel e, de quebra,
1079:     * independe do estado de SET EXACT.
1080:     *==================================================================
1081:     PROTECTED FUNCTION ComecaCom(par_cTexto, par_cPrefixo)
1082:         RETURN (LEFT(par_cTexto, LEN(par_cPrefixo)) == par_cPrefixo)
1083:     ENDFUNC
1084: 
1085:     *==================================================================
1086:     * TerminalDisponivel - .T. quando o protocolo SiTef pode ser acionado.
1087:     * Falso em modo de teste/validacao de UI (o pipeline roda sem

*-- Linhas 1114 a 1157:
1114:     * Pasta ausente nesta maquina (dev/teste sem integracao fiscal) ->
1115:     * a gravacao eh pulada sem quebrar o fluxo.
1116:     *==================================================================
1117:     PROCEDURE MontarRetorno(par_cCupom)
1118:         LOCAL loc_cCupom, loc_nPos, loc_nLinha, loc_oErro
1119: 
1120:         loc_cCupom = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
1121: 
1122:         IF !DIRECTORY("C:\client\Resp", 1)
1123:             RETURN
1124:         ENDIF
1125: 
1126:         TRY
1127:             IF USED("crSiTef")
1128:                 USE IN crSiTef
1129:             ENDIF
1130:             CREATE CURSOR crSiTef (tef c(100))
1131: 
1132:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1133:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1134:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1135:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
1136:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1137:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1138:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
1139:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
1140:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + THIS.this_cNSU)
1141:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
1142:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
1143:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1144:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1145:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1146:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1147:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1148:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1149:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
1150:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1151:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1152:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
1153: 
1154:             *-- Quebra o cupom em linhas "029-NNN", uma por CHR(10)
1155:             loc_nPos   = 1
1156:             loc_nLinha = 1
1157:             DO WHILE loc_nPos <> 0

*-- Linhas 1190 a 1246:
1190:     * ("009-000 = FF" / "010-000 = 05") e a mensagem do erro.
1191:     * Pasta ausente -> gravacao pulada, sem quebrar o cancelamento.
1192:     *==================================================================
1193:     PROCEDURE RetornoFalha(par_cMensagem)
1194:         LOCAL loc_cMensagem, loc_oErro
1195: 
1196:         loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
1197: 
1198:         IF !DIRECTORY("C:\client\Resp", 1)
1199:             RETURN
1200:         ENDIF
1201: 
1202:         TRY
1203:             IF USED("crSiTef")
1204:                 USE IN crSiTef
1205:             ENDIF
1206:             CREATE CURSOR crSiTef (tef c(100))
1207: 
1208:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1209:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1210:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1211:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
1212:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1213:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1214:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1215:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1216:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1217:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1218:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1219: 
1220:             SELECT crSiTef
1221:             COPY TO C:\client\Resp\IntPos.001 SDF
1222:             ZAP
1223: 
1224:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1225:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1226:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1227: 
1228:             COPY TO C:\client\Resp\IntPos.STS SDF
1229: 
1230:             USE IN crSiTef
1231:         CATCH TO loc_oErro
1232:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
1233:         ENDTRY
1234:     ENDPROC
1235: 
1236:     *==================================================================
1237:     * Destroy
1238:     *==================================================================
1239:     PROCEDURE Destroy()
1240:         IF USED("crSiTef")
1241:             USE IN crSiTef
1242:         ENDIF
1243:         DODEFAULT()
1244:     ENDPROC
1245: 
1246: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigproerBO.prg):
*====================================================================
* sigproerBO.prg
*
* Business Object para Formsigproer (Reimpressao do SiTef)
* Tabela: SigCdEmp (dados da empresa usados para montar o terminal SiTef)
* Herda de: BusinessBase
*
* FASE 1/8: Propriedades e Init()
* FASE 2/8: CRUD (CarregarDoCursor/CarregarPorCodigo/CarregarEmpresaAtual)
*   e protocolo SiTef (DeclararFuncoesSiTef/ReiniciarProtocoloSiTef/
*   ContinuarSiTef)
* FASE 7/8: ConectarSiTef/IniciarSiTef/MontarIdTerminal - transcricao do
*   bloco de hardware de SIGPROER.Init (ConfiguraIntSiTefInterativo +
*   IniciaFuncaoSiTefInterativo), chamado pelo Form.InicializarForm.
*====================================================================

DEFINE CLASS sigproerBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdEmp)
    this_cCemps   = ""    && cemps char(3) - PK da empresa
    this_nNumero  = 0     && nemps numeric(3,0) - usado para montar o ID do terminal SiTef

    *-- Estado do protocolo interativo SiTef (CliSiTef32I.DLL).
    *-- Migrado das variaveis PUBLIC declaradas no SIGPROER.Init legado
    *-- (ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    *-- lnContinua). No sistema novo viram properties do BO - PILAR 3: o
    *-- migrado nao cria variavel global nova.
    this_nProximoComando  = 0     && ProximoComando
    this_nTipoCampo       = 0     && TipoCampo
    this_nTamanhoMinimo   = 0     && TamanhoMinimo
    this_nTamanhoMaximo   = 0     && TamanhoMaximo
    this_cBuffer          = ""    && Buffer - buffer de comunicacao com o terminal
    this_nContinua        = 0     && lnContinua
    this_lSiTefDeclarado  = .F.   && .T. quando o DECLARE-DLL do protocolo funcionou

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            THIS.DeclararFuncoesSiTef()
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigproerBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 3 funcoes do protocolo
    * interativo, transcrito de SIGPROER.Load (as MESMAS assinaturas, na
    * mesma ordem). Redeclarar a mesma assinatura eh inofensivo em VFP9.
    * O TRY existe para nao derrubar o Init em maquina de desenvolvimento
    * sem o CliSiTef32I.DLL instalado: nesse caso this_lSiTefDeclarado fica
    * .F. e o Form avisa pelo mesmo caminho que o legado usa quando o
    * terminal nao responde (RetornoFalha "Sem comunicacao com SiTef").
    *====================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            THIS.this_lSiTefDeclarado = .T.
        CATCH TO loc_oErro
            *-- DLL ausente nesta maquina (dev/teste sem PIN-pad SiTef).
            *-- Nao exibe dialogo aqui: o Init do BO roda dentro do
            *-- InicializarForm do Form e um modal travaria o pipeline
            *-- (CLAUDE.md regra #6). Quem avisa eh o Form, no momento em
            *-- que o usuario realmente aciona o terminal.
            THIS.this_lSiTefDeclarado = .F.
        ENDTRY
    ENDPROC

    *====================================================================
    * ReiniciarProtocoloSiTef - Zera o estado do protocolo. Transcrito do
    * bloco que abre GetSenha.GotFocus / SENHA.GotFocus no legado:
    *   ProximoComando=0 / TipoCampo=0 / TamanhoMinimo=0 /
    *   TamanhoMaximo=0 / Buffer=Replicate(Chr(0),2000) / lnContinua=0
    *====================================================================
    PROCEDURE ReiniciarProtocoloSiTef()
        THIS.this_nProximoComando = 0
        THIS.this_nTipoCampo      = 0
        THIS.this_nTamanhoMinimo  = 0
        THIS.this_nTamanhoMaximo  = 0
        THIS.this_cBuffer         = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua       = 0
    ENDPROC

    *====================================================================
    * ContinuarSiTef - Centraliza as chamadas a ContinuaFuncaoSiTef
    * Interativo espalhadas pelo legado (GetSenha.GotFocus/LostFocus e
    * SENHA.GotFocus/LostFocus).
    *
    * Os 5 primeiros argumentos da DLL sao POR REFERENCIA (@) e VFP9 nao
    * aceita property de objeto em argumento @ - por isso o valor sai das
    * properties para variaveis LOCAL, a DLL eh chamada e o resultado
    * volta para as properties. Mesma tecnica do sigprdftBO.
    *
    * PUBLIC (sem PROTECTED): o Form chama de fora (CLAUDE.md regra #51).
    *====================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), REPLICATE(CHR(0), 2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *====================================================================
    * MontarIdTerminal - Monta o 3o argumento (lsTerminal) de
    * ConfiguraIntSiTefInterativo, transcrito de SIGPROER.Init:
    *   lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
    *       TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
    *
    * fConverteStr() (SIGFUNCS.PRG) nao foi portada para esta migracao -
    * o equivalente ja adotado em sigprdftBO.CarregarParametrosOperacao
    * (mesma integracao SiTef) eh PADL(ALLTRIM(STR(valor, 5)), 5, "0");
    * mesma convencao aqui, com this_nNumero (nEmps) no lugar de codemps.
    *
    * crSigFiMpF (caixa aberto) nao tem equivalente de "caixa aberto"
    * nesta migracao - mesma ressalva de sigprdftBO: melhor esforco eh o
    * 1o registro de SIGFIMPF da empresa corrente; sem match, fallback
    * "000000" (mesmo comportamento do legado quando a caixa nao eh
    * localizada por SEEK/Requery).
    *====================================================================
    FUNCTION MontarIdTerminal()
        LOCAL loc_cCaixa, loc_oErro
        loc_cCaixa = "000000"

        TRY
            IF USED("cursor_4c_SigFiMpf")
                USE IN cursor_4c_SigFiMpf
            ENDIF

            SQLEXEC(gnConnHandle, ;
                "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_SigFiMpf")

            IF USED("cursor_4c_SigFiMpf") AND !EOF("cursor_4c_SigFiMpf")
                loc_cCaixa = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpf.cncaixas, "0")), "@L 999999")
            ENDIF

            IF USED("cursor_4c_SigFiMpf")
                USE IN cursor_4c_SigFiMpf
            ENDIF
        CATCH TO loc_oErro
            loc_cCaixa = "000000"
        ENDTRY

        RETURN PADL(ALLTRIM(STR(THIS.this_nNumero, 5)), 5, "0") + loc_cCaixa
    ENDFUNC

    *====================================================================
    * ConectarSiTef - migrado do bloco ConfiguraIntSiTefInterativo do
    * SIGPROER.Init. Retorna .T. quando a conexao com o servidor SiTef
    * foi estabelecida (retorno 0, igual ao legado).
    *====================================================================
    FUNCTION ConectarSiTef(par_cEndSitef, par_cLoja, par_cTerminal)
        LOCAL loc_nRetorno
        loc_nRetorno = ConfiguraIntSiTefInterativo(par_cEndSitef, par_cLoja, par_cTerminal, 0)
        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *====================================================================
    * IniciarSiTef - migrado do bloco IniciaFuncaoSiTefInterativo do
    * SIGPROER.Init:
    *   IniciaFuncaoSiTefInterativo(Iif(Empty(lsData),114,113), lcValores,
    *       "1", "", "", "", "")
    * par_nModalidade ja vem resolvido do Form (THIS.this_cDataSitef eh
    * quem decide 113/114). Retorna .T. quando o retorno eh 10000 (igual
    * ao legado).
    *====================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor)
        LOCAL loc_nRetorno
        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, "1", "", "", "", "")
        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCemps)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCemps  = TratarNulo(cemps, "C")
                THIS.this_nNumero = TratarNulo(nemps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigproerBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega cemps/nemps de SigCdEmp pelo codigo da
    * empresa. Equivalente ao AddCursor+Requery do Init legado
    * (Select * From SigCdEmp Where cEmps = ?_Empr), usado para montar o
    * ID do terminal SiTef (lcEmp = fConverteStr(CrSigCdEmp.nEmps) e
    * lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ...).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCemps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCemps) != "C" OR EMPTY(ALLTRIM(par_cCemps))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
            ELSE
                IF USED("cursor_4c_Emps")
                    USE IN cursor_4c_Emps
                ENDIF

                loc_cSQL = "SELECT cemps, nemps FROM SigCdEmp" + ;
                    " WHERE cemps = " + EscaparSQL(ALLTRIM(par_cCemps))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Emps") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Emps")
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCemps)
                    MostrarErro("Erro ao carregar empresa:" + CHR(13) + CapturarErroSQL(), "sigproerBO.CarregarPorCodigo")
                ENDIF

                IF USED("cursor_4c_Emps")
                    USE IN cursor_4c_Emps
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar empresa:" + CHR(13) + loException.Message, "sigproerBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarEmpresaAtual - Carrega a empresa logada no sistema.
    * Equivalente ao filtro "Where cEmps = ?_Empr" do Init legado.
    * _EMPR eh legado - usar sempre go_4c_Sistema.cCodEmpresa (CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarEmpresaAtual()
        RETURN THIS.CarregarPorCodigo(go_4c_Sistema.cCodEmpresa)
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - Formsigproer eh a tela de
    * Reimpressao do SiTef: o Init legado so faz AddCursor+Requery
    * (leitura) de SigCdEmp para montar o ID do terminal; MontaRetorno/
    * RetornoFalha gravam arquivos de resposta do SiTef (IntPos.001/
    * IntPos.STS), nunca a tabela SigCdEmp. Nao ha INSERT/UPDATE/DELETE
    * em SigCdEmp no legado, logo o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto.
    *====================================================================

ENDDEFINE


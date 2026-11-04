# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDadosEmpresaSiTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCTF.Container1): Top original=5 vs migrado 'lbl_4c_Label1' Top=181 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCTF.Container1): Left original=9 vs migrado 'lbl_4c_Label1' Left=326 (diff=317px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCtf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2137 linhas total):

*-- Linhas 11 a 161:
11: * Dialogo modal aberto para CANCELAR uma transacao TEF em andamento (cartao de
12: * debito/credito), comunicando com o terminal via protocolo interativo SiTef
13: * (CliSiTef32I.DLL - ConfiguraIntSiTefInterativo / IniciaFuncaoSiTefInterativo
14: * / ContinuaFuncaoSiTefInterativo, declaradas no PROCEDURE Load do legado).
15: * A tela NAO grava nada no SQL Server: o resultado do cancelamento vai para
16: * arquivos LOCAIS (C:\client\Resp\IntPos.001 e IntPos.STS - ver MontaRetorno/
17: * RetornoFalha do dump), consumidos pelo chamador apos o Unload. A UNICA
18: * leitura de banco e a de SigCdEmp (numero da empresa, usado para montar o
19: * IdTerminal do protocolo) - ja implementada em SigOpCtfBO (Fases 1-2).
20: *
21: * Legado (Init): PARAMETERS EndSiTef, IdTerminal, ValPago, Tipo, Data, Nsu,
22: *   pcCartao, plImpressora, pcCodEstabs
23: * Uso canonico:
24: *   loForm = CREATEOBJECT("FormSigOpCtf", cEndSiTef, cIdTerminal, nValPago, ;
25: *       cTipo, dData, cNsu, cCartao, lImpressora, cCodEstabs)
26: *   IF VARTYPE(loForm) = "O"
27: *       loForm.Show()
28: *   ENDIF
29: *
30: * Layout: form PLANO, sem PageFrame - o SCX legado (BaseClass "form" puro)
31: * nao tem PageFrame algum: cntSombra + SAIDA (CommandGroup de 1 botao) +
32: * Shape2 (moldura decorativa) + Container1 (label de status, trocado em
33: * runtime) + os campos de dados (Valor, 4 Ultimos Digitos, Senha do
34: * Supervisor, Numero do Cartao, Codigo de Seguranca) penduram direto na
35: * Form. Ver padrao em FormSIGPRTFH.prg (mesma familia de dialogo SiTef).
36: *
37: *------------------------------------------------------------------------------
38: * ESCOPO JA ENTREGUE
39: *
40: * Fase 3/8 - estrutura base: propriedades visuais do dump, Init() com os 9
41: * parametros do legado, InicializarForm() (cria o SigOpCtfBO), cabecalho
42: * (cnt_4c_Sombra), moldura (shp_4c_Shape2), o container de status
43: * (cnt_4c_Container1) com a mensagem inicial do legado ("Insira ou Passe o
44: * Cartao" - Container1.Label1) e o botao de saida (obj_4c_SAIDA/CANCELA) -
45: * a UNICA acao do dialogo, equivalente ao bloco de saida dos forms CRUD, e
46: * que nao depende de nenhum campo ainda nao criado. Destroy() tambem entra
47: * aqui, delegando a FormBase via DODEFAULT().
48: *
49: * Fase 5/8 - primeira metade dos campos de captura (ConfigurarCamposDados1):
50: * Label4/GetValor ("Valor :"), Label6/SENHA ("Senha do Supervisor :") e
51: * Label7/GetCartao ("Numero Cartao :"). Conferido byte a byte no dump
52: * (SigOpCtf_form_codigo_fonte.txt) que NENHUMA dessas tres legendas tem
53: * acento (diferente de Container1.Label1, que tem "Cart" + CHR(227) + "o")
54: * - transcritas literalmente, sem inventar CHR(). Os tres campos nascem
55: * Enabled=.F. (GetValor/GetCartao - dump explicito) ou no default .T. do
56: * TextBox (SENHA - dump NAO lista Enabled para ela): o laco interativo da
57: * Fase 7 habilita cada um na vez certa, equivalente ao
58: * "ThisForm.GetCodSeg.Enabled=.t." visto no dump.
59: *
60: * Fase 6/8 (este arquivo) - segunda metade dos campos de captura
61: * (ConfigurarCamposDados2): Label5/GetDigitos ("4 Ultimos Digitos :"),
62: * Label12/GetCodSeg ("Cod. Seg. :"), o campo vestigial Text2 e as duas
63: * legendas fixas Label1/Label3 ("0 - Inexist."/"1 - Ilegivel", na raiz da
64: * Form - distintas de Container1.Label1 ja criado na Fase 3). GetDigitos
65: * nao lista Enabled no dump -> fica no default .T. (mesmo criterio da
66: * SENHA na Fase 5); GetCodSeg e Text2 nascem Enabled=.F. (dump explicito).
67: * Text2 ocupa a MESMA area de txt_4c_SENHA (Left=161/Top=126/Width=100/
68: * Height=23) - no legado ele e criado ANTES de SENHA e fica oculto por
69: * baixo dela no z-order (confirmado: nenhuma PROCEDURE do dump altera
70: * .Visible de Text2 ou SENHA). Como SENHA ja existe desde a Fase 5,
71: * ZOrder(1) em Text2 reproduz aqui a mesma pintura do legado, mandando-o
72: * para TRAS - sem isso ele cobriria SENHA e bloquearia a digitacao da
73: * senha do supervisor.
74: *
75: * Ainda na Fase 6, a parte de "lookups" desta fase: o legado NAO TEM
76: * lookup algum (medido no dump - zero fwBuscaExt/fwBuscaSel/fwBuscaInt/
77: * sigacess/mAddColuna/AcessoXxx; e um dialogo que conversa com o terminal
78: * SiTef pela DLL, nao com tabela), e inventar um FormBuscaAuxiliar seria
79: * violar o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao
80: * existem no original". O que o legado tem de validacao de campo sao os
81: * DOIS unicos PROCEDURE Valid com corpo do dump, transcritos integralmente
82: * aqui (ver o bloco "VALIDACOES DE CAMPO" mais abaixo):
83: *   - ValidarDigitos   <- SIGOPCTF.GetDigitos.Valid (exige 4 digitos, limpa
84: *                         o campo e recusa a saida quando nao bate)
85: *   - ValidarCodSeg    <- SIGOPCTF.GetCodSeg.Valid (recusa a faixa 2..99,
86: *                         com os operadores estritos do legado)
87: * mais DigitosKeyPress/CodSegKeyPress (os handlers que disparam em
88: * ENTER/TAB, onde o "Return(.f.)" do legado vira NODEFAULT + SetFocus -
89: * BINDEVENT em "Valid" nao e confiavel em TextBox, regra CLAUDE.md #3),
90: * o helper ExibirMensagemTef (substitui "DO Form SigTfDss", cujo SCX nao
91: * esta no acervo) e RegistrarEventosCampos (os BINDEVENT), chamado pelo
92: * InicializarForm.
93: *
94: * Fase 7/8 (este arquivo) - laco interativo com o terminal: o prompt
95: * generico de pipeline para esta fase pede "BtnIncluirClick/BtnAlterarClick/
96: * BtnVisualizarClick/BtnExcluirClick" (template CRUD) - NAO SE APLICA aqui
97: * pelo MESMO motivo ja registrado na nota da Fase 4 abaixo (zero Grid, zero
98: * INSERT/UPDATE/DELETE, zero "modo LISTA"). O que a Fase 7 realmente
99: * entrega, porque e o que falta no roadmap desde a Fase 6 ("NAO ENTRAM NESTA
100: * FASE" abaixo), e o laco de SIGOPCTF.SENHA/GetDigitos/GetCartao/GetCodSeg
101: * GotFocus/LostFocus (SENHA/GetDigitos/GetCartao/GetCodSeg - Text2 continua
102: * FORA, vestigial) + SAIDA.CANCELA.Click + RetornoFalha/MontaRetorno (do
103: * FORM, nao do BO - mesmo lugar do sibling Formsigprdft) + os 3 DECLARE-DLL/
104: * ConectarSiTef/IniciarSiTef/ContinuarSiTef novos em SigOpCtfBO.prg. Ver o
105: * bloco "LACO INTERATIVO COM O TERMINAL SITEF" mais abaixo, antes de
106: * TornarControlesVisiveis, para a documentacao metodo a metodo.
107: *
108: * O handshake (ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo, no
109: * Init legado) foi deslocado para SenhaGotFocus (POS-Show) em vez de
110: * InicializarForm (PRE-Show) - ver cabecalho de SenhaGotFocus para a
111: * justificativa (regra CLAUDE.md #29). A leitura de SigCdEmp/SIGFIMPF e a
112: * montagem de lsIdTerminal/lcIdTerminal (CarregarDadosEmpresaSiTef, que
113: * substitui as linhas do Init legado ANTES do handshake) continuam em
114: * InicializarForm, por serem SQL/computacao pura, sem risco de Release()
115: * pre-Show.
116: *
117: * O .When de Text2/SENHA/GetCodSeg ("Return(EMPTY(This.Value))", que so
118: * deixa ENTRAR no campo enquanto ele esta vazio): e gate de ENTRADA,
119: * reproduzido como guard no topo de SenhaGotFocus/DigitosGotFocus (o campo
120: * nunca recupera foco depois de LostFocus desabilita-lo - regra CLAUDE.md
121: * #3, BINDEVENT em "When" nao bloqueia nada porque o retorno do delegate e
122: * descartado). Mesmo tratamento ja dado em Formsigprdft.DigitosGotFocus,
123: * irmao da mesma familia SiTef.
124: *
125: * NAO existem aqui PageFrame, pagina Lista/Dados nem botoes CRUD
126: * canonicos: o dump nao tem grade (analise.json: "temGrid": false) nem
127: * INSERT/UPDATE/DELETE algum (comportamento.json: zero queries SQL fora
128: * do CREATE CURSOR local de MontaRetorno/RetornoFalha) - inventar essas
129: * estruturas violaria o PILAR 1 e a regra de nunca inventar
130: * funcionalidade ausente do original.
131: *
132: *------------------------------------------------------------------------------
133: * FASE 4/8 - "Grid e botoes CRUD (Page1)" no template generico. NAO SE
134: * APLICA a este legado e NAO ACRESCENTA NADA a este arquivo.
135: *
136: * Medido contra o dump (layout.json/analise.json/comportamento.json, task716):
137: * zero "BaseClass: grid|pageframe|listbox", zero AddCursor/pColuna/Grade/grd,
138: * e os unicos ControlSource do form sao os escalares this_* lidos via
139: * Init/PARAMETERS - nao ha superficie de LISTA (nem Page1) para desenhar
140: * Grid, e por isso tambem nao ha "modo LISTA" que justifique os 5 botoes
141: * CRUD canonicos (Incluir/Visualizar/Alterar/Excluir/Buscar). O form eh um
142: * dialogo CAPTURA de dados (Valor, 4 Ultimos Digitos, Senha, Cartao, Codigo
143: * de Seguranca) que dialoga com o terminal via DLL - perfil igual ao
144: * DESPACHANTE/CAPTURA ja documentado em
145: * docs/FORMCOR_LICOES_APRENDIDAS.md e nas licoes de gate das Fases 4-8
146: * (SIGOPCHP/task699, SIGOPCTD/task715 e SIGOPCRP/task714, todos sem Grid
147: * nem CRUD). A unica acao de saida do dialogo (botao CANCELA/obj_4c_SAIDA)
148: * ja foi entregue na Fase 3 (ConfigurarSaida) porque e' estrutural, nao
149: * depende de nenhum campo ainda nao criado, e equivale ao bloco de saida
150: * dos forms CRUD - nao ha "Incluir/Alterar/Excluir" a inventar para um
151: * dialogo de confirmacao de cancelamento TEF.
152: *
153: * Os campos de dados (Fases 5-6) e o laco interativo com o terminal mais o
154: * Click do botao de saida (Fases 7-8) permanecem no escopo ja descrito
155: * acima, sem mudanca de plano.
156: *
157: *------------------------------------------------------------------------------
158: * FASE 8/8 - "Form - Eventos Auxiliares e Consolidacao Final" no template
159: * generico, que pede BtnBuscarClick/Btn...rrarClick, BtnSalvarClick/
160: * Btn...larClick, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
161: * Carregar...sta/AjustarBotoesPorModo.

*-- Linhas 310 a 498:
310:     *--------------------------------------------------------------------------
311:     * Init - Recebe os mesmos 9 parametros do Init legado. Guarda os
312:     * escalares ANTES de DODEFAULT() - FormBase.Init() chama
313:     * InicializarForm(), que ainda nao usa estes valores nesta fase (o BO so
314:     * precisa deles a partir do laco interativo, Fase 7), mas a guarda
315:     * acontece aqui para o Init ficar completo desde ja (regra CLAUDE.md
316:     * Problema 8: logica extra ANTES do DODEFAULT(), nunca RETURN dentro de
317:     * TRY/CATCH).
318:     *--------------------------------------------------------------------------
319:     PROCEDURE Init(par_cEndSiTef, par_cIdTerminal, par_nValorPago, ;
320:             par_cTipoPgto, par_dDataTrans, par_cNsu, par_cCartao, ;
321:             par_lImpressora, par_cCodEstabs)
322: 
323:         THIS.this_cEndSiTef   = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
324:         THIS.this_cIdTerminal = IIF(VARTYPE(par_cIdTerminal) = "C", par_cIdTerminal, "")
325:         THIS.this_nValorPago  = IIF(VARTYPE(par_nValorPago) = "N", par_nValorPago, ;
326:             VAL(TRANSFORM(par_nValorPago)))
327:         THIS.this_cTipoPgto   = IIF(VARTYPE(par_cTipoPgto) = "C", par_cTipoPgto, "")
328:         THIS.this_dDataTrans  = IIF(INLIST(VARTYPE(par_dDataTrans), "D", "T"), ;
329:             par_dDataTrans, {})
330:         THIS.this_cNsu        = IIF(VARTYPE(par_cNsu) = "C", par_cNsu, "")
331:         THIS.this_cCartao     = IIF(VARTYPE(par_cCartao) = "C", par_cCartao, "")
332:         THIS.this_lImpressora = IIF(VARTYPE(par_lImpressora) = "L", par_lImpressora, .F.)
333:         THIS.this_cCodEstabs  = IIF(VARTYPE(par_cCodEstabs) = "C", par_cCodEstabs, "")
334: 
335:         RETURN DODEFAULT()
336:     ENDPROC
337: 
338:     *--------------------------------------------------------------------------
339:     * InicializarForm - Cria o Business Object e monta a estrutura visual
340:     * base (cabecalho, moldura, container de status e botao de saida), na
341:     * mesma ordem do SCX legado.
342:     *--------------------------------------------------------------------------
343:     PROTECTED PROCEDURE InicializarForm()
344:         LOCAL loc_lSucesso, loc_oErro
345:         loc_lSucesso = .F.
346: 
347:         TRY
348:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCtfBO")
349: 
350:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
351:                 THIS.ConfigurarCabecalho()
352:                 THIS.ConfigurarPainel()
353:                 THIS.ConfigurarCamposDados1()
354:                 THIS.ConfigurarCamposDados2()
355:                 THIS.ConfigurarContainerStatus()
356:                 THIS.ConfigurarSaida()
357:                 THIS.RegistrarEventosCampos()
358: 
359:                 THIS.TornarControlesVisiveis(THIS)
360: 
361:                 loc_lSucesso = THIS.CarregarDadosEmpresaSiTef()
362:             ELSE
363:                 MsgErro("Erro ao criar Business Object SigOpCtfBO." + CHR(13) + ;
364:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
365:             ENDIF
366:         CATCH TO loc_oErro
367:             MsgErro(loc_oErro.Message + CHR(13) + ;
368:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
369:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCtf")
370:         ENDTRY
371: 
372:         RETURN loc_lSucesso
373:     ENDPROC
374: 
375:     *--------------------------------------------------------------------------
376:     * CarregarDadosEmpresaSiTef - Parte do Init legado que acontece ANTES do
377:     * protocolo com o terminal: leitura de SigCdEmp/SIGFIMPF e montagem dos
378:     * identificadores do terminal (lsIdTerminal/lcIdTerminal). Migrado de
379:     * SIGOPCTF.Init:
380:     *     .poDatamgr = CreateObject('fSqlConector',ThisForm.Name)
381:     *     If Not .poDatamgr.pnIdconn>0
382:     *         DO Form SigTfDss With "Erro",'Impossivel Efetuar Conexao com
383:     *             Servidor','de Banco de Dados.'
384:     *         Return(.f.)
385:     *     Endif
386:     *     .AddCursor('SigCdEmp',...) + .Requery('crSigCdEmp')
387:     *     (lsEmp=fConverteStr(CrSigCdEmp.nEmps) - vestigial, nunca lido de
388:     *     novo no dump)
389:     *     lsIdTerminal/lcIdTerminal - ver SigOpCtfBO.MontarIdentificacaoTerminal
390:     *     GetValor.Value = Iif(plImpressora,Val(Strtran(lnValPago,",","."))
391:     *         ,lnValPago)
392:     *     IF pcCartao = "S" / Label5.Caption = "Digite a Validade" / Endif
393:     *
394:     * "Return(.f.)" do legado equivale a esta funcao devolver .F.:
395:     * InicializarForm propaga para CREATEOBJECT() = .F. e o dialogo NUNCA
396:     * abre - exatamente o comportamento do legado quando a conexao com o SQL
397:     * Server falha.
398:     *
399:     * A chamada real ao terminal (ConfiguraIntSiTefInterativo/
400:     * IniciaFuncaoSiTefInterativo) NAO mora aqui: fica em SenhaGotFocus, o
401:     * PRIMEIRO campo habilitado a receber foco quando a tela abre (txt_4c_
402:     * Valor nasce Enabled=.F.; txt_4c_SENHA eh o proximo na ordem de tab) -
403:     * mesmo criterio do sibling Formsigprdft, que defere ConectarSiTef/
404:     * IniciarSiTef para DigitosGotFocus em vez de rodar em InicializarForm:
405:     * chamar THIS.Release() aqui, ANTES do Show() do chamador, destruiria o
406:     * objeto antes do CREATEOBJECT devolver (regra CLAUDE.md #29).
407:     *
408:     * Bypass para teste automatizado/validacao de UI headless (sem conexao
409:     * real e sem CliSiTef32I.DLL na maquina do pipeline).
410:     *--------------------------------------------------------------------------
411:     PROTECTED FUNCTION CarregarDadosEmpresaSiTef()
412:         LOCAL loc_oBO, loc_oErro
413: 
414:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
415:            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
416:             RETURN .T.
417:         ENDIF
418: 
419:         loc_oBO = THIS.this_oBusinessObject
420: 
421:         TRY
422:             IF !loc_oBO.CarregarPorCodigo(go_4c_Sistema.cCodEmpresa)
423:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
424:                     "o com Servidor" + CHR(13) + "de Banco de Dados.", "Erro")
425:                 RETURN .F.
426:             ENDIF
427: 
428:             loc_oBO.CarregarCaixaSiTef()
429:             loc_oBO.MontarIdentificacaoTerminal(THIS.this_cCodEstabs)
430: 
431:             *-- "IF pcCartao = "S" / Label5.Caption = ..." e
432:             *-- "GetValor.Value = Iif(plImpressora, ...)" do Init legado
433:             *-- moram em BOParaForm(), que e o ponto unico de recarga da tela
434:             *-- a partir do estado resolvido.
435:             THIS.BOParaForm()
436:         CATCH TO loc_oErro
437:             MsgErro(loc_oErro.Message + CHR(13) + ;
438:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
439:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.CarregarDadosEmpresaSiTef")
440:             RETURN .F.
441:         ENDTRY
442: 
443:         RETURN .T.
444:     ENDFUNC
445: 
446:     *--------------------------------------------------------------------------
447:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
448:     * Origem: SIGOPCTF.cntSombra Top=0, Left=0, Width=800 (> Form.Width=463 -
449:     * clone de template maior, nunca redimensionado no SCX - usar THIS.Width,
450:     * que produz o MESMO efeito visual sem extrapolar o form), Height=80,
451:     * BackColor=100,100,100; lblSombra/lblTitulo Top=18/17, Left=10,
452:     * Width=769 no legado (> Form.Width - mesmo motivo, aqui THIS.Width-20),
453:     * FontSize=18, Tahoma Bold, ForeColor preto/branco. O legado sobrescreve
454:     * os dois Caption no Init ("ThisForm.cntSombra.lblSombra.Caption =
455:     * ThisForm.Caption" / idem lblTitulo) - aqui ja nasce com THIS.Caption,
456:     * sem precisar reatribuir depois.
457:     *--------------------------------------------------------------------------
458:     PROTECTED PROCEDURE ConfigurarCabecalho()
459:         LOCAL loc_oErro
460:         TRY
461:             THIS.AddObject("cnt_4c_Sombra", "Container")
462:             WITH THIS.cnt_4c_Sombra
463:                 .Top         = 0
464:                 .Left        = 0
465:                 .Width       = THIS.Width
466:                 .Height      = 80
467:                 .BackStyle   = 1
468:                 .BackColor   = RGB(100, 100, 100)
469:                 .BorderWidth = 0
470:                 .Visible     = .T.
471:             ENDWITH
472: 
473:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
474:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
475:                 .FontBold      = .T.
476:                 .FontName      = "Tahoma"
477:                 .FontSize      = 18
478:                 .FontUnderline = .F.
479:                 .WordWrap      = .T.
480:                 .Alignment     = 0
481:                 .BackStyle     = 0
482:                 .AutoSize      = .F.
483:                 .Caption       = THIS.Caption
484:                 .Height        = 40
485:                 .Left          = 10
486:                 .Top           = 18
487:                 .Width         = THIS.Width - 20
488:                 .ForeColor     = RGB(0, 0, 0)
489:                 .Visible       = .T.
490:             ENDWITH
491: 
492:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
493:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
494:                 .FontBold  = .T.
495:                 .FontName  = "Tahoma"
496:                 .FontSize  = 18
497:                 .WordWrap  = .T.
498:                 .Alignment = 0

*-- Linhas 509 a 592:
509:         CATCH TO loc_oErro
510:             MsgErro(loc_oErro.Message + CHR(13) + ;
511:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
512:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCabecalho")
513:         ENDTRY
514:     ENDPROC
515: 
516:     *--------------------------------------------------------------------------
517:     * ConfigurarPainel - Moldura/retangulo decorativo (Shape2 do legado) que
518:     * circunda a area de campos (Valor/4 Ultimos Digitos/Senha), criados na
519:     * Fase 5. Origem: SIGOPCTF.Shape2
520:     *   Top=90, Left=3, Height=130, Width=402, BorderWidth=2, SpecialEffect=0.
521:     *--------------------------------------------------------------------------
522:     PROTECTED PROCEDURE ConfigurarPainel()
523:         LOCAL loc_oErro
524:         TRY
525:             THIS.AddObject("shp_4c_Shape2", "Shape")
526:             WITH THIS.shp_4c_Shape2
527:                 .Top           = 90
528:                 .Left          = 3
529:                 .Height        = 130
530:                 .Width         = 402
531:                 .BackStyle     = 0
532:                 .BorderWidth   = 2
533:                 .SpecialEffect = 0
534:                 .Visible       = .T.
535:             ENDWITH
536:         CATCH TO loc_oErro
537:             MsgErro(loc_oErro.Message + CHR(13) + ;
538:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
539:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarPainel")
540:         ENDTRY
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * ConfigurarCamposDados1 - Primeira metade dos campos de captura (Fase
545:     * 5/8): Valor, Senha do Supervisor e Numero do Cartao. Posicionados
546:     * dentro da moldura shp_4c_Shape2 (Top=90..220). Enabled=.F. nos campos
547:     * em que o dump declara (GetValor/GetCartao); SENHA fica no default
548:     * .T. do TextBox porque o dump NAO lista Enabled para ela - o laco
549:     * interativo da Fase 7 reajusta Enabled de cada campo na vez certa.
550:     * Origem: SIGOPCTF.Label4/GetValor, Label6/SENHA, Label7/GetCartao.
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarCamposDados1()
553:         LOCAL loc_oErro
554:         TRY
555:             *-- Label4 + GetValor ("Valor :")
556:             THIS.AddObject("lbl_4c_Label4", "Label")
557:             WITH THIS.lbl_4c_Label4
558:                 .FontBold  = .T.
559:                 .FontName  = "Tahoma"
560:                 .FontSize  = 8
561:                 .Alignment = 0
562:                 .BackStyle = 0
563:                 .AutoSize  = .F.
564:                 .Caption   = "Valor :"
565:                 .Height    = 15
566:                 .Left      = 117
567:                 .Top       = 102
568:                 .Width     = 37
569:                 .TabIndex  = 8
570:                 .ForeColor = RGB(90, 90, 90)
571:                 .Visible   = .T.
572:             ENDWITH
573: 
574:             THIS.AddObject("txt_4c_Valor", "TextBox")
575:             WITH THIS.txt_4c_Valor
576:                 .Alignment = 3
577:                 .Value     = 0
578:                 .Enabled   = .F.
579:                 .Height    = 23
580:                 .InputMask = "99,999,999.99"
581:                 .Left      = 161
582:                 .TabIndex  = 1
583:                 .Top       = 98
584:                 .Width     = 100
585:                 .Visible   = .T.
586:             ENDWITH
587: 
588:             *-- Label6 + SENHA ("Senha do Supervisor :")
589:             THIS.AddObject("lbl_4c_Label6", "Label")
590:             WITH THIS.lbl_4c_Label6
591:                 .FontBold  = .T.
592:                 .FontName  = "Tahoma"

*-- Linhas 657 a 728:
657:         CATCH TO loc_oErro
658:             MsgErro(loc_oErro.Message + CHR(13) + ;
659:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
660:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCamposDados1")
661:         ENDTRY
662:     ENDPROC
663: 
664:     *--------------------------------------------------------------------------
665:     * ConfigurarCamposDados2 - Segunda metade dos campos de captura (Fase
666:     * 6/8): 4 Ultimos Digitos, Cod. Seg., o campo vestigial Text2 (ver nota
667:     * de ZOrder abaixo) e as duas legendas fixas "0 - Inexist." / "1 -
668:     * Ilegivel" que documentam os codigos de retorno da leitura do cartao.
669:     * Enabled=.F. nos campos em que o dump declara (GetCodSeg/Text2);
670:     * GetDigitos NAO declara Enabled -> fica no default .T. (mesmo
671:     * criterio da SENHA na Fase 5) - o laco interativo da Fase 7 reajusta
672:     * Enabled/foco de cada campo na vez certa.
673:     *
674:     * Text2 (SIGOPCTF.Text2) ocupa EXATAMENTE a mesma area de txt_4c_SENHA
675:     * (Left=161, Top=126, Width=100, Height=23) e nenhuma PROCEDURE do
676:     * dump altera .Visible de um ou outro - no legado, Text2 e criado
677:     * ANTES de SENHA (ordem do SCX) e por isso fica OCULTO por baixo dela
678:     * no z-order; e Enabled=.F./TabStop=.F., vestigio sem papel funcional
679:     * no fluxo. Como SENHA ja foi criada na Fase 5 (antes deste metodo),
680:     * ZOrder(1) reproduz aqui a mesma ordem de pintura do legado, mandando
681:     * Text2 para TRAS - sem isso Text2 ficaria por CIMA de SENHA e
682:     * bloquearia o clique/digitacao no campo real.
683:     *
684:     * Origem: SIGOPCTF.Label5/GetDigitos, Text2, GetCodSeg/Label12, Label1
685:     * (direto na Form - distinto de Container1.Label1, ja criado na Fase
686:     * 3), Label3.
687:     *--------------------------------------------------------------------------
688:     PROTECTED PROCEDURE ConfigurarCamposDados2()
689:         LOCAL loc_oErro
690:         TRY
691:             *-- Label5 + GetDigitos ("4 Ultimos Digitos :")
692:             THIS.AddObject("lbl_4c_Label5", "Label")
693:             WITH THIS.lbl_4c_Label5
694:                 .FontBold  = .T.
695:                 .FontName  = "Tahoma"
696:                 .FontSize  = 8
697:                 .Alignment = 0
698:                 .BackStyle = 0
699:                 .AutoSize  = .F.
700:                 .Caption   = "4 Ultimos Digitos :"
701:                 .Height    = 15
702:                 .Left      = 51
703:                 .Top       = 188
704:                 .Width     = 103
705:                 .TabIndex  = 11
706:                 .ForeColor = RGB(90, 90, 90)
707:                 .Visible   = .T.
708:             ENDWITH
709: 
710:             THIS.AddObject("txt_4c_Digitos", "TextBox")
711:             WITH THIS.txt_4c_Digitos
712:                 *-- O dump NAO declara Value para este campo (ao contrario de
713:                 *-- GetValor, que traz "Value = 0"): e' CARACTERE, como prova o
714:                 *-- "This.Value = """ do proprio Valid legado e o
715:                 *-- "LEN(Alltrim(This.Value))" que ele usa. Inicializado
716:                 *-- explicitamente (regra do projeto: TextBox sempre nasce com
717:                 *-- .Value inicializado) para ALLTRIM/EMPTY nunca receberem o
718:                 *-- default do VFP.
719:                 .Value     = ""
720:                 .Height    = 23
721:                 .InputMask = "9999"
722:                 .Left      = 161
723:                 .TabIndex  = 4
724:                 .Top       = 184
725:                 .Width     = 39
726:                 .Visible   = .T.
727:             ENDWITH
728: 

*-- Linhas 817 a 1331:
817:         CATCH TO loc_oErro
818:             MsgErro(loc_oErro.Message + CHR(13) + ;
819:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
820:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCamposDados2")
821:         ENDTRY
822:     ENDPROC
823: 
824:     *--------------------------------------------------------------------------
825:     * ConfigurarContainerStatus - Container1 do legado: moldura com a
826:     * mensagem corrente da interacao com o terminal (Container1.Label1,
827:     * trocada em runtime pelo laco interativo das Fases 7-8 - ver
828:     * SIGOPCTF.SENHA/GetDigitos/GetCartao GotFocus/LostFocus no dump:
829:     * "Digite a Senha do Supervisor" / "Digite os 4 Ultimos Digitos" /
830:     * "Digite o Numero do Cartao" / "Digite a Validade do Cartao" /
831:     * "Insira ou Passe o Cartao"). Mensagem inicial = a do Init legado
832:     * (nenhum metodo altera Label1 antes do primeiro foco entrar em SENHA).
833:     * Origem: SIGOPCTF.Container1 (Top=227, Left=3, Width=288, Height=57,
834:     * BorderWidth=2, SpecialEffect=2, TabIndex=15) e Container1.Label1
835:     * (AutoSize=.F. preservado - regra CLAUDE.md #23, FontSize=14 Tahoma
836:     * Bold, Alignment=2 centralizado, ForeColor 90,90,90, Height=47, Left=9,
837:     * Top=5, Width=270).
838:     *--------------------------------------------------------------------------
839:     PROTECTED PROCEDURE ConfigurarContainerStatus()
840:         LOCAL loc_oErro
841:         TRY
842:             THIS.AddObject("cnt_4c_Container1", "Container")
843:             WITH THIS.cnt_4c_Container1
844:                 .Top           = 227
845:                 .Left          = 3
846:                 .Width         = 288
847:                 .Height        = 57
848:                 .BorderWidth   = 2
849:                 .SpecialEffect = 2
850:                 .TabIndex      = 15
851:                 .Visible       = .T.
852:             ENDWITH
853: 
854:             THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
855:             WITH THIS.cnt_4c_Container1.lbl_4c_Label1
856:                 .FontName  = "Tahoma"
857:                 .FontBold  = .T.
858:                 .FontSize  = 14
859:                 .Alignment = 2
860:                 .AutoSize  = .F.
861:                 .BackStyle = 0
862:                 .Caption   = "Insira ou Passe o Cart" + CHR(227) + "o"
863:                 .Height    = 47
864:                 .Left      = 9
865:                 .Top       = 5
866:                 .Width     = 270
867:                 .ForeColor = RGB(90, 90, 90)
868:                 .Visible   = .T.
869:             ENDWITH
870:         CATCH TO loc_oErro
871:             MsgErro(loc_oErro.Message + CHR(13) + ;
872:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
873:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarContainerStatus")
874:         ENDTRY
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * ConfigurarSaida - CommandGroup de 1 botao (SAIDA/CANCELA do legado) -
879:     * unica acao de saida do dialogo. Origem: SIGOPCTF.SAIDA
880:     *   AutoSize=.T., ButtonCount=1, BackStyle=0, BorderStyle=0, Height=85,
881:     *   Left=382, Top=-2, Width=85, TabIndex=6, BackColor=255,255,255,
882:     *   Themes=.F.; Command1 (renomeado "CANCELA" no legado): Top=5, Left=5,
883:     *   Height=75, Width=75, FontBold=.T., FontItalic=.T.,
884:     *   FontName="Comic Sans MS", FontSize=7,
885:     *   Picture=..\framework\imagens\cadastro_sair_26.jpg, Cancel=.T.,
886:     *   Caption="", ToolTipText="[ESC] Sair", ForeColor=90,90,90,
887:     *   BackColor=255,255,255, Themes=.F.
888:     * CommandGroup NAO tem ForeColor (regra CLAUDE.md #33) - a cor vai no
889:     * Buttons(1), nao no grupo. Buttons(N) configurado em WITH ANINHADO
890:     * dentro do WITH do grupo (excecao segura da regra CLAUDE.md #44).
891:     * Sem BINDEVENT ainda - Click/GotFocus (o laco interativo com o
892:     * terminal e o fechamento do dialogo) entram nas Fases 7-8.
893:     *--------------------------------------------------------------------------
894:     PROTECTED PROCEDURE ConfigurarSaida()
895:         LOCAL loc_oErro
896:         TRY
897:             THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
898:             WITH THIS.obj_4c_SAIDA
899:                 .AutoSize    = .T.
900:                 .ButtonCount = 1
901:                 .BackStyle   = 0
902:                 .BorderStyle = 0
903:                 .Height      = 85
904:                 .Left        = 382
905:                 .Top         = -2
906:                 .Width       = 85
907:                 .TabIndex    = 6
908:                 .BackColor   = RGB(255, 255, 255)
909:                 .Themes      = .F.
910:                 .Visible     = .T.
911: 
912:                 WITH .Buttons(1)
913:                     .Top         = 5
914:                     .Left        = 5
915:                     .Height      = 75
916:                     .Width       = 75
917:                     .FontBold    = .T.
918:                     .FontItalic  = .T.
919:                     .FontName    = "Comic Sans MS"
920:                     .FontSize    = 7
921:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_26.jpg"
922:                     .Cancel      = .T.
923:                     .Caption     = ""
924:                     .ToolTipText = "[ESC] Sair"
925:                     .ForeColor   = RGB(90, 90, 90)
926:                     .BackColor   = RGB(255, 255, 255)
927:                     .Themes      = .F.
928:                 ENDWITH
929:             ENDWITH
930:         CATCH TO loc_oErro
931:             MsgErro(loc_oErro.Message + CHR(13) + ;
932:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
933:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarSaida")
934:         ENDTRY
935:     ENDPROC
936: 
937:     *==========================================================================
938:     * VALIDACOES DE CAMPO (Fase 6/8)
939:     *
940:     * O SCX legado NAO tem lookup algum - medido no dump
941:     * (tasks\task716\SigOpCtf_form_codigo_fonte.txt): zero fwBuscaExt,
942:     * fwBuscaSel, fwBuscaInt, sigacess, mAddColuna e AcessoXxx. E um dialogo
943:     * de CAPTURA que conversa com o terminal SiTef pela DLL CliSiTef32I, nao
944:     * com tabela - inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a
945:     * regra explicita "NUNCA inventar tabelas de lookup que nao existem no
946:     * original", e metodo vazio e proibido pela regra de completude.
947:     *
948:     * O que o legado TEM e validacao de FORMATO no Valid de DOIS campos -
949:     * GetDigitos e GetCodSeg sao os unicos PROCEDURE Valid COM CORPO do dump
950:     * inteiro (SIGOPCTF.Text2.Valid existe mas esta VAZIO; GetValor, SENHA e
951:     * GetCartao nao tem Valid algum). Os dois metodos Validar* abaixo
952:     * transcrevem esses Valid INTEIROS, e os handlers ligados por BINDEVENT
953:     * disparam em ENTER(13)/TAB(9), onde o "Return(.f.)" do legado (que
954:     * cancela a saida do campo) vira NODEFAULT + SetFocus. BINDEVENT em
955:     * "Valid" nao e confiavel em TextBox - regra CLAUDE.md #3.
956:     *
957:     * NAO entram nesta fase, porque sao EVENTOS DIFERENTES do Valid:
958:     *   - GetDigitos/SENHA/GetCartao/GetCodSeg/Text2 .LostFocus e .GotFocus,
959:     *     que SAO o laco do protocolo (ContinuaFuncaoSiTefInterativo em
960:     *     sequencia, com as mensagens do Container1.Label1) - Fase 7.
961:     *   - O .When de Text2/SENHA/GetCodSeg ("Return(EMPTY(This.Value))", que
962:     *     so deixa ENTRAR no campo enquanto ele esta vazio): e gate de
963:     *     ENTRADA, logo vai no guard de abertura dos handlers de GotFocus, na
964:     *     Fase 7. BINDEVENT em "When" nao serve - o retorno do delegate e
965:     *     DESCARTADO e o When nao bloqueia nada (regra CLAUDE.md #3). Mesmo
966:     *     tratamento ja dado em Formsigprdft.DigitosGotFocus, irmao da mesma
967:     *     familia SiTef.
968:     *==========================================================================
969: 
970:     *--------------------------------------------------------------------------
971:     * RegistrarEventosCampos - BINDEVENT dos dois campos que o legado valida
972:     * no Valid. Metodos-alvo PUBLIC (BINDEVENT falha EM SILENCIO com
973:     * PROTECTED) e com os parametros do evento declarados - KeyPress exige
974:     * par_nKeyCode + par_nShiftAltCtrl, e handler sem parametro ligado a
975:     * KeyPress estoura a cada tecla (regra CLAUDE.md #3).
976:     *
977:     * txt_4c_Codigo (GetCodSeg) nasce Enabled=.F. no dump: o BINDEVENT fica
978:     * registrado desde ja e so passa a disparar quando o laco do protocolo
979:     * habilitar o campo na Fase 7 ("ThisForm.GetCodSeg.Enabled=.t." aparece
980:     * em 3 pontos do dump) - ligar evento em controle desabilitado e
981:     * inofensivo.
982:     *
983:     * NAO entram: txt_4c_Valor (GetValor) e txt_4c_Cartao (GetCartao), que o
984:     * dump nao da Valid nem When (GetCartao tem so LostFocus = protocolo,
985:     * Fase 7); e txt_4c_Text2, cujo Valid esta vazio e que e Enabled=.F. /
986:     * TabStop=.F. (vestigial).
987:     *--------------------------------------------------------------------------
988:     PROTECTED PROCEDURE RegistrarEventosCampos()
989:         LOCAL loc_oErro
990:         TRY
991:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosKeyPress")
992:             BINDEVENT(THIS.txt_4c_Codigo,  "KeyPress", THIS, "CodSegKeyPress")
993: 
994:             *-- Laco interativo com o terminal SiTef (Fase 7/8) - ver bloco
995:             *-- "LACO INTERATIVO COM O TERMINAL SITEF" mais abaixo.
996:             BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelaClick")
997:             BINDEVENT(THIS.txt_4c_SENHA,   "GotFocus",  THIS, "SenhaGotFocus")
998:             BINDEVENT(THIS.txt_4c_SENHA,   "LostFocus", THIS, "SenhaLostFocus")
999:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")
1000:             BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")
1001:             BINDEVENT(THIS.txt_4c_Cartao,  "LostFocus", THIS, "CartaoLostFocus")
1002:             BINDEVENT(THIS.txt_4c_Codigo,  "GotFocus",  THIS, "CodSegGotFocus")
1003:             BINDEVENT(THIS.txt_4c_Codigo,  "LostFocus", THIS, "CodSegLostFocus")
1004:         CATCH TO loc_oErro
1005:             MsgErro(loc_oErro.Message + CHR(13) + ;
1006:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1007:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.RegistrarEventosCampos")
1008:         ENDTRY
1009:     ENDPROC
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * ExibirMensagemTef - substitui o "DO Form SigTfDss With titulo, msg1,
1013:     * msg2, msg3, ..." do legado (dialogo de mensagem do Framework Fortyus;
1014:     * SIGTFDSS.SCX nao faz parte do acervo). MsgAviso segue o padrao do
1015:     * projeto para mensagem transitoria de protocolo, que nao e erro tecnico
1016:     * - e o mesmo helper ja adotado em Formsigprdft.ExibirMensagemTef e
1017:     * FormSIGPRTFH.ExibirMensagemTef.
1018:     *
1019:     * As quatro posicoes reproduzem a assinatura usada no dump, que varia:
1020:     *   DO Form SigTfDss With "","Quantidade de Digitos Invalida",""
1021:     *   DO Form SigTfDss With "","SEG Invalido",""
1022:     *   DO Form SigTfDss With "Erro",'Impossivel...','de Banco de Dados.'
1023:     *   DO Form SigTfDss With "Erro na Transacao","",Substr(Buffer,1,32), ;
1024:     *                         Substr(Buffer,33,32),"","VM",Left,Top
1025:     * ou seja titulo + ate tres linhas de mensagem - as duas chamadas desta
1026:     * fase sao as duas primeiras, e as de Buffer entram na Fase 7 reusando
1027:     * este mesmo helper. Linha vazia e descartada, nunca vira CHR(13) solto.
1028:     * Titulo VAZIO (os dois casos desta fase) usa THIS.Caption, que e o
1029:     * proprio titulo da tela, em vez de inventar texto que o legado nao tem.
1030:     *--------------------------------------------------------------------------
1031:     PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2, par_cMsg3)
1032:         LOCAL loc_cMsg, loc_cTitulo
1033: 
1034:         loc_cMsg = ""
1035: 
1036:         IF VARTYPE(par_cMsg1) = "C" AND !EMPTY(par_cMsg1)
1037:             loc_cMsg = ALLTRIM(par_cMsg1)
1038:         ENDIF
1039:         IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
1040:             loc_cMsg = loc_cMsg + IIF(EMPTY(loc_cMsg), "", CHR(13)) + ALLTRIM(par_cMsg2)
1041:         ENDIF
1042:         IF VARTYPE(par_cMsg3) = "C" AND !EMPTY(par_cMsg3)
1043:             loc_cMsg = loc_cMsg + IIF(EMPTY(loc_cMsg), "", CHR(13)) + ALLTRIM(par_cMsg3)
1044:         ENDIF
1045: 
1046:         loc_cTitulo = THIS.Caption
1047:         IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
1048:             loc_cTitulo = ALLTRIM(par_cTitulo)
1049:         ENDIF
1050: 
1051:         MsgAviso(loc_cMsg, loc_cTitulo)
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * FormParaBO - transporta os campos DIGITAVEIS da tela para o Business
1056:     * Object. Neste dialogo os campos editaveis NAO alimentam um registro de
1057:     * banco: alimentam o protocolo do terminal SiTef, e o BO e quem guarda
1058:     * esse estado (this_cSenhaSupervisor/this_cUltimosDigitos/
1059:     * this_cNumeroCartao/this_cCodSeguranca -> this_cBuffer -> DLL).
1060:     *
1061:     * O legado faz este transporte INLINE, quatro vezes, uma por LostFocus
1062:     * (SENHA/GetDigitos/GetCartao/GetCodSeg), sempre na forma
1063:     * "Buffer = Alltrim(This.Value) + Replicate(Chr(0), ...)". Centralizar
1064:     * aqui NAO cria uma segunda via: o caminho continua sendo um so
1065:     * (campo -> BO -> buffer -> DLL); o que deixa de existir sao as quatro
1066:     * copias da mesma expressao de padding.
1067:     *
1068:     * GUARDA DELIBERADA: campo em BRANCO nao sobrescreve a property. Cada
1069:     * LostFocus do legado comeca com "IF EMPTY(This.Value) / RETURN", ou
1070:     * seja, campo vazio nunca chega a alimentar o buffer - zerar a property
1071:     * aqui descartaria o valor que o passo ANTERIOR do protocolo ja deixou
1072:     * aceito (os campos vao sendo liberados um a um conforme o terminal
1073:     * pede, e os anteriores permanecem preenchidos na tela).
1074:     *
1075:     * PROTECTED EXPLICITO: FormBase declara este hook como PROTECTED e o
1076:     * VFP9 nao permite ALARGAR o escopo numa subclasse - omitir o
1077:     * modificador nao o tornaria publico, so esconderia o fato.
1078:     * Parametros: nenhum, para casar com a assinatura que FormBase.Salvar()
1079:     * usa ao chamar THIS.FormParaBO().
1080:     *--------------------------------------------------------------------------
1081:     PROTECTED PROCEDURE FormParaBO()
1082:         LOCAL loc_oBO, loc_lOk
1083: 
1084:         loc_lOk = .F.
1085: 
1086:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1087:             loc_oBO = THIS.this_oBusinessObject
1088: 
1089:             IF !EMPTY(THIS.txt_4c_SENHA.Value)
1090:                 loc_oBO.this_cSenhaSupervisor = ALLTRIM(THIS.txt_4c_SENHA.Value)
1091:             ENDIF
1092: 
1093:             IF !EMPTY(THIS.txt_4c_Digitos.Value)
1094:                 loc_oBO.this_cUltimosDigitos = ALLTRIM(THIS.txt_4c_Digitos.Value)
1095:             ENDIF
1096: 
1097:             IF !EMPTY(THIS.txt_4c_Cartao.Value)
1098:                 loc_oBO.this_cNumeroCartao = ALLTRIM(THIS.txt_4c_Cartao.Value)
1099:             ENDIF
1100: 
1101:             IF !EMPTY(THIS.txt_4c_Codigo.Value)
1102:                 loc_oBO.this_cCodSeguranca = ALLTRIM(THIS.txt_4c_Codigo.Value)
1103:             ENDIF
1104: 
1105:             *-- txt_4c_Valor NAO entra aqui de proposito: ele nasce
1106:             *-- Enabled = .F. e e so a EXIBICAO do valor que o chamador
1107:             *-- passou no Init. O valor da transacao continua tendo UM dono,
1108:             *-- a property THIS.this_nValorPago do form, que e o que
1109:             *-- RetornoFalha/MontaRetorno e o laco do protocolo leem (como no
1110:             *-- legado, onde lnValPago e PUBLIC do form). Copia-lo para o BO
1111:             *-- criaria um segundo dono do mesmo dado, que e exatamente o que
1112:             *-- esta regra existe para evitar.
1113:             loc_lOk = .T.
1114:         ENDIF
1115: 
1116:         RETURN loc_lOk
1117:     ENDPROC
1118: 
1119:     *--------------------------------------------------------------------------
1120:     * BOParaForm - caminho inverso: reflete na tela o que o BO resolveu.
1121:     * Transcricao do trecho do Init legado que roda DEPOIS de ler SigCdEmp e
1122:     * montar a identificacao do terminal:
1123:     *     GetValor.Value = Iif(plImpressora, Val(Strtran(lnValPago,",",".")), lnValPago)
1124:     *     IF pcCartao = "S"
1125:     *         Label5.Caption = "Digite a Validade"
1126:     *     Endif
1127:     *
1128:     * Chamado por CarregarDadosEmpresaSiTef() (onde estas duas atribuicoes
1129:     * estavam inline) e tambem pelos GotFocus que repoem a mascara do
1130:     * cartao, de modo que a tela tenha UM ponto de recarga a partir do BO.
1131:     *
1132:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara
1133:     * PROTECTED; chamada sempre por THIS., regra CLAUDE.md #8).
1134:     *--------------------------------------------------------------------------
1135:     PROTECTED PROCEDURE BOParaForm()
1136:         LOCAL loc_oBO, loc_lOk
1137: 
1138:         loc_lOk = .F.
1139: 
1140:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1141:             loc_oBO = THIS.this_oBusinessObject
1142: 
1143:             *-- Valor vem da property do FORM (dono unico - ver a nota em
1144:             *-- FormParaBO), reproduzindo a linha do Init legado tal e qual:
1145:             *--   GetValor.Value = Iif(plImpressora,
1146:             *--       Val(Strtran(lnValPago,",",".")), lnValPago)
1147:             THIS.txt_4c_Valor.Value = IIF(THIS.this_lImpressora, ;
1148:                 VAL(STRTRAN(TRANSFORM(THIS.this_nValorPago), ",", ".")), ;
1149:                 THIS.this_nValorPago)
1150: 
1151:             *-- "Digite a Validade" substitui "4 Ultimos Digitos :" quando o
1152:             *-- chamador pede a validade do cartao (pcCartao = "S").
1153:             IF THIS.this_cCartao = "S"
1154:                 THIS.lbl_4c_Label5.Caption = "Digite a Validade"
1155:             ENDIF
1156: 
1157:             *-- Os campos digitaveis voltam do BO para a tela. Property vazia
1158:             *-- NAO apaga o que esta digitado, pelo mesmo motivo da guarda de
1159:             *-- FormParaBO: o protocolo libera um campo por vez e os
1160:             *-- anteriores continuam visiveis.
1161:             IF !EMPTY(loc_oBO.this_cSenhaSupervisor)
1162:                 THIS.txt_4c_SENHA.Value = ALLTRIM(loc_oBO.this_cSenhaSupervisor)
1163:             ENDIF
1164: 
1165:             IF !EMPTY(loc_oBO.this_cUltimosDigitos)
1166:                 THIS.txt_4c_Digitos.Value = ALLTRIM(loc_oBO.this_cUltimosDigitos)
1167:             ENDIF
1168: 
1169:             IF !EMPTY(loc_oBO.this_cNumeroCartao)
1170:                 THIS.txt_4c_Cartao.Value = ALLTRIM(loc_oBO.this_cNumeroCartao)
1171:             ENDIF
1172: 
1173:             IF !EMPTY(loc_oBO.this_cCodSeguranca)
1174:                 THIS.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCodSeguranca)
1175:             ENDIF
1176: 
1177:             loc_lOk = .T.
1178:         ENDIF
1179: 
1180:         RETURN loc_lOk
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * ValidarDigitos - transcricao INTEIRA de SIGOPCTF.GetDigitos.Valid:
1185:     *
1186:     *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
1187:     *         DO Form SigTfDss With "","Quantidade de Digitos Invalida",""
1188:     *         This.Value = ""
1189:     *         Return(.f.)
1190:     *     ENDIF
1191:     *
1192:     * Devolve .F. SO nesse caso. Campo VAZIO devolve .T.: no legado o IF nao
1193:     * entra, o Valid termina sem Return e o VFP trata isso como aprovado -
1194:     * quem impede o protocolo de avancar com campo vazio e o
1195:     * "IF EMPTY(This.Value) / RETURN" que abre o LostFocus (Fase 7). NAO
1196:     * acrescentar obrigatoriedade, faixa nem mensagem que o legado nao tem.
1197:     *
1198:     * O "This.Value = """ do legado FICA. Nao e o clear proibido pela regra
1199:     * CLAUDE.md #50, que trata de LOOKUP com universo vazio: aqui e
1200:     * validacao de FORMATO, em que o legado limpa o campo de proposito para
1201:     * o usuario redigitar os 4 digitos (a mascara e "9999").
1202:     * PUBLIC: chamado pelo handler ligado por BINDEVENT.
1203:     *--------------------------------------------------------------------------
1204:     PROCEDURE ValidarDigitos()
1205:         LOCAL loc_lValido
1206:         loc_lValido = .T.
1207: 
1208:         IF LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)) != 4 AND ;
1209:            !EMPTY(THIS.txt_4c_Digitos.Value)
1210:             THIS.ExibirMensagemTef("", "Quantidade de Digitos Invalida", "", "")
1211:             THIS.txt_4c_Digitos.Value = ""
1212:             loc_lValido = .F.
1213:         ENDIF
1214: 
1215:         RETURN loc_lValido
1216:     ENDPROC
1217: 
1218:     *--------------------------------------------------------------------------
1219:     * ValidarCodSeg - transcricao INTEIRA de SIGOPCTF.GetCodSeg.Valid:
1220:     *
1221:     *     IF VAL(This.Value)>1 .and. VAL(This.Value)<100
1222:     *         DO Form SigTfDss With "","SEG Invalido",""
1223:     *         Return(.f.)
1224:     *     ELSE
1225:     *         Return(.t.)
1226:     *     Endif
1227:     *
1228:     * A faixa recusada e 2..99, com os operadores ESTRITOS do legado - e
1229:     * regra de negocio, transcrita literalmente (regra CLAUDE.md #17). Os
1230:     * dois labels fixos ao lado do campo explicam por que 0 e 1 PASSAM:
1231:     * lbl_4c_Label1 "0 - Inexist." e lbl_4c_Label3 "1 - Ilegivel" sao
1232:     * codigos de marcacao, e o codigo de seguranca de verdade tem 3 ou 4
1233:     * digitos (>= 100). NAO "corrigir" para >= 0 / <= 999 nem exigir
1234:     * preenchimento: campo vazio da VAL("") = 0, que o legado aprova.
1235:     *
1236:     * Diferente de ValidarDigitos, aqui o legado NAO limpa o campo quando
1237:     * recusa - nao acrescentar o clear.
1238:     * PUBLIC: chamado pelo handler ligado por BINDEVENT.
1239:     *--------------------------------------------------------------------------
1240:     PROCEDURE ValidarCodSeg()
1241:         LOCAL loc_lValido, loc_nCodSeg
1242:         loc_nCodSeg = VAL(THIS.txt_4c_Codigo.Value)
1243: 
1244:         IF loc_nCodSeg > 1 AND loc_nCodSeg < 100
1245:             THIS.ExibirMensagemTef("", "SEG Invalido", "", "")
1246:             loc_lValido = .F.
1247:         ELSE
1248:             loc_lValido = .T.
1249:         ENDIF
1250: 
1251:         RETURN loc_lValido
1252:     ENDPROC
1253: 
1254:     *--------------------------------------------------------------------------
1255:     * DigitosKeyPress - equivalente de SIGOPCTF.GetDigitos.Valid, disparado
1256:     * em ENTER(13)/TAB(9) porque BINDEVENT "Valid" nao e confiavel em
1257:     * TextBox (regra CLAUDE.md #3). Reproduz o Valid COMPLETO:
1258:     *   - reprovado  -> NODEFAULT (cancela a navegacao que o Enter/Tab ia
1259:     *                   fazer) + SetFocus, que juntos sao o "Return(.f.)"
1260:     *                   do legado: o campo nao e abandonado;
1261:     *   - aprovado   -> nada a fazer, o Enter/Tab segue normalmente, igual
1262:     *                   ao Valid do legado terminando sem Return.
1263:     * O avanco do protocolo SiTef NAO mora aqui: no legado ele esta no
1264:     * LostFocus deste mesmo campo, que e outro evento e ganha o proprio
1265:     * metodo na Fase 7.
1266:     * PUBLIC: exigido por BINDEVENT.
1267:     *--------------------------------------------------------------------------
1268:     PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1269:         IF VARTYPE(par_nKeyCode) != "N"
1270:             RETURN
1271:         ENDIF
1272:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1273:             RETURN
1274:         ENDIF
1275: 
1276:         IF !THIS.ValidarDigitos()
1277:             NODEFAULT
1278:             IF THIS.txt_4c_Digitos.Enabled AND THIS.txt_4c_Digitos.Visible
1279:                 THIS.txt_4c_Digitos.SetFocus()
1280:             ENDIF
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *--------------------------------------------------------------------------
1285:     * CodSegKeyPress - equivalente de SIGOPCTF.GetCodSeg.Valid, nos mesmos
1286:     * termos de DigitosKeyPress (ENTER/TAB + NODEFAULT/SetFocus no lugar do
1287:     * "Return(.f.)"). O "Return(.t.)" do ramo ELSE legado e o caminho em que
1288:     * nada se faz e a navegacao prossegue.
1289:     * PUBLIC: exigido por BINDEVENT.
1290:     *--------------------------------------------------------------------------
1291:     PROCEDURE CodSegKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1292:         IF VARTYPE(par_nKeyCode) != "N"
1293:             RETURN
1294:         ENDIF
1295:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1296:             RETURN
1297:         ENDIF
1298: 
1299:         IF !THIS.ValidarCodSeg()
1300:             NODEFAULT
1301:             IF THIS.txt_4c_Codigo.Enabled AND THIS.txt_4c_Codigo.Visible
1302:                 THIS.txt_4c_Codigo.SetFocus()
1303:             ENDIF
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *==========================================================================
1308:     * LACO INTERATIVO COM O TERMINAL SITEF (Fase 7/8)
1309:     *
1310:     * Migra os pares GotFocus/LostFocus de SENHA, GetDigitos, GetCartao e
1311:     * GetCodSeg (SigOpCtf_form_codigo_fonte.txt) e o Click do botao de saida
1312:     * (SAIDA.CANCELA) - a parte do dialogo que NAO entrou nas Fases 3/5/6
1313:     * porque dependia dos campos de dados ja estarem criados. Text2
1314:     * (Enabled=.F./TabStop=.F., vestigial - ver nota da Fase 6) continua
1315:     * sem GotFocus/LostFocus: nada no dump chama Text2.SetFocus(), o campo
1316:     * nunca recebe foco de verdade.
1317:     *
1318:     * Cada DO WHILE do dump chama ContinuaFuncaoSiTefInterativo em sequencia
1319:     * ate ProximoComando=30 (ou erro) - aqui, THIS.this_oBusinessObject.
1320:     * ContinuarSiTef(), que faz a mesma chamada por referencia e devolve o
1321:     * estado em this_nProximoComando/this_nTipoCampo/this_cBuffer (ver
1322:     * SigOpCtfBO.prg).
1323:     *
1324:     * Quatro variaveis PUBLIC do legado (congeladas no Init, nunca
1325:     * reatribuidas pelos handlers) ja existem como property do FORM:
1326:     *   lsTipo -> this_cTipoPgto   lcNsu -> this_cNsu
1327:     *   lcCartao -> this_cCartao  lnValPago -> this_nValorPago
1328:     * Duas NAO existiam e foram criadas no topo da classe:
1329:     *   ThisForm.pcCartao (property do FORM, reaproveitada pelos handlers
1330:     *     como os 5 primeiros digitos do cartao lido via TipoCampo=131 -
1331:     *     DIFERENTE de lcCartao/this_cCartao, que ficam congelados) ->

*-- Linhas 1358 a 1401:
1358:     * o passa explicitamente (BtnCancelaClick). Por isso aqui le-se direto
1359:     * da property, sem 2o parametro.
1360:     *--------------------------------------------------------------------------
1361:     PROCEDURE RetornoFalha(par_cMensagem)
1362:         LOCAL loc_cMensagem, loc_cValPago, loc_oErro
1363: 
1364:         loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
1365:         loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999999.99")), ".", ",")
1366: 
1367:         IF !DIRECTORY("C:\client\Resp", 1)
1368:             RETURN
1369:         ENDIF
1370: 
1371:         TRY
1372:             IF USED("crSiTef")
1373:                 USE IN crSiTef
1374:             ENDIF
1375:             CREATE CURSOR crSiTef (tef c(100))
1376: 
1377:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1378:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1379:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1380:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1381:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1382:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1383:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1384:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1385:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1386:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1387:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1388: 
1389:             SELECT crSiTef
1390:             COPY TO C:\client\Resp\IntPos.001 SDF
1391:             ZAP
1392: 
1393:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1394:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1395:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1396: 
1397:             COPY TO C:\client\Resp\IntPos.STS SDF
1398: 
1399:             USE IN crSiTef
1400:         CATCH TO loc_oErro
1401:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")

*-- Linhas 1411 a 1454:
1411:     * o proprio legado SOBRESCREVE lsValPago com Transform(lnValPago,...)
1412:     * logo na 1a linha do metodo, descartando o que foi passado.
1413:     *--------------------------------------------------------------------------
1414:     PROCEDURE MontaRetorno(par_cCupom, par_cNsu, par_cValPago)
1415:         LOCAL loc_cValPago, loc_cCupomRestante, loc_nPos, loc_nLinha, loc_oErro
1416: 
1417:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999999.99")), ".", ",")
1418: 
1419:         IF !DIRECTORY("C:\client\Resp", 1)
1420:             RETURN
1421:         ENDIF
1422: 
1423:         TRY
1424:             IF USED("crSiTef")
1425:                 USE IN crSiTef
1426:             ENDIF
1427:             CREATE CURSOR crSiTef (tef c(100))
1428: 
1429:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1430:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1431:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1432:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1433:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1434:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1435:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
1436:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
1437:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + IIF(VARTYPE(par_cNsu) = "C", par_cNsu, ""))
1438:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
1439:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
1440:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1441:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1442:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1443:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1444:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1445:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1446:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
1447:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1448:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1449:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
1450: 
1451:             loc_cCupomRestante = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
1452:             loc_nPos   = 1
1453:             loc_nLinha = 1
1454:             DO WHILE loc_nPos != 0

*-- Linhas 1482 a 1559:
1482:     *--------------------------------------------------------------------------
1483:     * BtnCancelaClick - migrado de SIGOPCTF.SAIDA.CANCELA.Click. Unica acao
1484:     * de saida do dialogo - cancela a transacao (Continua...(-1)) e grava a
1485:     * falha. PUBLIC: exigido por BINDEVENT.
1486:     *--------------------------------------------------------------------------
1487:     PROCEDURE BtnCancelaClick()
1488:         THIS.this_oBusinessObject.ContinuarSiTef(-1)
1489:         THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
1490:         THIS.Release()
1491:     ENDPROC
1492: 
1493:     *--------------------------------------------------------------------------
1494:     * SenhaGotFocus - PRIMEIRO campo habilitado do dialogo (TabIndex=2;
1495:     * txt_4c_Valor TabIndex=1 nasce Enabled=.F.) - dispara quando a tela
1496:     * abre. Reune DOIS blocos do legado:
1497:     *
1498:     * 1) O handshake com o terminal (SIGOPCTF.Init, blocos
1499:     *    ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo) -
1500:     *    deslocado de Init()/InicializarForm para aqui (POS-Show, dentro de
1501:     *    um evento) porque a falha desses dois blocos chama RetornoFalha +
1502:     *    RELEASE WINDOWS no legado, que equivale a THIS.Release() - chamar
1503:     *    Release() de DENTRO de Init/InicializarForm (ANTES do Show() do
1504:     *    chamador) destruiria o objeto antes do CREATEOBJECT devolver
1505:     *    (regra CLAUDE.md #29). Mesmo criterio do sibling Formsigprdft, que
1506:     *    defere ConectarSiTef/IniciarSiTef para DigitosGotFocus em vez de
1507:     *    rodar em InicializarForm. So dispara uma vez - nao ha flag
1508:     *    explicita porque SenhaLostFocus desabilita txt_4c_SENHA no fim
1509:     *    (This.Enabled=.f. no legado) e o campo nunca recupera o foco
1510:     *    depois disso.
1511:     *
1512:     * 2) SIGOPCTF.SENHA.GotFocus propriamente dito: muda a legenda de
1513:     *    status e drena o buffer do protocolo (que ja tem a mensagem
1514:     *    "Digite a Senha" enfileirada pelo IniciaFuncaoSiTefInterativo) ate
1515:     *    ProximoComando=30 (pronto para receber entrada do usuario).
1516:     *
1517:     * PUBLIC: exigido por BINDEVENT.
1518:     *--------------------------------------------------------------------------
1519:     PROCEDURE SenhaGotFocus()
1520:         LOCAL loc_oBO, loc_cValPago, loc_cData, loc_cHora, loc_nRetorno, loc_cMensagem, loc_oErro
1521: 
1522:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1523:            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1524:             RETURN
1525:         ENDIF
1526: 
1527:         loc_oBO = THIS.this_oBusinessObject
1528: 
1529:         TRY
1530:             IF !loc_oBO.ConectarSiTef()
1531:                 THIS.RetornoFalha("Sem comunicacao com SiTef")
1532:                 THIS.Release()
1533:                 RETURN
1534:             ENDIF
1535: 
1536:             loc_cData    = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
1537:             loc_cHora    = STRTRAN(TIME(), ":", "")
1538:             loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.txt_4c_Valor.Value, "99999999.99")), ".", ",")
1539: 
1540:             IF !loc_oBO.IniciarSiTef(loc_cValPago, loc_cData, loc_cHora)
1541:                 THIS.RetornoFalha("Sem comunicacao com SiTef")
1542:                 THIS.Release()
1543:                 RETURN
1544:             ENDIF
1545:         CATCH TO loc_oErro
1546:             *-- CliSiTef32I.DLL ausente nesta maquina (DeclararFuncoesSiTef
1547:             *-- nao conseguiu declarar as funcoes) - mesma falha de
1548:             *-- comunicacao que o legado reportaria.
1549:             THIS.RetornoFalha("Sem comunicacao com SiTef")
1550:             THIS.Release()
1551:             RETURN
1552:         ENDTRY
1553: 
1554:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
1555: 
1556:         loc_oBO.this_nProximoComando = 0
1557:         loc_oBO.this_nTipoCampo      = 0
1558:         loc_oBO.this_nTamanhoMinimo  = 0
1559:         loc_oBO.this_nTamanhoMaximo  = 0

*-- Linhas 1582 a 1627:
1582:     * debito/credito/parcelado) e o tipo de cartao (THIS.this_cCartao -
1583:     * com/sem cartao presente), e decide se o proximo campo a habilitar e
1584:     * txt_4c_Digitos (4 ultimos digitos) ou txt_4c_Cartao (numero completo).
1585:     * PUBLIC: exigido por BINDEVENT.
1586:     *--------------------------------------------------------------------------
1587:     PROCEDURE SenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1588:         LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem
1589: 
1590:         IF EMPTY(THIS.txt_4c_SENHA.Value)
1591:             RETURN
1592:         ENDIF
1593: 
1594:         loc_oBO = THIS.this_oBusinessObject
1595: 
1596:         *-- Legado: Buffer = Alltrim(this.Value)
1597:         *--     + Replicate(Chr(0), 2000 - Len(Alltrim(this.Value)))
1598:         THIS.FormParaBO()
1599:         loc_oBO.MontarBufferSiTef(loc_oBO.this_cSenhaSupervisor)
1600: 
1601:         loc_nTipo     = 1
1602:         loc_nRetorno  = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1603:         loc_cMensagem = loc_oBO.this_cBuffer
1604:         loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
1605:         loc_oBO.this_nContinua = 0
1606: 
1607:         DO WHILE loc_oBO.this_nProximoComando != 30 OR THIS.this_cTipoPgto = "D"
1608:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1609: 
1610:             IF LASTKEY() = 27
1611:                 loc_oBO.ContinuarSiTef(-1)
1612:                 THIS.RetornoFalha("Operacao Cancelada pelo Operador")
1613:                 THIS.Release()
1614:                 RETURN
1615:             ENDIF
1616: 
1617:             IF loc_nRetorno = 0
1618:                 EXIT
1619:             ENDIF
1620:             IF loc_nRetorno < 0
1621:                 THIS.RetornoFalha(loc_cMensagem)
1622:                 THIS.Release()
1623:                 RETURN
1624:             ENDIF
1625: 
1626:             IF loc_oBO.this_nProximoComando = 22
1627:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;

*-- Linhas 1733 a 1778:
1733:     * DigitosGotFocus - migrado de SIGOPCTF.GetDigitos.GotFocus. So age
1734:     * quando TipoCampo ja esta em 515 ao focar o campo (pedido de data
1735:     * vindo do protocolo) - fora desse caso o legado nao faz nada aqui (o
1736:     * If TipoCampo = 515 envolve o metodo INTEIRO). PUBLIC: BINDEVENT.
1737:     *--------------------------------------------------------------------------
1738:     PROCEDURE DigitosGotFocus()
1739:         LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem
1740: 
1741:         loc_oBO = THIS.this_oBusinessObject
1742:         IF loc_oBO.this_nTipoCampo != 515
1743:             RETURN
1744:         ENDIF
1745: 
1746:         loc_nTipo = 1
1747:         loc_cMensagem = ""
1748:         loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
1749:         loc_oBO.this_nContinua = 1000
1750:         loc_nRetorno = 10000
1751: 
1752:         DO WHILE loc_nRetorno = 10000
1753:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1754:             IF loc_nRetorno = 0
1755:                 EXIT
1756:             ENDIF
1757:             IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
1758:                 THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
1759:                     ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
1760:                 EXIT
1761:             ENDIF
1762:             IF loc_oBO.this_nProximoComando = 22
1763:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1764:                     ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
1765:                 loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1766:                 THIS.Release()
1767:                 RETURN
1768:             ENDIF
1769:             IF loc_oBO.this_nProximoComando = 20
1770:                 loc_oBO.this_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
1771:                 loc_oBO.this_nContinua = 1000
1772:                 LOOP
1773:             ENDIF
1774:             IF loc_oBO.this_nProximoComando = 30
1775:                 IF loc_nTipo = 1
1776:                     IF THIS.this_cCartaoBin = "00125"
1777:                         loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999"))
1778:                     ELSE

*-- Linhas 1822 a 1882:
1822:     *--------------------------------------------------------------------------
1823:     * DigitosLostFocus - migrado de SIGOPCTF.GetDigitos.LostFocus. Valida
1824:     * (ja feito em ValidarDigitos/DigitosKeyPress - regra CLAUDE.md #3,
1825:     * BINDEVENT "Valid" nao eh confiavel em TextBox) e, com 4 digitos,
1826:     * envia ao protocolo e drena a resposta. PUBLIC: BINDEVENT.
1827:     *--------------------------------------------------------------------------
1828:     PROCEDURE DigitosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1829:         LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem, loc_cData
1830: 
1831:         IF EMPTY(THIS.txt_4c_Digitos.Value)
1832:             RETURN
1833:         ENDIF
1834: 
1835:         loc_oBO = THIS.this_oBusinessObject
1836:         loc_nRetorno  = 10000
1837:         loc_cMensagem = ""
1838:         loc_nTipo     = 1
1839:         *-- Legado: Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 1996)
1840:         *-- (complemento LITERAL - ver MontarBufferSiTef no BO)
1841:         THIS.FormParaBO()
1842:         loc_oBO.MontarBufferSiTef(loc_oBO.this_cUltimosDigitos, 1996)
1843: 
1844:         DO WHILE loc_nRetorno = 10000
1845:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1846:             IF loc_nRetorno = 0
1847:                 EXIT
1848:             ENDIF
1849:             IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
1850:                 THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
1851:                     ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
1852:                 EXIT
1853:             ENDIF
1854:             IF loc_oBO.this_nTipoCampo = 514
1855:                 THIS.txt_4c_Digitos.Enabled = .F.
1856:                 THIS.txt_4c_Codigo.Enabled  = .T.
1857:                 EXIT
1858:             ENDIF
1859:             IF loc_oBO.this_nTipoCampo = 515
1860:                 loc_cData = LEFT(DTOC(DATE()), 2) + SUBSTR(DTOC(DATE()), 4, 2) + RIGHT(DTOC(DATE()), 4)
1861:                 loc_oBO.this_cBuffer = loc_cData + REPLICATE(CHR(0), 1992)
1862:                 loc_nTipo = 2
1863:                 LOOP
1864:             ENDIF
1865:             IF loc_oBO.this_nProximoComando = 22
1866:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1867:                     ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
1868:                 loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1869:                 THIS.Release()
1870:                 RETURN
1871:             ENDIF
1872:             IF loc_oBO.this_nProximoComando = 30
1873:                 IF loc_nTipo = 1
1874:                     loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
1875:                     loc_oBO.this_nContinua = 1000
1876:                     loc_nTipo = 2
1877:                     LOOP
1878:                 ENDIF
1879:                 IF loc_nTipo = 2
1880:                     IF THIS.this_cCartaoBin = "00125"
1881:                         loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999"))
1882:                     ELSE

*-- Linhas 1925 a 1970:
1925:     * (this_cTipoPgto) com "D" nos DOIS ramos (nunca compara com "C") -
1926:     * aparenta ser erro do legado, mas regra CLAUDE.md #17 manda
1927:     * TRANSCREVER a formula tal como esta, nao corrigir o que parece bug.
1928:     * PUBLIC: BINDEVENT.
1929:     *--------------------------------------------------------------------------
1930:     PROCEDURE CartaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1931:         LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem
1932: 
1933:         IF EMPTY(THIS.txt_4c_Cartao.Value)
1934:             RETURN
1935:         ENDIF
1936: 
1937:         loc_oBO = THIS.this_oBusinessObject
1938: 
1939:         *-- Legado: Buffer = ALLTRIM(This.Value)
1940:         *--     + REPLICATE(CHR(0), 2000-LEN(ALLTRIM(This.Value)))
1941:         THIS.FormParaBO()
1942:         loc_oBO.MontarBufferSiTef(loc_oBO.this_cNumeroCartao)
1943: 
1944:         loc_nTipo     = 1
1945:         loc_nRetorno  = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1946:         loc_cMensagem = loc_oBO.this_cBuffer
1947:         loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
1948:         loc_oBO.this_nContinua = 0
1949: 
1950:         DO WHILE loc_oBO.this_nProximoComando != 30
1951:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1952: 
1953:             IF LASTKEY() = 27
1954:                 loc_oBO.ContinuarSiTef(-1)
1955:                 THIS.RetornoFalha("Operacao Cancelada pelo Operador")
1956:                 THIS.Release()
1957:                 RETURN
1958:             ENDIF
1959:             IF loc_nRetorno < 0
1960:                 THIS.RetornoFalha(loc_cMensagem)
1961:                 THIS.Release()
1962:                 RETURN
1963:             ENDIF
1964:             IF loc_oBO.this_nTipoCampo = 131
1965:                 THIS.this_cCartaoBin = loc_oBO.this_cBuffer
1966:             ENDIF
1967:             IF loc_oBO.this_nProximoComando = 22
1968:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1969:                     ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
1970:                 loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

*-- Linhas 2008 a 2064:
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * CodSegGotFocus - migrado de SIGOPCTF.GetCodSeg.GotFocus. PUBLIC:
2011:     * BINDEVENT.
2012:     *--------------------------------------------------------------------------
2013:     PROCEDURE CodSegGotFocus()
2014:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Codigo" + CHR(13) + "de Seguranca"
2015:     ENDPROC
2016: 
2017:     *--------------------------------------------------------------------------
2018:     * CodSegLostFocus - migrado de SIGOPCTF.GetCodSeg.LostFocus. Ultimo
2019:     * campo do fluxo - o RELEASE WINDOWS final do legado NAO esta dentro de
2020:     * IF nenhum: a tela SEMPRE fecha depois do codigo de seguranca ser
2021:     * processado, sucesso ou falha (ja validado em ValidarCodSeg/
2022:     * CodSegKeyPress - regra CLAUDE.md #3). PUBLIC: BINDEVENT.
2023:     *--------------------------------------------------------------------------
2024:     PROCEDURE CodSegLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2025:         LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem
2026: 
2027:         IF EMPTY(THIS.txt_4c_Codigo.Value)
2028:             RETURN
2029:         ENDIF
2030: 
2031:         loc_oBO = THIS.this_oBusinessObject
2032:         loc_nTipo     = 1
2033:         loc_cMensagem = ""
2034:         *-- Legado: Buffer = Alltrim(This.Value)
2035:         *--     + REPLICATE(CHR(0), 2000-LEN(Alltrim(This.Value)))
2036:         THIS.FormParaBO()
2037:         loc_oBO.MontarBufferSiTef(loc_oBO.this_cCodSeguranca)
2038:         loc_oBO.this_nContinua = 1000
2039:         loc_nRetorno = 10000
2040: 
2041:         DO WHILE loc_nRetorno = 10000
2042:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2043:             IF loc_nRetorno = 0
2044:                 EXIT
2045:             ENDIF
2046:             IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
2047:                 THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
2048:                     ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
2049:                 EXIT
2050:             ENDIF
2051:             IF loc_oBO.this_nProximoComando = 22
2052:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
2053:                     ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
2054:                 loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2055:                 THIS.Release()
2056:                 RETURN
2057:             ENDIF
2058:             IF loc_oBO.this_nProximoComando = 30
2059:                 IF loc_nTipo = 1
2060:                     loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
2061:                     loc_oBO.this_nContinua = 1000
2062:                     loc_nTipo = 2
2063:                     LOOP
2064:                 ENDIF

*-- Linhas 2100 a 2137:
2100:     ENDPROC
2101: 
2102:     *--------------------------------------------------------------------------
2103:     * TornarControlesVisiveis - Torna todos os controles visiveis
2104:     * recursivamente (AddObject cria com Visible=.F. por padrao). Nao ha
2105:     * container flutuante nesta tela (nenhum Visible=.F. intencional no
2106:     * dump), entao nao ha excecao a filtrar.
2107:     *--------------------------------------------------------------------------
2108:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2109:         LOCAL loc_nI, loc_oObjeto
2110: 
2111:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2112:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2113: 
2114:             IF VARTYPE(loc_oObjeto) = "O"
2115:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2116:                     loc_oObjeto.Visible = .T.
2117:                 ENDIF
2118: 
2119:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2120:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2121:                 ENDIF
2122:             ENDIF
2123:         ENDFOR
2124:     ENDPROC
2125: 
2126:     *--------------------------------------------------------------------------
2127:     * Destroy - Delega a FormBase.Destroy() (libera this_oBusinessObject e
2128:     * restaura o menu). Nenhum cursor local eh aberto nesta fase - cursores
2129:     * de laco interativo com o terminal SiTef entram na Fase 7 e, se algum
2130:     * sobreviver ao fechamento, o fechamento proprio deles ganha tratamento
2131:     * aqui naquela fase.
2132:     *--------------------------------------------------------------------------
2133:     PROCEDURE Destroy()
2134:         DODEFAULT()
2135:     ENDPROC
2136: 
2137: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCtfBO.prg):
*============================================================================
* SigOpCtfBO.prg - Business Object para Cancelamento de SiTef
*
* Tabela de referencia : SigCdEmp (PK: cemps char(3))
* Form OPERACIONAL     : FormSigOpCtf - cancelamento de transacao TEF
*                        (comunicacao com CliSiTef32I.DLL via protocolo
*                        interativo SiTef; formatos IntPos.001/IntPos.STS)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpCtfBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdEmp (dados da empresa usados na integracao
    * com o SiTef - endereco do terminal e identificacao da empresa)
    *==========================================================================
    this_cCodEmpresa      = ""    && char(3)  - SigCdEmp.cemps (PK)
    this_nCodEmpresaNum   = 0     && numeric(3,0) - SigCdEmp.nemps
    this_cRazaoSocial     = ""    && char(40) - SigCdEmp.razas
    this_cCodEmpresaSiTef = ""    && char(3)  - SigCdEmp.cempsitefs

    *==========================================================================
    * Propriedades da transacao de cancelamento (parametros recebidos pelo
    * form na abertura - par_cEndSiTef/par_cIdTerminal/... do Init legado)
    *==========================================================================
    this_cEndSiTef   = ""    && Endereco do servidor SiTef
    this_cIdTerminal = ""    && Codigo do estabelecimento/terminal
    this_nValorPago  = 0     && Valor da transacao a cancelar
    this_cTipoPgto   = ""    && "D"=Debito, "C"=Credito
    this_dDataTrans  = {}    && Data da transacao original
    this_cNsu        = ""    && NSU da transacao original
    this_cCartao     = ""    && "S" = exige digitacao da validade do cartao
    this_lImpressora = .F.   && .T. quando o caixa possui impressora fiscal
    this_cCodEstabs  = ""    && Codigo alternativo do estabelecimento (PDV)
    this_lCancelado  = .T.   && Espelha llCancel do legado (.T. = nao cancelado)

    *==========================================================================
    * Mensagem de retorno do protocolo SiTef (ultima falha reportada)
    *==========================================================================
    this_cMensagemSiTef = ""

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer          = SPACE(2000)
    this_nContinua        = 0

    *==========================================================================
    * Identificacao do terminal SiTef (migrado do bloco de Init legado que
    * monta lsIdTerminal/lcIdTerminal a partir de SigCdEmp/SigFiMpF).
    *   this_cLojaSiTef          <- lsIdTerminal (2o arg de
    *                               ConfiguraIntSiTefInterativo - "lsLoja")
    *   this_cIdTerminalCompleto <- lcIdTerminal (3o arg - "lsTerminal")
    *   this_cCaixaSiTef         <- crSigFiMpF.Cncaixas (ver CarregarCaixaSiTef)
    *==========================================================================
    this_cLojaSiTef          = ""
    this_cIdTerminalCompleto = ""
    this_cCaixaSiTef         = ""

    *==========================================================================
    * Campos DIGITAVEIS do dialogo, transportados por
    * FormSigOpCtf.FormParaBO() / devolvidos por BOParaForm().
    *
    * O legado le This.Value DENTRO de cada LostFocus e monta o buffer ali
    * mesmo, repetindo a expressao quatro vezes:
    *     SENHA.LostFocus      Buffer = Alltrim(this.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(this.Value)))
    *     GetDigitos.LostFocus Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 1996)
    *     GetCartao.LostFocus  Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 2000-LEN(ALLTRIM(This.Value)))
    *     GetCodSeg.LostFocus  Buffer = Alltrim(This.Value) + REPLICATE(CHR(0), 2000-LEN(Alltrim(This.Value)))
    *
    * Guardar o valor digitado aqui NAO acrescenta uma 2a via de transporte:
    * ele continua tendo UM caminho (campo -> BO -> this_cBuffer -> DLL), com
    * a diferenca de que a montagem do buffer passa a existir num lugar so
    * (MontarBufferSiTef) em vez de quatro copias da mesma expressao.
    *==========================================================================
    this_cSenhaSupervisor = ""   && SENHA.Value      - senha do supervisor
    this_cUltimosDigitos  = ""   && GetDigitos.Value - 4 ultimos digitos / validade
    this_cNumeroCartao    = ""   && GetCartao.Value  - numero do cartao
    this_cCodSeguranca    = ""   && GetCodSeg.Value  - codigo de seguranca

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 3 funcoes do protocolo interativo
    * (migrado de SIGOPCTF.Load - este form NAO declara
    * FinalizaTransacaoSiTefInterativo, ao contrario de SIGPRDFT/SIGPRTFH:
    * cancelamento nunca finaliza uma venda, so desfaz). Redeclarar a mesma
    * assinatura eh inofensivo em VFP9; a falha real (DLL ausente) so
    * aparece quando a funcao eh CHAMADA, nao na declaracao - por isso o TRY
    * aqui eh so para nao derrubar InicializarForm em maquina sem o
    * CliSiTef32I.DLL (mesmo criterio de sigprdftBO.DeclararFuncoesSiTef).
    *==========================================================================
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
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef) - a chamada real avisa o usuario via ConectarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCaixaSiTef - Migrado do trecho do Init legado que le
    * crSigFiMpF.Cncaixas (cursor global do Framework, nunca populado em
    * nenhum ponto do dump deste form - mesma categoria de dependencia
    * ausente tratada em sigprdftBO.CarregarParametrosOperacao). Em vez de
    * depender de cursor global nao documentado, consulta SIGFIMPF pela
    * empresa corrente com o MESMO fallback "melhor esforco" do sibling:
    * sem registro, this_cCaixaSiTef fica "000000" (igual ao TRANSFORM(VAL(
    * ""),"@L 999999") que o legado produziria com o cursor vazio).
    *==========================================================================
    FUNCTION CarregarCaixaSiTef()
        LOCAL loc_oErro

        THIS.this_cCaixaSiTef = "000000"

        TRY
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF

            SQLEXEC(gnConnHandle, ;
                "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaSiTef = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com o fallback "000000" acima -
            *-- mesmo desfecho pratico do legado quando crSigFiMpF esta vazio.
        ENDTRY

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * MontarIdentificacaoTerminal - Migrado de SIGOPCTF.Init:
    *     If Empty(pcCodEstabs)
    *         lsIdTerminal="00000"+_Empr
    *     Else
    *         lsIdTerminal=pcCodEstabs
    *     EndIf
    *     lcIdTerminal=fConverteStr(CrSigCdEmp.nEmps)+TRANSFORM(VAL(
    *         crSigFiMpF.Cncaixas),"@L 999999")
    *
    * _Empr e o global LEGACY -> go_4c_Sistema.cCodEmpresa (CLAUDE.md:
    * "_EMPR: NEVER use"). nEmps vem de CarregarPorCodigo (this_nCodEmpresaNum);
    * Cncaixas ja foi resolvido e formatado em CarregarCaixaSiTef
    * (this_cCaixaSiTef), entao aqui so concatena - sem repetir o TRANSFORM.
    *==========================================================================
    PROCEDURE MontarIdentificacaoTerminal(par_cCodEstabs)
        IF VARTYPE(par_cCodEstabs) = "C" AND !EMPTY(par_cCodEstabs)
            THIS.this_cLojaSiTef = par_cCodEstabs
        ELSE
            THIS.this_cLojaSiTef = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        THIS.this_cIdTerminalCompleto = fConvertestr(THIS.this_nCodEmpresaNum) + THIS.this_cCaixaSiTef
    ENDPROC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPCTF.Init:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
    * Retorna .T. se a comunicacao com o servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cLojaSiTef, THIS.this_cIdTerminalCompleto, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPCTF.Init:
    *     IF IniciaFuncaoSiTefInterativo(200, lcValPago, "1", lcData, lcHora,
    *         TRANSFORM(VAL(IdTerminal),"@L 999"), "") <> 10000
    *
    * Modalidade (200) e Cupom ("1") sao LITERAIS no legado - nao existe
    * property de cupom em SIGOPCTF (diferente de SIGPRDFT/SIGPRTFH), por
    * isso ficam fixos aqui, nao parametrizados. IdTerminal (6o argumento,
    * "lsOperador") e o PARAMETRO CRU recebido no Init do form (par_cIdTerminal
    * -> this_cIdTerminal), NAO o lsIdTerminal/lcIdTerminal computados acima -
    * dois campos homonimos no legado com fontes diferentes, transcritos tal
    * como estao.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cValor, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(200, par_cValor, "1", par_cData, ;
            par_cHora, TRANSFORM(VAL(THIS.this_cIdTerminal), "@L 999"), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (SENHA/GetDigitos/GetCartao/GetCodSeg GotFocus/
    * LostFocus, SAIDA.CANCELA.Click). Centraliza a chamada por referencia
    * (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) - mesmo criterio de
    * sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera.
    *
    * Transcrito do legado, que repete a MESMA expressao em cada LostFocus
    * (ver o bloco de properties this_cSenhaSupervisor..this_cCodSeguranca).
    * par_nComplemento existe para preservar a segunda forma, LITERAL, do
    * GetDigitos.LostFocus - "REPLICATE(CHR(0), 1996)" - em vez de recalcular
    * 2000 - LEN(): 1996 = 2000 - 4 porque GetDigitos.Valid so aceita 4
    * caracteres, entao as duas formas coincidem no caminho normal, mas
    * transcrever a do legado evita divergir se o campo chegar com outro
    * tamanho (regra CLAUDE.md #17 - transcrever, nunca reescrever).
    * Omitido, usa 2000 - LEN(ALLTRIM(valor)), como nos outros tres campos.
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

        IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
            loc_nComplemento = par_nComplemento
        ELSE
            loc_nComplemento = 2000 - LEN(loc_cValor)
        ENDIF

        IF loc_nComplemento < 0
            loc_nComplemento = 0
        ENDIF

        THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

        RETURN THIS.this_cBuffer
    ENDFUNC

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE LEITURA (SigCdEmp)
    *
    * O dump do legado (tasks\task716\SigOpCtf_form_codigo_fonte.txt) faz UMA
    * UNICA operacao de banco, dentro do Init:
    *
    *     .poDatamgr = CreateObject('fSqlConector', ThisForm.Name)
    *     .AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    *         [Select * From SigCdEmp Where cEmps = ?_Empr])
    *     .Requery('crSigCdEmp')
    *     lsEmp = fConverteStr(CrSigCdEmp.nEmps)
    *
    * Um SELECT, usado so para obter o numero da empresa (nEmps) e montar o
    * IdTerminal exigido pelo protocolo SiTef (ConfiguraIntSiTefInterativo).
    * Em NENHUM metodo do dump - Init, Load, Unload, MontaRetorno,
    * RetornoFalha, nem nos handlers de GetValor/Text2/GetDigitos/SENHA/
    * GetCartao/GetCodSeg - ha INSERT, UPDATE, DELETE ou TABLEUPDATE sobre
    * SigCdEmp. A tela cancela uma transacao de cartao via DLL
    * (CliSiTef32I.DLL) e grava arquivos LOCAIS (C:\client\Resp\IntPos.001 e
    * IntPos.STS), nunca grava no banco de dados.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma lista de colunas de gravacao que o legado
    *     nunca grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar, e forcar uma linha em LogAuditoria aqui
    *     registraria uma gravacao que nunca aconteceu;
    *   - CarregarPorCodigo() e CarregarDoCursor() SAO implementados abaixo,
    *     porque reproduzem fielmente a UNICA leitura que o legado faz.
    *==========================================================================

    *==========================================================================
    * CarregarPorCodigo - Carrega os dados da empresa (SigCdEmp) usados na
    * montagem do protocolo SiTef, pelo codigo informado (cemps).
    *
    * Legado (Init): AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,
    * [Select * From SigCdEmp Where cEmps = ?_Empr]) + Requery('crSigCdEmp').
    *
    * par_cCodEmpresa: codigo da empresa (SigCdEmp.cemps). Quando omitido ou
    * vazio, usa go_4c_Sistema.cCodEmpresa - equivalente ao _Empr do legado
    * (CLAUDE.md: "_EMPR: LEGACY - NEVER use -> go_4c_Sistema.cCodEmpresa").
    *
    * Retorno: .T. se encontrou e carregou o registro, .F. caso contrario
    * (this_cMensagemErro fica preenchido com o motivo).
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodEmpresa)
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCodEmpresa) = "C" AND !EMPTY(ALLTRIM(par_cCodEmpresa))
                loc_cCodigo = ALLTRIM(par_cCodEmpresa)
            ELSE
                loc_cCodigo = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            IF EMPTY(loc_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "SELECT cemps, nemps, razas, cempsitefs" + ;
                           " FROM SigCdEmp" + ;
                           " WHERE cemps = " + EscaparSQL(loc_cCodigo)

                IF USED("cursor_4c_Empresa")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Empresa") > 1
                        TABLEREVERT(.T., "cursor_4c_Empresa")
                    ENDIF
                    USE IN cursor_4c_Empresa
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Empresa") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Empresa")
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + loc_cCodigo + " n" + CHR(227) + ;
                        "o encontrada em SigCdEmp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em SigOpCtfBO.CarregarPorCodigo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula this_cCodEmpresa/this_nCodEmpresaNum/
    * this_cRazaoSocial/this_cCodEmpresaSiTef a partir do cursor aberto por
    * CarregarPorCodigo.
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos - NUNCA
    * "campo" (FORMCOR_LICOES_APRENDIDAS.md, Problema 9: essa
    * sintaxe nao existe em VFP9 e estoura "Function name is missing )").
    *
    * PROTECTED: so eh usado internamente por CarregarPorCodigo. O ponto de
    * entrada PUBLIC para o Form eh CarregarPorCodigo (regra #51 do
    * CLAUDE.md - metodo chamado de fora nunca pode ser PROTECTED).
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodEmpresa      = TratarNulo(cemps, "")
            THIS.this_nCodEmpresaNum   = TratarNulo(nemps, 0)
            THIS.this_cRazaoSocial     = TratarNulo(razas, "")
            THIS.this_cCodEmpresaSiTef = TratarNulo(cempsitefs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave da entidade de referencia (SigCdEmp.cemps),
    * usada so se algum dia RegistrarAuditoria() for acionado por uma
    * subclasse futura. PROTECTED: nunca chamado de fora (regra #51).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodEmpresa
    ENDFUNC

ENDDEFINE


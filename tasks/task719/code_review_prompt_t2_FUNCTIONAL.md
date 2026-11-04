# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [METODO-INEXISTENTE] Metodo 'THIS.AcessoGradeCota()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValorNumerico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPercentualDescontoExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CotaEstourada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescontoEntraNaCota()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarValorDescontoExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Cota define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Cota.RecordSource).
- [GRID-HEADER] Header Caption 'Descriçã' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrição do Desconto, % Desconto, Valor Desconto, Empresa, Cota, Utilizada. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2757 linhas total):

*-- Linhas 31 a 168:
31: *   Init(<20 parametros de contexto>)     equivalente ao pCnx/pForm legado,
32: *                                          mas com o contexto INTEIRO (o
33: *                                          legado lia dos cursores globais)
34: *   InicializarForm                       BO + Picture + superficie visual
35: *   ConfigurarPageFrame                   orquestrador da montagem
36: *   ConfigurarCabecalho                   cntSombra + lblSombra/lblTitulo
37: *   TornarControlesVisiveis               AddObject nasce com Visible = .F.
38: *
39: * A Fase 4 acrescentou, dentro dessa casca:
40: *
41: *   ConfigurarBotoes      cmg_4c_Botoes (cntBotoes) - Confirmar/Cancelar
42: *   ConfigurarGradeCota   grd_4c_Cota (GrdCota) - cota da empresa, 3
43: *                         colunas somente-leitura, exibida so com acesso
44: *                         GERENTE (AcessoGradeCota)
45: *   ConfigurarGrade       grd_4c_Dados (Grade) - a grade principal de
46: *                         descontos, 4 colunas: checkbox de selecao /
47: *                         descricao / % desconto / valor desconto
48: *   CarregarLista         carga das DUAS grades, delegando ao BO
49: *                         (SigOpDesBO.CarregarCota e .CarregarDescontos,
50: *                         que reproduzem o pipeline de cursores do Init
51: *                         legado: crDesc, crTipo, localDes e crSigCdDes)
52: *   MontaGrade            funil UNICO de repintura (Go Top + Refresh),
53: *                         com VincularGrade/VincularGradeCota para o
54: *                         rebind quando o RecordSource se perde
55: *
56: * A Fase 5 entregou a primeira metade dos totais (Say2/lnValor e
57: * Say4/lnTDesc).
58: *
59: * ESCOPO DA FASE 6/8 - CAMPOS RESTANTES E CELULAS DIGITAVEIS
60: * ----------------------------------------------------------
61: *   ConfigurarTotais        completado com Say1/lnSaldo, o terceiro par
62: *                           de total (o unico que faltava do dump)
63: *   InstalarCelulasGrade    as tres celulas da grade principal passam a
64: *                           ser subclasses de TextBox com o When/Valid
65: *                           do legado EMBUTIDO (regra CLAUDE.md #46), em
66: *                           Column2/3/4 via CurrentControl
67: *   ValidarPercentualDesconto / ValidarValorDesconto
68: *                           os dois PROCEDURE Valid do legado
69: *                           (Grade.Column3.Text1 e Grade.Column4.Text1),
70: *                           transcritos regra a regra
71: *   CalcularTotais          o PROCEDURE calctots do legado - motor de
72: *                           totais que os dois Valid acionam e de quem
73: *                           eles leem o Saldo para o teste final
74: *   GradeAfterRowColChange  a navegacao da coluna de descricao para a
75: *                           coluna editavel do tipo de desconto
76: *
77: * NAO HA LOOKUP NESTA TELA, e isso foi medido, nao presumido: o dump
78: * SigOpDes_form_codigo_fonte.txt nao casa nenhum dos padroes de busca do
79: * legado - zero "fwbusca" (que cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
80: * zero "mAddColuna", zero "sigacess(" e zero "Acesso<X>(". A tela recebe
81: * a lista de descontos elegiveis JA resolvida pelo pipeline de
82: * elegibilidade do BO; o usuario nao digita codigo de tabela nenhuma -
83: * ele marca linhas e edita percentual/valor. Criar aqui um
84: * AbrirLookup*/AbrirBusca* significaria consultar uma tabela que o
85: * legado nunca consulta (viola o PILAR 1 e a regra "NUNCA inventar
86: * tabelas de lookup").
87: *
88: * O que ESTA fase cobre no lugar do lookup e' o par When/Valid dos
89: * campos DIGITAVEIS, que e' a outra metade do contrato da fase: a grade
90: * tem duas celulas que aceitam digitacao (% Desconto e Valor Desconto) e
91: * uma que o legado bloqueia por When (Descricao).
92: *
93: * ESCOPO DA FASE 7/8 - EVENTOS PRINCIPAIS
94: * ----------------------------------------
95: *   BtnCancelarClick / BtnConfirmarClick
96: *                           cmg_4c_Botoes.Buttons(1)/Buttons(2) (btnSair/
97: *                           btnConfirmar do legado). Sair so libera o
98: *                           dialogo; Confirmar remove os descontos
99: *                           anteriores do item e regrava em SigMvItd uma
100: *                           linha por tipo marcado (ConfirmarSelecaoExec +
101: *                           SigOpDesBO.ExcluirDescontosDoItem/Inserir)
102: *   ChkSelecaoClick/MouseDown/MouseUp/KeyPress + ChkSelecaoToggle(Exec)
103: *                           os 4 handlers do checkbox de selecao de cada
104: *                           linha (fwcheckbox1 do legado), com a
105: *                           autorizacao de gerente/supervisor/diretoria via
106: *                           DO FORM SigOpSen (FAIL-CLOSED - ver
107: *                           feedback_sigopsen_ausente_gate_autorizacao)
108: *   Header1Click            Grade.Column1.Header1.Click - selecionar/
109: *                           desmarcar TODAS as linhas de uma vez
110: *
111: * Os tres acionam CalcularTotais (Fase 6/8).
112: *
113: * ESCOPO DA FASE 8/8 - CONSOLIDACAO FINAL
114: * ----------------------------------------
115: *   FormParaBO              FONTE UNICA tela -> BO: o contexto do
116: *                           movimento/item/produto (que o Init recebeu por
117: *                           parametro) e os TRES totais lidos dos TextBox.
118: *                           Chamado por InicializarForm, CalcularTotais e
119: *                           ConfirmarSelecaoExec - antes, essas atribuicoes
120: *                           estavam espalhadas pelos tres (e o contexto era
121: *                           reatribuido DENTRO do SCAN de gravacao, uma vez
122: *                           por linha).
123: *   BOParaForm              FONTE UNICA BO -> tela: os mesmos tres totais.
124: *                           Chamado por CarregarLista entre MontaGrade e
125: *                           CalcularTotais - ordem obrigatoria, porque
126: *                           CalcularTotais LE txt_4c_LnValor.Value como
127: *                           base do rateio.
128: *   Destroy                 o "PROCEDURE Release" do legado: solta as duas
129: *                           grades dos cursores e SO ENTAO fecha
130: *                           cursor_4c_Dados/cursor_4c_Cota, fechando com
131: *                           DODEFAULT() (sem ele o menu principal do
132: *                           sistema aparece encolhido depois que este
133: *                           dialogo fecha).
134: *
135: * O Cancelar da Fase 7 foi renomeado de BtnSairClick para BtnCancelarClick:
136: * o handler leva o nome da ACAO que o usuario ve, e o dump da' a Command1
137: * "Caption = \<Cancelar" / "Cancel = .T." ("btnSair" e' so o .Name interno
138: * do objeto no SCX).
139: *
140: * METODOS CANONICOS DE CRUD QUE NAO SE APLICAM A ESTA TELA
141: * ---------------------------------------------------------
142: * SIGOPDES e' dialogo MODAL FILHO de selecao, nao cadastro: nao tem pagina
143: * de Lista nem de Dados, nao tem modo INCLUIR/ALTERAR/VISUALIZAR e nao tem
144: * botao nenhum alem dos DOIS do dump (cntBotoes.ButtonCount = 2). Medido no
145: * dump SigOpDes_form_codigo_fonte.txt, nao presumido:
146: *
147: *   BtnSalvarClick       zero ocorrencias de "btnSalvar", "btnGravar" e
148: *                        "mGravaDados" no dump. O botao de gravar desta tela
149: *                        e' o Confirmar (Command2, "Caption = \<Confirmar"),
150: *                        e o handler dele e' BtnConfirmarClick. Inventar um
151: *                        segundo botao "Salvar" violaria o PILAR 1.
152: *   BtnBuscarClick       nao ha lookup nem busca nesta tela (zero "fwbusca",
153: *                        zero "mAddColuna", zero "sigacess(" no dump - ver a
154: *                        nota da Fase 6 acima). A lista de descontos
155: *                        elegiveis chega JA resolvida pelo pipeline do BO.
156: *   BtnEncerrarClick     "Encerrar" e' o nome canonico do botao de saida de
157: *                        form CRUD (cnt_4c_Saida/cmd_4c_Encerrar, regra
158: *                        CLAUDE.md #10). Aqui o botao de saida e' o Cancelar
159: *                        do proprio dump, ja entregue como BtnCancelarClick -
160: *                        um BtnEncerrarClick seria um segundo nome para o
161: *                        MESMO e unico caminho de fechar a tela.
162: *   HabilitarCampos      nao ha modo de edicao a habilitar/desabilitar. O
163: *                        que o legado controla por campo ele controla no
164: *                        When de cada celula (Column2.Text1.When -> .f.,
165: *                        Column3/4.Text1.When -> "localdes.selecao=1",
166: *                        lnValor/lnTDesc/lnSaldo.When -> .F., GrdCota
167: *                        inteiro ReadOnly), e esses When estao EMBUTIDOS nas
168: *                        subclasses de celula (Fase 6) e nas propriedades

*-- Linhas 290 a 524:
290:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
291:     * pela flag loc_lSucesso.
292:     *==========================================================================
293:     PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cContads, ;
294:                     par_dDatas, par_cEmpDopNums, par_cCpros, par_nCitens, ;
295:                     par_nUnitOrigs, par_nQtds, par_nTotas, ;
296:                     par_cCgrus, par_cSgrus, par_cCodcors, par_cColecoes, ;
297:                     par_cCodfinp, par_nPvens, par_dDtLacto, par_lForaLinha, ;
298:                     par_nPrecode, par_nQtdParcelas)
299:         LOCAL loc_lSucesso, loc_oErro
300: 
301:         loc_lSucesso = .F.
302: 
303:         *-- WindowType = 1 em PRODUCAO (regra CLAUDE.md #29): o chamador
304:         *-- instancia este form com CREATEOBJECT numa variavel LOCAL e so a
305:         *-- chamada bloqueante de Show() modal mantem essa referencia viva
306:         *-- enquanto o dialogo esta aberto. Em teste/validacao de UI o
307:         *-- Show() nunca e' chamado, e o 0 da classe evita risco de falha de
308:         *-- instanciacao headless.
309:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
310:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
311:             THIS.WindowType = 1
312:             THIS.ShowWindow = 1
313:         ENDIF
314: 
315:         TRY
316:             THIS.this_cEmps       = TratarNulo(par_cEmps, "")
317:             THIS.this_cDopes      = TratarNulo(par_cDopes, "")
318:             THIS.this_nNumes      = TratarNulo(par_nNumes, 0)
319:             THIS.this_cContads    = TratarNulo(par_cContads, "")
320:             THIS.this_dDatas      = ConverterParaData(par_dDatas)
321:             THIS.this_cEmpDopNums = TratarNulo(par_cEmpDopNums, "")
322:             THIS.this_cCpros      = TratarNulo(par_cCpros, "")
323:             THIS.this_nCitens     = TratarNulo(par_nCitens, 0)
324:             THIS.this_nUnitOrigs  = TratarNulo(par_nUnitOrigs, 0)
325:             THIS.this_nQtds       = TratarNulo(par_nQtds, 0)
326:             THIS.this_nTotas      = TratarNulo(par_nTotas, 0)
327: 
328:             THIS.this_cCgrus      = TratarNulo(par_cCgrus, "")
329:             THIS.this_cSgrus      = TratarNulo(par_cSgrus, "")
330:             THIS.this_cCodcors    = TratarNulo(par_cCodcors, "")
331:             THIS.this_cColecoes   = TratarNulo(par_cColecoes, "")
332:             THIS.this_cCodfinp    = TratarNulo(par_cCodfinp, "")
333:             THIS.this_nPvens      = TratarNulo(par_nPvens, 0)
334:             THIS.this_dDtLacto    = ConverterParaData(par_dDtLacto)
335:             THIS.this_lForaLinha  = TratarNulo(par_lForaLinha, .F.)
336:             THIS.this_nPrecode    = TratarNulo(par_nPrecode, 0)
337: 
338:             *-- Parametro OPCIONAL: TratarNulo devolve o default tambem
339:             *-- quando o argumento foi OMITIDO (o VFP entrega .F. nesse
340:             *-- caso, e TratarNulo trata logico vazio como ausente).
341:             THIS.this_nQtdParcelas = TratarNulo(par_nQtdParcelas, 0)
342: 
343:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpDesBO")
344: 
345:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
346:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpDesBO." + ;
347:                         CHR(13) + "VARTYPE retornou: " + ;
348:                         VARTYPE(THIS.this_oBusinessObject), "Erro em Init")
349:             ELSE
350:                 *-- FormBase.Init chama InicializarForm
351:                 loc_lSucesso = DODEFAULT()
352:             ENDIF
353:         CATCH TO loc_oErro
354:             loc_lSucesso = .F.
355:             MsgErro(loc_oErro.Message + CHR(13) + ;
356:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
357:                     "Procedure: " + loc_oErro.Procedure, ;
358:                     "Erro em FormSigOpDes.Init")
359:         ENDTRY
360: 
361:         RETURN loc_lSucesso
362:     ENDPROC
363: 
364:     *==========================================================================
365:     * InicializarForm - propaga o contexto para o BO e monta a superficie
366:     * visual da tela.
367:     *
368:     * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
369:     * arquivo vive em vbmp\ no sistema novo, alcancado por
370:     * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase -
371:     * regra CLAUDE.md Pattern #170/#156). Atribuido direto, sem guard
372:     * IF FILE(): guard mascara arquivo ausente em silencio (regra CLAUDE.md
373:     * #25) - o arquivo foi conferido em vbmp\new_background.jpg.
374:     *
375:     * this_nValor (propriedade de totais do BO) recebe this_nUnitOrigs aqui
376:     * porque e' exatamente o que o Init legado faz:
377:     * "this.lnValor.value = crTpmMvItn.unitorigs".
378:     *==========================================================================
379:     PROTECTED PROCEDURE InicializarForm()
380:         LOCAL loc_lSucesso, loc_oErro
381: 
382:         loc_lSucesso = .F.
383: 
384:         TRY
385:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
386: 
387:             *-- Contexto do movimento/item/produto -> BO, e this_nValor
388:             *-- (legado: "this.lnValor.value = crTpmMvItn.unitorigs").
389:             *-- A transferencia mora em FormParaBO, que e' a fonte unica
390:             *-- tela -> BO: a gravacao do Confirmar chama o MESMO metodo, e
391:             *-- duplicar estas atribuicoes aqui criaria um segundo lugar
392:             *-- para divergir em silencio.
393:             *--
394:             *-- ANTES de ConfigurarPageFrame de proposito: ConfigurarTotais
395:             *-- nasce os tres TextBox de total lendo
396:             *-- this_oBusinessObject.this_nValor/this_nTDesc/this_nSaldo, que
397:             *-- precisam ja estar resolvidos. FormParaBO sabe que nessa
398:             *-- primeira passagem os TextBox ainda nao existem.
399:             *--
400:             *-- O retorno e' descartado de proposito: FormParaBO JA exibiu a
401:             *-- falha (unico caminho de falha e' BO ausente/excecao, e repetir
402:             *-- a mensagem aqui daria dois dialogos para o mesmo erro - regra
403:             *-- CLAUDE.md #20). Sem contexto a grade abre vazia, o que e'
404:             *-- melhor que a tela nao abrir.
405:             THIS.FormParaBO()
406: 
407:             THIS.ConfigurarPageFrame()
408: 
409:             *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
410:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
411:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
412: 
413:             *-- AddObject cria tudo com Visible = .F.
414:             THIS.TornarControlesVisiveis(THIS)
415: 
416:             *-- Carga das duas grades. Pulada em validacao de UI e em modo
417:             *-- de teste porque nesses modos nao ha conexao: gnConnHandle
418:             *-- invalido faz o SQLEXEC disparar excecao, e a tela deixaria
419:             *-- de instanciar por falta de banco, nao por defeito de layout.
420:             *-- O retorno e' descartado de proposito - a falha de carga ja
421:             *-- foi reportada pelo BO e a tela abre com a grade vazia, em
422:             *-- vez de nao abrir.
423:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
424:                (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
425:                 THIS.CarregarLista()
426:             ENDIF
427: 
428:             loc_lSucesso = .T.
429:         CATCH TO loc_oErro
430:             loc_lSucesso = .F.
431:             THIS.this_cMensagemErro = loc_oErro.Message
432:             MsgErro(loc_oErro.Message + CHR(13) + ;
433:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
434:                     "Procedure: " + loc_oErro.Procedure, ;
435:                     "Erro em InicializarForm")
436:         ENDTRY
437: 
438:         RETURN loc_lSucesso
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * ConfigurarPageFrame - orquestra a montagem visual
443:     *
444:     * Nao ha PageFrame real: o legado SIGOPDES e' flat (ver o cabecalho do
445:     * arquivo). O nome e' mantido por conformidade com o contrato do
446:     * pipeline. ORDEM OBRIGATORIA - o cabecalho primeiro (a faixa cinza
447:     * ocupa Top 0..80 e qualquer controle criado depois desenha por cima -
448:     * regra CLAUDE.md #11); cmg_4c_Botoes em seguida, porque o legado
449:     * (cntBotoes Top=-2 Height=85) flutua POR CIMA da faixa de proposito -
450:     * e' a barra de acao do topo, nao um controle de dados (excecao da
451:     * mesma regra #11); as duas grades depois, ja abaixo da faixa
452:     * (GrdCota.Top=85, Grade.Top=131 - nenhuma precisa de compensacao,
453:     * este form nao tem PageFrame.Top=-29).
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarPageFrame()
456:         THIS.ConfigurarCabecalho()
457:         THIS.ConfigurarBotoes()
458:         THIS.ConfigurarGradeCota()
459:         THIS.ConfigurarGrade()
460:         THIS.ConfigurarTotais()
461:     ENDPROC
462: 
463:     *==========================================================================
464:     * ConfigurarBotoes - cmg_4c_Botoes (cntBotoes do legado): CommandGroup
465:     * com 2 botoes, Confirmar (Buttons(2) = Command2 do dump) e Cancelar
466:     * (Buttons(1) = Command1 do dump, com .Cancel = .T. - ESC aciona).
467:     *
468:     * Geometria/aparencia TRANSCRITA do dump (SIGOPDES.cntBotoes): grupo em
469:     * Top=-2/Left=643/Width=160/Height=85 - flutua por cima da faixa do
470:     * cabecalho de proposito (ver ConfigurarPageFrame). CommandGroup NAO
471:     * tem FontName/ForeColor/BackColor (regra CLAUDE.md "CommandGroup.
472:     * FontName NAO EXISTE") - essas propriedades vao nos Buttons(N), que
473:     * sao CommandButton de verdade.
474:     *
475:     * Icones TRANSCRITOS do dump (regra CLAUDE.md #25): cadastro_sair_60.jpg
476:     * (Cancelar) e cadastro_salvar_60.jpg (Confirmar) - ambos confirmados
477:     * em vbmp\. Themes = .F. em ambos (Buttons(N) dentro de CommandGroup
478:     * MANTEM Themes = .F. - regra CommandButton ForeColor/BackColor/Themes
479:     * EXATOS).
480:     *
481:     * BINDEVENT dos Click (btnConfirmar/btnSair - Fase 7/8) fica no fim do
482:     * metodo, junto com o motor CalcTots que os dois acionam.
483:     *==========================================================================
484:     PROTECTED PROCEDURE ConfigurarBotoes()
485:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
486: 
487:         WITH THIS.cmg_4c_Botoes
488:             .Top          = -2
489:             .Left         = 643
490:             .Width        = 160
491:             .Height       = 85
492:             .ButtonCount  = 2
493:             .BackStyle    = 0
494:             .BorderStyle  = 0
495:             .SpecialEffect = 1
496:             .BorderColor  = RGB(136, 189, 188)
497:             .Value        = 0
498:             .TabIndex     = 2
499:             .Visible      = .T.
500: 
501:             *-- Buttons(1) = Command1/btnSair do dump (Cancelar, [Esc] encerra)
502:             WITH .Buttons(1)
503:                 .Top          = 5
504:                 .Left         = 80
505:                 .Width        = 75
506:                 .Height       = 75
507:                 .FontName     = "Comic Sans MS"
508:                 .FontSize     = 8
509:                 .FontBold     = .T.
510:                 .FontItalic   = .T.
511:                 .WordWrap     = .T.
512:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
513:                 .Cancel       = .T.
514:                 .Caption      = "\<Cancelar"
515:                 .MousePointer = 15
516:                 .ToolTipText  = "[Esc] Encerrar"
517:                 .SpecialEffect = 0
518:                 .ForeColor    = RGB(90, 90, 90)
519:                 .BackColor    = RGB(255, 255, 255)
520:                 .Themes       = .F.
521:                 .TabIndex     = 2
522:             ENDWITH
523: 
524:             *-- Buttons(2) = Command2/btnConfirmar do dump

*-- Linhas 544 a 615:
544:             ENDWITH
545:         ENDWITH
546: 
547:         *-- BINDEVENT dos dois botoes (Fase 7/8). Buttons(1) = btnSair/Cancelar
548:         *-- (legado: "ThisForm.Release" puro); Buttons(2) = btnConfirmar
549:         *-- (legado: grava SigMvItd e libera o dialogo).
550:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
551:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")
552:     ENDPROC
553: 
554:     *==========================================================================
555:     * ConfigurarGradeCota - grd_4c_Cota (GrdCota do legado): cota de desconto
556:     * acumulada da empresa, visivel SOMENTE para acesso GERENTE (legado:
557:     * "THIS.grdCota.Visible=fChecaAcesso('SIGCDDES','GERENTE')" no Init).
558:     *
559:     * 3 colunas somente-leitura (ReadOnly = .T. no grid inteiro, igual ao
560:     * dump): Empresa / Cota / Utilizada. O dump fisicamente tem 3 objetos
561:     * Column (ColumnCount = 3), com os 2 ultimos renomeados (.Name =
562:     * "Column3"/"Column4") por terem sobrado de um ColumnCount = 4 original
563:     * (a 2a coluna, ValMeta, esta comentada no Init - "*!*This.GrdCota.
564:     * Column2.ControlSource = [crSigCdDes.valmeta]") - aqui os 3 Column
565:     * ficam na ordem natural 1/2/3 (PILAR 3 nao exige preservar o
566:     * artefato de rename).
567:     *
568:     * O cursor cursor_4c_Cota e' criado vazio AQUI porque Column.ControlSource
569:     * exige que o cursor JA exista: atribuir ControlSource de cursor
570:     * inexistente estoura "Alias is not found" dentro do TRY do
571:     * InicializarForm, o CREATEOBJECT devolve .F. e o usuario aciona a tela
572:     * e nada acontece, sem erro visivel. Quem popula de verdade e'
573:     * SigOpDesBO.CarregarCota, chamada por CarregarLista.
574:     *==========================================================================
575:     PROTECTED PROCEDURE ConfigurarGradeCota()
576:         LOCAL loc_oGrdCota
577: 
578:         *-- Estrutura inicial com a MESMA lista de colunas que
579:         *-- SigOpDesBO.CarregarCota recria: APPEND FROM casa as colunas por
580:         *-- NOME, e coluna faltando aqui sumiria da grade em silencio.
581:         IF !USED("cursor_4c_Cota")
582:             SET NULL ON
583:             CREATE CURSOR cursor_4c_Cota ;
584:                 (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
585:                  Codigo C(10), Valmeta N(11,2))
586:             SET NULL OFF
587:         ENDIF
588: 
589:         THIS.AddObject("grd_4c_Cota", "Grid")
590:         loc_oGrdCota = THIS.grd_4c_Cota
591: 
592:         WITH loc_oGrdCota
593:             .ColumnCount  = 3
594:             .RecordSource = "cursor_4c_Cota"
595:             .Top          = 85
596:             .Left         = 25
597:             .Width        = 413
598:             .Height       = 39
599:             .FontName     = "Verdana"
600:             .FontSize     = 8
601:             .HeaderHeight = 22
602:             .RowHeight    = 16
603:             .ScrollBars   = 2
604:             .ReadOnly     = .T.
605:             .RecordMark   = .F.
606:             .DeleteMark   = .F.
607:             .TabIndex     = 1
608:             .Visible      = THIS.AcessoGradeCota()
609:         ENDWITH
610: 
611:         *-- Column1: Empresa (crSigCdDes.emps)
612:         WITH loc_oGrdCota.Column1
613:             .ControlSource = "cursor_4c_Cota.Emps"
614:             .Width         = 75
615:             .Movable       = .F.

*-- Linhas 677 a 697:
677:             .Caption   = "Utilizada"
678:         ENDWITH
679:     ENDPROC
680: 
681:     *==========================================================================
682:     * ConfigurarGrade - grd_4c_Dados (Grade do legado): grade principal de
683:     * tipos de desconto elegiveis (localDes no legado) - 4 colunas:
684:     * checkbox de selecao / descricao / % desconto / valor desconto.
685:     *
686:     * Column1 e' checkbox puro (regra CLAUDE.md #18 - Column.AddObject NAO
687:     * basta, precisa de CurrentControl + Sparse = .F.; regra "CheckBox
688:     * .Value SEMPRE NUMERICO" - Selecao e' NUMERIC(1,0) no legado, nao
689:     * logico). Geometria/InputMask/Format de cada coluna TRANSCRITOS do
690:     * dump (SIGOPDES.Grade.ColumnN) - regra CLAUDE.md #49 (Format/InputMask
691:     * nunca descartados).
692:     *
693:     * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
694:     * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
695:     * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
696:     * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
697:     * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de

*-- Linhas 704 a 751:
704:     * declara em ColumnN.Text1 passam a ser aplicadas nessa subclasse, que
705:     * e' quem desenha e edita a celula a partir do CurrentControl.
706:     *
707:     * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
708:     * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
709:     * (Fase 7/8) ficam no fim do metodo.
710:     *==========================================================================
711:     PROTECTED PROCEDURE ConfigurarGrade()
712:         LOCAL loc_oGrade
713: 
714:         *-- Estrutura inicial com a MESMA lista de colunas que
715:         *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
716:         *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
717:         *-- tambem mantem em localDes e que os fluxos de validacao e de
718:         *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
719:         *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
720:         *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
721:         *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
722:         IF !USED("cursor_4c_Dados")
723:             SET NULL ON
724:             CREATE CURSOR cursor_4c_Dados ;
725:                 (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
726:                  Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
727:                  Descosmax N(7,4), Usuars C(10))
728:             SET NULL OFF
729:         ENDIF
730: 
731:         THIS.AddObject("grd_4c_Dados", "Grid")
732:         loc_oGrade = THIS.grd_4c_Dados
733: 
734:         WITH loc_oGrade
735:             .ColumnCount  = 4
736:             .RecordSource = "cursor_4c_Dados"
737:             .Top          = 131
738:             .Left         = 24
739:             .Width        = 748
740:             .Height       = 169
741:             .FontName     = "Verdana"
742:             .FontSize     = 8
743:             .HeaderHeight = 22
744:             .RowHeight    = 16
745:             .ScrollBars   = 2
746:             .ReadOnly     = .F.
747:             .RecordMark   = .F.
748:             .DeleteMark   = .F.
749:             .TabIndex     = 1
750:             .Visible      = .T.
751:         ENDWITH

*-- Linhas 789 a 843:
789:             .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
790:         ENDWITH
791: 
792:         *-- BINDEVENT do checkbox de selecao (Fase 7/8) - regra CLAUDE.md
793:         *-- "CheckBox em coluna de Grid": o toggle nativo NAO e' confiavel
794:         *-- dentro de Column, entao Click/MouseDown so suprimem (NODEFAULT) e
795:         *-- MouseUp/KeyPress(Enter/Espaco) e' quem de fato alterna, via
796:         *-- ChkSelecaoToggle - que tambem carrega a logica de autorizacao do
797:         *-- legado (SigOpSen). BINDEVENT do Header1.Click (selecionar/
798:         *-- desmarcar tudo) fica aqui tambem, por serem da mesma coluna.
799:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "Click",     THIS, "ChkSelecaoClick")
800:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseDown", THIS, "ChkSelecaoMouseDown")
801:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseUp",   THIS, "ChkSelecaoMouseUp")
802:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "KeyPress",  THIS, "ChkSelecaoKeyPress")
803:         BINDEVENT(loc_oGrade.Column1.Header1,        "Click",     THIS, "Header1Click")
804: 
805:         *-- Column2: descricao do tipo de desconto (localDes.Descrs)
806:         WITH loc_oGrade.Column2
807:             .ControlSource = "cursor_4c_Dados.Descrs"
808:             .Width         = 500
809:             .Movable       = .F.
810:             .Resizable     = .F.
811:             .ReadOnly      = .F.
812:             .Visible       = .T.
813:         ENDWITH
814:         WITH loc_oGrade.Column2.Header1
815:             .FontName  = "Verdana"
816:             .FontSize  = 8
817:             .Alignment = 2
818:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
819:         ENDWITH
820: 
821:         *-- Column3: percentual de desconto (localDes.Descos)
822:         WITH loc_oGrade.Column3
823:             .ControlSource = "cursor_4c_Dados.Descos"
824:             .Width         = 88
825:             .ReadOnly      = .F.
826:             .Visible       = .T.
827:         ENDWITH
828:         WITH loc_oGrade.Column3.Header1
829:             .FontName  = "Verdana"
830:             .FontSize  = 8
831:             .Alignment = 2
832:             .Caption   = "% Desconto"
833:         ENDWITH
834: 
835:         *-- Column4: valor do desconto (localDes.Valdes)
836:         WITH loc_oGrade.Column4
837:             .ControlSource = "cursor_4c_Dados.Valdes"
838:             .Width         = 110
839:             .ReadOnly      = .F.
840:             .Visible       = .T.
841:         ENDWITH
842:         WITH loc_oGrade.Column4.Header1
843:             .FontName  = "Verdana"

*-- Linhas 868 a 932:
868:     * TabIndex do dump (33 nos tres Say, 38 nos tres campos) NAO e'
869:     * transcrito, de proposito: os tres campos tem TabStop = .F. (o When
870:     * Return(.F.) do legado) e Label nao entra na tabulacao, logo o
871:     * TabIndex deles e' inerte - e atribuir TabIndex em runtime RENUMERA
872:     * os demais controles do form, o que mexeria na ordem de tabulacao
873:     * real (cmg_4c_Botoes = 2, grd_4c_Dados = 1) sem nenhum ganho.
874:     *
875:     * Os tres campos (lnValor/lnTDesc/lnSaldo) tem PROCEDURE When
876:     * Return(.F.) no legado - nunca recebem foco, sao so EXIBICAO. Aqui
877:     * isso vira ReadOnly = .T. + TabStop = .F. (equivalente: a celula nunca
878:     * entra em edicao e o Tab pula o controle), sem precisar de evento.
879:     *
880:     * Geometria/InputMask TRANSCRITOS do dump (SIGOPDES.Say2/lnValor/Say4/
881:     * lnTDesc) - regra CLAUDE.md #49 (Format/InputMask nunca descartados).
882:     * ForeColor dos labels e' RGB(90,90,90), EXPLICITO no dump (nao e' o
883:     * caso de "classe say sem ForeColor" da regra CLAUDE.md #12).
884:     *
885:     * lnValor.Value nasce de THIS.this_oBusinessObject.this_nValor - esse
886:     * valor ja foi igualado a this_nUnitOrigs em InicializarForm, que e'
887:     * exatamente o que o Init legado faz ("this.lnValor.value =
888:     * crTpmMvItn.unitorigs"). lnTDesc.Value nasce 0: o legado so o
889:     * preenche dentro do motor CalcTots (Fase 7/8), disparado por acoes do
890:     * usuario (marcar/editar uma linha da grade) que ainda nao existem.
891:     *==========================================================================
892:     PROTECTED PROCEDURE ConfigurarTotais()
893:         *-- lbl_4c_Label2 / txt_4c_LnValor: "Valor Original :" (Say2/lnValor)
894:         THIS.AddObject("lbl_4c_Label2", "Label")
895:         WITH THIS.lbl_4c_Label2
896:             .Top       = 307
897:             .Left      = 368
898:             .Height    = 15
899:             .AutoSize  = .T.
900:             .BackStyle = 0
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:             .ForeColor = RGB(90, 90, 90)
904:             .Caption   = "Valor Original :"
905:             .Visible   = .T.
906:         ENDWITH
907: 
908:         THIS.AddObject("txt_4c_LnValor", "TextBox")
909:         WITH THIS.txt_4c_LnValor
910:             .Top           = 303
911:             .Left          = 452
912:             .Width         = 98
913:             .Height        = 23
914:             .FontName      = "Verdana"
915:             .FontSize      = 8
916:             .FontBold      = .F.
917:             .Alignment     = 1
918:             .InputMask     = "999,999,999.99"
919:             .MaxLength     = 10
920:             .SpecialEffect = 1
921:             .ReadOnly      = .T.
922:             .TabStop       = .F.
923:             .Value         = THIS.this_oBusinessObject.this_nValor
924:             .Visible       = .T.
925:         ENDWITH
926: 
927:         *-- lbl_4c_Label4 / txt_4c_LnTDesc: "Total Desconto :" (Say4/lnTDesc)
928:         THIS.AddObject("lbl_4c_Label4", "Label")
929:         WITH THIS.lbl_4c_Label4
930:             .Top       = 308
931:             .Left      = 564
932:             .Height    = 15

*-- Linhas 1013 a 1059:
1013:     * paginas de cadastro.
1014:     *
1015:     * Caption dos dois labels fica em branco aqui (so o Caption real, que
1016:     * depende de THIS.Caption, e' aplicado em InicializarForm - igual ao
1017:     * Init legado).
1018:     *==========================================================================
1019:     PROTECTED PROCEDURE ConfigurarCabecalho()
1020:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
1021:         WITH THIS.cnt_4c_Cabecalho
1022:             .Top           = 0
1023:             .Left          = 0
1024:             .Width         = THIS.Width
1025:             .Height        = 80
1026:             .BackStyle     = 1
1027:             .BackColor     = RGB(100, 100, 100)
1028:             .BorderWidth   = 0
1029:             .SpecialEffect = 0
1030:             .Visible       = .T.
1031:         ENDWITH
1032: 
1033:         *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
1034:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
1035:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
1036:             .Top           = 18
1037:             .Left          = 10
1038:             .Width         = 769
1039:             .Height        = 40
1040:             .AutoSize      = .F.
1041:             .BackStyle     = 0
1042:             .WordWrap      = .T.
1043:             .Alignment     = 0
1044:             .FontName      = "Tahoma"
1045:             .FontSize      = 18
1046:             .FontBold      = .T.
1047:             .FontUnderline = .F.
1048:             .ForeColor     = RGB(0, 0, 0)
1049:             .Caption       = ""
1050:             .Visible       = .T.
1051:         ENDWITH
1052: 
1053:         *-- lblTitulo: texto branco por cima da sombra
1054:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
1055:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
1056:             .Top         = 17
1057:             .Left        = 10
1058:             .Width       = 769
1059:             .Height      = 46

*-- Linhas 1070 a 1408:
1070:             .Visible     = .T.
1071:         ENDWITH
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * AcessoGradeCota - responde se a grade de cota (grd_4c_Cota) deve
1076:     * aparecer. Legado: "THIS.grdCota.Visible = fChecaAcesso('SIGCDDES',
1077:     * 'GERENTE')" - so o acesso GERENTE ve a cota da empresa.
1078:     *
1079:     * A chamada de 2 argumentos e' a do legado e esta FIEL: os 3
1080:     * parametros restantes de fChecaAcesso tem fallback proprio dentro da
1081:     * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
1082:     *
1083:     * O guard de modo existe porque fChecaAcesso abre conexao propria
1084:     * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
1085:     * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
1086:     * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
1087:     * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
1088:     * cota nao teria o que mostrar de qualquer forma.
1089:     *==========================================================================
1090:     PROTECTED FUNCTION AcessoGradeCota()
1091:         LOCAL loc_lAcesso
1092: 
1093:         loc_lAcesso = .F.
1094: 
1095:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
1096:            (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
1097:             loc_lAcesso = fChecaAcesso("SIGCDDES", "GERENTE")
1098:         ENDIF
1099: 
1100:         RETURN loc_lAcesso
1101:     ENDFUNC
1102: 
1103:     *==========================================================================
1104:     * CarregarLista - carga das duas grades da tela, no mesmo ponto do
1105:     * fluxo em que o Init legado as popula.
1106:     *
1107:     * Legado: o Init monta crDesc/crTipo/localDes e crSigCdDes e termina
1108:     * ligando cada grade ao seu cursor
1109:     * ("This.Grade.RecordSource = [localDes]" e
1110:     *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
1111:     * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
1112:     * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
1113:     * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
1114:     * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
1115:     *
1116:     * PUBLIC de proposito: o harness de teste automatizado chama
1117:     * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
1118:     * para metodo PROTECTED e a chamada real falharia em runtime).
1119:     *
1120:     * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
1121:     *==========================================================================
1122:     PROCEDURE CarregarLista()
1123:         LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro
1124: 
1125:         loc_lSucesso = .F.
1126: 
1127:         TRY
1128:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1129:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1130:                         "vel para carregar os descontos.", "Erro em CarregarLista")
1131:             ELSE
1132:                 *-- A cota vem PRIMEIRO: CarregarCota resolve this_cCodigo
1133:                 *-- (o codigo da cota vigente), que a gravacao dos
1134:                 *-- descontos selecionados consome.
1135:                 loc_lCota      = THIS.this_oBusinessObject.CarregarCota()
1136:                 loc_lDescontos = THIS.this_oBusinessObject.CarregarDescontos()
1137: 
1138:                 *-- Repintar SEMPRE, inclusive quando a carga falha: a
1139:                 *-- grade pode estar exibindo o conteudo de uma carga
1140:                 *-- anterior, e popular cursor nao repinta grade sozinho.
1141:                 THIS.MontaGrade()
1142: 
1143:                 *-- BO -> tela: o Valor Original (legado: "this.lnValor.value
1144:                 *-- = crTpmMvItn.unitorigs") e os dois totais que a carga do
1145:                 *-- BO deixou nas properties. Tem de rodar ANTES do
1146:                 *-- CalcularTotais, porque CalcularTotais LE
1147:                 *-- txt_4c_LnValor.Value como base do rateio - inverter a
1148:                 *-- ordem calcularia percentual sobre o valor da carga
1149:                 *-- anterior, sem erro nenhum na tela.
1150:                 THIS.BOParaForm()
1151: 
1152:                 *-- O Init legado termina com "=thisform.CalcTots()": a
1153:                 *-- tela abre com Total Desconto / Saldo ja refletindo os
1154:                 *-- descontos que MarcarDescontosGravados pre-selecionou, e
1155:                 *-- a cota utilizada ja somada. Sem esta chamada os tres
1156:                 *-- campos de total abririam zerados sobre uma grade com
1157:                 *-- linhas marcadas - divergencia muda, porque nada falha.
1158:                 THIS.CalcularTotais()
1159: 
1160:                 loc_lSucesso = loc_lCota AND loc_lDescontos
1161:             ENDIF
1162:         CATCH TO loc_oErro
1163:             loc_lSucesso = .F.
1164:             MsgErro(loc_oErro.Message + CHR(13) + ;
1165:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1166:                     "Procedure: " + loc_oErro.Procedure, ;
1167:                     "Erro em CarregarLista")
1168:         ENDTRY
1169: 
1170:         RETURN loc_lSucesso
1171:     ENDPROC
1172: 
1173:     *==========================================================================
1174:     * MontaGrade - funil UNICO de repintura das duas grades.
1175:     *
1176:     * Popular um cursor NAO faz a grade ligada a ele exibir as linhas: o
1177:     * legado sempre fecha a carga com "Go Top In <cursor>" +
1178:     * "<grade>.Refresh", e sem isso a grade fica visualmente vazia com o
1179:     * cursor cheio - sintoma que manda o diagnostico para SQL/permissao.
1180:     * Por isso a repintura mora aqui e e' chamada por TODO caminho que
1181:     * popula os cursores.
1182:     *
1183:     * ColumnCount NAO e' reatribuido: qualquer atribuicao a ColumnCount
1184:     * recria os objetos Column e DESTRUIRIA o CheckBox posto por
1185:     * AddObject em Column1 (com ele, a coluna de selecao da grade).
1186:     *
1187:     * O rebind completo (RecordSource -> ControlSource -> Width ->
1188:     * Header1.Caption -> CurrentControl/Sparse) so roda quando o
1189:     * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
1190:     * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
1191:     * seria apagar o que ConfigurarGrade acabou de montar. Na carga
1192:     * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
1193:     * Refresh.
1194:     *==========================================================================
1195:     PROCEDURE MontaGrade()
1196:         LOCAL loc_oGrade, loc_oGrdCota, loc_oErro
1197: 
1198:         TRY
1199:             *-- Grade principal de descontos
1200:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1201:                 loc_oGrade = THIS.grd_4c_Dados
1202: 
1203:                 IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
1204:                     THIS.VincularGrade()
1205:                 ENDIF
1206: 
1207:                 SELECT cursor_4c_Dados
1208:                 GO TOP
1209:                 loc_oGrade.Refresh()
1210:             ENDIF
1211: 
1212:             *-- Grade da cota da empresa
1213:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
1214:                 loc_oGrdCota = THIS.grd_4c_Cota
1215: 
1216:                 IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
1217:                     THIS.VincularGradeCota()
1218:                 ENDIF
1219: 
1220:                 SELECT cursor_4c_Cota
1221:                 GO TOP
1222:                 loc_oGrdCota.Refresh()
1223:             ENDIF
1224: 
1225:             *-- Volta o alias corrente para a grade principal, que e' a
1226:             *-- que recebe o foco e de onde os eventos de celula leem.
1227:             IF USED("cursor_4c_Dados")
1228:                 SELECT cursor_4c_Dados
1229:             ENDIF
1230:         CATCH TO loc_oErro
1231:             MsgErro(loc_oErro.Message + CHR(13) + ;
1232:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1233:                     "Procedure: " + loc_oErro.Procedure, ;
1234:                     "Erro em MontaGrade")
1235:         ENDTRY
1236:     ENDPROC
1237: 
1238:     *==========================================================================
1239:     * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
1240:     * que a atribuicao de RecordSource reseta.
1241:     *
1242:     * Atribuir RecordSource devolve Column.Width ao default 90, limpa
1243:     * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
1244:     * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
1245:     * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
1246:     * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
1247:     * dump em ConfigurarGrade.
1248:     *
1249:     * ColumnCount fica de fora: reatribui-lo recriaria os Column e
1250:     * destruiria o CheckBox de Column1.
1251:     *==========================================================================
1252:     PROTECTED PROCEDURE VincularGrade()
1253:         LOCAL loc_oGrade
1254: 
1255:         loc_oGrade = THIS.grd_4c_Dados
1256: 
1257:         *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
1258:         *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
1259:         *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
1260:         *-- unico jeito de marcar a linha. Por isso, aqui:
1261:         *-- NAO reatribuir ColumnCount.
1262:         loc_oGrade.RecordSource = "cursor_4c_Dados"
1263: 
1264:         loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
1265:         loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1266:         loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
1267:         loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"
1268: 
1269:         loc_oGrade.Column1.Width = 23
1270:         loc_oGrade.Column2.Width = 500
1271:         loc_oGrade.Column3.Width = 88
1272:         loc_oGrade.Column4.Width = 110
1273: 
1274:         loc_oGrade.Column1.Header1.Caption = ""
1275:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
1276:                                              "o do Desconto"
1277:         loc_oGrade.Column3.Header1.Caption = "% Desconto"
1278:         loc_oGrade.Column4.Header1.Caption = "Valor Desconto"
1279: 
1280:         *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
1281:         *-- CheckBox de selecao, apesar de existir, nao aparece; sem
1282:         *-- Sparse = .F. ele apareceria so na linha ativa.
1283:         IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
1284:             loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
1285:         ENDIF
1286:         loc_oGrade.Column1.Sparse = .F.
1287: 
1288:         *-- As celulas de Column2/3/4 tambem se perdem no rebind
1289:         *-- (RecordSource derruba CurrentControl), e sem elas a coluna de
1290:         *-- descricao voltaria a aceitar digitacao e as duas colunas
1291:         *-- editaveis perderiam o When/Valid do legado. InstalarCelulasGrade
1292:         *-- e' idempotente: so chama AddObject quando o objeto nao existe.
1293:         THIS.InstalarCelulasGrade(loc_oGrade)
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
1298:     * que a atribuicao de RecordSource reseta (mesma regra de ordem de
1299:     * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
1300:     * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
1301:     * natural, com as larguras e captions do dump.
1302:     *
1303:     * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
1304:     * as colunas e sobrescreveria o das colunas.
1305:     *==========================================================================
1306:     PROTECTED PROCEDURE VincularGradeCota()
1307:         LOCAL loc_oGrdCota
1308: 
1309:         loc_oGrdCota = THIS.grd_4c_Cota
1310: 
1311:         *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
1312:         *-- larguras do dump sao montadas por ConfigurarGradeCota, e
1313:         *-- reatribuir ColumnCount as recriaria do zero.
1314:         loc_oGrdCota.RecordSource = "cursor_4c_Cota"
1315: 
1316:         loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
1317:         loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
1318:         loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"
1319: 
1320:         loc_oGrdCota.Column1.Width = 75
1321:         loc_oGrdCota.Column2.Width = 145
1322:         loc_oGrdCota.Column3.Width = 169
1323: 
1324:         loc_oGrdCota.Column1.Header1.Caption = "Empresa"
1325:         loc_oGrdCota.Column2.Header1.Caption = "Cota"
1326:         loc_oGrdCota.Column3.Header1.Caption = "Utilizada"
1327: 
1328:         loc_oGrdCota.ReadOnly         = .T.
1329:         loc_oGrdCota.Column1.ReadOnly = .T.
1330:         loc_oGrdCota.Column2.ReadOnly = .T.
1331:         loc_oGrdCota.Column3.ReadOnly = .T.
1332:     ENDPROC
1333: 
1334:     *==========================================================================
1335:     * InstalarCelulasGrade - poe em Column2/3/4 da grade principal a
1336:     * SUBCLASSE de TextBox que carrega o When/Valid daquela celula no
1337:     * legado, e liga cada uma por CurrentControl.
1338:     *
1339:     * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao
1340:     * de celula de grade mora no Valid do TextBox da coluna, e BINDEVENT
1341:     * em "Valid" de TextBox de Column nao e' confiavel - alem disso o
1342:     * BINDEVENT DESCARTA o retorno do delegate, e aqui o retorno e' o
1343:     * mecanismo: o Valid devolvendo .F. e' o que mantem o cursor na celula
1344:     * depois de recusar o valor digitado, e o When devolvendo .F. e' o que
1345:     * impede a entrada na celula. Nenhum dos dois efeitos sobrevive a um
1346:     * BINDEVENT. AfterRowColChange tambem nao serve: ele dispara DEPOIS de
1347:     * entrar na celula nova e o indice que ele recebe e' o da coluna de
1348:     * DESTINO, nao o da coluna que o usuario acabou de deixar.
1349:     *
1350:     * Column.AddObject NAO basta para o controle aparecer (regra CLAUDE.md
1351:     * #18): sem CurrentControl a coluna continua desenhando o Text1 dela, o
1352:     * objeto existe, responde a PEMSTATUS e o When/Valid nunca roda. Por
1353:     * isso as propriedades visuais que o dump declara em ColumnN.Text1 sao
1354:     * aplicadas AQUI, na subclasse - ela e' que passa a desenhar a celula.
1355:     *
1356:     * Sparse fica no default (.T.) nas tres colunas, como no dump (que so
1357:     * declara Sparse em Column1, a do CheckBox): as subclasses sao TextBox
1358:     * e desenham igual ao Text1 que substituem, e o When/Valid de uma
1359:     * Column roda na celula ATIVA, que e' justamente o que Sparse = .T. ja
1360:     * instancia. Forcar Sparse = .F. aqui instanciaria um controle por
1361:     * linha visivel sem mudar nada do que se ve.
1362:     *
1363:     * IDEMPOTENTE de proposito: AddObject duas vezes com o mesmo nome no
1364:     * mesmo alvo estoura "Object is already defined" e derrubaria o Init.
1365:     * VincularGrade chama este metodo depois de cada rebind, porque
1366:     * atribuir RecordSource derruba CurrentControl.
1367:     *==========================================================================
1368:     PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
1369:         IF VARTYPE(par_oGrade) != "O"
1370:             RETURN
1371:         ENDIF
1372: 
1373:         *-- Column2: descricao do tipo de desconto. O legado NAO usa
1374:         *-- ReadOnly aqui (o dump declara Column2.ReadOnly = .F.) - quem
1375:         *-- bloqueia a digitacao e' o "When / Return .f." do Text1, e e'
1376:         *-- esse o mecanismo reproduzido. Transcrever so o ReadOnly = .F.
1377:         *-- do dump e parar ai deixaria a descricao do desconto EDITAVEL.
1378:         IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelDescricao", 5)
1379:             par_oGrade.Column2.AddObject("txt_4c_CelDescricao", ;
1380:                                           "TextBoxCelDescricaoSigOpDes_4c")
1381:         ENDIF
1382:         WITH par_oGrade.Column2.txt_4c_CelDescricao
1383:             .BorderStyle = 0
1384:             .InputMask   = ""
1385:             .Margin      = 0
1386:             .ReadOnly    = .F.
1387:             .ForeColor   = RGB(0, 0, 0)
1388:             .BackColor   = RGB(255, 255, 255)
1389:             .Visible     = .T.
1390:         ENDWITH
1391:         par_oGrade.Column2.CurrentControl = "txt_4c_CelDescricao"
1392: 
1393:         *-- Column3: percentual de desconto (localDes.Descos)
1394:         IF !PEMSTATUS(par_oGrade.Column3, "txt_4c_CelPercentual", 5)
1395:             par_oGrade.Column3.AddObject("txt_4c_CelPercentual", ;
1396:                                           "TextBoxCelPercentualSigOpDes_4c")
1397:         ENDIF
1398:         WITH par_oGrade.Column3.txt_4c_CelPercentual
1399:             .BorderStyle = 0
1400:             .InputMask   = "999.99"
1401:             .Margin      = 0
1402:             .ForeColor   = RGB(0, 0, 0)
1403:             .BackColor   = RGB(255, 255, 255)
1404:             .Visible     = .T.
1405:         ENDWITH
1406:         par_oGrade.Column3.CurrentControl = "txt_4c_CelPercentual"
1407: 
1408:         *-- Column4: valor do desconto (localDes.Valdes)

*-- Linhas 1497 a 1587:
1497:     ENDFUNC
1498: 
1499:     *==========================================================================
1500:     * CalcularTotais - o PROCEDURE calctots do legado.
1501:     *
1502:     * Motor de totais da tela: normaliza a linha corrente, soma os
1503:     * descontos, atualiza a cota utilizada da empresa e escreve os tres
1504:     * campos de total. TRANSCRITO linha a linha (regra CLAUDE.md #17 - a
1505:     * formula, o ROUND, o /100 e o SINAL sao regra de negocio):
1506:     *
1507:     *   replace descos with IIF(selecao = 0, 00.0000, descos)
1508:     *   replace valdes with IIF(selecao = 0, 000000000.00,
1509:     *                           ROUND(lnvalor.value * descos / 100, 2))
1510:     *   lnReg = IIF(EOF('localdes'), 0, RECNO())
1511:     *   GO top / SUM valdes to lnTDesc
1512:     *   GO top / SUM valdes to lnTDescI for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1513:     *   SELECT crSigmvitd / GO top
1514:     *   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1515:     *                           AND citens <> pcItem
1516:     *   replace valdes with crValdes.vdes + lnTDescI + lnTDescM in crSigCdDes
1517:     *   lnSaldo = lnvalor.value - lnTDesc
1518:     *   lnSaldo.Value = lnSaldo / lnTdesc.Value = lnTDesc
1519:     *   IF lnReg <> 0 / GO lnReg / endif
1520:     *   thisform.Refresh
1521:     *
1522:     * Os dois primeiros REPLACE sao SEM escopo no legado, isto e' valem
1523:     * para a linha CORRENTE e nao para o cursor inteiro - quem muda e' a
1524:     * linha que o usuario acabou de marcar ou editar.
1525:     *
1526:     * lnTDescM (descontos JA GRAVADOS dos OUTROS itens do movimento) vem
1527:     * de crSigmvitd, cursor global do form chamador que esta arquitetura
1528:     * nao tem: a soma e' resolvida uma vez na carga por
1529:     * SigOpDesBO.CarregarDescontoOutrosItens e lida aqui da propriedade
1530:     * this_nVDescOutrosItens. Uma vez e' suficiente e nao e' atalho - esta
1531:     * tela edita UM item, os outros nao mudam enquanto o dialogo esta
1532:     * aberto, e o legado tambem nao os reconsulta (ele so re-soma um
1533:     * cursor que ninguem alterou).
1534:     *
1535:     * A base da cota (crValdes.vdes do legado) e' lida de this_nValDes e
1536:     * NAO de cursor_4c_Cota.Valdes, porque esta mesma rotina SOBRESCREVE
1537:     * essa coluna do cursor: ler dali faria a cota utilizada crescer de
1538:     * forma acumulada a cada tecla digitada.
1539:     *
1540:     * RECNO e' salvo e reposto porque SUM varre o cursor inteiro e deixa o
1541:     * ponteiro em EOF - sem repor, a linha que o usuario esta editando
1542:     * deixaria de ser a linha corrente no meio do proprio Valid.
1543:     *
1544:     * PUBLIC: os eventos da Fase 7/8 (Click do checkbox de cada linha,
1545:     * Header1.Click de selecionar-tudo) acionam este metodo de fora.
1546:     *==========================================================================
1547:     PROCEDURE CalcularTotais()
1548:         LOCAL loc_nReg, loc_nSaldo, loc_nTDesc, loc_nTDescI, loc_nTDescM
1549:         LOCAL loc_nValor, loc_nBaseCota, loc_oErro
1550: 
1551:         TRY
1552:             IF !USED("cursor_4c_Dados")
1553:                 MsgErro("Cursor de descontos indispon" + CHR(237) + "vel " + ;
1554:                         "para calcular os totais.", "Erro em CalcularTotais")
1555:             ELSE
1556:                 loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
1557: 
1558:                 SELECT cursor_4c_Dados
1559: 
1560:                 *-- Linha corrente: desmarcada zera os dois campos, marcada
1561:                 *-- recalcula o valor a partir do percentual.
1562:                 IF !EOF("cursor_4c_Dados")
1563:                     IF NVL(cursor_4c_Dados.Selecao, 0) = 0
1564:                         REPLACE Descos WITH 0, ;
1565:                                 Valdes WITH 0 ;
1566:                             IN cursor_4c_Dados
1567:                     ELSE
1568:                         REPLACE Valdes WITH ROUND(loc_nValor * ;
1569:                                 NVL(cursor_4c_Dados.Descos, 0) / 100, 2) ;
1570:                             IN cursor_4c_Dados
1571:                     ENDIF
1572:                 ENDIF
1573: 
1574:                 loc_nReg = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))
1575: 
1576:                 *-- Total de desconto do item: TODAS as linhas
1577:                 GO TOP IN cursor_4c_Dados
1578:                 SUM cursor_4c_Dados.Valdes TO loc_nTDesc
1579: 
1580:                 *-- Parcela que CONSOME a cota da empresa: ficam de fora
1581:                 *-- aniversario(1), financeiro(2), troca zerada(6),
1582:                 *-- up diamond(7), upgrade alianca(10), extra/loja(11),
1583:                 *-- brinde(12) e troca de preco(13).
1584:                 GO TOP IN cursor_4c_Dados
1585:                 SUM cursor_4c_Dados.Valdes TO loc_nTDescI ;
1586:                     FOR !INLIST(NVL(cursor_4c_Dados.Tpdesc, 0), ;
1587:                                 1, 2, 6, 7, 10, 11, 12, 13)

*-- Linhas 1634 a 1786:
1634:         CATCH TO loc_oErro
1635:             MsgErro(loc_oErro.Message + CHR(13) + ;
1636:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1637:                     "Procedure: " + loc_oErro.Procedure, ;
1638:                     "Erro em CalcularTotais")
1639:         ENDTRY
1640:     ENDPROC
1641: 
1642:     *==========================================================================
1643:     * BtnCancelarClick - cmg_4c_Botoes.Buttons(1) (Command1 do dump).
1644:     *
1645:     * Legado: "PROCEDURE btnSair.Click / ThisForm.Release" - nenhuma outra
1646:     * logica, nenhuma confirmacao. Cancelar fecha o dialogo sem gravar nada.
1647:     *
1648:     * POR QUE "Cancelar" E NAO "Sair": o handler e' nomeado pela ACAO que o
1649:     * usuario ve, nao pelo nome do objeto legado. O dump de SIGOPDES.cntBotoes
1650:     * da' a Command1 "Caption = \<Cancelar", "ToolTipText = [Esc] Encerrar" e
1651:     * "Cancel = .T." - o botao na tela diz CANCELAR; "btnSair" e' so o .Name
1652:     * interno do objeto no SCX. Herdar o nome do objeto faria o metodo divergir
1653:     * do que a tela mostra e do nome canonico do pipeline para o caminho de
1654:     * "fechar sem gravar".
1655:     *
1656:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1657:     *==========================================================================
1658:     PROCEDURE BtnCancelarClick()
1659:         THIS.Release()
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * BtnConfirmarClick - cmg_4c_Botoes.Buttons(2) (btnConfirmar do legado).
1664:     *
1665:     * Legado (PROCEDURE btnConfirmar.Click):
1666:     *
1667:     *   ThisForm.Grade.Refresh
1668:     *   Select localDes / Go Top In localDes / ThisForm.Grade.Refresh
1669:     *   SELECT crsigmvitd
1670:     *   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
1671:     *   Select localDes / DELETE ALL for descos = 0 / GO top
1672:     *   SCAN
1673:     *       If (localDes.Selecao = 1)
1674:     *           lcIdChave = fUniqueIds()
1675:     *           INSERT into crSigmvItd (...) values (...)
1676:     *       ENDIF
1677:     *   ENDSCAN
1678:     *   ThisForm.Release
1679:     *
1680:     * "DELETE ALL for descos = 0" marca deletadas (SET DELETED liga) as
1681:     * linhas com desconto zero, e o SCAN so insere as que sobrevivem E tem
1682:     * Selecao = 1 - equivalente a "Selecao = 1 AND Descos <> 0", que e' o
1683:     * filtro usado no SCAN de ConfirmarSelecaoExec.
1684:     *
1685:     * O par wrapper + Exec existe pela mesma razao de ValidarPercentualDesconto
1686:     * (regra CLAUDE.md #1): o corpo tem SCAN/loop e chamadas de BO que podem
1687:     * estourar, e o Release() final tem de rodar FORA do TRY. Release()
1688:     * acontece SEMPRE, inclusive apos erro - igual ao legado, que nao tem
1689:     * TRY/CATCH nenhum e sempre libera o dialogo no fim.
1690:     *
1691:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1692:     *==========================================================================
1693:     PROCEDURE BtnConfirmarClick()
1694:         LOCAL loc_oErro
1695: 
1696:         TRY
1697:             THIS.ConfirmarSelecaoExec()
1698:         CATCH TO loc_oErro
1699:             MsgErro(loc_oErro.Message + CHR(13) + ;
1700:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1701:                     "Procedure: " + loc_oErro.Procedure, ;
1702:                     "Erro em BtnConfirmarClick")
1703:         ENDTRY
1704: 
1705:         THIS.Release()
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * ConfirmarSelecaoExec - corpo do btnConfirmar.Click: remove os
1710:     * descontos anteriores do item e regrava, em SigMvItd, uma linha para
1711:     * cada tipo de desconto marcado na grade com valor diferente de zero.
1712:     *
1713:     * SigOpDesBO.ExcluirDescontosDoItem() substitui o
1714:     * "DELETE all for cpros = ... and citens = ..." em crsigmvitd (cursor
1715:     * global do form chamador): aqui a tabela e' acessada direto, restrita
1716:     * ao mesmo par cpros/citens.
1717:     *
1718:     * Cada iteracao do SCAN preenche no BO exatamente as colunas que o
1719:     * INSERT do legado usa alem do contexto fixo do item (ja presente nas
1720:     * properties this_cCpros/this_nCitens/this_cEmps/this_cDopes/
1721:     * this_nNumes, herdadas do Init do form): Cdesc/Ddesc/Pdes/Vdes/TpDesc/
1722:     * Usuars vem da linha corrente de cursor_4c_Dados, ValBase vem de
1723:     * this_nUnitOrigs (legado: "crTpmMvItn.unitorigs") e Codigo (a cota
1724:     * vigente, "crSigcdDes.codigo") ja foi resolvido por
1725:     * SigOpDesBO.CarregarCota na abertura da tela e permanece em
1726:     * this_oBusinessObject.this_cCodigo.
1727:     *
1728:     * this_cCidChaves e' zerado ANTES de cada Inserir(): e' o gatilho que faz
1729:     * Inserir() gerar um fUniqueIds() NOVO por linha (regra CLAUDE.md #22) -
1730:     * equivalente a "lcIdChave = fUniqueIds()" dentro do SCAN do legado.
1731:     *==========================================================================
1732:     PROCEDURE ConfirmarSelecaoExec()
1733:         LOCAL loc_lExcluiu
1734: 
1735:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1736:             MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1737:                     "vel para confirmar a sele" + CHR(231) + CHR(227) + "o.", ;
1738:                     "Erro em BtnConfirmarClick")
1739:             RETURN
1740:         ENDIF
1741: 
1742:         *-- Contexto do item/movimento + os totais que estao na TELA, numa
1743:         *-- chamada so e FORA do SCAN: o contexto e' o MESMO para todas as
1744:         *-- linhas gravadas (e' sempre o mesmo item), entao reatribui-lo a
1745:         *-- cada iteracao so criava um segundo lugar para divergir do
1746:         *-- InicializarForm. Dentro do SCAN ficam APENAS os campos que
1747:         *-- mudam de linha para linha.
1748:         THIS.FormParaBO()
1749: 
1750:         loc_lExcluiu = THIS.this_oBusinessObject.ExcluirDescontosDoItem()
1751: 
1752:         IF !loc_lExcluiu
1753:             RETURN
1754:         ENDIF
1755: 
1756:         IF !USED("cursor_4c_Dados")
1757:             RETURN
1758:         ENDIF
1759: 
1760:         SELECT cursor_4c_Dados
1761:         GO TOP
1762: 
1763:         SCAN FOR NVL(Selecao, 0) = 1 AND NVL(Descos, 0) <> 0
1764:             WITH THIS.this_oBusinessObject
1765:                 *-- this_cCidChaves zerado a cada volta e' o gatilho que faz
1766:                 *-- Inserir() gerar um fUniqueIds() NOVO por linha (regra
1767:                 *-- CLAUDE.md #22) - equivalente ao "lcIdChave =
1768:                 *-- fUniqueIds()" dentro do SCAN do legado. Sem isto a
1769:                 *-- segunda linha colidiria no indice unico.
1770:                 .this_cCidChaves = ""
1771: 
1772:                 *-- Campos da LINHA corrente da grade (legado: localdes.*)
1773:                 .this_cCdesc     = cursor_4c_Dados.Codigos
1774:                 .this_cDdesc     = cursor_4c_Dados.Descrs
1775:                 .this_nPdes      = cursor_4c_Dados.Descos
1776:                 .this_nVdes      = cursor_4c_Dados.Valdes
1777:                 .this_nTpDesc    = cursor_4c_Dados.Tpdesc
1778:                 .this_cUsuars    = cursor_4c_Dados.Usuars
1779: 
1780:                 *-- Base do desconto (legado: crTpmMvItn.unitorigs)
1781:                 .this_nValBase   = THIS.this_nUnitOrigs
1782:             ENDWITH
1783: 
1784:             THIS.this_oBusinessObject.Inserir()
1785: 
1786:             SELECT cursor_4c_Dados

*-- Linhas 1813 a 1933:
1813:     * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
1814:     * desta migracao.
1815:     *
1816:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1817:     *==========================================================================
1818:     PROCEDURE Header1Click()
1819:         LOCAL loc_oHeader, loc_oErro
1820: 
1821:         TRY
1822:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1823:                 loc_oHeader = THIS.grd_4c_Dados.Column1.Header1
1824: 
1825:                 IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
1826:                     loc_oHeader.Tag = ""
1827:                     UPDATE cursor_4c_Dados SET Selecao = 0
1828:                 ELSE
1829:                     loc_oHeader.Tag = "X"
1830:                     UPDATE cursor_4c_Dados SET Selecao = 1
1831:                 ENDIF
1832: 
1833:                 THIS.grd_4c_Dados.Refresh()
1834:             ENDIF
1835:         CATCH TO loc_oErro
1836:             MsgErro(loc_oErro.Message + CHR(13) + ;
1837:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1838:                     "Procedure: " + loc_oErro.Procedure, ;
1839:                     "Erro em Header1Click")
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
1845:     * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de
1846:     * Column1 (fwcheckbox1 do legado).
1847:     *
1848:     * Regra CLAUDE.md "CheckBox em coluna de Grid": o toggle nativo NAO e'
1849:     * confiavel dentro de Column (Column.AddObject + CurrentControl +
1850:     * Sparse = .F.), entao Click/MouseDown so suprimem (NODEFAULT) e
1851:     * MouseUp/KeyPress(Enter=13/Espaco=32) sao quem de fato aciona o
1852:     * ChkSelecaoToggle - equivalente ao "clicar no checkbox" do legado, cujo
1853:     * Click comeca com "=DoDefault()" (toggle nativo) e so DEPOIS reage ao
1854:     * this.Value resultante.
1855:     *
1856:     * Todos PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1857:     *==========================================================================
1858:     PROCEDURE ChkSelecaoClick()
1859:         NODEFAULT
1860:     ENDPROC
1861: 
1862:     PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1863:         NODEFAULT
1864:     ENDPROC
1865: 
1866:     PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1867:         THIS.ChkSelecaoToggle()
1868:         NODEFAULT
1869:     ENDPROC
1870: 
1871:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1872:         IF INLIST(par_nKeyCode, 13, 32)
1873:             THIS.ChkSelecaoToggle()
1874:             NODEFAULT
1875:         ENDIF
1876:     ENDPROC
1877: 
1878:     *==========================================================================
1879:     * ChkSelecaoToggle - wrapper com TRY/CATCH de ChkSelecaoToggleExec
1880:     * (regra CLAUDE.md #1 - RETURN fica fora do TRY; o Exec tem RETURN
1881:     * antecipado e roda sem TRY proprio).
1882:     *
1883:     * PUBLIC: chamado pelos quatro handlers acima.
1884:     *==========================================================================
1885:     PROCEDURE ChkSelecaoToggle()
1886:         LOCAL loc_oErro
1887: 
1888:         TRY
1889:             THIS.ChkSelecaoToggleExec()
1890:         CATCH TO loc_oErro
1891:             MsgErro(loc_oErro.Message + CHR(13) + ;
1892:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1893:                     "Procedure: " + loc_oErro.Procedure, ;
1894:                     "Erro em ChkSelecaoToggle")
1895:         ENDTRY
1896:     ENDPROC
1897: 
1898:     *==========================================================================
1899:     * ChkSelecaoToggleExec - corpo do fwcheckbox1.Click do legado.
1900:     *
1901:     * Legado:
1902:     *
1903:     *   =DoDefault()
1904:     *   IF this.Value = 0
1905:     *       thisform.calctots() / return
1906:     *   ENDIF
1907:     *   if INLIST(localdes.tpdesc,3,4,5,11,12,13)   && desconto de gerente
1908:     *       Do Form SigOpSen With 'CANCITEM','Libera Desconto','' To _Retorno
1909:     *       llOk = ( Left( _Retorno, 1 ) = "*" )
1910:     *       If !llOk
1911:     *           MessageBox('Autorizacao nao Confirmada!!',0+48,'')
1912:     *           thisform.grade.column1.Fwcheckbox1.Value=0
1913:     *           thisform.grade.Refresh
1914:     *       ELSE
1915:     *           replace usuars with SUBSTR(_Retorno,2) in localdes
1916:     *       EndIf
1917:     *       thisform.calctots() / RETURN .t.
1918:     *   ENDIF
1919:     *   if INLIST(localdes.tpdesc,8)   && desconto supervisor
1920:     *       Do Form SigOpSen With 'LIBFPAG', ... (mesma logica)
1921:     *   ENDIF
1922:     *   if INLIST(localdes.tpdesc,9)   && desconto diretoria
1923:     *       Do Form SigOpSen With 'SDINSUF', ... (mesma logica)
1924:     *   ENDIF
1925:     *   thisform.calctots() / RETURN .t.
1926:     *
1927:     * As TRES chamadas de SigOpSen do legado sao o MESMO dialogo com
1928:     * programa (1o parametro) diferente - aqui e' um DO CASE que resolve o
1929:     * programa pelo Tpdesc e um UNICO bloco de autorizacao, sem repetir a
1930:     * logica tres vezes.
1931:     *
1932:     * SigOpSen NAO EXISTE na nova arquitetura (ver
1933:     * feedback_sigopsen_ausente_gate_autorizacao): o sigopsen.SCX so existe

*-- Linhas 1944 a 2090:
1944:     * igual ao legado: a' DoDefault() ja alternou this.Value quando o Click
1945:     * comeca a rodar.
1946:     *==========================================================================
1947:     PROTECTED PROCEDURE ChkSelecaoToggleExec()
1948:         LOCAL loc_nNovoValor, loc_nTpDesc, loc_cPrograma
1949:         LOCAL loc_cRetorno, loc_lAutorizado, loc_lDialogoAbriu, loc_cFalhaDialogo
1950:         LOCAL loc_oErroSen
1951: 
1952:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1953:             RETURN
1954:         ENDIF
1955: 
1956:         loc_nNovoValor = IIF(NVL(cursor_4c_Dados.Selecao, 0) = 0, 1, 0)
1957:         REPLACE Selecao WITH loc_nNovoValor IN cursor_4c_Dados
1958: 
1959:         IF loc_nNovoValor = 0
1960:             THIS.CalcularTotais()
1961:             RETURN
1962:         ENDIF
1963: 
1964:         loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
1965:         loc_cPrograma = ""
1966: 
1967:         DO CASE
1968:             CASE INLIST(loc_nTpDesc, 3, 4, 5, 11, 12, 13)
1969:                 loc_cPrograma = "CANCITEM"
1970:             CASE loc_nTpDesc = 8
1971:                 loc_cPrograma = "LIBFPAG"
1972:             CASE loc_nTpDesc = 9
1973:                 loc_cPrograma = "SDINSUF"
1974:         ENDCASE
1975: 
1976:         IF !EMPTY(loc_cPrograma)
1977:             loc_cRetorno      = ""
1978:             loc_cFalhaDialogo = ""
1979:             loc_lDialogoAbriu = .F.
1980: 
1981:             TRY
1982:                 DO FORM SigOpSen WITH loc_cPrograma, "Libera Desconto", "" TO loc_cRetorno
1983:                 loc_lDialogoAbriu = .T.
1984:             CATCH TO loc_oErroSen
1985:                 loc_cFalhaDialogo = loc_oErroSen.Message
1986:             ENDTRY
1987: 
1988:             CLEAR TYPEAHEAD
1989: 
1990:             loc_lAutorizado = (loc_lDialogoAbriu AND ;
1991:                                LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")
1992: 
1993:             IF !loc_lAutorizado
1994:                 IF loc_lDialogoAbriu
1995:                     MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + ;
1996:                              CHR(227) + "o Confirmada!!", "")
1997:                 ELSE
1998:                     *-- FAIL-CLOSED: sem o dialogo de senha nao se libera
1999:                     *-- nenhum desconto que exija autorizacao.
2000:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2001:                             "vel abrir a tela de autoriza" + CHR(231) + ;
2002:                             CHR(227) + "o (SigOpSen)." + CHR(13) + ;
2003:                             "O desconto N" + CHR(195) + "O foi liberado." + ;
2004:                             CHR(13) + CHR(13) + "Detalhe: " + loc_cFalhaDialogo, ;
2005:                             "Libera Desconto")
2006:                 ENDIF
2007: 
2008:                 REPLACE Selecao WITH 0 IN cursor_4c_Dados
2009:                 THIS.grd_4c_Dados.Refresh()
2010:             ELSE
2011:                 REPLACE Usuars WITH SUBSTR(loc_cRetorno, 2) IN cursor_4c_Dados
2012:             ENDIF
2013:         ENDIF
2014: 
2015:         THIS.CalcularTotais()
2016:     ENDPROC
2017: 
2018:     *==========================================================================
2019:     * ValidarPercentualDesconto - o PROCEDURE Valid de
2020:     * SIGOPDES.Grade.Column3.Text1 (celula "% Desconto").
2021:     *
2022:     * Chamado pelo Valid da subclasse txt_4c_CelPercentual, que e' o
2023:     * CurrentControl da coluna. O retorno E' o mecanismo: .F. mantem o
2024:     * cursor na celula e recusa a saida; .T. libera.
2025:     *
2026:     * PUBLIC porque quem chama e' a subclasse da celula, de FORA da classe
2027:     * do form (regra CLAUDE.md #51 - metodo chamado de fora nunca pode ser
2028:     * PROTECTED em nivel nenhum da heranca).
2029:     *
2030:     * O par wrapper + Exec existe por causa da regra CLAUDE.md #1: o corpo
2031:     * tem tres RETURN antecipados (um por regra recusada), e RETURN dentro
2032:     * de TRY/CATCH e' proibido. O wrapper fica com o TRY e com o RETURN
2033:     * unico; o Exec, sem TRY, pode usar os RETURN do legado.
2034:     *==========================================================================
2035:     PROCEDURE ValidarPercentualDesconto(par_oTxt)
2036:         LOCAL loc_lValido, loc_oErro
2037: 
2038:         loc_lValido = .T.
2039: 
2040:         TRY
2041:             loc_lValido = THIS.ValidarPercentualDescontoExec(par_oTxt)
2042:         CATCH TO loc_oErro
2043:             *-- Falha de infraestrutura NAO prende o usuario na celula: o
2044:             *-- erro e' exibido e a saida e' liberada. Recusar a saida aqui
2045:             *-- deixaria a tela travada na celula, sem o usuario ter como
2046:             *-- sair a nao ser pelo Cancelar.
2047:             loc_lValido = .T.
2048:             MsgErro(loc_oErro.Message + CHR(13) + ;
2049:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2050:                     "Procedure: " + loc_oErro.Procedure, ;
2051:                     "Erro em ValidarPercentualDesconto")
2052:         ENDTRY
2053: 
2054:         RETURN loc_lValido
2055:     ENDPROC
2056: 
2057:     *==========================================================================
2058:     * ValidarPercentualDescontoExec - corpo do Valid da coluna "% Desconto".
2059:     *
2060:     * Transcricao do legado, regra por regra:
2061:     *
2062:     *   SELECT crDesc / LOCATE for codigos = localdes.codigos
2063:     *   IF this.Value > crDesc.descosmax -> "Desconto maior que o permitido"
2064:     *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
2065:     *      -> "Desconto nao permitido para pagamento parcelado."
2066:     *   thisform.calctots()
2067:     *   IF (lnSaldo.Value < 0) or (crSigCdDes.valdes > crSigCdDes.valcota
2068:     *      and !INLIST(crDesc.tpdesc,1,2,9,11))
2069:     *      -> "Desconto maior que o permitido"
2070:     *
2071:     * O LOCATE do legado procura em crDesc a linha de MESMO codigos da
2072:     * linha corrente de localDes. Nesta arquitetura crDesc e localDes
2073:     * foram FUNDIDOS num cursor so (cursor_4c_Dados, montado por
2074:     * SigOpDesBO.CarregarDescontos: Descos/Valdes sao as colunas editaveis
2075:     * de localDes e Descosmax/Tpdesc/Codigos vem de crDesc), entao "a
2076:     * linha de crDesc com o mesmo codigos" E' a linha corrente - o LOCATE
2077:     * deixa de ser necessario em vez de ser descartado.
2078:     *
2079:     * REVERSAO SEMPRE PARA ZERO, e isso NAO e' simplificacao: o legado
2080:     * reverte com "this.Value = crDesc.descos", e crDesc.descos vale 0 em
2081:     * TODA linha - o Init legado faz "replace all descos with 0.00 in
2082:     * crDesc" e nada mais escreve nessa coluna de crDesc (os REPLACE de
2083:     * edicao e de calctots vao todos para localDes). Reverter para
2084:     * cursor_4c_Dados.Descos seria reverter para o valor que o usuario
2085:     * acabou de digitar, ou seja nao reverter nada.
2086:     *
2087:     * DIVERGENCIA CONHECIDA, de um unico tipo de desconto: o teto cobrado
2088:     * aqui e' cursor_4c_Dados.Descosmax, que para o tipo 13 (troca de
2089:     * preco) ja vem SOBRESCRITO pelo percentual da troca
2090:     * (FiltrarElegibilidade, passo 3, espelhando "replace descosmax with

*-- Linhas 2115 a 2215:
2115: 
2116:         *-- Regra 1: percentual acima do teto do tipo de desconto
2117:         IF loc_nDigitado > loc_nTeto
2118:             MsgAviso("Desconto maior que o permitido", "Aviso")
2119:             THIS.ReverterCelulaDesconto(par_oTxt)
2120:             RETURN .F.
2121:         ENDIF
2122: 
2123:         *-- Regra 2: desconto financeiro (tipo 2) nao existe em venda
2124:         *-- parcelada (legado: RECCOUNT('crPar') <> 0)
2125:         IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
2126:             MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
2127:                      "parcelado.", "Aviso")
2128:             THIS.ReverterCelulaDesconto(par_oTxt)
2129:             RETURN .F.
2130:         ENDIF
2131: 
2132:         *-- Valor aceito ate aqui: grava no cursor e recalcula os totais
2133:         REPLACE Descos WITH loc_nDigitado IN cursor_4c_Dados
2134:         THIS.CalcularTotais()
2135: 
2136:         *-- Regra 3: desconto maior que o produto (saldo negativo) ou cota
2137:         *-- da empresa estourada por um tipo que consome cota
2138:         IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
2139:            (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
2140:             MsgAviso("Desconto maior que o permitido", "Aviso")
2141:             THIS.ReverterCelulaDesconto(par_oTxt)
2142:             THIS.CalcularTotais()
2143: 
2144:             *-- Legado: "RETURN IIF(this.Value = 0, .t., .f.)" - depois da
2145:             *-- reversao o campo vale 0, logo a saida da celula e'
2146:             *-- LIBERADA (o legado nao prende o usuario numa celula que ele
2147:             *-- acabou de ver ser zerada). A expressao e' transcrita em vez
2148:             *-- de pre-resolvida para continuar valendo se a reversao
2149:             *-- deixar de ser zero.
2150:             RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
2151:         ENDIF
2152: 
2153:         RETURN .T.
2154:     ENDFUNC
2155: 
2156:     *==========================================================================
2157:     * ValidarValorDesconto - o PROCEDURE Valid de
2158:     * SIGOPDES.Grade.Column4.Text1 (celula "Valor Desconto").
2159:     *
2160:     * Mesmo contrato de ValidarPercentualDesconto: chamado pelo Valid da
2161:     * subclasse txt_4c_CelValor, PUBLIC, e o retorno governa a saida da
2162:     * celula. Par wrapper + Exec pelo mesmo motivo (regra CLAUDE.md #1).
2163:     *==========================================================================
2164:     PROCEDURE ValidarValorDesconto(par_oTxt)
2165:         LOCAL loc_lValido, loc_oErro
2166: 
2167:         loc_lValido = .T.
2168: 
2169:         TRY
2170:             loc_lValido = THIS.ValidarValorDescontoExec(par_oTxt)
2171:         CATCH TO loc_oErro
2172:             loc_lValido = .T.
2173:             MsgErro(loc_oErro.Message + CHR(13) + ;
2174:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2175:                     "Procedure: " + loc_oErro.Procedure, ;
2176:                     "Erro em ValidarValorDesconto")
2177:         ENDTRY
2178: 
2179:         RETURN loc_lValido
2180:     ENDPROC
2181: 
2182:     *==========================================================================
2183:     * ValidarValorDescontoExec - corpo do Valid da coluna "Valor Desconto".
2184:     *
2185:     * Aqui o usuario digita o VALOR e o legado o converte em percentual
2186:     * antes de validar - a formula e' TRANSCRITA (regra CLAUDE.md #17),
2187:     * inclusive o guard de divisao por zero e as 4 casas do ROUND:
2188:     *
2189:     *   lnPdes = Iif(This.Value = 0 Or (Thisform.lnvalor.Value * 100) = 0,
2190:     *                0,
2191:     *                Round(This.Value / Thisform.lnvalor.Value * 100, 4))
2192:     *   If lnPdes > crDesc.descosmax -> "Desconto maior que o permitido"
2193:     *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
2194:     *      -> "Desconto nao permitido para pagamento parcelado."
2195:     *   Replace descos With lnPdes In localdes
2196:     *   Thisform.calctots()
2197:     *   IF (lnSaldo.Value < 0) or (cota estourada e tipo consome cota)
2198:     *      -> "Desconto maior que o permitido"
2199:     *
2200:     * O teto e' cobrado sobre o PERCENTUAL derivado, nao sobre o valor: e'
2201:     * o mesmo Descosmax da coluna "% Desconto".
2202:     *
2203:     * A reversao e' feita por ReverterCelulaDesconto, que zera o percentual
2204:     * E o valor no cursor junto com o controle. O legado so atribui
2205:     * "This.Value = crDesc.valdes" e deixa a volta ao cursor para o VFP -
2206:     * mas no terceiro guard o percentual JA foi gravado com o valor
2207:     * recusado, e calctots recalcula o valor a partir dele; sem zerar o
2208:     * percentual explicitamente, o valor recusado voltaria ao cursor.
2209:     * Zerar os dois e' o estado em que o legado converge depois do
2210:     * write-back, escrito de forma deterministica em vez de depender da
2211:     * ordem em que o VFP devolve o valor do controle ao ControlSource.
2212:     *==========================================================================
2213:     PROTECTED FUNCTION ValidarValorDescontoExec(par_oTxt)
2214:         LOCAL loc_nDigitado, loc_nValor, loc_nPdes, loc_nTeto, loc_nTpDesc
2215: 

*-- Linhas 2230 a 2757:
2230: 
2231:         *-- Regra 1: percentual equivalente acima do teto do tipo
2232:         IF loc_nPdes > loc_nTeto
2233:             MsgAviso("Desconto maior que o permitido", "Aviso")
2234:             THIS.ReverterCelulaDesconto(par_oTxt)
2235:             RETURN .F.
2236:         ENDIF
2237: 
2238:         *-- Regra 2: desconto financeiro (tipo 2) em venda parcelada
2239:         IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
2240:             MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
2241:                      "parcelado.", "Aviso")
2242:             THIS.ReverterCelulaDesconto(par_oTxt)
2243:             RETURN .F.
2244:         ENDIF
2245: 
2246:         *-- Legado: "Replace descos With lnPdes In localdes" - o valor
2247:         *-- digitado passa a existir como PERCENTUAL, e e' calctots que
2248:         *-- reescreve o valor a partir dele (ROUND(valor * descos / 100, 2)).
2249:         *-- Por isso o valor gravado pode diferir em centavos do digitado:
2250:         *-- e' o comportamento do legado, nao arredondamento acrescentado.
2251:         REPLACE Descos WITH loc_nPdes IN cursor_4c_Dados
2252:         THIS.CalcularTotais()
2253: 
2254:         *-- Regra 3: saldo negativo ou cota da empresa estourada
2255:         IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
2256:            (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
2257:             MsgAviso("Desconto maior que o permitido", "Aviso")
2258:             THIS.ReverterCelulaDesconto(par_oTxt)
2259:             THIS.CalcularTotais()
2260: 
2261:             RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
2262:         ENDIF
2263: 
2264:         RETURN .T.
2265:     ENDFUNC
2266: 
2267:     *==========================================================================
2268:     * ReverterCelulaDesconto - desfaz a digitacao recusada por um dos Valid.
2269:     *
2270:     * Legado: "this.Value = crDesc.descos" (coluna %) e
2271:     * "This.Value = crDesc.valdes" (coluna Valor), seguidos de
2272:     * "this.Refresh". As duas colunas de crDesc valem 0 em toda linha (ver
2273:     * o comentario de ValidarPercentualDescontoExec), entao a reversao e'
2274:     * para ZERO nos dois casos - o legado usa nomes diferentes para o
2275:     * mesmo zero.
2276:     *
2277:     * Zera TAMBEM o cursor, nas duas colunas: o controle sozinho nao basta
2278:     * porque CalcularTotais recalcula o valor a partir do percentual do
2279:     * CURSOR, e um percentual recusado que ficasse gravado reapareceria
2280:     * como valor na proxima passagem do calculo.
2281:     *
2282:     * NAO toca em Selecao: recusar o percentual nao desmarca a linha, e
2283:     * desmarcar faria o When da celula passar a devolver .F., tirando do
2284:     * usuario a chance de corrigir o valor que ele acabou de digitar.
2285:     *==========================================================================
2286:     PROTECTED PROCEDURE ReverterCelulaDesconto(par_oTxt)
2287:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2288:             REPLACE Descos WITH 0, ;
2289:                     Valdes WITH 0 ;
2290:                 IN cursor_4c_Dados
2291:         ENDIF
2292: 
2293:         IF VARTYPE(par_oTxt) = "O"
2294:             par_oTxt.Value = 0
2295:             par_oTxt.Refresh()
2296:         ENDIF
2297:     ENDPROC
2298: 
2299:     *==========================================================================
2300:     * FormParaBO - FONTE UNICA da transferencia TELA -> BO.
2301:     *
2302:     * Reune, num lugar so, as duas coisas que esta tela precisa empurrar para
2303:     * o SigOpDesBO:
2304:     *
2305:     *   1. O CONTEXTO do movimento/item/produto que o Init recebeu por
2306:     *      parametro. No legado isso nao existia como transferencia: o BO
2307:     *      "era" o form, e as regras de elegibilidade liam TprMvCab,
2308:     *      crTpmMvItn e crProd diretamente (cursores globais do form
2309:     *      chamador). Nesta arquitetura o contexto entra pelo Init do form e
2310:     *      tem de chegar ao BO antes de qualquer consulta.
2311:     *
2312:     *   2. Os TRES TOTAIS da tela (Valor Original / Total Desconto / Saldo),
2313:     *      lidos dos TextBox. O legado tambem trata a tela como fonte: o
2314:     *      calctots le "thisform.lnvalor.value" e escreve
2315:     *      "thisform.lnSaldo.Value" / "thisform.lnTdesc.Value", e o
2316:     *      btnConfirmar grava "localdes.valdes" - sempre o que esta na TELA,
2317:     *      nunca o que veio da carga.
2318:     *
2319:     * POR QUE EXISTE: o contexto era atribuido inline em InicializarForm e as
2320:     * colunas de contexto eram reatribuidas DE NOVO dentro do SCAN de
2321:     * ConfirmarSelecaoExec. Dois lugares escrevendo as mesmas properties sao
2322:     * dois lugares para divergir em silencio (um recebe campo novo e o outro
2323:     * nao, e a gravacao passa a usar contexto velho sem erro nenhum).
2324:     *
2325:     * LEITURA DOS TEXTBOX SOB GUARDA DE EXISTENCIA: InicializarForm chama
2326:     * este metodo ANTES de ConfigurarPageFrame, porque ConfigurarTotais le
2327:     * this_oBusinessObject.this_nValor para inicializar os TextBox - ou seja,
2328:     * na primeira chamada os TextBox ainda NAO existem. Sem a guarda,
2329:     * THIS.txt_4c_LnValor estouraria "Property TXT_4C_LNVALOR is not found"
2330:     * dentro do TRY do InicializarForm, o CREATEOBJECT devolveria .F. e o
2331:     * usuario acionaria a tela sem nada acontecer e sem erro visivel. Nessa
2332:     * primeira passagem this_nValor recebe this_nUnitOrigs, que e' exatamente
2333:     * o "this.lnValor.value = crTpmMvItn.unitorigs" do Init legado.
2334:     *
2335:     * ValorNumerico em toda leitura de TextBox: InputMask pode devolver
2336:     * Caractere depois de passar por digitacao, e atribuir Caractere a uma
2337:     * property numerica do BO faria a conta seguinte estourar longe daqui.
2338:     *
2339:     * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
2340:     * "PROTECTED PROCEDURE FormParaBO()" (e' um dos hooks que
2341:     * FormBase.Salvar/Novo/Cancelar chamam por THIS.), e em VFP9 a subclasse
2342:     * NAO pode ALARGAR o escopo herdado - escrever "PROCEDURE FormParaBO"
2343:     * sem o modificador nao torna o metodo publico, so esconde que ele
2344:     * continua protegido. Medido no probe desta fase: com a declaracao sem
2345:     * modificador, PEMSTATUS(oForm, "FormParaBO", 2) devolvia .T. (protegido)
2346:     * e a chamada de fora estourava "Property FORMPARABO is not found."
2347:     *
2348:     * Consequencia pratica: este metodo so e' alcancavel de DENTRO da classe
2349:     * (sempre por THIS., regra CLAUDE.md #8). Para exercita-lo num harness, o
2350:     * caminho e' uma "DEFINE CLASS Probe... AS FormSigOpDes" com um metodo
2351:     * publico que chame THIS.FormParaBO() - subclasse alcanca membro
2352:     * protegido, script solto nao.
2353:     *
2354:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
2355:     *==========================================================================
2356:     PROTECTED PROCEDURE FormParaBO()
2357:         LOCAL loc_lSucesso, loc_oErro
2358: 
2359:         loc_lSucesso = .F.
2360: 
2361:         TRY
2362:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2363:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
2364:                         "vel para transferir os dados da tela.", ;
2365:                         "Erro em FormParaBO")
2366:             ELSE
2367:                 WITH THIS.this_oBusinessObject
2368:                     *-- Contexto do movimento/item (legado: TprMvCab e
2369:                     *-- crTpmMvItn)
2370:                     .this_cEmps       = THIS.this_cEmps
2371:                     .this_cDopes      = THIS.this_cDopes
2372:                     .this_nNumes      = THIS.this_nNumes
2373:                     .this_cContads    = THIS.this_cContads
2374:                     .this_dDatas      = THIS.this_dDatas
2375:                     .this_cEmpDopNums = THIS.this_cEmpDopNums
2376:                     .this_cCpros      = THIS.this_cCpros
2377:                     .this_nCitens     = THIS.this_nCitens
2378:                     .this_nUnitOrigs  = THIS.this_nUnitOrigs
2379:                     .this_nQtds       = THIS.this_nQtds
2380:                     .this_nTotas      = THIS.this_nTotas
2381: 
2382:                     *-- Contexto do cadastro do produto atual (legado:
2383:                     *-- crProd), consumido pelas regras de elegibilidade
2384:                     .this_cCgrus      = THIS.this_cCgrus
2385:                     .this_cSgrus      = THIS.this_cSgrus
2386:                     .this_cCodcors    = THIS.this_cCodcors
2387:                     .this_cColecoes   = THIS.this_cColecoes
2388:                     .this_cCodfinp    = THIS.this_cCodfinp
2389:                     .this_nPvens      = THIS.this_nPvens
2390:                     .this_dDtLacto    = THIS.this_dDtLacto
2391:                     .this_lForaLinha  = THIS.this_lForaLinha
2392:                     .this_nPrecode    = THIS.this_nPrecode
2393:                 ENDWITH
2394: 
2395:                 *-- Totais. Na PRIMEIRA chamada (de dentro do
2396:                 *-- InicializarForm, antes de ConfigurarTotais) os TextBox
2397:                 *-- ainda nao existem: this_nValor recebe this_nUnitOrigs, o
2398:                 *-- mesmo valor com que ConfigurarTotais nasce o campo.
2399:                 IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
2400:                     THIS.this_oBusinessObject.this_nValor = ;
2401:                         THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
2402:                 ELSE
2403:                     THIS.this_oBusinessObject.this_nValor = THIS.this_nUnitOrigs
2404:                 ENDIF
2405: 
2406:                 IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
2407:                     THIS.this_oBusinessObject.this_nTDesc = ;
2408:                         THIS.ValorNumerico(THIS.txt_4c_LnTDesc.Value)
2409:                 ENDIF
2410: 
2411:                 IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
2412:                     THIS.this_oBusinessObject.this_nSaldo = ;
2413:                         THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value)
2414:                 ENDIF
2415: 
2416:                 loc_lSucesso = .T.
2417:             ENDIF
2418:         CATCH TO loc_oErro
2419:             loc_lSucesso = .F.
2420:             MsgErro(loc_oErro.Message + CHR(13) + ;
2421:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2422:                     "Procedure: " + loc_oErro.Procedure, ;
2423:                     "Erro em FormParaBO")
2424:         ENDTRY
2425: 
2426:         RETURN loc_lSucesso
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * BOParaForm - FONTE UNICA da transferencia BO -> TELA.
2431:     *
2432:     * O inverso do FormParaBO, e com o mesmo alcance: os TRES campos de total
2433:     * da tela (Valor Original / Total Desconto / Saldo). Nao ha mais nada para
2434:     * espelhar - os campos editaveis desta tela nao sao controles do form, sao
2435:     * as CELULAS da grade, e elas leem de cursor_4c_Dados por ControlSource
2436:     * (quem repinta e' MontaGrade, nao este metodo).
2437:     *
2438:     * Legado equivalente, no fim do Init: "this.lnValor.value =
2439:     * crTpmMvItn.unitorigs" seguido de "=thisform.CalcTots()" - a tela abre
2440:     * com o Valor Original vindo do item e os outros dois ja calculados.
2441:     * Aqui o Valor Original vem de this_nValor (que FormParaBO acabou de
2442:     * resolver a partir de this_nUnitOrigs) e os outros dois das properties
2443:     * que a carga do BO deixou; CalcularTotais, chamado logo depois pelo
2444:     * CarregarLista, recalcula Total Desconto e Saldo sobre a grade ja cheia.
2445:     *
2446:     * GUARDA DE EXISTENCIA nos tres TextBox pela mesma razao do FormParaBO:
2447:     * o metodo pode rodar antes da superficie visual estar montada, e um
2448:     * "Property is not found" aqui derrubaria o Init inteiro.
2449:     *
2450:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase.prg
2451:     * declara "PROTECTED PROCEDURE BOParaForm()" e o VFP9 nao deixa a
2452:     * subclasse alargar o escopo herdado - sem o modificador o metodo ficaria
2453:     * protegido de qualquer jeito, e a declaracao mentiria para quem le.
2454:     *
2455:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
2456:     *==========================================================================
2457:     PROTECTED PROCEDURE BOParaForm()
2458:         LOCAL loc_lSucesso, loc_oErro
2459: 
2460:         loc_lSucesso = .F.
2461: 
2462:         TRY
2463:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2464:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
2465:                         "vel para atualizar os totais da tela.", ;
2466:                         "Erro em BOParaForm")
2467:             ELSE
2468:                 WITH THIS.this_oBusinessObject
2469:                     IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
2470:                         THIS.txt_4c_LnValor.Value = ;
2471:                             THIS.ValorNumerico(.this_nValor)
2472:                     ENDIF
2473: 
2474:                     IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
2475:                         THIS.txt_4c_LnTDesc.Value = ;
2476:                             THIS.ValorNumerico(.this_nTDesc)
2477:                     ENDIF
2478: 
2479:                     IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
2480:                         THIS.txt_4c_LnSaldo.Value = ;
2481:                             THIS.ValorNumerico(.this_nSaldo)
2482:                     ENDIF
2483:                 ENDWITH
2484: 
2485:                 loc_lSucesso = .T.
2486:             ENDIF
2487:         CATCH TO loc_oErro
2488:             loc_lSucesso = .F.
2489:             MsgErro(loc_oErro.Message + CHR(13) + ;
2490:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2491:                     "Procedure: " + loc_oErro.Procedure, ;
2492:                     "Erro em BOParaForm")
2493:         ENDTRY
2494: 
2495:         RETURN loc_lSucesso
2496:     ENDPROC
2497: 
2498:     *==========================================================================
2499:     * Destroy - o "PROCEDURE Release" do legado.
2500:     *
2501:     * Legado:
2502:     *
2503:     *   RELEASE pcChv, pcEDN, pcItem
2504:     *   This.Grade.RecordSource          = []
2505:     *   This.Grade.Column1.ControlSource = []
2506:     *   This.Grade.Column2.ControlSource = []
2507:     *   This.Grade.Column3.ControlSource = []
2508:     *   This.Grade.Column4.ControlSource = []
2509:     *   Use In localDes
2510:     *
2511:     * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
2512:     * contexto que elas carregavam entre o Init e os eventos vive em
2513:     * properties this_* do form e do BO, que morrem com os objetos - nao ha
2514:     * o que soltar do espaco global.
2515:     *
2516:     * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
2517:     * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
2518:     * deixa o Grid apontando para alias morto, e qualquer repintura posterior
2519:     * (o VFP repinta durante a propria destruicao da tela) acha alias
2520:     * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
2521:     * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
2522:     * grades sao nossas e os dois cursores tambem.
2523:     *
2524:     * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
2525:     * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
2526:     * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
2527:     * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
2528:     * buffer sujo.
2529:     *
2530:     * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
2531:     * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
2532:     * cadeia de heranca o menu do sistema aparece encolhido depois que este
2533:     * dialogo fecha.
2534:     *
2535:     * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
2536:     * destruicao por falha de limpeza deixaria o form pendurado.
2537:     *==========================================================================
2538:     PROCEDURE Destroy()
2539:         LOCAL loc_oErro
2540: 
2541:         TRY
2542:             *-- Solta a grade principal do cursor (legado: Grade.RecordSource
2543:             *-- e os quatro Column.ControlSource)
2544:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2545:                 WITH THIS.grd_4c_Dados
2546:                     .RecordSource          = ""
2547:                     .Column1.ControlSource = ""
2548:                     .Column2.ControlSource = ""
2549:                     .Column3.ControlSource = ""
2550:                     .Column4.ControlSource = ""
2551:                 ENDWITH
2552:             ENDIF
2553: 
2554:             *-- Solta a grade da cota (GrdCota, 3 colunas)
2555:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
2556:                 WITH THIS.grd_4c_Cota
2557:                     .RecordSource          = ""
2558:                     .Column1.ControlSource = ""
2559:                     .Column2.ControlSource = ""
2560:                     .Column3.ControlSource = ""
2561:                 ENDWITH
2562:             ENDIF
2563: 
2564:             *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
2565:             IF USED("cursor_4c_Dados")
2566:                 USE IN cursor_4c_Dados
2567:             ENDIF
2568: 
2569:             IF USED("cursor_4c_Cota")
2570:                 USE IN cursor_4c_Cota
2571:             ENDIF
2572:         CATCH TO loc_oErro
2573:             MsgErro(loc_oErro.Message + CHR(13) + ;
2574:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2575:                     "Procedure: " + loc_oErro.Procedure, ;
2576:                     "Erro em Destroy")
2577:         ENDTRY
2578: 
2579:         DODEFAULT()
2580:     ENDPROC
2581: 
2582:     *==========================================================================
2583:     * TornarControlesVisiveis - torna visiveis, recursivamente, todos os
2584:     * controles de par_oContainer (AddObject sempre cria com Visible = .F.).
2585:     * Percorre tambem Pages de PageFrame, mesmo este form nao tendo nenhum
2586:     * hoje - mantido pelo mesmo motivo do padrao canonico FormCor/FormCargo:
2587:     * um PageFrame acrescentado depois ja seria coberto.
2588:     *
2589:     * grd_4c_Cota e' EXCECAO: a visibilidade dele e' decidida pelo acesso
2590:     * GERENTE (ver AcessoGradeCota) e forcar Visible = .T. aqui exporia a
2591:     * cota de desconto da empresa para QUALQUER usuario, apagando em
2592:     * silencio a regra que o legado aplica. A recursao entra no objeto de
2593:     * qualquer forma, para os filhos dele nascerem visiveis quando o
2594:     * container voltar a ser exibido.
2595:     *==========================================================================
2596:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2597:         LOCAL loc_nI, loc_oObjeto, loc_nP
2598: 
2599:         IF VARTYPE(par_oContainer) != "O"
2600:             RETURN
2601:         ENDIF
2602: 
2603:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2604:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2605: 
2606:             IF VARTYPE(loc_oObjeto) = "O"
2607:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
2608:                    UPPER(loc_oObjeto.Name) != "GRD_4C_COTA"
2609:                     loc_oObjeto.Visible = .T.
2610:                 ENDIF
2611: 
2612:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2613:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2614:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2615:                     ENDFOR
2616:                 ENDIF
2617: 
2618:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2619:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2620:                 ENDIF
2621:             ENDIF
2622:         ENDFOR
2623:     ENDPROC
2624: 
2625: ENDDEFINE
2626: 
2627: *==============================================================================
2628: * Subclasses de celula da grade principal de FormSigOpDes
2629: *
2630: * Uma por coluna editavel/bloqueada de SIGOPDES.Grade, instaladas por
2631: * FormSigOpDes.InstalarCelulasGrade com Column.AddObject + CurrentControl.
2632: *
2633: * POR QUE SUBCLASSE: a validacao de celula de grade mora no Valid do TextBox
2634: * da coluna, e BINDEVENT em "Valid" de TextBox de Column nao e' confiavel
2635: * (regra CLAUDE.md #46); alem disso BINDEVENT DESCARTA o retorno do delegate,
2636: * e aqui o retorno E' o mecanismo - o Valid devolvendo .F. recusa a saida da
2637: * celula e o When devolvendo .F. recusa a entrada. Nenhum dos dois efeitos
2638: * sobrevive a um BINDEVENT.
2639: *
2640: * Cada subclasse so decide ENTRAR/SAIR e delega a regra ao metodo PUBLIC
2641: * correspondente do form (fonte unica): o legado tambem chama
2642: * "thisform.calctots()" de dentro dos Valid, isto e' a regra nunca morou no
2643: * controle.
2644: *
2645: * O guard PEMSTATUS existe porque estas classes vivem no mesmo arquivo do
2646: * form mas sao instanciadas pelo Grid: se um dia a celula for reusada em
2647: * outro form sem esses metodos, a ausencia vira "a celula nao valida" em vez
2648: * de "Property is not found" derrubando a tela.
2649: *==============================================================================
2650: 
2651: *------------------------------------------------------------------------------
2652: * TextBoxCelDescricaoSigOpDes_4c - celula da coluna "Descricao do Desconto"
2653: * (SIGOPDES.Grade.Column2.Text1).
2654: *
2655: * O legado declara Column2.ReadOnly = .F. e bloqueia a digitacao com
2656: * "PROCEDURE When / Return .f." no Text1 - a descricao do tipo de desconto e'
2657: * so leitura, o usuario nunca a edita.
2658: *
2659: * O "PROCEDURE GotFocus" que o dump traz neste mesmo objeto (um salto para a
2660: * coluna 3 ou 4 conforme o tpdesc da linha) e' CODIGO MORTO no legado e por
2661: * isso nao e' reproduzido: com o When devolvendo .F. a celula nunca e'
2662: * ativada, logo o GotFocus dela nunca dispara. Reproduzi-lo por outra via
2663: * (AfterRowColChange, por exemplo) ACRESCENTARIA um salto de foco que a tela
2664: * legada nao faz. O mesmo vale para o GotFocus identico de
2665: * SIGOPDES.GrdCota.Column1.Text1, que tambem tem When devolvendo .F.
2666: *------------------------------------------------------------------------------
2667: DEFINE CLASS TextBoxCelDescricaoSigOpDes_4c AS TextBox
2668: 
2669:     PROCEDURE When()
2670:         RETURN .F.
2671:     ENDPROC
2672: 
2673: ENDDEFINE
2674: 
2675: *------------------------------------------------------------------------------
2676: * TextBoxCelPercentualSigOpDes_4c - celula da coluna "% Desconto"
2677: * (SIGOPDES.Grade.Column3.Text1).
2678: *
2679: * When  legado: "RETURN localdes.selecao = 1" - so a linha MARCADA aceita
2680: *               percentual. A linha comentada logo acima dele no dump
2681: *               ("INLIST(tpdesc,1,2,3,4,5,8,9) and selecao = 1") e' a versao
2682: *               antiga da regra e fica comentada, como no legado.
2683: * Valid legado: as tres regras de teto / parcelado / saldo-e-cota, que vivem
2684: *               em FormSigOpDes.ValidarPercentualDesconto.
2685: *------------------------------------------------------------------------------
2686: DEFINE CLASS TextBoxCelPercentualSigOpDes_4c AS TextBox
2687: 
2688:     PROCEDURE When()
2689:         LOCAL loc_lPermite
2690: 
2691:         loc_lPermite = .F.
2692: 
2693:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2694:             IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
2695:                 loc_lPermite = cursor_4c_Dados.Selecao
2696:             ELSE
2697:                 loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
2698:             ENDIF
2699:         ENDIF
2700: 
2701:         RETURN loc_lPermite
2702:     ENDPROC
2703: 
2704:     PROCEDURE Valid()
2705:         LOCAL loc_lValido
2706: 
2707:         loc_lValido = .T.
2708: 
2709:         IF PEMSTATUS(THISFORM, "ValidarPercentualDesconto", 5)
2710:             loc_lValido = THISFORM.ValidarPercentualDesconto(THIS)
2711:         ENDIF
2712: 
2713:         RETURN loc_lValido
2714:     ENDPROC
2715: 
2716: ENDDEFINE
2717: 
2718: *------------------------------------------------------------------------------
2719: * TextBoxCelValorSigOpDes_4c - celula da coluna "Valor Desconto"
2720: * (SIGOPDES.Grade.Column4.Text1).
2721: *
2722: * When  legado: "RETURN localdes.selecao = 1" (o "&&RETURN .f." comentado
2723: *               abaixo dele no dump e' a versao antiga da regra).
2724: * Valid legado: converte o valor digitado em percentual e aplica as mesmas
2725: *               tres regras - vive em FormSigOpDes.ValidarValorDesconto.
2726: *------------------------------------------------------------------------------
2727: DEFINE CLASS TextBoxCelValorSigOpDes_4c AS TextBox
2728: 
2729:     PROCEDURE When()
2730:         LOCAL loc_lPermite
2731: 
2732:         loc_lPermite = .F.
2733: 
2734:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2735:             IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
2736:                 loc_lPermite = cursor_4c_Dados.Selecao
2737:             ELSE
2738:                 loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
2739:             ENDIF
2740:         ENDIF
2741: 
2742:         RETURN loc_lPermite
2743:     ENDPROC
2744: 
2745:     PROCEDURE Valid()
2746:         LOCAL loc_lValido
2747: 
2748:         loc_lValido = .T.
2749: 
2750:         IF PEMSTATUS(THISFORM, "ValidarValorDesconto", 5)
2751:             loc_lValido = THISFORM.ValidarValorDesconto(THIS)
2752:         ENDIF
2753: 
2754:         RETURN loc_lValido
2755:     ENDPROC
2756: 
2757: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDesBO.prg):
*====================================================================
* SigOpDesBO.prg
*
* Business Object para Selecao de Descontos (dialogo modal aberto a
* partir da grade de itens de um movimento de venda).
*
* Tabela gravada ao confirmar a selecao: SigMvItd (uma linha por tipo
* de desconto marcado na grade). Tabela consultada/atualizada para o
* controle de cota acumulada por empresa: SigCdDes.
*
* O item/movimento de origem (Emps/Dopes/Numes/Cpros/Citens/...) e o
* cadastro do produto atual (Cgrus/Sgrus/...) sao fornecidos pelo form
* chamador - esta nova arquitetura nao depende mais dos cursores
* globais do legado (TprMvCab/crTpmMvItn), que sao passados pelo
* FormBase chamador via parametro.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDesBO AS BusinessBase

	*-- Contexto do movimento/item (equivalente a TprMvCab/crTpmMvItn do legado)
	this_cEmps       = ""   && Emps       char(3)  - empresa do movimento
	this_cDopes      = ""   && Dopes      char(20) - documento/operacao do movimento
	this_nNumes      = 0    && Numes      numeric(6,0) - numero do movimento
	this_cContads    = ""   && Contads    char(10) - codigo da conta/cliente do movimento
	this_dDatas      = {}   && Datas      datetime - data do movimento
	this_cEmpDopNums = ""   && EmpDopNums char(29) - chave posicional Emps+Dopes+Numes (regra #42, NAO usar ALLTRIM nas partes)
	this_cCpros      = ""   && Cpros      char(14) - codigo do produto do item atual
	this_nCitens     = 0    && Citens     numeric  - numero/indice do item na lista de itens
	this_nUnitOrigs  = 0    && UnitOrigs  numeric(14,6) - valor unitario original do item (base do desconto)
	this_nQtds       = 0    && Qtds       numeric(9,3)  - quantidade do item
	this_nTotas      = 0    && Totas      numeric(11,2) - valor total do item

	*-- Cadastro do produto atual (SigCdPro), usado nas regras de elegibilidade de desconto
	this_cCgrus      = ""   && Cgrus      - grupo do produto
	this_cSgrus      = ""   && Sgrus      - subgrupo do produto
	this_cCodcors    = ""   && Codcors    - codigo da cor do produto
	this_cColecoes   = ""   && Colecoes   - codigo da colecao do produto
	this_cCodfinp    = ""   && Codfinp    - codigo do acabamento/finp do produto
	this_nPvens      = 0    && Pvens      - preco de venda atual do produto
	this_dDtLacto    = {}   && DtLacto    - data de lancamento do produto
	this_lForaLinha  = .F.  && ForaLinha  - indica produto fora de linha
	this_nPrecode    = 0    && Precode    - indica produto de/por (preco promocional)

	*-- Totais da selecao de desconto (equivalente a ThisForm.lnValor/lnSaldo/lnTDesc do legado)
	this_nValor      = 0    && Valor original do item, base do calculo de desconto
	this_nSaldo      = 0    && Saldo apos aplicar os descontos selecionados na grade
	this_nTDesc      = 0    && Soma dos valores de desconto selecionados na grade

	*-- Cota de desconto da empresa (SigCdDes), controla o limite acumulado
	this_cCodigo     = ""   && Codigo    char(10)      - PK de SigCdDes
	this_nValCota    = 0    && ValCota   numeric(11,2) - valor da cota de desconto da empresa
	this_nValDes     = 0    && ValDes    numeric(11,2) - valor de desconto ja utilizado (acumulado)
	this_nValMeta    = 0    && ValMeta   numeric(11,2) - valor da meta de venda da empresa
	this_nValCotaC   = 0    && ValCotaC  numeric(11,2) - valor da cota complementar

	*-- Soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	*-- mesmo movimento, restrita aos tipos que CONSOMEM a cota da
	*-- empresa. Equivale ao lnTDescM do calctots legado, que vem de
	*-- "SELECT crSigmvitd / SUM vdes to lnTDescM for
	*--  !INLIST(tpdesc,1,2,6,7,10,11,12,13) AND citens <> pcItem".
	*-- crSigmvitd e' cursor global do form chamador, que esta
	*-- arquitetura nao tem: a soma e' resolvida por
	*-- CarregarDescontoOutrosItens e lida pelo CalcularTotais do form.
	this_nVDescOutrosItens = 0

	*-- Linha de desconto a gravar em SigMvItd quando o usuario confirma a selecao
	this_cCidChaves  = ""   && CidChaves char(20)      - PK da linha de desconto (gerada por fUniqueIds())
	this_dDtAlts     = {}   && DtAlts    datetime      - data/hora da inclusao do desconto
	this_cCdesc      = ""   && Cdesc     char(10)      - codigo do tipo de desconto selecionado (SigOpTdz.codigos)
	this_cDdesc      = ""   && Ddesc     char(30)      - descricao do tipo de desconto selecionado
	this_nPdes       = 0    && Pdes      numeric(7,4)  - percentual de desconto aplicado
	this_nVdes       = 0    && Vdes      numeric(9,2)  - valor de desconto aplicado
	this_nValBase    = 0    && ValBase   numeric(10,2) - valor base sobre o qual o desconto foi calculado
	this_nTpDesc     = 0    && TpDesc    numeric(2,0)  - tipo de desconto (1=aniversario,2=financeiro,3=relogio,6=troca,7=updiamond,8=supervisor,9=diretoria,10=upalianca,11=extra,12=brinde,13=alteracao de preco)
	this_cUsuars     = ""   && Usuars    char(10)      - usuario que autorizou/incluiu o desconto

	*-- Colunas NOT NULL de SigMvItd que o INSERT legado NUNCA cita (regra #22 -
	*-- invisiveis no dump porque nao tem controle na tela nem property no SCX).
	*-- Sem valor proprio no legado: usar o default documentado (numeric -> 0,
	*-- char -> vazio) para nao quebrar o INSERT com "valor NULL" no SQL Server.
	this_nCitensTpDesc = 0  && CitensTpDesc numeric(4,0) - sem referencia no legado, default 0
	this_cChaveexterna = "" && ChaveExterna char(33)     - sem referencia no legado, default vazio

	*-- Contexto de ELEGIBILIDADE do item, consultado por
	*-- ConsultarContextoElegibilidade e lido por FiltrarElegibilidade.
	*-- Cada uma substitui o RECCOUNT() de um cursor auxiliar do Init
	*-- legado (ver o comentario de FiltrarElegibilidade).
	this_nQtdPromoImp  = 0  && crProPro - SigImpPr vigente para o produto
	this_nQtdAniv      = 0  && crClid   - SigCdCli.nascs no mes corrente
	this_nQtdPrecoAlt  = 0  && crPre    - SigPrPre com troca de preco em 2 dias
	this_nDescPrecoAlt = 0  && crPre.descos - percentual da troca de preco (teto do tipo 13)
	this_nQtdItdJolie  = 0  && crItdJ   - SigMvItd ja gravado com o tipo 2 do grupo configurado

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigMvItd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso
	* em RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de SigMvItd do cursor
	* para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes
	* de acessar os campos (regra #9 CLAUDE.md).
	*
	* O 2o argumento de TratarNulo e' o VALOR PADRAO devolvido quando a
	* coluna vem NULL, NAO um codigo de tipo: TratarNulo(citens, "N")
	* gravaria a STRING "N" numa property numerica e a primeira conta
	* feita com ela estouraria por tipo. Por isso cada chamada abaixo
	* passa o default do TIPO da property - "" para char, 0 para numeric
	* e {} para datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCdesc         = TratarNulo(cdesc, "")
				THIS.this_cCidChaves     = TratarNulo(cidchaves, "")
				THIS.this_nCitens        = TratarNulo(citens, 0)
				THIS.this_cCpros         = TratarNulo(cpros, "")
				THIS.this_cDdesc         = TratarNulo(ddesc, "")
				THIS.this_cDopes         = TratarNulo(dopes, "")
				THIS.this_dDtAlts        = TratarNulo(dtalts, {})
				THIS.this_cEmpDopNums    = TratarNulo(empdopnums, "")
				THIS.this_cEmps          = TratarNulo(emps, "")
				THIS.this_nNumes         = TratarNulo(numes, 0)
				THIS.this_nPdes          = TratarNulo(pdes, 0)
				THIS.this_cUsuars        = TratarNulo(usuars, "")
				THIS.this_nValBase       = TratarNulo(valbase, 0)
				THIS.this_nVdes          = TratarNulo(vdes, 0)
				THIS.this_nCitensTpDesc  = TratarNulo(citenstpdesc, 0)
				THIS.this_cCodigo        = TratarNulo(codigo, "")
				THIS.this_nTpDesc        = TratarNulo(tpdesc, 0)
				THIS.this_cChaveexterna  = TratarNulo(chaveexterna, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere nova linha de desconto em SigMvItd
	* PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida -
	* equivalente a "lcIdChave = fUniqueIds()" do btnConfirmar.Click legado.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- DtAlts = data/hora da inclusao (equivalente a DATETIME() do legado)
			THIS.this_dDtAlts = DATETIME()

			loc_cSQL = "INSERT INTO SigMvItd ("
			loc_cSQL = loc_cSQL + "cdesc, cidchaves, citens, cpros, ddesc, dopes, dtalts, empdopnums,"
			loc_cSQL = loc_cSQL + "emps, numes, pdes, usuars, valbase, vdes, citenstpdesc, codigo,"
			loc_cSQL = loc_cSQL + "tpdesc, chaveexterna"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza linha de desconto existente em SigMvItd (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			loc_cSQL = "UPDATE SigMvItd SET"
			loc_cSQL = loc_cSQL + " cdesc = " + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " ddesc = " + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pdes = " + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + " valbase = " + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + " vdes = " + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + " citenstpdesc = " + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " codigo = " + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + " tpdesc = " + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidChaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirDescontosDoItem - remove TODAS as linhas de desconto do item
	* corrente em SigMvItd, antes de btnConfirmar.Click regravar a
	* selecao atual da grade.
	*
	* Legado (btnConfirmar.Click):
	*   SELECT crsigmvitd
	*   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
	*
	* crsigmvitd e' cursor GLOBAL do form chamador (todas as linhas de
	* desconto do movimento, de TODOS os itens) - nesta arquitetura o
	* DELETE vai direto na tabela, restrito ao mesmo par cpros/citens, que
	* e' exatamente o que o FOR do legado filtra.
	*
	* PUBLIC: chamado pelo form em BtnConfirmarClick (regra #51 - metodo
	* chamado de fora nunca pode ser PROTECTED).
	*====================================================================
	PROCEDURE ExcluirDescontosDoItem()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso

		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCpros, "")))
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelItd")

			IF loc_nResult < 0
				MsgErro("Erro ao remover os descontos anteriores do item:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.ExcluirDescontosDoItem")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ContarSQL - devolve o escalar da coluna N de um SELECT COUNT(*)
	* executado no SQL Server. Centraliza o padrao
	* "SQLEXEC -> le N -> fecha cursor" usado pelas checagens de
	* elegibilidade abaixo, que no legado eram RECCOUNT() de cursores
	* auxiliares (crProPro/crClid/crItdJ).
	*
	* O cursor de apoio e' SEMPRE fechado antes e depois, para nao deixar
	* alias aberto entre chamadas (o 2o SQLEXEC no mesmo alias erraria).
	* PROTECTED - chamado so por THIS. dentro do proprio BO (regra #51).
	*====================================================================
	PROTECTED FUNCTION ContarSQL(par_cSQL)
		LOCAL loc_nTotal, loc_nResult, loc_nAliasAnt

		loc_nTotal    = 0
		loc_nAliasAnt = SELECT()

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		loc_nResult = SQLEXEC(gnConnHandle, par_cSQL, "cursor_4c_DesCnt")

		IF loc_nResult >= 0 AND USED("cursor_4c_DesCnt")
			SELECT cursor_4c_DesCnt
			IF !EOF()
				loc_nTotal = NVL(cursor_4c_DesCnt.N, 0)
			ENDIF
		ENDIF

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		IF loc_nAliasAnt > 0
			SELECT (loc_nAliasAnt)
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ContarTipoConfig - conta linhas de cursor_4c_TipoTmp (o crTipo do
	* legado: SigOpTdt cruzado com SigOpTdz) para um par Tipos/TpDesc,
	* opcionalmente restrito ao grupo informado em Codtips.
	*
	* Substitui os RECCOUNT() dos cursores auxiliares do Init legado:
	*   crTipoRe   = crTipo where tipos = 1 and tpdesc = 3   (relogio)
	*   crTipoExAl = crTipo where tipos = 1 and tpdesc = 11  (extra alianca)
	*   crTipoJ    = crTipo where tipos = 1 and tpdesc = 2   (jolie)
	*   crGrRe/crGrAl/crGrJ = o MESMO conjunto, restrito a
	*                         "cgrus do produto in (codtips)"
	*
	* par_nUsarCod e' NUMERICO (0 = conta o par Tipos/TpDesc inteiro,
	* 1 = conta so as linhas cujo Codtips casa com par_cCodTips) de
	* proposito: parametro LOGICO omitido obriga teste de PCOUNT para ser
	* lido com seguranca.
	*
	* O RECNO corrente de cursor_4c_TipoTmp e' reposto no fim - o SCAN
	* move o ponteiro e outras checagens leem o mesmo alias depois.
	*====================================================================
	PROTECTED FUNCTION ContarTipoConfig(par_nTipos, par_nTpDesc, par_nUsarCod, par_cCodTips)
		LOCAL loc_nTotal, loc_nRecAnt, loc_cCod, loc_nAliasAnt

		loc_nTotal = 0

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			loc_cCod      = IIF(VARTYPE(par_cCodTips) = "C", ALLTRIM(par_cCodTips), "")

			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					IF par_nUsarCod = 0 OR ;
					   ALLTRIM(cursor_4c_TipoTmp.Codtips) == loc_cCod
						loc_nTotal = loc_nTotal + 1
					ENDIF
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ObterCodigoTipoConfig - devolve o Codigos da PRIMEIRA linha de
	* cursor_4c_TipoTmp para o par Tipos/TpDesc informado.
	*
	* Reproduz a leitura do legado "crTipoExAl.codigos" / "crTipoJ.codigos"
	* nos DELETE condicionais: apos "SELECT * from crTipo where ... into
	* cursor crTipoXX" o ponteiro fica no TOPO, entao o que o legado le e'
	* o primeiro registro da ordenacao por cidchaves - que e' a ordenacao
	* com que cursor_4c_TipoTmp e' criado.
	*====================================================================
	PROTECTED FUNCTION ObterCodigoTipoConfig(par_nTipos, par_nTpDesc)
		LOCAL loc_cCodigo, loc_nRecAnt, loc_nAliasAnt

		loc_cCodigo = ""

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					loc_cCodigo = ALLTRIM(NVL(cursor_4c_TipoTmp.Codigos, ""))
					EXIT
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* CarregarCota - popula cursor_4c_Cota (crSigCdDes do legado) com a
	* cota de desconto da empresa do movimento: codigo, empresa, cota
	* contratada, cota ja utilizada e meta.
	*
	* No legado crSigCdDes NAO e' consultado neste form - ele chega aberto
	* do form chamador, que o monta a partir de SigCdDes. Aqui a consulta
	* e' feita no proprio BO, filtrada pela empresa do movimento
	* (this_cEmps), que e' a mesma linha que o legado exibia.
	*
	* A coluna Valdes trazida aqui e' o acumulado GRAVADO em SigCdDes;
	* CalcTots soma a ela os descontos da tela antes de exibir.
	*
	* SQLEXEC NUNCA sobre o alias ligado ao Grid (isso zeraria o
	* ColumnCount): a consulta vai para cursor_4c_CotaTmp e cursor_4c_Cota
	* e' recarregado com ZAP + APPEND FROM DBF(), que preserva estrutura,
	* RecordSource e ControlSource.
	*====================================================================
	PROCEDURE CarregarCota()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps

		loc_lSucesso = .F.

		TRY
			loc_cEmps = ALLTRIM(NVL(THIS.this_cEmps, ""))

			loc_cSQL = "SELECT ISNULL(codigo, '') AS Codigo,"
			loc_cSQL = loc_cSQL + " ISNULL(emps, '') AS Emps,"
			loc_cSQL = loc_cSQL + " ISNULL(valcota, 0) AS Valcota,"
			loc_cSQL = loc_cSQL + " ISNULL(valdes, 0) AS Valdes,"
			loc_cSQL = loc_cSQL + " ISNULL(valmeta, 0) AS Valmeta"
			loc_cSQL = loc_cSQL + " FROM SigCdDes"
			loc_cSQL = loc_cSQL + " WHERE emps = " + EscaparSQL(loc_cEmps)
			loc_cSQL = loc_cSQL + " ORDER BY codigo"

			IF USED("cursor_4c_CotaTmp")
				USE IN cursor_4c_CotaTmp
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotaTmp")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar a cota de descontos da empresa:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF !USED("cursor_4c_Cota")
					SET NULL ON
					CREATE CURSOR cursor_4c_Cota ;
						(Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
						 Codigo C(10), Valmeta N(11,2))
					SET NULL OFF
				ENDIF

				SELECT cursor_4c_Cota
				ZAP

				IF USED("cursor_4c_CotaTmp") AND RECCOUNT("cursor_4c_CotaTmp") > 0
					SELECT cursor_4c_Cota
					APPEND FROM DBF("cursor_4c_CotaTmp")
				ENDIF

				IF USED("cursor_4c_CotaTmp")
					USE IN cursor_4c_CotaTmp
				ENDIF

				SELECT cursor_4c_Cota
				GO TOP

				*-- Codigo da cota vigente: e' o "crSigcdDes.codigo" que o
				*-- btnConfirmar.Click legado grava em SigMvItd.codigo.
				IF !EOF("cursor_4c_Cota")
					THIS.this_cCodigo  = ALLTRIM(NVL(cursor_4c_Cota.Codigo, ""))
					THIS.this_nValCota = NVL(cursor_4c_Cota.Valcota, 0)
					THIS.this_nValDes  = NVL(cursor_4c_Cota.Valdes, 0)
					THIS.this_nValMeta = NVL(cursor_4c_Cota.Valmeta, 0)
				ENDIF

				*-- lnTDescM do calctots legado: os descontos ja gravados
				*-- pelos OUTROS itens do movimento entram na cota
				*-- utilizada que a grade exibe. Resolvido aqui, junto com
				*-- a cota, porque e' a mesma conta e nao muda enquanto o
				*-- dialogo esta aberto. O retorno nao condiciona o
				*-- sucesso da carga da cota: sem a soma dos outros itens
				*-- a tela ainda abre e opera, so a cota utilizada fica
				*-- sem essa parcela - e a falha de SQL ja foi exibida.
				THIS.CarregarDescontoOutrosItens()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarCota")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDescontoOutrosItens - resolve o lnTDescM do calctots legado:
	* a soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	* mesmo movimento, contando so os tipos que CONSOMEM a cota da
	* empresa.
	*
	* Legado (PROCEDURE calctots):
	*
	*   SELECT crSigmvitd
	*   GO top
	*   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
	*                            AND citens <> pcItem
	*
	* crSigmvitd e' um cursor GLOBAL do form chamador (todos os itens de
	* desconto do movimento), igual a TprMvCab/crTpmMvItn - nao existe
	* nesta arquitetura, entao a mesma conta e' feita no SQL Server com o
	* filtro IDENTICO: mesmo movimento (empdopnums), outro item
	* (citens <> this_nCitens) e a MESMA lista de tipos excluidos.
	*
	* Os oito tipos de fora sao aniversario(1), financeiro(2), troca
	* zerada(6), up diamond(7), upgrade alianca(10), extra/loja(11),
	* brinde(12) e troca de preco(13) - a lista do comentario do legado
	* ("nao entra na cota A,V,TZ,UP,UpAlianca,extra/loja,brinde,troca
	* preco"). NAO confundir com a lista do teste de ESTOURO da cota nos
	* Valid das celulas, que exclui apenas 1, 2, 9 e 11: o legado tem duas
	* listas diferentes de proposito.
	*
	* Resolvido UMA vez, na carga: esta tela edita UM item, os descontos
	* dos outros itens nao mudam enquanto o dialogo esta aberto, e o
	* legado tambem nao os reconsulta (ele so re-soma um cursor que
	* ninguem alterou entre uma chamada de calctots e a seguinte).
	*
	* A chave do movimento e' POSICIONAL (regra #42): Emps char(3) +
	* Dopes char(20) + Str(Numes, 6) = char(29). PADR explicito em cada
	* parte, NUNCA ALLTRIM - encurtar qualquer parte desloca a chave, o
	* SELECT nao casa nada e devolve ZERO linhas sem erro nenhum, o que
	* faria a cota utilizada ser calculada sem os outros itens.
	*
	* Zero linhas NAO e' falha: movimento com um unico item, ou com
	* descontos so dos tipos excluidos, soma zero - exatamente o que o
	* legado obtem com crSigmvitd vazio.
	*====================================================================
	PROCEDURE CarregarDescontoOutrosItens()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpDopNums

		loc_lSucesso = .F.

		TRY
			THIS.this_nVDescOutrosItens = 0

			loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
							  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
							  STR(NVL(THIS.this_nNumes, 0), 6)

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF

			loc_cSQL = "SELECT ISNULL(SUM(vdes), 0) AS Vdes"
			loc_cSQL = loc_cSQL + " FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
			loc_cSQL = loc_cSQL + " AND citens <> " + ;
								  FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc NOT IN (1, 2, 6, 7, 10, 11, 12, 13)"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdOutros")

			IF loc_nResult < 0
				MsgErro("Erro ao somar os descontos dos demais itens do " + ;
						"movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ItdOutros") AND ;
				   RECCOUNT("cursor_4c_ItdOutros") > 0
					SELECT cursor_4c_ItdOutros
					GO TOP
					THIS.this_nVDescOutrosItens = NVL(cursor_4c_ItdOutros.Vdes, 0)
				ENDIF

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontoOutrosItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConsultarContextoElegibilidade - executa as consultas de contexto
	* que o Init legado fazia em cursores auxiliares e guarda o resultado
	* nas propriedades this_nQtd*/this_nDescPrecoAlt.
	*
	* Equivalencia com o legado, consulta por consulta:
	*
	*   crProPro -> this_nQtdPromoImp  (SigImpPr vigente na data do
	*               movimento; havendo promocao, so sobram os tipos 8 e 9)
	*   crClid   -> this_nQtdAniv      (SigCdCli.nascs no mes corrente;
	*               sem aniversario, o tipo 1 sai)
	*   crPre    -> this_nQtdPrecoAlt / this_nDescPrecoAlt (SigPrPre com
	*               troca de preco nos ultimos 2 dias; sem troca o tipo 13
	*               sai, com troca o percentual vira o teto do tipo 13)
	*   crItdJ   -> this_nQtdItdJolie  (SigMvItd ja gravado com o desconto
	*               tipo 2 do grupo configurado para este item)
	*
	* A divisao de crPre e' feita no VFP e nao no SQL Server porque
	* "ROUND((pvens - pvensant) / pvens * 100, 2)" com pvens = 0 ABORTA a
	* query inteira no SQL Server (divide by zero); aqui o zero devolve 0
	* e o tipo 13 fica com o teto do proprio cadastro, em vez de a tela
	* inteira falhar.
	*
	* ORDEM: depende de cursor_4c_TipoTmp ja estar carregado, porque o
	* codigo do tipo 2 jolie sai de ObterCodigoTipoConfig.
	*====================================================================
	PROTECTED PROCEDURE ConsultarContextoElegibilidade()
		LOCAL loc_cSQL, loc_cCpros, loc_cContads, loc_dBase, loc_dLimite
		LOCAL loc_nResult, loc_cCodTipoJ, loc_nPvens, loc_nPvensAnt

		loc_cCpros   = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cContads = ALLTRIM(NVL(THIS.this_cContads, ""))

		*-- Data base do movimento (TprMvCab.datas no legado). Sem data no
		*-- contexto cai em DATE(), para as comparacoes de vigencia nunca
		*-- virarem comparacao com NULL (que nao casa nada em silencio).
		loc_dBase = ConverterParaData(THIS.this_dDatas)
		IF EMPTY(loc_dBase)
			loc_dBase = DATE()
		ENDIF

		*-- Legado: ldData = DTOT(TTOD(TprMvCab.datas) - 2)
		loc_dLimite = loc_dBase - 2

		THIS.this_nQtdPromoImp  = 0
		THIS.this_nQtdAniv      = 0
		THIS.this_nQtdPrecoAlt  = 0
		THIS.this_nDescPrecoAlt = 0
		THIS.this_nQtdItdJolie  = 0

		*-- crProPro: produto com promocao de importacao vigente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigImpPr"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND dtinicial <= " + FormatarDataSQL(loc_dBase)
		loc_cSQL = loc_cSQL + " AND dtfinal >= " + FormatarDataSQL(loc_dBase)
		THIS.this_nQtdPromoImp = THIS.ContarSQL(loc_cSQL)

		*-- crClid: aniversario do cliente no mes corrente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigCdCli"
		loc_cSQL = loc_cSQL + " WHERE iclis = " + EscaparSQL(loc_cContads)
		loc_cSQL = loc_cSQL + " AND nascs IS NOT NULL"
		loc_cSQL = loc_cSQL + " AND MONTH(nascs) = " + FormatarNumeroSQL(MONTH(DATE()), 0)
		THIS.this_nQtdAniv = THIS.ContarSQL(loc_cSQL)

		*-- crPre: troca de preco do produto nos ultimos 2 dias
		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		loc_cSQL = "SELECT TOP 1 ISNULL(pvens, 0) AS Pvens,"
		loc_cSQL = loc_cSQL + " ISNULL(pvensant, 0) AS Pvensant"
		loc_cSQL = loc_cSQL + " FROM SigPrPre"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND datas >= " + FormatarDataSQL(loc_dLimite)
		loc_cSQL = loc_cSQL + " ORDER BY datas DESC"

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PreTmp")

		IF loc_nResult >= 0 AND USED("cursor_4c_PreTmp")
			SELECT cursor_4c_PreTmp
			IF !EOF()
				THIS.this_nQtdPrecoAlt = RECCOUNT("cursor_4c_PreTmp")
				loc_nPvens    = NVL(cursor_4c_PreTmp.Pvens, 0)
				loc_nPvensAnt = NVL(cursor_4c_PreTmp.Pvensant, 0)
				IF loc_nPvens <> 0
					THIS.this_nDescPrecoAlt = ROUND((loc_nPvens - loc_nPvensAnt) / ;
													loc_nPvens * 100, 2)
				ENDIF
			ENDIF
		ENDIF

		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		*-- crItdJ: desconto tipo 2 do grupo configurado ja gravado para
		*-- este item (havendo, o tipo 2 permanece na grade).
		loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)

		IF !EMPTY(loc_cCodTipoJ)
			loc_cSQL = "SELECT COUNT(*) AS N FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc = 2"
			loc_cSQL = loc_cSQL + " AND cdesc = " + EscaparSQL(loc_cCodTipoJ)
			THIS.this_nQtdItdJolie = THIS.ContarSQL(loc_cSQL)
		ENDIF
	ENDPROC

	*====================================================================
	* FiltrarElegibilidade - aplica sobre par_cAlias (copia de trabalho
	* dos tipos de desconto) os DELETE de elegibilidade do Init legado,
	* na MESMA ordem em que o legado os executa.
	*
	* Mapa linha a linha com o legado:
	*
	*  1) if RECCOUNT('crItnS') = 0 -> DELETE for INLIST(tpdesc,6,7,10)
	*     crItnS e' o item de SUBNIVEL, que no legado vem do cursor
	*     crEesti aberto pelo form chamador. O contrato de Init deste form
	*     recebe o item ATUAL, nao a troca de subnivel, logo RECCOUNT = 0
	*     e os tipos de troca (6 = troca zerada, 7 = up diamond,
	*     10 = upgrade alianca) saem - exatamente o que o legado faz
	*     quando nao ha subnivel.
	*  2) if RECCOUNT('crTipoExAl') <> 0 and RECCOUNT('crGrAl') = 0
	*        -> DELETE for tpdesc = 11 and codigos = crTipoExAl.codigos
	*  3) if RECCOUNT('crPre') = 0 -> DELETE for INLIST(tpdesc,13)
	*     senao -> replace descosmax with crPre.descos for tpdesc = 13
	*  4) if RECCOUNT('crGrRe') = 0 -> DELETE for INLIST(tpdesc,3)
	*  5) if nascs vazio ou de outro mes -> DELETE for INLIST(tpdesc,1)
	*  6) if RECCOUNT('crProPro') > 0 -> DELETE for !INLIST(tpdesc,8,9)
	*  7) if RECCOUNT('crDepor') > 0 -> DELETE for !INLIST(tpdesc,2,8,9)
	*     crDepor e' "SigCdPro where cpros = X and precode <> 0", que o
	*     contexto ja traz em this_nPrecode.
	*  8) jolie -> DELETE for tpdesc = 2 and codigos = crTipoJ.codigos
	*
	* Dois DELETE do legado ficam de FORA, por motivos opostos:
	*
	*  - FORA DE LINHA: o bloco "DELETE for !INLIST(tpdesc,2,5,8,9)" esta
	*    COMENTADO no legado (*!*), com a nota "Permite descontos mesmo se
	*    produto fora de linha" - manter o comportamento comentado e' a
	*    leitura fiel, e por isso this_lForaLinha nao filtra nada aqui.
	*  - BRINDE (tipo 12): o legado so o mantem quando SigCdPmc tem
	*    promocao vigente com "valmin <= valor dos OUTROS itens do
	*    movimento"; esse somatorio vem do cursor de itens do form
	*    chamador, que nao faz parte do contrato de Init. Filtrar por um
	*    total arbitrario RETIRARIA da tela um desconto que o legado
	*    concede, entao o tipo 12 permanece e a autorizacao continua
	*    sendo cobrada no fluxo de confirmacao.
	*
	* A condicao jolie do legado tem DOIS ramos ligados por OR; aqui
	* entra apenas o primeiro ("grupo configurado no tipo 2 e o produto
	* fora desse grupo"), porque o segundo depende do mesmo somatorio de
	* itens do chamador. O ramo aplicado e' um SUBCONJUNTO do que o legado
	* apaga, logo nenhum tipo que o legado mantem e' retirado.
	*====================================================================
	PROTECTED PROCEDURE FiltrarElegibilidade(par_cAlias)
		LOCAL loc_nTipoExAl, loc_nGrupoExAl, loc_cCodExAl
		LOCAL loc_nTipoRe, loc_nGrupoRe, loc_nTipoJ, loc_nGrupoJ, loc_cCodTipoJ
		LOCAL loc_cCgrus

		loc_cCgrus = ALLTRIM(NVL(THIS.this_cCgrus, ""))

		*-- (1) sem item de subnivel: tipos de troca saem
		SELECT (par_cAlias)
		DELETE FOR INLIST(Tpdesc, 6, 7, 10)

		*-- (2) tipo 11 com grupo configurado que nao e' o do produto
		loc_nTipoExAl  = THIS.ContarTipoConfig(1, 11, 0, "")
		loc_nGrupoExAl = THIS.ContarTipoConfig(1, 11, 1, loc_cCgrus)

		IF loc_nTipoExAl <> 0 AND loc_nGrupoExAl = 0
			loc_cCodExAl = THIS.ObterCodigoTipoConfig(1, 11)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 11 AND ALLTRIM(Codigos) == loc_cCodExAl
		ENDIF

		*-- (3) tipo 13 depende de troca de preco recente
		SELECT (par_cAlias)
		IF THIS.this_nQtdPrecoAlt = 0
			DELETE FOR INLIST(Tpdesc, 13)
		ELSE
			REPLACE ALL Descosmax WITH THIS.this_nDescPrecoAlt ;
				FOR Tpdesc = 13
		ENDIF

		*-- (4) tipo 3 (relogio) depende do grupo configurado
		loc_nTipoRe  = THIS.ContarTipoConfig(1, 3, 0, "")
		loc_nGrupoRe = THIS.ContarTipoConfig(1, 3, 1, loc_cCgrus)

		SELECT (par_cAlias)
		IF loc_nTipoRe <> 0 AND loc_nGrupoRe = 0
			DELETE FOR INLIST(Tpdesc, 3)
		ENDIF

		*-- (5) tipo 1 (aniversario) depende do mes de nascimento
		SELECT (par_cAlias)
		IF THIS.this_nQtdAniv = 0
			DELETE FOR INLIST(Tpdesc, 1)
		ENDIF

		*-- (6) produto em promocao: so supervisor (8) e diretoria (9)
		SELECT (par_cAlias)
		IF THIS.this_nQtdPromoImp > 0
			DELETE FOR !INLIST(Tpdesc, 8, 9)
		ENDIF

		*-- (7) produto de/por: so financeiro (2), supervisor (8), diretoria (9)
		SELECT (par_cAlias)
		IF NVL(THIS.this_nPrecode, 0) <> 0
			DELETE FOR !INLIST(Tpdesc, 2, 8, 9)
		ENDIF

		*-- (8) tipo 2 (jolie) com grupo configurado que nao e' o do produto
		loc_nTipoJ  = THIS.ContarTipoConfig(1, 2, 0, "")
		loc_nGrupoJ = THIS.ContarTipoConfig(1, 2, 1, loc_cCgrus)

		IF loc_nTipoJ <> 0 AND loc_nGrupoJ = 0 AND THIS.this_nQtdItdJolie = 0
			loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 2 AND ALLTRIM(Codigos) == loc_cCodTipoJ
		ENDIF

		SELECT (par_cAlias)
	ENDPROC

	*====================================================================
	* MarcarDescontosGravados - pre-seleciona em par_cAlias os tipos de
	* desconto JA gravados em SigMvItd para o item corrente, trazendo o
	* percentual, o valor e o usuario que autorizou.
	*
	* Legado (fim do Init):
	*   SELECT * from crSigmvitd where cpros = lcCpros and citens = pcItem
	*                                                   into cursor crOpItd
	*   SELECT localDes / GO top / SCAN
	*       SELECT crOpItd / LOCATE for cdesc = localDes.codigos
	*       IF FOUND()
	*           replace selecao with 1              in localDes
	*           replace descos  with crOpItd.pdes   in localDes
	*           replace valdes  with crOpItd.vdes   in localDes
	*           replace usuars  with crOpItd.usuars in localDes
	*       ENDIF
	*   ENDSCAN
	*
	* O filtro ganha empdopnums (a chave posicional Emps+Dopes+Numes) em
	* cima de cpros/citens: no legado crSigmvitd JA chega do chamador
	* restrito ao movimento aberto, enquanto aqui a leitura e' direta na
	* tabela e cpros+citens sozinhos casariam o mesmo item de OUTROS
	* movimentos. A chave e' montada com PADR nas partes, NUNCA ALLTRIM -
	* ela e' POSICIONAL (3 + 20 + 6 = 29, a largura de
	* SigMvItd.empdopnums); ALLTRIM nas partes encurta a chave e o SELECT
	* devolve ZERO linhas sem nenhum erro.
	*====================================================================
	PROTECTED PROCEDURE MarcarDescontosGravados(par_cAlias)
		LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNums, loc_cCpros, loc_cCodigo

		loc_cCpros      = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
						  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
						  STR(NVL(THIS.this_nNumes, 0), 6)

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		loc_cSQL = "SELECT ISNULL(cdesc, '') AS Cdesc,"
		loc_cSQL = loc_cSQL + " ISNULL(pdes, 0) AS Pdes,"
		loc_cSQL = loc_cSQL + " ISNULL(vdes, 0) AS Vdes,"
		loc_cSQL = loc_cSQL + " ISNULL(usuars, '') AS Usuars"
		loc_cSQL = loc_cSQL + " FROM SigMvItd"
		loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
		loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdTmp")

		IF loc_nResult < 0
			MsgErro("Erro ao ler os descontos j" + CHR(225) + " gravados do item:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
		ELSE
			IF USED("cursor_4c_ItdTmp") AND RECCOUNT("cursor_4c_ItdTmp") > 0
				SELECT (par_cAlias)
				GO TOP
				SCAN
					loc_cCodigo = ALLTRIM(NVL(EVALUATE(par_cAlias + ".Codigos"), ""))

					SELECT cursor_4c_ItdTmp
					GO TOP
					LOCATE FOR ALLTRIM(cursor_4c_ItdTmp.Cdesc) == loc_cCodigo

					IF FOUND()
						SELECT (par_cAlias)
						REPLACE Selecao WITH 1, ;
								Descos  WITH NVL(cursor_4c_ItdTmp.Pdes, 0), ;
								Valdes  WITH NVL(cursor_4c_ItdTmp.Vdes, 0), ;
								Usuars  WITH ALLTRIM(NVL(cursor_4c_ItdTmp.Usuars, ""))
					ENDIF

					SELECT (par_cAlias)
				ENDSCAN
			ENDIF
		ENDIF

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		SELECT (par_cAlias)
		GO TOP
	ENDPROC

	*====================================================================
	* CarregarDescontos - popula cursor_4c_Dados (localDes do legado) com
	* os tipos de desconto que o item corrente pode receber.
	*
	* Pipeline, espelhando o Init legado:
	*
	*  1) cursor_4c_DesTmp  <- SigOpTdz cruzado com SigCdTbd pela operacao
	*                          do movimento (crDesc do legado), com a
	*                          copia de trabalho das colunas de localDes:
	*                          Selecao = 0, Valdes = 0, Descos = 0 e
	*                          Descosmax = SigOpTdz.descos (o teto que o
	*                          Valid da coluna "% Desconto" cobra). O
	*                          legado monta esse mesmo par com
	*                          "Select 0 as selecao, 000000000.00 as
	*                          valdes, descos as descosmax, * from crDesc"
	*                          seguido de "replace all descos with 0.00".
	*  2) cursor_4c_TipoTmp <- SigOpTdt cruzado com SigOpTdz (crTipo),
	*                          ordenado por cidchaves: a configuracao de
	*                          grupo de cada tipo de desconto.
	*  3) ConsultarContextoElegibilidade -> promocao / aniversario /
	*                          troca de preco / jolie ja gravado
	*  4) FiltrarElegibilidade           -> os DELETE do legado
	*  5) MarcarDescontosGravados        -> pre-selecao a partir de SigMvItd
	*  6) cursor_4c_Dados   <- ZAP + APPEND FROM DBF(copia compactada)
	*
	* Dois cuidados de SQL nas consultas 1 e 2:
	*
	*  - COLLATE DATABASE_DEFAULT em "a.codigos = c.codigos":
	*    SigOpTdz.codigos e' SQL_Latin1_General_CP1_CI_AS e
	*    SigCdTbd.codigos e' Latin1_General_CI_AS. Sem o COLLATE o SQL
	*    Server RECUSA a query inteira com conflito de ordenacao, em
	*    runtime, com o .prg compilando limpo. O join de SigOpTdt com
	*    SigOpTdz nao precisa: as duas colunas estao na mesma collation.
	*  - "a.listaemp IS NULL" no filtro do tipo 11: o legado faz
	*    "DELETE FROM crDesc where tpDesc = 11 and !listaemp like '%emp%'"
	*    e, com listaemp nulo, "!NULL" e' NULL no VFP - a linha NAO e'
	*    apagada. Omitir o IS NULL apagaria linha que o legado mantem.
	*
	* O ZAP/APPEND existe porque SQLEXEC (ou SELECT INTO CURSOR) sobre o
	* alias ligado ao Grid o fecha e recria, zerando o ColumnCount - a
	* grade viraria um retangulo branco sem cabecalho, sem erro nenhum.
	* A lista de colunas do CREATE CURSOR aqui e' a MESMA do placeholder
	* criado em FormSigOpDes.ConfigurarGrade, porque APPEND FROM casa as
	* colunas por NOME.
	*====================================================================
	PROCEDURE CarregarDescontos()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps, loc_cDopes
		LOCAL loc_cListaEmp, loc_cDeletedAnt

		loc_lSucesso = .F.

		TRY
			loc_cEmps     = ALLTRIM(NVL(THIS.this_cEmps, ""))
			loc_cDopes    = ALLTRIM(NVL(THIS.this_cDopes, ""))
			loc_cListaEmp = EscaparSQL("%" + loc_cEmps + "%")

			*-- (1) crDesc: tipos habilitados na operacao do movimento
			IF USED("cursor_4c_DesSql")
				USE IN cursor_4c_DesSql
			ENDIF

			loc_cSQL = "SELECT 0 AS Selecao,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(9,2)) AS Valdes,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(7,4)) AS Descos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descos, 0) AS Descosmax,"
			loc_cSQL = loc_cSQL + " ISNULL(a.codigos, '') AS Codigos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descrs, '') AS Descrs,"
			loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc,"
			loc_cSQL = loc_cSQL + " CAST('' AS char(10)) AS Usuars"
			loc_cSQL = loc_cSQL + " FROM SigOpTdz a"
			loc_cSQL = loc_cSQL + " INNER JOIN SigCdTbd c"
			loc_cSQL = loc_cSQL + " ON a.codigos COLLATE DATABASE_DEFAULT = c.codigos"
			loc_cSQL = loc_cSQL + " WHERE c.dopes = " + EscaparSQL(loc_cDopes)
			loc_cSQL = loc_cSQL + " AND a.tpdesc <> 0"
			loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
			loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
								  loc_cListaEmp + ")"
			loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesSql")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar os tipos de desconto da opera" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + ;
						CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Copia de trabalho READWRITE: os DELETE/REPLACE de
				*-- elegibilidade nao rodam em cursor de SQL pass-through.
				IF USED("cursor_4c_DesTmp")
					USE IN cursor_4c_DesTmp
				ENDIF
				SELECT * FROM cursor_4c_DesSql INTO CURSOR cursor_4c_DesTmp READWRITE

				IF USED("cursor_4c_DesSql")
					USE IN cursor_4c_DesSql
				ENDIF

				*-- (2) crTipo: configuracao de grupo por tipo de desconto
				IF USED("cursor_4c_TipoTmp")
					USE IN cursor_4c_TipoTmp
				ENDIF

				loc_cSQL = "SELECT ISNULL(b.codigos, '') AS Codigos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.codtips, '') AS Codtips,"
				loc_cSQL = loc_cSQL + " ISNULL(b.tipos, 0) AS Tipos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.cidchaves, '') AS Cidchaves,"
				loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc"
				loc_cSQL = loc_cSQL + " FROM SigOpTdt b"
				loc_cSQL = loc_cSQL + " INNER JOIN SigOpTdz a ON a.codigos = b.codigos"
				loc_cSQL = loc_cSQL + " WHERE a.tpdesc <> 0"
				loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
				loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
									  loc_cListaEmp + ")"
				loc_cSQL = loc_cSQL + " ORDER BY b.cidchaves"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoTmp")

				IF loc_nResult < 0
					MsgErro("Erro ao carregar a configura" + CHR(231) + CHR(227) + ;
							"o dos tipos de desconto:" + CHR(13) + ;
							CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- (3) contexto e (4) elegibilidade
					THIS.ConsultarContextoElegibilidade()
					THIS.FiltrarElegibilidade("cursor_4c_DesTmp")

					*-- Compacta: APPEND FROM respeita SET DELETED, e o
					*-- estado do ambiente nao e' garantido aqui. O SET e'
					*-- restaurado logo depois, sem macro.
					loc_cDeletedAnt = SET("DELETED")
					SET DELETED ON

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					SELECT * FROM cursor_4c_DesTmp INTO CURSOR cursor_4c_DesApp READWRITE

					IF loc_cDeletedAnt = "OFF"
						SET DELETED OFF
					ELSE
						SET DELETED ON
					ENDIF

					IF USED("cursor_4c_DesTmp")
						USE IN cursor_4c_DesTmp
					ENDIF

					*-- (5) pre-selecao do que ja esta gravado
					THIS.MarcarDescontosGravados("cursor_4c_DesApp")

					*-- (6) recarga do alias do Grid preservando a estrutura
					IF !USED("cursor_4c_Dados")
						SET NULL ON
						CREATE CURSOR cursor_4c_Dados ;
							(Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
							 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
							 Descosmax N(7,4), Usuars C(10))
						SET NULL OFF
					ENDIF

					SELECT cursor_4c_Dados
					ZAP

					IF USED("cursor_4c_DesApp") AND RECCOUNT("cursor_4c_DesApp") > 0
						SELECT cursor_4c_Dados
						APPEND FROM DBF("cursor_4c_DesApp")
					ENDIF

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					IF USED("cursor_4c_TipoTmp")
						USE IN cursor_4c_TipoTmp
					ENDIF

					SELECT cursor_4c_Dados
					GO TOP

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontos")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


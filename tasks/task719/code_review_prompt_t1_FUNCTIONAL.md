# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [METODO-INEXISTENTE] Metodo 'THIS.AcessoGradeCota()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValorNumerico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPercentualDescontoExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CotaEstourada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescontoEntraNaCota()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarValorDescontoExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cota' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cota' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2753 linhas total):

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

*-- Linhas 544 a 766:
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
582:             CREATE CURSOR cursor_4c_Cota ;
583:                 (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
584:                  Codigo C(10), Valmeta N(11,2))
585:         ENDIF
586: 
587:         THIS.AddObject("grd_4c_Cota", "Grid")
588:         loc_oGrdCota = THIS.grd_4c_Cota
589: 
590:         WITH loc_oGrdCota
591:             .ColumnCount  = 3
592:             .RecordSource = "cursor_4c_Cota"
593:             .Top          = 85
594:             .Left         = 25
595:             .Width        = 413
596:             .Height       = 39
597:             .FontName     = "Verdana"
598:             .FontSize     = 8
599:             .HeaderHeight = 22
600:             .RowHeight    = 16
601:             .ScrollBars   = 2
602:             .ReadOnly     = .T.
603:             .RecordMark   = .F.
604:             .DeleteMark   = .F.
605:             .TabIndex     = 1
606:             .Visible      = THIS.AcessoGradeCota()
607:         ENDWITH
608: 
609:         *-- Column1: Empresa (crSigCdDes.emps)
610:         WITH loc_oGrdCota.Column1
611:             .ControlSource = "cursor_4c_Cota.Emps"
612:             .Width         = 75
613:             .Movable       = .F.
614:             .Resizable     = .F.
615:             .ReadOnly      = .T.
616:             .Visible       = .T.
617:         ENDWITH
618:         WITH loc_oGrdCota.Column1.Text1
619:             .BorderStyle = 0
620:             .InputMask   = ""
621:             .Margin      = 0
622:             .ReadOnly    = .T.
623:             .ForeColor   = RGB(0, 0, 0)
624:             .BackColor   = RGB(255, 255, 255)
625:             .Visible     = .T.
626:         ENDWITH
627:         WITH loc_oGrdCota.Column1.Header1
628:             .FontName  = "Verdana"
629:             .FontSize  = 8
630:             .Alignment = 2
631:             .Caption   = "Empresa"
632:         ENDWITH
633: 
634:         *-- Column2: Cota (crSigCdDes.valcota)
635:         WITH loc_oGrdCota.Column2
636:             .ControlSource = "cursor_4c_Cota.ValCota"
637:             .Width         = 145
638:             .ReadOnly      = .T.
639:             .Visible       = .T.
640:         ENDWITH
641:         WITH loc_oGrdCota.Column2.Text1
642:             .BorderStyle = 0
643:             .Format      = "999,999,999.99"
644:             .InputMask   = ""
645:             .Margin      = 0
646:             .ReadOnly    = .T.
647:             .ForeColor   = RGB(0, 0, 0)
648:             .BackColor   = RGB(255, 255, 255)
649:         ENDWITH
650:         WITH loc_oGrdCota.Column2.Header1
651:             .FontName  = "Verdana"
652:             .FontSize  = 8
653:             .Alignment = 2
654:             .Caption   = "Cota"
655:         ENDWITH
656: 
657:         *-- Column3: Utilizada (crSigCdDes.Valdes)
658:         WITH loc_oGrdCota.Column3
659:             .ControlSource = "cursor_4c_Cota.Valdes"
660:             .Width         = 169
661:             .ReadOnly      = .T.
662:             .Visible       = .T.
663:         ENDWITH
664:         WITH loc_oGrdCota.Column3.Text1
665:             .BorderStyle = 0
666:             .Margin      = 0
667:             .ReadOnly    = .T.
668:             .ForeColor   = RGB(0, 0, 0)
669:             .BackColor   = RGB(255, 255, 255)
670:         ENDWITH
671:         WITH loc_oGrdCota.Column3.Header1
672:             .FontName  = "Verdana"
673:             .FontSize  = 8
674:             .Alignment = 2
675:             .Caption   = "Utilizada"
676:         ENDWITH
677:     ENDPROC
678: 
679:     *==========================================================================
680:     * ConfigurarGrade - grd_4c_Dados (Grade do legado): grade principal de
681:     * tipos de desconto elegiveis (localDes no legado) - 4 colunas:
682:     * checkbox de selecao / descricao / % desconto / valor desconto.
683:     *
684:     * Column1 e' checkbox puro (regra CLAUDE.md #18 - Column.AddObject NAO
685:     * basta, precisa de CurrentControl + Sparse = .F.; regra "CheckBox
686:     * .Value SEMPRE NUMERICO" - Selecao e' NUMERIC(1,0) no legado, nao
687:     * logico). Geometria/InputMask/Format de cada coluna TRANSCRITOS do
688:     * dump (SIGOPDES.Grade.ColumnN) - regra CLAUDE.md #49 (Format/InputMask
689:     * nunca descartados).
690:     *
691:     * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
692:     * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
693:     * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
694:     * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
695:     * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de
696:     * destino SigMvItd.pdes numeric(7,4) e SigMvItd.vdes numeric(9,2),
697:     * gravadas por SigOpDesBO.Inserir().
698:     *
699:     * As celulas de Column2/3/4 sao instaladas por InstalarCelulasGrade
700:     * (Fase 6/8), que poe em cada coluna uma SUBCLASSE de TextBox com o
701:     * When/Valid do legado embutido - as propriedades visuais que o dump
702:     * declara em ColumnN.Text1 passam a ser aplicadas nessa subclasse, que
703:     * e' quem desenha e edita a celula a partir do CurrentControl.
704:     *
705:     * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
706:     * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
707:     * (Fase 7/8) ficam no fim do metodo.
708:     *==========================================================================
709:     PROTECTED PROCEDURE ConfigurarGrade()
710:         LOCAL loc_oGrade
711: 
712:         *-- Estrutura inicial com a MESMA lista de colunas que
713:         *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
714:         *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
715:         *-- tambem mantem em localDes e que os fluxos de validacao e de
716:         *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
717:         *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
718:         *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
719:         *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
720:         IF !USED("cursor_4c_Dados")
721:             CREATE CURSOR cursor_4c_Dados ;
722:                 (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
723:                  Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
724:                  Descosmax N(7,4), Usuars C(10))
725:         ENDIF
726: 
727:         THIS.AddObject("grd_4c_Dados", "Grid")
728:         loc_oGrade = THIS.grd_4c_Dados
729: 
730:         WITH loc_oGrade
731:             .ColumnCount  = 4
732:             .RecordSource = "cursor_4c_Dados"
733:             .Top          = 131
734:             .Left         = 24
735:             .Width        = 748
736:             .Height       = 169
737:             .FontName     = "Verdana"
738:             .FontSize     = 8
739:             .HeaderHeight = 22
740:             .RowHeight    = 16
741:             .ScrollBars   = 2
742:             .ReadOnly     = .F.
743:             .RecordMark   = .F.
744:             .DeleteMark   = .F.
745:             .TabIndex     = 1
746:             .Visible      = .T.
747:         ENDWITH
748: 
749:         *-- Column1: checkbox de selecao (fwcheckbox1 do legado)
750:         WITH loc_oGrade.Column1
751:             .ControlSource = "cursor_4c_Dados.Selecao"
752:             .Width         = 23
753:             .Alignment     = 2
754:             .Movable       = .F.
755:             .Resizable     = .F.
756:             .ReadOnly      = .F.
757:             .Sparse        = .F.
758:             .Format        = "K!"
759:             .ForeColor     = RGB(0, 0, 0)
760:             .Visible       = .T.
761:         ENDWITH
762: 
763:         loc_oGrade.Column1.AddObject("chk_4c_Selecao", "CheckBox")
764:         WITH loc_oGrade.Column1.chk_4c_Selecao
765:             .Top       = 31
766:             .Left      = 12

*-- Linhas 785 a 848:
785:             .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
786:         ENDWITH
787: 
788:         *-- BINDEVENT do checkbox de selecao (Fase 7/8) - regra CLAUDE.md
789:         *-- "CheckBox em coluna de Grid": o toggle nativo NAO e' confiavel
790:         *-- dentro de Column, entao Click/MouseDown so suprimem (NODEFAULT) e
791:         *-- MouseUp/KeyPress(Enter/Espaco) e' quem de fato alterna, via
792:         *-- ChkSelecaoToggle - que tambem carrega a logica de autorizacao do
793:         *-- legado (SigOpSen). BINDEVENT do Header1.Click (selecionar/
794:         *-- desmarcar tudo) fica aqui tambem, por serem da mesma coluna.
795:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "Click",     THIS, "ChkSelecaoClick")
796:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseDown", THIS, "ChkSelecaoMouseDown")
797:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseUp",   THIS, "ChkSelecaoMouseUp")
798:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "KeyPress",  THIS, "ChkSelecaoKeyPress")
799:         BINDEVENT(loc_oGrade.Column1.Header1,        "Click",     THIS, "Header1Click")
800: 
801:         *-- Column2: descricao do tipo de desconto (localDes.Descrs)
802:         WITH loc_oGrade.Column2
803:             .ControlSource = "cursor_4c_Dados.Descrs"
804:             .Width         = 500
805:             .Movable       = .F.
806:             .Resizable     = .F.
807:             .ReadOnly      = .F.
808:             .Visible       = .T.
809:         ENDWITH
810:         WITH loc_oGrade.Column2.Header1
811:             .FontName  = "Verdana"
812:             .FontSize  = 8
813:             .Alignment = 2
814:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
815:         ENDWITH
816: 
817:         *-- Column3: percentual de desconto (localDes.Descos)
818:         WITH loc_oGrade.Column3
819:             .ControlSource = "cursor_4c_Dados.Descos"
820:             .Width         = 88
821:             .ReadOnly      = .F.
822:             .Visible       = .T.
823:         ENDWITH
824:         WITH loc_oGrade.Column3.Header1
825:             .FontName  = "Verdana"
826:             .FontSize  = 8
827:             .Alignment = 2
828:             .Caption   = "% Desconto"
829:         ENDWITH
830: 
831:         *-- Column4: valor do desconto (localDes.Valdes)
832:         WITH loc_oGrade.Column4
833:             .ControlSource = "cursor_4c_Dados.Valdes"
834:             .Width         = 110
835:             .ReadOnly      = .F.
836:             .Visible       = .T.
837:         ENDWITH
838:         WITH loc_oGrade.Column4.Header1
839:             .FontName  = "Verdana"
840:             .FontSize  = 8
841:             .Alignment = 2
842:             .Caption   = "Valor Desconto"
843:         ENDWITH
844: 
845:         *-- Celulas digitaveis / bloqueadas das colunas 2, 3 e 4. Fica por
846:         *-- ULTIMO porque Column.ReadOnly tem de ser definido DEPOIS de
847:         *-- Grid.ReadOnly (o do grid propaga para as colunas e sobrescreve
848:         *-- o delas - regra CLAUDE.md #46).

*-- Linhas 864 a 928:
864:     * TabIndex do dump (33 nos tres Say, 38 nos tres campos) NAO e'
865:     * transcrito, de proposito: os tres campos tem TabStop = .F. (o When
866:     * Return(.F.) do legado) e Label nao entra na tabulacao, logo o
867:     * TabIndex deles e' inerte - e atribuir TabIndex em runtime RENUMERA
868:     * os demais controles do form, o que mexeria na ordem de tabulacao
869:     * real (cmg_4c_Botoes = 2, grd_4c_Dados = 1) sem nenhum ganho.
870:     *
871:     * Os tres campos (lnValor/lnTDesc/lnSaldo) tem PROCEDURE When
872:     * Return(.F.) no legado - nunca recebem foco, sao so EXIBICAO. Aqui
873:     * isso vira ReadOnly = .T. + TabStop = .F. (equivalente: a celula nunca
874:     * entra em edicao e o Tab pula o controle), sem precisar de evento.
875:     *
876:     * Geometria/InputMask TRANSCRITOS do dump (SIGOPDES.Say2/lnValor/Say4/
877:     * lnTDesc) - regra CLAUDE.md #49 (Format/InputMask nunca descartados).
878:     * ForeColor dos labels e' RGB(90,90,90), EXPLICITO no dump (nao e' o
879:     * caso de "classe say sem ForeColor" da regra CLAUDE.md #12).
880:     *
881:     * lnValor.Value nasce de THIS.this_oBusinessObject.this_nValor - esse
882:     * valor ja foi igualado a this_nUnitOrigs em InicializarForm, que e'
883:     * exatamente o que o Init legado faz ("this.lnValor.value =
884:     * crTpmMvItn.unitorigs"). lnTDesc.Value nasce 0: o legado so o
885:     * preenche dentro do motor CalcTots (Fase 7/8), disparado por acoes do
886:     * usuario (marcar/editar uma linha da grade) que ainda nao existem.
887:     *==========================================================================
888:     PROTECTED PROCEDURE ConfigurarTotais()
889:         *-- lbl_4c_Label2 / txt_4c_LnValor: "Valor Original :" (Say2/lnValor)
890:         THIS.AddObject("lbl_4c_Label2", "Label")
891:         WITH THIS.lbl_4c_Label2
892:             .Top       = 307
893:             .Left      = 368
894:             .Height    = 15
895:             .AutoSize  = .T.
896:             .BackStyle = 0
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:             .ForeColor = RGB(90, 90, 90)
900:             .Caption   = "Valor Original :"
901:             .Visible   = .T.
902:         ENDWITH
903: 
904:         THIS.AddObject("txt_4c_LnValor", "TextBox")
905:         WITH THIS.txt_4c_LnValor
906:             .Top           = 303
907:             .Left          = 452
908:             .Width         = 98
909:             .Height        = 23
910:             .FontName      = "Verdana"
911:             .FontSize      = 8
912:             .FontBold      = .F.
913:             .Alignment     = 1
914:             .InputMask     = "999,999,999.99"
915:             .MaxLength     = 10
916:             .SpecialEffect = 1
917:             .ReadOnly      = .T.
918:             .TabStop       = .F.
919:             .Value         = THIS.this_oBusinessObject.this_nValor
920:             .Visible       = .T.
921:         ENDWITH
922: 
923:         *-- lbl_4c_Label4 / txt_4c_LnTDesc: "Total Desconto :" (Say4/lnTDesc)
924:         THIS.AddObject("lbl_4c_Label4", "Label")
925:         WITH THIS.lbl_4c_Label4
926:             .Top       = 308
927:             .Left      = 564
928:             .Height    = 15

*-- Linhas 1009 a 1055:
1009:     * paginas de cadastro.
1010:     *
1011:     * Caption dos dois labels fica em branco aqui (so o Caption real, que
1012:     * depende de THIS.Caption, e' aplicado em InicializarForm - igual ao
1013:     * Init legado).
1014:     *==========================================================================
1015:     PROTECTED PROCEDURE ConfigurarCabecalho()
1016:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
1017:         WITH THIS.cnt_4c_Cabecalho
1018:             .Top           = 0
1019:             .Left          = 0
1020:             .Width         = THIS.Width
1021:             .Height        = 80
1022:             .BackStyle     = 1
1023:             .BackColor     = RGB(100, 100, 100)
1024:             .BorderWidth   = 0
1025:             .SpecialEffect = 0
1026:             .Visible       = .T.
1027:         ENDWITH
1028: 
1029:         *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
1030:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
1031:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
1032:             .Top           = 18
1033:             .Left          = 10
1034:             .Width         = 769
1035:             .Height        = 40
1036:             .AutoSize      = .F.
1037:             .BackStyle     = 0
1038:             .WordWrap      = .T.
1039:             .Alignment     = 0
1040:             .FontName      = "Tahoma"
1041:             .FontSize      = 18
1042:             .FontBold      = .T.
1043:             .FontUnderline = .F.
1044:             .ForeColor     = RGB(0, 0, 0)
1045:             .Caption       = ""
1046:             .Visible       = .T.
1047:         ENDWITH
1048: 
1049:         *-- lblTitulo: texto branco por cima da sombra
1050:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
1051:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
1052:             .Top         = 17
1053:             .Left        = 10
1054:             .Width       = 769
1055:             .Height      = 46

*-- Linhas 1066 a 1404:
1066:             .Visible     = .T.
1067:         ENDWITH
1068:     ENDPROC
1069: 
1070:     *==========================================================================
1071:     * AcessoGradeCota - responde se a grade de cota (grd_4c_Cota) deve
1072:     * aparecer. Legado: "THIS.grdCota.Visible = fChecaAcesso('SIGCDDES',
1073:     * 'GERENTE')" - so o acesso GERENTE ve a cota da empresa.
1074:     *
1075:     * A chamada de 2 argumentos e' a do legado e esta FIEL: os 3
1076:     * parametros restantes de fChecaAcesso tem fallback proprio dentro da
1077:     * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
1078:     *
1079:     * O guard de modo existe porque fChecaAcesso abre conexao propria
1080:     * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
1081:     * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
1082:     * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
1083:     * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
1084:     * cota nao teria o que mostrar de qualquer forma.
1085:     *==========================================================================
1086:     PROTECTED FUNCTION AcessoGradeCota()
1087:         LOCAL loc_lAcesso
1088: 
1089:         loc_lAcesso = .F.
1090: 
1091:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
1092:            (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
1093:             loc_lAcesso = fChecaAcesso("SIGCDDES", "GERENTE")
1094:         ENDIF
1095: 
1096:         RETURN loc_lAcesso
1097:     ENDFUNC
1098: 
1099:     *==========================================================================
1100:     * CarregarLista - carga das duas grades da tela, no mesmo ponto do
1101:     * fluxo em que o Init legado as popula.
1102:     *
1103:     * Legado: o Init monta crDesc/crTipo/localDes e crSigCdDes e termina
1104:     * ligando cada grade ao seu cursor
1105:     * ("This.Grade.RecordSource = [localDes]" e
1106:     *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
1107:     * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
1108:     * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
1109:     * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
1110:     * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
1111:     *
1112:     * PUBLIC de proposito: o harness de teste automatizado chama
1113:     * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
1114:     * para metodo PROTECTED e a chamada real falharia em runtime).
1115:     *
1116:     * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
1117:     *==========================================================================
1118:     PROCEDURE CarregarLista()
1119:         LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro
1120: 
1121:         loc_lSucesso = .F.
1122: 
1123:         TRY
1124:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1125:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1126:                         "vel para carregar os descontos.", "Erro em CarregarLista")
1127:             ELSE
1128:                 *-- A cota vem PRIMEIRO: CarregarCota resolve this_cCodigo
1129:                 *-- (o codigo da cota vigente), que a gravacao dos
1130:                 *-- descontos selecionados consome.
1131:                 loc_lCota      = THIS.this_oBusinessObject.CarregarCota()
1132:                 loc_lDescontos = THIS.this_oBusinessObject.CarregarDescontos()
1133: 
1134:                 *-- Repintar SEMPRE, inclusive quando a carga falha: a
1135:                 *-- grade pode estar exibindo o conteudo de uma carga
1136:                 *-- anterior, e popular cursor nao repinta grade sozinho.
1137:                 THIS.MontaGrade()
1138: 
1139:                 *-- BO -> tela: o Valor Original (legado: "this.lnValor.value
1140:                 *-- = crTpmMvItn.unitorigs") e os dois totais que a carga do
1141:                 *-- BO deixou nas properties. Tem de rodar ANTES do
1142:                 *-- CalcularTotais, porque CalcularTotais LE
1143:                 *-- txt_4c_LnValor.Value como base do rateio - inverter a
1144:                 *-- ordem calcularia percentual sobre o valor da carga
1145:                 *-- anterior, sem erro nenhum na tela.
1146:                 THIS.BOParaForm()
1147: 
1148:                 *-- O Init legado termina com "=thisform.CalcTots()": a
1149:                 *-- tela abre com Total Desconto / Saldo ja refletindo os
1150:                 *-- descontos que MarcarDescontosGravados pre-selecionou, e
1151:                 *-- a cota utilizada ja somada. Sem esta chamada os tres
1152:                 *-- campos de total abririam zerados sobre uma grade com
1153:                 *-- linhas marcadas - divergencia muda, porque nada falha.
1154:                 THIS.CalcularTotais()
1155: 
1156:                 loc_lSucesso = loc_lCota AND loc_lDescontos
1157:             ENDIF
1158:         CATCH TO loc_oErro
1159:             loc_lSucesso = .F.
1160:             MsgErro(loc_oErro.Message + CHR(13) + ;
1161:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1162:                     "Procedure: " + loc_oErro.Procedure, ;
1163:                     "Erro em CarregarLista")
1164:         ENDTRY
1165: 
1166:         RETURN loc_lSucesso
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * MontaGrade - funil UNICO de repintura das duas grades.
1171:     *
1172:     * Popular um cursor NAO faz a grade ligada a ele exibir as linhas: o
1173:     * legado sempre fecha a carga com "Go Top In <cursor>" +
1174:     * "<grade>.Refresh", e sem isso a grade fica visualmente vazia com o
1175:     * cursor cheio - sintoma que manda o diagnostico para SQL/permissao.
1176:     * Por isso a repintura mora aqui e e' chamada por TODO caminho que
1177:     * popula os cursores.
1178:     *
1179:     * ColumnCount NAO e' reatribuido: qualquer atribuicao a ColumnCount
1180:     * recria os objetos Column e DESTRUIRIA o CheckBox posto por
1181:     * AddObject em Column1 (com ele, a coluna de selecao da grade).
1182:     *
1183:     * O rebind completo (RecordSource -> ControlSource -> Width ->
1184:     * Header1.Caption -> CurrentControl/Sparse) so roda quando o
1185:     * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
1186:     * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
1187:     * seria apagar o que ConfigurarGrade acabou de montar. Na carga
1188:     * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
1189:     * Refresh.
1190:     *==========================================================================
1191:     PROCEDURE MontaGrade()
1192:         LOCAL loc_oGrade, loc_oGrdCota, loc_oErro
1193: 
1194:         TRY
1195:             *-- Grade principal de descontos
1196:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1197:                 loc_oGrade = THIS.grd_4c_Dados
1198: 
1199:                 IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
1200:                     THIS.VincularGrade()
1201:                 ENDIF
1202: 
1203:                 SELECT cursor_4c_Dados
1204:                 GO TOP
1205:                 loc_oGrade.Refresh()
1206:             ENDIF
1207: 
1208:             *-- Grade da cota da empresa
1209:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
1210:                 loc_oGrdCota = THIS.grd_4c_Cota
1211: 
1212:                 IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
1213:                     THIS.VincularGradeCota()
1214:                 ENDIF
1215: 
1216:                 SELECT cursor_4c_Cota
1217:                 GO TOP
1218:                 loc_oGrdCota.Refresh()
1219:             ENDIF
1220: 
1221:             *-- Volta o alias corrente para a grade principal, que e' a
1222:             *-- que recebe o foco e de onde os eventos de celula leem.
1223:             IF USED("cursor_4c_Dados")
1224:                 SELECT cursor_4c_Dados
1225:             ENDIF
1226:         CATCH TO loc_oErro
1227:             MsgErro(loc_oErro.Message + CHR(13) + ;
1228:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1229:                     "Procedure: " + loc_oErro.Procedure, ;
1230:                     "Erro em MontaGrade")
1231:         ENDTRY
1232:     ENDPROC
1233: 
1234:     *==========================================================================
1235:     * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
1236:     * que a atribuicao de RecordSource reseta.
1237:     *
1238:     * Atribuir RecordSource devolve Column.Width ao default 90, limpa
1239:     * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
1240:     * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
1241:     * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
1242:     * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
1243:     * dump em ConfigurarGrade.
1244:     *
1245:     * ColumnCount fica de fora: reatribui-lo recriaria os Column e
1246:     * destruiria o CheckBox de Column1.
1247:     *==========================================================================
1248:     PROTECTED PROCEDURE VincularGrade()
1249:         LOCAL loc_oGrade
1250: 
1251:         loc_oGrade = THIS.grd_4c_Dados
1252: 
1253:         *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
1254:         *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
1255:         *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
1256:         *-- unico jeito de marcar a linha. Por isso, aqui:
1257:         *-- NAO reatribuir ColumnCount.
1258:         loc_oGrade.RecordSource = "cursor_4c_Dados"
1259: 
1260:         loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
1261:         loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1262:         loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
1263:         loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"
1264: 
1265:         loc_oGrade.Column1.Width = 23
1266:         loc_oGrade.Column2.Width = 500
1267:         loc_oGrade.Column3.Width = 88
1268:         loc_oGrade.Column4.Width = 110
1269: 
1270:         loc_oGrade.Column1.Header1.Caption = ""
1271:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
1272:                                              "o do Desconto"
1273:         loc_oGrade.Column3.Header1.Caption = "% Desconto"
1274:         loc_oGrade.Column4.Header1.Caption = "Valor Desconto"
1275: 
1276:         *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
1277:         *-- CheckBox de selecao, apesar de existir, nao aparece; sem
1278:         *-- Sparse = .F. ele apareceria so na linha ativa.
1279:         IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
1280:             loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
1281:         ENDIF
1282:         loc_oGrade.Column1.Sparse = .F.
1283: 
1284:         *-- As celulas de Column2/3/4 tambem se perdem no rebind
1285:         *-- (RecordSource derruba CurrentControl), e sem elas a coluna de
1286:         *-- descricao voltaria a aceitar digitacao e as duas colunas
1287:         *-- editaveis perderiam o When/Valid do legado. InstalarCelulasGrade
1288:         *-- e' idempotente: so chama AddObject quando o objeto nao existe.
1289:         THIS.InstalarCelulasGrade(loc_oGrade)
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
1294:     * que a atribuicao de RecordSource reseta (mesma regra de ordem de
1295:     * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
1296:     * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
1297:     * natural, com as larguras e captions do dump.
1298:     *
1299:     * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
1300:     * as colunas e sobrescreveria o das colunas.
1301:     *==========================================================================
1302:     PROTECTED PROCEDURE VincularGradeCota()
1303:         LOCAL loc_oGrdCota
1304: 
1305:         loc_oGrdCota = THIS.grd_4c_Cota
1306: 
1307:         *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
1308:         *-- larguras do dump sao montadas por ConfigurarGradeCota, e
1309:         *-- reatribuir ColumnCount as recriaria do zero.
1310:         loc_oGrdCota.RecordSource = "cursor_4c_Cota"
1311: 
1312:         loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
1313:         loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
1314:         loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"
1315: 
1316:         loc_oGrdCota.Column1.Width = 75
1317:         loc_oGrdCota.Column2.Width = 145
1318:         loc_oGrdCota.Column3.Width = 169
1319: 
1320:         loc_oGrdCota.Column1.Header1.Caption = "Empresa"
1321:         loc_oGrdCota.Column2.Header1.Caption = "Cota"
1322:         loc_oGrdCota.Column3.Header1.Caption = "Utilizada"
1323: 
1324:         loc_oGrdCota.ReadOnly         = .T.
1325:         loc_oGrdCota.Column1.ReadOnly = .T.
1326:         loc_oGrdCota.Column2.ReadOnly = .T.
1327:         loc_oGrdCota.Column3.ReadOnly = .T.
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * InstalarCelulasGrade - poe em Column2/3/4 da grade principal a
1332:     * SUBCLASSE de TextBox que carrega o When/Valid daquela celula no
1333:     * legado, e liga cada uma por CurrentControl.
1334:     *
1335:     * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao
1336:     * de celula de grade mora no Valid do TextBox da coluna, e BINDEVENT
1337:     * em "Valid" de TextBox de Column nao e' confiavel - alem disso o
1338:     * BINDEVENT DESCARTA o retorno do delegate, e aqui o retorno e' o
1339:     * mecanismo: o Valid devolvendo .F. e' o que mantem o cursor na celula
1340:     * depois de recusar o valor digitado, e o When devolvendo .F. e' o que
1341:     * impede a entrada na celula. Nenhum dos dois efeitos sobrevive a um
1342:     * BINDEVENT. AfterRowColChange tambem nao serve: ele dispara DEPOIS de
1343:     * entrar na celula nova e o indice que ele recebe e' o da coluna de
1344:     * DESTINO, nao o da coluna que o usuario acabou de deixar.
1345:     *
1346:     * Column.AddObject NAO basta para o controle aparecer (regra CLAUDE.md
1347:     * #18): sem CurrentControl a coluna continua desenhando o Text1 dela, o
1348:     * objeto existe, responde a PEMSTATUS e o When/Valid nunca roda. Por
1349:     * isso as propriedades visuais que o dump declara em ColumnN.Text1 sao
1350:     * aplicadas AQUI, na subclasse - ela e' que passa a desenhar a celula.
1351:     *
1352:     * Sparse fica no default (.T.) nas tres colunas, como no dump (que so
1353:     * declara Sparse em Column1, a do CheckBox): as subclasses sao TextBox
1354:     * e desenham igual ao Text1 que substituem, e o When/Valid de uma
1355:     * Column roda na celula ATIVA, que e' justamente o que Sparse = .T. ja
1356:     * instancia. Forcar Sparse = .F. aqui instanciaria um controle por
1357:     * linha visivel sem mudar nada do que se ve.
1358:     *
1359:     * IDEMPOTENTE de proposito: AddObject duas vezes com o mesmo nome no
1360:     * mesmo alvo estoura "Object is already defined" e derrubaria o Init.
1361:     * VincularGrade chama este metodo depois de cada rebind, porque
1362:     * atribuir RecordSource derruba CurrentControl.
1363:     *==========================================================================
1364:     PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
1365:         IF VARTYPE(par_oGrade) != "O"
1366:             RETURN
1367:         ENDIF
1368: 
1369:         *-- Column2: descricao do tipo de desconto. O legado NAO usa
1370:         *-- ReadOnly aqui (o dump declara Column2.ReadOnly = .F.) - quem
1371:         *-- bloqueia a digitacao e' o "When / Return .f." do Text1, e e'
1372:         *-- esse o mecanismo reproduzido. Transcrever so o ReadOnly = .F.
1373:         *-- do dump e parar ai deixaria a descricao do desconto EDITAVEL.
1374:         IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelDescricao", 5)
1375:             par_oGrade.Column2.AddObject("txt_4c_CelDescricao", ;
1376:                                           "TextBoxCelDescricaoSigOpDes_4c")
1377:         ENDIF
1378:         WITH par_oGrade.Column2.txt_4c_CelDescricao
1379:             .BorderStyle = 0
1380:             .InputMask   = ""
1381:             .Margin      = 0
1382:             .ReadOnly    = .F.
1383:             .ForeColor   = RGB(0, 0, 0)
1384:             .BackColor   = RGB(255, 255, 255)
1385:             .Visible     = .T.
1386:         ENDWITH
1387:         par_oGrade.Column2.CurrentControl = "txt_4c_CelDescricao"
1388: 
1389:         *-- Column3: percentual de desconto (localDes.Descos)
1390:         IF !PEMSTATUS(par_oGrade.Column3, "txt_4c_CelPercentual", 5)
1391:             par_oGrade.Column3.AddObject("txt_4c_CelPercentual", ;
1392:                                           "TextBoxCelPercentualSigOpDes_4c")
1393:         ENDIF
1394:         WITH par_oGrade.Column3.txt_4c_CelPercentual
1395:             .BorderStyle = 0
1396:             .InputMask   = "999.99"
1397:             .Margin      = 0
1398:             .ForeColor   = RGB(0, 0, 0)
1399:             .BackColor   = RGB(255, 255, 255)
1400:             .Visible     = .T.
1401:         ENDWITH
1402:         par_oGrade.Column3.CurrentControl = "txt_4c_CelPercentual"
1403: 
1404:         *-- Column4: valor do desconto (localDes.Valdes)

*-- Linhas 1470 a 1797:
1470: 
1471:     *==========================================================================
1472:     * CotaEstourada - responde se a cota de desconto da empresa foi
1473:     * excedida. Legado: "crSigCdDes.valdes > crSigCdDes.valcota".
1474:     *
1475:     * Le cursor_4c_Cota (crSigCdDes do legado) na linha corrente, que
1476:     * CarregarCota deixa posicionada na empresa do movimento e
1477:     * CalcularTotais mantem atualizada. Cota ausente (cursor vazio) NAO
1478:     * bloqueia: o legado, com crSigCdDes vazio, compara dois campos
1479:     * inexistentes e o teste da .F. - recusar a gravacao por falta de
1480:     * cadastro de cota seria inventar bloqueio.
1481:     *==========================================================================
1482:     PROTECTED FUNCTION CotaEstourada()
1483:         LOCAL loc_lEstourou
1484: 
1485:         loc_lEstourou = .F.
1486: 
1487:         IF USED("cursor_4c_Cota") AND !EOF("cursor_4c_Cota")
1488:             loc_lEstourou = (NVL(cursor_4c_Cota.Valdes, 0) > ;
1489:                              NVL(cursor_4c_Cota.Valcota, 0))
1490:         ENDIF
1491: 
1492:         RETURN loc_lEstourou
1493:     ENDFUNC
1494: 
1495:     *==========================================================================
1496:     * CalcularTotais - o PROCEDURE calctots do legado.
1497:     *
1498:     * Motor de totais da tela: normaliza a linha corrente, soma os
1499:     * descontos, atualiza a cota utilizada da empresa e escreve os tres
1500:     * campos de total. TRANSCRITO linha a linha (regra CLAUDE.md #17 - a
1501:     * formula, o ROUND, o /100 e o SINAL sao regra de negocio):
1502:     *
1503:     *   replace descos with IIF(selecao = 0, 00.0000, descos)
1504:     *   replace valdes with IIF(selecao = 0, 000000000.00,
1505:     *                           ROUND(lnvalor.value * descos / 100, 2))
1506:     *   lnReg = IIF(EOF('localdes'), 0, RECNO())
1507:     *   GO top / SUM valdes to lnTDesc
1508:     *   GO top / SUM valdes to lnTDescI for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1509:     *   SELECT crSigmvitd / GO top
1510:     *   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1511:     *                           AND citens <> pcItem
1512:     *   replace valdes with crValdes.vdes + lnTDescI + lnTDescM in crSigCdDes
1513:     *   lnSaldo = lnvalor.value - lnTDesc
1514:     *   lnSaldo.Value = lnSaldo / lnTdesc.Value = lnTDesc
1515:     *   IF lnReg <> 0 / GO lnReg / endif
1516:     *   thisform.Refresh
1517:     *
1518:     * Os dois primeiros REPLACE sao SEM escopo no legado, isto e' valem
1519:     * para a linha CORRENTE e nao para o cursor inteiro - quem muda e' a
1520:     * linha que o usuario acabou de marcar ou editar.
1521:     *
1522:     * lnTDescM (descontos JA GRAVADOS dos OUTROS itens do movimento) vem
1523:     * de crSigmvitd, cursor global do form chamador que esta arquitetura
1524:     * nao tem: a soma e' resolvida uma vez na carga por
1525:     * SigOpDesBO.CarregarDescontoOutrosItens e lida aqui da propriedade
1526:     * this_nVDescOutrosItens. Uma vez e' suficiente e nao e' atalho - esta
1527:     * tela edita UM item, os outros nao mudam enquanto o dialogo esta
1528:     * aberto, e o legado tambem nao os reconsulta (ele so re-soma um
1529:     * cursor que ninguem alterou).
1530:     *
1531:     * A base da cota (crValdes.vdes do legado) e' lida de this_nValDes e
1532:     * NAO de cursor_4c_Cota.Valdes, porque esta mesma rotina SOBRESCREVE
1533:     * essa coluna do cursor: ler dali faria a cota utilizada crescer de
1534:     * forma acumulada a cada tecla digitada.
1535:     *
1536:     * RECNO e' salvo e reposto porque SUM varre o cursor inteiro e deixa o
1537:     * ponteiro em EOF - sem repor, a linha que o usuario esta editando
1538:     * deixaria de ser a linha corrente no meio do proprio Valid.
1539:     *
1540:     * PUBLIC: os eventos da Fase 7/8 (Click do checkbox de cada linha,
1541:     * Header1.Click de selecionar-tudo) acionam este metodo de fora.
1542:     *==========================================================================
1543:     PROCEDURE CalcularTotais()
1544:         LOCAL loc_nReg, loc_nSaldo, loc_nTDesc, loc_nTDescI, loc_nTDescM
1545:         LOCAL loc_nValor, loc_nBaseCota, loc_oErro
1546: 
1547:         TRY
1548:             IF !USED("cursor_4c_Dados")
1549:                 MsgErro("Cursor de descontos indispon" + CHR(237) + "vel " + ;
1550:                         "para calcular os totais.", "Erro em CalcularTotais")
1551:             ELSE
1552:                 loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
1553: 
1554:                 SELECT cursor_4c_Dados
1555: 
1556:                 *-- Linha corrente: desmarcada zera os dois campos, marcada
1557:                 *-- recalcula o valor a partir do percentual.
1558:                 IF !EOF("cursor_4c_Dados")
1559:                     IF NVL(cursor_4c_Dados.Selecao, 0) = 0
1560:                         REPLACE Descos WITH 0, ;
1561:                                 Valdes WITH 0 ;
1562:                             IN cursor_4c_Dados
1563:                     ELSE
1564:                         REPLACE Valdes WITH ROUND(loc_nValor * ;
1565:                                 NVL(cursor_4c_Dados.Descos, 0) / 100, 2) ;
1566:                             IN cursor_4c_Dados
1567:                     ENDIF
1568:                 ENDIF
1569: 
1570:                 loc_nReg = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))
1571: 
1572:                 *-- Total de desconto do item: TODAS as linhas
1573:                 GO TOP IN cursor_4c_Dados
1574:                 SUM cursor_4c_Dados.Valdes TO loc_nTDesc
1575: 
1576:                 *-- Parcela que CONSOME a cota da empresa: ficam de fora
1577:                 *-- aniversario(1), financeiro(2), troca zerada(6),
1578:                 *-- up diamond(7), upgrade alianca(10), extra/loja(11),
1579:                 *-- brinde(12) e troca de preco(13).
1580:                 GO TOP IN cursor_4c_Dados
1581:                 SUM cursor_4c_Dados.Valdes TO loc_nTDescI ;
1582:                     FOR !INLIST(NVL(cursor_4c_Dados.Tpdesc, 0), ;
1583:                                 1, 2, 6, 7, 10, 11, 12, 13)
1584: 
1585:                 loc_nTDescM   = 0
1586:                 loc_nBaseCota = 0
1587: 
1588:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1589:                     loc_nTDescM   = THIS.ValorNumerico( ;
1590:                         THIS.this_oBusinessObject.this_nVDescOutrosItens)
1591:                     loc_nBaseCota = THIS.ValorNumerico( ;
1592:                         THIS.this_oBusinessObject.this_nValDes)
1593:                 ENDIF
1594: 
1595:                 *-- Cota utilizada da empresa = acumulado gravado em
1596:                 *-- SigCdDes + o que esta tela esta aplicando neste item +
1597:                 *-- o que os outros itens do movimento ja gravaram.
1598:                 IF USED("cursor_4c_Cota") AND !EOF("cursor_4c_Cota")
1599:                     REPLACE Valdes WITH loc_nBaseCota + loc_nTDescI + loc_nTDescM ;
1600:                         IN cursor_4c_Cota
1601:                 ENDIF
1602: 
1603:                 *-- SINAL preservado: o legado NAO zera saldo negativo - e'
1604:                 *-- justamente o saldo negativo que os Valid das celulas
1605:                 *-- testam para recusar desconto maior que o produto.
1606:                 loc_nSaldo = loc_nValor - loc_nTDesc
1607: 
1608:                 THIS.txt_4c_LnTDesc.Value = loc_nTDesc
1609:                 THIS.txt_4c_LnSaldo.Value = loc_nSaldo
1610: 
1611:                 *-- Espelho no BO: a gravacao le os totais de la, e deixar
1612:                 *-- a tela como unica fonte faria o registro gravar os
1613:                 *-- valores da carga em vez dos que estao na tela.
1614:                 *--
1615:                 *-- Pelo FormParaBO, nao por atribuicao direta: os TextBox
1616:                 *-- acabaram de receber os valores novos, e FormParaBO e' o
1617:                 *-- unico lugar que sabe le-los (inclusive tolerando o
1618:                 *-- Caractere que o InputMask pode devolver). Atribuir aqui
1619:                 *-- tambem deixaria DOIS lugares espelhando as mesmas
1620:                 *-- properties, que foi exatamente o que esta fase desfez.
1621:                 THIS.FormParaBO()
1622: 
1623:                 SELECT cursor_4c_Dados
1624:                 IF loc_nReg <> 0 AND loc_nReg <= RECCOUNT("cursor_4c_Dados")
1625:                     GO loc_nReg IN cursor_4c_Dados
1626:                 ENDIF
1627: 
1628:                 THIS.Refresh()
1629:             ENDIF
1630:         CATCH TO loc_oErro
1631:             MsgErro(loc_oErro.Message + CHR(13) + ;
1632:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1633:                     "Procedure: " + loc_oErro.Procedure, ;
1634:                     "Erro em CalcularTotais")
1635:         ENDTRY
1636:     ENDPROC
1637: 
1638:     *==========================================================================
1639:     * BtnCancelarClick - cmg_4c_Botoes.Buttons(1) (Command1 do dump).
1640:     *
1641:     * Legado: "PROCEDURE btnSair.Click / ThisForm.Release" - nenhuma outra
1642:     * logica, nenhuma confirmacao. Cancelar fecha o dialogo sem gravar nada.
1643:     *
1644:     * POR QUE "Cancelar" E NAO "Sair": o handler e' nomeado pela ACAO que o
1645:     * usuario ve, nao pelo nome do objeto legado. O dump de SIGOPDES.cntBotoes
1646:     * da' a Command1 "Caption = \<Cancelar", "ToolTipText = [Esc] Encerrar" e
1647:     * "Cancel = .T." - o botao na tela diz CANCELAR; "btnSair" e' so o .Name
1648:     * interno do objeto no SCX. Herdar o nome do objeto faria o metodo divergir
1649:     * do que a tela mostra e do nome canonico do pipeline para o caminho de
1650:     * "fechar sem gravar".
1651:     *
1652:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1653:     *==========================================================================
1654:     PROCEDURE BtnCancelarClick()
1655:         THIS.Release()
1656:     ENDPROC
1657: 
1658:     *==========================================================================
1659:     * BtnConfirmarClick - cmg_4c_Botoes.Buttons(2) (btnConfirmar do legado).
1660:     *
1661:     * Legado (PROCEDURE btnConfirmar.Click):
1662:     *
1663:     *   ThisForm.Grade.Refresh
1664:     *   Select localDes / Go Top In localDes / ThisForm.Grade.Refresh
1665:     *   SELECT crsigmvitd
1666:     *   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
1667:     *   Select localDes / DELETE ALL for descos = 0 / GO top
1668:     *   SCAN
1669:     *       If (localDes.Selecao = 1)
1670:     *           lcIdChave = fUniqueIds()
1671:     *           INSERT into crSigmvItd (...) values (...)
1672:     *       ENDIF
1673:     *   ENDSCAN
1674:     *   ThisForm.Release
1675:     *
1676:     * "DELETE ALL for descos = 0" marca deletadas (SET DELETED liga) as
1677:     * linhas com desconto zero, e o SCAN so insere as que sobrevivem E tem
1678:     * Selecao = 1 - equivalente a "Selecao = 1 AND Descos <> 0", que e' o
1679:     * filtro usado no SCAN de ConfirmarSelecaoExec.
1680:     *
1681:     * O par wrapper + Exec existe pela mesma razao de ValidarPercentualDesconto
1682:     * (regra CLAUDE.md #1): o corpo tem SCAN/loop e chamadas de BO que podem
1683:     * estourar, e o Release() final tem de rodar FORA do TRY. Release()
1684:     * acontece SEMPRE, inclusive apos erro - igual ao legado, que nao tem
1685:     * TRY/CATCH nenhum e sempre libera o dialogo no fim.
1686:     *
1687:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1688:     *==========================================================================
1689:     PROCEDURE BtnConfirmarClick()
1690:         LOCAL loc_oErro
1691: 
1692:         TRY
1693:             THIS.ConfirmarSelecaoExec()
1694:         CATCH TO loc_oErro
1695:             MsgErro(loc_oErro.Message + CHR(13) + ;
1696:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1697:                     "Procedure: " + loc_oErro.Procedure, ;
1698:                     "Erro em BtnConfirmarClick")
1699:         ENDTRY
1700: 
1701:         THIS.Release()
1702:     ENDPROC
1703: 
1704:     *==========================================================================
1705:     * ConfirmarSelecaoExec - corpo do btnConfirmar.Click: remove os
1706:     * descontos anteriores do item e regrava, em SigMvItd, uma linha para
1707:     * cada tipo de desconto marcado na grade com valor diferente de zero.
1708:     *
1709:     * SigOpDesBO.ExcluirDescontosDoItem() substitui o
1710:     * "DELETE all for cpros = ... and citens = ..." em crsigmvitd (cursor
1711:     * global do form chamador): aqui a tabela e' acessada direto, restrita
1712:     * ao mesmo par cpros/citens.
1713:     *
1714:     * Cada iteracao do SCAN preenche no BO exatamente as colunas que o
1715:     * INSERT do legado usa alem do contexto fixo do item (ja presente nas
1716:     * properties this_cCpros/this_nCitens/this_cEmps/this_cDopes/
1717:     * this_nNumes, herdadas do Init do form): Cdesc/Ddesc/Pdes/Vdes/TpDesc/
1718:     * Usuars vem da linha corrente de cursor_4c_Dados, ValBase vem de
1719:     * this_nUnitOrigs (legado: "crTpmMvItn.unitorigs") e Codigo (a cota
1720:     * vigente, "crSigcdDes.codigo") ja foi resolvido por
1721:     * SigOpDesBO.CarregarCota na abertura da tela e permanece em
1722:     * this_oBusinessObject.this_cCodigo.
1723:     *
1724:     * this_cCidChaves e' zerado ANTES de cada Inserir(): e' o gatilho que faz
1725:     * Inserir() gerar um fUniqueIds() NOVO por linha (regra CLAUDE.md #22) -
1726:     * equivalente a "lcIdChave = fUniqueIds()" dentro do SCAN do legado.
1727:     *==========================================================================
1728:     PROCEDURE ConfirmarSelecaoExec()
1729:         LOCAL loc_lExcluiu
1730: 
1731:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1732:             MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1733:                     "vel para confirmar a sele" + CHR(231) + CHR(227) + "o.", ;
1734:                     "Erro em BtnConfirmarClick")
1735:             RETURN
1736:         ENDIF
1737: 
1738:         *-- Contexto do item/movimento + os totais que estao na TELA, numa
1739:         *-- chamada so e FORA do SCAN: o contexto e' o MESMO para todas as
1740:         *-- linhas gravadas (e' sempre o mesmo item), entao reatribui-lo a
1741:         *-- cada iteracao so criava um segundo lugar para divergir do
1742:         *-- InicializarForm. Dentro do SCAN ficam APENAS os campos que
1743:         *-- mudam de linha para linha.
1744:         THIS.FormParaBO()
1745: 
1746:         loc_lExcluiu = THIS.this_oBusinessObject.ExcluirDescontosDoItem()
1747: 
1748:         IF !loc_lExcluiu
1749:             RETURN
1750:         ENDIF
1751: 
1752:         IF !USED("cursor_4c_Dados")
1753:             RETURN
1754:         ENDIF
1755: 
1756:         SELECT cursor_4c_Dados
1757:         GO TOP
1758: 
1759:         SCAN FOR NVL(Selecao, 0) = 1 AND NVL(Descos, 0) <> 0
1760:             WITH THIS.this_oBusinessObject
1761:                 *-- this_cCidChaves zerado a cada volta e' o gatilho que faz
1762:                 *-- Inserir() gerar um fUniqueIds() NOVO por linha (regra
1763:                 *-- CLAUDE.md #22) - equivalente ao "lcIdChave =
1764:                 *-- fUniqueIds()" dentro do SCAN do legado. Sem isto a
1765:                 *-- segunda linha colidiria no indice unico.
1766:                 .this_cCidChaves = ""
1767: 
1768:                 *-- Campos da LINHA corrente da grade (legado: localdes.*)
1769:                 .this_cCdesc     = cursor_4c_Dados.Codigos
1770:                 .this_cDdesc     = cursor_4c_Dados.Descrs
1771:                 .this_nPdes      = cursor_4c_Dados.Descos
1772:                 .this_nVdes      = cursor_4c_Dados.Valdes
1773:                 .this_nTpDesc    = cursor_4c_Dados.Tpdesc
1774:                 .this_cUsuars    = cursor_4c_Dados.Usuars
1775: 
1776:                 *-- Base do desconto (legado: crTpmMvItn.unitorigs)
1777:                 .this_nValBase   = THIS.this_nUnitOrigs
1778:             ENDWITH
1779: 
1780:             THIS.this_oBusinessObject.Inserir()
1781: 
1782:             SELECT cursor_4c_Dados
1783:         ENDSCAN
1784:     ENDPROC
1785: 
1786:     *==========================================================================
1787:     * Header1Click - SIGOPDES.Grade.Column1.Header1.Click (selecionar/
1788:     * desmarcar TODAS as linhas da grade principal).
1789:     *
1790:     * Legado:
1791:     *
1792:     *   If (This.parent.Header1.Tag = [X])
1793:     *       This.parent.Header1.Tag = [ ]
1794:     *       Update localDes Set Selecao = 0
1795:     *   Else
1796:     *       This.parent.Header1.Tag = [X]
1797:     *       Update localDes Set Selecao = 1

*-- Linhas 1809 a 1929:
1809:     * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
1810:     * desta migracao.
1811:     *
1812:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1813:     *==========================================================================
1814:     PROCEDURE Header1Click()
1815:         LOCAL loc_oHeader, loc_oErro
1816: 
1817:         TRY
1818:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1819:                 loc_oHeader = THIS.grd_4c_Dados.Column1.Header1
1820: 
1821:                 IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
1822:                     loc_oHeader.Tag = ""
1823:                     UPDATE cursor_4c_Dados SET Selecao = 0
1824:                 ELSE
1825:                     loc_oHeader.Tag = "X"
1826:                     UPDATE cursor_4c_Dados SET Selecao = 1
1827:                 ENDIF
1828: 
1829:                 THIS.grd_4c_Dados.Refresh()
1830:             ENDIF
1831:         CATCH TO loc_oErro
1832:             MsgErro(loc_oErro.Message + CHR(13) + ;
1833:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1834:                     "Procedure: " + loc_oErro.Procedure, ;
1835:                     "Erro em Header1Click")
1836:         ENDTRY
1837:     ENDPROC
1838: 
1839:     *==========================================================================
1840:     * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
1841:     * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de
1842:     * Column1 (fwcheckbox1 do legado).
1843:     *
1844:     * Regra CLAUDE.md "CheckBox em coluna de Grid": o toggle nativo NAO e'
1845:     * confiavel dentro de Column (Column.AddObject + CurrentControl +
1846:     * Sparse = .F.), entao Click/MouseDown so suprimem (NODEFAULT) e
1847:     * MouseUp/KeyPress(Enter=13/Espaco=32) sao quem de fato aciona o
1848:     * ChkSelecaoToggle - equivalente ao "clicar no checkbox" do legado, cujo
1849:     * Click comeca com "=DoDefault()" (toggle nativo) e so DEPOIS reage ao
1850:     * this.Value resultante.
1851:     *
1852:     * Todos PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1853:     *==========================================================================
1854:     PROCEDURE ChkSelecaoClick()
1855:         NODEFAULT
1856:     ENDPROC
1857: 
1858:     PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1859:         NODEFAULT
1860:     ENDPROC
1861: 
1862:     PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1863:         THIS.ChkSelecaoToggle()
1864:         NODEFAULT
1865:     ENDPROC
1866: 
1867:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1868:         IF INLIST(par_nKeyCode, 13, 32)
1869:             THIS.ChkSelecaoToggle()
1870:             NODEFAULT
1871:         ENDIF
1872:     ENDPROC
1873: 
1874:     *==========================================================================
1875:     * ChkSelecaoToggle - wrapper com TRY/CATCH de ChkSelecaoToggleExec
1876:     * (regra CLAUDE.md #1 - RETURN fica fora do TRY; o Exec tem RETURN
1877:     * antecipado e roda sem TRY proprio).
1878:     *
1879:     * PUBLIC: chamado pelos quatro handlers acima.
1880:     *==========================================================================
1881:     PROCEDURE ChkSelecaoToggle()
1882:         LOCAL loc_oErro
1883: 
1884:         TRY
1885:             THIS.ChkSelecaoToggleExec()
1886:         CATCH TO loc_oErro
1887:             MsgErro(loc_oErro.Message + CHR(13) + ;
1888:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1889:                     "Procedure: " + loc_oErro.Procedure, ;
1890:                     "Erro em ChkSelecaoToggle")
1891:         ENDTRY
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * ChkSelecaoToggleExec - corpo do fwcheckbox1.Click do legado.
1896:     *
1897:     * Legado:
1898:     *
1899:     *   =DoDefault()
1900:     *   IF this.Value = 0
1901:     *       thisform.calctots() / return
1902:     *   ENDIF
1903:     *   if INLIST(localdes.tpdesc,3,4,5,11,12,13)   && desconto de gerente
1904:     *       Do Form SigOpSen With 'CANCITEM','Libera Desconto','' To _Retorno
1905:     *       llOk = ( Left( _Retorno, 1 ) = "*" )
1906:     *       If !llOk
1907:     *           MessageBox('Autorizacao nao Confirmada!!',0+48,'')
1908:     *           thisform.grade.column1.Fwcheckbox1.Value=0
1909:     *           thisform.grade.Refresh
1910:     *       ELSE
1911:     *           replace usuars with SUBSTR(_Retorno,2) in localdes
1912:     *       EndIf
1913:     *       thisform.calctots() / RETURN .t.
1914:     *   ENDIF
1915:     *   if INLIST(localdes.tpdesc,8)   && desconto supervisor
1916:     *       Do Form SigOpSen With 'LIBFPAG', ... (mesma logica)
1917:     *   ENDIF
1918:     *   if INLIST(localdes.tpdesc,9)   && desconto diretoria
1919:     *       Do Form SigOpSen With 'SDINSUF', ... (mesma logica)
1920:     *   ENDIF
1921:     *   thisform.calctots() / RETURN .t.
1922:     *
1923:     * As TRES chamadas de SigOpSen do legado sao o MESMO dialogo com
1924:     * programa (1o parametro) diferente - aqui e' um DO CASE que resolve o
1925:     * programa pelo Tpdesc e um UNICO bloco de autorizacao, sem repetir a
1926:     * logica tres vezes.
1927:     *
1928:     * SigOpSen NAO EXISTE na nova arquitetura (ver
1929:     * feedback_sigopsen_ausente_gate_autorizacao): o sigopsen.SCX so existe

*-- Linhas 1940 a 2753:
1940:     * igual ao legado: a' DoDefault() ja alternou this.Value quando o Click
1941:     * comeca a rodar.
1942:     *==========================================================================
1943:     PROTECTED PROCEDURE ChkSelecaoToggleExec()
1944:         LOCAL loc_nNovoValor, loc_nTpDesc, loc_cPrograma
1945:         LOCAL loc_cRetorno, loc_lAutorizado, loc_lDialogoAbriu, loc_cFalhaDialogo
1946:         LOCAL loc_oErroSen
1947: 
1948:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1949:             RETURN
1950:         ENDIF
1951: 
1952:         loc_nNovoValor = IIF(NVL(cursor_4c_Dados.Selecao, 0) = 0, 1, 0)
1953:         REPLACE Selecao WITH loc_nNovoValor IN cursor_4c_Dados
1954: 
1955:         IF loc_nNovoValor = 0
1956:             THIS.CalcularTotais()
1957:             RETURN
1958:         ENDIF
1959: 
1960:         loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
1961:         loc_cPrograma = ""
1962: 
1963:         DO CASE
1964:             CASE INLIST(loc_nTpDesc, 3, 4, 5, 11, 12, 13)
1965:                 loc_cPrograma = "CANCITEM"
1966:             CASE loc_nTpDesc = 8
1967:                 loc_cPrograma = "LIBFPAG"
1968:             CASE loc_nTpDesc = 9
1969:                 loc_cPrograma = "SDINSUF"
1970:         ENDCASE
1971: 
1972:         IF !EMPTY(loc_cPrograma)
1973:             loc_cRetorno      = ""
1974:             loc_cFalhaDialogo = ""
1975:             loc_lDialogoAbriu = .F.
1976: 
1977:             TRY
1978:                 DO FORM SigOpSen WITH loc_cPrograma, "Libera Desconto", "" TO loc_cRetorno
1979:                 loc_lDialogoAbriu = .T.
1980:             CATCH TO loc_oErroSen
1981:                 loc_cFalhaDialogo = loc_oErroSen.Message
1982:             ENDTRY
1983: 
1984:             CLEAR TYPEAHEAD
1985: 
1986:             loc_lAutorizado = (loc_lDialogoAbriu AND ;
1987:                                LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")
1988: 
1989:             IF !loc_lAutorizado
1990:                 IF loc_lDialogoAbriu
1991:                     MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + ;
1992:                              CHR(227) + "o Confirmada!!", "")
1993:                 ELSE
1994:                     *-- FAIL-CLOSED: sem o dialogo de senha nao se libera
1995:                     *-- nenhum desconto que exija autorizacao.
1996:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1997:                             "vel abrir a tela de autoriza" + CHR(231) + ;
1998:                             CHR(227) + "o (SigOpSen)." + CHR(13) + ;
1999:                             "O desconto N" + CHR(195) + "O foi liberado." + ;
2000:                             CHR(13) + CHR(13) + "Detalhe: " + loc_cFalhaDialogo, ;
2001:                             "Libera Desconto")
2002:                 ENDIF
2003: 
2004:                 REPLACE Selecao WITH 0 IN cursor_4c_Dados
2005:                 THIS.grd_4c_Dados.Refresh()
2006:             ELSE
2007:                 REPLACE Usuars WITH SUBSTR(loc_cRetorno, 2) IN cursor_4c_Dados
2008:             ENDIF
2009:         ENDIF
2010: 
2011:         THIS.CalcularTotais()
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * ValidarPercentualDesconto - o PROCEDURE Valid de
2016:     * SIGOPDES.Grade.Column3.Text1 (celula "% Desconto").
2017:     *
2018:     * Chamado pelo Valid da subclasse txt_4c_CelPercentual, que e' o
2019:     * CurrentControl da coluna. O retorno E' o mecanismo: .F. mantem o
2020:     * cursor na celula e recusa a saida; .T. libera.
2021:     *
2022:     * PUBLIC porque quem chama e' a subclasse da celula, de FORA da classe
2023:     * do form (regra CLAUDE.md #51 - metodo chamado de fora nunca pode ser
2024:     * PROTECTED em nivel nenhum da heranca).
2025:     *
2026:     * O par wrapper + Exec existe por causa da regra CLAUDE.md #1: o corpo
2027:     * tem tres RETURN antecipados (um por regra recusada), e RETURN dentro
2028:     * de TRY/CATCH e' proibido. O wrapper fica com o TRY e com o RETURN
2029:     * unico; o Exec, sem TRY, pode usar os RETURN do legado.
2030:     *==========================================================================
2031:     PROCEDURE ValidarPercentualDesconto(par_oTxt)
2032:         LOCAL loc_lValido, loc_oErro
2033: 
2034:         loc_lValido = .T.
2035: 
2036:         TRY
2037:             loc_lValido = THIS.ValidarPercentualDescontoExec(par_oTxt)
2038:         CATCH TO loc_oErro
2039:             *-- Falha de infraestrutura NAO prende o usuario na celula: o
2040:             *-- erro e' exibido e a saida e' liberada. Recusar a saida aqui
2041:             *-- deixaria a tela travada na celula, sem o usuario ter como
2042:             *-- sair a nao ser pelo Cancelar.
2043:             loc_lValido = .T.
2044:             MsgErro(loc_oErro.Message + CHR(13) + ;
2045:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2046:                     "Procedure: " + loc_oErro.Procedure, ;
2047:                     "Erro em ValidarPercentualDesconto")
2048:         ENDTRY
2049: 
2050:         RETURN loc_lValido
2051:     ENDPROC
2052: 
2053:     *==========================================================================
2054:     * ValidarPercentualDescontoExec - corpo do Valid da coluna "% Desconto".
2055:     *
2056:     * Transcricao do legado, regra por regra:
2057:     *
2058:     *   SELECT crDesc / LOCATE for codigos = localdes.codigos
2059:     *   IF this.Value > crDesc.descosmax -> "Desconto maior que o permitido"
2060:     *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
2061:     *      -> "Desconto nao permitido para pagamento parcelado."
2062:     *   thisform.calctots()
2063:     *   IF (lnSaldo.Value < 0) or (crSigCdDes.valdes > crSigCdDes.valcota
2064:     *      and !INLIST(crDesc.tpdesc,1,2,9,11))
2065:     *      -> "Desconto maior que o permitido"
2066:     *
2067:     * O LOCATE do legado procura em crDesc a linha de MESMO codigos da
2068:     * linha corrente de localDes. Nesta arquitetura crDesc e localDes
2069:     * foram FUNDIDOS num cursor so (cursor_4c_Dados, montado por
2070:     * SigOpDesBO.CarregarDescontos: Descos/Valdes sao as colunas editaveis
2071:     * de localDes e Descosmax/Tpdesc/Codigos vem de crDesc), entao "a
2072:     * linha de crDesc com o mesmo codigos" E' a linha corrente - o LOCATE
2073:     * deixa de ser necessario em vez de ser descartado.
2074:     *
2075:     * REVERSAO SEMPRE PARA ZERO, e isso NAO e' simplificacao: o legado
2076:     * reverte com "this.Value = crDesc.descos", e crDesc.descos vale 0 em
2077:     * TODA linha - o Init legado faz "replace all descos with 0.00 in
2078:     * crDesc" e nada mais escreve nessa coluna de crDesc (os REPLACE de
2079:     * edicao e de calctots vao todos para localDes). Reverter para
2080:     * cursor_4c_Dados.Descos seria reverter para o valor que o usuario
2081:     * acabou de digitar, ou seja nao reverter nada.
2082:     *
2083:     * DIVERGENCIA CONHECIDA, de um unico tipo de desconto: o teto cobrado
2084:     * aqui e' cursor_4c_Dados.Descosmax, que para o tipo 13 (troca de
2085:     * preco) ja vem SOBRESCRITO pelo percentual da troca
2086:     * (FiltrarElegibilidade, passo 3, espelhando "replace descosmax with
2087:     * crPre.descos in localDes for tpdesc = 13"). No legado o Valid le
2088:     * crDesc.descosmax, que e' o teto do CADASTRO - la a sobrescrita foi
2089:     * para localDes e o Valid nao a ve. A fusao dos dois cursores foi
2090:     * decidida nas Fases 1-2 e nao se desfaz aqui; o efeito e' que o tipo
2091:     * 13 passa a ser cobrado pelo teto da troca de preco em vez do teto do
2092:     * cadastro. Esta e' a unica coluna do dump em que os dois divergem.
2093:     *
2094:     * O cursor recebe o valor digitado ANTES de CalcularTotais: dentro do
2095:     * Valid o valor esta em par_oTxt.Value e o cursor so recebe DEPOIS
2096:     * (regra CLAUDE.md #46), mas o teste final do legado le o Saldo que
2097:     * calctots produz A PARTIR DO CURSOR - sem gravar antes, o teste
2098:     * julgaria o valor ANTERIOR e deixaria passar o desconto recusado.
2099:     *==========================================================================
2100:     PROTECTED FUNCTION ValidarPercentualDescontoExec(par_oTxt)
2101:         LOCAL loc_nDigitado, loc_nTeto, loc_nTpDesc
2102: 
2103:         IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados") OR ;
2104:            EOF("cursor_4c_Dados")
2105:             RETURN .T.
2106:         ENDIF
2107: 
2108:         loc_nDigitado = THIS.ValorNumerico(par_oTxt.Value)
2109:         loc_nTeto     = NVL(cursor_4c_Dados.Descosmax, 0)
2110:         loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
2111: 
2112:         *-- Regra 1: percentual acima do teto do tipo de desconto
2113:         IF loc_nDigitado > loc_nTeto
2114:             MsgAviso("Desconto maior que o permitido", "Aviso")
2115:             THIS.ReverterCelulaDesconto(par_oTxt)
2116:             RETURN .F.
2117:         ENDIF
2118: 
2119:         *-- Regra 2: desconto financeiro (tipo 2) nao existe em venda
2120:         *-- parcelada (legado: RECCOUNT('crPar') <> 0)
2121:         IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
2122:             MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
2123:                      "parcelado.", "Aviso")
2124:             THIS.ReverterCelulaDesconto(par_oTxt)
2125:             RETURN .F.
2126:         ENDIF
2127: 
2128:         *-- Valor aceito ate aqui: grava no cursor e recalcula os totais
2129:         REPLACE Descos WITH loc_nDigitado IN cursor_4c_Dados
2130:         THIS.CalcularTotais()
2131: 
2132:         *-- Regra 3: desconto maior que o produto (saldo negativo) ou cota
2133:         *-- da empresa estourada por um tipo que consome cota
2134:         IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
2135:            (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
2136:             MsgAviso("Desconto maior que o permitido", "Aviso")
2137:             THIS.ReverterCelulaDesconto(par_oTxt)
2138:             THIS.CalcularTotais()
2139: 
2140:             *-- Legado: "RETURN IIF(this.Value = 0, .t., .f.)" - depois da
2141:             *-- reversao o campo vale 0, logo a saida da celula e'
2142:             *-- LIBERADA (o legado nao prende o usuario numa celula que ele
2143:             *-- acabou de ver ser zerada). A expressao e' transcrita em vez
2144:             *-- de pre-resolvida para continuar valendo se a reversao
2145:             *-- deixar de ser zero.
2146:             RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
2147:         ENDIF
2148: 
2149:         RETURN .T.
2150:     ENDFUNC
2151: 
2152:     *==========================================================================
2153:     * ValidarValorDesconto - o PROCEDURE Valid de
2154:     * SIGOPDES.Grade.Column4.Text1 (celula "Valor Desconto").
2155:     *
2156:     * Mesmo contrato de ValidarPercentualDesconto: chamado pelo Valid da
2157:     * subclasse txt_4c_CelValor, PUBLIC, e o retorno governa a saida da
2158:     * celula. Par wrapper + Exec pelo mesmo motivo (regra CLAUDE.md #1).
2159:     *==========================================================================
2160:     PROCEDURE ValidarValorDesconto(par_oTxt)
2161:         LOCAL loc_lValido, loc_oErro
2162: 
2163:         loc_lValido = .T.
2164: 
2165:         TRY
2166:             loc_lValido = THIS.ValidarValorDescontoExec(par_oTxt)
2167:         CATCH TO loc_oErro
2168:             loc_lValido = .T.
2169:             MsgErro(loc_oErro.Message + CHR(13) + ;
2170:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2171:                     "Procedure: " + loc_oErro.Procedure, ;
2172:                     "Erro em ValidarValorDesconto")
2173:         ENDTRY
2174: 
2175:         RETURN loc_lValido
2176:     ENDPROC
2177: 
2178:     *==========================================================================
2179:     * ValidarValorDescontoExec - corpo do Valid da coluna "Valor Desconto".
2180:     *
2181:     * Aqui o usuario digita o VALOR e o legado o converte em percentual
2182:     * antes de validar - a formula e' TRANSCRITA (regra CLAUDE.md #17),
2183:     * inclusive o guard de divisao por zero e as 4 casas do ROUND:
2184:     *
2185:     *   lnPdes = Iif(This.Value = 0 Or (Thisform.lnvalor.Value * 100) = 0,
2186:     *                0,
2187:     *                Round(This.Value / Thisform.lnvalor.Value * 100, 4))
2188:     *   If lnPdes > crDesc.descosmax -> "Desconto maior que o permitido"
2189:     *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
2190:     *      -> "Desconto nao permitido para pagamento parcelado."
2191:     *   Replace descos With lnPdes In localdes
2192:     *   Thisform.calctots()
2193:     *   IF (lnSaldo.Value < 0) or (cota estourada e tipo consome cota)
2194:     *      -> "Desconto maior que o permitido"
2195:     *
2196:     * O teto e' cobrado sobre o PERCENTUAL derivado, nao sobre o valor: e'
2197:     * o mesmo Descosmax da coluna "% Desconto".
2198:     *
2199:     * A reversao e' feita por ReverterCelulaDesconto, que zera o percentual
2200:     * E o valor no cursor junto com o controle. O legado so atribui
2201:     * "This.Value = crDesc.valdes" e deixa a volta ao cursor para o VFP -
2202:     * mas no terceiro guard o percentual JA foi gravado com o valor
2203:     * recusado, e calctots recalcula o valor a partir dele; sem zerar o
2204:     * percentual explicitamente, o valor recusado voltaria ao cursor.
2205:     * Zerar os dois e' o estado em que o legado converge depois do
2206:     * write-back, escrito de forma deterministica em vez de depender da
2207:     * ordem em que o VFP devolve o valor do controle ao ControlSource.
2208:     *==========================================================================
2209:     PROTECTED FUNCTION ValidarValorDescontoExec(par_oTxt)
2210:         LOCAL loc_nDigitado, loc_nValor, loc_nPdes, loc_nTeto, loc_nTpDesc
2211: 
2212:         IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados") OR ;
2213:            EOF("cursor_4c_Dados")
2214:             RETURN .T.
2215:         ENDIF
2216: 
2217:         loc_nDigitado = THIS.ValorNumerico(par_oTxt.Value)
2218:         loc_nValor    = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
2219:         loc_nTeto     = NVL(cursor_4c_Dados.Descosmax, 0)
2220:         loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
2221: 
2222:         *-- Valor digitado convertido em percentual sobre o valor original
2223:         loc_nPdes = IIF(loc_nDigitado = 0 OR (loc_nValor * 100) = 0, ;
2224:                         0, ;
2225:                         ROUND(loc_nDigitado / loc_nValor * 100, 4))
2226: 
2227:         *-- Regra 1: percentual equivalente acima do teto do tipo
2228:         IF loc_nPdes > loc_nTeto
2229:             MsgAviso("Desconto maior que o permitido", "Aviso")
2230:             THIS.ReverterCelulaDesconto(par_oTxt)
2231:             RETURN .F.
2232:         ENDIF
2233: 
2234:         *-- Regra 2: desconto financeiro (tipo 2) em venda parcelada
2235:         IF loc_nTpDesc = 2 AND THIS.this_nQtdParcelas <> 0 AND loc_nDigitado > 0
2236:             MsgAviso("Desconto n" + CHR(227) + "o permitido para pagamento " + ;
2237:                      "parcelado.", "Aviso")
2238:             THIS.ReverterCelulaDesconto(par_oTxt)
2239:             RETURN .F.
2240:         ENDIF
2241: 
2242:         *-- Legado: "Replace descos With lnPdes In localdes" - o valor
2243:         *-- digitado passa a existir como PERCENTUAL, e e' calctots que
2244:         *-- reescreve o valor a partir dele (ROUND(valor * descos / 100, 2)).
2245:         *-- Por isso o valor gravado pode diferir em centavos do digitado:
2246:         *-- e' o comportamento do legado, nao arredondamento acrescentado.
2247:         REPLACE Descos WITH loc_nPdes IN cursor_4c_Dados
2248:         THIS.CalcularTotais()
2249: 
2250:         *-- Regra 3: saldo negativo ou cota da empresa estourada
2251:         IF THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value) < 0 OR ;
2252:            (THIS.CotaEstourada() AND THIS.DescontoEntraNaCota(loc_nTpDesc))
2253:             MsgAviso("Desconto maior que o permitido", "Aviso")
2254:             THIS.ReverterCelulaDesconto(par_oTxt)
2255:             THIS.CalcularTotais()
2256: 
2257:             RETURN IIF(THIS.ValorNumerico(par_oTxt.Value) = 0, .T., .F.)
2258:         ENDIF
2259: 
2260:         RETURN .T.
2261:     ENDFUNC
2262: 
2263:     *==========================================================================
2264:     * ReverterCelulaDesconto - desfaz a digitacao recusada por um dos Valid.
2265:     *
2266:     * Legado: "this.Value = crDesc.descos" (coluna %) e
2267:     * "This.Value = crDesc.valdes" (coluna Valor), seguidos de
2268:     * "this.Refresh". As duas colunas de crDesc valem 0 em toda linha (ver
2269:     * o comentario de ValidarPercentualDescontoExec), entao a reversao e'
2270:     * para ZERO nos dois casos - o legado usa nomes diferentes para o
2271:     * mesmo zero.
2272:     *
2273:     * Zera TAMBEM o cursor, nas duas colunas: o controle sozinho nao basta
2274:     * porque CalcularTotais recalcula o valor a partir do percentual do
2275:     * CURSOR, e um percentual recusado que ficasse gravado reapareceria
2276:     * como valor na proxima passagem do calculo.
2277:     *
2278:     * NAO toca em Selecao: recusar o percentual nao desmarca a linha, e
2279:     * desmarcar faria o When da celula passar a devolver .F., tirando do
2280:     * usuario a chance de corrigir o valor que ele acabou de digitar.
2281:     *==========================================================================
2282:     PROTECTED PROCEDURE ReverterCelulaDesconto(par_oTxt)
2283:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2284:             REPLACE Descos WITH 0, ;
2285:                     Valdes WITH 0 ;
2286:                 IN cursor_4c_Dados
2287:         ENDIF
2288: 
2289:         IF VARTYPE(par_oTxt) = "O"
2290:             par_oTxt.Value = 0
2291:             par_oTxt.Refresh()
2292:         ENDIF
2293:     ENDPROC
2294: 
2295:     *==========================================================================
2296:     * FormParaBO - FONTE UNICA da transferencia TELA -> BO.
2297:     *
2298:     * Reune, num lugar so, as duas coisas que esta tela precisa empurrar para
2299:     * o SigOpDesBO:
2300:     *
2301:     *   1. O CONTEXTO do movimento/item/produto que o Init recebeu por
2302:     *      parametro. No legado isso nao existia como transferencia: o BO
2303:     *      "era" o form, e as regras de elegibilidade liam TprMvCab,
2304:     *      crTpmMvItn e crProd diretamente (cursores globais do form
2305:     *      chamador). Nesta arquitetura o contexto entra pelo Init do form e
2306:     *      tem de chegar ao BO antes de qualquer consulta.
2307:     *
2308:     *   2. Os TRES TOTAIS da tela (Valor Original / Total Desconto / Saldo),
2309:     *      lidos dos TextBox. O legado tambem trata a tela como fonte: o
2310:     *      calctots le "thisform.lnvalor.value" e escreve
2311:     *      "thisform.lnSaldo.Value" / "thisform.lnTdesc.Value", e o
2312:     *      btnConfirmar grava "localdes.valdes" - sempre o que esta na TELA,
2313:     *      nunca o que veio da carga.
2314:     *
2315:     * POR QUE EXISTE: o contexto era atribuido inline em InicializarForm e as
2316:     * colunas de contexto eram reatribuidas DE NOVO dentro do SCAN de
2317:     * ConfirmarSelecaoExec. Dois lugares escrevendo as mesmas properties sao
2318:     * dois lugares para divergir em silencio (um recebe campo novo e o outro
2319:     * nao, e a gravacao passa a usar contexto velho sem erro nenhum).
2320:     *
2321:     * LEITURA DOS TEXTBOX SOB GUARDA DE EXISTENCIA: InicializarForm chama
2322:     * este metodo ANTES de ConfigurarPageFrame, porque ConfigurarTotais le
2323:     * this_oBusinessObject.this_nValor para inicializar os TextBox - ou seja,
2324:     * na primeira chamada os TextBox ainda NAO existem. Sem a guarda,
2325:     * THIS.txt_4c_LnValor estouraria "Property TXT_4C_LNVALOR is not found"
2326:     * dentro do TRY do InicializarForm, o CREATEOBJECT devolveria .F. e o
2327:     * usuario acionaria a tela sem nada acontecer e sem erro visivel. Nessa
2328:     * primeira passagem this_nValor recebe this_nUnitOrigs, que e' exatamente
2329:     * o "this.lnValor.value = crTpmMvItn.unitorigs" do Init legado.
2330:     *
2331:     * ValorNumerico em toda leitura de TextBox: InputMask pode devolver
2332:     * Caractere depois de passar por digitacao, e atribuir Caractere a uma
2333:     * property numerica do BO faria a conta seguinte estourar longe daqui.
2334:     *
2335:     * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
2336:     * "PROTECTED PROCEDURE FormParaBO()" (e' um dos hooks que
2337:     * FormBase.Salvar/Novo/Cancelar chamam por THIS.), e em VFP9 a subclasse
2338:     * NAO pode ALARGAR o escopo herdado - escrever "PROCEDURE FormParaBO"
2339:     * sem o modificador nao torna o metodo publico, so esconde que ele
2340:     * continua protegido. Medido no probe desta fase: com a declaracao sem
2341:     * modificador, PEMSTATUS(oForm, "FormParaBO", 2) devolvia .T. (protegido)
2342:     * e a chamada de fora estourava "Property FORMPARABO is not found."
2343:     *
2344:     * Consequencia pratica: este metodo so e' alcancavel de DENTRO da classe
2345:     * (sempre por THIS., regra CLAUDE.md #8). Para exercita-lo num harness, o
2346:     * caminho e' uma "DEFINE CLASS Probe... AS FormSigOpDes" com um metodo
2347:     * publico que chame THIS.FormParaBO() - subclasse alcanca membro
2348:     * protegido, script solto nao.
2349:     *
2350:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
2351:     *==========================================================================
2352:     PROTECTED PROCEDURE FormParaBO()
2353:         LOCAL loc_lSucesso, loc_oErro
2354: 
2355:         loc_lSucesso = .F.
2356: 
2357:         TRY
2358:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2359:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
2360:                         "vel para transferir os dados da tela.", ;
2361:                         "Erro em FormParaBO")
2362:             ELSE
2363:                 WITH THIS.this_oBusinessObject
2364:                     *-- Contexto do movimento/item (legado: TprMvCab e
2365:                     *-- crTpmMvItn)
2366:                     .this_cEmps       = THIS.this_cEmps
2367:                     .this_cDopes      = THIS.this_cDopes
2368:                     .this_nNumes      = THIS.this_nNumes
2369:                     .this_cContads    = THIS.this_cContads
2370:                     .this_dDatas      = THIS.this_dDatas
2371:                     .this_cEmpDopNums = THIS.this_cEmpDopNums
2372:                     .this_cCpros      = THIS.this_cCpros
2373:                     .this_nCitens     = THIS.this_nCitens
2374:                     .this_nUnitOrigs  = THIS.this_nUnitOrigs
2375:                     .this_nQtds       = THIS.this_nQtds
2376:                     .this_nTotas      = THIS.this_nTotas
2377: 
2378:                     *-- Contexto do cadastro do produto atual (legado:
2379:                     *-- crProd), consumido pelas regras de elegibilidade
2380:                     .this_cCgrus      = THIS.this_cCgrus
2381:                     .this_cSgrus      = THIS.this_cSgrus
2382:                     .this_cCodcors    = THIS.this_cCodcors
2383:                     .this_cColecoes   = THIS.this_cColecoes
2384:                     .this_cCodfinp    = THIS.this_cCodfinp
2385:                     .this_nPvens      = THIS.this_nPvens
2386:                     .this_dDtLacto    = THIS.this_dDtLacto
2387:                     .this_lForaLinha  = THIS.this_lForaLinha
2388:                     .this_nPrecode    = THIS.this_nPrecode
2389:                 ENDWITH
2390: 
2391:                 *-- Totais. Na PRIMEIRA chamada (de dentro do
2392:                 *-- InicializarForm, antes de ConfigurarTotais) os TextBox
2393:                 *-- ainda nao existem: this_nValor recebe this_nUnitOrigs, o
2394:                 *-- mesmo valor com que ConfigurarTotais nasce o campo.
2395:                 IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
2396:                     THIS.this_oBusinessObject.this_nValor = ;
2397:                         THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
2398:                 ELSE
2399:                     THIS.this_oBusinessObject.this_nValor = THIS.this_nUnitOrigs
2400:                 ENDIF
2401: 
2402:                 IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
2403:                     THIS.this_oBusinessObject.this_nTDesc = ;
2404:                         THIS.ValorNumerico(THIS.txt_4c_LnTDesc.Value)
2405:                 ENDIF
2406: 
2407:                 IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
2408:                     THIS.this_oBusinessObject.this_nSaldo = ;
2409:                         THIS.ValorNumerico(THIS.txt_4c_LnSaldo.Value)
2410:                 ENDIF
2411: 
2412:                 loc_lSucesso = .T.
2413:             ENDIF
2414:         CATCH TO loc_oErro
2415:             loc_lSucesso = .F.
2416:             MsgErro(loc_oErro.Message + CHR(13) + ;
2417:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2418:                     "Procedure: " + loc_oErro.Procedure, ;
2419:                     "Erro em FormParaBO")
2420:         ENDTRY
2421: 
2422:         RETURN loc_lSucesso
2423:     ENDPROC
2424: 
2425:     *==========================================================================
2426:     * BOParaForm - FONTE UNICA da transferencia BO -> TELA.
2427:     *
2428:     * O inverso do FormParaBO, e com o mesmo alcance: os TRES campos de total
2429:     * da tela (Valor Original / Total Desconto / Saldo). Nao ha mais nada para
2430:     * espelhar - os campos editaveis desta tela nao sao controles do form, sao
2431:     * as CELULAS da grade, e elas leem de cursor_4c_Dados por ControlSource
2432:     * (quem repinta e' MontaGrade, nao este metodo).
2433:     *
2434:     * Legado equivalente, no fim do Init: "this.lnValor.value =
2435:     * crTpmMvItn.unitorigs" seguido de "=thisform.CalcTots()" - a tela abre
2436:     * com o Valor Original vindo do item e os outros dois ja calculados.
2437:     * Aqui o Valor Original vem de this_nValor (que FormParaBO acabou de
2438:     * resolver a partir de this_nUnitOrigs) e os outros dois das properties
2439:     * que a carga do BO deixou; CalcularTotais, chamado logo depois pelo
2440:     * CarregarLista, recalcula Total Desconto e Saldo sobre a grade ja cheia.
2441:     *
2442:     * GUARDA DE EXISTENCIA nos tres TextBox pela mesma razao do FormParaBO:
2443:     * o metodo pode rodar antes da superficie visual estar montada, e um
2444:     * "Property is not found" aqui derrubaria o Init inteiro.
2445:     *
2446:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase.prg
2447:     * declara "PROTECTED PROCEDURE BOParaForm()" e o VFP9 nao deixa a
2448:     * subclasse alargar o escopo herdado - sem o modificador o metodo ficaria
2449:     * protegido de qualquer jeito, e a declaracao mentiria para quem le.
2450:     *
2451:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
2452:     *==========================================================================
2453:     PROTECTED PROCEDURE BOParaForm()
2454:         LOCAL loc_lSucesso, loc_oErro
2455: 
2456:         loc_lSucesso = .F.
2457: 
2458:         TRY
2459:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2460:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
2461:                         "vel para atualizar os totais da tela.", ;
2462:                         "Erro em BOParaForm")
2463:             ELSE
2464:                 WITH THIS.this_oBusinessObject
2465:                     IF PEMSTATUS(THIS, "txt_4c_LnValor", 5)
2466:                         THIS.txt_4c_LnValor.Value = ;
2467:                             THIS.ValorNumerico(.this_nValor)
2468:                     ENDIF
2469: 
2470:                     IF PEMSTATUS(THIS, "txt_4c_LnTDesc", 5)
2471:                         THIS.txt_4c_LnTDesc.Value = ;
2472:                             THIS.ValorNumerico(.this_nTDesc)
2473:                     ENDIF
2474: 
2475:                     IF PEMSTATUS(THIS, "txt_4c_LnSaldo", 5)
2476:                         THIS.txt_4c_LnSaldo.Value = ;
2477:                             THIS.ValorNumerico(.this_nSaldo)
2478:                     ENDIF
2479:                 ENDWITH
2480: 
2481:                 loc_lSucesso = .T.
2482:             ENDIF
2483:         CATCH TO loc_oErro
2484:             loc_lSucesso = .F.
2485:             MsgErro(loc_oErro.Message + CHR(13) + ;
2486:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2487:                     "Procedure: " + loc_oErro.Procedure, ;
2488:                     "Erro em BOParaForm")
2489:         ENDTRY
2490: 
2491:         RETURN loc_lSucesso
2492:     ENDPROC
2493: 
2494:     *==========================================================================
2495:     * Destroy - o "PROCEDURE Release" do legado.
2496:     *
2497:     * Legado:
2498:     *
2499:     *   RELEASE pcChv, pcEDN, pcItem
2500:     *   This.Grade.RecordSource          = []
2501:     *   This.Grade.Column1.ControlSource = []
2502:     *   This.Grade.Column2.ControlSource = []
2503:     *   This.Grade.Column3.ControlSource = []
2504:     *   This.Grade.Column4.ControlSource = []
2505:     *   Use In localDes
2506:     *
2507:     * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
2508:     * contexto que elas carregavam entre o Init e os eventos vive em
2509:     * properties this_* do form e do BO, que morrem com os objetos - nao ha
2510:     * o que soltar do espaco global.
2511:     *
2512:     * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
2513:     * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
2514:     * deixa o Grid apontando para alias morto, e qualquer repintura posterior
2515:     * (o VFP repinta durante a propria destruicao da tela) acha alias
2516:     * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
2517:     * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
2518:     * grades sao nossas e os dois cursores tambem.
2519:     *
2520:     * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
2521:     * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
2522:     * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
2523:     * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
2524:     * buffer sujo.
2525:     *
2526:     * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
2527:     * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
2528:     * cadeia de heranca o menu do sistema aparece encolhido depois que este
2529:     * dialogo fecha.
2530:     *
2531:     * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
2532:     * destruicao por falha de limpeza deixaria o form pendurado.
2533:     *==========================================================================
2534:     PROCEDURE Destroy()
2535:         LOCAL loc_oErro
2536: 
2537:         TRY
2538:             *-- Solta a grade principal do cursor (legado: Grade.RecordSource
2539:             *-- e os quatro Column.ControlSource)
2540:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2541:                 WITH THIS.grd_4c_Dados
2542:                     .RecordSource          = ""
2543:                     .Column1.ControlSource = ""
2544:                     .Column2.ControlSource = ""
2545:                     .Column3.ControlSource = ""
2546:                     .Column4.ControlSource = ""
2547:                 ENDWITH
2548:             ENDIF
2549: 
2550:             *-- Solta a grade da cota (GrdCota, 3 colunas)
2551:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
2552:                 WITH THIS.grd_4c_Cota
2553:                     .RecordSource          = ""
2554:                     .Column1.ControlSource = ""
2555:                     .Column2.ControlSource = ""
2556:                     .Column3.ControlSource = ""
2557:                 ENDWITH
2558:             ENDIF
2559: 
2560:             *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
2561:             IF USED("cursor_4c_Dados")
2562:                 USE IN cursor_4c_Dados
2563:             ENDIF
2564: 
2565:             IF USED("cursor_4c_Cota")
2566:                 USE IN cursor_4c_Cota
2567:             ENDIF
2568:         CATCH TO loc_oErro
2569:             MsgErro(loc_oErro.Message + CHR(13) + ;
2570:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2571:                     "Procedure: " + loc_oErro.Procedure, ;
2572:                     "Erro em Destroy")
2573:         ENDTRY
2574: 
2575:         DODEFAULT()
2576:     ENDPROC
2577: 
2578:     *==========================================================================
2579:     * TornarControlesVisiveis - torna visiveis, recursivamente, todos os
2580:     * controles de par_oContainer (AddObject sempre cria com Visible = .F.).
2581:     * Percorre tambem Pages de PageFrame, mesmo este form nao tendo nenhum
2582:     * hoje - mantido pelo mesmo motivo do padrao canonico FormCor/FormCargo:
2583:     * um PageFrame acrescentado depois ja seria coberto.
2584:     *
2585:     * grd_4c_Cota e' EXCECAO: a visibilidade dele e' decidida pelo acesso
2586:     * GERENTE (ver AcessoGradeCota) e forcar Visible = .T. aqui exporia a
2587:     * cota de desconto da empresa para QUALQUER usuario, apagando em
2588:     * silencio a regra que o legado aplica. A recursao entra no objeto de
2589:     * qualquer forma, para os filhos dele nascerem visiveis quando o
2590:     * container voltar a ser exibido.
2591:     *==========================================================================
2592:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2593:         LOCAL loc_nI, loc_oObjeto, loc_nP
2594: 
2595:         IF VARTYPE(par_oContainer) != "O"
2596:             RETURN
2597:         ENDIF
2598: 
2599:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2600:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2601: 
2602:             IF VARTYPE(loc_oObjeto) = "O"
2603:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
2604:                    UPPER(loc_oObjeto.Name) != "GRD_4C_COTA"
2605:                     loc_oObjeto.Visible = .T.
2606:                 ENDIF
2607: 
2608:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2609:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2610:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2611:                     ENDFOR
2612:                 ENDIF
2613: 
2614:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2615:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2616:                 ENDIF
2617:             ENDIF
2618:         ENDFOR
2619:     ENDPROC
2620: 
2621: ENDDEFINE
2622: 
2623: *==============================================================================
2624: * Subclasses de celula da grade principal de FormSigOpDes
2625: *
2626: * Uma por coluna editavel/bloqueada de SIGOPDES.Grade, instaladas por
2627: * FormSigOpDes.InstalarCelulasGrade com Column.AddObject + CurrentControl.
2628: *
2629: * POR QUE SUBCLASSE: a validacao de celula de grade mora no Valid do TextBox
2630: * da coluna, e BINDEVENT em "Valid" de TextBox de Column nao e' confiavel
2631: * (regra CLAUDE.md #46); alem disso BINDEVENT DESCARTA o retorno do delegate,
2632: * e aqui o retorno E' o mecanismo - o Valid devolvendo .F. recusa a saida da
2633: * celula e o When devolvendo .F. recusa a entrada. Nenhum dos dois efeitos
2634: * sobrevive a um BINDEVENT.
2635: *
2636: * Cada subclasse so decide ENTRAR/SAIR e delega a regra ao metodo PUBLIC
2637: * correspondente do form (fonte unica): o legado tambem chama
2638: * "thisform.calctots()" de dentro dos Valid, isto e' a regra nunca morou no
2639: * controle.
2640: *
2641: * O guard PEMSTATUS existe porque estas classes vivem no mesmo arquivo do
2642: * form mas sao instanciadas pelo Grid: se um dia a celula for reusada em
2643: * outro form sem esses metodos, a ausencia vira "a celula nao valida" em vez
2644: * de "Property is not found" derrubando a tela.
2645: *==============================================================================
2646: 
2647: *------------------------------------------------------------------------------
2648: * TextBoxCelDescricaoSigOpDes_4c - celula da coluna "Descricao do Desconto"
2649: * (SIGOPDES.Grade.Column2.Text1).
2650: *
2651: * O legado declara Column2.ReadOnly = .F. e bloqueia a digitacao com
2652: * "PROCEDURE When / Return .f." no Text1 - a descricao do tipo de desconto e'
2653: * so leitura, o usuario nunca a edita.
2654: *
2655: * O "PROCEDURE GotFocus" que o dump traz neste mesmo objeto (um salto para a
2656: * coluna 3 ou 4 conforme o tpdesc da linha) e' CODIGO MORTO no legado e por
2657: * isso nao e' reproduzido: com o When devolvendo .F. a celula nunca e'
2658: * ativada, logo o GotFocus dela nunca dispara. Reproduzi-lo por outra via
2659: * (AfterRowColChange, por exemplo) ACRESCENTARIA um salto de foco que a tela
2660: * legada nao faz. O mesmo vale para o GotFocus identico de
2661: * SIGOPDES.GrdCota.Column1.Text1, que tambem tem When devolvendo .F.
2662: *------------------------------------------------------------------------------
2663: DEFINE CLASS TextBoxCelDescricaoSigOpDes_4c AS TextBox
2664: 
2665:     PROCEDURE When()
2666:         RETURN .F.
2667:     ENDPROC
2668: 
2669: ENDDEFINE
2670: 
2671: *------------------------------------------------------------------------------
2672: * TextBoxCelPercentualSigOpDes_4c - celula da coluna "% Desconto"
2673: * (SIGOPDES.Grade.Column3.Text1).
2674: *
2675: * When  legado: "RETURN localdes.selecao = 1" - so a linha MARCADA aceita
2676: *               percentual. A linha comentada logo acima dele no dump
2677: *               ("INLIST(tpdesc,1,2,3,4,5,8,9) and selecao = 1") e' a versao
2678: *               antiga da regra e fica comentada, como no legado.
2679: * Valid legado: as tres regras de teto / parcelado / saldo-e-cota, que vivem
2680: *               em FormSigOpDes.ValidarPercentualDesconto.
2681: *------------------------------------------------------------------------------
2682: DEFINE CLASS TextBoxCelPercentualSigOpDes_4c AS TextBox
2683: 
2684:     PROCEDURE When()
2685:         LOCAL loc_lPermite
2686: 
2687:         loc_lPermite = .F.
2688: 
2689:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2690:             IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
2691:                 loc_lPermite = cursor_4c_Dados.Selecao
2692:             ELSE
2693:                 loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
2694:             ENDIF
2695:         ENDIF
2696: 
2697:         RETURN loc_lPermite
2698:     ENDPROC
2699: 
2700:     PROCEDURE Valid()
2701:         LOCAL loc_lValido
2702: 
2703:         loc_lValido = .T.
2704: 
2705:         IF PEMSTATUS(THISFORM, "ValidarPercentualDesconto", 5)
2706:             loc_lValido = THISFORM.ValidarPercentualDesconto(THIS)
2707:         ENDIF
2708: 
2709:         RETURN loc_lValido
2710:     ENDPROC
2711: 
2712: ENDDEFINE
2713: 
2714: *------------------------------------------------------------------------------
2715: * TextBoxCelValorSigOpDes_4c - celula da coluna "Valor Desconto"
2716: * (SIGOPDES.Grade.Column4.Text1).
2717: *
2718: * When  legado: "RETURN localdes.selecao = 1" (o "&&RETURN .f." comentado
2719: *               abaixo dele no dump e' a versao antiga da regra).
2720: * Valid legado: converte o valor digitado em percentual e aplica as mesmas
2721: *               tres regras - vive em FormSigOpDes.ValidarValorDesconto.
2722: *------------------------------------------------------------------------------
2723: DEFINE CLASS TextBoxCelValorSigOpDes_4c AS TextBox
2724: 
2725:     PROCEDURE When()
2726:         LOCAL loc_lPermite
2727: 
2728:         loc_lPermite = .F.
2729: 
2730:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2731:             IF VARTYPE(cursor_4c_Dados.Selecao) = "L"
2732:                 loc_lPermite = cursor_4c_Dados.Selecao
2733:             ELSE
2734:                 loc_lPermite = (NVL(cursor_4c_Dados.Selecao, 0) = 1)
2735:             ENDIF
2736:         ENDIF
2737: 
2738:         RETURN loc_lPermite
2739:     ENDPROC
2740: 
2741:     PROCEDURE Valid()
2742:         LOCAL loc_lValido
2743: 
2744:         loc_lValido = .T.
2745: 
2746:         IF PEMSTATUS(THISFORM, "ValidarValorDesconto", 5)
2747:             loc_lValido = THISFORM.ValidarValorDesconto(THIS)
2748:         ENDIF
2749: 
2750:         RETURN loc_lValido
2751:     ENDPROC
2752: 
2753: ENDDEFINE


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
					CREATE CURSOR cursor_4c_Cota ;
						(Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
						 Codigo C(10), Valmeta N(11,2))
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
						CREATE CURSOR cursor_4c_Dados ;
							(Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
							 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
							 Descosmax N(7,4), Usuars C(10))
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

